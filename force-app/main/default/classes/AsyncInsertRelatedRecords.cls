public class AsyncInsertRelatedRecords implements Queueable{
    List<SObject> recordsList = new List<SObject>();
    String strOperation = '';

    public AsyncInsertRelatedRecords(List<SObject> listRelated, String strOperation){
        this.recordsList = listRelated;
        this.strOperation = strOperation;
    }

    public void execute(QueueableContext context) {
       if(!recordsList.isEmpty()){
           system.debug('Inside Queueable');
               Integer i =0;
               while(i < 10){
                    try{
                        if(strOperation == 'Insert'){
                            insert recordsList;
                            i=10;
                        }
                        if(strOperation == 'Update'){
                            update recordsList;
                        }
                    }
                    catch(Exception e){
                        if(e.getMessage().contains('UNABLE_TO_LOCK_ROW')){
                           i++; 
                        }
                        else{
                            i = 10;
                        }
                        system.debug('Error in inserting/updating the chunk of records...');
                    }
                }
        }
            
       
    } 

}