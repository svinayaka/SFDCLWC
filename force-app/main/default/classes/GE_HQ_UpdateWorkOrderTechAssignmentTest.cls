@isTest(SeeAllData=true)
public class GE_HQ_UpdateWorkOrderTechAssignmentTest {

    private static SVMXC__Service_Group__c team1 = null;
    private static SVMXC__Service_Group__c team = null;
    //private static SVMXC__Service_Group_Members__c tech1 = null;
    private static Map<String, Id> rtMap = new Map<String, Id>();
    public static integer check=0;
    private static SVMXC__Service_Group_Members__c tech = null;
    
    
    
    static {
        for (RecordType rt : [SELECT Id, Name FROM RecordType WHERE SObjectType = 'SVMXC__Service_Order__c'])
        {
            rtMap.put(rt.Name, rt.Id);
        }
    }
    
    
    /*static testMethod void AssignedTech() {
        
        SVMXC__Skill__c skil=[Select id from SVMXC__Skill__c limit 1];
        system.debug(rtMap);
        team = new SVMXC__Service_Group__c(
           Name = 'test',
           GE_HQ_Resource_Director__c = UserInfo.getUserId()
           );
           
            insert team;
            
          SVMXC__Service_Group_Members__c tech1= new SVMXC__Service_Group_Members__c(
           name='abc',
           SVMXC__Street__c = 'test Home street',
           SVMXC__City__c = 'test home city',
           SVMXC__State__c = 'test home state',
           SVMXC__Country__c = 'United States',
           SVMXC__Zip__c = 'test home zip',
           SVMXC__Longitude__c = 1.1,
           SVMXC__Latitude__c = 1.2,
           SVMXC__Service_Group__c = team.Id,
           GE_SM_HQ_SSO_ID__c = '123',
           GE_SM_HQ_Regional_Manager__c = 'test Manager',
           SVMXC__Email__c = 'chris.hurd@servicemax.com'
          
           );
        
        insert tech1;
           
           SVMXC__Service_Group_Members__c tech2 = new SVMXC__Service_Group_Members__c(
           name='xyz',
           SVMXC__Street__c = 'test Home street',
           SVMXC__City__c = 'test home city',
           SVMXC__State__c = 'test home state',
           SVMXC__Country__c = 'United States',
           SVMXC__Zip__c = 'test home zip',
           SVMXC__Longitude__c = 1.1,
           SVMXC__Latitude__c = 1.2,
           SVMXC__Service_Group__c = team.Id,
           GE_SM_HQ_SSO_ID__c = '124',
           GE_SM_HQ_Regional_Manager__c = 'test Manager',
           SVMXC__Email__c = 'xyx@servicemax.com'
          
           );
        
        insert tech2;
      
          SVMXC__Service_Order__c wo1 = new SVMXC__Service_Order__c(
           SVMXC__Street__c = 'test wo street',
           SVMXC__City__c = 'test wo city',
           SVMXC__Skill__c=skil.id,
           SVMXC__State__c = 'test wo state',
           //Region__c='Europe';
           SVMXC__Country__c = 'Canada',
           SVMXC__Zip__c = 'test wo zip',
           SVMXC__Longitude__c = 3.1,
           SVMXC__Latitude__c = 3.2,
           GE_SM_HQ_Scheduled_End_Date_Time__c = Date.newInstance(2015, 1, 8),
           GE_SM_HQ_Scheduled_Start_Date_Time__c = Date.newInstance(2015, 1, 10),
           GE_OG_MC_Service_Region__c = 'Middle East Africa',
           GE_OG_MC_Business_Unit__c='BN',
           SVMXC__Group_Member__c = null,
           RecordTypeId = rtMap.get('MCS'),
           GE_OG_MC_Subject__c = 'abc',
           SVMXC__Service_Group__c =team.id),
           //GE_SM_HQ_Borrowed_Technician_Approved_On__c = null,
           //GE_SM_PW_PGS_Technician_Restricted__c=false);
           
           insert wo1;
           
           wo1.GE_SM_HQ_Scheduled_End_Date_Time__c = Date.newInstance(2015, 1, 8);
           wo1.GE_SM_HQ_Scheduled_Start_Date_Time__c = Date.newInstance(2015, 1, 10);
           wo1.SVMXC__Group_Member__c=tech2.id;
           
           update wo1;
           
           
           SVMXC__SVMX_Event__c e = null;
           SVMXC__SVMX_Event__c event = null;
           event = new SVMXC__SVMX_Event__c ( 

              Name='test',
              SVMXC__StartDateTime__c=Date.newInstance(2015, 1, 8),
              SVMXC__EndDateTime__c=Date.newInstance(2015, 1, 10),
              SVMXC__Service_Team__c=team.id,
              SVMXC__Technician__c=tech1.id,
              SVMXC__WhatId__c = wo1.id);
              
              insert event ;
              
              event.Name='abc';
              
              update event;
              
             }*/
    
