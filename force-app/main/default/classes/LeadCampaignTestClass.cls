@istest
public class LeadCampaignTestClass{
private static testMethod void testclass1 () {
 Campaign theme = new Campaign();
        theme.Name='Test Theme';
        theme.RecordTypeId=Util_GE_OG.getRecordTypeDetails('Campaign','Theme').getRecordTypeId();
        theme.Description='Test Theme for Description';
        theme.OwnerId=UserInfo.getUserId();
        theme.Material_Documentation_link_ge_og__c='www.google.com';
        theme.StartDate = System.today()-10;
        theme.EndDate=System.today()+50;
        insert theme;}
}