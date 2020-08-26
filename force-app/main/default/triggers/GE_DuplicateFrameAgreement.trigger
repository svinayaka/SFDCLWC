/*trigger GE_DuplicateFrameAgreement on Account_Frame_Agreement__c (before insert,after update) {
    
  // Iterate through the list of new records
    
 for (Account_Frame_Agreement__c afg : trigger.new)
 {              
 // We only care if there is one record     
 List<Account_Frame_Agreement__c> resultList = [SELECT Contract_Name__c,Account_Name__c FROM  Account_Frame_Agreement__c WHERE  Contract_Name__c = :afg.Contract_Name__c    AND  Account_Name__c = :afg.Account_Name__c];
                 // Raise the error back if any records found        
 if (!resultList.isEmpty()) {
 

  afg.addError('Duplicate record on Junction Object, Selected Account is already associated to this Frame Agreement');
         }  

  }

}*/

trigger GE_DuplicateFrameAgreement on Account_Frame_Agreement__c (before insert,before update){
List<Account_Frame_Agreement__c> nafglst= new List<Account_Frame_Agreement__c>();
List<Account_Frame_Agreement__c> eafglst= new List<Account_Frame_Agreement__c>();
Map<String,String> afgmap= new Map<String,String>();
for (Account_Frame_Agreement__c afg : trigger.new)
 {   
     afgmap.put(afg.Contract_Name__c, afg.Account_Name__c);           
     //nafglst.add(afg);
 
 }
 System.debug('$$afgmap'+afgmap);
 eafglst= [SELECT Id,Contract_Name__c,Account_Name__c FROM  Account_Frame_Agreement__c WHERE  Contract_Name__c IN:afgMap.KeySet()];
 
 System.debug('$$eafglst'+eafglst);
 Map<String, Set<String>> mapContractTosetAccount = new Map<String, Set<String>>();
 for(Account_Frame_Agreement__c AFA    :  eafglst ){
    if(AFA.Contract_Name__c != null && AFA.Account_Name__c != null ){
        
        if(mapContractTosetAccount.get(AFA.Contract_Name__c) != null ){
            Set<String> setAccIds =  mapContractTosetAccount.get(AFA.Contract_Name__c) ;
            setAccIds.add( AFA.Account_Name__c);
            mapContractTosetAccount.put(AFA.Contract_Name__c, setAccIds);
        }else{
            Set<String> setAccIds = new Set<String> ();
            setAccIds.add( AFA.Account_Name__c);
            mapContractTosetAccount.put(AFA.Contract_Name__c, setAccIds);
        }               
        
    }
 }
 
 
 for(Integer i = 0 ; i < trigger.new.size() ; i++ ){
    if(mapContractTosetAccount != null){
        if(mapContractTosetAccount.get(trigger.new[i].Contract_Name__c) != null && mapContractTosetAccount.get(trigger.new[i].Contract_Name__c).size() > 0  ){
    
            Set<string> setRelatedAccountIds = mapContractTosetAccount.get(trigger.new[i].Contract_Name__c) ;
            if(setRelatedAccountIds.contains(trigger.new[i].Account_Name__c) == true ){
                trigger.new[i].addError('Duplicate record on Junction Object, Selected Account is already associated to this Frame Agreement');
            }
        }
    }
 
 }
 
 
 /*
 
for(Account_Frame_Agreement__c dafg : eafglst){
  if(dafg.Account_Name__c == afgMap.get(dafg.Contract_Name__c))
  
  { System.debug('$$Entered Dup loop');
  System.debug('$$dafg'+dafg);
    List<Account_Frame_Agreement__c> dup= new List<Account_Frame_Agreement__c>();
    dup.add(trigger.newmap.get(dafg.id));
    dup[0].addError('Duplicate record on Junction Object, Selected Account is already associated to this Frame Agreement');
    //System.debug('$$dafg'+dup);
    //System.debug('$$afgMap.get(dafg.Contract_Name__c).Account_Name__c)'+afgMap.get(dafg.Contract_Name__c).Account_Name__c);
   
  }
  
}*/


}