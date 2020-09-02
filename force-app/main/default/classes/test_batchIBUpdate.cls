@isTest
private class test_batchIBUpdate {

    static testmethod void test() {
        Test.starttest();
        // The query used by the batch job.
        // rtypeSCM = Schema.SObjectType.GE_Installed_Base__c.getRecordTypeInfosByName().get('Subsea Control Module').getRecordTypeId();
        // rtypeSM = Schema.SObjectType.GE_Installed_Base__c.getRecordTypeInfosByName().get('Subsea Manifold').getRecordTypeId();
        // rtypeSXT = Schema.SObjectType.GE_Installed_Base__c.getRecordTypeInfosByName().get('Subsea Xmas Tree').getRecordTypeId();
        String query = 'SELECT Id, Name, GE_OGSS_InstnDte__c,GE_OGSS_WelIdntfr__c, GE_ES_Status__c FROM GE_Installed_Base__c ';

        
        // Create some test merchandise items to be deleted
        //   by the batch job.
        GE_Installed_Base__c[] ml = new List < GE_Installed_Base__c > ();
        for (Integer i = 0; i < 10; i++) {
            GE_Installed_Base__c m = new GE_Installed_Base__c(
                Name = 'IB ' + i,
                // Description='Some description',
                GE_ES_Status__c = 'Installed (1)',
                GE_OGSS_WelIdntfr__c = 'test');
            ml.add(m);
        }
        insert ml;

        batchIBUpdate c = new batchIBUpdate();
        Database.executeBatch(c);
        Test.stopTest();


    }
    static testMethod void SWIBBatchApexCaseForEventRecordTest2() {

        List < Case > lstGECombinedList = new List < Case > ();
        List < Case > lstGESNEquipNameCIR = new List < Case > ();
        List < Case > lstGESNEquipNameNPT = new List < Case > ();
        List < Case > lstGESNEquipNameCam = new List < Case > ();

        Integer sortNum;


        /*String cirRecID = Schema.SObjectType.Case.getRecordTypeInfosByName().get('CIR').getRecordTypeId(); 
        String nptRecID = Schema.SObjectType.Case.getRecordTypeInfosByName().get('SS_NPT').getRecordTypeId();
        String SIRCamRecID = Schema.SObjectType.Case.getRecordTypeInfosByName().get('SIR - CaM').getRecordTypeId();*/

        String CIRrecType = Schema.SObjectType.Case.getRecordTypeInfosByName().get('CIR').getRecordTypeId();

        //  String cirRecID = [Select id from recordtype where sobjecttype=:'Case' and name=:'CIR'].id;
        //  String nptRecID = [Select id from recordtype where sobjecttype=:'Case' and name=:'SS_NPT'].id;
        //  String SIRCamRecID =[Select id from recordtype where sobjecttype=:'Case' and name=:'SIR - CaM'].id;

        List < string > lstGESNEquipName = new List < string > ();

        Test.starttest();
        String rtypeSCM = [Select id from recordtype where sobjecttype =: 'GE_Installed_Base__c'
            and name =: 'Subsea Control Module'
        ].id;
        String rtypeSM = [Select id from recordtype where sobjecttype =: 'GE_Installed_Base__c'
            and name =: 'Subsea Manifold'
        ].id;
        String rtypeSXT = [Select id from recordtype where sobjecttype =: 'GE_Installed_Base__c'
            and name =: 'Subsea Xmas Tree'
        ].id;


        Profile p1 = [SELECT Id FROM Profile WHERE Name = 'System Administrator'];
        User u = new User(Alias = 'standt', Email = 'standarduser121w32@testorg.com',
            EmailEncodingKey = 'UTF-8', LastName = 'Testing', LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US', ProfileId = p1.Id,
            TimeZoneSidKey = 'America/Los_Angeles', UserName = 'standarduser22332@testorg.com');
        //Test.stoptest();

        String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('CMF Approved').getRecordTypeId();
        //Test.startTest();


        account a = new account();
        a.name = 'test';
        a.RecordtypeId = CommAccrecType;
        insert a;
        /*
        contact c1 = new contact();
        c1.FirstName='test';
        c1.MobilePhone='2222222222';
        c1.LastName='test';
        c1.accountid = a.id; 
        c1.email='test@ge.com';
        insert c1;*/

        list < GE_Installed_Base__c > scope = new list < GE_Installed_Base__c > ();
        GE_Installed_Base__c gi = new GE_Installed_Base__c();
        gi.name = 'test';
        gi.Account__c = a.id;
        gi.GE_ES_Station_Name__c = 'test';
        gi.GE_ES_Status__c = 'Installed';
        insert gi;
        scope.add(gi);

        system.assertequals(gi.name, 'test');
        GE_OG_Product_Hierarchy1__c p = new GE_OG_Product_Hierarchy1__c();
        p.GE_OG_MCS_Assembly__c = 'Remote Visual Inspection';
        p.GE_OG_MCS_Business__c = 'Subsea (SS)';
        p.GE_OG_MCS_Component__c = 'Video Borescopes';
        p.GE_OG_MCS_Item_Description1__c = 'Air Hose';
        p.GE_OG_MCS_Item_Description__c = 'Accessory';
        p.GE_OG_MCS_Item__c = 'Flying Probe';
        p.GE_OG_MCS_Sub_Business__c = 'Inspection Technologies';
        p.Name = 'OG_Prod_Hier__1341';
        insert p;

        /*    list<Case> scope = new list<Case>();*/
        case c = new
        case ();

        c.GE_OG_CIR_Site_Country__c = 'AFGHANISTAN';
        C.GE_OG_Business_CIR__c = p.GE_OG_MCS_Business__c;
        c.GE_ES_Sub_Type__c = 'MCS Sub Status';
        c.accountid = a.id;
        c.GE_OG_CIR_Unit_Serial_number__c = gi.id;
        c.GE_OG_CIR_Assembly__c = p.GE_OG_MCS_Assembly__c;
        c.recordtypeid = CIRrecType;
        c.GE_OG_CIR_Component__c = p.GE_OG_MCS_Component__c;
        c.GE_OG_Sub_Business_CIR__c = p.GE_OG_MCS_Sub_Business__c;
        c.GE_OG_CIR_Item__c = p.GE_OG_MCS_Item__c;
        c.status = 'new';
        c.Origin = 'Email';
        insert c;
        // scope.add(c);


        List < SWIBEventRecord__c > sortlist = new List < SWIBEventRecord__c > ();
        SWIBeventRecord__c event = new SWIBeventRecord__c();
        event.Component_Affected__c = 'testing1';
        event.Component_PN__c = 'testing1';
        event.Component_SN__c = 'testing1';
        event.event_Description__c = 'testing1';
        event.Failure_Mode__c = 'testing1';
        event.Notes__c = 'testing1';
        event.Record_Type__c = c.RecordType.Name;
        event.RecordTypeID__c = c.recordtypeid;
        //event.SWIB_GE_S_N_Equip_Name__c =  gi.id;
        event.GE_Equipment_Name_Lkp__c = gi.id;

        // ev1.Well_ID__c =c.GE_NPT_Well_Name_ID__c;
        event.Event_Type__c = 'Installation';
        event.Event_Start_Date__c = System.today();
        event.event_End_Date__c = System.today() - 1;

        event.event_Record_Number__c = 'testing';
        insert event;
        sortlist.add(event);



        batchIBUpdate objBatch = new batchIBUpdate();
        ID batchprocessid = Database.executeBatch(objBatch);
        
        AsyncApexJob aaj = [SELECT Id, Status, JobItemsProcessed, TotalJobItems, NumberOfErrors
            FROM AsyncApexJob WHERE ID =: batchprocessid
        ];
        
        database.batchableContext bc;
        //  Database.SaveResult srList1;
        objBatch.execute(bc, scope);
        objBatch.start(bc);
        objBatch.finish(bc);
        // objBatch.lstGESNEquipName = lstGESNEquipName;


        Test.StopTest();


    }
    static testMethod void TestMethod3() {


        Test.starttest();
        Profile p = [select id, name from Profile where name = 'OG_Sales/Comm Ops'];
        User u = new User(Alias = 'standt11', Email = 'SWIB3@testorg.com',
            EmailEncodingKey = 'UTF-8', LastName = 'Testing', LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US', ProfileId = p.Id,
            TimeZoneSidKey = 'America/Los_Angeles', UserName = 'SWIB3@testorg.com');

        insert u;


        List < SWIBEventRecord__c > sortList = new List < SWIBEventRecord__c > ();
        String cirRecID = Schema.SObjectType.Case.getRecordTypeInfosByName().get('CIR').getRecordTypeId();
        String nptRecID = Schema.SObjectType.Case.getRecordTypeInfosByName().get('SS_NPT').getRecordTypeId();

        String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
        //test.starttest();
        account a = new account();
        a.name = 'test';
        a.RecordtypeId = CommAccrecType;
        a.type = 'Direct Customer';
        a.classification__c = 'Strategic';
        insert a;


        list < Case > scope = new list < Case > ();
        List < Case > lstGECombinedList = new List < Case > ();
        List < Case > lstGESNEquipNameCIR = new List < Case > ();
        List < Case > lstGESNEquipNameNPT = new List < Case > ();
        List < Case > lstGESNEquipNameCam = new List < Case > ();

        case c1 = new
        case ();
        c1.recordtypeid = nptRecID;
        c1.GE_OG_CIR_Site_Country__c = 'AFGHANISTAN';
        c1.GE_OG_Business_CIR__c = 'TMS';
        c1.GE_ES_Sub_Type__c = 'MCS Sub Status';
        c1.GE_OG_Account_Name_Only_If_Not_List_CIR__c = 'testing';
        c1.Status = 'New';
        c1.Origin = 'Test';
        c1.GE_OG_Resolution_Committed_date_CIR__c = null;
        c1.GE_OG_Escalation_Level_CIR__c = 'Escalated';
        c1.IS_CIR_sixthday_Notification_Sent__c = false;
        c1.GE_OG_CIR_Customer_Address__c = 'testing';
        c1.GE_OG_CIR_Customer_Phone__c = '1123';
        insert c1;
        lstGESNEquipNameNPT.add(c1);


        case c = new
        case ();
        c.recordtypeid = cirRecID;
        c.GE_OG_CIR_Site_Country__c = 'AFGHANISTAN';
        c.GE_OG_Business_CIR__c = 'TMS';
        c.GE_ES_Sub_Type__c = 'MCS Sub Status';
        c.GE_OG_Account_Name_Only_If_Not_List_CIR__c = 'testing';
        c.Status = 'New';
        c.Origin = 'Test';
        c.GE_OG_Resolution_Committed_date_CIR__c = null;
        c.GE_OG_Escalation_Level_CIR__c = 'Escalated';
        c.IS_CIR_sixthday_Notification_Sent__c = false;
        c.GE_OG_CIR_Customer_Address__c = 'testing';
        c.GE_OG_CIR_Customer_Phone__c = '1123';
        c.GE_OG_Issue_Event_Date_CIR__c = system.today();
        insert c;
        scope.add(c);


        lstGESNEquipNameCIR.add(c);
        lstGESNEquipNameNPT.add(c);
        lstGESNEquipNameCam.add(c);

        List < string > lstGESNEquipName = new List < string > ();

        String rtypeSCM = [Select id from recordtype where sobjecttype =: 'GE_Installed_Base__c'
            and name =: 'Subsea Control Module'
        ].id;
        String rtypeSM = [Select id from recordtype where sobjecttype =: 'GE_Installed_Base__c'
            and name =: 'Subsea Manifold'
        ].id;
        String rtypeSXT = [Select id from recordtype where sobjecttype =: 'GE_Installed_Base__c'
            and name =: 'Subsea Xmas Tree'
        ].id;


        List < GE_Installed_Base__c > lstGESNEquipName11 = new List < GE_Installed_Base__c > ();
        GE_Installed_Base__c ib = new GE_Installed_Base__c();
        ib.recordtypeid = rtypeSCM;
        ib.Name = 'demo';
        ib.GE_OGSS_ProdFamily__c = 'testing';
        ib.GE_ES_Status__c = 'testing';
        ib.GE_OG_SS_Control_Module_Location__c = 'testing';
        ib.GE_OG_SS_Pod_Number_1__c = 'testing';
        ib.GE_OG_SS_SEM_sl_Number_1__c = 'testing';
        ib.GE_OG_SS_Comms_Technology__c = 'testing';
        ib.GE_OG_SS_Back_Up_Comms_Type__c = 'testing';
        ib.GE_OG_SS_Primary_Comms_Type__c = 'testing';
        ib.GE_OG_SS_Comms_Channel__c = 'testing';
        ib.GE_OG_SS_Input_Voltage_Range__c = 'testing';
        ib.GE_OG_SS_Input_Power_Communications__c = 'testing';
        ib.GE_OG_SS_SEM_Type__c = 'testing';
        ib.GE_OG_SS_DCV_Pressure_Transducers__c = 'testing';
        ib.GE_OG_SS_DCV_Type__c = 'testing';
        ib.GE_OG_SS_HP_Working_Pressure__c = 'testing';
        ib.GE_OG_SS_Returns__c = 'testing';
        ib.GE_OG_SS_SEMs_Per_Control_Module__c = 'testing';
        ib.GE_OG_SS_LP_Working_Pressure__c = 'testing';
        ib.GE_OG_SS_HP_Functions__c = 'testing';
        ib.GE_OGSS_SrcSys__c = 'testing';
        ib.GE_OG_SS_LP_Functions__c = 'testing';
        ib.GE_OG_Delrd_Date__c = System.today();
        ib.GE_OG_SaleodrCrt_Date__c = System.today();
        ib.GE_OG_SS_Field_Hydraulic_Fluid__c = 'testing';
        ib.GE_OG_Sal_Odr_Num__c = 'testing';
        ib.GE_OGSS_CBSCode__c = 'testing';
        ib.GE_OGSS_PMSCode__c = 'testing';
        ib.GE_OGSS_Manufacturer__c = 'testing';
        insert ib;
        lstGESNEquipName11.add(ib);

        GE_Installed_Base__c ib1 = new GE_Installed_Base__c();
        ib1.recordtypeid = rtypeSCM;
        ib1.Name = 'testing1';
        ib1.GE_OGSS_ProdFamily__c = 'testing3';
        ib1.GE_ES_Status__c = 'testing3';
        ib1.GE_OG_SS_Control_Module_Location__c = 'testing3';
        ib1.GE_OG_SS_Pod_Number_1__c = 'testing3';
        ib1.GE_OG_SS_SEM_sl_Number_1__c = 'testing3';
        ib1.GE_OG_SS_Comms_Technology__c = 'testing3';
        ib1.GE_OG_SS_Back_Up_Comms_Type__c = 'testing3';
        ib1.GE_OG_SS_Primary_Comms_Type__c = 'testing3';
        ib1.GE_OG_SS_Comms_Channel__c = 'testing3';
        ib1.GE_OG_SS_Input_Voltage_Range__c = 'testing3';
        ib1.GE_OG_SS_Input_Power_Communications__c = 'testing3';
        ib1.GE_OG_SS_SEM_Type__c = 'testing3';
        ib1.GE_OG_SS_DCV_Pressure_Transducers__c = 'testing3';
        ib1.GE_OG_SS_DCV_Type__c = 'testing3';
        ib1.GE_OG_SS_HP_Working_Pressure__c = 'testing3';
        ib1.GE_OG_SS_Returns__c = 'testing3';
        ib1.GE_OG_SS_SEMs_Per_Control_Module__c = 'testing3';
        ib1.GE_OG_SS_LP_Working_Pressure__c = 'testing3';
        ib1.GE_OG_SS_HP_Functions__c = 'testing3';
        ib1.GE_OGSS_SrcSys__c = 'testing3';
        ib1.GE_OG_SS_LP_Functions__c = 'testing3';
        ib1.GE_OG_Delrd_Date__c = System.today();
        ib1.GE_OG_SaleodrCrt_Date__c = System.today();
        ib1.GE_OG_SS_Field_Hydraulic_Fluid__c = 'testing3';
        ib1.GE_OG_Sal_Odr_Num__c = 'testing3';
        ib1.GE_OGSS_CBSCode__c = 'testing3';
        ib1.GE_OGSS_PMSCode__c = 'testing3';
        ib1.GE_OGSS_Manufacturer__c = 'testing3';
        insert ib1;
        lstGESNEquipName11.add(ib1);

        GE_Installed_Base__c ib2 = new GE_Installed_Base__c();
        ib2.recordtypeid = rtypeSCM;
        ib2.Name = 'testing2';
        ib2.GE_OGSS_ProdFamily__c = 'testing4';
        ib2.GE_ES_Status__c = 'testing4';
        ib2.GE_OG_SS_Control_Module_Location__c = 'testing4';
        ib2.GE_OG_SS_Pod_Number_1__c = 'testing4';
        ib2.GE_OG_SS_SEM_sl_Number_1__c = 'testing4';
        ib2.GE_OG_SS_Comms_Technology__c = 'testing4';
        ib2.GE_OG_SS_Back_Up_Comms_Type__c = 'testing4';
        ib2.GE_OG_SS_Primary_Comms_Type__c = 'testing4';
        ib2.GE_OG_SS_Comms_Channel__c = 'testing4';
        ib2.GE_OG_SS_Input_Voltage_Range__c = 'testing4';
        ib2.GE_OG_SS_Input_Power_Communications__c = 'testing4';
        ib2.GE_OG_SS_SEM_Type__c = 'testing4';
        ib2.GE_OG_SS_DCV_Pressure_Transducers__c = 'testing4';
        ib2.GE_OG_SS_DCV_Type__c = 'testing4';
        ib2.GE_OG_SS_HP_Working_Pressure__c = 'testing4';
        ib2.GE_OG_SS_Returns__c = 'testing4';
        ib2.GE_OG_SS_SEMs_Per_Control_Module__c = 'testing4';
        ib2.GE_OG_SS_LP_Working_Pressure__c = 'testing4';
        ib2.GE_OG_SS_HP_Functions__c = 'testing4';
        ib2.GE_OGSS_SrcSys__c = 'testing4';
        ib2.GE_OG_SS_LP_Functions__c = 'testing4';
        ib2.GE_OG_Delrd_Date__c = System.today();
        ib2.GE_OG_SaleodrCrt_Date__c = System.today();
        ib2.GE_OG_SS_Field_Hydraulic_Fluid__c = 'testing4';
        ib2.GE_OG_Sal_Odr_Num__c = 'testing4';
        ib2.GE_OGSS_CBSCode__c = 'testing4';
        ib2.GE_OGSS_PMSCode__c = 'testing4';
        ib2.GE_OGSS_Manufacturer__c = 'testing4';
        insert ib2;
        lstGESNEquipName11.add(ib2);


        List < SWIBEventRecord__c > lstSWIBEventRecord = new List < SWIBEventRecord__c > ();
        SWIBEventRecord__c ev = new SWIBEventRecord__c();

        ev.Component_Affected__c = 'testing';
        ev.Component_PN__c = 'testing';
        ev.Component_SN__c = 'testing';
        ev.Event_Description__c = 'testing';
        ev.Failure_Mode__c = 'testing';
        ev.Notes__c = 'testing';
        ev.Record_Type__c = 'testing';
        ev.RecordTypeID__c = 'testing';
        //ev.SWIB_GE_S_N_Equip_Name__c = ib.Id;
        ev.GE_Equipment_Name_Lkp__c = ib.Id;

        ev.Event_End_Date__c = System.today() + 2;
        ev.Event_Type__c = 'Installation';
        ev.Well_ID__c = 'testing';
        ev.Event_Record_Number__c = 'demo';
        insert ev;
        lstSWIBEventRecord.add(ev);

        SWIBEventRecord__c ev1 = new SWIBEventRecord__c();
        ev1.Component_Affected__c = 'testing1';
        ev1.Component_PN__c = 'testing1';
        ev1.Component_SN__c = 'testing1';
        ev1.Event_Description__c = 'testing1';
        ev1.Failure_Mode__c = 'testing1';
        ev1.Notes__c = 'testing1';
        ev1.Record_Type__c = 'testing1';
        ev1.RecordTypeID__c = 'testing1';
        //ev1.SWIB_GE_S_N_Equip_Name__c = ib1.Id;
        ev1.GE_Equipment_Name_Lkp__c = ib1.Id;

        ev1.Event_End_Date__c = System.today() + 1;
        ev1.Event_Type__c = 'Installation';
        ev1.Well_ID__c = 'testing1';
        ev1.Event_Record_Number__c = 'testing1';
        insert ev1;
        lstSWIBEventRecord.add(ev1);

        SWIBEventRecord__c ev2 = new SWIBEventRecord__c();
        ev2.Component_Affected__c = 'testing2';
        ev2.Component_PN__c = 'testing2';
        ev2.Component_SN__c = 'testing2';
        ev2.Event_Description__c = 'testing2';
        ev2.Failure_Mode__c = 'testing2';
        ev2.Notes__c = 'testing2';
        ev1.Record_Type__c = 'testing2';
        ev2.RecordTypeID__c = 'testing2';
        //ev2.SWIB_GE_S_N_Equip_Name__c = ib2.Id;
        ev2.GE_Equipment_Name_Lkp__c = ib2.Id;

        ev2.Event_End_Date__c = System.today();
        ev2.Event_Type__c = 'Installation';
        ev2.Well_ID__c = 'testing2';
        ev2.Event_Record_Number__c = 'testing2';
        insert ev2;
        lstSWIBEventRecord.add(ev2);

        System.debug('list of event record' + lstSWIBEventRecord.Size());
        string WellID;
        date lastStatusDate;
        for (SWIBEventRecord__c SWIB: lstSWIBEventRecord) {


            if (SWIB.Event_Type__c == 'Installation' && SWIB.Well_ID__c != null) {
                WellID = SWIB.Well_ID__c;
                lastStatusDate = SWIB.Event_End_Date__c;
            }
        }



        sortList.addall(lstSWIBEventRecord);
        Integer sortNum;
        // Integer sortNum1 = 0 ;
        Integer listEmpty;
        Integer low = 0;
        Integer high = 2;
        Integer i; // = low;
        Integer j; // = high;
        sortNum = sortList.Size();

        system.debug('-------sortList--------' + sortList);
        system.debug('----------------sortNum value of event record------------------------' + sortNum);

        listEmpty = sortNum;

        system.debug('----------------listEmpty value of event record------------------------' + listEmpty);



        GE_Installed_Base__c IBUpdate1 = new GE_Installed_Base__c();
        IBUpdate1 = [SELECT Name, GE_OGSS_InstnDte__c, GE_OGSS_WelIdntfr__c FROM GE_Installed_Base__c WHERE ID =: ib.Id];
        IBUpdate1.GE_OGSS_InstnDte__c = ev.Event_End_Date__c;
        IBUpdate1.GE_OGSS_WelIdntfr__c = ev.Well_ID__c;
        update IBUpdate1;


        i = 0;
        j = listEmpty;

        //    batchIBUpdate objBatch1 = new batchIBUpdate();

        // SWIBcontroller1 objBatch = new SWIBcontroller1(new apexpages.standardcontroller(ib));
        batchIBUpdate objBatch = new batchIBUpdate();
        ID batchprocessid = Database.executeBatch(objBatch);
        AsyncApexJob aaj = [SELECT Id, Status, JobItemsProcessed, TotalJobItems, NumberOfErrors
            FROM AsyncApexJob WHERE ID =: batchprocessid
        ];
        database.batchableContext bc;
        //  Database.SaveResult srList1;
        //    objBatch.execute(bc);
        objBatch.start(bc);
        objBatch.finish(bc);
        // objBatch.IBupdate();
        //  objBatch.callTwoMethods();
        //  objBatch.save();
        // objBatch.modeSet();

        objBatch.lastStatusDate = ev.Event_End_Date__c;
        objBatch.WellID = 'testing';
        objBatch.sortList = sortList;
        objbatch.Quicksort(0, sortNum - 1);
        //  objbatch.subjectInput = 'testing';
        //  objbatch.mode = 'testing';
        //  objbatch.lstIB = lstGESNEquipName11;
        //  objbatch.displayMessage = true;
        //   objbatch.isSWIBPermissionExist = true;
        objbatch.SWIBStatus = 'test';
        Test.stopTest();

    }

