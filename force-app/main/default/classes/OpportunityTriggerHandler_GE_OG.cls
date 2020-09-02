/*
Class/Trigger Name     : OpportunityTriggerHandler_GE_OG
Used Where ?           : OpportunityTrigger_GE_OG
Purpose/Overview       : Helper Class for Trigger on Opportunity
Scrum Team             : Transformation - OPPTY MGMT
Requirement Number     : R-23405
Author                 : Nitish Pandey
Created Date           : 09/OCT/2015
Test Class Name        : OpportunityStagesAutomation_GE_OG_Test
Code Coverage          : 91%
*/
public without sharing class OpportunityTriggerHandler_GE_OG
{
    public void beforeInsertFunctionality(List<Opportunity> newlstOpp, Map<ID,Opportunity> oldOppMap)
    {
        
        //system.debug('== \n\n\n  commercial_primary_resource_ge_og__c \n\n\n === '+newlstOpp[0].commercial_primary_resource_ge_og__c);
        
        //creating instance of class 'ProcessOppRegionUpdate_GE_OG'
        //calling method for 'GE O&G Region' and 'Install Country' and Risk Region Update on Oppty
        ProcessOppRegionUpdate_GE_OG opptyregion = new ProcessOppRegionUpdate_GE_OG();
        opptyregion.updateOppRegion(newlstOpp,oldOppMap);
        
        //Added as part of the REquirement R-29621. Added by Kiru
        Util_GE_OG.restrictCountryOnOppty(newlstOpp);
        
        
    }
    
    public void afterInsertFunctionality(List<Opportunity> newlstOpp,Map<ID,Opportunity> oldOppMap)
    {
        //creating instance of class 'AddOpportunityTeamMemberAutomation_GE_OG'
        //calling method for "Add OpportunityTeamMember"
        AddOpportunityTeamMemberAutomation_GE_OG opptyTeamMember = new AddOpportunityTeamMemberAutomation_GE_OG();
        Map<ID, OpportunityTeamMember> mapOTM;
        system.debug('++++++++++++++++++++Before entering checkrecursion+++++++++++++++++++++');
        if(CheckRecursion_GE_OG.runteamMember()){
            system.debug('+++++++++++++++++++++After entering checkrecursion+++++++++++++++++++++');
            opptyTeamMember.addCommercialUserToOpportunityTeam(newlstOpp,oldOppMap);
            
            //Added By Madhuri - R-24033 : Automatically add the opportunity owner to the Deal Team as the "Primary Sales" role
            opptyTeamMember.addOppOwnerToOpportunityTeam(newlstOpp,oldOppMap);
            AddOpportunityTeamMemberAutomation_GE_OG.addCPR(newlstOpp);
        }
        PreBidEvaluationHandler_GE_OG objPreBidEvaluationHandler = new PreBidEvaluationHandler_GE_OG();
        objPreBidEvaluationHandler.createPreBidRecord(newlstOpp);
        
        OpportunityCustomerLegalEntity_GE_OG objOpportunityCustomerLegalEntity = new OpportunityCustomerLegalEntity_GE_OG();
        objOpportunityCustomerLegalEntity.insertCustomerLegalEntityOnOpportunity(newlstOpp);
        
        // R-25901 - Notify project team if Opportunity is linked to a project
        List<Id> recordIds = new List<Id>();
        for(Opportunity o : newlstOpp){
            if(o.opportunity_project_ge_og__c != null){
                //recordIds.add(o.opportunity_project_ge_og__c);
                // Updated on 1/18/2017 R-26630 - Notify project owner & Deal team if Opportunity is linked to a project
                recordIds.add(o.Id);
            }
        }
        system.debug('recordIds%%%%%%%'+recordIds);
        if(recordIds.size() > 0)
            AddOpportunityToProject_GE_OG.emailProjectTeamofAddedOpportunities(recordIds);
        // end R-25901
        
        
        // R-R-28937
        List<Id> records = new List<Id>();
        for(Opportunity o : newlstOpp){
            
            
            if(o.amount_ge_og__c!= null){
                
                System.debug('testingchatter'+ o.Name + ' - ' + o.amount_ge_og__c);
                records.add(o.id);
                
            }
        }
        if(records.size() > 0)
            PostChatteronAccount.PostChatter(records);
        // end R-28937 
        
        
    }
    
    
    public void beforeUpdateFunctionality(List<Opportunity> newlstOpp, Map<ID,Opportunity> oldOppMap)
    {
        
        //Added by Madhuri - 05/02/2016 : To handle closed opportunities
        Id profileId = Userinfo.getProfileId();
        ProcessClosedOpportunities_GE_OG closedOpp = new ProcessClosedOpportunities_GE_OG();
        //User ur = [select id ,GE_OG_Commercial_Excellence_User__c from User where id=:userInfo.getUserId()]; // Added to Test By Nitish
        sObject userRecord = Util_GE_OG.queryObjectFields(String.valueOf(Userinfo.getUserId()));
        User oUser =(User)userRecord;
        
        //String profileName = [Select Id,Name from Profile where Id=:profileId].Name;
        //if(profileName != 'GE_ES Developer'){
        if(oUser.GE_OG_Commercial_Excellence_User__c == false){  //Added by Nitish to test
            
            closedOpp.editAccessOnOpportunity(newlstOpp,oldOppMap);
        }
        
        //Added By Madhuri : 01/04/2016 - To update the Standard stage field for Closed Opportunities
        closedOpp.updateStageOfClosedOpportunity(newlstOpp,oldOppMap);
        
        //creating instance of class 'ProcessOppRegionUpdate_GE_OG'
        //calling method for 'GE O&G Region' and 'Install Country' Update on Oppty
        ProcessOppRegionUpdate_GE_OG opptyregion = new ProcessOppRegionUpdate_GE_OG();
        opptyregion.updateOppRegion(newlstOpp,oldOppMap);
        
        //creating instance of class 'AddOpportunityTeamMemberAutomation_GE_OG'
        //calling method for "Add OpportunityTeamMember"
        AddOpportunityTeamMemberAutomation_GE_OG opptyTeamMember = new AddOpportunityTeamMemberAutomation_GE_OG();
        Map<ID, OpportunityTeamMember> mapOTM;
        opptyTeamMember.addCommercialUserToOpportunityTeam(newlstOpp,oldOppMap);
        
        
        //creating instance of class 'OpportunityStagesAutomationHandler_GE_OG'
        //calling method for stage Update on Oppty
        OpportunityStagesAutomationHandler_GE_OG oppstage= new OpportunityStagesAutomationHandler_GE_OG();
        oppstage.updateOpportunityStage(newlstOpp,oldOppMap);
        
        
        /******************R-23798**********************/
        // Change the forecast category only with change in Forecsat category, not with change in Stage
        
        for(Opportunity opp : newlstOpp){
            System.debug('\n\n OpportunityTriggerHandler_GE_OG std Stage OLD ' + oldOppMap.get(opp.id).StageName);
            System.debug('\n\n OpportunityTriggerHandler_GE_OG std Stage NEW ' + opp.StageName);
            System.debug('\n\n OpportunityTriggerHandler_GE_OG custom Stage OLD ' + oldOppMap.get(opp.id).stage_ge_og__c);
            System.debug('\n\n OpportunityTriggerHandler_GE_OG custom Stage NEW ' + opp.stage_ge_og__c);
            System.debug('\n\n OUTSIDE Forecast OLD ' + oldOppMap.get(opp.id).ForecastCategoryName);
            System.debug('\n\n OUTSIDE Forecast NEW ' + opp.ForecastCategoryName);
            if(opp.stageName != 'Closed Won' && opp.stageName != 'Closed Lost' && opp.stageName != 'Cancelled'){
                if(opp.stageName != oldOppMap.get(opp.id).StageName /*&& opp.Forecast_Changed_ge_og__c == True*/){
                    
                    System.debug('\n\n ENTERTED INTO FORECAST BLOCK ');
                    System.debug('\n\n Forecast Changed ' + opp.Forecast_Changed_ge_og__c);
                    System.debug('\n\n Forecast OLD ' + oldOppMap.get(opp.id).ForecastCategoryName);
                    System.debug('\n\n Forecast NEW ' + opp.ForecastCategoryName);
                    opp.ForecastCategoryName = oldOppMap.get(opp.id).ForecastCategoryName ;
                    
                    
                }
            }
            
        }
        // Code for calculate GFS Execution Date and Update Request Type R-23725
        OpportunityGFSExcecutionAutomation_GE_OG  objgfsaautomation = new OpportunityGFSExcecutionAutomation_GE_OG();
        objgfsaautomation.CalculateOpportunityGFSExcetuionDate(newlstOpp,oldOppMap);
        //Added by Kiru
        OpportunityMultiTier_GE_OG multitier = new OpportunityMultiTier_GE_OG();
        multitier.updateMultiTier(newlstOpp,oldOppMap);
        
        //Added as part of the REquirement R-29621. Added by Kiru
        Util_GE_OG.restrictCountryOnOppty(newlstOpp);
    }
    
    //Added as part of  R-25004
    Set<Id> setNewOpptyId = new Set<Id>();
    //END of  R-25004    
    //public void afterUpdateFunctionality(List<Opportunity> newOppList,Map<Id,Opportunity> oldOppMap){
    //R-24778 : Above line is commented to modify as below:
    public void afterUpdateFunctionality(List<Opportunity> newOppList,Map<Id,Opportunity> oldOppMap,List<Opportunity> oldOppList){
        List<Opportunity> oplist = new  List<Opportunity>();
       // AddOpportunityTeamMemberAutomation_GE_OG.addCPR(newOppList,oldOppMap);
        //Fetching all Active Deal Desk for the Opportunity 
        Map<String,Integer> opportunityProductCount =  new Map<String,Integer>();
        Map<Id,Deal_Desk_ge_og__c> opptyDealMap = new Map<Id,Deal_Desk_ge_og__c>();
        Map<Id,List<OpportunityLineItem>> opptyProductMap = new Map<Id,List<OpportunityLineItem>>();
        Set<Id> setOpptyIdWithoutPreBid = new Set<Id>();
        List<Opportunity> lstOppWithoutPreBid = new List<Opportunity>();
        
        for(Opportunity op : newOppList)
        {
            Opportunity oppy = oldOppMap.get(op.Id);
            if((op.Commercial_Primary_Resource_ge_og__c != oppy.Commercial_Primary_Resource_ge_og__c )){
                oplist.add(op);
            }
        } 
        if(oplist.size()>0){
        
              AddOpportunityTeamMemberAutomation_GE_OG.addCPR(oplist);
            
        }
        
        List<Deal_Desk_ge_og__c> dealDeskList = [select id, deal_desk_opportunity_id_ge_og__r.is_global_ge_og__c, 
                                                 deal_desk_opportunity_id_ge_og__c, status_ge_og__c //dd_max_deviation_ge_og__c
                                                 from Deal_Desk_ge_og__c where 
                                                 active_deal_desk_ge_og__c = True and deal_desk_opportunity_id_ge_og__c in: newOppList and 
                                                 ( deal_desk_opportunity_id_ge_og__r.StageName = 'Qualifying' Or 
                                                  deal_desk_opportunity_id_ge_og__r.StageName = 'Bid In Development')
                                                ];
        
        List<Deal_Desk_ge_og__c> closedOpptyDDList = [select id, deal_desk_opportunity_id_ge_og__r.is_global_ge_og__c, 
                                                      deal_desk_opportunity_id_ge_og__c, status_ge_og__c //dd_max_deviation_ge_og__c
                                                      from Deal_Desk_ge_og__c where status_ge_og__c='Submitted' and
                                                      active_deal_desk_ge_og__c = True and deal_desk_opportunity_id_ge_og__c in: newOppList and 
                                                      ( deal_desk_opportunity_id_ge_og__r.StageName = 'Closed Lost' Or 
                                                       deal_desk_opportunity_id_ge_og__r.StageName = 'Cancelled')
                                                     ];
        
        List<Risk_Checklist_Category_ge_og__c> closedOpptyRccList = [select id,status_ge_og__c
                                                                     from Risk_Checklist_Category_ge_og__c where status_ge_og__c='Submitted' and 
                                                                     Is_Active_ge_og__c= True and RCC_Opportunity_ge_og__c in: newOppList and 
                                                                     ( RCC_Opportunity_ge_og__r.StageName = 'Closed Lost' Or 
                                                                      RCC_Opportunity_ge_og__r.StageName = 'Cancelled')
                                                                    ]; 
        
        //Added by Harsha C for R-32503
        List<Pre_Bid_ge_og__c> closedOpptyPrebidList = [SELECT Id, Name, pre_bid_opportunity_ge_og__c,   prebid_approved_date_ge_og__c, prebid_submission_date_ge_og__c FROM Pre_Bid_ge_og__c where pre_bid_status_ge_og__c='Submitted' and 
                                                        pre_bid_active_ge_og__c= True and pre_bid_opportunity_ge_og__c in: newOppList and 
                                                        ( pre_bid_opportunity_ge_og__r.StageName = 'Closed Lost' Or 
                                                         pre_bid_opportunity_ge_og__r.StageName = 'Cancelled')
                                                       ]; 
        
        
       System.debug('closedOpptyPrebidList    ? ?  /  /  / '+closedOpptyPrebidList);
        System.debug('closedOpptyRccList ******************************'+closedOpptyRccList );
        List<AggregateResult> opportunityProductCountResult = [select OpportunityId opp, count(Id) productCount from OpportunityLineItem where OpportunityId in : newOppList group by OpportunityId ];
        system.debug('\n\n\n\n\n\n\n Deal Size'+dealDeskList.size()+'\n\n\n\n\n\n');
        for(AggregateResult agg : opportunityProductCountResult ){
            opportunityProductCount.put(String.valueOf(agg.get('Opp')),Integer.valueOf(agg.get('productCount')));
        }
        
        for(Deal_Desk_ge_og__c dd : dealDeskList ){
            opptyDealMap.put(dd.deal_desk_opportunity_id_ge_og__c,dd);
        }
        
        //  Recall functionality for Deal 
        
        for(Deal_Desk_ge_og__c ddObj : closedOpptyDDList )
        {
            DealDeskApprover_GE_OG objDealDeskApprover = new DealDeskApprover_GE_OG();
            objDealDeskApprover.RecallRecord(ddObj);
            break;
        }
        
        
        //  Recall functionality for Risk
        // for(Risk_Checklist_Category_ge_og__c rccObj : closedOpptyRccList)
        //  {
        If(!closedOpptyRccList.isEmpty()){
            RiskChecklistReviewer_GE_OG objRCCApprover = new RiskChecklistReviewer_GE_OG();
            objRCCApprover.recallrecord(closedOpptyRccList);
           }
        //Added by Harsha C for R-32503
        If(!closedOpptyPrebidList.isEmpty()){
           RecallRecord_GE_OG objprebid = new RecallRecord_GE_OG();
            String prebidid = closedOpptyPrebidList[0].Id;
            String h =RecallRecord_GE_OG.recallRecord(prebidid);
            System.debug('h >>> '+h);
        }
        
        //   break;
        // }
        
        List<Opportunity> opptywithProductList = [select id, OpptyMaxFlag__c,Probability, deal_path_ge_og__c, IsClosed, StageName,fulfillment_checklist_generated_ge_og__c , Is_express_ge_og__c, need_comm_ops_support_ge_og__c,tier_2_ge_og__c,
                                                  tier_4_ge_og__c, tier_3_ge_og__c,
                                                  (select id, GE_ES_Product_Services__c, GE_ES_Opportunity_Driver__c , //GE_PW_TML_sitscpe__c,
                                                   GE_PTier2_PL__c, GE_PTier3_PL__c, GE_PTier4_PL__c from OpportunityLineItems)
                                                  from opportunity where id in: newOppList];
        
        //Added as part of  R-25004
        for(Opportunity opp : opptywithProductList ){
            //Added by Kiru - To skip the below future method class while batch(Account Merge Functionlaity) is executing
            if(opp.OpptyMaxFlag__c && !System.isBatch())
            {
                setNewOpptyId.add(opp.Id);
                
            }
        }
        //moved outside the forloop as part of bug 0000025556
        if(setNewOpptyId.size()>0 && !System.isBatch() && !System.isFuture()){           
            GE_OG_OfflineOpportunityInsertHelper.InsertOfflineOpportunity(setNewOpptyId); 
        }
        //END of  R-25004                                          
        
        Id riskChecklistRecordTypeId = Util_GE_OG.getRecordTypeDetails('Checklist_Category_ge_og__c','Fulfillment Checklist').getRecordTypeId();
        
        
        //fetching all Active Risk Checklist Category with Deviation
        List <Checklist_Category_ge_og__c> checklistCategoryList = [Select id, active_ge_og__c, RecordTypeId, checklist_category_tier_2_ge_og__c, category_ge_og__c, 
                                                                    checklist_category_tier_3_ge_og__c,sitescope_ge_og__c,
                                                                    checklist_category_tier_4_ge_og__c, product_service_ge_og__c, oppty_driver_ge_og__c, (select Id,checklist_category_id_ge_og__c, question_ge_og__c
                                                                                                                                                          from Checklists__r where  active_checklist_ge_og__c = true) 
                                                                    from Checklist_Category_ge_og__c where RecordTypeId =: riskChecklistRecordTypeId 
                                                                    and active_ge_og__c = True];
        
        
        //CQA Checklist
        CQAChecklistController_GE_OG cqa = new CQAChecklistController_GE_OG();
        system.debug('------------------------>>>>Fulfilment checklistCategoryList Size'+checklistCategoryList.size()+'\n\n\n\n\n\n');
        cqa.generateCQAChecklist(opptywithProductList,oldOppMap,checklistCategoryList);        
        
        
        OpportunityCustomerLegalEntity_GE_OG objOpportunityCustomerLegalEntity = new OpportunityCustomerLegalEntity_GE_OG();
        objOpportunityCustomerLegalEntity.updateCustomerLegalEntityOnOpportunity(newOppList, oldOppMap);
        
        // Code for calculate GFS Execution Date and Update Request Type R-23725
        OpportunityGFSExcecutionAutomation_GE_OG  objgfsaautomation = new OpportunityGFSExcecutionAutomation_GE_OG();
        objgfsaautomation.updateRequestType(newOppList,oldOppMap);   
        
        //calling method for "Add OpportunityTeamMember"
        AddOpportunityTeamMemberAutomation_GE_OG opptyTeamMember = new AddOpportunityTeamMemberAutomation_GE_OG();
        Map<ID, OpportunityTeamMember> mapOTM;
        
        //Added By Madhuri - R-24033 : Automatically add the opportunity owner to the Deal Team as the "Primary Sales" role
        opptyTeamMember.addOppOwnerToOpportunityTeam(newOppList,oldOppMap);
        // Offline Opportunity R-24778
        //  GE_OG_OfflineOpportunityInsertHelper offOPPInsert = new GE_OG_OfflineOpportunityInsertHelper();
        //  offOPPInsert.InsertOfflineOpportunity(newOppList,oldOppList);
        //Bug #: 0000024088 - commented above 2 lines 
        
        
        
        //Added by Nitish for Removing references from Fulfillment and Risk Checklist when Opportunity is Disposed
        List<Opportunity> diposedOpportunities = new List<Opportunity>();
        for(Opportunity opp : newOppList){
            setNewOpptyId.add(opp.Id);  //Added as part of  R-25004
            if(opp.deal_path_ge_og__c == 'Deal Desk' && (opp.stageName == 'Closed Won' || opp.stageName == 'Closed Lost' || opp.stageName == 'Cancelled')){
                diposedOpportunities.add(opp);
            }
        }
        
        
        if(diposedOpportunities!=null){
            OpportunityDisposedFunctionality odf = new OpportunityDisposedFunctionality();
            odf.removeRefrences(diposedOpportunities);
        }
        
        for(Opportunity opp : newOppList){
            System.debug('\n\n AFTER UPDATE Stage OLD ' + oldOppMap.get(opp.id).StageName);
            System.debug('\n\n AFTER UPDATE Stage NEW ' + opp.StageName);
            System.debug('\n\n AFTER UPDATE Forecast OLD ' + oldOppMap.get(opp.id).ForecastCategoryName);
            System.debug('\n\n AFTER UPDATE Forecast NEW ' + opp.ForecastCategoryName);
        }
        
        // R-25901 - Notify project team if Opportunity is linked to a project
        List<Id> recordIds = new List<Id>();
        for(Opportunity o : newOppList){
            System.debug('KOSHAY: Project value: ' + o.Name + ' - ' + o.opportunity_project_ge_og__c);
            // Opportunity has a value for Project lookup
            if(o.opportunity_project_ge_og__c != null){
                // Old version of record also has a value for project
                if(oldOppMap.get(o.Id).opportunity_project_ge_og__c != null)
                {
                    // Updated on 1/18/2017 R-26630 - Notify project owner & Deal team if Opportunity is linked to a project
                    // If the updated record value for Project is different than the Old version of the record, then add it to the list
                    if(o.opportunity_project_ge_og__c != oldOppMap.get(o.Id).opportunity_project_ge_og__c)
                        recordIds.add(o.id);
                }
                // old record had no project field value, but new record does have a value, so add it to the list
                else
                    recordIds.add(o.id);
                
            }
        }
        if(recordIds.size() > 0)
            AddOpportunityToProject_GE_OG.emailProjectTeamofAddedOpportunities(recordIds);
        // end R-25901
        
        // Added by Kiru for R-26476
        OpportunityMultiTier_GE_OG multitier = new OpportunityMultiTier_GE_OG();
        multitier.updateMultiTier(newOppList,oldOppMap);
        
        //End of R-26476
        
        
        // R-R-28937
        List<Id> records = new List<Id>();
        
        for(Opportunity o : newOppList){
            System.debug(o.Name + ' - ' + o.amount_ge_og__c+'  --Amount sTD='+o.amount+' -- ' +oldOppMap.get(o.Id).amount_ge_og__c);
            // Opportunity has a value for Amount
            if(o.amount_ge_og__c != null||o.amount !=null){
                // Old version of record also has a value for Amount
                if(oldOppMap.get(o.Id).amount_ge_og__c != null||oldOppMap.get(o.Id).amount != null)
                {
                    // If the updated Amount value is different than the Old Amount, then add it to the list
                    if(o.amount_ge_og__c != oldOppMap.get(o.Id).amount_ge_og__c || o.amount != oldOppMap.get(o.Id).amount )
                    {
                        records.add(o.id);
                        system.debug('AKP'+records.size());
                    }
                    
                }
                // old record had no Amount but new record does have amount, so add it to the list
                else
                    records.add(o.id);
                system.debug('AKP1'+records.size());
                
                
            }
        }
        
        if(records.size() > 0){
            system.debug('AKP2'+records.size());
            
            PostChatteronAccount.PostChatter(records);
            // end R-28937     
        }
        
        
    }
    
    
    //Method for eRad record Creation,added by Shanu Aggarwal,R-23908 on after update
    public void afterupdateeradCreation(List<opportunity> opplist,Map<id,opportunity> oppMap,Map<id,opportunity> oppoldMap){
        GE_OG_eRad_Creation eradcreate = new GE_OG_eRad_Creation();
        eradcreate.onupdateradrecordcreation(opplist,oppMap,oppoldmap);
    }
    
    //Method for update OLI Delivery Date, R-23941 on after update
    public void afterUpdataeDeliveryDateOnOLI(List<opportunity> opplist,Map<id,opportunity> oppoldmap){
        UpdateDeliveryDateOnOLI_GE_OG updateOLIdelivery = new UpdateDeliveryDateOnOLI_GE_OG();
        updateOLIdelivery.updateDeliveryDateOnOLI(opplist,oppoldmap); 
    }
    
    public void oppAmountSummationForAsset(List<Opportunity> newOpp,List<Opportunity> oldOpp, Map<ID,Opportunity> oppMap){
        oppAmountSummation_Asset_Project asts = new oppAmountSummation_Asset_Project();
        asts.amountSummationForAsset(newOpp,oldOpp,oppMap);
    }
    
    public void oppAmountSummationForProject(List<Opportunity> newOpp,List<Opportunity> oldOpp, Map<ID,Opportunity> oppMap){
        oppAmountSummation_Asset_Project pr = new oppAmountSummation_Asset_Project();
        pr.amountSummationForProject(newOpp,oldOpp,oppMap);
    }
}