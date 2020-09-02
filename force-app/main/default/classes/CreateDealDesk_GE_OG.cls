/*
Class/Trigger Name     : CreateDealDesk_GE_OG
Used Where ?           : "New Checklist" button on Opportunity
Purpose/Overview       : Used for creating Deal desk record when "New Checklist" button on Opportunity
                         is clicked
Scrum Team             : Transformation - OPPTY MGMT
Requirement Number     : R-23281
Author                 : Sanath Kumar Dheram
Created Date           : 16/SEP/2015
Test Class Name        : CreateDealDesk_GE_OG_Test
Code Coverage          : 87
*/
global class CreateDealDesk_GE_OG
{
    // Method to create Deal desk record
    @InvocableMethod(label='Create Deal Desk' description='Create a new Deal Desk, and will return success or failure message.')
    public static list<String> createDealDesk(list<id> opportunityId)
    {
        List<String> successResult = new List<String>();
        successResult.add(CreateDealDeskBusinessLogic(opportunityId[0]));
        return successResult;
        
    }
    
    
    // This method is used only for testing from Custom Button
    webservice static string createDealDesk(String opportunityId)
    {
         return CreateDealDeskBusinessLogic(opportunityId);
        
    }
    
    public static string CreateDealDeskBusinessLogic(id opportunityId){
        String dealDeskCreated;
        Opportunity opp = [select Id,StageName,pipeline_amount_ge_og__c from Opportunity where id=: opportunityId];
        if(opp.StageName == 'Cancelled')
            return('Opportunity is Cancelled, Deal Desk cannot be created');
        
        //fetching already created Deal Desk which is active for the Oppty
        list<Deal_Desk_ge_og__c> activeDealDeskList = [select id,deal_desk_opportunity_id_ge_og__r.stageName, status_ge_og__c,active_deal_desk_ge_og__c from Deal_Desk_ge_og__c where 
                                                        active_deal_desk_ge_og__c = true and deal_desk_opportunity_id_ge_og__c =: opportunityId];
        
        
        
        //Checking if Deal Desk already created or not
        if(activeDealDeskList.size()==1){
            Deal_Desk_ge_og__c createdDealDesk = activeDealDeskList[0];
            //If Deal desk is active and status is either of 'Initiated','Submitted','Rejected', give validation error
            if(createdDealDesk.status_ge_og__c != Label.Approved){
                return 'This Opportunity already has an Active Risk checklist';
            }
            else {
                //making current deal desk as Inactive
                createdDealDesk.active_deal_desk_ge_og__c=false;
                update createdDealDesk;
                // Insert a new deal desk record
                return newDealDesk(opportunityId);
                
            }
        }
        else if (activeDealDeskList.size()==0){
            // Insert a new deal desk record
            dealDeskCreated = newDealDesk(opportunityId);
        }
        else{
            return 'More than one Active record exists. Please contact Support Team';
        }
        
        return dealDeskCreated ;
        
    
    }
    
    //Method to create new Deal Desk against an opportunity
    public static string newDealDesk(string opportunityId){
        try{
            //creating a new Deal Desk.
            Deal_Desk_ge_og__c objDealDesk = new Deal_Desk_ge_og__c();
            objDealDesk.deal_desk_opportunity_id_ge_og__c = opportunityId;
            objDealDesk.active_deal_desk_ge_og__c=true;
            insert objDealDesk;
            return 'Deal Desk Inserted Successfully';
        }
        catch(Exception ex){
            system.debug('---Exception--->>>>'+ex);
            return 'Deal Desk Insertion failed';
        }
    }
    
    
    
}