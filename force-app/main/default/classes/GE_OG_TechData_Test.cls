@isTest
public class GE_OG_TechData_Test 
{
    
    static testmethod void test1()
    {
         Test.StartTest();  
        User u1 = [SELECT Id FROM User WHERE Profile.Name='GE_PC_Super Technician' AND IsActive = TRUE limit 1];
         //User u1 = [SELECT Id FROM User WHERE GE_HQ_SSO_ID__c='502324626'];
        System.runAs(u1) {   
         
         //ServiceTeam Insert
        SVMXC__Service_Group__c team = new SVMXC__Service_Group__c();
        team.name='Test Team';
        team.GE_OG_DS_Billing_Admin_Email__c='test@test.com';
        team.GE_HQ_P_L_Level__c='O&G > D&S';
        insert team;  
         
          //Technician Insert     
        SVMXC__Service_Group_Members__c tech = new SVMXC__Service_Group_Members__c(
        SVMXC__Service_Group__c = team.Id,
        Name = 'SVMX Tech',
        SVMXC__Active__c = true,
        SVMXC__Enable_Scheduling__c = true,
        SVMXC__Email__c = 'test.abc@xyz.com',
        GE_SM_HQ_SSO_ID__c = '502324626',
        SVMCX_Status__c = 'Active GE',
        GE_SM_HQ_Regional_Manager__c = 'SVMX',
        GE_SM_HQ_Manager_Email__c = 'test.abc@xyz.com',
        SVMXC_Function__c = 'Services',
        GE_SM_HQ_Controls_EmpType__c = 'Field Engineer', 
        SVMXC__Salesforce_User__c = UserInfo.getUserId()
        );
        insert tech;
        //New Skill
        SVMXC__Skill__c  skill= new   SVMXC__Skill__c(Name = 'test Skill',
        GE_DRL_Skill_Category__c='Controls',
        SVMXC__Skill_Category__c ='Controls',
        GE_OG_DS_Product_Group__c='test',
        Sub_Business__c='Pressure Control');
        insert skill;
      integer i=0;
       List<GE_OG_GS_Course__c> courseAssgn = new List<GE_OG_GS_Course__c>(); 
        for(i=0 ; i<=11 ; i++ )
        {
          GE_OG_GS_Course__c tempCourse = new GE_OG_GS_Course__c(); 
          
          tempCourse.GE_OG_GS_Category__c ='Customer Requirement'+i;          
          tempCourse.GE_OG_GS_Course_Name__c = 'test Course';
          tempCourse.GE_OG_GS_Course_Status__c= 'Passed';
          tempCourse.GE_DS_Criticality__c='Required';
          tempCourse.GE_OG_GS_Passed_Date__c= Date.Today();
          tempCourse.GE_OG_GS_Target_Level__c='ENTRY LEVEL'; 
          tempCourse.GE_OG_DRL_Course_Source__c='Test Source';
          tempCourse.GE_OG_GS_Course_Technician__c=tech.Id;       
          courseAssgn.add(tempCourse);   
         }
         Insert courseAssgn;
        List<SVMXC__Service_Group_Skills__c> exp =new List<SVMXC__Service_Group_Skills__c>(); 
        for(i=0 ; i<=30 ; i++ )
        {
          SVMXC__Service_Group_Skills__c  tempExpertise = new SVMXC__Service_Group_Skills__c (); 
          
          tempExpertise.GE_PC_Sign_Off__c= false;          
          tempExpertise.GE_DRL_Skill_Category__c = 'Controls';
          tempExpertise.GE_SS_Skill_Group__c = 'Hardware - EFL';
          tempExpertise.SVMXC__Skill__c=skill.Id ;
          tempExpertise.Expertise_Level__c='Level 0';
          tempExpertise.GE_PC_WorkOrders_Completed__c = 0; 
          tempExpertise.SVMXC__Skill_Level__c =1;
          tempExpertise.SVMXC__Service_Group__c=team.id;
          tempExpertise.SVMXC__Group_Member__c=tech.Id;
        
          exp.add(tempExpertise);   
         }
         Insert exp;
         System.debug('Record Count Expertise'  + +exp.size());
       
          List<GE_OG_GS_Certification__c> certs= new List<GE_OG_GS_Certification__c>(); 
        for(i=0 ; i<=11 ; i++ )
        {
          GE_OG_GS_Certification__c tempCerts = new GE_OG_GS_Certification__c(); 
          
          tempCerts.GE_OG_GS_Category__c ='Global Customer';          
          tempCerts.GE_OG_GS_Certificate_Name__c= 'test Certificate';
          tempCerts.GE_OG_GS_Status__c= 'Acquired';
          tempCerts.GE_OG_GS_Acquired_Date__c=Date.Today();
          tempCerts.GE_DS_Criticality__c='Required';
          tempCerts.GE_OG_GS_Cert_Technician__c=tech.Id;       
          certs.add(tempCerts);   
         }
         Insert certs;
          List<GE_OG_GS_Passport__c> passport= new List<GE_OG_GS_Passport__c>(); 
        for(i=0 ; i<=11 ; i++ )
        {
          GE_OG_GS_Passport__c tempPassport = new GE_OG_GS_Passport__c(); 
          
               
          tempPassport.GE_OG_GS_Passport_Type__c = 'Primary';
          tempPassport.GE_OG_GS_Remaining_Pages__c= 30;
          tempPassport.GE_OG_GS_Passport_Expiry_Date__c= Date.Today();
          tempPassport.GE_OG_GS_Technician__c=tech.Id;       
          passport.add(tempPassport);   
         }
         Insert passport;
          
         GE_OG_GS_Passport__c tempPass = new GE_OG_GS_Passport__c(
         GE_OG_GS_Passport_Type__c= 'Primary',
         GE_OG_GS_Remaining_Pages__c= 30,
         GE_OG_GS_Passport_Expiry_Date__c= Date.Today(),
         GE_OG_GS_Technician__c=tech.Id); 
         Insert tempPass;
         
          List<GE_OG_GS_Visa__c> visa= new List<GE_OG_GS_Visa__c>(); 
        for(i=0 ; i<=11 ; i++ )
        {
          GE_OG_GS_Visa__c tempvisa = new GE_OG_GS_Visa__c(); 
          tempvisa.GE_OG_GS_Passport__c= tempPass.Id;
          tempvisa.GE_OG_GS_Visa_For__c= 'Business Visa';
          tempvisa.GE_OG_GS_Visa_Expiry_Date__c=Date.Today();
          tempvisa.GE_OG_GS_Visa_Country__c='Ireland';
          tempvisa.GE_OG_GS_Technician__c=tech.Id;       
          visa.add(tempvisa);   
         }
         Insert visa;
        
        ApexPages.currentPage().getParameters().put('techId',tech.Id);
        
        GE_OG_TechDatacontrl tst = new GE_OG_TechDatacontrl ();        
        tst.expNext();
        tst.expPrevious();        
        tst.courseNext();
        tst.coursePrevious();        
        tst.certiNext();
        tst.certiPrevious();        
        tst.passportNext();
        tst.passportPrevious();        
        tst.visaNext();
        tst.visaPrevious(); 
        tst.callexpertPage();
        tst.callcoursePage();
        tst.callCertsPage();
        tst.callPassportPage();
        tst.callVisaPage();    
         GE_OG_TechResumeHelper techresumehlp = new GE_OG_TechResumeHelper();
        techresumehlp.getExpertises(tech.id);
        techresumehlp.getCourseAssignments(tech.id);
        techresumehlp.getCertifications(tech.id);
        techresumehlp.getPassports(tech.id);
        techresumehlp.getVisas(tech.id);
        }
       
        
        test.stopTest();
        
    }
    static testmethod void test2()
    {
         Test.StartTest();  
         User u1 = [SELECT Id FROM User WHERE Profile.Name='GE_PC_Super Technician' AND IsActive = TRUE limit 1];
         //User u1 = [SELECT Id FROM User WHERE GE_HQ_SSO_ID__c='502324626'];
        System.runAs(u1) {   
         
         //ServiceTeam Insert
        SVMXC__Service_Group__c team = new SVMXC__Service_Group__c();
        team.name='Test Team';
        team.GE_OG_DS_Billing_Admin_Email__c='test@test.com';
        team.GE_HQ_P_L_Level__c='O&G > D&S';
        insert team;  
         
          //Technician Insert     
        SVMXC__Service_Group_Members__c tech = new SVMXC__Service_Group_Members__c(
        SVMXC__Service_Group__c = team.Id,
        Name = 'SVMX Tech',
        SVMXC__Active__c = true,
        SVMXC__Enable_Scheduling__c = true,
        SVMXC__Email__c = 'test.abc@xyz.com',
        GE_SM_HQ_SSO_ID__c = '502324626',
        SVMCX_Status__c = 'Active GE',
        GE_SM_HQ_Regional_Manager__c = 'SVMX',
        GE_SM_HQ_Manager_Email__c = 'test.abc@xyz.com',
        SVMXC_Function__c = 'Services',
        GE_SM_HQ_Controls_EmpType__c = 'Field Engineer', 
        SVMXC__Salesforce_User__c = UserInfo.getUserId()
        );
        insert tech;
        //New Skill
        SVMXC__Skill__c  skill= new   SVMXC__Skill__c(Name = 'test Skill',
        GE_DRL_Skill_Category__c='Controls',
        SVMXC__Skill_Category__c ='Controls',
        GE_OG_DS_Product_Group__c='test',
        Sub_Business__c='Pressure Control');
        insert skill;
      integer i=0;
       
          GE_OG_GS_Course__c tempCourse = new GE_OG_GS_Course__c(); 
          
          tempCourse.GE_OG_GS_Category__c ='Customer Requirement'+i;          
          tempCourse.GE_OG_GS_Course_Name__c = 'test Course';
          tempCourse.GE_OG_GS_Course_Status__c= 'Passed';
          tempCourse.GE_DS_Criticality__c='Required';
          tempCourse.GE_OG_GS_Passed_Date__c= Date.Today();
          tempCourse.GE_OG_GS_Target_Level__c='ENTRY LEVEL'; 
          tempCourse.GE_OG_DRL_Course_Source__c='Test Source';
          tempCourse.GE_OG_GS_Course_Technician__c=tech.Id;       
          Insert tempCourse;
        
          SVMXC__Service_Group_Skills__c  tempExpertise = new SVMXC__Service_Group_Skills__c (); 
          
          tempExpertise.GE_PC_Sign_Off__c= false;          
          tempExpertise.GE_DRL_Skill_Category__c = 'Controls';
          tempExpertise.GE_SS_Skill_Group__c = 'Hardware - EFL';
          tempExpertise.SVMXC__Skill__c=skill.Id ;
          tempExpertise.Expertise_Level__c='Level 0';
          tempExpertise.GE_PC_WorkOrders_Completed__c = 0; 
          tempExpertise.SVMXC__Skill_Level__c =1;
          tempExpertise.SVMXC__Service_Group__c=team.id;
          tempExpertise.SVMXC__Group_Member__c=tech.Id;
          Insert tempExpertise;          
       
          
          GE_OG_GS_Certification__c tempCerts = new GE_OG_GS_Certification__c(); 
          
          tempCerts.GE_OG_GS_Category__c ='Global Customer';          
          tempCerts.GE_OG_GS_Certificate_Name__c= 'test Certificate';
          tempCerts.GE_OG_GS_Status__c= 'Acquired';
          tempCerts.GE_OG_GS_Acquired_Date__c=Date.Today();
          tempCerts.GE_DS_Criticality__c='Required';
          tempCerts.GE_OG_GS_Cert_Technician__c=tech.Id;       
          Insert tempCerts;   
        
          GE_OG_GS_Passport__c tempPassport = new GE_OG_GS_Passport__c(); 
          
          tempPassport.GE_OG_GS_Passport_Type__c = 'Primary';
          tempPassport.GE_OG_GS_Remaining_Pages__c= 30;
          tempPassport.GE_OG_GS_Passport_Expiry_Date__c= Date.Today();
          tempPassport.GE_OG_GS_Technician__c=tech.Id;       
          Insert tempPassport;   
        
          
         GE_OG_GS_Passport__c tempPass = new GE_OG_GS_Passport__c(
         GE_OG_GS_Passport_Type__c= 'Primary',
         GE_OG_GS_Remaining_Pages__c= 30,
         GE_OG_GS_Passport_Expiry_Date__c= Date.Today(),
         GE_OG_GS_Technician__c=tech.Id); 
         Insert tempPass;
         
          
          GE_OG_GS_Visa__c tempvisa = new GE_OG_GS_Visa__c(); 
          tempvisa.GE_OG_GS_Passport__c= tempPass.Id;
          tempvisa.GE_OG_GS_Visa_For__c= 'Business Visa';
          tempvisa.GE_OG_GS_Visa_Expiry_Date__c=Date.Today();
          tempvisa.GE_OG_GS_Visa_Country__c='Ireland';
          tempvisa.GE_OG_GS_Technician__c=tech.Id;       
          Insert tempvisa;   
        
        ApexPages.currentPage().getParameters().put('techId',tech.Id);
        
        GE_OG_TechDatacontrl tst = new GE_OG_TechDatacontrl ();        
        tst.expNext();
        tst.expPrevious();        
        tst.courseNext();
        tst.coursePrevious();        
        tst.certiNext();
        tst.certiPrevious();        
        tst.passportNext();
        tst.passportPrevious();        
        tst.visaNext();
        tst.visaPrevious();
        tst.techAttachNext();
        tst.techAttachPrevious();
        tst.callexpertPage();
        tst.callcoursePage();
        tst.callCertsPage();
        tst.callPassportPage();
        tst.callVisaPage();
        tst.callTechAttachmentPage();
        List<GE_OG_GS_Technician_Attachment__c> taLst = new List<GE_OG_GS_Technician_Attachment__c>();
        GE_OG_GS_Technician_Attachment__c temp = new GE_OG_GS_Technician_Attachment__c();
         temp.GE_OG_GS_TA_Technician__c= tech.Id;
         temp.GE_OG_GS_Technician_Attachment_Name__c = 'test Expertise';
         temp.GE_OG_Expertise__c=tempExpertise.Id;
         temp.GE_OG_GS_TA_Associated_To__c = 'Expertise'; 
         taLst.add(temp);
         GE_OG_GS_Technician_Attachment__c temp1 = new GE_OG_GS_Technician_Attachment__c();
         temp1.GE_OG_GS_TA_Technician__c= tech.Id;
         temp1.GE_OG_GS_Technician_Attachment_Name__c = 'test Course';
         temp1.GE_OG_GS_TA_Course__c= tempCourse.Id;
         temp1.GE_OG_GS_TA_Associated_To__c = 'Courses'; 
         taLst.add(temp1);
         GE_OG_GS_Technician_Attachment__c temp2 = new GE_OG_GS_Technician_Attachment__c();
         temp2.GE_OG_GS_TA_Technician__c= tech.Id;
         temp2.GE_OG_GS_Technician_Attachment_Name__c = 'test Certification';
         temp2.GE_OG_GS_TA_Certification__c= tempCerts.Id;
         temp2.GE_OG_GS_TA_Associated_To__c = 'Certification'; 
         taLst.add(temp2);
         GE_OG_GS_Technician_Attachment__c temp3 = new GE_OG_GS_Technician_Attachment__c();
         temp3.GE_OG_GS_TA_Technician__c= tech.Id;
         temp3.GE_OG_GS_Technician_Attachment_Name__c = 'test Passport';
         temp3.GE_OG_GS_TA_Passport__c= tempPass.Id ;
         temp3.GE_OG_GS_TA_Associated_To__c = 'Passport'; 
         taLst.add(temp3);   
         GE_OG_GS_Technician_Attachment__c temp4 = new GE_OG_GS_Technician_Attachment__c();
         temp4.GE_OG_GS_TA_Technician__c= tech.Id;
         temp4.GE_OG_GS_Technician_Attachment_Name__c = 'test Visa';
         temp4.GE_OG_GS_TA_Visa__c = tempvisa.Id;
         temp4.GE_OG_GS_TA_Associated_To__c = 'Visa'; 
         taLst.add(temp4);  
         insert taLst; 
         GE_OG_TechnicianAttachmentContrl tacontrol = new GE_OG_TechnicianAttachmentContrl();
         tacontrol.getAssociatedTo1();
         tacontrol.selectedvalue();
         tacontrol.getExpertiseLst();
         tacontrol.getCourseLst();
         tacontrol.getCertificateLst();
         tacontrol.getPassportLst();
         tacontrol.getVisaLst();
         tacontrol.addTechAttachment();
         // added to increase code coverage 
          tacontrol.associatedTo='Expertise';  
          tacontrol.selectedvalue();
          tacontrol.addTechAttachment();
          
              tacontrol.associatedTo='Courses';  
          tacontrol.selectedvalue();
           tacontrol.addTechAttachment();
              tacontrol.associatedTo='Certification';  
          tacontrol.selectedvalue();
           tacontrol.addTechAttachment();
              tacontrol.associatedTo='Passport';  
          tacontrol.selectedvalue();
           tacontrol.addTechAttachment();
              tacontrol.associatedTo='Visa';  
          tacontrol.selectedvalue();
           tacontrol.addTechAttachment();
          tacontrol.reset();
         
        }
        
        test.stopTest();
        
    } 
    static testmethod void test3()
    {
         Test.StartTest();  
        // User u1 = [SELECT Id FROM User WHERE GE_HQ_SSO_ID__c='502324626'];
         User u1 = [SELECT Id FROM User WHERE Profile.Name='GE_PC_Super Technician' AND IsActive = TRUE limit 1];
        System.runAs(u1) {   
         
         //ServiceTeam Insert
        SVMXC__Service_Group__c team = new SVMXC__Service_Group__c();
        team.name='Test Team';
        team.GE_OG_DS_Billing_Admin_Email__c='test@test.com';
        team.GE_HQ_P_L_Level__c='O&G > D&S';
        insert team;  
         
          //Technician Insert     
        SVMXC__Service_Group_Members__c tech = new SVMXC__Service_Group_Members__c(
        SVMXC__Service_Group__c = team.Id,
        Name = 'SVMX Tech',
        SVMXC__Active__c = true,
        SVMXC__Enable_Scheduling__c = true,
        SVMXC__Email__c = 'test.abc@xyz.com',
        GE_SM_HQ_SSO_ID__c = '502324626',
        SVMCX_Status__c = 'Active GE',
        GE_SM_HQ_Regional_Manager__c = 'SVMX',
        GE_SM_HQ_Manager_Email__c = 'test.abc@xyz.com',
        SVMXC_Function__c = 'Services',
        GE_SM_HQ_Controls_EmpType__c = 'Field Engineer', 
        SVMXC__Salesforce_User__c = UserInfo.getUserId()
        );
        insert tech;
        //New Skill
        SVMXC__Skill__c  skill1= new   SVMXC__Skill__c(Name = 'test Skill',
        GE_DRL_Skill_Category__c='Controls',
        SVMXC__Skill_Category__c ='Controls',
        GE_OG_DS_Product_Group__c='Hardware - EFL',
        Sub_Business__c='Pressure Control');
        insert skill1;
        SVMXC__Skill__c  skill= new   SVMXC__Skill__c(Name = 'test Skill',
        GE_DRL_Skill_Category__c='Controls',
        SVMXC__Skill_Category__c ='Controls',
        GE_OG_DS_Product_Group__c='Intervention - Reeler',
        Sub_Business__c='Pressure Control');
        insert skill;
        List<SVMXC__Skill__c  > skillList = new List<SVMXC__Skill__c>();
        skillList.add(skill1);
        skillList.add(skill);
          GE_OG_SS_Master_Course__c course = new GE_OG_SS_Master_Course__c();
          course.GE_OG_SS_Course_Category__c = 'Test Category';
          course.Name = 'Test Course Name';
          course.GE_OG_SS_Course_Source__c = 'GElearning';   
          insert course;
           List<GE_OG_SS_Master_Course__c > cList= new List<GE_OG_SS_Master_Course__c >();      
          GE_OG_GS_Course__c tempCourse = new GE_OG_GS_Course__c(); 
          
          tempCourse.GE_OG_GS_Category__c ='Customer Requirement';          
          tempCourse.GE_OG_GS_Course_Name__c = 'test Course';
          tempCourse.GE_OG_GS_Course_Status__c= 'Passed';
          tempCourse.GE_DS_Criticality__c='Required';
          tempCourse.GE_OG_GS_Passed_Date__c= Date.Today();
          tempCourse.GE_OG_GS_Target_Level__c='ENTRY LEVEL'; 
          tempCourse.GE_OG_DRL_Course_Source__c='Test Source';         
          tempCourse.GE_OG_GS_Course_Technician__c=tech.Id; 
          tempCourse.GE_OG_SS_Master_Course__c = course.Id;      
          Insert tempCourse;              
         GE_OG_TechBean.courseAssignmentBean tempCourseAssign = new GE_OG_TechBean.courseAssignmentBean(); 
          
          tempCourseAssign.courseId = tempCourse.Id;
          tempCourseAssign.courseReference = tempCourse.Name;
          tempCourseAssign.courseName = tempCourse.GE_OG_GS_Course_Name__c;
          tempCourseAssign.courseCategory = tempCourse.GE_OG_GS_Category__c;
          tempCourseAssign.courseStatus = tempCourse.GE_OG_GS_Course_Status__c;
          tempCourseAssign.targetLevel = tempCourse.GE_OG_GS_Target_Level__c;
          tempCourseAssign.attendedDate = tempCourse.GE_OG_GS_Attended_Date__c;
          tempCourseAssign.passedDate = tempCourse.GE_OG_GS_Passed_Date__c;
          tempCourseAssign.courseExpiry = tempCourse.GE_DRL_Course_Expiry__c;
          tempCourseAssign.courseSource = tempCourse.GE_OG_SS_Course_Source__c;
          tempCourseAssign.criticality = tempCourse.GE_DS_Criticality__c;          
          tempCourseAssign.score = tempCourse.GE_OG_GS_Score__c;
          tempCourseAssign.courseCode = tempCourse.GE_OG_DRL_Course_Code__c;
          tempCourseAssign.courseNameAll = tempCourse.GE_OG_SS_Master_Course__r.Name;
          tempCourseAssign.isSelectCourse = true;
         List<GE_OG_TechBean.courseAssignmentBean> coursebean = new List<GE_OG_TechBean.courseAssignmentBean>();
        coursebean.add(tempCourseAssign);
        
          SVMXC__Service_Group_Skills__c ex= new SVMXC__Service_Group_Skills__c();
        ex.SVMXC__Skill__c=skill.id;
        ex.GE_PC_WorkOrders_Completed__c=1;
        ex.Expertise_Level__c='Level 0';
        ex.SVMXC__Group_Member__c=tech.id;
        ex.GE_DRL_Skill_Category__c='HT Lead';
        ex.GE_OG_PC_Skill_Level_Target_Date__c=date.today();
        ex.SVMXC__Service_Group__c=team.id;
        Insert ex;
        GE_OG_TechBean.expertiseBean tempExpertise = new GE_OG_TechBean.expertiseBean(); 
          
          tempExpertise.expertiseId = ex.Id;
          tempExpertise.recordNumber = ex.Name;
          tempExpertise.signOff = ex.GE_PC_Sign_Off__c;          
          tempExpertise.skillCategory = ex.GE_DRL_Skill_Category__c;
          tempExpertise.skillGroup = ex.GE_SS_Skill_Group__c;
          tempExpertise.skill = ex.SVMXC__Skill__r.Name;
          tempExpertise.expertiseLevel = ex.Expertise_Level__c;
          tempExpertise.lastCompletedWorkOrder = ex.GE_PC_Last_Completed_WorkOrder__r.Name;
          tempExpertise.workOrdersCompleted = ex.GE_PC_WorkOrders_Completed__c; 
          tempExpertise.skillLevel = ex.SVMXC__Skill_Level__c;
          tempExpertise.lastModifiedBy = ex.LastModifiedBy.Name;      
          tempExpertise.skillDescription = ex.GE_OG_Skill_Description__c;
          tempExpertise.currentTargetLevel = ex.GE_DRL_Current_Target_Level__c;
          tempExpertise.nextTargetLevel = ex.GE_DRL_Target_Level__c;
          tempExpertise.primarySkill = ex.SVMXC_Primary_Skill__c;        
          tempExpertise.isSelectExprt = true;
          
        List<GE_OG_TechBean.expertiseBean> expbean = new List<GE_OG_TechBean.expertiseBean>();        
        expbean.add(tempExpertise);  
        
          GE_OG_GS_Certification__c tempCerts = new GE_OG_GS_Certification__c(); 
          
          tempCerts.GE_OG_GS_Category__c ='Global Customer';          
          tempCerts.GE_OG_GS_Certificate_Name__c= 'test Certificate';
          tempCerts.GE_OG_GS_Status__c= 'Acquired';
          tempCerts.GE_OG_GS_Acquired_Date__c=Date.Today();
          tempCerts.GE_DS_Criticality__c='Required';
          tempCerts.GE_OG_GS_Cert_Technician__c=tech.Id;       
          Insert tempCerts;
            
          GE_OG_TechBean.certificationBean tempCertification = new GE_OG_TechBean.certificationBean(); 
            tempCertification.certificationId = tempCerts.Id;
            tempCertification.certificationReference = tempCerts.Name;
            tempCertification.certificationName = tempCerts.GE_OG_GS_Certificate_Name__c;
            tempCertification.category = tempCerts.GE_OG_GS_Category__c;
            tempCertification.status = tempCerts.GE_OG_GS_Status__c;
            tempCertification.acquiredDate = tempCerts.GE_OG_GS_Acquired_Date__c;
            tempCertification.isSelectCerts = true;
          List<GE_OG_TechBean.certificationBean> certbean = new List<GE_OG_TechBean.certificationBean>();
          certbean.add(tempCertification);  
                      
           GE_OG_Skill_Category_Group__c sCateGroup = new GE_OG_Skill_Category_Group__c(
        GE_OG_Skill_Category__c='Controls',
        GE_OG_Skill_Group__c = 'Hardware - EFL',
        Name= 'Test skillCategory');
        insert sCateGroup ;
         GE_OG_Skill_Category_Group__c sCateGroup1 = new GE_OG_Skill_Category_Group__c(
        GE_OG_Skill_Category__c='Controls',
        GE_OG_Skill_Group__c = 'Intervention - Reeler',
        Name= 'Test skillGroup');
        insert sCateGroup1 ;
        GE_OG_Certification_map__c  certCategObj = new GE_OG_Certification_map__c (
        GE_OG_CertsCategory__c = 'Test Category',
        GE_OG_Certification_Name__c ='Certified',
         Name= 'Test CertCateg&Name');
         insert certCategObj ;
         
           PageReference pageRef = Page.GE_OG_TechDataUpsert;
        Test.setCurrentPage(pageRef);
          ApexPages.currentPage().getParameters().put('techId1',tech.Id);
          ApexPages.currentPage().getParameters().put('recordType','Expert');  
          pageRef.getParameters().put('certCategory','DoA 2.0');
          pageRef.getParameters().put('certStatus','Passed');
          pageRef.getParameters().put('certName',certCategObj.Name);
           
           GE_OG_TechDataUpsertContrl tc = new GE_OG_TechDataUpsertContrl();  
          
         //PageReference  certpageref = tc.addCerts();
        
         tc.lstExpertiseBeans = expbean;
         tc.lstCourseAssignmentBeans = coursebean;
         tc.lstCertificationBeans = certbean;
         tc.passportTypeA= 'Primary';
         tc.passportremainingPagesA= 30;
         tc.passportExpiryDateA= Date.Today();
         tc.passportNumberA = '1234456';
         tc.passportIssueDateA = Date.Today();
         tc.passportStatusA = 'Expired';
         tc.passportCountryA = 'India';
         tc.passportIssuedByA = 'Test';
         tc.courseSource='test course source'; 
        tc.courseCode='TEST345';
        tc.courseCategory='Test Course Category';
        tc.courseName='Test Course23';
        tc.courseStatus='Passed';
        tc.courseCriticality='Optional';
        tc.courseTargetLevel='Level 1';
        tc.courseSearch='test';
        tc.legacyId='3424';
        tc.certCategory='Test Cert Category';
        tc.certName='Test Cert Nmae';
        tc.certStatus='Passed';
        tc.certType=' Test Cert Type';
        tc.additionalInfo='testing';
        tc.visaCountryA='India';
        tc.visaforA='Testing';
        tc.visaStatusA='Expired';    
        tc.attendedDate=Date.Today();
        tc.passedDate= Date.Today();   
        tc.aquiredDate=Date.Today();
        tc.expiryDate=Date.Today();
        tc.targetDate=Date.Today();
        tc.expiryDateA=Date.Today();
        tc.issueDateA=Date.Today();
        tc.isSelectSkill=true;
        tc.isSelectCour= true;
        tc.skillLst = skillList;
              
        GE_OG_GS_Passport__c addPassport = new GE_OG_GS_Passport__c();
        addPassport.GE_OG_GS_Passport_Number__c=tc.passportNumberA;
        addPassport.GE_OG_GS_Passport_Type__c=tc.passportTypeA;
        addPassport.GE_OG_GS_Passport_Expiry_Date__c=tc.passportExpiryDateA;
        addPassport.GE_OG_GS_Issued_Date__c=tc.passportIssueDateA;
        addPassport.GE_OG_GS_Issued_By__c=tc.passportIssuedByA;
        addPassport.GE_OG_GS_Passport_Status__c=tc.passportStatusA;
        addPassport.GE_OG_GS_Technician__c=tech.Id;
        addPassport.GE_OG_GS_Passport_Country__c=tc.passportCountryA;
        addPassport.GE_OG_GS_Remaining_Pages__c =tc.passportremainingPagesA;
        insert addPassport;        
        tc.passportA= addPassport.GE_OG_GS_Passport_Number__c;
         
          GE_OG_GS_Visa__c tempvisa = new GE_OG_GS_Visa__c(); 
          tempvisa.GE_OG_GS_Passport__c= addPassport.Id;
          tempvisa.GE_OG_GS_Visa_For__c= 'Business Visa';
          tempvisa.GE_OG_GS_Visa_Expiry_Date__c=Date.Today();
          tempvisa.GE_OG_GS_Visa_Country__c='Ireland';
          tempvisa.GE_OG_GS_Technician__c=tech.Id;       
          Insert tempvisa;   
         
        ApexPages.currentPage().getParameters().put('techId',tech.Id);
        String category;
        string skillGroup;
        string selectedCateg;
        string selectedGroup;
        GE_OG_TechDatacontrl tst = new GE_OG_TechDatacontrl ();             
        tst.callexpertPage();
        tst.callcoursePage();
        tst.callCertsPage();
        tst.callPassportPage();
        tst.callVisaPage();
       
        ApexPages.currentPage().getParameters().put('selectedCateg','Controls' );
         ApexPages.currentPage().getParameters().put('selectedGroup','Hardware - EFL' );
         
        GE_OG_TechDataUpsertHelper tstUpsertH = new GE_OG_TechDataUpsertHelper();
        tstUpsertH.getExpertises(tech.Id);
        tstUpsertH.getCourseAssignments(tech.Id);
        tstUpsertH.getCertifications(tech.Id);
        tstUpsertH.getVisas(tech.Id);
        tstUpsertH.getPassports(tech.Id);
        tc.courses = course;
        tc.skills= skill1;
        
        GE_OG_TechDataUpsertContrl.skillWrapper sw = new GE_OG_TechDataUpsertContrl.skillWrapper(skill1);
        sw.isSelectSkill=true;  
        sw.objSkill =  tc.skills;
        tc.skillwrprList.add(sw);
        GE_OG_TechDataUpsertContrl.CourseWrapper cw = new GE_OG_TechDataUpsertContrl.CourseWrapper(course);
        cw.isSelectCour=true;  
        cw.objCourse =tc.courses;
        //tc.cwrprList.add(cw);        
        tc.category=sCateGroup.Name ;
        tc.skillGroup=sCateGroup.Name ;
       // selectedGroup = sCateGroup.GE_OG_Skill_Group__c;
       // selectedCateg = sCateGroup.GE_OG_Skill_Category__c;       
       
        Set<Id> skillIds= new Set<Id>();
        skillIds.add(ex.SVMXC__Skill__c);
        
        GE_OG_TechBean.visaBean visabean = new GE_OG_TechBean.visaBean();
        visabean.isSelectVisa= true;
        GE_OG_TechBean.passportBean passportbean = new GE_OG_TechBean.passportBean();
        passportbean.isSelectPassport = true;
        
        tc.Go();
        
        tc.getLevel();
        tc.getcategorylist();
        tc.getgroupList();
        tc.editExpertMethod();
        tc.showRecords();        
        tc.Cancelexpt();            
        //tc.addCourse();
        tc.ShowCourseMethod();
        tc.updateCerts();
        tc.courseSearch();
        tc.addCerts();
        tc.editVisaMethod();
        tc.ShowVisaMethod();
        tc.addVisa();        
        tc.saveVisa();
        tc.ShowBlockMethod();
        tc.editCertsMethod();
        tc.editCourseMethod();
        tc.ShowpassportMethod();
        tc.editpassportMethod();
        tc.addPassport();
        tc.savePassport();
        tc.saveExpertise();
        tc.addExpertise();       
        tstUpsertH.CheckSelection();
        tstUpsertH.CheckSuccess();
        tstUpsertH.CheckSkillSelection();
        tstUpsertH.CheckaddExpertiseSuccess();
        tc.getCourStatus();
        tc.getCourTargetLevel();
        tc.getCourName();
        tc.getCourCriticality();
        tc.getCourCategory();
        tc.getCourCurrentLevl();
        tc.getCourTrainingPath();
        tc.getCertsName();
        tc.getPassports();
        tc.cancelCour();
        tstUpsertH.CheckSuccessCour();
        tstUpsertH.CheckSelectionCour();
        tstUpsertH.CheckCourseSelection();
        tstUpsertH.CheckaddCourseSuccess();
        tc.cancelCour();
        tstUpsertH.CheckSelectionCert();
        tstUpsertH.CheckSuccessCert();
        tstUpsertH.CheckaddCertSuccess();
        tc.cancelCerts();   
        tc.cancelVisa();
        tstUpsertH.CheckSelectionVisa();
        tstUpsertH.CheckSuccessVisa();
        tstUpsertH.CheckaddVisaSuccess(); 
        tstUpsertH.CheckSelectionPassport();
        tstUpsertH.CheckSuccessPassport();
        tstUpsertH.CheckaddPassportSuccess();     
        tc.cancelPassport();
        tc.getCertscategory();
        tc.getcertStatusList();
        tc.getcertTypeList();
        tc.getVisacountry();
        tc.getVisaStatus();
        tc.getVisafor();
        tc.getpassportCountrylst(); 
        tc.getpassportStatuslst();
        tc.getpassportTypelst();
        tc.saveCourse();
        tc.goback();
        }
        test.stopTest();
    }
    static testmethod void test4()
    {
         Test.StartTest();  
         //User u1 = [SELECT Id FROM User WHERE GE_HQ_SSO_ID__c='502324626'];
         User u1 = [SELECT Id FROM User WHERE Profile.Name='GE_PC_Super Technician' AND IsActive = TRUE limit 1];
        System.runAs(u1) {   
         
         //ServiceTeam Insert
        SVMXC__Service_Group__c team = new SVMXC__Service_Group__c();
        team.name='Test Team';
        team.GE_OG_DS_Billing_Admin_Email__c='test@test.com';
        team.GE_HQ_P_L_Level__c='O&G > D&S';
        insert team;  
         
          //Technician Insert     
        SVMXC__Service_Group_Members__c tech = new SVMXC__Service_Group_Members__c(
        SVMXC__Service_Group__c = team.Id,
        Name = 'SVMX Tech',
        SVMXC__Active__c = true,
        SVMXC__Enable_Scheduling__c = true,
        SVMXC__Email__c = 'test.abc@xyz.com',
        GE_SM_HQ_SSO_ID__c = '502324626',
        SVMCX_Status__c = 'Active GE',
        GE_SM_HQ_Regional_Manager__c = 'SVMX',
        GE_SM_HQ_Manager_Email__c = 'test.abc@xyz.com',
        SVMXC_Function__c = 'Services',
        GE_SM_HQ_Controls_EmpType__c = 'Field Engineer', 
        SVMXC__Salesforce_User__c = UserInfo.getUserId()
        );
        insert tech;
        //New Skill
        SVMXC__Skill__c  skill1= new   SVMXC__Skill__c(Name = 'test Skill',
        GE_DRL_Skill_Category__c='Controls',
        SVMXC__Skill_Category__c ='Controls',
        GE_OG_DS_Product_Group__c='Hardware - EFL',
        Sub_Business__c='Pressure Control');
        insert skill1;
        SVMXC__Skill__c  skill= new   SVMXC__Skill__c(Name = 'test Skill',
        GE_DRL_Skill_Category__c='Controls',
        SVMXC__Skill_Category__c ='Controls',
        GE_OG_DS_Product_Group__c='Intervention - Reeler',
        Sub_Business__c='Pressure Control');
        insert skill;
      integer i=0;
      
          GE_OG_GS_Course__c tempCourse = new GE_OG_GS_Course__c(); 
          
          tempCourse.GE_OG_GS_Category__c ='Customer Requirement';          
          tempCourse.GE_OG_GS_Course_Name__c = 'test Course';
          tempCourse.GE_OG_GS_Course_Status__c= 'Passed';
          tempCourse.GE_DS_Criticality__c='Required';
          tempCourse.GE_OG_GS_Passed_Date__c= Date.Today();
          tempCourse.GE_OG_GS_Target_Level__c='ENTRY LEVEL'; 
          tempCourse.GE_OG_DRL_Course_Source__c='Test Source';
          tempCourse.GE_OG_GS_Course_Technician__c=tech.Id;       
          Insert tempCourse;              
         
          SVMXC__Service_Group_Skills__c ex= new SVMXC__Service_Group_Skills__c();
        ex.SVMXC__Skill__c=skill.id;
        ex.GE_PC_WorkOrders_Completed__c=1;
        ex.Expertise_Level__c='Level 0';
        ex.SVMXC__Group_Member__c=tech.id;
        ex.GE_DRL_Skill_Category__c='HT Lead';
        ex.GE_OG_PC_Skill_Level_Target_Date__c=date.today();
        ex.SVMXC__Service_Group__c=team.id;
        Insert ex;
                  
          GE_OG_GS_Certification__c tempCerts = new GE_OG_GS_Certification__c(); 
          
          tempCerts.GE_OG_GS_Category__c ='Global Customer';          
          tempCerts.GE_OG_GS_Certificate_Name__c= 'test Certificate';
          tempCerts.GE_OG_GS_Status__c= 'Acquired';
          tempCerts.GE_OG_GS_Acquired_Date__c=Date.Today();
          tempCerts.GE_DS_Criticality__c='Required';
          tempCerts.GE_OG_GS_Cert_Technician__c=tech.Id;       
          Insert tempCerts;   
         
         GE_OG_GS_Passport__c tempPass = new GE_OG_GS_Passport__c(
         GE_OG_GS_Passport_Type__c= 'Primary',
         GE_OG_GS_Remaining_Pages__c= 30,
         GE_OG_GS_Passport_Expiry_Date__c= Date.Today(),
         GE_OG_GS_Technician__c=tech.Id); 
         Insert tempPass;
         
          
          GE_OG_GS_Visa__c tempvisa = new GE_OG_GS_Visa__c(); 
          tempvisa.GE_OG_GS_Passport__c= tempPass.Id;
          tempvisa.GE_OG_GS_Visa_For__c= 'Business Visa';
          tempvisa.GE_OG_GS_Visa_Expiry_Date__c=Date.Today();
          tempvisa.GE_OG_GS_Visa_Country__c='Ireland';
          tempvisa.GE_OG_GS_Technician__c=tech.Id;       
          Insert tempvisa;   
         
        ApexPages.currentPage().getParameters().put('techId',tech.Id);
        String category;
        string skillGroup;
        string selectedCateg;
        string selectedGroup;
        GE_OG_TechDatacontrl tst = new GE_OG_TechDatacontrl ();             
        tst.callexpertPage();
        tst.callcoursePage();
        tst.callCertsPage();
        tst.callPassportPage();
        tst.callVisaPage();
        tst.callTechAttachmentPage();
        GE_OG_Skill_Category_Group__c sCateGroup = new GE_OG_Skill_Category_Group__c(
        GE_OG_Skill_Category__c='Controls',
        GE_OG_Skill_Group__c = 'Hardware - EFL',
        Name= 'Test skillCategory');
        insert sCateGroup ;
         GE_OG_Skill_Category_Group__c sCateGroup1 = new GE_OG_Skill_Category_Group__c(
        GE_OG_Skill_Category__c='Controls',
        GE_OG_Skill_Group__c = 'Intervention - Reeler',
        Name= 'Test skillGroup');
        insert sCateGroup1 ;
        ApexPages.currentPage().getParameters().put('techId1',tech.Id);
        ApexPages.currentPage().getParameters().put('recordType','Course');        
        GE_OG_TechDataUpsertHelper tstUpsertH = new GE_OG_TechDataUpsertHelper();
        tstUpsertH.getExpertises(tech.Id);
        tstUpsertH.getCourseAssignments(tech.Id);
        tstUpsertH.getCertifications(tech.Id);
        tstUpsertH.getVisas(tech.Id);
        tstUpsertH.getPassports(tech.Id);
        GE_OG_TechDataUpsertContrl tc = new GE_OG_TechDataUpsertContrl();
        GE_OG_TechDataUpsertContrl.skillWrapper sw = new GE_OG_TechDataUpsertContrl.skillWrapper(skill1);
        sw.isSelectSkill=true;  
        sw.objSkill =  skill1;
              
       // tc.skillwrprList.add(sw);  
        Set<Id> skillIds= new Set<Id>();
        skillIds.add(ex.SVMXC__Skill__c);
        System.Debug('***category***'+tc.category);
        System.Debug('***Skill Group***'+tc.skillGroup);
        System.Debug('***Selectedcategory***'+selectedCateg);
        System.Debug('***Selected Group***'+selectedGroup);
        
        
        GE_OG_TechDataUpsertContrl tstUpsert = new GE_OG_TechDataUpsertContrl();  
        
        
        //tstUpsert.Go();     
                
       // tstUpsert.addCourse();       
       // tstUpsert.updateCerts();
        tstUpsert.courseSearch();
       // tstUpsert.addCerts();        
        //tstUpsert.addVisa();
        //tstUpsert.saveVisa();        
      //  tstUpsert.addPassport();
        //tstUpsert.savePassport();
        //tstUpsert.saveExpertise();
       // tstUpsert.addExpertise();       
       
        }
        test.stopTest();
    }
    static testmethod void test5()
    {
         Test.StartTest();  
        // User u1 = [SELECT Id FROM User WHERE GE_HQ_SSO_ID__c='502324626'];
         User u1 = [SELECT Id FROM User WHERE Profile.Name='GE_PC_Super Technician' AND IsActive = TRUE limit 1];
        System.runAs(u1) {   
         
         //ServiceTeam Insert
        SVMXC__Service_Group__c team = new SVMXC__Service_Group__c();
        team.name='Test Team';
        team.GE_OG_DS_Billing_Admin_Email__c='test@test.com';
        team.GE_HQ_P_L_Level__c='O&G > D&S';
        insert team;  
         
          //Technician Insert     
        SVMXC__Service_Group_Members__c tech = new SVMXC__Service_Group_Members__c(
        SVMXC__Service_Group__c = team.Id,
        Name = 'SVMX Tech',
        SVMXC__Active__c = true,
        SVMXC__Enable_Scheduling__c = true,
        SVMXC__Email__c = 'test.abc@xyz.com',
        GE_SM_HQ_SSO_ID__c = '502324626',
        SVMCX_Status__c = 'Active GE',
        GE_SM_HQ_Regional_Manager__c = 'SVMX',
        GE_SM_HQ_Manager_Email__c = 'test.abc@xyz.com',
        SVMXC_Function__c = 'Services',
        GE_SM_HQ_Controls_EmpType__c = 'Field Engineer', 
        SVMXC__Salesforce_User__c = UserInfo.getUserId()
        );
        insert tech;
        //New Skill
        SVMXC__Skill__c  skill1= new   SVMXC__Skill__c(Name = 'test Skill',
        GE_DRL_Skill_Category__c='Controls',
        SVMXC__Skill_Category__c ='Controls',
        GE_OG_DS_Product_Group__c='Hardware - EFL',
        Sub_Business__c='Pressure Control');
        insert skill1;
        SVMXC__Skill__c  skill= new   SVMXC__Skill__c(Name = 'test Skill',
        GE_DRL_Skill_Category__c='Controls',
        SVMXC__Skill_Category__c ='Controls',
        GE_OG_DS_Product_Group__c='Intervention - Reeler',
        Sub_Business__c='Pressure Control');
        insert skill;
      integer i=0;
      
          GE_OG_GS_Course__c tempCourse = new GE_OG_GS_Course__c(); 
          
          tempCourse.GE_OG_GS_Category__c ='Customer Requirement';          
          tempCourse.GE_OG_GS_Course_Name__c = 'test Course';
          tempCourse.GE_OG_GS_Course_Status__c= 'Passed';
          tempCourse.GE_DS_Criticality__c='Required';
          tempCourse.GE_OG_GS_Passed_Date__c= Date.Today();
          tempCourse.GE_OG_GS_Target_Level__c='ENTRY LEVEL'; 
          tempCourse.GE_OG_DRL_Course_Source__c='Test Source';
          tempCourse.GE_OG_GS_Course_Technician__c=tech.Id;       
          Insert tempCourse;              
         
          SVMXC__Service_Group_Skills__c ex= new SVMXC__Service_Group_Skills__c();
        ex.SVMXC__Skill__c=skill.id;
        ex.GE_PC_WorkOrders_Completed__c=1;
        ex.Expertise_Level__c='Level 0';
        ex.SVMXC__Group_Member__c=tech.id;
        ex.GE_DRL_Skill_Category__c='HT Lead';
        ex.GE_OG_PC_Skill_Level_Target_Date__c=date.today();
        ex.SVMXC__Service_Group__c=team.id;
        Insert ex;
                  
          GE_OG_GS_Certification__c tempCerts = new GE_OG_GS_Certification__c(); 
          
          tempCerts.GE_OG_GS_Category__c ='Global Customer';          
          tempCerts.GE_OG_GS_Certificate_Name__c= 'test Certificate';
          tempCerts.GE_OG_GS_Status__c= 'Acquired';
          tempCerts.GE_OG_GS_Acquired_Date__c=Date.Today();
          tempCerts.GE_DS_Criticality__c='Required';
          tempCerts.GE_OG_GS_Cert_Technician__c=tech.Id;       
          Insert tempCerts;   
         
         GE_OG_GS_Passport__c tempPass = new GE_OG_GS_Passport__c(
         GE_OG_GS_Passport_Type__c= 'Primary',
         GE_OG_GS_Remaining_Pages__c= 30,
         GE_OG_GS_Passport_Expiry_Date__c= Date.Today(),
         GE_OG_GS_Technician__c=tech.Id); 
         Insert tempPass;
         
          
          GE_OG_GS_Visa__c tempvisa = new GE_OG_GS_Visa__c(); 
          tempvisa.GE_OG_GS_Passport__c= tempPass.Id;
          tempvisa.GE_OG_GS_Visa_For__c= 'Business Visa';
          tempvisa.GE_OG_GS_Visa_Expiry_Date__c=Date.Today();
          tempvisa.GE_OG_GS_Visa_Country__c='Ireland';
          tempvisa.GE_OG_GS_Technician__c=tech.Id;       
          Insert tempvisa;   
         
        ApexPages.currentPage().getParameters().put('techId',tech.Id);
        String category;
        string skillGroup;
        string selectedCateg;
        string selectedGroup;
        GE_OG_TechDatacontrl tst = new GE_OG_TechDatacontrl ();             
        tst.callexpertPage();
        tst.callcoursePage();
        tst.callCertsPage();
        tst.callPassportPage();
        tst.callVisaPage();
        GE_OG_Skill_Category_Group__c sCateGroup = new GE_OG_Skill_Category_Group__c(
        GE_OG_Skill_Category__c='Controls',
        GE_OG_Skill_Group__c = 'Hardware - EFL',
        Name= 'Test skillCategory');
        insert sCateGroup ;
         GE_OG_Skill_Category_Group__c sCateGroup1 = new GE_OG_Skill_Category_Group__c(
        GE_OG_Skill_Category__c='Controls',
        GE_OG_Skill_Group__c = 'Intervention - Reeler',
        Name= 'Test skillGroup');
        insert sCateGroup1 ;
        ApexPages.currentPage().getParameters().put('techId1',tech.Id);
        ApexPages.currentPage().getParameters().put('recordType','Certification');        
        GE_OG_TechDataUpsertHelper tstUpsertH = new GE_OG_TechDataUpsertHelper();
        tstUpsertH.getExpertises(tech.Id);
        tstUpsertH.getCourseAssignments(tech.Id);
        tstUpsertH.getCertifications(tech.Id);
        tstUpsertH.getVisas(tech.Id);
        tstUpsertH.getPassports(tech.Id);
        GE_OG_TechDataUpsertContrl tc = new GE_OG_TechDataUpsertContrl();
        GE_OG_TechDataUpsertContrl.skillWrapper sw = new GE_OG_TechDataUpsertContrl.skillWrapper(skill1);
        sw.isSelectSkill=true;  
        sw.objSkill =  skill1;
              
       // tstUpsert.skillwrprList.add(sw);  
        Set<Id> skillIds= new Set<Id>();
        skillIds.add(ex.SVMXC__Skill__c);
        System.Debug('***category***'+tc.category);
        System.Debug('***Skill Group***'+tc.skillGroup);
        System.Debug('***Selectedcategory***'+selectedCateg);
        System.Debug('***Selected Group***'+selectedGroup);
        
        
        GE_OG_TechDataUpsertContrl tstUpsert = new GE_OG_TechDataUpsertContrl();  
        
        
        //tstUpsert.Go();     
                
       // tstUpsert.addCourse();       
       // tstUpsert.updateCerts();
        tstUpsert.courseSearch();
       // tstUpsert.addCerts();        
        //tstUpsert.addVisa();
        //tstUpsert.saveVisa();        
      //  tstUpsert.addPassport();
        //tstUpsert.savePassport();
        //tstUpsert.saveExpertise();
       // tstUpsert.addExpertise();       
       
        }
        test.stopTest();
    }
    static testmethod void test6()
    {
         Test.StartTest();  
         //User u1 = [SELECT Id FROM User WHERE GE_HQ_SSO_ID__c='502324626'];
         User u1 = [SELECT Id FROM User WHERE Profile.Name='GE_PC_Super Technician' AND IsActive = TRUE limit 1];
        System.runAs(u1) {   
         
         //ServiceTeam Insert
        SVMXC__Service_Group__c team = new SVMXC__Service_Group__c();
        team.name='Test Team';
        team.GE_OG_DS_Billing_Admin_Email__c='test@test.com';
        team.GE_HQ_P_L_Level__c='O&G > D&S';
        insert team;  
         
          //Technician Insert     
        SVMXC__Service_Group_Members__c tech = new SVMXC__Service_Group_Members__c(
        SVMXC__Service_Group__c = team.Id,
        Name = 'SVMX Tech',
        SVMXC__Active__c = true,
        SVMXC__Enable_Scheduling__c = true,
        SVMXC__Email__c = 'test.abc@xyz.com',
        GE_SM_HQ_SSO_ID__c = '502324626',
        SVMCX_Status__c = 'Active GE',
        GE_SM_HQ_Regional_Manager__c = 'SVMX',
        GE_SM_HQ_Manager_Email__c = 'test.abc@xyz.com',
        SVMXC_Function__c = 'Services',
        GE_SM_HQ_Controls_EmpType__c = 'Field Engineer', 
        SVMXC__Salesforce_User__c = UserInfo.getUserId()
        );
        insert tech;
        //New Skill
        SVMXC__Skill__c  skill1= new   SVMXC__Skill__c(Name = 'test Skill',
        GE_DRL_Skill_Category__c='Controls',
        SVMXC__Skill_Category__c ='Controls',
        GE_OG_DS_Product_Group__c='Hardware - EFL',
        Sub_Business__c='Pressure Control');
        insert skill1;
        SVMXC__Skill__c  skill= new   SVMXC__Skill__c(Name = 'test Skill',
        GE_DRL_Skill_Category__c='Controls',
        SVMXC__Skill_Category__c ='Controls',
        GE_OG_DS_Product_Group__c='Intervention - Reeler',
        Sub_Business__c='Pressure Control');
        insert skill;
      integer i=0;
      
          GE_OG_GS_Course__c tempCourse = new GE_OG_GS_Course__c(); 
          
          tempCourse.GE_OG_GS_Category__c ='Customer Requirement';          
          tempCourse.GE_OG_GS_Course_Name__c = 'test Course';
          tempCourse.GE_OG_GS_Course_Status__c= 'Passed';
          tempCourse.GE_DS_Criticality__c='Required';
          tempCourse.GE_OG_GS_Passed_Date__c= Date.Today();
          tempCourse.GE_OG_GS_Target_Level__c='ENTRY LEVEL'; 
          tempCourse.GE_OG_DRL_Course_Source__c='Test Source';
          tempCourse.GE_OG_GS_Course_Technician__c=tech.Id;       
          Insert tempCourse;              
         
          SVMXC__Service_Group_Skills__c ex= new SVMXC__Service_Group_Skills__c();
        ex.SVMXC__Skill__c=skill.id;
        ex.GE_PC_WorkOrders_Completed__c=1;
        ex.Expertise_Level__c='Level 0';
        ex.SVMXC__Group_Member__c=tech.id;
        ex.GE_DRL_Skill_Category__c='HT Lead';
        ex.GE_OG_PC_Skill_Level_Target_Date__c=date.today();
        ex.SVMXC__Service_Group__c=team.id;
        Insert ex;
                  
          GE_OG_GS_Certification__c tempCerts = new GE_OG_GS_Certification__c(); 
          
          tempCerts.GE_OG_GS_Category__c ='Global Customer';          
          tempCerts.GE_OG_GS_Certificate_Name__c= 'test Certificate';
          tempCerts.GE_OG_GS_Status__c= 'Acquired';
          tempCerts.GE_OG_GS_Acquired_Date__c=Date.Today();
          tempCerts.GE_DS_Criticality__c='Required';
          tempCerts.GE_OG_GS_Cert_Technician__c=tech.Id;       
          Insert tempCerts;   
         
         GE_OG_GS_Passport__c tempPass = new GE_OG_GS_Passport__c(
         GE_OG_GS_Passport_Type__c= 'Primary',
         GE_OG_GS_Remaining_Pages__c= 30,
         GE_OG_GS_Passport_Expiry_Date__c= Date.Today(),
         GE_OG_GS_Technician__c=tech.Id); 
         Insert tempPass;
         
          
          GE_OG_GS_Visa__c tempvisa = new GE_OG_GS_Visa__c(); 
          tempvisa.GE_OG_GS_Passport__c= tempPass.Id;
          tempvisa.GE_OG_GS_Visa_For__c= 'Business Visa';
          tempvisa.GE_OG_GS_Visa_Expiry_Date__c=Date.Today();
          tempvisa.GE_OG_GS_Visa_Country__c='Ireland';
          tempvisa.GE_OG_GS_Technician__c=tech.Id;       
          Insert tempvisa;   
         
        ApexPages.currentPage().getParameters().put('techId',tech.Id);
        GE_OG_TechDatacontrl tst = new GE_OG_TechDatacontrl ();             
        tst.callexpertPage();
        tst.callcoursePage();
        tst.callCertsPage();
        tst.callPassportPage();
        tst.callVisaPage();
        GE_OG_Skill_Category_Group__c sCateGroup = new GE_OG_Skill_Category_Group__c(
        GE_OG_Skill_Category__c='Controls',
        GE_OG_Skill_Group__c = 'Hardware - EFL',
        Name= 'Test skillCategory');
        insert sCateGroup ;
         GE_OG_Skill_Category_Group__c sCateGroup1 = new GE_OG_Skill_Category_Group__c(
        GE_OG_Skill_Category__c='Controls',
        GE_OG_Skill_Group__c = 'Intervention - Reeler',
        Name= 'Test skillGroup');
        insert sCateGroup1 ;
        ApexPages.currentPage().getParameters().put('techId1',tech.Id);
        ApexPages.currentPage().getParameters().put('recordType','Passport');        
        GE_OG_TechDataUpsertHelper tstUpsertH = new GE_OG_TechDataUpsertHelper();
        tstUpsertH.getExpertises(tech.Id);
        tstUpsertH.getCourseAssignments(tech.Id);
        tstUpsertH.getCertifications(tech.Id);
        tstUpsertH.getVisas(tech.Id);
        tstUpsertH.getPassports(tech.Id);
        GE_OG_TechDataUpsertContrl tc = new GE_OG_TechDataUpsertContrl();
        GE_OG_TechDataUpsertContrl.skillWrapper sw = new GE_OG_TechDataUpsertContrl.skillWrapper(skill1);
        sw.isSelectSkill=true;  
        sw.objSkill =  skill1;
        
        }
        test.stopTest();
    }
    static testmethod void test7()
    {
         Test.StartTest();  
         //User u1 = [SELECT Id FROM User WHERE GE_HQ_SSO_ID__c='502324626'];
         User u1 = [SELECT Id FROM User WHERE Profile.Name='GE_PC_Super Technician' AND IsActive = TRUE limit 1];
        System.runAs(u1) {   
         
         //ServiceTeam Insert
        SVMXC__Service_Group__c team = new SVMXC__Service_Group__c();
        team.name='Test Team';
        team.GE_OG_DS_Billing_Admin_Email__c='test@test.com';
        team.GE_HQ_P_L_Level__c='O&G > D&S';
        insert team;  
         
          //Technician Insert     
        SVMXC__Service_Group_Members__c tech = new SVMXC__Service_Group_Members__c(
        SVMXC__Service_Group__c = team.Id,
        Name = 'SVMX Tech',
        SVMXC__Active__c = true,
        SVMXC__Enable_Scheduling__c = true,
        SVMXC__Email__c = 'test.abc@xyz.com',
        GE_SM_HQ_SSO_ID__c = '502324626',
        SVMCX_Status__c = 'Active GE',
        GE_SM_HQ_Regional_Manager__c = 'SVMX',
        GE_SM_HQ_Manager_Email__c = 'test.abc@xyz.com',
        SVMXC_Function__c = 'Services',
        GE_SM_HQ_Controls_EmpType__c = 'Field Engineer', 
        SVMXC__Salesforce_User__c = UserInfo.getUserId()
        );
        insert tech;
        //New Skill
       SVMXC__Skill__c  skill1= new   SVMXC__Skill__c(Name = 'test Skill',
        GE_DRL_Skill_Category__c='Controls',
        SVMXC__Skill_Category__c ='Controls',
        GE_OG_DS_Product_Group__c='Hardware - EFL',
        Sub_Business__c='Pressure Control');
        insert skill1;
        SVMXC__Skill__c  skill= new   SVMXC__Skill__c(Name = 'test Skill',
        GE_DRL_Skill_Category__c='Controls',
        SVMXC__Skill_Category__c ='Controls',
        GE_OG_DS_Product_Group__c='Intervention - Reeler',
        Sub_Business__c='Pressure Control');
        insert skill;
      integer i=0;
      
          GE_OG_GS_Course__c tempCourse = new GE_OG_GS_Course__c(); 
          
          tempCourse.GE_OG_GS_Category__c ='Customer Requirement';          
          tempCourse.GE_OG_GS_Course_Name__c = 'test Course';
          tempCourse.GE_OG_GS_Course_Status__c= 'Passed';
          tempCourse.GE_DS_Criticality__c='Required';
          tempCourse.GE_OG_GS_Passed_Date__c= Date.Today();
          tempCourse.GE_OG_GS_Target_Level__c='ENTRY LEVEL'; 
          tempCourse.GE_OG_DRL_Course_Source__c='Test Source';
          tempCourse.GE_OG_GS_Course_Technician__c=tech.Id;       
          Insert tempCourse;              
         
          SVMXC__Service_Group_Skills__c ex= new SVMXC__Service_Group_Skills__c();
        ex.SVMXC__Skill__c=skill.id;
        ex.GE_PC_WorkOrders_Completed__c=1;
        ex.Expertise_Level__c='Level 0';
        ex.SVMXC__Group_Member__c=tech.id;
        ex.GE_DRL_Skill_Category__c='HT Lead';
        ex.GE_OG_PC_Skill_Level_Target_Date__c=date.today();
        ex.SVMXC__Service_Group__c=team.id;
        Insert ex;
                  
          GE_OG_GS_Certification__c tempCerts = new GE_OG_GS_Certification__c(); 
          
          tempCerts.GE_OG_GS_Category__c ='Global Customer';          
          tempCerts.GE_OG_GS_Certificate_Name__c= 'test Certificate';
          tempCerts.GE_OG_GS_Status__c= 'Acquired';
          tempCerts.GE_OG_GS_Acquired_Date__c=Date.Today();
          tempCerts.GE_DS_Criticality__c='Required';
          tempCerts.GE_OG_GS_Cert_Technician__c=tech.Id;       
          Insert tempCerts;   
         
         GE_OG_GS_Passport__c tempPass = new GE_OG_GS_Passport__c(
         GE_OG_GS_Passport_Type__c= 'Primary',
         GE_OG_GS_Remaining_Pages__c= 30,
         GE_OG_GS_Passport_Expiry_Date__c= Date.Today(),
         GE_OG_GS_Technician__c=tech.Id); 
         Insert tempPass;
         
          
          GE_OG_GS_Visa__c tempvisa = new GE_OG_GS_Visa__c(); 
          tempvisa.GE_OG_GS_Passport__c= tempPass.Id;
          tempvisa.GE_OG_GS_Visa_For__c= 'Business Visa';
          tempvisa.GE_OG_GS_Visa_Expiry_Date__c=Date.Today();
          tempvisa.GE_OG_GS_Visa_Country__c='Ireland';
          tempvisa.GE_OG_GS_Technician__c=tech.Id;       
          Insert tempvisa;   
         
        ApexPages.currentPage().getParameters().put('techId',tech.Id);
        String category;
        string skillGroup;
        string selectedCateg;
        string selectedGroup;
        GE_OG_TechDatacontrl tst = new GE_OG_TechDatacontrl ();             
        tst.callexpertPage();
        tst.callcoursePage();
        tst.callCertsPage();
        tst.callPassportPage();
        tst.callVisaPage();
       GE_OG_Skill_Category_Group__c sCateGroup = new GE_OG_Skill_Category_Group__c(
        GE_OG_Skill_Category__c='Controls',
        GE_OG_Skill_Group__c = 'Hardware - EFL',
        Name= 'Test skillCategory');
        insert sCateGroup ;
         GE_OG_Skill_Category_Group__c sCateGroup1 = new GE_OG_Skill_Category_Group__c(
        GE_OG_Skill_Category__c='Controls',
        GE_OG_Skill_Group__c = 'Intervention - Reeler',
        Name= 'Test skillGroup');
        insert sCateGroup1 ;
        ApexPages.currentPage().getParameters().put('techId1',tech.Id);
        ApexPages.currentPage().getParameters().put('recordType','Visa');        
        GE_OG_TechDataUpsertHelper tstUpsertH = new GE_OG_TechDataUpsertHelper();
        tstUpsertH.getExpertises(tech.Id);
        tstUpsertH.getCourseAssignments(tech.Id);
        tstUpsertH.getCertifications(tech.Id);
        tstUpsertH.getVisas(tech.Id);
        tstUpsertH.getPassports(tech.Id); 
        GE_OG_TechDataUpsertContrl tc = new GE_OG_TechDataUpsertContrl();
        GE_OG_TechDataUpsertContrl.skillWrapper sw = new GE_OG_TechDataUpsertContrl.skillWrapper(skill1);
        sw.isSelectSkill=true;  
        sw.objSkill =  skill1;
              
       // tstUpsert.skillwrprList.add(sw);  
        Set<Id> skillIds= new Set<Id>();
        skillIds.add(ex.SVMXC__Skill__c);
        System.Debug('***category***'+tc.category);
        System.Debug('***Skill Group***'+tc.skillGroup);
        System.Debug('***Selectedcategory***'+selectedCateg);
        System.Debug('***Selected Group***'+selectedGroup);
        
        
        GE_OG_TechDataUpsertContrl tstUpsert = new GE_OG_TechDataUpsertContrl();  
        
        tstUpsert.courseSearch();
        }
        test.stopTest();
    }
    
