@isTest()
public class NewChannelPartnerAccessTest{
    
    public static testMethod void test1() {
     NewChannelPartnerAccess controller = new NewChannelPartnerAccess();
    }
    /*public static testMethod void test1() {
    
        PageReference pageRef = Page.NewChannelPartnerAccess;
        Test.setCurrentPage(pageRef);
        Account acc = createBaseData();
        
        ApexPAges.StandardController sc = new ApexPages.StandardController(acc);
        NewChannelPartnerAccess controller = new NewChannelPartnerAccess(sc);

        controller.confirm();
        
        for(NewChannelPartnerAccess.ContactWrap cw:controller.contactList)
            cw.Selected = true;
            
        controller.runback();
                    
        controller.confirm();
        
        for(NewChannelPartnerAccess.ContactWrap cw:controller.contactList)
            cw.profile = 'Gold Partner User';
            
        Test.startTest();
        controller.confirm();
        Test.stopTest();
        
        controller.cancel();
        
        sc = new ApexPages.StandardController(acc);
        controller = new NewChannelPartnerAccess(sc);
        
        for(NewChannelPartnerAccess.ContactWrap cw:controller.contactList)
            controller.userId = cw.userId;
        
        controller.email = 'abc12.xyz@ge.com';
        
        controller.changeEmailCtrl();
        if(controller.userId != null)
        controller.resetPwd();
        
        for(NewChannelPartnerAccess.ContactWrap cw:controller.contactList)
            cw.Selected = false;
            
        for(NewChannelPartnerAccess.ContactWrap cw:controller.contactList)
            cw.profile = 'Gold Partner User';
            
        controller.confirm();
 }
    
    public static Account createBaseData(){
    
        User thisUser = [Select Id from User where Id = :UserInfo.getUserId()];
        
        Account acc;
      
        System.runAs ( thisUser ) { 
            
            acc = new Account(Name='Test', GE_HQ_New_Account_Street__c='Test',GE_HQ_New_Account_City__c='Test',
                                GE_HQ_New_Account_State_Province__c='Test',GE_HQ_New_Account_Zip_Postal_Code__c='Test',
                                GE_HQ_New_Account_Country__c='BAHRAIN',GE_PW_Phone_New_Request__c='1234567890');
            insert acc;
            
            Contact conc = new Contact(FirstName='Test', LastName='Test', Tier_1_P_L__c='Oil & Gas (O&G)',Tier_2_P_L__c='PII Pipeline Solutions',
                                Email='abc.xyz@ge.com',accountId=acc.Id);
            insert conc;
            
        }
        return acc;
    }
    public static testMethod void test2() {
    
        PageReference pageRef = Page.NewChannelPartnerAccess;
        Test.setCurrentPage(pageRef);
        Account acc = createBaseData();
        
        ApexPAges.StandardController sc = new ApexPages.StandardController(acc);
        NewChannelPartnerAccess controller = new NewChannelPartnerAccess(sc);

        controller.confirm();
        
        for(NewChannelPartnerAccess.ContactWrap cw:controller.contactList)
            cw.Selected = true;
            
        controller.runback();
                    
        controller.confirm();
        
        for(NewChannelPartnerAccess.ContactWrap cw:controller.contactList)
            cw.profile = 'Gold Partner User';
            
        Test.startTest();
        controller.confirm();
        Test.stopTest();
 }
    
    private Messaging.SingleEmailMessage[] sent;
    public void sendEmail(Messaging.SingleEmailMessage[] mail) {
        Messaging.sendEmail(mail);
        sent = mail;    
      }*/
}