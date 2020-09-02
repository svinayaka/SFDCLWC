/*
Type Name [Class/Trigger/Page Name] : Test Class
Used Where ?                        : Test Class for the Main Class - GE_HQ_Update_Login_History
Functional Area                     : Chatter
Author                              : Sanjay Kumar Patidar
Created Date                        : May 17th 2012
Test Class Name                     : 

Change History -
Date Modified   : Developer Name        : Method/Section Modified/Added     : Purpose/Overview of Change
*/

@isTest
private class Test_GE_HQ_Update_Login_History
    {

    public static testMethod void Test_Batchable() 
        {
        Test.StartTest();
        GE_HQ_Update_Login_History myClass= new GE_HQ_Update_Login_History();
        String sch = '0 30 23 * * ?';
        system.schedule('Test Territory Check', sch, myClass);
        Test.StopTest();        
        }
    public static TestMethod void UpdateLoginHistory_Test(){
    
        List<LoginHistory> objloginHistory = [select id,Userid,logintime,logintype,sourceip,loginurl,browser,platform,status,Application,clientversion,Apitype,Apiversion from loginhistory where userid= '005A0000000tP9g'];
        Database.BatchableContext BC;
        UpdateLoginHistory iploginHis = new UpdateLoginHistory();
        iploginHis.query = 'select id from loginhistory limit 10';
        iploginHis.start(BC);
        iploginHis.execute(BC,objloginHistory);
    /*Test.StartTest();    
        ID batchprocessid = Database.executeBatch(iploginHis);
        System.debug('***batchprocessid***'+batchprocessid);
        iploginHis.finish(BC);
    Test.StopTest(); */    
    }    
    }