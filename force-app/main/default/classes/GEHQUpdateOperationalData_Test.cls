/*    
Class Name        : GEHQUpdateOperationalData_Test
Purpose/Overview  : For code coverage of Trigger GEHQUpdateOperationalData 
Author            : Rekha N
Change History    : Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
                              
*/

@isTest
private class GEHQUpdateOperationalData_Test {
     static testMethod void GEHQUpdateOperationalData_Test() {     
       
               //creating Account
               Account Acc = new Account();
               Acc.Name = 'Account for OP Data';
               Acc.Recordtypeid = [select id,name from recordtype where name like 'CMF Approved' AND SobjectType = 'Account' ].id; 
               Acc.GE_HQ_Nts_Comments__c = 'Test Trigger';            
               insert Acc;            
               
               
               //Creating IB
               Id IBId = [Select id from Recordtype where sObjectType = 'GE_Installed_Base__c' and name = 'Gasification' limit 1][0].id;
               GE_Installed_Base__c ib1= new GE_Installed_Base__c(Name ='Test999',RecordTypeId=IBId,Account__c= Acc.Id );
               insert ib1;
     
               // Creating Opeartional Data
               GE_HQ_Operational_Data__c OP = new GE_HQ_Operational_Data__c();
               OP.GE_S_N_Equip_Name__c = ib1.Id;
               OP.GE_HQ_LCV_Hrs__c=13;
               OP.GE_HQ_LCV_Strts__c =12;
               OP.GE_HQ_LCV_Trps__c =13;
              
               
               Test.startTest();               
               insert OP;                
               Test.stopTest();      
            
                           
     }  
}