/*
Test Class Name: GE_ES_CompanyName_Trigger_Test
Used In : GE_ES_CompanyName Trigger on Lead
Purpose/Overview : Test Class to calculate the code coverage for GE_ES_CompanyName Trigger on Lead
Functional Area : Opportunity Management
Author: Praveena Chintapalli 
Created Date: 3/3/2011
Test Class Name : 
*/

@isTest
private class GE_ES_CompanyName_Trigger_Test
{
    static testMethod void TestCase01()
    {
        //creating an account
        Account acc = new Account();
        acc.Name = 'TestAccount1';
        acc.GE_HQ_New_Account_Street__c = 'ABC Street';
        acc.GE_HQ_New_Account_State_Province__c = 'AP';
        acc.GE_HQ_New_Account_City__c = 'Hyd';
        acc.GE_HQ_New_Account_Country__c = 'INDIA';
        acc.GE_HQ_New_Account_Zip_Postal_Code__c = '500038';
        insert acc;
        
        //creating a sales region
        GE_ES_Sales_Region__c SalesReg = new GE_ES_Sales_Region__c();
        SalesReg.Name = 'Test Sales Region';
        SalesReg.GE_ES_P_L__c = 'ES';
        insert SalesReg;
        
        //creating an install base
        GE_Installed_Base__c IB = new GE_Installed_Base__c();
        IB.Name = 'Test IB';
        IB.Account__c = acc.Id;
        insert IB;
        
        //creating a lead
        Lead lead1 = new Lead();
        //lead1.Name = 'Test Lead';
        lead1.GE_ES_Sales_Region__c = SalesReg.Id;
        lead1.GE_ES_IB_Serial_Number__c = IB.Id;
        lead1.GE_HQ_Business_Tier1__c = 'Energy Management (EM)';
        lead1.GE_HQ_Business_Tier2__c = 'Digital Energy (DE)';
        //lead1.GE_ES_P_L__c = 'DE';
        lead1.Company = 'Satyam';
        //lead1.Name = 'Praveena Ch';
        lead1.FirstName = 'Praveena';
        lead1.LastName = 'Ch';
        lead1.Email = 'praveena@ge.com';
        insert lead1;  
    }
}