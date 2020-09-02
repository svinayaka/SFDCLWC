public class ReparentLegalEntity_PRM_GE_OG {




public static List<Sobject> reparent_PRM(Account newParentAccount, List<Contract> contractList)
{
    Id legalEntityId;
    Id oldMemberOfId;
    Id newMemberOfId;
    Boolean executedContract = false;
    Boolean noChannelContracts = false;
    Boolean executedContractOnOldHQ = false;
    List<Sobject> returnList = new List<Sobject>();
    Set<ID>chAppSet = new Set<ID>();
    legalEntityId = contractList[0].AccountId;
    newMemberOfId = newParentAccount.Member_of_GE_OG__c;
    List<Contract> oldHQAddendumContracts = new List<Contract>();
    List<Contract> oldHQExecutedAddendums = new List<Contract>();
    Account oldHqAccount;
    Id oldCommAccId;
    //ID MasterAgreementContract = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Channel Master Agreement').getRecordTypeId();
    for(Contract con : contractList)
    {
        
        
        
        if(con.Status == 'Executed' || con.Status =='Under Renewal' || con.Status =='Under NR/T')
        {
            
           // newParentAccountSet.add(con.AccountId);
           executedContract = true;
           oldMemberOfId = con.GE_Commercial_Member_Of_GE_OG__c;
           oldCommAccId = con.GE_PRM_Commercial_Account__c ;
           
           
        }
        
        con.GE_PRM_Commercial_Account__c = newParentAccount.Id;
        con.GE_Commercial_Member_Of_GE_OG__c = newMemberOfId;
        
        returnList.add(con);
        
    }
    
    for(GE_PRM_Channel_Appointment__c chApp : [Select Id,GE_PRM_Commercial_Account__c,GE_PRM_Account_Name__c From GE_PRM_Channel_Appointment__c Where GE_PRM_Account_Name__c =: legalEntityId])
    {
        chApp.GE_PRM_Commercial_Account__c = newParentAccount.Id;
        returnList.add(chApp);
    }
    
    if(executedContract)
    {
        if(newMemberOfId != null)
        {
            for(Account acc : [Select Id,Type,Classification__c,Active_Channel_Partner__c From Account Where Id =: newMemberOfId])
            {
                if(acc.Classification__c != 'Key Account' && acc.Classification__c != 'Strategic')
                {
                    acc.Type = 'Channel Partner';
                    acc.Active_Channel_Partner__c = true;
                    acc.Classification__c = 'Unclassified';
                    returnList.add(acc);
                }
            }
        }
        else
        {
            newParentAccount.Type = 'Channel Partner';
            newParentAccount.Active_Channel_Partner__c = true;
            newParentAccount.Classification__c = 'Unclassified';
            returnList.add(newParentAccount);
        }
        
        if(oldMemberOfId != null)
        {
            oldHQAddendumContracts = [Select Id, Status, RecordType.Name From Contract Where GE_Commercial_Member_Of_GE_OG__c =:oldMemberOfId AND (RecordType.Name = 'Channel Addendum Agreement' OR RecordType.Name = 'Channel Master Agreement')];
            oldHQExecutedAddendums = [Select Id, Status, RecordType.Name From Contract Where GE_Commercial_Member_Of_GE_OG__c =:oldMemberOfId AND RecordType.Name = 'Channel Addendum Agreement' AND Status = 'Executed'];
            oldHqAccount = [Select Id, Type, Classification__c,Active_Channel_Partner__c From Account Where Id =:oldMemberOfId];
        
        
        
        
        if(!oldHQAddendumContracts.isEmpty())
        {
            oldHqAccount.Type = 'Channel Partner';
            oldHqAccount.Classification__c = 'Unclassified';
            
            if(!oldHQExecutedAddendums.isEmpty())
            {
                oldHqAccount.Active_Channel_Partner__c = true;
            }
            
            returnList.add(oldHqAccount);
        }
        else
        {
            oldHqAccount.Type = 'Direct Customer';
            oldHqAccount.Active_Channel_Partner__c = false;
            returnList.add(oldHqAccount);
        }
        
        }
        else
        {
            oldHQAddendumContracts = [Select Id, Status, RecordType.Name From Contract Where GE_Commercial_Member_Of_GE_OG__c =:oldCommAccId AND (RecordType.Name = 'Channel Addendum Agreement' OR RecordType.Name = 'Channel Master Agreement')];
            oldHQExecutedAddendums = [Select Id, Status, RecordType.Name From Contract Where GE_Commercial_Member_Of_GE_OG__c =:oldCommAccId AND RecordType.Name = 'Channel Addendum Agreement' AND Status = 'Executed'];
            oldHqAccount = [Select Id, Type, Classification__c,Active_Channel_Partner__c From Account Where Id =:oldCommAccId];
            
            if(!oldHQAddendumContracts.isEmpty())
        {
            oldHqAccount.Type = 'Channel Partner';
            oldHqAccount.Classification__c = 'Unclassified';
            
            if(!oldHQExecutedAddendums.isEmpty())
            {
                oldHqAccount.Active_Channel_Partner__c = true;
            }
            
            returnList.add(oldHqAccount);
        }
        else
        {
            oldHqAccount.Type = 'Direct Customer';
            oldHqAccount.Active_Channel_Partner__c = false;
            returnList.add(oldHqAccount);
        }
        }
        
        
        
      
        
        
    }
    
    
    return returnList;
    
}
}