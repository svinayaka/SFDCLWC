/*
Class Name      : GE_OG_trg_NumOFContactsforEmailid
Purpose/Overview  : Close all tasks when case has closed.
Author            : CaseTeam
Created Date      : 
Test Class        : GE_NumOFContactsforEmailid_Test
*/

/*
S.NO         MethodName                                         operation
1.           numOFContactsforEmailidInsertion        beforeInsert
2.           numOFContactsforEmailidUpdate           beforeupdate
3.           webEmailidInsertionUpdation             beforeupdate,beforeinsert
*/



public class GE_OG_trg_Case_NumOFContactsforEmailid
{

/*
  this method is for 'beforeInsert'
  Modified from Trigger:GE_NumOFContactsforEmailid
  
*/

public void numOFContactsforEmailidInsertion(List<case>  newcaseList)
{
System.debug('caseList is------'+newcaseList);
List<Case>  newcaseList1= (List<Case>)newcaseList;
Decimal McsTimecalc;
/*
//System.debug('vvvvvv-------'+GE_OG_MCS_TotalTimecalculation__c.getValues('calculationtime'));
GE_OG_MCS_TotalTimecalculation__c mcsTime= [select id, name from GE_OG_MCS_TotalTimecalculation__c];
//GE_OG_MCS_TotalTimecalculation__c  mcsTime = GE_OG_MCS_TotalTimecalculation__c.getValues('calculationtime');


 
// System.debug('mcsTime-----'+mcsTime);
 
if(mcsTime.calculation__c!=null )

{

System.debug('mcsTime-------'+mcsTime);
System.debug('mcsTime-------'+mcsTime.calculation__c);
 McsTimecalc = mcsTime.calculation__c;
}
McsTimecalc = 0.0;
List<Case> cc = New List<Case>();
List<Case> openCase = New List<Case>(); 
System.debug('newCaseList1-------------'+newcaseList1);
    for(Case c: newcaseList1){ 
    
     if(c.status == 'open' && c.mcs_opentoclosedcalc__c == false){
           McsTimecalc = 0.00;
           c.clsoedfld__c = McsTimecalc;       
           OpenCase.add(c);
           }
    
    }
   
 if(openCase.size() > 0){
          mcsTime.calculation__c = 0.00;
           upsert mcsTime;
           } 
      

   
*/

}


/*
  this method is for 'beforeupdate'
  Modified from Trigger:GE_NumOFContactsforEmailid
  
*/

public void numOFContactsforEmailidUpdate(List<case>  newcaseList,Map<Id,Case>  oldMapCase)
{

      /*    List<Case>  newcaseList1= (List<Case>)newcaseList;
         Map<Id,Case>  oldMapCase1=(Map<Id,Case>)oldMapCase;
        GE_OG_MCS_TotalTimecalculation__c  mcsTime = GE_OG_MCS_TotalTimecalculation__c.getValues('calculationtime'); 
        Decimal McsTimecalc = mcsTime.calculation__c;
       List<Case> cc = New List<Case>();
     List<Case> openCase = New List<Case>(); 

 
    for(Case c: newcaseList1){         
      if( oldMapCase1.get(c.id).Status =='closed' && c.status == 'open'){   
                    
          McsTimecalc +=  oldMapCase1.get(c.id).closedtoopenlatest__c;
          
          c.clsoedfld__c = McsTimecalc;
         
           cc.add(c);
          }
          
              if(c.status== 'closed' ){
          c.mcs_opentoclosedcalc__c = true;
         // c.statusclosed__c =  c.MCS_SubstatusCurrntAge__c;   
   
      }   
    
    }
        
  
      if(cc.size()>0){
          mcsTime.calculation__c = McsTimecalc;
          
          upsert mcsTime;
          
         }


*/
   
  }
  
  /*
  this method is for 'beforeupdate','beforeinsert'
  Modified from Trigger:GE_NumOFContactsforEmailid
  
*/

public void webEmailidInsertionUpdation(List<case>  newcaseList)
{
List<Case>  newcaseList1= (List<Case>)newcaseList;
Set<String> webEmails = new Set<String>();
   integer count=0;
 for(Case caseRec: newcaseList1){
    if(caseRec.SuppliedEmail != null){
        webEmails.add(caseRec.SuppliedEmail);
    }
 }
 Map<String, Integer> contactCount = new Map<String, Integer>();
 if(webEmails.size()>0){
 for(Contact conRec: [Select Id, Email from Contact where Email IN :webEmails]){
    if(contactCount.get(conRec.Email) != null){
         count = contactCount.get(conRec.Email);
        contactCount.put(conRec.Email, count+1);
                system.debug('*******************'+contactCount);
    }else{
        contactCount.put(conRec.Email, 1);
         system.debug('*******************'+contactCount);
    }
 }
 
 for(Case caseRec: newcaseList1){
    if(contactCount.get(caseRec.SuppliedEmail) != null){
        caseRec.GE_Of_Contacts__c = contactCount.get(caseRec.SuppliedEmail);
         system.debug('*******************'+contactCount);
    }else {
   caseRec.GE_Of_Contacts__c = 0;
    }
 }
  
  }
  }

}