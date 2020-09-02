/*
Class/Trigger Name     : CQAChecklistController_GE_OG 
Used Where ?           : OpportunityTriggerHandler_GE_OG
Purpose/Overview       : Creating CQA checklist(Fulfillment checklist) when Oppty is in Qualifying stage and product is added and Install countru is added.
Scrum Team             : Transformation - Deal MGMT
Requirement Number     : R-23478
Author                 : Nitish Pandey
Created Date           : 16/SEP/2015
Test Class Name        : CQAChecklistController_GE_OG_Test
Code Coverage          : 97%
*/


public class CQAChecklistController_GE_OG {
    
    // Generating FF checklist on Updation of Opportunity
    public void generateCQAChecklist(List<Opportunity> newOppList,Map<Id,Opportunity> oldOppMap,List <Checklist_Category_ge_og__c> checklistCategoryList){
        
        //Initializing Variable
        List<Fulfillment_Checklist_Category_ge_og__c> createCQAChecklist = new List<Fulfillment_Checklist_Category_ge_og__c>();
        Map<String,List<Checklist_ge_og__c>> categoryChecklistMap = new Map<String,List<Checklist_ge_og__c>>();
        Set<String> categorySet = new Set<String>();
        Set<Opportunity> oppFFChecklistSet = new Set<Opportunity>();
        
        for(opportunity opp : newOppList){
            
            //Checks if opportunity is Express; then Need Comops Support must me true and Stage must be Qualifying
            //If Opportunity is Deal Desk, then Meet Express Criteria must be 'No' and Stage must be Bid In Development
            /*
            if(!opp.fulfillment_checklist_generated_ge_og__c && ((opp.Is_express_ge_og__c == 'Yes' && opp.StageName =='Qualifying' && opp.need_comm_ops_support_ge_og__c && 
                opp.need_comm_ops_support_ge_og__c != oldOppMap.get(opp.id).need_comm_ops_support_ge_og__c) || 
                (opp.Is_express_ge_og__c == 'No' && opp.StageName =='Bid In Development' ))) 
            */
            
           
            if(!opp.fulfillment_checklist_generated_ge_og__c && opp.OpportunityLineItems.size()>0 && (opp.deal_path_ge_og__c =='Deal Desk' || opp.Is_express_ge_og__c=='No') && opp.IsClosed == False)
            //if(!opp.fulfillment_checklist_generated_ge_og__c && opp.need_comm_ops_support_ge_og__c && opp.OpportunityLineItems.size()>0)
                {
                
                System.debug('\n\n\n\n\n Entered in for Loop \n\n\n\n\n');
                
                //Initializing variable
                //'All' will be added as default,and later on add values from oppty and oppty Product
                Set<String> tier2Value = new Set<String>{'All','ALL'};
                Set<String> tier3Value = new Set<String>{'All','ALL'};
                Set<String> tier4Value = new Set<String>{'All','ALL'};
                //Set<String> siteScopeValue = new Set<String>{'All','ALL'};
                Set<String> opptyDriverValue = new Set<String>{'All','ALL'};
                //Set<String> prodServiceValue = new Set<String>{'All','ALL'};
                
                //Adding Values from Oppty
                tier2Value.add(opp.tier_2_ge_og__c==null?'':opp.tier_2_ge_og__c);
                tier3Value.add(opp.tier_3_ge_og__c==null?'':opp.tier_3_ge_og__c);
                tier4Value.add(opp.tier_4_ge_og__c==null?'':opp.tier_4_ge_og__c);
                
                //Adding values from Oppty Product
                if(opp.OpportunityLineItems.size()>0){
                    for(opportunityLineItem oppItem : opp.OpportunityLineItems){
                        //siteScopeValue.add(oppItem.GE_PW_TML_sitscpe__c==null?'':oppItem.GE_PW_TML_sitscpe__c);
                        opptyDriverValue.add(oppItem.GE_ES_Opportunity_Driver__c==null?'':oppItem.GE_ES_Opportunity_Driver__c);
                        //prodServiceValue.add(oppItem.GE_ES_Product_Services__c==null?'':oppItem.GE_ES_Product_Services__c);
                        
                        tier2Value.add(oppItem.GE_PTier2_PL__c==null?'':oppItem.GE_PTier2_PL__c);
                        tier3Value.add(oppItem.GE_PTier3_PL__c==null?'':oppItem.GE_PTier3_PL__c);
                        tier4Value.add(oppItem.GE_PTier4_PL__c==null?'':oppItem.GE_PTier4_PL__c);
                        
                    }
                    
                }
                
                // Check for each active Checklist Category is values matches with Oppty and Oppty Product values
                //If matches, categorize them with Category and List of Checklist by using Map
                for(Checklist_Category_ge_og__c checklistCategory : checklistCategoryList){
                
                    if(tier2Value.contains(checklistCategory.checklist_category_tier_2_ge_og__c) && 
                        tier3Value.contains(checklistCategory.checklist_category_tier_3_ge_og__c) && 
                        tier4Value.contains(checklistCategory.checklist_category_tier_4_ge_og__c) &&
                        opptyDriverValue.contains(checklistCategory.oppty_driver_ge_og__c)
                        )
                    {
                    
                        System.debug('\n\n\n\n\n Chechlist category : ' +checklistCategory+' \n\n\n\n\n');
                        System.debug('\n\n Checklist :: '+checklistCategory.Checklists__r);
                        System.debug('\n\n Checklist :: '+checklistCategory.Checklists__r.size());
                        
                        //categorySet.add(checklistCategory.category_ge_og__c);
                        /**********Commented By Nitish************/
                        /*
                        if(!categoryChecklistMap.containsKey(checklistCategory.category_ge_og__c)){
                            System.debug('\n\n Checklist IF BLOCK:: ');
                            categoryChecklistMap.put(checklis0tCategory.category_ge_og__c,checklistCategory.Checklists__r);
                        }
                        else{
                            System.debug('\n\n Checklist ELSE BLOCK:: ');
                            categoryChecklistMap.get(checklistCategory.category_ge_og__c).addAll(checklistCategory.Checklists__r);
                        }
                        */
                        //if(!categoryChecklistMap.containsKey(checklistCategory.category_ge_og__c)){
                        if(!categoryChecklistMap.containsKey(opp.id)){
                            System.debug('\n\n Checklist IF BLOCK:: ');
                            categoryChecklistMap.put(opp.id,checklistCategory.Checklists__r);
                        }
                        else{
                            System.debug('\n\n Checklist ELSE BLOCK:: ');
                            categoryChecklistMap.get(opp.id).addAll(checklistCategory.Checklists__r);
                        }
                        
                        oppFFChecklistSet.add(opp);
                    }
                    
                }
                //Adding Fulfillment Checklist Category
                /**********Commented By Nitish***********/
                /*
                for(String str : categorySet){
                    createCQAChecklist.add(new Fulfillment_Checklist_Category_ge_og__c(ff_opportunity_id_ge_og__c = opp.Id,
                                                 ff_category_ge_og__c = str));
                }
                */

            }
            
            
            
        }
        //Adding Fulfillment Checklist Category
        /**********Added By Nitish***********/
        for(Opportunity op : oppFFChecklistSet){
            createCQAChecklist.add(new Fulfillment_Checklist_Category_ge_og__c(ff_opportunity_id_ge_og__c = op.Id,
                                         ff_category_ge_og__c = ''));
        }
        
         System.debug('\n\n Category Checklist Map:: '+categoryChecklistMap.size()+' \n\n ---- Records ---- '+categoryChecklistMap);
         System.debug('\n\n CQA Checklist:: '+createCQAChecklist.size()+' \n\n ---- Records ---- '+createCQAChecklist);
        //Inserting Fulfillment Checklist Category
        if(!createCQAChecklist.isEmpty())
            insert createCQAChecklist;
        
        List<Fulfillment_Checklist_Category_ge_og__c> FFChecklist = [select id,ff_opportunity_id_ge_og__c from Fulfillment_Checklist_Category_ge_og__c where id in : createCQAChecklist];
        //Creating Fulfillment Checklist Deviation
        //createCQAChecklistDeviation(createCQAChecklist,categoryChecklistMap);
        createCQAChecklistDeviation(FFChecklist,categoryChecklistMap);
        
    }
    
