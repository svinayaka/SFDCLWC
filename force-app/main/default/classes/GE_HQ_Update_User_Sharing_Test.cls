/*
Class Name:-      GE_HQ_Update_User_Sharing_Test
Overview:-        Test Class for GE_HQ_Update_User_Sharing trigger
Author:-          Jayadev Rath
Created Date:-    18th Jan 2012
Change History:-  Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
                  18th Jan 2012 : Jayadev Rath       : Created: Created for covering GE_HQ_Update_User_Sharing trigger
*/

@isTest
Private Class GE_HQ_Update_User_Sharing_Test {

    Public Static testMethod void GE_HQ_Update_User_Sharing_Test() {
        GE_HQ_Account_Plan__c AccPlan = new GE_HQ_Account_Plan__c(Name = 'Test Acc Plan');
        Insert AccPlan;
        User[] Users = [Select Id from User where isActive = True limit 2];
        GE_HQ_Account_Plan_Team__c APTeam = new GE_HQ_Account_Plan_Team__c(GE_HQ_Acc_Plan_Name__c=AccPlan.Id, GE_HQ_Access_Level__c='Read/Write', GE_HQ_Acc_Plan_Team_Member__c=Users[0].Id); 
        Insert APTeam;
        APTeam.GE_HQ_Access_Level__c = 'Read Only';
        try{
        Update APTeam;
        }catch(Exception ex){
            
        }
        APTeam.GE_HQ_Acc_Plan_Team_Member__c=Users[1].Id;
        try{
        Update APTeam;
        }catch(Exception ex1){
            
        }
        Delete APTeam;
    }
}