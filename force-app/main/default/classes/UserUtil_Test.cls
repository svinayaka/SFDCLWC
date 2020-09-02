/*
Class Name 			   : UserUtil
Used Where ?           : UserUtil_Test
Purpose/Overview       : code coverage for UserUtil class.
Scrum Team             : Transformation - OPPTY MGMT
Requirement Number     : R-32605.
Author                 : Harsha C
Created Date           : 24/AUG/2019
Test Class Name        : UserUtil_Test
Code Coverage          : 93%
*/
@isTest
public class UserUtil_Test {
  public static testMethod void userUtilTest(){
      Test.startTest();
      Id userId = UserInfo.getUserId();  
      User u = UserUtil.getUser(userId); 
      test.stopTest();
  }
     public static testMethod void userUtilTest2(){
      Test.startTest();
      User u = UserUtil.CurrentUser; 
      test.stopTest();
  }
}