    static testMethod void technicianNull(){
        
        GE_Installed_Base__c ib= new GE_Installed_Base__c( Order_Number__c= 'abcd', GE_ES_Customer_Equipment__c='xyz');

        SVMXC__Skill__c skill=[Select id from SVMXC__Skill__c limit 1];
        system.debug(rtMap);
        team1 = new SVMXC__Service_Group__c(
            SVMXC__Email__c = 'sakshi.dixit@ge.com',
           Name = 'test12',
           GE_OG_GS_Mobilization_Manager__c = UserInfo.getUserId(),
           GE_HQ_Resource_Director__c = UserInfo.getUserId()
           );
           
            insert team1;
          SVMXC__Service_Group_Members__c tech2 = new SVMXC__Service_Group_Members__c();
          
           tech2.name='abc';
           tech2.SVMXC__Street__c = 'test Home street';
           tech2.SVMXC__City__c = 'test home city';
           tech2.SVMXC__State__c = 'test home state';
           tech2.SVMXC__Country__c = 'United States';
           tech2.SVMXC__Zip__c = 'test home zip';
           tech2.SVMXC__Longitude__c = 1.1;
           tech2.SVMXC__Latitude__c = 1.2;
           tech2.SVMXC__Service_Group__c = team1.Id;
           tech2.GE_SM_HQ_SSO_ID__c = '123';
           tech2.GE_SM_HQ_Regional_Manager__c = 'test Manager';
           tech2.SVMXC__Email__c = 'chris.hurd@servicemax.com';
           tech2.GE_SM_HQ_Manager_Email__c ='chris.hurd@servicemax.com';
           tech2.GE_OG_DS_Service_Team_Leader_Email__c ='chris.hurd@servicemax.com';
           
           insert tech2;
           
           tech2.GE_SM_PW_PGS_Number_Of_Short_Tasks__c = 0;
           
           update tech2;
           
           
            SVMXC__Service_Group_Members__c techn = new SVMXC__Service_Group_Members__c();
          
           techn.name='xyz';
           techn.SVMXC__Street__c = 'test Home street';
           techn.SVMXC__City__c = 'test home city';
           techn.SVMXC__State__c = 'test home state';
           techn.SVMXC__Country__c = 'United States';
           techn.SVMXC__Zip__c = 'test home zip';
           techn.SVMXC__Longitude__c = 1.1;
           techn.SVMXC__Latitude__c = 1.2;
           techn.SVMXC__Service_Group__c = team1.Id;
           techn.GE_SM_HQ_SSO_ID__c = '502406412';
           techn.GE_SM_HQ_Regional_Manager__c = 'Sathyanarayana Borugula';
           techn.SVMXC__Email__c = 'chris.hurd@servicemax.com';
           techn.GE_SM_HQ_Manager_Email__c ='chris.hurd@servicemax.com';
           techn.GE_OG_DS_Service_Team_Leader_Email__c ='chris.hurd@servicemax.com';
           
           insert techn;
           
           
          SVMXC__Service_Order__c wo2 = new SVMXC__Service_Order__c();
           wo2.SVMXC__Street__c = 'test wo street';
           wo2.SVMXC__City__c = 'test wo city';
           wo2.SVMXC__Skill__c=skill.id;
           wo2.SVMXC__State__c = 'test wo state';
           //Region__c='Europe';
           wo2.SVMXC__Country__c = 'Test Country';
           wo2.SVMXC__Zip__c = 'test wo zip';
           wo2.SVMXC__Longitude__c = 3.1;
           wo2.SVMXC__Latitude__c = 3.2;
           wo2.GE_SM_HQ_Scheduled_End_Date_Time__c = Date.newInstance(2015, 1, 15);
           wo2.GE_SM_HQ_Scheduled_Start_Date_Time__c = Date.newInstance(2015, 1, 10);
           wo2.GE_OG_MC_Service_Region__c = 'Middle East Africa';
           wo2.GE_OG_MC_Business_Unit__c='BN';
           wo2.SVMXC__Service_Group__c =team1.id;
           wo2.SVMXC__Group_Member__c = tech2.id;
           wo2.RecordTypeId = rtMap.get('D&S');
           wo2.GE_DS_FSE_Discipline__c = 'Other';
           wo2.GE_OG_MC_Subject__c = 'WO-1234';
           wo2.GE_DS_Service_Team_Leader_Email__c ='abc@ge.com';

           
       
           insert wo2;
         

            wo2.SVMXC__Group_Member__c = techn.Id;
            wo2.GE_SM_HQ_Borrowed_Technician_Rejected__c= true;
            wo2.SVMXC__Member_Email__c = null;
            wo2.GE_SM_HQ_Borrowed_Technician_Approved_On__c = null;
            wo2.GE_SM_HQ_Technician_Home_Dispatcher__c = UserInfo.getUserID();
            wo2.GE_SM_HQ_Technician_Type__c = null;
            //wo2.SVMXC__Service_Group__c = null;
            wo2.SVMXC__Service_Group__c =team1.id;
            wo2.GE_SM_HQ_Dispatched_Outside_Territory__c = false;           
        //    wo2.GE_SM_PW_PGS_Technician_Restricted__c = false; Commented as part of requirement R-26296
            //wo2.GE_SM_HQ_Installed_Base__c=ib.id;
             
           update wo2;

           //
            SVMXC__Service_Order__c wo3 = new SVMXC__Service_Order__c();
           wo3.SVMXC__Street__c = 'test wo street';
           wo3.SVMXC__City__c = 'test wo city';
           wo3.SVMXC__Skill__c=skill.id;
           wo3.SVMXC__State__c = 'test wo state';
            wo3.GE_SM_HQ_Borrowed_Technician_Rejected__c= true;
           wo3.GE_SM_HQ_Scheduled_End_Date_Time__c = Date.newInstance(2015, 1, 15);
           wo3.GE_SM_HQ_Scheduled_Start_Date_Time__c = Date.newInstance(2015, 1, 10);
           wo3.GE_OG_MC_Service_Region__c = 'Middle East Africa';
           wo3.GE_OG_MC_Business_Unit__c='BN';
          //wo3.SVMXC__Service_Group__c =team1.id;
           wo3.SVMXC__Group_Member__c = tech2.id;
           wo3.RecordTypeId = rtMap.get('MCS');
           wo3.SVMXC__Group_Member__c = null;
           wo3.GE_SM_HQ_Borrowed_Technician_Approved_On__c =null;
           wo3.GE_SM_HQ_Dispatched_Outside_Territory__c = true;           
      //     wo3.GE_SM_PW_PGS_Technician_Restricted__c = false; Commented as part of requirement R-26296
          // wo3.GE_SM_HQ_Installed_Base__c=ib.id;
           wo3.GE_SM_HQ_Technician_Home_Dispatcher__c = UserInfo.getUserID();
             
           insert wo3;
           
           
           //wo3.SVMXC__Group_Member__c = techn.id;
           
           //update wo3;
           
           
           


          
          //    
             
            SVMXC__Skill__c skill1 = new SVMXC__Skill__c(
            Name = 'test',
            GE_PW_PGS_Country__c = 'Test Country',
            GE_PW_PGS_Needs_Visa__c = true,
            GE_PW_PGS_Days_to_Get_Visa__c = 5,
            Business__c = 'PGS',
            Sub_Business__c = 'CS');
            insert skill1;
            wo2.SVMXC__Skill__c=skill1.id;
            update wo2;
           
           Account acct = new Account(
            Name = 'test');
            
            insert acct;
            
          /*  GE_SM_PW_PGS_Tech_Account_Restricted__c bl = new GE_SM_PW_PGS_Tech_Account_Restricted__c(
            GE_PW_PGS_Account__c = acct.Id,
            GE_PW_PGS_Technician_Equipment__c = tech2.Id,
            GE_PW_PGS_Installed_Base__c=ib.id
            
            );
    
       insert b1;*/
       
       
        wo2.SVMXC__Company__c= acct.id;
         update wo2;
        
       
       
    
    

         GE_SM_PW_PGS_Tech_Account_Restricted__c blackout= new GE_SM_PW_PGS_Tech_Account_Restricted__c();
        
           blackout.GE_PW_PGS_Technician_Equipment__c =tech2.Id;
           blackout.GE_PW_PGS_Installed_Base__c=ib.id;
           blackout.GE_PW_PGS_Account__c =acct.id;
           

        insert blackout;

}     

