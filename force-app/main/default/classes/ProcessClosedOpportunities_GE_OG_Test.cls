/*
Class/Trigger Name     : ProcessClosedOpportunities_GE_OG_Test
Used Where ?           : Test Class
Purpose/Overview       : Used for Code Coverage of ProcessClosedOpportunities_GE_OG
Scrum Team             : Transformation - OPPTY MGMT
Requirement Number     : 
Author                 : Nitish Pandey
Created Date           : 25/02/2016
Used for Classes       : ProcessClosedOpportunities_GE_OG
*/


@isTest

public class ProcessClosedOpportunities_GE_OG_Test{
 @testsetup
    static void createRecord(){
       
        //Creating new account
        Test.StartTest();
        account acc = new account();
        acc.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        acc.name = 'Test Account';
        acc.Account_Tier_GEOG__c = 'Country';
        acc.Classification__c= 'Strategic';
        acc.Type = 'Direct Customer';
        acc.ShippingCountry = 'India';
        acc.Region_GEOG__c = 'India';
        insert acc;
        
      /*  account accComp = new account();
        accComp.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        accComp.name = 'Test Account Comp';
        accComp.Account_Tier_GEOG__c = 'Country';
        accComp.Classification__c= 'Strategic';
        accComp.Type = 'Competitor';
        accComp.ShippingCountry = 'India';
        accComp.Region_GEOG__c = 'India';
        insert accComp;*/
        
        
        
        OG_Trigger_fire_Decision__c tfd = new OG_Trigger_fire_Decision__c();
        tfd.isActive__c = true ;
        tfd.Object_Name__c = 'Account' ;
        tfd.Trigger_Name__c = 'GE_OG_Update_FinanceUpdateStatus' ;
        tfd.Name = 'Test';
        insert tfd;
        
        
        OG_Trigger_fire_Decision__c tfd1 = new OG_Trigger_fire_Decision__c();
        tfd1.isActive__c = true ;
        tfd1.Object_Name__c = 'Account' ;
        tfd1.Trigger_Name__c = 'AccountStrength_GEOG' ;
        tfd1.Name = 'Test';
        insert tfd1;
        
        
        //creating new opportuntiy
        opportunity opp = CommonTestDataFactory_GE_OG.createOppty('TestOppty', acc.id);
        
        system.debug('------REGION-##########-->>>>>>>>>>>>>>>>>>>'+[SELECT Id,region_ge_og__c FROM Opportunity WHERE Id=:opp.Id].region_ge_og__c);
        
        
        //Create Product
        Product2 product = CommonTestDataFactory_GE_OG.createProduct('Test Product');
        
        //Create Price Book Entry
        PriceBookEntry prBook= CommonTestDataFactory_GE_OG.createPriceBookEntry(product);
        
        //Craete oppty Product
        OpportunityLineItem oti = CommonTestDataFactory_GE_OG.createOpportunityLineItem(opp,prBook);
        
        
        
        Test.StopTest();

    }
    
    public static testMethod void processClosedOpportunities(){
        Account acc = CommonTestDataFactory_GE_OG.createAccount('Test AccountClosedOpp1');
        //Account acc = [SELECT Id FROM Account WHERE Name = 'Test Account'];
       //Account accComp = CommonTestDataFactory_GE_OG.createRelationshipAccount('Test AccountClosedOppCompetitor1');
        //account accComp = [SELECT ID FROM Account Where name ='Test Account Comp'];
        
        
        opportunity opp1 = new opportunity();
        opp1.name= 'TESTOPPTY';
        opp1.stageName = 'Prospecting';
        opp1.has_opportunitycontactrole_ge_og__c = True;
        opp1.region_ge_og__c = 'Test Region';
        opp1.Risk_Region_ge_og__c = 'Test Region';
        opp1.closedate = system.today().addDays(30);
        opp1.accountId = acc.Id;
        //Changed the below from Measurement & Control to Digital Solutions - kiru
        opp1.tier_2_ge_og__c ='Digital Solutions';
        opp1.tier_3_ge_og__c ='Bently Nevada';
        //opp.GE_Estimated_Amount__c = 1000.00;
        opp1.amount_ge_og__c =100.00;
        opp1.install_country_ge_og__c= 'India';       
        insert opp1;
        
         Test.startTest();
         
         
         Map<Id,Opportunity> mapOldOppty = new Map<Id,Opportunity>{opp1.Id => opp1};
         
         
         
        
        
        
        Opportunity opp2 = [select id, stage_ge_og__c, recordType.name, StageName, primary_reason_code_ge_og__c, primary_sub_reason_code_ge_og__c,delivery_date_ge_og__c from Opportunity where id=:opp1.id];
        opp2.stage_ge_og__c = 'Cancelled';
        opp2.primary_reason_code_ge_og__c = 'Alternate Solution';
        opp2.primary_sub_reason_code_ge_og__c = 'Alternate GE Solution';
        opp2.stageName = 'Cancelled';
        //opp2.opportunity_type_ge_og__c = 'Grouped Flow';
        opp2.RecordtypeId = Util_GE_OG.getRecordTypeDetails('Opportunity','O&G Closed').getRecordTypeId();
        update opp2;
        
        ProcessClosedOpportunities_GE_OG objClosedOppty = new ProcessClosedOpportunities_GE_OG();
        objClosedOppty.editAccessOnOpportunity(new List<opportunity>{opp2},mapOldOppty);
        
        system.debug('44444444444444444444444  ' + opp2.recordType.name);
        List<Opportunity> lstOpp = new List<opportunity>();
        
       
        Opportunity opp3 = [select id, stage_ge_og__c, recordType.name, primary_reason_code_ge_og__c,StageName, primary_sub_reason_code_ge_og__c,delivery_date_ge_og__c from Opportunity where id=:opp1.id];
        lstOpp.add(opp3);
        opp3.delivery_date_ge_og__c = system.today().addDays(30);
        update opp3;
        system.debug('555555555555555555555555    '+ opp3.StageName);
        Map<ID,Opportunity> oldOppMap = new Map<ID,Opportunity>();
        oldOppMap.put(opp3.id, opp3);
        
        //ProcessClosedOpportunities_GE_OG pco = new ProcessClosedOpportunities_GE_OG();
        //pco.editAccessOnOpportunity(lstOpp,oldOppMap);
        
        
        
        //try{
            opp3.StageName = 'Active';
            opp3.name = 'My New Test Name';
            update opp3;
            
            /*
            Opportunity opp4 = [select id, stage_ge_og__c, recordType.name, primary_reason_code_ge_og__c,StageName, primary_sub_reason_code_ge_og__c,delivery_date_ge_og__c from Opportunity where id=:opp1.id];
            Map<ID,Opportunity> oldOppMap1 = new Map<ID,Opportunity>();
            oldOppMap1.put(opp4.id, opp4);
            ProcessClosedOpportunities_GE_OG pco1 = new ProcessClosedOpportunities_GE_OG();
            pco1.editAccessOnOpportunity(lstOpp,oldOppMap1);
            */
        /*}
        catch (exception e){}*/
        
        Test.stopTest();
    }
    
