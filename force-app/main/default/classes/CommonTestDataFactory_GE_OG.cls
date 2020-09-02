/*
Description     : This is data factory containing various method for creating Dummy Records for Test Classes Used by all Scrum.
Functional Area : Transformation - All Scrum
Created By      : Nitish Pandey

*/
@isTest

//This Class contains method to craete records for Different Objects.
public class CommonTestDataFactory_GE_OG {     
    
    
    /* Create Opportunity Team Member */
    public static OpportunityTeamMember createOpportunityTeamMember(ID OppID, ID userID, String role){
        OpportunityTeamMember objOTM = new OpportunityTeamMember();
        objOTM.OpportunityID = OppID;
        objOTM.UserID = userID;
        objOTM.TeamMemberRole = role;
        return objOTM;
    }
    
    /* Create Opportunity Threshold Custom Setting*/
    public static Oppty_Threshold__c createThresholdCustomSetting1(){
        Oppty_Threshold__c objThrshold1 = new Oppty_Threshold__c();
        objThrshold1.Amount__c = 55000;
        objThrshold1.Tier_2__c = 'Digital Solutions';
        objThrshold1.Name = 'Digital Solutions';
        Insert objThrshold1;
        Return objThrshold1;
        
    }
    
    /* Create Opportunity Threshold Custom Setting*/
    public static Oppty_Threshold__c createThresholdCustomSettingOFS(){
        Oppty_Threshold__c objThrshold1 = new Oppty_Threshold__c();
        objThrshold1.Amount__c = 55000;
        objThrshold1.Tier_2__c = 'Oil Field Services';
        objThrshold1.Name = 'Oil Field Services';
        Insert objThrshold1;
        Return objThrshold1;
        
    }
    
    public static Oppty_Threshold__c createThresholdCustomSetting2(){
        
        
        Oppty_Threshold__c objThrshold2 = new Oppty_Threshold__c();
        objThrshold2.Amount__c = 55000;
        objThrshold2.Tier_2__c = 'Oil Field Equipment';
        objThrshold2.Name = 'Oil Field Equipment';
        Insert objThrshold2;
        Return objThrshold2;
        
    }
    
    public static Oppty_Threshold__c createThresholdCustomSetting3(){
        
        Oppty_Threshold__c objThrshold3 = new Oppty_Threshold__c();
        objThrshold3.Amount__c = 55000;
        objThrshold3.Tier_2__c = 'Oil Field Services';
        objThrshold3.Name = 'Oil Field Services';
        Insert objThrshold3;
        Return objThrshold3;  
        
    } 
    
    public static Oppty_Threshold__c createThresholdCustomSetting4(){
        Oppty_Threshold__c objThrshold4 = new Oppty_Threshold__c();
        objThrshold4.Amount__c = 55000;
        objThrshold4.Tier_2__c = 'Turbomachinery & Process Solutions';
        objThrshold4.Name = 'Turbomachinery & Process Solutions';
        Insert objThrshold4;
        Return objThrshold4;
    }
    
    
    
    /* Create Opportunity Reason Code Custom Setting*/
    public static List<Opportunity_Primary_Reason_Has_Code__c> createPrimaryReasonCustomSetting(){
        List<Opportunity_Primary_Reason_Has_Code__c> lstReasonCode = new List<Opportunity_Primary_Reason_Has_Code__c>(); 
        Opportunity_Primary_Reason_Has_Code__c objReasoncode = new Opportunity_Primary_Reason_Has_Code__c();
        objReasoncode.has_primary_sub_reason_code_ge_og__c = True;
        objReasoncode.primary_reason_code_ge_og__c = 'CLOSED WON-XYZ';
        objReasoncode.Name = '1';
        lstReasonCode.add(objReasoncode);
        
        objReasoncode = new Opportunity_Primary_Reason_Has_Code__c();
        objReasoncode.has_primary_sub_reason_code_ge_og__c = True;
        objReasoncode.primary_reason_code_ge_og__c = 'CLOSED Lost-XYZ';
        objReasoncode.Name = '2';
        lstReasonCode.add(objReasoncode);
        
        objReasoncode = new Opportunity_Primary_Reason_Has_Code__c();
        objReasoncode.has_primary_sub_reason_code_ge_og__c = True;
        objReasoncode.primary_reason_code_ge_og__c = 'CANCELLED-XYZ';
        objReasoncode.Name = '3';
        lstReasonCode.add(objReasoncode);
        
        objReasoncode = new Opportunity_Primary_Reason_Has_Code__c();
        objReasoncode.has_primary_sub_reason_code_ge_og__c = False;
        objReasoncode.primary_reason_code_ge_og__c = 'CANCELLED-ABC';
        lstReasonCode.add(objReasoncode);
        objReasoncode.Name = '4';
        return lstReasonCode;
    }
    
    
    
    
    public static Country_Region_Mapping_ge_og__c createCountryRegionMappingData(){
        Country_Region_Mapping_ge_og__c objcountryregmap = new Country_Region_Mapping_ge_og__c();
        objcountryregmap.Name = '1';
        objcountryregmap.country_name_ge_og__c = 'India';
        objcountryregmap.iso_code_ge_og__c = 'IN';
        objcountryregmap.region_ge_og__c = 'India';
        objcountryregmap.status_ge_og__c = 'Active';
        objcountryregmap.fence_fime_days_ge_og__c = 10;
        objcountryregmap.fence_time_days_turnkey_ge_og__c= 20;
        return objcountryregmap;
    }
    
    /* Method to create Custom Settinng */
    public static void createStaticCountryRegionMappingData(){
        Country_Region_Mapping_ge_og__c objcountryregmap = new Country_Region_Mapping_ge_og__c();
        objcountryregmap.Name = '2';
        objcountryregmap.country_name_ge_og__c = 'India';
        objcountryregmap.iso_code_ge_og__c = 'IN';
        objcountryregmap.region_ge_og__c = 'India';
        objcountryregmap.status_ge_og__c = 'Active';
        insert objcountryregmap;
    }
    
