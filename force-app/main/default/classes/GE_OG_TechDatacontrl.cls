/*
Class Name                   - GE_OG_TechDatacontrl
Test Class Name              - GE_OG_TechData_Test
Created Date                 -  3/24/2017 
Description                  -  This Controller Class will wrap the data into Visualforce page queried from the objects -
                                 Expertise, CourseAssignments, Certifications, Passport and Visa of the Technician
Requirment #                 - R-25711
*/

public class GE_OG_TechDatacontrl{

public list<GE_OG_TechBean.expertiseBean> lstExpertiseBeans {get;set;}
public list<GE_OG_TechBean.courseAssignmentBean> lstCourseAssignmentBeans {get;set;} 
public list<GE_OG_TechBean.certificationBean> lstCertificationBeans {get;set;}    
public list<GE_OG_TechBean.passportBean> lstPassportBeans {get;set;}
public list<GE_OG_TechBean.visaBean> lstVisaBeans {get;set;}
public list<GE_OG_TechBean.techAttachBean> lsttechAttachBeans{get;set;}
public SVMXC__Service_Group_members__c technician {get;set;}  


public Id techId = ApexPages.currentPage().getParameters().get('techId');
public boolean flag = false;
public list<GE_OG_TechBean.expertiseBean> tempList = new list<GE_OG_TechBean.expertiseBean>();
public Integer limit_size = 10;

public Integer expIndex = 10;
public Integer expSkipper = 0;
public Integer courseIndex = 10;
public Integer courseSkipper = 0;
public Integer certiIndex = 10;
public Integer certiSkipper = 0;
public Integer passportIndex = 10;
public Integer passportSkipper = 0;
public Integer visaIndex = 10;
public Integer visaSkipper = 0;
public Integer techAttachSkipper = 0; //Addition
public Integer techAttachIndex = 10; //Addition

       
    public Boolean expNextBool {get;set;}
    public Boolean expPrevBool {get;set;}   
    public Boolean courseNextBool {get;set;}
    public Boolean coursePrevBool {get;set;}    
    public Boolean certiNextBool {get;set;}
    public Boolean certiPrevBool {get;set;}     
    public Boolean passportNextBool {get;set;}
    public Boolean passportPrevBool {get;set;}  
    public Boolean visaNextBool {get;set;}
    public Boolean visaPrevBool {get;set;}
    public Boolean techAttachNextBool {get;set;} //Addition
    public Boolean techAttachPrevBool {get;set;} //Addition   
    public Boolean showedit {get;set;}
    
    public Integer expCount {get;set;}
    public Integer courseCount {get;set;}
    public Integer certiCount {get;set;}
    public Integer passportCount {get;set;}
    public Integer visaCount {get;set;}
    public Integer techAttachCount {get;set;}//Addition
    
    public String careerTrackLevel{get;set;}
    
    GE_OG_TechDataHelper helper;

