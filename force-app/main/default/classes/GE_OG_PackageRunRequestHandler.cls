/*Class name: 		GE_OG_PackageRunRequestHandler
* Purpose: 		Used to run the flagging process tied to the object Package_Run_Request__c.
* 		    		Will run an async process to flag and map manage package users
* Created Date:	3/24/2016
* Author:			Matt Koshay
**/

public class GE_OG_PackageRunRequestHandler {
    
    public static void runPackageLicenseBatchJob(List <Package_Run_Request__c> newObjects){
        
        String className = 'GE_OG_PackageLicenseBatch';
        
        // Check if the batch job is already running
        List<AsyncApexJob> batchJob = new List<AsyncApexJob>();
        batchJob = [SELECT Id, MethodName, Status, CreatedDate FROM AsyncApexJob where ApexClassId in (SELECT Id FROM ApexClass where name= :className) 
                    and jobtype = 'BatchApex' and status ='Processing'];
        // if we do not have a batch job already running, then run the job
        if(batchJob.size()==0){
            System.debug('Creating batch entry');
            // don't run the batch call in test context.  This is covered in a different test class
            if(!test.isRunningTest()){
                GE_OG_PackageLicenseBatch batch = new GE_OG_PackageLicenseBatch();
                ID batchprocessid = database.executeBatch(batch, 1000);
            }
            
            newObjects.get(0).Job_Information_Error_info__c ='Job submitted successfully - email will be sent when completed';
            newObjects.get(0).Status__c='Success';
            System.debug('Job Submitted Successfully');
            
        }
        //If we have queued or processing jobs, don't create more!
        if (batchJob.size()>0 || test.isRunningTest()){
            newObjects.get(0).Job_Information_Error_info__c ='Cancelling this job since there are other jobs in the queue ' + batchJob;
            newObjects.get(0).Status__c='Cancelled';
            System.debug('There is a batch job running so no job is scheduled');
        }
        
        
    }
    
   /* public static void disableSMaxTrigger(List <Package_Run_Request__c> newObjects, boolean over_ride){
        
        // We only want to process one request so filter out and only process the first record  
        for(Integer i=0; i<newObjects.size(); i++){
            if(i != 0){
                newObjects.get(i).Job_Information_Error_info__c='Record not process; was tied to batch of records.  Only processed record ' + newObjects.get(0).Id;
                newObjects.get(i).Status__c='Cancelled';
            }
            
        }
        
        // Try to turn off the ServiceMax user object triggers
        boolean successfulResult = GE_OG_Package_Utils.toggleSMaxUserTrigger(false);
        
        // able to turn off the ServiceMax user object triggers 
        // for test coverage, need to be able to toggle this over_ride value (can't set custom label values)
        if(successfulResult || over_ride){            
            // Set the status of record
            newObjects.get(0).Job_Information_Error_info__c ='Turned Off SMax User trigger setting successfull... will attempt to run async flagging process';
            newObjects.get(0).Status__c='Queued';
            
            //if we were able to turn off the setting then run the flagging/mapping process if there are no other pending jobs in the queue
            List<AsyncApexJob> futureCalls = new List<AsyncApexJob>();
            futureCalls = [SELECT Id, MethodName, Status, CreatedDate FROM AsyncApexJob where methodName='runFlaggingMapping' and status ='Processing'];
            if(futureCalls.size()==0)
                runFlaggingMapping(false);           
            //If we have queued or processing jobs, don't create more!
            else{
                newObjects.get(0).Job_Information_Error_info__c ='Cancelling this job since there are other jobs in the queue ' + futureCalls;
                newObjects.get(0).Status__c='Cancelled';
            }
        }
        else{
            newObjects.get(0).Job_Information_Error_info__c ='Failed to turn off SMax User trigger setting';
            newObjects.get(0).Status__c='Failure';
        }       
        
    }
    
    
    @future
    public static void runFlaggingMapping(boolean over_ride){
        
        Package_Run_Request__c PR = new Package_Run_Request__c();
        Package_Run_Request__c tempPR;
        List<Package_Run_Request__c> PRList = new List<Package_Run_Request__c>();   
        List<Package_Run_Request__c> PRCancelList = new List<Package_Run_Request__c>();
        
        PRList = [select Id, Status__c, Job_Information_Error_info__c from Package_Run_Request__c where Status__c='Queued'];
        // We only want to process one request so filter out and only process the first record  
        for(Integer i=0; i<PRList.size(); i++){
            if(i==0)
                PR=PRList.get(i);            
            else{
                tempPR = new Package_Run_Request__c();
                tempPR = PRList.get(i);
                tempPR.Job_Information_Error_info__c='Record not process; was tied to batch of records.  Only processed record ' + PR.Id;
                tempPR.Status__c='Cancelled';
                PRCancelList.add(tempPR);
            }
        }
        
        // if we have something to process (or running tests)
        if(PR.ID != null || over_ride) {
            //	run the flag/mapping process
            List<String> packages = new List<String>();
            For(Package__c pack : [select Name from Package__c where Active__c = true])
                packages.add(pack.name);
            System.debug('Packages to run the process against: ' + packages);
            // Run the method to flag App Exchange package user license usage        
            GE_OG_Package_Users PU = new GE_OG_Package_Users();
            PU.flagPackageUsers(packages);
            PU.createPackageUsers('ServiceMax');
            
            // turn the user flag back on
            boolean successfulResult = GE_OG_Package_Utils.toggleSMaxUserTrigger(true);
            
            // for test coverage, need to be able to toggle this value (can't set custom label values)
            if(over_ride)
                successfulResult = true;
            
            //if we're not able to set the flag back to true and we had an exception
            if(!successfulResult){
                PR.Status__c='Failure';
                PR.Job_Information_Error_info__c ='Failed to turn ON SMax User trigger setting action needed'; 
            }
            // Successful Job
            else if(successfulResult){
                PR.Status__c='Success';
                PR.Job_Information_Error_info__c = 'Job completed successfully';
            }
            
            if(PR.ID != null)
                Update PR;
        }
        
    } */
    
}