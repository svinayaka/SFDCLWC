global class BatchContactStaleController implements Database.Batchable<sObject>{

    global Database.QueryLocator start(Database.BatchableContext BC){
        String strStale = 'Stale';
        String strNotStale = 'Not Stale';
        String strBlank = '';
        String strQuery = 'SELECT id,Contact_Stale__c,Contact_Stale_Date__c,Contact_Stale_Reason__c, Stale_Contact__c, Stale_Reason_Code__c from Contact WHERE (Contact_Stale__c = \''+strStale+ '\' AND (Stale_Contact__c !=\''+strStale+'\' OR Contact_Stale_Date__c=null)) OR (Contact_Stale__c=\''+strNotStale+'\' AND (Stale_Contact__c!=\''+strNotStale+'\' OR Stale_Reason_Code__c!=\''+strBlank+'\' OR Contact_Stale_Date__c!=null))';
        return Database.getQueryLocator(strQuery);
    }
    
    global void execute(Database.BatchableContext BC, List<Contact> scope){
        List<Contact> lstFinal = new List<Contact>();
        for(Contact objCon: scope){
            objCon.Stale_Contact__c = objCon.Contact_Stale__c;
            objCon.Stale_Reason_Code__c = objCon.Contact_Stale_Reason__c;
            if(objCon.Contact_Stale__c == 'Stale' && objCon.Contact_Stale_Date__c == null){
                objCon.Contact_Stale_Date__c = system.now();
            }
            else if(objCon.Contact_Stale__c == 'Not Stale'){
                objCon.Contact_Stale_Date__c = null;
            }
            lstFinal.add(objCon);
        }
        try{
            if(!lstFinal.isEmpty()){
                update lstFinal;
            }
        }
        catch(Exception e){
            system.debug('Exception while updating Contacts');
        }
    }
    
    global void finish(Database.BatchableContext BC){
        
    }
}