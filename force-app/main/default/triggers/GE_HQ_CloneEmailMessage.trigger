/*
    Author: Shahbaz Ahmed
    Date Created: 10/24/2012
    Release : Org Split
    Description: This trigger is to move the email message over to old case if the case is getting generated as a result of 
    emails from customers for legacy Single Org cases belonging to OG and EM businesses.
*/
trigger GE_HQ_CloneEmailMessage on EmailMessage (before insert) {
 
    Set<Id> parentIDs = new Set<Id>();
    List<Case> existingCases = new List<Case>();
    List<EmailMessage> emailMsgs= new List<EmailMessage>();
    Map<Id, EmailMessage> msgWithParentId = new Map<Id, EmailMessage>();
    Map<String, EmailMessage> threadMsgs = new Map<String, EmailMessage>();
    Map<Id, EmailMessage> newMsgs= new Map<Id, EmailMessage>();
    for (EmailMessage emailMsg: trigger.new)
    {
      String refId= '';
      if (emailMsg.Subject!=null && (emailMsg.Subject.indexOf('[ ref:00DAKBfD') != -1 || emailMsg.Subject.indexOf('[ ref:_00DA0KBfD') != -1) && emailMsg.Subject.indexOf(':ref ]') != -1 && emailMsg.Incoming == true)
      {          
         refId = emailMsg.Subject.substring(emailMsg.Subject.lastindexOf('[ ref:'), emailMsg.Subject.lastindexOf(':ref ]')+6);
         refId = refId.replaceAll('_','');
         refId = refId.replace('ref:00DA0','ref:00DA');
         refId = refId.replace('.500A0','.500A');
        
         parentIDs.add(emailMsg.ParentId);
         threadMsgs.put(refId,emailMsg);  
         msgWithParentId.put(emailMsg.ParentId,emailMsg);
         newMsgs.put(emailMsg.Id, emailMsg);
         System.debug('REFERENCE'+refId);       
   
      }  
     }
      if(!threadMsgs.isEmpty())
      existingCases = [select Id, Legacy_Thread_ID__c, OwnerId from Case where Legacy_Thread_ID__c in :threadMsgs.keySet() ];
      if(existingCases!=null && existingCases.size()>0) {
        for(Case cse : existingCases) {
          EmailMessage emlMsg = threadMsgs.get(cse.Legacy_Thread_ID__c);
          if(emlMsg!=null) { emlMsg.ParentId=cse.Id;
      Task[] newTask = new Task[0];

        // Try to look up any contacts based on the email from address
        // If there is more than one contact with the same email address,
        // an exception will be thrown and the catch statement will be called.
        Contact vCon;
        try {
        vCon = [SELECT Id, Name, Email
        FROM Contact
        WHERE Email = :emlMsg.fromAddress
        LIMIT 1];
        } catch(Exception e){}
        // Add a new Task to the contact record we just found above.
        newTask.add(new Task(Description = emlMsg.TextBody,
        Priority = 'Normal',
        Status = 'Inbound Email',
        Subject = emlMsg.subject,
        WhatId = cse.Id,
        IsReminderSet = true,
        ReminderDateTime = System.now()+1,
        OwnerId = cse.OwnerId,
        WhoId = (vCon!=null?vCon.Id:null)));

        // Insert the new Task 
        try{
        insert newTask;     
        } catch(Exception e){}
        }
       }
    }
    try {
    List<Case> redundCases = [select Id from Case where Id in : parentIDs and Legacy_Thread_ID__c=null and Is_Redundant__c=true];
    if(redundCases!=null && redundCases.size()>0) delete redundCases;
    } catch(Exception e){System.debug('Some Redundant Cases could not be deleted!. Please use data loader to delete them based upon Is Reundant Flag being true.');}
             

}