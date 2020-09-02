public class ReparentingRequestTriggerHandler
{
    public static void handleAfterUpdate(List<Re_Parenting_LE_Request__c> reParentingList)
    {
        List<Id> oldHQ = new List<Id>();
        List<Id> oldCommAcc = new List<Id>();
        List<Id> newHQ = new List<Id>();
        List<Id> newCommAcc = new List<Id>();
        List<Id> accountIds = new List<Id>();
        List<Contract> updateList = new List<Contract>();
        Id adendumdRecordTypeId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('PRM Addendum').getRecordTypeId();
        Id ammendRecordTypeId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('PRM Amendment').getRecordTypeId();
        Id masterRecordTypeId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('PRM Master Agreement').getRecordTypeId();
        
        for(Re_Parenting_LE_Request__c rep : [Select Id,Old_Parent_Account__c,Legal_Entity__c,Old_Parent_Account__r.Member_of_GE_OG__c,New_Parent_Account__c,New_Parent_Account__r.Member_of_GE_OG__c,Request_Status__c From Re_Parenting_LE_Request__c Where Id IN: reParentingList])
        {
            //oldParentList.add(rep.Old_Parent_Account__c);
            //newParentList.add(rep.New_Parent_Account__c);
            if(rep.Request_Status__c == 'Completed')
            {
                if(rep.Old_Parent_Account__c != null)
                {
                    if(rep.Old_Parent_Account__r.Member_of_GE_OG__c != null)
                    {
                        oldHQ.add(rep.Old_Parent_Account__r.Member_of_GE_OG__c);
                    }
                    else
                    {
                        oldCommAcc.add(rep.Old_Parent_Account__c);
                    }
                }
                if(rep.New_Parent_Account__c != null)
                {
                    if(rep.New_Parent_Account__r.Member_of_GE_OG__c != null)
                    {
                        newHQ.add(rep.New_Parent_Account__r.Member_of_GE_OG__c);
                    }
                    else
                    {
                        newCommAcc.add(rep.New_Parent_Account__c);
                    }
                }
                
                accountIds.add(rep.Legal_Entity__c);
            }
            
        }
        if(!oldHQ.isEmpty())
        {
            handleExecutedContractsForHQ(oldHQ);
        }
        if(!newHQ.isEmpty())
        {
            handleExecutedContractsForHQ(newHQ);
        }
        if(!oldCommAcc.isEmpty())
        {
            handleExecutedContractsForCommAcc(oldCommAcc);
        }
        if(!newCommAcc.isEmpty())
        {
            handleExecutedContractsForCommAcc(newCommAcc);
        }
        
        if(!accountIds.isEmpty())
        {
            for(Contract con : [Select Id,AccountId,GE_Commercial_Member_Of_GE_OG__c,GE_PRM_Commercial_Account__c,RecordTypeId From Contract Where AccountId IN: accountIds])
            {
                if(con.RecordTypeId == adendumdRecordTypeId || con.RecordTypeId == masterRecordTypeId || con.RecordTypeId == ammendRecordTypeId)
                {
                    updateList.add(con);
                }
            } 
        }
        
        update updateList;
        
    }
    
    private static void handleExecutedContractsForHQ(List<Id> HQAccountList)
    {   
        Id adendumdRecordTypeId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('PRM Addendum').getRecordTypeId();
        List<Contract> executedContracts = new List<Contract>();
        //Set<Id> HQAccountSet = new Set<Id>(HQAccountList);
        Set<Id> HQAccountExecutedSet = new Set<Id>();
        List<Account> updateAccountList = new List<Account>();
        
        executedContracts = [Select Id, GE_Commercial_Member_Of_GE_OG__c, Status, Status_GE_OG__c From Contract Where RecordTypeId =:adendumdRecordTypeId AND Status = 'Executed' AND GE_Commercial_Member_Of_GE_OG__c IN : HQAccountList];
        
        if(!executedContracts.isEmpty())
        {
            for(Contract con : executedContracts)
            {
                HQAccountExecutedSet.add(con.GE_Commercial_Member_Of_GE_OG__c);
            }
        }
        
        if(!HQAccountExecutedSet.isEmpty())
        {
            for(Account acc : [Select Id, Active_Channel_Partner__c, Classification__c, Type From Account Where Id IN :HQAccountExecutedSet AND (Classification__c != 'Key Account'  OR Classification__c !='Strategic')])
            {
                acc.Active_Channel_Partner__c = true;
                acc.Type = 'Channel Partner';
                updateAccountList.add(acc);
                
            }
        }
    
    
     return;
    
    }
    
    private static void handleExecutedContractsForCommAcc(List<Id> CommAccountList)
    {   
        Id adendumdRecordTypeId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('PRM Addendum').getRecordTypeId();
        List<Contract> executedContracts = new List<Contract>();
        //Set<Id> HQAccountSet = new Set<Id>(HQAccountList);
        Set<Id> commAccountExecutedSet = new Set<Id>();
        List<Account> updateAccountList = new List<Account>();
        
        executedContracts = [Select Id, GE_Commercial_Member_Of_GE_OG__c,GE_PRM_Commercial_Account__c, Status, Status_GE_OG__c From Contract Where RecordTypeId =:adendumdRecordTypeId AND Status = 'Executed' AND GE_PRM_Commercial_Account__c IN : CommAccountList];
        
        if(!executedContracts.isEmpty())
        {
            for(Contract con : executedContracts)
            {
                commAccountExecutedSet.add(con.GE_Commercial_Member_Of_GE_OG__c);
            }
        }
        
        if(!commAccountExecutedSet.isEmpty())
        {
            for(Account acc : [Select Id, Active_Channel_Partner__c, Classification__c, Type From Account Where Id IN :commAccountExecutedSet AND Classification__c != 'Key Account'  AND Classification__c !='Strategic'])
            {
                acc.Active_Channel_Partner__c = true;
                acc.Type = 'Channel Partner';
                updateAccountList.add(acc);
                
            }
        }
    
    
     return;
    
    }
    
    
}