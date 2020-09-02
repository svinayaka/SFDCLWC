public class O_PopulateMemberofOnAssetHandler_GE_OG {
    public void populateMemberOf(List<Asset> assetList){
        for (Asset a: assetList){
            system.debug('Inside O_PopulateMemberofOnAsset-------------');
            system.debug('a.accountId'+a.accountId);
            Account a1 = new Account();
            a1= [Select Id, Member_of_GE_OG__c from account where id =: a.accountId];
            system.debug('a1'+a1);
           //commented by Harsha C if(a1.Member_of_GE_OG__c != null){
            a.Account_Member_of_ge_og__c = a1.Member_of_GE_OG__c;
           // }
            
            system.debug('a.Account_Member_of_ge_og__c after insert------------'+a.Account_Member_of_ge_og__c);
        }
        
    }
    
     public void populateMemberOfonupdate(List<Asset> newassetList,Map<Id,Asset> oldassetMap){
        for (Asset a: newassetList){
        if(a.accountid != oldassetMap.get(a.id).accountid){
        }
            system.debug('Inside O_PopulateMemberofOnAsset-------------');
            system.debug('a.accountId'+a.accountId);
            Account a1 = new Account();
            a1= [Select Id, Member_of_GE_OG__c from account where id =: a.accountId];
            system.debug('a1'+a1);
           //Commented By Harsha C if(a1.Member_of_GE_OG__c != null){
            a.Account_Member_of_ge_og__c = a1.Member_of_GE_OG__c;
           // }
            
            system.debug('a.Account_Member_of_ge_og__c after insert------------'+a.Account_Member_of_ge_og__c);
        }
        
    }
}