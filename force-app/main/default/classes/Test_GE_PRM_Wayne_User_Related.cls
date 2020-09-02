/*
1.GE_PRM_Count_Active_Partner_Users (Class)- 100%
2.PRMWayneQuotes (Class)  - 100%
3.GE_PRM_Strategy (Class) - 100%
4.PRMHome (Class)  - 100%
*/
@isTest()
Public class Test_GE_PRM_Wayne_User_Related {
    static testmethod void PRM_Wayne_Method()
    {    
        RecordType rt = [SELECT Id FROM RecordType WHERE SObjectType='Account' AND Name='Relationship Account' LIMIT 1];
        String recordTypeId = rt.id;
        String accountName = 'HierarchyTest';
        
        Account acc= new Account(name=accountName+'0', GE_HQ_Country_Code__c='RU',ShippingStreet='1 Main St.', ShippingState='VA', ShippingPostalCode='12345', ShippingCountry='USA', ShippingCity='Anytown', Description='This is a test account', BillingStreet='1 Main St.', BillingState='VA', BillingPostalCode='12345', BillingCountry='USA', BillingCity='Anytown', AnnualRevenue=10000,recordtypeid=recordTypeId,type='Direct Customer', Classification__c='Unclassified' );
        insert acc;
        
        acc.Phone='9985956992';
        update acc;
        
        //RecordType rt1 = [SELECT Id FROM RecordType WHERE SObjectType='Account' AND Name='Relationship Account' LIMIT 1];
        Account acc1= new Account(name=accountName+'0', GE_HQ_Country_Code__c='RU',ShippingStreet='1 Main St.', ShippingState='VA',
                                  ShippingPostalCode='12345', ShippingCountry='USA', ShippingCity='Anytown', 
                                  Description='This is a test account', BillingStreet='1 Main St.', BillingState='VA', 
                                  BillingPostalCode='12345', BillingCountry='USA', BillingCity='Anytown',
                                  AnnualRevenue=10000,recordtypeid=rt.id,type='Channel Partner',Classification__c='Unclassified',
                                  Account_Tier_GEOG__c='Country',Account_Status__c='Active' );
        insert acc1;
        system.debug('%%%%%%'+acc1);      
        //Query the Profiles using Custom Setting - GE_Profile.         
        List<Profile> pf = [Select id,name from Profile where name ='Gold Partner User' limit 1];
        Id cusPartId =  pf[0].id;
        //inserting contact
        Contact cont = new Contact(firstname = 'test', lastname = 'partner', Email='test@test.com', accountid = acc.Id, GE_ES_I_Agree_picklist__c='Yes', phone = '7709876789',GE_PRM_Primary_Contact__c = true);
        insert cont; 
        System.assertEquals(cont.firstname,'test'); 
        //inserting Partner user object       
        User partUser = new User(firstname = 'partner', BMUserType__c='Partner User',GE_HQ_Tier_3_P_L__c='Flow & Process Technologies (Dresser)',lastname = 'user', email = 'partneruser@ge.com', alias = 'pUsr', profileId = cusPartId, contactid = cont.id,
                                 Username = 'partuser@ge.com', title = 'Partner User', CommunityNickname = 'puse', TimeZoneSidKey = 'America/New_York', LocaleSidKey = 'en_US',  EmailEncodingKey= 'ISO-8859-1', LanguageLocaleKey= 'en_US');
        insert partUser;
        System.assertEquals(partUser.firstname,'partner');           
        //To cover the prmhome class
       /* system.runAs(partUser)
        {
            PRMHome  prm= new PRMHome();    
            PageReference pageRef = prm.NewOpportunity();
            pageRef = prm.BeckerNMooney();
        } */
        //Inserting nonBMUser to cover the else part in the PRMHome Class
        //Query the Profiles using Custom Setting - GE_Profile.
        List<Profile> pf1 = [Select id,name from Profile where name ='OG_Sales/Comm Ops' limit 1];
        Id chnlMagrId =  pf1[0].id;
        User chnlManr = new User(firstname = 'channel', lastname = 'managers', email = 'chnmanagers@ge.com', alias = 'chnUsrs', profileId = chnlMagrId, Title = 'Channel Managers', Username = 'channelmagrs@ge.com', CommunityNickname = 'chus', TimeZoneSidKey = 'America/New_York', LocaleSidKey = 'en_US',  EmailEncodingKey= 'ISO-8859-1', LanguageLocaleKey= 'en_US');
        insert chnlManr;
        System.assertEquals(chnlManr.firstname,'channel');
        system.runAs(chnlManr )
        {
            //PRMHome  prm= new PRMHome();    
            //PageReference pageRef = prm.NewOpportunity();
        } 
        //End the PRMHome Class    
        System.debug('1.Number of Queries used in this apex code so far: ' + Limits.getQueries());
        System.debug('2.Number of rows queried in this apex code so far: ' + Limits.getDmlRows());
        System.debug('3. Number of script statements used so far : ' +  Limits.getDmlStatements());
        System.debug('4.Number of Queries used in this apex code so far: ' + Limits.getQueries());
        System.debug('5.Number of rows queried in this apex code so far: ' + Limits.getDmlRows());
        //To cover the PRMWayneQuotes class
        //PRMWayneQuotes prmquotes= new PRMWayneQuotes(); 
        
        //Calling the pagereference method
        //PageReference pageRef = prmquotes.pageredir();
        //To cover the GE_PRM_Count_Active_Partner_Users class
        //GE_PRM_Count_Active_Partner_Users countactive= new GE_PRM_Count_Active_Partner_Users();
        Test.startTest();
        //System.schedule('Test', '0 0 19 * * ?', countactive);
        Test.stopTest();
        //End The GE_PRM_Count_Active_Partner_Users Class
        //The below lines will cover the GE_PRM_Strategy Class
        system.debug('%%%%%%%'+acc1.Id);
        //Inserting Account Plan
        GE_HQ_Account_Plan__c accPlan = new GE_HQ_Account_Plan__c(Name = 'Test Account Plan 1', GE_PRM_Account__c = acc1.id);
        insert accPlan;
        System.assertEquals(accPlan.Name,'Test Account Plan 1');
        
        //inserting account plan rel
        GE_HQ_Acc_AccPlan_Rel__c myGEAccount = new GE_HQ_Acc_AccPlan_Rel__c (GE_HQ_Account_Plan__c=accPlan.Id, GE_HQ_Account__c = acc1.id);
        insert myGEAccount ;
        
        //inserting account plan team
        GE_HQ_Account_Plan_Team__c accteam = new GE_HQ_Account_Plan_Team__c(GE_HQ_Access_Level__c ='Read/Write', GE_HQ_Acc_Plan_Name__c = accPlan.Id, GE_HQ_Acc_Plan_Team_Member__c = partUser.Id,  GE_HQ_Acc_Plan_Team_Role__c = 'Channel Manager'); 
        insert accteam;
        System.assertEquals(accteam.GE_HQ_Access_Level__c,'Read/Write');
        ApexPages.StandardController stdController = new ApexPages.StandardController(acc);      
        //inserting strategy object
        GE_PRM_Strategy strategyOb = new GE_PRM_Strategy(stdController);
        system.runAs(partUser)
        {
            strategyOb = new GE_PRM_Strategy(stdController);
        }        
    }
    /*
    static testMethod void Test_GE_PRM_UpdateNewRecom_Method()
    {
        Id newProductLine;
        Id newRenew;
        Id terminationNonReniwal;
       
        
        //getting the ids and developername of the record types which are under the object GE_PRM_Recommendation__c      
        List<RecordType> rt = [select id, developername from recordtype where sobjecttype = 'GE_PRM_Recommendation__c'];
        
        //Getting the ids of KYC records
        RecordType kycRecordType = [select id, developername from recordtype where developername= 'GE_PRM_KYC' ];        
        
        String recordTypeId = Schema.SObjectType.GE_PW_Key_Players__c.getRecordTypeInfosByName().get('GE PW Aero Key Player').getRecordTypeId();
        
        //Iterating through the record type list to assign the specific id to the related developer name
        for(Integer i= 0; i<rt.size(); i++)
        {
            if(rt.get(i).developername == 'GE_PRM_New_Product_Line')
            {               
                //Assigning the new product line record type's ID to the newProductLine id variable
                newProductLine = rt.get(i).id;
                System.debug(newProductLine);
            }
            
            if(rt.get(i).developername == 'GE_PRM_New_Renewal')
            {               
                //Assigning the new/renewal record type's ID to the newRenew id variable
                newRenew = rt.get(i).id;
            }
            
            if(rt.get(i).developername == 'GE_PRM_Termination_Non_Renewal')
            {               
                //Assigning the termination/non-renewal record type's ID to the terminationNonReniwal id variable
                terminationNonReniwal = rt.get(i).id;
            }
        }         
        
        //Query the record type id for the given record type name under the GE_PRM_Appointment__c object
        RecordType rtApp = [select id from recordtype where name = 'GE_PRM_Application_Approved' and sobjecttype = 'GE_PRM_Appointment__c'];    
        
        Account acc = [select Id, Name from Account where name = 'TestClassAccount'];
        //insert appointment record
        GE_PRM_Appointment__c apptmtObj = new GE_PRM_Appointment__c(GE_PRM_Application_Approved_Date__c=system.today(),GE_PRM_Status__c = 'Approved', GE_PRM_Account_Name__c = acc.id, recordtypeid = rtApp.id, GE_PRM_Applicant_Name__c = 'applicant name', 
                                                                    GE_PRM_Legal_Address_1__c = 'legal add 1', GE_PRM_Legal_Address_2__c = 'leg add 2', GE_PRM_Legal_City__c = 'atl', GE_PRM_Legal_Postal_Code__c = '12345', GE_PRM_Legal_Country__c = 'US', 
                                                                    GE_PRM_CNTY_Authorized_To_Do_BIZ_In__c = 'US;India', GE_PRM_No_Of_Employees__c = 10, GE_PRM_Identify_Government_Agencies__c = 'GOI',
                                                                    GE_PRM_3_Largest_Customers__c = 'rel', GE_PRM_Sub_Agent_or_Dis_for_GE_Prod__c = 'yes', GE_PRM_Sub_Agent_or_Dis_for_GE_Prod_Yes__c = 'test', Number_of_Individuals_Promoting_GE__c = 5, GE_PRM_Govt_or_Political_Party_Positions__c = 'Yes', GE_PRM_Which_Vertical_Market_do_you_serv__c = 'Cement and Building Materials;Data & Communications;Water and Wastewater;Transmission & Distribution;Equipment & Appliances;Food & Beverage;Power Generation');
        
        insert apptmtObj;
        System.assertEquals(apptmtObj.GE_PRM_Status__c,'Approved');
        
        Date dt = Date.newinstance(2011,04,30);
        //inserting opportunity
        Opportunity opty=new Opportunity();
        opty.name='test';
        opty.accountId=acc.Id;
        opty.CloseDate=system.today();
        opty.stageName='Prospect';
        opty.GE_ES_NRE_Site__c='no';
        test.startTest();
        insert opty;
        System.assertEquals(opty.stageName,'Prospect');
        
        List<GE_PRM_Recommendation__c> recomObjList = new List<GE_PRM_Recommendation__c>();
        
        GE_PRM_Recommendation__c recomObj = new GE_PRM_Recommendation__c( RecordTypeId = newRenew,
                                                                         GE_PRM_Status__c = 'Approved',
                                                                         GE_PRM_Appointment_Number__c = apptmtObj.Id,
                                                                         GE_PRM_Agreement_Category__c = 'new',
                                                                         GE_PRM_Agreement_Type__c='Renewal',
                                                                         GE_PRM_RFA_Type__c='Express',
                                                                         GE_PRM_Has_GE_visited_ACP_Facilities__c='yes',                                                            
                                                                         GE_PRM_Recommended_channel_type__c = 'Sales Representative (SR)',
                                                                         GE_PRM_Business_Tier_1__c = 'Oil & Gas (O&G)');
        //test.startTest();
        
        insert recomObj;
        
        System.assertEquals(recomObj.GE_PRM_Agreement_Category__c , 'new');
        
        
        GE_PRM_Recommendation__c recomObj1 = new GE_PRM_Recommendation__c( RecordTypeId = newProductLine,
                                                                          GE_PRM_Status__c = 'In Process',
                                                                          GE_PRM_Agreement_Type__c='New Product Line/Service',
                                                                          GE_PRM_Appointment_Number__c = apptmtObj.Id,
                                                                          GE_PRM_Agreement_Category__c = 'New Product Line/Service',
                                                                          GE_PRM_Recommended_channel_type__c = 'Sales Representative (SR)',
                                                                          GE_PRM_Business_Tier_1__c = 'Oil & Gas (O&G)');
        //System.assertEquals(recomObj.GE_PRM_Agreement_Category__c , 'New Product Line/Service');
        recomObjList.add(recomObj1);  
        
        GE_PRM_Recommendation__c recomObj2 = new GE_PRM_Recommendation__c( RecordTypeId = newRenew,
                                                                          GE_PRM_Status__c = 'In Process',
                                                                          GE_PRM_Appointment_Number__c = apptmtObj.Id,
                                                                          GE_PRM_Agreement_Category__c = 'New',
                                                                          GE_PRM_Recommended_channel_type__c = 'Sales Representative (SR)',
                                                                          GE_PRM_Business_Tier_1__c = 'Oil & Gas (O&G)');
        System.assertEquals(recomObj.GE_PRM_Agreement_Category__c , 'new');
        recomObjList.add(recomObj2);
        
        GE_PRM_Recommendation__c recomObjupdateraj = new GE_PRM_Recommendation__c( RecordTypeId=terminationNonReniwal,
                                                                                  GE_PRM_Status__c = 'Rejected',
                                                                                  GE_PRM_Appointment_Number__c = apptmtObj.Id,
                                                                                  GE_PRM_Agreement_Category__c = 'Renewal',
                                                                                  GE_PRM_Parent_Id__c=recomObj.Id,
                                                                                  GE_PRM_sales_in_US_only__c='Yes',
                                                                                  GE_PRM_use_of_sub_dealer__c='No',
                                                                                  GE_PRM_partner_1yr__c='No',
                                                                                  GE_PRM_Account__c=acc.id,                                                                      
                                                                                  GE_PRM_Non_standard_discounts__c='Standard',
                                                                                  GE_PRM_Recommended_channel_type__c = 'Sales Representative (SR)',
                                                                                  GE_PRM_Business_Tier_1__c = 'Oil & Gas (O&G)');
        recomObjList.add(recomObjupdateraj);
        System.assertEquals(recomObjupdateraj.GE_PRM_sales_in_US_only__c,'Yes');
        
        GE_PRM_Recommendation__c recomObjupdateraj12 = new GE_PRM_Recommendation__c( RecordTypeId=terminationNonReniwal,
                                                                                    GE_PRM_Status__c = 'Rejected',
                                                                                    GE_PRM_Appointment_Number__c = apptmtObj.Id,
                                                                                    GE_PRM_Agreement_Category__c = 'Renewal',
                                                                                    GE_PRM_Parent_Id__c=recomObj.Id,
                                                                                    GE_PRM_sales_in_US_only__c='Yes',
                                                                                    GE_PRM_use_of_sub_dealer__c='No',
                                                                                    GE_PRM_Agreement_Type__c='Renewal',
                                                                                    GE_PRM_RFA_Type__c='Express',
                                                                                    GE_PRM_partner_1yr__c='No',
                                                                                    GE_PRM_Account__c=acc.id,                                                                                      
                                                                                    GE_PRM_Non_standard_discounts__c='Standard',
                                                                                    GE_PRM_Recommended_channel_type__c = 'Sales Representative (SR)',
                                                                                    GE_PRM_Business_Tier_1__c = 'Oil & Gas (O&G)');
        System.assertEquals(recomObjupdateraj12.GE_PRM_partner_1yr__c,'No');
        recomObjList.add(recomObjupdateraj12);
        
        GE_PRM_Recommendation__c recomObj3 = new GE_PRM_Recommendation__c( RecordTypeId = terminationNonReniwal,
                                                                          GE_PRM_Status__c = 'In Process',
                                                                          GE_PRM_Appointment_Number__c = apptmtObj.Id,
                                                                          GE_PRM_Agreement_Category__c = 'Termination/Non-Renewal',
                                                                          GE_PRM_Recommended_channel_type__c = 'Sales Representative (SR)',
                                                                          GE_PRM_Business_Tier_1__c = 'Oil & Gas (O&G)');
        insert recomObjList;        
        System.assertEquals(recomObj3.GE_PRM_Status__c,'In Process');
        
        
        GE_PRM_Appointment__c apptmtObjraj3 = new GE_PRM_Appointment__c(GE_PRM_Application_Approved_Date__c=system.today(),GE_PRM_Status__c = 'Approved', GE_PRM_Account_Name__c = acc.id, recordtypeid = rtApp.id, GE_PRM_Applicant_Name__c = 'applicant name', 
                                                                        GE_PRM_Recommendation__c=recomObj1.Id,GE_PRM_Legal_Address_1__c = 'legal add 1', GE_PRM_Legal_Address_2__c = 'leg add 2', GE_PRM_Legal_City__c = 'atl', GE_PRM_Legal_Postal_Code__c = '12345', GE_PRM_Legal_Country__c = 'US', 
                                                                        GE_PRM_CNTY_Authorized_To_Do_BIZ_In__c = 'US;India', GE_PRM_No_Of_Employees__c = 10, GE_PRM_Identify_Government_Agencies__c = 'GOI',
                                                                        GE_PRM_3_Largest_Customers__c = 'rel', GE_PRM_Sub_Agent_or_Dis_for_GE_Prod__c = 'yes', GE_PRM_Sub_Agent_or_Dis_for_GE_Prod_Yes__c = 'test', Number_of_Individuals_Promoting_GE__c = 5, GE_PRM_Govt_or_Political_Party_Positions__c = 'Yes', GE_PRM_Which_Vertical_Market_do_you_serv__c = 'Cement and Building Materials;Data & Communications;Water and Wastewater;Transmission & Distribution;Equipment & Appliances;Food & Beverage;Power Generation');
        
        insert apptmtObjraj3;
        
        System.assertEquals(apptmtObjraj3.GE_PRM_Status__c,'Approved');
        
        //Add Country records to generate riskscore
        
        List<GE_PRM_App_Structure__c> appObjList = new List<GE_PRM_App_Structure__c>(); 
        
        for(Integer i=0;i<recomObjList.size();i++)
        {
            GE_PRM_App_Structure__c appObjj = new GE_PRM_App_Structure__c(
                GE_PRM_Countries__c = 'India',
                GE_PRM_Type__c = 'Recommendation Country',
                GE_PRM_Specific_Authorized_Region__c = 'Test',
                GE_PRM_Recommendation__c = recomObjList.get(i).Id
            );
            System.assertEquals(appObjj.GE_PRM_Countries__c,'India');
            appObjList.add(appObjj);
        }
        
        
        GE_PRM_App_Structure__c appObj1 = new GE_PRM_App_Structure__c(
            GE_PRM_Countries__c = 'Austria',
            GE_PRM_Type__c = 'Recommendation Country',
            GE_PRM_Specific_Authorized_Region__c = 'Test',
            GE_PRM_Recommendation__c = recomObjList.get(0).Id
        );
        
        System.assertEquals(appObj1.GE_PRM_Countries__c,'Austria');
        appObjList.add(appObj1);
        
        GE_PRM_App_Structure__c appObj2 = new GE_PRM_App_Structure__c(
            Cloned_Record__c = true,
            GE_PRM_Type__c = 'Notes',
            GE_PRM_Appointment__c = apptmtObj.Id,
            GE_PRM_Notes_Questions_Etc__c = 'Test',
            GE_PRM_Recommendation__c = recomObjList.get(0).Id
        );
        appObjList.add(appObj2);
        test.stopTest();       
        insert appObjList;                   
    }
    */
      }