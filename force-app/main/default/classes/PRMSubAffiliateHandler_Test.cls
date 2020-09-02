@isTest
public class PRMSubAffiliateHandler_Test {
    static testMethod void subAffiliateTest(){
        List<PRM_Channel_Appointment_GE_OG__c> chApp = new List<PRM_Channel_Appointment_GE_OG__c>();
        List<Account> lstacc = new List<Account>();
        List<PRM_Sub_Affiliate__c> subAff = new List<PRM_Sub_Affiliate__c>();
        Map<Id,PRM_Sub_Affiliate__c> oldMap = new Map<Id,PRM_Sub_Affiliate__c>();
        
        Profile  chnlMgrId =  [select id from profile where name ='System Administrator' limit 1];
        User chnlMgnr = new User(firstname = 'channel', lastname = 'manager', email = 'chnmanager@ge.com', alias = 'chnUsr', profileId = chnlMgrId.id, Title = 'Channel Manager', Username = 'channelmagr@ge.com', CommunityNickname = 'chuse', TimeZoneSidKey = 'America/New_York', LocaleSidKey = 'en_US',  EmailEncodingKey= 'ISO-8859-1', LanguageLocaleKey= 'en_US');
        insert chnlMgnr;
        
        system.runAs(chnlMgnr){
            Schema.DescribeSObjectResult accObj = Schema.SObjectType.Account; 
            Map<String,Schema.RecordTypeInfo> accByName = accObj.getRecordTypeInfosByName();
            Schema.RecordTypeInfo rtByName_acc1 =  accByName.get('CMF Approved');
            Id acc12=rtByName_acc1.getRecordTypeId();
            
            Account Acc= new Account();
            Acc.Name='Test Acc';  
            Acc.GE_HQ_KYC_Complete__c=False;
            Acc.GE_PRM_KYC_Completed__c=False;
            Acc.GE_HQ_DUNS_Number__c='555123459';  
            Acc.GE_OG_Buss_Tier1__c='Oil & Gas (O&G)';
            Acc.GE_OG_Buss_Tier2__c='Drilling & Surface (D&S)';
            Acc.GE_OG_Buss_Tier3__c='D&S - DT';
            Acc.GE_PW_Country_Quote_To_Sold_To_HQ__c='UNITED STATES';
            Acc.GE_PW_City_Quote_To_Sold_To_HQ__c='city';
            Acc.GE_PW_State_Province_Quote_To_Sold_To_HQ__c='state';
            Acc.GE_PW_Zip_Postal_Code_Quote_To_Sold_ToHQ__c='zip';
            Acc.GE_PW_Country_Bill_To__c='UNITED STATES';
            Acc.GE_PW_City_Bill_To__c='United States';
            Acc.GE_PW_State_Province_Bill_To__c='state';
            Acc.GE_PW_Zip_Postal_Code_Bill_To__c='560068';
            Acc.GE_PW_Country_Ship_To__c='UNITED STATES';
            Acc.GE_PW_City_Ship_To__c='city';
            Acc.GE_PW_State_Province_Ship_To__c='state';
            Acc.GE_PW_Zip_Postal_Code_Ship_To__c='zip';
            Acc.GE_HQ_New_Account_Country__c = 'UNITED STATES';
            Acc.GE_HQ_Nts_Comments__c='Test'; 
            Acc.GE_OG_MDM_Shipping_Country_ISO_Code__c = 'US';     
            Acc.GE_OG_MDM_Billing_Country_ISO_Code__c ='IN';
            Acc.RecordTypeId=acc12;
            Acc.GE_OG_AccFin_Status__c='In Progress';
            Acc.Account_Status__c ='CC Approved';
            Acc.ShippingCountry ='UNITED KINGDOM';
            Acc.GE_PW_Phone_New_Request__c='(111)111-1111';
            Acc.GE_HQ_Site_Use_Code__c ='BILL_TO';
            Acc.GE_HQ_New_Account_Country__c = 'UNITED KINGDOM'; 
            Acc.GE_HQ_Country_Code__c = 'GB'; 
            insert Acc; 
            
            PRM_Channel_Appointment_GE_OG__c prm_chApp = new PRM_Channel_Appointment_GE_OG__c();
            prm_chApp.PRM_Account_Name__c = Acc.id;
            prm_chApp.PRM_Primary_Tier_2__c = 'Digital Solutions';
            prm_chApp.PRM_Commercial_Manager__c = chnlMgnr.id;
            prm_chApp.PRM_Primary_Sales_Channel_Manager__c = chnlMgnr.id;
            chApp.add(prm_chApp);
            insert chApp;
            
            PRM_Sub_Affiliate__c prm_subAff = new PRM_Sub_Affiliate__c();
            prm_subAff.PRM_Affiliate_Dependent_Type__c = 'Branch';
            prm_subAff.PRM_Legal_Name__c = 'Test';
            prm_subAff.PRM_Authorized_Commercial_Lines__c = 'Auth Test';
            prm_subAff.PRM_Prinicipal_Contact__c = 'Test Contact';
            prm_subAff.PRM_Active__c = true;
            prm_subAff.PRM_Channel_Appointment__c = prm_chApp.id;
            prm_subAff.CurrencyIsoCode = 'USD';
            subAff.add(prm_subAff);
            
            PRM_Sub_Affiliate__c prm_subAff1 = new PRM_Sub_Affiliate__c();
            prm_subAff1.PRM_Affiliate_Dependent_Type__c = 'Sub-Dealer';
            prm_subAff1.PRM_Legal_Name__c = 'Test';
            prm_subAff1.PRM_Authorized_Commercial_Lines__c = 'Auth Test';
            prm_subAff1.PRM_Prinicipal_Contact__c = 'Test Contact';
            prm_subAff1.PRM_Active__c = true;
            prm_subAff1.PRM_Channel_Appointment__c = prm_chApp.id;
            prm_subAff1.CurrencyIsoCode = 'USD';
            subAff.add(prm_subAff1);
            insert subAff;
            
            prm_subAff.PRM_Affiliate_Dependent_Type__c = 'Subsidiary';
            update prm_subAff;
            oldMap.put(prm_subAff.id,prm_subAff);
            
            prm_subAff.PRM_Affiliate_Dependent_Type__c = 'Sub-Dealer';
            update prm_subAff;
            oldMap.put(prm_subAff.id,prm_subAff);
            
            prm_subAff1.PRM_Affiliate_Dependent_Type__c = 'Sub-Agent';
            update prm_subAff1;
            oldMap.put(prm_subAff1.id,prm_subAff1);
            
            prm_subAff1.PRM_Affiliate_Dependent_Type__c = 'Branch';
            update prm_subAff1;
            oldMap.put(prm_subAff1.id,prm_subAff1);
        }
        
        Test.startTest();
        PRMSubAffiliateHandler obj = new PRMSubAffiliateHandler();
        //obj.subAffiliateOnInsert(subAff);
        //obj.subAffiliateBranchUpdate(subAff,oldMap);
        //obj.subAffiliateDealerUpdate(subAff,oldMap);
        Test.stopTest();
    }
    
}