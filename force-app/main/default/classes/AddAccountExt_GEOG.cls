public class AddAccountExt_GEOG{

    public Account acc{get;set;}
    public Contact con{get;set;}
    pageReference pg;

    public AddAccountExt_GEOG(ApexPages.StandardController controller) 
    {
       acc = new account();
       con = new contact();
      
         acc = [SELECT  name, GE_HQ_New_Account_Country__c, Classification__c, Type,RecordTypeId,Account_Tier_GEOG__c From account
       WHERE Id =: controller.getId()];
    }
    
    public pageReference Save() {
        
        acc.id = null;
        insert acc;
        system.debug('accid '+acc+' '+acc.RecordTypeId);
        con.accountId = acc.Id;
        insert con;
        
        return new pageReference('/001/o');
    }
    
    public pageReference Cancel() {
        pg = new pageReference('/001/o');
        return pg;
    }
}