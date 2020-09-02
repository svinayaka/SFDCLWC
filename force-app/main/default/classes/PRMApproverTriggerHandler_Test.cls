@isTest
public class PRMApproverTriggerHandler_Test
{
    static testMethod void testMethod1()
    {
        List<PRM_Commercial_Line_GE_OG__c> comlinelst = new List<PRM_Commercial_Line_GE_OG__c>();
        
         Account Acc1= new Account();
        Acc1.Name='Test Acc2';
        Acc1.Account_Status__c ='CC Approved';
        Acc1.GE_HQ_New_Account_Country__c = 'AUSTRIA'; 
        Acc1.GE_HQ_Country_Code__c = 'AT'; 
        insert Acc1;
        //Account Acc1 = CommonTestDataFactory_GE_OG.mediumRiskCountry('Test Acc2');
        
        PRM_Channel_Appointment_GE_OG__c prm_chApp1 = new PRM_Channel_Appointment_GE_OG__c();
        prm_chApp1.PRM_Account_Name__c = Acc1.id;
        prm_chApp1.PRM_Primary_Tier_2__c = 'Digital Solutions';
        prm_chApp1.PRM_Commercial_Manager__c = Userinfo.getUserId();
        prm_chApp1.PRM_Primary_Sales_Channel_Manager__c = Userinfo.getUserId();
        prm_chApp1.PRM_Any_use_of_Sub_dealers_or_Sub_Agents__c = 'Yes';
        insert prm_chApp1;
        
        PRM_Commercial_Line_GE_OG__c prm_commline= new PRM_Commercial_Line_GE_OG__c();
        prm_commline.PRM_Channel_Appointment__c = prm_chApp1.id;
        prm_commline.PRM_Status__c='Draft';
        prm_commline.PRM_Tier_2__c = 'Digital Solutions';
        prm_commline.PRM_Tier_4__c = 'Bently Nevada';
        prm_commline.PRM_Tier_3__c = 'Software';
        prm_commline.PRM_Non_Std_Indefinite_Discount_Com__c = 'Non-standard';
        comlinelst.add(prm_commline);
        insert comlinelst;
        
        PRM_Channel_Appointment_Parent_Approval__c caaParent = new PRM_Channel_Appointment_Parent_Approval__c();
        caaParent.PRM_Channel_Appointment__c = prm_chApp1.Id;
        caaParent.Parent_Status__c = 'Pending';
        caaParent.Status_Date__c = System.Today();
        caaParent.Type__c = 'Commercial';
        insert caaParent;
        
        PRM_Channel_Appointment_Approver__c approver = new PRM_Channel_Appointment_Approver__c();
        approver.Approver__c = Userinfo.getUserId();
        approver.Role__c = 'Commercial 1';
        approver.Region__c = 'Europe';
        approver.Country__c = 'AUSTRIA';
        approver.Delegated_User__c = Userinfo.getUserId();
        approver.Status__c = 'Pending';
        approver.PRM_Channel_Appointment__c = prm_chApp1.Id;
        approver.PRM_Channel_Appointment_Parent__c = caaParent.Id;
        approver.Tier_2_P_L__c = 'Digital Solutions';
        approver.Tier_3_P_L__c = 'Bently Nevada';
        approver.Tier_4_P_L__c = 'Software';
        
        insert approver;
        
        PRM_Channel_Appointment_Approver__c app = [Select Id,Status__c From PRM_Channel_Appointment_Approver__c Where Id =: approver.Id];
        app.Status__c = 'Approved';
        update app;
        
        
    }
    
