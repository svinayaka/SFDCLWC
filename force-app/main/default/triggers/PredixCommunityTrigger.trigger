//this trigger is used for getting the contributor list in Predix Community
trigger PredixCommunityTrigger on Case (after insert,after update) {
    
    if(GEOG_AvoidPredixTriggerRecursive.firstRun){
        GEOG_AvoidPredixTriggerRecursive.firstRun = false;
         
   Id IPSRecTypeID = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Predix IPS').getRecordTypeId();
   ID UORecTypeID = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Predix UO').getRecordTypeId();

   

    Set<ID> setCaseIDs = new Set<ID>();
    Set<ID> setCsID = new Set<ID>();
    
    for(Case c : Trigger.new){
        if(c.RecordTypeId == IPSRecTypeID || c.RecordTypeId == UORecTypeID ){
            setCaseIDs .add(c.LastModifiedById);
            setCsID.add(c.Id);
        }
    }
    if(setCsID.size()>0){
    Map<Id, User> mapUser = new Map<Id, User>([Select Id, Name, ProfileId, Profile.Name From User WHERE ID IN :setCaseIDs ]);
    
    Map<Id, Case> mapCase = new Map<Id, Case>([Select Id, LastModifiedById,RecordTypeId, Community_Last_Modified_User__c from case where Id in :setCsID]);
 
        List<Case> lstCs = new List<Case>();
        List<Case> lstUpdateCs = new List<Case>();
        //Id IPSRecTypeID = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Predix IPS').getRecordTypeId();
        //ID UORecTypeID = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Predix UO').getRecordTypeId();
        
        for(Case c : mapCase.values()){
            system.debug('----mapUser----'+mapUser);
            system.debug('----c.LastModifiedById----'+c.LastModifiedById);
         if((c.RecordTypeId == IPSRecTypeID || c.RecordTypeId == UORecTypeID) && (mapUser.get(c.LastModifiedById).Profile.Name!='II Partner Community UO' || mapUser.get(c.LastModifiedById).Profile.Name!='II Partner Community IPS')){
            
            if(trigger.isInsert){
                c.Community_Last_Modified_User__c=mapUser.get(c.LastModifiedById).Name.trim();
            }
            
            else if(mapUser.get(c.LastModifiedById).Name!=null ){
             c.Community_Last_Modified_User__c=c.Community_Last_Modified_User__c+','+mapUser.get(c.LastModifiedById).Name.trim();
            }
            System.debug('------'+c.Community_Last_Modified_User__c);
            
            if(c.Community_Last_Modified_User__c!=null){
                String[] strCommunityModifiedUser = c.Community_Last_Modified_User__c.split(',');
                 system.debug('====strCommunityModifiedUser ==='+strCommunityModifiedUser );
                Set<String> setModifiedUser = new Set<String>();
                system.debug('====strCommunityModifiedUser ==='+strCommunityModifiedUser );
                for(String usr: strCommunityModifiedUser)
                {
                    system.debug('====usr==='+usr);
                    if(setModifiedUser.contains(usr.trim())){
                        
                    }
                    else if(usr!='null'){
                        setModifiedUser.add(usr.trim());
                    }
                    system.debug('====setModifiedUser==='+setModifiedUser);
                }
                
                string finalModifiedUser ='';
                 
                List<String> listModifiedUser= new List<String>(setModifiedUser);
                 system.debug('====listModifiedUser==='+listModifiedUser.size());
                 if(listModifiedUser.size()==6){
                     listModifiedUser.remove(0);
                 }
                 c.Community_Last_Modified_User__c = '';
                for(String s : listModifiedUser)
                {
                        
                        
                        if(c.Community_Last_Modified_User__c==''){
                            c.Community_Last_Modified_User__c= s;
                        }
                        else{
                        c.Community_Last_Modified_User__c= c.Community_Last_Modified_User__c+', '+ s;
                        }
                 
                                   
                }
                
                
            }
            
            System.debug('------'+c.Community_Last_Modified_User__c);
            
            }
            lstUpdateCs.add(c);
        }
        
        if(lstUpdateCs.size()>0)
        update lstUpdateCs;
        
    }
    }
}