/*
Req: R-25681
Class Name              :        GE_AL_UpdateWellEquipRunDataSchedule
Purpose                 :        To Call Batch class GE_AL_UpdateWellEquipmentRunDataBatch
Created on              :        5/17/2017  
*/

global class GE_AL_UpdateWellEquipRunDataSchedule implements Schedulable {
    global void execute(SchedulableContext sc) {
    GE_AL_UpdateWellEquipmentRunDataBatch uWellequipData = new GE_AL_UpdateWellEquipmentRunDataBatch();
    database.executebatch(uWellequipData);
    }
}