@IsTest
Public Class GE_OG_SSInboundIntegration_Test
{
    public static  testmethod  void inboundFSLinesInfo(){ 
        Profile p = [SELECT Id FROM Profile WHERE Name='System Integration GE OG'];
        User u = new User(Alias = 'standt', Email='standarduser@testorg.com',
                          EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
                          LocaleSidKey='en_US', ProfileId = p.Id,
                          TimeZoneSidKey='America/Los_Angeles',
                          UserName= 'SSInboundTestUser@nomail.com');
        system.runAs(u){
            GE_SS_Project__c proj = New GE_SS_Project__c();
            insert proj;
            GE_OG_FS_Project_Detail__c FSPD = new GE_OG_FS_Project_Detail__c();
            FSPD.GE_OG_Line_Id__c = '123';
            insert FSPD;
            GE_OG_SSInboundIntegration ssinbound = new GE_OG_SSInboundIntegration();
            GE_OG_SSInboundIntegration.Status ssinboundStatus = new GE_OG_SSInboundIntegration.Status();
            GE_OG_SSInboundIntegration.Line_Status recStat = new GE_OG_SSInboundIntegration.Line_Status();
            List<GE_OG_SSInboundIntegration.Record_Status> recStatList = new List<GE_OG_SSInboundIntegration.Record_Status>();
            List<GE_OG_SSInboundIntegration.Project_detail> ProjList = new List<GE_OG_SSInboundIntegration.Project_detail>();
            GE_OG_SSInboundIntegration.Project_detail FSLine = new GE_OG_SSInboundIntegration.Project_detail();
            FSLine.Actual_Returned_Date = system.today();
            FSLine.Actual_Shipped_Date = system.today();
            FSLine.Customer_Request_Date = system.today();
            FSLine.FS_Project_Number = '12345';
            FSLine.Invoice_Date = system.today();
            FSLine.Invoice_Number = '12345';
            FSLine.Item = '123';
            FSLine.Item_Description = 'test';
            FSLine.Line_Number = '123';
            FSLine.Line_Status = 'CANCELLED';
            FSLine.OraclelineId = '123';
            FSLine.Order_Number = '123456789';
            FSLine.Order_Quantity = 1;
            FSLine.Order_Status = 'Shipped';
            FSLine.Product_Type = 'Parts';
            FSLine.Serial_Number = 'QTK1122';
            FSLine.Shipped_Quantity = 1;
            ProjList.add(FSLine);
            GE_OG_SSInboundIntegration.Project_detail FSLine2 = new GE_OG_SSInboundIntegration.Project_detail();
            FSLine2.Actual_Returned_Date = system.today();
            FSLine2.Actual_Shipped_Date = system.today();
            FSLine2.Customer_Request_Date = system.today();
            FSLine2.FS_Project_Number = '12345';
            FSLine2.Invoice_Date = system.today();
            FSLine2.Invoice_Number = '12345';
            FSLine2.Item = '123';
            FSLine2.Item_Description = 'test';
            FSLine2.Line_Number = '123';
            FSLine2.Line_Status = 'Shipped';
            FSLine2.OraclelineId = '1234';
            FSLine2.Order_Number = '123456789';
            FSLine2.Order_Quantity = 1;
            FSLine2.Order_Status = 'Shipped';
            FSLine2.Product_Type = 'Parts';
            FSLine2.Serial_Number = 'QTK1122';
            FSLine2.Shipped_Quantity = 1;
            ProjList.add(FSLine2);
            GE_OG_SSInboundIntegration.Record_Status recStatdata = new GE_OG_SSInboundIntegration.Record_Status();
            recStatdata.Id = Proj.id;
            recStatdata.Status= 'Success';
            recStatdata.Error_Message = 'Success';
            recStatList.add(recStatdata);
            
            GE_SS_Project__c proj_2 = New GE_SS_Project__c();
            insert proj_2;
            GE_OG_SSInboundIntegration.Record_Status recStatdata_2 = new GE_OG_SSInboundIntegration.Record_Status();
            recStatdata_2.Id = Proj_2.id;
            recStatdata_2.Status= 'Success';
            recStatdata_2.Error_Message = 'Success';
            recStatList.add(recStatdata_2);
            delete Proj_2;
            
            ssinboundStatus = GE_OG_SSInboundIntegration.updateProjStatus(recStatList);
            ssinboundStatus = GE_OG_SSInboundIntegration.updateProjLineStatus(recStatList);
            ssinboundStatus = GE_OG_SSInboundIntegration.updateProjlines(ProjList);
        }
    }
    public static  testmethod  void inboundFSProjectStatusInfo(){ 
        GE_OG_SSInboundIntegration.Status ssinboundStatus = new GE_OG_SSInboundIntegration.Status();
        GE_OG_SSInboundIntegration.Line_Status recStat = new GE_OG_SSInboundIntegration.Line_Status();
        List<GE_OG_SSInboundIntegration.Record_Status> recStatList = new List<GE_OG_SSInboundIntegration.Record_Status>();
        GE_OG_SSInboundIntegration.Record_Status recStatdata2 = new GE_OG_SSInboundIntegration.Record_Status();
        recStatdata2.Id = '123456';
        recStatdata2.Status= 'Success';
        recStatdata2.Error_Message = 'Success';
        recStatList.add(recStatdata2);
        ssinboundStatus = GE_OG_SSInboundIntegration.updateProjStatus(recStatList);
        GE_OG_FS_Project_Detail__c FSPD = new GE_OG_FS_Project_Detail__c();
        FSPD.GE_OG_Line_Id__c = '123456';
        insert FSPD;
        GE_OG_SSInboundIntegration.Record_Status recStatdata_2 = new GE_OG_SSInboundIntegration.Record_Status();
        recStatdata_2.Id = 'SUCCESSSUCCESSSUCCESSSUCCESSSUCCESSSUCCESSSUCCESSSUCCESSSUCCESSSUCCESSSUCCESSSUCCESSSUCCESSSUCCESSSUCCESSSUCCESSSUCCESSSUCCESSSUCCESSSUCCESSSUCCESSSUCCESSSUCCESSSUCCESSSUCCESSSUCCESSSUCCESSSUCCESSSUCCESSSUCCESSSUCCESSSUCCESSSUCCESSSUCCESSSUCCESSSUCCESSSUCCESS';
        recStatdata_2.Status= 'Success';
        recStatdata_2.Error_Message = 'Success';
        recStatList.add(recStatdata_2);
        ssinboundStatus = GE_OG_SSInboundIntegration.updateProjLineStatus(recStatList);
    }
}