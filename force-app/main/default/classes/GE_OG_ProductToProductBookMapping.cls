/*
Class Name: GE_OG_ProductToProductBookMapping
Used Where ? : Used for Price Book Entry Automation
Purpose/Overview : Automates the manual process of creating price book entries for product insert/Update
Functional Area : Product Management
Author: Mohit Maheshwari
Created Date: 13/Oct/2015
Requirement : R-23545
Test Class Name : ProductAndPriceBookEnrty_GE_OG_Test
*/

public class GE_OG_ProductToProductBookMapping{
    
    //R-23545
    public void productBookEntryAutomation(List<Product2> lstProducts, Map<ID,Product2> mapOldProduct, Boolean isInsert){
        // Intialize variables
        Id stdProductBookId;
        Set<String> setprofileadmindev = new Set<String>();
        Set<String> setPermissionsetId = new Set<String>();
        Set<Id> productIds = new Set<Id>();
        for(Product2 iop : lstProducts){
            productIds.add(iop.Id);
        }
        
        List<PricebookEntry> lstStdPricebookEntries = new List<PricebookEntry>();
        // Get a list of CurrencyType
        List<CurrencyType> lstCurrency = [Select IsoCode From CurrencyType where ISACTIVE=TRUE];
        List<profile_permission_ge_og__c> lstprofileadmindev = profile_permission_ge_og__c.getAll().values();
        for(profile_permission_ge_og__c profileadmindev : lstprofileadmindev){
            System.debug('profileadmindev  >>> '+profileadmindev.Name);
            setprofileadmindev.add(profileadmindev.profile_id_ge_og__c);
        }
        
        List<PermissionSetAssignment> psa = [SELECT AssigneeId FROM PermissionSetAssignment WHERE PermissionSet.Name = 'Product_Edit'];
        for(PermissionSetAssignment ps : psa){
            //System.debug('ps >>>  '+ps.Assignee.Name);
            setPermissionsetId.add(ps.AssigneeId);
        }
        ID serviceMaxRecordTypeID = Schema.SObjectType.Product2.getRecordTypeInfosByName().get(system.label.Service_Max).getRecordTypeId();
        
        // Get a 'Standard Price Book' ID
        if(!Test.isRunningTest())
            stdProductBookId = [Select ID from Pricebook2 where Name = 'Standard Price Book' and IsStandard = True].ID;
        else
            stdProductBookId = Test.getStandardPricebookID();
        
        List<PricebookEntry> pe = [Select Product2Id,Id,Pricebook2Id,CurrencyIsoCode from PricebookEntry WHERE Product2Id IN :productIds and Pricebook2Id =: stdProductBookId];
        System.debug('productIds >> '+productIds);
        System.debug('pe.size()>>> +'+pe.size()+'  '+pe);
        System.debug('lstProducts >>> '+lstProducts);
        if(isInsert){
            // Logic to insert PriceBookEntries
            for(Product2 objProduct:lstProducts) {
                
                if(setprofileadmindev.size()>0 &&(!setprofileadmindev.contains(UserInfo.getprofileid()) && !setPermissionsetId.contains(UserInfo.getUserId()))&& objProduct.RecordTypeID !=  serviceMaxRecordTypeID ){
                    objProduct.adderror('You have insufficient permissions to create or edit or delete products.');
                }
                
                //if(objProduct.is_service_max_ge_og__c.ToUpperCase()==Label.No.ToUpperCase()){
                if(objProduct.RecordTypeID != serviceMaxRecordTypeID && !objProduct.isClone()){
                    
                    for(CurrencyType objCurrency:lstCurrency) {
                        PricebookEntry objPBE = new PricebookEntry();
                        objPBE.Product2Id = objProduct.Id;
                        objPBE.UseStandardPrice = False;
                        objPBE.UnitPrice = 0;
                        objPBE.CurrencyIsoCode = objCurrency.IsoCode;
                        objPBE.IsActive = objProduct.IsActive;
                        objPBE.Pricebook2Id = stdProductBookId;
                        lstStdPricebookEntries.add(objPBE);
                        
                    }
                }
            }
        }
        
        if(!isInsert){
            // create set of Products need to be 'Active/InActive' in PBE
            for(Product2 objProduct:lstProducts) {
                
                if(setprofileadmindev.size()>0 && (!setprofileadmindev.contains(UserInfo.getprofileid()) && !setPermissionsetId.contains(UserInfo.getUserId())) && objProduct.RecordTypeID !=  serviceMaxRecordTypeID ){
                    System.debug('test line 68');
                    objProduct.adderror('You have insufficient permissions to create or edit or delete products.');
                }
            }
        }
        
        if (lstStdPricebookEntries.size()>0 && !Test.isRunningTest()){
            insert lstStdPricebookEntries;
        }
    }
    
    
    public void ProductBookEntryAutomationDelete(List<Product2> lstProducts){
        
        Set<String> setprofileadmindev = new Set<String>();
        Set<String> setPermissionsetId = new Set<String>();
        List<profile_permission_ge_og__c> lstprofileadmindev = profile_permission_ge_og__c.getAll().values();
        for(profile_permission_ge_og__c profileadmindev : lstprofileadmindev){
            setprofileadmindev.add(profileadmindev.profile_id_ge_og__c);
        }
        List<PermissionSetAssignment> psa = [SELECT AssigneeId FROM PermissionSetAssignment WHERE PermissionSet.Name = 'Product_Edit'];
        for(PermissionSetAssignment ps : psa){
            setPermissionsetId.add(ps.AssigneeId);
        }
        
        ID serviceMaxRecordTypeID = Schema.SObjectType.Product2.getRecordTypeInfosByName().get(system.label.Service_Max).getRecordTypeId();
        
        for(Product2 objProduct:lstProducts) {
            if(setprofileadmindev.size()>0 && (!setprofileadmindev.contains(UserInfo.getprofileid()) && !setPermissionsetId.contains(UserInfo.getUserId())) && objProduct.RecordTypeID !=  serviceMaxRecordTypeID ){
                System.debug('test line 96');
                objProduct.adderror('You have insufficient permissions to create or edit or delete products.');
            }
        }
    }
}