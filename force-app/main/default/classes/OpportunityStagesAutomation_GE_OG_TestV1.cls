/*
    Class/Trigger Name     : OpportunityStagesAutomation_GE_OG_TestV1
    Purpose/Overview       : Test Class to calculate the code coverage for the OpportunityStagesAutomationHandler_GE_OG Class 
                             for OpportunityTrigger_GE_OG Trigger helper class
    Scrum Team             : Transformation - OPPTY MGMT
    Requirement Number     : R-23281
    Author                 : Nitish Pandey
    Created Date           : 17-Sep-2015
    Used For               : OpportunityStagesAutomationHandler_GE_OG - 90%
                             DealDeskOpportunityAutomation_GE_OG    
    */ 

    @isTest

    public class OpportunityStagesAutomation_GE_OG_TestV1
    {

        @testsetup
        static void createRecord()
        {
           Test.startTest(); 
           //creating 'Country Region Mapping' for 'INDIA'
           Country_Region_Mapping_ge_og__c objcustom = CommonTestDataFactory_GE_OG.createCountryRegionMappingData();
           insert objcustom;
           
           /* Create Opportunity Reason Code Custom Setting */
           List<Opportunity_Primary_Reason_Has_Code__c> lstReasonCode = CommonTestDataFactory_GE_OG.createPrimaryReasonCustomSetting();
           insert lstReasonCode;
           
           
           // Create Member Account
           Account acc1 = CommonTestDataFactory_GE_OG.createAccount ('TestAccount Member');
           system.assertEquals('TestAccount Member',acc1.Name);
           
           //Createing an Account 
           Account acc = CommonTestDataFactory_GE_OG.createCommercialParentAccountWithMember ('TestAccount Relation', acc1.ID);
           system.assertEquals('TestAccount Relation',acc.Name);
           
           //Now
           //Account accmem = CommonTestDataFactory_GE_OG.createRelationshipAccount('TestAccount Relation 1');
           //system.assertEquals('TestAccount Relation 1',accmem.Name);
           
           //Createing an Account
           Account accLE = CommonTestDataFactory_GE_OG.createLegalEntityAccountWithMember('TestAccount Legal',acc.ID,acc1.ID);
           system.assertEquals('TestAccount Legal',accLE.Name);
           
           
           //Now Create Test Account for ContactSumTrigger
           //String TestContactAccountName = system.Label.Test_Account_Name;
           //Account testacc = CommonTestDataFactory_GE_OG.createCommercialParentAccount(TestContactAccountName);
           
            
           //Create Legal Account with Type 'Internal' 
           Account accInternal = CommonTestDataFactory_GE_OG.createInternalLegalEntity('TestAccount Internal');
           //system.assertEquals('TestAccount Internal',accInternal.Name);
           
           //Creating an Opportunity
           Opportunity opp = CommonTestDataFactory_GE_OG.createOppty('Testopportunity',acc.ID);
           system.assertEquals('Testopportunity',opp.Name);
            
           //Creating a Product
           Product2 prod1 = CommonTestDataFactory_GE_OG.createProduct('testProduct');
           system.assertEquals('testProduct',prod1.Name);
           List<PriceBookEntry> lstPBE = new List<PriceBookEntry>();
           lstPBE = [Select ID from PriceBookEntry where CurrencyISOCode = 'USD' and isactive = true limit 1];
           //lstPBE.add(PBE);
           
           
           //Create OpportunityLineItem 
           if(lstPBE.size()==0){
                PricebookEntry objPBE = new PricebookEntry();
                objPBE.Product2Id = prod1.Id;
                objPBE.UseStandardPrice = False;
                objPBE.UnitPrice = 0;
                objPBE.CurrencyIsoCode = 'USD';
                objPBE.IsActive = prod1.IsActive;
                objPBE.Pricebook2Id = Test.getStandardPricebookID();
                insert  objPBE;
                lstPBE = new List<PriceBookEntry>();
                lstPBE = [Select ID from PriceBookEntry where CurrencyISOCode = 'USD' and isactive = true limit 1];
           }
           system.assertEquals(1,lstPBE.size());
           if(lstPBE.size()>0){
                List<OpportunityLineItem> lstOLI = new List<OpportunityLineItem>();
                lstOLI = CommonTestDataFactory_GE_OG.createOpportunityLineItemSameTier(opp, lstPBE);
                if(lstOLI.size()>0){
                    insert lstOLI;
                }
           }
           Test.stopTest();
       }
        
       
        
        
        public static testMethod void testExpressOpptyAutomation_new41()
        {
            Test.startTest();
            Account accLE = [select id from account where name='TestAccount Legal'];
            Account accInternal = [Select ID, Name from Account where Name = 'TestAccount Internal'];
            Map<id,Opportunity> oldOpptyMap = new Map<id,Opportunity>();
            List<Opportunity> newOpptyList;
            
            Map<String, Boolean> mapOppPrimaryReason = new Map<String,Boolean>();
            mapOppPrimaryReason.put('Test', True);
            
            Opportunity_Stage_Won_Lost_Nego_GE_OG oswl = new Opportunity_Stage_Won_Lost_Nego_GE_OG();
            
             contact objcont = new contact();
            objcont.Email = 'test@sfdc.com';
            objcont.firstname = 'test';
            objcont.lastname = 'test';
            objcont.accountid =  accLE.id;
            insert objcont; 
                        
            // Opportunity oppty = [select id, has_opportunitycontactrole_ge_og__c, oppty_cm_ge_og__c, risk_checklist_submitted_ge_og__c, accountId, fulfillment_checklist_submitted_ge_og__c,recordtypeId, region_ge_og__c, bid_to_win_approval_ge_og__c, legal_entity_ge_og__c  from opportunity where Name = 'Testopportunity'];
            Opportunity oppty = [select id, has_opportunitycontactrole_ge_og__c, oppty_cm_ge_og__c, accountId, fulfillment_checklist_submitted_ge_og__c,recordtypeId, region_ge_og__c, bid_to_win_approval_ge_og__c, legal_entity_ge_og__c  from opportunity where Name = 'Testopportunity'];
            
            opportunitycontactrole objocr = new opportunitycontactrole();
            objocr.opportunityid = oppty.id;
            objocr.role = 'Technical';
            objocr.ContactId = objcont.id;
            insert objocr;
            oppty.install_country_ge_og__c = 'India';
            update oppty;
            oppty.quote_type_ge_og__c = 'Bid Competitive / Tender';
            oppty.has_opportunitycontactrole_ge_og__c =true ;
            oppty.deal_path_ge_og__c = 'Deal Desk';
            oppty.need_comm_ops_support_ge_og__c = true;
            oppty.has_commercial_primary_resource_ge_og__c = True;
            oppty.end_user_ge_og__c= accLE.id;
            oppty.install_country_ge_og__c= 'India';
            oppty.oppty_cm_ge_og__c =  15;
            oppty.bid_due_date_ge_og__c= system.today();
            oppty.rfq_received_date_ge_og__c = system.today();
            oppty.pre_bid_evaluation_ge_og__c = true;
            oppty.bid_no_bid_approval_ge_og__c = true;
            oppty.delivery_date_ge_og__c = system.today();
            oppty.isbudgetary_ge_og__c = 'Firm Fixed';
            oppty.sub_industry_ge_og__c = 'XYZ'; 
            oppty.bid_to_win_approval_ge_og__c = True;
            oppty.legal_entity_ge_og__c = accLE.id;
            oppty.ge_legal_entity_ge_og__c = accInternal.ID;
            CheckRecursion_GE_OG.run =true; //handling recursion Scenario
            oppty.primary_reason_code_ge_og__c = 'XYZ';
            oppty.primary_sub_reason_code_ge_og__c = 'ABC';
            CheckRecursion_GE_OG.run =false; //handling recursion Scenario
            try{
                update oppty;
            }
            catch(exception e){
            
            }
                       
            Opportunity oppty1 = [select id, stage_ge_og__c, StageName, competitor_required_ge_og__c, competitor_ge_og__c, competitor_1_ge_og__c, Is_express_ge_og__c, primary_reason_code_ge_og__c, primary_sub_reason_code_ge_og__c  from opportunity where Name = 'Testopportunity'];
                        
            try{
                oppty1.stage_ge_og__c = 'Closed Lost';
                oppty1.primary_reason_code_ge_og__c = 'Test';
                oppty1.primary_sub_reason_code_ge_og__c = 'Test';
                oppty1.disposition_comments_ge_og__c = 'Closed';
                oppty1.competitor_ge_og__c = True;
                oppty1.competitor_1_ge_og__c = 'Test';
                
                
                CheckRecursion_GE_OG.run =true; //handling recursion Scenario
                
                update oppty1;
                system.debug('iiiiiiiiiiiiiiiiiiiiiiiiiiii    '+ [select id, stageName from Opportunity where id=:oppty.id]);
                
            }
            catch(exception e){
                system.debug('exxxxxxxxxxx     ' + e);
            }
            Test.stopTest();
        }
        
        public static testMethod void testExpressOpptyAutomation_canStg()
        {
            
            
            //Account accCountry = [select id from account where name='Test Account Country'];
            Account accLE = [select id from account where name='TestAccount Legal'];
            
            Account accInternal = [Select ID, Name from Account where Name = 'TestAccount Internal'];
            
            Opportunity_Primary_Reason_Has_Code__c opr = new Opportunity_Primary_Reason_Has_Code__c();
            opr.has_primary_sub_reason_code_ge_og__c = true;
            opr.primary_reason_code_ge_og__c ='Funding';
            opr.name ='Funding';
            insert opr;
            
            contact objcont = new contact();
            objcont.Email = 'test@sfdc.com';
            objcont.accountid =  accLE.id;
            objcont.firstname = 'test';
            objcont.lastname = 'test';
            insert objcont;
            
            
            
           // try{
            //Opportunity oppty = [select id, has_opportunitycontactrole_ge_og__c, risk_checklist_submitted_ge_og__c, accountId, fulfillment_checklist_submitted_ge_og__c,recordtypeId, region_ge_og__c, bid_to_win_approval_ge_og__c, legal_entity_ge_og__c  from opportunity where Name = 'Testopportunity'];
            Opportunity oppty = [select id, has_opportunitycontactrole_ge_og__c, accountId, fulfillment_checklist_submitted_ge_og__c,recordtypeId, region_ge_og__c, bid_to_win_approval_ge_og__c, legal_entity_ge_og__c  from opportunity where Name = 'Testopportunity'];
            oppty.install_country_ge_og__c = 'India';
             
            update oppty;
            Test.startTest();

            oppty.quote_type_ge_og__c = 'Bid Competitive / Tender';
            oppty.has_opportunitycontactrole_ge_og__c =true ;
           // oppty.deal_path_ge_og__c = 'Express';
            //oppty.Is_express_ge_og__c = 'Yes';
            oppty.need_comm_ops_support_ge_og__c = true;
            oppty.has_commercial_primary_resource_ge_og__c = True;
            oppty.end_user_ge_og__c= accLE.id;
            oppty.install_country_ge_og__c= 'India';
            oppty.bid_due_date_ge_og__c= system.today();
            oppty.delivery_date_ge_og__c = null;
            oppty.isbudgetary_ge_og__c = 'Firm Fixed';
            oppty.sub_industry_ge_og__c = 'XYZ'; 
            oppty.legal_entity_ge_og__c = accLE.id;
           // oppty.convertible_ge_og__c = 'No';
            oppty.ge_legal_entity_ge_og__c = accInternal.ID;
            oppty.bid_sent_date_ge_og__c = System.Today();
            oppty.bid_sent_ge_og__c = True;
            system.debug('eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee1  '+ [select id, stage_ge_og__c from opportunity where id=:oppty.id]);
            oppty.primary_reason_code_ge_og__c = 'Funding' ;
            oppty.primary_sub_reason_code_ge_og__c = 'Alternate Channel';
            oppty.stage_ge_og__c = System.Label.Cancelled;
           
            
            CheckRecursion_GE_OG.run =true; //handling recursion Scenario
           try{
                update oppty;
                 Map<id,Opportunity> oldOpptyMap = new Map<id,Opportunity>();
                List<Opportunity> newOpptyList =  [select id, StageName, stage_ge_og__c, primary_reason_code_ge_og__c, primary_sub_reason_code_ge_og__c from opportunity where id=:oppty.id];
                
                Map<String, Boolean> mapOppPrimaryReason = null;
                Opportunity_Stage_Won_Lost_Nego_GE_OG oswln = new Opportunity_Stage_Won_Lost_Nego_GE_OG();
                oswln.checkedCancelled(newOpptyList, oldOpptyMap, mapOppPrimaryReason);
                
                system.debug('eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee  '+ [select id, stage_ge_og__c from opportunity where id=:oppty.id]);
             }
             
             catch(exception e){
             
             }
            Test.stopTest();
          
        }
        
        public static testMethod void testExpressOpptyAutomation_canStg1()
        {
            
            
            //Account accCountry = [select id from account where name='Test Account Country'];
            Account accLE = [select id from account where name='TestAccount Legal'];
            
            Account accInternal = [Select ID, Name from Account where Name = 'TestAccount Internal'];
            
            Opportunity_Primary_Reason_Has_Code__c opr = new Opportunity_Primary_Reason_Has_Code__c();
            opr.has_primary_sub_reason_code_ge_og__c = false;
            opr.primary_reason_code_ge_og__c ='Funding';
            opr.name ='Funding';
            insert opr;
            
            contact objcont = new contact();
            objcont.Email = 'test@sfdc.com';
            objcont.accountid =  accLE.id;
            objcont.firstname = 'test';
            objcont.lastname = 'test';
            insert objcont;
            
            
            
           // try{
            //Opportunity oppty = [select id, has_opportunitycontactrole_ge_og__c, risk_checklist_submitted_ge_og__c, accountId, fulfillment_checklist_submitted_ge_og__c,recordtypeId, region_ge_og__c, bid_to_win_approval_ge_og__c, legal_entity_ge_og__c  from opportunity where Name = 'Testopportunity'];
            Opportunity oppty = [select id, has_opportunitycontactrole_ge_og__c, accountId, fulfillment_checklist_submitted_ge_og__c,recordtypeId, region_ge_og__c, bid_to_win_approval_ge_og__c, legal_entity_ge_og__c  from opportunity where Name = 'Testopportunity'];
            oppty.install_country_ge_og__c = 'India';
             
            update oppty;
            Test.startTest();

            oppty.quote_type_ge_og__c = 'Bid Competitive / Tender';
            oppty.has_opportunitycontactrole_ge_og__c =true ;
           // oppty.deal_path_ge_og__c = 'Express';
            //oppty.Is_express_ge_og__c = 'Yes';
            oppty.need_comm_ops_support_ge_og__c = true;
            oppty.has_commercial_primary_resource_ge_og__c = True;
            oppty.end_user_ge_og__c= accLE.id;
            oppty.install_country_ge_og__c= 'India';
            oppty.bid_due_date_ge_og__c= system.today();
            oppty.delivery_date_ge_og__c = null;
            oppty.isbudgetary_ge_og__c = 'Firm Fixed';
            oppty.sub_industry_ge_og__c = 'XYZ'; 
            oppty.legal_entity_ge_og__c = accLE.id;
            //oppty.convertible_ge_og__c = 'No';
            oppty.ge_legal_entity_ge_og__c = accInternal.ID;
            oppty.bid_sent_date_ge_og__c = System.Today();
            oppty.bid_sent_ge_og__c = True;
            system.debug('eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee1  '+ [select id, stage_ge_og__c from opportunity where id=:oppty.id]);
            oppty.primary_reason_code_ge_og__c = 'Funding' ;
            oppty.primary_sub_reason_code_ge_og__c = 'Alternate Channel';
            oppty.stage_ge_og__c = System.Label.Cancelled;
           
            
            CheckRecursion_GE_OG.run =true; //handling recursion Scenario
            try{
                update oppty;
                 Map<id,Opportunity> oldOpptyMap = new Map<id,Opportunity>();
                List<Opportunity> newOpptyList =  [select id, StageName, stage_ge_og__c, primary_reason_code_ge_og__c, primary_sub_reason_code_ge_og__c from opportunity where id=:oppty.id];
                
                Map<String, Boolean> mapOppPrimaryReason = null;
                Opportunity_Stage_Won_Lost_Nego_GE_OG oswln = new Opportunity_Stage_Won_Lost_Nego_GE_OG();
                oswln.checkedCancelled(newOpptyList, oldOpptyMap, mapOppPrimaryReason);
                
                system.debug('eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee  '+ [select id, stage_ge_og__c from opportunity where id=:oppty.id]);
             }
             
             catch(exception e){
             
             }
            Test.stopTest();
          }
        
    }