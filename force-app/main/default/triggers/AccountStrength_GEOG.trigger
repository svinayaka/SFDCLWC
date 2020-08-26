trigger AccountStrength_GEOG on Account (Before insert, Before update) {

  //Code to skip trigger
    OG_Trigger_fire_Decision__c lstObj = OG_Trigger_fire_Decision__c.getValues('AccountStrength_GEOG');
    if(lstObj!=null && lstObj.isActive__c == true && lstObj.Object_Name__c=='Account'){
    return;  
    }

else{

    if(trigger.isBefore){
        
    Set<Id> setAccId = new Set<Id>();
    Set<Id> setAccIdre = new Set<Id>();
    Map<Id,Integer> mapAccountId_CountAccountTeamMember = new Map<Id,Integer>();
    
    List<contact> conlst = [SELECT AccountId 
                              FROM Contact
                              WHERE GE_PRM_Primary_Contact__c = true AND AccountId IN: trigger.new];
      for(account a : trigger.new){
            setAccIdre.add(a.id);
        }                        
                              
    List<ContactAccountSharing__c> consharlst = [SELECT Account_GEOG__c
                              FROM ContactAccountSharing__c 
                              WHERE Primary_Contact_GE_OG__c = true AND Account_GEOG__c IN: setAccIdre];
    
    for(Contact objContact : conlst){
        setAccId.add(objContact.AccountId);
    }
    
    for(ContactAccountSharing__c objContactShar : consharlst){
        setAccId.add(objContactShar.Account_GEOG__c);
    }
    
    for(AggregateResult aggResult:[SELECT COUNT(Id) cnt,AccountId
                                       FROM AccountTeamMember
                                       WHERE AccountId IN: setAccId
                                       GROUP BY AccountId])
        {
            if((Id)aggresult.get('AccountId') != null)
            {
                mapAccountId_CountAccountTeamMember.put((Id)aggresult.get('AccountId'),(Integer)aggresult.get('cnt'));
            }
        }
        
    for(Account accnt : trigger.new){
    
    if(accnt.Type!= null && accnt.Classification__c!=null){
        
            accnt.Strength__c= 'Low';
                
                if(accnt.GE_ES_Primary_Industry__c != null && setAccId.contains(accnt.Id))
                {   
                     accnt.Strength__c= 'Medium';
                     
                     if(accnt.Compliance_Ready__c == True && mapAccountId_CountAccountTeamMember.containskey(accnt.Id) && mapAccountId_CountAccountTeamMember.get(accnt.Id) != null && mapAccountId_CountAccountTeamMember.get(accnt.Id) > = 1)
                        
                     {
                         accnt.Strength__c= 'High';
                     }
                } 
          }
     }
     }
}
}