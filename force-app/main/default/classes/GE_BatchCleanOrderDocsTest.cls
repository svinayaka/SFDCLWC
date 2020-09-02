/*
Class Name        : GE_BatchCleanOrderDocsTest
Purpose/Overview  : Test class for GE_BatchCleanOrderDocs

Author            : Htut Zaw
Test Class        :
Change History    : Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
                  : 2014-04-11    : Htut Zaw           : Inital creation
*/
@isTest
private class GE_BatchCleanOrderDocsTest
{
  /*
  Purpose/Overview  : The unit test method
  Input Param       : n/a
  Return Param      : n/a
  Exceptions        : n/a
  */
  @isTest static void testBatch()
  {
    Exception batchExcep = null;

    // create some sample docs to remove
    Folder folder = [SELECT Id, Name FROM Folder WHERE Name = '_TempOrders'];
    List<Document> docList = new List<Document>();

    for (Integer i = 0; i < 10; i++)
    {
      Document d = new Document();
      d.Name = 'Sample Text File' + i;
      String myContent = 'aabbcc';
      d.Body = Blob.valueOf(myContent);
      d.ContentType = 'text/plain';
      d.Type = 'txt';
      d.FolderId = folder.Id;
      docList.add(d);
    }
    insert docList;

    System.assertEquals(getTempDocCount(), 10);

    Test.startTest();

    GE_BatchCleanOrderDocs.setHoursOld(0);
    GE_BatchCleanOrderDocs.run();

    Test.stopTest();

    System.assertEquals(getTempDocCount(), 0);

  }


  /*
  Purpose/Overview  : Returns the number of documents in the _TempOrders folder
  Input Param       : n/a
  Return Param      : the count of documents
  Exceptions        : n/a
  */
  static private Integer getTempDocCount()
  {
    Integer retVal = 0;

    Folder folder = [SELECT Id, Name FROM Folder WHERE Name = '_TempOrders'];

    AggregateResult[] aggResults = [SELECT Count(Id)
                                    FROM Document
                                    WHERE FolderId = :folder.Id];
    for (AggregateResult ar : aggResults)
    {
      retVal = (Integer)ar.get('expr0');
    }

    return retVal;
  }

}