    public static Country_Region_Mapping_ge_og__c createCountryRegionMappingData(String name, String countryName, String isoCode, String region, String status){
        Country_Region_Mapping_ge_og__c objcountryregmap = new Country_Region_Mapping_ge_og__c();
        objcountryregmap.Name = name;
        objcountryregmap.country_name_ge_og__c = countryName;
        objcountryregmap.iso_code_ge_og__c = isoCode;
        objcountryregmap.region_ge_og__c = region;
        objcountryregmap.status_ge_og__c = status;
        //insert objcountryregmap;
        return objcountryregmap;
    }
    
    /* Method to create new Competitor account */
    public static account createCompetitorAccount (String accountName) {
        account accnt= new account();
        accnt.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','New Competitor').getRecordTypeId();
        accnt.name = accountName;
        accnt.Account_Tier_GEOG__c = 'Global';
        accnt.Classification__c= 'Strategic';
        accnt.Type = 'Competitor';
        accnt.ShippingCountry = 'India';
        accnt.Account_Status__c='Active';
        insert accnt;
        return accnt;
    }    
    
    /* Method to create new account */
    public static account createAccount (string accName) {
        account acc = new account();
        acc.name = accname;
        acc.recordtypeid= Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
        acc.ShippingCountry = 'India';
        acc.Account_Tier_GEOG__c = 'Global';
        acc.Region_GEOG__c = 'India';
        acc.Type = 'Direct Customer';
        acc.Classification__c = 'Strategic';
        
        insert acc;
        return acc;
    }
    
    /* Method to create new account */
    public static account createInternalLegalEntity(string accName) {
        account acc = new account();
        acc.name = accname;
        acc.recordtypeid= Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
        acc.ShippingCountry = 'India';
        acc.Account_Tier_GEOG__c = 'LE';
        //acc.Region_GEOG__c = 'India';
        acc.Type = 'Internal';
        acc.Classification__c = 'Strategic';
        insert acc;
        return acc;
    }
    
    
    
    /* Method to create new Relationship account */
    public static account createRelationshipAccount (string accName) {
        
        account acc = new account();
        acc.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        acc.name = accname;
        acc.Account_Tier_GEOG__c = 'Country';
        acc.Classification__c= 'Strategic';
        acc.Type = 'Partner';
        //acc.Type = 'Competitor';
        acc.ShippingCountry = 'India';
        acc.GE_ES_Primary_Industry__c = 'Marine';
        acc.Country_GEOG__c = 'India';
        insert acc;
        return acc;
    }
    
    /* Method to create new Relationship account */
    /*public static account createRelationshipAccount(string accName) {

account acc = new account();
acc.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
acc.name = accname;
acc.Account_Tier_GEOG__c = 'Country';
acc.Classification__c= 'Strategic';
acc.Type = 'Competitor';
acc.ShippingCountry = 'India';
insert acc;
return acc;
}*/
    
    /* Method to create new Relationship account */
    public static account createLegalEntityAccount1(string accName, ID accID) {
        
        account acc = new account();
        acc.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        acc.name = accname;
        acc.Account_Tier_GEOG__c = 'LE';
        acc.Oil_Gas_Parent_Account__c = accID;
        
        Account accGlobal= CommonTestDataFactory_GE_OG.createAccount('TestAccount Global');    
        acc.Member_of_GE_OG__c = accGlobal.Id;//
        
        
        acc.Country_GEOG__c = 'INDIA';
        acc.Classification__c= 'Strategic';
        acc.Type = 'Competitor';
        acc.ShippingCountry = 'India';
        acc.Account_Status__c = 'CC Approved';
        insert acc;
        return acc;
    }
    /* Method to create new Relationship account */
    public static account createLegalEntityAccount(string accName, ID accID) {
        
        account acc = new account();
        acc.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        acc.name = accname;
        acc.Account_Tier_GEOG__c = 'LE';
        acc.Oil_Gas_Parent_Account__c = accID;
        Account accGlobal= CommonTestDataFactory_GE_OG.createAccount('TestAccount Global');    
        acc.Member_of_GE_OG__c = accGlobal.Id;//
        //acc.Member_of_GE_OG__c = accID;//
        acc.Country_GEOG__c = 'INDIA';
        acc.Classification__c= 'Strategic';
        acc.Type = 'Competitor';
        acc.ShippingCountry = 'India';
        acc.Account_Status__c = 'CC Approved';
        insert acc;
        return acc;
    }
    
    /* Method to create new Selling LE account */
    public static account createSellingLegalEntityAccount(string accName, ID accID) {
        
        account acc = new account();
        acc.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        acc.name = accname;
        acc.Account_Tier_GEOG__c = 'LE';
        acc.Oil_Gas_Parent_Account__c = accID;
        Account accGlobal= CommonTestDataFactory_GE_OG.createAccount('TestAccount Global123');    
        acc.Member_of_GE_OG__c = accGlobal.Id;//
        //acc.Member_of_GE_OG__c = accID;//
        acc.Country_GEOG__c = 'INDIA';
        acc.Classification__c= 'Strategic';
        acc.Type = 'Internal';
        acc.ShippingCountry = 'India';
        acc.Account_Status__c = 'CC Approved';
        insert acc;
        return acc;
    }
    /* Method to create new Legal account */
    public static account createLegalEntityAccountWithMember(string accName, ID accID, ID memberID) {
        
        account acc = new account();
        acc.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        acc.name = accname;
        acc.Account_Tier_GEOG__c = 'LE';
        acc.Oil_Gas_Parent_Account__c = accID;
        acc.Country_GEOG__c = 'INDIA';
        acc.Classification__c= 'Strategic';
        acc.Type = 'Direct Customer';
        acc.ShippingCountry = 'India';
        acc.Account_Status__c = 'CC Approved';
        acc.Member_of_GE_OG__c = memberID;
        insert acc;
        return acc;
    }
    
    /* Create Competitor Account for PreBid
* */
    public static account createPreBidCompetitorAccount(String accCompName){
        account accComp = new account();
        accComp.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        accComp.name = accCompName;
        accComp.Account_Tier_GEOG__c = 'Country';
        accComp.Classification__c= 'Strategic';
        accComp.Type = 'Competitor';
        accComp.Account_Status__c = 'Active';
        accComp.ShippingCountry = 'India';
        accComp.Region_GEOG__c = 'India';
        insert accComp;
        return accComp;
    }
    
