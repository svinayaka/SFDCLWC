@isTest(SeeAllData=true)
public class GE_OG_WOQueueassignment_Test{
    
    public static testMethod void TestQueueassignment1() {
    
Test.StartTest();
    SVMXC__Skill__c skill=new SVMXC__Skill__c();
    insert skill;
//Rectype=Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('MCS').getRecordTypeId();
    RecordType Rectype= [SELECT Id,Name FROM RecordType WHERE Name='MCS' and isActive=true and sObjectType='SVMXC__Service_Order__c' limit 1];
    SVMXC__Service_Order__c Wrk_Order=new SVMXC__Service_Order__c();
    Wrk_Order.RecordTypeId=Rectype.ID;
    Wrk_Order.SVMXC__Skill__c=skill.id;
    Wrk_Order.GE_OG_MC_Service_Region__c='Europe';
    Wrk_Order.GE_OG_MC_Business_Unit__c='BN';
    insert Wrk_Order;
    //RecordType Rectype= [SELECT Id,Name FROM RecordType WHERE Name='MCS' and isActive=true and sObjectType='SVMXC__Service_Order__c' limit 1];
    SVMXC__Service_Order__c Wrk_Order2=new SVMXC__Service_Order__c();
    Wrk_Order2.SVMXC__Skill__c=skill.id;
    Wrk_Order2.RecordTypeId=Rectype.ID;
    Wrk_Order2.GE_OG_MC_Service_Region__c='India';
    Wrk_Order2.GE_OG_MC_Business_Unit__c='BN';
    Wrk_Order2.SVMXC__Order_Status__c='Dispatched';
    insert Wrk_Order2;
    
    SVMXC__Service_Order__c Wrk_Order3=new SVMXC__Service_Order__c();
    Wrk_Order3.SVMXC__Skill__c=skill.id;
    Wrk_Order3.RecordTypeId=Rectype.ID;
    Wrk_Order3.GE_OG_MC_Service_Region__c='Asia';
    Wrk_Order3.GE_OG_MC_Business_Unit__c='BN';
    insert Wrk_Order3;
    
    SVMXC__Service_Order__c Wrk_Order4=new SVMXC__Service_Order__c();
    Wrk_Order4.SVMXC__Skill__c=skill.id;
    Wrk_Order4.RecordTypeId=Rectype.ID;
    Wrk_Order4.GE_OG_MC_Service_Region__c='Middle East Africa';
    Wrk_Order4.GE_OG_MC_Business_Unit__c='BN';
    insert Wrk_Order4;
    
    SVMXC__Service_Order__c Wrk_Order5=new SVMXC__Service_Order__c();
    Wrk_Order5.SVMXC__Skill__c=skill.id;
    Wrk_Order5.RecordTypeId=Rectype.ID;
    Wrk_Order5.GE_OG_MC_Service_Region__c='China';
    Wrk_Order5.GE_OG_MC_Business_Unit__c='BN';
    insert Wrk_Order5;
    Test.StopTest();
  }
  public static testMethod void TestQueueassignment11() {
    SVMXC__Skill__c skill=new SVMXC__Skill__c();
    insert skill;
Test.StartTest();
  RecordType Rectype= [SELECT Id,Name FROM RecordType WHERE Name='MCS' and isActive=true and sObjectType='SVMXC__Service_Order__c' limit 1];  
    SVMXC__Service_Order__c Wrk_Order6=new SVMXC__Service_Order__c();
    Wrk_Order6.SVMXC__Skill__c=skill.id;
    Wrk_Order6.RecordTypeId=Rectype.ID;
    Wrk_Order6.GE_OG_MC_Service_Region__c='Latin America';
    Wrk_Order6.GE_OG_MC_Business_Unit__c='BN';
    insert Wrk_Order6;
   
    SVMXC__Service_Order__c Wrk_Order7=new SVMXC__Service_Order__c();
    Wrk_Order7.SVMXC__Skill__c=skill.id;
    Wrk_Order7.RecordTypeId=Rectype.ID;
    Wrk_Order7.GE_OG_MC_Service_Region__c='North America';
    Wrk_Order7.GE_OG_MC_Business_Unit__c='BN';
    insert Wrk_Order7;
  
    SVMXC__Service_Order__c Wrk_Order8=new SVMXC__Service_Order__c();
    Wrk_Order8.SVMXC__Skill__c=skill.id;
    Wrk_Order8.RecordTypeId=Rectype.ID;
    Wrk_Order8.GE_OG_MC_Service_Region__c='Australia';
    Wrk_Order8.GE_OG_MC_Business_Unit__c='BN';
    insert Wrk_Order8;

    SVMXC__Service_Order__c Wrk_Order9=new SVMXC__Service_Order__c();
    Wrk_Order9.SVMXC__Skill__c=skill.id;
    Wrk_Order9.RecordTypeId=Rectype.ID;
    Wrk_Order9.GE_OG_MC_Service_Region__c='Canada';
    Wrk_Order9.GE_OG_MC_Business_Unit__c='BN';
    insert Wrk_Order9;


Test.Stoptest();


}
public static testMethod void TestQueueassignment2() {
    
    SVMXC__Skill__c skill=new SVMXC__Skill__c();
    insert skill;
    Test.StartTest();
    //ID Rectype=Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('MCS').getRecordTypeId();
    RecordType Rectype= [SELECT Id,Name FROM RecordType WHERE Name='MCS' and isActive=true and sObjectType='SVMXC__Service_Order__c' limit 1];
    SVMXC__Service_Order__c Wrk_Order=new SVMXC__Service_Order__c();
    Wrk_Order.SVMXC__Skill__c=skill.id;
    Wrk_Order.RecordTypeId=Rectype.ID;
    Wrk_Order.GE_OG_MC_Service_Region__c='Europe';
    Wrk_Order.GE_OG_MC_Business_Unit__c='BN';
    insert Wrk_Order;


//SVMXC__Service_Order__c Wrk_Order=new SVMXC__Service_Order__c();
Wrk_Order.GE_OG_MC_Service_Region__c='Europe';
    Wrk_Order.GE_OG_MC_Business_Unit__c='BN';
    //Wrk_Order.RecordTypeId=Rectype.ID;
    update Wrk_Order;
    Wrk_Order.GE_OG_MC_Service_Region__c='Asia';
    Wrk_Order.GE_OG_MC_Business_Unit__c='BN';
    //Wrk_Order.RecordTypeId=Rectype.ID;
    update Wrk_Order;
    Wrk_Order.GE_OG_MC_Service_Region__c='India';
    Wrk_Order.GE_OG_MC_Business_Unit__c='BN';
    //Wrk_Order.RecordTypeId=Rectype.ID;
    update Wrk_Order;
    Wrk_Order.GE_OG_MC_Service_Region__c='Latin America';
    Wrk_Order.GE_OG_MC_Business_Unit__c='BN';
    //Wrk_Order.RecordTypeId=Rectype.ID;
    update Wrk_Order;
    Wrk_Order.GE_OG_MC_Service_Region__c='North America';
    Wrk_Order.GE_OG_MC_Business_Unit__c='BN';
    //Wrk_Order.RecordTypeId=Rectype.ID;
    update Wrk_Order;
    Wrk_Order.GE_OG_MC_Service_Region__c='China';
    Wrk_Order.GE_OG_MC_Business_Unit__c='BN';
    //Wrk_Order.RecordTypeId=Rectype.ID;
    update Wrk_Order;
    Wrk_Order.GE_OG_MC_Service_Region__c='Middle East Africa';
    Wrk_Order.GE_OG_MC_Business_Unit__c='BN';
    //Wrk_Order.RecordTypeId=Rectype.ID;
    update Wrk_Order;
    Wrk_Order.GE_OG_MC_Service_Region__c='Australia';
    Wrk_Order.GE_OG_MC_Business_Unit__c='BN';
    //Wrk_Order.RecordTypeId=Rectype.ID;
    update Wrk_Order;
    Wrk_Order.GE_OG_MC_Service_Region__c='Canada';
    Wrk_Order.GE_OG_MC_Business_Unit__c='BN';
    //Wrk_Order.RecordTypeId=Rectype.ID;
    update Wrk_Order;
   Test.Stoptest();
} 
public static testMethod void TestQueueassignment3() {
    SVMXC__Skill__c skill=new SVMXC__Skill__c();
    insert skill;
Test.StartTest();
//Rectype=Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('MCS').getRecordTypeId();
    RecordType Rectype= [SELECT Id,Name FROM RecordType WHERE Name='MCS' and isActive=true and sObjectType='SVMXC__Service_Order__c' limit 1];
    SVMXC__Service_Order__c Wrk_Order=new SVMXC__Service_Order__c();
    Wrk_Order.RecordTypeId=Rectype.ID;
    Wrk_Order.GE_OG_MC_Service_Region__c='Europe';
    Wrk_Order.GE_OG_MC_Business_Unit__c='CS';
    Wrk_Order.SVMXC__Skill__c=skill.id;
    insert Wrk_Order;
    //RecordType Rectype= [SELECT Id,Name FROM RecordType WHERE Name='MCS' and isActive=true and sObjectType='SVMXC__Service_Order__c' limit 1];
    SVMXC__Service_Order__c Wrk_Order2=new SVMXC__Service_Order__c();
    Wrk_Order2.RecordTypeId=Rectype.ID;
    Wrk_Order2.GE_OG_MC_Service_Region__c='India';
    Wrk_Order2.GE_OG_MC_Business_Unit__c='CS';
    Wrk_Order2.SVMXC__Skill__c=skill.id;
    insert Wrk_Order2;
    
    SVMXC__Service_Order__c Wrk_Order3=new SVMXC__Service_Order__c();
    Wrk_Order3.RecordTypeId=Rectype.ID;
    Wrk_Order3.GE_OG_MC_Service_Region__c='Asia';
    Wrk_Order3.GE_OG_MC_Business_Unit__c='CS';
    Wrk_Order3.SVMXC__Skill__c=skill.id;
    insert Wrk_Order3;
    
    SVMXC__Service_Order__c Wrk_Order4=new SVMXC__Service_Order__c();
    Wrk_Order4.RecordTypeId=Rectype.ID;
    Wrk_Order4.GE_OG_MC_Service_Region__c='Middle East Africa';
    Wrk_Order4.GE_OG_MC_Business_Unit__c='CS';
    Wrk_Order4.SVMXC__Skill__c=skill.id;
    insert Wrk_Order4;
    
    SVMXC__Service_Order__c Wrk_Order5=new SVMXC__Service_Order__c();
    Wrk_Order5.RecordTypeId=Rectype.ID;
    Wrk_Order5.GE_OG_MC_Service_Region__c='China';
    Wrk_Order5.GE_OG_MC_Business_Unit__c='CS';
    Wrk_Order5.SVMXC__Skill__c=skill.id;
    insert Wrk_Order5;
   Test.StopTest();
  }
  public static testMethod void TestQueueassignment12() {
    SVMXC__Skill__c skill=new SVMXC__Skill__c();
    insert skill;
Test.StartTest();
RecordType Rectype= [SELECT Id,Name FROM RecordType WHERE Name='MCS' and isActive=true and sObjectType='SVMXC__Service_Order__c' limit 1];
    SVMXC__Service_Order__c Wrk_Order6=new SVMXC__Service_Order__c();
    Wrk_Order6.RecordTypeId=Rectype.ID;
    Wrk_Order6.GE_OG_MC_Service_Region__c='Latin America';
    Wrk_Order6.GE_OG_MC_Business_Unit__c='CS';
    Wrk_Order6.SVMXC__Skill__c=skill.id;
    insert Wrk_Order6;
    
    SVMXC__Service_Order__c Wrk_Order7=new SVMXC__Service_Order__c();
    Wrk_Order7.RecordTypeId=Rectype.ID;
    Wrk_Order7.GE_OG_MC_Service_Region__c='North America';
    Wrk_Order7.GE_OG_MC_Business_Unit__c='CS';
    Wrk_Order7.SVMXC__Skill__c=skill.id;
    insert Wrk_Order7;
   
    SVMXC__Service_Order__c Wrk_Order8=new SVMXC__Service_Order__c();
    Wrk_Order8.RecordTypeId=Rectype.ID;
    Wrk_Order8.GE_OG_MC_Service_Region__c='Australia';
    Wrk_Order8.GE_OG_MC_Business_Unit__c='CS';
    Wrk_Order8.SVMXC__Skill__c=skill.id;
    insert Wrk_Order8;

    SVMXC__Service_Order__c Wrk_Order9=new SVMXC__Service_Order__c();
    Wrk_Order9.RecordTypeId=Rectype.ID;
    Wrk_Order9.GE_OG_MC_Service_Region__c='Canada';
    Wrk_Order9.GE_OG_MC_Business_Unit__c='CS';
    Wrk_Order9.SVMXC__Skill__c=skill.id;
    insert Wrk_Order9;


Test.Stoptest();


}
public static testMethod void TestQueueassignment4() {
    SVMXC__Skill__c skill=new SVMXC__Skill__c();
    insert skill;
    Test.StartTest();
    //ID Rectype=Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('MCS').getRecordTypeId();
    RecordType Rectype= [SELECT Id,Name FROM RecordType WHERE Name='MCS' and isActive=true and sObjectType='SVMXC__Service_Order__c' limit 1];
SVMXC__Service_Order__c Wrk_Order=new SVMXC__Service_Order__c();
    Wrk_Order.RecordTypeId=Rectype.ID;
    Wrk_Order.SVMXC__Skill__c=skill.id;
    Wrk_Order.GE_OG_MC_Service_Region__c='Europe';
    Wrk_Order.GE_OG_MC_Business_Unit__c='CS';
    Wrk_Order.SVMXC__Order_Status__c='Dispatched';
    Wrk_Order.GE_PC_Safety_Answer__c = '4-Exceeded Expectations (Provided more than what was required)';
    insert Wrk_Order;


//SVMXC__Service_Order__c Wrk_Order=new SVMXC__Service_Order__c();
Wrk_Order.GE_OG_MC_Service_Region__c='Europe';
    Wrk_Order.GE_OG_MC_Business_Unit__c='CS';
    Wrk_Order.GE_PC_Safety_Answer__c = '5-Superior (Established new quality performance standards)';
    Wrk_Order.SVMXC__Order_Status__c='Work Complete';
    //Wrk_Order.RecordTypeId=Rectype.ID;
    update Wrk_Order;
    Wrk_Order.GE_OG_MC_Service_Region__c='Asia';
    Wrk_Order.GE_OG_MC_Business_Unit__c='CS';
    //Wrk_Order.RecordTypeId=Rectype.ID;
    update Wrk_Order;
    Wrk_Order.GE_OG_MC_Service_Region__c='India';
    Wrk_Order.GE_OG_MC_Business_Unit__c='CS';
    //Wrk_Order.RecordTypeId=Rectype.ID;
    update Wrk_Order;
    Wrk_Order.GE_OG_MC_Service_Region__c='Latin America';
    Wrk_Order.GE_OG_MC_Business_Unit__c='CS';
    //Wrk_Order.RecordTypeId=Rectype.ID;
    update Wrk_Order;
    Wrk_Order.GE_OG_MC_Service_Region__c='North America';
    Wrk_Order.GE_OG_MC_Business_Unit__c='CS';
    //Wrk_Order.RecordTypeId=Rectype.ID;
    update Wrk_Order;
    Wrk_Order.GE_OG_MC_Service_Region__c='China';
    Wrk_Order.GE_OG_MC_Business_Unit__c='CS';
    //Wrk_Order.RecordTypeId=Rectype.ID;
    update Wrk_Order;
    Wrk_Order.GE_OG_MC_Service_Region__c='Middle East Africa';
    Wrk_Order.GE_OG_MC_Business_Unit__c='CS';
    //Wrk_Order.RecordTypeId=Rectype.ID;
    update Wrk_Order;
    Wrk_Order.GE_OG_MC_Service_Region__c='Australia';
    Wrk_Order.GE_OG_MC_Business_Unit__c='CS';
    //Wrk_Order.RecordTypeId=Rectype.ID;
    update Wrk_Order;
    Wrk_Order.GE_OG_MC_Service_Region__c='Canada';
    Wrk_Order.GE_OG_MC_Business_Unit__c='CS';
    //Wrk_Order.RecordTypeId=Rectype.ID;
    update Wrk_Order;
   Test.Stoptest();
} 
public static testMethod void TestQueueassignment5() {
    SVMXC__Skill__c skill=new SVMXC__Skill__c();
    insert skill;
Test.StartTest();
//Rectype=Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('MCS').getRecordTypeId();
    RecordType Rectype= [SELECT Id,Name FROM RecordType WHERE Name='MCS' and isActive=true and sObjectType='SVMXC__Service_Order__c' limit 1];
    SVMXC__Service_Order__c Wrk_Order=new SVMXC__Service_Order__c();
    Wrk_Order.RecordTypeId=Rectype.ID;
    Wrk_Order.SVMXC__Skill__c=skill.id;
    Wrk_Order.GE_OG_MC_Service_Region__c='Europe';
    Wrk_Order.GE_OG_MC_Business_Unit__c='MS';
    insert Wrk_Order;
    //RecordType Rectype= [SELECT Id,Name FROM RecordType WHERE Name='MCS' and isActive=true and sObjectType='SVMXC__Service_Order__c' limit 1];
   SVMXC__Service_Order__c Wrk_Order2=new SVMXC__Service_Order__c();
    Wrk_Order2.RecordTypeId=Rectype.ID;
    Wrk_Order2.SVMXC__Skill__c=skill.id;
    Wrk_Order2.GE_OG_MC_Service_Region__c='India';
    Wrk_Order2.GE_OG_MC_Business_Unit__c='MS';
    insert Wrk_Order2;
    
    SVMXC__Service_Order__c Wrk_Order3=new SVMXC__Service_Order__c();
    Wrk_Order3.RecordTypeId=Rectype.ID;
    Wrk_Order3.SVMXC__Skill__c=skill.id;
    Wrk_Order3.GE_OG_MC_Service_Region__c='Asia';
    Wrk_Order3.GE_OG_MC_Business_Unit__c='MS';
    insert Wrk_Order3;
    
    SVMXC__Service_Order__c Wrk_Order4=new SVMXC__Service_Order__c();
    Wrk_Order4.RecordTypeId=Rectype.ID;
    Wrk_Order4.SVMXC__Skill__c=skill.id;
    Wrk_Order4.GE_OG_MC_Service_Region__c='Middle East Africa';
    Wrk_Order4.GE_OG_MC_Business_Unit__c='MS';
    insert Wrk_Order4;
    
    SVMXC__Service_Order__c Wrk_Order5=new SVMXC__Service_Order__c();
    Wrk_Order5.RecordTypeId=Rectype.ID;
    Wrk_Order5.SVMXC__Skill__c=skill.id;
    Wrk_Order5.GE_OG_MC_Service_Region__c='China';
    Wrk_Order5.GE_OG_MC_Business_Unit__c='MS';
    insert Wrk_Order5;
    Test.StopTest();
  }
  public static testMethod void TestQueueassignment10() {
    SVMXC__Skill__c skill=new SVMXC__Skill__c();
    insert skill;
Test.StartTest();
//Rectype=Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('MCS').getRecordTypeId();
    RecordType Rectype= [SELECT Id,Name FROM RecordType WHERE Name='MCS' and isActive=true and sObjectType='SVMXC__Service_Order__c' limit 1];  
    SVMXC__Service_Order__c Wrk_Order6=new SVMXC__Service_Order__c();
    Wrk_Order6.RecordTypeId=Rectype.ID;
    Wrk_Order6.SVMXC__Skill__c=skill.id;
    Wrk_Order6.GE_OG_MC_Service_Region__c='Latin America';
    Wrk_Order6.GE_OG_MC_Business_Unit__c='MS';
    insert Wrk_Order6;
    
    SVMXC__Service_Order__c Wrk_Order7=new SVMXC__Service_Order__c();
    Wrk_Order7.RecordTypeId=Rectype.ID;
    Wrk_Order7.SVMXC__Skill__c=skill.id;
    Wrk_Order7.GE_OG_MC_Service_Region__c='North America';
    Wrk_Order7.GE_OG_MC_Business_Unit__c='MS';
    insert Wrk_Order7;
   
    SVMXC__Service_Order__c Wrk_Order8=new SVMXC__Service_Order__c();
    Wrk_Order8.RecordTypeId=Rectype.ID;
    Wrk_Order8.SVMXC__Skill__c=skill.id;
    Wrk_Order8.GE_OG_MC_Service_Region__c='Australia';
    Wrk_Order8.GE_OG_MC_Business_Unit__c='MS';
    insert Wrk_Order8;

    SVMXC__Service_Order__c Wrk_Order9=new SVMXC__Service_Order__c();
    Wrk_Order9.RecordTypeId=Rectype.ID;
    Wrk_Order9.SVMXC__Skill__c=skill.id;
    Wrk_Order9.GE_OG_MC_Service_Region__c='Canada';
    Wrk_Order9.GE_OG_MC_Business_Unit__c='MS';
    insert Wrk_Order9;


Test.Stoptest();


}
public static testMethod void TestQueueassignment6() {
    SVMXC__Skill__c skill=new SVMXC__Skill__c();
    insert skill;
    Test.StartTest();
    //ID Rectype=Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('MCS').getRecordTypeId();
    RecordType Rectype= [SELECT Id,Name FROM RecordType WHERE Name='MCS' and isActive=true and sObjectType='SVMXC__Service_Order__c' limit 1];

SVMXC__Service_Order__c Wrk_Order=new SVMXC__Service_Order__c();
    Wrk_Order.RecordTypeId=Rectype.ID;
    Wrk_Order.SVMXC__Skill__c=skill.id;
    Wrk_Order.GE_OG_MC_Service_Region__c='Canada';
    Wrk_Order.GE_OG_MC_Business_Unit__c='MS';
    insert Wrk_Order;

    
    //SVMXC__Service_Order__c Wrk_Order=new SVMXC__Service_Order__c();
    //Wrk_Order.RecordTypeId=Rectype.ID;
    Wrk_Order.GE_OG_MC_Service_Region__c='Europe';
    Wrk_Order.GE_OG_MC_Business_Unit__c='MS';
        update Wrk_Order;
        
   Wrk_Order.GE_OG_MC_Service_Region__c='North America';
    Wrk_Order.GE_OG_MC_Business_Unit__c='MS';
    //Wrk_Order.RecordTypeId=Rectype.ID;
    update Wrk_Order;
    Wrk_Order.GE_OG_MC_Service_Region__c='Asia';
    Wrk_Order.GE_OG_MC_Business_Unit__c='MS';
    //Wrk_Order.RecordTypeId=Rectype.ID;
    update Wrk_Order;
    Wrk_Order.GE_OG_MC_Service_Region__c='India';
    Wrk_Order.GE_OG_MC_Business_Unit__c='MS';
    //Wrk_Order.RecordTypeId=Rectype.ID;
    update Wrk_Order;
    Wrk_Order.GE_OG_MC_Service_Region__c='Latin America';
    Wrk_Order.GE_OG_MC_Business_Unit__c='MS';
    //Wrk_Order.RecordTypeId=Rectype.ID;
    update Wrk_Order;
    Wrk_Order.GE_OG_MC_Service_Region__c='China';
    Wrk_Order.GE_OG_MC_Business_Unit__c='MS';
    //Wrk_Order.RecordTypeId=Rectype.ID;
    update Wrk_Order;
    Wrk_Order.GE_OG_MC_Service_Region__c='Middle East Africa';
    Wrk_Order.GE_OG_MC_Business_Unit__c='MS';
    //Wrk_Order.RecordTypeId=Rectype.ID;
    update Wrk_Order;
    Wrk_Order.GE_OG_MC_Service_Region__c='Australia';
    Wrk_Order.GE_OG_MC_Business_Unit__c='MS';
    //Wrk_Order.RecordTypeId=Rectype.ID;
    update Wrk_Order;
    Wrk_Order.GE_OG_MC_Service_Region__c='Canada';
    Wrk_Order.GE_OG_MC_Business_Unit__c='MS';
    //Wrk_Order.RecordTypeId=Rectype.ID;
    update Wrk_Order;
test.stoptest();
}
public static testMethod void TestQueueassignment7() {
    SVMXC__Skill__c skill=new SVMXC__Skill__c();
    insert skill;
Test.StartTest();
//Rectype=Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('MCS').getRecordTypeId();
    RecordType Rectype= [SELECT Id,Name FROM RecordType WHERE Name='MCS' and isActive=true and sObjectType='SVMXC__Service_Order__c' limit 1];
    SVMXC__Service_Order__c Wrk_Order=new SVMXC__Service_Order__c();
    Wrk_Order.RecordTypeId=Rectype.ID;
    Wrk_Order.SVMXC__Skill__c=skill.id;
    Wrk_Order.GE_OG_MC_Service_Region__c='Europe';
    Wrk_Order.GE_OG_MC_Business_Unit__c='IT';
    insert Wrk_Order;
    //RecordType Rectype= [SELECT Id,Name FROM RecordType WHERE Name='MCS' and isActive=true and sObjectType='SVMXC__Service_Order__c' limit 1];
    SVMXC__Service_Order__c Wrk_Order2=new SVMXC__Service_Order__c();
    Wrk_Order2.RecordTypeId=Rectype.ID;
    Wrk_Order2.SVMXC__Skill__c=skill.id;
    Wrk_Order2.GE_OG_MC_Service_Region__c='India';
    Wrk_Order2.GE_OG_MC_Business_Unit__c='IT';
    insert Wrk_Order2;
    
    SVMXC__Service_Order__c Wrk_Order3=new SVMXC__Service_Order__c();
    Wrk_Order3.RecordTypeId=Rectype.ID;
    Wrk_Order3.SVMXC__Skill__c=skill.id;
    Wrk_Order3.GE_OG_MC_Service_Region__c='Asia';
    Wrk_Order3.GE_OG_MC_Business_Unit__c='IT';
    insert Wrk_Order3;
    
    SVMXC__Service_Order__c Wrk_Order4=new SVMXC__Service_Order__c();
    Wrk_Order4.RecordTypeId=Rectype.ID;
    Wrk_Order4.SVMXC__Skill__c=skill.id;
    Wrk_Order4.GE_OG_MC_Service_Region__c='Middle East Africa';
    Wrk_Order4.GE_OG_MC_Business_Unit__c='IT';
    insert Wrk_Order4;
    
    SVMXC__Service_Order__c Wrk_Order5=new SVMXC__Service_Order__c();
    Wrk_Order5.RecordTypeId=Rectype.ID;
    Wrk_Order5.SVMXC__Skill__c=skill.id;
    Wrk_Order5.GE_OG_MC_Service_Region__c='China';
    Wrk_Order5.GE_OG_MC_Business_Unit__c='IT';
    insert Wrk_Order5;
    Test.Stoptest();
    }
 public static testMethod void TestQueueassignment9() {
    SVMXC__Skill__c skill=new SVMXC__Skill__c();
    insert skill;
Test.StartTest();
//Rectype=Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('MCS').getRecordTypeId();
    RecordType Rectype= [SELECT Id,Name FROM RecordType WHERE Name='MCS' and isActive=true and sObjectType='SVMXC__Service_Order__c' limit 1];
    SVMXC__Service_Order__c Wrk_Order6=new SVMXC__Service_Order__c();
    Wrk_Order6.RecordTypeId=Rectype.ID;
    Wrk_Order6.SVMXC__Skill__c=skill.id;
    Wrk_Order6.GE_OG_MC_Service_Region__c='Latin America';
    Wrk_Order6.GE_OG_MC_Business_Unit__c='IT';
    insert Wrk_Order6;
    
    SVMXC__Service_Order__c Wrk_Order7=new SVMXC__Service_Order__c();
    Wrk_Order7.RecordTypeId=Rectype.ID;
    Wrk_Order7.SVMXC__Skill__c=skill.id;
    Wrk_Order7.GE_OG_MC_Service_Region__c='North America';
    Wrk_Order7.GE_OG_MC_Business_Unit__c='IT';
    insert Wrk_Order7;
   
    SVMXC__Service_Order__c Wrk_Order8=new SVMXC__Service_Order__c();
    Wrk_Order8.RecordTypeId=Rectype.ID;
    Wrk_Order8.SVMXC__Skill__c=skill.id;
    Wrk_Order8.GE_OG_MC_Service_Region__c='Australia';
    Wrk_Order8.GE_OG_MC_Business_Unit__c='IT';
    insert Wrk_Order8;

    SVMXC__Service_Order__c Wrk_Order9=new SVMXC__Service_Order__c();
    Wrk_Order9.RecordTypeId=Rectype.ID;
    Wrk_Order9.SVMXC__Skill__c=skill.id;
    Wrk_Order9.GE_OG_MC_Service_Region__c='Canada';
    Wrk_Order9.GE_OG_MC_Business_Unit__c='IT';
    insert Wrk_Order9;


Test.Stoptest();


}
public static testMethod void TestQueueassignment8() {
    SVMXC__Skill__c skill=new SVMXC__Skill__c();
    insert skill;
    Test.StartTest();
    //ID Rectype=Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('MCS').getRecordTypeId();
    RecordType Rectype= [SELECT Id,Name FROM RecordType WHERE Name='MCS' and isActive=true and sObjectType='SVMXC__Service_Order__c' limit 1];
SVMXC__Service_Order__c Wrk_Order=new SVMXC__Service_Order__c();
    Wrk_Order.RecordTypeId=Rectype.ID;
    Wrk_Order.SVMXC__Skill__c=skill.id;
    Wrk_Order.GE_OG_MC_Service_Region__c='Europe';
    Wrk_Order.GE_OG_MC_Business_Unit__c='IT';
    insert Wrk_Order;


//SVMXC__Service_Order__c Wrk_Order=new SVMXC__Service_Order__c();
Wrk_Order.GE_OG_MC_Service_Region__c='Europe';
    Wrk_Order.GE_OG_MC_Business_Unit__c='IT';
    //Wrk_Order.RecordTypeId=Rectype.ID;
    update Wrk_Order;
    Wrk_Order.GE_OG_MC_Service_Region__c='Asia';
    Wrk_Order.GE_OG_MC_Business_Unit__c='IT';
    //Wrk_Order.RecordTypeId=Rectype.ID;
    update Wrk_Order;
    Wrk_Order.GE_OG_MC_Service_Region__c='India';
    Wrk_Order.GE_OG_MC_Business_Unit__c='IT';
    //Wrk_Order.RecordTypeId=Rectype.ID;
    update Wrk_Order;
    Wrk_Order.GE_OG_MC_Service_Region__c='Latin America';
    Wrk_Order.GE_OG_MC_Business_Unit__c='IT';
    //Wrk_Order.RecordTypeId=Rectype.ID;
    update Wrk_Order;
    Wrk_Order.GE_OG_MC_Service_Region__c='North America';
    Wrk_Order.GE_OG_MC_Business_Unit__c='IT';
    //Wrk_Order.RecordTypeId=Rectype.ID;
    update Wrk_Order;
    Wrk_Order.GE_OG_MC_Service_Region__c='China';
    Wrk_Order.GE_OG_MC_Business_Unit__c='IT';
    //Wrk_Order.RecordTypeId=Rectype.ID;
    update Wrk_Order;
    Wrk_Order.GE_OG_MC_Service_Region__c='Middle East Africa';
    Wrk_Order.GE_OG_MC_Business_Unit__c='IT';
    //Wrk_Order.RecordTypeId=Rectype.ID;
    update Wrk_Order;
    Wrk_Order.GE_OG_MC_Service_Region__c='Australia';
    Wrk_Order.GE_OG_MC_Business_Unit__c='IT';
    //Wrk_Order.RecordTypeId=Rectype.ID;
    update Wrk_Order;
    Wrk_Order.GE_OG_MC_Service_Region__c='Canada';
    Wrk_Order.GE_OG_MC_Business_Unit__c='IT';
    //Wrk_Order.RecordTypeId=Rectype.ID;
    update Wrk_Order;
   Test.Stoptest();
}
public static testMethod void TestQueueassignment13() {
    SVMXC__Skill__c skill=new SVMXC__Skill__c();
    insert skill;
    Test.StartTest();
    //ID Rectype=Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('MCS').getRecordTypeId();
    RecordType Rectype= [SELECT Id,Name FROM RecordType WHERE Name='MCS' and isActive=true and sObjectType='SVMXC__Service_Order__c' limit 1];
SVMXC__Service_Order__c Wrk_Order=new SVMXC__Service_Order__c();
    Wrk_Order.RecordTypeId=Rectype.ID;
    Wrk_Order.SVMXC__Skill__c=skill.id;
    Wrk_Order.GE_OG_MC_Service_Region__c='Europe';
    Wrk_Order.GE_OG_MC_Business_Unit__c='F&PT';
    insert Wrk_Order;


//SVMXC__Service_Order__c Wrk_Order=new SVMXC__Service_Order__c();
Wrk_Order.GE_OG_MC_Service_Region__c='Europe';
    Wrk_Order.GE_OG_MC_Business_Unit__c='F&PT';
    //Wrk_Order.RecordTypeId=Rectype.ID;
    update Wrk_Order;
    Wrk_Order.GE_OG_MC_Service_Region__c='Asia';
    Wrk_Order.GE_OG_MC_Business_Unit__c='F&PT';
    //Wrk_Order.RecordTypeId=Rectype.ID;
    update Wrk_Order;
    Wrk_Order.GE_OG_MC_Service_Region__c='India';
    Wrk_Order.GE_OG_MC_Business_Unit__c='F&PT';
    //Wrk_Order.RecordTypeId=Rectype.ID;
    update Wrk_Order;
    Wrk_Order.GE_OG_MC_Service_Region__c='Latin America';
    Wrk_Order.GE_OG_MC_Business_Unit__c='F&PT';
    //Wrk_Order.RecordTypeId=Rectype.ID;
    update Wrk_Order;
    Wrk_Order.GE_OG_MC_Service_Region__c='North America';
    Wrk_Order.GE_OG_MC_Business_Unit__c='F&PT';
    //Wrk_Order.RecordTypeId=Rectype.ID;
    update Wrk_Order;
    Wrk_Order.GE_OG_MC_Service_Region__c='China';
    Wrk_Order.GE_OG_MC_Business_Unit__c='F&PT';
    //Wrk_Order.RecordTypeId=Rectype.ID;
    update Wrk_Order;
    Wrk_Order.GE_OG_MC_Service_Region__c='Middle East Africa';
    Wrk_Order.GE_OG_MC_Business_Unit__c='F&PT';
    //Wrk_Order.RecordTypeId=Rectype.ID;
    update Wrk_Order;
    Wrk_Order.GE_OG_MC_Service_Region__c='Australia';
    Wrk_Order.GE_OG_MC_Business_Unit__c='F&PT';
    //Wrk_Order.RecordTypeId=Rectype.ID;
    update Wrk_Order;
    Wrk_Order.GE_OG_MC_Service_Region__c='Canada';
    Wrk_Order.GE_OG_MC_Business_Unit__c='F&PT';
    //Wrk_Order.RecordTypeId=Rectype.ID;
    update Wrk_Order;
    delete Wrk_Order;
    undelete Wrk_Order;
   Test.Stoptest();
}

public static testMethod void TestWordDetailStatusUpdate() {

Id woRTId = Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('PC').getRecordTypeId();
//Insert Skill

        SVMXC__Skill__c skill=new SVMXC__Skill__c();
        skill.Name='Test Skill';
        insert skill;

//WorkOrder Insert
        SVMXC__Service_Order__c woObj = new SVMXC__Service_Order__c();        
        woObj.RecordTypeId=woRTId;
        woObj.SVMXC__Order_Status__c = 'Open';
        woObj.SVMXC__Skill__c=skill.Id;
        woObj.GE_PC_Branch__c='Cotulla';
        insert woObj;

Product2 prod=new Product2(Name='TestProd',ProductCode='TestProd',
                           //GE_ES_Bsn_Type__c='D&S',
GE_ES_P_L__c='D&S - PC',GE_ES_Sub_P_L__c='PC');
//GE_ES_P_L__c='D&S - PC',GE_ES_Sub_P_L__c='PC',GE_OG_SS_Product_Part_Description__c='Test');
insert prod;

SVMXC__Service_Order_Line__c part=new SVMXC__Service_Order_Line__c(SVMXC__Service_Order__c=woObj.id,
SVMXC__Line_Type__c='Parts',SVMXC__Line_Status__c='Open',SVMXC__Actual_Quantity2__c=1,
SVMXC__Actual_Price2__c=100,SVMXC__Product__c=prod.id);  
insert part;

Test.StartTest();

woObj.GE_PC_Branch__c='Cleburne';
update woObj;

woObj.SVMXC__Order_Status__c='Sent to Oracle';
update woObj;

woObj.SVMXC__Order_Status__c='Ready for Invoicing';
update woObj;

woObj.SVMXC__Order_Status__c='closed';
woObj.GE_PC_Oracle_FSO__c = '123';
update woObj;

Test.Stoptest();
}

public static testMethod void testWorkOrderLinesAfter() {
        
            Id LocRecid = Schema.SObjectType.SVMXC__Site__c.getRecordTypeInfosByName().get('Field').getRecordTypeId();
        
        // insert Site
    SVMXC__Site__c loc = new SVMXC__Site__c(RecordTypeId = LocRecid,
                                GE_SS_Project_Region__c = 'LAM',
                                Name = 'Test Field Loc',
                                SVMXC__Latitude__c = 37.662533,
                                SVMXC__Longitude__c = 121.874730,
                                Management_Country__c = 'Aruba');
                        insert loc;
        
        //Case with Location
        Id SSMobilize =  Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('SS-Mobilize').getRecordTypeId();
    

      //  SVMXC__Service_Order__c c = new SVMXC__Service_Order__c(RecordTypeId=SSMobilize);
        SVMXC__Service_Order__c c = new SVMXC__Service_Order__c(
                            RecordTypeId = SSMobilize,
                            //SVMXC__Company__c = acc.id,
                            //SVMXC__Case__c = cs.id,
                            SVMXC__Order_Status__c = 'Opened',
                            GE_SS_Field__c = loc.id,
                            SVMXC__Country__c  = 'United States',
                            GE_SS_No_of_Drilling_Personnel__c = 3);
        
        insert c;
                
        Schema.SObjectType s = SVMXC__Service_Order_line__c.sObjectType;
        Schema.DescribeSObjectResult resSchema = s.getDescribe() ;
        Map<String,Schema.RecordTypeInfo> recordTypeInfo = resSchema.getRecordTypeInfosByName(); 
        Id rtId = recordTypeInfo.get('Spares').getRecordTypeId();
        
        Id SSIP =  Schema.SObjectType.SVMXC__Installed_Product__c.getRecordTypeInfosByName().get('Subsea Equipment').getRecordTypeId();
        
        // insert IP
        SVMXC__Installed_Product__c IP = new SVMXC__Installed_Product__c(Name='TsetIP',SVMXC__Status__c = 'Installed',SVMXC__City__c = 'Test', SVMXC__Country__c = 'USA',
                                                                                SVMXC__Installation_Notes__c = 'Test Notes', GE_SS_Quantity__c = 1, RecordTypeId = SSIP );
        insert IP;
        
        Test.startTest();
        
        // insert subsea case lines
        SVMXC__Service_Order_line__c TripWOline = new SVMXC__Service_Order_line__c();
        TripWOline.RecordTypeId = rtId;
        TripWOline.SVMXC__Serial_Number__c = IP.Id;
        TripWOline.SVMXC__Service_Order__c = c.Id;
        //TripWOline.GE_SS_Quantity__c = 2;
        
        insert TripWOline;
        
        SVMXC__Installed_Product__c updatedIP = [SELECT GE_SS_Quantity__c FROM SVMXC__Installed_Product__c WHERE Id = : IP.Id LIMIT 1];
        
        //System.assertEquals(updatedIP.GE_SS_Quantity__c, TripWOline.GE_SS_Quantity__c);
        
        Test.stopTest();
        
    
    }
    public static testmethod void testWOLinesAfter2()
{
  
Id LocRecid = Schema.SObjectType.SVMXC__Site__c.getRecordTypeInfosByName().get('Field').getRecordTypeId();
        
        // insert Site
    SVMXC__Site__c loc = new SVMXC__Site__c(RecordTypeId = LocRecid,
                                GE_SS_Project_Region__c = 'LAM',
                                Name = 'Test Field Loc',
                                SVMXC__Latitude__c = 37.662533,
                                SVMXC__Longitude__c = 121.874730,
                                Management_Country__c = 'Aruba');
                        insert loc;
        
        //Case with Location
        Id SSMobilize =  Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('SS-Mobilize').getRecordTypeId();
     
      //  SVMXC__Service_Order__c c = new SVMXC__Service_Order__c(RecordTypeId=SSMobilize);
        SVMXC__Service_Order__c c = new SVMXC__Service_Order__c(
                            RecordTypeId = SSMobilize,
                            //SVMXC__Company__c = acc.id,
                            //SVMXC__Case__c = cs.id,
                            SVMXC__Order_Status__c = 'Open',
                            GE_SS_Field__c = loc.id,
                            SVMXC__Country__c  = 'United States',                            
                            GE_SS_No_of_Drilling_Personnel__c = 3);
        
        insert c;
        
        Id SSTrip =  Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('SS-Trip').getRecordTypeId();
        SVMXC__Service_Order__c CT = new SVMXC__Service_Order__c(
                            RecordTypeId = SSTrip,
                            //SVMXC__Company__c = acc.id,
                            //SVMXC__Case__c = cs.id,
                            SVMXC__Order_Status__c = 'Open',
                            GE_SS_Field__c = loc.id,
                            SVMXC__Country__c  = 'United States',
                            GE_SS_Parent_Work_Order__c = c.id,
                            GE_SS_No_of_Drilling_Personnel__c = 3);
                            
                            insert CT;
    
        SVMXC__Service_Order__c CT1 = new SVMXC__Service_Order__c(
                            RecordTypeId = SSTrip,
                            //SVMXC__Company__c = acc.id,
                            //SVMXC__Case__c = cs.id,
                            SVMXC__Order_Status__c = 'Open',
                            GE_SS_Field__c = loc.id,
                            SVMXC__Country__c  = 'United States',
                            GE_SS_Parent_Work_Order__c = c.id,
                            GE_SS_No_of_Drilling_Personnel__c = 3);
                            
                            insert CT1;
        
        Schema.SObjectType s = SVMXC__Service_Order_line__c.sObjectType;
        Schema.DescribeSObjectResult resSchema = s.getDescribe() ;
        Map<String,Schema.RecordTypeInfo> recordTypeInfo = resSchema.getRecordTypeInfosByName(); 
        Id rtId = recordTypeInfo.get('Spares').getRecordTypeId();
        
        Id SSIP =  Schema.SObjectType.SVMXC__Installed_Product__c.getRecordTypeInfosByName().get('Subsea Equipment').getRecordTypeId();
        
        // insert IP
        SVMXC__Installed_Product__c IP = new SVMXC__Installed_Product__c(Name='TsetIP',SVMXC__Status__c = 'Installed',SVMXC__City__c = 'Test', SVMXC__Country__c = 'USA',
                                                                                SVMXC__Installation_Notes__c = 'Test Notes', GE_SS_Quantity__c = 1, RecordTypeId = SSIP );
        insert IP;
        
       
        
        // insert subsea case lines
        SVMXC__Service_Order_line__c TripWOline = new SVMXC__Service_Order_line__c();
        TripWOline.RecordTypeId = rtId;
        TripWOline.SVMXC__Serial_Number__c = IP.Id;
        TripWOline.SVMXC__Service_Order__c = CT.Id;
        //TripWOline.GE_SS_Quantity__c = 2;
        
        insert TripWOline;
     SVMXC__Installed_Product__c updatedIP = [SELECT GE_SS_Quantity__c FROM SVMXC__Installed_Product__c WHERE Id = : IP.Id LIMIT 1];
        
        //System.assertEquals(updatedIP.GE_SS_Quantity__c, TripWOline.GE_SS_Quantity__c);
        
     
    Schema.SObjectType s1 = SVMXC__Service_Order_line__c.sObjectType;
        Schema.DescribeSObjectResult resSchema1 = s1.getDescribe() ;
        Map<String,Schema.RecordTypeInfo> recordTypeInfo1 = resSchema1.getRecordTypeInfosByName(); 
        Id rtId1 = recordTypeInfo1.get('Equipment').getRecordTypeId();
        
       // Id SSIP =  Schema.SObjectType.SVMXC__Installed_Product__c.getRecordTypeInfosByName().get('GE OG SS').getRecordTypeId();
        
        // insert IP
        
        
        Test.startTest();
        
        // insert subsea case lines
        SVMXC__Service_Order_line__c TripWOline1 = new SVMXC__Service_Order_line__c();
        TripWOline1.RecordTypeId = rtId1;
        TripWOline1.SVMXC__Serial_Number__c = IP.Id;
        TripWOline1.SVMXC__Service_Order__c = CT.Id;
        //TripWOline.GE_SS_Quantity__c = 2;
        
        insert TripWOline1;
        List<SVMXC__Service_Order_line__c> sol=new List<SVMXC__Service_Order_line__c>();
   sol.add(TripWOline1);
    sol.add(TripWOline);
        IP.GE_SS_Quantity__c=2;
        update IP;
        //SVMXC_WorkOrderLinesAfter.syncTripWOLineswithMobWLDelete(sol);
        Test.stopTest();

}
 public static testmethod void testWOLinesAfter3()
{
  
Id LocRecid = Schema.SObjectType.SVMXC__Site__c.getRecordTypeInfosByName().get('Field').getRecordTypeId();
        
        // insert Site
    SVMXC__Site__c loc = new SVMXC__Site__c(RecordTypeId = LocRecid,
                                GE_SS_Project_Region__c = 'LAM',
                                Name = 'Test Field Loc',
                                SVMXC__Latitude__c = 37.662533,
                                SVMXC__Longitude__c = 121.874730,
                                Management_Country__c = 'Aruba');
                        insert loc;
        
        //Case with Location
        Id SSMobilize =  Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('SS-Mobilize').getRecordTypeId();
      Id OpptyRecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('O&G').getRecordTypeId();
            Id accRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('CMF Approved').getRecordTypeId();
            Id acc1RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
            List<Account> accList = new List<Account> ();
            Account acc = new Account(Name = 'Test Account',RecordTypeId=acc1RecordTypeId ,Classification__c='Key Acccount',
            Type='Direct Customer',Account_Tier_GEOG__c='Global');
            insert acc;
            
            Account accLE= new Account(Name ='TestAccount Legal',
            RecordTypeId=accRecordTypeId ,
            Account_Status__c='CC Approved',
            Account_Tier_GEOG__c='LE',
            Classification__c='Key Acccount',
            Type='Direct Customer',
            Member_of_GE_OG__c=acc.Id);
            //insert accLE;
            accList.add(accLE);
             Account endaccLE = new Account(Name ='TestAccount end user',
            RecordTypeId=accRecordTypeId ,
            Account_Status__c='CC Approved',
            Account_Tier_GEOG__c='LE',            
            Classification__c='Key Acccount',
            Type='Direct Customer',
            ParentId=acc.Id,
            Member_of_GE_OG__c=acc.Id);
            //insert endaccLE ;
            accList.add(endaccLE);
            insert accList;
            Test.startTest();
              Opportunity_Stage_Won_Lost_Nego_GE_OG oswl = new Opportunity_Stage_Won_Lost_Nego_GE_OG();
            
            Opportunity oppty = new Opportunity();
            oppty.Name='TestOptyZ';
            oppty.AccountId = acc.id;
            oppty.install_country_ge_og__c = 'India';
            oppty.quote_type_ge_og__c = 'Bid Competitive / Tender';
            oppty.has_opportunitycontactrole_ge_og__c =true ;
            oppty.deal_path_ge_og__c = 'Express';
            oppty.Is_express_ge_og__c = 'Yes';
            oppty.need_comm_ops_support_ge_og__c = true;
            oppty.has_commercial_primary_resource_ge_og__c = True;
            oppty.end_user_ge_og__c= endaccLE.id;
            oppty.install_country_ge_og__c= 'India';
            oppty.bid_due_date_ge_og__c= system.today();
            oppty.delivery_date_ge_og__c = null;
            oppty.isbudgetary_ge_og__c = 'Firm Fixed';
            oppty.sub_industry_ge_og__c = 'XYZ'; 
            oppty.legal_entity_ge_og__c = accLE.id;
            oppty.bid_sent_date_ge_og__c = System.Today();
            oppty.bid_sent_ge_og__c = True;
            oppty.stage_ge_og__c = 'Prospecting';
            oppty.StageName = 'Prospecting';
            oppty.competitor_ge_og__c=true;
            oppty.primary_reason_code_ge_og__c = '';
            oppty.primary_sub_reason_code_ge_og__c = '';
            oppty.region_ge_og__c = 'Test Region';
            oppty.closedate = system.today().addDays(30);
            oppty.RecordTypeId=OpptyRecordTypeId;      
            oppty.tier_2_ge_og__c ='Oil Field Services';
            oppty.tier_3_ge_og__c ='Drilling Services';      
            oppty.amount_ge_og__c =1000.00;
            oppty.install_country_ge_og__c= 'India';
            //insert oppty;
            Test.stopTest();
      //  SVMXC__Service_Order__c c = new SVMXC__Service_Order__c(RecordTypeId=SSMobilize);
        SVMXC__Service_Order__c c = new SVMXC__Service_Order__c(
                            RecordTypeId = SSMobilize,
                            //SVMXC__Company__c = acc.id,
                            //SVMXC__Case__c = cs.id,
                            SVMXC__Order_Status__c = 'Open',
                            GE_SS_Field__c = loc.id,
                            SVMXC__Country__c  = 'United States',
                            /*GE_DS_Opportunity_Name__C = oppty.Id,*/
                            GE_SS_No_of_Drilling_Personnel__c = 3);
        
        insert c;
        
        
       /* Id SSTrip =  Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('SS-Trip').getRecordTypeId();
        SVMXC__Service_Order__c CT = new SVMXC__Service_Order__c(
                            RecordTypeId = SSTrip,
                            //SVMXC__Company__c = acc.id,
                            //SVMXC__Case__c = cs.id,
                            SVMXC__Order_Status__c = 'Open',
                            GE_SS_Field__c = loc.id,
                            SVMXC__Country__c  = 'United States',
                            GE_SS_Parent_Work_Order__c = c.id,
                            GE_SS_No_of_Drilling_Personnel__c = 3);
                            
                            insert CT;
                            
        c.GE_SS_Field__c = loc.id;                    
        c.SVMXC__Order_Status__c = 'Closed';
        Update c;   */
                    
      

}
}