@isTest
public class AddOpportunityToAsset_Helper_Test {
    @testSetup
    public static void testAddOpportunitytoAsset(){
        //creating 'Country Region Mapping' for 'INDIA'
        Country_Region_Mapping_ge_og__c objcustom = CommonTestDataFactory_GE_OG.createCountryRegionMappingData();
        insert objcustom;
        
        // Create Member Account
        Account acc1 = CommonTestDataFactory_GE_OG.createAccount ('TestAccount Member');
        system.assertEquals('TestAccount Member',acc1.Name);
        
        //Createing an Account 
        Account acc = CommonTestDataFactory_GE_OG.createCommercialParentAccountWithMember ('TestAccount Relation', acc1.ID);
        system.assertEquals('TestAccount Relation',acc.Name);
        
        //Creating an Opportunity
        Opportunity opp = CommonTestDataFactory_GE_OG.createOppty('Testopportunity',acc.ID);
        system.assertEquals('Testopportunity',opp.Name);
        
        /*
        Opportunity opp2 = CommonTestDataFactory_GE_OG.createOppty('Testopportunity2',acc.ID);
        system.assertEquals('Testopportunity2',opp2.Name);
        */
        Asset newasset = new Asset();
        newasset.Name = 'Test Asset';
        newasset.AccountId = acc.Id;
        newasset.CurrencyIsoCode = 'USD';
        newasset.Summary_Scope_of_Supply_ge_og__c ='Test newasset' ;  
        newasset.Asset_Type_ge_og__c = 'Drilling Rig';
        insert newasset;
              
    }  
    
    
    public static testMethod void testOpportunityStages1(){
        test.startTest();
        Opportunity opty = [Select Id,Name,ownerId from Opportunity where Name= 'Testopportunity'];
        Asset asst = [Select Id,Name from Asset where Name='Test Asset'];
        opty.Opportunity_Asset_ge_og__c = asst.Id;
        update opty;
        List<Opportunity> opList = new List<Opportunity>();
        opList.add(opty);
        AddOpportunityToAsset_GE_OG addOpptytoAsset = new AddOpportunityToAsset_GE_OG();
        addOpptytoAsset.after_Insert_Functionality(opList);
        test.stopTest();
    }
    
    public static void testMethod2 (){
        List<Opportunity> opList = [Select Id,Name from Opportunity where Name= 'Test Oppty'];
        AddOpportunityToAsset_GE_OG addOpptytoAsset = new AddOpportunityToAsset_GE_OG();
        // addOpptytoAsset.after_Update_Functionality(opList);
    }
    
    
    
    
}