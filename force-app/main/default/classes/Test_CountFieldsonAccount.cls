@isTest
public class Test_CountFieldsonAccount{
    public static testMethod void testMethod1()
    {
        String strRecordTypeId = [Select Id From RecordType Where SobjectType = 'Account' and Name = 'CMF Approved' LIMIT 1].Id;
        String strRecordTypeParentId = [Select Id From RecordType Where SobjectType = 'Account' and Name = 'Relationship Account' LIMIT 1].Id;
        
        Account hqAccount = new Account(name='regionalParent',type='Direct Customer', Classification__c = 'Strategic',Account_Tier_GEOG__c='Global',RecordTypeId=strRecordTypeParentId,Compliance_Ready__c=true);
        insert hqAccount;
        
        Account regionalAccount = new Account(name='regionalParent', type='Direct Customer', Classification__c = 'Strategic',Account_Tier_GEOG__c='Regional',RecordTypeId=strRecordTypeParentId,parentId=hqAccount.id,Compliance_Ready__c=true);
        insert regionalAccount;
        
        test.StartTest();
        CountContactsCasesActivityOnAccountBatch btch =  new CountContactsCasesActivityOnAccountBatch();
        Database.executeBatch(btch);
        test.StopTest();
        
    }

    
    public static testMethod void testMethod2()
    {
        Test.StartTest();
        CountFieldsonAccountBatchScheduler sh1 = new CountFieldsonAccountBatchScheduler();

        String sch = '0 0 23 * * ?'; 
        system.schedule('Test Territory Check', sch, sh1); 
        
        Test.stopTest(); 
    }
    
    public static testMethod void testMethod3()
    {
         String strRecordTypeParentId = [Select Id From RecordType Where SobjectType = 'Account' and Name = 'Relationship Account' LIMIT 1].Id;
        
        Account hqAccount = new Account(name='regionalParent',type='Direct Customer', Classification__c = 'Strategic',Account_Tier_GEOG__c='Global',RecordTypeId=strRecordTypeParentId,Compliance_Ready__c=true);
        insert hqAccount;
        
        Contact cont1 = new Contact();
        cont1.GE_OG_Contact_Audience__c='Customer Care';
        cont1.LastName = 'Test';
        cont1.FirstName = 'Test';
        cont1.Phone = '98745632145';
        cont1.Email = 'test@te1st1298.com';
        cont1.GE_PRM_Primary_Contact__c = True;
        cont1.AccountId = hqAccount.Id;
        insert cont1;
        
        test.StartTest();
        CountContactsCasesActivityOnAccountBatch btch =  new CountContactsCasesActivityOnAccountBatch();
        Database.executeBatch(btch);
        test.StopTest();
        
    
    }
    
    
    }