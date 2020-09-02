@IsTest
global class GE_OG_FSProjectDetails_Management_Test {
    
    public static  testmethod  void invokeTMBatch1Test(){       
        SVMXC__Service_Order__c wo = new SVMXC__Service_Order__c();
        insert wo;
        GE_OG_FS_Project_Detail__c tm = new GE_OG_FS_Project_Detail__c();
        tm.GE_OG_Installed_Product_ID__c = 'SSSN0001';
        tm.GE_OG_FS_Line_Type__c = 'Equipment';
        tm.GE_OG_Product_Code__c = 'PCSN1N2';
        tm.GE_OG_Product_Description__c = 'InvokingFromTestClass';
        tm.GE_OG_Product_Type__c = 'Parts';
        tm.GE_OG_Tier_1__c = 'Oil & Gas';
        tm.GE_OG_Tier_2__c = 'Oil Field Equipment';
        tm.GE_OG_Processed__c = false;
        insert tm;
        Test.startTest();
        GE_OG_InvokeFSProjectDetailMgmtBatch.executeFSPDProcessing();
        Test.stopTest();
    }
    public static  testmethod  void invokeTMBatch2Test(){
        Id fsProjectRecTypeId = Schema.SObjectType.GE_SS_Project__c.getRecordTypeInfosByName().get('SS Project').getRecordTypeId();
        Id pdtSMXRecTypeId = Schema.SObjectType.Product2.getRecordTypeInfosByName().get('ServiceMax').getRecordTypeId();
        Id ipEqpRecTypeId = Schema.SObjectType.SVMXC__Installed_Product__c.getRecordTypeInfosByName().get('Subsea Equipment').getRecordTypeId();
        Id ipSprRecTypeId = Schema.SObjectType.SVMXC__Installed_Product__c.getRecordTypeInfosByName().get('Subsea Spares').getRecordTypeId();
        Id ipToolRecTypeId = Schema.SObjectType.SVMXC__Installed_Product__c.getRecordTypeInfosByName().get('Subsea Tools').getRecordTypeId();
        Id wdEQPRecTypeId = Schema.SObjectType.SVMXC__Service_Order_Line__c.getRecordTypeInfosByName().get('Equipment').getRecordTypeId();
        Id wdSprRecTypeId = Schema.SObjectType.SVMXC__Service_Order_Line__c.getRecordTypeInfosByName().get('Spares').getRecordTypeId();
        Id wdtoolRecTypeId = Schema.SObjectType.SVMXC__Service_Order_Line__c.getRecordTypeInfosByName().get('Tools').getRecordTypeId();
        Id woRTId = Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('SS-Trip').getRecordTypeId();
        Product2 pd=new Product2();
        pd.name='PC1234';
        pd.ProductCode='PC1234';
        pd.Description='Test description';
        pd.IsActive = true;
        pd.CurrencyIsoCode='USD'; 
        pd.RecordTypeId = pdtSMXRecTypeId;
        insert pd;
        SVMXC__Installed_Product__c ip = new SVMXC__Installed_Product__c();
        ip.SVMXC__Product__c = pd.id;
        ip.GE_AL_Installed_Product_Type__c = 'Equipment';
        ip.GE_OG_SS_Tier2__c = 'Oil Field Equipment';
        ip.GE_OG_SS_Tier3__c = 'Subsea Systems';
        IP.Name = 'IPSN001';
        ip.SVMXC__Serial_Lot_Number__c = 'IPSN001';
        ip.RecordTypeId = ipEQPRecTypeId;
        insert ip;
        GE_SS_Project__c fsp = new GE_SS_Project__c();
        fsp.RecordTypeId = fsProjectRecTypeId;
        insert fsp;
        GE_SS_Project__c fspData = [select id,GE_SS_Project_ID__c from GE_SS_Project__c LIMIT 1];
        SVMXC__Service_Order__c wo = new SVMXC__Service_Order__c();
        wo.RecordTypeId = woRTId;
        insert wo;
        
        GE_OG_FS_Project_Detail__c tm2 = new GE_OG_FS_Project_Detail__c();
        tm2.GE_OG_Installed_Product_ID__c = 'IPSN001';
        tm2.GE_OG_FS_Line_Type__c = 'Equipment';
        tm2.GE_OG_Product_Code__c = 'PC1234';
        tm2.GE_OG_Product_Description__c = 'InvokingFromTestClass';
        tm2.GE_OG_Product_Type__c = 'Parts';
        tm2.GE_OG_Tier_1__c = 'Oil & Gas';
        tm2.GE_OG_Tier_2__c = 'Oil Field Equipment';
        tm2.GE_OG_Tier_3__c = 'Subsea Systems';
        tm2.GE_OG_Processed__c = false;
        tm2.GE_OG_FS_Project__c = fsp.id;
        insert tm2;
        SVMXC__Service_Order_Line__c wd = new SVMXC__Service_Order_Line__c();
        wd.SVMXC__Service_Order__c = wo.id;
        wd.SVMXC__Serial_Number__c = ip.id;
        wd.RecordTypeId = wdEQPRecTypeId;
        wd.GE_SS_FS_Project_Detail__c = tm2.id;
        insert wd;
        tm2.GE_OG_Processed__c = false;
        update tm2;
       
        Test.startTest();
        GE_OG_InvokeFSProjectDetailMgmtBatch.executeFSPDProcessing();
        Test.stopTest();
    }
    public static  testmethod  void invoketm3Batch1Test(){
        Id fsProjectRecTypeId = Schema.SObjectType.GE_SS_Project__c.getRecordTypeInfosByName().get('SS Project').getRecordTypeId(); 
        GE_SS_Project__c fsp = new GE_SS_Project__c();
        fsp.RecordTypeId = fsProjectRecTypeId;
        insert fsp;
        GE_SS_Project__c fspData = [select id,GE_SS_Project_ID__c from GE_SS_Project__c LIMIT 1];
        SVMXC__Service_Order__c wo = new SVMXC__Service_Order__c();
        insert wo;
        GE_OG_FS_Project_Detail__c tm3 = new GE_OG_FS_Project_Detail__c();
        tm3.GE_OG_Installed_Product_ID__c = 'SSSN0001';
        tm3.GE_OG_FS_Line_Type__c = 'Spares';
        tm3.GE_OG_Product_Code__c = 'PCSN1N2';
        tm3.GE_OG_Product_Description__c = 'InvokingFromTestClass';
        tm3.GE_OG_Product_Type__c = 'Parts';
        tm3.GE_OG_Tier_1__c = 'Oil & Gas';
        tm3.GE_OG_Tier_2__c = 'Oil Field Equipment';
        tm3.GE_OG_Tier_3__c = 'Subsea Systems';
        tm3.GE_OG_Processed__c = false;
        tm3.GE_OG_FS_project_ID__c = fspData.GE_SS_Project_ID__c;
        tm3.GE_SS_Tool_condition__c = 'Used';
        insert tm3;
        Profile p = [SELECT Id FROM Profile WHERE Name='System Integration GE OG'];
        User u = new User(Alias = 'standt', Email='standarduser@testorg.com',
        EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
        LocaleSidKey='en_US', ProfileId = p.Id,
        TimeZoneSidKey='America/Los_Angeles',
         UserName= 'UniqueTestUser@nomail.com');
        system.runAs(u){
            tm3.GE_OG_Line_Id__c = '192837';
            tm3.GE_OG_Processed__c = false;
            tm3.GE_SS_Tool_condition__c = 'Unused';
            update tm3;
        
        Test.startTest();
        GE_OG_InvokeFSProjectDetailMgmtBatch.executeFSPDProcessing();
        Test.stopTest();
            }
    }
    public static  testmethod  void invoketm4Batch1Test(){
        Id fsProjectRecTypeId = Schema.SObjectType.GE_SS_Project__c.getRecordTypeInfosByName().get('SS Project').getRecordTypeId();        
        SVMXC__Service_Order__c wo = new SVMXC__Service_Order__c();
        insert wo;
        GE_SS_Project__c fsP = new GE_SS_Project__c();
        fsP.GE_SS_Integration_Status__c = 'Failed';
        fsP.RecordTypeId = fsProjectRecTypeId;
        insert fsP;
        GE_OG_FS_Project_Detail__c tm4 = new GE_OG_FS_Project_Detail__c();
        tm4.GE_OG_Installed_Product_ID__c = 'SSSN0001';
        tm4.GE_OG_FS_Line_Type__c = 'Tools';
        tm4.GE_OG_Product_Code__c = 'PCSN1N2';
        tm4.GE_OG_Product_Description__c = 'InvokingFromTestClass';
        tm4.GE_OG_Product_Type__c = 'Parts';
        tm4.GE_OG_Tier_1__c = 'Oil & Gas';
        tm4.GE_OG_Tier_2__c = 'Oil Field Equipment';
        tm4.GE_OG_Tier_3__c = 'Subsea Systems'; 
        tm4.GE_OG_Processed__c = false; 
        insert tm4;
        Test.startTest();
        GE_OG_InvokeFSProjectDetailMgmtBatch.executeFSPDProcessing();
        GE_OG_InvokeFSProjectDetailMgmtBatch fsPDetail = new GE_OG_InvokeFSProjectDetailMgmtBatch();
        fsPDetail.closePopup();
        Test.stopTest();
    }
    public static  testmethod  void invoketm5Batch1Test(){
        Id fsProjectRecTypeId = Schema.SObjectType.GE_SS_Project__c.getRecordTypeInfosByName().get('SS Project').getRecordTypeId();  
        Id fsLinesRTId = Schema.SObjectType.GE_OG_FS_Project_Detail__c.getRecordTypeInfosByName().get('SS Lines').getRecordTypeId();        
        SVMXC__Service_Order__c wo = new SVMXC__Service_Order__c();
        insert wo;
        GE_SS_Project__c fsP = new GE_SS_Project__c();
        fsP.GE_SS_Integration_Status__c = 'Failed';
        fsP.RecordTypeId = fsProjectRecTypeId;
        insert fsP;
        GE_OG_FS_Project_Detail__c tm5 = new GE_OG_FS_Project_Detail__c();
        tm5.GE_OG_Installed_Product_ID__c = 'SSSN0001';
        tm5.GE_OG_FS_Line_Type__c = 'Tools';
        tm5.GE_OG_Product_Code__c = 'PCSN1N2';
        tm5.GE_OG_Product_Description__c = 'InvokingFromTestClass';
        tm5.GE_OG_Product_Type__c = 'Parts';
        tm5.GE_OG_Tier_1__c = 'Oil & Gas';
        tm5.GE_OG_Tier_2__c = 'Oil Field Equipment';
        tm5.GE_OG_Tier_3__c = 'Subsea Systems'; 
        tm5.GE_OG_Processed__c = false; 
        tm5.Integration_Status__c = 'Failed';
        tm5.RecordTypeId = fsLinesRTId;
        tm5.GE_SS_Actual_Shipped_Date_from_Customer__c = System.Today();
        tm5.GE_SS_Tool_condition__c = 'Unused';
        tm5.GE_SS_Expected_Arrival_Date_to_Shop__c = System.today();
        //tm5.GE_OG_Line_Type__c = 'Tools';
        insert tm5;
        Test.startTest();
        GE_OG_FSProjectRetryBatch woBatch= new GE_OG_FSProjectRetryBatch();
        database.executeBatch(woBatch, 20); 
        Test.stopTest();
    }
    public static  testmethod  void invoketm6Batch1Test(){
        Id fsLinesRTId = Schema.SObjectType.GE_OG_FS_Project_Detail__c.getRecordTypeInfosByName().get('SS Lines').getRecordTypeId();        
        SVMXC__Service_Order__c wo = new SVMXC__Service_Order__c();
        insert wo;
        GE_OG_FS_Project_Detail__c tm6 = new GE_OG_FS_Project_Detail__c();
        tm6.GE_OG_Installed_Product_ID__c = 'SSSN0001';
        tm6.GE_OG_FS_Line_Type__c = 'Tools';
        tm6.GE_OG_Product_Code__c = 'PCSN1N2';
        tm6.GE_OG_Product_Description__c = 'InvokingFromTestClass';
        tm6.GE_OG_Product_Type__c = 'Parts';
        tm6.GE_OG_Tier_1__c = 'Oil & Gas';
        tm6.GE_OG_Tier_2__c = 'Oil Field Equipment';
        tm6.GE_OG_Tier_3__c = 'Subsea Systems'; 
        tm6.GE_OG_Processed__c = false; 
        tm6.Integration_Status__c = 'Failed';
        tm6.RecordTypeId = fsLinesRTId;
        tm6.GE_SS_Actual_Shipped_Date_from_Customer__c = System.Today();
        tm6.GE_SS_Tool_condition__c = 'Unused';
        tm6.GE_SS_Expected_Arrival_Date_to_Shop__c = System.today();
        tm6.GE_OG_Line_Type__c = 'Tools';
        tm6.GE_OG_Line_Id__c = '123';
        insert tm6;
        Test.startTest();
        GE_OG_FSProjectLinesRetryBatch wo2Batch= new GE_OG_FSProjectLinesRetryBatch(); 
        database.executeBatch(wo2Batch, 20); 
        Test.stopTest();
    }
    public static  testmethod  void invokeTMBatch7Test(){ 
        GE_OG_FS_Project_Detail__c tm7 = new GE_OG_FS_Project_Detail__c();
        insert tm7;
        delete tm7;
    }
    public static  testmethod  void invoketm8Batch1Test(){
        Id fsLinesRTId = Schema.SObjectType.GE_OG_FS_Project_Detail__c.getRecordTypeInfosByName().get('SS Lines').getRecordTypeId();        
        SVMXC__Service_Order__c wo = new SVMXC__Service_Order__c();
        insert wo;
        GE_OG_FS_Project_Detail__c tm8 = new GE_OG_FS_Project_Detail__c();
        tm8.GE_OG_Installed_Product_ID__c = 'SSSN0001';
        tm8.GE_OG_FS_Line_Type__c = 'Tools';
        tm8.GE_OG_Product_Code__c = 'PCSN1N2'; 
        tm8.GE_OG_Processed__c = false; 
        tm8.Integration_Status__c = 'Failed';
        tm8.RecordTypeId = fsLinesRTId;
        tm8.GE_SS_Actual_Shipped_Date_from_Customer__c = System.Today();
        tm8.GE_SS_Tool_condition__c = 'Unused';
        tm8.GE_SS_Expected_Arrival_Date_to_Shop__c = System.today();
        tm8.GE_OG_Line_Type__c = 'Tools';
        tm8.GE_OG_Line_Id__c = '123';
        insert tm8;
        tm8.GE_SS_Tool_condition__c = 'Used';
        update tm8;
    }
    public static  testmethod  void GE_OG_SS_ProjectIntegration_UtilityTest(){
        Test.setMock(WebServiceMock.class, new WebServiceMockImpl());
        Set<Id> prjIdSet = new Set<Id>();
        Set<Id> fspdIdSet = new Set<Id>();
        GE_SS_Project__c prj = new GE_SS_Project__c();
        insert prj;
        GE_OG_FS_Project_Detail__c fspd = new GE_OG_FS_Project_Detail__c();
        insert fspd;
        prjIdSet.add(prj.id);
        fspdIdSet.add(fspd.id);
        delete prj;
        delete fspd;
        GE_OG_SS_ProjectIntegration_Utility.submitFSProjectToOracle(prjIdSet);
        GE_OG_SS_ProjectIntegration_Utility.submitFSProjectDetailUpdatesToOracle(fspdIdSet);
    }
     private class  WebServiceMockImpl implements WebServiceMock
    
    {
        public void doInvoke(
            Object stub, Object request, Map<String, Object> response,
            String endpoint, String soapAction, String requestName,
            String responseNS, String responseName, String responseType)
        {
            if(request instanceof GE_ES_GIBWSClient.publishOpportunity)
                response.put('response_x', new list<GE_SS_FSProjectLines_Publish.Rental_Output_Type>());
            return;
        }
    }
}