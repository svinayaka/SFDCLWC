public without sharing class GE_OG_DTS_EventDetail {

 public Id woId {get;set;}
     
    public class eventtable{
    
   public String Name {get;set;}   
   public String sd {get;set;}
   public String ed {get;set;}   
   public String allday{get;set;}
        
    } 
     
     
    public List<eventtable> geteventdetails()
    {    
        List<Id> techid = new List<Id>();
        List<SVMXC__Service_Group_Members__c> technicians;
        SVMXC__Service_Order__c wo = [SELECT name,GE_PC_Driving_Directions__c FROM SVMXC__Service_Order__c where id =: woId];
        String s = wo.GE_PC_Driving_Directions__c;        
        string[] eve = s.split(',');
        List<eventtable> evedet = new List<eventtable>();
        
        for(Integer i=0;i<eve.size();i++){      
                        eventtable t = new eventtable();  
                        string[] token = eve[i].split(';');
                        String team = token[1];
                        String tech = token[0];
                        
                        t.sd = token[3];
                        t.ed = token[4]; 
                        t.allday = token[2];   
                        evedet.add(t);                                           
                        techid.add(tech);  
                    }
        technicians = [select id,Name from SVMXC__Service_Group_Members__c where id in :techid]; 
           
        for(Integer i=0;i<technicians.size();i++){
         evedet[i].Name = technicians[i].Name;
        }
        return evedet;
    }
    
    public string getUrl(){
    
    String approvallink = '';
    
    List<ProcessInstanceWorkitem> workItemLst =  [SELECT id FROM ProcessInstanceWorkitem WHERE processInstance.TargetObjectId=:woId];
    
    if(workItemLst.size() > 0)  
      {  
         
        approvallink ='https://'+ System.URL.getSalesforceBaseUrl().getHost() +   
         '/p/process/ProcessInstanceWorkitemWizardStageManager?id=' + workItemLst[0].id;      
     }  
    
    
    
    return approvallink;
    
    }
    
    
    public string getComments(){
    
        String comments='';
        
        List<ProcessInstanceStep> steps = new List<ProcessInstanceStep>([SELECT Comments FROM ProcessInstanceStep WHERE ProcessInstance.TargetObjectId = :woId ORDER BY SystemModStamp DESC LIMIT 1]);
        if(steps.size()>0){
        
        comments = steps[0].Comments;
        
        }
        
        return comments;
    }
    
    
}