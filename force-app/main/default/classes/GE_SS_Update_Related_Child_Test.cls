@isTest(SeeAllData=false)
public class GE_SS_Update_Related_Child_Test {

   // public GE_SS_Project__c tmpFSProject{get;set;}
   // public GE_SS_Project_Region__c recPG1{get;set;}
    
    public testmethod static void UpdateFSProjectMethod()
    {
        
         Id csrtid = Schema.SObjectType.SVMXC__service_order__c.getRecordTypeInfosByName().get('SS-Mobilize').getRecordTypeId();
        id cslrtid = Schema.SObjectType.SVMXC__Service_Order_Line__c.getRecordTypeInfosByName().get('Tools').getRecordTypeId();
        Id LocRecid = Schema.SObjectType.SVMXC__Site__c.getRecordTypeInfosByName().get('Field').getRecordTypeId();
        Id wdlrtid = Schema.SObjectType.SVMXC__Service_Order_Line__c.getRecordTypeInfosByName().get('Tools').getRecordTypeId();
        Id wortid = Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('SS-Trip').getRecordTypeId();
        Id FSPid = Schema.SObjectType.GE_SS_Project__c.getRecordTypeInfosByName().get('SS Project').getRecordTypeId();
        Id AccRecId=Schema.SObjectType.Account.getRecordTypeInfosByName().get('CMF Approved').getRecordTypeId();
        test.starttest();
        
        Account acc = new Account(Name = 'SVMX Test Account', Type='Direct Customer',RecordTypeId=AccRecId,  Classification__c = 'Key Account');
        insert acc;
        System.assertEquals(acc.Name,'SVMX Test Account');
        
        //project region
        GE_SS_Project_Region__c recPG = new GE_SS_Project_Region__c(
        Name= 'India',
        //CurrencyIsoCode = 'ISO',
        GE_SS_Assignment_Group__c = 'richa.chauhan@ge.com',Active__c=true);
        
        insert recPG;
        
        //project region
        GE_SS_Project_Region__c recPG1 = new GE_SS_Project_Region__c(
        Name= 'USA',
        //CurrencyIsoCode = 'ISO',
        GE_SS_Assignment_Group__c = 'richa.chauhan@ge.com', Active__c=true);
        
        insert recPG1;
        
        //fs project
        GE_SS_Project__c recFSProject = new GE_SS_Project__c(
        GE_SS_Account__c = acc.id,
        GE_SS_Project_Region__c = recPG.id, RecordTypeId = FSPid);
        insert recFSProject;
        
        recFSProject.GE_SS_Project_Region__c = recPG1.id;
        Update recFSProject;
        
        Product2 prod = new Product2(Name='Test Prod',
                                    ProductCode = '1234');
        insert prod;
    
        SVMXC__Installed_Product__c ib = new SVMXC__Installed_Product__c(
                                    Name = 'TestIB',
                                    SVMXC__Product__c = prod.id,
                                    GE_AL_Installed_Product_Type__c  = 'Tools');
        insert ib;
    
         SVMXC__Site__c loc = new SVMXC__Site__c(RecordTypeId = LocRecid,
                                GE_SS_Project_Region__c = 'LAM',
                                Name = 'Test Field Loc',
                                SVMXC__Latitude__c = 37.662533,
                                SVMXC__Longitude__c = 121.874730,
                                Management_Country__c = 'Aruba');
                        insert loc;
            
        GE_SS_Project_Region__c pr = new GE_SS_Project_Region__c(
        Name = 'APAA',Active__c=true,GE_SS_Assignment_Group__c ='test@ge.com'); 
            
        insert pr;
    
        SVMXC__service_order__c cs = new SVMXC__service_order__c(RecordTypeId = csrtid,
                            SVMXC__Order_Status__c = 'New',
                            SVMXC__Component__c = ib.id,        //lookup to IB 
                            SVMXC__Product__c = prod.id,
                            GE_SS_No_of_Completions_Personnel__c = 2,
                            GE_SS_No_of_Controls_Personnel__c = 2,
                            GE_SS_Field__c = loc.id,
                            //GE_SS_FS_Project__c = recFSProject.id
                            GE_SS_Project__c = recFSProject.id,
                            Management_Country__c = 'India',
                            GE_SS_Project_Region__c = pr.id
                            );       //lookup to Product
        insert cs;
        System.Debug('****Project Region ****' +pr.id);
        SVMXC__service_order__c tcs = new SVMXC__service_order__c(RecordTypeId = wortid,
                            SVMXC__Order_Status__c = 'New',
                            SVMXC__Component__c = ib.id,        //lookup to IB 
                            //SVMXC__Product__c = prod.id,
                           //GE_SS_No_of_Completions_Personnel__c = 2,
                           // GE_SS_No_of_Controls_Personnel__c = 2,
                            GE_SS_Field__c = loc.id,
                            GE_SS_Project__c = recFSProject.id,
                           // GE_SS_Project_Region__c = pr.id,
                            Management_Country__c = 'India',
                            GE_SS_No_of_Drilling_Personnel__c = 3,
                            
                            GE_SS_Parent_Work_Order__c = cs.id);//Commented as part of R-26370 GE_SS_Assignment_Group__c ='test@ge.com',
        insert tcs;         


        GE_SS_Service_Ticket__c st = new GE_SS_Service_Ticket__c(
        GE_SS_Work_Order__c = cs.id,
        GE_SS_Project_Region__c = pr.id,
        Management_Country__c = 'India',
        GE_SS_Field__c = loc.id
        );
        
        insert st;
    
        GE_SS_Field_Problem__c recFieldProblem = new GE_SS_Field_Problem__c(
        GE_SS_Mobilize_Work_Order__c = cs.id,
        GE_SS_Work_Order__c = cs.id,
        GE_SS_Type_of_Field_Problem__c = 'Minor');
        
        insert recFieldProblem;
        
      //  UpdateFSProjectMethod1(recFSProject.id, recPG1.id);
        
        GE_SS_Project__c tmpFSProject = ([select GE_SS_Project_Region__c, RecordTypeId from GE_SS_Project__c where id =: recFSProject.id]);
        
        SVMXC__service_order__c tmpWO = ([Select id, recordtype.name, RecordTypeId, GE_SM_HQ_Record_Type_Name__c from SVMXC__service_order__c where id =: cs.id]);
        //SVMXC__Service_Order__c svo = ([Select id,GE_SS_Project__c,Management_Country__c,GE_SS_Project_Region__c,GE_SS_Field__c, (Select id,GE_SS_Project__c, GE_SS_Project_region__c, Management_Country__c, GE_SS_Field__c FROM Work_Orders__r), (Select id, GE_SS_Project_region__c, Management_Country__c, GE_SS_Field__c FROM Service_Tickets__r) from SVMXC__Service_Order__c where GE_SM_HQ_Record_Type_Name__c = 'SS-Mobilize' Limit 1]);
        system.debug('tmpWO--->' + tmpWO);
        
        tmpFSProject.GE_SS_Project_Region__c = recPG1.id;
        
        update tmpFSProject;
        //tmpFSProject.
        tmpFSProject.GE_SS_Project_Region__c = recPG.id;
        
        system.debug('test class-->' + tmpFSProject);
        system.debug('test class recordtype ..cs--->' + cs.GE_SM_HQ_Record_Type_Name__c);
        
        update tmpFSProject;
        
        test.stoptest();
    }
    
   //  public testmethod static void UpdateFSProjectMethod1(Id recFSProjectid, Id recPG1id)
   //  {
   //     tmpFSProject = ([select GE_SS_Project_Region__c from GE_SS_Project__c where id =: recFSProjectid]);
   //     tmpFSProject.GE_SS_Project_Region__c = recPG1id;
        
  //      update tmpFSProject;
   //  }
}