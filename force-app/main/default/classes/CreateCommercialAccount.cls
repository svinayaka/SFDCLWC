public inherited sharing class CreateCommercialAccount {
    public CreateCommercialAccount() {

    }

    @AuraEnabled(Cacheable = true)
    public static list<Account> retriveAccs(String strAccName) {
        strAccName = '%' + strAccName + '%';
        list<Account> lstAccs = [SELECT  Id, Name, Industry, Phone, Type From Account WHERE Name LIKE :strAccName];

        if(lstAccs.isEmpty()) {
            throw new AuraHandledException('No Record Found..');
        }
        return lstAccs; 
    }
}