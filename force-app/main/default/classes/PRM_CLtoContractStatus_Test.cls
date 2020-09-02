/**
 * Created by Kiru
 * for the classes PRM_CLtoContractStatus
 * 
 * */
@isTest
public class PRM_CLtoContractStatus_Test {
    
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
        cl.PRM_Addendum_ID__c = addendum.Id;
        //  cl.PRM_Status__c = 'Under Renewal';
        //  update cl;
        
        cl2.PRM_Addendum_ID__c = addendum.Id;
        //  cl2.PRM_Status__c = 'Under Amend';
        // update cl2;
        
        cl3.PRM_Addendum_ID__c = addendum.Id;
        cl4.PRM_Addendum_ID__c = addendum.Id;
        //   cl3.PRM_Status__c = 'Archived';
        // update cl;
        
        updlst.add(cl);
        updlst.add(cl2);
        updlst.add(cl3);
        updlst.add(cl4);        
        Update updlst;
        
        List<PRM_Commercial_Line_GE_OG__c> clLst = new List<PRM_Commercial_Line_GE_OG__c>();
        clLst.add(cl);
        clLst.add(cl2);
        clLst.add(cl3);
        clLst.add(cl4);
        PRM_CLtoContractStatus.calcualtecontractstatus(clLst);
        cntrllst.add(addendum);
       PRM_ContractStatus.passID(cntrllst);
        Test.stopTest();
        
    }
    
    @isTest
    public static void contractstatusUnderNRT(){
        Test.startTest();
        List<PRM_Commercial_Line_GE_OG__c> updlst = new List<PRM_Commercial_Line_GE_OG__c>();
          List<Contract> cntrllst = new List<Contract>();
        Account acc = CommonTestDataFactory_GE_OG.createAccount('PRM Acct');
        PRM_Channel_Appointment_GE_OG__c prmcp = PRM_CommonTestDataFactory.createChAppt(acc);
        PRM_Commercial_Line_GE_OG__c cl = PRM_CommonTestDataFactory.createPRMCL(prmcp);
        //  PRM_Commercial_Line_GE_OG__c cl2 = PRM_CommonTestDataFactory.createPRMRenewCL(prmcp);
        PRM_Commercial_Line_GE_OG__c cl3 = PRM_CommonTestDataFactory.createPRMArchiveCL(prmcp);
        PRM_Commercial_Line_GE_OG__c cl4 = PRM_CommonTestDataFactory.createPRMNRTCL(prmcp);
        Contract mst = PRM_CommonTestDataFactory.createPRMMaster(prmcp,acc);
        Contract addendum = PRM_CommonTestDataFactory.createPRMAddendum(prmcp,acc,mst);
        cl.PRM_Addendum_ID__c = addendum.Id;
        //  cl.PRM_Status__c = 'Under Renewal';
        //  update cl;
        
        //  cl2.PRM_Addendum_ID__c = addendum.Id;
        //  cl2.PRM_Status__c = 'Under Amend';
        // update cl2;
        
        cl3.PRM_Addendum_ID__c = addendum.Id;
        cl4.PRM_Addendum_ID__c = addendum.Id;
        //   cl3.PRM_Status__c = 'Archived';
        // update cl;
        
        updlst.add(cl);
        //  updlst.add(cl2);
        updlst.add(cl3);
        updlst.add(cl4);        
        Update updlst;
        
        List<PRM_Commercial_Line_GE_OG__c> clLst = new List<PRM_Commercial_Line_GE_OG__c>();
        clLst.add(cl);
        // clLst.add(cl2);
        clLst.add(cl3);
        clLst.add(cl4);
        PRM_CLtoContractStatus.calcualtecontractstatus(clLst);
         cntrllst.add(addendum);
       PRM_CLtoContractStatusAmendment.calcualtecontractstatus(cntrllst);
        Test.stopTest();
        
    }
    
    @isTest
    public static void contractstatusUnderAmend(){
        /***
Test.startTest();
Account acc = CommonTestDataFactory_GE_OG.createAccount('PRM Acct');
PRM_Channel_Appointment_GE_OG__c prmcp = PRM_CommonTestDataFactory.createChAppt(acc);
PRM_Commercial_Line_GE_OG__c cl = PRM_CommonTestDataFactory.createPRMCL(prmcp);
Contract mst = PRM_CommonTestDataFactory.createPRMMaster(prmcp,acc);
Contract addendum = PRM_CommonTestDataFactory.createPRMAddendum(prmcp,acc,mst);
cl.PRM_Addendum_ID__c = addendum.Id;
cl.PRM_Status__c = 'Under Amend';
update cl;

List<PRM_Commercial_Line_GE_OG__c> clLst = new List<PRM_Commercial_Line_GE_OG__c>();
clLst.add(cl);
//   PRM_CLtoContractStatus.calcualtecontractstatus(clLst);

addendum.GE_PRM_Contract_Draft_date__c = Date.today();
addendum.GE_PRM_Contract_Sent_to_CP__c = Date.today();
//  update addendum;
Test.stopTest();
**/
        
    }
    
}