    static testMethod void testMethod2()
    {
        List<PRM_Commercial_Line_GE_OG__c> comlinelst = new List<PRM_Commercial_Line_GE_OG__c>();
        
         Account Acc1= new Account();
        Acc1.Name='Test Acc2';
        Acc1.Account_Status__c ='CC Approved';
        Acc1.GE_HQ_New_Account_Country__c = 'AUSTRIA'; 
        Acc1.GE_HQ_Country_Code__c = 'AT'; 
        insert Acc1;
        //Account Acc1 = CommonTestDataFactory_GE_OG.mediumRiskCountry('Test Acc2');
        
        PRM_Channel_Appointment_GE_OG__c prm_chApp1 = new PRM_Channel_Appointment_GE_OG__c();
        prm_chApp1.PRM_Account_Name__c = Acc1.id;
        prm_chApp1.PRM_Primary_Tier_2__c = 'Digital Solutions';
        prm_chApp1.PRM_Commercial_Manager__c = Userinfo.getUserId();
        prm_chApp1.PRM_Primary_Sales_Channel_Manager__c = Userinfo.getUserId();
        prm_chApp1.PRM_Any_use_of_Sub_dealers_or_Sub_Agents__c = 'Yes';
        insert prm_chApp1;
        
        PRM_Channel_Appointment_Parent_Approval__c caaParent = new PRM_Channel_Appointment_Parent_Approval__c();
        caaParent.PRM_Channel_Appointment__c = prm_chApp1.Id;
        caaParent.Parent_Status__c = 'Pending';
        caaParent.Status_Date__c = System.Today();
        caaParent.Type__c = 'Commercial';
        insert caaParent;
        
        PRM_Commercial_Line_GE_OG__c prm_commline= new PRM_Commercial_Line_GE_OG__c();
        prm_commline.PRM_Channel_Appointment__c = prm_chApp1.id;
        prm_commline.PRM_Status__c='Commercial Approved';
        prm_commline.PRM_Tier_2__c = 'Digital Solutions';
        prm_commline.PRM_Tier_4__c = 'Bently Nevada';
        prm_commline.PRM_Tier_3__c = 'Software';
        prm_commline.PRM_Non_Std_Indefinite_Discount_Com__c = 'Non-standard';
        prm_commline.Commercial_Parent__c = caaParent.Id;
        comlinelst.add(prm_commline);
        
        PRM_Commercial_Line_GE_OG__c prm_commline1= new PRM_Commercial_Line_GE_OG__c();
        prm_commline1.PRM_Channel_Appointment__c = prm_chApp1.id;
        prm_commline1.PRM_Status__c='Compliance Submitted';
        prm_commline1.PRM_Tier_2__c = 'Digital Solutions';
        prm_commline1.PRM_Tier_4__c = 'Bently Nevada';
        prm_commline1.PRM_Tier_3__c = 'Software';
        prm_commline1.PRM_Non_Std_Indefinite_Discount_Com__c = 'Non-standard';
        prm_commline1.Commercial_Parent__c = caaParent.Id;
        comlinelst.add(prm_commline1);
        
        insert comlinelst;
        
        PRM_Channel_Appointment_Approver__c approver = new PRM_Channel_Appointment_Approver__c();
        approver.Approver__c = Userinfo.getUserId();
        approver.Role__c = 'Commercial 1';
        approver.Region__c = 'Europe';
        approver.Country__c = 'AUSTRIA';
        approver.Delegated_User__c = Userinfo.getUserId();
        approver.Status__c = 'Pending';
        approver.PRM_Channel_Appointment__c = prm_chApp1.Id;
        approver.PRM_Channel_Appointment_Parent__c = caaParent.Id;
        approver.Tier_2_P_L__c = 'Digital Solutions';
        approver.Tier_3_P_L__c = 'Bently Nevada';
        approver.Tier_4_P_L__c = 'Software';
        
        insert approver;
        
        PRM_Channel_Appointment_Parent_Approval__c parent = [Select Id,Parent_Status__c From PRM_Channel_Appointment_Parent_Approval__c Where Id =: caaParent.Id];
        parent.Parent_Status__c = 'Recalled';
        update parent;
        
        
    }
    
