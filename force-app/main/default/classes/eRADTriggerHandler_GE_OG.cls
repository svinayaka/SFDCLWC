public class eRADTriggerHandler_GE_OG {
    
    public static void calculateProductUnits(List<eRAD__c> erRec){
        Set<ID> oppID = new Set<ID>();
        List<eRAD__c> erID = new List<eRAD__c>();
        List<Product_Detail__c> prd = new List<Product_Detail__c>();
        Product_Detail__c prds;
        Map<Id,Id> opptyeradmap = new Map<Id,ID>();
        for(eRAD__c er : erRec){
            oppID.add(er.Opportunity__c);
            erID.add(er);
            opptyeradmap.put(er.Opportunity__c,er.ID);
        }
        if(oppID.size()>0){
            AggregateResult[] ag = [select opportunityid,of_Units_Text__c,uom_ge_og__c,sum(Amount_USD__c) Amount from OpportunityLineItem where 
                                    OpportunityID in :oppID and of_Units_Text__c!=null and uom_ge_og__c='Train' group by of_Units_Text__c,uom_ge_og__c,opportunityid];
            for(AggregateResult a : ag){
                prds = new Product_Detail__c();
                prds.Num_Of_Units__c = (String)a.get('of_Units_Text__c');
                prds.Amount_USD__c = (Decimal)a.get('Amount');
                prds.Unit__c = (String)a.get('uom_ge_og__c');
                prds.eRAD__c = opptyeradmap.get((Id)a.get('opportunityid'));
                system.debug('Values: '+prds.eRAD__c);
                prd.add(prds);
                system.debug('Product details: '+prd);
            }
            insert prd;
        }
    }
}