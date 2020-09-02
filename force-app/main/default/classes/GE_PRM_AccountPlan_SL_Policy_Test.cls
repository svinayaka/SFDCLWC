@isTest

public class GE_PRM_AccountPlan_SL_Policy_Test {
    
    /*static testmethod void Testmethod1(){
    String  appObjPrefix = GE_HQ_Account_Plan__c.SObjectType.getDescribe().getKeyPrefix(); 
    Messaging.InboundEmail email = new Messaging.InboundEmail();
    GE_HQ_Account_Plan__c accplan=new GE_HQ_Account_Plan__c(name='Sample Account Plan');
    
    insert accplan;
   
     accplan= [SELECT Name,Id,ownerid,Additional_Comments_GEOG__c,Channel_Last_acknowledgment_Date__c FROM GE_HQ_Account_Plan__c WHERE ID=:accplan.id limit 1];
     update accplan;
     
    email.subject = accplan.id; 
     
    email.plainTextBody = 'Agree'+'\n'+'Agree'+'\n'+'Test Comments'+'Test'+'\n'+'Testing'; 
    accplan.Additional_Comments_GEOG__c='TestComments';
    accplan.Channel_Last_acknowledgment_Date__c=Date.today();
    String[] emailBody=email.plainTextBody.split('\n');
    emailBody[0]='agree';
    
    //String emailapprej=emailBody[0];
    String emailapprej='al';
    
    update accplan;
    Messaging.InboundEnvelope envelope;    
    GE_PRM_AccountPlan_SL_Policy ssl = new GE_PRM_AccountPlan_SL_Policy();
    ssl.handleInboundEmail(email,envelope );
    system.debug('PLAIN TEXT BODY***************:'+email.plainTextBody);    
    }
    
    static testmethod void Testmethod11(){
    String  appObjPrefix = GE_HQ_Account_Plan__c.SObjectType.getDescribe().getKeyPrefix(); 
    Messaging.InboundEmail email = new Messaging.InboundEmail();
   GE_HQ_Account_Plan__c accplan=new GE_HQ_Account_Plan__c(name='Sample Account Plan');
   
   insert accplan;
   
     accplan= [SELECT Name,Id,ownerid,Additional_Comments_GEOG__c,Channel_Last_acknowledgment_Date__c FROM GE_HQ_Account_Plan__c WHERE ID=:accplan.id limit 1];
     update accplan;
     
    email.subject = accplan.id; 
    
    
    email.plainTextBody = 'modify'+'\n'+'modify'+'\n'+'Test Comments'+'modify'+'\n'+'modify'; 
    accplan.Additional_Comments_GEOG__c='TestComments';
    accplan.Channel_Last_acknowledgment_Date__c=Date.today();
    String[] emailBody=email.plainTextBody.split('\n');
    emailBody[0]='modify';
    
    
    String emailapprej='al';
 
    update accplan;
    Messaging.InboundEnvelope envelope;    
    GE_PRM_AccountPlan_SL_Policy ssl = new GE_PRM_AccountPlan_SL_Policy();
    ssl.handleInboundEmail(email,envelope );
    system.debug('PLAIN TEXT BODY***************:'+email.plainTextBody); 
    
   
    
    
    }
    
    
    //Test for only Agree or Modify with no comments
    
    static testmethod void testWithoutComments(){
    String  appObjPrefix = GE_HQ_Account_Plan__c.SObjectType.getDescribe().getKeyPrefix(); 
    Messaging.InboundEmail email = new Messaging.InboundEmail();
   GE_HQ_Account_Plan__c accplan=new GE_HQ_Account_Plan__c(name='Sample Account Plan');
   
   insert accplan;
   
     accplan= [SELECT Name,Id,ownerid,Additional_Comments_GEOG__c,Channel_Last_acknowledgment_Date__c FROM GE_HQ_Account_Plan__c WHERE ID=:accplan.id limit 1];
     update accplan;
     
    email.subject = accplan.id; 
    
    
    email.plainTextBody = 'modify'; 
    accplan.Additional_Comments_GEOG__c='TestComments';
    accplan.Channel_Last_acknowledgment_Date__c=Date.today();
    String[] emailBody=email.plainTextBody.split('\n');
    emailBody[0]='modify';
    
    
    String emailapprej='al';
 
    update accplan;
    Messaging.InboundEnvelope envelope;    
    GE_PRM_AccountPlan_SL_Policy ssl = new GE_PRM_AccountPlan_SL_Policy();
    ssl.handleInboundEmail(email,envelope );
    system.debug('PLAIN TEXT BODY***************:'+email.plainTextBody); 
    
   
    
    
    }*/
    
    
    /* public static testMethod void testEmail()

{
test.startTest();



Account acc = new account();
        acc.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        acc.name = 'Test new AccouPlan';
        acc.Account_Tier_GEOG__c = 'Country';
        acc.Classification__c= 'Strategic';
        acc.Type = 'Channel Partner';
        //acc.Type = 'Competitor';
        acc.ShippingCountry = 'India';
        acc.GE_ES_Primary_Industry__c = 'ABC';
        acc.Country_GEOG__c = 'India';
        insert acc;





  Profile[] profiles = [Select p.name, p.id From Profile p WHERE Name = 'Standard User'];
Profile profile;
 if (profiles.size() > 0)
                profile = profiles[0];
            System.Debug('User.ProfileId - ' + profile.Id);
            String profileId = profile.Id;


User one = new User(alias = 'tst_ZZZ', email='bmtestuser@ge.com', 
                emailencodingkey='UTF-8', lastname='testuser_ZZZ', languagelocalekey='en_US', 
                localesidkey='en_US', profileid = profileId, isActive=true, 
                BMUserType__c = BMGlobal.BM_INTERNAL_USER, BMUserAccessType__c = 'FullAccess',                      
                timezonesidkey='America/New_York', username='testuser_KKK@comitydesigns.com');

 insert one;
 
GE_HQ_Account_Plan__c acctPlan1=new GE_HQ_Account_Plan__c(name='Test Account',GE_PRM_Account__c=acc.id,Secondary_Channel_Manager_GEOG__c=one.id);

insert acctPlan1;

ApexPages.StandardController controller = new ApexPages.StandardController(acctPlan1);


ApexPages.currentPage().getParameters().put('Id',acctPlan1.id);

SaveAndOpenPDF sveop=new SaveAndOpenPDF(controller);

 
 
sveop.sendEmailNotification(acctPlan1.id);

test.stopTest();




 
 


    
}
 */

static testMethod void myTestMethod() {




Account acc = new account();
        acc.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        acc.name = 'Test new AccouPlan';
        acc.Account_Tier_GEOG__c = 'Country';
        acc.Classification__c= 'Strategic';
        acc.Type = 'Channel Partner';
        //acc.Type = 'Competitor';
        acc.ShippingCountry = 'India';
        acc.GE_ES_Primary_Industry__c = 'Industrial';
        acc.Country_GEOG__c = 'India';
        insert acc;





  Profile[] profiles = [Select p.name, p.id From Profile p WHERE Name = 'Standard User'];
Profile profile;
 if (profiles.size() > 0)
                profile = profiles[0];
            System.Debug('User.ProfileId - ' + profile.Id);
            String profileId = profile.Id;


User one = new User(alias = 'tst_ZZZ', email='bmtestuser@ge.com', 
                emailencodingkey='UTF-8', lastname='testuser_ZZZ', languagelocalekey='en_US', 
                localesidkey='en_US', profileid = profileId, isActive=true, 
                BMUserType__c = BMGlobal.BM_INTERNAL_USER, BMUserAccessType__c = 'FullAccess',                      
                timezonesidkey='America/New_York', username='testuser_KKK@comitydesigns.com');

 insert one;
 
GE_HQ_Account_Plan__c acctPlan1=new GE_HQ_Account_Plan__c(name='Test Account',GE_PRM_Account__c=acc.id,Secondary_Channel_Manager_GEOG__c=one.id,Channel_Last_acknowledgment_Date__c = Date.today());

insert acctPlan1;
   // Create a new email, envelope object and Attachment
   Messaging.InboundEmail email = new Messaging.InboundEmail();
   Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
   Messaging.InboundEmail.BinaryAttachment inAtt = new Messaging.InboundEmail.BinaryAttachment();
   
     email.plainTextBody = 'Agree'+'\n'+'Agree'+'\n'+'Test Comments'+'Test'+'\n'+'Testing'; 
     
     String[] emailBody = email.plainTextBody.split('\n');
     
     String emailapprej= (emailBody[0]).toLowerCase();

   email.subject = 'test'+' '+acctPlan1.id;
   env.fromAddress = 'user@acme.com';

   // set the body of the attachment
   inAtt.body = blob.valueOf('test');
   inAtt.fileName = 'my attachment name';
   inAtt.mimeTypeSubType = 'plain/txt';

   email.binaryAttachments = new Messaging.inboundEmail.BinaryAttachment[] {inAtt }; 

   // call the class and test it with the data in the testMethod
   GE_PRM_AccountPlan_SL_Policy emailServiceObj = new GE_PRM_AccountPlan_SL_Policy();
   emailServiceObj.handleInboundEmail(email, env );                      
}    

static testMethod void myTestMethod1() {




Account acc = new account();
        acc.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        acc.name = 'Test new AccouPlan';
        acc.Account_Tier_GEOG__c = 'Country';
        acc.Classification__c= 'Strategic';
        acc.Type = 'Channel Partner';
        //acc.Type = 'Competitor';
        acc.ShippingCountry = 'India';
        acc.GE_ES_Primary_Industry__c = 'Liquefied Natural Gas';
        acc.Country_GEOG__c = 'India';
        insert acc;





  Profile[] profiles = [Select p.name, p.id From Profile p WHERE Name = 'Standard User'];
Profile profile;
 if (profiles.size() > 0)
                profile = profiles[0];
            System.Debug('User.ProfileId - ' + profile.Id);
            String profileId = profile.Id;


User one = new User(alias = 'tst_ZZZ', email='bmtestuser@ge.com', 
                emailencodingkey='UTF-8', lastname='testuser_ZZZ', languagelocalekey='en_US', 
                localesidkey='en_US', profileid = profileId, isActive=true, 
                BMUserType__c = BMGlobal.BM_INTERNAL_USER, BMUserAccessType__c = 'FullAccess',                      
                timezonesidkey='America/New_York', username='testuser_KKK@comitydesigns.com');

 insert one;
 
GE_HQ_Account_Plan__c acctPlan1=new GE_HQ_Account_Plan__c(name='Test Account',GE_PRM_Account__c=acc.id,Secondary_Channel_Manager_GEOG__c=one.id,Channel_Last_acknowledgment_Date__c = Date.today());

insert acctPlan1;
   // Create a new email, envelope object and Attachment
   Messaging.InboundEmail email = new Messaging.InboundEmail();
   Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
   Messaging.InboundEmail.BinaryAttachment inAtt = new Messaging.InboundEmail.BinaryAttachment();
   
    email.plainTextBody = 'modify'+'\n'+'modify'+'\n'+'Test Comments'+'modify'+'\n'+'modify'; 
     
     String[] emailBody = email.plainTextBody.split('\n');
     
     String emailapprej= (emailBody[0]).toLowerCase();

   email.subject = 'test'+' '+acctPlan1.id;
   env.fromAddress = 'user@acme.com';

   // set the body of the attachment
   inAtt.body = blob.valueOf('test');
   inAtt.fileName = 'my attachment name';
   inAtt.mimeTypeSubType = 'plain/txt';

   email.binaryAttachments = new Messaging.inboundEmail.BinaryAttachment[] {inAtt }; 

   // call the class and test it with the data in the testMethod
   GE_PRM_AccountPlan_SL_Policy emailServiceObj = new GE_PRM_AccountPlan_SL_Policy();
   emailServiceObj.handleInboundEmail(email, env );                      
}    

    
  
  
    
}