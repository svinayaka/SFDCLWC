global class GE_PRM_Batch_AccType_Scheduler implements Schedulable {

global void execute(SchedulableContext SC) {
       
      GE_Account_Batch_Update_Contract Accbatch = new GE_Account_Batch_Update_Contract();
      Database.ExecuteBatch(Accbatch,1);
      
     
   //GE_PRM_Batch_Update_ComAccs_Agreement agreementBatch = New GE_PRM_Batch_Update_ComAccs_Agreement();
     // Database.ExecuteBatch(agreementBatch );
     
}
}