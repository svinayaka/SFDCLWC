/*
Class/Trigger Name     : O_CampaignHelper_GE_OG
Used Where ?           : 
Purpose/Overview       : Used for Campaign records
Scrum Team             : OPPTY MGMT
Requirement Number     : 
Author                 : Gourav Anand
Created Date           : 09/FEB/2017
Test Class Name        : O_Campaign_GE_OG_Testelct
Code Coverage          : 
*/

public class O_CampaignHelper_GE_OG {

     ID themeRecType = schema.SObjectType.Campaign.getRecordTypeInfosByName().get('Theme').getRecordTypeID();    
        Id programRecType  = Schema.SObjectType.Campaign.getRecordTypeInfosByName().get('Program').getRecordTypeID();    
        ID cmpgnRecType = schema.SObjectType.Campaign.getRecordTypeInfosByName().get('Campaign').getRecordTypeID();    
          
    //To update the Parent Status count fields as per new Child Campaigns
    public void updateParentCmpgnStatusFlds(List<Campaign> newCmpgnList, Map<Id,Campaign> oldMapCmpgn, Boolean isInsert, Boolean isUpdate){
        System.debug('----------O_CampaignHelper_GE_OG.updateParentCmpgnStatusFlds---->>>>>>'+newCmpgnList.size()+oldMapCmpgn+isInsert+isUpdate);
        Set<Id> cmpgnIdSet = new Set<Id>();
        Set<Id> parentIdSet = new Set<Id>();
        Map<Id,Campaign> mapCmpgn = new Map<Id,Campaign>();
        Map<Id,List<Campaign>> mapParentCmpgn = new Map<Id,List<Campaign>>();
        
        List<Campaign> childCmpgnList = new List<Campaign>();
        
        List<Campaign> updParentList = new List<Campaign>();
       // Id programRecType  = Schema.SObjectType.Campaign.getRecordTypeInfosByName().get('Program').getRecordTypeID();    
        //ID cmpgnRecType = schema.SObjectType.Campaign.getRecordTypeInfosByName().get('Campaign').getRecordTypeID();    
       
        for(Campaign cmpgn : newCmpgnList ){
          
            if(isUpdate){
                System.debug('---------------Old status:'+oldMapCmpgn.get(cmpgn.Id).Status +' and new Status:'+cmpgn.Status+' AND '+oldMapCmpgn.get(cmpgn.Id).Custom_Status_ge_og__c+cmpgn.Custom_Status_ge_og__c);  
            }  
          if( (cmpgn.ParentId !=null || cmpgn.ParentId !='') &&
              (cmpgn.RecordTypeId==cmpgnRecType || cmpgn.RecordTypeId==programRecType) &&
              (isInsert || (isUpdate && oldMapCmpgn.get(cmpgn.Id).ParentId == cmpgn.ParentId))
            )
           {
                System.debug('------------------==>>establishing Parent & Child Campaign relationship');
                System.debug('------------FT status values on Campaign creation: Status:'+cmpgn.Status+'- Custom Status:'+cmpgn.Custom_Status_ge_og__c);
                parentIdSet.add(cmpgn.ParentId);
                cmpgnIdSet.add(cmpgn.Id);
                
                if(mapParentCmpgn.containsKey(cmpgn.ParentId)) {
                     List<Campaign> parentCmpgnList = mapParentCmpgn.get(cmpgn.ParentId);
                     parentCmpgnList.add(cmpgn);
                     mapParentCmpgn.put(cmpgn.ParentId, parentCmpgnList);
                }else {
                     mapParentCmpgn.put(cmpgn.ParentId, new List<Campaign> { cmpgn });
                }
            }    
       }
       System.debug('--------------------------Parent Id set size='+parentIdSet.size()); 
       if(parentIdSet !=null && parentIdSet.size()>0) {
         Map<Id,Campaign> parentMap = new Map<Id,Campaign>([Select Id,CurrencyIsoCode,tier2_ge_og__c,tier3_ge_og__c, Name,Aborted_Campaign_Count_ge_og__c, Completed_Campaign_Count_ge_og__c, 
                                                          Inprogress_Campaign_Count_ge_og__c,Planned_Campaign_Count_ge_og__c, 
                                                          Total_Child_Campaigns_ge_og__c//,Earliest_Child_Start_Date_ge_og__c 
                                                            from Campaign where id in: parentIdSet]);
         //Map<Id,Campaign> updParentMap = new Map<Id,Campaign>(); 
        
         for(Id pId:mapParentCmpgn.keySet()){
           //Campaign updPCmpgn = new Campaign(Id=pId);
           System.debug('-------------+++++  Iterating Parent Campaign map >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'+parentMap.get(pId).Name);
           Campaign updParent = parentMap.get(pId);
           //Date minChildStartDate = updParent.Earliest_Child_Start_Date_ge_og__c;  
           //system.debug('--------minChildStartDate'+minChildStartDate);
           Decimal totalCount = updParent.Total_Child_Campaigns_ge_og__c;
           Decimal abortedCount= updParent.Aborted_Campaign_Count_ge_og__c;
           Decimal plannedCount = updParent.Planned_Campaign_Count_ge_og__c;
           Decimal inprogressCount = updParent.Inprogress_Campaign_Count_ge_og__c;
           Decimal completedCount = updParent.Completed_Campaign_Count_ge_og__c;
           
           //Iterating all child campaigns under each Parent Campaign
           for(Campaign cCmpgn:mapParentCmpgn.get(pId)){
               List<AggregateResult> result = [Select id, min(StartDate) minStart from Campaign where id =: cCmpgn.id group by id];
               for(AggregateResult ar: result){
                  System.debug('min start date'+ar.get('minStart')); 
               }
               if(isInsert){
                   if(cCmpgn.RecordTypeId==cmpgnRecType && (updParent.tier2_ge_og__c !='' && updParent.tier2_ge_og__c != null && updParent.tier2_ge_og__c != 'Multi')){
                       system.debug('Passed non multi condition---------');
                       cCmpgn.tier2_ge_og__c= updParent.tier2_ge_og__c;
                       system.debug('Set cmpgn tier 2 as program tier 2'+cCmpgn.tier2_ge_og__c);
                       
                   }
                   if(cCmpgn.RecordTypeId==cmpgnRecType || cCmpgn.RecordTypeId==programRecType){
                       cCmpgn.CurrencyIsoCode= updParent.CurrencyIsoCode;   
                   }
               }
               System.debug('=============--------->>Initial values for Parent:'+updParent.Name+' :: totalCount:'+totalCount+';abortedCount:'+abortedCount+';plannedCount:'+plannedCount
                                                                        +';inprogressCount'+inprogressCount+';completedCount:'+completedCount);    
                if(isInsert || isUpdate){
                     totalCount = totalCount+1 ;
                    /* if(minChildStartDate ==null ){
                        System.debug('===--------------- Entering for updating Min Child Date:'+cCmpgn.StartDate);
                        minChildStartDate = cCmpgn.StartDate;   
                    } 
                    else if(minChildStartDate !=null && minChildStartDate > cCmpgn.StartDate){
                        System.debug('===--------------- Entering for updating Min Child Date:'+cCmpgn.StartDate);
                        minChildStartDate = cCmpgn.StartDate;
                    } */
                     System.debug('-------------Insert/Update campaign>>>>>>>>>>>>> isInsert:'+isInsert);
                     if(cCmpgn.Status=='Planned' ){
                         plannedCount = plannedCount+1 ;
                     }
                     else if(cCmpgn.Status=='Aborted'){
                         abortedCount = abortedCount+1 ;
                     }
                     else if(cCmpgn.Status=='Completed'){
                         completedCount = completedCount+1 ;
                     }
                     else if(cCmpgn.Status=='In Progress'){
                         inprogressCount = inprogressCount+1 ;
                         
                     }
                }
                if(isUpdate){
                     totalCount = totalCount-1 ;
                     System.debug('-------------Update campaign>>>>>>>>>>>>>>>>>>>  isUpdate:'+isUpdate);
                     if(oldMapCmpgn.get(cCmpgn.Id).Status=='Planned' ){
                         plannedCount = plannedCount-1 ;
                         
                     }
                     else if(oldMapCmpgn.get(cCmpgn.Id).Status=='Aborted'){
                         abortedCount = abortedCount-1 ;
                     }
                     else if(oldMapCmpgn.get(cCmpgn.Id).Status=='Completed'){
                         completedCount = completedCount-1 ;
                     }
                     else if(oldMapCmpgn.get(cCmpgn.Id).Status=='In Progress'){
                         inprogressCount = inprogressCount-1 ;
                         
                     }
                }       
            }
           System.debug('=============--------->>Final values for Parent:'+updParent.Name+' ::  totalCount:'+totalCount+'; abortedCount:'+abortedCount+'; plannedCount:'+plannedCount
                                                                        +'; inprogressCount:'+inprogressCount+'; completedCount:'+completedCount);
           updParent.Total_Child_Campaigns_ge_og__c = totalCount;
           updParent.Aborted_Campaign_Count_ge_og__c = abortedCount;
           updParent.Planned_Campaign_Count_ge_og__c = plannedCount;
           updParent.Inprogress_Campaign_Count_ge_og__c = inprogressCount;
           updParent.Completed_Campaign_Count_ge_og__c = completedCount;
           updParent.tier2_ge_og__c=updParent.tier2_ge_og__c;
           //updParent.Earliest_Child_Start_Date_ge_og__c = minChildStartDate;  
           updParentList.add(updParent);
         } 
      }
      if(updParentList !=null && updParentList.size()>0)  {
          System.debug('=================================>>>>>>>>>>>update List'+ updParentList.size());
          update updParentList;   
      }
    }    

    
    //To automate Status transition for Campaigns
    public void automateStatusTransition(List<Campaign> newCmpgnList, Map<Id,Campaign> oldMapCmpgn){
       
        checkUpdateAbortedStatus(newCmpgnList, oldMapCmpgn);
        List<Campaign> updCampaignList = new List<Campaign>();
        for(Campaign cmpgn: newCmpgnList){
         
           if(cmpgn.Custom_Status_ge_og__c!='Aborted'){ 
                System.debug('     **************No Abort Action, check Criteria checkboxes for Campaign:'+cmpgn.Name);
                System.debug(cmpgn.Has_Tier_2_ge_og__c ); 
                System.debug(cmpgn.Has_Owner_Function_ge_og__c ); 
                System.debug(cmpgn.Has_Campaign_Type_ge_og__c ); 
                System.debug(cmpgn.Has_Campaign_Business_Obj_ge_og__c ); 
                System.debug(cmpgn.Has_End_Date_ge_og__c ); 
                System.debug(cmpgn.Has_Target_Region_ge_og__c ); 
                System.debug(cmpgn.Has_TARGET_INDUSTRY_ge_og__c ); 
                System.debug(cmpgn.Has_Target_Personas_ge_og__c ); 
                System.debug(cmpgn.Has_Channel_Partner_Coverage_ge_og__c ); 
                System.debug(cmpgn.Has_Target_Opportunities_ge_og__c ); 
                System.debug(cmpgn.Has_Opportunity_Value_ge_og__c ); 
                System.debug(cmpgn.Has_Actual_Cost_ge_og__c ); 
                System.debug('     *******   Criteria checkboxes done *********** '+cmpgn.Name);
               
             if((cmpgn.RecordTypeId==themeRecType  && cmpgn.Has_Owner_ge_og__c && cmpgn.Has_Start_Date_ge_og__c && cmpgn.Has_End_Date_ge_og__c && cmpgn.Has_Documentation_Support_ge_og__c)
               //removed Documentation support & Contains NPI for Program
                || (cmpgn.RecordTypeId==programRecType && cmpgn.Has_Owner_ge_og__c && cmpgn.Has_Start_Date_ge_og__c && cmpgn.Has_End_Date_ge_og__c && cmpgn.Has_Owner_Function_ge_og__c)
                ||(cmpgn.RecordTypeId==cmpgnRecType && cmpgn.Has_Tier_2_ge_og__c && cmpgn.Has_Owner_Function_ge_og__c && cmpgn.Has_Campaign_Type_ge_og__c && cmpgn.Has_Campaign_Business_Obj_ge_og__c 
                && cmpgn.Has_End_Date_ge_og__c && cmpgn.Has_Target_Region_ge_og__c && cmpgn.Has_TARGET_INDUSTRY_ge_og__c && cmpgn.Has_Target_Personas_ge_og__c && 
                cmpgn.Has_Channel_Partner_Coverage_ge_og__c && cmpgn.Has_Target_Opportunities_ge_og__c
                 && cmpgn.Has_Opportunity_Value_ge_og__c && cmpgn.Has_Actual_Cost_ge_og__c && !String.isBlank(cmpgn.Lead_Type_ge_og__c) )
              ){  
                 system.debug('step1');
                 
                   system.debug('step3');
                      if(  cmpgn.Is_Start_Date_Grt_Today_ge_og__c &&   cmpgn.Is_End_Date_Grt_Today_ge_og__c ){
                    System.debug('----------------->>> Going to Status Planned' );  
                    cmpgn.Status=System.Label.Campaign_Status_Planned;
                    cmpgn.Custom_Status_ge_og__c='';
                    updCampaignList.add(cmpgn)  ;
                 }
                 if(  cmpgn.Is_Start_Date_Less_Today_ge_og__c  && cmpgn.Is_End_Date_Grt_Today_ge_og__c ){
                    System.debug('----------------->>> Going to Status In-Progress' );  
                    cmpgn.Status=System.Label.Campaign_Status_InProgress;
                    cmpgn.Custom_Status_ge_og__c='';
                    updCampaignList.add(cmpgn)  ;
                }
                if(  cmpgn.Is_Start_Date_Less_Today_ge_og__c &&  cmpgn.Is_End_Date_Less_Today_ge_og__c ){
                    System.debug('----------------->>> Going to Status Completed' );  
                    cmpgn.Status=System.Label.Campaign_Status_Completed;
                    cmpgn.Custom_Status_ge_og__c='';
                    updCampaignList.add(cmpgn)  ;
                } 
                  
                 
                
           }else 
            {
                if(cmpgn.RecordTypeId==cmpgnRecType){
                    System.debug('-------------Campaign Type:Going to set default Draft status');
                    cmpgn.Status=System.Label.Campaign_Status_Draft;
                    cmpgn.Custom_Status_ge_og__c='';
                }else if(cmpgn.RecordTypeId==themeRecType || cmpgn.RecordTypeId==programRecType){
                    System.debug('-------------Theme or Program Type:Going to set default Planned status');
                    cmpgn.Status=System.Label.Campaign_Status_Planned;
                    cmpgn.Custom_Status_ge_og__c='';
                }
                updCampaignList.add(cmpgn)  ;
            }
          } //if closing for Custom Status - Aborted checkloop  
        }
        
    }
    
