@isTest(seeAllData=True)
public class GE_DS_Update_ManagerEmail_Test {

     static testmethod void test1()  {
            
       Test.startTest();
         
      User u1 = [SELECT Id FROM User WHERE Profile.Name='GE_DS_SMax_Admin' AND IsActive = TRUE limit 1];
         //User u1 = [SELECT Id FROM User WHERE GE_HQ_SSO_ID__c='502324626'];
        System.runAs(u1) {
      User u2 = [SELECT Id FROM User WHERE Profile.Name='GE_DS_SMax_Technician' AND IsActive = TRUE limit 1];      
          System.runas(u2){
     
              //ServiceTeam Insert
        SVMXC__Service_Group__c team = new SVMXC__Service_Group__c();
        team.name='DS Test Team';
        team.GE_OG_DS_Billing_Admin_Email__c='test@test.com';
        team.GE_HQ_P_L_Level__c='Digital Solutions';
        team.GE_HQ_Resource_Director__c=UserInfo.getUserId();
        insert team;        
      
        //Technician Insert     
        SVMXC__Service_Group_Members__c tech = new SVMXC__Service_Group_Members__c();
        tech.SVMXC__Service_Group__c = team.Id;
        tech.Name = 'SVMX Tech';
        tech.SVMXC__Active__c = true;
        tech.SVMXC__Enable_Scheduling__c = true;
        tech.SVMXC__Email__c = 'test.abc@xyz.com';
        tech.GE_SM_HQ_SSO_ID__c = '123456737';
        tech.SVMCX_Status__c = 'Active GE';
        tech.GE_SM_HQ_Regional_Manager__c = 'SVMX';
        tech.GE_SM_HQ_Manager_Email__c = 'test.abc@xyz.com';
        tech.SVMXC_Function__c = 'Services';
        tech.GE_SM_HQ_Controls_EmpType__c = 'Field Engineer'; 
        tech.SVMXC__Salesforce_User__c = UserInfo.getUserId();        
        insert tech; 
        //update team;
       // delete team;
            
          //New Skill
        SVMXC__Skill__c  skill= new   SVMXC__Skill__c(Name = 'test Skill',
        SVMXC__Skill_Category__c ='Controls',
        Sub_Business__c='Bently',
        Business__c='Digital Solutions');
        insert skill;
            
         //Expertise  
        SVMXC__Service_Group_Skills__c  tempExpertise = new SVMXC__Service_Group_Skills__c ();         
          tempExpertise.SVMXC__Skill__c=skill.Id ;         
          tempExpertise.SVMXC__Service_Group__c=team.id;
          tempExpertise.SVMXC__Group_Member__c=tech.Id;
          tempExpertise.GE_SM_HQ_Manager_Email__c='test.abc@xyz.com'; 
         Insert tempExpertise;
         
                   
      //Passport Insert
      GE_OG_GS_Passport__c psprt = new GE_OG_GS_Passport__c();
         psprt.GE_OG_GS_Passport_Number__c ='1234567';
         psprt.GE_DS_Manager_Email__c =  'test.abc@xyz.com';
         psprt.GE_OG_GS_Technician__c = tech.Id;   
         Insert psprt;
            
        //Insert Visa
       GE_OG_GS_Visa__c tempvisa = new GE_OG_GS_Visa__c(); 
          tempvisa.GE_OG_GS_Passport__c= psprt.Id;
          tempvisa.GE_OG_GS_Visa_Expiry_Date__c=Date.Today();
          tempvisa.GE_OG_GS_Visa_Type__c='Visa exempt';
          tempvisa.GE_OG_GS_Technician__c=tech.Id; 
          tempvisa.GE_DS_Manager_Email__c = 'test.abc@xyz.com';
          insert tempvisa;
            
        // Insert GatePass
        GE_OG_DS_Gate_Pass__c temppass = new GE_OG_DS_Gate_Pass__c();
           temppass.GE_DS_Country__c='United states';
           temppass.GE_DS_Type_of_Pass__c='basic plus';
           temppass.GE_DS_Manager_Email__c='test.abc@xyz.com';
           temppass.GE_DS_Technician__c=tech.Id;
          insert temppass;
          update team;
          delete team;
          }
        } 
         
         Test.stopTest();
}
}