 /*@TestVisible
   class techattachWrapper
    {
        public List<techAttachmentbean> techAttachmentlist{get;set;}
        public GE_OG_GS_Technician_Attachment__c objtechattach{get;set;}
        public attachWrapper()
        {
            
            objtechattach = new GE_OG_GS_Technician_Attachment__c();
        }
    }*/
public GE_OG_TechDatacontrl()
{     
    //Technician Details
    technician = [ SELECT Id, Name,GE_DS_Career_Track_Level__c, SVMXC__Service_Group__r.Name, SVMXC__Salesforce_User__r.Id FROM SVMXC__Service_Group_members__c
       WHERE Id =: techId];   
          careerTrackLevel= technician.GE_DS_Career_Track_Level__c;
          if(userinfo.getUserId()==technician.SVMXC__Salesforce_User__r.Id)
          {
              flag = true;
          }             
    if(flag)
    {
        expCount = [SELECT Count() FROM SVMXC__Service_Group_Skills__c where SVMXC__Group_Member__r.Id=: techId];
        courseCount = [SELECT Count() FROM GE_OG_GS_Course__c where GE_OG_GS_Course_Technician__r.Id=: techId];
        certiCount = [SELECT Count() FROM GE_OG_GS_Certification__c where GE_OG_GS_Cert_Technician__r.Id=: techId];
        passportCount = [SELECT Count() FROM GE_OG_GS_Passport__c where GE_OG_GS_Technician__r.Id=: techId];
        visaCount = [SELECT Count() FROM GE_OG_GS_Visa__c where GE_OG_GS_Technician__r.Id=: techId];
        techAttachCount = [SELECT Count() FROM GE_OG_GS_Technician_Attachment__c where GE_OG_GS_TA_Technician__r.Id=: techId]; //Addition
        
        List<SVMXC__Service_Group_Skills__c> expertiseList = new List<SVMXC__Service_Group_Skills__c>();
        lstExpertiseBeans = new List<GE_OG_TechBean.expertiseBean>();
        
        
 
            helper = new GE_OG_TechDataHelper();
            lstExpertiseBeans = helper.getExpertises(techId,expSkipper); 
            lstCourseAssignmentBeans = helper.getCourseAssignments(techId,expSkipper); 
            lstCertificationBeans = helper.getCertifications(techId,expSkipper); 
            lstPassportBeans = helper.getPassports(techId,expSkipper); 
            lstVisaBeans = helper.getVisas(techId,expSkipper); 
            lsttechAttachBeans = helper.getTechAttachment(techId,techAttachSkipper);
     
        if(expCount > expIndex && expCount > 0)  
        {   
            expPrevBool = true;
            expNextBool = false;
        }
        else{
            
            expPrevBool = true;
            expNextBool = true;
        }
        if(courseCount > courseIndex && courseCount > 0)  
        {   
            coursePrevBool = true;
            courseNextBool = false;
        }
        else{
            
            coursePrevBool = true;
            courseNextBool = true;
        }
        if(certiCount > certiIndex && certiCount > 0)  
        {   
            certiPrevBool = true;
            certiNextBool = false;
        }
        else{
            
            certiPrevBool = true;
            certiNextBool = true;
        }
        if(passportCount > passportIndex && passportCount > 0)  
        {   
            passportPrevBool = true;
            passportNextBool = false;
        }
        else{
            
            passportPrevBool = true;
            passportNextBool = true;
        }
        if(visaCount > visaIndex && visaCount > 0)  
        {   
            visaPrevBool = true;
            visaNextBool = false;
        }
        else{
            
            visaPrevBool = true;
            visaNextBool = true;
        }
         if(techAttachCount > techAttachIndex && techAttachCount > 0)  //Addition
        {   
            techAttachPrevBool = true;
            techAttachNextBool = false;
        }
        else{
            
            techAttachPrevBool = true;
            techAttachNextBool = true;
        }//
        showedit = false;
    }
    else{
            expPrevBool = true;
            expNextBool = true;
            courseNextBool = true;
            coursePrevBool = true;  
            certiNextBool = true;
            certiPrevBool = true;   
            passportNextBool = true;
            passportPrevBool = true;    
            visaNextBool = true;
            visaPrevBool = true;
            techAttachNextBool = true;//Addition
            techAttachPrevBool = true;//Addition
            showedit = true;
        }
    expIndex = expSkipper;
    courseIndex = courseSkipper;
    certiIndex = certiSkipper;
    passportIndex = passportSkipper;
    visaIndex = visaSkipper;
    techattachIndex = techattachSkipper;//Addition
}
     public pagereference callexpertPage(){
        PageReference editPage = new PageReference('/apex/GE_OG_TechDataUpsert?techId1='+techId);
        editPage.getParameters().put('recordType','Expert');        
        editPage.setRedirect(true);
        return editPage;
     }
     public pagereference callcoursePage(){
        PageReference editPage = new PageReference('/apex/GE_OG_TechDataUpsert?techId1='+techId);
        editPage.getParameters().put('recordType','Course');        
        editPage.setRedirect(true);
        return editPage;
     }
     public pagereference callCertsPage(){
        PageReference editPage = new PageReference('/apex/GE_OG_TechDataUpsert?techId1='+techId);
        editPage.getParameters().put('recordType','Certification');        
        editPage.setRedirect(true);
        return editPage;
     }
     public pagereference callPassportPage(){
        PageReference editPage = new PageReference('/apex/GE_OG_TechDataUpsert?techId1='+techId);
        editPage.getParameters().put('recordType','Passport');        
        editPage.setRedirect(true);
        return editPage;
     }
     public pagereference callVisaPage(){
        PageReference editPage = new PageReference('/apex/GE_OG_TechDataUpsert?techId1='+techId);
        editPage.getParameters().put('recordType','Visa');        
        editPage.setRedirect(true);
        return editPage;
     }
     public pagereference callTechAttachmentPage(){
        PageReference addPage = new PageReference('/apex/GE_OG_TechnicianAttachmentPage?techId1='+techId);              
        addPage.setRedirect(true);
        return addPage;
     }

    
     public void expPrevious()
    {
         if(expSkipper > limit_size)
        {    
            expIndex = expIndex - limit_size;
            expSkipper = expSkipper - limit_size; 
            helper = new GE_OG_TechDataHelper();
            lstExpertiseBeans = helper.getExpertises(techId,expIndex); 
            expPrevBool = false;
            expNextBool = false;
        }
         else
        {
            expIndex = expIndex - limit_size;
            expSkipper = expSkipper - limit_size;
            helper = new GE_OG_TechDataHelper();
            lstExpertiseBeans = helper.getExpertises(techId,expIndex); 
            expPrevBool = true;
            expNextBool = false;        
        }   
       
    }
    
