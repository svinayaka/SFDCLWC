global class GE_CIR_SixthdayNotifySchedule implements Schedulable {
   global void execute(SchedulableContext sc) {
      GE_CIR_SendSixthDayEscEmail objBatch = new GE_CIR_SendSixthDayEscEmail(); 
      database.executebatch(objBatch ,20);
   }
}