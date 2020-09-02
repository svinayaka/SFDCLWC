@isTest
public class TestRelationship_HierarchyController{
    public static testMethod void testMethod1(){
        test.startTest();
        /*country_region_mapping_ge_og__c objCustomSetting = new country_region_mapping_ge_og__c();
        objCustomSetting.country_name_ge_og__c = 'INDIA';
        objCustomSetting.region_ge_og__c = 'INDIA';
        objCustomSetting.Name = '1';
        insert objCustomSetting;*/
        
        AccountTestDataFactory.createStaticCountryRegionMappingData();
        Relationship_HierarchyController rController = new Relationship_HierarchyController();
        rController.seacrchForCountry();
        rController.seacrchForRegion();
        rController.seacrchForHQ();
        rController.processSelectedAccount();
        rController.goBack();
        rController.createRelationshipAccount();
        test.stopTest();
    }
    
    public static testMethod void testMethod2(){
        test.startTest();
        Relationship_HierarchyController rController = new Relationship_HierarchyController();
        Account objSelectedAccount = new Account(name='Test Selected',Type='Direct Customer',Classification__c='Unclassified',Account_Tier_GEOG__c='Country');
        insert objSelectedAccount;
        rController.strSlectedId = objSelectedAccount.id;
        ApexPages.CurrentPage().getParameters().put('tier','Country');
        rController.processSelectedAccount();
        
        Account objSelectedAccountReg = new Account(name='Test Selected Regional',Type='Direct Customer',Classification__c='Unclassified',Account_Tier_GEOG__c='Regional');
        insert objSelectedAccountReg;
        objSelectedAccount.parentId = objSelectedAccountReg.id;
        update objSelectedAccount;
        rController.processSelectedAccount();
        ApexPages.CurrentPage().getParameters().put('tier','Regional');
        rController.processSelectedAccount();
        ApexPages.CurrentPage().getParameters().put('tier','Global');
        rController.processSelectedAccount();
        test.stopTest();
    }
    
    public static testMethod void testMethod3(){
        test.startTest();
        Relationship_HierarchyController rController = new Relationship_HierarchyController();
        Account objSelectedAccountHQ = new Account(name='Test Selected / HQ',Type='Direct Customer',Classification__c='Unclassified',Account_Tier_GEOG__c='Global');
        insert objSelectedAccountHQ;
        rController.lstHQFinal.add(objSelectedAccountHQ);
        
        Account objSelectedAccountReg = new Account(name='Test Selected Regional / Regional',Type='Direct Customer',Classification__c='Unclassified',Account_Tier_GEOG__c='Regional',parentId=objSelectedAccountHQ.id);
        insert objSelectedAccountReg;
        rController.lstRegionalFinal.add(objSelectedAccountReg);
        
        Account objSelectedAccount = new Account(name='Test Selected',Type='Direct Customer',Classification__c='Unclassified',Account_Tier_GEOG__c='Country',parentId=objSelectedAccountReg.id);
        insert objSelectedAccount;
        rController.lstCountryFinal.add(objSelectedAccount);
        
        rController.linkSelectedAccount();
        
        rController.isCountry =true;
        rController.isRegional =true;
        rController.linkSelectedAccount();
        
        rController.isCountry =false;
        rController.isRegional =true;
        rController.isGlobal =true;
        rController.linkSelectedAccount();
        
        rController.isCountry =true;
        rController.isRegional =false;
        rController.isGlobal =true;
        rController.linkSelectedAccount();
        test.stopTest();
    }
    
    public static testMethod void testPopulate(){
        test.startTest();
        Relationship_HierarchyController rController = new Relationship_HierarchyController();
        rController.selectedCountry = 'INDIA';
        /*country_region_mapping_ge_og__c objCustomSetting = new country_region_mapping_ge_og__c();
        objCustomSetting.country_name_ge_og__c = 'INDIA';
        objCustomSetting.region_ge_og__c = 'INDIA';
        objCustomSetting.Name = '1';
        insert objCustomSetting;*/
        AccountTestDataFactory.createStaticCountryRegionMappingData();
        
        rController.populateValuesCountry();
        rController.populateValuesRegion();
        rController.populateValuesHQ();
        test.stopTest();
    }
    
    public static testMethod void testCreateAccount(){
        test.startTest();
        Relationship_HierarchyController rController = new Relationship_HierarchyController();
        ApexPages.CurrentPage().getParameters().put('tier','Country');
        rController.createRelationshipAccount();
        
        ApexPages.CurrentPage().getParameters().put('tier','Regional');
        rController.createRelationshipAccount();
        
        ApexPages.CurrentPage().getParameters().put('tier','Global');
        rController.createRelationshipAccount();
        test.stopTest();
    }
}