     public void expNext()
    {
        expIndex = expIndex + limit_size;
        expSkipper = expSkipper + limit_size;
        lstExpertiseBeans.clear();
        if(expIndex > expCount)
        {
            expIndex = Math.Mod(expCount,limit_size) + expSkipper;
            expNextBool = true;
            expPrevBool = false;
            helper = new GE_OG_TechDataHelper();
            lstExpertiseBeans = helper.getExpertises(techId,expIndex);  
            expIndex = expSkipper + limit_size;
        }
        
        else
        {
            helper = new GE_OG_TechDataHelper();
            lstExpertiseBeans = helper.getExpertises(techId,expIndex); 
            expPrevBool = false;
        }
        
    }
    
    
   
    
    public void coursePrevious()
    {
         if(courseSkipper > limit_size)
        {    
            courseIndex = courseIndex - limit_size;
            courseSkipper = courseSkipper - limit_size; 
            helper = new GE_OG_TechDataHelper();
            lstCourseAssignmentBeans = helper.getCourseAssignments(techId,courseIndex); 
            coursePrevBool = false;
            courseNextBool = false;
        }
         else
        {
            courseIndex = courseIndex - limit_size;
            courseSkipper = courseSkipper - limit_size;
            helper = new GE_OG_TechDataHelper();
            lstCourseAssignmentBeans = helper.getCourseAssignments(techId,courseIndex); 
            coursePrevBool = true;
            courseNextBool = false;        
        }   
       
    }
    
     public void courseNext()
    {
        courseIndex = courseIndex + limit_size;
        courseSkipper = courseSkipper + limit_size;
        lstCourseAssignmentBeans.clear();
        if(courseIndex > courseCount)
        {
            courseIndex = Math.Mod(courseCount,limit_size) + courseSkipper;
            courseNextBool = true;
            coursePrevBool = false;
            helper = new GE_OG_TechDataHelper();
            lstCourseAssignmentBeans = helper.getCourseAssignments(techId,courseIndex);  
            courseIndex = courseSkipper + limit_size;
        }
        
        else
        {
            helper = new GE_OG_TechDataHelper();
            lstCourseAssignmentBeans = helper.getCourseAssignments(techId,courseIndex); 
            coursePrevBool = false;
        }
        
    }
    
    
    public void certiPrevious()
    {
         if(certiSkipper > limit_size)
        {    
            certiIndex = certiIndex - limit_size;
            certiSkipper = certiSkipper - limit_size; 
            helper = new GE_OG_TechDataHelper();
            lstCertificationBeans = helper.getCertifications(techId,certiIndex); 
            certiPrevBool = false;
            certiNextBool = false;
        }
         else
        {
            certiIndex = certiIndex - limit_size;
            certiSkipper = certiSkipper - limit_size;
            helper = new GE_OG_TechDataHelper();
            lstCertificationBeans = helper.getCertifications(techId,certiIndex); 
            certiPrevBool = true;
            certiNextBool = false;        
        }   
       
    }
    
    
     public void certiNext()
    {
        certiIndex = certiIndex + limit_size;
        certiSkipper = certiSkipper + limit_size;
        lstCertificationBeans.clear();
        if(certiIndex > certiCount)
        {
            certiIndex = Math.Mod(certiCount,limit_size) + certiSkipper;
            certiNextBool = true;
            certiPrevBool = false;
            helper = new GE_OG_TechDataHelper();
            lstCertificationBeans = helper.getCertifications(techId,certiIndex);  
            certiIndex = certiSkipper + limit_size;
        }
        
        else
        {
            helper = new GE_OG_TechDataHelper();
            lstCertificationBeans = helper.getCertifications(techId,certiIndex); 
            certiPrevBool = false;
        }
        
    }        
    
    
     public void passportPrevious()
    {
         if(passportSkipper > limit_size)
        {    
            passportIndex = passportIndex - limit_size;
            passportSkipper = passportSkipper - limit_size; 
            helper = new GE_OG_TechDataHelper();
            lstPassportBeans = helper.getPassports(techId,passportIndex); 
            passportPrevBool = false;
            passportNextBool = false;
        }
         else
        {
            passportIndex = passportIndex - limit_size;
            passportSkipper = passportSkipper - limit_size;
            helper = new GE_OG_TechDataHelper();
            lstPassportBeans = helper.getPassports(techId,passportIndex); 
            passportPrevBool = true;
            passportNextBool = false;        
        }   
       
    }
     public void passportNext()
    {
        passportIndex = passportIndex + limit_size;
        passportSkipper = passportSkipper + limit_size;
        lstPassportBeans.clear();
        if(passportIndex > passportCount)
        {
            passportIndex = Math.Mod(passportCount,limit_size) + passportSkipper;
            passportNextBool = true;
            passportPrevBool = false;
            helper = new GE_OG_TechDataHelper();
            lstPassportBeans = helper.getPassports(techId,passportIndex);  
            passportIndex = passportSkipper + limit_size;
        }
        
        else
        {
            helper = new GE_OG_TechDataHelper();
            lstPassportBeans = helper.getPassports(techId,passportIndex); 
            passportPrevBool = false;
        }
        
    }
    
    
   
    
    public void visaPrevious()
    {
         if(visaSkipper > limit_size)
        {    
            visaIndex = visaIndex - limit_size;
            visaSkipper = visaSkipper - limit_size; 
            helper = new GE_OG_TechDataHelper();
            lstVisaBeans = helper.getVisas(techId,visaIndex); 
            visaPrevBool = false;
            visaNextBool = false;
        }
         else
        {
            visaIndex = visaIndex - limit_size;
            visaSkipper = visaSkipper - limit_size;
            helper = new GE_OG_TechDataHelper();
            lstVisaBeans = helper.getVisas(techId,visaIndex); 
            visaPrevBool = true;
            visaNextBool = false;        
        }   
       
    }

