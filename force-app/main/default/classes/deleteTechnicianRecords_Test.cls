@isTest

private class deleteTechnicianRecords_Test {


public static testmethod void test() {   

list<GE_OG_OHR_User_Data_Sync__c > scope= new list<GE_OG_OHR_User_Data_Sync__c >();    

     GE_OG_OHR_User_Data_Sync__c  ohrdata= new GE_OG_OHR_User_Data_Sync__c();
     ohrdata.GE_OG_Technician_Batch_Run_Date__c = Date.today();
     insert ohrdata;
 
 // GE_OG_OHR_User_Data_Sync__c  ohrdata1= new GE_OG_OHR_User_Data_Sync__c ();
     //    ohrdata1.id=ohrdata.id;
       //  ohrdata1.GE_OG_Technician_Batch_Run_Date__c = Date.today();
       //  delete ohrdata1;
          scope.add(ohrdata);

        Test.startTest();
       // deleteTechnicianRecords  d = new deleteTechnicianRecords();
       // batchUsrUpdate b = new batchUsrUpdate(5);
        deleteTechnicianRecords  objBatch = new deleteTechnicianRecords ();
        ID batchprocessid = Database.executeBatch(objBatch);
        database.batchableContext bc;
          objBatch.execute(bc,scope);
        Test.stopTest();
    }
    
    public static testmethod void test1() {       
        Test.startTest();
        deleteTechnicianRecords  d = new deleteTechnicianRecords();
       // batchUsrUpdate b = new batchUsrUpdate(5);
        ID batchprocessid = Database.executeBatch(d,50);     
        Test.stopTest();
    }


}