@isTest
private class batchUsrUpdate_Test {

    public static testmethod void test() {       
        Test.startTest();
        batchUsrUpdate b = new batchUsrUpdate();
       // batchUsrUpdate b = new batchUsrUpdate(5);
        ID batchprocessid = Database.executeBatch(b,50);     
        Test.stopTest();
    }
    @isTest(SeeAllData=true)
    public static void test2(){
        User usr = [SELECT Id, Name,GE_HQ_SSO_ID__c,State, City, Email, GE_DS_Country__c,PostalCode FROM User WHERE isActive = true AND GE_Is_ServiceMax_User__c = true LIMIT 1 ];
        Test.startTest();
        batchUsrUpdate b;
       // b.query = 'SELECT Id, Name, GE_HQ_SSO_ID__c, City, Email, PostalCode, State, GE_DS_Country__c FROM User WHERE Id IN: usr.Id LIMIT 1';
        b = new batchUsrUpdate(1);
        ID batchprocessid = Database.executeBatch(b,50); 
        Test.stopTest();
    }
    public static testmethod void test3() {
        User usr = [SELECT Id, Name,GE_HQ_SSO_ID__c,State, City, Email, GE_DS_Country__c,PostalCode FROM User WHERE isActive = true AND GE_Is_ServiceMax_User__c = true LIMIT 1 ]; 
        Test.startTest();
        //batchUsrUpdate b = new batchUsrUpdate();
        //GE_OG_OHR_SSOData_Test.getTestResponse();
       // batchUsrUpdate b = new batchUsrUpdate(5);
       
       Test.setMock(HttpCalloutMock.class, new MockHttpResponseGeneratorOHR());
       //mhr.testWS();
       batchUsrUpdate b = new batchUsrUpdate();
        b.query = 'SELECT Id, Name, GE_HQ_SSO_ID__c, City, Email, PostalCode, State, GE_DS_Country__c FROM User WHERE GE_HQ_SSO_ID__c = \'212413527\' LIMIT 1';
        ID batchprocessid = Database.executeBatch(b,50);
        Test.stopTest();
    }
}