    static testMethod void testMethod3()
    {
        List<PRM_Commercial_Line_GE_OG__c> comlinelst = new List<PRM_Commercial_Line_GE_OG__c>();
        
         Account Acc1= new Account();
        Acc1.Name='Test Acc2';
        Acc1.Account_Status__c ='CC Approved';
        Acc1.GE_HQ_New_Account_Country__c = 'AUSTRIA'; 
        Acc1.GE_HQ_Country_Code__c = 'AT'; 
        insert Acc1;
        //Account Acc1 = CommonTestDataFactory_GE_OG.mediumRiskCountry('Test Acc2');
        
        PRM_Channel_Appointment_GE_OG__c prm_chApp1 = new PRM_Channel_Appointment_GE_OG__c();
        prm_chApp1.PRM_Account_Name__c = Acc1.id;
        prm_chApp1.PRM_Primary_Tier_2__c = 'Digital Solutions';
        prm_chApp1.PRM_Commercial_Manager__c = Userinfo.getUserId();
        prm_chApp1.PRM_Primary_Sales_Channel_Manager__c = Userinfo.getUserId();
        prm_chApp1.PRM_Any_use_of_Sub_dealers_or_Sub_Agents__c = 'Yes';
        insert prm_chApp1;
        
        
        
        PRM_Channel_Appointment_Parent_Approval__c caaParent = new PRM_Channel_Appointment_Parent_Approval__c();
        caaParent.PRM_Channel_Appointment__c = prm_chApp1.Id;
        caaParent.Parent_Status__c = 'Pending';
        caaParent.Status_Date__c = System.Today();
        caaParent.Type__c = 'Compliance';
        insert caaParent;
        
        PRM_Commercial_Line_GE_OG__c prm_commline= new PRM_Commercial_Line_GE_OG__c();
        prm_commline.PRM_Channel_Appointment__c = prm_chApp1.id;
        prm_commline.PRM_Status__c='Draft';
        prm_commline.PRM_Tier_2__c = 'Digital Solutions';
        prm_commline.PRM_Tier_4__c = 'Bently Nevada';
        prm_commline.PRM_Tier_3__c = 'Software';
        prm_commline.Compliance_Parent__c = caaParent.Id;
        prm_commline.PRM_Non_Std_Indefinite_Discount_Com__c = 'Non-standard';
        comlinelst.add(prm_commline);
        insert comlinelst;
        
        PRM_Channel_Appointment_Approver__c approver = new PRM_Channel_Appointment_Approver__c();
        approver.Approver__c = Userinfo.getUserId();
        approver.Role__c = 'Commercial 1';
        approver.Region__c = 'Europe';
        approver.Country__c = 'AUSTRIA';
        approver.Delegated_User__c = Userinfo.getUserId();
        approver.Status__c = 'Pending';
        approver.PRM_Channel_Appointment__c = prm_chApp1.Id;
        approver.PRM_Channel_Appointment_Parent__c = caaParent.Id;
        approver.Tier_2_P_L__c = 'Digital Solutions';
        approver.Tier_3_P_L__c = 'Bently Nevada';
        approver.Tier_4_P_L__c = 'Software';
        
        insert approver;
        approver.Status__c = 'Approved';
        
        update approver;
        
         
        
    }
    
