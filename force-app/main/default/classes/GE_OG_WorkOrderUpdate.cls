public with sharing class GE_OG_WorkOrderUpdate{
ID Rectype=Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('PC').getRecordTypeId();

Set<id> woIdset = new Set<id>();
Set<id> techSet = new Set<id>();
Set<id> serviceTeamSet = new Set<id>();
List<SVMXC__Service_Group__c> serviceTeamList = new List<SVMXC__Service_Group__c>();
List<SVMXC__SVMX_Event__c> event = new List<SVMXC__SVMX_Event__c>();
List<SVMXC__Service_Group_Members__c> TechnicianList = new List<SVMXC__Service_Group_Members__c>();
List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();

// It gets called after updation on Work Order object 
public void sendSurveyEmails(List<SVMXC__Service_Order__c> oldWorkOrder,List<SVMXC__Service_Order__c> newWorkOrder)
{ 

    map<Id, SVMXC__Service_Order__c > newWorkOrderList = new map<Id, SVMXC__Service_Order__c >();
    for(SVMXC__Service_Order__c newWo:newWorkOrder)
    {
    
     if((newwo.RecordTypeId==Rectype) && ((newWo.GE_PC_Safety_Ans_rating__c <= 2) || (newWo.GE_PC_Quality_Ans_rating__c <= 2) || (newWo.GE_PC_Deliver_Ans_rating__c <= 2)))
        {          
            woIdset.add(newWo.Id);          
        }        
    }    

// check whether New work order list has got atleast one WO
    if (woIdSet.size() > 0)
    {       
        
        List<SVMXC__SVMX_Event__c> sMaxeventList = [SELECT Id,ownerId,SVMXC__Technician__c  FROM SVMXC__SVMX_Event__c WHERE SVMXC__WhatId__c IN :woIdset];
       
        if(sMaxeventList.size()>0){
            for(SVMXC__SVMX_Event__c ev:sMaxeventList)
            {
                if(ev.SVMXC__Technician__c !=null)
                {
                    techSet.add(ev.SVMXC__Technician__c);                 
                }       
            }
        }
                
        if(techSet.size() > 0)
        {
            TechnicianList = [SELECT Id,name,SVMXC__Service_Group__c from SVMXC__Service_Group_Members__c WHERE Id IN :techSet];        
        }  
        
        if(TechnicianList.size() >0)
        {
            for(SVMXC__Service_Group_Members__c tech:TechnicianList)
            {
                if(tech.SVMXC__Service_Group__c!=null)
                {
                    serviceTeamSet.add(tech.SVMXC__Service_Group__c);                   
                }       
            }
        }
        if(serviceTeamSet.size()>0)
        {
            serviceTeamList = [SELECT Id, GE_HQ_Resource_Director__c FROM SVMXC__Service_Group__c WHERE Id IN :serviceTeamSet]; 
            newWorkOrderList = new map<Id, SVMXC__Service_Order__c >([Select Id, Name, SVMXC__Company__r.Name from SVMXC__Service_Order__c where Id IN: woIdset]);
        }
        if(serviceTeamList.size() >0)
        { 
            mails = new List<Messaging.SingleEmailMessage>(); 
            for(SVMXC__Service_Order__c newWo:newWorkOrder) 
            {
                if(woIdset.contains(newWo.Id)){
                    for(SVMXC__Service_Group__c st:serviceTeamList)
                    {
                        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                        mail.setTargetObjectId(st.GE_HQ_Resource_Director__c);
                        mail.setUseSignature(false);
                        mail.setSaveAsActivity(false);
                        mail.setSubject('Low Score on Survey from '+ newWo.Name+' for '+newWorkOrderList.get(newWo.Id).SVMXC__Company__r.Name);                        
                        String body = 'The Work Order and Survey Dashboard can be reviewed using these links:';
                        body += '<br>';
                        body += '<br>';
                        body += 'Work Order Link: ';
                        body +='<a href=';
                        body +=URL.getSalesforceBaseUrl().toExternalForm()+'/'+newWo.id;
                        body +='>'+URL.getSalesforceBaseUrl().toExternalForm()+'/'+newWo.id+'<'+'/'+'a>';
                        body += '<br>';
                        body += '<br>';
                        body += 'Dashboard Link: ';
                        body +='<a href=';
                        body +=URL.getSalesforceBaseUrl().toExternalForm()+'/'+'01Z12000000hYpB';
                        body +='>'+URL.getSalesforceBaseUrl().toExternalForm()+'/'+'01Z12000000hYpB'+'<'+'/'+'a>'; 
                        mail.setHtmlBody(body);
                        if(mail!=null)
                        {
                         mails.add(mail);                                    
                        }
                     }
                }
            }
             if (mails!=null)
             {    
                 Messaging.sendEmail(mails);                                   
             } 
        }
    } 
      
}
//Start R-23096 : Added on 14-Sep-15 : Update Status of all Work Order Lines to Open when Work Order Status is set to Ready for Invoicing.
public void updateWorkDetailStatus(Map<ID,SVMXC__Service_Order__c> mapWOs)
{
    List<SVMXC__Service_Order_Line__c> lstUpdateWODetails=new List<SVMXC__Service_Order_Line__c>();
    for(SVMXC__Service_Order_Line__c WODetail:[Select Id,SVMXC__Line_Status__c from SVMXC__Service_Order_Line__c where SVMXC__Service_Order__c=:mapWOs.keySet()])
    {
        WODetail.SVMXC__Line_Status__c='Open';
        lstUpdateWODetails.add(WODetail);
    }
    if(lstUpdateWODetails.size()>0)
    {
        update lstUpdateWODetails;
    }
    System.debug('Work Details Updated '+lstUpdateWODetails);
}
//End R-23096
//Start R-24337
public void updateWOBillingRegion(List<SVMXC__Service_Order__c> newObjects)
    {
        Map<ID,String> mapWOvsSTName=new Map<ID,String>();
        Map<String,ID> mapNameVsSTeam=new Map<String,ID>();
        Map<ID,ID> mapWOvsST=new Map<ID,ID>();
        List<SVMXC__Service_Order__c> lstWOs=new List<SVMXC__Service_Order__c>();
        List<SVMXC__Service_Order__c> lstPCWOs=new List<SVMXC__Service_Order__c>();
        for(SVMXC__Service_Order__c wo:newObjects)
        {
            if(wo.RecordTypeID==Rectype)
               lstPCWOs.add(wo);
        }
        System.debug('#### WO List for Billing Region Update'+lstPCWOs.size());
        if(lstPCWOs.size()>0)
        {
            for(SVMXC__Service_Order__c wo:lstPCWOs)
            {
                mapWOvsSTName.put(wo.id, 'PC '+wo.GE_PC_Branch__c);
            }
            List<SVMXC__Service_Group__c>sTeam = [select ID, Name from SVMXC__Service_Group__c where name=:mapWOvsSTName.values()];
            System.debug('### Service Team Name '+sTeam.size());
            for(SVMXC__Service_Group__c servteam:sTeam)    
            {
                mapNameVsSTeam.put(servteam.Name,servteam.ID);
                System.debug('### Service Team Name '+mapNameVsSTeam.keySet());
            }           
            for(SVMXC__Service_Order__c wo:lstPCWOs)
            {   
               System.debug('### mapNameVsSTeam.get(mapWOvsSTName.get(wo.ID)) '+mapNameVsSTeam.get(mapWOvsSTName.get(wo.ID))); 
                if(mapNameVsSTeam.get(mapWOvsSTName.get(wo.ID))!=null)
                {    
                    SVMXC__Service_Order__c workOrder = new SVMXC__Service_Order__c();
                    workOrder.ID=wo.ID;
                    workOrder.GE_DS_Billing_Region__c=mapNameVsSTeam.get('PC '+wo.GE_PC_Branch__c);
                    lstWOs.add(workOrder);
                }
            }
            System.debug('Work List before Update '+lstWOs);
            if(lstWOs.size()>0)
                update lstWOs;
        }
    }
    //End R-24337
    
 //R-26065 starts 

public void updateWOJobTypeSkillset(List<SVMXC__Service_Order__c> oldObjects, List<SVMXC__Service_Order__c> newObjects,String evt) 
{
    List<SVMXC__Service_Order__c> updateWoList = new List<SVMXC__Service_Order__c>();
    String jobType = '';
    boolean flag = false;
    
    if(evt=='afterUpdate')
    {
        for(SVMXC__Service_Order__c oldWrk:oldObjects)
        {
            for(SVMXC__Service_Order__c newWrk:newObjects)
            {
               // if(oldWrk.Id==newWrk.Id && (oldWrk.GE_PC_Job_Type__c!=newWrk.GE_PC_Job_Type__c || oldWrk.SVMXC__Skill_Set__c!=newWrk.SVMXC__Skill_Set__c))
                if(oldWrk.Id==newWrk.Id)
                {               
                    jobType = jobType+newWrk.GE_PC_Job_Type__c+';';
                }   
            
            }
        }
    }
    if(evt=='afterInsert')
    {
        for(SVMXC__Service_Order__c newWrk:newObjects)
            {
                jobType = jobType+newWrk.GE_PC_Job_Type__c+';';
            }
    }
    if (jobType != null && jobType.length() > 0) 
     {
              jobType = jobType.substring(0, jobType.length()-1);
     }
     
    List<SVMXC__Skill__c> jobTypeSkills = new List<SVMXC__Skill__c>();
    
    jobTypeSkills = [Select Id,Name, GE_OG_Job_Type__c from SVMXC__Skill__c where GE_OG_Job_Type__c includes (:jobType)];
    
    for(SVMXC__Service_Order__c newOrdr :newObjects)
    {
       String  jobTypes ='';
        for(SVMXC__Skill__c sk:jobTypeSkills)
        {
            if(sk.GE_OG_Job_Type__c!=null && newOrdr.GE_PC_Job_Type__c!=null && sk.GE_OG_Job_Type__c.contains(newOrdr.GE_PC_Job_Type__c))
            {
                flag=true;
                jobTypes=jobTypes+'{"skillName":"'+sk.Name+'",';
                jobTypes=jobTypes+'"skillLevel":0,';
                jobTypes=jobTypes+'"skillId":"'+sk.Id+'",';
                jobTypes=jobTypes+'"isSkillMandatory":false},';
            }
        }
        if(flag=true)
        {
        
            if (jobTypes != null && jobTypes.length() > 0) 
            {
              jobTypes = jobTypes.substring(0, jobTypes.length()-1);
              jobTypes = '['+jobTypes+']';
            }       
        
            SVMXC__Service_Order__c woToUpdate= new SVMXC__Service_Order__c();
            woToUpdate.Id = newOrdr.Id;
            woToUpdate.SVMXC__Skill_Set__c = jobTypes;
            flag=false;
            updateWoList.add(woToUpdate);
        }   
    
    }
    if(updateWoList.size()>0)
    {
        update updateWoList;
    }
     
}
//R-26065 Ends

}