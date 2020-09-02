/*
Class Name     		   : OG_O_Create_RiskChecklistCategory
Used Where ?           : "Create Risk Checklist" when process builder 'Update Deal Path On Opportunity To Deal Desk'  is executed
Purpose/Overview       : Used for creating Risk Checklists record when Deal path is set to Deal Desk
Scrum Team             : OPPTY MGMT
Requirement Number     : R-*****
Author                 : Gourav Anand
Created Date           : 
Test Class Name        : CreateDealDesk_GE_OG_Test
Code Coverage          : 90
*/


global class OG_O_Create_RiskChecklistCategory
{
    // Method to create Deal desk record
    @InvocableMethod(label='Create Risk Checklist Category' description='Create a new Risk Checklist, and will return success or failure message.')
    public static list<String> createRiskChecklistCategory(list<id> opportunityId)
    {
        System.debug('----------------->Calling createRiskChecklistCategory method from SKuid and OpptyID='+opportunityId[0]);
        List<String> successResult = new List<String>();
        successResult.add(CreateRiskChecklistLogic(opportunityId[0]));
        return successResult;
        
    }
    
    
    // This method is used only for testing from Custom Button
    webservice static string createRiskChecklistCategory(String opportunityId)
    {
        System.debug('----------------->Calling createRiskChecklistCategory method from Custom Button and OpptyID='+opportunityId); 
        return createRiskChecklistLogic(opportunityId);
        
    }
    
    public static String createRiskChecklistLogic(id opportunityId){
        String RccCreated;
        System.debug('------------Entering CreateRiskChecklistLogic and OppId='+opportunityId);
        Opportunity opp = [select Id,StageName,pipeline_amount_ge_og__c from Opportunity where id=: opportunityId];
        if(opp.StageName == 'Cancelled')
            return('Opportunity is Cancelled, Deal Desk cannot be created');
        
       //fetching already created Risk Checklist which is active for the Oppty
        List<Risk_Checklist_Category_ge_og__c> activeRiskChecklist = [select id,RCC_Opportunity_ge_og__r.stageName, status_ge_og__c,rcl_category_ge_og__c,Is_Active_ge_og__c from Risk_Checklist_Category_ge_og__c where 
                                                        Is_Active_ge_og__c = true and RCC_Opportunity_ge_og__c =: opportunityId];
        System.debug('-----------------------------activeRiskChecklist='+activeRiskChecklist);
        Integer count = [Select count()  from Risk_Checklist_Category_ge_og__c where 
                                                        Is_Active_ge_og__c = true and RCC_Opportunity_ge_og__c =: opportunityId ]; 
        //fetching already created Deal Desk which is active for the Oppty
        list<Deal_Desk_ge_og__c> activeDealDeskList = [select id,deal_desk_opportunity_id_ge_og__r.stageName, status_ge_og__c,active_deal_desk_ge_og__c from Deal_Desk_ge_og__c where 
                                                        active_deal_desk_ge_og__c = true and deal_desk_opportunity_id_ge_og__c =: opportunityId];
        if(activeDealDeskList.size()==1){
           System.debug('activeDealDeskList size is------------------------------->'+activeDealDeskList.size()); 
           Deal_Desk_ge_og__c dealDesk = activeDealDeskList[0];
        }
        if(activeRiskChecklist.size()>0){
            return 'This Opportunity has one or more active Risk Checklists';
        }else if (activeRiskChecklist.size()==0){
            RiskChecklistCategoryHandler_GE_OG rccHandler = new RiskChecklistCategoryHandler_GE_OG();
            // Insert a new RCC recordset
           System.debug('------------------->Going to call createNewRiskChecklistCategory as no active RCCs & OpptyID:'+opportunityId);
                 rccHandler.createNewRiskChecklistCategory(opportunityId);
        }
        
    
  		return 'Risk inserted successfully.'   ;    
       
	}
 
       
}