    static testMethod void testMethod5()
    {
        List<PRM_Commercial_Line_GE_OG__c> comlinelst = new List<PRM_Commercial_Line_GE_OG__c>();
        
         Account Acc1= new Account();
        Acc1.Name='Test Acc2';
        Acc1.Account_Status__c ='CC Approved';
        Acc1.GE_HQ_New_Account_Country__c = 'AUSTRIA'; 
        Acc1.GE_HQ_Country_Code__c = 'AT'; 
        insert Acc1;
        //Account Acc1 = CommonTestDataFactory_GE_OG.mediumRiskCountry('Test Acc2');
        
        PRM_Channel_Appointment_GE_OG__c prm_chApp1 = new PRM_Channel_Appointment_GE_OG__c();
        prm_chApp1.PRM_Account_Name__c = Acc1.id;
        prm_chApp1.PRM_Primary_Tier_2__c = 'Digital Solutions';
        prm_chApp1.PRM_Commercial_Manager__c = Userinfo.getUserId();
        prm_chApp1.PRM_Primary_Sales_Channel_Manager__c = Userinfo.getUserId();
        prm_chApp1.PRM_Any_use_of_Sub_dealers_or_Sub_Agents__c = 'Yes';
        insert prm_chApp1;
        
        
        
        PRM_Channel_Appointment_Parent_Approval__c caaParent = new PRM_Channel_Appointment_Parent_Approval__c();
        caaParent.PRM_Channel_Appointment__c = prm_chApp1.Id;
        caaParent.Parent_Status__c = 'Pending';
        caaParent.Status_Date__c = System.Today();
        caaParent.Type__c = 'Compliance';
        insert caaParent;
        
        PRM_Commercial_Line_GE_OG__c prm_commline= new PRM_Commercial_Line_GE_OG__c();
        prm_commline.PRM_Channel_Appointment__c = prm_chApp1.id;
        prm_commline.PRM_Status__c='Draft';
        prm_commline.PRM_Tier_2__c = 'Digital Solutions';
        prm_commline.PRM_Tier_4__c = 'Bently Nevada';
        prm_commline.PRM_Tier_3__c = 'Software';
        prm_commline.Compliance_Parent__c = caaParent.Id;
        prm_commline.PRM_Non_Std_Indefinite_Discount_Com__c = 'Non-standard';
        comlinelst.add(prm_commline);
        insert comlinelst;
        
        Commercial_Line_Apporver_Relation__c rel = new Commercial_Line_Apporver_Relation__c();
        rel.Approver_Name__c = Userinfo.getName();
        rel.Final_Tier__c = prm_commline.PRM_Tier_2__c + prm_commline.PRM_Tier_3__c + prm_commline.PRM_Tier_4__c;
        rel.Role__c = 'Commercial 1';
        rel.ParentId__c = caaParent.Id;
        insert rel;
        
        PRM_Channel_Appointment_Approver__c approver = new PRM_Channel_Appointment_Approver__c();
        approver.Approver__c = Userinfo.getUserId();
        approver.Role__c = 'Commercial 1';
        approver.Region__c = 'Europe';
        approver.Country__c = 'AUSTRIA';
        approver.Delegated_User__c = Userinfo.getUserId();
        approver.Status__c = 'Pending';
        approver.PRM_Channel_Appointment__c = prm_chApp1.Id;
        approver.PRM_Channel_Appointment_Parent__c = caaParent.Id;
        approver.Tier_2_P_L__c = 'Digital Solutions';
        approver.Tier_3_P_L__c = 'Bently Nevada';
        approver.Tier_4_P_L__c = 'Software';
        
        insert approver;
        
        
    }
    
    static testMethod void testMethod6()
    {
        List<PRM_Commercial_Line_GE_OG__c> comlinelst = new List<PRM_Commercial_Line_GE_OG__c>();
        Set<Id> chpID = new Set<Id>();
         Account Acc1= new Account();
        Acc1.Name='Test Acc2';
        Acc1.Account_Status__c ='CC Approved';
        Acc1.GE_HQ_New_Account_Country__c = 'AUSTRIA'; 
        Acc1.GE_HQ_Country_Code__c = 'AT'; 
        insert Acc1;
        //Account Acc1 = CommonTestDataFactory_GE_OG.mediumRiskCountry('Test Acc2');
        
        PRM_Channel_Appointment_GE_OG__c prm_chApp1 = new PRM_Channel_Appointment_GE_OG__c();
        prm_chApp1.PRM_Account_Name__c = Acc1.id;
        prm_chApp1.PRM_Primary_Tier_2__c = 'Digital Solutions';
        prm_chApp1.PRM_Commercial_Manager__c = Userinfo.getUserId();
        prm_chApp1.PRM_Primary_Sales_Channel_Manager__c = Userinfo.getUserId();
        prm_chApp1.PRM_Any_use_of_Sub_dealers_or_Sub_Agents__c = 'Yes';
        insert prm_chApp1;
        chpID.add(prm_chApp1.Id);
        
        PRM_ApproversTriggerHandler.handleNeedMoreInfo(chpID,true);
        
       
        
        
    }
    
