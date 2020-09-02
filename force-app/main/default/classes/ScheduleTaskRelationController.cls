public class ScheduleTaskRelationController implements schedulable{
    public void execute(SchedulableContext sc)
    {
        BatchTaskRelationController objSch = new BatchTaskRelationController(); 
        Database.executebatch(objSch);
    }
}