/*
Type Name [Class/Trigger/Page Name] : GE_OGMCTS_Case_FollowersDelSchedule
Used Where ?                        : Used to Delete the Followers of MC-TS Cases,once case is closed
Purpose/Overview                    : Runs Every Day 8:AM and Delete the Case follwers.                                      
Functional Area                     : Case (Service) (R-22392)
Author                              : Raju Manche
Created Date                        : June 17 2015
Test Class Name                     : Test_GEOGMCTS_Case_Follwers

Change History -
Date Modified   : Developer Name        : Method/Section Modified/Added     : Purpose/Overview of Change
*/
global class GE_OGMCTS_Case_FollowersDelSchedule implements Schedulable {
    
    global void execute(SchedulableContext sc) {
        FollowerDelete();
    } 
    //:Date.today().addDays(-1)
    //AND (Case_Last_Modified_Date__c > :date.today().adddays(-1) OR Case_Last_Modified_Date__c >:date.today()))];
    public void FollowerDelete() {
        List <EntitySubscription> listtoDelete = [SELECT Id,SubscriberId FROM EntitySubscription 
                                                  WHERE ParentId IN (SELECT Id FROM case where (Status = 'Cancelled' OR Status='Closed')
                                                                     AND recordtype.name='MC-TS' and closedDate=YesterDay)];
        delete listtoDelete;      
    }    
}