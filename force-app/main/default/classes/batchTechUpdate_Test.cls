@isTest
private class batchTechUpdate_Test{

    @isTest(SeeAllData=true)
    static void test() {
        // The query used by the batch job.
        //String query = 'SELECT Id, Name, GE_SM_HQ_SSO_ID__c, SVMXC__City__c, SVMXC__Email__c, SVMXC__Zip__c, SVMXC__State__c, SVMXC__Country__c,SVMXC__Street__c  FROM SVMXC__Service_Group_Members__c where GE_SM_HQ_SSO_ID__c!= null LIMIT 5 ';
        Test.startTest();
            batchTechnicianUpdate c = new batchTechnicianUpdate();
            //GE_OG_OHR_SSOData_Test.getTestResponse();
            Database.executeBatch(c);
            batchTechnicianUpdate c1 = new batchTechnicianUpdate(1);
            Database.executeBatch(c1);
        Test.stopTest();

        // Verify merchandise items got deleted 
        //Integer i = [SELECT COUNT() FROM Merchandise__c];
        //System.assertEquals(i, 0);
    }
    
    @isTest(SeeAllData=true)
    public static void test3() {
        
        Test.startTest();
            //batchTechnicianUpdate b = new batchTechnicianUpdate();
            Test.setMock(HttpCalloutMock.class, new MockHttpResponseGeneratorOHR());
            //GE_OG_OHR_SSOData_Test.getTestResponse();
            //GE_OG_OHR_SSOData_Test.testData();
            // batchTechnicianUpdate b = new batchTechnicianUpdate(5);
            batchTechnicianUpdate b = new batchTechnicianUpdate();
            //b.query = 'SELECT Id, Name, Id, Name, GE_SM_HQ_SSO_ID__c, SVMXC__City__c, SVMXC__Email__c, SVMXC__Zip__c, SVMXC__State__c, SVMXC__Country__c,SVMXC__Street__c  FROM SVMXC__Service_Group_Members__c where GE_SM_HQ_SSO_ID__c = \'502384249\' LIMIT 1';
            ID batchprocessid = Database.executeBatch(b,50);
        Test.stopTest();
    }
  
}