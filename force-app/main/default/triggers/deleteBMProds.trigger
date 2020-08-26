trigger deleteBMProds on BigMachines__Quote__c (before insert, before update) {
  
    // There is no standard scenario where multiple quotes are created in one
    // batch operation.  There are standard scenarios where multiple quotes
    // are updated in one batch operation.  This trigger only operates for 
    // individual quote creation or multiple quote modification.  If multiple
    // quotes are created at the same time (through the Data Loader, for 
    // example) this trigger will not do anything.  This trigger will fire, 
    // however, if multiple quotes are updated at the same time.

    //loop through trigger and find primary
    Integer index = -1;
    Integer currentPriIndex = -1;
    if (Trigger.isInsert) {
        //if a single quote is being created as primary, sync it with opty
        if ((Trigger.size == 1) && (Trigger.new[0].BigMachines__Is_Primary__c == true)) {
            index = 0;
        }
    } else {
        for (Integer i=0; i<Trigger.size; i++) {
            //loop through all updated quotes
            if ((Trigger.old[i].BigMachines__Is_Primary__c == false) && (Trigger.new[i].BigMachines__Is_Primary__c == true)) {
                //if a quote is changing to primary
                if (index == -1) {
                    // found first primary, mark to sync with opty
                    index = i;
                } else {
                    // found more than one primary, so don't sync with opty
                    index = -2;
                    break;
                }
            }
            if((Trigger.old[i].BigMachines__Is_Primary__c == true) && (Trigger.new[i].BigMachines__Is_Primary__c == true)) {
                currentPriIndex = i;
            }
        } 
    } 
    if(index==-1 && currentPriIndex >= 0){index=currentPriIndex;}
    if (index >= 0) {
        // Sunayana : Code commented  as class GEESGlobalContextController does not exists any more
        // GEESGlobalContextController.isBigMachinePrimaryQuoteRun = true ;
        //MRK - delete only if the new quote status is Ready for approval. 
        if (Trigger.new[index].BigMachines__Status__c == 'Ready for Approval' || Trigger.new[index].BigMachines__Status__c == 'Ready for Customer' || Trigger.new[index].BigMachines__Status__c == 'Approved')
        {
            System.Debug('Delete BM Prods');
            BigMachinesDeleteBMProds.deleteBMProds(Trigger.new[index].Id, Trigger.new[index].BigMachines__Opportunity__c);
        }
    }
    
}