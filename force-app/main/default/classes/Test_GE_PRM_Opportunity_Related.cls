/*
Type Name [Class/Trigger/Page Name] : Test Class
Used Where ?                        : 
Purpose/Overview                    : To incrase the code coverage 
Functional Area                     : PRM
Created Date                        : 5/21/2014           
Change History -
Date Modified   : Developer Name    : Method/Section Modified/Added  : Purpose/Overview of Change
*/

/*
1. GE_PRM_Opportunity_Sharing (Trigger)     - 95%
2. GE_PRM_Partner_Oppty_Sharing (Trigger)   - 100%
3. GE_PRM_Partner_Quote_Sharing (Trigger)   - 100%
4. GE_PRM_Opty_NewButton_Override (Class)   - 100%
5. GE_PRM_Opportunity_Sharing (Class)       - 96%
*/
@isTest
public class Test_GE_PRM_Opportunity_Related
{ 
    
/*    static testMethod void Test_PRM_Opportunity_Sharing_DR() {
            String AccRecordtype = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
             
            Account oGAct = new Account();
            oGAct.Name='TestAccount1';
            oGAct.GE_HQ_DUNS_Number__c='GEGUL9999';
            oGAct.Account_Tier_GEOG__c = 'Country';
            oGAct.recordtypeid = AccRecordtype;
            insert oGAct;
            
            Account acc= new Account();
         
            User u=[select id,firstname,lastname,email from User where id=:userinfo.getUserId()];   
            
            acc.Name='TestClassAccount';  
            
            Schema.DescribeSObjectResult accObj1 = Schema.SObjectType.Account; 
            Map<String,Schema.RecordTypeInfo> accByName1 = accObj1.getRecordTypeInfosByName();
            Schema.RecordTypeInfo rtByName_acc1 =  accByName1.get('Relationship Account');
            Id ac1=rtByName_acc1.getRecordTypeId();
            acc.RecordTypeId=ac1;
            acc.GE_OG_AccFin_Status__c='In Progress';
            acc.account_status__c ='CC Approved';
            acc.ShippingCountry ='ARGENTINA';
            acc.Oil_Gas_Parent_Account__c = oGAct.id;
            acc.ParentId = oGAct.id;
            acc.GE_PW_Phone_New_Request__c='(111)111-1111';
            //acc.Account_Tier_GEOG__c ='LE';
            
            insert acc ;
            
            Account acc1= new Account();
            acc1.Name='TestClassAccount1';  
            acc1.RecordTypeId=ac1;
            acc1.GE_OG_AccFin_Status__c='In Progress';
            acc1.account_status__c ='CC Approved';
            acc1.ShippingCountry ='ARGENTINA';
            acc1.Oil_Gas_Parent_Account__c = oGAct.id;
            acc1.ParentId = oGAct.id;
            acc1.GE_PW_Phone_New_Request__c='(111)111-1111';
            acc1.Account_Tier_GEOG__c ='LE';
            insert acc1;
            
        //Account acc = [select Id, Name from Account where name = 'TestClassAccount'];
        System.assertEquals(acc.Name,'TestClassAccount');
        
        GE_Profile__c  myChannelMgr = new GE_Profile__c();
            myChannelMgr.name= 'GE_OG_PII Sales Manager';
            myChannelMgr.Profile_Name__c = 'GE_OG_PII Sales Manager';
            myChannelMgr.Profile_SFDC_ID__c = '00eA0000000JkIMIA0';
            insert myChannelMgr;
            
            Id chnlMagrId =myChannelMgr.Profile_SFDC_ID__c;
            
            /*GE_Profile__c  myDRPartnerUser = new GE_Profile__c();
            myDRPartnerUser.name= 'Channel Partner Sales Rep user';
            myDRPartnerUser.Profile_Name__c = 'Channel Partner Sales Rep user';
            myDRPartnerUser.Profile_SFDC_ID__c = '00eA0000000KUmtIAG';
            insert myDRPartnerUser;*/
            /*
            GE_Profile__c  myDRPartnerUser = new GE_Profile__c();
            myDRPartnerUser.name= 'GE Channel Partner Community Member';
            myDRPartnerUser.Profile_Name__c = 'GE Channel Partner Community Member';
            myDRPartnerUser.Profile_SFDC_ID__c = '00eA0000000bU9K';
            insert myDRPartnerUser;
            
            Id DRPartId =  myDRPartnerUser.Profile_SFDC_ID__c;
            
            GE_Profile__c  mySRPartnerUser= new GE_Profile__c();
            mySRPartnerUser.name= 'GE_OG_SS Sales';
            mySRPartnerUser.Profile_Name__c = 'GE_OG_SS Sales';
            mySRPartnerUser.Profile_SFDC_ID__c = '00eA0000000b3DE';
            insert mySRPartnerUser;
            
            Id SRPartId =  mySRPartnerUser.Profile_SFDC_ID__c;    
        
        //Query the Profiles using Custom Setting - GE_Profile.
        //GE_Profile__c myChannelMgr = GE_Profile__c.getValues('GE_OG_PII Sales Manager');
       // Id chnlMagrId =  myChannelMgr.Profile_SFDC_ID__c;
       // GE_Profile__c myDRPartnerUser = GE_Profile__c.getValues('Channel Partner Leader user - DR');
       // Id DRPartId =  myDRPartnerUser.Profile_SFDC_ID__c;
       // GE_Profile__c mySRPartnerUser = GE_Profile__c.getValues('Channel Partner Leader user - SR');
       // Id SRPartId =  mySRPartnerUser.Profile_SFDC_ID__c;        
        
        //Insert contact record and associate this with the above account record
        Contact DRCont = new Contact(firstname = 'test', lastname = 'partner', accountid = acc.Id, GE_ES_I_Agree_picklist__c='Yes', phone = '+7098767890',GE_PRM_Primary_Contact__c = true);
        insert DRCont; 
        System.assertEquals(DRCont.firstname,'test');
         //Opportunity OpptyObj;
         User DRpartUser;
         Date dt;
          User chnlManr ;
          BigMachines__Quote__c BMQuote;
          AccountTeamMember atm;
         User thisUser = [ select Id from User where Id = :UserInfo.getUserId() ];
        System.runAs(thisUser )
        {
        //Inserting DR partner user     
         DRpartUser = new User(firstname = 'DRpartner', BMUserType__c='Partner User',GE_HQ_Tier_3_P_L__c='Flow & Process Technologies (Dresser)',lastname = 'user', email = 'partneruser@ge.com', alias = 'pUsr', profileId = DRPartId,contactid = DRCont.id,
                                   Username = 'DRpartuser@ge.com', title = 'Partner User', CommunityNickname = 'DR-Part', TimeZoneSidKey = 'America/New_York', LocaleSidKey = 'en_US',  EmailEncodingKey= 'ISO-8859-1', LanguageLocaleKey= 'en_US');
        insert DRpartUser;
        
        System.assertEquals(DRpartUser.firstname,'DRpartner');
        //
        //List<PermissionSet> prset=new List
        /*id abc = [SELECT id FROM PermissionSet where Name = 'GE_PRM_KYC_Access' limit 1].id;
        PermissionSetAssignment prmnew = new PermissionSetAssignment();
        prmnew.PermissionSetId = abc;
        prmnew.AssigneeId = DRpartUser.id;
        insert prmnew;        */
        /*
        id abc = [SELECT id FROM PermissionSet where Name = 'Track_Your_Order' limit 1].id;
        PermissionSetAssignment prmnew = new PermissionSetAssignment();
        prmnew.PermissionSetId = abc;
        prmnew.AssigneeId = DRpartUser.id;
        insert prmnew;  
        //        
        //Insert Channel Manager
         chnlManr = new User(firstname = 'channel', lastname = 'manager', email = 'chnmanager@ge.com', alias = 'chnUsr', profileId = chnlMagrId, Title = 'Channel Manager', Username = 'channelmagr@ge.com', CommunityNickname = 'chuse', TimeZoneSidKey = 'America/New_York', LocaleSidKey = 'en_US',  EmailEncodingKey= 'ISO-8859-1', LanguageLocaleKey= 'en_US');
        insert chnlManr;
        System.assertEquals(chnlManr.firstname,'channel');
        
         //dt = Date.newinstance(2011,04,30);
        //Opportunity OpptyObj;
        

        // Account Team Member
         atm = new AccountTeamMember(accountid = acc.Id, teammemberrole = 'Channel Manager', userid = chnlManr.Id);
        insert atm;
        System.assertEquals(atm.teammemberrole,'Channel Manager');
        }
        test.startTest();
       // system.runAs(DRPartUser) {
            //OpptyObj = new Opportunity(name='Partneropty', AccountId=acc.id, ownerid = DRPartUser.Id, CloseDate=dt, StageName='prospect', GE_ES_NRE_Site__c='yes', GE_OG_Install_Country__c = 'ALGERIA', GE_PRM_Channel_Partners_Customer__c = 'Test', GE_PRM_Channel_Partner_s_Customer_Info__c = 'Test',recordtypeid='012A00000003bUj');
            //OpptyObj = new Opportunity(name='Partneropty', AccountId=acc.id, ownerid = DRPartUser.Id, CloseDate=dt, StageName='prospect', GE_ES_NRE_Site__c='yes', GE_OG_Install_Country__c = 'ALGERIA', GE_PRM_Channel_Partners_Customer__c = 'Test', GE_PRM_Channel_Partner_s_Customer_Info__c = 'Test');
            //insert OpptyObj;

            Project_ge_og__c prj = new Project_ge_og__c();
            prj.Name = 'TestProject1';
            prj.project_account_ge_og__c = oGAct.id;
            prj.GE_OG_SS_First_Oil_Date__c=Date.today();
            insert prj;
            
             upsert new GE_Configuration_Setting__c(Name = 'OG Counter',GE_OG_SS_WSIDCntr__c=0,GE_OG_PII_OIDCnt__c=0,GE_OGGS_Oppty_ID__c=0,GE_OG_Oppty_Id_Counter__c=0,GE_OG_DTS_OpptyID__c=0) Name; 
            upsert new GE_Profile__c(Name='GE_ES System Integration',Profile_SFDC_ID__c='00eA0000000EHeBIAW',Profile_Name__c='GE_ES System Integration') Name;
            
            String OppRecordtype = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('O&G').getRecordTypeId();
            Opportunity OpptyObj = new Opportunity();
             
            OpptyObj.RecordTypeId =OppRecordtype ;
            OpptyObj.Name= 'Partneropty';
            OpptyObj.GE_ES_Project__c = prj.Id;
            OpptyObj.AccountId = acc.Id;
            OpptyObj.Type = 'Primary';
            OpptyObj.StageName = 'Prospecting';
            OpptyObj.CurrencyIsoCode = 'USD';
            OpptyObj.bid_due_date_ge_og__c = Date.today();
            OpptyObj.CloseDate= Date.today();
            OpptyObj.amount_ge_og__c= 200;
            OpptyObj.GE_OG_Stream__c = 'Core Services - Aberdeen';
            OpptyObj.GE_OG_TM_Quote_Type__c = 'Budget';
            OpptyObj.GE_OG_TM_Industrial_Sector__c = 'LNG';
            OpptyObj.GE_OG_TM_Generate_ID__c = True;
            OpptyObj.GE_OG_TM_Subsector__c = 'CCR';
            OpptyObj.GE_OG_TM_Application_Center__c = 'Bari';
            OpptyObj.rfq_received_date_ge_og__c = Date.today();
            OpptyObj.GE_OG_TM_Proposal_Assesment__c = 'Tech & Comm With Same Due Date';
            OpptyObj.end_user_ge_og__c = acc1.Id;
            OpptyObj.tier_3_ge_og__c = 'Bently Nevada';
            OpptyObj.tier_2_ge_og__c = 'TMS';
            OpptyObj.ownerid = DRPartUser.Id;
            OpptyObj.GE_ES_NRE_Site__c='yes';
            OpptyObj.install_country_ge_og__c= 'ALGERIA';
            OpptyObj.channel_partners_customer_ge_og__c= 'Test';
            OpptyObj.channel_partner_s_customer_info_ge_og__c= 'Test';
            
            
            insert OpptyObj;
            
            
            
            System.assertEquals(OpptyObj.Name,'Partneropty');
            OpptyObj.OwnerId = chnlManr.Id;         
            update OpptyObj; 
            
            BMQuote= new BigMachines__Quote__c(BigMachines__Opportunity__c=OpptyObj.Id, Name ='Test');
            
            insert BMQuote;
            System.assertEquals(BMQuote.Name,'Test');
            BMQuote.OwnerId = chnlManr.Id;         
            update BMQuote; 
            
            // GE_PRM_Opty_NewButton_Override (Partner  User - Coverage)
          /*  PageReference pageRefPartner = Page.GE_PRM_Opty_NewButton_Override;
            pageRefPartner.getParameters().put('Id', OpptyObj.id);
            Test.setCurrentPage(pageRefPartner);
            ApexPages.StandardController scPartner = new ApexPages.StandardController(OpptyObj);     
            GE_PRM_Opty_NewButton_Override PartnerOverride = new GE_PRM_Opty_NewButton_Override(scPartner);
            PartnerOverride.partnerRedirect();*/
            
