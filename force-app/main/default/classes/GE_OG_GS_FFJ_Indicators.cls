/*
Class Name                   - GE_OG_GS_FFJ_Indicators  
Object Name                  - SVMXC__SVMX_Event__c
Created Date                 - 11/11/2015
Description                  -  Handler Class for requirement R-23659 : Fit For Job Managment. Is called from GE_OG_SVMX_Event_TriggerHandler
*/
public class GE_OG_GS_FFJ_Indicators {
    public void CreateFFJIndicators(List<SVMXC__SVMX_Event__c> newObjects){
        //String sWORecordTypes = GE_OG_GS_Fit_For_Job__c.getInstance('Record Types List').GE_OG_GS_Record_Types_To_Apply__c;
        //List<String> listWORecordTypes = sWORecordTypes.split(',');
        SVMXC__Service_Group_Skills__c[] oExpertise;
        //Set<String> setWORecordTypes = new Set<String>();
        Set<Id> setWOIds = new Set<Id>();
        Set<Id> setSMEventIds = new Set<Id>();
        Set<String> setSkillRequirement = new Set<String>();
        List<SVMXC__SVMX_Event__c> listSMEvents = new List<SVMXC__SVMX_Event__c>(); 
        //SVMXC__Skill__c[] oSkill;
        String sRootSkill;
        String sMinCert;
        String sOfficialCert;
        String sCompetency;
        String sMinCerInd;    
        //setWORecordTypes.addAll(listWORecordTypes);
        for(SVMXC__SVMX_Event__c objEvent : newObjects){
            setSMEventIds.add(objEvent.Id);
            setWOIds.add(objEvent.SVMXC__Service_Order__c);	 
        }
        listSMEvents = [Select Id, SVMXC__Service_Order__c, SVMXC__Service_Order__r.RecordType.Name, SVMXC__Service_Order__r.GE_SM_HQ_Record_Type_Name__c, SVMXC__Service_Order__r.GE_OG_GS_Skill_Requirement__c, 
                            SVMXC__Service_Order__r.GE_SS_Project__r.GE_OG_GS_Minimum_Certification__c ,SVMXC__Technician__c from SVMXC__SVMX_Event__c where id IN :setSMEventIds];
        Map<Id,SVMXC__Service_Order__c> mapWOToUpdate= new Map<Id,SVMXC__Service_Order__c>([select Id from SVMXC__Service_Order__c where Id IN :setWOIds]);
        
        for(SVMXC__SVMX_Event__c oSMEvent :listSMEvents){
            setSkillRequirement.add(oSMEvent.SVMXC__Service_Order__r.GE_OG_GS_Skill_Requirement__c);   
        }
        List<SVMXC__Skill__c> listSkills = new List<SVMXC__Skill__c>([select Id, Name, GE_OG_GS_Skill_Root_Skill__c from SVMXC__Skill__c where Name IN :setSkillRequirement]);
        Map<String,String> mapSkillRootSkill = new Map<String,String>();
        for(SVMXC__Skill__c oSkill :listSkills){
            mapSkillRootSkill.put(oSkill.Name, oSkill.GE_OG_GS_Skill_Root_Skill__c);        
        }   
        
        for(SVMXC__SVMX_Event__c oSMEvent :listSMEvents){
            //if(setWORecordTypes.contains(oSMEvent.SVMXC__Service_Order__r.GE_SM_HQ_Record_Type_Name__c)){
            if(oSMEvent.SVMXC__Service_Order__r.GE_SM_HQ_Record_Type_Name__c == 'GS-Requirement'){
                //Competency Matrix
                oExpertise = [Select Id from SVMXC__Service_Group_Skills__c where SVMXC__Group_Member__c = :oSMEvent.SVMXC__Technician__c and 
                                SVMXC__Skill__r.Name = :oSMEvent.SVMXC__Service_Order__r.GE_OG_GS_Skill_Requirement__c];
                if(oExpertise.size() > 0){
                    sCompetency = 'Green';
                }
                else{
                    sCompetency = 'Red';
                }
                if(sCompetency == 'Green'){
                    mapWOToUpdate.get(oSMEvent.SVMXC__Service_Order__c).GE_OG_GS_Competency_Text__c = 'Green';    
                }
                else{
                    mapWOToUpdate.get(oSMEvent.SVMXC__Service_Order__c).GE_OG_GS_Competency_Text__c = 'Red';    
                }
                //Expertise Certification level of the FSE versus Project Scope of Work 
                sMinCert = oSMEvent.SVMXC__Service_Order__r.GE_SS_Project__r.GE_OG_GS_Minimum_Certification__c;
                sMinCerInd = 'Red';
                if(sMinCert == 'No Certification'){
                    sMinCerInd = 'Green';
                }
                else{
                    if(mapSkillRootSkill.get(oSMEvent.SVMXC__Service_Order__r.GE_OG_GS_Skill_Requirement__c) != NULL){
                        sRootSkill = mapSkillRootSkill.get(oSMEvent.SVMXC__Service_Order__r.GE_OG_GS_Skill_Requirement__c);    
                    }
                    else{
                       sRootSkill = ''; 
                    }
                    oExpertise = [Select Id, GE_OG_GS_Official_Certification_Level__c from SVMXC__Service_Group_Skills__c where SVMXC__Group_Member__c 
                                     = :oSMEvent.SVMXC__Technician__c and GE_OG_GS_Root_Expertise_Skill__c = :sRootSkill limit 1];
                    if(oExpertise.size() > 0){
                        sOfficialCert = oExpertise[0].GE_OG_GS_Official_Certification_Level__c;
                        if((sMinCert == 'FSE' && (sOfficialCert == 'FSE' || sOfficialCert == 'LFSE' || sOfficialCert == 'SFSE' || sOfficialCert == 'MFSE')) ||
                           (sMinCert == 'LFSE' && (sOfficialCert == 'LFSE' || sOfficialCert == 'SFSE' || sOfficialCert == 'MFSE')) ||
                           (sMinCert == 'SFSE' && (sOfficialCert == 'SFSE' || sOfficialCert == 'MFSE')) ||
                           (sMinCert == 'MFSE' && sOfficialCert == 'MFSE')){
                            sMinCerInd = 'Green';
                        }
                    }
                }
                if(sMinCerInd == 'Green'){
                    mapWOToUpdate.get(oSMEvent.SVMXC__Service_Order__c).GE_OG_GS_Minimum_Certification_Text__c = 'Green';
                }
                else{
                    mapWOToUpdate.get(oSMEvent.SVMXC__Service_Order__c).GE_OG_GS_Minimum_Certification_Text__c = 'Red';
                }
                //populate Justification of skill MisMatch
            	if(sCompetency == 'Green' && sMinCerInd == 'Green'){
                	mapWOToUpdate.get(oSMEvent.SVMXC__Service_Order__c).GE_OG_MC_Justification_of_skill_MisMatch__c = 'FFJ Match';
            	}
            	else{
                	mapWOToUpdate.get(oSMEvent.SVMXC__Service_Order__c).GE_OG_MC_Justification_of_skill_MisMatch__c = Null;    
            	}
            }
            
            
            
        }
        if(mapWOToUpdate.values().size() > 0){
            update mapWOToUpdate.values();
        }
    }

}