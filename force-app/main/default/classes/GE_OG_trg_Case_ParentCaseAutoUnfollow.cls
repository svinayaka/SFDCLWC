/*
Class Name: 
Used In : 
Purpose/Overview : 
Functional Area : Case
Author: CaseTeam
Test Class Name : 
*/

/*
S.NO         MethodName                                                     operation
1.           prePopulateMCS                                                  beforeInsert,beforeUpdate
2.           mcsAutoUnfollowBasedOnCaseClosed                                afterInsert,afterUpdate
3.           markCaseAsRedundant                                             before insert
4.           mcsTaskUpdate                                                    afterUpdate
*/


public class GE_OG_trg_Case_ParentCaseAutoUnfollow {

/*
  this method is for 'beforeInsert','beforeUpdate' operation.
  Modified from Trigger:GE_MCS_Prepopulate_from_ParentCase.
  Purpose:PrePopulataing from ParentCase for RecordType-'MCS-CS'.
  TestClassName:
*/

public void prePopulateMCS(List<case>  newcaseList)
{
     map<id,Case> kids = new map<id,Case>();
     map<id,Case> parents = new map<id,Case>();
     
     List<Case>  newcaseList1= (List<Case>)newcaseList;
     System.debug('beforeInsertutil-------------'+GEESUtil.caseRecTypes);
      if(GEESUtil.caseRecTypes==null)
    {
   GEESUtil.getAssociatedCaseRecordTypeIDforRecordTypeName();
   
    }
     Schema.RecordTypeInfo rtByName =  GEESUtil.caseRecTypes.get('MCS - CS');
      Id RecordTypeID = rtByName.getRecordTypeId();
  
  
  for(Case kc : newcaseList1){
        if(kc.ParentId!=null && kc.RecordTypeId == RecordTypeID)
            kids.put(kc.ParentId,kc);
    }
     List<Case> cases=[select Opportunity_Name__c,GE_ES_Sub_Type__c,Id from Case where id in : kids.keyset()];
    for(Case pc : cases){
        parents.put(pc.id,pc);
    }
    for(Case c : kids.values()){
        if (parents.get(c.ParentId).GE_ES_Sub_Type__c == 'RFQ Processing') {
            c.Opportunity_Name__c = parents.get(c.ParentId).Opportunity_Name__c;
            c.GE_ES_Sub_Type__c = 'RFQ Processing';
        }  

           


}
}

/*
  this method is for 'afterInsert','afterUpdate' operation.
  Modified from Trigger:GEOGMCS_AutoUnfollowBasedOnCaseClosed    
  Purpose:deleting ids for 'EntitySubscription' recordtype-'MCS-CS'.
  TestClassName:GEOGMCS_AutoUnfollowCaseClosedTest.
*/

public void mcsAutoUnfollowBasedOnCaseClosed(List<case>  newcaseList)
{
        // list of Case ID's
        Set<Id> caseIds     = new Set<Id>();
        // get user Id who close the case
        String SubscriberId = Userinfo.getUserId();
        List<Case>  newcaseList1= (List<Case>)newcaseList;
         if(GEESUtil.caseRecTypes==null)
        {
         GEESUtil.getAssociatedCaseRecordTypeIDforRecordTypeName();
   
         }
     Schema.RecordTypeInfo rtByName =  GEESUtil.caseRecTypes.get('MCS - CS');
      Id RecordTypeID = rtByName.getRecordTypeId();
      List<EntitySubscription> listSubscription = new List<EntitySubscription>();
        
        for(Case c :newcaseList1){
            if( c.RecordTypeId == RecordTypeID && c.status == 'Closed'){
                caseIds.add(c.id);
            }        
        }
        
         if( caseIds != null && caseIds.size() >0){
            listSubscription = [Select Id From EntitySubscription Where ParentId = :caseIds];
            delete listSubscription; 
        }

}

/*
  this method is for 'before insert' operation.
  Modified from Trigger:GE_HQ_MarkCaseAsRedundant    
  Purpose:is to mark Is Redundant flag as true if the case is getting generated as a result of 
    emails from customers for legacy Single Org cases belonging to OG and EM businesses.
  TestClassName:
*/
public void markCaseAsRedundant (List<case>  newcaseList)
{

List<Case>  newcaseList1= (List<Case>)newcaseList;
for (Case caseObj : newcaseList1)
    {
      if (caseObj.Subject!=null && (caseObj.Subject.indexOf('[ ref:00DAKBfD') != -1 || caseObj.Subject.indexOf('[ ref:_00DA0KBfD') != -1) && caseObj.Subject.indexOf(':ref ]') != -1 && caseObj.Origin!=null && caseObj.Origin.indexOf('Email') != -1)
      {
         caseObj.Is_Redundant__c=true;
         
      }
    }

}

/*
  this method is for 'after insert' operation.
  Modified from Trigger:GE_MCS_TaskUpdate    
  Purpose:Close all tasks when case has closed..
  TestClassName:GE_MCS_TaskUpdate_Test
*/
public void mcsTaskInsert (List<case>  newcaseList)
{

List<Case>  newcaseList1= (List<Case>)newcaseList;

 List<String> CaseIds = new List<String>();
  List<Task> taskList = new List<Task>();
  
  if(GEESUtil.caseRecTypes==null)
    {
   GEESUtil.getAssociatedCaseRecordTypeIDforRecordTypeName();
   
    }
     Schema.RecordTypeInfo rtByName =  GEESUtil.caseRecTypes.get('MCS - CS');
      Id RecordTypeID = rtByName.getRecordTypeId();
      
      for(Case c:newcaseList1){
        if(c.recordTypeId == RecordTypeID &&(c.status == 'Closed' ))
        {
           CaseIds.add(c.Id);
        }
    }
    
     if(CaseIds != null && CaseIds.size()>0){
         
    taskList = [select WhatId, Status from Task where WhatId in: CaseIds and Status <> 'Completed' ];
    
    if(taskList != null && taskList.size() > 0){
        for(task t:taskList){
            t.Status = 'Completed';
        }
        update taskList;
    }
    }
  




}

/*
  this method is for 'afterUpdate' operation.
  Modified from Trigger:GE_MCS_TaskUpdate    
  Purpose:Close all tasks when case has closed..
  TestClassName:GE_MCS_TaskUpdate_Test
*/

public void mcsTaskUpdate (List<case>  newcaseList,Map<Id,Case>  OldMapCase)
{

List<Case>  newcaseList1= (List<Case>)newcaseList;
Map<Id,Case>  oldMapCase1=(Map<Id,Case>)  OldMapCase;
 List<String> CaseIds = new List<String>();
  List<Task> taskList = new List<Task>();
  System.debug('geesUtil'+GEESUtil.caseRecTypes);
  if(GEESUtil.caseRecTypes==null)
    {
   GEESUtil.getAssociatedCaseRecordTypeIDforRecordTypeName();
   
    }
     Schema.RecordTypeInfo rtByName =  GEESUtil.caseRecTypes.get('MCS - CS');
      Id RecordTypeID = rtByName.getRecordTypeId();
      
      for(Case c:newcaseList1){
        if(c.recordTypeId == RecordTypeID &&  ((c.status == 'Closed' )&&(oldMapCase1.get(c.Id).status!='Closed'))  )
        {
           CaseIds.add(c.Id);
        }
    }
    
     if(CaseIds != null && CaseIds.size()>0){
         
    taskList = [select WhatId, Status from Task where WhatId in: CaseIds and Status <> 'Completed' ];
    
    if(taskList != null && taskList.size() > 0){
        for(task t:taskList){
            t.Status = 'Completed';
        }
        update taskList;
    }
    }
  




}




}