    /* Method to create new Commercial Parent account */
    public static account createCommercialParentAccount (string accName) {
        
        account acc = new account();
        acc.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        acc.name = accname;
        acc.Account_Tier_GEOG__c = 'Country';
        acc.Country_GEOG__c = 'INDIA';
        acc.Classification__c= 'Strategic';
        acc.Type = 'Competitor';
        acc.ShippingCountry = 'India';
        acc.Account_Status__c = 'Active';
        insert acc; 
        return acc;
    }
    
    /* Method to create new Commercial Parent account */
    /* Modified by Mohit - Comment Type as Competitor */
    public static account createCommercialParentAccountWithMember (string accName, ID accID) {
        
        account acc = new account();
        acc.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        acc.name = accname;
        acc.Account_Tier_GEOG__c = 'Country';
        acc.Country_GEOG__c = 'INDIA';
        acc.Classification__c= 'Strategic';
        acc.Type = 'Direct Customer';
        acc.Member_of_GE_OG__c = accID;
        acc.ShippingCountry = 'India';
        acc.GE_ES_Primary_Industry__c = 'Marine';
        insert acc;
        return acc;
    }
    
    
    
    /* Method to create new opportunity */
    public static opportunity createOppty(string oppName, id accountId){
        
        CommonTestDataFactory_GE_OG.DeactivateIFETrig();
        
        Oppty_Threshold__c OpptyThreshold= CommonTestDataFactory_GE_OG.createThresholdCustomSetting1();
        
        opportunity opp = new opportunity();
        opp.name= oppName;
        opp.stageName = 'Prospecting';
        opp.has_opportunitycontactrole_ge_og__c = True;
        opp.region_ge_og__c = 'Test Region';
        opp.Risk_Region_ge_og__c = 'Test Region';
        opp.closedate = system.today().addDays(30);
        opp.accountId = accountId;
        //Changed the below from Measurement & Control to Digital Solutions - kiru
        opp.tier_2_ge_og__c ='Digital Solutions';
        opp.tier_3_ge_og__c ='Bently Nevada';
        //opp.GE_Estimated_Amount__c = 1000.00;
        opp.amount_ge_og__c =100.00;
        opp.install_country_ge_og__c= 'India';  
        opp.oppty_cm_ge_og__c=14;
        insert opp;
        return opp;
    }
    
    /* Method to create new opportunity for OFS*/
    public static opportunity createOpptyOFS(string oppName, id accountId){
        
        CommonTestDataFactory_GE_OG.DeactivateIFETrig();
        
        Oppty_Threshold__c OpptyThreshold= CommonTestDataFactory_GE_OG.createThresholdCustomSettingOFS();
        
        opportunity opp = new opportunity();
        opp.name= oppName;
        opp.stageName = 'Prospecting';
        opp.has_opportunitycontactrole_ge_og__c = True;
        opp.region_ge_og__c = 'Test Region';
        opp.Risk_Region_ge_og__c = 'India';
        opp.closedate = system.today().addDays(30);
        opp.accountId = accountId;
        opp.tier_2_ge_og__c ='Oil Field Services';
        opp.tier_3_ge_og__c ='Artificial Lift';
        //opp.GE_Estimated_Amount__c = 1000.00;
        opp.amount_ge_og__c =10000.00;
        opp.install_country_ge_og__c= 'India';  
        opp.oppty_cm_ge_og__c=12;
        insert opp;
        return opp;
    }
    
    public static opportunity createOpptyOFSIWS(string oppName, id accountId){
        
        CommonTestDataFactory_GE_OG.DeactivateIFETrig();
        
        Oppty_Threshold__c OpptyThreshold= CommonTestDataFactory_GE_OG.createThresholdCustomSettingOFS();
        
        opportunity opp = new opportunity();
        opp.name= oppName;
        opp.stageName = 'Prospecting';
        opp.has_opportunitycontactrole_ge_og__c = True;
        opp.region_ge_og__c = 'Test Region';
        opp.Risk_Region_ge_og__c = 'India';
        opp.closedate = system.today().addDays(30);
        opp.accountId = accountId;
        opp.tier_2_ge_og__c ='Oil Field Services';
        opp.tier_3_ge_og__c ='Integrated Well Services';
        //opp.GE_Estimated_Amount__c = 1000.00;
        opp.amount_ge_og__c =10000.00;
        opp.install_country_ge_og__c= 'India';  
        opp.oppty_cm_ge_og__c=12;
        insert opp;
        return opp;
    }
    
    public static opportunity createOpptyHQ(string oppName, id accountId){
        
        CommonTestDataFactory_GE_OG.DeactivateIFETrig();
        
        Oppty_Threshold__c OpptyThreshold= CommonTestDataFactory_GE_OG.createThresholdCustomSetting1();
        
        opportunity opp = new opportunity();
        opp.name= oppName;
        opp.stageName = 'Prospecting';
        opp.has_opportunitycontactrole_ge_og__c = True;
        opp.region_ge_og__c = 'Test Region';
        opp.Risk_Region_ge_og__c = 'Test Region';
        opp.closedate = system.today().addDays(30);
        opp.accountId = accountId;
        //Changed the below from Measurement & Control to Digital Solutions - kiru
        opp.tier_2_ge_og__c ='HQ';
        opp.tier_3_ge_og__c ='None';
        //opp.GE_Estimated_Amount__c = 1000.00;
        opp.amount_ge_og__c =100.00;
        opp.install_country_ge_og__c= 'India';  
        
        insert opp;
        return opp;
    }
    
    public static opportunity createOppty1(string oppName, id accountId){
        
        CommonTestDataFactory_GE_OG.DeactivateIFETrig();
        
        opportunity opp = new opportunity();
        opp.name= oppName;
        opp.stageName = 'Prospecting';
        opp.has_opportunitycontactrole_ge_og__c = True;
        opp.region_ge_og__c = 'Test Region';
        opp.Risk_Region_ge_og__c = 'Test Region';
        opp.closedate = system.today().addDays(30);
        opp.accountId = accountId;
        //Changed the below from Measurement & Control to Digital Solutions - kiru
        opp.tier_2_ge_og__c ='Digital Solutions';
        opp.tier_3_ge_og__c ='Bently Nevada';
        //opp.GE_Estimated_Amount__c = 1000.00;
        opp.amount_ge_og__c =100.00;
        opp.install_country_ge_og__c= 'India';       
        insert opp;
        return opp;
    }
    
