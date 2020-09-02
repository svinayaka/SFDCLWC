@isTest
public class privatereportsinserttest {
 @isTest(SeeAllData='true')

   public static void testinsertprivatereportsmethod(){
       /** List<Private_Reports__c> tobeinserted = new List<Private_Reports__c>();
        Report pr= [SELECT Id,Name,CreatedById,CreatedBy.name,CreatedDate,DeveloperName,FolderName,Format,LastModifiedById,LastModifiedBy.name,LastModifiedDate FROM Report limit 1];
        Private_Reports__c pvr = new Private_Reports__c();
        pvr.Report_ID__c=pr.id;
        pvr.Name=pr.name;
        pvr.Report_Created_By__c=pr.CreatedById;
        pvr.Report_Created_date__c=pr.CreatedDate;
        pvr.Report_Developer_Name__c=pr.DeveloperName; 
        pvr.Report_Folder_Name__c=pr.FolderName;
        pvr.Report_Format__c=pr.Format; 
        pvr.Report_Modified_By__c=pr.LastModifiedById;
        pvr.Report_Modified_date__c=pr.LastModifiedDate;
        tobeinserted.add(pvr);
        insert tobeinserted; **/
        test.startTest();
        privatereportsinsert pvtreports =new privatereportsinsert();
        database.executeBatch(pvtreports);
        pvtreports.Finish(null);
        test.stopTest();
        }
}