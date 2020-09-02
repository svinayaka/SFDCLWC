@isTest(seeAllData=true)
public class GE_MC_AssignFEWO_EmailHelper_Test {
  
            
        static testMethod void borrowTechnicianTest(){
        
        
        Id rtId = Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('D&S').getRecordTypeId();
        Id mcsrtId = Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('MCS').getRecordTypeId();
        Id strtId = Schema.SObjectType.SVMXC__Service_Group__c.getRecordTypeInfosByName().get('Technician').getRecordTypeId();
        Id Userid = UserInfo.getUserId();
        Test.startTest();
            SVMXC__Service_Group__c sg = new SVMXC__Service_Group__c(
                                    RecordTypeId = strtId,
                                    Name = 'SVMX STName',
                                    GE_HQ_Resource_Director__c = Userid,
                                    SVMXC__Active__c = true,
                                    GE_HQ_P_L_Level__c = 'O&G > D&S',
                                    GE_HQ_Sub_P_L__c = 'Drilling',
                                    GE_HQ_Region__c = 'NAM',
                                    GE_OG_DS_Billing_Admin_Email__c = 'test.abc@xyz.com'                                    
                                    );
            insert sg;
        
            SVMXC__Service_Group_Members__c tech = new SVMXC__Service_Group_Members__c(
                                    SVMXC__Service_Group__c = sg.Id,
                                    Name = 'SVMX Tech',
                                    SVMXC__Active__c = true,
                                    SVMXC__Enable_Scheduling__c = true,
                                    SVMXC__Email__c = 'test.abc@xyz.com',
                                    GE_SM_HQ_SSO_ID__c = '1234567',
                                    SVMCX_Status__c = 'Active GE',
                                    GE_SM_HQ_Regional_Manager__c = 'SVMX',
                                    GE_SM_HQ_Manager_Email__c = 'test.abc@xyz.com',
                                    SVMXC_Function__c = 'Services',
                                    GE_SM_HQ_Controls_EmpType__c = 'Field Engineer'                                 
                                    );
            insert tech;
        
            GE_HQ_UpdateWorkOrderTechAssignment.sentEmail=false;
            SVMXC__Service_Order__c svo = new SVMXC__Service_Order__c (
                                           // SVMXC__Case__c = cs.Id ,
                                            //SVMXC__Company__c = ac.Id , 
                                            //SVMXC__Contact__c = ct.Id,
                                            SVMXC__Order_Status__c = 'Open',
                                            SVMXC__Priority__c ='Medium',
                                            SVMXC__Order_Type__c='Field Service',
                                            RecordTypeId = rtId,
                                            SVMXC__Service_Group__c = sg.Id,
                                            SVMXC__Closed_By__c=Userid,
                                            SVMXC__Group_Member__c = tech.Id,
                                            GE_SM_HQ_Dispatched_Outside_Territory__c=false,
                                            GE_SM_HQ_Borrowed_Technician_Approved_On__c=null
                                            );
            insert svo;
            SVMXC__Service_Group_Members__c tech1 = new SVMXC__Service_Group_Members__c(
                                    SVMXC__Service_Group__c = sg.Id,
                                    Name = 'SVMX Tech',
                                    SVMXC__Active__c = true,
                                    SVMXC__Enable_Scheduling__c = true,
                                    SVMXC__Email__c = 'test.abc@xyz.com',
                                    GE_SM_HQ_SSO_ID__c = '502406412',
                                    SVMCX_Status__c = 'Active GE',
                                    GE_SM_HQ_Regional_Manager__c = 'SVMX',
                                    GE_SM_HQ_Manager_Email__c = 'test.abc@xyz.com',
                                    SVMXC_Function__c = 'Services',
                                    GE_SM_HQ_Controls_EmpType__c = 'Field Engineer'                                 
                                    );
            insert tech1;
            
            GE_HQ_UpdateWorkOrderTechAssignment.sentEmail=false;
            svo.GE_SM_HQ_Dispatched_Outside_Territory__c=true;
            svo.GE_SM_HQ_Borrowed_Technician_Approved_On__c=Date.Today();
            update svo;
            
            svo.SVMXC__Group_Member__c=tech1.id;
            update svo;
        Test.stopTest();
    }
      
            
}