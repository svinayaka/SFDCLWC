/*
Class/Trigger Name     : OpportunityProductTriggerHandler_GE_OG
Used Where ?           : OpportunityProductTrigger_GE_OG
Purpose/Overview       : Creating CQA checklist(Fulfillment checklist) when Oppty is in Qualifying stage and product is added and Install countru is added.
Scrum Team             : Transformation - OPPTY MGMT
Requirement Number     : R-23478
Author                 : Nitish Pandey
Created Date           : 09/OCT/2015
Test Class Name        : CQAChecklistController_GE_OG_Test
Code Coverage          : 
 :
*/
public without sharing class OpportunityProductTriggerHandler_GE_OG
{
    
    //Before Insert Funtionality
    public void beforeInsertFunctionality(List<OpportunityLineItem> opptyProductList){
        
        // created for validate Opportunity Product Record
        // call logic to validate Opportunity Product
        ValidateOpportunityLineItem_GE_OG objValidateOLI = new ValidateOpportunityLineItem_GE_OG();
        objValidateOLI.validateOpportunityLineItemTier(opptyProductList);

    }
    
    //After Insert of Opportunity Product
    public void afterInsertFuctionality(List<OpportunityLineItem> opptyProductList){
        
        //Initializing Variable
        Set<id> opptyid = new Set<ID>();
        Map<id,Set<Id>> opptycCQADeviationMap = new Map <id,Set<Id>>();
        
        //adding oppty in set to remove duplicacy
        for(OpportunityLineItem oli : opptyProductList){
            opptyid.add(oli.opportunityId);
        }
        
        //Fetching opportunity with its related product by Inner Query
        //Start: Commented below for Opportunity Cleanup to remove reference of GE_OG_Has_Express_Evaluated__c
        /*List<Opportunity> opptywithProductList = [select id, fulfillment_checklist_generated_ge_og__c, StageName, Is_express_ge_og__c, GE_OG_Has_Express_Evaluated__c, need_comm_ops_support_ge_og__c,tier_2_ge_og__c,
                                                tier_4_ge_og__c, tier_3_ge_og__c,
                                                (Select id, ff_category_ge_og__c,ff_opportunity_id_ge_og__c from Fulfillment_Checklist_Categories__r),
                                                (select id, GE_ES_Product_Services__c, GE_ES_Opportunity_Driver__c , GE_PW_TML_sitscpe__c,
                                                GE_PTier2_PL__c, GE_PTier3_PL__c, GE_PTier4_PL__c from OpportunityLineItems)
                                                from opportunity where id in: opptyid];*/
       //End: Commented below for Opportunity Cleanup to remove reference of GE_OG_Has_Express_Evaluated__c
       //Start: Added below for Opportunity Cleanup to remove reference of GE_OG_Has_Express_Evaluated__c
              List<Opportunity> opptywithProductList = [select id, fulfillment_checklist_generated_ge_og__c,StageName, Is_express_ge_og__c, need_comm_ops_support_ge_og__c,tier_2_ge_og__c,
                                                tier_4_ge_og__c, tier_3_ge_og__c,
                                                (Select id, ff_category_ge_og__c,ff_opportunity_id_ge_og__c from Fulfillment_Checklist_Categories__r),
                                                (select id, GE_ES_Product_Services__c, GE_ES_Opportunity_Driver__c , //GE_PW_TML_sitscpe__c,
                                                GE_PTier2_PL__c, GE_PTier3_PL__c, GE_PTier4_PL__c from OpportunityLineItems)
                                                from opportunity where id in: opptyid];
       //End: Added below for Opportunity Cleanup to remove reference of GE_OG_Has_Express_Evaluated__c
        // getting Record Type Id                                       
        Id riskChecklistRecordTypeId = Util_GE_OG.getRecordTypeDetails('Checklist_Category_ge_og__c','Fulfillment Checklist').getRecordTypeId();
          
        //fetching all Active Risk Checklist Category with Deviation
        List <Checklist_Category_ge_og__c> checklistCategoryList = [Select id, active_ge_og__c, RecordTypeId, checklist_category_tier_2_ge_og__c, category_ge_og__c, 
                                                                    checklist_category_tier_3_ge_og__c,sitescope_ge_og__c,
                                                                    checklist_category_tier_4_ge_og__c, product_service_ge_og__c, oppty_driver_ge_og__c, 
                                                                    (select Id,checklist_category_id_ge_og__c,question_ge_og__c
                                                                    from Checklists__r where  active_checklist_ge_og__c = true) 
                                                                    from Checklist_Category_ge_og__c where RecordTypeId =: riskChecklistRecordTypeId 
                                                                    and active_ge_og__c = True];
        
        // Fetching all Fullfillment Checklist Deviation under opportunties.
        List<Fulfillment_Checklist_Deviation_ge_og__c> cqaDeviationList = [select id, ff_checklist_reference_ge_og__c, ff_checklist_category_id_ge_og__c,
                                                                            ff_checklist_category_id_ge_og__r.ff_opportunity_id_ge_og__c, 
                                                                            ff_checklist_category_id_ge_og__r.ff_category_ge_og__c from 
                                                                            Fulfillment_Checklist_Deviation_ge_og__c where 
                                                                            ff_checklist_category_id_ge_og__r.ff_opportunity_id_ge_og__c in : opptyid];
        
        //For loop for separating FF deviation with each category by using Map
        
      
        for(Fulfillment_Checklist_Deviation_ge_og__c fcd : cqaDeviationList){
        
            if(!opptycCQADeviationMap.containsKey(fcd.ff_checklist_category_id_ge_og__r.ff_opportunity_id_ge_og__c)){
       
            
                Set<Id> IdSet = new Set<Id>();
                IdSet.add(fcd.ff_checklist_reference_ge_og__c);
                opptycCQADeviationMap.put(fcd.ff_checklist_category_id_ge_og__r.ff_opportunity_id_ge_og__c,IdSet);
                
            }
            else{
                opptycCQADeviationMap.get(fcd.ff_checklist_category_id_ge_og__r.ff_opportunity_id_ge_og__c).add(fcd.ff_checklist_reference_ge_og__c);
            }
                
        }
        
        //Calling method from helper Class
        OpptunityProductcqaChecklistController opcc = new OpptunityProductcqaChecklistController();
        opcc.generateCQAChecklist(opptywithProductList,checklistCategoryList,opptycCQADeviationMap);
        
    }
    
    public static void afterDeleteFunctionality(List<OpportunityLineItem> opptyProductRec){
         Set<Id> OliIdSet = new Set<Id>() ;
         for(OpportunityLineItem oli : opptyProductRec){
              if(oli.OpptyMaxFlag__c)
              OliIdSet.add(oli.Id); 
         }
                  
          if(OliIdSet.size() > 0){
              GE_OG_OfflineOpportunityInsertHelper.deleteOpptyMaxProductLine(OliIdSet) ;
          }    
    }//End of afterDeleteFunctionality method
    
    //After Deletion of Any Opportuntiy Product
    Public void beforeDeleteFuctionality(List<OpportunityLineItem> opptyProductList){
        
        //Initializing Variable
        Set<id> opptyid = new Set<ID>();
        Map<id,Set<Fulfillment_Checklist_Deviation_ge_og__c>> opptycCQADeviationMap = new Map <id,Set<Fulfillment_Checklist_Deviation_ge_og__c>>();
        
        //adding oppty in set to remove duplicacy
        for(OpportunityLineItem oli : opptyProductList){
            opptyid.add(oli.opportunityId);
        }
        
        //Start: Commented below for Opportunity Cleanup to remove reference of GE_OG_Has_Express_Evaluated__c
        /*List<Opportunity> opptywithProductList = [select id, fulfillment_checklist_generated_ge_og__c, StageName,Is_express_ge_og__c, GE_OG_Has_Express_Evaluated__c,   need_comm_ops_support_ge_og__c,tier_2_ge_og__c,
                                                tier_4_ge_og__c, tier_3_ge_og__c,
                                                (Select id, ff_category_ge_og__c from Fulfillment_Checklist_Categories__r),
                                                (select id, GE_ES_Product_Services__c, GE_ES_Opportunity_Driver__c , GE_PW_TML_sitscpe__c, 
                                                GE_PTier2_PL__c, GE_PTier3_PL__c, GE_PTier4_PL__c from OpportunityLineItems)
                                                from opportunity where id in: opptyid];*/
        //End: Commented below for Opportunity Cleanup to remove reference of GE_OG_Has_Express_Evaluated__c
        //Start: Added below for Opportunity Cleanup to remove reference of GE_OG_Has_Express_Evaluated__c
        List<Opportunity> opptywithProductList = [select id, fulfillment_checklist_generated_ge_og__c,StageName,Is_express_ge_og__c,   need_comm_ops_support_ge_og__c,tier_2_ge_og__c,
                                                tier_4_ge_og__c, tier_3_ge_og__c,
                                                (Select id, ff_category_ge_og__c from Fulfillment_Checklist_Categories__r),
                                                (select id, GE_ES_Product_Services__c, GE_ES_Opportunity_Driver__c , //GE_PW_TML_sitscpe__c, 
                                                GE_PTier2_PL__c, GE_PTier3_PL__c, GE_PTier4_PL__c from OpportunityLineItems)
                                                from opportunity where id in: opptyid];
        
        //End: Added below for Opportunity Cleanup to remove reference of GE_OG_Has_Express_Evaluated__c
        // getting Record Type Id                                          
        Id fulfillmentChecklistRecordTypeId = Util_GE_OG.getRecordTypeDetails('Checklist_Category_ge_og__c','Fulfillment Checklist').getRecordTypeId();
          
        //fetching all Active Risk Checklist Category with Deviation
        List <Checklist_Category_ge_og__c> checklistCategoryList = [Select id, active_ge_og__c, RecordTypeId, checklist_category_tier_2_ge_og__c, category_ge_og__c, 
                                                                    checklist_category_tier_3_ge_og__c,sitescope_ge_og__c,
                                                                    checklist_category_tier_4_ge_og__c, product_service_ge_og__c, oppty_driver_ge_og__c, 
                                                                    (select Id,checklist_category_id_ge_og__c,question_ge_og__c
                                                                    from Checklists__r where  active_checklist_ge_og__c = true) 
                                                                    from Checklist_Category_ge_og__c where RecordTypeId =: fulfillmentChecklistRecordTypeId 
                                                                    and active_ge_og__c = True];
        
        // Fetching all Fullfillment Checklist Deviation under opportunties.
        List<Fulfillment_Checklist_Deviation_ge_og__c> cqaDeviationList = [select id, ff_checklist_reference_ge_og__c, ff_checklist_category_id_ge_og__c,
                                                                            ff_checklist_category_id_ge_og__r.ff_opportunity_id_ge_og__c, 
                                                                            ff_checklist_category_id_ge_og__r.ff_category_ge_og__c from 
                                                                            Fulfillment_Checklist_Deviation_ge_og__c where 
                                                                            ff_checklist_category_id_ge_og__r.ff_opportunity_id_ge_og__c in : opptyid];
        
        //For loop for separating FF deviation with each category by using Map
        for(Fulfillment_Checklist_Deviation_ge_og__c fcd : cqaDeviationList){
         
            if(!opptycCQADeviationMap.containsKey(fcd.ff_checklist_category_id_ge_og__r.ff_opportunity_id_ge_og__c)){
            
                Set<Fulfillment_Checklist_Deviation_ge_og__c> IdSet = new Set<Fulfillment_Checklist_Deviation_ge_og__c>();
                IdSet.add(fcd);
                opptycCQADeviationMap.put(fcd.ff_checklist_category_id_ge_og__r.ff_opportunity_id_ge_og__c,IdSet);
                
            }
            else{
            
                opptycCQADeviationMap.get(fcd.ff_checklist_category_id_ge_og__r.ff_opportunity_id_ge_og__c).add(fcd);
            }
                
        }
        //Calling method from helper Class
        OpptunityProductcqaChecklistController opcc = new OpptunityProductcqaChecklistController();
        
        opcc.checkCQAChecklist(opptywithProductList,checklistCategoryList,opptycCQADeviationMap); 
    }
    
}