/*
Class Name: GE_OG_PC_TS_Kronos
Used For : Timesheets Approvals
Purpose/Overview : Apex classes built will approve the reviewed TimeSheet.
Author: Amit Kumar
Created Date: 19th JAN 2015
Test Class Name : Test_GE_OG_PCIntegration
Change History    : 
S No.    : Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change

*/
global class GE_OG_PC_TS_Kronos{
       webservice static String PC_ApproveTimeSheet(ID arg1)
       {
           try{
                System.debug('TimeSheet ID===>'+arg1);
                /* Approval Process through APEX
                List<SVMXC_Timesheet__c> timeSheetID = [SELECT id FROM SVMXC_Timesheet__c WHERE Technician__c =:TechID]; 
                List<ProcessInstance> prInst = [SELECT TargetObjectId, Status FROM ProcessInstance WHERE Status='Pending' AND TargetObjectId=:arg1];
                if(prInst.size()>0){
                        System.debug('TargetObjectID ==>'+prInst);
                        for(ProcessInstance PI: prInst){
                                ProcessInstanceWorkitem piWI = [select Id,OriginalActorId from ProcessInstanceWorkitem where ProcessInstanceId= :PI.Id LIMIT 1];
                                Approval.ProcessWorkitemRequest req = new Approval.ProcessWorkitemRequest();
                                req.setComments('Approved (API)');
                                req.setAction('Approve');
                                System.debug('PIWI ID ===> '+piWI.id);
                                req.setWorkitemId(piWI.id);
                                Approval.ProcessResult result =  Approval.process(req);
                                System.debug('Approved ===> Success');
                         }
                        return 'Success';
                }
                else{
                    System.debug(' ==> No Pending Approvals');
                    return 'NoRecords';
                }*/
               List<SVMXC_Timesheet__c> tsList = [SELECT id, GE_OG_DS_Status__c FROM SVMXC_Timesheet__c WHERE id=:arg1 LIMIT 1]; 
               if(tsList.size() > 0 ){
                        if(tsList[0].GE_OG_DS_Status__c !='Approved'){
                        //Update Time Entry status
                        List<SVMXC_Time_Entry__c> teList = [SELECT id, Name, GE_OG_PC_Status__c FROM SVMXC_Time_Entry__c WHERE Timesheet__r.id=:arg1];
                        System.debug('Time Entry details retrieved ==> '+teList);
                        for(SVMXC_Time_Entry__c record : teList){
                            record.GE_OG_PC_Status__c='Approved';
                        }
                        update teList;
                        tsList[0].GE_OG_DS_Status__c='Approved';
                        update tsList;
                        return 'Success';
                     } 
                     System.debug(' ==> Repeated Approval Action.');
                     return 'RepeatEvent';
               }
               else{
                    System.debug(' ==> No Pending Approvals');
                    return 'NoRecords';
                }
           }
           catch(Exception e){
               System.debug('GE_OG_PC_TS_Kronos:'+e.getLineNumber()+'---'+e.getMessage());
               return 'Error';
           }
       }
}