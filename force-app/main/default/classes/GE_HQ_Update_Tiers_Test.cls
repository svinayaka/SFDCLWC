/*
Class Name:-      GE_HQ_Update_Tiers_Test
Overview:-        Test class for GE_HQ_Update_Tiers trigger on Region object
Author:-          Jayadev Rath
Created Date:-    15th Dec 2011
Change History:-  Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
                  15th Dec 2011 : Jayadev Rath       : Created : Created the for covering the Trigger
*/
@isTest
Private Class GE_HQ_Update_Tiers_Test {
    Static TestMethod Void GE_HQ_Update_Tiers_Test() {
        List<GE_HQ_P_L__c> BTList= [Select Id,GE_HQ_P_L_Hierarchy_Level__c,GE_HQ_Parent_P_L_Name__c,GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__c,GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__c,GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__c from GE_HQ_P_L__c where GE_HQ_P_L_Hierarchy_Level__c=4 and GE_HQ_Is_Active__c=True limit 1];
        If(BTList != Null && BTList.size()>0) {
            // Tier 5 is not prsent. So create a new record.
            GE_HQ_P_L__c BTier5 = new GE_HQ_P_L__c(Name='Tier 5',GE_HQ_Parent_P_L_Name__c = BTList[0].Id,GE_HQ_Is_Active__c=True,GE_HQ_P_L_ID__c=9999);
            Insert BTier5;

            GE_HQ_Region__c Rec5 = new GE_HQ_Region__c(Name='Region1',GE_HQ_Function__c = 'Sales',GE_HQ_Business_Tier__c=BTier5.Id);
            GE_HQ_Region__c Rec4 = new GE_HQ_Region__c(Name='Region1',GE_HQ_Function__c = 'Sales',GE_HQ_Business_Tier__c=BTList[0].Id);
            GE_HQ_Region__c Rec3 = new GE_HQ_Region__c(Name='Region1',GE_HQ_Function__c = 'Sales',GE_HQ_Business_Tier__c=BTList[0].GE_HQ_Parent_P_L_Name__c);
            GE_HQ_Region__c Rec2 = new GE_HQ_Region__c(Name='Region1',GE_HQ_Function__c = 'Sales',GE_HQ_Business_Tier__c=BTList[0].GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__c);
            GE_HQ_Region__c Rec1 = new GE_HQ_Region__c(Name='Region1',GE_HQ_Function__c = 'Sales',GE_HQ_Business_Tier__c=BTList[0].GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__c);
            GE_HQ_Region__c Rec0 = new GE_HQ_Region__c(Name='Region1',GE_HQ_Function__c = 'Sales',GE_HQ_Business_Tier__c=BTList[0].GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__c);
            List<GE_HQ_Region__c> RegList = new List<GE_HQ_Region__c>();
            RegList.add(Rec0); RegList.add(Rec1); RegList.add(Rec2); RegList.add(Rec3); RegList.add(Rec4); RegList.add(Rec5);
            Insert RegList;
        }
    }
}