trigger GE_SS_Update_Related_Child on GE_SS_Project__c (after Update , after insert) {

    List<SVMXC__Service_Order__c> lstTripWO = new List<SVMXC__Service_Order__c>();
    List<GE_SS_Service_Ticket__c> STREC = new List<GE_SS_Service_Ticket__c>();
    map<id,GE_SS_Project__c> FSPREC= new map<id,GE_SS_Project__c>(); 
    
    set<id> project_ids = new set<Id>();
    
    static map<id,RecordType> record_map = new map<id,RecordType>([SELECT DeveloperName,Id,Name FROM RecordType WHERE SobjectType = 'GE_SS_Project__c']);
    try{
    if(Trigger.IsUpdate && trigger.isAfter) {
        for(GE_SS_Project__c prj : trigger.new) {
            if((prj.GE_SS_Project_region__c <> trigger.oldMap.get(prj.id).GE_SS_Project_region__c || prj.GE_SS_Account__c <> trigger.oldMap.get(prj.id).GE_SS_Account__c || prj.GE_SS_Country__c <> trigger.oldMap.get(prj.id).GE_SS_Country__c || prj.GE_SS_Management_Country__c <> trigger.oldMap.get(prj.id).GE_SS_Management_Country__c || prj.GE_SS_Field__c <> trigger.oldMap.get(prj.id).GE_SS_Field__c) && (record_map.containsKey(prj.RecordTypeid) && record_map.get(prj.RecordTypeId).DeveloperName == 'SS_Project')) {
                project_ids.add(prj.id);
                FSPREC.put(prj.id,prj);
            }
        }
    }
    system.debug('after update project_ids--->' + project_ids);
        
    for(SVMXC__Service_Order__c svo : [Select id,GE_SS_Project__c,Management_Country__c,GE_SS_Project_Region__c,GE_SS_Field__c,SVMXC__Company__c,SVMXC__Country__c,(Select id,GE_SS_Project__c, GE_SS_Project_region__c, Management_Country__c, GE_SS_Field__c,SVMXC__Company__c,SVMXC__Country__c FROM Work_Orders__r), (Select id, GE_SS_Project_region__c, Management_Country__c, GE_SS_Field__c,GE_SS_Country__c,GE_SS_Account__c FROM Service_Tickets__r) from SVMXC__Service_Order__c where GE_SM_HQ_Record_Type_Name__c = 'SS-Mobilize' and GE_SS_Project__c IN: project_ids]) {
        system.debug('for reached--->' + svo);
        system.debug('size '+svo.Work_Orders__r.size());
        system.debug('size '+svo.Service_Tickets__r.size());
        if(FSPREC.containskey(svo.GE_SS_Project__c) && FSPREC.get(svo.GE_SS_Project__c) <> null) {
            svo.GE_SS_Project_Region__c = FSPREC.get(svo.GE_SS_Project__c).GE_SS_Project_region__c;
            svo.Management_Country__c = FSPREC.get(svo.GE_SS_Project__c).GE_SS_Management_Country__c;
            svo.GE_SS_Field__c = FSPREC.get(svo.GE_SS_Project__c).GE_SS_Field__c;
            svo.SVMXC__Company__c=FSPREC.get(svo.GE_SS_Project__c).GE_SS_Account__c;
            svo.SVMXC__Country__c=FSPREC.get(svo.GE_SS_Project__c).GE_SS_Country__c;
            lstTripWO.add(svo);
            system.debug('Outer Wo'+svo.Work_Orders__r);
            system.debug('Outer ticket'+svo.Service_Tickets__r);
            for(SVMXC__Service_Order__c two : svo.Work_Orders__r) {
                system.debug('trip work order'+two.id);
                two.GE_SS_Project_Region__c = FSPREC.get(svo.GE_SS_Project__c).GE_SS_Project_region__c;
                two.Management_Country__c = FSPREC.get(svo.GE_SS_Project__c).GE_SS_Management_Country__c;
                two.GE_SS_Field__c = FSPREC.get(svo.GE_SS_Project__c).GE_SS_Field__c;
                two.SVMXC__Company__c=FSPREC.get(svo.GE_SS_Project__c).GE_SS_Account__c;
                two.SVMXC__Country__c=FSPREC.get(svo.GE_SS_Project__c).GE_SS_Country__c;
                lstTripWO.add(two);
            }
            
            for(GE_SS_Service_Ticket__c stt : svo.Service_Tickets__r) {
                system.debug('service ticket'+stt.id);
                stt.GE_SS_Project_region__c = FSPREC.get(svo.GE_SS_Project__c).GE_SS_Project_region__c;
                stt.Management_Country__c = FSPREC.get(svo.GE_SS_Project__c).GE_SS_Management_Country__c;
                stt.GE_SS_Field__c = FSPREC.get(svo.GE_SS_Project__c).GE_SS_Field__c;
                stt.GE_SS_Country__c=FSPREC.get(svo.GE_SS_Project__c).GE_SS_Country__c;
                stt.GE_SS_Account__c=FSPREC.get(svo.GE_SS_Project__c).GE_SS_Account__c;
                STREC.add(stt);
            }
        }
        
    }
    
    if(lstTripWO.size()>0)
        update lstTripWO;
    if(STREC.size()>0)
        update STREC;
        }
        catch(exception ex)
        {
            System.Debug('Error Occured in Trigger GE_SS_Update_Related_Child!'+ ex.getMessage());
            //trigger.new[0].addError('System Timeoutc Error');
        }
        
        if(Trigger.isAfter &&  !GE_SS_FS_Project_Trigger_Helper.isRecursive){
           if(Trigger.isInsert){
              GE_SS_FS_Project_Trigger_Helper.invokeFSProjectSubmitToOracle(Trigger.new) ;
           }  
        }              
}