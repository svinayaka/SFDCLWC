/**
 * Created by Kiru
 * for PRM Upgrade Project
 * */
@isTest
public class PRM_CreateCloneDueDiligence_Test {
    
    @isTest
    public static void created(){
        Test.startTest();
        List<Profile> prflst = [Select Id from Profile where name='OG_Sales/Comm Ops' limit 1];
        List<PRM_Commercial_Line_GE_OG__c> ClLst = new List<PRM_Commercial_Line_GE_OG__c>();
        User comm_manager = new User( Title = 'title',
                                     Alias = 'prmcommr',
                                     TimeZoneSidKey = 'America/Los_Angeles',
                                     EmailEncodingKey = 'UTF-8',
                                     LanguageLocaleKey = 'en_US',
                                     LocaleSidKey = 'en_US');
        comm_manager.FirstName = 'FirstName';
        comm_manager.LastName = 'Lastname';
        comm_manager.ProfileId = prflst[0].Id;
        comm_manager.CommunityNickname='prmcommmngr';
        comm_manager.Username='prmcommmngr@bakerhughes.com';
        comm_manager.Email='prmcommmngr@bakerhughes.com';
        //insert comm_manager;
        
        GE_HQ_Country__c cntry = new GE_HQ_Country__c();
        cntry.Name='ITALY';
        cntry.GE_PRM_Risk_Score__c = 25;
        cntry.GE_PRM_Adverse_Termination_Risk__c = 25;
        cntry.GE_PW_Risk_Type__c='Medium';
        cntry.GE_HQ_ISO_Code__c='IT';
        insert cntry;
        
        PRM_Channel_Appointment_GE_OG__c prmcp = new PRM_Channel_Appointment_GE_OG__c();
        prmcp.PRM_Primary_Tier_2__c='Digital Solutions';
        prmcp.PRM_Commercial_Manager__c = Userinfo.getUserId();
        prmcp.PRM_Primary_Sales_Channel_Manager__c = Userinfo.getUserId();
        insert prmcp;
        
        PRM_Due_Diligence__c prmdd = new PRM_Due_Diligence__c();
        prmdd.PRM_Channel_Appointment__c = prmcp.Id;
        prmdd.CA_Commercial_Manager__c = Userinfo.getUserId();
        insert prmdd;
        
        List<PRM_Due_Diligence__c> ddlst = new List<PRM_Due_Diligence__c>();
        ddlst.add(prmdd);
        PRM_CreateCloneDueDiligence.createDDfromPrevious(ddlst);
        PRMDueDiligenceHandler_GE_OG obj = new PRMDueDiligenceHandler_GE_OG();
        obj.emailNotificationOnDDInsertNotStarted(ddlst);
        
        PRM_Commercial_Line_GE_OG__c cl = new PRM_Commercial_Line_GE_OG__c();
        cl.PRM_Channel_Appointment__c = prmcp.Id;
        // cl.PRM_Tier_1__c = '';        
        cl.PRM_Tier_2__c = 'Digital Solutions';
        cl.PRM_Tier_3__c = 'Bently Nevada';
        cl.PRM_Tier_4__c = 'Software';
        
        cl.PRM_Pricing_Type__c = 'Flat';
        cl.PRM_If_flat_Pricing__c = 50;
        cl.PRM_Relationship_Type__c = 'Distributor';
        cl.PRM_Commercial_Line_Type__c='NRT';
        cl.PRM_Status__c='Draft';
        cl.PRM_Authorized_Countries_1__c = 'ITALY';
        
        insert cl;
        ClLst.add(cl);
        PRM_CalculateAdverseCountryCL.calAdvRisk(ClLst);
      
        Test.stopTest();
        
    }
}