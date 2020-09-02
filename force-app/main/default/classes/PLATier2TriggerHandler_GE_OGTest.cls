/*
Class/Trigger Name     : PLATier2TriggerHandler_GE_OGTest 
Purpose/Overview       : Test Class to calculate the code coverage for the PLATier2TriggerHandler_GE_OG class
Scrum Team             : Transformation - Deal MGMT
Requirement Number     : 
Author                 : Sonali Rathore
Created Date           : 22-MAR-2018

*/
@isTest 
public class PLATier2TriggerHandler_GE_OGTest
{
    static testMethod void testMethod1() 
    {
    
    Account_Planning__c testAccPlanning = new Account_Planning__c();
    testAccPlanning.Name='TestPlan Account' ;
    testAccPlanning.Account_Name_GEOG__c='0011200001FxZKL';
    testAccPlanning.Year_GEOG__c='2049';
    testAccPlanning.Status_GEOG__c='Active';
    insert testAccPlanning ;
    
    //Test.StartTest(); 
    //plaTier.plaTier2UpdateFunctionality(plaTiernew);
    /*Product_Line_Assessment_Tier_3_ge_og__c platier3new = new Product_Line_Assessment_Tier_3_ge_og__c();
    platier3new.Tier_2_ge_og__c=platier2new.Tier_2_ge_og__c;
    platier3new.Product_Line_Assessment_Tier_2_ge_og__c=platier2new.id;   */
    //Test.StopTest();
    }
}