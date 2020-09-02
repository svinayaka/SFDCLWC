public class CountFieldsonAccountBatchScheduler implements schedulable
{
    public void execute(SchedulableContext sc)
    {
        CountContactsCasesActivityOnAccountBatch objSch = new CountContactsCasesActivityOnAccountBatch(); 
        Database.executebatch(objSch,1000);
    }
}