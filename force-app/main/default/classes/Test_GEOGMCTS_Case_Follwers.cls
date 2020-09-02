/*
Type Name [Class/Trigger/Page Name] : Test_GEOGMCTS_Case_Follwers
Used Where ?                        : Test class for the class :GE_OGMCTS_Case_FollowersDelSchedule
Purpose/Overview                    : Runs Every Day 8:AM and Delete the Case follwers.                                      
Functional Area                     : Case (Service) (R-22392)
Author                              : Raju Manche
Created Date                        : June 17 2015
Test Class Name                     : Test_GEOGMCTS_Case_Follwers

Change History -
Date Modified   : Developer Name        : Method/Section Modified/Added     : Purpose/Overview of Change
*/
@isTest
public class Test_GEOGMCTS_Case_Follwers
{
    public static testMethod void schedulablemethod()
    {
        Test.startTest();
        GE_OGMCTS_Case_FollowersDelSchedule  ogc=new GE_OGMCTS_Case_FollowersDelSchedule();
        String sch = '0 0 0 * * ?'; 
        system.schedule('Test Territory Check', sch, ogc);
        Test.stopTest();
    }
}