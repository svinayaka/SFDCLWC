/*
Class Name        : GE_BatchCleanOrderDocs
Purpose/Overview  : Batch class to cleanup documents created by the GE_OrderUtilsWS class. Delete any documents
                    in "_TempOrders" folder that are older than 24 hours old.
Author            : Htut Zaw
Test Class        : GE_BatchCleanOrderDocsTest
Change History    : Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
                  : 2014-04-11    : Htut Zaw           : Inital creation
*/
global class GE_BatchCleanOrderDocs implements Schedulable, Database.Batchable<sObject>
{
  private static Integer hoursOld = 24;

  /*
  Purpose/Overview  : Set the number of hours old for processing documents
  Input Param       : value - the value of number of hours old to process documents
  Return Param      : n/a
  Exceptions        : n/a
  */
  public static void setHoursOld(Integer value)
  {
    hoursOld = value;
  }

  /*
  Purpose/Overview  : Execute the batch process based on scheduler event
  Input Param       : ctx - The schedule context
  Return Param      : n/a
  Exceptions        : n/a
  */
  public void execute(SchedulableContext ctx)
  {
    run();
  }

  /*
  Purpose/Overview  : Returns the number of documents in the _TempOrders folder
  Input Param       : n/a
  Return Param      : the count of documents
  Exceptions        : n/a
  */
  public static void run()
  {
    Database.executeBatch(new GE_BatchCleanOrderDocs());
  }

  /*
  Purpose/Overview  : Setup the batch process and determine the list of documents to process.
  Input Param       : BC - the batch context object
  Return Param      : The SOQL query locator for the records (documents) to process
  Exceptions        : n/a
  */
  global Database.QueryLocator start(Database.BatchableContext BC)
  {
    Folder folder = [SELECT Id, Name FROM Folder WHERE Name = '_TempOrders'];

    Datetime dttm = Datetime.now().addHours(-hoursOld);  // delete anything greater than 24 hours old

    return Database.getQueryLocator([SELECT Id FROM Document WHERE FolderId = :folder.Id AND CreatedDate <= :dttm]);
  }

  /*
  Purpose/Overview  : Execute logic on a batch of documents
  Input Param       : BC - he batch context object
                      docList - list of documents to process based on the start method selection
  Return Param      : n/a
  Exceptions        : n/a
  */
  global void execute(Database.BatchableContext BC, List<Document> docList)
  {
    delete docList;
  }

  /*
  Purpose/Overview  : Perform any finalization work at the end of the batch
  Input Param       : The batch context object
  Return Param      : n/a
  Exceptions        : n/a
  */
  global void finish(Database.BatchableContext BC)
  {

  }

}