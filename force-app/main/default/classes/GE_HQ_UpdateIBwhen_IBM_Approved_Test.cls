/*    
Class Name        : GE_HQ_UpdateIBwhen_IBM_Approved_Test
Purpose/Overview  : For coverage of Class GE_HQ_UpdateIBwhen_IBM_Approved 
Author            : Rekha N
Change History    : Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
                  : 
              
*/
@isTest
public class GE_HQ_UpdateIBwhen_IBM_Approved_Test {

   static testMethod void GE_HQ_UpdateIBwhen_IBM_Approved_Test1() {
   try{
     GE_ES_CustomerGalaxyIntegrationWrapper.isFromTest  = true;
     List<User> usrObj=[select Id,Name,isActive,Profile.Name from User where Profile.Name like '%System Administrator%' and isActive=true];          
        if(usrObj!=null && usrObj.size()>0){
           System.runAs(usrObj[0]){ 
              
               //creating Account
               Account Acc = new Account();
               Acc.Name = 'Account for IBM Approved';
               Acc.Recordtypeid = [select id,name from recordtype where name like 'CMF Approved' AND SobjectType = 'Account' ].id; 
               Acc.GE_HQ_Nts_Comments__c = 'Test Trigger';            
               insert Acc;            
               
               // Geting User Recs
               User[] u = [select id,name from user where name = 'Elisa Ciliberti' or Name = 'Bryan Butler' limit 2];
         
               //Creating IB
               Id IBId = [Select id from Recordtype where sObjectType = 'GE_Installed_Base__c' and name = 'Gasification' limit 1][0].id;
               GE_Installed_Base__c ib1= new GE_Installed_Base__c(Name ='Test999',RecordTypeId=IBId,Account__c= Acc.Id,GE_ES_Sales_Channel__c ='ARGO',GE_ES_Account_Manager__c = u[0].id );
               insert ib1;
     
               // Creating IBM
               GE_HQ_IB_Mod_Request__c ibm1 = new GE_HQ_IB_Mod_Request__c();
               ibm1.GE_HQ_Installed_Base__c = ib1.Id;
               ibm1.GE_HQ_Sales_Chnl__c='Energy Services Sales';
               ibm1.GE_HQ_Status__c ='New';
               ibm1.GE_HQ_Sales_Mgr__c=u[0].id ;
               
               Test.startTest();               
               insert ibm1;  
               ibm1.GE_HQ_Status__c ='Approved';  
               upsert ibm1;   
           
              Test.stopTest();                
            }
         }  }catch(Exception ex){}                
      }  
//// for update.........
 
  static testMethod void test2(){  
        GE_ES_CustomerGalaxyIntegrationWrapper.isFromTest  = true;
         
        List<User> usrObj=[select Id,Name,isActive,Profile.Name from User where Profile.Name like '%System Administrator%' and isActive=true];          
        if(usrObj!=null && usrObj.size()>0){
          System.runAs(usrObj[0]){     
          Test.startTest();
          Test.stopTest();                
          }
       }                
  }
}