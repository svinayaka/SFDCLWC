/*
 * Author:      Unknown
 * Date:        Unknown
 * Purpose:     Create/Update expertise record based on dispatch to work order
 *
 * History:
 * Date         Modifier        Notes
 *-------------|---------------|-----------------------------------------------------------------------------------
 *  2016-03-10  Chris Hurd      Added functionality to send email alert to Resource Manager notifying when new expertise
 *                              is created for a technician.
 */
 public class GE_OG_GS_ExpertiseUsage {
    
    public static void updateExpertiseUsage(List<SVMXC__Service_Order__c> woList, Map<Id, SVMXC__Service_Order__c> oldMap)
    {
        Set<String> skillSet = new Set<String>();
        Set<Id> techIdSet = new Set<Id>();
        List<SVMXC__Service_Group_Skills__c> updatedSkillList = new List<SVMXC__Service_Group_Skills__c>();
        List<SVMXC__Service_Group_Skills__c> newSubSkillList = new List<SVMXC__Service_Group_Skills__c>();
        
        Map<String, SVMXC__Service_Group_Skills__c> updatedExpertisesMap = new Map<String, SVMXC__Service_Group_Skills__c>();
        Map<String, SVMXC__Service_Group_Skills__c> newExpertisesMap = new Map<String, SVMXC__Service_Group_Skills__c>();
        
        List<SVMXC__Service_Order__c> updatedList = new List<SVMXC__Service_Order__c>();
        Map<Id, Map<Id, SVMXC__Service_Group_Skills__c>> techExpMap = new Map<ID, Map<Id, SVMXC__Service_Group_Skills__c>>();
        
        Set<Id> rtIdSet = new Set<Id>();
        Map<String, Schema.RecordTypeInfo> WORType = Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName(); 
        for (String rtName : WORType.keySet())
        {
            if (rtName.startsWith('GS'))
            {
                rtIdSet.add(WORType.get(rtName).getRecordTypeId());
            }
        }
        
        for (SVMXC__Service_Order__c wo : woList)
        {
            if (rtIdSet.contains(wo.RecordTypeId) 
                    && wo.SVMXC__Order_Status__c == 'Completed' 
                    && wo.SVMXC__Completed_Date_Time__c == null 
                    && wo.GE_OG_GS_Skill_Requirement__c != null
                    && wo.SVMXC__Group_Member__c != null
                    && wo.SVMXC__Order_Status__c != oldMap.get(wo.Id).SVMXC__Order_Status__c)
            {
                skillSet.add(wo.GE_OG_GS_Skill_Requirement__c);
                techIdSet.add(wo.SVMXC__Group_Member__c);
                updatedList.add(wo);
                techExpMap.put(wo.SVMXC__Group_Member__c, new Map<Id, SVMXC__Service_Group_Skills__c>());
            }
        }
        
        
        if (! updatedList.isEmpty())
        {
            Set<Id> skillIdSet = new Set<Id>();
            Map<String, Id> skillNameMap = new Map<String, Id>();
            Map<Id, Id> skillRootMap = new Map<Id, Id>();
            Set<Id> updatedIdSet = new Set<Id>();
 
            Map<Id, SVMXC__Service_Group_Members__c> techMap = new Map<Id, SVMXC__Service_Group_Members__c>([SELECT Id, SVMXC__Service_Group__c, GE_OG_DS_Supervisor_Name__c, GE_OG_MC_Supervisor_E_mail__c FROM SVMXC__Service_Group_Members__c WHERE Id IN :techIdSet]);
            
            for (SVMXC__Skill__c skill : [SELECT Id, GE_OG_GS_Root_Skill_link__c, GE_OG_GS_Root_Skill_link__r.Name, Name FROM SVMXC__Skill__c WHERE Name IN :skillSet ])
            {
                skillNameMap.put(skill.Name, skill.Id);
                skillIdSet.add(skill.Id);
                
                if (skill.GE_OG_GS_Root_Skill_link__c != null)
                {
                    skillRootMap.put(skill.Id, skill.GE_OG_GS_Root_Skill_link__c);
                    skillNameMap.put(skill.GE_OG_GS_Root_Skill_link__r.Name, skill.GE_OG_GS_Root_Skill_link__c);
                    skillIdSet.add(skill.GE_OG_GS_Root_Skill_link__c);
                }
                else {
                    skillRootMap.put(skill.Id, skill.Id); 
                }
            }
            
            for (SVMXC__Service_Group_Skills__c exp : [SELECT Id, SVMXC__Service_Group__c, SVMXC__Group_Member__c, SVMXC__Skill__c, GE_OG_GS_Root_Expertise_Link__c, GE_OG_GS_Expertise_Usage_Counter__c FROM SVMXC__Service_Group_Skills__c WHERE SVMXC__Group_Member__c IN :techIdSet AND SVMXC__Skill__c IN :skillIdSet])
            {
                techExpMap.get(exp.SVMXC__Group_Member__c).put(exp.SVMXC__Skill__c, exp);
            }
            
            for (SVMXC__Service_Order__c wo : updatedList)
            {

                wo.SVMXC__Completed_Date_Time__c = system.now();
                SVMXC__Service_Group_Members__c tech = techMap.get(wo.SVMXC__Group_Member__c);
                
                if (skillNameMap.containsKey(wo.GE_OG_GS_Skill_Requirement__c) && techExpMap.containsKey(wo.SVMXC__Group_Member__c) && techExpMap.get(wo.SVMXC__Group_Member__c).containsKey(skillNameMap.get(wo.GE_OG_GS_Skill_Requirement__c)))
                {
                    SVMXC__Service_Group_Skills__c s = techExpMap.get(wo.SVMXC__Group_Member__c).get(skillNameMap.get(wo.GE_OG_GS_Skill_Requirement__c));
                    s.GE_OG_GS_Expertise_Usage_Counter__c = (s.GE_OG_GS_Expertise_Usage_Counter__c != null ? s.GE_OG_GS_Expertise_Usage_Counter__c : 0) + 1;
                    if (updatedIdSet.add(s.Id))
                    {
                           addExpertiseToMap(updatedExpertisesMap,s);
                    }
                    
                    if (s.GE_OG_GS_Root_Expertise_Link__c != null)
                    {
                        s = techExpMap.get(wo.SVMXC__Group_Member__c).get(skillRootMap.get(skillNameMap.get(wo.GE_OG_GS_Skill_Requirement__c)));
                        if (s != null)
                        {
                            s.GE_OG_GS_Expertise_Usage_Counter__c = (s.GE_OG_GS_Expertise_Usage_Counter__c != null ? s.GE_OG_GS_Expertise_Usage_Counter__c : 0) + 1;
                            if (updatedIdSet.add(s.Id))
                            {
                                addExpertiseToMap(updatedExpertisesMap,s);
                            }
                        }
                    }
                }
                else if (skillNameMap.containsKey(wo.GE_OG_GS_Skill_Requirement__c))
                {
                    SVMXC__Service_Group_Skills__c rootSkill;
                    
                    if (techExpMap.get(wo.SVMXC__Group_Member__c).containsKey(skillRootMap.get(skillNameMap.get(wo.GE_OG_GS_Skill_Requirement__c))))
                    {
                        rootSkill = techExpMap.get(wo.SVMXC__Group_Member__c).get(skillRootMap.get(skillNameMap.get(wo.GE_OG_GS_Skill_Requirement__c)));
                      
                        if (rootSkill.GE_OG_GS_Expertise_Usage_Counter__c != null) {
                            rootSkill.GE_OG_GS_Expertise_Usage_Counter__c ++;
                        }
                        else {
                            rootSkill.GE_OG_GS_Expertise_Usage_Counter__c = 1;
                        }
                        
                        addExpertiseToMap(updatedExpertisesMap,rootSkill);
                        
                    }
                    else
                    {
                        rootSkill = new SVMXC__Service_Group_Skills__c();
                        rootSkill.SVMXC__Skill__c = skillRootMap.get(skillNameMap.get(wo.GE_OG_GS_Skill_Requirement__c));
                        rootSkill.SVMXC__Service_Group__c = tech.SVMXC__Service_Group__c;
                        rootSkill.SVMXC__Group_Member__c = tech.Id;
                        rootSkill.GE_OG_GS_Expertise_Usage_Counter__c = 1;
                        rootSkill.GE_OG_GS_Root_Qualification_Level__c = 'Entry Level';
                        addExpertiseToMap(updatedExpertisesMap,rootSkill);
                        techExpMap.get(wo.SVMXC__Group_Member__c).put(rootSkill.SVMXC__Skill__c, rootSkill);
                    }
                    if (! skillNameMap.get(wo.GE_OG_GS_Skill_Requirement__c).equals(rootSkill.SVMXC__Skill__c))  {
                        SVMXC__Service_Group_Skills__c newSkill = new SVMXC__Service_Group_Skills__c();
                        newSkill.SVMXC__Skill__c = skillNameMap.get(wo.GE_OG_GS_Skill_Requirement__c);
                        newSkill.SVMXC__Service_Group__c = tech.SVMXC__Service_Group__c;
                        newSkill.SVMXC__Group_Member__c = tech.Id;
                        newSkill.GE_OG_GS_Expertise_Usage_Counter__c = 1;
                        newSkill.GE_OG_GS_Root_Expertise_Link__r = rootSkill;
                        addExpertiseToMap(newExpertisesMap, newSkill);
                        techExpMap.get(wo.SVMXC__Group_Member__c).put(newSkill.SVMXC__Skill__c, newSkill);
                    }
                }
                
            }   
                if (! updatedExpertisesMap.values().isEmpty())
                {
                    upsert updatedExpertisesMap.values();
                }
            
                if (! newExpertisesMap.values().isEmpty())
                {
                    for (SVMXC__Service_Group_Skills__c skill : newExpertisesMap.values())
                    {
                        skill.GE_OG_GS_Root_Expertise_Link__c = skill.GE_OG_GS_Root_Expertise_Link__r.Id;
                    }
                    
                    insert newExpertisesMap.values();
    
                    EmailTemplate template = [SELECT Id FROM EmailTemplate WHERE DeveloperName = 'GE_OG_GS_New_Expertise_Notification' LIMIT 1];
                    List<Messaging.SingleEmailMessage> emailList = new List<Messaging.SingleEmailMessage>();
    
                    for (SVMXC__Service_Group_Skills__c skill : newExpertisesMap.values())
                    {
                        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                        email.setToAddresses(new List<String> {techMap.get(skill.SVMXC__Group_Member__c).GE_OG_MC_Supervisor_E_mail__c});
                        email.setTemplateId(template.Id);
                        email.setSaveAsActivity(false);
                        email.setTargetObjectId(UserInfo.getUserId());
                        email.setWhatId(skill.Id);
                        emailList.add(email);
                    }
    
                    try
                    {
                        Messaging.sendEmail(emailList);
                    }
                    catch (Exception ex) {
                        system.debug(ex.getStackTraceString());
                    }
                }                    
        }
    }
    
    private static void addExpertiseToMap(Map<String, SVMXC__Service_Group_Skills__c> expertiseMap, SVMXC__Service_Group_Skills__c newExpertise ) {
        String mapKey = '' + newExpertise.SVMXC__Skill__c+newExpertise.SVMXC__Group_Member__c;       
        if (! expertiseMap.containsKey(mapKey )) {
            expertiseMap.put(mapKey , newExpertise);            
        } else {
            expertiseMap.get(mapKey ).GE_OG_GS_Expertise_Usage_Counter__c ++;
        }
    }

}