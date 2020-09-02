/* 
Class Name: GEHQBusCourtesy
Purpose/Overview: Class to Implement Partial refresh for Business courtesy Object.
Author : Rajkumar  Malla
Created Date:2/12/2012
Test Class: GEHQBusCourtesyTest
*/

public class GEHQBusCourtesy{

     private final GE_HQ_Business_Courtesy__c bc; 
     Apexpages.StandardController controller;  
    
     public GEHQBusCourtesy(ApexPages.StandardController stdController) {         
         this.bc = (GE_HQ_Business_Courtesy__c)stdController.getRecord(); 
         controller = stdController;    
     } 


     public PageReference doSave() { 
         
         controller.save();
         String theId = ApexPages.currentPage().getParameters().get('id'); 
         PageReference pageRef = new PageReference('/' + theId);         
         pageRef.setRedirect(true);         
         return null; 
     }
}