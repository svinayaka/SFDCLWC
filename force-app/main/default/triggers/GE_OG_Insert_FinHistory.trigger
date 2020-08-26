/*           
  Trigger Name : GE_OG_Insert_FinHistory
  Purpose/Overview :  Used to update the Finance status  on Account and Insert the Finance History.
  Functional Area : Account & Contact 
  Author: Malemleima Chanu // added a  boolean isupdateable  // 1/23/2014
  Created Date: 
  Test Class Name :  
 */

  trigger GE_OG_Insert_FinHistory on GE_OG_Finance_Details__c (after insert , after update) {
  
  //code added by rahul maurya
  if(ClsAvoidTriggerRecursion.Var_Static_ManageFinanceDetailTrgr == false)
    return;
  else
      ClsAvoidTriggerRecursion.Var_Static_ManageFinanceDetailTrgr = true;
      
  List<GE_OG_Fin_Histry__c> finhistory = new List<GE_OG_Fin_Histry__c>();
  Set<Id> financeDetailIds = new Set<Id>();
  Map<Id, Account> accToBeupdated = new Map<Id, Account>();
  boolean isupdateable = false;
 
 
 for( GE_OG_Finance_Details__c fin :Trigger.new){
     if(fin.GE_OG_Finance_Status__c !='Finance Not Applicable'){
         financeDetailIds.add(fin.id);  } 
         }

 if(Trigger.isupdate){
 for(GE_OG_Finance_Details__c newFinance: Trigger.new){   
  
   String riskscore = Trigger.oldMap.get(newFinance.id).GE_HQ_Finance_Risk_Score__c;
   String creditlimit = Trigger.oldMap.get(newFinance.id).GE_OG_Finance_Credit_Limit__c;
   String financetc = Trigger.oldMap.get(newFinance.id).GE_OG_Finan_TC__c;
   String actualfin = Trigger.oldMap.get(newFinance.id).GE_OG_Actual__c; 
   String status = Trigger.oldMap.get(newFinance.id).GE_OG_Finance_Status__c;
   String newstatus = Trigger.newMap.get(newFinance.id).GE_OG_Finance_Status__c;
   
   if ( status != newstatus )
   {
   GE_OG_Fin_Histry__c finhst=new GE_OG_Fin_Histry__c();                     
   finhst.GE_OG_Fin_RiskScore__c = riskscore;
   finhst.GE_OG_Fin_CredLmt__c = creditlimit; 
   finhst.GE_OG_Fin_T_C_s__c = financetc;
   finhst.GE_OG_ActualHst__c = actualfin;
   finhst.GE_OG_FinHist_status__c = newstatus;
   finhst.GE_OG_Finance_Details__c = newFinance.Id;
   finhst.Name = newFinance.Name;
   isupdateable = true;
   finhistory.add(finhst);
  
      }          
   } 
   
    Map<id,GE_OG_Finance_Details__c> accountToFinanceMap = new Map<id,GE_OG_Finance_Details__c>();
    List <GE_OG_Finance_Details__c> financeDetailList = new List<GE_OG_Finance_Details__c>([select Id,Name,GE_OG_Finance_Status__c,GE_OG_Account__c,GE_OG_Account__r.GE_OG_AccFin_Status__c from GE_OG_Finance_Details__c where Id IN :financeDetailIds]); 

   for(GE_OG_Finance_Details__c fd :financeDetailList){
            system.debug('Account currentstatus:----'+fd.GE_OG_Account__r.GE_OG_AccFin_Status__c);
            if(fd.GE_OG_Finance_Status__c != fd.GE_OG_Account__r.GE_OG_AccFin_Status__c  ){               
               accountToFinanceMap.put(fd.GE_OG_Account__c,fd);
          }
       
     // List<Account> accToBeupdated = new List<Account>();
      for(Account a :[Select id,GE_OG_AccFin_Status__c from Account where id in:accountToFinanceMap.keySet()]){
      GE_OG_Finance_Details__c f = accountToFinanceMap.get(a.id);
      a.GE_OG_AccFin_Status__c = f.GE_OG_Finance_Status__c;
    //a.GE_OG_KYC_Outbound_Resp__c = f.GE_OG_KYC__r.KYC_Outbound_Response__c;
      isupdateable = true;
      accToBeupdated.put(a.id, a); }
      }
 }
     // ******************** Added for the Finance Not Applicable ************************ 
   /* if(Trigger.isinsert){
      Map<id,GE_OG_Finance_Details__c> accToFinanceMap = new Map<id,GE_OG_Finance_Details__c>();
      List <GE_OG_Finance_Details__c> fininsertList = new List<GE_OG_Finance_Details__c>([select Id,Name,GE_OG_Finance_Status__c,GE_OG_Account__c,GE_OG_Account__r.GE_OG_AccFin_Status__c from GE_OG_Finance_Details__c where Id IN :financeDetailIds]); 

      for(GE_OG_Finance_Details__c fd :fininsertList){
            system.debug('Account currentstatus:----'+fd.GE_OG_Account__r.GE_OG_AccFin_Status__c);
            if((fd.GE_OG_Finance_Status__c != fd.GE_OG_Account__r.GE_OG_AccFin_Status__c) && fd.GE_OG_Finance_Status__c == 'Finance Not Applicable' ){               
               accToFinanceMap.put(fd.GE_OG_Account__c,fd);
          }
       
     
      for(Account a :[Select id,GE_OG_AccFin_Status__c from Account where id in:accToFinanceMap.keySet()]){
      GE_OG_Finance_Details__c f = accToFinanceMap.get(a.id);
      a.GE_OG_AccFin_Status__c = 'Finance Not Applicable' ;
      accToBeupdated.add(a); }
      }
    } */


List<Account> accToBeupdate = new list<Account>();

for(Id accId : accToBeupdated.Keyset()){
    accToBeupdate.add(accToBeupdated.get(accId));
}


 if(isupdateable){
 insert finhistory;
     update accToBeupdate;
    }
 
  }