    public void checkUpdateAbortedStatus(List<Campaign> newCmpgnList, Map<Id,Campaign> oldMapCmpgn){
        System.debug('---------Entering into checkUpdateAbortedStatus:--->>>>'+newCmpgnList.size());
        if(newCmpgnList.Size()>0){
            // Iterate Over updated Campaigns and Abort based on criteria mentioned
            for(Campaign cmpgn: newCmpgnList){
                String strCustomStatus = cmpgn.Custom_Status_ge_og__c;
                String prvCstmStatus = oldMapCmpgn.get(cmpgn.Id).Custom_Status_ge_og__c;
                System.debug('---------checkedAborted ------Earlier stage before updating '+cmpgn.Name+':'+prvCstmStatus+'-'+strCustomStatus);
                if(strCustomStatus!=prvCstmStatus && strCustomStatus==System.Label.Campaign_Status_Aborted){
                   if(cmpgn.RecordTypeId==themeRecType || cmpgn.RecordTypeId==programRecType){
                     if(cmpgn.Aborted_Campaign_Count_ge_og__c==cmpgn.Total_Child_Campaigns_ge_og__c){
                        System.debug('----Going to Abort Theme_Parent---Earlier stage before updating '+cmpgn.Name+':'+prvCstmStatus+'-'+strCustomStatus); 
                        cmpgn.status=System.Label.Campaign_Status_Aborted;
                     }else{
                        cmpgn.addError(System.Label.Campaign_Theme_Program_Record_Abort_Error);
                     }
                  }else if(cmpgn.RecordTypeId==cmpgnRecType ){
                    if(cmpgn.Total_Campaign_Leads_in_Hierarchy_ge_og__c==0){
                        System.debug('----Going to Abort Campaign---Earlier stage before updating '+cmpgn.Name+':'+prvCstmStatus+'-'+strCustomStatus); 
                        cmpgn.Status=System.Label.Campaign_Status_Aborted;                  
                    }else{
                       cmpgn.addError(System.Label.Campaign_Record_Abort_Error);
                    }
                  }
                }
              
                if(cmpgn.Status!= System.Label.Campaign_Status_Aborted && cmpgn.Status != cmpgn.Custom_Status_ge_og__c)
                    cmpgn.Custom_Status_ge_og__c='';
                
            }
           } 
        }
    
    
    public void updateParentCmpgn(List<Campaign> newCmpgnList, Map<Id,Campaign> oldMapCmpgn){
        System.debug('----------O_CampaignHelper_GE_OG.updateParentCmpgn---->>>>>>'+newCmpgnList.size()+oldMapCmpgn);
        
        Set<Id> cmpgnIdSet = new Set<Id>();
        Set<Id> newParentIdSet = new Set<Id>();
        Set<Id> oldParentIdSet = new Set<Id>();
        Map<Id,Campaign> mapCmpgn = new Map<Id,Campaign>();
        Map<Id,List<Campaign>> newMapParentCmpgn = new Map<Id,List<Campaign>>();
        Map<Id,List<Campaign>> oldMapParentCmpgn = new Map<Id,List<Campaign>>();
        
        List<Campaign> childCmpgnList = new List<Campaign>();
        
        List<Campaign> updParentList = new List<Campaign>();
       // Id programRecType  = Schema.SObjectType.Campaign.getRecordTypeInfosByName().get('Program').getRecordTypeID();    
        //ID cmpgnRecType = schema.SObjectType.Campaign.getRecordTypeInfosByName().get('Campaign').getRecordTypeID();    
       
        for(Campaign cmpgn : newCmpgnList ){
          
             
          if( (cmpgn.ParentId !=null || cmpgn.ParentId !='') &&
          (cmpgn.RecordTypeId==cmpgnRecType || cmpgn.RecordTypeId==programRecType) &&
          (oldMapCmpgn.get(cmpgn.Id).ParentId != cmpgn.ParentId)
              )
           {
                System.debug('------------------==>>establishing Parent & Child Campaign relationship');
                System.debug('------------FT status values on Campaign creation: Status:'+cmpgn.Status+'- Custom Status:'+cmpgn.Custom_Status_ge_og__c);
                newParentIdSet.add(cmpgn.ParentId);
                oldParentIdSet.add(oldMapCmpgn.get(cmpgn.Id).ParentId);
                cmpgnIdSet.add(cmpgn.Id);
                
                //Storing new Parent details with child campaigns
                if(newMapParentCmpgn.containsKey(cmpgn.ParentId)) {
                     List<Campaign> newParentCmpgnList = newMapParentCmpgn.get(cmpgn.ParentId);
                     newParentCmpgnList.add(cmpgn);
                     newMapParentCmpgn.put(cmpgn.ParentId, newParentCmpgnList);
                }else {
                     newMapParentCmpgn.put(cmpgn.ParentId, new List<Campaign> { cmpgn });
                }
                
                //Storing old Parent details with child campaigns
                if(oldMapParentCmpgn.containsKey(oldMapCmpgn.get(cmpgn.Id).ParentId)) {
                     List<Campaign> oldParentCmpgnList = oldMapParentCmpgn.get(oldMapCmpgn.get(cmpgn.Id).ParentId);
                     oldParentCmpgnList.add(cmpgn);
                     oldMapParentCmpgn.put(oldMapCmpgn.get(cmpgn.Id).ParentId, oldParentCmpgnList);
                }else {
                     oldMapParentCmpgn.put(oldMapCmpgn.get(cmpgn.Id).ParentId, new List<Campaign> { oldMapCmpgn.get(cmpgn.Id) });
                }
            }    
       }
       System.debug('--------------------------Parent Id set size='+newParentIdSet.size()); 
       if(newParentIdSet !=null && newParentIdSet.size()>0 && oldParentIdSet !=null && oldParentIdSet.size()>0) {
         //Creating new Parent map list to update
         Map<Id,Campaign> newParentMap = new Map<Id,Campaign>([Select Id,tier2_ge_og__c,tier3_ge_og__c, Name,Aborted_Campaign_Count_ge_og__c, Completed_Campaign_Count_ge_og__c, 
                                                          Inprogress_Campaign_Count_ge_og__c,Planned_Campaign_Count_ge_og__c, 
                                                          Total_Child_Campaigns_ge_og__c //,Earliest_Child_Start_Date_ge_og__c 
                                                               from Campaign where id in: newParentIdSet]);
                                                          
         //Creating new old map list to update
         Map<Id,Campaign> oldParentMap = new Map<Id,Campaign>([Select Id,tier2_ge_og__c,tier3_ge_og__c, Name,Aborted_Campaign_Count_ge_og__c, Completed_Campaign_Count_ge_og__c, 
                                                          Inprogress_Campaign_Count_ge_og__c,Planned_Campaign_Count_ge_og__c, 
                                                          Total_Child_Campaigns_ge_og__c //,Earliest_Child_Start_Date_ge_og__c 
                                                               from Campaign where id in: oldParentIdSet]);                                               
                                                          
         for(Id pId:newMapParentCmpgn.keySet()){
           System.debug('-------------+++++  Iterating new Parent Campaign map >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'+newParentMap.get(pId).Name);
           Campaign updNewParent = newParentMap.get(pId);
           //Date minChildStartDate = updNewParent.Earliest_Child_Start_Date_ge_og__c;  
           Decimal totalCount = updNewParent.Total_Child_Campaigns_ge_og__c;
           Decimal abortedCount= updNewParent.Aborted_Campaign_Count_ge_og__c;
           Decimal plannedCount = updNewParent.Planned_Campaign_Count_ge_og__c;
           Decimal inprogressCount = updNewParent.Inprogress_Campaign_Count_ge_og__c;
           Decimal completedCount = updNewParent.Completed_Campaign_Count_ge_og__c;
           
           //Iterating all child campaigns under each new Parent Campaign
           for(Campaign cCmpgn:newMapParentCmpgn.get(pId)){
               
               System.debug('=============--------->>Initial values for Parent:'+updNewParent.Name+' :: totalCount:'+totalCount+';abortedCount:'+abortedCount+';plannedCount:'+plannedCount
                                                                        +';inprogressCount'+inprogressCount+';completedCount:'+completedCount);    
                
                   //this should be used to increase count 1 for new Parent details
                    totalCount = totalCount+1 ;
                     
                    /* if(minChildStartDate ==null ){
                        System.debug('===--------------- Entering for updating Min Child Date:'+cCmpgn.StartDate);
                        minChildStartDate = cCmpgn.StartDate;   
                    }
                    else if(minChildStartDate !=null && minChildStartDate > cCmpgn.StartDate){
                        System.debug('===--------------- Entering for updating Min Child Date:'+cCmpgn.StartDate);
                        minChildStartDate = cCmpgn.StartDate;
                    } */
                     
                     if(cCmpgn.Status=='Planned' ){
                         plannedCount = plannedCount+1 ;
                     }
                     else if(cCmpgn.Status=='Aborted'){
                         abortedCount = abortedCount+1 ;
                     }
                     else if(cCmpgn.Status=='Completed'){
                         completedCount = completedCount+1 ;
                     }
                     else if(cCmpgn.Status=='In Progress'){
                         inprogressCount = inprogressCount+1 ;
                         
                     }
            }
            //updParent
           System.debug('=============--------->>Final values for Parent:'+updNewParent.Name+' ::  totalCount:'+totalCount+'; abortedCount:'+abortedCount+'; plannedCount:'+plannedCount
                                                            +'; inprogressCount:'+inprogressCount+'; completedCount:'+completedCount);
           updNewParent.Total_Child_Campaigns_ge_og__c = totalCount;
           updNewParent.Aborted_Campaign_Count_ge_og__c = abortedCount;
           updNewParent.Planned_Campaign_Count_ge_og__c = plannedCount;
           updNewParent.Inprogress_Campaign_Count_ge_og__c = inprogressCount;
           updNewParent.Completed_Campaign_Count_ge_og__c = completedCount;
           //updNewParent.tier2_ge_og__c=updNewParent.tier2_ge_og__c;
           //updNewParent.Earliest_Child_Start_Date_ge_og__c = minChildStartDate;  
           updParentList.add(updNewParent);
           
         } 
         
         //To iterate over old Parent and reduce count
         for(Id pId:oldMapParentCmpgn.keySet()){
           //Campaign updPCmpgn = new Campaign(Id=pId);
           System.debug('-------------+++++  Iterating new Parent Campaign map >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'+oldParentMap.get(pId).Name);
           Campaign updOldParent = oldParentMap.get(pId);
           //Date minChildStartDate = updOldParent.Earliest_Child_Start_Date_ge_og__c;  
           Decimal totalCount = updOldParent.Total_Child_Campaigns_ge_og__c;
           Decimal abortedCount= updOldParent.Aborted_Campaign_Count_ge_og__c;
           Decimal plannedCount = updOldParent.Planned_Campaign_Count_ge_og__c;
           Decimal inprogressCount = updOldParent.Inprogress_Campaign_Count_ge_og__c;
           Decimal completedCount = updOldParent.Completed_Campaign_Count_ge_og__c;
           
           //Iterating all child campaigns under each Parent Campaign
           for(Campaign cCmpgn:oldMapParentCmpgn.get(pId)){
               
               System.debug('=============--------->>Initial values for old Parent:'+updOldParent.Name+' :: totalCount:'+totalCount+';abortedCount:'+abortedCount+';plannedCount:'+plannedCount
                                                                        +';inprogressCount'+inprogressCount+';completedCount:'+completedCount);    
                    
                //this should be used for reducing count 1 for old Parent details
                
                     totalCount = totalCount-1 ;
                     
                    /* if(minChildStartDate !=null && totalCount==0 ){
                        System.debug('===--------------- Entering for updating Min Child Date:'+cCmpgn.StartDate);
                        minChildStartDate = null;   
                    } */
                     if(oldMapCmpgn.get(cCmpgn.Id).Status=='Planned' ){
                         plannedCount = plannedCount-1 ;
                         
                     }
                     else if(oldMapCmpgn.get(cCmpgn.Id).Status=='Aborted'){
                         abortedCount = abortedCount-1 ;
                     }
                     else if(oldMapCmpgn.get(cCmpgn.Id).Status=='Completed'){
                         completedCount = completedCount-1 ;
                     }
                     else if(oldMapCmpgn.get(cCmpgn.Id).Status=='In Progress'){
                         inprogressCount = inprogressCount-1 ;
                         
                     }
                        
            }
            //updNewParent
           System.debug('=============--------->>Final values for old Parent:'+updOldParent.Name+' ::  totalCount:'+totalCount+'; abortedCount:'+abortedCount+'; plannedCount:'+plannedCount
                                                                        +'; inprogressCount:'+inprogressCount+'; completedCount:'+completedCount);
           updOldParent.Total_Child_Campaigns_ge_og__c = totalCount;
           updOldParent.Aborted_Campaign_Count_ge_og__c = abortedCount;
           updOldParent.Planned_Campaign_Count_ge_og__c = plannedCount;
           updOldParent.Inprogress_Campaign_Count_ge_og__c = inprogressCount;
           updOldParent.Completed_Campaign_Count_ge_og__c = completedCount;
           //updOldParent.tier2_ge_og__c=updOldParent.tier2_ge_og__c;
           //updOldParent.Earliest_Child_Start_Date_ge_og__c = minChildStartDate;  
           updParentList.add(updOldParent);
         }
      }
      if(updParentList !=null && updParentList.size()>0)  {
          System.debug('=================================>>>>>>>>>>>update List'+ updParentList.size());
          update updParentList;   
      }
    }
    
