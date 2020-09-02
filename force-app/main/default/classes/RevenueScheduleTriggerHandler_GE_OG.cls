/***********************************************************************************************************************
 * Class Name:         RevenueScheduleTriggerHandler_GE_OG
 * Purpose:            Tied to R-26544 : Used to update Tier values on Revenue Schedule from realted Product
 * Author:             Sonali Rathore
 * Date:               01/16/2018
 * Test Class:         RevenueScheduleTriggerHandler_GE_OG_Test
 * *************************************************************************************************************************/
 
 public without sharing class RevenueScheduleTriggerHandler_GE_OG
{
    public void tierUpdateFunctionality(List<Revenue_Schedule_ge_og__c> revenueschedule)
    {
        Set<Id> oliIds = new Set<Id>();
        Set<Id> ProductId= new set<Id>();
        List<Revenue_Schedule_ge_og__c> ListRevSec = new List<Revenue_Schedule_ge_og__c>();
        List<Revenue_Schedule_ge_og__c> updateList = new List<Revenue_Schedule_ge_og__c>();
        
        For(Revenue_Schedule_ge_og__c rs:revenueschedule){
            if(String.isBlank(rs.OpportunityLineItemTier2_ge_og__c) || String.isNotBlank(rs.OpportunityLineItem_Tier3_ge_og__c) || String.isNotBlank(rs.Product_Name_ge_og__c)){
                oliIds.add(rs.OpportunityLineItemID_ge_og__c);
                ListRevSec.add(rs);
            }
        }
        //List<OpportunityLineItem> ListOlis = [Select id,GE_PTier2_PL__c,GE_PTier3_PL__c,opportunity_product_id_ge_og__c,Product2.name from OpportunityLineItem where id in : oliIds];
        //Modified below as a part of R-29360
        List<OpportunityLineItem> ListOlis = [Select id,GE_PTier2_PL__c,GE_PTier3_PL__c,GE_ES_Primary_Quote__c,opportunity_product_id_ge_og__c,Product2.name from OpportunityLineItem where id in : oliIds];
        for(Revenue_Schedule_ge_og__c rsnew:ListRevSec){
            for(OpportunityLineItem oli:ListOlis){
                if(rsnew.OpportunityLineItemID_ge_og__c== oli.opportunity_product_id_ge_og__c){
                    rsnew.OpportunityLineItemTier2_ge_og__c=oli.GE_PTier2_PL__c;
                    rsnew.OpportunityLineItem_Tier3_ge_og__c=oli.GE_PTier3_PL__c;
                    rsnew.Product_Name_ge_og__c=oli.Product2.name;
                    rsnew.Is_OpportunityLineItem_Included_ge_og__c=oli.GE_ES_Primary_Quote__c;
                    system.debug('rsnew.Is_OpportunityLineItem_Included_ge_og__c' +rsnew.Is_OpportunityLineItem_Included_ge_og__c);
                    updateList.add(rsnew);
                }
            }
        }
        
    }
    
    /*
The below method is used to update currency ISO from Opportunity to Revenue Schedule
R-26544
*/
    
    public void updatecurrecnyoncreateorupdate(List<Revenue_Schedule_ge_og__c> revenueschedule){
        system.debug('BEFORE INSERT updatecurrecnyoncreateorupdate');
        List<Id> opptyid = new List<Id>();
        
        for(Revenue_Schedule_ge_og__c rev : revenueschedule){
            opptyid.add(rev.Opportunity__C);
        }
        Map<Id,String> opptycurrencymap = new Map<Id,String>();
        for(Opportunity opp :[Select Id,CurrencyIsoCode from Opportunity where id in :opptyid]){
            opptycurrencymap.put(opp.Id, opp.CurrencyIsoCode);
        }
        system.debug('====Map'+opptycurrencymap);
        
        for(Revenue_Schedule_ge_og__c rev: revenueschedule){
            if(opptycurrencymap != null && opptycurrencymap.size() > 0){
                system.debug('Opportunity Currency==='+opptycurrencymap.get(rev.Opportunity__c));
                rev.CurrencyIsoCode = opptycurrencymap.get(rev.Opportunity__c); 
            }
        }
        
    }
    
}