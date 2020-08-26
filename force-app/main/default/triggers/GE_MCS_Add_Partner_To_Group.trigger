/*
Name        : GE_MCS_Add_Partner_To_Group
Test class  : GE_MCS_Add_Partner_To_GroupTest
Purpose/Overview  : Automatically add new partner user to a public group (providing Library access) based on the Tier 3 value
Change History    : Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
                  : 2014-09-30    : Htut Zaw           : Initial creation
                  : 2014-10-31    : Ramaprasad S       : Modified to handle 38 chars Limit in Custom Setting name. Replaced ' &', ' -', '(', ')' to ''
*/
trigger GE_MCS_Add_Partner_To_Group on User (after insert, after update) {
    List<GroupMember> grpMemList = new List<GroupMember>();
    for(User usr : Trigger.New) {
        if(usr.usertype == 'PowerPartner' && 
                (usr.GE_HQ_Tier_3_P_L__c != null && usr.GE_HQ_Tier_3_P_L__c != ''))
        {
            String profId = usr.ProfileId;
            profId = profId.substring(0,15);
            String tier3char = usr.GE_HQ_Tier_3_P_L__c;
            tier3char = tier3char.replace('(','');
            tier3char = tier3char.replace(')','');
            tier3char = tier3char.replace(' &','');
            tier3char = tier3char.replace(' -','');
            GE_COMMUNITY_PROFILES__c prof = GE_COMMUNITY_PROFILES__c.getInstance(profId);
            if (prof != null)
            {
                GE_MCS_COMMUNITY_GROUPS__c commGrp = GE_MCS_COMMUNITY_GROUPS__c.getInstance(tier3char);
                if (commGrp != Null) {
                    GroupMember grpMem = new GroupMember();
                    grpMem.GroupId = commGrp.Public_Group_Id__c;
                    grpMem.UserOrGroupId = usr.Id;
                    grpMemList.add(grpMem);
                }
            }         
        }
    }
    if(!grpMemList.isEmpty()) {
        insert grpMemList;
    }
}