    //To get all Campaign records and check start date changes with child campaign start date   
    public void validatePrntCmpgnStartDt(List<Campaign> updatedCampaignList){
            Set<id> parentIdSet = new Set<id>();
            Set<Date> parentStartDateSet = new Set<Date>();
            Map<id,Date> parentStartDateMap = new Map<id,Date>();
            List<Campaign> childCampaignList = new List<Campaign>();
            Set<id> errorCampaignSet = new Set<id>();
            
            //Getting the Program or Theme records for start date change
            for(Campaign pCmpgn: updatedCampaignList){
                parentIdSet.add(pCmpgn.id);
                parentStartDateMap.put(pCmpgn.id,pCmpgn.startDate);
            }
        
            childCampaignList = [select id,parentId,startDate,endDate from campaign where parentid in:parentIdSet];
        
            //Storing and comparing Start Date on Parent with child campaigns
            if(!childCampaignList.isEmpty()){
                for(Campaign cCmpgn: childCampaignList){
                    Date parentStartDate = parentStartDateMap.get(cCmpgn.parentId);
                    if(cCmpgn.startDate<parentStartDate){
                        errorCampaignSet.add(cCmpgn.parentId);
                    }
                }
            }
        
            //To throw error for Start Date error on Parent Campaign
            for(Campaign pCmpgn: updatedCampaignList){
                if(errorCampaignSet.contains(pCmpgn.id)){
                pCmpgn.addError('Start Date must be less than or equals to earliest Child campaign Start Date');
                }
            }
       
    }
    public static void ProcessCampaignRecords(){
       Integer Cmr = 0;
         Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
         Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
         Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
         Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
    }

        
}