    public static opportunity createSSOppty(string oppSSName, id accountId){  
        opportunity oppSS = new opportunity();
        oppSS.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Opportunity','Grouped Flow').getRecordTypeId();
        oppSS.name= 'TESToppSS';
        oppSS.stageName = 'Negotiating';
        oppSS.has_opportunitycontactrole_ge_og__c = True;
        oppSS.region_ge_og__c = 'India';
        oppSS.Risk_Region_ge_og__c = 'India';
        oppSS.closedate = system.today().addDays(30);
        oppSS.Grouped_Flow_Type_ge_og__c = 'With Account';
        oppSS.accountId = accountId;
        oppSS.tier_2_ge_og__c ='Oil Field Services'; 
        oppSS.tier_3_ge_og__c ='Chemicals';
        oppSS.amount_ge_og__c =1000.00;
        oppSS.need_comm_ops_support_ge_og__c = true;
        oppSS.Is_express_ge_og__c = 'Yes';
        oppSS.opportunity_region_ge_og__c = 'Region';
        CommonTestDataFactory_GE_OG.DeactivateIFETrig();
        insert oppSS;
        return oppSS;
    }
    
    //added by harsha
    public static opportunity createOpptyForTPS(string oppName, id accountId){
        
        CommonTestDataFactory_GE_OG.DeactivateIFETrig();
        
        Oppty_Threshold__c OpptyThreshold= CommonTestDataFactory_GE_OG.createThresholdCustomSetting4();
        
        opportunity opp = new opportunity();
        opp.name= oppName;
        opp.stageName = 'Prospecting';
        opp.has_opportunitycontactrole_ge_og__c = True;
        opp.region_ge_og__c = 'Asia Pacific';
        opp.Risk_Region_ge_og__c = 'Asia Pacific';
        opp.closedate = system.today().addDays(30);
        opp.accountId = accountId;
        //Changed the below from Measurement & Control to Digital Solutions - kiru
        opp.tier_2_ge_og__c ='Turbomachinery & Process Solutions';
        opp.tier_3_ge_og__c ='New Units';
        //opp.F_AND_PT_Segment_GE_OG__c = 'Valves';
        //opp.GE_Estimated_Amount__c = 1000.00;
        opp.amount_ge_og__c =100.00;
        opp.install_country_ge_og__c= 'India';       
        insert opp;
        return opp;
    }
    
    //added by harsha
    public static opportunity createOpptyForTPSFPT(string oppName, id accountId){
        
        CommonTestDataFactory_GE_OG.DeactivateIFETrig();
        
        Oppty_Threshold__c OpptyThreshold= CommonTestDataFactory_GE_OG.createThresholdCustomSetting4();
        
        opportunity opp = new opportunity();
        opp.name= oppName;
        opp.stageName = 'Prospecting';
        opp.has_opportunitycontactrole_ge_og__c = True;
        opp.region_ge_og__c = 'Asia Pacific';
        opp.Risk_Region_ge_og__c = 'Asia Pacific';
        opp.closedate = system.today().addDays(30);
        opp.accountId = accountId;
        //Changed the below from Measurement & Control to Digital Solutions - kiru
        opp.tier_2_ge_og__c ='Turbomachinery & Process Solutions';
        opp.tier_3_ge_og__c ='Flow & Process Technologies';
        //opp.F_AND_PT_Segment_GE_OG__c = 'Valves';
        //opp.GE_Estimated_Amount__c = 1000.00;
        opp.amount_ge_og__c =100.00;
        opp.install_country_ge_og__c= 'India';  
        opp.F_AND_PT_Segment_GE_OG__c = 'Valves';
        insert opp;
        return opp;
    }
    
    /* Method to off IFE Trigger*/
    
    public static void DeactivateIFETrig()
    {    
        IFE__DisableOpportunityTriggers__c ifgetOppty = IFE__DisableOpportunityTriggers__c.getInstance('Test_Opty');
        System.debug('\n\n =============>>>>> IFE TRIGGER '+ifgetOppty);
        if(ifgetOppty == null){
            IFE__DisableOpportunityTriggers__c ifOppty = new IFE__DisableOpportunityTriggers__c();
            ifOppty.name = 'Test_Opty';
            ifOppty.IFE__Is_Disabled__c = true;
            insert ifOppty;
        }
        
    }   
    
    
    /*Method to Create new Products with different Tier 3 as Oppty */
    
    public static Product2 createProduct(String productName){
        Product2 product = new Product2();
        product.name = productName;
        // product.is_service_max_ge_og__c='Yes';
        //Changed the below from Measurement & Control to Digital Solutions - kiru
        product.GE_Tier2_PnL__c = 'Digital Solutions';
        product.GE_Tier3_PnL__c = 'Digital';
        product.IsActive = True;
        insert product; 
        return product;
        
    }
    
    public static Product2 createDigitalProduct(String productName){
        Product2 product = new Product2();
        product.name = productName;
        // product.is_service_max_ge_og__c='Yes';
        //Changed the below from Measurement & Control to Digital Solutions - kiru
        product.GE_Tier2_PnL__c = 'Digital Solutions';
        product.GE_Tier3_PnL__c = 'Digital';
        product.IsActive = True;
        product.digital_ge_og__c = True;
        insert product; 
        return product;
    }
    
    /*Method to Create new Products with same Tier 3 as Oppty */
    
    public static Product2 createProductSameTier3(String productName){
        Product2 product = new Product2();
        product.name = productName;
        // product.is_service_max_ge_og__c='Yes';
        //Changed the below from Measurement & Control to Digital Solutions - kiru
        product.GE_Tier2_PnL__c = 'Digital Solutions';
        product.GE_Tier3_PnL__c = 'Bently Nevada';
        product.IsActive = True;
        insert product; 
        return product;
        
    }
    
    public static Product2 createProduct(String productName, String tier){
        Product2 product = new Product2();
        product.name = productName;
        //  product.is_service_max_ge_og__c='Yes';
        product.GE_Tier2_PnL__c = tier;
        product.GE_Tier3_PnL__c = 'Test Tier3';
        product.IsActive = True;
        insert product; 
        return product;
        
    }
    