    static testMethod void TestMethod2() {
        Integer listEmpty;
        Integer sortNum;

        test.starttest();
        Profile p = [select id, name from Profile where name = 'OG_Sales/Comm Ops'];
        User u = new User(Alias = 'standt11', Email = 'SWIB2@testorg.com',
            EmailEncodingKey = 'UTF-8', LastName = 'Testing', LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US', ProfileId = p.Id,
            TimeZoneSidKey = 'America/Los_Angeles', UserName = 'SWIB2@testorg.com');

        insert u;




        // Query your permission set name from Organization that your want to test.
        PermissionSet ps = [SELECT Id FROM PermissionSet WHERE Name = 'C_SWIB_Edit'];

        // Assign the above inserted user for the above Permission Set.
        PermissionSetAssignment psa = new PermissionSetAssignment();
        psa.AssigneeId = u.Id;
        psa.PermissionSetId = ps.Id;
        insert psa;

        System.runAs(u) {

            List < SWIBEventRecord__c > sortList = new List < SWIBEventRecord__c > ();
            String cirRecID = Schema.SObjectType.Case.getRecordTypeInfosByName().get('CIR').getRecordTypeId();
            String nptRecID = Schema.SObjectType.Case.getRecordTypeInfosByName().get('SS_NPT').getRecordTypeId();





            List < GE_Installed_Base__c > lstGESNEquipName = new List < GE_Installed_Base__c > ();

            String rtypeSCM = [Select id from recordtype where sobjecttype =: 'GE_Installed_Base__c'
                and name =: 'Subsea Control Module'
            ].id;
            String rtypeSM = [Select id from recordtype where sobjecttype =: 'GE_Installed_Base__c'
                and name =: 'Subsea Manifold'
            ].id;
            String rtypeSXT = [Select id from recordtype where sobjecttype =: 'GE_Installed_Base__c'
                and name =: 'Subsea Xmas Tree'
            ].id;


            List < GE_Installed_Base__c > lstGESNEquipName11 = new List < GE_Installed_Base__c > ();
            GE_Installed_Base__c ib = new GE_Installed_Base__c();
            ib.recordtypeid = rtypeSCM;
            ib.Name = 'demo';
            ib.GE_OGSS_ProdFamily__c = 'testing';
            ib.GE_ES_Status__c = 'testing';
            ib.GE_OG_SS_Control_Module_Location__c = 'testing';
            ib.GE_OG_SS_Pod_Number_1__c = 'testing';
            ib.GE_OG_SS_SEM_sl_Number_1__c = 'testing';
            ib.GE_OG_SS_Comms_Technology__c = 'testing';
            ib.GE_OG_SS_Back_Up_Comms_Type__c = 'testing';
            ib.GE_OG_SS_Primary_Comms_Type__c = 'testing';
            ib.GE_OG_SS_Comms_Channel__c = 'testing';
            ib.GE_OG_SS_Input_Voltage_Range__c = 'testing';
            ib.GE_OG_SS_Input_Power_Communications__c = 'testing';
            ib.GE_OG_SS_SEM_Type__c = 'testing';
            ib.GE_OG_SS_DCV_Pressure_Transducers__c = 'testing';
            ib.GE_OG_SS_DCV_Type__c = 'testing';
            ib.GE_OG_SS_HP_Working_Pressure__c = 'testing';
            ib.GE_OG_SS_Returns__c = 'testing';
            ib.GE_OG_SS_SEMs_Per_Control_Module__c = 'testing';
            ib.GE_OG_SS_LP_Working_Pressure__c = 'testing';
            ib.GE_OG_SS_HP_Functions__c = 'testing';
            ib.GE_OGSS_SrcSys__c = 'testing';
            ib.GE_OG_SS_LP_Functions__c = 'testing';
            ib.GE_OG_Delrd_Date__c = System.today();
            ib.GE_OG_SaleodrCrt_Date__c = System.today();
            ib.GE_OG_SS_Field_Hydraulic_Fluid__c = 'testing';
            ib.GE_OG_Sal_Odr_Num__c = 'testing';
            ib.GE_OGSS_CBSCode__c = 'testing';
            ib.GE_OGSS_PMSCode__c = 'testing';
            ib.GE_OGSS_Manufacturer__c = 'testing';
            insert ib;
            lstGESNEquipName11.add(ib);

            GE_Installed_Base__c ib1 = new GE_Installed_Base__c();
            ib1.recordtypeid = rtypeSCM;
            ib1.Name = 'testing1';
            ib1.GE_OGSS_ProdFamily__c = 'testing3';
            ib1.GE_ES_Status__c = 'Installation';
            ib1.GE_OG_SS_Control_Module_Location__c = 'testing3';
            ib1.GE_OG_SS_Pod_Number_1__c = 'testing3';
            ib1.GE_OG_SS_SEM_sl_Number_1__c = 'testing3';
            ib1.GE_OG_SS_Comms_Technology__c = 'testing3';
            ib1.GE_OG_SS_Back_Up_Comms_Type__c = 'testing3';
            ib1.GE_OG_SS_Primary_Comms_Type__c = 'testing3';
            ib1.GE_OG_SS_Comms_Channel__c = 'testing3';
            ib1.GE_OG_SS_Input_Voltage_Range__c = 'testing3';
            ib1.GE_OG_SS_Input_Power_Communications__c = 'testing3';
            ib1.GE_OG_SS_SEM_Type__c = 'testing3';
            ib1.GE_OG_SS_DCV_Pressure_Transducers__c = 'testing3';
            ib1.GE_OG_SS_DCV_Type__c = 'testing3';
            ib1.GE_OG_SS_HP_Working_Pressure__c = 'testing3';
            ib1.GE_OG_SS_Returns__c = 'testing3';
            ib1.GE_OG_SS_SEMs_Per_Control_Module__c = 'testing3';
            ib1.GE_OG_SS_LP_Working_Pressure__c = 'testing3';
            ib1.GE_OG_SS_HP_Functions__c = 'testing3';
            ib1.GE_OGSS_SrcSys__c = 'testing3';
            ib1.GE_OG_SS_LP_Functions__c = 'testing3';
            ib1.GE_OG_Delrd_Date__c = System.today();
            ib1.GE_OG_SaleodrCrt_Date__c = System.today();
            ib1.GE_OG_SS_Field_Hydraulic_Fluid__c = 'testing3';
            ib1.GE_OG_Sal_Odr_Num__c = 'testing3';
            ib1.GE_OGSS_CBSCode__c = 'testing3';
            ib1.GE_OGSS_PMSCode__c = 'testing3';
            ib1.GE_OGSS_Manufacturer__c = 'testing3';
            ib1.GE_OGSS_WelIdntfr__c = 'testing';
            insert ib1;
            ib1.GE_ES_Status__c = 'Installed';
            update ib1;

            lstGESNEquipName11.add(ib1);

            GE_Installed_Base__c ib2 = new GE_Installed_Base__c();
            ib2.recordtypeid = rtypeSCM;
            ib2.Name = 'testing2';
            ib2.GE_OGSS_ProdFamily__c = 'testing4';
            ib2.GE_ES_Status__c = 'testing4';
            ib2.GE_OG_SS_Control_Module_Location__c = 'testing4';
            ib2.GE_OG_SS_Pod_Number_1__c = 'testing4';
            ib2.GE_OG_SS_SEM_sl_Number_1__c = 'testing4';
            ib2.GE_OG_SS_Comms_Technology__c = 'testing4';
            ib2.GE_OG_SS_Back_Up_Comms_Type__c = 'testing4';
            ib2.GE_OG_SS_Primary_Comms_Type__c = 'testing4';
            ib2.GE_OG_SS_Comms_Channel__c = 'testing4';
            ib2.GE_OG_SS_Input_Voltage_Range__c = 'testing4';
            ib2.GE_OG_SS_Input_Power_Communications__c = 'testing4';
            ib2.GE_OG_SS_SEM_Type__c = 'testing4';
            ib2.GE_OG_SS_DCV_Pressure_Transducers__c = 'testing4';
            ib2.GE_OG_SS_DCV_Type__c = 'testing4';
            ib2.GE_OG_SS_HP_Working_Pressure__c = 'testing4';
            ib2.GE_OG_SS_Returns__c = 'testing4';
            ib2.GE_OG_SS_SEMs_Per_Control_Module__c = 'testing4';
            ib2.GE_OG_SS_LP_Working_Pressure__c = 'testing4';
            ib2.GE_OG_SS_HP_Functions__c = 'testing4';
            ib2.GE_OGSS_SrcSys__c = 'testing4';
            ib2.GE_OG_SS_LP_Functions__c = 'testing4';
            ib2.GE_OG_Delrd_Date__c = System.today();
            ib2.GE_OG_SaleodrCrt_Date__c = System.today();
            ib2.GE_OG_SS_Field_Hydraulic_Fluid__c = 'testing4';
            ib2.GE_OG_Sal_Odr_Num__c = 'testing4';
            ib2.GE_OGSS_CBSCode__c = 'testing4';
            ib2.GE_OGSS_PMSCode__c = 'testing4';
            ib2.GE_OGSS_Manufacturer__c = 'testing4';
            insert ib2;
            lstGESNEquipName11.add(ib2);

            lstGESNEquipName = lstGESNEquipName11;


            List < SWIBEventRecord__c > lstSWIBEventRecord = new List < SWIBEventRecord__c > ();
            SWIBEventRecord__c ev = new SWIBEventRecord__c();

            ev.Component_Affected__c = 'testing';
            ev.Component_PN__c = 'testing';
            ev.Component_SN__c = 'testing';
            ev.Event_Description__c = 'testing';
            ev.Failure_Mode__c = 'testing';
            ev.Notes__c = 'testing';
            ev.Record_Type__c = 'testing';
            ev.RecordTypeID__c = 'testing';
            //ev.SWIB_GE_S_N_Equip_Name__c = ib.Id;
            ev.GE_Equipment_Name_Lkp__c = ib.Id;

            ev.Event_End_Date__c = System.today();
            ev.Event_Type__c = 'Installation';
            ev.Well_ID__c = 'testing';
            ev.Event_Record_Number__c = 'demo';
            insert ev;
            lstSWIBEventRecord.add(ev);

            SWIBEventRecord__c ev0 = new SWIBEventRecord__c();

            ev0.Component_Affected__c = 'testing';
            ev0.Component_PN__c = 'testing';
            ev0.Component_SN__c = 'testing';
            ev0.Event_Description__c = 'testing';
            ev0.Failure_Mode__c = 'testing';
            ev0.Notes__c = 'testing';
            ev0.Record_Type__c = 'testing';
            ev0.RecordTypeID__c = 'testing';
            //ev0.SWIB_GE_S_N_Equip_Name__c = ib.Id;
            ev0.GE_Equipment_Name_Lkp__c = ib.Id;

            ev0.Event_End_Date__c = System.today();
            ev0.Event_Type__c = 'Pull';
            ev0.Well_ID__c = 'testing';
            ev0.Event_Record_Number__c = 'demo1';
            insert ev0;
            lstSWIBEventRecord.add(ev0);

            SWIBEventRecord__c ev1 = new SWIBEventRecord__c();
            ev1.Component_Affected__c = 'testing1';
            ev1.Component_PN__c = 'testing1';
            ev1.Component_SN__c = 'testing1';
            ev1.Event_Description__c = 'testing1';
            ev1.Failure_Mode__c = 'testing1';
            ev1.Notes__c = 'testing1';
            ev1.Record_Type__c = 'testing1';
            ev1.RecordTypeID__c = 'testing1';
            //ev1.SWIB_GE_S_N_Equip_Name__c = ib1.Id;
            ev1.GE_Equipment_Name_Lkp__c = ib1.Id;
            ev1.Event_End_Date__c = System.today();
            ev1.Event_Type__c = 'Installation';
            ev1.Well_ID__c = 'testing1';
            ev1.Event_Record_Number__c = 'testing1';
            insert ev1;
            lstSWIBEventRecord.add(ev1);

            SWIBEventRecord__c ev2 = new SWIBEventRecord__c();
            ev2.Component_Affected__c = 'testing2';
            ev2.Component_PN__c = 'testing2';
            ev2.Component_SN__c = 'testing2';
            ev2.Event_Description__c = 'testing2';
            ev2.Failure_Mode__c = 'testing2';
            ev2.Notes__c = 'testing2';
            ev1.Record_Type__c = 'testing2';
            ev2.RecordTypeID__c = 'testing2';
            //ev2.SWIB_GE_S_N_Equip_Name__c = ib.Id;
            ev2.GE_Equipment_Name_Lkp__c = ib.Id;

            ev2.Event_End_Date__c = System.today();
            ev2.Event_Type__c = 'Installation';
            ev2.Well_ID__c = 'testing2';
            ev2.Event_Record_Number__c = 'testing2';
            insert ev2;
            lstSWIBEventRecord.add(ev2);



            System.debug('list of event record' + lstSWIBEventRecord.Size());
            System.debug('list of event record' + lstSWIBEventRecord);
            string WellID;
            string SWIBStatus;
            date lastStatusDate;
            for (SWIBEventRecord__c SWIB: lstSWIBEventRecord) {
                system.debug('-----Entering this loop--------');

                if (SWIB.Event_Type__c == 'Installation') {
                    WellID = SWIB.Well_ID__c;
                    lastStatusDate = SWIB.Event_End_Date__c;
                    SWIBStatus = 'Installed';
                }
            }



            sortList.addall(lstSWIBEventRecord);
            system.debug('-------sortList--------' + sortList);
            //   Integer sortNum;
            // Integer sortNum1 = 0 ;
            //Integer listEmpty;
            Integer low = 0;
            Integer high = 1;
            //  Integer i ;// = low;
            //  Integer j;// = high;
            //i = 0;
            //  j = listEmpty;
            sortNum = sortList.Size();

            System.debug('sortNum' + sortList.Size());

            system.debug('-------sortList--------' + sortList);
            system.debug('----------------sortNum value of event record------------------------' + sortNum);

            listEmpty = sortNum;

            system.debug('----------------listEmpty value of event record------------------------' + listEmpty);



            /*  GE_Installed_Base__c IBUpdate1 = new  GE_Installed_Base__c();
IBUpdate1 =[SELECT Name,GE_OGSS_InstnDte__c,GE_ES_Status__c,GE_OGSS_WelIdntfr__c  FROM GE_Installed_Base__c WHERE ID = :ib.Id];
IBUpdate1.GE_OGSS_InstnDte__c = ev.Event_End_Date__c;
IBUpdate1.GE_OGSS_WelIdntfr__c  = ev.Well_ID__c;
IBUpdate1.GE_ES_Status__c='Pulled';
update IBUpdate1;
*/



            //update IBUpdate1;







            Date lastStatusDate1;
            lastStatusDate1 = ev.Event_End_Date__c;
            System.debug('------------lastStatusDate1----------' + lastStatusDate1);

            //  Test.startTest();

            String aa = apexpages.currentpage().getparameters().put('id', ib.id);
            PageReference pageRef = new PageReference('/apex/SWIBReqPage_IB?id=' + aa);


            //SWIBcontroller1 objBatch = new SWIBcontroller1(new apexpages.standardcontroller(ib));
            //  objBatch.GE_ES_Status__c='Installed';
            batchIBUpdate objBatch = new batchIBUpdate();
            ID batchprocessid = Database.executeBatch(objBatch);
            AsyncApexJob aaj = [SELECT Id, Status, JobItemsProcessed, TotalJobItems, NumberOfErrors
                FROM AsyncApexJob WHERE ID =: batchprocessid
            ];
            database.batchableContext bc;
            //  Database.SaveResult srList1;
            objBatch.execute(bc, lstGESNEquipName);
            objBatch.start(bc);
            objBatch.finish(bc);


            objBatch.lastStatusDate = ev.Event_End_Date__c;
            objBatch.WellID = 'testing';
            objBatch.SWIBStatus = 'Installed';
            objBatch.sortList = sortList;
            //   objBatch.lstGECombinedList = sortList;
            objbatch.Quicksort(0, sortNum - 1);
            // objbatch.subjectInput = 'testing';
            //  objbatch.mode = 'edit';
            //   objbatch.lstIB = lstGESNEquipName11;
            //objBatch.IBupdate();
            // objBatch.GE_ES_Status__c='Pulled';

            // objBatch.callTwoMethods();
            //  objBatch.save();



            // objBatch.modeSet();
            // objbatch.displayMessage = true;

            Test.stopTest();

        }
    }

}