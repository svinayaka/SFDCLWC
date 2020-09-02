@isTest
public class OG_FA_Content_Display_On_Contract_Test{
    static  TestMethod void OG_FA_Content_Display_On_Contract_Test()
    {
        
        Profile p = [select Id,name from Profile where Name ='OG_Sales/Comm Ops' limit 1];
        string contractPermissionSetId = [select Id from PermissionSet where Label = 'FA Manager'].Id;
        
     User u = new User();
        u.FirstName = 'test';
        u.LastName = 'tester';
        u.Email = 'test@example.com';
        u.Username = 'testingContent@ge.com';
        u.Alias = 'tsf2';
        u.emailencodingkey='UTF-8'; 
        u.languagelocalekey='en_US';
        u.localesidkey='en_US';
        //u.profileid = '00eA0000000n90x';
        u.profileid='00eA0000000b6mR';
        u.timezonesidkey='America/New_York';
         
        u.IsActive = true;
        
        u.profileId = p.id;
        u.GE_HQ_Tier_1_P_L__c='HQ';
            
      insert u; 
    
    PermissionSetAssignment  obj = new PermissionSetAssignment(AssigneeId=u.Id, PermissionSetId=contractPermissionSetId);
    insert obj; 
     
     System.runas(u){ 
        
            account acc=new account();
            acc.name='test';
            insert acc;
            contract c = new contract(name='test',GE_HQ_Buss_Tier1__c='M&C');
            String AddedumRT = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Channel Addendum Agreement').getRecordTypeId();
            c.recordtypeid=AddedumRT;
            contract Ogcontract = c.clone(false,false);
            ogcontract.GE_OG_Evergreen__c = true;
            ogcontract.AccountId = acc.id;
            ogcontract.recordtypeid=AddedumRT;
            insert ogcontract;
            ContentVersion cv=new ContentVersion();
            cv.title='Test title';
            cv.contenturl='http://www.google.co.in';
            cv.GE_ES_Contract__c=Ogcontract.id;
            insert cv;
            OG_FA_Content_Display_On_Contract controller=new OG_FA_Content_Display_On_Contract(new ApexPages.StandardController(Ogcontract));
            controller.init();
         }
    }
}