    /*Method to Create new Price Book Entry */
    public static PriceBookEntry createPriceBookEntry (product2 product){
        
        PriceBookEntry pricebk = new PriceBookEntry();
        pricebk.CurrencyIsoCode = 'USD';
        pricebk.UnitPrice = 1.0;
        pricebk.Pricebook2Id =Test.getStandardPricebookId();
        pricebk.Product2Id = product.id;
        pricebk.IsActive = true;  
        pricebk.UseStandardPrice = false;   
        insert pricebk; 
        return pricebk;
    }
    
    /* Method for creating new Opportunity Line Item */
    
    public static List<OpportunityLineItem> createOpportunityLineItemDiffTier(opportunity opp, List<PriceBookEntry> lstpbe){
        
        List<OpportunityLineItem> lstoli = new List<OpportunityLineItem>();
        
        for(Integer i=0;i<lstpbe.size();i++){
            OpportunityLineItem objOppline=new OpportunityLineItem();
            objOppline.opportunityid=opp.Id;
            // objOppline.GE_OG_PII_Diameter__c='02"';
            objOppline.PRICEBOOKENTRYID=lstpbe[i].id;
            objOppline.Quantity=2;
            //objOppline.CurrencyIsoCode = 'USD';
            objOppline.UNITPRICE=30; 
            objOppline.GE_OG_SS_Oppty_Product_CM__c = 45;
            lstoli.add(objOppline);
        }
        return lstoli;
    }
    
    public static List<OpportunityLineItem> createOpportunityLineItemSameTier(opportunity opp, List<PriceBookEntry> lstpbe){
        
        List<OpportunityLineItem> lstoli = new List<OpportunityLineItem>();
        
        for(Integer i=0;i<lstpbe.size();i++){
            OpportunityLineItem objOppline=new OpportunityLineItem();
            objOppline.opportunityid=opp.Id;
            // objOppline.GE_OG_PII_Diameter__c='02"';
            objOppline.PRICEBOOKENTRYID=lstpbe[i].id;
            //objOppline.CurrencyIsoCode = 'USD';
            objOppline.Quantity=1;
            objOppline.UNITPRICE=1000; 
            objOppline.GE_OG_SS_Oppty_Product_CM__c = 45;
            objOppline.GE_ES_Primary_Quote__c = True;
            lstoli.add(objOppline);
        }
        return lstoli;
    }
    
    
    public static OpportunityTeamMember createOpportunityTeamMember(opportunity opp){
        
        OpportunityTeamMember objOTM=new OpportunityTeamMember();
        objOTM.opportunityid=opp.Id;
        objOTM.TeamMemberRole ='Sales';
        objOTM.Userid= UserInfo.getUserID();
        insert objOTM;
        return objOTM;
    }
    
    
    public static OpportunityLineItem createOpportunityLineItem(opportunity opp, PriceBookEntry pricebk){
        
        OpportunityLineItem objOppline=new OpportunityLineItem();
        objOppline.opportunityid=opp.Id;
        //  objOppline.GE_OG_PII_Diameter__c='02"';
        objOppline.PRICEBOOKENTRYID=pricebk.id;
        objOppline.Quantity=2;
        objOppline.UNITPRICE=30; 
        //  objOppline.GE_OG_Expected_Delivery_Date__c = Date.Today();
        // objOppline.GE_OG_TM_Bid_Currency_Amount__c = 30;
        // objOppline.GE_OG_TM_Train__c ='T01';
        // objOppline.GE_OG_TM_Prod_Plt__c='Bari';
        objOppline.GE_OG_SS_Oppty_Product_CM__c = 45;
        //objOppline.CurrencyIsoCode = 'USD';
        objOppline.GE_ES_Primary_Quote__c = True;
        insert objOppline;
        return objOppline;
    }
    
    
    /* Method to create new CheckList Category */
    public static list<Checklist_Category_ge_og__c> createChecklistCategory(){
        
        //defining list for Checklist Category used for insertion
        list<Checklist_Category_ge_og__c> ChecklistCategoryList = new list<Checklist_Category_ge_og__c>();
        
        //creating map for storing category value of Checklist Category
        Map<integer, string> categoryMap = new Map<integer, string>{1 => 'Execution', 2 => 'Finance', 3 =>'Legal'};
            
            //Creating new Checklist Category for each Category Value
            for(integer i=1; i<=3; i++){
                Checklist_Category_ge_og__c clCategory = new Checklist_Category_ge_og__c();
                clCategory.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Checklist_Category_ge_og__c','Risk Checklist').getRecordTypeId();
                clCategory.checklist_type_ge_og__c = 'Risk Checklist';
                clCategory.active_ge_og__c = true;
                clCategory.checklist_category_tier_2_ge_og__c = 'All';
                clCategory.checklist_category_tier_3_ge_og__c = 'All';
                clCategory.category_ge_og__c = categoryMap.get(i);
                ChecklistCategoryList.add(clCategory);
            }
        
        insert ChecklistCategoryList;
        return ChecklistCategoryList;
        
    }
    public static list<Checklist_Category_ge_og__c> createFulfillmentChecklistCategory(){
        
        //defining list for Checklist Category used for insertion
        list<Checklist_Category_ge_og__c> ChecklistCategoryList = new list<Checklist_Category_ge_og__c>();
        
        //creating map for storing category value of Checklist Category
        Map<integer, string> categoryMap = new Map<integer, string>{1 => 'Execution', 2 => 'Finance', 3 =>'Legal'};
            
            //Creating new Checklist Category for each Category Value
            for(integer i=1; i<=3; i++){
                Checklist_Category_ge_og__c clCategory = new Checklist_Category_ge_og__c();
                clCategory.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Checklist_Category_ge_og__c','Fulfillment Checklist').getRecordTypeId();
                clCategory.active_ge_og__c = true;
                clCategory.category_ge_og__c = categoryMap.get(i);
                clCategory.oppty_driver_ge_og__c = 'All';
                clCategory.product_service_ge_og__c = 'All';
                clCategory.sitescope_ge_og__c = 'All';
                clCategory.checklist_category_tier_2_ge_og__c = 'All';
                clCategory.checklist_category_tier_3_ge_og__c = 'All';
                clCategory.checklist_category_tier_4_ge_og__c = 'ALL';
                
                ChecklistCategoryList.add(clCategory);
            }
        
        insert ChecklistCategoryList;
        return ChecklistCategoryList;
        
    }
    
    
    /* Method to create new CheckList */
    public static list<Checklist_ge_og__c> createChecklist( list<Checklist_Category_ge_og__c> checklistCategoryList){
        
        //defining list for Checklist used for insertion
        list<Checklist_ge_og__c> checklistList = new list<Checklist_ge_og__c>();
        
        //creating 5 records for each checklist category 
        for(Checklist_Category_ge_og__c clcategory : checklistCategoryList){
            for(integer i=1; i<=5; i++){
                Checklist_ge_og__c checklist = new Checklist_ge_og__c();
                checklist.active_checklist_ge_og__c = True;
                checklist.checklist_category_id_ge_og__c = clcategory.id;
                
                checklist.question_ge_og__c = 'Test ' + clcategory.category_ge_og__c + ' ' + i;
                checklistList.add(checklist);
            }
        }
        insert checklistList;
        return checklistList;
        
    }
    
