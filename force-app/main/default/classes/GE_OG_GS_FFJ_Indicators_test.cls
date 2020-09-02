@istest(SeeAllData=true)
public class GE_OG_GS_FFJ_Indicators_test {

    public static testMethod void  ValidateIndicators1(){

        //create service team
        SVMXC__Service_Group__c sampServeTeam = new SVMXC__Service_Group__c() ;
        sampServeTeam.Name ='test Service team';
        insert sampServeTeam;
        //create technician
        SVMXC__Service_Group_Members__c ObjTechnician=new SVMXC__Service_Group_Members__c();
        ObjTechnician.name='Test Technician 1';
        ObjTechnician.SVMXC__Service_Group__c=sampServeTeam.id;
        insert ObjTechnician;
        //create skill
        SVMXC__Skill__c skill1 = new SVMXC__Skill__c();
        skill1.Name = 'skill1';
        insert skill1;
        //create expertise
        SVMXC__Service_Group_Skills__c expertise1 = new SVMXC__Service_Group_Skills__c();
        //expertise1.Name = 'expertise1';
        expertise1.SVMXC__Service_Group__c = sampServeTeam.Id;
        expertise1.SVMXC__Group_Member__c = ObjTechnician.Id;
        expertise1.SVMXC__Skill__c = skill1.Id;
        expertise1.GE_OG_GS_Root_Official_Cert_Level__c = 'No Certification';
        insert expertise1;
        
        //create project
        GE_SS_Project__c proj1 = new GE_SS_Project__c();
        proj1.Name = 'proj1';
        proj1.GE_OG_GS_Minimum_Certification__c = 'No Certification';
        insert proj1;
        //create WO
        RecordType rt = [select id, Name from RecordType where SobjectType='SVMXC__Service_Order__c' and Name = 'GS-Requirement' Limit 1];
        SVMXC__Service_Order__c WO1 = new SVMXC__Service_Order__c();
        //WO1.Name = 'WO1';
        WO1.recordtypeid= rt.Id;
        
        WO1.GE_SS_Project__c = proj1.Id;
        WO1.GE_OG_GS_Skill_Requirement__c = 'skill2';
        insert WO1;
               
        Test.startTest();
        //create event
        SVMXC__SVMX_Event__c EveObj1=new SVMXC__SVMX_Event__c();
        EveObj1.Name='TestEvent1';
        EveObj1.SVMXC__StartDateTime__c= System.now();
        EveObj1.SVMXC__EndDateTime__c= System.now() +10;
        //EveObj1.SVMXC__Service_Team__c=sampServeTeam.id;
        EveObj1.SVMXC__Technician__c=ObjTechnician.id;
        EveObj1.SVMXC__Service_Order__c = WO1.Id;
        EveObj1.SVMXC__WhatId__c = WO1.Id;
        
        insert EveObj1;
        SVMXC__Service_Order__c WO2 = [select GE_OG_GS_Competency_Text__c, GE_OG_GS_Minimum_Certification_Text__c from SVMXC__Service_Order__c where Id = :WO1.Id];

        System.assertEquals('Red', WO2.GE_OG_GS_Competency_Text__c);
        System.assertEquals('Green', WO2.GE_OG_GS_Minimum_Certification_Text__c);

        Test.stopTest();
        
        
    }


