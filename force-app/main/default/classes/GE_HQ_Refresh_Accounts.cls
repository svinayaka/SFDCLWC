/*
Class Name        : GE_HQ_Refresh_Accounts 
Purpose/Overview  : Inserting all the child Accounts in Junction Object
Author            : Lakshmi Prasanna Kethu
Test Class        : GE_HQ_Refresh_Accounts_Test
*/

public class GE_HQ_Refresh_Accounts {

 
    String AccPlanDDUNS;
    GE_HQ_Account_Plan__c AccPlanRec;
    
    public GE_HQ_Refresh_Accounts(){}
    
    public GE_HQ_Refresh_Accounts(ApexPages.StandardController controller){
        AccPlanRec = [Select Id, GE_HQ_DDUNS_Number__c, GE_HQ_DDUNS_Number__r.GE_HQ_DUNS_Number__c  from GE_HQ_Account_Plan__c where Id=:ApexPages.currentPage().getParameters().get('Id')];
        AccPlanDDUNS = AccPlanRec.GE_HQ_DDUNS_Number__r.GE_HQ_DUNS_Number__c;
    }
    
    public PageReference RefreshAccts(){
    
        if(AccPlanDDUNS!=null && AccPlanDDUNS!=''){
        
            // Preparing list of Account Plans        
            List<GE_HQ_Account_Plan__c> AccPlanList = new List<GE_HQ_Account_Plan__c>();
            AccPlanList.add(AccPlanRec);
        
            //deleting existing child accounts under given Account Plan        
            List<GE_HQ_Acc_AccPlan_Rel__c> deleteJORecords = deleteJunctionRecords(AccPlanList);
            System.debug('deleteJORecords size::'+deleteJORecords.size()+deleteJORecords);
            if(deleteJORecords.size()>0)
                delete deleteJORecords;
            
            //Preparing child accunts for given Account Plan
            List<GE_HQ_Acc_AccPlan_Rel__c> JOInsertList = getJunctionRecords(AccPlanList);
            System.debug('JOInsertList size::'+JOInsertList.size()+JOInsertList);
            if(JOInsertList.size()>0)
                insert JOInsertList;
               
        }
        PageReference AccPlanPage = new ApexPages.StandardController(AccPlanRec).view();
        AccPlanPage.setRedirect(true);
        return AccPlanPage;
    }

    
    public List<GE_HQ_Acc_AccPlan_Rel__c> deleteJunctionRecords(List<GE_HQ_Account_Plan__c> AccPlanList){

        List<GE_HQ_Acc_AccPlan_Rel__c> deleteRecList = new list<GE_HQ_Acc_AccPlan_Rel__c>();
        deleteRecList = [Select id from GE_HQ_Acc_AccPlan_Rel__c where GE_HQ_Account_Plan__c IN :AccPlanList];
        return deleteRecList;

    }
    
    public List<GE_HQ_Acc_AccPlan_Rel__c> getJunctionRecords(List<GE_HQ_Account_Plan__c> AccPlanList){
    
        if(AccPlanList!=Null && AccPlanList.size()>0){
        
            map<String, GE_HQ_Account_Plan__c> AccPlanMap = new map<String, GE_HQ_Account_Plan__c>();
            Set<String> AccPlanDUNS = new Set<String>();
            
            system.debug('Line No:50 >>-> '+AccPlanList.size());
            
            for(GE_HQ_Account_Plan__c AccPlan : AccPlanList){
                if(AccPlan.GE_HQ_DDUNS_Number__r.GE_HQ_DUNS_Number__c!=null && AccPlan.GE_HQ_DDUNS_Number__r.GE_HQ_DUNS_Number__c!=''){
                    AccPlanDUNS.add(AccPlan.GE_HQ_DDUNS_Number__r.GE_HQ_DUNS_Number__c);
                    AccPlanMap.put(AccPlan.GE_HQ_DDUNS_Number__r.GE_HQ_DUNS_Number__c, AccPlan);
                }
            }
            
            RecordType rt = [SELECT Id FROM RecordType WHERE SobjectType='Account' and Name='CMF Approved'];
            
            list<Account> AccList = new list<Account>([Select Id,GE_HQ_GE_GLOBAL_DUNS__c from Account where GE_HQ_GE_GLOBAL_DUNS__c IN :AccPlanDUNS
                                                        And GE_HQ_DUNS_Number__c NOT IN :AccPlanDUNS and RecordTypeId=:rt.Id AND GE_HQ_Watchlist_Flag__c <> 'Y' AND GE_HQ_Sanctioned_Country_Flag__c <> 'Y']);
            
            list<GE_HQ_Acc_AccPlan_Rel__c> InsertList = new list<GE_HQ_Acc_AccPlan_Rel__c>();
            System.debug('AccList========='+AccList.size());
            for(Account acc: AccList){
                Id AccPlanId = AccPlanMap.get(acc.GE_HQ_GE_GLOBAL_DUNS__c).Id;
               // System.debug('Id========='+acc.Id);
                InsertList.add(new GE_HQ_Acc_AccPlan_Rel__c(GE_HQ_Account__c=acc.Id, GE_HQ_Account_Plan__c=AccPlanId, GE_HQ_Acc_Type__c='Account Plan'));
               // if(InsertList.size() > 1)
               // {break;}
            }
            System.debug('InsertList=========='+InsertList);
            return InsertList;
        }
        return new List<GE_HQ_Acc_AccPlan_Rel__c>();
    }
}