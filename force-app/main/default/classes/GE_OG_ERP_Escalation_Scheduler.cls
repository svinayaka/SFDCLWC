/*
Class Name: GE_OG_ERP_Escalation_Scheduler 
Description: Scheduler Class to send escalations emails to ERP users.
Developer: Harsh Sharma.
Test Class: 
*/

global class GE_OG_ERP_Escalation_Scheduler implements Schedulable{

    //public static String CRON_EXP='0 0 0 * * ?';
      
    global void execute(SchedulableContext SC){
       List<GE_OG_ERP_Detail__c> pERPs=[select id,name,GE_OG_Advance_User__c,GE_OG_ERP_Advance_Input_Pending__c,GE_OG_ERP_Outbound_Timestamp__c from GE_OG_ERP_Detail__c where GE_OG_ERP_Advance_Input_Pending__c=true];
       List<GE_OG_ERP_Detail__c> pending_adv=new List<GE_OG_ERP_Detail__c>();
       List<GE_OG_ERP_Detail__c> eList=new List<GE_OG_ERP_Detail__c>();
       
       
       if(pERPs.size()>0){
           for(GE_OG_ERP_Detail__c adv:pERPs){
              Datetime startDate = DateTime.valueOf(adv.GE_OG_ERP_Outbound_Timestamp__c);// Start date
              Datetime endDate = DateTime.now();//End Date  
              Decimal intDays = endDate.day()-startDate.day();
              Decimal intHours= endDate.hour()-startDate.hour();
              Decimal intMins = endDate.minute()-startDate.minute();
              Decimal cycleTime=intDays*24 + intHours + intMins/60;
              system.debug('cycle time --->'+cycleTime);
              if(cycleTime > 24){
                  pending_adv.add(adv);
              }
           }
       }
       
       if(pending_adv.size()>0){
           if(pending_adv.size()>10){
               for(Integer i=0;i<10;i++){
                   pending_adv[i].GE_OG_ERP_Advance_Input_Pending__c=false;
                   eList.add(pending_adv[i]);
               }
           }else{
               for(GE_OG_ERP_Detail__c adv:pending_adv){
                   adv.GE_OG_ERP_Advance_Input_Pending__c=false;
                   eList.add(adv);
               }
           }
           update eList;
           
           String[] toAddresses = new String[] {};
           
           for(GE_OG_ERP_Detail__c adv_user:eList){
               toAddresses.add(adv_user.GE_OG_Advance_User__c);
               System.debug('####'+toAddresses);
           }
          
           Messaging.SingleEmailMessage mail=new Messaging.SingleEmailMessage();
           //String[] toAddresses = new String[] {eString};
           //mail.setReplyTo('advance_users_input@22b7574mgrwqsaxqmbqrp3a4bu1ftmcjm8gwaswlzmkoovwq36.z-14namai.z.apex.sandbox.salesforce.com');
           System.debug('*****'+ toAddresses);
           mail.setToAddresses(toAddresses);
           mail.setBccSender(false);
           mail.setSenderDisplayName('ERP Advance User Support'); 
           mail.setSubject('Reminder Mail - ERP Advance User Input Pending!!');
           mail.setUseSignature(false);
           mail.setPlainTextBody('This is a reminder mail. Please provide your inputs ASAP. Thanks!!');
           Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
       }
       
    }
}