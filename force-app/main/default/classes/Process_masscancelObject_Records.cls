public class Process_masscancelObject_Records {
    Public Static void buildCsvFile(){
        List<Mass_Cancel_Opportunities_ge_og__c> masscancelObj = [SELECT Id, Name, OpportunityId_ge_og__c, Upload_Request_ge_og__c, Processed_ge_og__c, Uploaded_File_Name_ge_og__c, Opportunity_Win_Loss_Comments_ge_og__c, Success_Error_Message_ge_og__c,Upload_Request_ge_og__r.Id,Upload_Request_ge_og__r.Name FROM Mass_Cancel_Opportunities_ge_og__c where Processed_ge_og__c = false] ;
        set<Id> uploadrequestId = new Set<Id>();
        Map<Id,String> ursuccessmap = new Map<Id,String>();
        Map<Id,String> urfailuremap = new Map<Id,String>();
        Map<Id,String> uridfilename = new Map<Id,String>();
        List<Mass_Cancel_Opportunities_ge_og__c> mascancelUpdatelist = new List<Mass_Cancel_Opportunities_ge_og__c>();
        List<Attachment> attachmentList = new List<Attachment>();
        try{
            for(Mass_Cancel_Opportunities_ge_og__c masscancel : masscancelObj){
                String successErrormessgae ;
                if(masscancel.Success_Error_Message_ge_og__c != null){
                    successErrormessgae  = (masscancel.Success_Error_Message_ge_og__c);
                    
                }else{
                    successErrormessgae = ' ';
                }
                Mass_Cancel_Opportunities_ge_og__c masscancelUpdate = new Mass_Cancel_Opportunities_ge_og__c();
                masscancelUpdate.id = masscancel.Id;
                masscancel.Processed_ge_og__c = true;
                mascancelUpdatelist.add(masscancel);
                uploadrequestId.add(masscancel.Upload_Request_ge_og__r.Id);
                if(uridfilename.containsKey(masscancel.Upload_Request_ge_og__r.Id)){
                    
                }else{
                    uridfilename.put(masscancel.Upload_Request_ge_og__r.Id,masscancel.Uploaded_File_Name_ge_og__c);
                    
                }
                System.debug('successErrormessgae >>> '+successErrormessgae);
                System.debug('masscancel.Success_Error_Message_ge_og__c >> '+masscancel.Success_Error_Message_ge_og__c);
                if((successErrormessgae.startsWith('Error') || (String.isBlank(successErrormessgae)) ) && successErrormessgae != null ){
                    if(urfailuremap.containsKey(masscancel.Upload_Request_ge_og__r.Id)){
                        String failurecsv = urfailuremap.get(masscancel.Upload_Request_ge_og__r.Id)+'\n' ; failurecsv=failurecsv+masscancel.OpportunityId_ge_og__c+','+masscancel.Success_Error_Message_ge_og__c;urfailuremap.put(masscancel.Upload_Request_ge_og__r.Id,failurecsv);
                    }else  if(String.isBlank(successErrormessgae)){                        
                    }else{
                        String failurecsv = 'OpportunityId,Status\n'; 
                        failurecsv=failurecsv+masscancel.OpportunityId_ge_og__c+','+masscancel.Success_Error_Message_ge_og__c;
                        urfailuremap.put(masscancel.Upload_Request_ge_og__r.Id,failurecsv);
                    }
                }else{
                    if(ursuccessmap.containsKey(masscancel.Upload_Request_ge_og__r.Id) && !(String.isBlank(successErrormessgae)) && successErrormessgae != null ){
                        String successcsv = ursuccessmap.get(masscancel.Upload_Request_ge_og__r.Id)+'\n' ;  successcsv=successcsv+masscancel.OpportunityId_ge_og__c+','+masscancel.Success_Error_Message_ge_og__c;  ursuccessmap.put(masscancel.Upload_Request_ge_og__r.Id,successcsv);
                    }
                    else  if(String.isBlank(successErrormessgae)){
                        
                    }else{
                        String successcsv = 'OpportunityId,Status\n'; successcsv=successcsv+masscancel.OpportunityId_ge_og__c+','+masscancel.Success_Error_Message_ge_og__c;   ursuccessmap.put(masscancel.Upload_Request_ge_og__r.Id,successcsv);
                    } 
                }
            }
            for(Id uploadreqId : uploadrequestId){
                if(ursuccessmap.containsKey(uploadreqId)){
                    Attachment attachment = new Attachment();    attachment.Body = Blob.valueOf(ursuccessmap.get(uploadreqId)); attachment.Name = 'Success_'+uridfilename.get(uploadreqId);                     attachment.ParentId = uploadreqId; attachmentList.add(attachment);
                    
                }
                if(urfailuremap.containsKey(uploadreqId)){
                    Attachment attachment = new Attachment();
                    attachment.Body = Blob.valueOf(urfailuremap.get(uploadreqId));
                    attachment.Name = 'Error_'+uridfilename.get(uploadreqId);
                    attachment.ParentId = uploadreqId; 
                    attachmentList.add(attachment);
                    
                }
            }
            LIST<Upload_Request_ge_og__c> urlist = new LIST<Upload_Request_ge_og__c>();
            /*   for(Id uploadreqId : uploadrequestId){
Integer total=0;
Upload_Request_ge_og__c ur = new Upload_Request_ge_og__c();
ur.id= uploadreqId;
if(ursuccessmap.containsKey(uploadreqId)){
String[] csvfilelines = new String[]{};
String successrecords = ursuccessmap.get(uploadreqId);
csvfilelines = successrecords.split('\n');
ur.Success_Records__c = csvfilelines.size();
total = total+csvfilelines.size();

}

if(urfailuremap.containsKey(uploadreqId)){
String[] csvfilelines = new String[]{};
String failureRecords = urfailuremap.get(uploadreqId);
csvfilelines = failureRecords.split('\n');
ur.Error_Records__c = csvfilelines.size();
total = total+csvfilelines.size();

}
ur.Total_Records__c = total;
ur.Status__c = 'Completed';
urlist.add(ur);

}*/
            //Database.update(urlist);
            for(Id uploadreqId : uploadrequestId){
                Upload_Request_ge_og__c ur = new Upload_Request_ge_og__c();
                ur.Id = uploadreqId;
                ur.Status__c = 'Completed';
                urlist.add(ur);
            }
            Database.update(urlist);
            Database.update(mascancelUpdatelist);
            Database.insert(attachmentList);
        }  catch(Exception e){
            System.debug('exception occured >>> '+e.getCause());
            System.debug('exception error message >>> '+e.getMessage());
            System.debug('exception occured in Line number >>> '+e.getLineNumber());
        }
    }
    
}