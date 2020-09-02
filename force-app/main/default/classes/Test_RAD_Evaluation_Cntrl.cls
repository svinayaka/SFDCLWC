@istest
public class Test_RAD_Evaluation_Cntrl {

@testsetup
    public static void createAccount()
    {
   // GE_ES_CustomerGalaxyIntegrationWrapper.IsFromTest = true;
    
        /*Account buyer = new Account();
     
        User u=[select id,firstname,lastname,email from User where id=:userinfo.getUserId()];   
                
        buyer.Name='Test Acc For TestClass';  
        buyer.GE_HQ_Request_Status__c='CMF Approved';
        buyer.GE_HQ_KYC_Complete__c=TRUE;
        buyer.GE_PRM_KYC_Completed__c=TRUE;
        buyer.GE_HQ_DUNS_Number__c='555123459';  
        buyer.GE_OG_Buss_Tier1__c='Oil & Gas (O&G)';
        buyer.GE_OG_Buss_Tier2__c='Lufkin';
        buyer.GE_OG_Buss_Tier3__c='Oilfield';
        buyer.GE_PW_Country_Quote_To_Sold_To_HQ__c='UNITED STATES';
        buyer.GE_PW_City_Quote_To_Sold_To_HQ__c='city';
        buyer.GE_PW_State_Province_Quote_To_Sold_To_HQ__c='state';
        buyer.GE_PW_Zip_Postal_Code_Quote_To_Sold_ToHQ__c='zip';
        buyer.GE_PW_Country_Bill_To__c='UNITED STATES';
        buyer.GE_PW_City_Bill_To__c='United States';
        buyer.GE_PW_State_Province_Bill_To__c='state';
        buyer.GE_PW_Zip_Postal_Code_Bill_To__c='560068';
        buyer.GE_PW_Country_Ship_To__c='UNITED STATES';
        buyer.GE_PW_City_Ship_To__c='city';
        buyer.GE_PW_State_Province_Ship_To__c='state';
        buyer.GE_PW_Zip_Postal_Code_Ship_To__c='zip';
        buyer.GE_HQ_New_Account_Country__c = 'UNITED STATES';
        buyer.GE_HQ_Nts_Comments__c='Test';
        
         Schema.DescribeSObjectResult accObj = Schema.SObjectType.Account; 
        Map<String,Schema.RecordTypeInfo> accByName = accObj.getRecordTypeInfosByName();
        Schema.RecordTypeInfo rtByName_acc =  accByName.get('CMF Approved');
        Id acc=rtByName_acc.getRecordTypeId();
        buyer.RecordTypeId=acc;
        buyer.GE_OG_AccFin_Status__c='In Progress';
        buyer.GE_HQ_Request_Status__c ='CMF Approved';
        buyer.ShippingCountry ='ARGENTINA';
        buyer.GE_PW_Phone_New_Request__c='(111)111-1111';
        insert buyer;
        
        Project_ge_og__c prj = new Project_ge_og__c();
        prj.Name = 'TestProject1';
        prj.GE_OG_SS_First_Oil_Date__c=Date.today();
        insert prj;
        
        upsert new GE_Configuration_Setting__c(Name = 'OG Counter',GE_OG_SS_WSIDCntr__c=0,GE_OG_PII_OIDCnt__c=0,GE_OGGS_Oppty_ID__c=0,GE_OG_Oppty_Id_Counter__c=0,GE_OG_DTS_OpptyID__c=0) Name;*/ 
        //upsert new GE_Profile__c(Name='GE_ES System Integration',Profile_SFDC_ID__c='00eA0000000EHeBIAW',Profile_Name__c='GE_ES System Integration') Name;
        
        /*Opportunity oppty = new Opportunity();
        oppty.RecordTypeId =Util_GE_OG.getRecordTypeDetails('Opportunity','O&G').getRecordTypeId();
        oppty.Name= 'Test Oppty1';
        oppty.GE_ES_Project__c = prj.Id;
        oppty.AccountId = buyer.Id;
        oppty.Type = 'Primary';
        oppty.StageName = 'propespect';
        oppty.CurrencyIsoCode = 'USD';
        oppty.bid_due_date_ge_og__c = Date.today();
        oppty.CloseDate= Date.today();
      //  oppty.GE_OG_TM_Commercial_Center__c= 'Bari';
        oppty.GE_OG_Stream__c = 'Core Services - Aberdeen';
        oppty.GE_OG_TM_Quote_Type__c = 'Budget';
        oppty.GE_OG_TM_Industrial_Sector__c = 'LNG';
        oppty.GE_OG_TM_Generate_ID__c = True;
        oppty.GE_OG_TM_Subsector__c = 'CCR';
        oppty.GE_OG_TM_Application_Center__c = 'Bari';
        oppty.rfq_received_date_ge_og__c = Date.today();
        oppty.GE_OG_TM_Proposal_Assesment__c = 'Tech & Comm With Same Due Date';
        oppty.end_user_ge_og__c = buyer.Id;
        oppty.oppty_cm_ge_og__c = 35;
        oppty.tier_2_ge_og__c = 'TMS';
        Oppty.commercial_primary_resource_ge_og__c = userInfo.getuserId();
        Oppty.ownerId = userInfo.getuserId();
        Oppty.tier_3_ge_og__c = 'Opex CS';
        
        insert oppty;*/
        
        
        
        
        
        account acc = new account();
        acc.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        acc.name = 'Test Account';
        acc.Account_Tier_GEOG__c = 'Country';
        acc.Classification__c= 'Strategic';
        acc.Type = 'Direct Customer';
        acc.ShippingCountry = 'India';
        acc.Region_GEOG__c = 'India';
        
        insert acc;
        
        
        
        /*account accnt= new account();
        accnt.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','New Competitor').getRecordTypeId();
        accnt.name = 'GE Oil & Gas';
        accnt.Account_Tier_GEOG__c = 'Global';
        accnt.Classification__c= 'Strategic';
        accnt.Type = 'Direct Customer';
        accnt.ShippingCountry = 'India'; 
        insert accnt;*/
        
        
        
        //creating new opportuntiy
        opportunity opp = CommonTestDataFactory_GE_OG.createOppty('Test Oppty1', acc.id);
        
        
        
        
        
        ID userid = UserInfo.getUserID();
        
       // User objuser1 = [Select ID, GE_HQ_SSO_ID__c from User where ID =: userid];
        
        eRAD_TMS_Approver_IDs__c cusset = new eRAD_TMS_Approver_IDs__c();
        cusset.name ='TMS - Opex CS';
        cusset.SSO_ID__c = '105032217';
        //cusset.SSO_ID__c = ''+objuser1.GE_HQ_SSO_ID__c;
        cusset.User_Name__c = 'Marco Valerio Cartocci';
        insert cusset;
        
        cusset = new eRAD_TMS_Approver_IDs__c();
        cusset.name ='TMS - Upgrades';
        cusset.SSO_ID__c = '105052370';
        //cusset.SSO_ID__c = ''+objuser1.GE_HQ_SSO_ID__c;
        cusset.User_Name__c = 'Riccardo Di Placido';
        insert cusset;
        
        cusset = new eRAD_TMS_Approver_IDs__c();
        cusset.name ='New Units / CS - LNG';
        cusset.SSO_ID__c = '105052370';
        //cusset.SSO_ID__c = ''+objuser1.GE_HQ_SSO_ID__c;
        cusset.User_Name__c = 'Chiara Pignatelli';
        insert cusset;
        
        
        
        
        User objuser = new User();
        objuser.FirstName='FName';
        objuser.lastname = 'LName';
        String username = 'test123@testsb1.com';
        objuser.username = username;
        objuser.email = username;
        objuser.alias = 'test';
        objuser.languagelocalekey='en_US';
        objuser.emailencodingkey='UTF-8';
        objuser.localesidkey='en_US';
        objuser.profileid = [Select ID from Profile where Name = 'System Administrator'].ID;
        objuser.UserPermissionsSFContentUser = true;
        objuser.timezonesidkey='America/Los_Angeles';
        objuser.IsActive = true;
       // objuser.GE_HQ_SSO_ID__c = '105032217';
        insert objuser;
        
        objuser = new User();
        objuser.FirstName='FName2';
        objuser.lastname = 'LName2';
        username = 'test123@testsb11.com';
        objuser.username = username;
        objuser.email = username;
        objuser.alias = 'test2';
        objuser.languagelocalekey='en_US';
        objuser.emailencodingkey='UTF-8';
        objuser.localesidkey='en_US';
        objuser.profileid = [Select ID from Profile where Name = 'System Administrator'].ID;
        objuser.UserPermissionsSFContentUser = true;
        objuser.timezonesidkey='America/Los_Angeles';
        objuser.IsActive = true;
       // objuser.GE_HQ_SSO_ID__c = '105052370';
        insert objuser;
        
        objuser = new User();
        objuser.FirstName='FName3';
        objuser.lastname = 'LName3';
        username = 'test123@testsb13.com';
        objuser.username = username;
        objuser.email = username;
        objuser.alias = 'test2';
        objuser.languagelocalekey='en_US';
        objuser.emailencodingkey='UTF-8';
        objuser.localesidkey='en_US';
        objuser.profileid = [Select ID from Profile where Name = 'System Administrator'].ID;
        objuser.UserPermissionsSFContentUser = true;
        objuser.timezonesidkey='America/Los_Angeles';
        objuser.IsActive = true;
       // objuser.GE_HQ_SSO_ID__c = '105030353';
        insert objuser;

       
        
    }
    public static eRAD__c eradCreate(String tier2){
        Opportunity oppty = [select id from Opportunity where name ='Test Oppty1' LIMIT 1]; 
        eRad__c radObj = new eRad__c();
        radObj.Name = 'Test eRad';
        radObj.Opportunity__c = Oppty.id;
        return radObj;
    }
    
