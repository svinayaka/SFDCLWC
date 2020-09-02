@istest
private class CaseStatusUpdateTest
{
    static testmethod void testtocovercasestatus()
    {
        account a = new account();
        a.name='test';
        insert a;
        case c = new case();        
        c.GE_OG_CIR_Site_Country__c='AFGHANISTAN';        
        C.GE_OG_Business_CIR__c='TMS'; 
        c.GE_OG_EHS_Product_Safety_CIR__c='Accident';
        c.GE_OG_Customer_Impact_CIR__c='High';
        c.GE_OG_Customer_Escalation_CIR__c='High';
        //c.GE_OG_Sub_Business_CIR__c='Trees';    
        c.GE_OG_GE_Executive_Request_CIR__c='Yes'; 
        c.GE_ES_Sub_Type__c='MCS Sub Status';   
        c.accountid=a.id;   
      
        c.status='new';
        c.GE_OG_CIR_Site_Name__c='sdf';
       
        insert c; 
        
        GE_Case_Notes__c gcn = new GE_Case_Notes__c ();
        gcn.GE_Body__c ='test';
        gcn.ge_case__c=c.id;
        insert gcn;
    }



}