    public void visaNext()
    {
        visaIndex = visaIndex + limit_size;
        visaSkipper = visaSkipper + limit_size;
        lstVisaBeans.clear();
        if(visaIndex > visaCount)
        {
            visaIndex = Math.Mod(visaCount,limit_size) + visaSkipper;
            visaNextBool = true;
            visaPrevBool = false;
            helper = new GE_OG_TechDataHelper();
            lstVisaBeans = helper.getVisas(techId,visaIndex);  
            visaIndex = visaSkipper + limit_size;
        }
        
        else
        {
            helper = new GE_OG_TechDataHelper();
            lstVisaBeans = helper.getVisas(techId,visaIndex); 
            visaPrevBool = false;
        }
        
    }
    public void techAttachPrevious()//Addition
    {
         if(techAttachSkipper > limit_size)
        {    
            techAttachIndex = techAttachIndex - limit_size;
            techAttachSkipper = techAttachSkipper - limit_size; 
            helper = new GE_OG_TechDataHelper();
            lsttechAttachBeans = helper.getTechAttachment(techId,techAttachIndex); 
            techAttachPrevBool = false;
            techAttachNextBool = false;
        }
         else
        {
            techAttachIndex = techAttachIndex - limit_size;
            techAttachSkipper = techAttachSkipper - limit_size;
            helper = new GE_OG_TechDataHelper();
            lsttechAttachBeans = helper.getTechAttachment(techId,techAttachIndex ); 
            techAttachPrevBool = true;
            techAttachNextBool = false;        
        }   
       
    }

    public void techAttachNext()//Addition
    {
        techAttachIndex = techAttachIndex + limit_size;
        techAttachSkipper = techAttachSkipper + limit_size;
        lsttechAttachBeans.clear();
        if(techAttachIndex > techAttachCount)
        {
            techAttachIndex = Math.Mod(techAttachCount,limit_size) + techAttachSkipper;
            techAttachNextBool = true;
            techAttachPrevBool = false;
            helper = new GE_OG_TechDataHelper();
            lsttechAttachBeans = helper.getTechAttachment(techId,techAttachIndex );  
            techAttachIndex = techAttachSkipper + limit_size;
        }
        
        else
        {
            helper = new GE_OG_TechDataHelper();
            lsttechAttachBeans = helper.getTechAttachment(techId,techAttachIndex ); 
            techAttachPrevBool = false;
        }
        
    }
    
   
}