    public static eRAD__c eradCreate_1(String tier2,String seg){
        Opportunity oppty = [select id from Opportunity where name ='Test Oppty1' LIMIT 1]; 
        eRad__c radObj = new eRad__c();
        radObj.Name = 'Test eRad';
        radObj.Opportunity__c = Oppty.id;
        radObj.Segment__c = seg;
        return radObj;
    }
    
    public static RAD_Evaluation_Cntrl radClass;
    public static testMethod void RAD_Class_Method(){
        erad__c eradobj = eradCreate('Subsea (SS)');
        eradobj.recordtypeid = Schema.SObjectType.eRad__c.getRecordTypeInfosByName().get('Subsea').getRecordTypeId();
        insert eradobj;
        Competitor__c com = new Competitor__c();
        com.eRAD__c =eradobj.id;
        com.Competitor__c = 'XXXX';
        insert com;
        
        erad__c eradobjcap = eradCreate('TMS');
        eradobjcap.recordtypeid = Schema.SObjectType.eRad__c.getRecordTypeInfosByName().get('TMS - CSA').getRecordTypeId();
        insert eradobjcap;
        
        
        test.startTest();
        
        ApexPages.StandardController stdOppObj = new ApexPages.standardController(eradobj);
        radClass = new RAD_Evaluation_Cntrl(stdOppObj);
        radclass.ss_savecontent();
        radclass.cancelpage();
        radclass.save_custom();
        radClass.savecontent();
        
        ApexPages.StandardController stdOppObjcap = new ApexPages.standardController(eradobjcap);
        radClass = new RAD_Evaluation_Cntrl(stdOppObjcap);
        radClass.savecontent();
        test.stopTest();
    }
    public static testMethod void RAD_Class_Method_4(){
        test.startTest();
        
        erad__c eradobjcap = eradCreate('Subsea (SS)');
        eradobjcap.recordtypeid = Schema.SObjectType.eRad__c.getRecordTypeInfosByName().get('Subsea').getRecordTypeId();
        eradobjcap.Capex_Category_Weight__c = '100%';
        insert eradobjcap;
        
        ApexPages.StandardController stdOppObjcap = new ApexPages.standardController(eradobjcap);
        radClass = new RAD_Evaluation_Cntrl(stdOppObjcap);
        radClass.savecontent();
        
        eRAD__c techobjsub = eradobjcap;
        techobjsub.Capex_Category_Weight__c = '0%';
        techobjsub.Technical_Category_weight__c = '100%';
        update techobjsub;
        
        ApexPages.StandardController stdtechobjsub = new ApexPages.standardController(techobjsub);
        radClass = new RAD_Evaluation_Cntrl(stdtechobjsub);
        radClass.savecontent();
        
        erad__c eradobjcapTMS = eradCreate('TMS');
        eradobjcapTMS.recordtypeid = Schema.SObjectType.eRad__c.getRecordTypeInfosByName().get('TMS - CSA').getRecordTypeId();
        eradobjcapTMS.Capex_Category_Weight__c = '100%';
        insert eradobjcapTMS;
        
        ApexPages.StandardController stdOppObjTMScap = new ApexPages.standardController(eradobjcapTMS);
        radClass = new RAD_Evaluation_Cntrl(stdOppObjTMScap);
        radClass.savecontent();
        
        eRAD__c techobjtms = eradobjcapTMS;
        techobjtms.Technical_Category_weight__c = '100%';
        techobjtms.Capex_Category_Weight__c = '0%';
        update techobjtms;
        
        ApexPages.StandardController stdtechobjtms = new ApexPages.standardController(techobjtms);
        radClass = new RAD_Evaluation_Cntrl(stdtechobjtms);
        radClass.savecontent();
        
        erad__c eradobjcapprc = eradobjcap;
        eradobjcapprc.Total_Price__c = '100%';
        eradobjcapprc.Capex_Score__c = '1.1';
        update eradobjcapprc;
        
        ApexPages.StandardController stdOppObjcapprc = new ApexPages.standardController(eradobjcapprc);
        radClass = new RAD_Evaluation_Cntrl(stdOppObjcapprc);
        radClass.savecontent();
        
        erad__c eradobjcapprcTMS = eradobjcapTMS;
        eradobjcapprcTMS.Total_Price__c = '100%';
        eradobjcapprcTMS.Capex_Score__c = '1.1';
        update eradobjcapprcTMS;
        
        ApexPages.StandardController stdOppObjcapprcTMS = new ApexPages.standardController(eradobjcapprcTMS);
        radClass = new RAD_Evaluation_Cntrl(stdOppObjcapprcTMS);
        radClass.savecontent();        
        
        test.stopTest();
    }
    
    
    public static testmethod void RAD_action_Method(){
        test.startTest();
        erad__c eradobjcomm = new eRAD__c();
        eradobjcomm.recordtypeid = Schema.SObjectType.eRad__c.getRecordTypeInfosByName().get('Subsea Read Only').getRecordTypeId();
        insert eradobjcomm;    
        
        ApexPages.StandardController stdOppObjcomm = new ApexPages.standardController(eradobjcomm);
        radClass = new RAD_Evaluation_Cntrl(stdOppObjcomm);
        radClass.pageaction();
        
        erad__c eradobj2 = eradCreate('TMS');
        eradobj2.recordtypeid = Schema.SObjectType.eRad__c.getRecordTypeInfosByName().get('TMS - New Units Read Only').getRecordTypeId();
        insert eradobj2;
        
        ApexPages.StandardController stdOppObj2 = new ApexPages.standardController(eradobj2);
        radClass = new RAD_Evaluation_Cntrl(stdOppObj2);
        radClass.pageaction();
        
                
        /*
        ID tempID = radClass.usrid('eRAD_TMS_Approver_IDs__c');
        if(tempID!=null)
            radClass.buttonboo=true;
        */
        
        erad__c eradobjcomm2 = eradCreate('Subsea (SS)');
        eradobjcomm2.recordtypeid = Schema.SObjectType.eRad__c.getRecordTypeInfosByName().get('Subsea').getRecordTypeId();
        eradobjcomm2.Commercial_Category_weight__c = '100%';
        insert eradobjcomm2;
        
        ApexPages.StandardController stdOppObjcomm2 = new ApexPages.standardController(eradobjcomm2);
        radClass = new RAD_Evaluation_Cntrl(stdOppObjcomm2);
        radClass.savecontent();
        
        eRAD__c relobjsub = eradobjcomm2;
        relobjsub.Commercial_Category_weight__c = '0%';
        relobjsub.Relation_Category_Weight__c = '100%';
        update relobjsub;
        
        ApexPages.StandardController stdrelobjsub = new ApexPages.standardController(relobjsub);
        radClass = new RAD_Evaluation_Cntrl(stdrelobjsub);
        radClass.savecontent();
        
        
        erad__c eradobjcommTMS = eradCreate('TMS');
        eradobjcommTMS.recordtypeid = Schema.SObjectType.eRad__c.getRecordTypeInfosByName().get('TMS - CSA').getRecordTypeId();
        eradobjcommTMS.Commercial_Category_weight__c = '100%';
        Insert eradobjcommTMS;
        
        ApexPages.StandardController stdOppObjcommTMS = new ApexPages.standardController(eradobjcommTMS);
        radClass = new RAD_Evaluation_Cntrl(stdOppObjcommTMS);
        radClass.savecontent();
        
        eRAD__c relobjTMS = eradobjcommTMS;
        relobjTMS.Commercial_Category_weight__c = '0%';
        relobjTMS.Relation_Category_Weight__c = '100%';
        update relobjTMS;
        
        ApexPages.StandardController stdrelobjTMS = new ApexPages.standardController(relobjTMS);
        radClass = new RAD_Evaluation_Cntrl(stdrelobjTMS);
        radClass.savecontent();
        
        erad__c eradobjcommprc = relobjsub;
        eradobjcommprc.Delivery_wk__c = '100%';
        eradobjcommprc.Commercial_Score__c = '1.1';
        update eradobjcommprc;
        
        ApexPages.StandardController stdOppObjcommprc = new ApexPages.standardController(eradobjcommprc);
        radClass = new RAD_Evaluation_Cntrl(stdOppObjcommprc);
        radClass.savecontent();
        
        erad__c eradobjcommprcTMS = relobjTMS;
        eradobjcommprcTMS.Delivery_wk__c = '100%';
        eradobjcommprcTMS.Commercial_Score__c = '1.1';
        update eradobjcommprcTMS;
        
        ApexPages.StandardController stdOppObjcommprcTMS = new ApexPages.standardController(eradobjcommprcTMS);
        radClass = new RAD_Evaluation_Cntrl(stdOppObjcommprcTMS);
        radClass.savecontent();
        test.stoptest();
    }
    
