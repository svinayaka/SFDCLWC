@isTest
public class PRM_ContractAddendumUpdates_Test {
    
    @isTest
    public static void contractstatus(){
        Test.startTest();
        List<PRM_Commercial_Line_GE_OG__c> updlst = new List<PRM_Commercial_Line_GE_OG__c>();
        List<Contract> cntrllst = new List<Contract>();
        Account acc = CommonTestDataFactory_GE_OG.createAccount('PRM Acct');
        PRM_Channel_Appointment_GE_OG__c prmcp = PRM_CommonTestDataFactory.createChAppt(acc);
        PRM_Commercial_Line_GE_OG__c cl = PRM_CommonTestDataFactory.createPRMCL(prmcp);
        PRM_Commercial_Line_GE_OG__c cl2 = PRM_CommonTestDataFactory.createPRMRenewCL(prmcp);
        PRM_Commercial_Line_GE_OG__c cl3 = PRM_CommonTestDataFactory.createPRMArchiveCL(prmcp);
        PRM_Commercial_Line_GE_OG__c cl4 = PRM_CommonTestDataFactory.createPRMNRTCL(prmcp);
        Contract mst = PRM_CommonTestDataFactory.createPRMMaster(prmcp,acc);
        Contract addendum = PRM_CommonTestDataFactory.createPRMAddendum(prmcp,acc,mst);
        Contract amendment = PRM_CommonTestDataFactory.createPRMAmendment(prmcp,acc,mst);
        amendment.PRM_Addendum_Contract__c =addendum.Id;
        update amendment;
        cl.PRM_Addendum_ID__c = addendum.Id;
        
        updlst.add(cl);
        
        Update updlst;
        
        
        cntrllst.add(amendment);
        
        PRM_ContractAddendumUpdates.updatelastamendment(cntrllst);
        Test.stopTest();
        
    }
    
}