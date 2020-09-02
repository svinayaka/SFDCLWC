@isTest
public class test_SWIBScheduleBatch{
static  testMethod void test_SubseaIBClassToBeScheduled() {
        
        Test.startTest();
        
   
       
          SWIBScheduleBatch c111 = new SWIBScheduleBatch();
    
     
     
       
    
    String sch = '20 30 8 10 2 ?'; 
    
   system.schedule('Subsea IB Class To Be Scheduled', sch, c111);
  // ID batchprocessid = 
 // Database.executeBatch(c111,200);
 SchedulableContext ctx;
 c111.execute(ctx);
    
      Test.stopTest();

    }
    }