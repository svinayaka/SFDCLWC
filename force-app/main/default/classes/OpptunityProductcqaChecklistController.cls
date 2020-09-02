/*
Class/Trigger Name     : OpptunityProductcqaChecklistController
Used For               : Creating CQA checklist(Fulfillment checklist).
Purpose/Overview       : Creating CQA checklist(Fulfillment checklist) when Oppty is in Qualifying stage and product is added and Install countru is added.
                         Also modify CQA checklist when product is added or removed after creation of CQA checklist.
Scrum Team             : Transformation - Deal MGMT
Test Class             : CQAChecklistController_GE_OG_Test
Requirement Number     : R-23478
Author                 : Nitish Pandey
Created Date           : 17-Sep-2015

*/


public class OpptunityProductcqaChecklistController{

    public void generateCQAChecklist(List<Opportunity> newOppList,List <Checklist_Category_ge_og__c> checklistCategoryList,Map<id,Set<Id>> opptycCQADeviationMap){
            
        List<Fulfillment_Checklist_Category_ge_og__c> createCQAChecklist = new List<Fulfillment_Checklist_Category_ge_og__c>();
        Map<String,List<Checklist_ge_og__c>> categoryChecklistMap = new Map<String,List<Checklist_ge_og__c>>();
        Set<String> categorySet = new Set<String>();
        
        for(opportunity opp : newOppList){
            
            if(opp.fulfillment_checklist_generated_ge_og__c) {
                
                Set<String> tier2Value = new Set<String>{'All','ALL'};
                Set<String> tier3Value = new Set<String>{'All','ALL'};
                Set<String> tier4Value = new Set<String>{'All','ALL'};
               // Set<String> siteScopeValue = new Set<String>{'All','ALL'};
                Set<String> opptyDriverValue = new Set<String>{'All','ALL'};
                //Set<String> prodServiceValue = new Set<String>{'All','ALL'};
                
                tier2Value.add(opp.tier_2_ge_og__c==null?'':opp.tier_2_ge_og__c);
                tier3Value.add(opp.tier_3_ge_og__c==null?'':opp.tier_3_ge_og__c);
                tier4Value.add(opp.tier_4_ge_og__c==null?'':opp.tier_4_ge_og__c);
                
                /*added for Deletion FF */
                /*
                if(opp.OpportunityLineItems.size()==1){
                    list<Fulfillment_Checklist_Category_ge_og__c> deleteFFChecklist= [select id from Fulfillment_Checklist_Category_ge_og__c where id in : opptycCQACategoryMap.get(opp.id)];
                    delete deleteFFChecklist;
                    CQAChecklistController_GE_OG cqac =  new CQAChecklistController_GE_OG();
                    cqac.generateCQAChecklist(newOppList,);
                    
                }
                */
                //if(opp.OpportunityLineItems.size()>0){
                if(opp.OpportunityLineItems.size()>0){
                    for(opportunityLineItem oppItem : opp.OpportunityLineItems){
                        //siteScopeValue.add(oppItem.GE_PW_TML_sitscpe__c);
                        opptyDriverValue.add(oppItem.GE_ES_Opportunity_Driver__c==null?'':oppItem.GE_ES_Opportunity_Driver__c);
                        
                        tier2Value.add(oppItem.GE_PTier2_PL__c==null?'':oppItem.GE_PTier2_PL__c);
                        tier3Value.add(oppItem.GE_PTier3_PL__c==null?'':oppItem.GE_PTier3_PL__c);
                        tier4Value.add(oppItem.GE_PTier4_PL__c==null?'':oppItem.GE_PTier4_PL__c);
                        //prodServiceValue.add(oppItem.GE_ES_Product_Services__c);
                    }
                    
                }
                
                
                
                for(Checklist_Category_ge_og__c checklistCategory : checklistCategoryList){
                    
                    if( tier2Value.contains(checklistCategory.checklist_category_tier_2_ge_og__c) && 
                        tier3Value.contains(checklistCategory.checklist_category_tier_3_ge_og__c) && 
                        tier4Value.contains(checklistCategory.checklist_category_tier_4_ge_og__c) &&
                        opptyDriverValue.contains(checklistCategory.oppty_driver_ge_og__c)
                        )
                    {
                        categorySet.add(checklistCategory.category_ge_og__c);
                        if(!categoryChecklistMap.containsKey(checklistCategory.category_ge_og__c)){
                            categoryChecklistMap.put(checklistCategory.category_ge_og__c,checklistCategory.Checklists__r);
                        }
                        else{
                            categoryChecklistMap.get(checklistCategory.category_ge_og__c).addAll(checklistCategory.Checklists__r);
                        }
                        
                    }
                }
                set<String> ctgSet = new Set<String>();
                for(Fulfillment_Checklist_Category_ge_og__c fcc:opp.Fulfillment_Checklist_Categories__r){
                    ctgSet.add(fcc.ff_category_ge_og__c);
                    createCQAChecklist.add(fcc);
                    
                }
                for(String str : categorySet){
                    if(!ctgSet.contains(str)){
                        createCQAChecklist.add(new Fulfillment_Checklist_Category_ge_og__c(ff_opportunity_id_ge_og__c = opp.Id,
                                                 ff_category_ge_og__c = str));
                    }
                    
                }

            }
            
        }
        
        if(!createCQAChecklist.isEmpty())
            upsert createCQAChecklist;
        
        //Creating Fulfillment Checklist Deviation
        createCQAChecklistDeviation(createCQAChecklist,categoryChecklistMap,opptycCQADeviationMap);
        
    }
    
    
    public void createCQAChecklistDeviation(List<Fulfillment_Checklist_Category_ge_og__c> listCQAChecklistCategory,Map<String,List<Checklist_ge_og__c>> categoryChecklistMap,Map<id,Set<Id>> opptycCQADeviationMap)
    {
        List<Fulfillment_Checklist_Deviation_ge_og__c> lstCQAChecklistDeviation = new List<Fulfillment_Checklist_Deviation_ge_og__c>();
        
        
        for(Fulfillment_Checklist_Category_ge_og__c objCQAChecklistCategory:listCQAChecklistCategory)
        {
            System.debug('********************opptycCQADeviationMap'+opptycCQADeviationMap);
            System.debug('********************objCQAChecklistCategory.ff_opportunity_id_ge_og__c'+objCQAChecklistCategory.ff_opportunity_id_ge_og__c);
            Set<Id> cqaDeviationSet = opptycCQADeviationMap.get(objCQAChecklistCategory.ff_opportunity_id_ge_og__c);
            
            // Use 'for inside for loop' as every Risk checklist category item records must be associated
            // to multiple Risk Checklist through Risk Checklist deviation
            system.debug('n\n\n\n\n\n category: ' +objCQAChecklistCategory.ff_category_ge_og__c+ '\n\n\n\n\n');
            if(categoryChecklistMap.get(objCQAChecklistCategory.ff_category_ge_og__c)!=Null){
                for(Checklist_ge_og__c checklistId:categoryChecklistMap.get(objCQAChecklistCategory.ff_category_ge_og__c))
                {
                System.debug('********************cqaDeviationSet'+cqaDeviationSet);
                System.debug('********************checklistId'+checklistId);
                System.debug('********************checklistId.id'+checklistId.id);
                    // The number of Script statements is reduced to one statement for each 'for inside for loop'
                    // which is the only governor limit that needs to be taken care in this case
                    if(cqaDeviationSet != NULL && !cqaDeviationSet.contains(checklistId.id)){
                    
                        lstCQAChecklistDeviation.add(new Fulfillment_Checklist_Deviation_ge_og__c
                                                 (ff_checklist_category_id_ge_og__c = objCQAChecklistCategory.Id,
                                                 ff_checklist_ge_og__c  = checklistId.question_ge_og__c,
                                                 ff_checklist_reference_ge_og__c = checklistId.id));
                         System.debug('********************INSIDE IF lstCQAChecklistDeviation'+lstCQAChecklistDeviation);                        
                
                    }
                    /* Added for 0 Deviations Logic*/
                    else if(opptycCQADeviationMap.size()== 0){
                        lstCQAChecklistDeviation.add(new Fulfillment_Checklist_Deviation_ge_og__c
                                                 (ff_checklist_category_id_ge_og__c = objCQAChecklistCategory.Id,
                                                 ff_checklist_ge_og__c  = checklistId.question_ge_og__c,
                                                 ff_checklist_reference_ge_og__c = checklistId.id));
                    System.debug('********************INSIDE ELSE lstCQAChecklistDeviation'+lstCQAChecklistDeviation); 
                    }
                    
                }
            }
            
        }
        
        // Insert Risk checklist deviation record
        if(!lstCQAChecklistDeviation.isEmpty())
            insert lstCQAChecklistDeviation;
    }
    
    
    
