/*
Type Name [Class/Trigger/Page Name] : Apex Trigger
Used Where ?                        : To assign P&L Channel Leader and Regional Commercial Manager
Purpose/Overview                    : This trigger is used to pre-populate the P&L Channel Leader field of contract on contract creation and updation
Functional Area                     : PRM
Author                              : Elavarasan Nagarathinam
Created Date                        : 24 June 2011
Test Class Name                     : 

Change History -
Date Modified   : Developer Name    : Method/Section Modified/Added     : Purpose/Overview of Change
03/27/2013      : Prasad Yadala     :                                   : Modified for the requirement RPW-0419.
11/26/2014      : Pradeep Rao Yadagiri                                  : Added record type condition to prevent this trigger execution for channel Master and Channel Addedum record types  

*/


trigger GE_PRM_Populate_PnL_Channel_Leader on Contract (before insert, before update){
    
    //Variable declarations
    
    String contractRecordTypeMasterId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Channel Master Agreement').getRecordTypeId();
    String contractRecordTypeAddedumId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Channel Addendum Agreement').getRecordTypeId();
            
    Set<String> strFinalKey = new Set<String>();
    Set<Id> contIds = new Set<Id>();
    Set<Id> rfaIds = new Set<Id>();
    String FinalTier = 'Energy Management (EM) - Digital Energy (DE) - Power Equipment - T4 -T5 - T6 - Compliance Manager - ';
    
    Boolean isApproved;
    Integer QLmt = Limits.getLimitQueryRows();
        
    List<GE_PRM_Recommendation_Approvers__c> recommendationApproversList = new List<GE_PRM_Recommendation_Approvers__c>();
    Map<String, Id> recommendationApproversMap = new Map<String, Id>();
   // List<GE_PRM_Recommendation__c> recommList = new List<GE_PRM_Recommendation__c>();
   // List<GE_PRM_Appointment__c> afaList = new List<GE_PRM_Appointment__c>();
    
    
//    List<Contract> contObjlist = new List<Contract>();

    //The below block will execute only on before event
    //Before Event --- Start
    
    if(Trigger.isBefore){
        
        //Take the PnL values of contract records into a set
        for(Contract contractObject: Trigger.New){
           if(contractObject.RecordTypeId != contractRecordTypeMasterId && contractObject.RecordTypeId != contractRecordTypeAddedumId){    
           if(contractObject.GE_PRM_Tier_3__c != null && contractObject.GE_PRM_Tier_3__c != '' && contractObject.GE_PRM_Region__c !=null && contractObject.GE_PRM_Region__c != ''){
                if(contractObject.GE_PRM_PnL_Channel_Leader__c == null)
                strFinalKey.add(contractObject.GE_PRM_Business_Tier_1__c+ ' - '+contractObject.GE_PRM_Tier_2__c+ ' - '+contractObject.GE_PRM_Tier_3__c+  ' - '+ 'T4' + ' -'+ 'T5' + ' - '+'T6' + ' - '+'Channel Leader 1' + ' - ' +contractObject.GE_PRM_Region__c);            
                system.debug(contractObject.GE_PRM_Business_Tier_1__c+ ' - '+contractObject.GE_PRM_Tier_2__c+ ' - '+contractObject.GE_PRM_Tier_3__c+  ' - '+ 'T4' + ' -'+ 'T5' + ' - '+'T6' + ' - '+'Channel Leader 1' + ' - ' +contractObject.GE_PRM_Region__c);
                if(contractObject.GE_PRM_Regional_Compliance_Manager__c == null)
                strFinalKey.add(contractObject.GE_PRM_Business_Tier_1__c+ ' - '+contractObject.GE_PRM_Tier_2__c+ ' - '+contractObject.GE_PRM_Tier_3__c+  ' - '+ 'T4' + ' -'+ 'T5' + ' - '+'T6' + ' - '+'Compliance Manager' + ' - ' +contractObject.GE_PRM_Region__c);            
                system.debug(contractObject.GE_PRM_Business_Tier_1__c+ ' - '+contractObject.GE_PRM_Tier_2__c+ ' - '+contractObject.GE_PRM_Tier_3__c+  ' - '+ 'T4' + ' -'+ 'T5' + ' - '+'T6' + ' - '+'Compliance Manager' + ' - ' +contractObject.GE_PRM_Region__c);
                }
           if(contractObject.GE_PRM_Tier_4__c != null && contractObject.GE_PRM_Tier_4__c != '' && contractObject.GE_ES_Account_Country__c != null && contractObject.GE_ES_Account_Country__c != '' && contractObject.GE_ES_Account_Country__c == 'UNITED STATES'){
               if(contractObject.GE_PRM_PnL_Channel_Leader__c == null)
               strFinalKey.add(contractObject.GE_PRM_Business_Tier_1__c+ ' - '+contractObject.GE_PRM_Tier_2__c+ ' - '+contractObject.GE_PRM_Tier_3__c+  ' - '+ contractObject.GE_PRM_Tier_4__c + ' - '+ 'T5' + ' - '+'T6' + ' - '+'Channel Leader 1' + ' - ' +contractObject.GE_ES_Account_Country__c.toUpperCase()+contractObject.GE_PRM_Region__c);
               if(contractObject.GE_PRM_Regional_Compliance_Manager__c == null)
               strFinalKey.add(contractObject.GE_PRM_Business_Tier_1__c+ ' - '+contractObject.GE_PRM_Tier_2__c+ ' - '+contractObject.GE_PRM_Tier_3__c+  ' - '+ contractObject.GE_PRM_Tier_4__c + ' - '+ 'T5' + ' - '+'T6' + ' - '+'Compliance Manager' + ' - ' +contractObject.GE_ES_Account_Country__c.toUpperCase()+contractObject.GE_PRM_Region__c);
               system.debug(contractObject.GE_PRM_Business_Tier_1__c+ ' - '+contractObject.GE_PRM_Tier_2__c+ ' - '+contractObject.GE_PRM_Tier_3__c+  ' - '+ contractObject.GE_PRM_Tier_4__c + ' - '+ 'T5' + ' - '+'T6' + ' - '+'Channel Leader 1' + ' - ' +contractObject.GE_ES_Account_Country__c.toUpperCase()+contractObject.GE_PRM_Region__c);
               }
           if(contractObject.GE_PRM_Tier_4__c != null && contractObject.GE_PRM_Tier_4__c != '' && contractObject.GE_ES_Account_Country__c != null && contractObject.GE_ES_Account_Country__c != '' && contractObject.GE_ES_Account_Country__c != 'UNITED STATES'){
               if(contractObject.GE_PRM_PnL_Channel_Leader__c == null)
               strFinalKey.add(contractObject.GE_PRM_Business_Tier_1__c+ ' - '+contractObject.GE_PRM_Tier_2__c+ ' - '+contractObject.GE_PRM_Tier_3__c+  ' - '+ contractObject.GE_PRM_Tier_4__c + ' - '+ 'T5' + ' - '+'T6' + ' - '+'Channel Leader 1' + ' - ' +contractObject.GE_ES_Account_Country__c.toUpperCase());
               if(contractObject.GE_PRM_Regional_Compliance_Manager__c == null)         
               strFinalKey.add(contractObject.GE_PRM_Business_Tier_1__c+ ' - '+contractObject.GE_PRM_Tier_2__c+ ' - '+contractObject.GE_PRM_Tier_3__c+  ' - '+ contractObject.GE_PRM_Tier_4__c + ' - '+ 'T5' + ' - '+'T6' + ' - '+'Compliance Manager' + ' - ' +contractObject.GE_ES_Account_Country__c.toUpperCase());
               system.debug(contractObject.GE_PRM_Business_Tier_1__c+ ' - '+contractObject.GE_PRM_Tier_2__c+ ' - '+contractObject.GE_PRM_Tier_3__c+  ' - '+ contractObject.GE_PRM_Tier_4__c + ' - '+ 'T5' + ' - '+'T6' + ' - '+'Channel Leader 1' + ' - ' +contractObject.GE_ES_Account_Country__c.toUpperCase());
               }
               }
            
            }  
            
            
            //Code added by Arpita for Req R-12249 - Starts
            // Start Code commented by Avinash R-22629
            /*
            for(Contract contractObj: Trigger.New){ 
             if(contractObj.RecordTypeId != contractRecordTypeMasterId && contractObj.RecordTypeId != contractRecordTypeAddedumId){    
            //if(contractObj.GE_PRM_Recommendation_Link__r.GE_PRM_RFA_Type__c == 'Express' || contractObj.GE_PRM_Recommendation_Link__r.GE_PRM_RFA_Type__c == 'Fast Track'){           
                contIds.add(contractObj.Id);
                rfaIds.add(contractObj.GE_PRM_Recommendation_Link__c);
                isApproved = false;
              //  }
              }  
            }
            
            system.debug('**contIds size***'+contIds.size());
            system.debug('**rfaIds size***'+rfaIds.size());

            Set<id> afaIds = new Set<id>();
            if(rfaIds.size() >0)
                recommList = [Select id,GE_PRM_Appointment_Number__c from GE_PRM_Recommendation__c where id IN: rfaIds and (GE_PRM_Appointment_Number__c != null or GE_PRM_Agreement_Type__c = 'Non-Renewal' or GE_PRM_Agreement_Type__c = 'Termination')];
            system.debug('**rfaIds size()***'+rfaIds.size());
            
            Map<Id,Boolean> AfaMap = new Map<Id,Boolean>();
            for(GE_PRM_Recommendation__c r: recommList)
            AfaMap.put(r.id,true);
            
                
            if(rfaIds.size() >0)
                afaList = [Select id, GE_PRM_Status__c,GE_PRM_Recommendation__c from GE_PRM_Appointment__c where GE_PRM_Recommendation__c IN:rfaIds ];
            system.debug('**afaList size()***'+afaList.size());
            
            if(afaList.size() >0){
                for(integer i=0; i<afaList.size(); i++){
                    if(afaList.get(i).GE_PRM_Status__c == 'Approved' || afaList.get(i).GE_PRM_Status__c == 'Archived')
                        AfaMap.put(afaList.get(i).GE_PRM_Recommendation__c,true);                                                
                    }
                }
            system.debug('**isApproved**'+isApproved);
            for(Contract contractObj: Trigger.New){
                 if(contractObj.RecordTypeId != contractRecordTypeMasterId && contractObj.RecordTypeId != contractRecordTypeAddedumId){    
           
                if(!AfaMap.containskey(contractObj.GE_PRM_Recommendation_Link__c) )
                {                
                        contractObj.addError('Recommendation should have atleast one approved appointment');                
                }
              }
             }*/
             // END code Commented by Avinash R-22629
            //Code added by Arpita for Req R-12249 - Starts    
        }
        
        
        //Query the recommendation approver object to get all regions and their regional compliance manager based on the contracts country/region
        if(strFinalKey.size() > 0){
            recommendationApproversList = [select GE_PRM_Approver_Name__c, GE_PRM_P_L__c, GE_PRM_Region__c, GE_PRM_Role__c,GE_PRM_Tier_4__c,GE_PRM_Country__c from GE_PRM_Recommendation_Approvers__c where GE_PRM_FINAL_TIER_SELECTIONS__C in :strFinalKey limit :QLmt];
        }
        
            
        //Prepare map with PnL as the key and approver name as the value
        if(recommendationApproversList.size() > 0){
            for(Integer i=0; i<recommendationApproversList.size();i++){
                if(recommendationApproversList.get(i).GE_PRM_Tier_4__c == null)
                recommendationApproversMap.put(recommendationApproversList.get(i).GE_PRM_P_L__c+recommendationApproversList.get(i).GE_PRM_Region__c+recommendationApproversList.get(i).GE_PRM_Role__c, recommendationApproversList.get(i).GE_PRM_Approver_Name__c);
                if(recommendationApproversList.get(i).GE_PRM_Tier_4__c != null && recommendationApproversList.get(i).GE_PRM_Country__c != 'United States')
                recommendationApproversMap.put(recommendationApproversList.get(i).GE_PRM_P_L__c+recommendationApproversList.get(i).GE_PRM_Country__c+recommendationApproversList.get(i).GE_PRM_Role__c, recommendationApproversList.get(i).GE_PRM_Approver_Name__c);
                if(recommendationApproversList.get(i).GE_PRM_Tier_4__c != null && recommendationApproversList.get(i).GE_PRM_Country__c == 'United States')
                recommendationApproversMap.put(recommendationApproversList.get(i).GE_PRM_P_L__c+recommendationApproversList.get(i).GE_PRM_Country__c+recommendationApproversList.get(i).GE_PRM_Region__c+recommendationApproversList.get(i).GE_PRM_Role__c, recommendationApproversList.get(i).GE_PRM_Approver_Name__c);
            }
        }
        
         if(!recommendationApproversMap.isEmpty())   
        //Populate the P&L Channel Leader field
        for(Contract contractObject : Trigger.New){
            if(contractObject.RecordTypeId != contractRecordTypeMasterId && contractObject.RecordTypeId != contractRecordTypeAddedumId){    
            if(contractObject.GE_PRM_Tier_3__c != null && contractObject.GE_PRM_Tier_3__c != '' && (recommendationApproversMap.containskey(contractObject.GE_PRM_Tier_3__c+contractObject.GE_PRM_Region__c+'Channel Leader 1'))){
                contractObject.GE_PRM_PnL_Channel_Leader__c = recommendationApproversMap.get(contractObject.GE_PRM_Tier_3__c+contractObject.GE_PRM_Region__c+'Channel Leader 1');
            }
             system.debug(contractObject.GE_PRM_Tier_4__c+contractObject.GE_ES_Account_Country__c.toUpperCase()+'Channel Leader 1');   
            if(contractObject.GE_PRM_Tier_4__c != null && contractObject.GE_PRM_Tier_4__c != '' && contractObject.GE_ES_Account_Country__c != 'United States' && recommendationApproversMap.containskey(contractObject.GE_PRM_Tier_4__c+contractObject.GE_ES_Account_Country__c.toUpperCase()+'Channel Leader 1')){
                contractObject.GE_PRM_PnL_Channel_Leader__c = recommendationApproversMap.get(contractObject.GE_PRM_Tier_4__c+contractObject.GE_ES_Account_Country__c.toUpperCase()+'Channel Leader 1');
            }
            
            if(contractObject.GE_PRM_Tier_4__c != null && contractObject.GE_PRM_Tier_4__c != '' && contractObject.GE_ES_Account_Country__c == 'United States' && recommendationApproversMap.containskey(contractObject.GE_PRM_Tier_4__c+contractObject.GE_ES_Account_Country__c.toUpperCase()+contractObject.GE_PRM_Region__c+'Channel Leader 1')){
                contractObject.GE_PRM_PnL_Channel_Leader__c = recommendationApproversMap.get(contractObject.GE_PRM_Tier_4__c+contractObject.GE_ES_Account_Country__c.toUpperCase()+contractObject.GE_PRM_Region__c+'Channel Leader 1');
            }
            //Populate Regional Compliance Manager field
            if(contractObject.GE_PRM_Tier_3__c != null && contractObject.GE_PRM_Tier_3__c != '' && (recommendationApproversMap.containskey(contractObject.GE_PRM_Tier_3__c+contractObject.GE_PRM_Region__c+'Compliance Manager'))){
                contractObject.GE_PRM_Regional_Compliance_Manager__c = recommendationApproversMap.get(contractObject.GE_PRM_Tier_3__c+contractObject.GE_PRM_Region__c+'Compliance Manager');
            }
            if(contractObject.GE_PRM_Tier_4__c != null && contractObject.GE_PRM_Tier_4__c != '' && contractObject.GE_ES_Account_Country__c != 'United States' && recommendationApproversMap.containskey(contractObject.GE_PRM_Tier_4__c+contractObject.GE_ES_Account_Country__c.toUpperCase()+'Compliance Manager')){
                contractObject.GE_PRM_Regional_Compliance_Manager__c = recommendationApproversMap.get(contractObject.GE_PRM_Tier_4__c+contractObject.GE_ES_Account_Country__c.toUpperCase()+'Compliance Manager');
            }
            
            if(contractObject.GE_PRM_Tier_4__c != null && contractObject.GE_PRM_Tier_4__c != '' && contractObject.GE_ES_Account_Country__c == 'United States' && recommendationApproversMap.containskey(contractObject.GE_PRM_Tier_4__c+contractObject.GE_ES_Account_Country__c.toUpperCase()+contractObject.GE_PRM_Region__c+'Compliance Manager')){
                contractObject.GE_PRM_Regional_Compliance_Manager__c = recommendationApproversMap.get(contractObject.GE_PRM_Tier_4__c+contractObject.GE_ES_Account_Country__c.toUpperCase()+contractObject.GE_PRM_Region__c+'Compliance Manager');
            }
            }
        
        }
        
        
        
    }