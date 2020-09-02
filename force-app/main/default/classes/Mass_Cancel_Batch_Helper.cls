public class Mass_Cancel_Batch_Helper {
    public static List<Mass_Cancel_Opportunities_ge_og__c> massCancelOptyRecords(List<Attachment> attachmentList){
        List<Mass_Cancel_Opportunities_ge_og__c> masscancelOpty = new List<Mass_Cancel_Opportunities_ge_og__c>();
        List<Mass_Cancel_Opportunities_ge_og__c> masscancelOptyupdate = new List<Mass_Cancel_Opportunities_ge_og__c>();
        for(Attachment at : attachmentList){
            String[] csvfilelines = new String[]{};
                Blob attachmentBody = at.Body;   
            String csvfileContent= attachmentBody.toString();  
            csvfilelines = csvfileContent.split('\n');
            
            for (Integer i=1;i<csvfilelines.size();i++)
            {
                String[] inputvalues = new String[]{};
                    inputvalues = csvfilelines[i].split(',');
                Mass_Cancel_Opportunities_ge_og__c masscancel = new Mass_Cancel_Opportunities_ge_og__c();
                masscancel.OpportunityId_ge_og__c = inputvalues[0];
                masscancel.Opportunity_Win_Loss_Comments_ge_og__c = inputvalues[1];
                masscancel.Upload_Request_ge_og__c = at.ParentId;
                masscancel.Uploaded_File_Name_ge_og__c = at.Name;
                masscancelOpty.add(masscancel);
                
            }
            
        }
        return masscancelOpty;
        
    }
}