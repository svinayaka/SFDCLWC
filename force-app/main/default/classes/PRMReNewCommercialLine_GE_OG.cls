/**
* 
* This class will be called by SKUID from the CL buttons, NR/T, Renewal and Amend
* The story is R-32794. SFDC class creats the 
* 
* */
public class PRMReNewCommercialLine_GE_OG {
    
    @InvocableMethod
    public static void passID(List<PRM_Commercial_Line_GE_OG__c> origID){
        
        List<PRM_Commercial_Line_GE_OG__c> oldClupdate = new List<PRM_Commercial_Line_GE_OG__c>();
        List<PRM_Commercial_Line_GE_OG__c> newClinsert = new List<PRM_Commercial_Line_GE_OG__c>();
        List<Contract> conUpdLst = new List<Contract>();
        for(PRM_Commercial_Line_GE_OG__c CL : origID){
            PRM_Commercial_Line_GE_OG__c renewcl = CL.clone();
            renewcl.PRM_Commercial_Line_Type__c = 'Renewal';
            renewcl.PRM_Previous_CL_ID__c = CL.Id;
            renewcl.PRM_Status__c = 'Draft';
            renewcl.PRM_Addendum_ID__c = null;
            renewcl.PRM_Amendment_ID__c = null;
            renewcl.Commercial_Parent__c = null;
            renewcl.Compliance_Parent__c = null;
         //   renewcl.Contract_Executed_Date__c = null;
            renewcl.External_Unique_ID__c = null;
            //  CL.PRM_Status__c='Under Renewal';
            //   CL.PRM_Previous_CL_ID__c = CL.PRM_Original_CL_ID__c;
            if(CL.PRM_Original_CL_ID__c !=null ){
                renewcl.PRM_Original_CL_ID__c = CL.PRM_Original_CL_ID__c;
            }else{
                renewcl.PRM_Original_CL_ID__c = CL.Id;
            }
            //get the related contract Addendum and change th status
            if(CL.PRM_Addendum_ID__c != null){
                Contract cntr = new Contract(Id=CL.PRM_Addendum_ID__c);
                cntr.Status = 'Under Renewal';
                conUpdLst.add(cntr);
            }
            
            oldClupdate.add(CL);
            newClinsert.add(renewcl);
        }
        if(oldClupdate != null){
            //  update oldClupdate;
        }
        
        if(newClinsert != null){
            insert newClinsert;
        }
        if(conUpdLst != null){
            Map<Id,Contract> cntrlstmap = new Map<Id,Contract>();
            cntrlstmap.putAll(conUpdLst);
            //  update conUpdLst;
            if(cntrlstmap.size()>0){
                update cntrlstmap.values();
            }
        }
    }
    
}