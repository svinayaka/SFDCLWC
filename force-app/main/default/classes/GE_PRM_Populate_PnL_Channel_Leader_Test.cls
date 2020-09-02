@isTest
public class GE_PRM_Populate_PnL_Channel_Leader_Test
{

static TestMethod void GE_PRM_Populate_PnL_Channel_LeaderMethod(){

GE_PRM_Appointment__c prmApp= new GE_PRM_Appointment__c();
prmApp.GE_PRM_Status__c='Submitted';
insert prmApp;

Account acc = new Account();
acc.name= 'testing';
acc.ShippingCountry = 'TEST';
insert acc;

GE_PRM_Recommendation__c prmrec= new GE_PRM_Recommendation__c();
prmrec.GE_PRM_Appointment_Number__c=prmApp.id;
prmrec.GE_PRM_Account__c= acc.id;
insert prmrec;

user u = new user();

GE_PRM_Recommendation_Approvers__c  prmapprovers = new GE_PRM_Recommendation_Approvers__c ();
prmapprovers.GE_PRM_Approver_Name__c = u.id;
prmapprovers.GE_PRM_Tier_1_New__c = 'OIL & GAS (O&G)';
prmapprovers.GE_PRM_Tier_2__c= 'DTS';
prmapprovers.GE_PRM_Tier_3__c = 'DP&S';
prmapprovers.GE_PRM_Role__c = 'Channel Leader 1';
prmapprovers.GE_PRM_Region__c= 'QUERYIT2';
prmapprovers.GE_PRM_Country__c= 'CANADA';

insert prmapprovers;

Contract  cont = new contract();

cont.GE_PRM_Recommendation_Link__c = prmrec.id;
cont.GE_OG_Contract_End_Date__c = system.today()-1;
//cont.GE_PRM_PnL_Channel_Leader__c= null; 
cont.GE_PRM_Business_Tier_1__c= 'OIL & GAS (O&G)';
cont.GE_PRM_Tier_2__c = 'DTS';
cont.GE_HQ_Buss_Tier1__c= 'PII';
cont.GE_PRM_Tier_3__c = 'DP&S';
cont.GE_PRM_Region__c = 'CANADA';
cont.GE_PRM_Tier_4__c = 'Control Solutions';
cont.GE_OG_Legal_Entity__c = 'Australia';
cont.GE_OG_FA_Type__c = 'Prices';
cont.Status = 'Draft';
cont.StartDate = date.parse('12/27/2009');
cont.AccountID = acc.id;
insert cont;
}

static TestMethod void GE_PRM_Populate_PnL_Channel_LeaderMethod1(){


test.starttest();

GE_PRM_Appointment__c prmApp1= new GE_PRM_Appointment__c();
prmApp1.GE_PRM_Status__c='Submitted';
insert prmApp1;

Account acc1 = new Account();
acc1.name= 'testing';
acc1.ShippingCountry = 'UNITED STATES';
insert acc1;

GE_PRM_Recommendation__c prmrec1= new GE_PRM_Recommendation__c();
prmrec1.GE_PRM_Appointment_Number__c=prmApp1.id;
prmrec1.GE_PRM_Account__c= acc1.id;
insert prmrec1;

user u1 = new user();

GE_PRM_Recommendation_Approvers__c  prmapprovers1 = new GE_PRM_Recommendation_Approvers__c ();
prmapprovers1.GE_PRM_Approver_Name__c = u1.id;
prmapprovers1.GE_PRM_Tier_1_New__c = 'Energy Management (EM)';
prmapprovers1.GE_PRM_Tier_2__c= 'Digital Energy (DE)';
prmapprovers1.GE_PRM_Tier_3__c = 'Grid Automation';
prmapprovers1.GE_PRM_Tier_4__c = 'Communications';
prmapprovers1.GE_PRM_Role__c = 'Channel Leader 1';
prmapprovers1.GE_PRM_Region__c= 'test';
prmapprovers1.GE_PRM_Country__c = 'UNITED STATES';
insert prmapprovers1;

Contract  cont1 = new contract();
cont1.GE_PRM_Recommendation_Link__c = prmrec1.id;
cont1.GE_OG_Contract_End_Date__c = system.today()-1;
cont1.GE_PRM_PnL_Channel_Leader__c= null; 
cont1.GE_PRM_Business_Tier_1__c= 'Energy Management (EM)';
cont1.GE_PRM_Tier_2__c = 'Digital Energy (DE)';
cont1.GE_HQ_Buss_Tier1__c= 'PII';
cont1.GE_PRM_Tier_3__c = 'Grid Automation';
cont1.GE_PRM_Region__c = 'test';
cont1.GE_PRM_Tier_4__c = 'Communications';
cont1.GE_OG_Legal_Entity__c = 'Australia';
cont1.GE_OG_FA_Type__c = 'Prices';
cont1.Status = 'Draft';
cont1.StartDate = date.parse('12/27/2009');
cont1.AccountID = acc1.id;
insert cont1;

test.stoptest();
}

}