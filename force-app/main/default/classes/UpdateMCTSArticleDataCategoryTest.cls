@isTest
public class UpdateMCTSArticleDataCategoryTest{
    
    
      public static testmethod void testKnowledgeBaseDataCat()
    {    
       List<Id> articleIdList = new List<Id>();
       List<Deal_Machine__kav> dealMachineList = new List<Deal_Machine__kav>();
       Id MC_TSRecId = Schema.SObjectType.Deal_Machine__kav.getRecordTypeInfosByName().get('MC-TS Article').getRecordTypeId();
       Id dealMachineRecId = Schema.SObjectType.Deal_Machine__kav.getRecordTypeInfosByName().get('Deal_Machine').getRecordTypeId();


       Deal_Machine__kav newArticle = new Deal_Machine__kav
      (Title='testClassArticle', UrlName='testClassArticleURL',Assembly__c='Ex2000', Sub_Business__c='Control Solutions',Business__c='Digital Solutions',RecordTypeId =MC_TSRecId);
       dealMachineList.add(newArticle );

      Deal_Machine__kav newDMArticle = new Deal_Machine__kav
      (Title='testClassDMArticle', UrlName='testClassDMArticleURL',RecordTypeId =dealMachineRecId);
      dealMachineList.add(newDMArticle);
      
       Insert dealMachineList ;
       articleIdList.add(newArticle.id);       
       articleIdList.add(newDMArticle.id);
       UpdateMCTSArticleDataCategory.updateMCTSArticleDataCategory(articleIdList);
    
    }
    
   

}