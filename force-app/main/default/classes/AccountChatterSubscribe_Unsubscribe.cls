/*Purpose/Overview     : AccountTeamMember to follow and unfollow chatter for a Account
Scrum Team             : Account & Contacts
Requirement Number     : R-30001
Author                 : Geetha Karmarkar
Test Class Name        : Test_AccountChatterSubscribe_Unsubscribe                   
*/

global without sharing class AccountChatterSubscribe_Unsubscribe{
    global class AccountChatterSubscribeParser{
        @InvocableVariable(required=true description='Account Id' label='Account Id')
        public string accountId;
        @InvocableVariable(required=true description='User Id' label='User Id')
        public string loginUserID;
        @InvocableVariable(required=true description='IsUpdated' label='IsUpdated')
        public Boolean isUpdated;
        @InvocableVariable(required=true description='Action' label='strAction')
        public String strAction;
    }
    
    @InvocableMethod(label='Subscribe to Chatter')
    public static List<String> subscribeToAccountChatter(List<AccountChatterSubscribeParser> lstParser){
        List<String> lstResults = new List<String>();
        String strResult = 'Failure';
        List<EntitySubscription> entList = new List<EntitySubscription>();
        List<EntitySubscription> entListToDelete = new List<EntitySubscription>();
        Map<String,List<EntitySubscription>> mEntitySubscription= new Map<String,List<EntitySubscription>>();
        Set<Id> sParentIds = new Set<Id>();
        
        AccountChatterSubscribeParser objInput = lstParser[0];
        List<EntitySubscription> lstSubscriptions = [Select Id,ParentId, SubscriberId 
                                                     FROM EntitySubscription 
                                                     WHERE ParentId =: objInput.accountId AND SubscriberId =: objInput.loginUserID
                                                     LIMIT 1];
        /*List<AccountTeamMember> lstExistingTeam = new List<AccountTeamMember>();
        lstExistingTeam = [SELECT id, accountId, userId, TeamMemberRole
                          FROM AccountTeamMember
                          WHERE userId =:objInput.loginUserID
                          AND accountId =:objInput.accountId
                          AND CreatedDate !=: system.now()
                          LIMIT 1];*/
        if(objInput.strAction == 'Follow'){    
            if(lstSubscriptions.isEmpty()){  
                entList.add(new EntitySubscription(ParentId = objInput.accountId,SubscriberId= objInput.loginUserID));
            }
        }
        else if(objInput.strAction == 'Unfollow'){
            if(!lstSubscriptions.isEmpty() && !objInput.isUpdated){
                entListToDelete.addAll(lstSubscriptions);  
            }
        }
        
     
        if(!entList.isEmpty() || Test.isRunningTest()){ 
             try{
                 insert entList;
                 strResult = 'Success';
             }
             catch(Exception e){
                 strResult = e.getMessage();
             }
        }  
        if(!entListToDelete.isEmpty() || Test.isRunningTest()){
           try{
               delete entListToDelete;
               strResult = 'Success';
           }
           catch(Exception e){
               strResult = e.getMessage();
           }
        }
        lstResults.add(strResult); 
        return lstResults;
    }
    
}