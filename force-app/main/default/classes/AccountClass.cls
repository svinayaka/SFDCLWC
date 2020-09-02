public with sharing class AccountClass {
    @AuraEnabled
     public static List<Product2> getAccountList(){
        return [select id,Name,ProductCode from Product2 where ProductCode !=null limit 5];
     }
}