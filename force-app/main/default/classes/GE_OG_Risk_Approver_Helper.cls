/*
Class Name:-      GE_OG_Risk_Approver_Helper
Overview:-        This Class is helper class for DR Trigger. Currently used to update users if they are Risk Approvers.
Author:-          Ashish Vashisht    
Created Date:-    19th July 2016
*/

public Class GE_OG_Risk_Approver_Helper
{
    
    public static void afterinsert(List<Deal_Reviewer_ge_og__c> Triggernew)
    {
        Set<Id> UsersToUpdate = new Set<Id>();
        List<User> InsertUpdateUser = new List<User>();
        
        List<Deal_Reviewer_ge_og__c> DRNew = Triggernew;
        
        for(Deal_Reviewer_ge_og__c dr : DRNew)
          {
              UsersToUpdate.add(dr.user_ge_og__c);
          }
          List<User> UserUpdt = [Select id, name,Is_DND__c from user where Id in :UsersToUpdate];
          
          for(User uupt : UserUpdt)
          {
             uupt.Is_DND__c = True;
             InsertUpdateUser.add(uupt);
          }     
          update InsertUpdateUser;
    }   
    
    public static void afterupdate(List<Deal_Reviewer_ge_og__c> Triggernew, List<Deal_Reviewer_ge_og__c> Triggerold,Map<Id,Deal_Reviewer_ge_og__c> triggerOldMap) 
    {
        List<User>fnlList = new list<User>();
        Set<User> fnlset = new Set<User>();
        
        List<Deal_Reviewer_ge_og__c> Triggernew1= Triggernew;
        List<Deal_Reviewer_ge_og__c> Triggerold1 = Triggerold;
        Map<Id,Deal_Reviewer_ge_og__c> triggerOldMap1 = triggerOldMap;
        
        List <User> Usrupdt = new List<User>();
        Set<Id> UserDR = new Set<Id>();
        Set<Id> OldUserDR = new Set<Id>();
        Set<Id> NewUserDR = new Set<Id>();
        for (Deal_Reviewer_ge_og__c DR : Triggernew1) 
        {
            // Access the "old" record by its ID in triggerOldMap1
            Deal_Reviewer_ge_og__c oldDR = triggerOldMap1.get(DR.Id);
  
            if (oldDR.user_ge_og__c != DR.user_ge_og__c) 
            {
                OldUserDR.add(oldDR.user_ge_og__c);
                NewUserDR.add(DR.user_ge_og__c);
                UserDR.add(oldDR.user_ge_og__c);
                UserDR.add(DR.user_ge_og__c);
               //UserOldMap.put(oldDR.user_ge_og__c, DR.user_ge_og__c);
            }
        }
        
        Map<Id,User> UserToUpdate =new Map<Id,User>([Select Id,Is_DND__c from User where Id IN :UserDR]);
        
        Usrupdt.addALL( OldUsercheck(Triggerold1,UserToUpdate,OldUserDR) );
        
        for(Deal_Reviewer_ge_og__c DR : Triggernew1)
        {
            System.debug('Inside New Loop ');
            if(UserToUpdate.containsKey(DR.user_ge_og__c))
            {
                User u = UserToUpdate.get(DR.user_ge_og__c);
                u.Is_DND__c = True ;
                Usrupdt.add(u);
            }
        }
        System.debug('UserstoUpdate' + usrupdt);
        
        fnlset.addAll(Usrupdt);
        fnlList.addAll(fnlset);
        update fnlList ;
    }
    
    public static List<User> OldUsercheck (List<Deal_Reviewer_ge_og__c> Triggerold1,Map<Id,User> UserToUpdateMap, Set<Id> OldUserIds )
    {
        List <User> Usrtoupdt = new List<User>();
        //Map contains the mapping from the User to Deal Reviewer
        Map<Id,List<Deal_Reviewer_ge_og__c>> UserOldMap = new Map<Id,List<Deal_Reviewer_ge_og__c>>();

        for(Deal_Reviewer_ge_og__c d: [Select user_ge_og__c,Id from Deal_Reviewer_ge_og__c where user_ge_og__c IN : OldUserIds ])
        {
            if(UserOldMap.containsKey(d.user_ge_og__c)) {
                List<Deal_Reviewer_ge_og__c> DRList = UserOldMap.get(d.user_ge_og__c);
                DRList.add(d);
                UserOldMap.put(d.user_ge_og__c, DRList);
            } else {
                UserOldMap.put(d.user_ge_og__c, new List<Deal_Reviewer_ge_og__c> { d });
            }
        }
        System.debug('Map ash' + UserOldMap);
        for(Deal_Reviewer_ge_og__c DR : Triggerold1)
        {
            if(!UserOldMap.containsKey(DR.user_ge_og__c))
            {
                System.debug('Inside Old Loop ');
                if(UserToUpdateMap.containsKey(DR.user_ge_og__c))
                {
                    User u = UserToUpdateMap.get(DR.user_ge_og__c);
                    u.Is_DND__c = False ;
                    Usrtoupdt.add(u);
                }
            }
            
        }
        return Usrtoupdt;
    }
    
    public static void afterdelete(List<Deal_Reviewer_ge_og__c> oldList)
    {
        Set<Id>OldUsers = new Set<Id>();
        List<User> Updateuserlist = new List<User>();
        List<User> fnlusrlst = new List<User>();
        Set<User> fnlusrset = new Set<User>();
        for(Deal_Reviewer_ge_og__c r:oldList)
        {
            OldUsers.add(r.user_ge_og__c);
        }
        Map<Id,User> UserToUpdate =new Map<Id,User>([Select Id,Is_DND__c from User where Id IN :OldUsers]);
        
        Updateuserlist.addAll(OldUsercheck(oldList,UserToUpdate,OldUsers));
        fnlusrset.addAll(Updateuserlist);
        fnlusrlst.addALL(fnlusrset);
        Update fnlusrlst;
        
    }
    
}