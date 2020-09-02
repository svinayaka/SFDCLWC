/*
Class                  : MMIDemandWebService
Purpose/Overview       : Webservice to link/Unlink MMI Demand to/from opportunity
Scrum Team             : GRID
Requirement Number     : R-30136
Author                 : Sonali Rathore
Created Date           : 01-Jul-2018
Test Class Name        : MMIDemandWebService_Test
Code Coverage          : 
*/
global without sharing class MMIDemandWebService {
    
    public class DemandList {
        public String MMIDemandKey;
        public String Operations;
        public String OpportunityID;
        public List<LineItems> lineItems;
    }
    
    public class LineItems {
        public String Tierkey;
        public Decimal Amount;
    }
    
    public List<DemandList> DemandList;
    //Kiru  Added to stop runnign trigger - SOQL 100 limit exceeding
    public static Boolean stoptrigger = false;
    // method to parse the Json string
    webservice static string parse(String jsonstr){
        String result = 'Failure';
        stoptrigger = true;
        system.debug('jsonstr==='+jsonstr);
        //system.debug('DESE== '+System.JSON.deserialize(jsonstr, MMIDemandWebService.class));
        if(jsonstr != '' && jsonstr != NULL){
            MMIDemandWebService  demlist = (MMIDemandWebService) JSON.deserialize(jsonstr, MMIDemandWebService.class);
            system.debug('demlist === '+demlist );
            if(demlist != NULL){
                for(MMIDemandWebService.DemandList  demlistcl :demlist.DemandList  ){
                    system.debug('demlistlineitems === '+demlistcl.lineItems);
                    system.debug('Operation=== '+demlistcl.Operations);
                    system.debug('MMIKey=== '+demlistcl.MMIDemandKey);
                    system.debug('OpptyID=== '+demlistcl.OpportunityID);
                    if(demlistcl.MMIDemandKey != NULL && demlistcl.OpportunityID != NULL && demlistcl.Operations != NULL && demlistcl.lineItems != NULL){
                        result = processdata(demlistcl.MMIDemandKey, demlistcl.OpportunityID, demlistcl.Operations, demlistcl.lineItems);
                    }
                }
            }
        }
        else{
            result ='Failure';  
        }
        
        stoptrigger = false;
        return result;
    }
    
    //Method to check for Link/Unlink opeartion and process the data accordingly 
    public static string processdata(String demandid, String opptyid, String operation, List<LineItems> lineitm){
        String result = 'Failure';
        Opportunity oppty = [Select Id,MMI_Demand_Key_ge_og__c, CurrencyIsoCode/**, StageName, stage_ge_og__C**/ from Opportunity where id =: opptyid];
        if(oppty != NULL){
            // Check for Link operation
            if(operation=='Link'){
                system.debug('inside the Link Condition');
                if(oppty.MMI_Demand_Key_ge_og__c != null && oppty.MMI_Demand_Key_ge_og__c!= ''){
                    if(oppty.MMI_Demand_Key_ge_og__c == demandid){
                        system.debug('MMI oppty with same demand');
                        
                        //Search for MMI line item product and delete that line item.
                        List<OpportunityLineItem> existingOLI = [select id,Product2.Id,Is_MMI_Product_ge_og__c from OpportunityLineItem where opportunity.id =:opptyid and Is_MMI_Product_ge_og__c= TRUE];
                        if(existingOLI != NULL){
                            deleteOLI(oppty.Id,existingOLI);
                        }
                        //Insert a new OLI.
                        createOLI(demandid,oppty.Id,lineitm);
                      /**  List<Opportunity> newlstOpp = new List<Opportunity>();
                        Map<Id, Opportunity> oldmap = new Map<Id, Opportunity>();
                        oldmap.put(oppty.Id, oppty);
                        newlstOpp.add(oppty);
                        //creating instance of class 'ProcessOppRegionUpdate_GE_OG'
                        //calling method for 'GE O&G Region' and 'Install Country' Update on Oppty
                       OpportunityStagesAutomationHandler_GE_OG oppstage= new OpportunityStagesAutomationHandler_GE_OG();
                        system.debug('IN to stage process');
                        oppstage.updateOpportunityStage(newlstOpp,oldmap);
                        system.debug('Out of stage process'); **/
                        result='Success';
                    }else{
                        result = 'Failure-Please choose a different opportunity as this opportunity already has a MMI Demand associated  to it';
                        system.debug('Failure-Please choose a different opportunity as this opportunity already has a MMI Demand associated to it');
                    }
                }
                else if(oppty.MMI_Demand_Key_ge_og__c == null){
                    system.debug('Non MMI oppty with new demand');
                    
                    // Insert new Opptunity Line Item
                    createOLI(demandid,oppty.Id,lineitm);
                    result='Success';
                }
            }
            //Check for Unlink opeartion
            if(operation=='Unlink'){
                system.debug('inside the Unlink Condition');
                List<OpportunityLineItem> existingOLI = [select id,Product2.Id,Is_MMI_Product_ge_og__c from OpportunityLineItem where opportunity.id =:opptyid and Is_MMI_Product_ge_og__c= TRUE];
                //Delete OLI from Oppty
                deleteOLI(oppty.Id,existingOLI);
                result='Success';
                
            }
        }
        return result;
    }
    //method to create Opportunity Line Items
    public static void createOLI(String mmidemandid,String opportunityId,List<LineItems> lineitm){
        Opportunity oppty = [Select Id,MMI_Demand_Key_ge_og__c,CurrencyIsoCode from Opportunity where id =: opportunityId];
        List<String> prodIds = new List<String>();
        List<opportunityLineItem> insertOLI = new List<opportunityLineItem>();
        MMI_Product_Mapping_ge_og__c[] prodMetaData = [SELECT Name,ProductId__c, TierKey__c FROM MMI_Product_Mapping_ge_og__c where TierKey__c !='']; 
        if(prodMetaData != NULL){
            for (LineItems mmiLineItem : lineitm) {
                for (MMI_Product_Mapping_ge_og__c prodCustMeta: prodMetaData) {
                    if(prodCustMeta.TierKey__c == mmiLineItem.Tierkey){
                        PricebookEntry priceBook = [select id,Product2Id from PricebookEntry where Product2Id =:prodCustMeta.ProductId__c and CurrencyISOCode=:oppty.CurrencyIsoCode];
                        System.debug('inside Tier Key Comparison');
                        OpportunityLineItem OLI = new OpportunityLineItem();
                        OLI.opportunityId=oppty.Id;
                        OLI.Quantity=1;
                        OLI.MMI_Demand_Line_Amount_ge_og__c=mmiLineItem.Amount;
                        OLI.UnitPrice=mmiLineItem.Amount;
                        OLI.PricebookEntryId=priceBook.Id;
                        OLI.GE_OG_SS_Oppty_Product_CM__c=0;
                        oli.Is_MMI_Product_ge_og__c= TRUE;
                        insertOLI.add(OLI);
                    }
                }
                
            }
        }
        Database.SaveResult[] srList = Database.insert(insertOLI, false);
        
        // Iterate through each returned result
        for (Database.SaveResult sr : srList) {
            if (sr.isSuccess()) {
                // Operation was successful, so get the ID of the record that was processed
                System.debug('Successfully inserted account. Account ID: ' + sr.getId());
                
            }
            else {
                // Operation failed, so get all errors                
                for(Database.Error err : sr.getErrors()) {
                    System.debug('The following error has occurred.');                    
                    System.debug(err.getStatusCode() + ': ' + err.getMessage());
                    System.debug('Fields that affected this error: ' + err.getFields());
                }
            }
        }
        System.debug('Inside create method mmidemandid'+mmidemandid);
        // Update MMI Demand Key on Oppty
        Oppty.MMI_Demand_Key_ge_og__c=mmidemandid;
        Update Oppty;
        
    }
    //method to delete Opportunity Line Items
    public static void deleteOLI(String opportunityId,List<OpportunityLineItem> deleteList){
        Opportunity oppty = [Select Id,MMI_Demand_Key_ge_og__c from Opportunity where id =: opportunityId];
        Database.DeleteResult[] drList = Database.delete(deleteList, false);
        
        // Iterate through each returned result
        for(Database.DeleteResult dr : drList) {
            if (dr.isSuccess()) {
                // Operation was successful, so get the ID of the record that was processed
                System.debug('Successfully deleted OLI with ID: ' + dr.getId());
                
            }
            else {
                // Operation failed, so get all errors                
                for(Database.Error err : dr.getErrors()) {
                    System.debug('The following error has occurred.');                    
                    System.debug(err.getStatusCode() + ': ' + err.getMessage());
                    System.debug('Fields that affected this error: ' + err.getFields());
                    
                }
            }
        }
        //Delete deleteList;
        //Delete MMI demand Key on Oppty
        oppty.MMI_Demand_Key_ge_og__c=NULL;
        Update Oppty;
    }
    
}