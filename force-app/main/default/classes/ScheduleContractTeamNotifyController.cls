public class ScheduleContractTeamNotifyController implements schedulable
{
    public void execute(SchedulableContext sc)
    {
        BatchContractTeamNotifyController objSch = new BatchContractTeamNotifyController(); 
        Database.executebatch(objSch);
    }
}