    static testmethod void test8()
    {
     Test.StartTest();  
         //User u1 = [SELECT Id FROM User WHERE GE_HQ_SSO_ID__c='502324626'];
         User u1 = [SELECT Id FROM User WHERE Profile.Name='GE_PC_Super Technician' AND IsActive = TRUE limit 1];
        System.runAs(u1) {   
         
         
         //Account 
            Account acc = new Account();
            ID accrecid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('CMF Approved').getRecordTypeId();
            acc.RecordTypeId = accrecid;
            acc.name = 'testaccount';
            acc.Classification__c = 'Strategic';
          acc.OwnerId = '005A0000001ztawIAA';
            insert acc; 
         
         //ServiceTeam Insert
        SVMXC__Service_Group__c team = new SVMXC__Service_Group__c();
        team.name='Test Team';
        team.GE_OG_DS_Billing_Admin_Email__c='test@test.com';
        team.GE_HQ_P_L_Level__c='O&G > D&S';
        insert team;  
         
          //Technician Insert     
        SVMXC__Service_Group_Members__c tech = new SVMXC__Service_Group_Members__c(
        SVMXC__Service_Group__c = team.Id,
        Name = 'SVMX Tech',
        SVMXC__Active__c = true,
        SVMXC__Enable_Scheduling__c = true,
        SVMXC__Email__c = 'test.abc@xyz.com',
        GE_SM_HQ_SSO_ID__c = '502324626',
        SVMCX_Status__c = 'Active GE',
        GE_SM_HQ_Regional_Manager__c = 'SVMX',
        GE_SM_HQ_Manager_Email__c = 'test.abc@xyz.com',
        SVMXC_Function__c = 'Services',
        GE_SM_HQ_Controls_EmpType__c = 'Field Engineer', 
        SVMXC__Salesforce_User__c = UserInfo.getUserId()
        );
        insert tech;
        //New Skill
       SVMXC__Skill__c  skill1= new   SVMXC__Skill__c(Name = 'test Skill',
        GE_DRL_Skill_Category__c='Controls',
        SVMXC__Skill_Category__c ='Controls',
        GE_OG_DS_Product_Group__c='Hardware - EFL',
        Sub_Business__c='Pressure Control');
        insert skill1;
        SVMXC__Skill__c  skill= new   SVMXC__Skill__c(Name = 'test Skill',
        GE_DRL_Skill_Category__c='Controls',
        SVMXC__Skill_Category__c ='Controls',
        GE_OG_DS_Product_Group__c='Intervention - Reeler',
        Sub_Business__c='Pressure Control');
        insert skill;
      integer i=0;
      Id worectype = Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('SS-Mobilize').getRecordTypeId();  
      SVMXC__Service_Order__c wo1 = new SVMXC__Service_Order__c();
            wo1.SVMXC__Company__c = acc.id;
            wo1.RecordTypeId = worectype;      
            wo1.GE_OG_MC_Business_Unit__c = 'F&PT';
            wo1.GE_OG_MC_Service_Region__c = 'Coimbatore';
            wo1.GE_SS_Customer_PO_number__c = '123123';
            wo1.GE_OG_Service_Order__c = '223312';
            wo1.GE_OG_GS_Customer_Want_Start_Date__c = System.today();
            wo1.GE_OG_GS_Customer_Want_End_Date__c = system.today();
            wo1.GE_OG_GS_Work_Scope_Notes__c = 'test';
            //wo1.GE_SM_HQ_Technician_Home_Dispatcher__c = home.Id;
            
            insert wo1;
      
      
       SVMXC__SVMX_Event__c  event = new SVMXC__SVMX_Event__c ();
            DateTime t = DateTime.newInstance(2017,5,18,12,30,6);
            System.debug('t'+t);
            event.SVMXC__Service_Team__c =team.Id;
            event.SVMXC__Technician__c = tech.Id;
            event.SVMXC__Service_Order__c = wo1.Id;
            event.Name = wo1.Name;
            event.SVMXC__StartDateTime__c = t;
            event.SVMXC__EndDateTime__c = t.addHours(3);
            event.SVMXC__IsAllDayEvent__c = false;
            event.SVMXC__Location__c = '';
            event.SVMXC__WhatId__c = wo1.Id;
            event.SVMXC__ActivityDate__c  = Date.today();
            event.SVMXC__ActivityDateTime__c  = t;
            event.SVMXC__DurationInMinutes__c  = 180;            
            insert event;
    
    
    GE_SS_Tech_Assignment tstAssign = new GE_SS_Tech_Assignment(); 
    
    }
    test.stopTest();
    }
    
}