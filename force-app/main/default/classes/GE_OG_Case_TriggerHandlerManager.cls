/**
*    
* Class/Trigger Name--: GE_OG_Case_TriggerHandlerManager
* Used Where ?--------: Case Trigger Handler
* Purpose/Overview----: Case Trigger Handler
* Functional Area-----: Service
* Author--------------: 
* Created Date--------: 
* Test Class Name-----: 

* Change History -

* Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change

**/

public without sharing class  GE_OG_Case_TriggerHandlerManager {
    /*
Operation:beforeInsert,beforeUpdate
Purpose:Used to populate the Opportunity field on the Child Case from the Parent Case if the Parent Case SubType = 'RFQ Processing'
*/
    public  void beforeInsertbeforeUpdatePrePopulateParent(List<Case>  newcaseList) {
        GE_OG_trg_Case_PrepopulateFromParentCase   prePopulateFromParent = new GE_OG_trg_Case_PrepopulateFromParentCase () ;
        prePopulateFromParent.prePopulateCaseFromParentCase(newcaseList) ; 
    }
    /*
Operation:beforeInsert
Purpose:Used to populate the Tier3 field on the Case based on the Origin.
*/
/*
    public  void beforeInsertUpdateTier3(List<Case>  newcaseList) {
        GE_OG_MCS_Case_updateTier3   updatetier3 = new GE_OG_MCS_Case_updateTier3 () ;
        updatetier3.updateTier3value(newcaseList) ; 
    }*/
    /* Added by raju
Operation:beforeInsert and before update
Purpose:Used to populate the Duplicate CaseNumbers with the Same Customer PO#.
*/
    //public void dupecheck(List<Case>newcaseList)
    public void dupecheck(Case newcaseList)
    {
        GE_OG_MCS_DuplicateCustomerPO_Check dupe=new GE_OG_MCS_DuplicateCustomerPO_Check();
        dupe.DuplicateCustomerPO_Check_method(newcaseList);
    }
    
    public void dupecheckUpdate(Case newcaseList, Case oldcaseList)
    {
        if(newcaseList.GE_ES_PO__c != oldcaseList.GE_ES_PO__c){    
            GE_OG_MCS_DuplicateCustomerPO_Check dupe=new GE_OG_MCS_DuplicateCustomerPO_Check();
            dupe.DuplicateCustomerPO_Check_method(newcaseList);
        }
    }
    
    /* Operation:after update
purpose:Used to create a caseshare for a case when owner of the case changes
*/
    
    Public void afterUpdateCaseShare(List<case> NewList,map<id,case> oldMapCase) {      
        GE_OG_trg_Case_CaseShare caseShare= new GE_OG_trg_Case_CaseShare();   
        caseShare.createCaseShare(NewList,oldMapCase);   
    }
    
    /* 
Operation:before update
purpose:Used to change status when owner changes from initiator to queue manager
*/
    Public void beforeupdatestatuschange(List<case> NewList,map<id,case> oldMapCase) {      
        GE_OG_CIR_StatusChange statuschange= new GE_OG_CIR_StatusChange();   
        statuschange.statuchangemethod(NewList,oldMapCase);   
    }
    
    /*
Operation:beforeInsert,beforeUpdate
purpose:Used to populate region field on case based on country and business tier
*/
    Public void beforeinsertbeforeupdatecaseCounterregionpopltion(List<case> NewList) {      
        GE_OG_Case_RegionMatrixCounter c= new GE_OG_Case_RegionMatrixCounter();   
        c.Reginfldspopulatin(NewList);    
    }
    
    /*
Operation:beforeInsert
Purpose:Close all tasks when case has closed
*/
    public  void beforeInsertNumOFContactsforEmailid(List<Case>  newcaseList) {
        GE_OG_trg_Case_NumOFContactsforEmailid   numOfContacts = new GE_OG_trg_Case_NumOFContactsforEmailid () ;
        numOfContacts.numOFContactsforEmailidInsertion(newcaseList) ; 
        numOfContacts.webEmailidInsertionUpdation(newcaseList) ; 
    }
    
    /*
Operation:beforeUpdate
Purpose:Close all tasks when case has closed
*/
    public  void beforeUpdateNumOFContactsforEmailid(List<Case>  newcaseList,Map<Id,Case>  oldMapCase,Map<Id,Case>  newMapCase) {
        GE_OG_trg_Case_NumOFContactsforEmailid   numOfContacts = new GE_OG_trg_Case_NumOFContactsforEmailid () ;
        // numOfContacts.numOFContactsforEmailidUpdate(newcaseList,oldMapCase,newMapCase) ; 
        // numOfContacts.webEmailidInsertionUpdation(newcaseList) ; 
    }
    
    /*
Operation:beforeInsert
Purpose:Included subtype mandatory logic for mcs record type
*/
    public  void beforeInsertassignmentGroupField(List<Case>  newcaseList) {
        GE_OG_trg_Case_PopulateFromInstalledBase   populateCaseFromIB = new GE_OG_trg_Case_PopulateFromInstalledBase () ;
        populateCaseFromIB.assignmentGroupFieldInsertion(newcaseList) ; 
    }
    
    /*
Operation:beforeUpdate
Purpose:Included subtype mandatory logic for mcs record type
*/
    public  void beforeUpdateassignmentGroupField(List<Case>  newcaseList,Map<Id,Case>  newMapCase,Map<Id,Case>  oldMapCase) {
        GE_OG_trg_Case_PopulateFromInstalledBase   populateCaseFromIB = new GE_OG_trg_Case_PopulateFromInstalledBase () ;
        populateCaseFromIB.assignmentGroupFieldUpdation(newcaseList,newMapCase,oldMapCase) ;                                     
    }
    
    /*
Operation:beforeInsert
Purpose:
*/
    public  void beforeInsertpopulateCaseFromInstalledBase(List<Case>  newcaseList) {
        GE_OG_trg_Case_PopulateFromInstalledBase   populateCaseFromIB = new GE_OG_trg_Case_PopulateFromInstalledBase () ;
        populateCaseFromIB.populateCaseFromInstalledBase(newcaseList) ; 
    }
    
    /*
Operation:beforeInsert.
Purpose: to mark Is Redundant flag as true if the case is getting generated as a result of 
emails from customers for legacy Single Org cases belonging to OG  businesses.
*/
    public  void beforeInsertCaseAsRedundant(List<Case>  newcaseList) {
        GE_OG_trg_Case_ParentCaseAutoUnfollow   parentCaseAutoUnfollow = new GE_OG_trg_Case_ParentCaseAutoUnfollow () ;
        parentCaseAutoUnfollow.markCaseAsRedundant(newcaseList) ; 
    }
    
    /*
Operation:afterInsert, afterUpdate.
Purpose:deleting ids for 'EntitySubscription' recordtype-'MCS-CS'..
*/
    public  void afterInsertafterUpdateAutoUnfollow(List<Case>  newcaseList) {
        GE_OG_trg_Case_ParentCaseAutoUnfollow   parentCaseAutoUnfollow = new GE_OG_trg_Case_ParentCaseAutoUnfollow () ;
        parentCaseAutoUnfollow.mcsAutoUnfollowBasedOnCaseClosed(newcaseList) ; 
    }
    
    /*
Operation:afterInsert, afterUpdate.
Purpose:Sending Email alert for Cases raised against critical accounts.
*/
    public  void afterInsertafterUpdateMCSSendEmailCaseCreation(List<Case> newcaseList,Map<Id,Case>  newMapCase,Map<Id,Case>  oldMapCase) {
        GE_OG_trg_Case_MCSSendEmailCaseCreation   mcsSendEmailCaseCreation = new GE_OG_trg_Case_MCSSendEmailCaseCreation () ;
        mcsSendEmailCaseCreation.mcsSendEmailOnCaseCreation(newcaseList,newMapCase,oldMapCase) ; 
    }
    
    /*
Operation:afterInsert
Purpose:Close all tasks when case has closed
*/
    public void afterInsertMCSTaskUpdate(List<Case>  newcaseList) {
        GE_OG_trg_Case_ParentCaseAutoUnfollow   parentCaseAutoUnfollow = new GE_OG_trg_Case_ParentCaseAutoUnfollow () ;
        parentCaseAutoUnfollow.mcsTaskInsert(newcaseList);
    }
    
    /*
Operation:afterUpdate
Purpose:Close all tasks when case has closed
*/
    public void afterUpdateMCSTaskUpdate(List<Case>  newcaseList,Map<Id,Case>  OldMapCase) {
        GE_OG_trg_Case_ParentCaseAutoUnfollow   parentCaseAutoUnfollow = new GE_OG_trg_Case_ParentCaseAutoUnfollow () ;
        parentCaseAutoUnfollow.mcsTaskUpdate(newcaseList,OldMapCase);
    }
}