    /* Method to create new Checklist Deviation */
    
    public static list<Checklist_Deviation_ge_og__c> createChecklistDeviation( list<Checklist_ge_og__c> checklistList){
        
        //defining list for Checklist used for insertion
        list<Checklist_Deviation_ge_og__c> checklistDeviationList = new list<Checklist_Deviation_ge_og__c>();
        
        //creating 5 records for each checklist category 
        for(Checklist_ge_og__c cl: checklistList){
            for(integer i=0; i<=5; i++){
                Checklist_Deviation_ge_og__c clDeviation = new Checklist_Deviation_ge_og__c();
                clDeviation.active_deviation_ge_og__c = True;
                clDeviation.checklist_id_ge_og__c = cl.id;
                clDeviation.checklist_deviation_level_ge_og__c= String.valueOf(i);
                clDeviation.deviation_ge_og__c= 'Test Answer' + ' ' + i;
                checklistDeviationList.add(clDeviation);
            }
        }
        insert checklistDeviationList ;
        return checklistDeviationList ;
        
    }
    
    
    /* Method for creating Deal Reviewer Criteria */
    public static List<Deal_Reviewer_Criteria_ge_og__c> createDealReviewerCriteria(String tier2,String region){
        
        List<Deal_Reviewer_Criteria_ge_og__c> dealReviewerList = new List<Deal_Reviewer_Criteria_ge_og__c>();
        Map<integer, string> categoryMap = new Map<integer, string>{1 => 'Execution', 2 => 'Finance', 3 =>'Legal'};
            for(integer i=1; i<=3; i++){
                for(integer j=0; j<=5; j++){
                    Deal_Reviewer_Criteria_ge_og__c dr = new Deal_Reviewer_Criteria_ge_og__c();
                    //dr.deal_reviewer_criteria_category_ge_og__c= categoryMap.get(i);
                    dr.type_ge_og__c = 'Reviewer';
                    
                    dr.deal_reviewer_criteria_tier_2_ge_og__c = tier2;
                    dr.deviation_level_ge_og__c = String.ValueOf(j);
                    //dr.deal_reviewer_criteria_region_ge_og__c = region;
                    dr.recordTypeId = Util_GE_OG.getRecordTypeDetails('Deal_Reviewer_Criteria_ge_og__c','Deal Reviewer').getRecordTypeId();
                    dealReviewerList.add(dr);
                }
                
            }
        
        insert dealReviewerList ;
        return dealReviewerList ;
        
    }
    
    /* Method for creating Deal Approver Criteria */
    public static List<Deal_Reviewer_Criteria_ge_og__c> createDealApproverCriteria(String category, String dealDeskRating,String level){
        
        List<Deal_Reviewer_Criteria_ge_og__c> dealReviewerList = new List<Deal_Reviewer_Criteria_ge_og__c>();
        for(integer i=0; i<=5; i++){
            Deal_Reviewer_Criteria_ge_og__c dr = new Deal_Reviewer_Criteria_ge_og__c();
            dr.recordTypeId = Util_GE_OG.getRecordTypeDetails('Deal_Reviewer_Criteria_ge_og__c','Deal Desk Approver').getRecordTypeId();
            //dr.deal_reviewer_criteria_category_ge_og__c= Category;
            dr.type_ge_og__c= 'Approver';
            //dr.deal_reviewer_criteria_region_ge_og__c= 'Test Region';
            
            dr.deviation_level_ge_og__c = level;
            dealReviewerList.add(dr);
        }
        
        insert dealReviewerList ;
        return dealReviewerList ;
        
    }
    
    public static List<Deal_Reviewer_Criteria_ge_og__c> createDealApproverCriteriaWithRegion(String Tier2,String dealDeskRating,string Region){
        
        List<Deal_Reviewer_Criteria_ge_og__c> dealReviewerList = new List<Deal_Reviewer_Criteria_ge_og__c>();
        for(integer i=0; i<=5; i++){
            Deal_Reviewer_Criteria_ge_og__c dr = new Deal_Reviewer_Criteria_ge_og__c();
            dr.recordTypeId = Util_GE_OG.getRecordTypeDetails('Deal_Reviewer_Criteria_ge_og__c','Deal Desk Approver').getRecordTypeId();
            dr.type_ge_og__c= 'Approver';
            //dr.deal_reviewer_criteria_region_ge_og__c= Region;
            dr.deal_reviewer_criteria_tier_2_ge_og__c =Tier2;
            
            dealReviewerList.add(dr);
        }
        
        insert dealReviewerList ;
        return dealReviewerList ;
        
    }
    
    /* Method for adding Deal Reviwer */
    public static List<Deal_Reviewer_ge_og__c> createDealApprover(List<Deal_Reviewer_Criteria_ge_og__c> drCriteriaList){
        List<Deal_Reviewer_ge_og__c> drList = new List<Deal_Reviewer_ge_og__c>();
        for(Deal_Reviewer_Criteria_ge_og__c drc:drCriteriaList){
            Deal_Reviewer_ge_og__c dr = new Deal_Reviewer_ge_og__c();
            //dr.deal_reviewer_criteria_num_ge_og__c = drc.id;
            dr.user_ge_og__c = UserInfo.getUserId();
            drList.add(dr);
        }
        
        insert drList;
        return drList;
    }
    
