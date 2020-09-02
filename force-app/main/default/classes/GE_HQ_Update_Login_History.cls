/*
Class Name        : GE_HQ_Update_Login_History
Purpose/Overview  : Inserting Login History into Custom Object
Author            : Sanjay Kumar Patidar
Test Class        : Test_GE_HQ_Update_Login_History
*/

/*
Use the below code in console to kick start the job

GE_HQ_Update_Login_History   s = new GE_HQ_Update_Login_History();
String hour = String.valueOf(Datetime.now().hour());
String min = String.valueOf(Datetime.now().minute()+1);
String ss = String.valueOf(Datetime.now().second() + 5);
String nextFireTime = ss + ' ' + min + ' ' + ' * * * ?';
system.schedule('Login History - Kick Start', nextFireTime, s);

*/

global class GE_HQ_Update_Login_History implements Schedulable
    {
    public static String CRON_EXP = '0 30 23 * * ?';
    global void execute(SchedulableContext SC) 
        {
        String returnQuery= 'Select Id, UserId, LoginTime, LoginType, SourceIp, LoginUrl, Browser, Platform, Status, Application, ClientVersion, ApiType, ApiVersion FROM LoginHistory where LoginTime = LAST_N_DAYS:2';
        
        UpdateLoginHistory BactchUpdateLoginHistory = new UpdateLoginHistory();
        BactchUpdateLoginHistory.Query = returnQuery;
        Database.executebatch(BactchUpdateLoginHistory, 2000);
        }
    }