@isTest
public class SendEmailToContractSpecialist_Test
{
    static TestMethod void sendEMailTestMethod(){   
        
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
        
        List<Id> parentIdList = new List<Id>();
        parentIdList.add(caaParent.Id);
        
        SendEmailToContractSpecialist.sendEmail(parentIdList);
}
}