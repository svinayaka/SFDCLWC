global class GE_OG_RemovePackage_ScheduleBatch implements Schedulable{
    
    global void execute(SchedulableContext sc ){
        GE_OG_RemovePackageLicenses OGDB=new GE_OG_RemovePackageLicenses();
        Database.executeBatch(OGDB,50);
        
    }   
}