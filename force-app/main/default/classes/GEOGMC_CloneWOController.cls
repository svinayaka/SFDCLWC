/*
Type Name [Class/Trigger/Page Name] : Class - GEOGMC_CloneWOController
Purpose                             : Customize the standard clone functionality of WorkOrder Object
Overview                            : This class Customize the standard clone functionality of WorkOrder Object
                                      by removing the fields ServiceTeam, Technician and Skill while clone
Functional Area                     : ServiceMax
Author                              : RajaKumar Malla
Created Date                        : 12 Feb 2013
*/


public class GEOGMC_CloneWOController{

    String currentWOId {get;set;}
    String soql {get;set;}
    SVMXC__Service_Order__c CloneWO{get;set;}
    SVMXC__Service_Order__c CurrentWO{get;set;}
    SVMXC__Service_Order__c Workid=new SVMXC__Service_Order__c();
    Static string CurrentWOIdSkill;    

    Public GEOGMC_CloneWOController(ApexPages.StandardController controller) {
    
        currentWOId = ApexPages.currentPage().getParameters().get('Id'); 
         currentWOId= String.escapeSingleQuotes(currentWOId);
        currentWOId = 'Id =' +'\''+currentWOId+'\''; 
        
        soql = GE_ES_Utils.getCreatableFieldsSOQL('SVMXC__Service_Order__c', currentWOId); 
        //System.debug('soql :'+ soql );
        CurrentWO = (SVMXC__Service_Order__c) Database.query(soql);
        System.debug('CurrentWO :'+ CurrentWO );
        CurrentWOIdSkill=ApexPages.currentPage().getParameters().get('Id');
    }

    public PageReference reDirect() {
    
        CloneWO = CurrentWO.clone(false, true);
        System.debug('CloneWO :'+ CloneWO );
        System.debug('currentWOId:'+ currentWOId);
        Workid=[Select Id,SVMXC__Skill__c from SVMXC__Service_Order__c where id=:CurrentWOIdSkill];
        System.debug('CurrentWOIdSkill'+CurrentWOIdSkill);
        CloneWO.SVMXC__Service_Group__c  = null;
        CloneWO.SVMXC__Group_Member__c  = null;
        CloneWO.SVMXC__Skill__c  = null;
        CloneWO.GE_HQ_SFDC_LEGACY_ID__c = null;
        CloneWO.SVMXC__Order_Status__c='Open';
        CloneWO.SVMXC__Closed_By__c=null;
        CloneWO.SVMXC__Closed_On__c=null; 
        CloneWO.GE_SM_HQ_Borrowed_Technician_Approved_On__c=null;
        CloneWO.SVMXC__NoOfTimesScheduled__c=null;
        CloneWO.GE_SM_HQ_Dispatched_Outside_Territory__c=false;
        CloneWO.SVMXC__Member_Email__c=null;
        CloneWO.SVMXC__Skill__c=Workid.SVMXC__Skill__c;
        CloneWO.GE_OG_SkillMismatchCheck__c=false;
        CloneWO.GE_OG_MC_Justification_of_skill_MisMatch__c=null;
        CloneWO.GE_SM_HQ_Scheduled_Start_Date_Time__c=null;
        CloneWO.GE_SM_HQ_Scheduled_End_Date_Time__c=null;
        insert CloneWO; 
        System.debug('CloneWO:'+ CloneWO);
    
        PageReference redirect = new PageReference('/'+CloneWO.id);
        redirect.setRedirect(true);
        return redirect; 
    }

}