    public static testMethod void  ValidateIndicators2(){
        /*
        //create custum settings if does not exist
        GE_OG_GS_Fit_For_Job__c cs = GE_OG_GS_Fit_For_Job__c.getInstance('Record Types List');
        if(cs == NULL){
            cs = new GE_OG_GS_Fit_For_Job__c();
            cs.Name ='Record Types List';
            cs.GE_OG_GS_Record_Types_To_Apply__c = 'GS-Requirement';
            insert cs;
        }
        */
        
        //create service team
        SVMXC__Service_Group__c sampServeTeam = new SVMXC__Service_Group__c() ;
        sampServeTeam.Name ='test Service team';
        insert sampServeTeam;
        //create technician
        SVMXC__Service_Group_Members__c ObjTechnician=new SVMXC__Service_Group_Members__c();
        ObjTechnician.name='Test Technician 1';
        ObjTechnician.SVMXC__Service_Group__c=sampServeTeam.id;
        insert ObjTechnician;
        //create skill
        SVMXC__Skill__c skill1 = new SVMXC__Skill__c();
        skill1.Name = 'skill1';
        insert skill1;
        //create expertise
        SVMXC__Service_Group_Skills__c expertise1 = new SVMXC__Service_Group_Skills__c();
        //expertise1.Name = 'expertise1';
        expertise1.SVMXC__Service_Group__c = sampServeTeam.Id;
        expertise1.SVMXC__Group_Member__c = ObjTechnician.Id;
        expertise1.SVMXC__Skill__c = skill1.Id;
        expertise1.GE_OG_GS_Root_Official_Cert_Level__c = 'No Certification';
        insert expertise1;
        
        //create project
        GE_SS_Project__c proj1 = new GE_SS_Project__c();
        proj1.Name = 'proj1';
        proj1.GE_OG_GS_Minimum_Certification__c = 'No Certification';
        insert proj1;
        //create WO
        RecordType rt = [select id, Name from RecordType where SobjectType='SVMXC__Service_Order__c' and Name = 'GS-Requirement' Limit 1];
        SVMXC__Service_Order__c WO1 = new SVMXC__Service_Order__c();
        //WO1.Name = 'WO1';
        WO1.recordtypeid= rt.Id;
        
        WO1.GE_SS_Project__c = proj1.Id;
        WO1.GE_OG_GS_Skill_Requirement__c = 'skill2';
        insert WO1;
               
        Test.startTest();
        WO1.GE_OG_GS_Skill_Requirement__c = 'skill1';
        Update WO1;
        expertise1.GE_OG_GS_Root_Official_Cert_Level__c = 'FSE';
        update expertise1;
               
        proj1.GE_OG_GS_Minimum_Certification__c = 'FSE';
        update proj1;
        
        //create event
        SVMXC__SVMX_Event__c EveObj2=new SVMXC__SVMX_Event__c();
        EveObj2.Name='TestEvent2';
        EveObj2.SVMXC__StartDateTime__c=System.now();
        EveObj2.SVMXC__EndDateTime__c=System.now() +10;
        //EveObj2.SVMXC__Service_Team__c=sampServeTeam.id;
        EveObj2.SVMXC__Technician__c=ObjTechnician.id;
        EveObj2.SVMXC__Service_Order__c = WO1.Id;
        EveObj2.SVMXC__WhatId__c = WO1.Id;
        insert EveObj2;
        
        SVMXC__Service_Order__c WO3 = [select GE_OG_GS_Competency_Text__c, GE_OG_GS_Minimum_Certification_Text__c from SVMXC__Service_Order__c where Id = :WO1.Id];
        System.assertEquals('Green', WO3.GE_OG_GS_Competency_Text__c);
        System.assertEquals('Green', WO3.GE_OG_GS_Minimum_Certification_Text__c);

        Test.stopTest();
        
        
    }

    public static testMethod void  ValidateIndicators3(){
        /*
        //create custum settings if does not exist
        GE_OG_GS_Fit_For_Job__c cs = GE_OG_GS_Fit_For_Job__c.getInstance('Record Types List');
        if(cs == NULL){
            cs = new GE_OG_GS_Fit_For_Job__c();
            cs.Name ='Record Types List';
            cs.GE_OG_GS_Record_Types_To_Apply__c = 'GS-Requirement';
            insert cs;
        }
        */
        
        //create service team
        SVMXC__Service_Group__c sampServeTeam = new SVMXC__Service_Group__c() ;
        sampServeTeam.Name ='test Service team';
        insert sampServeTeam;
        //create technician
        SVMXC__Service_Group_Members__c ObjTechnician=new SVMXC__Service_Group_Members__c();
        ObjTechnician.name='Test Technician 1';
        ObjTechnician.SVMXC__Service_Group__c=sampServeTeam.id;
        insert ObjTechnician;
        //create skill
        SVMXC__Skill__c skill1 = new SVMXC__Skill__c();
        skill1.Name = 'skill1';
        insert skill1;
        //create expertise
        SVMXC__Service_Group_Skills__c expertise1 = new SVMXC__Service_Group_Skills__c();
        //expertise1.Name = 'expertise1';
        expertise1.SVMXC__Service_Group__c = sampServeTeam.Id;
        expertise1.SVMXC__Group_Member__c = ObjTechnician.Id;
        expertise1.SVMXC__Skill__c = skill1.Id;
        expertise1.GE_OG_GS_Root_Official_Cert_Level__c = 'No Certification';
        insert expertise1;
        
        //create project
        GE_SS_Project__c proj1 = new GE_SS_Project__c();
        proj1.Name = 'proj1';
        proj1.GE_OG_GS_Minimum_Certification__c = 'No Certification';
        insert proj1;
        //create WO
        RecordType rt = [select id, Name from RecordType where SobjectType='SVMXC__Service_Order__c' and Name = 'GS-Requirement' Limit 1];
        SVMXC__Service_Order__c WO1 = new SVMXC__Service_Order__c();
        //WO1.Name = 'WO1';
        WO1.recordtypeid= rt.Id;
        
        WO1.GE_SS_Project__c = proj1.Id;
        WO1.GE_OG_GS_Skill_Requirement__c = 'skill2';
        insert WO1;
               
        Test.startTest();
        WO1.GE_OG_GS_Skill_Requirement__c = 'skill1';
        Update WO1;
        expertise1.GE_OG_GS_Root_Official_Cert_Level__c = 'FSE';
        update expertise1;
               
        proj1.GE_OG_GS_Minimum_Certification__c = 'LFSE';
        update proj1;
        
        //create event
        SVMXC__SVMX_Event__c EveObj3=new SVMXC__SVMX_Event__c();
        EveObj3.Name='TestEvent3';
        EveObj3.SVMXC__StartDateTime__c=System.now();
        EveObj3.SVMXC__EndDateTime__c=System.now() +10;
        //EveObj2.SVMXC__Service_Team__c=sampServeTeam.id;
        EveObj3.SVMXC__Technician__c=ObjTechnician.id;
        EveObj3.SVMXC__Service_Order__c = WO1.Id;
        EveObj3.SVMXC__WhatId__c = WO1.Id;
        insert EveObj3;
        
        SVMXC__Service_Order__c WO4 = [select GE_OG_GS_Competency_Text__c, GE_OG_GS_Minimum_Certification_Text__c from SVMXC__Service_Order__c where Id = :WO1.Id];
        //System.assertEquals('Green', WO4.GE_OG_GS_Competency_Text__c);
        System.assertEquals('Red', WO4.GE_OG_GS_Minimum_Certification_Text__c);

        Test.stopTest();
        
        
    }


