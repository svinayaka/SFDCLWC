/*
Trigger Name:-    GE_HQ_Update_User_Sharing
Overview:-        Whenever an Account plan team member is added for an Account plan, then the Account plan record should be shared with the new team member automatically
Author:-          Jayadev Rath
Created Date:-    17th Jan 2012
Test Class Name:- GE_HQ_Update_User_Sharing_Test
Change History:-  Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
                  17th Jan 2012 : Jayadev Rath       : Created: Created for R-5949 , BC: S-04447
*/
Trigger GE_HQ_Update_User_Sharing on GE_HQ_Account_Plan_Team__c (After Insert, Before Update, Before Delete) {

    If(Trigger.isInsert) {
        //GE_HQ_Acc_Plan_Name__c, GE_HQ_Access_Level__c , GE_HQ_Acc_Plan_Team_Member__c
        List<GE_HQ_Account_Plan__Share> SharedUsers = new List<GE_HQ_Account_Plan__Share>();
        For(GE_HQ_Account_Plan_Team__c AP : Trigger.New) {
            If(AP.GE_HQ_Acc_Plan_Name__c != Null && AP.GE_HQ_Acc_Plan_Team_Member__c != Null) {
                String AccLvl = (AP.GE_HQ_Access_Level__c == 'Read/Write') ? 'Edit' : 'Read';
                GE_HQ_Account_Plan__Share sh = new GE_HQ_Account_Plan__Share(ParentId = AP.GE_HQ_Acc_Plan_Name__c, AccessLevel= AccLvl, UserOrGroupId = AP.GE_HQ_Acc_Plan_Team_Member__c,RowCause= Schema.GE_HQ_Account_Plan__Share.rowCause.Account_Plan_Team_Member__c);
                SharedUsers.add(sh);
            }
        }
        If(SharedUsers != Null && SharedUsers.size() > 0) Insert SharedUsers;
    }
    
    
    If(Trigger.isUpdate) {
        List<GE_HQ_Account_Plan__Share> InsertList = new List<GE_HQ_Account_Plan__Share>();
        List<GE_HQ_Account_Plan__Share> DelList = new List<GE_HQ_Account_Plan__Share>();
        List<GE_HQ_Account_Plan__Share> UpList = new List<GE_HQ_Account_Plan__Share>();
        Set<Id> ParentIds = new Set<Id>();
        Set<Id> OldUserIds = new Set<Id>();
        Set<Id> UpdUserIds = new Set<Id>();

        For(GE_HQ_Account_Plan_Team__c AP : Trigger.New) {
            ParentIds.add(AP.GE_HQ_Acc_Plan_Name__c);
            If(Trigger.oldMap.get(AP.Id).GE_HQ_Acc_Plan_Team_Member__c != AP.GE_HQ_Acc_Plan_Team_Member__c) {
                OldUserIds.add(Trigger.oldMap.get(AP.Id).GE_HQ_Acc_Plan_Team_Member__c);
                If(AP.GE_HQ_Acc_Plan_Name__c != Null && AP.GE_HQ_Acc_Plan_Team_Member__c != Null) {
                    String AccLvl = (AP.GE_HQ_Access_Level__c == 'Read/Write') ? 'Edit' : 'Read';
                    GE_HQ_Account_Plan__Share sh = new GE_HQ_Account_Plan__Share(ParentId = AP.GE_HQ_Acc_Plan_Name__c, AccessLevel= AccLvl, UserOrGroupId = AP.GE_HQ_Acc_Plan_Team_Member__c,RowCause= Schema.GE_HQ_Account_Plan__Share.rowCause.Account_Plan_Team_Member__c);
                    InsertList.add(sh);
                }
            }
            Else If(Trigger.oldMap.get(AP.Id).GE_HQ_Access_Level__c != AP.GE_HQ_Access_Level__c) {
                UpdUserIds.add(AP.GE_HQ_Acc_Plan_Team_Member__c);
            }
        }
        
        List<GE_HQ_Account_Plan__Share> OldUsers= [Select Id,ParentId,UserOrGroupId from GE_HQ_Account_Plan__Share where ParentId in :ParentIds and UserOrGroupId in :OldUserIds];

        For(GE_HQ_Account_Plan_Team__c AP : Trigger.Old) {
            If(Trigger.newMap.get(AP.Id).GE_HQ_Acc_Plan_Team_Member__c != AP.GE_HQ_Acc_Plan_Team_Member__c) {
                For(GE_HQ_Account_Plan__Share rec:OldUsers) {
                    If(AP.GE_HQ_Acc_Plan_Team_Member__c == rec.UserOrGroupId && AP.GE_HQ_Acc_Plan_Name__c == rec.ParentId) DelList.add(rec);
                }
            }
        }
        If(DelList.size() > 0) { Delete DelList; Insert InsertList; }
        
        List<GE_HQ_Account_Plan__Share> UpdateRecords = [Select Id,ParentId,UserOrGroupId from GE_HQ_Account_Plan__Share where ParentId in :ParentIds and UserOrGroupId in :UpdUserIds];
        For(GE_HQ_Account_Plan_Team__c AP : Trigger.New) {
            For(GE_HQ_Account_Plan__Share rec:UpdateRecords) {
                String AccLvl = (AP.GE_HQ_Access_Level__c == 'Read/Write') ? 'Edit' : 'Read';
                If(AP.GE_HQ_Acc_Plan_Team_Member__c == rec.UserOrGroupId && AP.GE_HQ_Acc_Plan_Name__c == rec.ParentId) { rec.AccessLevel= AccLvl; UpList.add(rec); }
            }
        }
        If(UpList.size() > 0) Update UpList;
    }    


    If(Trigger.isDelete) {
        List<GE_HQ_Account_Plan__Share> SharedUsers = new List<GE_HQ_Account_Plan__Share>();
        Set<Id> UserIds = new Set<Id>();
        Set<Id> ParentIds = new Set<Id>();
        Map<Id,Id> OldSharedRecords = new Map<Id,Id>(); // Users vs. Parents

        For(GE_HQ_Account_Plan_Team__c AP : Trigger.Old) {
            UserIds.add(AP.GE_HQ_Acc_Plan_Team_Member__c);
            ParentIds.add(AP.GE_HQ_Acc_Plan_Name__c);
        }
        List<GE_HQ_Account_Plan__Share> OldUsers = [Select Id,UserOrGroupId,ParentId from GE_HQ_Account_Plan__Share where ParentId in :ParentIds and UserOrGroupId in :UserIds];
        List<GE_HQ_Account_Plan__Share> DelList = new List<GE_HQ_Account_Plan__Share >();
        // Still Cross references may exist, eg. For A,B Account Plan, Two users U1,U2 are there then 4 records will come, and all will be deleted. So filtering required.
        If(OldUsers !=Null && OldUsers.size()>0) {
            For(GE_HQ_Account_Plan_Team__c AP : Trigger.Old) {
                For(GE_HQ_Account_Plan__Share rec:OldUsers) {
                    If(AP.GE_HQ_Acc_Plan_Team_Member__c == rec.UserOrGroupId && AP.GE_HQ_Acc_Plan_Name__c == rec.ParentId) DelList.add(rec);
                }
            }
        }
        If(DelList.size() > 0) Delete DelList;
    }
}