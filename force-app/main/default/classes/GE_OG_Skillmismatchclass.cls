public class GE_OG_Skillmismatchclass {
    Static Integer StopRecurse=0;
    public Static SVMXC__Service_Order__c Directoremail=new SVMXC__Service_Order__c();
    Static Boolean EmailStatus=True;
    public Static Id SendtoEmailId;
    public static void updateskillcheck(SVMXC__Service_Order__c workorder,String emailcheck) {
        System.debug('Workorder id'+workorder);
        workorder.GE_OG_SkillMismatchCheck__c=True;
        if(StopRecurse==0)// Added by hari
        update workorder;
        StopRecurse++;// Added by hari
/* R-29438
        Directoremail=[Select id,Name,SVMXC__Service_Group__r.ID,SVMXC__Service_Group__r.GE_HQ_Resource_Director__r.Email,SVMXC__Service_Group__r.GE_OG_Director_Email__c,SVMXC__Group_Member__r.Name,SVMXC__Skill__r.Name from SVMXC__Service_Order__c where id=:workorder.ID];
        SendtoEmailId=Directoremail.SVMXC__Service_Group__r.GE_HQ_Resource_Director__r.Id;
        if(emailcheck=='True'){
            if(EmailStatus){
                //String[] toAddresses1 = new String[] {Directoremail.SVMXC__Service_Group__r.GE_HQ_Resource_Director__r.Email}; 
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
               // mail.setToAddresses(toAddresses1);
                mail.setSenderDisplayName(Directoremail.Name);
                mail.setTargetObjectId(SendtoEmailId);
                mail.setSaveAsActivity(false);
                mail.setSubject('Skill Mismatched for' +Directoremail.Name);
                mail.setHtmlBody(+Directoremail.SVMXC__Group_Member__r.Name+' has been assigned to a job on '+Directoremail.Name+' they may not be certified for. This job requires ' +Directoremail.SVMXC__Skill__r.Name+', and '+Directoremail.SVMXC__Group_Member__r.Name+' record does not show certification for this skill.');
                Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
                
                String[] toAddresses = new String[] {Directoremail.SVMXC__Service_Group__r.GE_OG_Director_Email__c}; 
                if(Directoremail.SVMXC__Service_Group__r.GE_OG_Director_Email__c!=null){
                    Messaging.SingleEmailMessage mail1 = new Messaging.SingleEmailMessage();
                    mail1.setToAddresses(toAddresses);
                    mail1.setSenderDisplayName(Directoremail.Name);
                    mail1.setSubject('Skill Mismatched for' +Directoremail.Name);
                    mail1.setHtmlBody(+Directoremail.SVMXC__Group_Member__r.Name+' has been assigned to a job on '+Directoremail.Name+' they may not be certified for. This job requires ' +Directoremail.SVMXC__Skill__r.Name+', and '+Directoremail.SVMXC__Group_Member__r.Name+' record does not show certification for this skill.');
                    Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail1 });
                }
                EmailStatus=false;    
            }
        } */

    }
    public static void noexpertise(SVMXC__Service_Order__c workorder,SVMXC__Service_Group_Members__c tc,String emailcheckfornoexpert) {
        workorder.GE_OG_SkillMismatchCheck__c=True;
        if(StopRecurse==0)// Added by hari
        update workorder;
        StopRecurse++;// Added by hari
       /* R-29438 
        Directoremail=[Select id,Name,SVMXC__Service_Group__r.ID,SVMXC__Service_Group__r.GE_HQ_Resource_Director__r.Email,SVMXC__Service_Group__r.GE_OG_Director_Email__c,SVMXC__Group_Member__r.Name,SVMXC__Skill__r.Name from SVMXC__Service_Order__c where id=:workorder.ID And SVMXC__Service_Group__r.GE_HQ_Resource_Director__r.Email!=''];
        
        SendtoEmailId=Directoremail.SVMXC__Service_Group__r.GE_HQ_Resource_Director__r.Id;
        if(emailcheckfornoexpert=='True') {
            if(EmailStatus) {
                //String[] toAddresses1 = new String[] {Directoremail.SVMXC__Service_Group__r.GE_HQ_Resource_Director__r.Email}; 
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                //mail.setToAddresses(toAddresses1);
                mail.setSenderDisplayName(Directoremail.Name);
                mail.setTargetObjectId(SendtoEmailId);
                mail.setSaveAsActivity(false);
                mail.setSubject('Skill Mismatched for' +Directoremail.Name);
                mail.setHtmlBody(+Directoremail.SVMXC__Group_Member__r.Name+' has been assigned to a job on '+Directoremail.Name+' they may not be certified for. This job requires ' +Directoremail.SVMXC__Skill__r.Name+', and '+Directoremail.SVMXC__Group_Member__r.Name+' record does not show certification for this skill.');
                Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
                
                String[] toAddresses = new String[] {Directoremail.SVMXC__Service_Group__r.GE_OG_Director_Email__c}; 
                if(Directoremail.SVMXC__Service_Group__r.GE_OG_Director_Email__c!=null){
                    Messaging.SingleEmailMessage mail1 = new Messaging.SingleEmailMessage();
                    mail1.setToAddresses(toAddresses);
                    mail1.setSenderDisplayName(Directoremail.Name);
                    mail1.setSubject('Skill Mismatched for' +Directoremail.Name);
                    mail1.setHtmlBody(+Directoremail.SVMXC__Group_Member__r.Name+' has been assigned to a job on '+Directoremail.Name+' they may not be certified for. This job requires ' +Directoremail.SVMXC__Skill__r.Name+', and '+Directoremail.SVMXC__Group_Member__r.Name+' record does not show certification for this skill.');
                    Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail1 });
                }
                EmailStatus=False;
            }
        } */
    }
    
    public static void GE_OG_SkillMismatch(List <SVMXC__SVMX_Event__c> newEvents, Boolean isInsert, Boolean isUpdate) {
        List<SVMXC__Service_Order__c> worklistondelete=new List<SVMXC__Service_Order__c>();
        List<SVMXC__Service_Group_Skills__c> expertise = new List<SVMXC__Service_Group_Skills__c>();
        List<String> uncheckwhatid=new List<String>();
        SVMXC__Service_Order__c SO1=new SVMXC__Service_Order__c();
        List<SVMXC__Service_Order__c> uncheckskill=new List<SVMXC__Service_Order__c>();
        Map<String,SVMXC__Service_Order__c> uncheckWoID=new Map<String,SVMXC__Service_Order__c>(); 
        Map<String,SVMXC__Service_Order__c> WoID=new Map<String,SVMXC__Service_Order__c>(); 
        Set<SVMXC__Service_Order__c> NoexpWO=new Set<SVMXC__Service_Order__c>();
        List<SVMXC__Service_Order__c> SO=new List<SVMXC__Service_Order__c>();
        //Set<SVMXC__Service_Order__c> putWo=new Set<SVMXC__Service_Order__c>();
        Map<Id,SVMXC__Service_Group_Members__c> skillmap=new Map<Id,SVMXC__Service_Group_Members__c>();
        Map<String, Schema.SObjectType> sObjectMap = Schema.getGlobalDescribe() ;
        Schema.SObjectType s = sObjectMap.get('SVMXC__Service_Order__c') ; // getting Sobject Type
        Schema.DescribeSObjectResult resSchema = s.getDescribe() ;
        Map<String,Schema.RecordTypeInfo> recordTypeInfo = resSchema.getRecordTypeInfosByName(); //getting all Recordtype for the Sobject
        Id rtId = recordTypeInfo.get('MCS').getRecordTypeId();
        List<String> whatid=new List<String>();
        List<String> techskill=new List<String>();
        system.debug('##############RecordTypeId###########'+rtId);
        List<GE_MC_Skill_Business_Unit_Service_Region__c> busr= GE_MC_Skill_Business_Unit_Service_Region__c.getall().values();
        List<SVMXC__SVMX_Event__c> eventlist=new List<SVMXC__SVMX_Event__c>();
        SVMXC__Service_Order__c ServiceOrder=new SVMXC__Service_Order__c();
        String emailcheck;
        //public static String isdel;
        //Public boolean expertisecheck=true;
        String skillmatched='False';
        if(isInsert){
            emailcheck='True';
        }
        if(isInsert || isUpdate) {    
            if(busr != null && busr.size()>0) {   
                for(SVMXC__SVMX_Event__c SMEvent : newEvents) {
                    eventlist.add(SMEvent);
                }
                for(SVMXC__SVMX_Event__c ss:eventlist){
                    whatid.add(ss.SVMXC__WhatId__c);    
                    techskill.add(ss.SVMXC__Technician__c);
                }
                if(whatid.size()>0)
                WoID.putall([SELECT Id,GE_OG_MC_Service_Region__c,SVMXC__Skill__r.Name, Name,GE_OG_MC_Business_Unit__c,SVMXC__Skill__c,SVMXC__Group_Member__r.Name,SVMXC__Service_Group__c,SVMXC__Group_Member__c,RecordTypeId FROM SVMXC__Service_Order__c WHERE ID IN:whatid and RecordTypeId =:rtId]);
                
                if(WoID != null && WoID.size()>0) {
                    if(techskill.size()>0)
                    skillmap.putall([Select id,(select id,SVMXC__Skill__c from SVMXC__Service_Group_Skills__r),(Select id from SVMXC__Service_Order__r) from SVMXC__Service_Group_Members__c where ID IN :techskill]);
                        for(SVMXC__Service_Group_Members__c tc:skillmap.values()) {
                            for(SVMXC__Service_Order__c work:WoID.values()) {
                                if(rtId==work.RecordTypeId) {
                                    if(work.GE_OG_MC_Business_Unit__c!=Null&&work.GE_OG_MC_Service_Region__c!=Null) {
                                        try {
                                            System.debug('inside try');
                                            //Bug# 0000025702: Added for multidispatching technicians of WO
                                            if(tc.getSObjects('SVMXC__Service_Group_Skills__r')!=Null) {
                                            expertise=tc.getSObjects('SVMXC__Service_Group_Skills__r');
                                            }
                                            if(expertise.size()>0) {
                                                for(GE_MC_Skill_Business_Unit_Service_Region__c bs:busr) {
                                                    if(work.GE_OG_MC_Business_Unit__c==bs.GE_OG_MC_Business_Unit__c&&work.GE_OG_MC_Service_Region__c==bs.GE_OG_MC_Service_Region__c) {
                                                        for(SVMXC__Service_Group_Skills__c expert: expertise) {
                                                            if(work.SVMXC__Skill__c!=expert.SVMXC__Skill__c) {
                                                                system.debug('inside if'+work);
                                                                SO.add(work);    
                                                            }
                                                            else {
                                                                skillmatched='True';
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        } Catch(NullPointerException e) {
                                            for(GE_MC_Skill_Business_Unit_Service_Region__c bs:busr) {
                                                if(work.GE_OG_MC_Business_Unit__c==bs.GE_OG_MC_Business_Unit__c&&work.GE_OG_MC_Service_Region__c==bs.GE_OG_MC_Service_Region__c) {
                                                    System.debug('inside catch'+work);                                              
                                                    NoexpWO.add(work);
                                                    SO1=work;
                                                    system.debug('SO1'+SO1+ 'tc'+tc +'emailcheck'+emailcheck);
                                                    GE_OG_Skillmismatchclass.noexpertise(SO1,tc,emailcheck);
                                                }
                                            }
                                        }
                                    }
                                }                   
                            }    
                        }
                    } // added by Raj
            }
        }
        system.debug('SO'+SO+'expertise'+expertise+'skillmatched'+skillmatched);
        if(SO.size()>0&&expertise.Size()>0&&skillmatched=='false') {
            ServiceOrder=SO[0];
            GE_OG_Skillmismatchclass.updateskillcheck(ServiceOrder,emailcheck);
        }
    }
}