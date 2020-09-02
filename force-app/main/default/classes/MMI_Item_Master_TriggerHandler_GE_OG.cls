/* Handler class for the trigger MMI_Item_Master_Trigger_GEOG */
public class MMI_Item_Master_TriggerHandler_GE_OG{
    public void beforeInsertCall(List<MMI_Item_Master_ge_og__c> lstNewItemMaster){
        for(MMI_Item_Master_ge_og__c objMaster: lstNewItemMaster){
            objMaster.Region__c = Util_GE_OG.regionPopulateByCountry(objMaster.Country__c);
        }
    }
    
    public void beforeUpdateCall(List<MMI_Item_Master_ge_og__c> lstNewItemMaster, Map<ID,MMI_Item_Master_ge_og__c> oldMAsterMap){
        for(MMI_Item_Master_ge_og__c objMaster: lstNewItemMaster){
            objMaster.Region__c = Util_GE_OG.regionPopulateByCountry(objMaster.Country__c);
        }
    }
    
    public void afterInsertCall(){
    }
    
    public void afterUpdateCall(){
    }
}