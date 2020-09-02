/*    
Class Name        : GE_HQ_UpdateIBRecords_Scheduler
Purpose/Overview  : Scheduler class for GE_HQ_UpdateIBRecords batch apex.
Author            : Jayadev Rath
Change History    : Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
                  : 19th Jan 2012 : Jayadev Rath       : Created: Created for the R-7151, BC S-04442.
*/
Global Class GE_HQ_UpdateIBRecords_Scheduler implements Schedulable{
   Global Void Execute(SchedulableContext sc) {
      GE_HQ_UpdateIBRecords b = new GE_HQ_UpdateIBRecords(); 
      Database.executeBatch(b);
   }
}