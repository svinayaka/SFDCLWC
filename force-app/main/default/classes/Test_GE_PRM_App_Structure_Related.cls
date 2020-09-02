/*
It will cover the below classes & Triggers
1.GE_PRM_updateAccountPlan------

*/
@isTest(seeAllData = true)
public class Test_GE_PRM_App_Structure_Related
{
    //It will cover---GE_PRM_updateAccountPlan---trigger
    static testMethod void Test_GE_PRM_updateAccountPlan()
    {    
        Test.startTest();
        //Inserting Account plan object
        GE_HQ_Account_Plan__c accountpaln=new GE_HQ_Account_Plan__c();
        accountpaln.GE_PRM_No_of_Sales_Team_People__c=12;
        accountpaln.GE_PRM_CY_Total_Target__c=0;
        accountpaln.GE_PRM_Total_Activity_Sales_Team_Spend__c=0.25;
        insert accountpaln;
        System.assertEquals(accountpaln.GE_PRM_Total_Activity_Sales_Team_Spend__c,0.25);        
        //Insert account record
        RecordType rt = [SELECT Id FROM RecordType WHERE SObjectType='Account' AND Name='CMF Approved' LIMIT 1];
        String recordTypeId = rt.id;
        String accountName = 'HierarchyTest';
        
        Account acc= new Account(name=accountName+'0', GE_HQ_Country_Code__c='RU',ShippingStreet='1 Main St.', ShippingState='VA', ShippingPostalCode='12345', ShippingCountry='USA', ShippingCity='Anytown', Description='This is a test account', BillingStreet='1 Main St.', BillingState='VA', BillingPostalCode='12345', BillingCountry='USA', BillingCity='Anytown', AnnualRevenue=10000,recordtypeid=recordTypeId );
        insert acc;
       
        
        //Inserting Appointment object
        GE_PRM_Appointment__c  app= new GE_PRM_Appointment__c(); 
        app.GE_PRM_Status__c='Approved';  
        app.GE_PRM_Account_Name__c=acc.id;
        app.GE_PRM_Original_Source_System__c='some text data '; 
        insert app;  
        System.assertEquals(app.GE_PRM_Status__c,'Approved');
        
        //Inserting Recommendatation object 
        GE_PRM_Recommendation__c recomendation=new GE_PRM_Recommendation__c(); 
        recomendation.CurrencyIsoCode='USD';
        recomendation.GE_PRM_Appointment_Number__c=app.id; 
        recomendation.GE_PRM_Status__c='In Process';  
        recomendation.recordtypeid = '012A0000000jy4F'; 
        recomendation.GE_PRM_Agreement_Category__c='New';  
        recomendation.GE_PRM_Business_Tier_1__c='Power & Water (P&W)'; 
        recomendation.GE_PRM_Status__c='Approved';  
        insert recomendation; 
        System.assertEquals(recomendation.GE_PRM_Status__c,'Approved');
        
        Test.stopTest();
        //Inserting partner Information object
        GE_PRM_App_Structure__c appstruct=new GE_PRM_App_Structure__c();
        appstruct.GE_PRM_Account_Plan__c=accountpaln.id;
        appstruct.GE_PRM_Recommendation__c=recomendation.id;
        appstruct.GE_PRM_Current_Year_Est_Sales__c=0.50;
        appstruct.GE_PRM_of_time_on_GE__c=0;
        appstruct.GE_PRM_Appointment__c=app.id;
        appstruct.GE_PRM_Activity__c='text';
        insert appstruct;
        System.assertEquals(appstruct.GE_PRM_Activity__c,'text');      
        //Deleting partner information object
        delete appstruct;
        
    }
    
    public static GE_PRM_App_Structure__c createAppstructure(Id appId, String appType, boolean isDelete){
        return new GE_PRM_App_Structure__c(GE_PRM_Appointment__c = appId,  GE_PRM_Type__c = appType, GE_PRM_delete__c = isDelete);
    }          
    ////////////////////////To cover App Structure class
    
