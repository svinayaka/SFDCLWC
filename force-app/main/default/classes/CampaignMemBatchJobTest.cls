@isTest 
public class CampaignMemBatchJobTest
{
    Private static User ur{get;set;}
    Private static User owr{get;set;}
    static testMethod void testMethod1() 
    {
        List<Campaign> lstcampaign= new List<Campaign>();
        ur = [Select id,isActive from User Where Profile.name='System Administrator' AND isActive =true limit 1];
        owr = [Select id,isActive from User Where Profile.name='System Administrator' AND isActive =false limit 1];
        Lead lead = new Lead();
        lead.firstName='Test11';
        lead.lastName= 'Lead11';
        //lead.Campaign =cmpgnId;
        lead.Email='test11@getest.com';
        lead.Status='Active123';
        //lead.Custom_Status_ge_og__c = 'Blacklisted';
        lead.OwnerId=UserInfo.getUserId();
        lead.RecordTypeId=Util_GE_OG.getRecordTypeDetails('Lead','Deal Machine Lead').getRecordTypeId();
        lead.Company='Test XTY Ltd';
        lead.sales_region_ge_og__c='India';
        
            insert lead;
        
        
        Campaign theme = new Campaign();
        theme.Name='Test Theme';
        theme.RecordTypeId=Util_GE_OG.getRecordTypeDetails('Campaign','Theme').getRecordTypeId();
        theme.Description='Test Theme for Description';
        theme.OwnerId=UserInfo.getUserId();
        theme.Material_Documentation_link_ge_og__c='www.google.com';
        theme.StartDate = System.today()-10;
        theme.EndDate=System.today()+50;
        insert theme;
        
        Campaign program = new Campaign();
        program.Name='Test Program';
        program.RecordTypeId=Util_GE_OG.getRecordTypeDetails('Campaign','Program').getRecordTypeId();
        program.ParentId=theme.id;
        program.Description='Test program for Description';
        program.tier2_ge_og__c='Digital Solutions';
        program.tier3_ge_og__c='Bentley Nevada';
        program.OwnerId=UserInfo.getUserId();
        program.StartDate = System.today()-5;
        program.EndDate=System.today()+40;
        insert program;
       
        Campaign cmpgn = new Campaign();
        cmpgn.Name='Test Campaign';
        cmpgn.RecordTypeId=Util_GE_OG.getRecordTypeDetails('Campaign','Campaign').getRecordTypeId();
        cmpgn.ParentId=program.Id;
        cmpgn.Description='Test Campaign for Description';
        cmpgn.tier2_ge_og__c='Digital Solutions';
        cmpgn.tier3_ge_og__c = 'Bently Nevada';
        cmpgn.Owner_Function_ge_og__c='Marketing';
        
        cmpgn.Type='Outbound Telesales';
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
        cmpgn.Commercial_owner_Telesales_script_ge_og__c=UserInfo.getUserId();
        cmpgn.Subject_Matter_Expert_ge_og__c=UserInfo.getUserId();
        cmpgn.status='In Progress';
        insert cmpgn;
       
       CampaignMember cmr = new CampaignMember();
        cmr.CampaignID =cmpgn.Id;
        cmr.LeadID = lead.Id;
        cmr.Status='';
        cmr.CMR_Type_ge_og__c='Lead';
        cmr.Status_ge_og__c='';
        cmr.Dispostion_Reason_ge_og__c='Information Only request (New)';
        cmr.Account_Primary_Sales_ge_og__c=ur.id;
        cmr.Owner_ge_og__c= owr.Id ;
        
        
            insert cmr;
        
       //CampaignMember updateCMR = [Select Id,Owner_ge_og__c from CampaignMember Where Id =: cmr.Id];
       //lstcampaign.add(program2);
       //updateCMR.Owner_ge_og__c = owr.Id ;
       //update updateCMR;
       //insert lstcampaign;
        
       Test.startTest();

           O_CampaignMemberInactiveOwnerUpdate obj = new O_CampaignMemberInactiveOwnerUpdate();
            DataBase.executeBatch(obj);
          
           
        Test.stopTest();
        
    }
}