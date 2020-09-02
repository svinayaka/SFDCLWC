/*
Class Name                   - GE_OG_EmailMessageTrigger_Handler 
Object Name                  - EmailMessage
Created Date                 - 3/29/2016
Description                  -  Handler Class GE_OG_EmailMessageTrigger_Handler would process all the Trigger requests coming from GE_OG_EmailMessage_Trigger
DO NOT CREATE ANY NEW METHODS in this class.  Call out to your class for business logic processing
Related to:		R-24487
*/
public class GE_OG_EmailMessageTrigger_Handler {
    
    public void OnBeforeInsert(List<EmailMessage> newObjects){
        // Execute Before Insert Logic

        // R-24487
        List<EmailMessage> theList = new List<EmailMessage>();
        for(EmailMessage em : newObjects){
            if(em.ParentId != null && em.TextBody != null)
                theList.add(em);
        }
        
        String toggle;
        try{
            toggle = Label.Case_Credit_Card_Trigger_Toggle;
        }
        Catch(Exception e){
            System.debug('Exception trying to get toggle value: '+ e.getMessage());
            toggle = 'off';
        }
        
        if(toggle == null){
            toggle = 'off';
        }
        
        if(theList.size()>0 && toggle=='on')
            GE_OG_EmailCreditCardCheck.processEmails(newObjects);
    }
/*    
    public void OnAfterInsert(List<EmailMessage> newObjects){
        // EXECUTE AFTER INSERT LOGIC                  
    }
       
    public void OnBeforeDelete(List<EmailMessage> ObjectsToDelete, Map<Id, EmailMessage> oldObjectMap){
        // BEFORE DELETE LOGIC
    }
    
    public void OnAfterDelete(List<EmailMessage> deletedObjects, Map<Id, EmailMessage> oldObjectMap){
        // AFTER DELETE LOGIC
    }
    
    public void OnUndelete(List<EmailMessage> restoredObjects){
        // AFTER UNDELETE LOGIC
    }
*/
    
}