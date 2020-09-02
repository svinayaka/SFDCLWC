/*
Class/Trigger Name     : KeyAssetEdit_GE_OG
Used Where ?           : O_PopulateMemberofOnAsset_GE_OG
Purpose/Overview       : When user is changing the Account of an Asset to anything outside the existing hierarchy 
Remove KeyAsset Record.
Scrum Team             : Opportunity Management
Requirement Number     : R-30237
Author                 : Harsha C
Created Date           : 14/NOV/2018
Test Class Name        : 
Code Coverage          : 
*/
public class KeyAssetEdit_GE_OG {
    public void removeKeyasset(List<Asset> newlstast, map<id, Asset> newMapast, List<Asset> oldlstast, map<Id, Asset> oldMapast){
        
        
        Set<Id> assetId = new Set<Id>();
        List<Key_Asset_ge_og__c> keyasset = new List<Key_Asset_ge_og__c>();
        for(Asset ast : newlstast){
            if(ast.AccountId != oldMapast.get(ast.Id).AccountId && (ast.Account_Member_of_ge_og__c != oldMapast.get(ast.Id).Account_Member_of_ge_og__c )) {
                assetId.add(ast.Id);
                System.debug(LoggingLevel.Info,'assetId ----> '+assetId);
            }
        }
        
        if(assetId != null ){
            keyasset = [Select Id from Key_Asset_ge_og__c where Asset_ge_og__c In :assetId]; 
            System.debug(LoggingLevel.Info,'keyasset ----> '+keyasset);
        }
        List<Id> keyAssetId = new List<Id>();
        for(Key_Asset_ge_og__c keyaet : keyasset ){
            keyAssetId.add(keyaet.Id);
        }
        
        
        if(keyAssetId != null)
        {
            System.debug(LoggingLevel.Info,'keyasset BEFORE Delete'+keyAssetId);
            try{
                Database.DeleteResult[] drList = Database.delete(keyAssetId, false);
                
            }
            catch(Exception e){
                System.debug('e.getcause() --->'+e.getCause());
                System.debug('e.getLineNumber() ---->'+e.getLineNumber());
                System.debug('e.getMessage()------>'+e.getMessage());
            }
            System.debug(LoggingLevel.Info,'keyasset AFTER Delete'+keyAssetId);
        }
    }
    
}