    public static testMethod void  ValidateIndicators4(){
        /*
        //create custum settings if does not exist
        GE_OG_GS_Fit_For_Job__c cs = GE_OG_GS_Fit_For_Job__c.getInstance('Record Types List');
        if(cs == NULL){
            cs = new GE_OG_GS_Fit_For_Job__c();
            cs.Name ='Record Types List';
            cs.GE_OG_GS_Record_Types_To_Apply__c = 'GS-Requirement';
            insert cs;
        }
        */
        
        //create service team
        SVMXC__Service_Group__c sampServeTeam = new SVMXC__Service_Group__c() ;
        sampServeTeam.Name ='test Service team';
        insert sampServeTeam;
        //create technician
        SVMXC__Service_Group_Members__c ObjTechnician=new SVMXC__Service_Group_Members__c();
        ObjTechnician.name='Test Technician 1';
        ObjTechnician.SVMXC__Service_Group__c=sampServeTeam.id;
        insert ObjTechnician;
        //create skill
        SVMXC__Skill__c skill1 = new SVMXC__Skill__c();
        skill1.Name = 'skill1';
        insert skill1;
        //create expertise
        SVMXC__Service_Group_Skills__c expertise1 = new SVMXC__Service_Group_Skills__c();
        //expertise1.Name = 'expertise1';
        expertise1.SVMXC__Service_Group__c = sampServeTeam.Id;
        expertise1.SVMXC__Group_Member__c = ObjTechnician.Id;
        expertise1.SVMXC__Skill__c = skill1.Id;
        expertise1.GE_OG_GS_Root_Official_Cert_Level__c = 'No Certification';
        insert expertise1;
        
        //create project
        GE_SS_Project__c proj1 = new GE_SS_Project__c();
        proj1.Name = 'proj1';
        proj1.GE_OG_GS_Minimum_Certification__c = 'No Certification';
        insert proj1;
        //create WO
        RecordType rt = [select id, Name from RecordType where SobjectType='SVMXC__Service_Order__c' and Name = 'GS-Requirement' Limit 1];
        SVMXC__Service_Order__c WO1 = new SVMXC__Service_Order__c();
        //WO1.Name = 'WO1';
        WO1.recordtypeid= rt.Id;
        
        WO1.GE_SS_Project__c = proj1.Id;
        WO1.GE_OG_GS_Skill_Requirement__c = 'skill2';
        insert WO1;
               
        Test.startTest();
        WO1.GE_OG_GS_Skill_Requirement__c = 'skill1';
        Update WO1;
        expertise1.GE_OG_GS_Root_Official_Cert_Level__c = 'FSE';
        update expertise1;
               
        proj1.GE_OG_GS_Minimum_Certification__c = 'SFSE';
        update proj1;
        
        //create event
        SVMXC__SVMX_Event__c EveObj4=new SVMXC__SVMX_Event__c();
        EveObj4.Name='TestEvent4';
        EveObj4.SVMXC__StartDateTime__c=System.now();
        EveObj4.SVMXC__EndDateTime__c=System.now() +10;
        //EveObj2.SVMXC__Service_Team__c=sampServeTeam.id;
        EveObj4.SVMXC__Technician__c=ObjTechnician.id;
        EveObj4.SVMXC__Service_Order__c = WO1.Id;
        EveObj4.SVMXC__WhatId__c = WO1.Id;
        insert EveObj4;
        
        SVMXC__Service_Order__c WO5 = [select GE_OG_GS_Competency_Text__c, GE_OG_GS_Minimum_Certification_Text__c from SVMXC__Service_Order__c where Id = :WO1.Id];
        //System.assertEquals('Green', WO5.GE_OG_GS_Competency_Text__c);
        System.assertEquals('Red', WO5.GE_OG_GS_Minimum_Certification_Text__c);

        Test.stopTest();
        
        
    }

