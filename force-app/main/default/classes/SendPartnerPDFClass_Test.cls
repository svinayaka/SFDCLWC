@isTest
public class SendPartnerPDFClass_Test
{
	static TestMethod void SendPartnerPDFTestMethod(){ 	
		
		List<Id> chId = new List<Id>();
		 
		 Account Acc1= new Account();
        Acc1.Name='Test Acc2';
		Acc1.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
        Acc1.Account_Status__c ='CC Approved';
        Acc1.GE_HQ_New_Account_Country__c = 'AUSTRIA'; 
        Acc1.GE_HQ_Country_Code__c = 'AT'; 
		Acc1.Type = 'Direct Customer';
		Acc1.Classification__c = 'Unclassified';
        insert Acc1;
        //Account Acc1 = CommonTestDataFactory_GE_OG.mediumRiskCountry('Test Acc2');
		
		Contact objCon = new Contact();
        objCon.FirstName = 'wwwx';
        objCon.LastName = 'zzzcc';
        objCon.email = 'demo@user.com';
        objCon.AccountId = Acc1.id;
        objCon.title = 'Test';
        objCon.phone='123456';
        objCon.GE_OG_Country__c ='India';
        objCon.MailingCity ='Test';
        objCon.MailingCountry  ='India';
        objCon.MailingPostalCode  ='123456';
        objCon.MailingStreet  ='Test';
        objCon.GE_ES_Function__c ='Sales';
        insert objCon;
        
        
        PRM_Channel_Appointment_GE_OG__c prm_chApp1 = new PRM_Channel_Appointment_GE_OG__c();
        prm_chApp1.PRM_Account_Name__c = Acc1.id;
        prm_chApp1.PRM_Primary_Tier_2__c = 'Digital Solutions';
        prm_chApp1.PRM_Commercial_Manager__c = Userinfo.getUserId();
        prm_chApp1.PRM_Primary_Sales_Channel_Manager__c = Userinfo.getUserId();
        prm_chApp1.PRM_Any_use_of_Sub_dealers_or_Sub_Agents__c = 'Yes';
		prm_chApp1.PRM_Principal_Contact__c = objCon.Id;
        insert prm_chApp1;
		
		chId.add(prm_chApp1.Id);
		
		Pagereference Page = new Pagereference('/apex/PRM_ChannelAppointmentPDF');  
        Page.getParameters().put('Id',prm_chApp1.id);
		
		
		SendPartnerPDFClass.sendPDF(chId);
}
}