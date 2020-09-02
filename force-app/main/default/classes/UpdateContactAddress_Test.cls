@isTest    
class UpdateContactAddress_Test
{

    private static testMethod void UpdateshippingAddress()
    {
    
       
         
         
        Account acnt = AccountTestDataFactory.createAccountWithStrength('Customer value perception','Relationship Account','EPC','Country','Strategic','FOUNDRY','Medium');
         
         //Creating LE account    
        account accLE = new account();
        accLE.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','CMF Approved').getRecordTypeId();
        accLE.name = 'Test Account LE';
        accLE.Account_Tier_GEOG__c = 'LE';
        accLE.Oil_Gas_Parent_Account__c = acnt.Id;
        accLE.Country_GEOG__c = 'INDIA';
        accLE.Type = 'EPC';
        accLE.Account_Status__c='CC Approved';
        accLE.Classification__c = 'Do Not Contact';
        accLE.ShippingCountry = 'India';
        insert accLE;
        
        
        
        system.debug('LE accougfynt:'+accLE);
        
        Account LeAcc=[select id,name,Account_Status__c from Account where id=:accLE.id];
        system.debug('LE account:'+LeAcc);
         Contact cont = new Contact();
         cont.GE_OG_Contact_Audience__c='Customer Care';
         cont.LastName = 'Test';
         cont.FirstName = 'Test';
         cont.Phone = '98745632145';
         cont.Email = 'test@test1298.com';
         cont.GE_PRM_Primary_Contact__c = True;
         cont.AccountId = acnt.Id;
         cont.GE_OG_Site_LegalEntity_Account__c=LeAcc.Id;
         insert cont;
         
         UpdateContactAddress.DisplayAddressDetails(cont.id);
         UpdateContactAddress.DisplayButtons(cont.id);
         UpdateContactAddress.UpdateShippingAddress(cont.id);
    }

}