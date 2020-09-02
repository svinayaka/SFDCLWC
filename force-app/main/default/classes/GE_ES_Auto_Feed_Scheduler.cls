/*
Type Name [Class/Trigger/Page Name] : Class
Used Where ?                        : Used to Delete the Chatter Feed Generated due to Tracked Changes for the Users who have Opted Out.
Purpose/Overview                    : Runs Every Minute and Delete the Auto Feed for the Tracked Changes for the Users who have Opted-Out
                                      Out using the Checkbox at the User Level
Functional Area                     : Chatter
Author                              : Sanjay Kumar Patidar
Created Date                        : Dec 1st 2011
Test Class Name                     : 

Change History -
Date Modified   : Developer Name        : Method/Section Modified/Added     : Purpose/Overview of Change
*/

/*
Dependency -
1. Create a User with Admin Access.
2. Create a Custom Setting - (Label - Feed Opt Out, Object Name - GE_ES_Feed_Opt_Out, Visibility - Public, Setting Type - List)
                             Custom Fileds - (Label - Running User, API Name - GE_ES_Running_User__c, Text(18), (Label - Email, API Name - GE_ES_Admin_Email__c, Email)
                             Create a Record -   Running User = Salesforce Id of the Admin User Created above.
*/


/*
Execute the below code once as Anonymous from the System Log to Start the Schedule Process. 
Process would Start 5 secs after the below code is Executed.

GE_ES_Auto_Feed_Scheduler   s = new GE_ES_Auto_Feed_Scheduler();
String hour = String.valueOf(Datetime.now().hour());
String min = String.valueOf(Datetime.now().minute());
String ss = String.valueOf(Datetime.now().second() + 5);
String nextFireTime = ss + ' ' + min + ' ' + hour + ' * * ?';
system.schedule('Chatter Schedule - Kick Start', nextFireTime, s);

De-Activate the Admin User after 5 Mins.
*/




global class GE_ES_Auto_Feed_Scheduler implements Schedulable
    {
    
    //Declare the Admin Email, to be used in Messaging.
    global string  adminEmail;
    global Id  runningUser;
    global void execute(SchedulableContext SC) 
        {
        try
            {
            
            //Variable Declarations - 
            Set<Id> OpptyId = new Set<Id>();
            Set<Id> LastModifiedbyId = new Set<Id>();
            Set<Id> AutoFeedOptOutUsers = new Set<Id>();        
            
            
            //Instantiate the Custom Setting Feed Opt Out
            GE_ES_Feed_Opt_Out__c DelRunningUserConfig = GE_ES_Feed_Opt_Out__c.getInstance('Feed Opt-Out Job Id');
             if(DelRunningUserConfig .GE_ES_Running_User__c !=null)
                 {
                 //Capture the Admin Email & Running User defined in Custom Setting
                 adminEmail  = DelRunningUserConfig.GE_ES_Admin_Email__c;
                 runningUser = DelRunningUserConfig.GE_ES_Running_User__c;
                 }

            //Query the User who have Opted Out for Auto Feed based on the Last Modifed by User Ids.    
            List<User> AutoFeedOptOut = new List<User>([Select Id from User where GE_ES_AutoFdOut__c = true]);
    
            //Loop through Auto Feed Opt out Users and put them in a Set.
            For(Integer i=0; i<AutoFeedOptOut.size(); i++)
                {
                AutoFeedOptOutUsers.add(AutoFeedOptOut[i].Id);
                }
            
            //Query the Feed Items created as part of the Tracked Changes.    
            List<FeedItem> OptOutOpportunityFeed = new List<FeedItem>([Select Id from FeedItem where CreatedById IN: AutoFeedOptOutUsers and Type = 'TrackedChange']);
    
            if(OptOutOpportunityFeed.size()>0)
                {
                try
                    {
                    Delete OptOutOpportunityFeed;
                    }
                catch(Exception e)
                    {
                    System.Debug('Exception Caught while Deleting the Auto Feed - '+e);
                    }
                } 
            
            //Query the CronTrigger Object for the Redundant Jobs created by the Scheduler (Condition - Created By = Running User, Previously Fired = True)
            List<CronTrigger> cronTriggerList = new List<CronTrigger>([Select Id from CronTrigger where TimesTriggered != 0 and CreatedById =:runningUser and PreviousFireTime!=null Order By Createddate]);
            
            If(cronTriggerList.size()>0)
                {
                For(Integer i=0; i<cronTriggerList.size(); i++)
                    {
                    //Abort the Jobs Queried Above.
                    system.abortJob(cronTriggerList[i].Id);
                    }
                }
        
            //Call the Start Method to Schedule another Job.                                 
            start();
            }
        catch(Exception e)
            {
            System.Debug('Exception Caught in the Auto Feed Scheculer Class - '+e);
            
            //Implement the SingleEmail Message Class for sending Email incase of an Exception.
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            String[] toAddresses = new String[] {adminEmail};
            mail.setToAddresses(toAddresses);
            mail.setSubject('Chatter Auto Feed Delete Scheduled Job Exception - ' + e);
            mail.setPlainTextBody ('The Scheduled Job for Chatter Auto Feed Removal has failed. Exception - ' +e);
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
            }   
        }
    
    //Start method for the Next Schedule.    
    public static void start()
        {
        
        String min ;
        //Capture the Hours, Minutes and Sec from the Current Time.
        String hour = String.valueOf(Datetime.now().hour());
        
        //Add 1 Minute to the Current Time
        If ( Datetime.now().minute() >= 45 ) 
{
min =  String.valueOf((Datetime.now().minute()+15) - 60) ;

}
        else 
        min = String.valueOf(Datetime.now().minute() + 15);
        
        //Check if the Min value returned is 60, If yes then change it to 00.
        if(min == '60')
            min='00';
        String ss = String.valueOf(Datetime.now().second()); 
        
        //Set the Next Schedule Time.
        String nextFireTime = '1 '+min+' * * * ?';
        
        GE_ES_Auto_Feed_Scheduler s = new GE_ES_Auto_Feed_Scheduler();
        
        //Start the Schedule.
        try
            {
            System.schedule('Feed Opt-Out Schedule at - '+String.valueOf(Datetime.now()), nextFireTime, s);
            }
        catch(Exception e)
            {
            System.Debug('Exception Caught while Scheduling the Auto Feed - '+e);
            }
        }
    }