    public static testmethod void RAD_action_Method_1(){
        test.startTest();
        erad__c eradobjcomm = new eRAD__c();
        eradobjcomm.recordtypeid = Schema.SObjectType.eRad__c.getRecordTypeInfosByName().get('Subsea Read Only').getRecordTypeId();
        insert eradobjcomm;    
        
        ApexPages.StandardController stdOppObjcomm = new ApexPages.standardController(eradobjcomm);
        radClass = new RAD_Evaluation_Cntrl(stdOppObjcomm);
        radClass.pageaction();
        Account acc = CommonTestDataFactory_GE_OG.createAccount('TestAccountRad');
        //Account acc = [Select ID from Account where Name = 'Test Account'];
        
        GE_PRM_Appointment__c objapp = new GE_PRM_Appointment__c();
        objapp.CurrencyIsoCode = 'USD';
        objapp.GE_PRM_Account_Name__c = acc.ID;
        insert objapp;
        
        GE_PRM_Recommendation__c objprm = new GE_PRM_Recommendation__c();
        objprm.GE_PRM_Appointment_Number__c = objapp.ID;
        objprm.GE_PRM_Agreement_Type__c = 'Non-Renewa';
        insert objprm;
        
        /*
        Contract objcontract = new Contract();
        objcontract.Name = 'Test';
        objcontract.RecordTypeID = [select ID, Name from RecordType where sObjectType = 'contract' and name = 'Master Frame Agreement'].ID;
        objcontract.AccountID = acc.ID;
        objcontract.GE_HQ_Buss_Tier1__c = 'DTS';
        objcontract.GE_PRM_Recommendation_Link__c = objprm.ID;
        objcontract.GE_OG_Evergreen__c = true;
        objcontract.GE_PRM_Tier_2__c = 'Measurement & Control';
        objcontract.GE_PRM_Business_Tier_1__c = 'Oil & Gas';
        objcontract.Status = 'Draft';
        objcontract.GE_OG_Governing_Law__c = 'US';
        objcontract.GE_OG_Dispute_Resolution_Description__c = 'NA';
        objcontract.GE_OG_Confidentiality_duration_years1__c = 'Unlimited';
        objcontract.GE_OG_Limitation_of_Liability_amount__c  = '25';
        objcontract.GE_OG_Standard_Warranty__c = 'Test';
        objcontract.GE_OG_Dispute_Resolution_Arbitration__c = 'Test';
        objcontract.GE_OG_Mutual_Confidentiality__c = 'Test';
        objcontract.GE_OG_3rd_Party_Indemnity__c = 'Test';
        objcontract.Exclusion_of_Consequential_Damages_incl__c = 'Test';
        objcontract.GE_FA_Applicable_Products_Services__c = 'Products';
        objcontract.GE_OG_Limitation_of_liability__c = 'Monetary Cap';
        objcontract.GE_Indty_Stru_Peop_Prop__c = 'Test';
        objcontract.GE_OG_Warranty_Timeframe1__c = 'Test';
        objcontract.GE_OG_Other_Indemnity__c = 'Test';
        insert objcontract;
        */
        
        
        
        Oppty_Threshold__c OpptyThreshold= CommonTestDataFactory_GE_OG.createThresholdCustomSetting4();

        Opportunity opp = [Select ID, tier_3_ge_og__c,tier_2_ge_og__c, Name, ContractID from Opportunity where Name = 'Test Oppty1'];
        //Opportunity opp = [Select ID, tier_3_ge_og__c,tier_2_ge_og__c, Name, ContractID, GE_OG_Contract__c from Opportunity where Name = 'Test Oppty1'];
        opp.tier_3_ge_og__c = 'New Units';
        //Replace Measurement & Control to Turbomachinery & Process Solutions
        opp.tier_2_ge_og__c = 'Turbomachinery & Process Solutions';
        /*Opp.ContractID = objcontract.ID;
       // Opp.GE_OG_Contract__c = objcontract.ID;*/
        update opp;
        
        
        erad__c eradobj2 = eradCreate('TMS');
        eradobj2.recordtypeid = Schema.SObjectType.eRad__c.getRecordTypeInfosByName().get('TMS - New Units Read Only').getRecordTypeId();
        insert eradobj2;
        
        ApexPages.StandardController stdOppObj2 = new ApexPages.standardController(eradobj2);
        radClass = new RAD_Evaluation_Cntrl(stdOppObj2);
        radClass.pageaction();
        
        opp.tier_3_ge_og__c = 'New Units';
        /*Opp.ContractID = objcontract.ID;
        //Opp.GE_OG_Contract__c = objcontract.ID;*/
        update opp;
        
        eradobj2 = eradCreate_1('TMS','LNG');
        eradobj2.recordtypeid = Schema.SObjectType.eRad__c.getRecordTypeInfosByName().get('TMS - New Units Read Only').getRecordTypeId();
        insert eradobj2;
        
        stdOppObj2 = new ApexPages.standardController(eradobj2);
        radClass = new RAD_Evaluation_Cntrl(stdOppObj2);
        radClass.pageaction();
        
        opp.tier_3_ge_og__c = 'New Units';
        /*Opp.ContractID = objcontract.ID;
        //Opp.GE_OG_Contract__c = objcontract.ID;*/
        update opp;
        
        eradobj2 = eradCreate_1('TMS','Test');
        eradobj2.recordtypeid = Schema.SObjectType.eRad__c.getRecordTypeInfosByName().get('TMS - New Units Read Only').getRecordTypeId();
        insert eradobj2;
        
        stdOppObj2 = new ApexPages.standardController(eradobj2);
        radClass = new RAD_Evaluation_Cntrl(stdOppObj2);
        radClass.pageaction();
                
        /*
        ID tempID = radClass.usrid('eRAD_TMS_Approver_IDs__c');
        if(tempID!=null)
            radClass.buttonboo=true;
        */
        
        
        
        
        opp.tier_3_ge_og__c = 'Opex Contractual';
        update opp;
        
        
        test.stoptest();
    }
    
