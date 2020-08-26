/*
Trigger Name:-    GE_HQ_Update_Tiers 
Overview:-        This Triger is used to update the Derived Tier values on Region object by looking into the Associated P&L Value
Author:-          Jayadev Rath
Created Date:-    15th Dec 2011
Test Class Name:- GE_HQ_Update_Tiers_Test
Change History:-  Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
                  15th Dec 2011 : Jayadev Rath       : Created : Created the Trigger to meet the target of BC S-04198 for updating the Derived Tier fields using a bouble up logic 
*/
Trigger GE_HQ_Update_Tiers on GE_HQ_Region__c (Before Insert, Before Update) {
    // Get the List of Business Tier records.
    Map<Id,GE_HQ_P_L__c> BTList = new Map<Id,GE_HQ_P_L__c>([Select Id,Name,GE_HQ_P_L_Hierarchy_Level__c,GE_HQ_Parent_P_L_Name__c from GE_HQ_P_L__c where GE_HQ_Is_Active__c= True limit 1000]);
    // Update the Derived Tier values on the record    
    For(GE_HQ_Region__c RegRec : Trigger.New){
        If(RegRec.GE_HQ_Business_Tier__c == Null) continue;
        String TierId = RegRec.GE_HQ_Business_Tier__c;
        //Integer HierarchyLvl =(Integer) BTList.get(TierId).GE_HQ_P_L_Hierarchy_Level__c;
        Integer HierarchyLvl =  (BTList.get(TierId).GE_HQ_P_L_Hierarchy_Level__c).intvalue();
  

        If(HierarchyLvl == 0) {
            RegRec.GE_HQ_Derived_Tier_0__c = BTList.get(TierId).Name;
            RegRec.GE_HQ_Derived_Tier_1__c = null;
            RegRec.GE_HQ_Derived_Tier_2__c = null;
            RegRec.GE_HQ_Derived_Tier_3__c = null;
            RegRec.GE_HQ_Derived_Tier_4__c = null;
            RegRec.GE_HQ_Derived_Tier_5__c = null;
        }       
        else If(HierarchyLvl == 1) {
            RegRec.GE_HQ_Derived_Tier_1__c = BTList.get(TierId).Name;
            RegRec.GE_HQ_Derived_Tier_0__c = BTList.get(BTList.get(TierId).GE_HQ_Parent_P_L_Name__c).Name;
            RegRec.GE_HQ_Derived_Tier_2__c = null;
            RegRec.GE_HQ_Derived_Tier_3__c = null;
            RegRec.GE_HQ_Derived_Tier_4__c = null;
            RegRec.GE_HQ_Derived_Tier_5__c = null;
        }
        else If(HierarchyLvl == 2) {
            RegRec.GE_HQ_Derived_Tier_2__c = BTList.get(TierId).Name;
            RegRec.GE_HQ_Derived_Tier_1__c = BTList.get(BTList.get(TierId).GE_HQ_Parent_P_L_Name__c).Name;
            RegRec.GE_HQ_Derived_Tier_0__c = BTList.get(BTList.get(BTList.get(TierId).GE_HQ_Parent_P_L_Name__c).GE_HQ_Parent_P_L_Name__c).Name;
            RegRec.GE_HQ_Derived_Tier_3__c = null;
            RegRec.GE_HQ_Derived_Tier_4__c = null;
            RegRec.GE_HQ_Derived_Tier_5__c = null;
        }
        else If(HierarchyLvl == 3) {
            RegRec.GE_HQ_Derived_Tier_3__c = BTList.get(TierId).Name;
            RegRec.GE_HQ_Derived_Tier_2__c = BTList.get(BTList.get(TierId).GE_HQ_Parent_P_L_Name__c).Name;
            RegRec.GE_HQ_Derived_Tier_1__c = BTList.get(BTList.get(BTList.get(TierId).GE_HQ_Parent_P_L_Name__c).GE_HQ_Parent_P_L_Name__c).Name;
            RegRec.GE_HQ_Derived_Tier_0__c = BTList.get(BTList.get(BTList.get(BTList.get(TierId).GE_HQ_Parent_P_L_Name__c).GE_HQ_Parent_P_L_Name__c).GE_HQ_Parent_P_L_Name__c).Name;
            RegRec.GE_HQ_Derived_Tier_4__c = null;
            RegRec.GE_HQ_Derived_Tier_5__c = null;
        }
        else If(HierarchyLvl == 4) {
            RegRec.GE_HQ_Derived_Tier_4__c = BTList.get(TierId).Name;
            RegRec.GE_HQ_Derived_Tier_3__c = BTList.get(BTList.get(TierId).GE_HQ_Parent_P_L_Name__c).Name;
            RegRec.GE_HQ_Derived_Tier_2__c = BTList.get(BTList.get(BTList.get(TierId).GE_HQ_Parent_P_L_Name__c).GE_HQ_Parent_P_L_Name__c).Name;
            RegRec.GE_HQ_Derived_Tier_1__c = BTList.get(BTList.get(BTList.get(BTList.get(TierId).GE_HQ_Parent_P_L_Name__c).GE_HQ_Parent_P_L_Name__c).GE_HQ_Parent_P_L_Name__c).Name;
            RegRec.GE_HQ_Derived_Tier_0__c = BTList.get(BTList.get(BTList.get(BTList.get(BTList.get(TierId).GE_HQ_Parent_P_L_Name__c).GE_HQ_Parent_P_L_Name__c).GE_HQ_Parent_P_L_Name__c).GE_HQ_Parent_P_L_Name__c).Name;
            RegRec.GE_HQ_Derived_Tier_5__c = null;
        }
        else If(HierarchyLvl == 5) {
            RegRec.GE_HQ_Derived_Tier_5__c = BTList.get(TierId).Name;
            RegRec.GE_HQ_Derived_Tier_4__c = BTList.get(BTList.get(TierId).GE_HQ_Parent_P_L_Name__c).Name;
            RegRec.GE_HQ_Derived_Tier_3__c = BTList.get(BTList.get(BTList.get(TierId).GE_HQ_Parent_P_L_Name__c).GE_HQ_Parent_P_L_Name__c).Name;
            RegRec.GE_HQ_Derived_Tier_2__c = BTList.get(BTList.get(BTList.get(BTList.get(TierId).GE_HQ_Parent_P_L_Name__c).GE_HQ_Parent_P_L_Name__c).GE_HQ_Parent_P_L_Name__c).Name;
            RegRec.GE_HQ_Derived_Tier_1__c = BTList.get(BTList.get(BTList.get(BTList.get(BTList.get(TierId).GE_HQ_Parent_P_L_Name__c).GE_HQ_Parent_P_L_Name__c).GE_HQ_Parent_P_L_Name__c).GE_HQ_Parent_P_L_Name__c).Name;
            RegRec.GE_HQ_Derived_Tier_0__c = BTList.get(BTList.get(BTList.get(BTList.get(BTList.get(BTList.get(TierId).GE_HQ_Parent_P_L_Name__c).GE_HQ_Parent_P_L_Name__c).GE_HQ_Parent_P_L_Name__c).GE_HQ_Parent_P_L_Name__c).GE_HQ_Parent_P_L_Name__c).Name;
        }
    }
}