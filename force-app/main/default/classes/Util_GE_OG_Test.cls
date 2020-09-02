/*
Class/Trigger Name     : Util_GE_OG_Test
Used For               : Util_GE_OG
Purpose/Overview       : Test Class to calculate the code coverage for the Util_GE_OG
Scrum Team             : Transformation - OPPTY MGMT
Requirement Number     : R-23281
Author                 : Nitish Pandey
Created Date           : 17-Sep-2015

*/

@isTest
//Class will cover all the methods written in the Util Class 'Util_GE_OG'
public class Util_GE_OG_Test
{
    
    public static testMethod void testRecordTypeDetails()
    {
             
        Id RecordTypeId = Util_GE_OG.getRecordTypeDetails('Checklist_Category_ge_og__c','Risk Checklist').getRecordTypeId();
        //Id RecordTypeId1 = Util_GE_OG.getRecordTypeDetails('','').getRecordTypeId();
        
        Schema.RecordTypeInfo rtInfo = Util_GE_OG.getRecordTypeDetails('','');
        
        Country_Region_Mapping_ge_og__c cr = new Country_Region_Mapping_ge_og__c();
        cr.name = 'INDIA';
        cr.country_name_ge_og__c = 'INDIA';
        cr.region_ge_og__c = 'India';
        insert cr;
        
        String regionName = Util_GE_OG.regionPopulateByCountry('India');
        sObject ur = Util_GE_OG.queryObjectFields(UserInfo.getUserId());
    }
    
    public static testMethod void testOpportunityGFSExcetuionDate()
    {
        Date excetuionDate1 = Util_GE_OG.CalculateOpportunityGFSExcetuionDate(false,'India',null,date.today(),new map<String,Double>(),new map<String,Double>());
        
        Date excetuionDate2 = Util_GE_OG.CalculateOpportunityGFSExcetuionDate(false,'India',date.today(),date.today(),new map<String,Double>(),new map<String,Double>());
        
        Date excetuionDate3 = Util_GE_OG.CalculateOpportunityGFSExcetuionDate(true,'India',date.today(),date.today().addDays(-1),new map<String,Double>(),new map<String,Double>());
    
        
    }

}