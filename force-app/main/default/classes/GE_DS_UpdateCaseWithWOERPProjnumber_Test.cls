@isTest(seeAllData=True)
public class GE_DS_UpdateCaseWithWOERPProjnumber_Test {
        static testmethod void test1()  {
            
       Test.startTest();
      //ServiceTeam Insert
        SVMXC__Service_Group__c team = new SVMXC__Service_Group__c();
        team.name='DS Test Team';
        team.GE_OG_DS_Billing_Admin_Email__c='test@test.com';
        team.GE_HQ_P_L_Level__c='O&G > MCS';
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
              
      //Case Insert
       Case ca = new Case();
       Id caseretypeId=Schema.SObjectType.Case.getRecordTypeInfosByName().get('FS-MCS').getRecordTypeId(); 
       ca.RecordTypeId=caseretypeId;
       ca.GE_HQ_Business_Tier2__c ='Digital Solutions';
       ca.GE_Tier_3__c  = 'Bently';
       ca.GE_OG_DS_Tier4_PL__c = 'Bently';
       ca.GE_Region__c = 'Europe';
       ca.GE_Country__c = 'bahrain';
       ca.GE_OG_Project_Name_CIR__c= 'Test data';
       ca.Status = 'Open';
       ca.CurrencyIsoCode = 'USD';
       ca.GE_SM_OG_MC_SAP_Project_Number__c ='2344';
       insert ca;
            
        //Skill Insert
        SVMXC__Skill__c sk = new SVMXC__Skill__c();
        sk.Name='Testing';
        sk.GE_OG_Job_Type__c='B-02';
        insert sk;
                 
       //WorkOrder Insert
        SVMXC__Service_Order__c wrkObj = new SVMXC__Service_Order__c();
        Id worktid = Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('MCS').getRecordTypeId();
        wrkObj.RecordTypeId=worktid;
        wrkObj.SVMXC__Order_Status__c = 'Open';
        wrkObj.SVMXC__Group_Member__c = tech.id;
        wrkObj.SVMXC__Service_Group__c = team.id;
        wrkObj.GE_OG_MC_Service_Region__c = 'Europe';
        wrkObj.SVMXC__Country__c = 'Bahrain';
        wrkObj.GE_OG_MC_ERP_Project_Number__c = 'test1234';
        wrkObj.CurrencyIsoCode = 'USD';
        wrkObj.GE_SS_No_of_Completions_Personnel__c = 1234; 
        wrkObj.GE_OG_MC_Business_Unit__c = 'Bently'; 
        wrkObj.SVMXC__Skill__c = sk.id;
        insert wrkObj;
      
       Test.stopTest();
                     
            
    }
}