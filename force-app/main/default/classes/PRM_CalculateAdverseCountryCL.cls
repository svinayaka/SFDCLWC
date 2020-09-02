public class PRM_CalculateAdverseCountryCL {
    
    @InvocableMethod
    public static void calAdvRisk(List<PRM_Commercial_Line_GE_OG__c> clLst){
        Set<String> cntryset = new Set<String>();
        for(PRM_Commercial_Line_GE_OG__c cl : clLst){
            String[] tmpString = cl.PRM_Authorized_Countries_1__c.split(';'); 
            for(String s :tmpString ){
                cntryset.add(s); 
            }
            
        }
        
        List<GE_HQ_Country__c> cntrylst = [Select Id,Name,GE_PRM_Adverse_Termination_Risk__c from GE_HQ_Country__c where name in:cntryset ];
        Map<String,Decimal> cntrymap = new Map<String,Decimal>();
        Map<Id,PRM_Commercial_Line_GE_OG__c> updclLst = new Map<Id,PRM_Commercial_Line_GE_OG__c>();
        for(GE_HQ_Country__c cntry : cntrylst){
            cntrymap.put(cntry.Name ,cntry.GE_PRM_Adverse_Termination_Risk__c);
        }
        
        for(PRM_Commercial_Line_GE_OG__c cl : clLst){
            String[] tmpString = cl.PRM_Authorized_Countries_1__c.split(';'); 
            PRM_Commercial_Line_GE_OG__c updcl = new PRM_Commercial_Line_GE_OG__c(Id=cl.Id);
             updcl.PRM_Adverse_country_risk__c = false;
             updclLst.put(updcl.Id,updcl);
            for(String s :tmpString ){
                if(cntrymap.get(s) >= 20){
                    updcl.PRM_Adverse_country_risk__c = true;
                    updclLst.put(updcl.Id,updcl);
                }
                
            }
            
        }
        system.debug(' === '+updclLst);
        Update updclLst.values();
    }
    
}