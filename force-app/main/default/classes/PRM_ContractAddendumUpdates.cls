/**
 * Created by Kiru
 * called from process builder - PRM_Update_Addendum_with_Amendment_Details
 * 
 * */
public class PRM_ContractAddendumUpdates {
    @invocablemethod
    public static void updatelastamendment(List<Contract> amndlst){
        List<Contract> updcontract =new List<Contract>();
        for(Contract amd : amndlst){
            COntract addupd = new COntract(Id=amd.PRM_Addendum_Contract__c);
            addupd.Last_Amendment_Id__c = amd.Id;
            updcontract.add(addupd);
        }
        
        if(updcontract != null){
            update updcontract;
        }
    }

}