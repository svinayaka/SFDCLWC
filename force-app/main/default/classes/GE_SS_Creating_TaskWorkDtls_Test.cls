/*
Req : R-26235
SubSea Test Class
The below Test class will covers the following class
GE_SS_Creating_TaskWorkDtls --- 100%
GE_SS_Attachments --- 96%
GE_SS_Labor_Atchmnts_workdtls_moblizeWO --- 96%
*/
@isTest
public class GE_SS_Creating_TaskWorkDtls_Test
{
    public static Id rtWOId = Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('SS-Mobilize').getRecordTypeId();
    public static Id rtESTMId = Schema.SObjectType.SVMXC__Service_Order_Line__c.getRecordTypeInfosByName().get('Estimate').getRecordTypeId();
    public static Id rtToolId = Schema.SObjectType.SVMXC__Service_Order_Line__c.getRecordTypeInfosByName().get('Tools Forecast').getRecordTypeId();
    public static testMethod void GE_SS_Creating_TaskWorkDtls_TestMethod()
    {
    
        SVMXC__Service_Group__c sg = new SVMXC__Service_Group__c( 
                                        Name = 'TestST',
                                        SVMXC__Country__c = 'United States',
                                        SVMXC__Active__c = true);
        insert sg;
        System.assertEquals(sg.Name,'TestST');      
        
        SVMXC__Service_Group_Members__c tech = new SVMXC__Service_Group_Members__c(
                                        Name = 'Test Tech',
                                        SVMXC__Service_Group__c = sg.id,                                      
                                        SVMXC__Enable_Scheduling__c = true,
                                        SVMXC__Active__c = true,
                                        SVMXC__Email__c = 'abc@xzy.com',
                                        SVMXC__Salesforce_User__c = UserInfo.getUserId());
        insert tech;
        System.assertEquals(tech.SVMXC__Enable_Scheduling__c,true);
        
         Product2 prod = new Product2(Name='Test Prod',
                                    ProductCode = '1234');
        insert prod;
        System.assertEquals(prod.Name,'Test Prod');

        
        SVMXC__Installed_Product__c ib = new SVMXC__Installed_Product__c(
                                    Name = 'TestIB',
                                    SVMXC__Product__c = prod.id,
                                    GE_AL_Installed_Product_Type__c  = 'Tools');
       insert ib;
        DateTime t = system.now();
        SVMXC__Service_Order__c wo = new SVMXC__Service_Order__c();
        wo.RecordTypeId =rtWOId;
        wo.SVMXC__Group_Member__c = tech.id; 
        wo.GE_SS_Billing_Reference__c='test';
        wo.SVMXC__Skill_Set__c = '[{"skillName":"8100 Casing Cutting","skillLevel":0,"skillId":"a3S12000004Y33rEAC","isSkillMandatory":false}]';
        insert wo;
        
        Test.startTest();
        SVMXC__Service_Order_Line__c wd = new SVMXC__Service_Order_Line__c();
        wd.RecordTypeId = rtESTMId;
        wd.SVMXC__Line_Type__c = 'Product';
        //wd.GE_SS_Service_Start_Date__c = system.today();
        //wd.GE_SS_Service_End_Date__c = system.today()+1;
        wd.GE_SS_Service_Start_Date__c = system.today();
        wd.GE_SS_Service_End_Date__c =  system.today()+370;
        wd.SVMXC__Work_Description__c='test';        
        wd.SVMXC__Service_Order__c = wo.Id;
        wd.GE_DS_Onshore_offshore__c='Onshore';        
        wd.SVMXC__Group_Member__c=tech.id;       
        wd.SVMXC__Activity_Type__c='Operating'; 
        wd.GE_SS_Billable_Days__c=2;
        wd.GE_DRL_Daily_Rate__c =2;
        wd.GE_SS_Total_Days_in_Service__c=4;       
        wd.SVMXC__Line_Status__c='Complete';
        wd.SVMXC__Serial_Number__c = ib.id;    
        insert wd;
        
        wd.SVMXC__Line_Type__c = 'Labor';
        update wd;
        
        
        Attachment objAttachment = new Attachment();
        objAttachment.ParentId = wd.id;
        //objAttachment.Name = 'test.pdf';
        objAttachment.Name = 'test';
        objAttachment.ContentType='Attachment';
        objAttachment.Body = Blob.valueof('test');
        insert objAttachment;
                
        SVMXC.INTF_WebServicesDef.SVMXMap objSVXMMap  = new SVMXC.INTF_WebServicesDef.SVMXMap();
        objSVXMMap.key = 'WorkDetail_ID';
        objSVXMMap.value = wd.Id;
        
        List<SVMXC.INTF_WebServicesDef.SVMXMap> objSVXMMapList  = new List<SVMXC.INTF_WebServicesDef.SVMXMap>();
        objSVXMMapList.add(objSVXMMap);
          
        SVMXC.INTF_WebServicesDef.INTF_Response response = new SVMXC.INTF_WebServicesDef.INTF_Response();
        response.valueMap = objSVXMMapList;
        
        ApexPages.currentPage().getParameters().put('id',wo.Id);
        SVMXC.INTF_WebServicesDef.INTF_Response res = GE_SS_Attachments.addAttachmentstoMWO(response);
        ApexPages.StandardController sc3 = new ApexPages.StandardController(objAttachment);    
        GE_SS_Labor_Atchmnts_workdtls_moblizeWO gsClass = new GE_SS_Labor_Atchmnts_workdtls_moblizeWO(sc3);
             gsClass.idval = String.valueOf(objAttachment.id);
             gsClass.woParentName=wo.name;
    gsClass.deleteRec();
    gsClass.redirectURL = '/001';
    //System.assertEquals(gsClass.Aid, null);
    gsClass.Aid = objAttachment.Id;
    gsClass.init();
    System.assertNotEquals(gsClass.Aid, null);
    gsClass.allRec = 'true';
    gsClass.init();        
         Test.stopTest();                 
    }
    
