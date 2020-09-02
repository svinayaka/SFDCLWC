/*
Class Name                   - GE_OG_TechBean
Test Class Name              - GE_OG_TechData_Test
Created Date                 -  3/31/2017 
Description                  -  This declaration class or Bean used to wrap from direct Sobject into non-object classes 
                                to refer objects - Expertise, CourseAssignments, Certifications, Passport and Visa 
Requirment #                 - R-25711
*/

public class GE_OG_TechBean{

 public class expertiseBean{

        public Id expertiseId{get;set;}
        public String recordNumber {get;set;}
        public Boolean signOff{get;set;}        
        public String skillCategory{get;set;}
        public String skillGroup{get;set;}
        public String skill{get;set;}        
        public String expertiseLevel{get;set;}
        public String lastCompletedWorkOrder{get;set;}             
        public Decimal workOrdersCompleted{get;set;}
        public Decimal skillLevel{get;set;}
        public String lastModifiedBy{get;set;}
        public String skillDescription{get;set;}
        public String currentTargetLevel{get;set;}
        public String nextTargetLevel{get;set;}
        public Boolean primarySkill{get;set;}
        Public Boolean isSelectExprt{get;set;}
        public String qualificationStatus{get;set;}
        
 } 
public class courseAssignmentBean{
        public Id courseId{get;set;}
        public String courseReference{get;set;}
        public String courseCategory{get;set;}
        public String courseName{get;set;}
        public String courseNameAll{get;set;}
        public String courseStatus{get;set;}
        public String targetLevel{get;set;}
        public Date attendedDate{get;set;}
        public Date passedDate{get;set;}
        public String courseExpiry{get;set;}
        public String courseSource{get;set;}
        public String criticality{get;set;}
        public boolean crossTrainingPlan{get;set;}
        public Decimal score{get;set;}
        public String trainingPath{get;set;}
        public String currentLevel{get;set;}
        public String courseCode{get;set;}
        Public Boolean isSelectCourse{get;set;}
      
    }

public class certificationBean{
        public Id certificationId{get;set;}
        public String certificationReference{get;set;}
        public String certificationName{get;set;}
        public String category{get;set;}
        public String status{get;set;}
        public Date acquiredDate{get;set;}
        public Date expiryDate{get;set;}
        public String additionalInfo{get;set;}
        public String legacyId{get;set;}
        public String certificateType{get;set;}
        public Date targetDate{get;set;}
        Public Boolean isSelectCerts{get;set;}
    }
    
public class passportBean{
        public Id passportId{get;set;}
        public String passportName{get;set;}
        public String passportNumber{get;set;}
        public String passportExpiry{get;set;}
        public Date passportExpiryDate{get;set;}
        public String passportType{get;set;}
        public Decimal remainingPages{get;set;}
        Public String passportCountry{get;set;}
        public String passportStatus{get;set;}
        Public Boolean isSelectPassport{get;set;}
        
    }
    
public class visaBean{
        public Id visaId{get;set;}
        public String visaReference{get;set;}
        public String technician{get;set;}    
        public String passport{get;set;}
        public String passportExpiry{get;set;}
        public String visaExpiry{get;set;}
        public Date visaExpiryDate{get;set;}
        public String visaCountry{get;set;}
        public String visaStatus{get;set;}
        public String visaFor{get;set;}
        Public Boolean isSelectVisa{get;set;}
    }   
//Addition
public class techAttachBean{
        public Id techAttachId{get;set;}
        public String techreference{get;set;}
        public String techattachName{get;set;}
        public String visaName{get;set;}
        public String technician{get;set;}    
        public String passportName{get;set;}
        public String certificateName{get;set;}
        public String courseName{get;set;}
        public String courseNameRef{get;set;}
        public String associatedTo{get;set;}
        public String expertiseName{get;set;}
        public String linktodoc{get;set;}
        public String downloadLink{get;set;}
        
    }   
    
}