    public static testMethod void processClosedOpportunities1(){
        Account acc = CommonTestDataFactory_GE_OG.createAccount('Test AccountClosedOpp2');
        //Account acc = [SELECT Id FROM Account WHERE Name = 'Test Account'];
       // Account accComp = CommonTestDataFactory_GE_OG.createRelationshipAccount('Test AccountClosedOppCompetitor2');
        //account accComp = [SELECT ID FROM Account Where name ='Test Account Comp'];
        
       // Oppty_Threshold__c OpptyThreshold= CommonTestDataFactory_GE_OG.createThresholdCustomSetting1();

        opportunity opp1 = new opportunity();
        opp1.name= 'TESTOPPTY';
        opp1.stageName = 'Prospecting';
        opp1.has_opportunitycontactrole_ge_og__c = True;
        opp1.region_ge_og__c = 'Test Region';
        opp1.Risk_Region_ge_og__c = 'Test Region';
        opp1.closedate = system.today().addDays(30);
        opp1.accountId = acc.Id;
        //Changed the below from Measurement & Control to Digital Solutions - kiru
        opp1.tier_2_ge_og__c ='Digital Solutions';
        opp1.tier_3_ge_og__c ='Bently Nevada';
        //opp.GE_Estimated_Amount__c = 1000.00;
        opp1.amount_ge_og__c =100.00;
        opp1.install_country_ge_og__c= 'India'; 
        insert opp1;
        
        //Create Product
        Product2 product = CommonTestDataFactory_GE_OG.createProduct('Test Product');
        
        //Create Price Book Entry
        PriceBookEntry prBook= CommonTestDataFactory_GE_OG.createPriceBookEntry(product);
        
        //Craete oppty Product
        OpportunityLineItem oti = CommonTestDataFactory_GE_OG.createOpportunityLineItem(opp1,prBook);
        
        Map<Id,Opportunity> mapOldOppty = new Map<Id,Opportunity>{opp1.Id => opp1};
         Test.startTest();
         
        Opportunity opp2 = [select id, stage_ge_og__c, recordType.name, StageName, primary_reason_code_ge_og__c, primary_sub_reason_code_ge_og__c,delivery_date_ge_og__c from Opportunity where id=:opp1.id];
        opp2.stage_ge_og__c = 'Cancelled';
        opp2.primary_reason_code_ge_og__c = 'Alternate Solution';
        opp2.primary_sub_reason_code_ge_og__c = 'Alternate GE Solution';
        opp2.stageName = 'Cancelled';
        //opp2.opportunity_type_ge_og__c = 'OG';
        opp2.RecordtypeId = Util_GE_OG.getRecordTypeDetails('Opportunity','O&G Closed').getRecordTypeId();
        update opp2;
        
        
        ProcessClosedOpportunities_GE_OG objClosedOppty = new ProcessClosedOpportunities_GE_OG();
        objClosedOppty.editAccessOnOpportunity(new List<opportunity>{opp2},mapOldOppty);
        
        
        
        system.debug('44444444444444444444444  ' + opp2.recordType.name);
        List<Opportunity> lstOpp = new List<opportunity>();
        
       
        opp2.delivery_date_ge_og__c = system.today().addDays(30);
        update opp2;
       
        /*try{
            delete oti;
        }
        catch (exception e){}*/
        
        
        Test.stopTest();
    }
    
    static testMethod void processClosedOpportunities2(){
        //ProcessClosedOpportunities_GE_OG p = new ProcessClosedOpportunities_GE_OG();
        ProcessClosedOpportunities_GE_OG.ProcessClosedOppties();
        
    }
}