/*
Class/Trigger Name     : GE_OG_AccountContactRelationHandler
Used Where ?           : GE_OG_AccountContactRelationTrigger
Purpose/Overview       : To set only one primary contact on RelatedContact Module and also to check Accounts Data Quality
Scrum Team             : Accounts & Contacts Scrum
Requirement Number     : 
Author                 : Niranjana
Created Date           : 14/NOV/2016
Test Class Name        : GE_OG_AccountContactRelationHandler_Test
Code Coverage          : 95%
*/

public class GE_OG_AccountContactRelationHandler{
    public static Boolean isFirstTime = true;
    
    public void SetPrimaryFlag(List<AccountContactRelation> oldConts, List<AccountContactRelation> newConts, Map<Id, AccountContactRelation> ContactOldMap){
        set<id> getAccountId= new Set<Id>();
        set<id> getContactId= new Set<Id>();
        set<id> getNewRelatedContactIds = new Set<Id>();
        Map<id,AccountContactRelation> UpdateContactList = new Map<id,AccountContactRelation>();
        List<Account> UpdateAccountDataQuality = new List<Account>();
        List<Contact> UpdateDirectContactList = new List<Contact>();
        
        system.debug('====newConts===='+newConts);
        system.debug('====ContactOldMap===='+ContactOldMap);
        
        if(isFirstTime){
            isFirstTime = false;
            
            for(AccountContactRelation con:newConts){
                if(ContactOldMap!=null){
                    AccountContactRelation oldCon= ContactOldMap.get(con.id);
                    if(oldCon.GE_OG_Primary_Contact__c != con.GE_OG_Primary_Contact__c){
                        getNewRelatedContactIds.add(con.id); 
                    }
                }
                else
                {
                    getNewRelatedContactIds.add(con.id);  
                }
            }
            system.debug('====getNewRelatedContactIds===='+getNewRelatedContactIds);
            
            if(getNewRelatedContactIds.isEmpty()==false){
                
                List<AccountContactRelation> NewContactList= [Select id,GE_OG_Primary_Contact__c,IsDirect,ContactID,AccountID,Contact.GE_PRM_Primary_Contact__c from AccountContactRelation where Id IN: getNewRelatedContactIds limit 50000];
                
                for(AccountContactRelation con: NewContactList){
                    if(con.IsDirect == true && con.ContactID!=null){
                        getAccountId.add(con.AccountId);  
                        getContactId.add(con.ContactId);         
                    }
                    else if(con.IsDirect == false){
                        getAccountId.add(con.AccountId);
                    }
                    system.debug('====con.Contact.GE_PRM_Primary_Contact__c==='+con.Contact.GE_PRM_Primary_Contact__c);
                    UpdateContactList.put(con.id,con);        
                }
                
                // Get accounts with their contacts.
                Map<Id,List<AccountContactRelation>> accountMap = new Map<Id,List<AccountContactRelation>>();
                for(AccountContactRelation a:[Select id,GE_OG_Primary_Contact__c,IsDirect,ContactID,AccountID from AccountContactRelation where AccountId IN:getAccountId and GE_OG_Primary_Contact__c=true limit 50000]){
                    system.debug('===inside=a==='+a);
                    accountMap.put(a.accountid,[Select id,GE_OG_Primary_Contact__c,IsDirect,ContactID,AccountID from AccountContactRelation where AccountId=:a.accountid and GE_OG_Primary_Contact__c=true limit 50000]);    
                }
                
                system.debug('====NewContactList==='+NewContactList);
                for (AccountContactRelation c : NewContactList) {
                    if(accountMap!=null){
                        if (c.GE_OG_Primary_Contact__c && accountMap.get(c.AccountId).size()>0) {
                            system.debug('====c.GE_OG_Primary_Contact__c==='+c.GE_OG_Primary_Contact__c);
                            system.debug('====accountMap.get(c.AccountId).size()==='+accountMap.get(c.AccountId).size());
                            system.debug('====accountMap.get(c.AccountId)==='+accountMap.get(c.AccountId));
                            List<AccountContactRelation> updAccountContactRelation = accountMap.get(c.AccountId);
                            for(AccountContactRelation con: updAccountContactRelation){ 
                                if(con.id!=c.id && con.IsDirect == true){
                                    system.debug('====inside if==='+con.id);
                                    con.GE_OG_Primary_Contact__c = false;
                                    getContactId.add(con.ContactId);
                                    UpdateContactList.put(con.id,con);
                                }
                                else if(con.id!= c.id && con.IsDirect == false){
                                    system.debug('====inside else if==='+con.id);
                                    con.GE_OG_Primary_Contact__c = false;
                                    UpdateContactList.put(con.id,con);
                                } 
                                else if(con.id== c.id){
                                    con.GE_OG_Primary_Contact__c = true;
                                    UpdateContactList.put(con.id,con);
                                }
                            } 
                        }
                    } 
                }
                update UpdateContactList.values();
                
                system.debug('====after UpdateContactList update==='+UpdateContactList);
                
                List<Contact> directContactList = [Select id, GE_PRM_Primary_Contact__c from Contact where id IN: getContactId limit 50000];
                system.debug('====directContactList==='+directContactList);
                
                Map<Id, AccountContactRelation> RelatedcontactMap = new Map<Id, AccountContactRelation>();
                for(AccountContactRelation conMap: NewContactList){
                    RelatedcontactMap.put(conMap.ContactId, conMap);
                }
                
                if(directContactList.size() > 0){
                    for(Contact con: directContactList){
                        if(RelatedcontactMap.get(con.Id)==null)
                            con.GE_PRM_Primary_Contact__c = false;
                        else if(RelatedcontactMap.get(con.Id).GE_OG_Primary_Contact__c== True)
                            con.GE_PRM_Primary_Contact__c = true;
                        else if(RelatedcontactMap.get(con.Id).GE_OG_Primary_Contact__c== False)
                            con.GE_PRM_Primary_Contact__c = false;
                        UpdateDirectContactList.add(con);
                    }
                    system.debug('====UpdateDirectContactList ==='+UpdateDirectContactList);
                    update UpdateDirectContactList ;
                }
                
                Map<Id,Integer> SumOfAccountTeamMember = new Map<Id,Integer>();
                List<Account> AccountList= [Select id,name,RecordTypeId,Strength__c,Type, Classification__c, OwnerID,Owner.Name, GE_ES_Primary_Industry__c, Compliance_Ready__c from Account where ID IN: getAccountId limit 50000];
                
                Map<Id,AccountContactRelation> AccountContactRelationMap = new Map<Id,AccountContactRelation>();
                for(AccountContactRelation conMap: NewContactList){
                    AccountContactRelationMap.put(conMap.AccountId, conMap);
                }
                
                system.debug('======AccountContactRelationMap==='+AccountContactRelationMap);        
                system.debug('======AccountList==='+AccountList);
                
                for(AggregateResult aggResult:[SELECT COUNT(Id) cnt,AccountId
                                               FROM AccountTeamMember
                                               WHERE AccountId IN: getAccountId
                                               GROUP BY AccountId])
                {
                    if((Id)aggresult.get('AccountId') != null)
                    {
                        SumOfAccountTeamMember.put((Id)aggresult.get('AccountId'),(Integer)aggresult.get('cnt'));
                    }
                }
                system.debug('======SumOfAccountTeamMember==='+SumOfAccountTeamMember); 
                
                List<Acc_Invalid_Sales_Primary_User__c> AccOwnerName=[Select User_Name__c from Acc_Invalid_Sales_Primary_User__c limit 50000];
                Set<id> InvalidUserName = new Set<id>();
                
                for(Account acc : AccountList){
                    for(Acc_Invalid_Sales_Primary_User__c uname:AccOwnerName){
                        if(acc.Owner.name==uname.User_Name__c)
                            InvalidUserName.add(acc.id);
                    }
                }
                
                Map<id,boolean> InvlaidUserMap= new Map<id,boolean>();
                for(Account a:[select id,name,ownerId,Owner.name from account where id IN: InvalidUserName limit 50000]){
                    InvlaidUserMap.put(a.id,true);   
                }
                
                if(AccountList.size()>0){       
                    for(Account acc : AccountList){
                        Id RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
                        system.debug('account type'+acc.Type);
                        system.debug('account type'+ acc.Classification__c);
                        if(acc.RecordTypeId==RecordTypeId){
                            system.debug('======InvlaidUserMap.get(acc.Id)==='+InvlaidUserMap.get(acc.Id));
                            system.debug('======accountMap.get(acc.id).size()==='+accountMap.get(acc.id));
                            if(InvlaidUserMap.get(acc.Id) ==true || (acc.Type== null || acc.Classification__c==null)){
                                acc.Strength__c= 'Low';    
                            }
                            
                            else if(acc.Type!= null && acc.Classification__c!=null){        
                                acc.Strength__c= 'Low';
                              
                                if(acc.GE_ES_Primary_Industry__c != null &&  accountMap.get(acc.id)!=null){   
                                    acc.Strength__c= 'Medium';
                                    
                                    if(acc.Compliance_Ready__c == True && SumOfAccountTeamMember.containskey(acc.Id) && SumOfAccountTeamMember.get(acc.Id) != null && SumOfAccountTeamMember.get(acc.Id) > = 1){
                                        acc.Strength__c= 'High';
                                    }
                                }
                            }
                        }
                        UpdateAccountDataQuality.add(acc);
                    }
                    
                }
                
                system.debug('======UpdateAccountDataQuality==='+UpdateAccountDataQuality);
                if(UpdateAccountDataQuality.size()>0)
                    //try{
                    update UpdateAccountDataQuality;
                // }
                //catch(DMLException e){}     
            }
        }
    }
    
