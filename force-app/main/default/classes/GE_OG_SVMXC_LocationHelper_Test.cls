@isTest(SeeAllData=true)
public class GE_OG_SVMXC_LocationHelper_Test{
    static testmethod void test()
    { 
    Test.StartTest();  
    SVMXC__Site__c loc = new SVMXC__Site__c ();
    loc.name = 'Test Location';
    loc.GE_AL_Well_Type__c = 'Sour Service';
    loc.SVMXC__Country__c = 'United States';
    insert loc;
    
    loc.SVMXC__Country__c = 'Kuwait';
    update loc;
    test.stopTest();  
    }
    static testmethod void test1()
    { 
    Test.StartTest();  
    SVMXC__Site__c loc1 = new SVMXC__Site__c ();
    loc1.name = 'Test Location1';
    loc1.GE_AL_Well_Type__c = 'Sour Service';
    loc1.SVMXC__Country__c = 'United States';
    loc1.GE_DTS__c = true;
    insert loc1;
    
    loc1.SVMXC__Country__c = 'Kuwait';
    update loc1;
    test.stopTest();  
    }
 }