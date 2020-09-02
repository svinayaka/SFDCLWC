/*
 * Author:      Chris Hurd (chris.hurd@bolt-data.com)
 * Date:        2016-03-09
 * Purpose:     Validate that there is only one 'Primary Skill' Expertise for a particular technician
 *
 * History:
 * Date         Modifier        Notes
 *-------------|---------------|-----------------------------------------------------------------------------------
 */
public class GE_OG_GS_PrimaryExpertise {
    
    public static void validateSinglePrimarySkill(List<SVMXC__Service_Group_Skills__c> expList, Map<Id, SVMXC__Service_Group_Skills__c> oldMap, Boolean isInsert)
    {
        List<SVMXC__Service_Group_Skills__c> updatedList = new List<SVMXC__Service_Group_Skills__c>();
        Map<Id, Map<Id, SVMXC__Service_Group_Skills__c>> techSkillMap = new Map<Id, Map<Id, SVMXC__Service_Group_Skills__c>>();
        Set<Id> nonPrimaryExpSet = new Set<Id>();

        for (SVMXC__Service_Group_Skills__c exp : expList)
        {
            if (exp.SVMXC_Primary_Skill__c && exp.SVMXC__Group_Member__c != null && (isInsert || ! oldMap.get(exp.Id).SVMXC_Primary_Skill__c))
            {
                techSkillMap.put(exp.SVMXC__Group_Member__c, new Map<ID, SVMXC__Service_Group_Skills__c>());
                updatedList.add(exp);
                system.debug('***debug1'+updatedList.add(exp));
            }

            if (! isInsert && ! exp.SVMXC_Primary_Skill__c && oldMap.get(exp.Id).SVMXC_Primary_Skill__c)
            {
                nonPrimaryExpSet.add(exp.Id);
            }

        }
             system.debug('***debug2'+updatedList);
        if (! updatedList.isEmpty())
        {
            for (SVMXC__Service_Group_Skills__c exp : [SELECT Id, SVMXC__Skill__c, SVMXC__Group_Member__c FROM SVMXC__Service_Group_Skills__c WHERE SVMXC__Group_Member__c IN :techSkillMap.keySet() AND SVMXC__Service_Group__r.GE_HQ_P_L_Level__c = 'Turbomachinery Solutions' AND SVMXC_Primary_Skill__c = true])
            {
                system.debug('***debug4'+nonPrimaryExpSet.contains(exp.Id));
                if (! nonPrimaryExpSet.contains(exp.Id))
                {
                    techSkillMap.get(exp.SVMXC__Group_Member__c).put(exp.Id, exp);
                }
            }
                system.debug('***debug4'+updatedList);
            for (SVMXC__Service_Group_Skills__c exp : updatedList)
            {
                system.debug('***debug3'+techSkillMap.get(exp.SVMXC__Group_Member__c));
                if (! techSkillMap.get(exp.SVMXC__Group_Member__c).isEmpty())
                {
                    exp.SVMXC_Primary_Skill__c.addError(system.label.GE_OG_GS_Only_One_Primary_Skill_Allowed);
                    techSkillMap.get(exp.SVMXC__Group_Member__c).put(null, exp);
                }
            }
        }
    }
}