    public static testMethod void  ValidateIndicators5(){
        /*
        //create custum settings if does not exist
        GE_OG_GS_Fit_For_Job__c cs = GE_OG_GS_Fit_For_Job__c.getInstance('Record Types List');
        if(cs == NULL){
            cs = new GE_OG_GS_Fit_For_Job__c();
            cs.Name ='Record Types List';
            cs.GE_OG_GS_Record_Types_To_Apply__c = 'GS-Requirement';
            insert cs;
        }
        */
        
        //create service team
        SVMXC__Service_Group__c sampServeTeam = new SVMXC__Service_Group__c() ;
        sampServeTeam.Name ='test Service team';
        insert sampServeTeam;
        //create technician
        SVMXC__Service_Group_Members__c ObjTechnician=new SVMXC__Service_Group_Members__c();
        ObjTechnician.name='Test Technician 1';
        ObjTechnician.SVMXC__Service_Group__c=sampServeTeam.id;
        insert ObjTechnician;
        //create skill
        SVMXC__Skill__c skill1 = new SVMXC__Skill__c();
        skill1.Name = 'skill1';
        insert skill1;
        //create expertise
        SVMXC__Service_Group_Skills__c expertise1 = new SVMXC__Service_Group_Skills__c();
        //expertise1.Name = 'expertise1';
        expertise1.SVMXC__Service_Group__c = sampServeTeam.Id;
        expertise1.SVMXC__Group_Member__c = ObjTechnician.Id;
        expertise1.SVMXC__Skill__c = skill1.Id;
        expertise1.GE_OG_GS_Root_Official_Cert_Level__c = 'No Certification';
        insert expertise1;
        
        //create project
        GE_SS_Project__c proj1 = new GE_SS_Project__c();
        proj1.Name = 'proj1';
        proj1.GE_OG_GS_Minimum_Certification__c = 'No Certification';
        insert proj1;
        //create WO
        RecordType rt = [select id, Name from RecordType where SobjectType='SVMXC__Service_Order__c' and Name = 'GS-Requirement' Limit 1];
        SVMXC__Service_Order__c WO1 = new SVMXC__Service_Order__c();
        //WO1.Name = 'WO1';
        WO1.recordtypeid= rt.Id;
        
        WO1.GE_SS_Project__c = proj1.Id;
        WO1.GE_OG_GS_Skill_Requirement__c = 'skill2';
        insert WO1;
               
        Test.startTest();
        WO1.GE_OG_GS_Skill_Requirement__c = 'skill1';
        Update WO1;
        expertise1.GE_OG_GS_Root_Official_Cert_Level__c = 'FSE';
        update expertise1;
               
        proj1.GE_OG_GS_Minimum_Certification__c = 'MFSE';
        update proj1;
        
        //create event
        SVMXC__SVMX_Event__c EveObj5=new SVMXC__SVMX_Event__c();
        EveObj5.Name='TestEvent5';
        EveObj5.SVMXC__StartDateTime__c=System.now();
        EveObj5.SVMXC__EndDateTime__c=System.now() +10;
        //EveObj5.SVMXC__Service_Team__c=sampServeTeam.id;
        EveObj5.SVMXC__Technician__c=ObjTechnician.id;
        EveObj5.SVMXC__Service_Order__c = WO1.Id;
        EveObj5.SVMXC__WhatId__c = WO1.Id;
        insert EveObj5;
        
        SVMXC__Service_Order__c WO6 = [select GE_OG_GS_Competency_Text__c, GE_OG_GS_Minimum_Certification_Text__c from SVMXC__Service_Order__c where Id = :WO1.Id];
        //System.assertEquals('Green', WO5.GE_OG_GS_Competency_Text__c);
        System.assertEquals('Red', WO6.GE_OG_GS_Minimum_Certification_Text__c);

        Test.stopTest();
        
        
    }
}