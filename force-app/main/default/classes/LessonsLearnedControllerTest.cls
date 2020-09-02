@isTest
public class LessonsLearnedControllerTest {
    
    
      public static testmethod void testLessonLearned()
    {    
        id recTypeAcc = Schema.SObjectType.Account.getRecordTypeInfosByName().get('CMF Approved').getRecordTypeId();
        Account acc = new Account();
        acc.Name ='Test';
        acc.recordTypeId = recTypeAcc;
        insert acc;
        
        Id wortidMob = Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('SS-Mobilize').getRecordTypeId();

        SVMXC__Service_Order__c svo = new SVMXC__Service_Order__c(
                            RecordTypeId = wortidMob ,
                            SVMXC__Company__c = acc.id,
                            SVMXC__Order_Status__c = 'Open',
                            GE_SS_No_of_Drilling_Personnel__c = 3); 
        insert svo;
        
        SVMXC__Site__c location = new SVMXC__Site__c();
        location.Name = 'ALVHEIM';        
        insert location;
        
        GE_SS_Project__c fsProject = new GE_SS_Project__c();
        fsProject.Name = 'test';
        fsProject.GE_SS_Account__c = acc.Id;
        insert fsProject;
        
        SVMXC__Installed_Product__c installedProd = new SVMXC__Installed_Product__c();
        installedProd.Name ='Test';
        installedProd.SVMXC__Company__c = acc.Id;
        insert installedProd;
        
        Product2 prod = new Product2();
        prod.Name = 'Test';
        insert prod;
        
        GE_SS_Project_Region__c projRegion = new GE_SS_Project_Region__c();
        projRegion.Name ='Europe';
        projRegion.Active__c = true;
        insert projRegion;
        
        SVMXC__Service_Order__c workOrder = new SVMXC__Service_Order__c();
        workOrder.GE_SS_Project__c = fsProject.id;
        insert workOrder;       
        
        User u = new User(
         ProfileId = [SELECT Id FROM Profile WHERE Name = 'GE_SS Field Service Admin'].Id,
         LastName = 'last',
         Email = 'user000@example.com',
         Username = 'user000@example.com',
         CompanyName = 'TEST',
         Title = 'title',
         Alias = 'alias',
         TimeZoneSidKey = 'America/Los_Angeles',
         EmailEncodingKey = 'UTF-8',
         LanguageLocaleKey = 'en_US',
         LocaleSidKey = 'en_US'
         
        );
        insert u;
        
        
        GE_OG_Lessons_Learnt__c lessonLearned = new GE_OG_Lessons_Learnt__c();
        lessonLearned.GE_OG_Location__c = location.id;
        lessonLearned.GE_SS_Product_Category__c = 'Tie-In';
        lessonLearned.Product_Group__c = 'CONNECTORS';
        lessonLearned.GE_OG_Job_Type__c = 'Completion';
        lessonLearned.GE_OG_Work_Order__c = workOrder.id;
        lessonLearned.GE_OG_Account__c = acc.Id;
        lessonLearned.Lessons_Learned_Type__c = 'Equipment';
        lessonLearned.GE_OG_Project_Region__c = projRegion.Id;
        lessonLearned.Status__c = 'Reviewed - no actions';
        lessonLearned.GE_OG_Country__c = 'Singapore';
        lessonLearned.GE_SS_FS_Project__c = fsProject.id;
        lessonLearned.GE_SS_Product__c= prod.id;
        lessonLearned.GE_OG_Installed_Product__c = installedProd.id;
        lessonLearned.GE_OG_Rig_Name__c = location.id;
        lessonLearned.GE_OG_Well__c = location.id;
        
        insert lessonLearned;
        
        lessonLearned.GE_OG_Subject__c = 'test';
        List<GE_OG_Lessons_Learnt__c> lessonLearneList = new List<GE_OG_Lessons_Learnt__c>();
        lessonLearneList.add(lessonLearned);
        
        List<Map<String, String>> countryList = LessonsLearnedController.getCountry();
        List<Map<String, String>> jobTypeList = LessonsLearnedController.getJobType();
        List<Map<String, String>>lessonLearnedList = LessonsLearnedController.getLessonLearnedType();
        List<Map<String, String>>prodCatList = LessonsLearnedController.getProductCategory();
        List<Map<String, String>>prodGroup = LessonsLearnedController.getProductGroup();
        List<Map<String, String>>statusList = LessonsLearnedController.getStatus();
        Map<String,String>fieldSet = new Map<String,String>();
        fieldSet.putall(LessonsLearnedController.getFieldSet('SS_NPT'));
        fieldSet.putall(LessonsLearnedController.getFieldSet('SIR - CaM'));
        fieldSet.putall(LessonsLearnedController.getFieldSet(''));
        Boolean flag = LessonsLearnedController.updateLessonLearned(lessonLearneList);
        Map<String,List<Map<String, String>>> casePicklist = LessonsLearnedController.getCasePickList();
        List<Case> caseList = new List<Case>();
        caseList.addall( LessonsLearnedController.getCaseRecords('Accident','Technical','Yes','WO-00123123','APA','No','Tool','Yes','First Event','1','','','','','','','','','','SS_NPT'));
        caseList.addall( LessonsLearnedController.getCaseRecords('Accident','Technical','No','WO-00123123','APA','Yes','Tool','Yes','First Event','1','Repair Inquiry','','TestAcc','APA','TestField','TestRig','123','3123','','SIR - CaM'));
        List<String>Id2List = new List<String>();
        /*GE_OG_Lessons_Learnt__c LL2 = new GE_OG_Lessons_Learnt__c();
        insert LL2;*/
        Id2List.add(String.valueOf(lessonLearned.id));
        Id2List.add(LessonsLearnedController.attachRecords('',Id2List,String.ValueOf(WorkOrder.id)));
        //Id2List.clear();
        //Id2List.add(String.valueOf(c1));
        //Id2List.add(LessonsLearnedController.attachRecords('NPT Case',Id2List,String.ValueOf(WorkOrder.id)));
        
        LessonsLearnedController.getLessonLearnedRecords('ALVHEIM','Tie-In','CONNECTORS','Completion','WO-00123123',acc.Name,'Equipment',projRegion.Name,'Reviewed - no actions','Singapore',
        fsProject.Name,Userinfo.getUserId(),prod.id,installedProd.Name,prod.Name,location.Name,location.Name,svo.id);
        LessonsLearnedController.getLessonLearnedRecords('','Tie-In','CONNECTORS','Completion',workOrder.Name,acc.Name,'Equipment',projRegion.Name,'Reviewed - no actions','Singapore',
        fsProject.Name,projRegion.CreatedById,prod.id,installedProd.Name,prod.Name,location.Name,location.Name,svo.id);
        LessonsLearnedController.getLessonLearnedRecords('ALVHEIM','','CONNECTORS','Completion',workOrder.Name,acc.Name,'Equipment',projRegion.Name,'Reviewed - no actions','Singapore',
        fsProject.Name,projRegion.CreatedById,prod.id,installedProd.Name,prod.Name,location.Name,location.Name,svo.id);
        LessonsLearnedController.getLessonLearnedRecords('ALVHEIM','Tie-In','','Completion',workOrder.Name,acc.Name,'Equipment',projRegion.Name,'Reviewed - no actions','Singapore',
        fsProject.Name,projRegion.CreatedById,prod.id,installedProd.Name,prod.Name,location.Name,location.Name,svo.id);
        LessonsLearnedController.getLessonLearnedRecords('ALVHEIM','Tie-In','CONNECTORS','',workOrder.Name,acc.Name,'Equipment',projRegion.Name,'Reviewed - no actions','Singapore',
        fsProject.Name,projRegion.CreatedById,prod.id,installedProd.Name,prod.Name,location.Name,location.Name,svo.id);
        LessonsLearnedController.getLessonLearnedRecords('ALVHEIM','Tie-In','CONNECTORS','Completion','',acc.Name,'Equipment',projRegion.Name,'Reviewed - no actions','Singapore',
        fsProject.Name,projRegion.CreatedById,prod.id,installedProd.Name,prod.Name,location.Name,location.Name,svo.id);
        LessonsLearnedController.getLessonLearnedRecords('ALVHEIM','Tie-In','CONNECTORS','Completion',workOrder.Name,'','Equipment',projRegion.Name,'Reviewed - no actions','Singapore',
        fsProject.Name,projRegion.CreatedById,prod.id,installedProd.Name,prod.Name,location.Name,location.Name,svo.id);
        LessonsLearnedController.getLessonLearnedRecords('','','CONNECTORS','Completion',workOrder.Name,'','Equipment',projRegion.Name,'Reviewed - no actions','Singapore',
        fsProject.Name,projRegion.CreatedById,prod.id,installedProd.Name,prod.Name,location.Name,location.Name,svo.id);
        LessonsLearnedController.getLessonLearnedRecords('','','','Completion',workOrder.Name,'','Equipment',projRegion.Name,'Reviewed - no actions','Singapore',
        fsProject.Name,projRegion.CreatedById,prod.id,installedProd.Name,prod.Name,location.Name,location.Name,svo.id);
        LessonsLearnedController.getLessonLearnedRecords('','','','',workOrder.Name,'','Equipment',projRegion.Name,'Reviewed - no actions','Singapore',
        fsProject.Name,projRegion.CreatedById,prod.id,installedProd.Name,prod.Name,location.Name,location.Name,svo.id);
        LessonsLearnedController.getLessonLearnedRecords('','','','','','','Equipment',projRegion.Name,'Reviewed - no actions','Singapore',
        fsProject.Name,projRegion.CreatedById,prod.id,installedProd.Name,prod.Name,location.Name,location.Name,svo.id);
        LessonsLearnedController.getLessonLearnedRecords('','','','','','','',projRegion.Name,'Reviewed - no actions','Singapore',
        fsProject.Name,projRegion.CreatedById,prod.id,installedProd.Name,prod.Name,location.Name,location.Name,svo.id);
        LessonsLearnedController.getLessonLearnedRecords('','','','','','','','','Reviewed - no actions','Singapore',
        fsProject.Name,projRegion.CreatedById,prod.id,installedProd.Name,prod.Name,location.Name,location.Name,svo.id);
        LessonsLearnedController.getLessonLearnedRecords('','','','','','','','','','Singapore',
        fsProject.Name,projRegion.CreatedById,prod.id,installedProd.Name,prod.Name,location.Name,location.Name,svo.id);
        LessonsLearnedController.getLessonLearnedRecords('','','','','','','','','','',
        fsProject.Name,projRegion.CreatedById,prod.id,installedProd.Name,prod.Name,location.Name,location.Name,svo.id);
        LessonsLearnedController.getLessonLearnedRecords('','','','','','','','','','',
        '',projRegion.CreatedById,prod.id,installedProd.Name,prod.Name,location.Name,location.Name,svo.id);
        LessonsLearnedController.getLessonLearnedRecords('','','','','','','','','','',
        '','',prod.id,installedProd.Name,prod.Name,location.Name,location.Name,svo.id);
        LessonsLearnedController.getLessonLearnedRecords('','','','','','','','','','',
        '','','',installedProd.Name,prod.Name,location.Name,location.Name,svo.id);
        
    
    }
    
   

}