            // GE_PRM_Opportunity_Sharing - (Partner Coverage)
            /*
            PageReference pageRefPartnerOpptySharing = Page.GE_PRM_Opportunity_Sharing;
            pageRefPartnerOpptySharing.getParameters().put('Id', OpptyObj.id);
            Test.setCurrentPage(pageRefPartnerOpptySharing);
            OpptyObj.OwnerId = chnlManr.Id;
            ApexPages.StandardController scPartnerOppShare = new ApexPages.StandardController(OpptyObj);     
            GE_PRM_Opportunity_Sharing PartnerOppSharing = new GE_PRM_Opportunity_Sharing(scPartnerOppShare);
            PartnerOppSharing.getChannelManagers();
            PartnerOppSharing.getPartnerUsers();
            PartnerOppSharing.shareOpportunity();            
        //}
        
        
        
        // GE_PRM_Opty_NewButton_Override (Normal  User - Coverage)
       /* PageReference pageRef = Page.GE_PRM_Opty_NewButton_Override;
        pageRef.getParameters().put('Id', OpptyObj.id);
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(OpptyObj);     
        GE_PRM_Opty_NewButton_Override ovr = new GE_PRM_Opty_NewButton_Override(sc);
        ovr.partnerRedirect(); */
        
        // GE_PRM_Opportunity_Sharing - (Normal User Coverage)
        /*
        PageReference pageRefOpptySharing = Page.GE_PRM_Opportunity_Sharing;
        pageRefOpptySharing.getParameters().put('Id', OpptyObj.id);
        Test.setCurrentPage(pageRefOpptySharing);
        OpptyObj.OwnerId = DRpartUser.Id;        
        ApexPages.StandardController scOppShare = new ApexPages.StandardController(OpptyObj);     
        GE_PRM_Opportunity_Sharing OppSharing = new GE_PRM_Opportunity_Sharing(scOppShare);
        OppSharing.getChannelManagers();
        OppSharing.getPartnerUsers();
        OppSharing.shareOpportunity();
        
        test.stopTest();    
    }  
    */
}