    public void SetAccountDataQuality(List<AccountContactRelation> oldConts, Map<Id, AccountContactRelation> ContactOldMap){
        set<id> getAccountId= new Set<Id>();
        List<Account> UpdateAccountDataQuality = new List<Account>();
        for(AccountContactRelation con: oldConts){
            if(con.GE_OG_Primary_Contact__c == true){
                getAccountId.add(con.AccountId);    
            }
        }
        
        List<Account> AccountList= [Select id,name,Strength__c,Type, Classification__c, OwnerID,Owner.Name, GE_ES_Primary_Industry__c, Compliance_Ready__c from Account where ID IN: getAccountId limit 50000];
        system.debug('======AccountList==='+AccountList);
        
        if(AccountList.size()>0){
            for(Account acc : AccountList){
                acc.Strength__c= 'Low';
                UpdateAccountDataQuality.add(acc);
            } 
            
            update UpdateAccountDataQuality;     
        }  
    }
    
    public void CheckPrimaryContactOnAccounts(List<AccountContactRelation> oldConts, List<AccountContactRelation> newConts, Map<Id, AccountContactRelation> ContactOldMap){
        set<id> getAccountId= new Set<Id>();
        set<id> getNewRelatedContactIds = new Set<Id>();
        
        for(AccountContactRelation con:newConts){
            if(ContactOldMap!=null){
                AccountContactRelation oldCon= ContactOldMap.get(con.id);
                if(oldCon.GE_OG_Primary_Contact__c != con.GE_OG_Primary_Contact__c){
                    getNewRelatedContactIds.add(con.id);
                    getAccountId.add(con.accountid); 
                }
            }
            else
            {
                getNewRelatedContactIds.add(con.id); 
                getAccountId.add(con.accountid); 
            }
        }
        system.debug('===getNewRelatedContactIds=a==='+getNewRelatedContactIds);
        
        List<Account> AccountList= [Select id,name,RecordTypeId,Strength__c,Type, Classification__c,GEOG_Primary_Contact_Flag__c,OwnerID,Owner.Name, GE_ES_Primary_Industry__c, Compliance_Ready__c from Account where ID IN: getAccountId limit 50000];
        system.debug('===AccountList=a==='+AccountList);
        
        Map<Id,Account> AccountMap = new Map<Id,Account>();
        for(Account accMap: AccountList){
            AccountMap.put(accMap.Id, accMap);
        }
        system.debug('===AccountMap=a==='+AccountMap);
        
        // Get accounts with their contacts.
        
        Map<Id,List<AccountContactRelation>> accountContactMap = new Map<Id,List<AccountContactRelation>>();
        for(AccountContactRelation a:[Select id,GE_OG_Primary_Contact__c,IsDirect,ContactID,AccountID from AccountContactRelation where AccountId IN:getAccountId and GE_OG_Primary_Contact__c=true limit 50000]){
            system.debug('===inside=a==='+a);
            accountContactMap.put(a.accountid,[Select id,GE_OG_Primary_Contact__c,IsDirect,ContactID,AccountID from AccountContactRelation where AccountId=:a.accountid and GE_OG_Primary_Contact__c=true limit 50000]);    
        }
        system.debug('===accountContactMap =a==='+accountContactMap);
        
        for (Account acc : AccountList) {
            if(accountContactMap!=null){
                if (accountContactMap.containsKey(acc.id)==true) {
                    system.debug('===inside true');
                    AccountMap.get(acc.id).GEOG_Primary_Contact_Flag__c=true;                    
                }
                else if (accountContactMap.containsKey(acc.id)==false) {
                    system.debug('===inside false');
                    AccountMap.get(acc.id).GEOG_Primary_Contact_Flag__c=false; 
                }
            }
        } 
        update AccountMap.values();
    }
}