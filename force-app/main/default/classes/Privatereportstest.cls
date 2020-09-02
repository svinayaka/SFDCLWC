@isTest
public class Privatereportstest {

    @isTest static void testDeleteprivatereportsmethod(){
        Test.startTest();
       Private_Reports__c pvr = new Private_Reports__c();
        pvr.Report_ID__c='00OA0000004wGOsMAM';
        pvr.Report_Created_By__c='005A0000001z6rdIAA';
        insert pvr;
        privatereportsdelete pvrd = new privatereportsdelete();
        database.executeBatch(pvrd);
        Test.stopTest();
    
}
}