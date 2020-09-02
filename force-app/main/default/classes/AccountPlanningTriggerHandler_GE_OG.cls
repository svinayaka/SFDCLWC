/*
Class/Trigger Name     : AccountPlanningTriggerHandler_GE_OG 
Used Where ?           : AccountPlanningTrigger_GE_OG 
Purpose/Overview       : Add PLA Tier 2 & PLA Tier 3 when Account Planning record is created
Scrum Team             : Transformation - OPPTY MGMT
Requirement Number     : 
Author                 : Sonali Rathore
Created Date           : 10/MAR/2018
Test Class Name        : 
Code Coverage          :                   
*/
public without sharing class AccountPlanningTriggerHandler_GE_OG {

 public void plaTierUpdateFunctionality(List<Account_Planning__c> listAccountPlanning)
    {
      Product_Line_Assessment_Tiers__mdt[] PLAtier2 = [SELECT DeveloperName,MasterLabel,Tier_2_ge_og__c, Tier_3_ge_og__c FROM Product_Line_Assessment_Tiers__mdt where Tier_3_ge_og__c =''];
      Product_Line_Assessment_Tiers__mdt[] PLAtier2_3 = [SELECT DeveloperName,MasterLabel,Tier_2_ge_og__c, Tier_3_ge_og__c FROM Product_Line_Assessment_Tiers__mdt where Tier_3_ge_og__c !='']; 
        List<Product_Line_Assessment_Tier_2_ge_og__c> insertPLATier2= new List<Product_Line_Assessment_Tier_2_ge_og__c>();
        
        for (Account_Planning__c accPlan : listAccountPlanning) {
        
            for (Product_Line_Assessment_Tiers__mdt listPLAtier2 : PLAtier2) {
            
            System.debug('inside AccountPlanningTriggerHandler_GE_OG');
            Product_Line_Assessment_Tier_2_ge_og__c platier2new=new Product_Line_Assessment_Tier_2_ge_og__c();
            platier2new.Tier_2_ge_og__c=listPLAtier2.Tier_2_ge_og__c;
            platier2new.Account_Planning_ge_og__c=accPlan.id;
            insertPLATier2.add(platier2new);
            } 
           
           // insert insertPLATier2;
            Database.SaveResult[] srList = Database.insert(insertPLATier2, false);
            
            // Iterate through each returned result
            for (Database.SaveResult sr : srList) {
                    if (sr.isSuccess()) {
                        // Operation was successful, so get the ID of the record that was processed
                        System.debug('Successfully inserted account. Account ID: ' + sr.getId());
                        //listtier2.add(sr.id);
                    }
                    else {
                        // Operation failed, so get all errors                
                        for(Database.Error err : sr.getErrors()) {
                            System.debug('The following error has occurred.');                    
                            System.debug(err.getStatusCode() + ': ' + err.getMessage());
                            System.debug('Account fields that affected this error: ' + err.getFields());
                        }
                    }
                }

}

}

}