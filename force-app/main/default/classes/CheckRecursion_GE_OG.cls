/*
Class/Trigger Name     : CheckRecursion_GE_OG
Purpose/Overview       : This class is responsible to handle recursive triggers
Scrum Team             : Transformation - OPPTY MGMT
Requirement Number     : R-23405
Author                 : Madhuri Sharma
Created Date           : 10/OCT/2015
Test Class Name        : OpportunityStagesAutomation_GE_OG_Test
Code Coverage          : 
*/

public Class CheckRecursion_GE_OG{
    
    public static boolean run = true;
    public static boolean ddRun = true;
    public static boolean prebidRun = true;
    public static boolean runDeliveryDate = true;
    public static boolean eRadCreation = true;
    public static boolean ddBeforeProcess = true;
    public static boolean runteamMember = true;
    public static boolean taskRun = true;
    public static boolean campaignRecursion = true;
    public static boolean cmrRecursion = true;
    public static boolean leadRecusrion =true;
    static Integer eradCount = 0;
    static Integer campaignCount = 0;
    public static boolean chAppt = true;
    public static boolean comLine = true;
    public static boolean cp_background = true;
    
    public static boolean runteamMember(){
        if(runteamMember){
            runteamMember = false;
            return true;
        }
        else{
            return runteamMember;
        }
        
    }
    
    public static boolean runOnce(){
        if(run){
         run=false;
         return true;
        }else{
            return run;
        }
    }
    
    public static boolean dealDeskRecusrion(){
        if(ddRun){
         ddrun=false;
         return true;
        }else{
            return ddrun;
        }
    }
    
     public static boolean ddBeforeProcess(){
        if(ddBeforeProcess){
         ddBeforeProcess=false;
         return true;
        }else{
            return ddBeforeProcess;
        }
    }
    
    
    public static boolean prebidRecursion(){
        if(prebidRun){
         prebidRun=false;
         return true;
        }else{
            return prebidRun;
        }
    }
    
    //To check for Task update recurssion
    public static boolean taskRecursion(){
        if(taskRun){
         taskRun=false;
         return true;
        }else{
            return taskRun;
        }
    }
    
    // method to stop recursive for update 1st Delivery Date on OLI
    public static boolean runDeliveryDate(){
        if(runDeliveryDate){
            runDeliveryDate=false;
            return true;
        }
        else{
            return runDeliveryDate;
        }
    }
    
    public static boolean eRadCreation(){
        if(eRadCreation){
            if(eradCount<2){
                eradCount++;
            }
            else if(eradCount>=2){
                eRadCreation = false;
                return false;
            }
            return true;
        }
        else{
            return eRadCreation;
        }
    }
    
    // method to stop recursive for update Campaign
    public static boolean checkRecursionCampaign(){
       System.debug('----------------------Count of iteration:'+campaignCount); 
       if(campaignRecursion){
            if(campaignCount<2){
                campaignCount++;
            }
            else if(campaignCount>=2){
                campaignRecursion = false;
                return false;
            }
            return true;
        }
        else{
            return campaignRecursion;
        } 
    } 
    
    //Method to stop recursive for CMR update
    public static boolean cmrRecusrion(){
        if(cmrRecursion){
         cmrRecursion=false;
         return true;
        }else{
            return cmrRecursion;
        }
    }
    
    //Method to stop recursive Lead update
    
    public static boolean leadRecusrion(){
        if(leadRecusrion){
         leadRecusrion=false;
         return true;
        }else{
            return leadRecusrion;
        }
    } 
    
}