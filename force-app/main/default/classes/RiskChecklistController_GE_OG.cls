/*
Class/Trigger Name     : RiskChecklistController_GE_OG 
Used Where ?           : RiskChecklistCategoryHandler_GE_OG, DealDeskTriggerHandler_GE_OG
Purpose/Overview       : it will contains all the functionality around Risk Checklist
Scrum Team             : Transformation - OPPTY MGMT
Requirement Number     : R-23494
Author                 : Nitish Pandey
Created Date           : 09/OCT/2015
Test Class Name        : RiskChecklistController_GE_OG_Test
Code Coverage          : 87%
*/
public without sharing class RiskChecklistController_GE_OG 
{
    
   /* //Make existing RCC records inactive before creating/regenerating new RCC set
   public void deactivateExistingRCC(String recId, String actionParam){
      System.debug('-------------Entering into RiskChecklistController_GE_OG.deactivateExistingRCC method');
       try{  
            List<Risk_Checklist_Category_ge_og__c> existingRCCList = new List<Risk_Checklist_Category_ge_og__c>();
        	if(actionParam=='Create'){
                   existingRCCList = [Select id,Is_Active_ge_og__c from Risk_Checklist_Category_ge_og__c 
                                                                    where RCC_Opportunity_ge_og__c=:recId and Is_Active_ge_og__c=true];
        	}
        	else if(actionParam=='Regenerate'){
                  existingRCCList = [Select id,Is_Active_ge_og__c from Risk_Checklist_Category_ge_og__c 
                                                                    where id=:recId and Is_Active_ge_og__c=true];
        	}    
        	List<Risk_Checklist_Category_ge_og__c> objRCC = new List<Risk_Checklist_Category_ge_og__c>();
         	
        	if(existingRCCList.size()>0){
                System.debug('-------------existingRCCList.size()='+existingRCCList.size());
          		for(Risk_Checklist_Category_ge_og__c rcc:existingRCCList){
                    
            	      rcc.Is_Active_ge_og__c=false;
            	      objRCC.add(rcc);
          		}
          	update objRCC;
            }
       }catch(Exception ex){
            system.debug('---Exception--->>>>'+ex);
            //return 'Existing RCC record update to inactive status failed';
       }
    }*/
    
    
    // Method to query the Checklist records whose parent Checklist category records recordtype is "Risk Checklist"
    //insert Risk checklist category records
    //it will return all newly created risk Checklist category
    //public List<Risk_Checklist_Category_ge_og__c> createRiskCheckListCategory(List<Checklist_Category_ge_og__c> checklistCategoryList,List<Deal_Desk_ge_og__c> lstDealDesk)
   public void createRiskCheckListCategory(List<Checklist_Category_ge_og__c> riskChecklistCategoryList,List<Deal_Desk_ge_og__c> newUpdDealDesk, 
                              Map<Id,Id> currentAndInactiveDDMap, Map<String,Risk_Checklist_Deviation_ge_og__c> existingRccOpptyDeviationMap,
                              Map<Id,Checklist_Deviation_ge_og__c> checklistWithL0DeviationMap)
    {
     try{
         System.debug('-------------Entering into RiskChecklistController_GE_OG.createRiskCheckListCategory and riskChecklistCategoryList.size='+riskChecklistCategoryList.size());
        List<Risk_Checklist_Category_ge_og__c> lstRiskCheckListCategory = new List<Risk_Checklist_Category_ge_og__c>();
        Set<String> categorySet = new Set<String>();
        Map<String,List<Checklist_ge_og__c>> checklistCategoryMap = new Map<String,List<Checklist_ge_og__c>>();
        // Create a list of Risk_Checklist_Category_ge_og__c to be inserted
        for(Deal_Desk_ge_og__c objDealDesk:newUpdDealDesk)
        {


            for(Checklist_Category_ge_og__c checklistCategory:riskChecklistCategoryList)
            {

                // Checks here for Tier 2 and Tier 3 values of Checklist Category and Deal Desk

                if((checklistCategory.checklist_category_tier_2_ge_og__c == 'All' && checklistCategory.checklist_category_tier_3_ge_og__c == 'All') || (checklistCategory.checklist_category_tier_2_ge_og__c == objDealDesk.deal_desk_tier_2_ge_og__c && checklistCategory.checklist_category_tier_3_ge_og__c == 'All') || (checklistCategory.checklist_category_tier_2_ge_og__c == objDealDesk.deal_desk_tier_2_ge_og__c && checklistCategory.checklist_category_tier_3_ge_og__c == objDealDesk.deal_desk_tier_3_ge_og__c) )
                {
                      System.debug('----------....>>>> Entered riskChecklistCategoryList For-Loop:'+checklistCategory+'\n\n');
                      categorySet.add(checklistCategory.category_ge_og__c);
                    
                      if(!checklistCategoryMap.containsKey(checklistCategory.category_ge_og__c)){
                        system.debug('---if loop---....>>>>> 1 list size:'+checklistCategory.Checklists__r.size()+'\n\n');
                        checklistCategoryMap.put(checklistCategory.category_ge_og__c,checklistCategory.Checklists__r);
                        system.debug('------....>>>>>     1 map size :'+checklistCategoryMap.get(checklistCategory.category_ge_og__c).size()+'\n\n');
                      }
                      else{
                        system.debug('---else loop----...>>   2 list size:'+checklistCategory.Checklists__r.size()+'\n\n');
                        checklistCategoryMap.get(checklistCategory.category_ge_og__c).addAll(checklistCategory.Checklists__r);
                        system.debug('------.....>>>>>>>>     2 map size :'+checklistCategoryMap.get(checklistCategory.category_ge_og__c).size()+'\n\n');
                    }
                    
                }
            }

            system.debug('----------------......>>>>>>>> Opp ID='+objDealDesk.deal_desk_opportunity_id_ge_og__c+' & categorySet.size='+categorySet.size());
            for(String str : categorySet){
                system.debug('----------------......>>>>>>>> category='+str);
                lstRiskCheckListCategory.add(new Risk_Checklist_Category_ge_og__c(RCC_Opportunity_ge_og__c = objDealDesk.deal_desk_opportunity_id_ge_og__c,
                                              rcl_category_ge_og__c = str, Is_Active_ge_og__c= true));
            }
        }
        
        // Insert Risk checklist category records
        system.debug('----------------......>>>>>>>> lstRiskCheckListCategory='+lstRiskCheckListCategory.size());
        if(!lstRiskCheckListCategory.isEmpty())
            insert lstRiskCheckListCategory;

            System.debug('---------------------------......................>>>>>'+lstRiskCheckListCategory.size()); 
         
        createRiskCheckListDeviation(lstRiskCheckListCategory,checklistCategoryMap,currentAndInactiveDDMap,existingRccOpptyDeviationMap,checklistWithL0DeviationMap );
        //return lstRiskCheckListCategory;



     }catch(Exception ex){
          system.debug('---Exception---------------------------------------------->>>>'+ex);
           // return 'Risk Checklist Category regeneration failed';
     } 

   }
    

    /* Method to input :
     * 
     * b.insert Risk Checklist Deviation records
     */
    public void createRiskCheckListDeviation(List<Risk_Checklist_Category_ge_og__c> listRiskChecklistCategory,
                                             Map<String,List<Checklist_ge_og__c>> checklistCategoryMap, Map<Id,Id> currentAndInactiveDDMap,
                                             Map<String,Risk_Checklist_Deviation_ge_og__c> existingRccOpptyDeviationMap,
                                             Map<Id,Checklist_Deviation_ge_og__c> checklistWithL0DeviationMap)
    {
        List<Risk_Checklist_Deviation_ge_og__c> lstRiskCheckListDeviation = new List<Risk_Checklist_Deviation_ge_og__c>();
        
        Id activeDDId = [select id  from Deal_Desk_ge_og__c where active_deal_desk_ge_og__c = true and 
            						 deal_desk_opportunity_id_ge_og__c =: listRiskChecklistCategory.get(0).RCC_Opportunity_ge_og__c ].id;
         System.debug('------------------------------->>Entering into createRiskCheckListDeviation activeDDId:'+activeDDId);
        for(Risk_Checklist_Category_ge_og__c objRiskChecklistCategory:listRiskChecklistCategory)
        {
            

               
            // Use 'for inside for loop' as every Risk checklist category item records must be associated
            // to multiple Risk Checklist through Risk Checklist deviation


            system.debug('---------------->>Going to be active DD:' + activeDDId);
            for(Checklist_ge_og__c checklistId:checklistCategoryMap.get(objRiskChecklistCategory.rcl_category_ge_og__c))
            {
                // The number of Script statements is reduced to one statement for each 'for inside for loop'
                // which is the only governor limit that needs to be taken care in this case
                String deviationMapKey = String.ValueOf(checklistId.id) + String.ValueOf(activeDDId);
                
                if(existingRccOpptyDeviationMap.get(deviationMapKey)!=Null){
                    system.debug('---------------1........>>>>existingRccOpptyDeviationMap not null=' + existingRccOpptyDeviationMap.get(deviationMapKey).deviation_reference_ge_og__c);
                          if(existingRccOpptyDeviationMap.get(deviationMapKey).deviation_reference_ge_og__c!=null){
                              system.debug('---------------........>>>>deviation_reference_ge_og__c is not null=' + existingRccOpptyDeviationMap);
                              lstRiskCheckListDeviation.add(new Risk_Checklist_Deviation_ge_og__c (risk_checklist_category_id_ge_og__c = objRiskChecklistCategory.Id, checklist_reference_ge_og__c = checklistId.id, rcl_deviation_level_ge_og__c = existingRccOpptyDeviationMap.get(deviationMapKey).rcl_deviation_level_ge_og__c, deviation_reference_ge_og__c = existingRccOpptyDeviationMap.get(deviationMapKey).deviation_reference_ge_og__c ));
                          }else{
                               system.debug('---------------........>>>>deviation_reference_ge_og__c is null=' + existingRccOpptyDeviationMap);
                               lstRiskCheckListDeviation.add(new Risk_Checklist_Deviation_ge_og__c (risk_checklist_category_id_ge_og__c = objRiskChecklistCategory.Id,checklist_reference_ge_og__c = checklistId.id, rcl_deviation_ge_og__c = existingRccOpptyDeviationMap.get(deviationMapKey).rcl_deviation_ge_og__c, rcl_deviation_level_ge_og__c = Integer.ValueOf(checklistWithL0DeviationMap.get(checklistId.id).checklist_deviation_level_ge_og__c), deviation_reference_ge_og__c = checklistWithL0DeviationMap.get(checklistId.id).id ));
                          }
                }
                else{
                    system.debug('---------------.......>>>>existingRccOpptyDeviationMap is null');
                    lstRiskCheckListDeviation.add(new Risk_Checklist_Deviation_ge_og__c (risk_checklist_category_id_ge_og__c = objRiskChecklistCategory.Id, checklist_reference_ge_og__c = checklistId.id, rcl_deviation_level_ge_og__c = Integer.ValueOf(checklistWithL0DeviationMap.get(checklistId.id).checklist_deviation_level_ge_og__c), deviation_reference_ge_og__c = checklistWithL0DeviationMap.get(checklistId.id).id ));
                }
            }
        }
        
        // Insert Risk checklist deviation record
        if(!lstRiskCheckListDeviation.isEmpty())
            insert lstRiskCheckListDeviation;
    }
    
    
    // Method to Update Risk checklist deviation records when Deal Dsk Got Updated
    public void updateRiskCheckListDeviation(Map<id,List<Risk_Checklist_Deviation_ge_og__c>> ddRiskDeviationMap, List<Risk_Checklist_Category_ge_og__c> rccList)
    {
        List<Risk_Checklist_Deviation_ge_og__c> updateRiskDeviationList = new List<Risk_Checklist_Deviation_ge_og__c>();
        List<Risk_Checklist_Category_ge_og__c> updateRCCUpdate = new List<Risk_Checklist_Category_ge_og__c>();
        for(Id ddId : ddRiskDeviationMap.keySet()){
            for(Risk_Checklist_Deviation_ge_og__c rcd : ddRiskDeviationMap.get(ddId)){
                system.debug('iiiiiiiiiiiiii  ' +rcd.id+'      '+rcd.deviation_reference_ge_og__r.checklist_deviation_level_ge_og__c+'    ' + rcd.deviation_reference_ge_og__r.deviation_ge_og__c);
                rcd.rcl_deviation_level_ge_og__c = Integer.ValueOf(rcd.deviation_reference_ge_og__r.checklist_deviation_level_ge_og__c);
                rcd.rcl_deviation_ge_og__c = rcd.deviation_reference_ge_og__r.deviation_ge_og__c;
                rcd.risk_checklist_deviation_locked_ge_og__c=True;
                rcd.risk_checklist_ge_og__c = rcd.checklist_reference_ge_og__r.question_ge_og__c;
               // rcd.deviation_reference_ge_og__c = Null;
               //rcd.checklist_reference_ge_og__c = Null;
                updateRiskDeviationList.add(rcd);
            }
        }
        for(Risk_Checklist_Category_ge_og__c rcc:rccList){
            rcc.risk_checklist_locked_ge_og__c=True;
            updateRCCUpdate.add(rcc);
            
        }
        
        update updateRiskDeviationList;
        update updateRCCUpdate;
    }
    
    
    // Added by Madhuri : 15-Mar-2016 - R-24331 (Method for default status as Supported )
    public void assignDefaultSupported(List<Risk_Checklist_Category_ge_og__c > newRccList,Map<Id,Risk_Checklist_Category_ge_og__c > oldRccMap){
        System.debug('\n\n ------ assignDefaultSupported ENTERED ----- ');
        for(Risk_Checklist_Category_ge_og__c rccObj:newRccList)
        {
            if(rccObj.status_ge_og__c == 'Submitted' && oldRccMap.get(rccObj.Id).status_ge_og__c != 'Submitted' && 
                rccObj.total_questions_ge_og__c == rccObj.answered_all_deviation_ge_og__c && (rccObj.rcl_reviewer_ge_og__c == null || rccObj.max_deviation_ge_og__c == 0)){
                
                System.debug('n\n ENTERED No reviewer BLOCK');
                rccObj.status_ge_og__c = 'Supported';
                rccObj.submission_for_support_date_ge_og__c = Date.today();
                rccObj.confirmation_of_support_date__c = Date.today();
                
            }
        }
    }
    
    //Method for Assigning Reviewer to Risk Checklist Category
    public void assignReviewerToRiskChecklistCategory(List<Risk_Checklist_Category_ge_og__c > newRccList,Map<Id,Risk_Checklist_Category_ge_og__c > oldRccMap,Map<Id,Id> rccOpptyMap){
        
        Map<Id,Id> rccReviewerMap = new Map<Id,Id>();
        
        //Added by Madhuri : 15-Mar-2016 - R-24331
        for(Risk_Checklist_Category_ge_og__c rccObj:newRccList)
        {
            System.debug('\n\n ------ assignReviewerToRiskChecklistCategory ENTERED ----- ');
            
            if(rccObj.status_ge_og__c == 'Submitted' && oldRccMap.get(rccObj.Id).status_ge_og__c != 'Submitted' &&   rccObj.max_deviation_ge_og__c != 0 &&
               rccObj.total_questions_ge_og__c == rccObj.answered_all_deviation_ge_og__c && rccObj.rcl_reviewer_ge_og__c != null)
            {
                System.debug('n\n ENTERED SUBMITTED BLOCK');
                RiskChecklistReviewer_GE_OG objRCCReviewer = new RiskChecklistReviewer_GE_OG();
                objRCCReviewer.submitRecord(rccObj,rccObj.rcl_reviewer_ge_og__c,rccOpptyMap);
                break;
                
            }
        }
        for(Risk_Checklist_Category_ge_og__c rccObj:newRccList)
        {
            if(rccObj.status_ge_og__c == 'Supported' && oldRccMap.get(rccObj.Id).status_ge_og__c != 'Supported' &&
                 rccObj.rcl_reviewer_ge_og__c != null && rccObj.max_deviation_ge_og__c != 0)
            {
                RiskChecklistReviewer_GE_OG objRCCReviewer = new RiskChecklistReviewer_GE_OG();
                objRCCReviewer.approveRecord(rccObj);
                break;
            }
        }
        
        for(Risk_Checklist_Category_ge_og__c rccObj:newRccList)
        {
            if(rccObj.status_ge_og__c == 'Not Supported' && oldRccMap.get(rccObj.Id).status_ge_og__c != 'Not Supported')
            {
                RiskChecklistReviewer_GE_OG objRCCReviewer = new RiskChecklistReviewer_GE_OG();
                objRCCReviewer.rejectRecord(rccObj);
                break;
            }
        }
        
    }
    

}