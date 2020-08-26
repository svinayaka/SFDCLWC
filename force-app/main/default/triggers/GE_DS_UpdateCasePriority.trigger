trigger GE_DS_UpdateCasePriority on Task (after insert, after update) {
    List<Id> caseIds = new List<Id>();
    
    //Get CaseIds for all Tasks
    for(Task cTask : Trigger.new){
        if(cTask.whatId != null){
            caseIds.add(cTask.whatId);
        }
    }
    
    Map<Id, String> casePriorityMap = new Map<Id, String>();
    List<Case> updateCases = new List<Case>();
    Map<String, Integer> prMap = new Map<String, Integer>{'High'=>2, 'Normal'=>1, 'Low'=>0};
    
    for(Case tCase: [select Id, Priority, (select Id, whatId, Priority from Tasks where Status ='In Progress') from Case where Id in :caseIds and RecordType.Name='DS - CSR']){
        if(tCase.Tasks.size() > 0){
            Integer cPriority = 0;
            for(Task cTask : tCase.Tasks){
                if(cPriority < prMap.get(cTask.Priority)){
                    cPriority = prMap.get(cTask.Priority);
                }
            }
            
            String tempPriority = (cPriority==0?'Low':(cPriority==1?'Medium':'High'));
            if(tCase.Priority != tempPriority){
                tCase.Priority = tempPriority;
                updateCases.add(tCase);
            }
        }
    }
    
    if(updateCases.size() > 0){
        update updateCases;
    }
    
    /*Getting CaseIds from Tasks
    for( Task t: Trigger.new ){
        if( t.WhatID != NULL ){
            system.debug('CaseID'+t.WhatID);
            String objKeyPrefix = t.WhatID;
            objKeyPrefix = objKeyPrefix.substring(0,3);
            System.debug('****'+objKeyPrefix);
            if(objKeyPrefix == '500'){
                caseIds.add(t.WhatID);
                system.debug('Case'+CaseIds);
                
            }
        }
    }
    
    Id recTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('DS - CSR').getRecordTypeId();  
    List<Case> casesWithTasks = [select ID, CaseNumber,Priority,(select ID, Subject,WhatID, Priority from Tasks where Status ='In Progress') from Case where Id in :caseIds and RecordType.Name='DS - CSR'];
    system.debug('Number of CaseWithTask'+casesWithTasks.size() );
    
    List <case> casesToBeUpdated = new List <case>();
    
    for(Case c : casesWithTasks){
        system.debug('---case Tasks---'+c.Tasks);
        for( Task t : c.Tasks ){
            system.debug('Subject'+t.Subject);
            if( c.Priority == 'Low' && t.Priority == 'Normal'){
                c.Priority='Medium';
                casesToBeUpdated.add(c);
            }
            else if( c.Priority == 'Low' && t.Priority == 'High' ){
                c.Priority='High';
                casesToBeUpdated.add(c);
            }    
            else if(c.Priority=='Medium' && t.Priority=='High'){
                c.Priority='High';
                casesToBeUpdated.add(c);
            }
        }        
    }
    update casesToBeUpdated; */
}