    /* Method for adding Deal Reviwer for PreBid approver*/
    public static List<Deal_Reviewer_ge_og__c> createDealApproverForPreBid(List<Deal_Reviewer_Criteria_ge_og__c> drCriteriaList){
        List<Deal_Reviewer_ge_og__c> drList = new List<Deal_Reviewer_ge_og__c>();
        for(Deal_Reviewer_Criteria_ge_og__c drc:drCriteriaList){
            Deal_Reviewer_ge_og__c dealRev = new Deal_Reviewer_ge_og__c();
            //dr.deal_reviewer_criteria_num_ge_og__c = drc.id;
            dealRev.DR_Region_ge_og__c='Test Region';
            dealRev.DR_Category_ge_og__c='PreBid Assesment';
            dealRev.DR_Approver_Level_ge_og__c='2';
            dealRev.DR_Tier_2_ge_og__c = 'Oil Field Services';
            dealRev.DR_Tier_3_ge_og__c = 'Artificial Lift';
            dealRev.user_ge_og__c = UserInfo.getUserId();
            drList.add(dealRev);
        }
        
        insert drList;
        return drList;
    }
    
    
    /* Method to create Product with ServicMax Products **/
    public static Product2 createProducts(String productname, String isservicemax){
        
        //Creating Product with servicemax product and updating record
        Product2 product = new Product2();
        product.name = productname;
        //product.product_tier_2_ge_og__c= 'Measurement & Control';
        product.GE_Tier3_PnL__c ='Bently Nevada';
        //  product.is_service_max_ge_og__c = isservicemax;
        insert product;
        return product;
    }
    
    /* Method to create Pre Bid Evaluation **/
    public static Pre_Bid_Evaluation_ge_og__c createPreBidEval(ID preBidID , Boolean isGERecord){
        Pre_Bid_Evaluation_ge_og__c objPreBidEval = new Pre_Bid_Evaluation_ge_og__c();
        objPreBidEval.pre_bid_name_ge_og__c = preBidID;
        objPreBidEval.ge_record_ge_og__c = isGERecord;
        return objPreBidEval;
    }
    
    /* Method to create Theme - Campaign*/
    public static Campaign createThemeCampaign(String themeName){
        Campaign theme = new Campaign();
        theme.Name=themeName;
        theme.RecordTypeId=Util_GE_OG.getRecordTypeDetails('Campaign','Theme').getRecordTypeId();
        theme.Description='Test Theme for Description';
        theme.OwnerId=UserInfo.getUserId();
        theme.Material_Documentation_link_ge_og__c='www.google.com';
        theme.StartDate = System.today()-10;
        theme.EndDate=System.today()+50;
        insert theme;
        return theme;
    }
    
    /* Method to create Program - Campaign*/
    public static Campaign createProgramCampaign(String programName,Id themeId){
        Campaign program = new Campaign();
        program.Name=programName;
        program.RecordTypeId=Util_GE_OG.getRecordTypeDetails('Campaign','Program').getRecordTypeId();
        program.ParentId=themeId;
        program.Description='Test program for Description';
        program.tier2_ge_og__c='Digital Solutions';
        program.tier3_ge_og__c='Bentley Nevada';
        program.OwnerId=UserInfo.getUserId();
        program.StartDate = System.today()-5;
        program.EndDate=System.today()+40;
        insert program;
        return program;
    }
    
    /* Method to create Campaign*/
    public static Campaign createCampaign(String cmpgnName,Id programId){
        Campaign cmpgn = new Campaign();
        cmpgn.Name=cmpgnName;
        cmpgn.RecordTypeId=Util_GE_OG.getRecordTypeDetails('Campaign','Campaign').getRecordTypeId();
        cmpgn.ParentId=programId;
        cmpgn.Description='Test Campaign for Description';
        cmpgn.tier2_ge_og__c='Digital Solutions';
        cmpgn.Owner_Function_ge_og__c='Marketing';
        
        cmpgn.Type='Outbound Telesales';
        cmpgn.Routing_info_qualified_lead_ge_og__c=' Routing Info';
        cmpgn.Target_List_Details_ge_og__c='Existing Database';
        cmpgn.Estimated_Number_of_Prospects_ge_og__c=2;
        cmpgn.Inside_sales_support_needed_ge_og__c='No';
        cmpgn.StartDate = System.today()+1;
        cmpgn.EndDate=System.today()+30;
        cmpgn.Target_Regions_ge_og__c='India';
        cmpgn.Primary_Target_Industry_ge_og__c='Upstream Offshore';
        cmpgn.Channel_Partner_Coverage_ge_og__c='20';
        cmpgn.Target_Number_of_Opportunities_ge_og__c=3;
        cmpgn.Anticipated_Mean_Opportunity_Value_ge_og__c=10;
        cmpgn.OwnerId=UserInfo.getUserId();
        cmpgn.ActualCost=10;        
        cmpgn.Commercial_owner_Telesales_script_ge_og__c=UserInfo.getUserId();
        cmpgn.Campaign_Target_Personas_ge_og__c = 'Other';
        cmpgn.Campaign_Business_Objective_ge_og__c='New Customers';
        
        insert cmpgn;
        cmpgn.Status = 'In Progress';
        update cmpgn;
        return cmpgn;
    }
    /* Method to create Synergy Theme - Campaign*/
    public static Campaign createSynergyTheme(String themeName){
        Campaign theme = new Campaign();
        theme.Name=themeName;
        theme.RecordTypeId=Util_GE_OG.getRecordTypeDetails('Campaign','Theme').getRecordTypeId();
        theme.Description='Test Theme for Description';
        theme.OwnerId=UserInfo.getUserId();
        theme.Material_Documentation_link_ge_og__c='www.google.com';
        theme.synergy_related_ge_og__c = 'Yes';
        theme.StartDate = System.today()+5;
        theme.EndDate=System.today()+50;
        insert theme;
        return theme;
    }
    
