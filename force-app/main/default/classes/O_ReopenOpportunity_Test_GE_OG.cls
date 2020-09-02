/*
Class/Trigger Name     : O_ReopenOpportunity_Test_GE_OG
Used For               : O_ReopenOpportunity_GE_OG
Purpose/Overview       : Test Class to calculate the code coverage for the O_ReopenOpportunity_GE_OG Class 
Scrum Team             : DEAL MGMT - Transformation
Requirement Number     : R-26400
Author                 : Rupal Seth
Created Date           : 26-Oct-2017
*/

@isTest
public class O_ReopenOpportunity_Test_GE_OG {
    Public static Opportunity opp {
        get;
        set;
    }
    Public static Opportunity opp1 {
        get;
        set;
    }
    Public static Account acc {
        get;
        set;
    }
    public static void init() {
        acc = new Account();
        acc = CommonTestDataFactory_GE_OG.createRelationshipAccount('TestAccount Relation 1');
        system.assertEquals('TestAccount Relation 1', acc.Name);
        opp = new Opportunity();
        opp = CommonTestDataFactory_GE_OG.createOppty('Testopportunity', acc.ID);

        opp1 = new opportunity();
        opp1.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Opportunity', 'Grouped Flow').getRecordTypeId();
        opp1.name = 'TESTopp1';
        opp1.stageName = 'Negotiating';
        opp1.Grouped_Flow_Type_ge_og__c = 'With Account';
        opp1.has_opportunitycontactrole_ge_og__c = True;
        opp1.region_ge_og__c = 'India';
        opp1.Risk_Region_ge_og__c = 'India';
        opp1.closedate = system.today().addDays(30);
        opp1.accountId = acc.Id;
        opp1.tier_2_ge_og__c = 'Digital Solutions';
        opp1.tier_3_ge_og__c = 'Bently Nevada';
        opp1.amount_ge_og__c = 1000.00;
        opp1.need_comm_ops_support_ge_og__c = true;
        opp1.Is_express_ge_og__c = 'Yes';
        opp1.opportunity_region_ge_og__c = 'Region';
        CommonTestDataFactory_GE_OG.DeactivateIFETrig();
        insert opp1;
    }

    public static testMethod void Test_reopenOpptyLogic_OG_Cancelled() {
        init();
        test.startTest();
        opp.StageName = 'Cancelled';
        opp.stage_ge_og__c = 'Cancelled';
        opp.primary_reason_code_ge_og__c = 'BHGE Preferred';
        opp.primary_sub_reason_code_ge_og__c = 'Channel/EPC';
        try{
            update opp;
        }
        catch(Exception e){
            system.debug('Update of O&G oppty failed-------'+e);
        }
        List < Id > lstOpptyId = new List < Id > {opp.Id};
        string OpptySuccess = O_ReopenOpportunity_GE_OG.reopenOppty(opp.Id);
        List < string > submitResult = O_ReopenOpportunity_GE_OG.reopenOppty(lstOpptyId);
        test.stopTest();
    }

    public static testMethod void Test_reopenOpptyLogic_GroupedFlow_Cancelled() {
        init();
        test.startTest();
        opp1.StageName = 'Cancelled';
        opp1.stage_ge_og__c = 'Cancelled';
        opp1.primary_reason_code_ge_og__c = 'BHGE Preferred';
        opp1.primary_sub_reason_code_ge_og__c = 'Channel/EPC';
        try{
            update opp1;
        }
        catch(Exception e){
            System.debug('Update of Grouped flow oppty failed---------'+e);
        }
        List < Id > lstOpptyId = new List < Id > {opp1.Id};
        string OpptySuccess = O_ReopenOpportunity_GE_OG.reopenOppty(opp1.Id);
        List < string > submitResult = O_ReopenOpportunity_GE_OG.reopenOppty(lstOpptyId);
        test.stopTest();
    }
}