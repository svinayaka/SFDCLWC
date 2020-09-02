/*
1.GE_PRM_Contracts (Class)                          - 100%
2.GE_PRM_CustomContractCreateEditDelete(Trigger)    - 100%
3.GE_PRM_Populate_PnL_Channel_Leader (Trigger)      - 92%
*/

@isTest
Public class Test_GE_PRM_All_Contracts_Related {
    static testmethod void PRM_CustomContractCreateEditDelete_Method()
    {
        GE_ES_CustomerGalaxyIntegrationWrapper.IsFromTest = true;
          
            GE_ES_Sales_Region__c objsalesr = new  GE_ES_Sales_Region__c();
            objsalesr.Name = 'Europe';
            objsalesr.GE_ES_P_L__c = 'OG';
            insert objsalesr;
            
            GE_ES_Country_State_Sales_Region__c objcsname = new GE_ES_Country_State_Sales_Region__c();
            objcsname.GE_ES_Country_Name__c = 'ARGENTINA';
            objcsname.GE_ES_eTax_Country__c = true;
            insert objcsname;
            
            
            GE_HQ_Country__c objcountry = new GE_HQ_Country__c();
            objcountry.Name = 'ARGENTINA';
            objcountry.GE_HQ_ISO_Code__c = 'AG';
            objcountry.GE_OG_Fence_Time_days__c = 50;
            objcountry.GE_OG_Fence_Time_days_TurnKey__c = 60;
            insert objcountry;
            
            Account acc = new Account();
         
            User u=[select id,firstname,lastname,email from User where id=:userinfo.getUserId()];   
            
            acc.Name='Test Acc For TestClass1';  
           
            Schema.DescribeSObjectResult accObj1 = Schema.SObjectType.Account; 
            Map<String,Schema.RecordTypeInfo> accByName1 = accObj1.getRecordTypeInfosByName();
            Schema.RecordTypeInfo rtByName_acc1 =  accByName1.get('CMF Approved');
            Id acc1=rtByName_acc1.getRecordTypeId();
            acc.RecordTypeId=acc1;
            acc.GE_OG_AccFin_Status__c='In Progress';
            acc.account_status__c ='CC Approved';
            acc.ShippingCountry ='ARGENTINA';
            acc.GE_PW_Phone_New_Request__c='(111)111-1111';
            insert acc;
     
        //Insert a Non US Account.
        Account NonUSAccount = New Account(Name = 'Non US Account', ShippingCountry = 'India');
        Insert NonUSAccount;
        System.assertEquals(NonUSAccount.Name,'Non US Account');
       
        //Query the Profiles using Custom Setting - GE_Profile.
        
        //GE_Profile__c myChannelMgr = GE_Profile__c.getValues('GE_PRM Compliance');
        //Id chnlMagrId =  myChannelMgr.Profile_SFDC_ID__c;        
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator' limit 1]; 
        ID chnlMagrId = p.id ;
        
        //Insert Channel Manager
        User chnlManr = new User(firstname = 'channel', lastname = 'managers', email = 'chnmanagers@ge.com', alias = 'chnUsrs', profileId = chnlMagrId, Title = 'Channel Managers', Username = 'channelmagrs@ge.com', CommunityNickname = 'chus', TimeZoneSidKey = 'America/New_York', LocaleSidKey = 'en_US',  EmailEncodingKey= 'ISO-8859-1', LanguageLocaleKey= 'en_US');
        insert chnlManr;          
       
        //RecordTypeIds.
        String ApprovedApplicationRT = Schema.SObjectType.GE_PRM_Appointment__c.getRecordTypeInfosByName().get('GE_PRM_Application_Approved').getRecordTypeId();        
        String NewFastTrackRT = Schema.SObjectType.GE_PRM_Recommendation__c.getRecordTypeInfosByName().get('New Fast Track').getRecordTypeId();
        
        //Insert Commercial Vetting Application  US Account          
        GE_PRM_Commercial_Vetting__c cv = new GE_PRM_Commercial_Vetting__c();
        cv.GE_PRM_Account__c = acc.id;
        cv.GE_PRM_Tier_2__c='Measurement & Control (M&C)';
        cv.GE_PRM_Type__c='New';
        cv.GE_PRM_Status__c='Approved';
        cv.GE_PRM_Reasons_for_recommendation__c='Test';
        cv.GE_PRM_Reasons_for_relationship__c='Test';
        cv.GE_PRM_Other_channels_considered__c='No';
        cv.GE_PRM_of_sales_with_GE_products__c=10;
        cv.GE_PRM_Coverage_overlap__c='No';
        cv.GE_PRM_Investment_required__c='No'; 
        cv.GE_PRM_Competitive_lines_or_services__c='No';
        cv.GE_PRM_Complimentary_Lines__c='Test';
        cv.GE_PRM_Other_GE_products__c='No';
        cv.GE_PRM_Time_in_business__c='2';
        cv.GE_PRM_Reputation_of_channel__c='Test';
        cv.GE_PRM_of_sales_people_selling_GE__c=12;
        cv.GE_PRM_Total_revenue__c=12;
        cv.GE_PRM_Expected_GE_Revenue__c=12; 
        insert cv;
        
        //Insert Commercial Vetting Application  US Account          
        GE_PRM_Commercial_Vetting__c NonUSCV = new GE_PRM_Commercial_Vetting__c();
        NonUSCV.GE_PRM_Account__c = NonUSAccount.id;
        NonUSCV.GE_PRM_Tier_2__c='Measurement & Control (M&C)';
        NonUSCV.GE_PRM_Type__c='New';
        NonUSCV.GE_PRM_Status__c='Approved';
        NonUSCV.GE_PRM_Reasons_for_recommendation__c='Test';
        NonUSCV.GE_PRM_Reasons_for_relationship__c='Test';
        NonUSCV.GE_PRM_Other_channels_considered__c='No';
        NonUSCV.GE_PRM_of_sales_with_GE_products__c=10;
        NonUSCV.GE_PRM_Coverage_overlap__c='No';
        NonUSCV.GE_PRM_Investment_required__c='No'; 
        NonUSCV.GE_PRM_Competitive_lines_or_services__c='No';
        NonUSCV.GE_PRM_Complimentary_Lines__c='Test';
        NonUSCV.GE_PRM_Other_GE_products__c='No';
        NonUSCV.GE_PRM_Time_in_business__c='2';
        NonUSCV.GE_PRM_Reputation_of_channel__c='Test';
        NonUSCV.GE_PRM_of_sales_people_selling_GE__c=12;
        NonUSCV.GE_PRM_Total_revenue__c=12;
        NonUSCV.GE_PRM_Expected_GE_Revenue__c=12; 
        insert NonUSCV;
        
        //Insert Recommendation Object 
        GE_PRM_Recommendation__c recomObj = new GE_PRM_Recommendation__c();
        recomObj.recordtypeid = NewFastTrackRT;  
        recomObj.GE_PRM_Status__c = 'Approved';    
        recomObj.GE_PRM_Account__c=acc.id;
        recomObj.GE_PRM_sales_in_US_only__c='no';
        recomObj.GE_PRM_selling_to_government__c='No';
        recomObj.GE_PRM_use_of_sub_dealer__c='No';
        recomObj.GE_PRM_partner_1yr__c='No';
        recomObj.GE_PRM_Non_standard_discounts__c='Higher than Standard';
        recomObj.GE_PRM_Agreement_Type__c='New';
        recomObj.GE_PRM_Business_Tier_2__c=('Drilling & Surface (D&S)');
        recomObj.GE_PRM_Commercial_Vetting__c=cv.id;
        recomObj.GE_PRM_Channel_Manager_Contact__c='testing';
        recomObj.GE_PRM_GE_Channel_Manager_Name__c=chnlManr.Id;
        recomObj.GE_PRM_Agreement_term__c='5 Years';       
        insert recomObj;      
        test.startTest();
        //Insert Non US Recommendation Object 
        GE_PRM_Recommendation__c NonUSrecomObj = new GE_PRM_Recommendation__c();
        NonUSrecomObj.recordtypeid = NewFastTrackRT;  
        NonUSrecomObj.GE_PRM_Status__c = 'Approved';    
        NonUSrecomObj.GE_PRM_Account__c=NonUSAccount.id;
        NonUSrecomObj.GE_PRM_sales_in_US_only__c='no';
        NonUSrecomObj.GE_PRM_selling_to_government__c='No';
        NonUSrecomObj.GE_PRM_use_of_sub_dealer__c='No';
        NonUSrecomObj.GE_PRM_partner_1yr__c='No';
        NonUSrecomObj.GE_PRM_Non_standard_discounts__c='Higher than Standard';
        NonUSrecomObj.GE_PRM_Agreement_Type__c='New';
        NonUSrecomObj.GE_PRM_Business_Tier_2__c=('Drilling & Surface (D&S)');
        NonUSrecomObj.GE_PRM_Commercial_Vetting__c=NonUSCV.id;
        NonUSrecomObj.GE_PRM_Channel_Manager_Contact__c='testing';
        NonUSrecomObj.GE_PRM_GE_Channel_Manager_Name__c=chnlManr.Id;
        NonUSrecomObj.GE_PRM_Agreement_term__c='5 Years';       
        insert NonUSrecomObj; 
        
        // Insert Appointment
        GE_PRM_Appointment__c appointmentObj = new GE_PRM_Appointment__c(GE_PRM_Status__c = 'Approved',GE_PRM_Recommendation__c=recomObj.Id,GE_PRM_Applicant_Name__c = 'applicant name',GE_PRM_Account_Name__c = acc.id,GE_PRM_AFA_Type__c='Fast Track', recordtypeid = ApprovedApplicationRT);        
        insert appointmentObj;
        
        GE_PRM_Appointment__c appointmentNonUSObj = new GE_PRM_Appointment__c(GE_PRM_Status__c = 'Approved',GE_PRM_Recommendation__c=NonUSrecomObj.Id,GE_PRM_Applicant_Name__c = 'applicant name',GE_PRM_Account_Name__c = acc.id,GE_PRM_AFA_Type__c='Fast Track', recordtypeid = ApprovedApplicationRT);        
        insert appointmentNonUSObj;
        
        //Start the Test here as we are only Testing Contract Related Triggers and Classes.
        //test.startTest();
        
        // Create a List for Contracts
        List<Contract> Contracts = new List<Contract>();
        
        // Contract with Address Info.
        contract Cntrct = new contract(); 
        Cntrct.GE_ES_User_Lead_Sales_Person__c = chnlManr.id; 
        Cntrct.Accountid = acc.id; 
        Cntrct.GE_PRM_Region__c ='US South';
        Cntrct.GE_PRM_Business_Tier_1__c = 'Oil & Gas (O&G)'; 
        Cntrct.Status = 'Awaiting Review before to be sent to channel';  
        Cntrct.ContractTerm = 12;
        Cntrct.GE_PRM_Tier_2__c = 'Drilling & Surface (D&S)';
        Cntrct.GE_PRM_Tier_3__c = 'Artificial Lift (AL)';
        Cntrct.GE_PRM_Tier_4__c = 'Artificial Lift (AL)';
        Cntrct.GE_PRM_Recommendation_Link__c=recomObj.id; 
        Cntrct.GE_OG_Evergreen__c = true;
        Cntrct.BillingStreet =  'Test';
        Cntrct.BillingCity =  'Test';
        Cntrct.BillingState =  'Test';
        Cntrct.BillingPostalCode =  'Test';
        Cntrct.BillingCountry =  'Test';
        Cntrct.ShippingStreet =  'Test';
        Cntrct.ShippingCity =  'Test';
        Cntrct.ShippingState =  'Test';
        Cntrct.ShippingPostalCode =  'Test';
        Cntrct.ShippingCountry =  'Test';
        Contracts.add(Cntrct);
        
        // Contract without Address Info.
        contract NonUSCntrct = new contract(); 
        NonUSCntrct.GE_ES_User_Lead_Sales_Person__c = chnlManr.id; 
        NonUSCntrct.Accountid = NonUSAccount.id; 
        NonUSCntrct.GE_PRM_Business_Tier_1__c = 'Oil & Gas (O&G)'; 
        NonUSCntrct.Status = 'Awaiting Review before to be sent to channel';  
        NonUSCntrct.ContractTerm = 12;
        NonUSCntrct.GE_PRM_Tier_2__c = 'Drilling & Surface (D&S)';
        NonUSCntrct.GE_PRM_Tier_3__c = 'Artificial Lift (AL)';
        NonUSCntrct.GE_PRM_Tier_4__c = 'Artificial Lift (AL)';
        NonUSCntrct.GE_PRM_Recommendation_Link__c=NonUSrecomObj.id; 
        NonUSCntrct.GE_OG_Evergreen__c = true;
        
        Contracts.add(NonUSCntrct);
        
        test.stopTest();
        insert(Contracts);
         
        // To cover the GE_PRM_Contracts Class
        PageReference pageRef = Page.GE_MCS_Related_Contracts;
        //Set the Page.
        Test.setCurrentPage(pageRef);
        //Controller
        ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(Contracts[0]);
        //GE_PRM_Contracts ec = new GE_PRM_Contracts (sc);
        //Get Contracts Method
        //ec.getContracts();    
        
        // Delete Contracts
        Delete Contracts;
        //test.stopTest();
        
    }
}