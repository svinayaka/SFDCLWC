/*
Type Name [Class/Trigger/Page Name] : Test Class - GEOGMC_CloneWOControllerTest
Purpose/Overview                    : Test class written for the apex class GEOGMC_CloneWOController
Functional Area                     : ServiceMax
Author                              : Vivek Sharma
Created Date                        : 13 Feb 2013
*/

@isTest(seeAllData=true)
public class GEOGMC_CloneWOControllerTest{
    static testMethod void myUnitTest() {
        Account acc = new Account(name = 'test account', ShippingStreet = '15115 OXNARD ST', ShippingCity = 'VAN NUYS', ShippingState = 'LA', ShippingPostalCode = '914112615', ShippingCountry = 'UNITED STATES');
        insert acc;
        //Account acc = [select id from Account where name = 'IPL HARDING STREET'];
        SVMXC__Skill__c skill=new SVMXC__Skill__c();
        insert skill;
     
         SVMXC__Service_Order__c wo = new SVMXC__Service_Order__c(SVMXC__Skill__c=skill.id,SVMXC__Company__c = acc.Id,SVMXC__Order_Status__c='Open',SVMXC__Order_Type__c='Depot Repair');
         insert wo;
     test.starttest();
        // page1 = ApexPages.currentPage().getParameters().get('Id',);
         PageReference page1=Page.GEOGMC_CloneWO;
        page1.getParameters().put('Id', wo.id);
        Test.setCurrentPage(page1);
        // ApexPages.StandardController sc1 = new ApexPages.StandardController(Mcsobj1);
        ApexPages.StandardController sc = new ApexPages.StandardController(wo);
        GEOGMC_CloneWOController woclone = new GEOGMC_CloneWOController(sc);
        woclone.reDirect();
               
     test.stoptest();  
    }
}