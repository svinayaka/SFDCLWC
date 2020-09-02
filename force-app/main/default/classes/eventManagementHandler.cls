public class eventManagementHandler{

public static void processInsertCMRs(List<CampaignMember> cmrList)
{   

    Set<String> extIdSet = new Set<String>();
    Map<String,Account_Event_Relation__c> accountEventMap = new Map<String,Account_Event_Relation__c>();
    Map<String,CampaignMember> cmrMap = new Map<String,CampaignMember>();
    List<Account_Event_Relation__c> insertList =  new List<Account_Event_Relation__c>();
    List<Account_Event_Relation__c> updateList =  new List<Account_Event_Relation__c>();
    
    for(CampaignMember cmr : [Select Id, Contact.Member_Of_18_Digit__c, Contact.AccountId, Contact.Account.Account_Tier_GEOG__c, CampaignId, Campaign.Session_Capacity__c, Campaign.Type, Campaign.Cvent_Link__c from CampaignMember Where Id IN : cmrList ])
    {
        String keyVal;
        if(cmr.Contact.Member_Of_18_Digit__c != null && !String.isBlank(cmr.Contact.Member_Of_18_Digit__c) )
        {
            keyVal = String.valueOf(cmr.Contact.Member_Of_18_Digit__c)+String.valueOf(cmr.CampaignId); 
            system.debug('Here 1');
            system.debug('key=>'+String.valueOf(cmr.Contact.Member_Of_18_Digit__c)+'=='+String.valueOf(cmr.CampaignId)); 
            
        }
        else if(cmr.Contact.Account.Account_Tier_GEOG__c == 'Global')
        {
            keyVal = String.valueOf(cmr.Contact.AccountId)+String.valueOf(cmr.CampaignId); 
            system.debug('Here 2');
            system.debug('key=>'+String.valueOf(cmr.Contact.Member_Of_18_Digit__c)+'=='+String.valueOf(cmr.CampaignId)); 
        }
        else
        {
            keyVal = '';
        }
        Account_Event_Relation__c acc; system.debug('KEY==>'+keyVal);
        if( !accountEventMap.isEmpty() && !String.isBlank(keyVal) && accountEventMap.containsKey(keyVal) && cmr.Campaign.Type == 'Event')
        {
            acc = accountEventMap.get(keyVal);
            acc.Total_Registrations__c = acc.Total_Registrations__c + 1; 
            
        }
        else
        {
            if(!String.isBlank(keyVal) && ((cmr.Campaign.Type == 'Event' && !String.isBlank(cmr.Campaign.Cvent_Link__c)) || cmr.Campaign.Type == 'Sessions'))
            {
                acc = new Account_Event_Relation__c();
            if(cmr.Campaign.Type == 'Event')
            {
                acc.Total_Registrations__c = 1;
                acc.Confirmed_Account_Attendees__c = 0;
                acc.Pending_Registration_Approval__c = 0;
                acc.Pending_Registration_Response__c = 0;
                acc.Confirmed_Event_Attendees__c = 0;
                acc.Event_Name__c = cmr.CampaignId;
                acc.Type__c = 'Event';
                if(cmr.Contact.Member_Of_18_Digit__c != null && !String.isBlank(cmr.Contact.Member_Of_18_Digit__c))
                {
                    acc.Account_HQ__c = cmr.Contact.Member_Of_18_Digit__c;
                }
                else
                {
                    acc.Account_HQ__c = cmr.Contact.AccountId;
                }
                
                
                acc.Events_and_Sessions_on_Account_HQ__c = keyVal;
            }
            
           if(cmr.Campaign.Type == 'Sessions')
            {
                acc.Session_Name__c = cmr.CampaignId;
                acc.Session_Capacity__c = cmr.Campaign.Session_Capacity__c;
                acc.Events_and_Sessions_on_Account_HQ__c = keyVal;
                acc.Type__c = 'Sessions';
            }  
            
            accountEventMap.put(keyVal,acc);
            }
             
        }
    }
    
    for(Account_Event_Relation__c existingAER : [Select Id,Total_Registrations__c,Confirmed_Account_Attendees__c,Pending_Registration_Approval__c,Events_and_Sessions_on_Account_HQ__c From Account_Event_Relation__c Where Events_and_Sessions_on_Account_HQ__c IN : accountEventMap.keySet()])
    {
        if(accountEventMap.containsKey(existingAER.Events_and_Sessions_on_Account_HQ__c) && accountEventMap.get(existingAER.Events_and_Sessions_on_Account_HQ__c).Event_Name__c != null )
        {
            Account_Event_Relation__c acc = accountEventMap.get(existingAER.Events_and_Sessions_on_Account_HQ__c);
            acc.Total_Registrations__c = acc.Total_Registrations__c + existingAER.Total_Registrations__c;
            acc.Id = existingAER.Id;
            updateList.add(acc);
            
            accountEventMap.remove(existingAER.Events_and_Sessions_on_Account_HQ__c);  
        }
        if(accountEventMap.containsKey(existingAER.Events_and_Sessions_on_Account_HQ__c) && accountEventMap.get(existingAER.Events_and_Sessions_on_Account_HQ__c).Session_Name__c != null)
        {
            Account_Event_Relation__c acc = accountEventMap.get(existingAER.Events_and_Sessions_on_Account_HQ__c);
            acc.Id = existingAER.Id;
            updateList.add(acc);
            accountEventMap.remove(existingAER.Events_and_Sessions_on_Account_HQ__c); 
        }
    }
    
    insertList = accountEventMap.values();
    insert insertList;
    update updateList;
   // upsert accountEventMap.values();
    
    
}

public static void processCMRsOnUpdate(List<CampaignMember> cmrList, Boolean isDelete)
{
    List<Account_Event_Relation__c> updateList = new List<Account_Event_Relation__c>();
    Map<String,String> accountHQMap = new Map<String,String>();
    Map<String,String> campaignMap = new Map<String,String>();
    Map<String,Integer> pendingResponseMap = new Map<String,Integer>();
    Map<String,Integer> confirmedResponseMap = new Map<String,Integer>();
    Map<String,Integer> pendingApprovalMap = new Map<String,Integer>();
    Map<String,Integer> confirmedSessionMap = new Map<String,Integer>();
    Map<String,Integer> totalResponseMap = new Map<String,Integer>();
    
    
    for(CampaignMember cmr : cmrList)
    {
        accountHQMap.put(String.valueOf(cmr.Member_of_Account__c), String.valueOf(cmr.Member_of_Account__c)+ String.valueOf(cmr.CampaignId));
        campaignMap.put(String.valueOf(cmr.CampaignId), String.valueOf(cmr.Member_of_Account__c)+ String.valueOf(cmr.CampaignId));
    
    }
    
    for(AggregateResult ar : [Select Member_of_Account__c m , count(Id) c From CampaignMember Where CampaignMember.Campaign.Type = 'Event' AND Invitation_Status__c = 'Sent' AND Campaign.Cvent_Link__c!= null AND Member_of_Account__c IN :accountHQMap.keySet() AND CampaignId IN : campaignMap.keySet() group by Member_of_Account__c ])
    {
        pendingResponseMap.put((Id) ar.get('m'),(Integer) ar.get('c'));
    }
    
    for(AggregateResult ar : [Select Member_of_Account__c m , count(Id) c From CampaignMember Where CampaignMember.Campaign.Type = 'Event' AND Invitation_Status__c = 'Accepted' AND Campaign.Cvent_Link__c!= null AND Member_of_Account__c IN :accountHQMap.keySet() AND CampaignId IN : campaignMap.keySet() group by Member_of_Account__c] )
    {
        confirmedResponseMap.put((Id) ar.get('m'),(Integer) ar.get('c'));
    }
    
    for(AggregateResult ar : [Select Member_of_Account__c m , count(Id) c From CampaignMember Where CampaignMember.Campaign.Type = 'Event' AND Member_of_Account__c IN :accountHQMap.keySet() AND Campaign.Cvent_Link__c!= null AND CampaignId IN : campaignMap.keySet() group by Member_of_Account__c] )
    {
        totalResponseMap.put((Id) ar.get('m'),(Integer) ar.get('c'));
    }
    
    for(AggregateResult ar : [Select Member_of_Account__c m , count(Id) c From CampaignMember Where CampaignMember.Campaign.Type = 'Event' AND Approval_Status__c = 'Pending' AND Campaign.Cvent_Link__c!= null AND Member_of_Account__c IN :accountHQMap.keySet() AND CampaignId IN : campaignMap.keySet() group by Member_of_Account__c] )
    {
        pendingApprovalMap.put((Id) ar.get('m'),(Integer) ar.get('c'));
    }
    
    for(AggregateResult ar : [Select Member_of_Account__c m , count(Id) c From CampaignMember Where CampaignMember.Campaign.Type = 'Sessions' AND Session_Response__c = 'Yes' AND Member_of_Account__c IN :accountHQMap.keySet() AND CampaignId IN : campaignMap.keySet() group by Member_of_Account__c] )
    {
        confirmedSessionMap.put((Id) ar.get('m'),(Integer) ar.get('c'));
    }
    
    for(Account_Event_Relation__c aec : [Select Id,Account_HQ__c,Total_Registrations__c,Confirmed_Event_Attendees__c,Pending_Registration_Response__c, Events_and_Sessions_on_Account_HQ__c  From Account_Event_Relation__c Where Events_and_Sessions_on_Account_HQ__c IN : accountHQMap.values()])
    {
            if(isDelete)
            {
                 if(totalResponseMap != null && !totalResponseMap.isEmpty())
                {
                aec.Total_Registrations__c =  totalResponseMap.get(aec.Account_HQ__c);
                }
             else
                {
                 aec.Total_Registrations__c =  0;
                }
            }
           
       
            if(confirmedResponseMap != null && !confirmedResponseMap.isEmpty())
            {
                aec.Confirmed_Event_Attendees__c = confirmedResponseMap.get(aec.Account_HQ__c);
            }
            else
            {
                aec.Confirmed_Event_Attendees__c = 0;
            }
            
     
            if(pendingResponseMap != null && !pendingResponseMap.isEmpty())
            {
                aec.Pending_Registration_Response__c = pendingResponseMap.get(aec.Account_HQ__c);
            }
            else
            {
                aec.Pending_Registration_Response__c = 0;
            }
            if(pendingApprovalMap != null && !pendingApprovalMap.isEmpty())
            {
                aec.Pending_Registration_Approval__c = pendingApprovalMap.get(aec.Account_HQ__c);
            }
            else
            {
                aec.Pending_Registration_Approval__c = 0;
            }
            if(confirmedSessionMap != null && !confirmedSessionMap.isEmpty())
            {
                aec.Confirmed_Session_Attendees__c = confirmedSessionMap.get(aec.Account_HQ__c);
            }
            else
            {
                aec.Confirmed_Session_Attendees__c = 0;
            }
            
      //  }
    
    updateList.add(aec);
    }
    
    update updateList;
}}