    static testMethod void Test_GE_PRM_App_Structure_Class_Method()
    {
        
        List<Profile> pf = [Select id,name from Profile where name ='Gold Partner User' limit 1];
        Id cusPartId =  pf[0].id;
       
        List<Profile> pf1 = [Select id,name from Profile where name ='System Administrator' limit 1];
        Id adminId=  pf1[0].id;      
        //inserting user object
        User usrobj = new User(Alias = 'standt', Email='standarduser@testorg.com',EmailEncodingKey='UTF-8', LastName='Sales Mgr DE PRM', LanguageLocaleKey='en_US',LocaleSidKey='en_US', ProfileId = adminId,TimeZoneSidKey='America/Los_Angeles', UserName='standarduser454@testorg.com');
        insert usrobj;
        System.assertEquals(usrobj.Alias,'standt');
        
        //inserting account      
       RecordType rt5 = [SELECT Id FROM RecordType WHERE SObjectType='Account' AND Name='CMF Approved' LIMIT 1];
        String recordTypeId = rt5.id;
        String accountName = 'HierarchyTest';
        
        RecordType rtRel = [SELECT Id FROM RecordType WHERE SObjectType='Account' AND Name='Relationship Account' LIMIT 1];
        String recordTypeIdRel = rtRel.id;
        Account acc= new Account(name=accountName+'0', GE_HQ_Country_Code__c='RU',ShippingStreet='1 Main St.', ShippingState='VA', ShippingPostalCode='12345', ShippingCountry='USA', ShippingCity='Anytown', Description='This is a test account', BillingStreet='1 Main St.', BillingState='VA', BillingPostalCode='12345', BillingCountry='USA', BillingCity='Anytown', AnnualRevenue=10000,recordtypeid=recordTypeIdRel,Type = 'Direct Customer', Classification__c = 'Strategic');
        insert acc;
        //inserting contact
        Contact cont = new Contact(GE_OG_Contact_Audience__c='Customer Care',firstname = 'test', lastname = 'partner', Email='testUnique@test.com', accountid = acc.Id, GE_ES_I_Agree_picklist__c='Yes', phone = '7709876789',GE_PRM_Primary_Contact__c = true);
        insert cont;
        System.assertEquals(cont.firstname,'test');
        
        //inserting partner user
        User partUser = new User(firstname = 'partner', BMUserType__c='Partner User',GE_HQ_Tier_3_P_L__c='Flow & Process Technologies (Dresser)',lastname = 'user', email = 'partneruser@ge.com', alias = 'pUsr', profileId = cusPartId, contactid = cont.id,
                                 Username = 'partuser@ge.com', title = 'Partner User', CommunityNickname = 'puse', TimeZoneSidKey = 'America/New_York', LocaleSidKey = 'en_US',  EmailEncodingKey= 'ISO-8859-1', LanguageLocaleKey= 'en_US');
        insert partUser;
        System.assertEquals(partUser.firstname,'partner');
        
        String rt = Schema.SObjectType.GE_PRM_Appointment__c.getRecordTypeInfosByName().get('GE_PRM_Application_Approved').getRecordTypeId();
        String rt1 = Schema.SObjectType.GE_PRM_Recommendation__c.getRecordTypeInfosByName().get('New Product Line').getRecordTypeId();
        
        //insert appointment record        
        GE_PRM_Appointment__c appointmentObj = new GE_PRM_Appointment__c(GE_PRM_Status__c = 'In Process', GE_PRM_Account_Name__c = acc.id, recordtypeid = rt, GE_PRM_Relatives_In_Govt_Yes__c= 'Sample Relatives in Govt',GE_PRM_Contact_Page__c ='Not Started');        
        insert appointmentObj;
        System.assertEquals(appointmentObj.GE_PRM_Status__c,'In Process'); 
        
        System.debug('****Appointment Obj****'+appointmentObj);            
        ApexPages.currentPage().getParameters().put('id',appointmentObj.id);                        
        List<GE_PRM_App_Structure__c> appStructureList = new List< GE_PRM_App_Structure__c>();
        
        appStructureList.add(createAppstructure(appointmentObj.id, 'Branch Offices', false));
        
        appStructureList.add(createAppstructure(appointmentObj.id, 'Owner', false));
        
        appStructureList.add(createAppstructure(appointmentObj.id, 'Officer/Director', false));
        
        appStructureList.add(createAppstructure(appointmentObj.id,  'General Reference', false));
        
        appStructureList.add(createAppstructure(appointmentObj.id,  'Principal Individuals', false));
        
        appStructureList.add(createAppstructure(appointmentObj.id,  'Expected Sales', false));
        
        appStructureList.add(createAppstructure(appointmentObj.id,  'Product lines or Services', false));
        
        appStructureList.add(createAppstructure(appointmentObj.id,  'Accountant', false));
        
        appStructureList.add(createAppstructure(appointmentObj.id,  'Financial References', false));
        
        appStructureList.add(createAppstructure(appointmentObj.id,  'Countries Company Licensed', false));
        
        appStructureList.add(createAppstructure(appointmentObj.id,   'Notes', false));
        
        appStructureList.add(createAppstructure(appointmentObj.id,  'Product lines or Services', false));
        
        appStructureList.add(createAppstructure(appointmentObj.id,  'Organization or Entity Affiliated with Applicant', false));
        
        //inserting app structure object
        GE_PRM_App_Structure__c AppStrcObj = createAppstructure(appointmentObj.id, 'Branch Offices', false);
        AppStrcObj.GE_PRM_Branch_Offices__c ='Sample Brach Off';
        AppStrcObj.GE_PRM_Ordering_Address_1__c ='Sample Address1';
        AppStrcObj.GE_PRM_Ordering_Address_2__c ='Sample Address2';
        AppStrcObj.GE_PRM_Ordering_City__c ='Sample City';
        AppStrcObj.GE_PRM_Ordering_Country__c ='United States';
        AppStrcObj.GE_PRM_Ordering_State_Province__c ='Sample State';
        AppStrcObj.GE_PRM_Ordering_Email__c ='SampleEmail@domain.com';
        AppStrcObj.GE_PRM_Ordering_Fax__c ='180012345';
        AppStrcObj.GE_PRM_Ordering_Phone__c ='180012346';
        AppStrcObj.GE_PRM_Ordering_Postal_Code__c ='Sample Postal';
        AppStrcObj.GE_PRM_Email__c = 'pragyaa@gm.com';
        insert AppStrcObj;
        System.assertEquals(AppStrcObj.GE_PRM_Ordering_Postal_Code__c,'Sample Postal');
        
        for(GE_PRM_App_Structure__c appStructureObj : appStructureList)
        {
            appStructureObj.GE_PRM_Ordering_Address_1__c ='Sample Address1';
            appStructureObj.GE_PRM_Ordering_Address_2__c ='Sample Address2';
            appStructureObj.GE_PRM_Ordering_City__c ='Sample City';
            appStructureObj.GE_PRM_Ordering_Country__c ='United States';
            appStructureObj.GE_PRM_Ordering_State_Province__c ='Sample State';
            appStructureObj.GE_PRM_Ordering_Email__c ='SampleEmail@domain.com';
            appStructureObj.GE_PRM_Ordering_Fax__c ='180012345';
            appStructureObj.GE_PRM_Ordering_Phone__c ='180012346';
            appStructureObj.GE_PRM_Ordering_Postal_Code__c ='Sample Postal';
            appStructureObj.GE_PRM_Email__c = 'pragyaa@gm.com';
            
            if(appStructureObj.GE_PRM_Delete__c == false && appStructureObj.GE_PRM_Type__c =='Branch Offices'){
                appStructureObj.GE_PRM_Branch_Offices__c ='Sample Brach Off';
                appStructureObj.GE_PRM_Email__c = 'pragyaa@gm.com';    
            }
            
            if(appStructureObj.GE_PRM_Delete__c == false && (appStructureObj.GE_PRM_Type__c == 'Accountant' ||  appStructureObj.GE_PRM_Type__c == 'Financial References' ||  appStructureObj.GE_PRM_Type__c == 'Owner' || appStructureObj.GE_PRM_Type__c == 'Officer/Director' ||  appStructureObj.GE_PRM_Type__c == 'Organization or Entity Affiliated with Applicant' ||  appStructureObj.GE_PRM_Type__c == 'Principal Individuals')){
                appStructureObj.GE_PRM_Name__c ='Same PRM Name'; 
                appStructureObj.GE_PRM_Email__c = 'pragyaa@gm.com';  
            }
            
            if(appStructureObj.GE_PRM_Delete__c == false && (appStructureObj.GE_PRM_Type__c == 'Organization or Entity Affiliated with Applicant' ||  appStructureObj.GE_PRM_Type__c == 'Owner')){
                appStructureObj.GE_PRM_Ownership__c =20; 
                appStructureObj.GE_PRM_Email__c = 'pragyaa@gm.com';   
            }
            
            if(appStructureObj.GE_PRM_Delete__c == false && (appStructureObj.GE_PRM_Type__c == 'Owner' || appStructureObj.GE_PRM_Type__c == 'Countries Company Licensed')){
                appStructureObj.GE_PRM_Countries__c='United States'; 
                appStructureObj.GE_PRM_Email__c = 'pragyaa@gm.com';   
            }
            
            if(appStructureObj.GE_PRM_Delete__c == false && (appStructureObj.GE_PRM_Type__c == 'Officer/Director' || appStructureObj.GE_PRM_Type__c == 'Principal Individuals')){
                appStructureObj.GE_PRM_Countries__c='United States';
                appStructureObj.GE_PRM_Title__c='Sample Title'; 
                appStructureObj.GE_PRM_Email__c = 'pragyaa@gm.com';                    
            }
            
            if(appStructureObj.GE_PRM_Delete__c == false && appStructureObj.GE_PRM_Type__c == 'Officer/Director'){
                appStructureObj.GE_PRM_Start_Date__c = Date.today();
                appStructureObj.GE_PRM_Email__c = 'pragyaa@gm.com';    
            }
            
            if(appStructureObj.GE_PRM_Delete__c == false && appStructureObj.GE_PRM_Type__c == 'General Reference'){
                appStructureObj.GE_PRM_Company_Name__c = 'Sample Company';  
                appStructureObj.GE_PRM_City__c ='Sample City'; 
                appStructureObj.GE_PRM_Countries__c='United States';
                appStructureObj.GE_PRM_Email__c = 'pragyaa@gm.com';              
            }
            
            if(appStructureObj.GE_PRM_Delete__c == false && (appStructureObj.GE_PRM_Type__c == 'Accountant' || appStructureObj.GE_PRM_Type__c == 'General Reference' || appStructureObj.GE_PRM_Type__c == 'Financial References')){
                appStructureObj.GE_PRM_Contact__c= 'Sample Contact'; 
                appStructureObj.GE_PRM_Complete_Address__c= 'Sample Complete Address';
                appStructureObj.GE_PRM_Email__c = 'pragyaa@gm.com';  
            }
            
            if(appStructureObj.GE_PRM_Delete__c == false && (appStructureObj.GE_PRM_Type__c == 'Accountant' || appStructureObj.GE_PRM_Type__c == 'General Reference' ||  appStructureObj.GE_PRM_Type__c == 'Financial References' || appStructureObj.GE_PRM_Type__c == 'Principal Individuals')){
                appStructureObj.GE_PRM_Phone__c= '180012345';  
                appStructureObj.GE_PRM_Email__c = 'pragyaa@gm.com';
            }
            
            if(appStructureObj.GE_PRM_Delete__c == false && (appStructureObj.GE_PRM_Type__c == 'Accountant' || appStructureObj.GE_PRM_Type__c == 'Financial References')){
                appStructureObj.GE_PRM_Complete_Address__c= 'Sample Complete Address';
                appStructureObj.GE_PRM_Email__c = 'pragyaa@gm.com';  
            }
            
            if(appStructureObj.GE_PRM_Delete__c == false && appStructureObj.GE_PRM_Type__c == 'Notes'){
                appStructureObj.GE_PRM_Notes_Questions_Etc__c= 'Sample Notes';
                appStructureObj.GE_PRM_Email__c = 'pragyaa@gm.com';  
            }
            
            if(appStructureObj.GE_PRM_Delete__c == false && appStructureObj.GE_PRM_Type__c == 'Organization or Entity Affiliated with Applicant'){
                appStructureObj.GE_PRM_Activity__c='Sample Activity';
                appStructureObj.GE_PRM_City_of_Registration__c ='Sample City Reg';
                appStructureObj.GE_PRM_Complete_Address__c ='Sample Complete Address';
                appStructureObj.GE_PRM_Relationship_Starting_Date__c = Date.today()+1;
                appStructureObj.GE_PRM_Name__c ='Sample Name';
                appStructureObj.GE_PRM_Relationship__c ='Sample Relationship';
                appStructureObj.GE_PRM_Ownership__c =25;
                appStructureObj.GE_PRM_Countries__c ='United States';
                appStructureObj.GE_PRM_Email__c = 'pragyaa@gm.com';
            }                    
        }
        insert appStructureList;
        
        System.runas(usrobj)
        {
            Test.startTest();
            
            //ApexPages.StandardController appObj = new ApexPages.StandardController(appointmentObj); 
            //GE_PRM_Appointment_Class applc = new GE_PRM_Appointment_Class(appObj);            
            //The below lines will cover the GE_PRM_Appointment_Class
            /*
applc.bPartnerUser = true;
applc.bAppAccess = true; 
PageReference pg;
pg = applc.marketingNext();
pg = applc.marketingPrev();    
pg = applc.affiliationsNext();
pg = applc.affiliationsPrev();                  
Blob bdyVal = Blob.valueOf('Attachment Body');
applc.attachmentCompanyLetterHead = new Attachment();
applc.attachmentCompanyLetterHead.body=bdyVal;
applc.attachmentCompanyLetterHead.Name='Test1';
applc.attachmentCompanyRegistration = new Attachment();
applc.attachmentCompanyRegistration.body=bdyVal;
applc.attachmentCompanyRegistration.Name='Test1';
applc.attachmentBalanceSheet1 = new Attachment();
applc.attachmentBalanceSheet1.body=bdyVal;
applc.attachmentBalanceSheet1.Name='Test1';
applc.attachmentBalanceSheet2 = new Attachment();
applc.attachmentBalanceSheet2.body=bdyVal;                  
applc.uploadRequiredDocuments();
applc.sdelAttachments = applc.attachmentCompanyLetterHead.id +';'+ applc.attachmentCompanyRegistration.id;
*/
            //pg = applc.deleteAttachments();
            PageReference pg;
            ApexPages.currentPage().getParameters().put('ApplicationId',appointmentObj.id);
            ApexPages.currentPage().getParameters().put('Id',AppStrcObj.id);
            
            //appObj = new ApexPages.StandardController(AppStrcObj); 
            //GE_PRM_App_Structure_Class AppStruObj = new GE_PRM_App_Structure_Class(appObj);
            ApexPages.currentPage().getParameters().put('pageName','sBranch');
            //AppStruObj.bCompleted = true;
           // AppStruObj.bPartiallyCompleted = true;
            //pg = AppStruObj.saveBranchDetails();
            //pg = AppStruObj.addressNext();
            //pg = AppStruObj.branchNext();
            //pg = AppStruObj.requestedPage();
            //pg = AppStruObj.branchDetail();                                
            Test.stopTest();  
        } 
        
    }
    
