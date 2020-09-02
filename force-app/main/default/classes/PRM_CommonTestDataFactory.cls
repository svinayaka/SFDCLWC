@Istest
public class PRM_CommonTestDataFactory {
    
    public static PRM_Channel_Appointment_GE_OG__c createChAppt(Account acc){
        PRM_Channel_Appointment_GE_OG__c chapp = new PRM_Channel_Appointment_GE_OG__c();
        chapp.PRM_Primary_Tier_2__c = 'Digital Solutions';
        chapp.PRM_Commercial_Manager__c = Userinfo.getUserId();
        chapp.PRM_Primary_Sales_Channel_Manager__c = Userinfo.getUserId();
        insert chapp;
        return chapp;
    }
    
    public static PRM_Commercial_Line_GE_OG__c createPRMCL(PRM_Channel_Appointment_GE_OG__c chappt){
        PRM_Commercial_Line_GE_OG__c cl = new PRM_Commercial_Line_GE_OG__c();
        cl.PRM_Channel_Appointment__c = chappt.Id;
        // cl.PRM_Tier_1__c = '';        
        cl.PRM_Tier_2__c = 'Digital Solutions';
        cl.PRM_Tier_3__c = 'Bently Nevada';
        cl.PRM_Tier_4__c = 'Software';
        
        cl.PRM_Pricing_Type__c = 'Flat';
        cl.PRM_If_flat_Pricing__c = 50;
        cl.PRM_Relationship_Type__c = 'Distributor';
        cl.PRM_Commercial_Line_Type__c='New';
        cl.PRM_Status__c='Draft';
        cl.PRM_Authorized_Countries_1__c = 'ITALY';
        
        insert cl;
        return cl;
    }
    
     public static PRM_Commercial_Line_GE_OG__c createPRMRenewCL(PRM_Channel_Appointment_GE_OG__c chappt){
        PRM_Commercial_Line_GE_OG__c cl = new PRM_Commercial_Line_GE_OG__c();
        cl.PRM_Channel_Appointment__c = chappt.Id;
        // cl.PRM_Tier_1__c = '';        
        cl.PRM_Tier_2__c = 'Digital Solutions';
        cl.PRM_Tier_3__c = 'Bently Nevada';
        cl.PRM_Tier_4__c = 'Software';
        
        cl.PRM_Pricing_Type__c = 'Flat';
        cl.PRM_If_flat_Pricing__c = 50;
        cl.PRM_Relationship_Type__c = 'Distributor';
        cl.PRM_Commercial_Line_Type__c='New';
        cl.PRM_Status__c='Under Renewal';
        cl.PRM_Authorized_Countries_1__c = 'ITALY';
        
        insert cl;
        return cl;
    }
    
      
     public static PRM_Commercial_Line_GE_OG__c createPRMArchiveCL(PRM_Channel_Appointment_GE_OG__c chappt){
        PRM_Commercial_Line_GE_OG__c cl = new PRM_Commercial_Line_GE_OG__c();
        cl.PRM_Channel_Appointment__c = chappt.Id;
        // cl.PRM_Tier_1__c = '';        
        cl.PRM_Tier_2__c = 'Digital Solutions';
        cl.PRM_Tier_3__c = 'Bently Nevada';
        cl.PRM_Tier_4__c = 'Software';
        
        cl.PRM_Pricing_Type__c = 'Flat';
        cl.PRM_If_flat_Pricing__c = 50;
        cl.PRM_Relationship_Type__c = 'Distributor';
        cl.PRM_Commercial_Line_Type__c='New';
        cl.PRM_Status__c='Archived';
        cl.PRM_Authorized_Countries_1__c = 'ITALY';
        
        insert cl;
        return cl;
    }
    
    public static PRM_Commercial_Line_GE_OG__c createPRMNRTCL(PRM_Channel_Appointment_GE_OG__c chappt){
        PRM_Commercial_Line_GE_OG__c cl = new PRM_Commercial_Line_GE_OG__c();
        cl.PRM_Channel_Appointment__c = chappt.Id;
        // cl.PRM_Tier_1__c = '';        
        cl.PRM_Tier_2__c = 'Digital Solutions';
        cl.PRM_Tier_3__c = 'Bently Nevada';
        cl.PRM_Tier_4__c = 'Software';
        
        cl.PRM_Pricing_Type__c = 'Flat';
        cl.PRM_If_flat_Pricing__c = 50;
        cl.PRM_Relationship_Type__c = 'Distributor';
        cl.PRM_Commercial_Line_Type__c='New';
        cl.PRM_Status__c='Under NR/T';
        cl.PRM_Authorized_Countries_1__c = 'ITALY';
        
        insert cl;
        return cl;
    }
    
    public static Contract createPRMMaster(PRM_Channel_Appointment_GE_OG__c chappt, Account acc){
        
        Id masterrtid = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('PRM Master Agreement').getRecordTypeId();
        
        Contract master = new Contract();
        master.AccountId = acc.Id;
        master.PRM_Channel_Appointment__c = chappt.Id;
        master.RecordTypeId = masterrtid;
        master.ContractTerm = 10;
        master.Status = 'Generate Draft';
        insert master;
        return master;
    }
    
    public static Contract createPRMAddendum(PRM_Channel_Appointment_GE_OG__c chappt, Account acc, Contract master){
        
        Id addendumid = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('PRM Addendum').getRecordTypeId();
        
        Contract addendum = new Contract();
        addendum.AccountId = acc.Id;
        addendum.PRM_Channel_Appointment__c = chappt.Id;
        addendum.RecordTypeId = addendumid;
        addendum.PRM_Master_Agreement__c = master.Id;
        addendum.ContractTerm = 10;
         addendum.Status = 'Generate Draft';
        insert addendum;
        return addendum;
    }
    
    public static Contract createPRMAmendment(PRM_Channel_Appointment_GE_OG__c chappt, Account acc, Contract master){
        
        Id amendmentid = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('PRM Amendment').getRecordTypeId();
        
        Contract amendment = new Contract();
        amendment.AccountId = acc.Id;
        amendment.PRM_Channel_Appointment__c = chappt.Id;
        amendment.RecordTypeId = amendmentid;
        amendment.PRM_Master_Agreement__c = master.Id;
        amendment.ContractTerm = 10;
        amendment.Status = 'Generate Draft';
        insert amendment;
        return amendment;
    }
    
}