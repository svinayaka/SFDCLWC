public class GE_PC_ExpertiseTechnicianUpdate {
    
   public void ExperienceUpdate(list<SVMXC__Service_Group_Skills__c> lExpertise){
       set<Id> sIds = new set<Id>();
       set<Id> sExIds = new set<Id>();
       map<Id, String> mExpSkill = new map<Id, String>();
       map<Id, Decimal> mExpSkillExp = new map<Id, Decimal>();
       set<Id> technicianID = new set<Id>();
       list<SVMXC__Service_Group_Members__c> lMembers = new list<SVMXC__Service_Group_Members__c>();
      ID PCRectype=Schema.SObjectType.SVMXC__Service_Group_Skills__c.getRecordTypeInfosByName().get('PC').getRecordTypeId();
     
       /* for(SVMXC__Service_Group_Skills__c skill: [select id, SVMXC__Skill__r.GE_PC_Parent_Skill__c, SVMXC__Group_Member__r.GE_PC_Parent_Skill__c from SVMXC__Service_Group_Skills__c where id in:lExpertise]){
           System.debug('skill' + skill); 
           sIds.add(skill.SVMXC__Group_Member__c);
           system.debug('skill.SVMXC__Skill__r.GE_PC_Parent_Skill__c'+skill.SVMXC__Skill__r.GE_PC_Parent_Skill__c);
           system.debug('skill.SVMXC__Group_Member__r.GE_PC_Parent_Skill__c'+skill.SVMXC__Group_Member__r.GE_PC_Parent_Skill__c);
           String SkillData=skill.SVMXC__Group_Member__r.GE_PC_Parent_Skill__c;
           System.debug('SkillData' + SkillData);
             if(SkillData!=null && SkillData.contains(skill.SVMXC__Skill__r.GE_PC_Parent_Skill__c)){
                 system.debug('skill'+skill);
                  sExIds.add(skill.Id);
           }
        } 
       system.debug('sExIds'+sExIds);
        ID PCRectype=Schema.SObjectType.SVMXC__Service_Group_Skills__c.getRecordTypeInfosByName().get('PC').getRecordTypeId();
        list<SVMXC__Service_Group_Members__c> lTechnicians = new list<SVMXC__Service_Group_Members__c>();
       
        AggregateResult[] expertiseRes= [select sum(GE_PC_Experience_Points__c),SVMXC__Group_Member__c from SVMXC__Service_Group_Skills__c 
                                                where SVMXC__Group_Member__c in:sIds and GE_PC_Sign_Off__c=True and GE_PC_Experience_Points__c!=Null and RecordTypeId=:PCRectype and SVMXC__Group_Member__c in:sIds and Id not in:sExIds
                                          Group by SVMXC__Group_Member__c];
            for(AggregateResult result : expertiseRes){
            System.debug('result is'+ result);
            Decimal sumOfExperience = (decimal)result.get('expr0');
            Id serviceMember =(Id)result.get('SVMXC__Group_Member__c');
            lTechnicians.add(new SVMXC__Service_Group_Members__c(Id=serviceMember,GE_PC_Experience_Points__c=sumOfExperience));
                }
       if(lTechnicians.size()>0){
            update lTechnicians;
          }*/
      ID PCRecdtype=Schema.SObjectType.SVMXC__Service_Group_Skills__c.getRecordTypeInfosByName().get('PC').getRecordTypeId(); 
       for(SVMXC__Service_Group_Skills__c skill1: lExpertise){
           if(skill1.recordtypeid==PCRecdtype){
          technicianID.add(skill1.SVMXC__Group_Member__c);
           }
        }
        for(SVMXC__Service_Group_Skills__c skEprt:[select id,SVMXC__Skill__r.GE_PC_Parent_Skill__c, GE_PC_Experience_Points__c, SVMXC__Group_Member__c from SVMXC__Service_Group_Skills__c where SVMXC__Group_Member__c in:technicianID and GE_PC_Sign_Off__c=True and RecordTypeId=:PCRectype and GE_PC_Experience_Points__c!=Null and SVMXC__Skill__r.GE_PC_Parent_Skill__c!=Null]){
            if(!mExpSkill.containskey(skEprt.SVMXC__Group_Member__c)){
                 mExpSkill.put(skEprt.SVMXC__Group_Member__c,skEprt.SVMXC__Skill__r.GE_PC_Parent_Skill__c);
                mExpSkillExp.put(skEprt.SVMXC__Group_Member__c,skEprt.GE_PC_Experience_Points__c);
            }
            else{
                 String Skill1 = mExpSkill.get(skEprt.SVMXC__Group_Member__c);
                Decimal exp = mExpSkillExp.get(skEprt.SVMXC__Group_Member__c);
                if(!skill1.contains(skEprt.SVMXC__Skill__r.GE_PC_Parent_Skill__c)){
                   skill1=skill1+''+ ';'+skEprt.SVMXC__Skill__r.GE_PC_Parent_Skill__c;
                    exp=mExpSkillExp.get(skEprt.SVMXC__Group_Member__c);
                    exp=exp+skEprt.GE_PC_Experience_Points__c;
                }               
                
                mExpSkill.put(skEprt.SVMXC__Group_Member__c, skill1);
                mExpSkillExp.put(skEprt.SVMXC__Group_Member__c,exp);
                     
            }
        }
       system.debug('mExpSkillExp'+mExpSkillExp);
            if(mExpSkill.size()>0){
               for(Id techID: mExpSkill.keyset()){
                   lMembers.add(new SVMXC__Service_Group_Members__c(Id=techID, GE_PC_Parent_Skill__c= mExpSkill.get(techID), GE_PC_Experience_Points__c=mExpSkillExp.get(techID) ));
               }
               if(lMembers.size()>0)
                   update lMembers;
            }
         }
}