    public static testMethod void ToolForecast_TestMethod()
    {
    
        SVMXC__Service_Group__c sg = new SVMXC__Service_Group__c( 
                                        Name = 'TestST',
                                        SVMXC__Country__c = 'United States',
                                        SVMXC__Active__c = true);
        insert sg;
        System.assertEquals(sg.Name,'TestST');      
        
        SVMXC__Service_Group_Members__c tech = new SVMXC__Service_Group_Members__c(
                                        Name = 'Test Tech',
                                        SVMXC__Service_Group__c = sg.id,                                      
                                        SVMXC__Enable_Scheduling__c = true,
                                        SVMXC__Active__c = true,
                                        SVMXC__Email__c = 'abc@xzy.com',
                                        SVMXC__Salesforce_User__c = UserInfo.getUserId());
        insert tech;
        System.assertEquals(tech.SVMXC__Enable_Scheduling__c,true);
        
         Product2 prod = new Product2(Name='Test Prod',
                                    ProductCode = '1234');
        insert prod;
        System.assertEquals(prod.Name,'Test Prod');

        
        SVMXC__Installed_Product__c ib = new SVMXC__Installed_Product__c(
                                    Name = 'TestIB',
                                    SVMXC__Product__c = prod.id,
                                    GE_AL_Installed_Product_Type__c  = 'Tools');
       insert ib;
        DateTime t = system.now();
        SVMXC__Service_Order__c wo = new SVMXC__Service_Order__c();
        wo.RecordTypeId =rtWOId;
        wo.SVMXC__Group_Member__c = tech.id; 
        wo.GE_SS_Billing_Reference__c='test';
        wo.SVMXC__Skill_Set__c = '[{"skillName":"8100 Casing Cutting","skillLevel":0,"skillId":"a3S12000004Y33rEAC","isSkillMandatory":false}]';
        insert wo;
        
        Test.startTest();
        SVMXC__Service_Order_Line__c wd = new SVMXC__Service_Order_Line__c();
        wd.RecordTypeId = rtToolId;
        wd.SVMXC__Requested_Quantity2__c=3;
        wd.SVMXC__Line_Type__c = 'Product';
        //wd.GE_SS_Service_Start_Date__c = system.today();
        //wd.GE_SS_Service_End_Date__c = system.today()+1;
        wd.GE_SS_Service_Start_Date__c = system.today();
        wd.GE_SS_Service_End_Date__c =  system.today()+370;
        wd.SVMXC__Work_Description__c='test';        
        wd.SVMXC__Service_Order__c = wo.Id;
        wd.GE_DS_Onshore_offshore__c='Onshore';        
        wd.SVMXC__Group_Member__c=tech.id;       
        wd.SVMXC__Activity_Type__c='Operating'; 
        wd.GE_SS_Billable_Days__c=2;
        wd.GE_DRL_Daily_Rate__c =2;
        wd.GE_SS_Total_Days_in_Service__c=4;       
        wd.SVMXC__Line_Status__c='Complete';
        wd.SVMXC__Serial_Number__c = ib.id;    
        insert wd;
        
        wd.SVMXC__Line_Type__c = 'Labor';
        update wd;
        
        
        Attachment objAttachment = new Attachment();
        objAttachment.ParentId = wd.id;
        //objAttachment.Name = 'test.pdf';
        objAttachment.Name = 'test';
        objAttachment.ContentType='Attachment';
        objAttachment.Body = Blob.valueof('test');
        insert objAttachment;
                
        SVMXC.INTF_WebServicesDef.SVMXMap objSVXMMap  = new SVMXC.INTF_WebServicesDef.SVMXMap();
        objSVXMMap.key = 'WorkDetail_ID';
        objSVXMMap.value = wd.Id;
        
        List<SVMXC.INTF_WebServicesDef.SVMXMap> objSVXMMapList  = new List<SVMXC.INTF_WebServicesDef.SVMXMap>();
        objSVXMMapList.add(objSVXMMap);
          
        SVMXC.INTF_WebServicesDef.INTF_Response response = new SVMXC.INTF_WebServicesDef.INTF_Response();
        response.valueMap = objSVXMMapList;
        
        ApexPages.currentPage().getParameters().put('id',wo.Id);
        SVMXC.INTF_WebServicesDef.INTF_Response res = GE_SS_Attachments.addAttachmentstoMWO(response);
        ApexPages.StandardController sc3 = new ApexPages.StandardController(objAttachment);    
        GE_SS_Labor_Atchmnts_workdtls_moblizeWO gsClass = new GE_SS_Labor_Atchmnts_workdtls_moblizeWO(sc3);
             gsClass.idval = String.valueOf(objAttachment.id);
             gsClass.woParentName=wo.name;
    gsClass.deleteRec();
    gsClass.redirectURL = '/001';
    //System.assertEquals(gsClass.Aid, null);
    gsClass.Aid = objAttachment.Id;
    gsClass.init();
    System.assertNotEquals(gsClass.Aid, null);
    gsClass.allRec = 'true';
    gsClass.init();        
         Test.stopTest();                 
    }
    
