/*
Req: R-25681
Class Name              :        GE_AL_CreateWellEquipRunDataSchedule
Class called from       :        wellrundatajob(Schedule Apex)
Purpose                 :        To Call Batch class GE_AL_CreateWellEquipmentRunDataBatch
Created on              :        5/17/2017  
*/

global class GE_AL_CreateWellEquipRunDataSchedule implements Schedulable {
   global void execute(SchedulableContext sc) {
      GE_AL_CreateWellEquipmentRunDataBatch cWellEquipData = new GE_AL_CreateWellEquipmentRunDataBatch(); 
      database.executebatch(cWellEquipData);
   }
}