 static testMethod void dispatchVisaRequiredTest() {
      
        setUp();
        
        SVMXC__Skill__c skill = new SVMXC__Skill__c(
            Name = 'test',
            GE_PW_PGS_Country__c = 'Test Country',
            GE_PW_PGS_Needs_Visa__c = true,
            GE_PW_PGS_Days_to_Get_Visa__c = 5,
            Business__c = 'PGS',
            Sub_Business__c = 'CS'
        );
        
        insert skill;
        
        SVMXC__Service_Order__c wo = new SVMXC__Service_Order__c(
           SVMXC__Street__c = 'test wo street',
           SVMXC__City__c = 'test wo city',
           SVMXC__State__c = 'test wo state',
           SVMXC__Country__c = 'Test Country',
           SVMXC__Zip__c = 'test wo zip',
           SVMXC__Longitude__c = 3.1,
           SVMXC__Latitude__c = 3.2,
           SVMXC__Group_Member__c = tech.Id,
           GE_SM_HQ_Technician_Home_Dispatcher__c = userinfo.getuserId(),
           RecordTypeId = rtMap.get('D&S')
        );
        
        insert wo;
        wo.GE_SM_HQ_Borrowed_Technician_Rejected__c=true;
        wo.SVMXC__Group_Member__c = tech.Id;
        update wo;
        
        Test.startTest();
        wo = [SELECT Id, SVMXC__Order_Status__c FROM SVMXC__Service_Order__c WHERE Id = :wo.Id LIMIT 1];
        
         Test.stopTest();   
         }
    
