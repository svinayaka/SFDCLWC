@isTest
public class SaveSendPDF_Test
{
        static testMethod void testMethod1()
        {
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
            
            
            Pagereference Page = new Pagereference('/apex/PRM_ChannelAppointmentPDF'); 
            Test.setCurrentPage(Page);  
            Page.getParameters().put('Id',prm_chApp1.id);   
            ApexPages.StandardController sc = new ApexPages.StandardController(prm_chApp1);
            SaveSendPDF  obj = new SaveSendPDF(sc);


            
            
            
            
        }
}