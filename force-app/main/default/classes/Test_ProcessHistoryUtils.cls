/*
It will cover the below Classes

1.GE_MCS_booleanfrtrg
2.ProcessHistoryUtils
3.CommunitiesLandingController
4.tets

*/
@isTest(SeeAllData=True)
Private Class Test_ProcessHistoryUtils{
    static testMethod void ProcessHistoryUtils_Method()
    {
        CommunitiesLandingController clc=new CommunitiesLandingController();
        clc.forwardToStartPage();
        Database.BatchableContext BatchCont;
        Database.QueryLocator QueryLoc;
       // ProcessInstance pi=[SELECT Id, TargetObjectId FROM ProcessInstance limit 1];
        //StepsAndWorkitem st=[SELECT Id, StepStatus, Comments, ActorId, OriginalActorId, CreatedDate, RemindersSent  FROM StepsAndWorkitem limit 1];
        //st.ProcessInstanceid=pi.id;
        //update st;
       
        User u = [select id,firstname,lastname,email,ManagerId from User where ManagerId!=null AND IsActive=True limit 1];   
         System.runAs(u){
        Case cse = new Case(GE_SS_Approver__c=u.ManagerId,GE_ES_Sub_Type__c='PO pre-Processing',GE_ES_Env_Case_Amount__c=1,Type = 'Authorization',Origin = 'Auto',Status ='New');
        insert cse;

        if([select count() from ProcessInstance where targetobjectid=:cse.id] < 1)
        {       
            Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
            req.setComments('Approve.');
            req.setNextApproverIds(New Id[]{u.ManagerId});
            req.setObjectId(cse.Id);

            //Submit the approval request
            //Approval.ProcessResult result = Approval.process(req);

        }
        
        ProcessHistoryUtils phu=new ProcessHistoryUtils();
        List<  GE_ES_ProcessInstanceHistory__c> lstOKTAQ= new List<  GE_ES_ProcessInstanceHistory__c>();
        
        QueryLoc= phu.start(BatchCont); 
        
        phu.execute(BatchCont,lstOKTAQ);
        phu.finish(BatchCont); 
        //GE_MCS_booleanfrtrg bool=new GE_MCS_booleanfrtrg();
        GE_MCS_booleanfrtrg.callingfrmCaseTrg=true;
        GE_MCS_booleanfrtrg.callingfrmTaskTrg=true;
    }
    
  }  
     static testMethod void ProcessHistoryUtils_Method1()
    {
         Profile p1 = [SELECT Id FROM Profile WHERE Name='OG_Sales/Comm Ops'];  
   /* Profile p2 = [SELECT Id FROM Profile WHERE Name='GE IM PM']; */ 

    User u1 = new User(Alias = 'standt', Email='standarduser1234@testorg.com', 
    EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
    LocaleSidKey='en_US', ProfileId = p1.Id, 
    TimeZoneSidKey='America/Los_Angeles', UserName='test1233445@test.com.in');

    insert u1;
        CommunitiesLandingController clc=new CommunitiesLandingController();
        clc.forwardToStartPage();
        Database.BatchableContext BatchCont;
        Database.QueryLocator QueryLoc;
        
        Id pcid ;
        List<Id> newWorkItemIds ;
        
        User u = [select id,firstname,lastname,email,ManagerId from User where ManagerId!=null AND IsActive=True limit 1];   
         System.runAs(u){
        Case cse = new Case(GE_SS_Approver__c=u.ManagerId,GE_ES_Sub_Type__c='PO pre-Processing',GE_ES_Env_Case_Amount__c=1,Type = 'Authorization',Origin = 'Auto',Status ='New');
        insert cse;

        if([select count() from ProcessInstance where targetobjectid=:cse.id] < 1)
        {       
            Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
            req.setComments('Approve.');
            req.setNextApproverIds(New Id[]{u.ManagerId});
            req.setObjectId(cse.Id);

            //Submit the approval request
            //Approval.ProcessResult result = Approval.process(req);
            //pcid = result.getInstanceId();  
            //newWorkItemIds = result.getNewWorkitemIds();
            
       
        
        
        }
        
     /*   
        ProcessInstance pi=[SELECT Id, TargetObjectId,(SELECT Id,RemindersSent, StepStatus,ActorID,OriginalActorId,TargetObjectId,CreatedDate, Comments FROM StepsAndWorkitems) FROM ProcessInstance where id=:pcid limit 1];
        //pi.ProcessInstanceStep.ActorId=u1.id;
        //ProcessInstanceWorkitem st =new ProcessInstanceWorkitem();
        
        ProcessInstanceWorkitem st=[SELECT Id, ActorId, OriginalActorId, CreatedDate  FROM ProcessInstanceWorkitem LIMIT 1] ;
        st.ProcessInstanceid=pi.id;
        //st.ActorId=u1.id;
        //st.OriginalActorId=u1.id;
        //st.RemindersSent=true;
        update st;
        ProcessInstanceStep PIS= [ SELECT ActorId,Comments,CreatedDate,Id,OriginalActorId,StepNodeId,StepStatus FROM ProcessInstanceStep LIMIT 1];
        //ProcessInstanceStep PIS = new ProcessInstanceStep();
        //PIS.ActorId=u1.id;
        //PIS.ProcessInstanceid=pi.id;
        //update PIS;
        
        

        


        ProcessHistoryUtils phu = new ProcessHistoryUtils();
        List<  GE_ES_ProcessInstanceHistory__c> lstOKTAQ= new List<  GE_ES_ProcessInstanceHistory__c>();
        List<ProcessInstance> lstOKTAQ1= new List<ProcessInstance>();
        lstOKTAQ1.add(pi);
        QueryLoc= phu.start(BatchCont); 
        
        phu.execute(BatchCont,lstOKTAQ1);
        phu.finish(BatchCont); 
        //GE_MCS_booleanfrtrg bool=new GE_MCS_booleanfrtrg();
        GE_MCS_booleanfrtrg.callingfrmCaseTrg=true;
        GE_MCS_booleanfrtrg.callingfrmTaskTrg=true;*/
    }
    
    
}
}