    static testMethod void dispatchVisaAlreadyHasTest() {
        setUp();
        
        SVMXC__Skill__c skill = new SVMXC__Skill__c(
            Name = 'test',
            GE_PW_PGS_Country__c = 'Test Country',
            GE_PW_PGS_Needs_Visa__c = true,
            
            GE_PW_PGS_Days_to_Get_Visa__c = 5,
            Business__c = 'PGS',
            Sub_Business__c = 'CS'
        );
        
        insert skill;
        
        SVMXC__Service_Group_Skills__c exp = new SVMXC__Service_Group_Skills__c(
            SVMXC__Skill__c = skill.Id,
            SVMXC__Availability_End_Date__c = system.today() + 10,
            SVMXC__Availability_Start_Date__c = system.today() - 1,
            SVMXC__Group_Member__c = tech.Id,
            SVMXC__Service_Group__c = team.Id,GE_OG_GS_Root_Qualification_Level__c='SFSE'
        );
        
        insert exp;
        
        SVMXC__Service_Order__c wo = new SVMXC__Service_Order__c(
           SVMXC__Street__c = 'test wo street',
           SVMXC__City__c = 'test wo city',
           SVMXC__State__c = 'test wo state',
           SVMXC__Country__c = 'Test Country',
           SVMXC__Zip__c = 'test wo zip',
           SVMXC__Longitude__c = 3.1,
           SVMXC__Latitude__c = 3.2,
           SVMXC__Group_Member__c = tech.Id,
           GE_SM_HQ_Scheduled_Start_Date_Time__c = system.now(),
           GE_SM_HQ_Scheduled_End_Date_Time__c = system.now() + 5,
           RecordTypeId = rtMap.get('D&S')
                  );
        
        insert wo;
        
        Test.startTest();
        wo = [SELECT Id, SVMXC__Order_Status__c FROM SVMXC__Service_Order__c WHERE Id = :wo.Id LIMIT 1];
//        system.assertEquals(5, wo.GE_SM_PW_PGS_Days_Needed_For_Visa__c);
//        system.assertEquals('Approved', wo.GE_SM_PW_PGS_Travel_Approval__c);
        
        Test.stopTest();
    }
    
