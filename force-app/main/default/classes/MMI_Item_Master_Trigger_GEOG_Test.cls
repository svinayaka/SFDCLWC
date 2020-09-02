@isTest
public class MMI_Item_Master_Trigger_GEOG_Test{
    public static testMethod void testCreateMaster(){
        MMI_Item_Master_ge_og__c objMaster = new MMI_Item_Master_ge_og__c();
        objMaster.name = 'TestMaster';
        objMaster.Material_Description__c = 'Test';
        objMaster.Country__c = 'INDIA';
        objMaster.Tier_2__c = 'Oil Field Services';
        objMaster.Tier_3__c = 'Artificial Lift';
        objMaster.Tier_4__c = 'Rod Lift Systems';
        objMaster.Plant_Number__c = '123456';
        objMaster.Plant_Name__c = 'Test Plant Name';
        objMaster.Product_Level_1__c = 'Level 1';
        objMaster.Product_Level_2__c = 'Level 2';
        objMaster.Quantity_in_Stock__c = 23;
        objMaster.Unit_Cost__c = 2;
        objMaster.Product_Level_1__c = 'Level 1';
        objMaster.Product_Level_2__c = 'Level 2';
        objMaster.Quantity_in_Stock__c = 23;
        insert objMaster;
        
        objMaster.Country__c = 'United States';
        update objMaster;
        
    }
}