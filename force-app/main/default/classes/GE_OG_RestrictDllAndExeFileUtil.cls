/*
Class/Trigger Name      : GE_OG_RestrictDllAndExeFileUtil
Used Where ?            : in content,Documents
Purpose/Overview        : to rstrict few file types from being uploaded
Functional Area         : Foundational
Author                  : Prasad Yadala
Created Date            : 12/10/2014
Test Class Name         : GE_OG_LibraryAttachmentTriggerTest
Code Coverage           : 100

Change History -

Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change

*/
public class GE_OG_RestrictDllAndExeFileUtil
{
    public static String strFilename;
    public static Set<String> listExtAndDllNotAllowed = new Set<String>();
    
    
    private static void setListExtAndDllNotAllowed(){
        // get the list of file extensions we want to block
        List<GE_OG_RestrFileExtn__c> files = new List<GE_OG_RestrFileExtn__c>();
        files = GE_OG_RestrFileExtn__c.getAll().values();
        for(GE_OG_RestrFileExtn__c file : files)        
            listExtAndDllNotAllowed.add(file.Name); 
    }
    
    
    public static void compareExeAndDll(String fileName,SObject objectType )
    {      
        setListExtAndDllNotAllowed(); 
        
        List<String> parts = fileName.splitByCharacterType();
        //below error message will be displayed if any of the restricted file types are being uploaded 
        if(listExtAndDllNotAllowed.Contains(parts[parts.size()-1]))
        {            
            String error='\"Due to GE Security compliance you cannot upload files of this type: ' + listExtAndDllNotAllowed +'.  Your file has not been uploaded\"';
            objectType.addError(error);            
        }
    }
    
    //method to retrieve the file name from feed
    public static void restrictFeedItemAttachment(FeedItem attachment)
    {        
        if(attachment.ContentFileName!=null)
        {
            strFilename = attachment.ContentFileName.toLowerCase();
            compareExeAndDll(strFilename,attachment);
        }
    }
    
    //method to retrieve the file name from content
    public static void restrictLibraryAttachment(ContentVersion attachment)
    {
        if(attachment.pathonclient!=null)
        {            
            strFilename = attachment.pathonclient.toLowerCase();
            compareExeAndDll(strFilename,attachment);
        }
    }
    
    //method to retrieve the file name from content
    public static void restrictSObjectAttachment(Attachment attach)
    {
        if(attach.Name!=null)
        {            
            strFilename = attach.Name.toLowerCase();
            compareExeAndDll(strFilename,attach);
        }
    }

    // Method is related to R-25011 to block non secure related attachments
    // This method is required on task becasue of an existing gap in the SFDC UI when
    // adding an attachment to a task.  The Attachment trigger is not fired in this userflow
    // this method could be removed in the future if the gap is resolved by SFDC
    public static void removeNonCompliantAttachments(List<Task> lstTasks){

        // check if the list of tasks have attachments.  Pass the list of attachments over
        // to the utility class to decide if they should be deleted or not
        list<Attachment> attachList = new List<Attachment>();
        attachList = [SELECT Id, ParentId, Name, OwnerId FROM Attachment where parentId in : lstTasks];
        Map<Id, List<Attachment>> attachmentMap = new map<Id, List<Attachment>>();

        for(Attachment a : attachList){
            // we have this task in the map already so just add the attachment to the list
            if(attachmentMap.containsKey(a.parentId)){
                attachmentMap.get(a.ParentId).add(a);
            }
            // we don't have an entry for this task in the map so add one
            else {
                List<Attachment> tempList = new list<Attachment>();
                tempList.add(a);
                attachmentMap.put(a.parentId, tempList);

            }
        }
		
        setListExtAndDllNotAllowed();        
        
        // go over the tasks and check for non compliant attachments
        for(Task myTask : lstTasks){
            if(attachmentMap.containsKey(myTask.Id)) {
                for(Attachment theAttachment : attachmentMap.get(myTask.Id)) {
                    String fileName = theAttachment.Name;
                    List<String> parts = fileName.splitByCharacterType();
                    //below error message will be displayed if any of the restricted file types are being uploaded
                    if (listExtAndDllNotAllowed.Contains(parts[parts.size() - 1])) {
                        String error = '\"Due to GE Security compliance you cannot upload files of this type ' + listExtAndDllNotAllowed + '.  Please remove all non-compliant file types from this task\"';
                        myTask.addError(error);

                    }
                }
            }
        }
    }




}