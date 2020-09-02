global class scheduledSendMailToTresholdUser implements Schedulable {
   global void execute(SchedulableContext SC) {
      SendMailToTresholdUser M = new sendMailToTresholdUser(); 
       ID batchprocessid = Database.executeBatch(M,50); 
   }
}