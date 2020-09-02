public class GE_HQ_TechnicianResumeController {

    public String WOList { get; set; }

    public String DisplayWorkExperience { get; set; }

    public String TechSkills { get; set; }

    public String DisplaySkills { get; set; }
/*

    public string techId = System.currentPageReference().getParameters().get('techId');
    
    public SVMXC__Service_Group_Members__c technician {get; set;}
    public List<SVMXC__Service_Order__c> WOList {get; set;}
    public List<SVMXC__Service_Group_Skills__c> TechSkills {get; set;}
    public List<SVMXC__Service_Group_Members__c> techList {get; set;}
    public List<SVMXC__Service_Group_Skills__c> TechE {get; set;}
     public List<SVMXC__SVMX_Event__c> TechMWO {get; set;}
    public List<GE_OG_GS_Course__c> TechCA{get; set;}
    public List<GE_OG_GS_Certification__c> TechCe{get; set;}
    public List<GE_OG_GS_Passport__c> TechPP{get; set;}
    public List<GE_OG_GS_Visa__c> TechV{get; set;}
    
    public Boolean getDisplayWorkExperience() {
        if (WOList != null && WOList.size() > 0)
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    
    public Boolean getDisplaySkills() 
    {
        if (TechSkills.size() > 0)
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    
    public GE_HQ_TechnicianResumeController()
    {
    date d = system.today().addYears(-2);
     date d1 = system.today().addYears(-3);
       TechMWO= [select Id,SVMXC__EndDateTime__c,SVMXC__StartDateTime__c, SVMXC__Service_Order__r.GE_SM_HQ_Record_Type_Name__c, SVMXC__Service_Order__r.Name, SVMXC__Service_Order__r.SVMXC__Order_Status__c, SVMXC__Service_Order__r.GE_SS_Billable_Type__c, SVMXC__Service_Order__r.GE_SS_Job_Location__c, SVMXC__Service_Order__r.SVMXC__Company__r.Name, SVMXC__Service_Order__r.GE_SS_Product_Category__c,SVMXC__Service_Order__r.GE_SS_Product_Group__c, SVMXC__Service_Order__r.GE_SS_Job_Type_New__c, SVMXC__Service_Order__r.GE_SS_Field__r.Name from  SVMXC__SVMX_Event__c where SVMXC__Technician__c=:techId AND SVMXC__Service_Order__r.GE_SM_HQ_Record_Type_Name__c = 'SS-Mobilize' and SVMXC__Service_Order__r.SVMXC__Order_Status__c=:'Closed' and SVMXC__EndDateTime__c >: d ];
       
         techList = [SELECT Name, Id,GE_SM_HQ_Business_Unit__c,SVMXC__Email__c,GE_DS_Career_Track_Level__c,GE_SS_Project_Region__r.Name,Management_Country__c,GE_OG_DS_Supervisor_Name__c, GE_SM_HQ_Education__c FROM SVMXC__Service_Group_Members__c WHERE Id = :Id.valueOf(techId) ];
         
         TechE =[SELECT Name,Id, GE_DRL_Skill_Category__c,GE_SS_Skill_Group__c,SVMXC__Skill__c,SVMXC__Skill__r.Name,Expertise_Level__c,SVMXC__Group_Member__c FROM SVMXC__Service_Group_Skills__c Where SVMXC__Group_Member__c =: Id.valueOf(techId)];
         
         TechCA =[SELECT Name,Id, GE_OG_SS_Course_Category__c,GE_OG_SS_Master_Course__c,GE_OG_SS_Master_Course__r.Name,GE_OG_GS_Course_Status__c,GE_OG_GS_Target_Level__c,GE_OG_GS_Attended_Date__c,GE_OG_GS_Passed_Date__c,GE_DRL_Course_Expiry__c,GE_OG_SS_Course_Source__c FROM GE_OG_GS_Course__c Where GE_OG_GS_Course_Technician__c=: Id.valueOf(techId) and GE_OG_GS_Course_Status__c=:'Passed' and GE_OG_GS_Attended_Date__c >: d1 ];
         
         TechCe =[SELECT Name,Id,GE_OG_GS_Certificate_Name__c,GE_OG_GS_Category__c,GE_OG_GS_Status__c,GE_OG_GS_Acquired_Date__c,GE_OG_GS_Cert_Expiry_Date__c FROM GE_OG_GS_Certification__c Where GE_OG_GS_Cert_Technician__c=: Id.valueOf(techId) ];
         
         TechPP=[SELECT Name,Id,GE_OG_GS_Passport_Expiry__c,GE_OG_GS_Passport_Expiry_Date__c,GE_OG_GS_Passport_Type__c,GE_OG_GS_Remaining_Pages__c from GE_OG_GS_Passport__c Where GE_OG_GS_Technician__c=: Id.valueOf(techId) ];
         
         TechV=[SELECT Name,Id,GE_OG_GS_Passport__r.Name,GE_OG_GS_V_Passport_Expiry__c,GE_OG_GS_Passport__c,GE_OG_GS_Visa_Country__c,GE_OG_GS_Visa_Expiry__c,GE_OG_GS_Visa_Expiry_Date__c,GE_OG_GS_Visa_For__c from GE_OG_GS_Visa__c Where GE_OG_GS_Technician__c=: Id.valueOf(techId) ];
         
        if (techList.size() > 0)
        {
            technician = techList.get(0);
            
            WOList = new List<SVMXC__Service_Order__c>();
            Set<Id> idSet = new Set<Id>();
            for (SVMXC__Service_Order__c wo : [SELECT Id, SVMXC__State__c, GE_SM_HQ_Technician_Type__c, SVMXC__Skill__c, SVMXC__Skill__r.Name, GE_SM_HQ_Technology__c, SVMXC__City__c, SVMXC__Country__c, SVMXC__Company__r.Name, SVMXC__Closed_On__c,SVMXC__Scheduled_Date_Time__c, SVMXC__Problem_Description__c FROM SVMXC__Service_Order__c WHERE SVMXC__Group_Member__c = :Id.valueOf(techId) ORDER BY SVMXC__Scheduled_Date_Time__c])
            {
                if (idSet.add(wo.Id))
                {
                    WOList.add(wo);
                }
            }
            
            
            TechSkills = [SELECT Id, SVMXC__Skill__r.Name, Competency_Level__c, SVMXC_Qualification_Status__c FROM SVMXC__Service_Group_Skills__c WHERE SVMXC__Group_Member__c = :technician.Id AND SVMXC__Skill__r.GE_SM_HQ_Do_Not_Display_On_Resume__c = false AND SVMXC__Skill__r.GE_PW_PGS_Needs_Visa__c = false];
        }
          
    }
    
    public Date getToday()
    {
        return system.today();
    }
    */
    
    public list<GE_OG_TechBean.expertiseBean> lstExpertiseBeans {get;set;}
public list<GE_OG_TechBean.courseAssignmentBean> lstCourseAssignmentBeans {get;set;} 
public list<GE_OG_TechBean.certificationBean> lstCertificationBeans {get;set;}    
public list<GE_OG_TechBean.passportBean> lstPassportBeans {get;set;}
public list<GE_OG_TechBean.visaBean> lstVisaBeans {get;set;}
public list<SVMXC__Service_Order__c>TechMWO{get;set;}
public Id techId = ApexPages.currentPage().getParameters().get('techId');
public SVMXC__Service_Group_Members__c technician {get; set;}
public Integer expSkipper = 0;
GE_OG_TechResumeHelper helper;
public GE_HQ_TechnicianResumeController()
{
technician =[select id,GE_SM_HQ_Business_Unit__c,name,GE_SM_HQ_Education__c ,SVMXC__Email__c,GE_SS_Project_Region__r.name,GE_DS_Career_Track_Level__c,Management_Country__c,GE_OG_DS_Supervisor_Name__c      from SVMXC__Service_Group_Members__c  where id=:techId];
TechMWO=getworkorders(techId);
List<SVMXC__Service_Group_Skills__c> expertiseList = new List<SVMXC__Service_Group_Skills__c>();
lstExpertiseBeans = new List<GE_OG_TechBean.expertiseBean>();
helper = new GE_OG_TechResumeHelper();
lstExpertiseBeans = helper.getExpertises(techId); 
lstCourseAssignmentBeans = helper.getCourseAssignments(techId); 
lstCertificationBeans = helper.getCertifications(techId); 
lstPassportBeans = helper.getPassports(techId); 
lstVisaBeans = helper.getVisas(techId); 
}

public List<SVMXC__Service_Order__c> getworkorders(Id techid){
    List<SVMXC__SVMX_Event__c> eventlist = new List<SVMXC__SVMX_Event__c>();
    List<SVMXC__Service_Order__c> wolist1 = new List<SVMXC__Service_Order__c>();
    Set<Id> woids = new Set<Id>();

    eventlist = [select id,SVMXC__WhatId__c from SVMXC__SVMX_Event__c where SVMXC__Technician__c =: techId];
    if(eventlist.size()>0){
    for(SVMXC__SVMX_Event__c eve:eventlist){
        woids.add(eve.SVMXC__WhatId__c);
    }
    }
    
    if(woids.size()>0){
        wolist1 = [select id,name,GE_SS_Job_Location__c,GE_SS_Product_Category__c,GE_SS_Product_Group__c,GE_SS_Job_Type_New__c,
        GE_SS_Field__c,GE_SS_Field__r.name,GE_SS_Billable_Type__c,GE_SM_HQ_Planned_Start_Date__c,GE_SM_HQ_Planned_End_Date__c, 
        SVMXC__State__c, GE_SM_HQ_Technician_Type__c, SVMXC__Skill__c, SVMXC__Skill__r.Name, SVMXC__City__c,
         SVMXC__Country__c, SVMXC__Company__r.Name, SVMXC__Closed_On__c,SVMXC__Scheduled_Date_Time__c, SVMXC__Problem_Description__c
         from SVMXC__Service_Order__c where id in : woids];
    }
    
    return wolist1;
    
}

 public Date getToday()
    {
        return system.today();
    }
}