     public static testMethod void GE_SS_Creating_TaskWorkDtls_addDaysMethod()
    {
       List<SVMXC__Service_Order_Line__c> wlList = new List<SVMXC__Service_Order_Line__c>() ; 
        SVMXC__Service_Group__c sg = new SVMXC__Service_Group__c( 
                                        Name = 'TestST',
                                        SVMXC__Country__c = 'United States',
                                        SVMXC__Active__c = true);
        insert sg;
        System.assertEquals(sg.Name,'TestST');      
        
        SVMXC__Service_Group_Members__c tech = new SVMXC__Service_Group_Members__c(
                                        Name = 'Test Tech',
                                        SVMXC__Service_Group__c = sg.id,                                      
                                        SVMXC__Enable_Scheduling__c = true,
                                        SVMXC__Active__c = true,
                                        SVMXC__Email__c = 'abc@xzy.com',
                                        SVMXC__Salesforce_User__c = UserInfo.getUserId());
        insert tech;
        System.assertEquals(tech.SVMXC__Enable_Scheduling__c,true);
        
         Product2 prod = new Product2(Name='Test Prod',
                                    ProductCode = '1234');
        insert prod;
        System.assertEquals(prod.Name,'Test Prod');

        
        SVMXC__Installed_Product__c ib = new SVMXC__Installed_Product__c(
                                    Name = 'TestIB',
                                    SVMXC__Product__c = prod.id,
                                    GE_AL_Installed_Product_Type__c  = 'Tools');
       insert ib;
        DateTime t = system.now();
        SVMXC__Service_Order__c wo = new SVMXC__Service_Order__c();
        wo.RecordTypeId =rtWOId;
        wo.SVMXC__Group_Member__c = tech.id; 
        wo.GE_SS_Billing_Reference__c='test';
        wo.SVMXC__Skill_Set__c = '[{"skillName":"8100 Casing Cutting","skillLevel":0,"skillId":"a3S12000004Y33rEAC","isSkillMandatory":false}]';
        insert wo;
        
        Test.startTest();
        SVMXC__Service_Order_Line__c wd = new SVMXC__Service_Order_Line__c();
        wd.RecordTypeId = rtESTMId;
        wd.SVMXC__Line_Type__c = 'Product';
        wd.GE_SS_Service_Start_Date__c = system.today();
        wd.GE_SS_Service_End_Date__c = system.today()+1;
        //wd.GE_SS_Service_Start_Date__c = system.today();
        //wd.GE_SS_Service_End_Date__c =  system.today()+370;
        wd.SVMXC__Service_Order__c = wo.Id;
        wd.GE_DS_Onshore_offshore__c='Onshore';        
        wd.SVMXC__Group_Member__c=tech.id;       
        wd.SVMXC__Activity_Type__c='Operating'; 
        wd.GE_SS_Billable_Days__c=2;
        wd.GE_DRL_Daily_Rate__c =2;
        wd.GE_SS_Total_Days_in_Service__c=4;       
        wd.SVMXC__Line_Status__c='Complete';
        wd.SVMXC__Serial_Number__c = ib.id;    
        insert wd;
        wlList.add(wd) ;
        
        wd.SVMXC__Line_Type__c = 'Labor';
        update wd;
                
        Attachment objAttachment = new Attachment();
        objAttachment.ParentId = wd.id;
        //objAttachment.Name = 'test.pdf';
        objAttachment.Name = 'test';
        objAttachment.ContentType='Attachment';
        objAttachment.Body = Blob.valueof('test');
        insert objAttachment;
        delete wd;
        
        GE_SS_Creating_TaskWorkDtls.GE_SS_NewToolsWLCreation(wlList) ;    
                   
         Test.stopTest();                
    }    
}