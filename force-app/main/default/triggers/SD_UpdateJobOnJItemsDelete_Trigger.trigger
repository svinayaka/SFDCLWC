trigger SD_UpdateJobOnJItemsDelete_Trigger on SDJob_Items__c ( before delete )
{
    Set<Id> jobIds = new Set<Id>();
    for ( SDJob_Items__c jitem : [SELECT id, SD_Job__c FROM SDJob_Items__c WHERE Id IN :Trigger.old] ) {
    jobIds.add( jitem.SD_Job__c );
    }
    
    List<FX5__Job__c> jobstoUpdate = [SELECT id,SD_Count_of_Job_Items__c,SD_Fundamentals_Added__c,SD_Fundamentals_To_Be_Added__c FROM FX5__Job__c WHERE Id IN :jobIds];
    for ( FX5__Job__c jb : jobstoUpdate ){ 
        IF(jb.SD_Count_of_Job_Items__c >= 1){
    		jb.SD_Fundamentals_To_Be_Added__c = TRUE;
        }
        Else{
           jb.SD_Fundamentals_To_Be_Added__c = FALSE; 
        }
    }
    System.debug('After DELETE Job Items : I am in Trigger SD_UpdateJobOnJItemsDelete_Trigger -->'+jobstoUpdate);
    update jobstoUpdate;
    
}