    static testMethod void Test_GE_PRM_DeleteNotes_Insert()
    {    
        //inserting account
       RecordType rt = [SELECT Id FROM RecordType WHERE SObjectType='Account' AND Name='CMF Approved' LIMIT 1];
        String recordTypeId = rt.id;
        String accountName = 'HierarchyTest';
        
        Account acc= new Account(name=accountName+'0', GE_HQ_Country_Code__c='RU',ShippingStreet='1 Main St.', ShippingState='VA', ShippingPostalCode='12345', ShippingCountry='USA', ShippingCity='Anytown', Description='This is a test account', BillingStreet='1 Main St.', BillingState='VA', BillingPostalCode='12345', BillingCountry='USA', BillingCity='Anytown', AnnualRevenue=10000,recordtypeid=recordTypeId );
        insert acc;
        
        
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
        
        //inserting appointment
        GE_PRM_Appointment__c apptmt=new GE_PRM_Appointment__c();
        apptmt.GE_PRM_Account_Name__c=acc.Id;
        apptmt.GE_PRM_Legal_Address_1__c='address1';
        apptmt.GE_PRM_Legal_Address_2__c='address2';
        apptmt.GE_PRM_Due_Diligence_Completion__c=null;
        apptmt.GE_PRM_AFA_Type__c='Fast Track';
        apptmt.GE_PRM_Applicant_Name__c='applicant';
        apptmt.GE_PRM_Date_and_Place_Entity_Founded__c='text';
        apptmt.GE_PRM_Legal_Structure_New__c='Partnership';
        apptmt.GE_PRM_Applicant_Contact_Name__c='contact';
        apptmt.GE_PRM_Legal_Phone__c='7709876789';
        apptmt.GE_PRM_Legal_Fax__c='7709876789';
        apptmt.GE_PRM_Mobile__c='7709876789';
        apptmt.GE_PRM_Applicant_Email__c='partneruser@ge.com';
        apptmt.GE_PRM_Applicant_Website_Address__c='www.google.com';
        apptmt.GE_PRM_Address_1__c='address1';
        apptmt.GE_PRM_Address_2__c='address2';
        apptmt.GE_PRM_Country_New__c='Angola';
        apptmt.GE_PRM_No_Of_Employees__c=10;
        apptmt.GE_PRM_Status__c='In Process';
        
        insert apptmt;
        System.assertEquals(apptmt.GE_PRM_Status__c,'In Process');
        
        //inserting recommendation  
        GE_PRM_Recommendation__c recomm=new GE_PRM_Recommendation__c();
        recomm.GE_PRM_Appointment_Number__c = apptmt.Id;
        recomm.GE_PRM_Account__c=acc.id;
        recomm.GE_PRM_Due_Diligence_Completed__c=null;
        recomm.GE_PRM_Compliance_Status__c='Compliance Accepted';
        recomm.GE_PRM_Business_Tier_1__c = 'Oil & Gas (O&G)';
        recomm.GE_PRM_Business_Tier_2__c=('Drilling & Surface (D&S)');
        recomm.GE_PRM_Business_Tier_3__c='Automation';
        recomm.GE_PRM_Business_Tier_4__c='Actuators';
        recomm.GE_PRM_Recommended_channel_type__c = 'Sales Representative (SR)';
        recomm.GE_PRM_Agreement_Category__c='New';
        recomm.GE_PRM_Agreement_effective_date__c=system.today();
        recomm.GE_PRM_Agreement_expiration__c=system.today();
        recomm.GE_PRM_Sales_Manager_Contact__c='contact';
        recomm.GE_PRM_Region__c='Canada';
        recomm.GE_PRM_Key_customers_covered__c='text';
        recomm.GE_PRM_Company_type__c='text';
        recomm.GE_PRM_No_of_Yr_Working_with_Channel_Rep__c='1-4 Years';
        recomm.GE_PRM_Appointment_Number__c=apptmt.id;
        recomm.GE_PRM_RFA_Type__c='Track';
        recomm.GE_PRM_Status__c = 'In Process';
        recomm.GE_PRM_Agreement_Type__c='New';
        recomm.GE_PRM_Commercial_Vetting__c=cv.id;
        insert recomm;
        
        
        List<GE_PRM_App_Structure__c> appStructureListDeleteNotes = new List< GE_PRM_App_Structure__c>();
        GE_PRM_App_Structure__c ap1 = new GE_PRM_App_Structure__c ();
        ap1.GE_PRM_Type__c = 'Notes';
        ap1.Cloned_Record__c = true;
        ap1.GE_PRM_Notes_Questions_Etc__c ='1';
        ap1.GE_PRM_Appointment__c = apptmt.Id;
        appStructureListDeleteNotes.add(ap1);
        
        GE_PRM_App_Structure__c ap2 = new GE_PRM_App_Structure__c ();
        ap2.GE_PRM_Type__c = 'Government Training';
        ap2.GE_PRM_Recommendation__c = recomm.Id;
        appStructureListDeleteNotes.add(ap2);        
        
        
        GE_PRM_App_Structure__c ap3 = new GE_PRM_App_Structure__c ();
        ap3.GE_PRM_Type__c = 'Branch Office';
        ap3.GE_PRM_Appointment__c = apptmt.Id;
        appStructureListDeleteNotes.add(ap3);        
        
        GE_PRM_App_Structure__c ap4 = new GE_PRM_App_Structure__c ();
        ap4.GE_PRM_Type__c = 'Subsidiary';
        ap4.GE_PRM_Appointment__c = apptmt.Id;
        appStructureListDeleteNotes.add(ap4);        
        
        GE_PRM_App_Structure__c ap5 = new GE_PRM_App_Structure__c ();
        ap5.GE_PRM_Type__c = 'Territory';
        ap5.GE_PRM_Countries__c = 'United States';
        ap5.GE_PRM_Recommendation__c = recomm.Id;
        appStructureListDeleteNotes.add(ap5);   
        test.startTest();
        insert appStructureListDeleteNotes; 
        test.stopTest();
        
    }    
}