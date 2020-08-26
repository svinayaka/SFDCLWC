/*           
 
Trigger Name : GE_OG_Update_FinanceUpdateStatus
Purpose/Overview :  Used to update the Finance status in Account object,Finance status on Finance and KYC
Functional Area : Account & Contact 
Author: Malemleima Chanu
Created Date: 5/30/2013
Test Class Name :  
 
 */
 
 trigger GE_OG_Update_FinanceUpdateStatus on Account(after update) {

//Code to skip trigger

    OG_Trigger_fire_Decision__c lstObj = OG_Trigger_fire_Decision__c.getValues('GE_OG_Update_FinanceUpdateStatus');
       
    if((lstObj!=null && lstObj.isActive__c == true && lstObj.Object_Name__c=='Account') || GEOG_SkipTriggerFromClass.Var_GE_OG_Update_FinanceUpdateStatus == True){
      
        return;  
    }
     else{

 Map<id,Account> accMap=new Map<id,Account>();
 List<GE_PRM_KYC_Termination_Checklist__c> kycList=new List<GE_PRM_KYC_Termination_Checklist__c>();

 for(Account acc :Trigger.new){
    
 if ((Trigger.newMap.get(acc.id).GE_OG_AccFin_Status__c != Trigger.oldMap.get(acc.id).GE_OG_AccFin_Status__c) || (Trigger.newMap.get(acc.id).GE_HQ_Request_Status__c != Trigger.oldMap.get(acc.id).GE_HQ_Request_Status__c))
  // if (Trigger.newMap.get(acc.id) != Trigger.oldMap.get(acc.id))    
      {
        accMap.put(acc.id,acc);
       }
      }
  System.Debug('*********Account Id***********:'+accmap);
 
   List<GE_OG_Finance_Details__c> finance = new List<GE_OG_Finance_Details__c>();
   List<GE_PRM_KYC_Termination_Checklist__c> kycListTobeUpdated=new List<GE_PRM_KYC_Termination_Checklist__c>(); 
  //------------- Start of the after update fucntionnality----------------- 
  boolean isupdateable = false;
 
 if(Trigger.isAfter){
 if(accMap.isEmpty()==false){
     
    List<GE_OG_Finance_Details__c> finstat= new List<GE_OG_Finance_Details__c>();
    
    
     finstat = [select Id,GE_OG_Resubmitted__c ,Name,GE_OG_KYC__r.GE_OG_Finance_checked__c,GE_OG_Finance_Status__c,GE_OG_Account__r.GE_HQ_Request_Status__c,GE_OG_KYC__r.GE_OG_Fin_Status__c,GE_OG_KYC__r.GE_PW_KYC_Type__c from GE_OG_Finance_Details__c where GE_OG_Account__r.Id  IN :accMap.keySet()];
    System.debug('finstat'+finstat);
  for ( GE_OG_Finance_Details__c fin : finstat)
     {
         
      System.Debug('*********Finance_Status__1***********:'+fin.GE_OG_Finance_Status__c);
      if((fin.GE_OG_Account__r.GE_HQ_Request_Status__c == 'New' || fin.GE_OG_Account__r.GE_HQ_Request_Status__c == 'Pending User Review')&& (fin.GE_OG_Finance_Status__c == 'Completed'|| fin.GE_OG_Finance_Status__c == 'Pending User Review - On Hold' ) )
      {// do nothing
      }
      
      else if((fin.GE_OG_Account__r.GE_HQ_Request_Status__c == 'New' || fin.GE_OG_Account__r.GE_HQ_Request_Status__c == 'Pending User Review')&&(fin.GE_OG_Finance_Status__c != 'Completed'|| fin.GE_OG_Finance_Status__c != 'Pending User Review - On Hold' || fin.GE_OG_Resubmitted__c == False ))
      {
       if((fin.GE_OG_Finance_Status__c != 'Pending Due Diligence') && (fin.GE_OG_Finance_Status__c != 'Finance Not Applicable') && (fin.GE_OG_Resubmitted__c == False) ){
       fin.GE_OG_Finance_Status__c = 'Pending Due Diligence';
       finance.add(fin);
       isupdateable = true;
       }
       
       }
       
       else if (( fin.GE_OG_Account__r.GE_HQ_Request_Status__c == 'Pending CMF' || fin.GE_OG_Account__r.GE_HQ_Request_Status__c == 'Submitted to CMF')&&(fin.GE_OG_Finance_Status__c == 'Completed'|| fin.GE_OG_Finance_Status__c == 'Pending User Review - On Hold' ))
       {//do nothing
       }
      
       else if (( fin.GE_OG_Account__r.GE_HQ_Request_Status__c == 'Pending CMF' || fin.GE_OG_Account__r.GE_HQ_Request_Status__c == 'Submitted to CMF')&&(fin.GE_OG_Finance_Status__c != 'Completed'|| fin.GE_OG_Finance_Status__c != 'Pending User Review - On Hold' || fin.GE_OG_Resubmitted__c == False )) 
       {
       
       if((fin.GE_OG_Finance_Status__c != 'Submitted')&&(fin.GE_OG_Finance_Status__c != 'Finance Not Applicable')&& (fin.GE_OG_Resubmitted__c == False)){
       fin.GE_OG_Finance_Status__c = 'Submitted';
       finance.add(fin);
       isupdateable = true;
       }
       }
     
     
       
       else if (fin.GE_OG_Account__r.GE_HQ_Request_Status__c == 'CMF Approved' && (fin.GE_OG_Finance_Status__c == 'Completed' || fin.GE_OG_Finance_Status__c == 'Pending User Review - On Hold')) {
           //do nothing
       }
       else if ( fin.GE_OG_Account__r.GE_HQ_Request_Status__c == 'CMF Approved' && (fin.GE_OG_Finance_Status__c != 'Completed' || fin.GE_OG_Finance_Status__c != 'Pending User Review - On Hold' || fin.GE_OG_Resubmitted__c == False)) 
       {
       if( (fin.GE_OG_Finance_Status__c != 'In Progress') && (fin.GE_OG_Finance_Status__c != 'Pending User Submission') && (fin.GE_OG_Finance_Status__c != 'Finance Not Applicable') && (fin.GE_OG_Resubmitted__c == False))
       fin.GE_OG_Finance_Status__c = 'In Progress';
       finance.add(fin);
       isupdateable = true;
       }       
       else{}
       
      System.Debug('*********Finance_Status__2***********:'+fin.GE_OG_Finance_Status__c);
      
     }
     } 
     }
     
      if(isupdateable){
      update finance ;
      }
      
    }  
     
  }