     static testMethod void testMethod8()
    {
        List<PRM_Commercial_Line_GE_OG__c> comlinelst = new List<PRM_Commercial_Line_GE_OG__c>();
        Set<Id> chpID = new Set<Id>();
         Account Acc1= new Account();
        Acc1.Name='Test Acc2';
        Acc1.Account_Status__c ='CC Approved';
        Acc1.GE_HQ_New_Account_Country__c = 'AUSTRIA'; 
        Acc1.GE_HQ_Country_Code__c = 'AT'; 
        insert Acc1;
        //Account Acc1 = CommonTestDataFactory_GE_OG.mediumRiskCountry('Test Acc2');
        
        PRM_Channel_Appointment_GE_OG__c prm_chApp1 = new PRM_Channel_Appointment_GE_OG__c();
        prm_chApp1.PRM_Account_Name__c = Acc1.id;
        prm_chApp1.PRM_Primary_Tier_2__c = 'Digital Solutions';
        prm_chApp1.PRM_Commercial_Manager__c = Userinfo.getUserId();
        prm_chApp1.PRM_Primary_Sales_Channel_Manager__c = Userinfo.getUserId();
        prm_chApp1.PRM_Any_use_of_Sub_dealers_or_Sub_Agents__c = 'Yes';
        insert prm_chApp1;
        chpID.add(prm_chApp1.Id);
        
        //PRM_ApproversTriggerHandler.handleNeedMoreInfo(chpID,true);
        
       
        PRM_Channel_Appointment_Parent_Approval__c caaParent = new PRM_Channel_Appointment_Parent_Approval__c();
        caaParent.PRM_Channel_Appointment__c = prm_chApp1.Id;
        caaParent.Parent_Status__c = 'Pending';
        caaParent.Status_Date__c = System.Today();
        caaParent.Type__c = 'Compliance';
        insert caaParent;
        
        PRM_Commercial_Line_GE_OG__c prm_commline= new PRM_Commercial_Line_GE_OG__c();
        prm_commline.PRM_Channel_Appointment__c = prm_chApp1.id;
        prm_commline.PRM_Status__c='Draft';
        prm_commline.PRM_Tier_2__c = 'Digital Solutions';
        prm_commline.PRM_Tier_4__c = 'Bently Nevada';
        prm_commline.PRM_Tier_3__c = 'Software';
        prm_commline.Compliance_Parent__c = caaParent.Id;
        prm_commline.PRM_Non_Std_Indefinite_Discount_Com__c = 'Non-standard';
        comlinelst.add(prm_commline);
        insert comlinelst;
        
        Commercial_Line_Apporver_Relation__c rel = new Commercial_Line_Apporver_Relation__c();
        rel.Approver_Name__c = Userinfo.getName();
        rel.Final_Tier__c = prm_commline.PRM_Tier_2__c + prm_commline.PRM_Tier_3__c + prm_commline.PRM_Tier_4__c;
        rel.Role__c = 'Commercial 1';
        rel.ParentId__c = caaParent.Id;
        insert rel;
        
        PRM_Channel_Appointment_Approver__c approver = new PRM_Channel_Appointment_Approver__c();
        approver.Approver__c = Userinfo.getUserId();
        approver.Role__c = 'Commercial 1';
        approver.Region__c = 'Europe';
        approver.Country__c = 'AUSTRIA';
        approver.Delegated_User__c = Userinfo.getUserId();
        approver.Status__c = 'Pending';
        approver.PRM_Channel_Appointment__c = prm_chApp1.Id;
        approver.PRM_Channel_Appointment_Parent__c = caaParent.Id;
        approver.Tier_2_P_L__c = 'Digital Solutions';
        approver.Tier_3_P_L__c = 'Bently Nevada';
        approver.Tier_4_P_L__c = 'Software';
        
        insert approver;
        
        PRM_Channel_Appointment_Approver__c approver1 = new PRM_Channel_Appointment_Approver__c();
        approver1.Approver__c = Userinfo.getUserId();
        approver1.Role__c = 'Commercial 1';
        approver1.Region__c = 'Europe';
        approver1.Country__c = 'AUSTRIA';
        approver1.Delegated_User__c = Userinfo.getUserId();
        approver1.Status__c = 'Pending';
        approver1.PRM_Channel_Appointment__c = prm_chApp1.Id;
        approver1.PRM_Channel_Appointment_Parent__c = caaParent.Id;
        approver1.Tier_2_P_L__c = 'Digital Solutions';
        approver1.Tier_3_P_L__c = 'Bently Nevada';
        approver1.Tier_4_P_L__c = 'Software';
        approver1.Status__c = 'Pending';
        insert approver1;
        
        
        approver1.Status__c = 'Rejected';
        
        update approver1;
        
        
    }
    
    
}