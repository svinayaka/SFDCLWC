@isTest(SeeAllData= true)
public class GE_OG_Skilltestclass{
static TestMethod void skillmismatch(){
Set<SVMXC__Service_Order__c> workO=new Set<SVMXC__Service_Order__c>();
Set<SVMXC__Service_Order__c> workO1=new Set<SVMXC__Service_Order__c>();
Map<String, Schema.SObjectType> sObjectMap = Schema.getGlobalDescribe() ;
Schema.SObjectType s = sObjectMap.get('SVMXC__Service_Order__c') ; // getting Sobject Type
Schema.DescribeSObjectResult resSchema = s.getDescribe() ;
Map<String,Schema.RecordTypeInfo> recordTypeInfo = resSchema.getRecordTypeInfosByName(); //getting all Recordtype for the Sobject
Id rtId = recordTypeInfo.get('MCS').getRecordTypeId();
ID SendtoEmailId;

User us=[Select id,email from User where isActive=True and email!=null limit 1];

SVMXC__Service_Group_Skills__c Expertise=[select id,SVMXC__Skill__c from SVMXC__Service_Group_Skills__c where SVMXC__Skill__c!=Null limit 1];
SVMXC__Service_Group__c st=new SVMXC__Service_Group__c(SVMXC__Email__c='Somanath.das@ge.com',GE_OG_Director_Email__c='Somanath.das@ge.com',GE_HQ_Resource_Director__c=us.id);insert st;
SVMXC__Service_Group_Members__c tech=new SVMXC__Service_Group_Members__c(Name='Test',GE_SM_HQ_SSO_ID__c='502177128',SVMXC__Service_Group__c=st.id);insert tech;
SVMXC__Service_Order__c wo=new SVMXC__Service_Order__c(RecordTypeId=rtId,SVMXC__Skill__c=Expertise.SVMXC__Skill__c,SVMXC__Service_Group__c=st.id);
insert wo;

//GE_OG_Skillmismatchclass skillclass=new GE_OG_Skillmismatchclass();
GE_OG_Skillmismatchclass.updateskillcheck(wo,'True');
}


static TestMethod void skillmismatch1(){
Set<SVMXC__Service_Order__c> workO=new Set<SVMXC__Service_Order__c>();
Set<SVMXC__Service_Order__c> workO1=new Set<SVMXC__Service_Order__c>();
Map<String, Schema.SObjectType> sObjectMap = Schema.getGlobalDescribe() ;
Schema.SObjectType s = sObjectMap.get('SVMXC__Service_Order__c') ; // getting Sobject Type
Schema.DescribeSObjectResult resSchema = s.getDescribe() ;
Map<String,Schema.RecordTypeInfo> recordTypeInfo = resSchema.getRecordTypeInfosByName(); //getting all Recordtype for the Sobject
Id rtId = recordTypeInfo.get('MCS').getRecordTypeId();

User us=[Select id,email from User where isActive=True and email!=null limit 1];


SVMXC__Service_Group_Skills__c Expertise=[select id,SVMXC__Skill__c from SVMXC__Service_Group_Skills__c where SVMXC__Skill__c!=Null limit 1];
SVMXC__Service_Group__c st=new SVMXC__Service_Group__c(SVMXC__Email__c='Somanath.das@ge.com',GE_OG_Director_Email__c='Somanath.das@ge.com',GE_HQ_Resource_Director__c=us.id);insert st;
SVMXC__Service_Group_Members__c tech=new SVMXC__Service_Group_Members__c(Name='Test',GE_SM_HQ_SSO_ID__c='502177128',SVMXC__Service_Group__c=st.id);insert tech;
SVMXC__Service_Order__c wo=new SVMXC__Service_Order__c(RecordTypeId=rtId,SVMXC__Skill__c=Expertise.SVMXC__Skill__c,SVMXC__Service_Group__c=st.id);
insert wo;
workO.add(wo);
Id SendtoEmailId=st.Id;

//GE_OG_Skillmismatchclass skillclass=new GE_OG_Skillmismatchclass();
GE_OG_Skillmismatchclass.noexpertise(wo,tech,'True');
}

static TestMethod void skilltriggermethod(){
    
    Set<SVMXC__Service_Order__c> workO=new Set<SVMXC__Service_Order__c>();
    Set<SVMXC__Service_Order__c> workO1=new Set<SVMXC__Service_Order__c>();
    Map<String, Schema.SObjectType> sObjectMap = Schema.getGlobalDescribe() ;
    Schema.SObjectType s = sObjectMap.get('SVMXC__Service_Order__c') ; // getting Sobject Type
    Schema.DescribeSObjectResult resSchema = s.getDescribe() ;
    Map<String,Schema.RecordTypeInfo> recordTypeInfo = resSchema.getRecordTypeInfosByName();
    Id rtId = recordTypeInfo.get('MCS').getRecordTypeId();

    User us=[Select id,email from User where isActive=True and email!=null limit 1];


    SVMXC__Service_Group_Skills__c Expertise=[select id,SVMXC__Skill__c from SVMXC__Service_Group_Skills__c where SVMXC__Skill__c!=Null limit 1];
    SVMXC__Service_Group__c st=new SVMXC__Service_Group__c(SVMXC__Email__c='Somanath.das@ge.com',GE_OG_Director_Email__c='Somanath.das@ge.com',GE_HQ_Resource_Director__c=us.id);insert st;
    SVMXC__Service_Group_Members__c tech=new SVMXC__Service_Group_Members__c(Name='Test',GE_SM_HQ_SSO_ID__c='502177128',SVMXC__Service_Group__c=st.id,GE_OG_GS_Credit_Card_Expiry_Date__c =System.today(), GE_SS_Total_Planned_Working_Days_in_Year__c =24,GE_SS_Total_Training_Days__c=12,GE_SS_Total_Personal_Leave_Days__c=12 );insert tech;
    SVMXC__Service_Order__c wo=new SVMXC__Service_Order__c(GE_OG_MC_Service_Region__c='North America',GE_OG_MC_Business_Unit__c='BN',RecordTypeId=rtId,SVMXC__Skill__c=Expertise.SVMXC__Skill__c,SVMXC__Service_Group__c=st.id, GE_OG_Min_Event_Start_Date__c = system.today(), GE_OG_Max_Event_End_Date__c = system.today() +10);
    
    insert wo;
    String woid=wo.id;
    SVMXC__SVMX_Event__c event=new SVMXC__SVMX_Event__c();
    event.SVMXC__Technician__c=tech.id;
    event.SVMXC__StartDateTime__c = System.now();
    event.SVMXC__EndDateTime__c = System.now() +10;
    event.SVMXC__WhatId__c=woid;
    insert event;
    delete event;
    
    test.startTest();
    SVMXC__Service_Group_Skills__c Expertise1 = new SVMXC__Service_Group_Skills__c();
    Expertise1.SVMXC__Group_Member__c = tech.Id;
    Expertise1.SVMXC__Service_Group__c=st.Id;
    insert Expertise1;

    SVMXC__Service_Order__c wo1=new SVMXC__Service_Order__c(GE_OG_MC_Service_Region__c='North America',GE_OG_MC_Business_Unit__c='BN',RecordTypeId=rtId,SVMXC__Skill__c=Expertise.SVMXC__Skill__c,SVMXC__Service_Group__c=st.id, GE_OG_Min_Event_Start_Date__c = system.today(), GE_OG_Max_Event_End_Date__c = system.today() +10);
    insert wo1;
    String woid1=wo1.id;
    
    SVMXC__SVMX_Event__c event1=new SVMXC__SVMX_Event__c();
    event1.SVMXC__Technician__c=tech.id;
    event1.SVMXC__WhatId__c=woid1;
    event1.SVMXC__StartDateTime__c = System.now();
    event1.SVMXC__EndDateTime__c = System.now() +10;
    insert event1;
    System.assertEquals(event1.SVMXC__Technician__c,Expertise1.SVMXC__Group_Member__c);
    delete event1;
    test.stopTest();
}

static TestMethod void skilltriggermethod1(){
    
    Set<SVMXC__Service_Order__c> workO=new Set<SVMXC__Service_Order__c>();
    Set<SVMXC__Service_Order__c> workO1=new Set<SVMXC__Service_Order__c>();
    Map<String, Schema.SObjectType> sObjectMap = Schema.getGlobalDescribe() ;
    Schema.SObjectType s = sObjectMap.get('SVMXC__Service_Order__c') ; // getting Sobject Type
    Schema.DescribeSObjectResult resSchema = s.getDescribe() ;
    Map<String,Schema.RecordTypeInfo> recordTypeInfo = resSchema.getRecordTypeInfosByName();
    Id rtId = recordTypeInfo.get('MCS').getRecordTypeId();

    User us=[Select id,email from User where isActive=True and email!=null limit 1];


    SVMXC__Service_Group_Skills__c Expertise=[select id,SVMXC__Skill__c from SVMXC__Service_Group_Skills__c where SVMXC__Skill__c!=Null limit 1];
    SVMXC__Service_Group__c st=new SVMXC__Service_Group__c(SVMXC__Email__c='Somanath.das@ge.com',GE_OG_Director_Email__c='Somanath.das@ge.com',GE_HQ_Resource_Director__c=us.id);insert st;
    SVMXC__Service_Group_Members__c tech=new SVMXC__Service_Group_Members__c(Name='Test',GE_SM_HQ_SSO_ID__c='502177128',SVMXC__Service_Group__c=st.id,GE_OG_GS_Credit_Card_Expiry_Date__c =System.today(), GE_SS_Total_Planned_Working_Days_in_Year__c =24,GE_SS_Total_Training_Days__c=12,GE_SS_Total_Personal_Leave_Days__c=12 );insert tech;
    SVMXC__Service_Order__c wo=new SVMXC__Service_Order__c(GE_OG_MC_Service_Region__c='North America',GE_OG_MC_Business_Unit__c='Bently',RecordTypeId=rtId,SVMXC__Skill__c=Expertise.SVMXC__Skill__c,SVMXC__Service_Group__c=st.id, GE_OG_Min_Event_Start_Date__c = system.today(), GE_OG_Max_Event_End_Date__c = system.today() +10);
    
    insert wo;
    String woid=wo.id;
    SVMXC__SVMX_Event__c event=new SVMXC__SVMX_Event__c();
    event.SVMXC__Technician__c=tech.id;
    event.SVMXC__StartDateTime__c = System.now();
    event.SVMXC__EndDateTime__c = System.now() +10;
    event.SVMXC__WhatId__c=woid;
    insert event;
    delete event;
    
    test.startTest();
    SVMXC__Service_Group_Skills__c Expertise1 = new SVMXC__Service_Group_Skills__c();
    Expertise1.SVMXC__Group_Member__c = tech.Id;
    Expertise1.SVMXC__Service_Group__c=st.Id;
    insert Expertise1;

    SVMXC__Service_Order__c wo1=new SVMXC__Service_Order__c(GE_OG_MC_Service_Region__c='North America',GE_OG_MC_Business_Unit__c='Bently',RecordTypeId=rtId,SVMXC__Skill__c=Expertise.SVMXC__Skill__c,SVMXC__Service_Group__c=st.id, GE_OG_Min_Event_Start_Date__c = system.today(), GE_OG_Max_Event_End_Date__c = system.today() +10);
    insert wo1;
    String woid1=wo1.id;
    
    SVMXC__SVMX_Event__c event1=new SVMXC__SVMX_Event__c();
    event1.SVMXC__Technician__c=tech.id;
    event1.SVMXC__WhatId__c=woid1;
    event1.SVMXC__StartDateTime__c = System.now();
    event1.SVMXC__EndDateTime__c = System.now() +10;
    insert event1;
    System.assertEquals(event1.SVMXC__Technician__c,Expertise1.SVMXC__Group_Member__c);
    delete event1;
    test.stopTest();
}

public static testMethod void GE_OG_MC_Mismatch_Justification_CntrlTest() {

    Map<String, Schema.SObjectType> sObjectMap = Schema.getGlobalDescribe() ;
    Schema.SObjectType s = sObjectMap.get('SVMXC__Service_Order__c') ; // getting Sobject Type
    Schema.DescribeSObjectResult resSchema = s.getDescribe() ;
    Map<String,Schema.RecordTypeInfo> recordTypeInfo = resSchema.getRecordTypeInfosByName();
    Id rtId = recordTypeInfo.get('MCS').getRecordTypeId();
    User us=[Select id,email from User where isActive=True and email!=null limit 1];
    
    SVMXC__Service_Group_Skills__c Expertise=[select id,SVMXC__Skill__c from SVMXC__Service_Group_Skills__c where SVMXC__Skill__c!=Null limit 1];
    SVMXC__Service_Group__c st=new SVMXC__Service_Group__c(SVMXC__Email__c='Somanath.das@ge.com',GE_OG_Director_Email__c='Somanath.das@ge.com',GE_HQ_Resource_Director__c=us.id);insert st;
    SVMXC__Service_Group_Members__c tech=new SVMXC__Service_Group_Members__c(Name='Test',GE_SM_HQ_SSO_ID__c='502177128',SVMXC__Service_Group__c=st.id);insert tech;
    SVMXC__Service_Order__c wo=new SVMXC__Service_Order__c(RecordTypeId=rtId,SVMXC__Skill__c=Expertise.SVMXC__Skill__c,SVMXC__Service_Group__c=st.id);
    insert wo;

    ApexPages.StandardController sc = new ApexPages.standardController(wo);
    GE_OG_MC_Mismatch_Justification_Cntrl just = new GE_OG_MC_Mismatch_Justification_Cntrl(sc);
    
}
}