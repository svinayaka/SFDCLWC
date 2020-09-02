@isTest
public class Test_AccountChatterSubscribe_Unsubscribe{

     public static testMethod void testsubscribeToAccountChatter(){
        test.startTest();
        List<Id> lstAccIds = new List<Id>();
        Account acnt = new Account();
        acnt.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        acnt.Account_Tier_GEOG__c = 'Country';
        acnt.Name='Customer value perception';
        acnt.Type = 'EPC';
        acnt.Classification__c = 'Strategic';
        acnt.GE_ES_Primary_Industry__c = 'Industrial';
        acnt.ownerId = UserInfo.getUserId();
        acnt.Strength__c = 'Medium';
        insert acnt;
        /* 
         //
         EntitySubscription es = new EntitySubscription (ParentId = acnt.id,SubscriberId = UserInfo.getUserId());
          Insert es;
         
         //
        */
        AccountChatterSubscribe_Unsubscribe.AccountChatterSubscribeParser objParse = new AccountChatterSubscribe_Unsubscribe.AccountChatterSubscribeParser();
        objParse.accountId = acnt.id;
        objParse.loginUserID = acnt.ownerId;
        objParse.isUpdated = FALSE;
        objParse.strAction = 'Unfollow';
        List<AccountChatterSubscribe_Unsubscribe.AccountChatterSubscribeParser> lstParse = new List<AccountChatterSubscribe_Unsubscribe.AccountChatterSubscribeParser>();
        lstParse.add(objParse);
        AccountChatterSubscribe_Unsubscribe.subscribeToAccountChatter(lstParse);
        objParse.isUpdated = FALSE;
        objParse.strAction = 'Unfollow';
        AccountChatterSubscribe_Unsubscribe.subscribeToAccountChatter(lstParse);
        test.stopTest();
    }
    
     public static testMethod void testsubscribeToAccountChatter1(){
        test.startTest();
        List<Id> lstAccIds = new List<Id>();
        Account acnt = new Account();
        acnt.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        acnt.Account_Tier_GEOG__c = 'Country';
        acnt.Name='Customer value perception';
        acnt.Type = 'EPC';
        acnt.Classification__c = 'Strategic';
        acnt.GE_ES_Primary_Industry__c = 'Industrial';
        acnt.ownerId = UserInfo.getUserId();
        acnt.Strength__c = 'Medium';
        insert acnt;
         
         //
         
         
         //
        
        AccountChatterSubscribe_Unsubscribe.AccountChatterSubscribeParser objParse = new AccountChatterSubscribe_Unsubscribe.AccountChatterSubscribeParser();
        objParse.accountId = acnt.id;
        objParse.loginUserID = acnt.ownerId;
        objParse.isUpdated = FALSE;
        objParse.strAction = 'Unfollow';
        List<AccountChatterSubscribe_Unsubscribe.AccountChatterSubscribeParser> lstParse = new List<AccountChatterSubscribe_Unsubscribe.AccountChatterSubscribeParser>();
        lstParse.add(objParse);
        AccountChatterSubscribe_Unsubscribe.subscribeToAccountChatter(lstParse);
        objParse.isUpdated = FALSE;
        objParse.strAction = 'Unfollow';
        
        EntitySubscription es = new EntitySubscription (ParentId = acnt.id,SubscriberId = acnt.ownerId);
        Insert es;
        AccountChatterSubscribe_Unsubscribe.subscribeToAccountChatter(lstParse);
        test.stopTest();
    }
}