/*
Class Name                   - GE_OG_TechDataHelper
Test Class Name              - GE_OG_TechData_Test
Created Date                 -  3/31/2017 
Description                  -  This Helper class will process the data into wrapper classes(Non-object) quried from the objects -
                                 Expertise, CourseAssignments, Certifications, Passport and Visa of the Technician
Requirment #                 - R-25711
*/


 
public class GE_OG_TechDataHelper{

// Get Expertise records with limit 10 and offset 10
public List<GE_OG_TechBean.expertiseBean> getExpertises(Id techId,integer index){
        List<SVMXC__Service_Group_Skills__c> expertiseList = new List<SVMXC__Service_Group_Skills__c>();
       List<GE_OG_TechBean.expertiseBean>  lstExpertiseBeans = new List<GE_OG_TechBean.expertiseBean>();
 
      
        expertiseList = [Select id, Name, GE_PC_Sign_Off__c, GE_DRL_Skill_Category__c, GE_SS_Skill_Group__c, SVMXC__Skill__r.Name, 
        Expertise_Level__c, GE_PC_Last_Completed_WorkOrder__r.Name, GE_PC_WorkOrders_Completed__c, SVMXC__Skill_Level__c, GE_OG_Skill_Description__c, 
         LastModifiedBy.Name, GE_DRL_Current_Target_Level__c, GE_DRL_Target_Level__c from SVMXC__Service_Group_Skills__c 
        where SVMXC__Group_Member__r.Id=: techId ORDER BY Name limit: 10 offset :index]; 
        
        for(SVMXC__Service_Group_Skills__c expertObj : expertiseList )
        {
          GE_OG_TechBean.expertiseBean tempExpertise = new GE_OG_TechBean.expertiseBean(); 
          
          tempExpertise.expertiseId = expertObj.Id;
          tempExpertise.recordNumber = expertObj.Name;
          tempExpertise.signOff = expertObj.GE_PC_Sign_Off__c;          
          tempExpertise.skillCategory = expertObj.GE_DRL_Skill_Category__c;
          tempExpertise.skillGroup = expertObj.GE_SS_Skill_Group__c;
          tempExpertise.skill = expertObj.SVMXC__Skill__r.Name;
          tempExpertise.expertiseLevel = expertObj.Expertise_Level__c;
          tempExpertise.lastCompletedWorkOrder = expertObj.GE_PC_Last_Completed_WorkOrder__r.Name;
          tempExpertise.workOrdersCompleted = expertObj.GE_PC_WorkOrders_Completed__c; 
          tempExpertise.skillLevel = expertObj.SVMXC__Skill_Level__c;
          tempExpertise.lastModifiedBy = expertObj.LastModifiedBy.Name;      
          tempExpertise.skillDescription = expertObj.GE_OG_Skill_Description__c;
          tempExpertise.currentTargetLevel = expertObj.GE_DRL_Current_Target_Level__c;
          tempExpertise.nextTargetLevel = expertObj.GE_DRL_Target_Level__c;
          
           
          lstExpertiseBeans.add(tempExpertise);   
         }
         return lstExpertiseBeans;
}


// Get CourseAssignment records with limit 10 and offset 10
public List<GE_OG_TechBean.courseAssignmentBean> getCourseAssignments(Id techId,integer index){
    List<GE_OG_GS_Course__c> courseAssignList = new List<GE_OG_GS_Course__c>();
    List<GE_OG_TechBean.courseAssignmentBean>  lstCourseAssignmentBeans = new List<GE_OG_TechBean.courseAssignmentBean>();
    
    courseAssignList = [Select id, Name, GE_OG_GS_Category__c, GE_OG_GS_Course_Name__c, GE_OG_GS_Course_Status__c,  
        GE_OG_GS_Target_Level__c, GE_OG_GS_Attended_Date__c, GE_OG_GS_Passed_Date__c, GE_DRL_Course_Expiry__c, 
        GE_OG_SS_Course_Source__c, GE_DS_Criticality__c,GE_OG_SS_Master_Course__r.Name, GE_OG_GS_Score__c, GE_OG_GS_Cross_Training_Plan__c, GE_OG_GS_Training_Path__c,GE_OG_GS_Current_Level__c, GE_OG_DRL_Course_Code__c from GE_OG_GS_Course__c where GE_OG_GS_Course_Technician__r.Id=: techId 
        ORDER BY Name limit: 10 offset :index];  
        
        for(GE_OG_GS_Course__c courseObj : courseAssignList )
        {
          GE_OG_TechBean.courseAssignmentBean tempCourseAssign = new GE_OG_TechBean.courseAssignmentBean(); 
          
          tempCourseAssign.courseId = courseObj.Id;
          tempCourseAssign.courseReference = courseObj.Name;
          tempCourseAssign.courseName = courseObj.GE_OG_GS_Course_Name__c;
          tempCourseAssign.courseCategory = courseObj.GE_OG_GS_Category__c;
          tempCourseAssign.courseStatus = courseObj.GE_OG_GS_Course_Status__c;
          tempCourseAssign.targetLevel = courseObj.GE_OG_GS_Target_Level__c;
          tempCourseAssign.attendedDate = courseObj.GE_OG_GS_Attended_Date__c;
          tempCourseAssign.passedDate = courseObj.GE_OG_GS_Passed_Date__c;
          tempCourseAssign.courseExpiry = courseObj.GE_DRL_Course_Expiry__c;
          tempCourseAssign.courseSource = courseObj.GE_OG_SS_Course_Source__c;
          tempCourseAssign.criticality = courseObj.GE_DS_Criticality__c;          
          tempCourseAssign.score = courseObj.GE_OG_GS_Score__c;
          tempCourseAssign.currentLevel = courseObj.GE_OG_GS_Current_Level__c;
          tempCourseAssign.trainingPath = courseObj.GE_OG_GS_Training_Path__c;
          tempCourseAssign.crossTrainingPlan = courseObj.GE_OG_GS_Cross_Training_Plan__c;
          tempCourseAssign.courseCode = courseObj.GE_OG_DRL_Course_Code__c;
          tempCourseAssign.courseNameAll = courseObj.GE_OG_SS_Master_Course__r.Name;
          
          lstCourseAssignmentBeans.add(tempCourseAssign);
           
        } 
         return lstCourseAssignmentBeans;

}

// Get Certifications records with limit 10 and offset 10
public List<GE_OG_TechBean.certificationBean> getCertifications(Id techId,integer index){
    List<GE_OG_GS_Certification__c> certificationList = new List<GE_OG_GS_Certification__c>();
    List<GE_OG_TechBean.certificationBean>  lstCertificationBeans = new List<GE_OG_TechBean.certificationBean>();
    certificationList = [Select id, Name, GE_OG_GS_Certificate_Name__c, GE_OG_GS_Category__c, GE_OG_GS_Status__c, GE_OG_GS_Acquired_Date__c,
        GE_OG_GS_Cert_Expiry_Date__c, GE_OG_DRL_Certification_Source__c, GE_OG_DRL_Legacy_Id__c from GE_OG_GS_Certification__c where GE_OG_GS_Cert_Technician__r.Id=:techId
        ORDER BY Name limit: 10 offset :index];  
        
        for(GE_OG_GS_Certification__c certifObj : certificationList )
        {
          GE_OG_TechBean.certificationBean tempCertification = new GE_OG_TechBean.certificationBean(); 
          tempCertification.certificationId = certifObj.Id;
          tempCertification.certificationReference = certifObj.Name;
          tempCertification.certificationName = certifObj.GE_OG_GS_Certificate_Name__c;
          tempCertification.category = certifObj.GE_OG_GS_Category__c;
          tempCertification.status = certifObj.GE_OG_GS_Status__c;
          tempCertification.acquiredDate = certifObj.GE_OG_GS_Acquired_Date__c;
          tempCertification.expiryDate = certifObj.GE_OG_GS_Cert_Expiry_Date__c;
          tempCertification.additionalInfo = certifObj.GE_OG_DRL_Certification_Source__c;
          tempCertification.legacyId = certifObj.GE_OG_DRL_Legacy_Id__c;
          
          lstCertificationBeans.add(tempCertification);
           
        }
    return lstCertificationBeans;

}       

// Get Passport records with limit 10 and offset 10
public List<GE_OG_TechBean.passportBean> getPassports(Id techId,integer index){   
         List<GE_OG_GS_Passport__c> passportList = new List<GE_OG_GS_Passport__c>();
         List<GE_OG_TechBean.passportBean>  lstPassportBeans = new List<GE_OG_TechBean.passportBean>();
         passportList  = [Select id, Name, GE_OG_GS_Passport_Expiry__c, GE_OG_GS_Passport_Expiry_Date__c, GE_OG_GS_Passport_Type__c, 
        GE_OG_GS_Remaining_Pages__c,GE_OG_GS_Passport_Number__c,GE_OG_GS_Passport_Country__c from GE_OG_GS_Passport__c where GE_OG_GS_Technician__r.Id=:techId 
        ORDER BY Name limit: 10 offset :index];  
        
        for(GE_OG_GS_Passport__c pspObj : passportList )
        {
          GE_OG_TechBean.passportBean tempPassport = new GE_OG_TechBean.passportBean(); 
          tempPassport.passportId = pspObj.Id;
          tempPassport.passportName = pspObj.Name;
          tempPassport.passportExpiry = pspObj.GE_OG_GS_Passport_Expiry__c;
          tempPassport.passportExpiryDate = pspObj.GE_OG_GS_Passport_Expiry_Date__c;
          tempPassport.passportType = pspObj.GE_OG_GS_Passport_Type__c;
          tempPassport.remainingPages = pspObj.GE_OG_GS_Remaining_Pages__c;
          tempPassport.passportNumber = pspObj.GE_OG_GS_Passport_Number__c;
          tempPassport.passportCountry = pspObj.GE_OG_GS_Passport_Country__c;
          lstPassportBeans.add(tempPassport);
           
        } 
        return lstPassportBeans;

}   

// Get Visa records with limit 10 and offset 10     
public List<GE_OG_TechBean.visaBean> getVisas(Id techId,integer index){   
     List<GE_OG_GS_Visa__c> visaList = new List<GE_OG_GS_Visa__c>();
     List<GE_OG_TechBean.visaBean>  lstVisaBeans = new List<GE_OG_TechBean.visaBean>();
     
       System.debug('Tech details --->:' +techId);
       System.debug('Offset details --->:' +index);
       
     
      visaList = [Select id, Name, GE_OG_GS_Passport_Technician__c, GE_OG_GS_Passport__r.Name, 
      GE_OG_GS_V_Passport_Expiry__c, GE_OG_GS_Visa_Expiry__c, GE_OG_GS_Visa_Expiry_Date__c, 
      GE_OG_GS_Visa_Country__c, GE_OG_GS_Visa_For__c from GE_OG_GS_Visa__c 
      where GE_OG_GS_Technician__r.Id=:techId ORDER BY Name limit:10 offset:index];  
         
         System.debug('Visas list:' +visaList );
         
         for(GE_OG_GS_Visa__c visaObj: visaList)
         {
           GE_OG_TechBean.visaBean tempVisa = new GE_OG_TechBean.visaBean();
           tempVisa.visaId = visaObj.Id;  
           tempVisa.visaReference = visaObj.Name;
           tempVisa.technician = visaObj.GE_OG_GS_Passport_Technician__c; 
           tempVisa.passport = visaObj.GE_OG_GS_Passport__r.Name;
           tempVisa.passportExpiry = visaObj.GE_OG_GS_V_Passport_Expiry__c;
           tempVisa.visaExpiry = visaObj.GE_OG_GS_Visa_Expiry__c;
           tempVisa.visaExpiryDate = visaObj.GE_OG_GS_Visa_Expiry_Date__c;
           tempVisa.visaCountry = visaObj.GE_OG_GS_Visa_Country__c;
           tempVisa.visaFor = visaObj.GE_OG_GS_Visa_For__c;       
        
           lstVisaBeans.add(tempVisa);
        }
        return lstVisaBeans;

}
//Addition
public List<GE_OG_TechBean.techAttachBean> getTechAttachment(Id techId,integer index){   
     List<GE_OG_GS_Technician_Attachment__c> techattachList = new List<GE_OG_GS_Technician_Attachment__c>();
     List<GE_OG_TechBean.techAttachBean>  lsttechAttachBeans = new List<GE_OG_TechBean.techAttachBean>();
     
       System.debug('Tech details --->:' +techId);
       System.debug('Offset details --->:' +index);
       
     
      techattachList = [Select id, Name, GE_OG_GS_TA_Technician__c, GE_OG_GS_TA_Passport__r.GE_OG_GS_Passport_Number__c,
       GE_OG_GS_TA_Course__r.GE_OG_SS_Master_Course__r.Name,GE_OG_GS_TA_Associated_To__c,GE_OG_GS_Technician_Attachment_Name__c, 
       GE_OG_GS_TA_Certification__r.GE_OG_GS_Certificate_Name__c, GE_OG_GS_TA_Course__r.GE_OG_GS_Course_Name__c, 
       GE_OG_GS_TA_Visa__r.Name,GE_OG_Expertise__r.GE_OG_DS_FSCC_Skill_Name__r.Name,GE_OG_GS_TA_Link_to_Document__c,
       GE_OG_GS_Download_Link_to_Document__c from GE_OG_GS_Technician_Attachment__c where GE_OG_GS_TA_Technician__c=:techId ORDER BY Name limit:10 offset:index];  
         
         System.debug('Attachments list:' +techattachList );
         
         for(GE_OG_GS_Technician_Attachment__c techAttachObj: techattachList )
         {
           GE_OG_TechBean.techAttachBean tempTA = new GE_OG_TechBean.techAttachBean();
           tempTA.techAttachId = techAttachObj.Id;  
           tempTA.techreference = techAttachObj.Name;
           tempTA.techattachName = techAttachObj.GE_OG_GS_Technician_Attachment_Name__c;
           tempTA.technician = techAttachObj.GE_OG_GS_TA_Technician__c; 
           tempTA.visaName = techAttachObj.GE_OG_GS_TA_Visa__r.Name;
           tempTA.passportName = techAttachObj.GE_OG_GS_TA_Passport__r.GE_OG_GS_Passport_Number__c;
           tempTA.certificateName = techAttachObj.GE_OG_GS_TA_Certification__r.GE_OG_GS_Certificate_Name__c;
           tempTA.courseNameRef = techAttachObj.GE_OG_GS_TA_Course__r.GE_OG_SS_Master_Course__r.Name;
           tempTA.courseName = techAttachObj.GE_OG_GS_TA_Course__r.GE_OG_GS_Course_Name__c;
           tempTA.associatedTo = techAttachObj.GE_OG_GS_TA_Associated_To__c;
           tempTA.expertiseName = techAttachObj.GE_OG_Expertise__r.GE_OG_DS_FSCC_Skill_Name__r.Name; 
           tempTA.linktodoc = techAttachObj.GE_OG_GS_TA_Link_to_Document__c; 
           tempTA.downloadLink= techAttachObj.GE_OG_GS_Download_Link_to_Document__c;       
        
           lsttechAttachBeans.add(tempTA);
        }
        return lsttechAttachBeans;

}

}