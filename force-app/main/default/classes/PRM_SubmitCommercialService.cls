global without sharing class PRM_SubmitCommercialService {
    
    
   public List<Inputs> inputs;
    
    public class Inputs {
        public List<String> commLines;
    }
    
    
    webservice static string parse(String json) {
    List<Id> commIds =  new List<Id>();
    String result = 'Failure';
        system.debug(' json == '+json);
        PRM_SubmitCommercialService prmcomm = (PRM_SubmitCommercialService) System.JSON.deserialize(json, PRM_SubmitCommercialService.class);
        system.debug(' == '+prmcomm);
        for(PRM_SubmitCommercialService.Inputs param: prmcomm.Inputs){
            system.debug(' == '+param.commLines);
            for(String str : param.commLines)
            {
                commIds.add((Id)str);
            }
            
        }
        if(commIds != null && !commIds.isEmpty())
        {
            result = processData(commIds);
        }
        return result;
    }
    
    public static String processData(List<Id> commLines)
    {    String result = 'Failure';
        try
        {
            PRM_GenerateApprovals.generateCommercialApprovers(commLines);
            result = 'Success'; 
        }
        catch(Exception e)
        {
            result = 'Failure'; 
        }
        
        return result;
        
    }
    
}