    static testMethod void dispatchRestricted() {
        setUp();
        
        Account acct = new Account(
            Name = 'test'
        );
        
        insert acct;
        
        GE_SM_PW_PGS_Tech_Account_Restricted__c bl = new GE_SM_PW_PGS_Tech_Account_Restricted__c(
            GE_PW_PGS_Account__c = acct.Id,
            GE_PW_PGS_Technician_Equipment__c = tech.Id
        );
        
        insert bl;
        
        SVMXC__Service_Order__c wo = new SVMXC__Service_Order__c(
           SVMXC__Street__c = 'test wo street',
           SVMXC__City__c = 'test wo city',
           SVMXC__State__c = 'test wo state',
           SVMXC__Country__c = 'Canada',
           SVMXC__Zip__c = 'test wo zip',
           SVMXC__Longitude__c = 3.1,
           SVMXC__Latitude__c = 3.2,
           GE_SM_HQ_Borrowed_Technician_Rejected__c=true,
           SVMXC__Group_Member__c = tech.Id,
           RecordTypeId = rtMap.get('D&S')

           //RecordTypeId = rtMap.get('PGS')
        );
        
        insert wo;
        
        Test.startTest();
        //Commented as part of requirement R-26296
        //wo = [SELECT Id, GE_SM_PW_PGS_Technician_Restricted__c FROM SVMXC__Service_Order__c WHERE Id = :wo.Id LIMIT 1];
        wo = [SELECT Id FROM SVMXC__Service_Order__c WHERE Id = :wo.Id LIMIT 1];
//    system.assert(wo.GE_SM_PW_PGS_Technician_Restricted__c);
        
        Test.stopTest();
    }
    
    
    
   static testMethod void nonHomeTerritory() {
       
       try
       {
        setUp();
        SVMXC__Skill__c skil=[Select id from SVMXC__Skill__c limit 1];
        system.debug(rtMap);
        SVMXC__Dispatcher_Access__c dispatcher = new SVMXC__Dispatcher_Access__c(
        SVMXC__Dispatcher__c = UserInfo.getUserId(),
        GE_HQ_Not_Home_Territory__c=True,
        SVMXC__Service_Team__c = team.Id
        );
        insert dispatcher;
        
        SVMXC__Service_Group__c teamS = new SVMXC__Service_Group__c(
           Name = 'test');
           
           insert teamS;
        
        
         SVMXC__Service_Group_Members__c tech3 = new SVMXC__Service_Group_Members__c();
          
           tech3.name='abc';
           tech3.SVMXC__Street__c = 'test Home street';
           tech3.SVMXC__City__c = 'test home city';
           tech3.SVMXC__State__c = 'test home state';
           tech3.SVMXC__Country__c = 'United States';
           tech3.SVMXC__Zip__c = 'test home zip';
           tech3.SVMXC__Longitude__c = 1.1;
           tech3.SVMXC__Latitude__c = 1.2;
           tech3.SVMXC__Service_Group__c = teamS.Id;
           tech3.GE_SM_HQ_SSO_ID__c = '456';
           tech3.GE_SM_HQ_Regional_Manager__c = 'test Manager';
           tech3.SVMXC__Email__c = 'chris.hurd@servicemax.com';
           
           insert tech3;
        
          SVMXC__Service_Order__c wk = new SVMXC__Service_Order__c(
           SVMXC__Street__c = 'test wo street',
           SVMXC__City__c = 'test wo city',
           SVMXC__Skill__c=skil.id,
           SVMXC__State__c = 'test wo state',
           SVMXC__Country__c = 'Canada',
           SVMXC__Zip__c = 'test wo zip',
           SVMXC__Longitude__c = 3.1,
           SVMXC__Latitude__c = 3.2,
           GE_SM_HQ_Scheduled_End_Date_Time__c = Date.newInstance(2015, 1, 8),
           GE_SM_HQ_Scheduled_Start_Date_Time__c = Date.newInstance(2015, 1, 10),
           GE_OG_MC_Service_Region__c = 'Middle East Africa',
           GE_OG_MC_Business_Unit__c='BN',
           SVMXC__Group_Member__c = tech.Id,
           RecordTypeId = rtMap.get('MCS'),
           GE_OG_MC_Subject__c = 'WO-1234',
           SVMXC__Service_Group__c =team.id,
           GE_SM_HQ_Dispatched_Outside_Territory__c=true,
           GE_SM_HQ_Borrowed_Technician_Approved_On__c=null
           );
         //  GE_SM_PW_PGS_Technician_Restricted__c=false Commented as part of requirement R-26296
           
           
           

        insert wk;
        }
        catch(Dmlexception e)
        {
        }
            
            
            // wk.SVMXC__Group_Member__c = tech3.Id;
            // update wk;
        
 // manual approval process execution
   
     /*
        if(!GE_HQ_UpdateWorkOrderTechAssignment.sentToApproval && dispatcher.GE_HQ_Not_Home_Territory__c==True)
         {
          User user1 =[select id from User where Name='SMax Super Dispatcher FS Admin User01 TEST'];
          // user1.ID=UserInfo.getUserId();
          Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
          req1.setObjectId(wk.id);
          req1.setSkipEntryCriteria(true);
          req1.setSubmitterId(user1.id);
          Approval.ProcessResult result = Approval.process(req1); 
         
         List<Id> newWorkItemIds = result.getNewWorkitemIds();
          
         Approval.ProcessWorkitemRequest req2 =  new Approval.ProcessWorkitemRequest();

         req2.setComments('Submitting request for approval.');
         req2.setComments('Approving request.');
         req2.setWorkitemId(wk.id);
         req2.setAction('Approve');
        
        Approval.ProcessResult result1 = Approval.process(req2);
        //result.getNewWorkitemIds(wk.id);
        }*/
     
      }
       
       
       static testMethod void approvaltest()
      
