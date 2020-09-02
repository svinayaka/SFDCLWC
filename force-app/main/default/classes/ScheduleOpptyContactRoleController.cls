public class ScheduleOpptyContactRoleController implements schedulable{
    public void execute(SchedulableContext sc)
    {
        BatchOpptyContactRoleController objSch = new BatchOpptyContactRoleController(); 
        Database.executebatch(objSch);
    }
}