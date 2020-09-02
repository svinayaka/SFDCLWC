@isTest
public class GE_OG_UpdatePrimaryAccountTrigger_Test{

  static testMethod void UpdatePrimaryAccountTest1(){
    
    account Racc = new account();
    Racc.name = 'Test1';
    Racc.recordtypeid= Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
    Racc.ShippingCountry = 'India';
    Racc.Account_Tier_GEOG__c = 'Country';
    Racc.Type = 'Direct Customer';
    Racc.Classification__c = 'Strategic';
    insert Racc;

    account Cacc = new account();
    Cacc.name = 'Test2';
    Cacc.Account_Tier_GEOG__c='LE';
    Cacc.recordtypeid= Schema.SObjectType.Account.getRecordTypeInfosByName().get('CMF Approved').getRecordTypeId();
    Cacc.ShippingCountry = 'India';
    //Cacc.Account_Tier_GEOG__c = 'Global';
    Cacc.Oil_Gas_Parent_Account__c = Racc.Id; 
    insert Cacc;

    GE_PRM_Channel_Appointment__c ca = New GE_PRM_Channel_Appointment__c();
    ca.GE_PRM_Appointment_Type__c = 'New';
    ca.GE_PRM_Tier_2_P_L__c = 'DTS';
    ca.GE_PRM_Account_Name__c = Cacc.Id;
    Insert ca;
/**
    Apttus__APTS_Agreement__c ag = new Apttus__APTS_Agreement__c();
    ag.Name = 'Test Agreement';
    ag.Apttus__Account__c = Cacc.Id;
    ag.GE_PRM_Channel_Appointment_ID__c = ca.Id ;
    //ag.CurrencyIsoCode = 'AED - UAE Dirham';
    ag.recordtypeid= Schema.SObjectType.Apttus__APTS_Agreement__c.getRecordTypeInfosByName().get('Channel Addendum Agreement').getRecordTypeId();             
    insert ag;   */

    Contract c = new Contract(); 
    c.Name = 'Test Con';
    c.AccountId = Cacc.Id;
    c.GE_PRM_Channel_Appointment_ID__c = ca.Id ;
    c.GE_PRM_Business_Tier_1__c = 'Oil & Gas (O&G)';
    c.GE_HQ_Buss_Tier1__c = 'PII';
    c.GE_HQ_Buss_Tier2__c = 'Reuter Stokes';
    c.GE_OG_Legal_Entity__c = 'ALGESCO SPA';
    c.StartDate =  Date.Today();
    c.GE_OG_Contract_End_Date__c = Date.Today() +8 ;
    c.Status  =  'Generate Draft'; 
    c.GE_OG_FA_Type__c = 'Discount';
    c.GE_PRM_Commercial_Account__c = null;
    c.recordtypeid= Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Channel Addendum Agreement').getRecordTypeId();      
    insert c;
    }

  
}