    public void checkCQAChecklist(List<Opportunity> newOppList,List <Checklist_Category_ge_og__c> checklistCategoryList,Map<id,Set<Fulfillment_Checklist_Deviation_ge_og__c>> opptycCQADeviationMap){
        system.debug(LoggingLevel.Info,'INSIDE checkCQAChecklist Method');   
        List<Fulfillment_Checklist_Category_ge_og__c> deleteCQAChecklist = new List<Fulfillment_Checklist_Category_ge_og__c>();
        Map<String,List<Checklist_ge_og__c>> categoryChecklistMap = new Map<String,List<Checklist_ge_og__c>>();
        Set<String> categorySet = new Set<String>();
        
        for(opportunity opp : newOppList){
            
            if(opp.fulfillment_checklist_generated_ge_og__c) {
                system.debug(LoggingLevel.Info,'INSIDE IF fulfillment checklist generated Check'); 
                Set<String> tier2Value = new Set<String>{'All','ALL'};
                Set<String> tier3Value = new Set<String>{'All','ALL'};
                Set<String> tier4Value = new Set<String>{'All','ALL'};
                //Set<String> siteScopeValue = new Set<String>{'All','ALL'};
                Set<String> opptyDriverValue = new Set<String>{'All','ALL'};
                //Set<String> prodServiceValue = new Set<String>{'All','ALL'};
                
                tier2Value.add(opp.tier_2_ge_og__c==null?'':opp.tier_2_ge_og__c);
                tier3Value.add(opp.tier_3_ge_og__c==null?'':opp.tier_3_ge_og__c);
                tier4Value.add(opp.tier_4_ge_og__c==null?'':opp.tier_4_ge_og__c);
                
                if(opp.OpportunityLineItems.size()>0){
                    for(opportunityLineItem oppItem : opp.OpportunityLineItems){
                        //siteScopeValue.add(oppItem.GE_PW_TML_sitscpe__c);
                        opptyDriverValue.add(oppItem.GE_ES_Opportunity_Driver__c==null?'':oppItem.GE_ES_Opportunity_Driver__c);
                        //prodServiceValue.add(oppItem.GE_ES_Product_Services__c);
                        
                        tier2Value.add(oppItem.GE_PTier2_PL__c==null?'':oppItem.GE_PTier2_PL__c);
                        tier3Value.add(oppItem.GE_PTier3_PL__c==null?'':oppItem.GE_PTier3_PL__c);
                        tier4Value.add(oppItem.GE_PTier4_PL__c==null?'':oppItem.GE_PTier4_PL__c);
                    }
                    
                }
                
                for(Checklist_Category_ge_og__c checklistCategory : checklistCategoryList){
                    system.debug(LoggingLevel.Info,'tier2Value'+tier2Value);
                    system.debug(LoggingLevel.Info,'tier3Value'+tier3Value);
                    system.debug(LoggingLevel.Info,'tier4Value'+tier4Value);
                    system.debug(LoggingLevel.Info,'opptyDriverValue'+opptyDriverValue);
                    if( tier2Value.contains(checklistCategory.checklist_category_tier_2_ge_og__c) && 
                        tier3Value.contains(checklistCategory.checklist_category_tier_3_ge_og__c) && 
                        tier4Value.contains(checklistCategory.checklist_category_tier_4_ge_og__c) &&
                        opptyDriverValue.contains(checklistCategory.oppty_driver_ge_og__c)
                        )
                    {
                        system.debug(LoggingLevel.Info,'INSIDE FOR LOOP CC');
                        categorySet.add(checklistCategory.category_ge_og__c);
                        system.debug(LoggingLevel.Info,'categorySet'+categorySet);
                        if(!categoryChecklistMap.containsKey(checklistCategory.category_ge_og__c)){
                         system.debug(LoggingLevel.Info,'IF:categoryChecklistMap'+categoryChecklistMap);
                            categoryChecklistMap.put(checklistCategory.category_ge_og__c,checklistCategory.Checklists__r);
                        }
                        
                        else{
                        system.debug(LoggingLevel.Info,'ELSE: checklistCategory.category_ge_og__c'+checklistCategory.category_ge_og__c);
                            categoryChecklistMap.get(checklistCategory.category_ge_og__c).addAll(checklistCategory.Checklists__r);
                        }
                        system.debug(LoggingLevel.Info,'After putting values: '+categoryChecklistMap);
                        
                    }
                }
                system.debug('\n\n\n\n\n CategorySet:'+categorySet.size()+'\n\n\n\n\n FFCL SIze:'+opp.Fulfillment_Checklist_Categories__r.size()+'\n\n\n\n');
                for(Fulfillment_Checklist_Category_ge_og__c fcc:opp.Fulfillment_Checklist_Categories__r){
                    //Updated the below conditon to delete FCC only if the Oppty doesn't have any productline associated
                    if(!categorySet.contains(fcc.ff_category_ge_og__c)){
                    system.debug(LoggingLevel.Info,'INSIDE IF of categorySet'+categorySet);
                        deleteCQAChecklist.add(fcc);
                    }                    
                }
                system.debug(LoggingLevel.Info,'deleteCQAChecklist: '+deleteCQAChecklist);
                

            }
            
        }
        //if(!deleteCQAChecklist.isEmpty())
            //delete deleteCQAChecklist;
        
        system.debug('newOppList: '+newOppList);
        system.debug('deleteCQAChecklist: '+deleteCQAChecklist);
        system.debug('categoryChecklistMap: '+categoryChecklistMap);
        system.debug('opptycCQADeviationMap: '+opptycCQADeviationMap);
        //Creating Fulfillment Checklist Deviation
        deleteCQASeries(newOppList,deleteCQAChecklist,categoryChecklistMap,opptycCQADeviationMap);
        
    }
    
