/*
================================================================
Class Name      : GE_DS_LocWithIPs_ControllerTest
Author          : Jagan Mohan Cherlakola
Created Date    : 10/01/2014
Reason          : This Test Class is used with 'GE_DS_LocWithIPs' and 'GE_DS_LocWithIPs_Controller'  to display the configuration of Installed Products on Location.

================================================================
*/


@isTest(seealldata = true)

   public class GE_DS_LocWithIPs_ControllerTest{
     static TestMethod void GE_DS_LocWithIPs_CntrlTest(){
     Id DSRecordtype =  Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('D&S').getRecordTypeId();
     
     SVMXC__Site__c loc = new SVMXC__Site__c(Name='USA',GE_DS_Heliport_City__c='California',GE_DS_Heliport_Country__c='USA');
     insert loc;
    
     SVMXC__Installed_Product__c ip = new SVMXC__Installed_Product__c(Name='TsetIP',SVMXC__Status__c= 'Installed',SVMXC__City__c='Hyderabad',SVMXC__Country__c='India',SVMXC__Installation_Notes__c='testclass');
     insert ip;
     //ip.SVMXC__Site__c =loc.id;    
     //ip.SVMXC__Serial_Lot_Number__c='23423';
     //update ip;
     
         SVMXC__Installed_Product__c ip2 = new SVMXC__Installed_Product__c(Name='TsetIP1',SVMXC__Status__c= 'Installed',SVMXC__City__c='Hyderabad',SVMXC__Country__c='India',SVMXC__Installation_Notes__c='testclass1');
     insert ip2;
     
     List<SVMXC__Installed_Product__c> ipList = new  List<SVMXC__Installed_Product__c>();
     ipList.add(ip);ipList.add(ip2);
     
     
     String sBy;
     String sDir;
     List<SObject> rList = new List<SObject>();
     rList.add(IP);
    
     
     GE_DS_LocWithIPs_Controller loct = new GE_DS_LocWithIPs_Controller(new ApexPages.StandardController(loc));
     
     loct.loc_id = loc.id;
     loct.empty();
     loct.getIps();
     loct.sortBy='Name';
     loct.sortDir ='ASC';
     loct.sortList(ipList);
     
     
    
     GE_DS_LocWithIPs_Controller loct1 = new GE_DS_LocWithIPs_Controller(new ApexPages.StandardController(loc));
     
     loct1.loc_id = loc.id;
     loct1.getIps();
     loct1.sortDir='DESC';
     loct1.sortBy='Name';
    loct.sortList(ipList);
  
    
     
     
     
    }
    
    
    }