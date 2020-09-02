global class GE_OG_AccountTeamMemberUpdate_Batch implements Database.Batchable<sObject>
{
    global boolean isRunForAll{get;set;}
    
    global Set<ID> setAccId{get;set;}
    global Database.QueryLocator start(Database.BatchableContext BC)
    {
        DateTime NowDate = datetime.now();
        DateTime Past24 = system.now().AddDays(-1);
        String query;
        String teamrole = 'Sales - Primary';
        if(setAccId!=null && setAccId.size()>0){
             query = 'Select Id, OwnerId,(SELECT AccountId,Id,TeamMemberRole,UserId FROM AccountTeamMembers where TeamMemberRole =:teamrole order by LastModifiedDate desc) from Account where Id in:setAccId';        
        }
        else{
            if(isRunForAll){
             
             query = 'Select Id, OwnerId,(SELECT AccountId,Id,TeamMemberRole,UserId FROM AccountTeamMembers where TeamMemberRole =:teamrole order by LastModifiedDate desc) from Account';
            
            }
            else{
                 query = 'Select Id, OwnerId,(SELECT AccountId,Id,TeamMemberRole,UserId FROM AccountTeamMembers where TeamMemberRole =:teamrole order by LastModifiedDate desc) from Account where LastModifiedDate < : NowDate and LastModifiedDate >: Past24';   
            }
        }
        
        return Database.getQueryLocator(query);
    }
   
    global void execute(Database.BatchableContext BC, List<Account> scope)
    {
        Map<Id, List<AccountTeamMember>> mapAccTeam = new Map<Id, List<AccountTeamMember>>();
        for(Account objAccountTeam:scope)
        {
            List<AccountTeamMember> setAccTeam = objAccountTeam.AccountTeamMembers;
            mapAccTeam.put(objAccountTeam.Id, setAccTeam); 
        }
         
        list<Account> lstAccountOwnerUpdate = new List<Account>();
        list<AccountTeamMember> lstAccountTeamMember = new List<AccountTeamMember>();
        Map<Id, Account> mapAcc = new Map<Id, Account>([Select Id, OwnerId from Account where Id in: mapAccTeam.KeySet()]);
        for(Id accId : mapAccTeam.KeySet()){
            List<AccountTeamMember> lstAccTeam = mapAccTeam.get(accId);
            if(lstAccTeam.size()>1){
                for(integer count=0; count<lstAccTeam.size(); count++){
                    if(count==0){
                        if(mapAcc.get(accId)!=null){
                            Account obj = mapAcc.get(accId);
                            obj.OwnerId = lstAccTeam[Count].UserId;
                            lstAccountOwnerUpdate.add(obj);
                        }
                    }
                    else{
                        AccountTeamMember obj = lstAccTeam[count];
                        obj.TeamMemberRole = 'Sales';
                        lstAccountTeamMember.add(obj);
                    }
                }
            }
            else if(lstAccTeam.size()==1){
                  if(mapAcc.get(accId)!=null){
                      Account obj = mapAcc.get(accId);
                      obj.OwnerId = lstAccTeam[0].UserId;
                      lstAccountOwnerUpdate.add(obj);
                  }                
            }
        }
        
        if(lstAccountOwnerUpdate.size()>0){
            update lstAccountOwnerUpdate;
        }
        if(lstAccountTeamMember.size()>0){
            update lstAccountTeamMember;
        }
        
    }   
    global void finish(Database.BatchableContext BC)
    {
    }
}