       {
         SVMXC__Skill__c skil=[Select id from SVMXC__Skill__c limit 1];
         system.debug(rtMap);
        
          SVMXC__Service_Group__c Myteam = new SVMXC__Service_Group__c(
          Name = 'test12',
          GE_HQ_Resource_Director__c = UserInfo.getUserId()
           );
          insert Myteam;
             SVMXC__Dispatcher_Access__c dispatcher1 = new SVMXC__Dispatcher_Access__c(
            SVMXC__Dispatcher__c = UserInfo.getUserId(),
            //GE_HQ_Not_Home_Territory__c=True,
            SVMXC__Service_Team__c = Myteam.Id
         );
          insert dispatcher1;
          
          
           SVMXC__Service_Group_Members__c teamM = new SVMXC__Service_Group_Members__c();
          
           teamM.name='asa';
           teamM.SVMXC__Street__c = 'test Home street';
           teamM.SVMXC__City__c = 'test home city';
           teamM.SVMXC__State__c = 'test home state';
           teamM.SVMXC__Country__c = 'United States';
           teamM.SVMXC__Zip__c = 'test home zip';
           teamM.SVMXC__Longitude__c = 1.1;
           teamM.SVMXC__Latitude__c = 1.2;
           teamM.SVMXC__Service_Group__c = Myteam.id;
           teamM.GE_SM_HQ_SSO_ID__c = '502468';
           teamM.GE_SM_HQ_Regional_Manager__c = 'test Manager';
           teamM.SVMXC__Email__c = 'chris.hurd@servicemax.com';
           insert teamM;
           
           
           SVMXC__Service_Group_Members__c teamM1 = new SVMXC__Service_Group_Members__c();
           teamM1.name='sas';
           teamM1.SVMXC__Street__c = 'test Home street';
           teamM1.SVMXC__City__c = 'test home city';
           teamM1.SVMXC__State__c = 'test home state';
           teamM1.SVMXC__Country__c = 'United States';
           teamM1.SVMXC__Zip__c = 'test home zip';
           teamM1.SVMXC__Longitude__c = 1.1;
           teamM1.SVMXC__Latitude__c = 1.2;
           teamM1.SVMXC__Service_Group__c = Myteam.id;
           teamM1.GE_SM_HQ_SSO_ID__c = '7848';
           teamM1.GE_SM_HQ_Regional_Manager__c = 'test Manager';
           teamM1.SVMXC__Email__c = 'chris.hurd@servicemax.com';
           insert teamM1;
           
           
           //GE_HQ_UpdateWorkOrderTechAssignment.sentToApproval = true;
          


           SVMXC__Service_Order__c workorder1 = new SVMXC__Service_Order__c(
         
           SVMXC__Skill__c=skil.id,
           
           GE_SM_HQ_Scheduled_End_Date_Time__c = Date.newInstance(2015, 5, 9),
           GE_SM_HQ_Scheduled_Start_Date_Time__c = Date.newInstance(2015, 7, 11),
           GE_OG_MC_Service_Region__c = 'North America',
           GE_OG_MC_Business_Unit__c='BN',
           SVMXC__Group_Member__c = teamM.id,
           RecordTypeId = rtMap.get('MCS'),
           
           GE_OG_MC_Subject__c = 'approval',
           SVMXC__Service_Group__c =Myteam.id,
           GE_SM_HQ_Dispatched_Outside_Territory__c=true,
           GE_SM_HQ_Borrowed_Technician_Approved_On__c=null  );
           //GE_SM_PW_PGS_Technician_Restricted__c=false Commented as part of requirement R-26296
           
          
           insert workorder1;
           
           SVMXC__SVMX_Event__c evt2=null;
           
           
           Boolean insertNew = true;
           
           workorder1.GE_SM_HQ_Scheduled_End_Date_Time__c = Date.newInstance(2015, 5, 9);
           workorder1.GE_SM_HQ_Scheduled_Start_Date_Time__c = Date.newInstance(2015, 7, 11);
           workorder1.SVMXC__Group_Member__c=teamM1.id;
           
           update workorder1;
           
            
           SVMXC__SVMX_Event__c evt= new SVMXC__SVMX_Event__c();
           evt.Name='approval';
           evt.SVMXC__Technician__c=teamM.Id;
           evt.SVMXC__WhatId__c=workorder1.id;
           evt.SVMXC__StartDateTime__c = System.now();
           evt.SVMXC__EndDateTime__c = System.now() +10;
           evt.Work_Order__c=workorder1.id;
           //insert evt;
           
           
           
           SVMXC__SVMX_Event__c evt1= new SVMXC__SVMX_Event__c();
           evt1.Name='approval';
           evt1.SVMXC__Technician__c=teamM.Id;
           evt1.SVMXC__WhatId__c=workorder1.id;
           evt1.Work_Order__c=workorder1.id;
           evt1.SVMXC__StartDateTime__c = System.now();
           evt1.SVMXC__EndDateTime__c = System.now() +10;
           //insert evt1;
          
         list<SVMXC__SVMX_Event__c> evtlist= new list<SVMXC__SVMX_Event__c>(); 
           
           evtlist.add(evt);
           evtlist.add(evt1);
           
           insert evtlist;
           
            SVMXC__SVMX_Event__c evt3= new SVMXC__SVMX_Event__c() ;
            evt3 =null;
            
          
          
          //evt2= new SVMXC__SVMX_Event__c() ;
           //insert evt2;
           
           
        system.debug('the wo no is'+workorder1);
          
          }

        
     private static void setUp()
    {
        team = new SVMXC__Service_Group__c(
           Name = 'test',
           GE_HQ_Resource_Director__c = UserInfo.getUserId()
        );
        
        insert team;
        
        tech = new SVMXC__Service_Group_Members__c(
           SVMXC__Street__c = 'test Home street',
           SVMXC__City__c = 'test home city',
           SVMXC__State__c = 'test home state',
           SVMXC__Country__c = 'United States',
           SVMXC__Zip__c = 'test home zip',
           SVMXC__Longitude__c = 1.1,
           SVMXC__Latitude__c = 1.2,
           SVMXC__Service_Group__c = team.Id,
           GE_SM_HQ_SSO_ID__c = '123',
           GE_SM_HQ_Regional_Manager__c = 'test Manager',
           SVMXC__Email__c = 'chris.hurd@servicemax.com'
          
               
        );
         
        GE_OG_SVMXEvent.WrapperTechnician WarpTechObj=new GE_OG_SVMXEvent.WrapperTechnician(tech);
        insert tech;
    }      
     
           
   }