@isTest
public class TotRegFieldForEvents_Test
{
    public static testMethod void testUpdateTotalReg()
        {   
        
             Opportunity_Trigger_Controller_ge_og__c oppScrumCmpgnTrig= CommonTestDataFactory_GE_OG.createCampaignTriggerCstmSetting(true, 'Campaign', 'O_Campaign_Trig_GE_OG');
            Opportunity_Trigger_Controller_ge_og__c  oppScrumCMRTrig = CommonTestDataFactory_GE_OG.createCampaignMemTriggerCstmSetting(true, 'CampaignMember', 'O_CampaignMember_Trig_GE_OG');
            
            
            String strRecordTypeParentId = [Select Id From RecordType Where SobjectType = 'Account' and Name = 'Relationship Account' LIMIT 1].Id;
            Account hqAccount = new Account(name='regionalParent',type='Direct Customer', Classification__c = 'Strategic',Account_Tier_GEOG__c='Global',RecordTypeId=strRecordTypeParentId,Compliance_Ready__c=true);
            insert hqAccount;
            
            Account regionalAccount = new Account(name='regionalParent', type='Direct Customer', Classification__c = 'Strategic',Account_Tier_GEOG__c='Regional',RecordTypeId=strRecordTypeParentId,parentId=hqAccount.id,Compliance_Ready__c=true);
            insert regionalAccount;
            regionalAccount.Member_of_GE_OG__c = hqAccount.Id;
            update regionalAccount;
            
            Contact cont1 = new Contact();
             cont1.GE_OG_Contact_Audience__c='Customer Care';
             cont1.LastName = 'Test';
             cont1.FirstName = 'Test';
             cont1.Phone = '12366677';
             cont1.Email = 't3st@te1st1298.com';
             cont1.GE_PRM_Primary_Contact__c = True;
             cont1.AccountId = hqAccount.Id;
             insert cont1;
             
             Contact cont2 = new Contact();
             cont2.GE_OG_Contact_Audience__c='Customer Care';
             cont2.LastName = 'Test';
             cont2.FirstName = 'Test';
             cont2.Phone = '99887766';
             cont2.Email = 'ev4nt@test1298.com';
             cont2.GE_PRM_Primary_Contact__c = True;
             cont2.AccountId = hqAccount.Id;
             insert cont2;
             
            
            Campaign theme = CommonTestDataFactory_GE_OG.createThemeCampaign('Event Theme');
            
            Campaign program = new Campaign();
            program.Name='Event Program';
            program.RecordTypeId=Util_GE_OG.getRecordTypeDetails('Campaign','Program').getRecordTypeId();
            program.ParentId= theme.Id;
            program.Description='Test program for Description';
            program.tier2_ge_og__c='Digital Solutions';
            program.tier3_ge_og__c='Bentley Nevada';
            program.OwnerId=UserInfo.getUserId();
            program.StartDate = System.today()-5;
            program.EndDate=System.today()+40;
            //program.Type='Event';
            
            insert program;
            
            Campaign cmpgn = new Campaign();
            cmpgn.Name='Event 1';
            cmpgn.RecordTypeId=Util_GE_OG.getRecordTypeDetails('Campaign','Campaign').getRecordTypeId();
            cmpgn.ParentId=program.Id;
            cmpgn.Description='Test Campaign for Description';
            cmpgn.tier2_ge_og__c='Digital Solutions';
            cmpgn.Owner_Function_ge_og__c='Marketing';
            cmpgn.Type = 'Event';
            //cmpgn.Type='Outbound Telesales';
            cmpgn.Routing_info_qualified_lead_ge_og__c=' Routing Info';
            cmpgn.Target_List_Details_ge_og__c='Existing Database';
            cmpgn.Estimated_Number_of_Prospects_ge_og__c=2;
            cmpgn.Inside_sales_support_needed_ge_og__c='No';
            cmpgn.StartDate = System.today()-1;
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
            cmpgn.Cvent_Link__c = 'www.salesforce.com';
            cmpgn.Event_Start_Date_ge_og__c  = System.today()-1;
            cmpgn.Event_End_Date_ge_og__c =System.today()+30;
            cmpgn.Event_Location_ge_og__c = 'Bangalore' ;
            cmpgn.Event_Type_ge_og__c ='Customer Center';
            cmpgn.Lead_Capture_Method_ge_og__c = 'Custom Event Mgmt App';
            
            insert cmpgn;
            cmpgn.Status = 'In Progress';
            update cmpgn;
            
            Account_Event_Relation__c ar = new Account_Event_Relation__c();
            ar.Events_and_Sessions_on_Account_HQ__c = String.valueOf(hqAccount.Id)+String.valueOf(cmpgn.Id);
            ar.Total_Registrations__c = 1;
            insert ar;
            
            CampaignMember cmr = new CampaignMember();
            cmr.CampaignID =cmpgn.Id;
            cmr.ContactId = cont2.Id;
            cmr.Status='Lead Prospecting';
            cmr.Invitation_Status__c = 'Sent';
            insert cmr;
            
            
            updateTotalRegistrationFieldForEvents obj = new updateTotalRegistrationFieldForEvents();
            Database.executeBatch(obj);
            
            
             
            
}}