    public void deleteCQASeries(List<Opportunity>newOppList,List<Fulfillment_Checklist_Category_ge_og__c> deleteCQAChecklist, Map<String,List<Checklist_ge_og__c>> categoryChecklistMap,Map<id,Set<Fulfillment_Checklist_Deviation_ge_og__c>> opptycCQADeviationMap)
    {
        
        system.debug('INSIDE deleteCQASeries: ');
        Set<Fulfillment_Checklist_Deviation_ge_og__c> deleteCQAChecklistDeviationSet = new Set<Fulfillment_Checklist_Deviation_ge_og__c>();
        List<Fulfillment_Checklist_Deviation_ge_og__c> deleteCQAChecklistDeviationList = new List<Fulfillment_Checklist_Deviation_ge_og__c>();
        for(opportunity opp: newOppList ){
        system.debug('INSIDE FOR opptycCQADeviationMap'+opptycCQADeviationMap);
            if(opptycCQADeviationMap.get(opp.id)!=Null){
            system.debug('INSIDE IF ');
                for(Fulfillment_Checklist_Deviation_ge_og__c fcd : opptycCQADeviationMap.get(opp.id)){
                    set<id> clSet = new Set<id>();
                    if(categoryChecklistMap.get(fcd.ff_checklist_category_id_ge_og__r.ff_category_ge_og__c)!=null){
                        for(Checklist_ge_og__c cct: categoryChecklistMap.get(fcd.ff_checklist_category_id_ge_og__r.ff_category_ge_og__c)){
                            clSet.add(cct.id);
                        }
                    }
                    
                    if(!clSet.contains(fcd.ff_checklist_reference_ge_og__c))
                            deleteCQAChecklistDeviationSet.add(fcd);
                    
                }
            }
            
        }

        
        system.debug('deleteCQAChecklistDeviationSet'+deleteCQAChecklistDeviationSet);
        system.debug('deleteCQAChecklistDeviationList'+deleteCQAChecklistDeviationList);
        system.debug('deleteCQAChecklist'+deleteCQAChecklist);
       
        // Insert Risk checklist deviation record
        deleteCQAChecklistDeviationList.addAll(deleteCQAChecklistDeviationSet);
        if(!deleteCQAChecklistDeviationList.isEmpty())
            delete deleteCQAChecklistDeviationList;
        
        if(!deleteCQAChecklist.isEmpty())
            delete deleteCQAChecklist;   
        
    }

}