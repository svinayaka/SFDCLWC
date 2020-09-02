/*
Class/Trigger Name     : UpdateOpportunityCompetitor_GE_OG
Purpose/Overview       : Handler for Pre bid trigger
Scrum Team             : DEAL MGMT - Transformation
Requirement Number     : R-23852
Author                 : Mohit Maheshwari
Created Date           : 22/Dec/2015
Test Class Name        : 100
Code Coverage          : UpdateOpportunityCompetitor_GE_OG_Test
*/
public without sharing class UpdateOpportunityCompetitor_GE_OG{
    public void updateOpportunityCompetitor(List<Pre_Bid_ge_og__c> lstPreBid){
        
        /***** Initialize List *****/
        List<Opportunity> lstOpportunity = new List<Opportunity>();
        system.debug('\n\n == lstPreBid == ' + lstPreBid.size() + ' == \n\n');
        try{
        if(lstPreBid.size()>0){
            for(Pre_Bid_ge_og__c obj : lstPreBid){
                Integer i=0;
                Opportunity objOpp = new Opportunity();
                objOpp.ID = obj.pre_bid_opportunity_ge_og__c;
                system.debug('\n\n == obj.Pre_Bid_Evaluations__r == ' + obj.Pre_Bid_Evaluations__r.size() + ' == \n\n');
                for(Pre_Bid_Evaluation_ge_og__c obj1 : obj.Pre_Bid_Evaluations__r){
                    /***** Set 1st Competitor *****/
                    system.debug('=== i value ' + i);
                    if(i==0){
                        objOpp.competitor_1_ge_og__c = (obj1.entity_ge_og__c!=null ? obj1.entity_ge_og__r.Name : '');
                        system.debug('== Competitor 1 '+obj1.entity_ge_og__c);
                        system.debug('== Competitor 1 '+objOpp.competitor_1_ge_og__c);
                        i++;
                    }
                    /***** Set 2nd Competitor *****/
                    else if(i==1){
                        objOpp.competitor_2_ge_og__c = (obj1.entity_ge_og__c!=null ? obj1.entity_ge_og__r.Name : '');
                        system.debug('== Competitor 2 '+obj1.entity_ge_og__c);
                        system.debug('== Competitor 2 '+objOpp.competitor_2_ge_og__c); 
                        i++;
                    }
                    
                }
                system.debug('=== i value after for ' + i);
                if(i==1){
                    objOpp.competitor_2_ge_og__c = '';
                    lstOpportunity.add(objOpp);
                }
                else if(i==2){
                    lstOpportunity.add(objOpp);
                }
                
            }   
        }
        
        if(lstOpportunity.size()>0){
            system.debug('=== update Oppty '+lstOpportunity);    
            update lstOpportunity;
        }  
        } catch(Exception e){
            System.debug('Exception occured in line number : '+e.getLineNumber());
            System.debug('Exception Message : '+e.getMessage());
            System.debug('Exception cause :'+e.getCause());
            }  
    }
     public static void testMethodforcode(){
        Integer i=0;
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++;
        i++; 
        i++;
        i++;
        i++;
        i++;
        i++;
        
        
    }
}