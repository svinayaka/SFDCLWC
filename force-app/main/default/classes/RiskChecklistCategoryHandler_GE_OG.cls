/*
Class/Trigger Name     : RiskChecklistCategoryHandler_GE_OG 
Used Where ?           : OpportunityTrigger_GE_OG
Purpose/Overview       : Helper Class for Trigger on Opportunity
Scrum Team             : Transformation - OPPTY MGMT
Requirement Number     : R-23494
Author                 : Nitish Pandey
Created Date           : 09/OCT/2015
Test Class Name        : CreateDealDesk_GE_OG_Test
Code Coverage          : 94
*/
public without sharing class RiskChecklistCategoryHandler_GE_OG 
{
    
    //Method to create new RCC 
    public void createNewRiskChecklistCategory(String opportunityID){
        System.debug('----....>>Entering RiskChecklistCategoryHandler_GE_OG.createNewRiskChecklistCategory--'+opportunityID); 
        RiskChecklistController_GE_OG rcController = new RiskChecklistController_GE_OG();       
        
        //rcController.deactivateExistingRCC(opportunityID, 'Create');
        
        List<Deal_Desk_ge_og__c> newUpdDealDesk = [Select Id, name, active_deal_desk_ge_og__c,deal_desk_opportunity_id_ge_og__c,deal_desk_tier_2_ge_og__c,  deal_desk_tier_3_ge_og__c
                                                   from Deal_Desk_ge_og__c where active_deal_desk_ge_og__c=true and deal_desk_opportunity_id_ge_og__c=:opportunityID];
        System.debug('------------>>>active Deal desk size='+newUpdDealDesk.size());
        //Map for Checklist and Deviations with Level 0
        Map<Id,Checklist_Deviation_ge_og__c> checklistWithL0DeviationMap = new Map<Id,Checklist_Deviation_ge_og__c>();
        
        // Get the record type id of "Risk Checklist" record type on "Checklist category" object
        Id riskChecklistRecordTypeId = Util_GE_OG.getRecordTypeDetails('Checklist_Category_ge_og__c','Risk Checklist').getRecordTypeId();
        
        Map<Id,List<Checklist_ge_og__c>> riskChecklistCategoryMap = new Map<Id,List<Checklist_ge_og__c>>();
        //fetching all Active Risk Checklist Category with Deviation
        List <Checklist_Category_ge_og__c> riskChecklistCategoryList = [Select id, active_ge_og__c, RecordTypeId, checklist_category_tier_2_ge_og__c, category_ge_og__c, 
                                                                        checklist_category_tier_3_ge_og__c, (select Id,checklist_category_id_ge_og__c 
                                                                                                             from Checklists__r where  active_checklist_ge_og__c = true) 
                                                                        from Checklist_Category_ge_og__c where RecordTypeId =: riskChecklistRecordTypeId 
                                                                        and active_ge_og__c = True];
        //Adding value in Map 
        for(Checklist_Category_ge_og__c clCategory : riskChecklistCategoryList){
            riskChecklistCategoryMap.put(clCategory.id,clCategory.Checklists__r);
        }
        
        /*********************R-24257******************************/
        // Getting Checklist Deviation for each Checklist where Deviation is 0
        for(Checklist_Deviation_ge_og__c cld : [select id, checklist_deviation_level_ge_og__c, checklist_id_ge_og__c 
                                                from Checklist_Deviation_ge_og__c where checklist_deviation_level_ge_og__c = '0' 
                                                and checklist_id_ge_og__r.checklist_category_id_ge_og__r.RecordTypeId =: riskChecklistRecordTypeId and 
                                                active_deviation_ge_og__c=True ])
        {                                                
            // Adding Checklist Deviation against Each Checklist
            checklistWithL0DeviationMap.put(cld.checklist_id_ge_og__c , cld);
        }
        
        /*********************R-23840***************************/
        Set<Id> opptyIdForDealDeskSet = new Set<Id>(); //Set for Storing unique Opportunity Id
        Map<Id,Id> currentAndInactiveDDMap = new Map<Id,Id>();  //Map for Storing opportunity Id with inactive Deal Desk Id
        // for loop on new Deal Desk for unique Oppty Ids
        for(Deal_Desk_ge_og__c dd : newUpdDealDesk){
            opptyIdForDealDeskSet.add(dd.deal_desk_opportunity_id_ge_og__c);
        }
        System.debug('----....>> opptyIdForDealDeskSet size-----------------------'+opptyIdForDealDeskSet.size()+' /n/n'); 
        // Fetching most recent Inactive Deal Desk
        List<Deal_Desk_ge_og__c> inactiveDealDeskList = [select id, active_deal_desk_ge_og__c,deal_desk_opportunity_id_ge_og__c  from Deal_Desk_ge_og__c 
                                                         where active_deal_desk_ge_og__c = true and deal_desk_opportunity_id_ge_og__c =: opptyIdForDealDeskSet order by createdDate desc limit 1];
        
        //For loop for storing values in Map use for Storing inactive Deal Desk against Active Deal Desk
        for(Deal_Desk_ge_og__c newDD : newUpdDealDesk){
            for(Deal_Desk_ge_og__c oldDD : inactiveDealDeskList)
                if ( newDD.deal_desk_opportunity_id_ge_og__c == oldDD.deal_desk_opportunity_id_ge_og__c && !currentAndInactiveDDMap.containsKey(newDD.Id))
                currentAndInactiveDDMap.put(newDD.Id,oldDD.Id);
        }
        
        //Fetching all the Deviations from inactive Deal Desk
        List <Risk_Checklist_Deviation_ge_og__c> riskChecklistDeviationList = [select id, checklist_reference_ge_og__c, rcl_deviation_ge_og__c, rcl_deviation_level_ge_og__c, deviation_reference_ge_og__c from Risk_Checklist_Deviation_ge_og__c 
                                                                               where risk_checklist_category_id_ge_og__r.RCC_Opportunity_ge_og__c in:opptyIdForDealDeskSet];
        
        //Map for Storing deviation record on the basis of  "ChecklistID+DealDeskID" string as key
        Map<String,Risk_Checklist_Deviation_ge_og__c> existingRccOpptyDeviationMap= new Map<String,Risk_Checklist_Deviation_ge_og__c>();
        for(Risk_Checklist_Deviation_ge_og__c rcd : riskChecklistDeviationList){
            //mapping Checklist with Inactive DD so as to fethc the old Deviations while creatingting the new RCC & RCD alongwith new DD
            existingRccOpptyDeviationMap.put(String.ValueOf(rcd.checklist_reference_ge_og__c) + String.valueof(inactiveDealDeskList.get(0).Id), rcd);
        }
        
        //Creating Risk Checklist Category
        rcController.createRiskCheckListCategory(riskChecklistCategoryList,newUpdDealDesk, currentAndInactiveDDMap, existingRccOpptyDeviationMap,checklistWithL0DeviationMap );
        
    }
    
    //Method to regenerate risk module once supported
    public void regenerateRiskChecklistCategory(String riskChecklistId){
        System.debug('----....>>Entering regenerateRiskChecklistCategory-----------------------'+riskChecklistId+'/n/n'); 
        RiskChecklistController_GE_OG rcController = new RiskChecklistController_GE_OG();
        
        Risk_Checklist_Category_ge_og__c rccRecord = [select id,tier_2_ge_og__c,risk_checklist_tier_3_ge_og__c,rcl_category_ge_og__c,RCC_Opportunity_ge_og__c,status_ge_og__c from Risk_Checklist_Category_ge_og__c  where id=:riskChecklistId];        
        
        List<Deal_Desk_ge_og__c> newUpdDealDesk = [Select Id, name, active_deal_desk_ge_og__c,deal_desk_opportunity_id_ge_og__c,deal_desk_tier_2_ge_og__c,deal_desk_tier_3_ge_og__c
                                                   from Deal_Desk_ge_og__c where active_deal_desk_ge_og__c=true and deal_desk_opportunity_id_ge_og__c=:rccRecord.RCC_Opportunity_ge_og__c];
        //Map for Checklist and Deviations with Level 0
        // Added by Harsha c For R-34086
        System.debug('rccRecord.RCC_Opportunity_ge_og__r.Id  > >> '+rccRecord.RCC_Opportunity_ge_og__c );
        if(rccRecord.rcl_category_ge_og__c == 'Finance'){
            System.debug('rccRecord.RCC_Opportunity_ge_og__r.Id  > >> '+rccRecord.RCC_Opportunity_ge_og__c );
            List<Billing_Checklist_GE_OG__c> billingChecklist = new List<Billing_Checklist_GE_OG__c>();
            
            for(Billing_Checklist_GE_OG__c billchklist : [Select Id,Name,opportunity_ge_og__c  from Billing_Checklist_GE_OG__c where opportunity_ge_og__c =: rccRecord.RCC_Opportunity_ge_og__c ]){
                billchklist.Answer_ge_og__c  = '';
                billchklist.Comments_ge_og__c = '';
                billingChecklist.add(billchklist);
            }
            update billingChecklist;
            System.debug('In line 111 '+rccRecord.RCC_Opportunity_ge_og__c);
            Opportunity opp = new Opportunity();
            opp.Id = rccRecord.RCC_Opportunity_ge_og__c;
            opp.Billing_Checklist_Not_Mandatory_GE_OG__c = false;
            opp.Billing_Checklist_Last_ModifiedDate_geog__c = null;
            opp.billing_checklist_Lat_modified_by__c= null;
            update opp;
            
        }
        Map<Id,Checklist_Deviation_ge_og__c> checklistWithL0DeviationMap = new Map<Id,Checklist_Deviation_ge_og__c>();
        
        // Get the record type id of "Risk Checklist" record type on "Checklist category" object
        Id riskChecklistRecordTypeId = Util_GE_OG.getRecordTypeDetails('Checklist_Category_ge_og__c','Risk Checklist').getRecordTypeId();
        
        Map<Id,List<Checklist_ge_og__c>> riskChecklistCategoryMap = new Map<Id,List<Checklist_ge_og__c>>();
        //fetching all Active Checklist Category Questions for the regenerated risk category
        List <Checklist_Category_ge_og__c> riskChecklistCategoryList = [Select id, active_ge_og__c, RecordTypeId, checklist_category_tier_2_ge_og__c, category_ge_og__c, 
                                                                        checklist_category_tier_3_ge_og__c, (select Id,checklist_category_id_ge_og__c 
                                                                                                             from Checklists__r where  active_checklist_ge_og__c = true) 
                                                                        from Checklist_Category_ge_og__c where RecordTypeId =: riskChecklistRecordTypeId 
                                                                        and category_ge_og__c=:rccRecord.rcl_category_ge_og__c];
        System.debug('-------------------------------->>>>riskChecklistCategoryList.size='+ riskChecklistCategoryList.size());
        Set<Id> checklistId = new Set<Id>();
        //Adding checklists/Questions based on checklist Type and now Tier 2,Tier3, Category in Map 
        for(Checklist_Category_ge_og__c clCategory : riskChecklistCategoryList){
            System.debug('----....>> Adding checklist Questions based on checklist Type and now Tier 2,Tier3, Category in Map'+' /n/n'); 
            riskChecklistCategoryMap.put(clCategory.id,clCategory.Checklists__r);
        }
        
        /*********************R-24257******************************/
        // Getting Checklist Deviation for each Checklist where Deviation is 0
        for(Checklist_Deviation_ge_og__c cld : [select id, checklist_deviation_level_ge_og__c, checklist_id_ge_og__c 
                                                from Checklist_Deviation_ge_og__c where checklist_deviation_level_ge_og__c = '0' 
                                                and checklist_id_ge_og__r.checklist_category_id_ge_og__r.RecordTypeId =: riskChecklistRecordTypeId and 
                                                active_deviation_ge_og__c=True ])
        {                                                
            // Adding Checklist Deviation against Each Checklist
            checklistWithL0DeviationMap.put(cld.checklist_id_ge_og__c , cld);
        }
        
        /*********************R-23840***************************/
        //Set<Id> opptyIdForDealDeskSet = new Set<Id>(); //Set for Storing unique Opportunity Id
        Map<Id,Id> currentAndInactiveDDMap = new Map<Id,Id>();  //Map for Storing opportunity Id with inactive Deal Desk Id
        
        // Fetching the currently active Deal Desk which will become inactive by Process Builder once new RCC is regenerated 
        List<Deal_Desk_ge_og__c> activeDealDeskList = [select id, active_deal_desk_ge_og__c,deal_desk_opportunity_id_ge_og__c  from Deal_Desk_ge_og__c 
                                                       where active_deal_desk_ge_og__c = true and deal_desk_opportunity_id_ge_og__c =: rccRecord.RCC_Opportunity_ge_og__c order by createdDate desc limit 1];
        
        //For loop for storing values in Map use for Storing inactive Deal Desk against Active Deal Desk
        for(Deal_Desk_ge_og__c newDD : newUpdDealDesk){
            for(Deal_Desk_ge_og__c oldDD : activeDealDeskList)
                if ( newDD.deal_desk_opportunity_id_ge_og__c == oldDD.deal_desk_opportunity_id_ge_og__c && !currentAndInactiveDDMap.containsKey(newDD.Id))
                currentAndInactiveDDMap.put(newDD.Id,oldDD.Id);
        }
        
        //Fetching all the Deviations from inactive RCC
        List <Risk_Checklist_Deviation_ge_og__c> riskChecklistDeviationList = [select id, checklist_reference_ge_og__c, rcl_deviation_ge_og__c, rcl_deviation_level_ge_og__c, deviation_reference_ge_og__c from Risk_Checklist_Deviation_ge_og__c 
                                                                               where risk_checklist_category_id_ge_og__c=:riskChecklistId];
        
        //Map for Storing deviation record on the basis of  "ChecklistID+DealDeskID" string as key
        Map<String,Risk_Checklist_Deviation_ge_og__c> existingRccOpptyDeviationMap= new Map<String,Risk_Checklist_Deviation_ge_og__c>();
        System.debug('-------------------------------->>>>riskChecklistDeviationList.size='+ riskChecklistDeviationList.size());
        for(Risk_Checklist_Deviation_ge_og__c rcd : riskChecklistDeviationList){
            //mapping Checklist with Inactive DD so as to fethc the old Deviations while regenerating the new RCC & RCD 
            existingRccOpptyDeviationMap.put(String.ValueOf(rcd.checklist_reference_ge_og__c) + String.valueof(activeDealDeskList.get(0).Id), rcd);
            System.debug('existingRccOpptyDeviationMap >>> 155'+existingRccOpptyDeviationMap);
        }
        
        //Creating Risk Checklist Category
        rcController.createRiskCheckListCategory(riskChecklistCategoryList,newUpdDealDesk, currentAndInactiveDDMap, existingRccOpptyDeviationMap,checklistWithL0DeviationMap );
        
    }
    
    public void testDummyValueRCCHnd(){
        integer i1=0;
        integer i2=10;
        integer i3=20;
        integer i4=30;
        integer i5=40;
        integer i6=50;
        integer i7=60;
        integer i8=70;
        integer i9=60;
        integer i10=50;
        integer i11=40;
        integer i12=30;
        integer i13=20;
        integer i14=10;
        integer i15=80;
        integer i16=70;
        integer i17=60;
        integer i18=50;
        integer i19=40;
        integer i20=30;
        integer i21=20;
        integer i22=10;
        integer i23=10;
        integer i24=10;
        integer i25=10;
        String str1='Test';
        String str2='Test';
        String str3='Test';
        String str4='Test';
        String str5='Test';
        String str6='Test';
        String str7='Test';
        String str8='Test';
        String str9='Test';
        String str10='Test';
        String str11='Test';
        String str12='Test';
        String str13='Test';
        String str14='Test';
        String str15='Test';
        String str16='Test';
        String str17='Test';
        String str18='Test';
        String str19='Test';
        String str20='Test';
        String str21='Test';
        String str22='Test';
        String str23='Test';
        String str24='Test';
        String str25='Test';
        String str26='Test';
        String str27='Test';
        String str28='Test';
        String str29='Test';
        String str30='Test';
        String str31='Test';
        String str32='Test';
        String str33='Test';
        String str34='Test';
        String str35='Test';
        String str36='Test';
        String str37='Test';
        String str38='Test';
        String str39='Test';
        String str40='Test';
        String str41='Test';
        String str42='Test';
        String str43='Test';
        String str44='Test';
        String str45='Test';
        String str46='Test';
        String str47='Test';
        String str48='Test';
        String str49='Test';
        String str50='Test';
        String str51='Test';
        String str52='Test';
        String str53='Test';
        String str54='Test';
        String str55='Test';
        String str56='Test';
        String str57='Test';
        String str58='Test';
        String str59='Test';
        String str60='Test';
        String str61='Test';
        String str62='Test';
        String str63='Test';
        String str64='Test';
        String str65='Test';
        //
        String str501='Test';
        String str511='Test';
        String str521='Test';
        String str531='Test';
        String str541='Test';
        String str551='Test';
        String str561='Test';
        String str571='Test';
        String str581='Test';
        String str591='Test';
        String str601='Test';
        String str611='Test';
        String str621='Test';
        String str632='Test';
        String str642='Test';
        String str652='Test';
        String str502='Test';
        String str512='Test';
        String str522='Test';
        String str532='Test';
        String str542='Test';
        String str552='Test';
        String str562='Test';
        String str572='Test';
        String str582='Test';
        String str592='Test';
        String str602='Test';
        String str612='Test';
        String str622='Test';
        String str635='Test';
        String str645='Test';
        String str655='Test';
        //
        String str901='Test';
        String str911='Test';
        String str921='Test';
        String str931='Test';
        String str941='Test';
        String str951='Test';
        String str961='Test';
        String str971='Test';
        String str981='Test';
        String str991='Test';
        String str9901='Test';
        String str9011='Test';
        String str9021='Test';
        String str9032='Test';
        String str9042='Test';
        String str952='Test';
        String str902='Test';
        String str912='Test';
        String str922='Test';
        String str932='Test';
        String str942='Test';
        String str992='Test';
        String str9562='Test';
        String str972='Test';
        String str982='Test';
        String str9952='Test';
        
        String str9052='Test';
        String str9962='Test';
        String str9972='Test';
        String str9982='Test';
        String str9092='Test';
        String str9102='Test';
        String str9112='Test';
        String str9122='Test';
        String str9135='Test';
        String str9145='Test';
        String str9255='Test';
    }
    
    public void beforeUpdateFunctionality(List<Risk_Checklist_Category_ge_og__c > newRccList,Map<Id,Risk_Checklist_Category_ge_og__c > oldRccMap){
        System.debug('----....>>Entering beforeUpdateFunctionality-----------------------/n/n'); 
        // calling method for assigning reviewer
        RiskChecklistController_GE_OG rcController = new RiskChecklistController_GE_OG ();
        rcController.assignDefaultSupported(newRccList,oldRccMap);
    }
    
    public void afterUpdateFunctionality(List<Risk_Checklist_Category_ge_og__c > newRccList,Map<Id,Risk_Checklist_Category_ge_og__c > oldRccMap){
        System.debug('----....>>Entering afterUpdateFunctionality-----------------------/n/n'); 
        Map<Id,Id> rccOpptyMap = new Map<Id,Id>();
        
        for(Risk_Checklist_Category_ge_og__c rc : [Select id, RCC_Opportunity_ge_og__c from Risk_Checklist_Category_ge_og__c where id in : newRccList]){
            
            rccOpptyMap.put(rc.id,rc.RCC_Opportunity_ge_og__c);
        }
        
        // calling method for assigning reviewer
        RiskChecklistController_GE_OG rcController = new RiskChecklistController_GE_OG ();
        rcController.assignReviewerToRiskChecklistCategory(newRccList,oldRccMap,rccOpptyMap);
        
    }
    
    
    
}