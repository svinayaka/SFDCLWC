@isTest(SeeAllData=true)
public class GE_OG_WOTotalLaborAmount_Test
{
  public  static  testmethod void testrate(){
       test.starttest();
        //New Location
              SVMXC__Site__c loc = new SVMXC__Site__c();
              loc.Name='Test Location'+system.now();
              loc.GE_AL_Well_Type__c='Drilling';
              insert loc;
         //Account Data Helper
              Account acc= [Select id, Name, GE_HQ_DUNS_Number__c from Account where GE_HQ_Request_Status__c='CMF Approved' LIMIT 1];
       //New Case              
              Id recTypeID= Schema.SObjectType.Case.getRecordTypeInfosByName().get('FS-D&S').getRecordTypeId();// FS-DS
              Case retCs = new Case();
             // retCs.Account=acc.ID;
              retCs.GE_PC_Ship_to_Account__c=acc.ID;
              retCs.GE_OG_DS_Region__c= 'NAM';
              retCs.GE_PC_Branch__c = 'NAM';
              retCs.GE_DS_Amount_Invoiced__c = 32424;
              retCs.SVMXC__Billing_Type__c ='Commissioning';
              retCs.GE_PW_PO__c ='PO000';
              retCs.Description='test case';
              retCs.GE_ES_Sub_Type__c='Re certification';
              retCs.RecordTypeId= recTypeID;
              insert retCs;
        
              
             Id recTypeID1= Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('D&S').getRecordTypeId();// FS-DS
               
              //New Work Order                          
              SVMXC__Service_Order__c woObj = new SVMXC__Service_Order__c();   
              woObj.SVMXC__Site__c=loc.ID;
              woObj.SVMXC__Case__c = retCs.Id;
              woObj.SVMXC__Order_Status__c = 'Open';
              woObj.GE_PC_Branch__c = 'Fairfield';
              woObj.SVMXC__Company__c = acc.ID;
              woObj.GE_PC_Ship_to_Account__c = acc.ID;
              woObj.SVMXC__Street__c = 'Test Street';
              woObj.SVMXC__City__c = 'Test City';
              woObj.SVMXC__State__c = 'Test State';
              woObj.SVMXC__Zip__c = '77041';
              woObj.SVMXC__Country__c = 'United States';
              woObj.GE_PC_Phone_Number__c = '18324761123';
              woObj.SVMXC__Work_Performed__c = 'Test';     
              woObj.GE_SS_Customer_PO_number__c = '5555';
              woObj.GE_DS_Daily_Rate__c =1000;
              woObj.GE_DS_Overtime__c =100;
              woObj.RecordTypeId=recTypeID1;
              insert woObj;
             
               
              //New Part
              Product2 prod = new Product2();
              prod.Name  = 'FsoTypeAttach';
              prod.ProductCode = '1234';
              prod.GE_ES_P_L__c = 'D&S - PC';
              insert prod;
              Product2 retProd = [Select id, Name, ProductCode, GE_ES_P_L__c FROM Product2 WHERE id=:prod.Id ];
              System.debug('Product-->'+retProd);
              
               
              //New Work Detail
              SVMXC__Service_Order_Line__c wodet = new SVMXC__Service_Order_Line__c();
              wodet.SVMXC__Line_Type__c  = 'Expenses';
              wodet.SVMXC__Product__c = retProd.Id;
              wodet.SVMXC__Actual_Quantity2__c = 10.00;
              wodet.SVMXC__Actual_Price2__c = 12.50;
              wodet.SVMXC__Line_Status__c = 'Open';
              wodet.SVMXC__Billable_Line_Price__c = 400;
              wodet.SVMXC__Start_Date_and_Time__c = Datetime.newInstance(system.today().year(), system.today().month(), system.today().day() - 1, 1, 0, 0);
              wodet.SVMXC__End_Date_and_Time__c = Datetime.newInstance(system.today().year(), system.today().month(), system.today().day() + 1, 1, 0, 0);
              wodet.SVMXC__Service_Order__c = woObj.Id;
              insert wodet;
             
              
          
              //New Work Detail
              SVMXC__Service_Order_Line__c wodet1 = new SVMXC__Service_Order_Line__c();
              wodet1.SVMXC__Line_Type__c  = 'Labor';
              wodet1.SVMXC__Line_Status__c = 'Open';
              wodet1.SVMXC__Activity_Type__c =' Install/Replace';
              wodet1.GE_DS_Onshore_offshore__c ='Onshore';            
             wodet1.GE_AL_MFL_Extended_Price_Labor__c=1000;
             Datetime startDate = system.now();// Start date
            Datetime endDate = system.now().addHours(60);//End Date
              wodet1.SVMXC__Start_Date_and_Time__c = startDate;
              wodet1.SVMXC__End_Date_and_Time__c = endDate;
                            
            integer intDays =  startDate.Date().daysBetween(endDate.Date());
            datetime sameDayEndDate = startDate.addDays(intDays);
                            
            Decimal decHours = ((endDate.getTime())/1000/60/60) - ((sameDayEndDate.getTime())/1000/60/60);
            wodet1.SVMXC__Billable_Quantity__c =decHours;

             
              wodet1.GE_DS_Non_Billable_Hours__c=0;
              wodet1.GE_DS_Overtime_Hrs__c=0;
              wodet1.SVMXC__Service_Order__c = woObj.Id;
              insert wodet1;
                      
              woObj.SVMXC__Order_Status__c='Work Complete';
              woObj.GE_DS_Daily_Rate__c =1500;
              woObj.GE_DS_Overtime__c =80;
              update woObj;
                         
                test.stopTest();
           }
}