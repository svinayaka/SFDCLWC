/**
 * 
 * Class/Trigger Name--: LastActivityDateOpportunity
 * Purpose/Overview----: This trigger is used to update the Last Activity Date Field On Opportunity whenever a new task is created
 * Author--------------: Nitish Pandey
 * Created Date--------: 29-June-2016
 * Test Class Name-----: LastActivityDateOpportunityTrg_Test    

 * Change History -

 * Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
   
**/

// Commented and added below for Bug 0000024023
trigger LastActivityDateOpportunity on Task (after insert, after update,before insert,before update) {

Trigger_Toggle__mdt triggerToggle = [select isEnabled__c from Trigger_Toggle__mdt where Trigger_Name__c  = 'LastActivityDateOpportunity' limit 1];
    
    boolean isEnabled = true;
    
    if(triggerToggle != null)
        isEnabled = triggerToggle.isEnabled__c;
  // Added as part of R-26355
    Set<Id> accTaskIds = new Set<Id>();
    List<Account> account= new List<Account>();
    Map<ID, String> accMap = new Map<ID, String>();
    Set<Task> inactiveAccTask = new Set<Task>();
    ID dealMacRecordType = schema.sObjectType.Task.getRecordTypeInfosByName().get('Deal Machine Task').getRecordTypeID();  
    Task oldTask = new Task();
   
    for(Task t:trigger.new) {
        If(Trigger.isUpdate){
        oldTask = Trigger.OldMap.get(t.id);
        }
        
        if(Trigger.isBefore && (Trigger.isInsert || (Trigger.isUpdate && oldtask.whatId != t.whatId)))
        if(t.WhatId!= null ) {
            System.debug('---------Entering into LastActivityDateOpportunity before Insert');
            Id dmRecType=t.RecordTypeId;
            String objKeyPrefix = t.WhatId;
            String objKeyPrefixId = objKeyPrefix.substring(0,3);
            //String sObjectType = 'Account';
            //objKeyPrefix.getSObjectType().getDescribe().getName();
            system.debug('WhatId'+t.whatId);
            //system.debug('-------------...............>>>>>>>Related Object Name='+sobjectType);
            system.debug('-------------...............>>>>>>>'+t.RecordTypeId);
           
              // if(sObjectType.equalsIgnorecase('Account') && dmRecType.equals(dealMacRecordType)) 
                if(objKeyPrefixId.equals('001') && dmRecType == dealMacRecordType) {   
                    System.debug('-- ---- Task updated:'+t.Id+' & Related To:'+t.WhatId);                
                    accTaskIds.add(t.WhatId); // storing Account Ids in a list that are related to task.
                }
                }
                }
 
    if(isEnabled){
    System.debug('Logic for Account related Task');
     if(accTaskIds.size()>0){  
        System.debug('------- -- accTaskIds.size()'+accTaskIds.size());
        
        account=[select id,Account_Status__c from Account where Account_Status__c = 'Inactive' AND id IN : accTaskIds LIMIT 50000 ];
        system.debug('-------------...............>>>>>>>Account'+account);
        for(Account acc:account){
            accMap.put(acc.id,acc.Account_Status__c);
            system.debug('-------------...............>>>>>>>accMap'+accMap);
         }
            
        for(Task tNew: trigger.new){
        //Id tWhatId = tNew.whatId;
        system.debug('-------------...............>>>>>>>tNew.whatId'+tNew.whatId);
        system.debug('-------------...............>>>>>>>accMap.containsKey(tWhatId)'+accMap.containsKey(tNew.WhatId));       
        If(accMap!= NULL && accMap.containsKey(tNew.whatId) ){
         //inactiveAccTask.add(tNew);
         tNew.addError('This Account is Inactive and cannot be associated to a new Task');
         system.debug('-------------...............>>>>>>>inactiveAccTask'+inactiveAccTask);
        }
        } 
        }
        /*
        for(Task tIds: inactiveAccTask){
               system.debug('-------------...............>>>>>>>Inside Error Block'+tIds); 
                tIds.addError('This Account is Inactive and cannot be associated to a new Task');
                
            }*/
           
     
    }
     
 if(trigger.isInsert && trigger.isAfter){
 
    System.debug('---------Entering into LastActivityDateOpportunity after Insert');
    //Initializing Variable
    List<Id> opptyIds = new List<Id>();
     List<Id> opptyTaskIds = new List<Id>();
     List<Id> accTaskIds = new List<Id>();
     List<Id> projectTaskIds = new List<Id>();
     List<Id> assetTaskIds = new List<Id>();
     List<Id> bhgeGoalTaskIds = new List<Id>();
     List<Id> cmrIds = new List<Id>();
    Map <Id,Task> taskOldMap = new Map <Id,Task>();
    taskOldMap = trigger.oldMap;
        
    //For loop to identify whether task is related to any Opportunity or not and update LastActivity Date on Oppty & Campaign Member.
    for(Task t:trigger.new) {
        System.debug('WhatId'+t.WhatId);
        if(t.WhatId!= null || t.WhoId != null){
            string objKeyPrefix = t.WhatId;
            system.debug('objKeyPrefix'+objKeyPrefix);
            String whoId = t.WhoId;
            system.debug('whoId'+whoId);
            if(objKeyPrefix !=null){
            objKeyPrefix = objKeyPrefix.substring(0,3); 
            }
            String cmrSubString = '';
            String cmrValue = t.Campaign_Lead_ID_ge_og__c;
            system.debug('cmrValue using campaign lead Id'+cmrValue);
            if (String.isEmpty(cmrValue) && String.isEmpty(objKeyPrefix))
            {   
                system.debug('Inside cmrValue empty loop');
                List<CampaignMember> cmrList = new List<CampaignMember>();
                cmrList = [Select id from CampaignMember where (CampaignId =: objKeyPrefix and contactId =: whoId) or leadId =: whoId limit 1];
                 if(cmrList.size() > 0 && cmrList[0]!=null) //Added by Kiru to solve null pointer exception
                system.debug('cmrValue inside empty loop after query'+cmrValue);   
            }
            system.debug('Outside cmrValue empty loop');
            if(!String.isEmpty(cmrValue)){
            cmrSubString = cmrValue.substring(0,3);
            }
            if(objKeyPrefix == '006') {
                System.debug('------ New task created:'+t.Id+' '+t.Assigned_To_ID_GE_OG__c);                
                opptyIds.add(t.WhatId); // storing Opportunity in a list that are related to task.
            }
            else if (cmrSubString == '00v'){
                //cmrIds.add(t.Campaign_Lead_ID_ge_og__c);
                cmrIds.add(cmrValue);
                system.debug('cmrIds'+cmrIds);
            }
        }
        
    }
    
    //For Email Notification on Task implementation
    ID dealMacRecordType = schema.sObjectType.Task.getRecordTypeInfosByName().get('Deal Machine Task').getRecordTypeID();    
    for(Task t:trigger.new) {
        if(t.WhatId!= null) {
            String status=t.Status;
            String dmRecType=t.RecordTypeId;
            string objKeyPrefix = t.WhatId;
            objKeyPrefix = objKeyPrefix.substring(0,3);
            system.debug('-------------...............>>>>>>>'+dealMacRecordType+'='+t.RecordTypeId);
           
                if(objKeyPrefix == '006' ){
                    System.debug('------ Task updated:'+t.Id+' & Related To:'+t.WhatId);                
                    opptyTaskIds.add(t.WhatId); // storing Opportunity in a list that are related to task.
                }
                else if(objKeyPrefix == '001') {
                    System.debug('-- ---- Task updated:'+t.Id+' & Related To:'+t.WhatId);                
                    accTaskIds.add(t.WhatId); // storing Opportunity in a list that are related to task.
                }
                else if(objKeyPrefix == 'a06') {
                    System.debug('-- ---- Task updated:'+t.Id+' & Related To:'+t.WhatId);                
                    projectTaskIds.add(t.WhatId); // storing Opportunity in a list that are related to task.
                }   
                else if(objKeyPrefix == '02i') {
                    System.debug('-- ---- Task updated:'+t.Id+' & Related To:'+t.WhatId);                
                    assetTaskIds.add(t.WhatId); // storing Opportunity in a list that are related to task.
                }
                else if(objKeyPrefix == 'aAa') {
                    System.debug('-- ---- Task updated:'+t.Id+' & Related To:'+t.WhatId);                
                    bhgeGoalTaskIds.add(t.WhatId); // storing Opportunity in a list that are related to task.
                }
        }
     }
    
    
    if(isEnabled){
    System.debug('Email alerts are going - 1');
     if(opptyTaskIds.size()>0 || accTaskIds.size()>0 || projectTaskIds.size()>0 || assetTaskIds.size()>0 || bhgeGoalTaskIds.size()>0){  
        System.debug('------- -- opptyIds.size()'+opptyIds.size());
        EmailToOpptyTeamMemebrs_GE_OG taskEmailDMTeamNotify = new EmailToOpptyTeamMemebrs_GE_OG();
        taskEmailDMTeamNotify.taskEmailToOpptyTeamMembers(trigger.new);  
        
    }
    
    }
    if(opptyIds.size()>0){  
        System.debug('--------- opptyIds.size()'+opptyIds.size());
      
       // EmailToOpptyTeamMemebrs_GE_OG taskEmailDMTeamNotify = new EmailToOpptyTeamMemebrs_GE_OG();
        //To send email on Task creation
       // taskEmailDMTeamNotify.taskEmailToOpptyTeamMembers(trigger.new);

        Map<Id, Opportunity> opptyMap = new Map<Id, Opportunity>();
            
        ////    
        //List<Opportunity> lstOppty = new List<Opportunity>();
        System.debug('-----------Task Trigger.new ::='+trigger.new);
        for(task tskobj:trigger.new) {
            System.debug('-----------New Task iteration ::=');
            Opportunity opp = new Opportunity(Id=tskobj.WhatId);
            opp.last_activity_date_ge_og__c= date.ValueOf(tskobj.CreatedDate);
            //Added to test the story create activity on closed oppty
            opp.Last_Activity_change_date_ge_og__c = System.now();
            //lstOppty.add(opp);
            opptyMap.put(opp.Id, opp);
            
        }
        System.debug('-----------After adding opportunity for which task are created,oppty list size='+opptyMap.values());
        //update lstOppty;
        update opptyMap.values();
     }
     if(cmrIds.size() > 0){
         CheckRecursion_GE_OG.taskRecursion();
         Map<Id, CampaignMember> cmrMap = new Map<Id, CampaignMember>();
         for (task tskobj:Trigger.new){
             CampaignMember cmr = [Select id,Has_CMR_Owner_ge_og__c,Status,Date_Qualifiying_Started_ge_og__c,Last_Activity_Date_ge_og__c, Last_Name_and_Email_check__c, Has_Campaign__c from CampaignMember where id =:tskObj.Campaign_Lead_ID_ge_og__c];
             
             system.debug('****************Date_Qualifiying_Started_ge_og__c'+cmr.Date_Qualifiying_Started_ge_og__c );
             system.debug('cmr----------------------$$'+cmr);
             //CampaignMember cmr = new CampaignMember(id=tskObj.Campaign_Lead_ID_ge_og__c);
             system.debug('Inside last date update loop'+cmr);                                       
             cmr.Last_Activity_Date_ge_og__c = date.ValueOf(tskobj.CreatedDate);
             system.debug('cmr.owner_ge_og__c-------------'+cmr.Has_CMR_Owner_ge_og__c);
            system.debug('cmr.status-------------'+cmr.Status); 
             if(cmr.Last_Activity_Date_ge_og__c != null && cmr.Has_CMR_Owner_ge_og__c && 
                cmr.Last_Name_and_Email_check__c && cmr.Has_Campaign__c){
                      System.debug('--------->>>Going to update CMR status: Qualifying');
                        cmr.Status='Lead Qualifying';
                        cmr.Status_ge_og__c='';
                        System.debug('--------->>>OUTSIDE IF cmr.Date_Qualifiying_Started_ge_og__c'+cmr.Date_Qualifiying_Started_ge_og__c);
                        if(cmr.Date_Qualifiying_Started_ge_og__c == NULL){
                        System.debug('--------->>>INSIDE CMR Status');
                          cmr.Date_Qualifiying_Started_ge_og__c=System.today();
                          }
                    
                    }  
             cmrMap.put(cmr.id, cmr);
             system.debug('cmrMap  for update'+cmrMap);
         }
             system.debug('taskrun before cmrmap update'+CheckRecursion_GE_OG.taskRun);
             update cmrMap.values();
             system.debug('cmrMap updated'); 
     }
  }  
    
  if(trigger.isUpdate && trigger.isAfter){
    System.debug('---------Entering into LastActivityDateOpportunity after Update');
    //Initializing Variable
    List<Id> opptyIds = new List<Id>();
      List<Id> opptyAccIds = new List<Id>();
      List<Id> opptyListIds = new List<Id>();
      List<Id> opptyUserIds = new List<Id>();
      List<Id> accIds = new List<Id>(); 
      List<Id> projectIds = new List<Id>(); 
      
    Map <Id,Task> taskOldMap = new Map <Id,Task>();
    taskOldMap = trigger.oldMap;
    ID dealMacRecordType = schema.sObjectType.Task.getRecordTypeInfosByName().get('Deal Machine Task').getRecordTypeID();    
    //For loop to identify whether task is related to any Opportunity or not.
    for(Task t:trigger.new) {
        if(t.WhatId!= null) {
            String status=t.Status;
            String dmRecType=t.RecordTypeId;
            string objKeyPrefix = t.WhatId;
            objKeyPrefix = objKeyPrefix.substring(0,3);
            system.debug('-------------...............>>>>>>>'+dealMacRecordType+'='+t.RecordTypeId+' &'+taskOldMap.get(t.Id).Status+'->'+t.Status);
           // if(t.RecordTypeId == dealMacRecordType && (taskOldMap.get(t.Id).OwnerId != t.OwnerId || (t.Status.contains('Complete') && taskOldMap.get(t.Id).Status != t.Status))){  
                if(objKeyPrefix == '006' ){
                    System.debug('------ Task updated:'+t.Id+' & Related To:'+t.WhatId);                
                    opptyIds.add(t.WhatId); // storing Opportunity in a list that are related to task.
                }
                else if(objKeyPrefix == '001') {
                    System.debug('-- ---- Task updated:'+t.Id+' & Related To:'+t.WhatId);                
                    accIds.add(t.WhatId); // storing Opportunity in a list that are related to task.
                }
                else if(objKeyPrefix == 'a06') {
                    System.debug('-- ---- Task updated:'+t.Id+' & Related To:'+t.WhatId);                
                    projectIds.add(t.WhatId); // storing Opportunity in a list that are related to task.
                }
            //}
        }
     }
   
    if(isEnabled){ 
    System.debug('Email alerts are going - 2');
    if(opptyIds.size()>0 || accIds.size()>0 || projectIds.size()>0){  
        System.debug('------- -- opptyIds.size()'+opptyIds.size());
        EmailToOpptyTeamMemebrs_GE_OG taskEmailDMTeamNotify = new EmailToOpptyTeamMemebrs_GE_OG();
        taskEmailDMTeamNotify.emailToOpptyTeamMembersOnTaskClose(trigger.new, trigger.oldMap);  
        taskEmailDMTeamNotify.emailToOpptyTaskAssigneeOnChange(trigger.new, trigger.oldMap);      
    }
    }
  }  
 
}