    public static testMethod void RAD_Class_Method_5(){
        test.startTest();
        
        erad__c eradobjopex = eradCreate('Subsea (SS)');
        eradobjopex.recordtypeid = Schema.SObjectType.eRad__c.getRecordTypeInfosByName().get('Subsea').getRecordTypeId();
        eradobjopex.Opex_Category_Weight__c = '100%';
        insert eradobjopex;
        
        ApexPages.StandardController stdOppObjopex = new ApexPages.standardController(eradobjopex);
        radClass = new RAD_Evaluation_Cntrl(stdOppObjopex);
        radClass.savecontent();
        
        eRAD__c refobjsub = eradobjopex;
        refobjsub.Reference_Category_Weight__c = '100%';
        refobjsub.Opex_Category_Weight__c = '0%';
        update refobjsub;
        
        ApexPages.StandardController stdrefobjsub = new ApexPages.standardController(refobjsub);
        radClass = new RAD_Evaluation_Cntrl(stdrefobjsub);
        radClass.savecontent();
        
        erad__c eradobjopexTMS = eradCreate('TMS');
        eradobjopexTMS.recordtypeid = Schema.SObjectType.eRad__c.getRecordTypeInfosByName().get('TMS - CSA').getRecordTypeId();
        eradobjopexTMS.Opex_Category_Weight__c = '100%';
        insert eradobjopexTMS;
        
        ApexPages.StandardController stdOppObjopxTMS = new ApexPages.standardController(eradobjopexTMS);
        radClass = new RAD_Evaluation_Cntrl(stdOppObjopxTMS);
        radClass.savecontent();
        
        eRAD__c refobjtms = eradobjopexTMS;
        refobjtms.Reference_Category_Weight__c = '100%';
        refobjtms.Opex_Category_Weight__c = '0%';
        update refobjtms;
        
        ApexPages.StandardController stdrefobjtms = new ApexPages.standardController(refobjtms);
        radClass = new RAD_Evaluation_Cntrl(stdrefobjtms);
        radClass.savecontent();
        
        erad__c eradobjopxprc = eradobjopex;
        eradobjopxprc.Storage_Rates__c = '100%';
        eradobjopxprc.Opex_Score__c = '1.1';
        update eradobjopxprc;
        
        ApexPages.StandardController stdOppObjopxprc = new ApexPages.standardController(eradobjopxprc);
        radClass = new RAD_Evaluation_Cntrl(stdOppObjopxprc);
        radClass.savecontent();
        
        erad__c eradobjopxprcTMS = eradobjopexTMS;
        eradobjopxprcTMS.Storage_Rates__c = '100%';
        eradobjopxprcTMS.Opex_Score__c = '1.1';
        update eradobjopxprcTMS;
        
        ApexPages.StandardController stdOppObjopxprctms = new ApexPages.standardController(eradobjopxprcTMS);
        radClass = new RAD_Evaluation_Cntrl(stdOppObjopxprctms);
        radClass.savecontent();
        
        test.stopTest();
    }
    
    
    public static testmethod void RAD_action_Method6()
    {
        test.startTest();
        
        Oppty_Threshold__c OpptyThreshold= CommonTestDataFactory_GE_OG.createThresholdCustomSetting4();

        
        //Opportunity opp = [Select ID, tier_3_ge_og__c,tier_2_ge_og__c, Name, ContractID, GE_OG_Contract__c from Opportunity where Name = 'Test Oppty1'];
        Opportunity opp = [Select ID, tier_3_ge_og__c,tier_2_ge_og__c, Name, ContractID from Opportunity where Name = 'Test Oppty1'];
        //Changed from TMS to Turbomachinery & Process Solutions
        opp.tier_2_ge_og__c = 'Turbomachinery & Process Solutions';
        opp.tier_3_ge_og__c = 'New Units';
        update opp;
        
        
        erad__c eradobjcomm = new eRAD__c();
        eradobjcomm.recordtypeid = Schema.SObjectType.eRad__c.getRecordTypeInfosByName().get('Subsea Read Only').getRecordTypeId();
        eradobjcomm.Segment__c = 'NG ON';
        eradobjcomm.Opportunity__c =  opp.Id;
        insert eradobjcomm;    
        
         
        ApexPages.StandardController stdOppObjcomm = new ApexPages.standardController(eradobjcomm);
        radClass = new RAD_Evaluation_Cntrl(stdOppObjcomm);
        radClass.pageaction();
        
        erad__c eradobj2 = eradCreate('TMS');
        eradobj2.recordtypeid = Schema.SObjectType.eRad__c.getRecordTypeInfosByName().get('TMS - New Units Read Only').getRecordTypeId();
        insert eradobj2;
        
       
        
        
        
        ApexPages.StandardController stdOppObj2 = new ApexPages.standardController(eradobj2);
        radClass = new RAD_Evaluation_Cntrl(stdOppObj2);
        radClass.pageaction();
        
                
       /*
        ID tempID = radClass.usrid('eRAD_TMS_Approver_IDs__c');
        if(tempID!=null)
            radClass.buttonboo=true;
        
        
        erad__c eradobjcomm2 = eradCreate('TMS - New Units Read Only');
        eradobjcomm2.recordtypeid = Schema.SObjectType.eRad__c.getRecordTypeInfosByName().get('Subsea').getRecordTypeId();
        eradobjcomm2.Commercial_Category_weight__c = '100%';
        insert eradobjcomm2;
        
        ApexPages.StandardController stdOppObjcomm2 = new ApexPages.standardController(eradobjcomm2);
        radClass = new RAD_Evaluation_Cntrl(stdOppObjcomm2);
        radClass.savecontent();
        
        eRAD__c relobjsub = eradobjcomm2;
        relobjsub.Commercial_Category_weight__c = '0%';
        relobjsub.Relation_Category_Weight__c = '100%';
        update relobjsub;
        
        ApexPages.StandardController stdrelobjsub = new ApexPages.standardController(relobjsub);
        radClass = new RAD_Evaluation_Cntrl(stdrelobjsub);
        radClass.savecontent();
        
        
        erad__c eradobjcommTMS = eradCreate('TMS');
        eradobjcommTMS.recordtypeid = Schema.SObjectType.eRad__c.getRecordTypeInfosByName().get('TMS - CSA').getRecordTypeId();
        eradobjcommTMS.Commercial_Category_weight__c = '100%';
        Insert eradobjcommTMS;
        
        ApexPages.StandardController stdOppObjcommTMS = new ApexPages.standardController(eradobjcommTMS);
        radClass = new RAD_Evaluation_Cntrl(stdOppObjcommTMS);
        radClass.savecontent();
        
        eRAD__c relobjTMS = eradobjcommTMS;
        relobjTMS.Commercial_Category_weight__c = '0%';
        relobjTMS.Relation_Category_Weight__c = '100%';
        update relobjTMS;
        
        ApexPages.StandardController stdrelobjTMS = new ApexPages.standardController(relobjTMS);
        radClass = new RAD_Evaluation_Cntrl(stdrelobjTMS);
        radClass.savecontent();
        
        erad__c eradobjcommprc = relobjsub;
        eradobjcommprc.Delivery_wk__c = '100%';
        eradobjcommprc.Commercial_Score__c = '1.1';
        update eradobjcommprc;
        
        ApexPages.StandardController stdOppObjcommprc = new ApexPages.standardController(eradobjcommprc);
        radClass = new RAD_Evaluation_Cntrl(stdOppObjcommprc);
        radClass.savecontent();
        
        erad__c eradobjcommprcTMS = relobjTMS;
        eradobjcommprcTMS.Delivery_wk__c = '100%';
        eradobjcommprcTMS.Commercial_Score__c = '1.1';
        update eradobjcommprcTMS;
        
        ApexPages.StandardController stdOppObjcommprcTMS = new ApexPages.standardController(eradobjcommprcTMS);
        radClass = new RAD_Evaluation_Cntrl(stdOppObjcommprcTMS);
        radClass.savecontent();*/
        test.stoptest();
    }
}