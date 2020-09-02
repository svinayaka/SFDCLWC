/**Class Name:SWIBScheduleBatch**/
/**Purpose:To implement scheduling of batch classes**/
/**        SWIBBatchApexCaseForEventRecord         **/
/**        SWIBBatchApexWOForEventRecord           **/

global class SWIBScheduleBatch implements schedulable
{
    global void execute(SchedulableContext sc)
    {
    
      SWIBBatchApexCaseForEventRecord objSWIBCase = new SWIBBatchApexCaseForEventRecord(); 
      SWIBBatchApexWOForEventRecord objSWIBWO = new SWIBBatchApexWOForEventRecord(); 
      database.executebatch(objSWIBCase);
      database.executebatch(objSWIBWO);
    }
}