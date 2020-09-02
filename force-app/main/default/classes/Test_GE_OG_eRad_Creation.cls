@isTest
Public class Test_GE_OG_eRad_Creation{
    //Added by Chaitanya Gupta K,R-20178
    @testsetup
    public static void createAccount()
    {
       
        account acc = new account();
        acc.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        acc.name = 'Test Acc';
        acc.Account_Tier_GEOG__c = 'Country';
        acc.Classification__c= 'Strategic';
        acc.Type = 'Direct Customer';
        acc.ShippingCountry = 'India';
        acc.Region_GEOG__c = 'India';
        insert acc;
        
    }
    
    public static Opportunity oppCreate(string tier1,string tier2,string tier3,string stage)
    { 
    
        IFE__DisableOpportunityTriggers__c ifgetOppty = IFE__DisableOpportunityTriggers__c.getInstance('Test_Opty');
        if(ifgetOppty == null){
            IFE__DisableOpportunityTriggers__c ifOppty = new IFE__DisableOpportunityTriggers__c();
            ifOppty.name = 'Test_Opty';
            ifOppty.IFE__Is_Disabled__c = true;
            insert ifOppty;
        }
        

        
        opportunity opp = new opportunity();
        opp.name= 'Test Oppty';
        opp.stageName = stage;
        opp.has_opportunitycontactrole_ge_og__c = True;
        opp.region_ge_og__c = 'Test Region';
        opp.closedate = system.today().addDays(30);
        opp.accountId = [Select Id From Account Limit 1].Id;
        //Updated the value to Oil & Gas
        opp.tier_1_ge_og__c ='Oil & Gas';
        opp.tier_2_ge_og__c =tier2;
        opp.tier_3_ge_og__c =tier3;
        opp.amount_ge_og__c =1000.00;
        opp.install_country_ge_og__c= 'India';
      
            
        return opp;
    }
    public static TestMethod void Test_GE_OG_eRad_Creation(){
        List<opportunity> oppList = new List<opportunity>();
        List<opportunity> updateoppList = new List<opportunity>();
        Map<id,Opportunity> oppMap = new Map<id,Opportunity>();
        Map<id,Opportunity> newupdateMap = new Map<id,Opportunity>();
        Map<id,Opportunity> oldupdateMap = new Map<id,Opportunity>();
        
        //Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
       User u=[select id,firstname,lastname,email from User where id=:userinfo.getUserId()];   
       
       Test.startTest();
        Oppty_Threshold__c OpptyThreshold= CommonTestDataFactory_GE_OG.createThresholdCustomSetting2();
        Oppty_Threshold__c OpptyThreshold1= CommonTestDataFactory_GE_OG.createThresholdCustomSetting4();

        opportunity ssopp = oppCreate('Oil & Gas','Oil Field Equipment','Subsea Drilling Systems','Prospecting');
            //ssopp.GE_OG_DP_Global_Customer__c = 'Test';
            //ssopp.Primary_SS_Competitor__c = 'test comp';
            //ssopp.X2_SS_Competitor__c = 'test comp';
            
            ssopp.RecordtypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('O&G').getRecordTypeId();
            insert ssopp;
            
            opportunity tmsopp = oppCreate('Oil & Gas','Turbomachinery & Process Solutions','Opex Contractual','Prospecting');
            insert tmsopp;                            
            //Start: Commented below for Opportunity Cleanup
            //tmsopp.GE_OG_GS_Prod_Srvc__c = 'Maintenance Contracts';
            //End: Commented below for Opportunity Cleanup
            //tmsopp.GE_OG_GS_Mgmt_Entity__c = 'CS';
            Test.stopTest();
            
            
            opportunity tmsNWopp = oppCreate('','Turbomachinery & Process Solutions','New Units','Prospecting');
            insert tmsNWopp;
            opportunity tmsOpexopp = oppCreate('','Turbomachinery & Process Solutions','Opex Contractual','Prospecting');
            insert tmsOpexopp;
            opportunity tmsDTSopp = oppCreate('','Turbomachinery & Process Solutions','Upgrades','Prospecting');
            tmsDTSopp.recordtypeid = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('O&G').getRecordTypeId();
            //Commented below as this value doesn't exist    
            //tmsDTSopp.tier_4_ge_og__c = 'DOS - New Units';
            insert tmsDTSopp;
             
            oppList.add(ssopp);
            oppList.add(tmsopp);
            oppList.add(tmsNWopp);
            oppList.add(tmsOpexopp);
            oppList.add(tmsDTSopp);
            for(opportunity opp : oppList)
            oppMap.put(opp.id,opp);
            GE_OG_eRad_Creation eradCreation = new GE_OG_eRad_Creation();
            //eradCreation.radrecordcreation(oppList,oppMap);
        
       
    } 
    
    
     /*public static TestMethod void Test_GE_OG_eRad_Creation_TMS_update(){
        List<opportunity> updateoppList = new List<opportunity>();
        Map<id,Opportunity> oppMap = new Map<id,Opportunity>();
        Map<id,Opportunity> newupdateMap = new Map<id,Opportunity>();
        Test.startTest();
        GE_OG_eRad_Creation eradCreation = new GE_OG_eRad_Creation();
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
       User u=[select id,firstname,lastname,email from User where id=:userinfo.getUserId()];   
        
        
        opportunity ssopp = oppCreate('','Subsea & Drilling','Opex Core','Prospecting');
        ssopp.GE_OG_DP_Global_Customer__c = 'Test';
        ssopp.tier_2_ge_og__c = 'Subsea & Drilling';
        //ssopp.Primary_SS_Competitor__c = 'test comp';
        //ssopp.X2_SS_Competitor__c = 'test comp';
        ssopp.recordtypeid = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('O&G').getRecordTypeId();
        insert ssopp;
        eRAD__c erad = new eRAD__c();
            erad.name = 'test';
            erad.Opportunity__c = ssopp.id;
            erad.Mode__c='Active';
            //erad.Opportunity_Status__c = 'Active Bid';
            erad.Segment__c='LNG';
            erad.Sub_Segment__c='Main Refrigerant';
            erad.Train_Configuration__c = 'GTG HD';
            erad.Customer_Statement__c  = 'Carbon Copy';
            erad.Plant_Type__c = 'Biomass';
            erad.Tender_Format_TMS__c = 'Auction';
            erad.GE_SoS_includes_NPI_Item__c = 'No';
            erad.GE_SoS_Includes_Product_Structured_Item__c ='No';
            
            Insert erad;
        
        Competitor__c compt =  new Competitor__c();
        //compt.RecordTypeId =[select id,name from recordtype where name like 'Turbomachinery Solutions/DTS' limit 1].id;
        compt.eRAD__c =erad.id; 
        insert compt;
        
        Discount__c disc = new Discount__c();
        disc.eRAD__c = erad.id;
        
        oppMap.put(ssopp.id,ssopp);
        ssopp.stagename = 'Bid In Development';
        
        OpportunityTeamMember objOTM = new OpportunityTeamMember();
        objOTM.OpportunityID = ssopp.Id;
        objOTM.UserID = UserInfo.getUserId();
        objOTM.TeamMemberRole = 'Commercial Primary Resource';
        Insert objOTM;
        
        
        update ssopp;
        
        
        updateoppList.add(ssopp);
        newupdateMap.put(ssopp.id,ssopp);
        
        opportunity tmsopp = oppCreate('','Turbomachinery Solutions','Opex Core','Prospecting');
        //Start: Commented below for Opportunity Cleanup
        //tmsopp.GE_OG_GS_Prod_Srvc__c = 'Maintenance Contracts';
        //End: Commented below for Opportunity Cleanup
        //tmsopp.GE_OG_GS_Mgmt_Entity__c = 'CS';
        insert tmsopp;
        
        erad = new eRAD__c();
            erad.name = 'test';
            erad.Opportunity__c = tmsopp.id;
            erad.Mode__c='Active';
            //erad.Opportunity_Status__c = 'Active Bid';
            erad.Segment__c='LNG';
            erad.Sub_Segment__c='Main Refrigerant';
            erad.Train_Configuration__c = 'GTG HD';
            erad.Customer_Statement__c  = 'Carbon Copy';
            erad.Plant_Type__c = 'Biomass';
            erad.Tender_Format_TMS__c = 'Auction';
            erad.GE_SoS_includes_NPI_Item__c = 'No';
            erad.GE_SoS_Includes_Product_Structured_Item__c ='No';
            
            Insert erad;
            compt =  new Competitor__c();
            //compt.RecordTypeId =[select id,name from recordtype where name like 'Turbomachinery Solutions/DTS' limit 1].id;
            compt.eRAD__c =erad.id; 
            insert compt;
        
            disc = new Discount__c();
            disc.eRAD__c = erad.id;
        
            oppMap.put(tmsopp.id,tmsopp);
            tmsopp.stagename = 'Closed Lost';
            //tmsopp.tier_3_ge_og__c= 'New Units';
            //tmsopp.GE_OG_TM_Primary_Winner_Competitor__c = null;
            update tmsopp;
        
        updateoppList.add(tmsopp);
        newupdateMap.put(tmsopp.id,tmsopp);
        
        eradCreation.onupdateradrecordcreation(updateoppList,newupdateMap,oppMap);
        
        updateoppList.clear();
        newupdateMap.clear();
        oppMap.clear();
        Test.stopTest();
        opportunity tmsDTSopp = oppCreate('','DTS','DP&S','Prospecting');
        tmsDTSopp.recordtypeid = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('O&G').getRecordTypeId();
        tmsDTSopp.tier_4_ge_og__c = 'DOS - New Units';
        insert tmsDTSopp;
            erad = new eRAD__c();
            erad.name = 'test';
            erad.Opportunity__c = tmsDTSopp.id;
            erad.Mode__c='Active';
            //erad.Opportunity_Status__c = 'Active Bid';
            erad.Segment__c='LNG';
            erad.Sub_Segment__c='Main Refrigerant';
            erad.Train_Configuration__c = 'GTG HD';
            erad.Customer_Statement__c  = 'Carbon Copy';
            erad.Plant_Type__c = 'Biomass';
            erad.Tender_Format_TMS__c = 'Auction';
            erad.GE_SoS_includes_NPI_Item__c = 'No';
            erad.GE_SoS_Includes_Product_Structured_Item__c ='No';
            
            Insert erad;
        compt =  new Competitor__c();
        //compt.RecordTypeId =[select id,name from recordtype where name like 'Turbomachinery Solutions/DTS' limit 1].id;
        compt.eRAD__c =erad.id; 
        insert compt;
        
        disc = new Discount__c();
        disc.eRAD__c = erad.id;
        
        oppMap.put(tmsDTSopp.id,tmsDTSopp);
        tmsDTSopp.stagename = 'Closed Lost';
        //Start: Commented below for Opportunity Cleanup
        //tmsDTSopp.GE_OG_Convertible_this_Quarter__c = 'Y';
        //End: Commented below for Opportunity Cleanup
        update tmsDTSopp;
        
        updateoppList.add(tmsDTSopp);
        newupdateMap.put(tmsDTSopp.id,tmsDTSopp);
        
        eradCreation.onupdateradrecordcreation(updateoppList,newupdateMap,oppMap);
        
        updateoppList.clear();
        newupdateMap.clear();
        oppMap.clear();
        
        opportunity tmsOpexopp = oppCreate('','Turbomachinery Solutions','Opex Core','Prospecting');
        insert tmsOpexopp;
        erad.Opportunity__c = tmsOpexopp.id;
            erad = new eRAD__c();
            erad.name = 'test';
            erad.Mode__c='Active';
           // erad.Opportunity_Status__c = 'Active Bid';
            erad.Segment__c='LNG';
            erad.Sub_Segment__c='Main Refrigerant';
            erad.Train_Configuration__c = 'GTG HD';
            erad.Customer_Statement__c  = 'Carbon Copy';
            erad.Plant_Type__c = 'Biomass';
            erad.Tender_Format_TMS__c = 'Auction';
            erad.GE_SoS_includes_NPI_Item__c = 'No';
            erad.GE_SoS_Includes_Product_Structured_Item__c ='No';
            
            Insert erad;
        compt =  new Competitor__c();
        //compt.RecordTypeId =[select id,name from recordtype where name like 'Turbomachinery Solutions/DTS' limit 1].id;
        compt.eRAD__c =erad.id; 
        insert compt;
        
        disc = new Discount__c();
        disc.eRAD__c = erad.id; 
        
        oppMap.put(tmsOpexopp.id,tmsOpexopp);
        tmsOpexopp.stagename = 'closed lost';
        update tmsOpexopp;
        
        updateoppList.add(tmsOpexopp);
        newupdateMap.put(tmsOpexopp.id,tmsOpexopp);
        
        eradCreation.onupdateradrecordcreation(updateoppList,newupdateMap,oppMap);
        
    }*/
    public static TestMethod void Test_GE_OG_eRad_Creation_DTS_update_Clone(){
        List<opportunity> updateoppList = new List<opportunity>();
        Map<id,Opportunity> oppMap = new Map<id,Opportunity>();
        Map<id,Opportunity> newupdateMap = new Map<id,Opportunity>();
        Test.startTest();
        GE_OG_eRad_Creation eradCreation;
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
       User u=[select id,firstname,lastname,email from User where id=:userinfo.getUserId()];   
        Oppty_Threshold__c OpptyThreshold= CommonTestDataFactory_GE_OG.createThresholdCustomSetting2();

        Opportunity tmsDTSopp = oppCreate('','Oil Field Equipment','Subsea Drilling Systems','Prospecting');
        tmsDTSopp.recordtypeid = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('O&G').getRecordTypeId();
        //Commented below as this value doesn't exist
        //tmsDTSopp.tier_4_ge_og__c = 'DOS - New Units';
        insert tmsDTSopp;
        oppMap.put(tmsDTSopp.id,tmsDTSopp);
        tmsDTSopp.stagename = 'closed lost';
        //Start: Commented below for Opportunity Cleanup
        //tmsDTSopp.GE_OG_Convertible_this_Quarter__c = 'Y';
        //End: Commented below for Opportunity Cleanup
        update tmsDTSopp;
        
        updateoppList.add(tmsDTSopp);
        newupdateMap.put(tmsDTSopp.id,tmsDTSopp);
        eradCreation = new GE_OG_eRad_Creation();
        eradCreation.onupdateradrecordcreation(updateoppList,newupdateMap,oppMap);
        Test.stopTest();
    }
    public static TestMethod void Test_GE_OG_eRad_Creation_TMS_update_CloneSolutions_update_Clone(){
        List<opportunity> updateoppList = new List<opportunity>();
        Map<id,Opportunity> oppMap = new Map<id,Opportunity>();
        Map<id,Opportunity> newupdateMap = new Map<id,Opportunity>();
        Test.startTest();
        GE_OG_eRad_Creation eradCreation;
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
        User u=[select id,firstname,lastname,email from User where id=:userinfo.getUserId()];   
        
                        Oppty_Threshold__c OpptyThreshold= CommonTestDataFactory_GE_OG.createThresholdCustomSetting4();

        opportunity tmsopp = oppCreate('','Turbomachinery & Process Solutions','Opex Contractual','Prospecting');
        //Start: Commented below for Opportunity Cleanup
        //tmsopp.GE_OG_GS_Prod_Srvc__c = 'Maintenance Contracts';
        //End: Commented below for Opportunity Cleanup
        //tmsopp.GE_OG_GS_Mgmt_Entity__c = 'CS';
        insert tmsopp;
        oppMap.put(tmsopp.id,tmsopp);
        tmsopp.stagename = 'closed lost';
        update tmsopp;
        updateoppList.add(tmsopp);
        newupdateMap.put(tmsopp.id,tmsopp);
        eradCreation = new GE_OG_eRad_Creation();
        eradCreation.onupdateradrecordcreation(updateoppList,newupdateMap,oppMap);
        Test.stopTest();
    }
    public static TestMethod void Test_GE_OG_eRad_Creation_SS_update_Clone(){
        List<opportunity> updateoppList = new List<opportunity>();
        Map<id,Opportunity> oppMap = new Map<id,Opportunity>();
        Map<id,Opportunity> newupdateMap = new Map<id,Opportunity>();
        Test.startTest();
        GE_OG_eRad_Creation eradCreation;
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
        User u=[select id,firstname,lastname,email from User where id=:userinfo.getUserId()];   
        
        Oppty_Threshold__c OpptyThreshold= CommonTestDataFactory_GE_OG.createThresholdCustomSetting4();

        
        opportunity ssopp = oppCreate('','Turbomachinery & Process Solutions','Opex Contractual','Prospecting');
        //ssopp.GE_OG_DP_Global_Customer__c = 'Test';
        //ssopp.Primary_SS_Competitor__c = 'test comp';
        //ssopp.X2_SS_Competitor__c = 'test comp';
        
        ssopp.RecordtypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('O&G').getRecordTypeId();
        insert ssopp;
        oppMap.put(ssopp.id,ssopp);
        ssopp.stagename = 'closed lost';
        update ssopp;
        
        updateoppList.add(ssopp);
        newupdateMap.put(ssopp.id,ssopp);
        eradCreation = new GE_OG_eRad_Creation();
        eradCreation.onupdateradrecordcreation(updateoppList,newupdateMap,oppMap);
        
        updateoppList.clear();
        newupdateMap.clear();
        oppMap.clear();
        Test.stopTest();
    }
    public static TestMethod void Test_GE_OG_eRad_Creation_TMS_update_Clone2(){
        List<opportunity> updateoppList = new List<opportunity>();
        Map<id,Opportunity> oppMap = new Map<id,Opportunity>();
        Map<id,Opportunity> newupdateMap = new Map<id,Opportunity>();
        Test.startTest();
        GE_OG_eRad_Creation eradCreation;
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
        User u=[select id,firstname,lastname,email from User where id=:userinfo.getUserId()];   
        
        Oppty_Threshold__c OpptyThreshold= CommonTestDataFactory_GE_OG.createThresholdCustomSetting4();

        opportunity tmsopp = oppCreate('','Turbomachinery & Process Solutions','New Units','Prospecting');
        insert tmsopp;
        oppMap.put(tmsopp.id,tmsopp);
        tmsopp.stagename = 'closed lost';
        update tmsopp;
        updateoppList.add(tmsopp);
        newupdateMap.put(tmsopp.id,tmsopp);
        eradCreation = new GE_OG_eRad_Creation();
        eradCreation.onupdateradrecordcreation(updateoppList,newupdateMap,oppMap);
        Test.stopTest();
    }

  
}