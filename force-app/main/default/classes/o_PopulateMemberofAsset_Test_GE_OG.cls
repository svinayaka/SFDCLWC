/*
Class/Trigger Name  :   o_PopulateMemberofAsset_Test_GE_OG 
Purpose/Overview    :   Used to cover O_PopulateMemberofOnAssetHandler_GE_OG
Scrum Team          :   OPPTY MGMT
Requirement Number  : 
Author              :   Rupal Seth
Created Date        :   27/MAR/2018
Test Class Name     :   O_Campaign_GE_OG_Test
Code Coverage       : 
*/

@isTest
public class o_PopulateMemberofAsset_Test_GE_OG{
    public static testMethod void createRecord(){
    //User u = [Select id,isActive from User Where Profile.name='GE_ES Developer' AND isActive = true limit 1];    
    //User u1 = [Select id,isActive from User Where Profile.name='System Administrator' AND isActive = true limit 1];
    Account acc = new Account();
        acc.recordtypeid= Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
        acc.name = 'Test Account';
        acc.ShippingCountry = 'India';
        acc.GE_ES_Primary_Industry__c = 'Drilling';
        acc.Classification__c= 'Strategic';
        acc.Type = 'Direct Customer';
        insert acc;
        
        Account acc1 = new Account();
        acc1.recordtypeid= Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
        acc1.name = 'Test Account';
        acc1.ShippingCountry = 'India';
        acc1.GE_ES_Primary_Industry__c = 'Drilling';
        acc1.Classification__c= 'Strategic';
        acc1.Type = 'Direct Customer';
        insert acc1;
        
    Asset a = new Asset();
    a.Name = 'TestAsset';
    a.AccountId = acc.id;
    a.Summary_Scope_of_Supply_ge_og__c = 'Test';
    a.Asset_Type_ge_og__c = 'Drilling Rig';
	insert a;
        
    a.AccountId = acc1.id;
    a.Summary_Scope_of_Supply_ge_og__c = 'Test again';
    update a;
    List<Asset> assetList = new List<Asset>();
    assetList.add(a);
    Map<Id,Asset> assetMap = new Map<Id,Asset>();
    assetMap.put(a.Id,a);
        
    O_AssetHelper_GE_OG.AddAssetOwnerToAssetTeam(assetList,'Insert',assetMap);
       
    }
    
    public static testMethod void updateRecord(){
    User u = [Select id,isActive from User Where Profile.name='GE_ES Developer' AND isActive = true limit 1];    
    User u1 = [Select id,isActive from User Where Profile.name='System Administrator' AND isActive = true limit 1];
    Account acc = new Account();
        acc.recordtypeid= Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
        acc.name = 'Test Account';
        acc.ShippingCountry = 'India';
        acc.GE_ES_Primary_Industry__c = 'Drilling';
        acc.Classification__c= 'Strategic';
        acc.Type = 'Direct Customer';
        insert acc;
        
        Account acc1 = new Account();
        acc1.recordtypeid= Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
        acc1.name = 'Test Account';
        acc1.ShippingCountry = 'India';
        acc1.GE_ES_Primary_Industry__c = 'Drilling';
        acc1.Classification__c= 'Strategic';
        acc1.Type = 'Direct Customer';
        insert acc1;
        
    Asset a = new Asset();
    a.Name = 'TestAsset';
    a.AccountId = acc.id;
    a.Summary_Scope_of_Supply_ge_og__c = 'Test';
    a.Asset_Type_ge_og__c = 'Drilling Rig';
    a.OwnerId = UserInfo.getUserId();
	insert a;
    List<Asset> assetList = new List<Asset>();
    assetList.add(a);
    Map<Id,Asset> assetMap = new Map<Id,Asset>();
    assetMap.put(a.Id,a);
        
    a.AccountId = acc1.id;
    a.Summary_Scope_of_Supply_ge_og__c = 'Test again';
    a.OwnerId = u.Id;
    update a;
        
    BHGE_Asset_Team_ge_og__c astTeam = new BHGE_Asset_Team_ge_og__c();
    astTeam.Asset__c = a.Id;
    astTeam.User__c = u1.Id;
    astTeam.Team_Role_ge_og__c = 'Sales';
    insert astTeam;
        
    O_AssetHelper_GE_OG.AddAssetOwnerToAssetTeam(assetList,'Update',assetMap);
       
    }
}