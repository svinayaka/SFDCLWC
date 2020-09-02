@isTest(seeAlldata=true)
public class Test_GE_Case_Trasbin {
    static testMethod void Test_GE_Case_Trasbin_DS_CSR() {
        Id r= Schema.SObjectType.Case.getRecordTypeInfosByName().get('MCS - CS').getRecordTypeId();
        Account acc = [select Id, Name from Account where name = 'TestClassAccount'];
        
        //Inserting a new Case
        Case csobj=new Case();
        csobj.Subject='Email';
        csobj.Status='Open';
        csobj.Origin='Email';
        csobj.OwnerId=UserInfo.getUserId();
        csobj.type='Customer Service';
        csobj.GE_ES_Sub_Type__c='Technical Support Request';
        csobj.recordtypeid = r;
        csobj.accountid=acc.Id;
        
        insert csobj;
        System.assertEquals(csobj.Origin,'Email'); 
        
        test.startTest();
        Group grp = new Group(Name='ssr',Type='Queue');
        insert grp;
        
        QueueSobject mappingObject = new QueueSobject(QueueId = grp.Id, SobjectType = 'Case');
        System.runAs(new User(Id = UserInfo.getUserId())) {
            insert mappingObject;
        }
        
        csObj.OwnerId = grp.Id;
        GE_Case_Trasbin trsash=new GE_Case_Trasbin();
        GE_Case_Trasbin.TrashBin(csObj.id);
        
        Id rtds= Schema.SObjectType.Case.getRecordTypeInfosByName().get('DS - CSR').getRecordTypeId();
        csobj.recordtypeid = rtds;
        GE_Case_Trasbin.TrashBin(csObj.id);
        test.stopTest();
    }
static testMethod void Test_GE_Case_Trasbin_DRL_FDR() {
        Id r= Schema.SObjectType.Case.getRecordTypeInfosByName().get('MCS - CS').getRecordTypeId();
        Account acc = [select Id, Name from Account where name = 'TestClassAccount'];
        
        //Inserting a new Case
        Case csobj=new Case();
        csobj.Subject='Email';
        csobj.Status='Open';
        csobj.Origin='Email';
        csobj.OwnerId=UserInfo.getUserId();
        csobj.type='Customer Service';
        csobj.GE_ES_Sub_Type__c='Technical Support Request';
        csobj.recordtypeid = r;
        csobj.accountid=acc.Id;
        
        insert csobj;
        System.assertEquals(csobj.Origin,'Email'); 
        
        test.startTest();
        Group grp = new Group(Name='ssr',Type='Queue');
        insert grp;
        
        QueueSobject mappingObject = new QueueSobject(QueueId = grp.Id, SobjectType = 'Case');
        System.runAs(new User(Id = UserInfo.getUserId())) {
            insert mappingObject;
        }
        
        csObj.OwnerId = grp.Id;
        GE_Case_Trasbin trsash=new GE_Case_Trasbin();
        GE_Case_Trasbin.TrashBin(csObj.id);

        //Id rtds1= Schema.SObjectType.Case.getRecordTypeInfosByName().get('DRL - FDR').getRecordTypeId();
       // csobj.recordtypeid = rtds1;
       // GE_Case_Trasbin.TrashBin(csObj.id);
        test.stopTest();
    }    
}