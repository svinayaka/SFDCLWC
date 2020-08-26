/**
 * 
 * Class/Trigger Name--: GEOGCIRTaskforecastUpdate  
 * Purpose/Overview----: This trigger is used to update the highest task closure forecast date to the case forecast date
                         on insert and update of a task.It is also used to stop the task from updating if the case owner 
                         and the performing user are not the same and the duedate is changed
 * Author--------------: Sandeep Rayavarapu
 * Created Date--------: 1/10/2014
 * Test Class Name-----: Test_GEOGCIRTaskforecastUpdate

 * Change History -

 * Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
   
**/



trigger GEOGCIRTaskforecastUpdate on Task (after insert,after update)  {
    //getting caseid from the task whatid
    set<id> caseid = new set<id>();
     Id r= Schema.SObjectType.task.getRecordTypeInfosByName().get('CIR').getRecordTypeId();
    for(task t:trigger.new) {
        if(t.whatid!=null) {
            if(string.valueof(t.whatid).startswith('500')) {
                caseid.add(t.whatid);
            }
        }
    }
    
    //crating a map with key as case id and value as case
    map<id,case> casemap = new map<id,case>();
    for(case c:[select id,OwnerId,GE_OG_Resolution_Forecasted_Date_CIR__c from case where id in:caseid]) {
        casemap.put(c.id,c);
    }
    
    //getting all the tasks from the case and putting it into a map with key as caseid and value as list of all tasks
    map<id,list<task>> maptasks = new map<id,list<task>>();
    for(task t:[select id,WhatId,Task_Closure_Forecast_Date__c from task where Whatid in:caseid AND recordtypeid=:r])
    {
        if(maptasks.containskey(t.whatid)==false)
        {
            maptasks.put(t.whatid,new list<task>{t});
        }
        
        else{
            maptasks.get(t.whatid).add(t);
        }
    
    }
    
    //checking the greatest task forecast date from the tasks and mapping the date to the case forecast date
    map<id,case> clst = new map<id,case>();
    for(task t:trigger.new) {
          
        if(casemap.containskey(t.whatid)==true&&t.recordtypeid==r)
        {
        
        
            date d;
            d=t.Task_Closure_Forecast_Date__c;
            
            case c=casemap.get(t.whatid);
            list<task> tlst= maptasks.get(t.whatid);
            system.debug('....'+d);
             system.debug('....'+tlst);
              
              //stopping the update if the case owner and the performing user are not the same and the duedate is changed
              if(trigger.isupdate)
              {
              if(c.ownerid!=userinfo.getuserid()&&trigger.oldmap.get(t.id).ActivityDate!=t.ActivityDate)
              {
              
                  t.adderror('Only owner of the case can Modify the Due date');
              
              }
              
              }
              
              
              
            for(task t1:tlst)
            {
                
                if(d<=t1.Task_Closure_Forecast_Date__c)
                {
                    d=t1.Task_Closure_Forecast_Date__c;
                }
                /*  condition is already handled in below for loop          
                
                if(t1.Task_Closure_Forecast_Date__c==null)
                {
                d=null;
                }  */
            }
            
            for(task t1:tlst)
            {
                
                
                if(t1.Task_Closure_Forecast_Date__c==null)
                {
                d=null;
                }
            }
            
            c.GE_OG_Resolution_Forecasted_Date_CIR__c=d;
            clst.put(c.id,c);
        }
    }
    update clst.values();
    
    
    
    
    
    
}