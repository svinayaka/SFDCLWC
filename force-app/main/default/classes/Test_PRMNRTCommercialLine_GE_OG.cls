@isTest
public class Test_PRMNRTCommercialLine_GE_OG {
@isTest public static void passIDTest() {
     PRM_Commercial_Line_GE_OG__c prm = new PRM_Commercial_Line_GE_OG__c();
        
        Test.startTest();
    
     Account acc = CommonTestDataFactory_GE_OG.createAccount('PRM Acct');
        PRM_Channel_Appointment_GE_OG__c prmcp = PRM_CommonTestDataFactory.createChAppt(acc);
        PRM_Commercial_Line_GE_OG__c prm2 = new PRM_Commercial_Line_GE_OG__c(PRM_Status__c = 'Draft',
                                                                             PRM_Commercial_Line_Type__c = 'NRT',
                                                                             PRM_Previous_CL_ID__c = prm.Id,
                                                                             PRM_Addendum_ID__c = null,
                                                                             PRM_Amendment_ID__c = null,
                                                                             Commercial_Parent__c = null,
                                                                             Compliance_Parent__c = null,
                                                                             //Contract_Executed_Date__c = null,
                                                                             External_Unique_ID__c = null,
                                                                             PRM_Original_CL_ID__c =null,
                                                                             PRM_Channel_Appointment__c = prmcp.Id
                                                                            );
        insert prm2;
        PRMNRTCommercialLine_GE_OG.passID(new PRM_Commercial_Line_GE_OG__c[]{prm2});
        Test.stopTest();
       
    }
}