    /* Method to create Synergy Program type Campaign*/
    public static Campaign createSynergyProgram(String programName,Id themeId){
        Campaign program = new Campaign();
        program.Name=programName;
        program.RecordTypeId=Util_GE_OG.getRecordTypeDetails('Campaign','Program').getRecordTypeId();
        program.ParentId=themeId;
        program.Description='Test program for Description';
        program.tier2_ge_og__c='Digital Solutions';
        program.tier3_ge_og__c='Bentley Nevada';
        program.synergy_related_ge_og__c = 'Yes';
        program.OwnerId=UserInfo.getUserId();
        program.StartDate = System.today()+7;
        program.EndDate=System.today()+40;
        insert program;
        return program;
    }
    
    /* Method to create Lead */
    public static Lead createLead(String firstName,String lastName){
        Lead lead = new Lead();
        lead.firstName=firstName;
        lead.lastName= lastName;
        //lead.Campaign =cmpgnId;
        lead.Email=firstName+'_'+lastName+'@getest.com';
        lead.Status='Active123';
        //lead.Custom_Status_ge_og__c = 'Blacklisted';
        lead.OwnerId=UserInfo.getUserId();
        lead.RecordTypeId=Util_GE_OG.getRecordTypeDetails('Lead','Deal Machine Lead').getRecordTypeId();
        lead.Company='Test XTY Ltd';
        lead.sales_region_ge_og__c='India';
        insert lead;
        return lead;
    }
    
    /* Method to create Campaign Member*/
    public static CampaignMember createCampaignMember(Id cmpgnId, Id leadId){
        CampaignMember cmr = new CampaignMember();
        cmr.CampaignID =cmpgnId;
        cmr.LeadID = leadId;
        cmr.Status='Unassigned';
        insert cmr;
        return cmr;
    }
    
    // Method to create Custom Settings values for any generic Object Trigger to activate
    public static Opportunity_Trigger_Controller_ge_og__c createObjTriggerCstmSetting(Boolean bValue, String objName, String trigName){
        Opportunity_Trigger_Controller_ge_og__c oppScrumTrigSetting = new Opportunity_Trigger_Controller_ge_og__c();
        oppScrumTrigSetting.Name = trigName;
        oppScrumTrigSetting.Is_Active_ge_og__c = bValue;
        oppScrumTrigSetting.Object_ge_og__c = objName;
        oppScrumTrigSetting.Trigger_Name_ge_og__c = trigName;
        insert oppScrumTrigSetting;
        return oppScrumTrigSetting;
    }
    
    // Method to create Custom Settings values for Campaign Trigger to activate
    public static Opportunity_Trigger_Controller_ge_og__c createCampaignTriggerCstmSetting(Boolean bValue, String objName, String trigName){
        Opportunity_Trigger_Controller_ge_og__c oppScrumTrigSetting = new Opportunity_Trigger_Controller_ge_og__c();
        oppScrumTrigSetting.Name = trigName;
        oppScrumTrigSetting.Is_Active_ge_og__c = bValue;
        oppScrumTrigSetting.Object_ge_og__c = objName;
        oppScrumTrigSetting.Trigger_Name_ge_og__c = trigName;
        insert oppScrumTrigSetting;
        return oppScrumTrigSetting;
    }
    
    // Method to create Custom Settings values for Campaign Member Trigger to activate
    public static Opportunity_Trigger_Controller_ge_og__c createCampaignMemTriggerCstmSetting(Boolean bValue, String objName, String trigName){
        Opportunity_Trigger_Controller_ge_og__c oppScrumCMRTrigSetting = new Opportunity_Trigger_Controller_ge_og__c();
        oppScrumCMRTrigSetting.Name = trigName;
        oppScrumCMRTrigSetting.Is_Active_ge_og__c = bValue;
        oppScrumCMRTrigSetting.Object_ge_og__c = objName;
        oppScrumCMRTrigSetting.Trigger_Name_ge_og__c = trigName;
        insert oppScrumCMRTrigSetting;
        return oppScrumCMRTrigSetting;
    }
    
    // Method to create Custom Settings values for Lead Trigger to activate
    public static Opportunity_Trigger_Controller_ge_og__c createLeadTriggerCstmSetting(Boolean bValue, String objName, String trigName){
        Opportunity_Trigger_Controller_ge_og__c oppScrumLeadTrigSetting = new Opportunity_Trigger_Controller_ge_og__c();
        oppScrumLeadTrigSetting.Name = trigName;
        oppScrumLeadTrigSetting.Is_Active_ge_og__c = bValue;
        oppScrumLeadTrigSetting.Object_ge_og__c = objName;
        oppScrumLeadTrigSetting.Trigger_Name_ge_og__c = trigName;
        insert oppScrumLeadTrigSetting;
        return oppScrumLeadTrigSetting;
    }
    
    //Method to create Asset
    public static Asset createAsset(String assetName){
        Account acc = createRelationshipAccount('Test Account for asset');
        Asset asset = new Asset();
        asset.Name = assetName;
        asset.Summary_Scope_of_Supply_ge_og__c = 'Test summary scope';
        asset.AccountId = acc.Id;
        
        return asset;
    }
    //Method to create NonStd Project
    public static Project_ge_og__c createProject(String projectName){
        Account acc = createRelationshipAccount('Test Account for full stream');
        Project_ge_og__c project = new Project_ge_og__c();
        //Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Joint_Pursuit_Project').getRecordTypeId();
        project.RecordTypeId = Schema.SObjectType.Project_ge_og__c.getRecordTypeInfosByName().get('Joint Pursuit Project').getRecordTypeId();
        project.Project_Path_ge_og__c = 'Non Standard- Fullstream';
        project.project_account_ge_og__c = acc.Id;
        project.Project_Summary_ge_og__c = 'test';
        project.Estimated_Value_ge_og__c = 100;
        project.Name = projectName;
        insert project;
        return project;
    }
    
    //Method to create O&G Project
    public static Project_ge_og__c createProjectOG(String projectName){
        Account acc = createRelationshipAccount('Test Account for full stream');
        Project_ge_og__c project = new Project_ge_og__c();
        //Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Joint_Pursuit_Project').getRecordTypeId();
        project.RecordTypeId = Schema.SObjectType.Project_ge_og__c.getRecordTypeInfosByName().get('OG Project').getRecordTypeId();
        //project.Project_Path_ge_og__c = '';
        project.project_account_ge_og__c = acc.Id;
        project.Project_Summary_ge_og__c = 'test';
        project.Estimated_Value_ge_og__c = 100;
        project.Name = projectName;
        insert project;
        return project;
    }
    
    
}