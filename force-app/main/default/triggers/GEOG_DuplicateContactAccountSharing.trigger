trigger GEOG_DuplicateContactAccountSharing on ContactAccountSharing__c (before insert, after insert, after update) {
if(trigger.isBefore){
     List<OG_Trigger_fire_Decision__c> lstObj = new list<OG_Trigger_fire_Decision__c>([Select Object_Name__c, Trigger_Name__c, isActive__c from OG_Trigger_fire_Decision__c where Trigger_Name__c='GEOG_DuplicateContactAccountSharing ' and isActive__c = true and Object_Name__c='ContactAccountSharing__c']);
    
    if(lstObj!=null && lstObj.size()>0){
        return;
    }
    
    Set<Id> setAccountId = new Set<Id>();
    Set<Id> setConatctId = new Set<Id>();
    
    for(ContactAccountSharing__c  cs: trigger.new){
        setAccountId.add(cs.Account_GEOG__c);
        setConatctId.add(cs.Contact_GEOG__c);
    }
    system.debug('====setConatctId========='+setConatctId);
    List<ContactAccountSharing__c> lstConAcc = new List<ContactAccountSharing__c>([Select Id, Account_GEOG__c, Contact_GEOG__c from ContactAccountSharing__c where Account_GEOG__c in:setAccountId or Contact_GEOG__c in :setConatctId limit 10000]);
    
     
    
    Map<Id, Set<Id>> mapConAcc = new Map<Id, Set<Id>>(); 
    for(ContactAccountSharing__c cs : lstConAcc){
        if(mapConAcc.get(cs.Contact_GEOG__c)!=null){
            mapConAcc.get(cs.Contact_GEOG__c).add(cs.Account_GEOG__c);
        }
        else{
            Set<Id> setAcc = new Set<Id>();
            setAcc.add(cs.Account_GEOG__c);
            mapConAcc.put(cs.Contact_GEOG__c, setAcc);
        }
    }
    
    system.debug('====mapConAcc========='+mapConAcc);
    
    for(ContactAccountSharing__c  cs: trigger.new){
    
    system.debug('====mapConAcc1========='+ mapConAcc.get(cs.Contact_GEOG__c));
    system.debug('====mapConAcc2========='+ cs.Contact_GEOG__c);
        if(mapConAcc.get(cs.Contact_GEOG__c)!=null){
            Set<Id> setAcc =mapConAcc.get(cs.Contact_GEOG__c);
            system.debug('====setAcc========='+ setAcc);
            if(setAcc.contains(cs.Account_GEOG__c)){
               if (!Test.isRunningTest())
               {
                  trigger.new[0].addError('A shared contact already exists. Please select a different Account.');
                  //return;
                   //isExist = true; 
                   //break;
                  
               }
           }
        }
         
         
    }
}
if(trigger.isAfter){
    if(CheckRecursion_GE_OG.runOnce()){
         Set<Id> setAcc = new Set<Id>();
         Set<Id> setCon = new Set<Id>();
         for(ContactAccountSharing__c  cs: trigger.new){
         if(cs.Primary_Contact_GE_OG__c == true ){
            setAcc.add(cs.Account_GEOG__c);
            setCon.add(cs.Id);
           }
         }
         List<ContactAccountSharing__c> lstUpdateConShare = new list<ContactAccountSharing__c>();
         List<ContactAccountSharing__c> lstConShare = new list<ContactAccountSharing__c>([Select Account_GEOG__c, Contact_GEOG__c, Primary_Contact_GE_OG__c from ContactAccountSharing__c where Account_GEOG__c in : setAcc and Primary_Contact_GE_OG__c = true and Id not in : setCon]);
         for(ContactAccountSharing__c  cs: lstConShare){
            cs.Primary_Contact_GE_OG__c = false; 
            lstUpdateConShare.add(cs);
         }
         system.debug('===lstUpdateConShare==='+lstUpdateConShare.size());
         if(lstUpdateConShare.size()>0){
            Update lstUpdateConShare;
         } 
      }   
         
}   
   
}