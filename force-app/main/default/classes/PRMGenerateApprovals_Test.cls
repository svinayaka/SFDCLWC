@isTest
public class PRMGenerateApprovals_Test 
{
     static testMethod void testMethod1()
     {
        List<Id> commLineIds = new List<Id>();
        List<PRM_Commercial_Line_GE_OG__c> comlinelst = new List<PRM_Commercial_Line_GE_OG__c>();
        
        GE_ES_Role__c role = new GE_ES_Role__c();
        role.Name = 'Approver1';
        role.GE_PRM_Approver_Type__c = 'CommercialApprovers';
        role.GE_PRM_Role__c = true;
        insert role;
		
		GE_PRM_Recommendation_Approvers__c rec = new GE_PRM_Recommendation_Approvers__c();
		rec.GE_PRM_Approver_Name__c = Userinfo.getUserId();
		rec.GE_PRM_Role__c = 'Approver1';
		rec.GE_PRM_ISO_Code__c = 'AT'; 
		rec.GE_PRM_Tier_2__c = 'Digital Solutions';
		rec.GE_PRM_Tier_3__c = 'Software';
		rec.GE_PRM_Tier_4__c = 'Bently Nevada';
		rec.GE_PRM_Final_Tier_Selections__c = 'Oil & Gas - Digital Solutions - Software - Bently Nevada - Commercial 1 - AUSTRIA - null%, Oil & Gas - Digital Solutions - Software - Bently Nevada - Commercial 2 - AUSTRIA - null%';
		insert rec;
        
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
        
        for(PRM_Commercial_Line_GE_OG__c com : [Select Id from PRM_Commercial_Line_GE_OG__c Where ID IN: comlinelst])
        {
            commLineIds.add(com.Id);
        }
        
        Test.startTest();
        PRM_GenerateApprovals.generateCommercialApprovers(commLineIds);
        Test.stopTest();
     }
     
     static testMethod void testMethod2()
     {
        List<Id> commLineIds = new List<Id>();
        List<PRM_Commercial_Line_GE_OG__c> comlinelst = new List<PRM_Commercial_Line_GE_OG__c>();
        GE_ES_Role__c role = new GE_ES_Role__c();
        role.Name = 'Approver1';
        role.GE_PRM_Approver_Type__c = 'Low';
        role.GE_PRM_Role__c = true;
        insert role;
		
		GE_PRM_Recommendation_Approvers__c rec = new GE_PRM_Recommendation_Approvers__c();
		rec.GE_PRM_Approver_Name__c = Userinfo.getUserId();
		rec.GE_PRM_Role__c = 'Approver1';
		rec.GE_PRM_ISO_Code__c = 'AT'; 
		rec.GE_PRM_Tier_2__c = 'Digital Solutions';
		rec.GE_PRM_Tier_3__c = 'Software';
		rec.GE_PRM_Tier_4__c = 'Bently Nevada';
		rec.GE_PRM_Final_Tier_Selections__c = 'Oil & Gas - Digital Solutions - Software - Bently Nevada - Approver1 - AUSTRIA - null%';
		insert rec;
        
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
        prm_chApp1.PRM_Risk_Rating__c = 'Low';
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
        
        for(PRM_Commercial_Line_GE_OG__c com : [Select Id from PRM_Commercial_Line_GE_OG__c Where ID IN: comlinelst])
        {
            commLineIds.add(com.Id);
        }
        
        Test.startTest();
        PRM_GenerateCompliance.generateComplianceApprovers(commLineIds);
        Test.stopTest();
     }
     
     static testMethod void testMethod3()
     {
        List<Id> commLineIds = new List<Id>();
        List<PRM_Commercial_Line_GE_OG__c> comlinelst = new List<PRM_Commercial_Line_GE_OG__c>();
        
        GE_ES_Role__c role = new GE_ES_Role__c();
        role.Name = 'Approver1';
        role.GE_PRM_Approver_Type__c = 'Medium';
        role.GE_PRM_Role__c = true;
        insert role;
        
		GE_PRM_Recommendation_Approvers__c rec = new GE_PRM_Recommendation_Approvers__c();
		rec.GE_PRM_Approver_Name__c = Userinfo.getUserId();
		rec.GE_PRM_Role__c = 'Approver1';
		rec.GE_PRM_ISO_Code__c = 'AT'; 
		rec.GE_PRM_Tier_2__c = 'Digital Solutions';
		rec.GE_PRM_Tier_3__c = 'Software';
		rec.GE_PRM_Tier_4__c = 'Bently Nevada';
		rec.GE_PRM_Final_Tier_Selections__c = 'Oil & Gas - Digital Solutions - Software - Bently Nevada - Approver1 - AUSTRIA - null%';
		insert rec;
		
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
        prm_chApp1.PRM_Risk_Rating__c = 'Medium';
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
        
        for(PRM_Commercial_Line_GE_OG__c com : [Select Id from PRM_Commercial_Line_GE_OG__c Where ID IN: comlinelst])
        {
            commLineIds.add(com.Id);
        }
        
        Test.startTest();
        PRM_GenerateCompliance.generateComplianceApprovers(commLineIds);
        Test.stopTest();
     }
     
