/*
Class/Trigger Name     : OpportunityMultiTier_GE_OG
Used Where ?           : OpportunityTrigger_GE_OG
Purpose/Overview       : Helper Class for Trigger on Opportunity
Scrum Team             : Transformation - OPPTY MGMT
Requirement Number     : R-26476
Author                 : Rupal Seth
Created Date           : 18/JAN/2018
Test Class Name        : OpportunityMultiTier_GE_OG_Test
Code Coverage          : 97%
*/

public class OpportunityMultiTier_GE_OG {
    
    public void updateMultiTier(List<Opportunity> lstOpp, Map<ID,Opportunity> oldOppMap){
      //Added By Harsha: 
        try
        {
            system.debug('INSIDE updateMultiTier');
            Set<ID> opptyids = new Set<Id>();
            
            List<Opportunity> finallist = new List<Opportunity>();
            for(Opportunity objOpp : lstOpp){
                system.debug('R*S Inside oppty for loop lstOpp' +lstOpp);
                system.debug('R*S objOpp.tier_3_ge_og__c'+objOpp.tier_3_ge_og__c);
                system.debug('R*S oldOppMap.get(objOpp.ID).tier_3_ge_og__c'+oldOppMap.get(objOpp.ID).tier_3_ge_og__c);
                system.debug('R*S objopp.HasOpportunityLineItem'+objopp.HasOpportunityLineItem);
                //Logic to check if Tier 3 is chaged and Oppty has produ line item in it
                if(objOpp.tier_3_ge_og__c != oldOppMap.get(objOpp.ID).tier_3_ge_og__c /*&& objopp.HasOpportunityLineItem*/){
                    system.debug('Inside Logic to check if Tier 3 is chaged and Oppty has produ line item in it');
                    opptyids.add(objOpp.Id);
                    
                }
            }
            
            system.debug('INSIDE opptyids'+opptyids);
            //Query oppty line item
            List<Opportunitylineitem> opptyprod = new List<Opportunitylineitem>();
            Set<Id> opptytoupateALLids = new Set<Id>();
            Set<Id> opptytoupateONids = new Set<Id>();
            Set<Id> opptytoupateOFFids = new Set<Id>();
            system.debug('opptyids'+opptyids);
            system.debug('opptyids.size()'+opptyids.size());
            if(opptyids!=null && opptyids.size() > 0){
                system.debug('Inside oppty id null check');
                opptyprod = [Select Id,GE_PTier3_PL__c,GE_HQ_Ref_Opp_Business_Tier3__c,Opportunityid from Opportunitylineitem where Opportunity.Id in : opptyids ];
            }
            //iterate the line item to compare the Tier 3
            for(Opportunitylineitem oli : opptyprod){
                system.debug('oli inside for loop' +oli);
                opptytoupateALLids.add(oli.Opportunityid);
                system.debug('oli.GE_PTier3_PL__c'+oli.GE_PTier3_PL__c);
                system.debug('oli.GE_HQ_Ref_Opp_Business_Tier3__c'+oli.GE_HQ_Ref_Opp_Business_Tier3__c);
                if(oli.GE_PTier3_PL__c != oli.GE_HQ_Ref_Opp_Business_Tier3__c){
                    opptytoupateONids.add(oli.Opportunityid);
                    //logic to
                    
                } 
                
            }
            //logic to update flag as FALSE
            opptytoupateALLids.removeAll(opptytoupateONids);
            system.debug('opptytoupateALLids'+opptytoupateALLids);
            opptytoupateOFFids.addAll(opptytoupateALLids);
            system.debug('INSIDE opptytoupateids'+opptytoupateONids);
            
            /*  Commented by Harsha
*   
List<Opportunity> updateoppON = [Select Id,MultiTier3_ge_og__c from Opportunity where id in : opptytoupateONids];
List<Opportunity> updateoppOFF = [Select Id,MultiTier3_ge_og__c from Opportunity where id in : opptytoupateOFFids];

for(Opportunity ops : updateoppON){
system.debug('Inside updateoppON loop');
ops.MultiTier3_ge_og__c = true;
finallist.add(ops);
system.debug('finallist after adding updateoppON opps to list'+finallist);
}
for(Opportunity ops : updateoppOFF){
system.debug('Inside updateoppOFF loop');
ops.MultiTier3_ge_og__c= FALSE;
finallist.add(ops);
system.debug('finallist after adding updateoppOFF opps to list'+finallist);
}

*
*/
            
            //*** Added by Harsha ***
            
            Opportunity oppoff = new opportunity();
            for(Id opId : opptytoupateONids)
            {
                opportunity oppOn = new Opportunity();
                oppOn.Id = opId;
                oppOn.MultiTier3_ge_og__c = true;
                finallist.add(oppOn);		
            }
            
            for(Id opId : opptytoupateOFFids)
            {
                opportunity oppof = new Opportunity();
                oppof.Id = opId;
                oppof.MultiTier3_ge_og__c = false;
                finallist.add(oppof);		
            }
            if(!finallist.isEmpty()){
                system.debug('Inside finallist not empty loop');
                Database.update(finallist,false);
            }
        }
        catch(Exception e){
            /* *********  Added by Harsha To get the details of occured Exception ********* */
            
            System.debug('Exception Occured in class OpportunityMultiTier_GE_OG and the Message Says : '+e.getMessage()); 
            System.debug('The cause Of the Exception Is : '+e.getCause());
            System.debug('The Exception occured at line number : '+e.getLineNumber());
            System.debug('The Exception TypeName Is : '+e.getTypeName());
            
            /****  ****  **** **** **** **** **** **** **** ****/
        }
        //system.debug('INSIDE final list'+finallist);
        //update finallist;       
         
    }
    
}