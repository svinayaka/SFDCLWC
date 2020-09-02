/*    
Class Name        : GE_HQ_Get_Region_Test
Purpose/Overview  : For covering GE_HQ_Get_Region class
Author            : Jayadev Rath
Change History    : Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
: 16th Dec 2011 : Jayadev Rath       : Created : Created for coverage of GE_HQ_Get_Region
12th June 2014 : Shubhangi Tiwari : called getGlobalServicesRegionId(), getRegionID(),getRegionIdForSpecificTier() methods for code coverage .
                  : 15-Dec-2014     Satyanarayana Pusuluri GE_HQ_Get_Region_Test3() for Receive email notification when changes are made to Business Tier object for R-19699
*/

@isTest
Private Class GE_HQ_Get_Region_Test {
    
    
    
    Static TestMethod  void GE_HQ_Get_Region_Test() {
        List<User> usrObj=[select Id,Name,isActive,Profile.Name from User where Profile.Name like '%System Administrator%' and isActive=true and GE_HQ_Tier_3_P_L__c!=null and GE_DS_Country__c!=null and GE_DS_Global_Customer__c!=null and GE_DS_Customer_Type__c!=null and GE_DS_Commercial_Primary_Resource__c!=null];

        if(usrObj!=null && usrObj.size()>0)
        {

            System.runAs(usrObj[0])
            {
        Test.startTest(); 
        // Creating a country record:
        GE_HQ_Country__c Country = new GE_HQ_Country__c(Name='CountryTest',GE_HQ_ISO_Code__c='11',GE_PRM_CPI_Score__c=1);
        Insert Country;
        //Creating a Tier record:
        GE_HQ_P_L__c BT = new GE_HQ_P_L__c(GE_HQ_Is_Active__c=True,GE_HQ_P_L_ID__c=998,Name='GE Energy (Test)');
        Insert BT;
        // Creating the region record:
        GE_HQ_Region__c Region = new GE_HQ_Region__c(Name='RegionTest',GE_HQ_Business_Tier__c=BT.Id,GE_HQ_Function__c='Sales',GE_HQ_Region_ID__c=99998,GE_HQ_Derived_Tier_2__c='Drilling & Surface (D&S)',GE_OG_GS_Hub__c='TestHub');
        Insert Region;
        
        
        // Creating the region matrix record:
        GE_HQ_Reg_Matrix__c Rmatrix = new GE_HQ_Reg_Matrix__c(GE_HQ_Country__c=Country.Id,GE_HQ_External_ID__c='TestExtid',GE_HQ_Region__c=Region.Id,GE_HQ_Status__c='Active',GE_HQ_Eff_Dt__c=Date.today(),GE_HQ_Exp_Dt__c=(Date.today()+30));
        Insert Rmatrix;
        
        
        
        //Account account = GE_OG_Oppty_Test_Handler.createAccount();
        
        //Project_ge_og__c project = GE_OG_Oppty_Test_Handler.createGEESProject(account);
        
        Opportunity opp ;        
        
        GE_HQ_Region__c Regions = [select Id, Name,GE_OG_GS_Hub__c,GE_HQ_Derived_Tier_2__c ,GE_HQ_Function__c from GE_HQ_Region__c where Name =: 'RegionTest' limit 1];
        
        Map<Id,Id> RgnIdForSpecificTier = new Map<Id,Id>();
        
        Map<String,Id> tierNRgnIdMap1 = new Map<String,Id>();
        
        tierNRgnIdMap1.put('Oil & Gas (O&G)-Measurement & Control (M&C)-RegionTest-Sales' , Regions.Id);
        
        tierNRgnIdMap1.put('Oil & Gas (O&G)-Turbo Machinery-RegionTest-Risk Process' , Regions.Id);
        
        tierNRgnIdMap1.put('Oil & Gas (O&G)-PII Pipeline Solutions-RegionTest-Operations' , Regions.Id);
        
        tierNRgnIdMap1.put('Oil & Gas (O&G)-Drilling & Surface (D&S)-RegionTest-Sales' , Regions.Id);
        
        tierNRgnIdMap1.put('Oil & Gas (O&G)-RegionTest-Sales' , Regions.Id);
        
        tierNRgnIdMap1.put('Oil & Gas (O&G)-RegionTest-Risk Process' , Regions.Id);
        
        tierNRgnIdMap1.put('Oil & Gas (O&G)-RegionTest-Operations' , Regions.Id);
        
        
        List<GE_HQ_Region__c> regionList = new List<GE_HQ_Region__c>();
        
        regionList.add(Region);
        
        String regionID; 
        
        List <Opportunity> listOppty = new List <Opportunity>();
        
        // Calling the getRegion() method
        String[] result = GE_HQ_Get_Region.getRegion('GE Energy (Test)','AF',null,'Sales');
        // System.debug(result+':::');
        String[] result1 = GE_HQ_Get_Region.getRegion(Null,'AF',null,'Sales');
        //System.debug(result1+':::');
        System.assertEquals('Invalid Tier Information',result1[0]);
        
        String[] result3 = GE_HQ_Get_Region.getRegion('Advanced Sensors','AF',null,'Sales');
        //  System.debug(result1+':::');
        
        String[] result2 = GE_HQ_Get_Region.getRegion('Advanced Sensors',null,null,'Sales');
        // System.debug(result2+':::');
        System.assertEquals('Invalid Country Information',result2[0]);
        
        
        //The below is optional (for the VF page to be tested)
        GE_HQ_Get_Region regionCheck = new GE_HQ_Get_Region();
        regionCheck.InputFunction='Sales';
        regionCheck.Country = 'AF';
        regionCheck.Tier ='GE Energy (Test)';
        regionCheck.State ='VERMONT';
        regionCheck.FindRegion();          
        
        
       // opp = GE_OG_Oppty_Test_Handler.createBussSpecificOpportunity(account,project,'Drilling & Surface (D&S)');
        
        //opp.GE_Tier2_IRegion__c = 'RegionTest';
        
        update opp ; 
        
        //regionID = GE_HQ_Get_Region.getGlobalServicesRegionId('RegionTest' , opp, regionList);
        
        System.assertEquals('Drilling & Surface (D&S)' , Opp.tier_2_ge_og__c);
        
        System.assertEquals('Drilling & Surface (D&S)' , regionList[0].GE_HQ_Derived_Tier_2__c);
        
        System.assertEquals('RegionTest' , regionList[0].Name);
        
        
        System.assertEquals(null , regionID);
        
        
        //regionID =  GE_HQ_Get_Region.getRegionID(Regions.Name ,opp ,tierNRgnIdMap1)   ; 
        
        System.assertEquals(Regions.Id ,regionID);    
        
        listOppty.add(opp);
        
        
        //RgnIdForSpecificTier = GE_HQ_Get_Region.getRegionIdForSpecificTier(listOppty);         
        
       // System.assertEquals(Regions.Id , RgnIdForSpecificTier.get(listOppty.get(0).ID));
        
        opp.tier_2_ge_og__c = 'Global Services (GS)';
        
       // Opp.GE_Tier2_ERegion__c = 'RegionTest';
        
        update opp ;
        
        //regionID = GE_HQ_Get_Region.getRegionID(Regions.Name ,opp ,tierNRgnIdMap1)   ;   
        
        System.assertEquals(Regions.Id ,regionID);
        
       // listOppty.add(opp);
        
        System.assertEquals('Global Services (GS)',listOppty.get(0).tier_2_ge_og__c);
        
        //RgnIdForSpecificTier = GE_HQ_Get_Region.getRegionIdForSpecificTier(listOppty);         
        
        opp.tier_2_ge_og__c ='Lufkin';
        
        opp.tier_3_ge_og__c = 'Automation' ;
        
        opp.tier_4_ge_og__c = 'Automation';
        
        //opp.GE_Tier_5_del__c = 'Auto Zenith';
        
        //opp.GE_Tier2_Pregion__c = 'RegionTest';
        
        update opp ;
        
        
        System.assertEquals('Lufkin',listOppty.get(0).tier_2_ge_og__c);
        
        //regionID = GE_HQ_Get_Region.getRegionID(Regions.Name ,opp ,tierNRgnIdMap1)   ;   
        
        System.assertEquals(Regions.Id ,regionID);
        
        //RgnIdForSpecificTier = GE_HQ_Get_Region.getRegionIdForSpecificTier(listOppty);     
        
        
        Test.stopTest();
    }}}
    
    /*
    Static TestMethod  void GE_HQ_Get_Region_Test2()
    {
        
        Test.startTest(); 
        // Creating a country record:
        GE_HQ_Country__c Country = new GE_HQ_Country__c(Name='CountryTest',GE_HQ_ISO_Code__c='11',GE_PRM_CPI_Score__c=1);
        Insert Country;
        //Creating a Tier record:
        GE_HQ_P_L__c BT = new GE_HQ_P_L__c(GE_HQ_Is_Active__c=True,GE_HQ_P_L_ID__c=998,Name='GE Energy (Test)');
        Insert BT;
        // Creating the region record:
        GE_HQ_Region__c Region = new GE_HQ_Region__c(Name='RegionTest',GE_HQ_Business_Tier__c=BT.Id,GE_HQ_Function__c='Sales',GE_HQ_Region_ID__c=99998,GE_HQ_Derived_Tier_2__c='Drilling & Surface (D&S)',GE_OG_GS_Hub__c='TestHub');
        Insert Region;
        
        
        // Creating the region matrix record:
        GE_HQ_Reg_Matrix__c Rmatrix = new GE_HQ_Reg_Matrix__c(GE_HQ_Country__c=Country.Id,GE_HQ_External_ID__c='TestExtid',GE_HQ_Region__c=Region.Id,GE_HQ_Status__c='Active',GE_HQ_Eff_Dt__c=Date.today(),GE_HQ_Exp_Dt__c=(Date.today()+30));
        Insert Rmatrix;
        
        
        
        //Account account = GE_OG_Oppty_Test_Handler.createAccount();
        Account account = GEESEntityDMOFactory.CreateCallOutAccount();
        
        Project_ge_og__c project = GE_OG_Oppty_Test_Handler.createGEESProject(account);
        
        Opportunity opp ;        
        
        GE_HQ_Region__c Regions = [select Id, Name,GE_OG_GS_Hub__c,GE_HQ_Derived_Tier_2__c ,GE_HQ_Function__c from GE_HQ_Region__c where Name =: 'RegionTest' limit 1];
        
        Map<Id,Id> RgnIdForSpecificTier = new Map<Id,Id>();
        
        Map<String,Id> tierNRgnIdMap1 = new Map<String,Id>();
        
        tierNRgnIdMap1.put('Oil & Gas (O&G)-Measurement & Control (M&C)-RegionTest-Sales' , Regions.Id);
        
        tierNRgnIdMap1.put('Oil & Gas (O&G)-Turbo Machinery-RegionTest-Risk Process' , Regions.Id);
        
        tierNRgnIdMap1.put('Oil & Gas (O&G)-PII Pipeline Solutions-RegionTest-Operations' , Regions.Id);
        
        tierNRgnIdMap1.put('Oil & Gas (O&G)-Drilling & Surface (D&S)-RegionTest-Sales' , Regions.Id);
        
        tierNRgnIdMap1.put('Oil & Gas (O&G)-RegionTest-Sales' , Regions.Id);
        
        tierNRgnIdMap1.put('Oil & Gas (O&G)-RegionTest-Risk Process' , Regions.Id);
        
        tierNRgnIdMap1.put('Oil & Gas (O&G)-RegionTest-Operations' , Regions.Id);
        
        
        List<GE_HQ_Region__c> regionList = new List<GE_HQ_Region__c>();
        
        regionList.add(Region);
        
        String regionID; 
        
        opp = GE_OG_Oppty_Test_Handler.createBussSpecificOpportunity(account,project,'Turbo Machinery');
        
       opp.GE_OG_TM_Commercial_Center__c = 'RegionTest';
      
      update opp ; 
        
        List <Opportunity> listOppty = new List <Opportunity>();       
        
        listOppty.add(opp);
        
        regionID = GE_HQ_Get_Region.getRegionID(Regions.Name ,opp ,tierNRgnIdMap1)   ;   
        
        System.assertEquals(Regions.Id ,regionID);
        
        RgnIdForSpecificTier = GE_HQ_Get_Region.getRegionIdForSpecificTier(listOppty);         
        
        opp.tier_2_ge_og__c = 'PII Pipeline Solutions';
        opp.GE_ES_OPPTY_CM__c = 45;
        opp.GE_OG_PII_Ops_Region__c = 'RegionTest';
        update opp ;
        
        regionID = GE_HQ_Get_Region.getRegionID(Regions.Name ,opp ,tierNRgnIdMap1)   ;
        
        System.assertEquals(Regions.Id ,regionID);
        
        RgnIdForSpecificTier = GE_HQ_Get_Region.getRegionIdForSpecificTier(listOppty);    
        
        opp.tier_2_ge_og__c = 'Subsea (SS)';
        opp.tier_3_ge_og__c = 'Gasification' ;
        opp.GE_OG_DP_Global_Customer__c = 'CHEVRON';
        opp.GE_Tier1_IRegion__c = 'RegionTest' ;
        opp.GE_OG_Install_Country__c = 'GERMANY';
        
        update opp ;
        
        regionID = GE_HQ_Get_Region.getRegionID(Regions.Name ,opp ,tierNRgnIdMap1)   ;  
        
        System.assertEquals(Regions.Id ,regionID);
        
        GE_HQ_Get_Region.getRegionIdForSpecificTier(listOppty); 
        
        opp.tier_2_ge_og__c = 'Measurement & Control (M&C)';
        
        opp.GE_Tier2_ERegion__c = 'RegionTest';
        
        update opp ;
        
        regionID =GE_HQ_Get_Region.getRegionID(Regions.Name ,opp ,tierNRgnIdMap1)   ; 
        
        System.assertEquals(Regions.Id ,regionID); 
        
        GE_HQ_Get_Region.getRegionIdForSpecificTier(listOppty);   
        
        Test.stopTest();       
    }
    */
    /*
    Static TestMethod  void GE_HQ_Get_Region_Contract_Test() 
    {
    //Account account = GE_OG_Oppty_Test_Handler.createAccount();
    Account acc = [select Id, Name from Account where name = 'TestClassAccount'];
    System.assertEquals(acc.name,'TestClassAccount');
    contract ct=new contract();
    ct.name='test';
    ct.startdate=system.today();
    ct.Status='draft';
    ct.accountId=acc.id;
    ct.GE_OG_Evergreen__c=true;
    //insert ct;
    }
    */
    
    
    Static TestMethod  void GE_HQ_Get_Region_Test3()
    {
        
        Test.startTest(); 
        //Creating a Tier record:
        list<GE_HQ_P_L__c> BTList = new List<GE_HQ_P_L__c>();
        
        GE_HQ_P_L__c BT = new GE_HQ_P_L__c(GE_HQ_P_L_ID__c=2223,Name='Testing PL for EMail',GE_OG_Comments__c='testing for code coverage',CreatedByid = UserInfo.getUserId(),LastModifiedByid = UserInfo.getUserId());
        insert BT; 
        BT.Name = 'Changed to Test';        
        BT.GE_OG_Comments__c = 'testing for test class';
        //BT.CreatedByid = UserInfo.getUserId();
        update BT;
        //BTList.add(BT);
        GE_HQ_P_L__c BT1 = new GE_HQ_P_L__c(GE_HQ_P_L_ID__c=2224,Name='Testing PL for EMail1',GE_OG_Comments__c='testing for code coverage',GE_HQ_Parent_P_L_Name__c=BT.id,CreatedByid = UserInfo.getUserId(),LastModifiedByid = UserInfo.getUserId());
        insert BT1; 
        BT1.Name = 'Changed to Test';       
        BT1.GE_OG_Comments__c = 'testing for test class';
        //BT1.CreatedByid = UserInfo.getUserId();
        update BT1;
    
        GE_HQ_P_L__c BT2 = new GE_HQ_P_L__c(GE_HQ_P_L_ID__c=2225,Name='Testing PL for EMail2',GE_OG_Comments__c='testing for code coverage',GE_HQ_Parent_P_L_Name__c=BT1.id,CreatedByid = UserInfo.getUserId(),LastModifiedByid = UserInfo.getUserId());
        insert BT2; 
        BT2.Name = 'Changed to Test';       
        BT2.GE_OG_Comments__c = 'testing for test class';
        //BT2.CreatedByid = UserInfo.getUserId();
        update BT2;

        GE_HQ_P_L__c BT3 = new GE_HQ_P_L__c(GE_HQ_P_L_ID__c=2226,Name='Testing PL for EMail3',GE_OG_Comments__c='testing for code coverage',GE_HQ_Parent_P_L_Name__c=BT2.id,CreatedByid = UserInfo.getUserId(),LastModifiedByid = UserInfo.getUserId());
        insert BT3; 
        BT3.Name = 'Changed to Test';       
        BT3.GE_OG_Comments__c = 'testing for test class';
        //BT3.CreatedByid = UserInfo.getUserId();
        update BT3;

        GE_HQ_P_L__c BT4 = new GE_HQ_P_L__c(GE_HQ_P_L_ID__c=2227,Name='Testing PL for EMail4',GE_OG_Comments__c='testing for code coverage',GE_HQ_Parent_P_L_Name__c=BT3.id,CreatedByid = UserInfo.getUserId(),LastModifiedByid = UserInfo.getUserId());
        insert BT4; 
        BT4.Name = 'Changed to Test';       
        BT4.GE_OG_Comments__c = 'testing for test class';
        //BT4.CreatedByid = UserInfo.getUserId();
        update BT4;

        GE_HQ_P_L__c BT5 = new GE_HQ_P_L__c(GE_HQ_P_L_ID__c=2228,Name='Testing PL for EMail5',GE_OG_Comments__c='testing for code coverage',GE_HQ_Parent_P_L_Name__c=BT4.id,CreatedByid = UserInfo.getUserId(),LastModifiedByid = UserInfo.getUserId());
        insert BT5; 
        BT5.Name = 'Changed to Test';       
        BT5.GE_OG_Comments__c = 'testing for test class';
        //BT5.CreatedByid = UserInfo.getUserId();
        update BT5;
        
        BTList.add(BT);
        BTList.add(BT1);
        BTList.add(BT2);
        BTList.add(BT3);
        BTList.add(BT4);
        BTList.add(BT5);
        list<GE_HQ_P_L__c> BTList1 = [select id,CreatedByid,LastModifiedByid,name,GE_OG_Comments__c ,GE_HQ_P_L_ID__c,GE_HQ_Parent_P_L_Name__c from GE_HQ_P_L__c where id in :BTList];
        system.debug('rrrrrrrrrrrrrrrrrrrr  ' + BT.CreatedByid);
        // System.assertEquals(bt.Name ,'Testing PL for EMail');
        //insert BTList; 
        //delete BTList;*/
        
        GE_HQ_Get_Region gr = new GE_HQ_Get_Region();
        gr.FindRegion();
        //GE_HQ_Get_Region.NotifyUsersOnInsertBusinessTier(BTList);
        //GE_HQ_Get_Region.NotifyUsersOnUpdateBusinessTier(BTList,BTList);
        //GE_HQ_Get_Region.NotifyUsersOnDeleteBusinessTier(BTList);
        
        /*
        delete BT5;
        delete BT4;
        delete BT3;
        delete BT2;
        delete BT1;
        delete BT;
        */
        Test.stopTest();       
    }
    
    
}