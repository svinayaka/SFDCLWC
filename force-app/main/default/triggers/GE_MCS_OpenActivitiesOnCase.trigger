trigger GE_MCS_OpenActivitiesOnCase on Task (after insert, after update) {
    List<Id> caseIds = new List<Id>();
    for(Task t:trigger.new) {
        if(t.WhatId != null) {
            string objKeyPrefix = t.WhatId;//.substring(0,3);
            objKeyPrefix = objKeyPrefix.substring(0,3);
            System.debug('---------'+objKeyPrefix);
            if(objKeyPrefix == '500') {
                // ensuring case id here
                caseIds.add(t.WhatId);
            }
        }
    }
    
    map<id,case> mapcases = new map<id,case>();
    for(case c:[select id,GE_ES_Sub_Type__c,RecordTypeId,GE_MCS_Open_Activity__c from case where id in:caseIds ]) {
        mapcases.put(c.id,c);
    }
    
    map<id,list<task>> maptasks = new map<id,list<task>>();
    for(task t:[select id,whatid,status from task where whatid in:mapcases.values()]) {
        if(maptasks.containskey(t.whatid)==false) {
            maptasks.put(t.whatid,new list<task>{t}); 
        }
        else {
            maptasks.get(t.whatid).add(t);
        }     
    }

    map<id,Case> CaseVals= new map<id,case>();
    List<Case> CaseValslst= new list<case>();
    integer completedTaskCounter = 0;
    
    for(task t:trigger.new) {
        if(mapcases.containskey(t.whatid)==true) {
            case c=mapcases.get(t.whatid);
            if(maptasks.containskey(c.id)==true&&c.recordtypeid== Schema.SObjectType.Case.getRecordTypeInfosByName().get('MCS - CS').getRecordTypeId()) {
                list<task> tlst = maptasks.get(c.id);
                for(task tskobj:tlst) {
                    if(tskobj.Status == 'In Progress' || tskobj.Status == 'Not Started') {
                        break;
                    }
                    completedTaskCounter ++;
                }
                if(completedTaskCounter == tlst.size()) {
                    c.GE_MCS_Open_Activity__c = 'No';
                }
                else {
                    c.GE_MCS_Open_Activity__c = 'YES';
                }
                CaseVals.put(c.id,c);
            }
        }
    }
   // CaseValslst.addall(casevals);
    try {
        update CaseVals.values();
    } catch(exception e) {
        trigger.new[0].subject.adderror('Sub Type is Mandatory : Please fill the field Sub Type');     
    }
}