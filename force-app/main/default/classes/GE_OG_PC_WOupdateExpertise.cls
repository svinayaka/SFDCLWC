/*
Class Name                   - GE_OG_PC_WOupdateExpertise
Test Class Name              - GE_OG_PC_WOupdateExpertise_Test
Created Date                 -  6/23/2015 
Description                  -  This Helper Class would process the insertion/updation of Expertise Records of the Technicians
*/

public with sharing class GE_OG_PC_WOupdateExpertise{
ID PCRectypeId=Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('PC').getRecordTypeId();
ID ALRectypeId=Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('AL').getRecordTypeId();
ID DRLRectypeId=Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('D&S').getRecordTypeId();


Set<id> woIdset = new Set<id>();
Set<id> userSet = new Set<id>();
Set<String> techSet = new Set<String>();

List<Event> event = new List<Event>();
List<SVMXC__Service_Group_Skills__c> expertiseList = new List<SVMXC__Service_Group_Skills__c>();
List<SVMXC__Service_Group_Skills__c> expertiseListUpdate = new List<SVMXC__Service_Group_Skills__c>();
List<SVMXC__Service_Group_Members__c> TechnicianList = new List<SVMXC__Service_Group_Members__c>();

// It gets called after updation on Work Order object 
public void afterupdatewo(List<SVMXC__Service_Order__c> oldWorkOrder,List<SVMXC__Service_Order__c> newWorkOrder)
{ 

for(SVMXC__Service_Order__c newwo:newWorkOrder)
{
    for(SVMXC__Service_Order__c oldwo:oldWorkOrder)
    {
        
        if (
             (
             (newwo.RecordTypeId==PCRectypeId && newwo.SVMXC__Order_Status__c=='Closed'&& newwo.SVMXC__Group_Member__c != null&&newwo.SVMXC__Service_Group__c!=null) ||
             (newwo.RecordTypeId== ALRectypeId && newwo.SVMXC__Order_Status__c=='Closed-Client Invoiced'&&newwo.SVMXC__Group_Member__c != null&&newwo.SVMXC__Service_Group__c!=null) || 
             (newwo.RecordTypeId== DRLRectypeId && newwo.SVMXC__Order_Status__c=='Closed'&& newwo.SVMXC__Group_Member__c != null&& newwo.SVMXC__Service_Group__c!=null)  
             )
            )
        {   
            woIdset.add(newwo.Id);
        }          
    }
}
System.debug('###Menat WorkOrder'+woIdset);
// check whether New work order list has got atleast one WO
if (woIdSet.size() > 0)
{    
    List<SVMXC__SVMX_Event__c> SMaxEventList = [SELECT Id,SVMXC__Technician__c,SVMXC__WhatId__c FROM SVMXC__SVMX_Event__c WHERE SVMXC__WhatId__c IN :woIdset];
    
    
     //R-26065: Below If condition added to include the skill records based on JobType
        String jobTypeSet = ''; 
        
        for(SVMXC__Service_Order__c wrkordr : newWorkOrder)
        {  
            if(wrkordr.GE_PC_Job_Type__c!=null)         
             jobTypeSet=jobTypeSet+wrkordr.GE_PC_Job_Type__c+';';
        }
        if (jobTypeSet != null && jobTypeSet.length() > 0) {
              jobTypeSet = jobTypeSet.substring(0, jobTypeSet.length()-1);
        } 
        List<SVMXC__Skill__c> jobTypeSkills = new List<SVMXC__Skill__c>();
        if(jobTypeSet!='')
            jobTypeSkills = [Select Id, GE_OG_Job_Type__c from SVMXC__Skill__c where GE_OG_Job_Type__c includes (:jobTypeSet)];
        //End //R-26065
    
   
    //R-24879 : Below line of method call added
    createExpertise(SMaxEventList);
    
    if(SMaxEventList.size()>0){
        for(SVMXC__SVMX_Event__c sev:SMaxEventList)
        {
            if(sev.SVMXC__Technician__c!=null)
            {
                techSet.add(sev.SVMXC__Technician__c);
                 system.debug('Testsev------------1'+sev.SVMXC__Technician__c);
            }       
        }
    }   
   
    if(techSet.size()>0)
    {
        expertiseList = [SELECT Id,SVMXC__Group_Member__c,SVMXC__Skill__c,GE_OG_DS_FSCC_Skill_Name__c,SVMXC__Skill__r.name,SVMXC__Skill__r.GE_OG_PC_Complexity__c,Expertise_Level__c,GE_PC_WorkOrders_Completed__c,GE_PC_Sign_Off__c FROM SVMXC__Service_Group_Skills__c WHERE SVMXC__Group_Member__c IN :techSet];    
system.debug('Test------------2'+expertiseList.size()); 
            
        
    }
    
    if(expertiseList.size() >0)
    {   
    
        for(SVMXC__Service_Order__c wo : newWorkOrder)
        {
            Set<Id> setSkills = new Set<Id>();
            
            if(wo.SVMXC__Skill__c != null)
            setSkills.add(wo.SVMXC__Skill__c );
            
            if(wo.GE_OG_MC_Skill1__c  != null)
            setSkills.add(wo.GE_OG_MC_Skill1__c );
            
            if(wo.GE_OG_MC_Skill2__c != null)
            setSkills.add(wo.GE_OG_MC_Skill2__c );
            
            if(wo.GE_OG_PC_Skill3__c != null)
            setSkills.add(wo.GE_OG_PC_Skill3__c);
            
            //R-26065: Below If condition added to include the skill records based on JobType
            if(jobTypeSkills.size()>0)
            {
                for(SVMXC__Skill__c sk: jobTypeSkills )
                {
                    if(sk.GE_OG_Job_Type__c.contains(wo.GE_PC_Job_Type__c))
                        setSkills.add(sk.id);
                }
            
            }
            //Ends R-26065
                        
            if (setSkills != null && setSkills.size() > 0)                
            {       
                for(SVMXC__Service_Group_Skills__c exp:expertiseList)
                {  
                  system.debug('expertiseLis ------------1'+expertiseList ); 
                                      
                    if(setSkills.contains(exp.SVMXC__Skill__c))
                        {   
                            system.debug('Test------------3'+exp.SVMXC__Skill__c);  
                            exp.GE_PC_WorkOrders_Completed__c=exp.GE_PC_WorkOrders_Completed__c+1;
                            
                            //R-22976 Updating Last Completed WorkOrder
                            exp.GE_PC_Last_Completed_WorkOrder__c=wo.Id;
                            
                            //R-22789 Updating the Expertise Level
                                if(exp.SVMXC__Skill__r.GE_OG_PC_Complexity__c=='High')
                                {
        
                                    if(exp.GE_PC_WorkOrders_Completed__c <=3 && (exp.Expertise_Level__c !='Level 1' && exp.Expertise_Level__c !='Level 2'))
                                    {
                                        system.debug('###Expertise Level High & WO <3 ');
                                        exp.Expertise_Level__c = 'Level 0';                                        
                                        expertiseListUpdate.add(exp);
                                    }
                                    if(((exp.GE_PC_WorkOrders_Completed__c ==4) || (exp.GE_PC_WorkOrders_Completed__c ==5)) && (exp.Expertise_Level__c != 'Level 2'))
                                    {
                                        exp.Expertise_Level__c = 'Level 1';
                                        expertiseListUpdate.add(exp);
                                    }
                                    if(exp.GE_PC_WorkOrders_Completed__c >=6)
                                    {
                                        exp.Expertise_Level__c = 'Level 2';
                                        expertiseListUpdate.add(exp);
                                    }
                                }

                                else if(exp.SVMXC__Skill__r.GE_OG_PC_Complexity__c=='Medium')
                                {

                                    if(exp.GE_PC_WorkOrders_Completed__c <=2 && (exp.Expertise_Level__c != 'Level 1' && exp.Expertise_Level__c !='Level 2'))
                                    {
                                        exp.Expertise_Level__c = 'Level 0';
                                        expertiseListUpdate.add(exp);
                                    }
                                    if(exp.GE_PC_WorkOrders_Completed__c==3  && (exp.Expertise_Level__c != 'Level 2'))
                                    {
                                        exp.Expertise_Level__c = 'Level 1';
                                        expertiseListUpdate.add(exp);
                                    }
                                    if(exp.GE_PC_WorkOrders_Completed__c >=4)
                                    {
                                        exp.Expertise_Level__c = 'Level 2';
                                        expertiseListUpdate.add(exp);
                                    }
                                }
                                //Commented If block to ensure it update Expertise level when Complexity is blank or low
                                else //if(exp.SVMXC__Skill__r.GE_OG_PC_Complexity__c=='Low')
                                {

                                    if(exp.GE_PC_WorkOrders_Completed__c ==0 && (exp.Expertise_Level__c !='Level 1' && exp.Expertise_Level__c !='Level 2'))
                                    {
                                        exp.Expertise_Level__c = 'Level 0';
                                        expertiseListUpdate.add(exp);
                                    }
                                    if(exp.GE_PC_WorkOrders_Completed__c ==1 && (exp.Expertise_Level__c != 'Level 2'))
                                    {
                                        exp.Expertise_Level__c = 'Level 1';
                                        expertiseListUpdate.add(exp);
                                    }
                                    if(exp.GE_PC_WorkOrders_Completed__c >=2)
                                    {
                                        exp.Expertise_Level__c = 'Level 2';
                                        expertiseListUpdate.add(exp);
                                    }
                                }
                        }
                            System.debug('###New Exp' +exp);
                        }
                }                    
            }           
        }  
        if(expertiseListUpdate.size()>0)
        {
            update expertiseListUpdate;
        }              
}}

//Start : R-22789 : Auto creation of Expertise Records based on Skill field value on WO when Wo is Assigned to Tech
public static void createExpertise(List<SVMXC__SVMX_Event__c> newObjects)
{
     ID PCRectype=Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('PC').getRecordTypeId();
     ID ALRectypeId=Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('AL').getRecordTypeId();
     ID DRLRectypeId=Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('D&S').getRecordTypeId();
    Map<ID,ID> mapTechVsWO=new Map<ID,ID>();
    for(SVMXC__SVMX_Event__c objEvent : newObjects)
    {
         if(objEvent.SVMXC__Technician__c!=null && objEvent.SVMXC__WhatId__c != null)
         {
               if(((Id)objEvent.SVMXC__WhatId__c).getSObjectType().getDescribe().getName() == 'SVMXC__Service_Order__c')
               {
                        //settWOIDs.add(objEvent.SVMXC__WhatId__c);
                        if(!mapTechVsWO.containsKey(objEvent.SVMXC__Technician__c))
                        mapTechVsWO.put(objEvent.SVMXC__Technician__c,objEvent.SVMXC__WhatId__c);
               }
         }
    }
 /* List<SVMXC__Service_Order__c> lstWOs=[Select Id, SVMXC__Group_Member__c, SVMXC__Skill__c, GE_OG_MC_Skill1__c, 
    GE_OG_MC_Skill2__c,GE_OG_PC_Skill3__c from SVMXC__Service_Order__c where id in :mapTechVsWO.values() and (RecordTypeId=:PCRectype OR RecordTypeId=: ALRectypeId OR RecordTypeId=: DRLRectypeId)  ];*/
    
    //R-24879 : Commented above query and modified as below
   List<SVMXC__Service_Order__c> lstWOs=[Select Id, SVMXC__Group_Member__c, GE_PC_Job_Type__c, SVMXC__Skill__c, GE_OG_MC_Skill1__c, 
    GE_OG_MC_Skill2__c,GE_OG_PC_Skill3__c from SVMXC__Service_Order__c where id in :mapTechVsWO.values() and ((RecordTypeId=:PCRectype and SVMXC__Order_Status__c = 'Closed') OR (RecordTypeId=: ALRectypeId and SVMXC__Order_Status__c  ='Closed-Client Invoiced') OR (RecordTypeId=: DRLRectypeId and SVMXC__Order_Status__c  ='Closed'))];
     
    System.debug('Expertise Creation for Work Orders :'+lstWOs);
    if(lstWOs.size()>0)
    {

        Map<Id,List<SVMXC__Service_Group_Skills__c>> mapTechVsExp=new Map<Id,List<SVMXC__Service_Group_Skills__c>>();
        List<SVMXC__Service_Group_Skills__c> lstExp=new List<SVMXC__Service_Group_Skills__c>();
        List<SVMXC__Service_Group_Skills__c> lstNewExp=new List<SVMXC__Service_Group_Skills__c>();
        Map<String,SVMXC__Service_Group_Skills__c> mapNewExp=new Map<String,SVMXC__Service_Group_Skills__c>();
        List<SVMXC__Service_Group_Skills__c> lstExpertise =new List<SVMXC__Service_Group_Skills__c>();

        List<SVMXC__Service_Group_Members__c> lstTechs=[select id,SVMXC__Service_Group__c, 
                                                    (SELECT Id,SVMXC__Group_Member__c,GE_PC_Sign_Off__c,SVMXC__Skill__c,GE_OG_GS_Expertise_Usage_Counter__c,SVMXC__Skill__r.name FROM SVMXC__Service_Group_Skills__r) 
                                                    from SVMXC__Service_Group_Members__c 
                                                    where id in :mapTechVsWO.keySet()];
        Map<ID, SVMXC__Service_Order__c> mapWOs=new Map <ID, SVMXC__Service_Order__c>();
        mapWOs.putAll(lstWOs);
        
        //R-26065: Below If condition added to include the skill records based on JobType
       String jobTypeSet=''; 
        
        for(SVMXC__Service_Order__c wrkordr : lstWOs)
        {   
            if(wrkordr.GE_PC_Job_Type__c!=null)        
            jobTypeSet=jobTypeSet+wrkordr.GE_PC_Job_Type__c+';';
        }
        if (jobTypeSet != null && jobTypeSet.length() > 0) {
              jobTypeSet = jobTypeSet.substring(0, jobTypeSet.length()-1);
        }        
       
        List<SVMXC__Skill__c> jobTypeSkills = new List<SVMXC__Skill__c>();
        if(jobTypeSet!='')
            jobTypeSkills = [Select Id, GE_OG_Job_Type__c from SVMXC__Skill__c where GE_OG_Job_Type__c includes (:jobTypeSet)];
        //End //R-26065


        for(SVMXC__Service_Group_Members__c tech:lstTechs)
        {
            mapTechVsExp.put(tech.id,tech.SVMXC__Service_Group_Skills__r);
        }

        for(SVMXC__Service_Group_Members__c tech:lstTechs)
        {
            SVMXC__Service_Order__c wo=mapWOs.get(mapTechVsWO.get(tech.id));
            lstExp=mapTechVsExp.get(tech.id);  //Retrieve all existing expertise records for current Technician
            Boolean isInsertSkill=true,isInsertSkill1=true,isInsertSkill2=true,isInsertSkill3=true;
            for(SVMXC__Service_Group_Skills__c expertise:lstExp)
            {
                // R-26065
                for(SVMXC__Skill__c sk: jobTypeSkills)
                {   
                    if(expertise.GE_PC_Sign_Off__c==false && sk.GE_OG_Job_Type__c.contains(wo.GE_PC_Job_Type__c) && expertise.SVMXC__Skill__c==sk.Id && wo.SVMXC__Skill__c!=sk.Id && wo.GE_OG_MC_Skill1__c!=sk.Id && wo.GE_OG_MC_Skill2__c!=sk.Id && wo.GE_OG_PC_Skill3__c!=sk.Id)
                    {
                        if(expertise.GE_OG_GS_Expertise_Usage_Counter__c==null)
                            expertise.GE_OG_GS_Expertise_Usage_Counter__c=0;
                            expertise.GE_OG_GS_Expertise_Usage_Counter__c = expertise.GE_OG_GS_Expertise_Usage_Counter__c +1;            
                        lstExpertise.add(expertise);                        
                    }                   
                    
                    if(sk.GE_OG_Job_Type__c.contains(wo.GE_PC_Job_Type__c) && expertise.SVMXC__Skill__c!=sk.Id)     
                lstNewExp.add(new SVMXC__Service_Group_Skills__c(SVMXC__Skill__c=sk.Id,SVMXC__Group_Member__c=tech.id,SVMXC__Service_Group__c=tech.SVMXC__Service_Group__c));                   
                }
                // Ends R-26065
                System.debug('New Expertises--->'+lstNewExp);

                if(wo.SVMXC__Skill__c==expertise.SVMXC__Skill__c)
                    isInsertSkill=false;
                if(wo.GE_OG_MC_Skill1__c==expertise.SVMXC__Skill__c)
                    isInsertSkill1=false;            
                if(wo.GE_OG_MC_Skill2__c==expertise.SVMXC__Skill__c)
                    isInsertSkill2=false;
                if(wo.GE_OG_PC_Skill3__c==expertise.SVMXC__Skill__c)
                    isInsertSkill3=false; 

                if(expertise.GE_PC_Sign_Off__c==false && (isInsertSkill==false || isInsertSkill1==false || isInsertSkill2==false || isInsertSkill3==false))
                {
                    if(expertise.GE_OG_GS_Expertise_Usage_Counter__c==null)
                        expertise.GE_OG_GS_Expertise_Usage_Counter__c=0;
                        expertise.GE_OG_GS_Expertise_Usage_Counter__c = expertise.GE_OG_GS_Expertise_Usage_Counter__c +1;            
                    lstExpertise.add(expertise);
                }
            }
            
            // R-26065 starts
            if(lstExp.size()<=0)
            {
                for(SVMXC__Skill__c sk: jobTypeSkills)
                { 
                    if(sk.GE_OG_Job_Type__c.contains(wo.GE_PC_Job_Type__c))     
                lstNewExp.add(new SVMXC__Service_Group_Skills__c(SVMXC__Skill__c=sk.Id,SVMXC__Group_Member__c=tech.id,SVMXC__Service_Group__c=tech.SVMXC__Service_Group__c));                   
                }
            }
            // R-26065 ends 
            if(wo.SVMXC__Skill__c!=null && isInsertSkill)       
                lstNewExp.add(new SVMXC__Service_Group_Skills__c(SVMXC__Skill__c=wo.SVMXC__Skill__c,SVMXC__Group_Member__c=tech.id,SVMXC__Service_Group__c=tech.SVMXC__Service_Group__c));
            if(wo.GE_OG_MC_Skill1__c!=null && isInsertSkill1)
                lstNewExp.add(new SVMXC__Service_Group_Skills__c(SVMXC__Skill__c=wo.GE_OG_MC_Skill1__c,SVMXC__Group_Member__c=tech.id,SVMXC__Service_Group__c=tech.SVMXC__Service_Group__c));
            if(wo.GE_OG_MC_Skill2__c!=null && isInsertSkill2)
                lstNewExp.add(new SVMXC__Service_Group_Skills__c(SVMXC__Skill__c=wo.GE_OG_MC_Skill2__c,SVMXC__Group_Member__c=tech.id,SVMXC__Service_Group__c=tech.SVMXC__Service_Group__c));
            if(wo.GE_OG_PC_Skill3__c!=null && isInsertSkill3)
                lstNewExp.add(new SVMXC__Service_Group_Skills__c(SVMXC__Skill__c=wo.GE_OG_PC_Skill3__c,SVMXC__Group_Member__c=tech.id,SVMXC__Service_Group__c=tech.SVMXC__Service_Group__c));
        }
        
        Map<String,SVMXC__Service_Group_Skills__c> mapExistExp=new Map<String,SVMXC__Service_Group_Skills__c>();
        if(lstExpertise.size()>0)
        {   
            for(SVMXC__Service_Group_Skills__c exprt:lstExpertise)
            {
                if(!mapExistExp.containsKey(exprt.SVMXC__Skill__c+''+exprt.SVMXC__Group_Member__c))
                {
                    mapExistExp.put(exprt.SVMXC__Skill__c+''+exprt.SVMXC__Group_Member__c,exprt);
                }               
            }   
                
            if(mapExistExp.values().size()>0)
            {
                update mapExistExp.values();   
            }
        }

        //Removing Duplicate Techs & Skills
        for(SVMXC__Service_Group_Skills__c exp:lstNewExp)
        {
            if(!mapNewExp.containsKey(exp.SVMXC__Skill__c+''+exp.SVMXC__Group_Member__c))
            {
                if(!mapExistExp.containsKey(exp.SVMXC__Skill__c+''+exp.SVMXC__Group_Member__c))                
                    mapNewExp.put(exp.SVMXC__Skill__c+''+exp.SVMXC__Group_Member__c,exp);
            }
        }

        if(mapNewExp.values().size()>0)
        {
            insert mapNewExp.values();   
        }
    } 
}//End : R-22789
}