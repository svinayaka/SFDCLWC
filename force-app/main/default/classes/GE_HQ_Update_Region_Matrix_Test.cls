@isTest
private class GE_HQ_Update_Region_Matrix_Test {
 public static testMethod void testSuccess()
  {
      test.startTest();
     date myDate = date.today();    
     date newDate1 = mydate.addYears(3);
     date newDate2 = mydate.addYears(5); 
    // Date myDate =  date.newinstance(2011, 10, 19);
    // Date myDate1 =  date.newinstance(2011, 10, 30);
     // Create country record . 
     GE_HQ_Country__c Country = new GE_HQ_Country__c();
     Country.Name = 'CROAT';
     Country.GE_HQ_ISO_Code__c ='oo'; 
     insert Country;
     // Create Tier0
     // GE_HQ_Tier0__c Tier = new GE_HQ_Tier0__c();
     // Tier.Name='GE Energy2';
     // Tier.GE_HQ_PL_ID__c=2;
     // insert Tier;
     // create Region ..
      GE_HQ_Region__c  Reg = new GE_HQ_Region__c();
          Reg.Name ='Africa';
          //Reg.GE_HQ_Region_ID__c=161;
          // Reg.GE_HQ_Tier0__c=Tier.Id;
          insert Reg;
          
         GE_HQ_Reg_Matrix__c RegMat = new GE_HQ_Reg_Matrix__c();
         RegMat.GE_HQ_Country__c=Country.Id;
         RegMat.GE_HQ_Eff_Dt__c=myDate;
         RegMat.GE_HQ_Exp_Dt__c=newDate2;
         RegMat.GE_HQ_Region__c=reg.Id;
         RegMat.GE_HQ_Status__c='Pending';
         insert RegMat;
         RegMat.GE_HQ_Status__c='Pending';
         RegMat.GE_HQ_Exp_Dt__c=newDate2;
        update RegMat;
         
          GE_HQ_Update_Region_Matrix batchProcess=new GE_HQ_Update_Region_Matrix();
        Database.executeBatch(batchProcess); 
    
    test.stopTest();
  }
   public static testmethod void test1()
   {
       Test.startTest();
       GE_HQ_Schedule_Update_Region_Matrix b = new GE_HQ_Schedule_Update_Region_Matrix();
        Datetime dt = Datetime.now().addMinutes(1);
        String sch = '0 '+dt.minute()+' * '+dt.day()+' '+dt.month()+' '+' ? '+dt.year();
        
       System.schedule('Schedule', sch, b);
       test.stoptest();
   }
}