      static testMethod void testMethod5()
     {
        GE_ES_Role__c role = new GE_ES_Role__c();
        role.Name = 'Approver1';
        role.GE_PRM_Approver_Type__c = 'High';
        role.GE_PRM_Role__c = true;
        insert role;
        
		GE_PRM_Recommendation_Approvers__c rec = new GE_PRM_Recommendation_Approvers__c();
		rec.GE_PRM_Approver_Name__c = Userinfo.getUserId();
		rec.GE_PRM_Role__c = 'Approver1';
		rec.GE_PRM_ISO_Code__c = 'AT'; 
		rec.GE_PRM_Tier_2__c = 'Digital Solutions';
		rec.GE_PRM_Tier_3__c = 'Software';
		rec.GE_PRM_Tier_4__c = 'Bently Nevada';
		rec.GE_PRM_Final_Tier_Selections__c = 'Oil & Gas - Digital Solutions - Software - Bently Nevada - Approver1 - AUSTRIA - null%';
		insert rec;
		
        List<PRM_Commercial_Line_GE_OG__c> comlinelst = new List<PRM_Commercial_Line_GE_OG__c>();
        List<Id> commLineIds = new List<Id>();
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
        prm_chApp1.PRM_Risk_Rating__c = 'High';
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
        
        for(PRM_Commercial_Line_GE_OG__c com : [Select Id from PRM_Commercial_Line_GE_OG__c Where ID IN: comlinelst])
        {
            commLineIds.add(com.Id);
        }
        
        Test.startTest();
        PRM_GenerateCompliance.generateComplianceApprovers(commLineIds);
        Test.stopTest();
     }
	 
	 static testMethod void testMethod6()
     {
        GE_ES_Role__c role = new GE_ES_Role__c();
        role.Name = 'Approver1';
        role.GE_PRM_Approver_Type__c = 'High';
        role.GE_PRM_Role__c = true;
        insert role;
        
		GE_PRM_Recommendation_Approvers__c rec = new GE_PRM_Recommendation_Approvers__c();
		rec.GE_PRM_Approver_Name__c = Userinfo.getUserId();
		rec.GE_PRM_Role__c = 'Approver1';
		rec.GE_PRM_ISO_Code__c = 'AT'; 
		rec.GE_PRM_Tier_2__c = 'Digital Solutions';
		rec.GE_PRM_Tier_3__c = 'Software';
		rec.GE_PRM_Tier_4__c = 'Bently Nevada';
		rec.GE_PRM_Final_Tier_Selections__c = 'Oil & Gas - Digital Solutions - Software - Bently Nevada - Approver1 - AUSTRIA - null%';
		insert rec;
		
        List<PRM_Commercial_Line_GE_OG__c> comlinelst = new List<PRM_Commercial_Line_GE_OG__c>();
        List<Id> commLineIds = new List<Id>();
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
        prm_chApp1.PRM_Risk_Rating__c = 'High';
        prm_chApp1.PRM_Any_use_of_Sub_dealers_or_Sub_Agents__c = 'Yes';
        insert prm_chApp1;
        
        
        PRM_Commercial_Line_GE_OG__c prm_commline= new PRM_Commercial_Line_GE_OG__c();
        prm_commline.PRM_Channel_Appointment__c = prm_chApp1.id;
        prm_commline.PRM_Status__c='Draft';
        prm_commline.PRM_Tier_2__c = 'Digital Solutions';
        prm_commline.PRM_Tier_4__c = 'Bently Nevada';
        prm_commline.PRM_Tier_3__c = 'Software';
		prm_commline.PRM_Commercial_Line_Type__c = 'NRT';
        prm_commline.PRM_Non_Std_Indefinite_Discount_Com__c = 'Non-standard';
        comlinelst.add(prm_commline);
        insert comlinelst;
        
        for(PRM_Commercial_Line_GE_OG__c com : [Select Id from PRM_Commercial_Line_GE_OG__c Where ID IN: comlinelst])
        {
            commLineIds.add(com.Id);
        }
        
        Test.startTest();
        PRM_GenerateCompliance.generateComplianceApprovers(commLineIds);
        Test.stopTest();
     }
     
     
}