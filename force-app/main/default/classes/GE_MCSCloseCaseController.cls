/*    
Class Name      : GE_MCSCloseCaseController
Purpose/Overview  : For MCS Case,Only Case Owner should able to Close the Case.
Author            : Lakshmi Prasanna Kethu
Created Date      : 20 December 2013
Test Class        : 
Modified On / By  : 18 July 2014 / Vijaya Lakshmi Murukutla
Purpose           : Included the Sub type Mandatory logic.

*/



global class GE_MCSCloseCaseController
{
    public GE_MCSCloseCaseController(ApexPages.StandardController controller) 
    {
     }
    
    
    Webservice static boolean Originalpage1(ID caseId)
    {
        String urlCaseId;
        String caseid1;
        List<String> lCaseId= New List<String>();        
        List<Case> lCase_selected= New List<Case>();        
        List<Case> updateCase= New List<Case>();
        List<Case> cOwnerSubType;
        boolean isOwner ;
        Id UserId=UserInfo.getUserId();

         Id cownId;
         urlCaseid= caseId;                
         lCaseID=urlCaseID.split(',');                                  
         lCase_selected=[select id,OwnerID,GE_ES_Sub_Type__c,Recordtype.Name , RecordTypeId from Case where ID in :lCaseID];
         caseid1= lCase_selected[0].id;
         cOwnerSubType=[SELECT Case.OwnerId,GE_ES_Sub_Type__c FROM Case WHERE id=:caseid1];
         
         if(UserId == cOwnerSubType[0].OwnerId ){
            isOwner = true;
            return isOwner;
         }else{
            isOwner = false;
            return isOwner;
         }
  }
  
  /*
   Webservice static boolean Originalpage_subType(ID caseId)
    {
        String urlCaseId;
        String caseid1;
        List<String> lCaseId= New List<String>();        
        List<Case> lCase_selected= New List<Case>();        
        List<Case> updateCase= New List<Case>();
        List<Case> cOwnerSubType;
        boolean SubTypeisNull ;
        Id UserId=UserInfo.getUserId();

         Id cownId;
         urlCaseid= caseId;                
         lCaseID=urlCaseID.split(',');                                  
         lCase_selected=[select id,OwnerID,GE_ES_Sub_Type__c,Recordtype.Name , RecordTypeId from Case where ID in :lCaseID];
         caseid1= lCase_selected[0].id;
         cOwnerSubType=[SELECT Case.OwnerId,GE_ES_Sub_Type__c FROM Case WHERE id=:caseid1];
         RecordType recordTypeId = [Select Id, Name from RecordType where DeveloperName = 'GE_ES_MCS_CS' and SobjectType='Case' Limit 1];
         if( recordTypeId.Id ==  lCase_selected[0].RecordTypeId && lCase_selected[0].GE_ES_Sub_Type__c == Null ){
            SubTypeisNull = true;
            return SubTypeisNull;
        } else{
            SubTypeisNull = false;
            return SubTypeisNull;
        }
  }
  
  Webservice static boolean Originalpage_RecordTypeId(ID caseId)
    {
        String urlCaseId;
        String caseid1;
        List<String> lCaseId= New List<String>();        
        List<Case> lCase_selected= New List<Case>();        
        List<Case> updateCase= New List<Case>();
        List<Case> cOwnerSubType;
        boolean isMCSCSRecordType ;
        Id UserId=UserInfo.getUserId();

         Id cownId;
         urlCaseid= caseId;                
         lCaseID=urlCaseID.split(',');                                  
         lCase_selected=[select id,OwnerID,GE_ES_Sub_Type__c,Recordtype.Name , RecordTypeId from Case where ID in :lCaseID];
         caseid1= lCase_selected[0].id;
         cOwnerSubType=[SELECT Case.OwnerId,GE_ES_Sub_Type__c FROM Case WHERE id=:caseid1];
         RecordType recordTypeId = [Select Id, Name from RecordType where DeveloperName = 'GE_ES_MCS_CS' and SobjectType='Case' Limit 1];
         if( recordTypeId.Id ==  lCase_selected[0].RecordTypeId ){
            isMCSCSRecordType = true;
            return isMCSCSRecordType;
        } else{
            isMCSCSRecordType = false;
            return isMCSCSRecordType;
        }
  }
  
  */
  
  
  
}
        /*getqueueDetails();
         if(IsQueMem == true)
         {
          showmessage =true;
          System.debug(cOwner[0].OwnerId);
         System.debug(UserInfo.getUserId());
         ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'You must take ownership of this case before you can change its status')); 
         PageReference orpage = new PageReference('/'+caseid);
         orpage.setRedirect(true);
         return orpage;         
         }
          
         else
         {
         showmessage =true;
          ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'you cannot close the Case')); 
         PageReference orpage = new PageReference('/'+caseid);
         orpage.setRedirect(true);
         return orpage; 
         }   
    }
    
    public void getqueueDetails()
    {
      List<QueueSObject> lstQueue = new List<QueueSObject>([Select id,Queue.Name,QueueId from QueueSobject where QueueId=:cOwner[0].OwnerId]);
     if(lstQueue.size()>0){
         System.debug(lstQueue[0].Queue.Name + lstQueue[0].QueueId);
         Set<Id> userOrGroupIds = new Set<Id>();
         Map<Id, Group> groupMap = new Map<Id, Group>([Select Id from Group where type='Queue' and Name =: lstQueue[0].Queue.Name]);
         List<GroupMember> groupMembers = [Select GroupId, UserOrGroupId From GroupMember Where GroupId In :groupMap.keySet()];
         System.debug(groupMembers[0].GroupId);
        
         for (GroupMember member : groupMembers) {
            userOrGroupIds.add(member.UserOrGroupId);
            if(UserId == member.UserOrGroupId)
            {
            System.debug(member.UserOrGroupId);
            IsQueMem= true;
            }
        }
        IsQueMem= false;
     }
   }   
}*/