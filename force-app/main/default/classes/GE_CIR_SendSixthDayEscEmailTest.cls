@isTest
                                
public class GE_CIR_SendSixthDayEscEmailTest {

    static testmethod void test() {
        
        //String query = 'select Id,IS_CIR_Sixth_Day_Esc_Email_Sent__c  from Case where recordtypeid = :cirRecID AND  Status != :CloseStatus AND Origin != :EccrOrigin AND Origin !=  :TMSOrigin  AND((GE_OG_Resolution_Committed_date_CIR__c != null AND Variance_To_Commited__c = 7) OR (GE_OG_Resolution_Committed_date_CIR__c = null AND Aging__c = 7)) AND IS_CIR_Sixth_Day_Esc_Email_Sent__c = false AND GE_OG_Escalation_Level_CIR__c = :Escalated AND IS_CIR_sixthday_Notification_Sent__c = false ';
 String cirRecID = Schema.SObjectType.Case.getRecordTypeInfosByName().get('CIR').getRecordTypeId();      
      account a = new account();
        a.name='test';
        insert a;
        
        GE_Installed_Base__c gi = new GE_Installed_Base__c();
        gi.name='test';
        gi.Account__c=a.id;
        insert gi;
        case c = new case();  
        c.recordtypeid=cirRecID;       
        c.GE_OG_CIR_Site_Country__c='AFGHANISTAN';        
        c.GE_OG_Business_CIR__c='TMS';        
        c.GE_ES_Sub_Type__c='MCS Sub Status';   
        c.accountid=a.id;
       c.Status='Open';
       c.Origin='Test';
       c.GE_OG_Resolution_Committed_date_CIR__c=null;
       c.GE_OG_Escalation_Level_CIR__c = 'Escalated';
       c.IS_CIR_sixthday_Notification_Sent__c = false;
      
       insert c;
 
       Test.startTest();
       GE_CIR_SendSixthDayEscEmail c1 = new GE_CIR_SendSixthDayEscEmail();
       Database.executeBatch(c1);
       Test.stopTest();

    }
     static testmethod void test1() {
       // Date myDate = Date.newInstance(2015, 4, 30);  
Date newDate = date.today().addDays(-7);
        //String query = 'select Id,IS_CIR_Sixth_Day_Esc_Email_Sent__c  from Case where recordtypeid = :cirRecID AND  Status != :CloseStatus AND Origin != :EccrOrigin AND Origin !=  :TMSOrigin  AND((GE_OG_Resolution_Committed_date_CIR__c != null AND Variance_To_Commited__c = 7) OR (GE_OG_Resolution_Committed_date_CIR__c = null AND Aging__c = 7)) AND IS_CIR_Sixth_Day_Esc_Email_Sent__c = false AND GE_OG_Escalation_Level_CIR__c = :Escalated AND IS_CIR_sixthday_Notification_Sent__c = false ';
String cirRecID = Schema.SObjectType.Case.getRecordTypeInfosByName().get('CIR').getRecordTypeId();           
      account a = new account();
        a.name='test';
        insert a;
        
        GE_Installed_Base__c gi = new GE_Installed_Base__c();
        gi.name='test';
        gi.Account__c=a.id;
        insert gi;
        case c = new case();  
        c.recordtypeid=cirRecID;       
        c.GE_OG_CIR_Site_Country__c='AFGHANISTAN';        
        c.GE_OG_Business_CIR__c='TMS';        
        c.GE_ES_Sub_Type__c='MCS Sub Status';   
        c.accountid=a.id;
       c.Status='Open';
       c.Origin='Test';
       c.GE_OG_Resolution_Committed_date_CIR__c=newDate;
       c.GE_OG_Escalation_Level_CIR__c = 'Escalated';
       c.IS_CIR_sixthday_Notification_Sent__c = false;
      
       insert c;
 
       Test.startTest();
       GE_CIR_SendSixthDayEscEmail c1 = new GE_CIR_SendSixthDayEscEmail();
       Database.executeBatch(c1);
       Test.stopTest();

    }
    
}