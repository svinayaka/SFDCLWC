/*
Class/Trigger Name     : PLATier2TriggerHandler_GE_OG
Used Where ?           : ProductLineAssessmentTier2Trigger_GE_OG 
Purpose/Overview       : Add PLA Tier 3 when PLA Tier 2 record is created
Scrum Team             : Transformation - OPPTY MGMT
Requirement Number     : R-29179
Author                 : Sonali Rathore
Created Date           : 10/MAR/2018
Test Class Name        : 
Code Coverage          :                   
*/
public without sharing class PLATier2TriggerHandler_GE_OG {

 public void plaTier2UpdateFunctionality(List<Product_Line_Assessment_Tier_2_ge_og__c> listPLATier2)
    {
    Product_Line_Assessment_Tiers__mdt[] PLAtier2_3 = [SELECT DeveloperName,MasterLabel,Tier_2_ge_og__c, Tier_3_ge_og__c FROM Product_Line_Assessment_Tiers__mdt where Tier_3_ge_og__c !='']; 
    
    List<Product_Line_Assessment_Tier_3_ge_og__c> insertPLATier3= new List<Product_Line_Assessment_Tier_3_ge_og__c>();
        
        for (Product_Line_Assessment_Tier_2_ge_og__c listInsertedTier2: listPLATier2) {
        
            for (Product_Line_Assessment_Tiers__mdt csPLAtier2_3 : PLAtier2_3) {
            
                if(csPLAtier2_3.Tier_2_ge_og__c ==listInsertedTier2.Tier_2_ge_og__c){
                System.debug('inside PLATier2TriggerHandler_GE_OG ');
                Product_Line_Assessment_Tier_3_ge_og__c platier3new = new Product_Line_Assessment_Tier_3_ge_og__c();
                platier3new.Tier_2_ge_og__c=listInsertedTier2.Tier_2_ge_og__c;
                platier3new.Tier_3_ge_og__c=csPLAtier2_3.Tier_3_ge_og__c;
                platier3new.Product_Line_Assessment_Tier_2_ge_og__c=listInsertedTier2.id;
                insertPLATier3.add(platier3new);
                } 
            }
           
            Database.SaveResult[] srList = Database.insert(insertPLATier3, false);
            
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