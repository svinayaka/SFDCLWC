/*Class name:		GE_OG_CreditCardEmailScanBatch
* Pupose:			This class will find emails that have credit card data in the description field. it creates Compliance Object records to hold the suspect record information.
* Date Created:	3/30/2016
* Author:			Koshay
* Related to:		R-24487
*/
global class GE_OG_CreditCardEmailScanBatch implements Database.Batchable<sObject>, Schedulable{
    
    public Datetime dt;  
    public String query = 'Select Id, TextBody, ParentId, CreatedDate from EmailMessage where CreatedDate > :dt';
    public Pattern thepattern;
    public Compliance_Object_Batch__c theBatch;
    
    global GE_OG_CreditCardEmailScanBatch(){
        thepattern= Pattern.compile('\\b(3[47]\\d{2}([ -]?)(?!(\\d)\\3{5}|123456|234567|345678)\\d{6}\\2(?!(\\d)\\4{4})\\d{5}|((4\\d|5[1-5]|65)\\d{2}|6011)([ -]?)(?!(\\d)\\8{3}|1234|3456|5678)\\d{4}\\7(?!(\\d)\\9{3})\\d{4}\\7\\d{4})\\b');
        try{
            OG_HQ_CC_Scan_Date__c scanningDate = [select Scan_Date__c from OG_HQ_CC_Scan_Date__c where name='CCScanDate'];
            
            if(scanningDate != null){
                if(scanningDate.Scan_Date__c != null)
                    dt = scanningDate.Scan_Date__c;
            }
            else{
                dt = System.now().addDays(-60);
                System.debug('Not able to get custom label DT, setting value to now - 60 days');
            }
        }
        Catch (Exception e){
            System.debug('Not able to get custom label DT, setting value to now - 60 days');
            dt = System.now().addDays(-60);
        }
        
        theBatch = new Compliance_Object_Batch__c(Object_Type__c='Email');
        insert theBatch;
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<EmailMessage> scope) {
        
        Matcher match = null;
        String preText ='';
        String postText='';
        boolean ret = false;
        
        List<Compliance_Object_Record__c> recordList = new List<Compliance_Object_Record__c>();
        Compliance_Object_Record__c record;
        
        for(EmailMessage em : scope){            
            if (em != null && em.TextBody != null){   
                preText ='';
                postText='';
                match = thepattern.matcher(em.TextBody);  
                
                ret = match.find();
                
                if (ret){
                    //Get the pre and post text context of this match
                    if(match.start() >34)
                        preText = em.TextBody.subString(match.start()-35,match.start()-1);
                    if(match.end() < em.TextBody.length()-35)
                        postText = em.TextBody.subString(match.end()+1,match.end()+34);                                 
                    
                    // Capture the case information and add to the list
                    record = new Compliance_Object_Record__c(Batch__c=theBatch.Id, Date_of_Record__c=date.newinstance(em.CreatedDate.year(), em.CreatedDate.month(), em.CreatedDate.day()),
                                                             Object_Type__c='Email',Pre_Text__c=preText, Post_Text__c=postText, RecordID__c=em.Id, Parent_RecordId__c=em.ParentId);
                    
                    recordList.add(record);
                    
                }                
            }
        }        
        insert recordList;
    }
    
    global void finish(Database.BatchableContext BC) {
        System.debug('GE_OG_CreditCardCaseScanBatch job finished');
        
        List<Compliance_Object_Record__c> Records = new List<Compliance_Object_Record__c>();
        Records = [Select Id from Compliance_Object_Record__c where Batch__c =: theBatch.Id];
        
        if(Records.size() >0){
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setSenderDisplayName('GEOG Batch Processing');
            mail.setTargetObjectId(System.UserInfo.getUserId());
            mail.setSubject('Email CC Batch Process Completed');
            mail.setPlainTextBody('Batch Process of Emails with possible Credit Card information has completed and found ' + Records.size() + ' records witih possible credit card.');            
            mail.setUseSignature(false);
			mail.setSaveAsActivity(false);
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
            
        } 
        
    }
    
    global void execute(SchedulableContext sc)
    {
        GE_OG_CreditCardEmailScanBatch batch = new GE_OG_CreditCardEmailScanBatch();
        database.executeBatch(batch, 2000);  
    }
    
}