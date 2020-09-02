public class ScheduleContactStaleController implements schedulable{
    public void execute(SchedulableContext sc)
    {
        BatchContactStaleController objSch = new BatchContactStaleController(); 
        Database.executebatch(objSch);
    }
}