    //Methid for Adding Checklist Deviation
    public void createCQAChecklistDeviation(List<Fulfillment_Checklist_Category_ge_og__c> listCQAChecklistCategory,Map<String,List<Checklist_ge_og__c>> categoryChecklistMap)
    {
        List<Fulfillment_Checklist_Deviation_ge_og__c> lstCQAChecklistDeviation = new List<Fulfillment_Checklist_Deviation_ge_og__c>();
        
        for(Fulfillment_Checklist_Category_ge_og__c objCQAChecklistCategory:listCQAChecklistCategory)
        {
            // Use 'for inside for loop' as every Risk checklist category item records must be associated
            // to multiple Risk Checklist through Risk Checklist deviation
            system.debug('hhhhhhhhhhhhhhhhhhhhh     '+objCQAChecklistCategory.ff_opportunity_id_ge_og__c);
            system.debug('ffffffffffffffffffffffff      '+ categoryChecklistMap.get(objCQAChecklistCategory.ff_opportunity_id_ge_og__c));
            /****Commented By Nitish****/
            //for(Checklist_ge_og__c checklistId:categoryChecklistMap.get(objCQAChecklistCategory.ff_category_ge_og__c))
            for(Checklist_ge_og__c checklistId:categoryChecklistMap.get(objCQAChecklistCategory.ff_opportunity_id_ge_og__c))
            {
                // The number of Script statements is reduced to one statement for each 'for inside for loop'
                // which is the only governor limit that needs to be taken care in this case
                lstCQAChecklistDeviation.add(new Fulfillment_Checklist_Deviation_ge_og__c
                                             (ff_checklist_category_id_ge_og__c = objCQAChecklistCategory.Id,
                                             ff_checklist_ge_og__c  = checklistId.question_ge_og__c,
                                             ff_checklist_reference_ge_og__c = checklistId.id));
            }
        }
        
        // Insert Risk checklist deviation record
        if(!lstCQAChecklistDeviation.isEmpty())
            insert lstCQAChecklistDeviation;
    }

}