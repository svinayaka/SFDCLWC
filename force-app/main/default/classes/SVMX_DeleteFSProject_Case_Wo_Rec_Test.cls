/**************************************************
 *TestClassName: SVMX_DeleteFSProject_Case_Wo_Rec_Test 
 *Created By: Umesh Rao
 *Created Date On: 16/12/2014
 *Description: To Delete FS Project, Case, WO, Subsequent children
 **************************************************/
 @isTest(SeeAllData=true)
 Public Class SVMX_DeleteFSProject_Case_Wo_Rec_Test
{
  
    Public static Testmethod Void SVMX_DeleteFSProject_Case_Wo_Rec_testmethod()
    {
      Id AccRecId=Schema.SObjectType.Account.getRecordTypeInfosByName().get('CMF Approved').getRecordTypeId();
        //Inserting Data Project Region
        GE_SS_Project_Region__c pr = new GE_SS_Project_Region__c();
        pr.Name = 'Test';
        pr.GE_SS_Assignment_Group__c = 'abc@test.com';
        pr.Active__c=true;
        insert pr;

        //Inserting Data into Account
        Account acc = new Account();
        acc.Name = 'AMERICAN UNIVERSITY OF THE CARIBBEAN';
        acc.GE_ES_Competitor__c = 'NO';
        acc.GE_HQ_Site_Use_Code__c = 'BOTH';
        acc.GE_HQ_New_Account_Street__c = 'Test Street';
        acc.GE_HQ_New_Account_City__c = 'Test City';
        acc.GE_HQ_New_Account_State_Province__c = 'Test State';
        acc.GE_HQ_New_Account_Zip_Postal_Code__c = '598590';
        acc.GE_HQ_New_Account_Country__c = 'INDIA';
        acc.Phone = '934793749';
        acc.Type='Direct Customer';
        acc.RecordTypeId= AccRecId; 
        acc.Classification__c = 'Key Account';
        insert acc; 
        
        //Inserting Data into FS Project record
      
      GE_SS_Project__c fsp = new GE_SS_Project__c();
      fsp.Name = 'Test';
      fsp.GE_SS_Account__c = acc.id;
      fsp.GE_SS_Status__c = 'Open';
      fsp.GE_SS_Project_Region__c = pr.id;
      fsp.GE_SS_Type_of_Customer_Project__c = 'Greenfield';
      fsp.GE_SS_Country__c = 'INDIA';
      insert fsp;
      
        Id LocRecid = Schema.SObjectType.SVMXC__Site__c.getRecordTypeInfosByName().get('Field').getRecordTypeId();
      //Insert Location
      
        SVMXC__Site__c loc1 = new SVMXC__Site__c(RecordTypeId = LocRecid,
                                GE_SS_Project_Region__c = 'LAM',
                                Name = 'Test Field Loc',
                                SVMXC__Latitude__c = 37.662533,
                                SVMXC__Longitude__c = 121.874730,
                                Management_Country__c = 'Aruba');
                        insert loc1;
      
    //User record;
      Profile pf= [SELECT Id FROM Profile WHERE name= 'System Administrator' LIMIT 1 ];
         //Inserting User
         User usr1 = new User(LastName = 'Test User Account2',Isactive =true,Username = 'testuseraccount2@ge.com',Email = 'testuser@ge.com',Alias = 'ta2' ,CommunityNickname= 'TestCN2' ,TimeZoneSidKey = 'America/Los_Angeles',LocaleSidKey='en_US',EmailEncodingKey= 'ISO-8859-1',ProfileId = pf.Id, LanguageLocaleKey = 'en_US');
  
        insert usr1;
        
        //Inserting Data into Case record
    
    //Retriving Case 'FS-SS' Record Type
    Id rtIdCase = Schema.SObjectType.Case.getRecordTypeInfosByName().get('FS-SS').getRecordTypeId();
    //cs.RecordTypeId = rtIdCase;
    
    Case cs = new Case();
    cs.GE_SS_Project__c = fsp.id;
    cs.Subject = 'Test Case';
    cs.Status = 'Open';
    cs.GE_SM_HQ_State__c = 'CA';
    cs.GE_SS_Approver__c = usr1.id;
    cs.GE_SS_Planned_Start_Date__c = SYSTEM.TODAY();
    cs.GE_SS_Project_Region__c = pr.id;
    cs.GE_ES_Country__c = 'INDIA';
    cs.GE_Country__c = 'INDIA';
    cs.GE_Product_Category__c = 'Rental';
    cs.GE_SS_Product_Group__c = 'SURFACE TREE';
    cs.GE_SS_Job_Type__c = 'Inspection';
   cs.GE_SS_Job_Description__c = 'Test Job ignore';
    cs.AccountId = acc.id;
    cs.RecordTypeId = rtIdCase;
    cs.GE_SS_Field__c = loc1.id;
    insert cs;
    
    //Retriving Work Order 'SS Mobilize' Record Type
    Id rtId = Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('SS-Mobilize').getRecordTypeId();
    
    //Insert Mobilize Work Order
    SVMXC__Service_Order__c WOR = new SVMXC__Service_Order__c();
    WOR.SVMXC__Case__c = cs.id;
    WOR.GE_SS_Product_Category__c = 'Rental';
    WOR.SVMXC__Company__c = acc.id;
   // WOR.GE_SS_State__c = 'Released To FS';
    WOR.GE_SS_Approver__c = usr1.id;
    WOR.GE_SS_Product_Group__c = 'CONTROLS SYSTEM';
    WOR.GE_SS_Job_Description__c = 'Test Job';
    WOR.RecordTypeId = rtId;
    WOR.GE_SS_Project_Region__c = pr.id;
    WOR.GE_SS_Job_Location__c = 'Onshore';
    WOR.SVMXC__Country__c = 'INDIA';
    WOR.GE_SS_No_of_Drilling_Personnel__c = 3;
    //WOR.GE_SS_Field__c = loc.id;
    insert WOR;
    
    //Insert Daily WO
Id rtId1 = Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('SS-Daily').getRecordTypeId();
SVMXC__Service_Order__c WOD = new SVMXC__Service_Order__c();
    WOD.SVMXC__Case__c = cs.id;
    WOD.GE_SS_Product_Category__c = 'Rental';
    WOD.SVMXC__Company__c = acc.id;
  //  WOD.GE_SS_State__c = 'Released To FS';
    WOD.GE_SS_Approver__c = usr1.id;
    WOD.GE_SS_Product_Group__c = 'CONTROLS SYSTEM';
    WOD.GE_SS_Job_Description__c = 'Test Job';
    WOD.RecordTypeId = rtId1;
    WOD.GE_SS_Project_Region__c = pr.id;
    WOD.GE_SS_Job_Location__c = 'Onshore';
    WOD.SVMXC__Country__c = 'INDIA';
    //WOD.GE_SS_Field__c = loc.id;
    WOD.GE_SS_Parent_Work_Order__c = WOR.id;
    WOD.GE_SS_No_of_Drilling_Personnel__c = 3;
    insert WOD;
    
    //Insert Trip Description

    GE_SS_Trip_Description__c trp = new GE_SS_Trip_Description__c();
    trp.Name = 'Test Description';
    trp.GE_SS_Product_Category__c = 'Rental';
    insert trp;
    
    //Insert Trip WO
Id rtId2 = Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('SS-Trip').getRecordTypeId();

    SVMXC__Service_Order__c WOT = new SVMXC__Service_Order__c();
    WOT.SVMXC__Case__c = cs.id;
    WOT.GE_SS_Product_Category__c = 'Rental';
    WOT.SVMXC__Company__c = acc.id;
   // WOT.GE_SS_State__c = 'Released To FS';
    WOT.GE_SS_Approver__c = usr1.id;
    WOT.GE_SS_Product_Group__c = 'CONTROLS SYSTEM';
    WOT.GE_SS_Parent_Work_Order__c = WOR.id;
    WOT.RecordTypeId = rtId2;
    WOT.GE_SS_Trip_Description__c = trp.id;
    WOT.GE_SS_No_of_Drilling_Personnel__c = 3;

//Insert Service Team

    SVMXC__Service_Group__c st = new SVMXC__Service_Group__c();
    st.Name = 'Test Service Team';
    st.GE_HQ_P_L_Level__c = 'O&G > SS';
    insert st;
    
//Insert Technician record

    SVMXC__Service_Group_Members__c tech = new SVMXC__Service_Group_Members__c();
    tech.SVMXC__Service_Group__c = st.id;
    tech.Name = 'Test technician';
    tech.SVMXC__Salesforce_User__c = usr1.id;
    tech.GE_SM_HQ_SSO_ID__c = '57747498';
    insert tech;

//Insert Service tikcet
    GE_SS_Service_Ticket__c st1 = new GE_SS_Service_Ticket__c();
    st1.GE_SS_Service_Representative__c = tech.id;
    st1.GE_SS_Service_Start_Date__c = SYSTEM.TODAY();
    st1.GE_SS_Service_Finish_Date__c = SYSTEM.TODAY();
    st1.GE_SS_Work_Order__c = WOR.id;
    insert st1;

    //SVMX_DeleteFSProject_Case_Wo_Rec dfcw = new SVMX_DeleteFSProject_Case_Wo_Rec();
    SVMX_DeleteFSProject_Case_Wo_Rec.deleteFsRec(fsp.id);
    //SVMX_DeleteFSProject_Case_Wo_Rec.deleteCsRec(cs.id);
    //SVMX_DeleteFSProject_Case_Wo_Rec.deleteMobWoRec(WOR.id);
    
    }
    
    Public static Testmethod Void SVMX_DeleteFSProject_Case_Wo_Rec_testmethod2()
    {
        Id AccRecId=Schema.SObjectType.Account.getRecordTypeInfosByName().get('CMF Approved').getRecordTypeId();
        //Inserting Data Project Region
        GE_SS_Project_Region__c pr = new GE_SS_Project_Region__c();
        pr.Name = 'Test';
        pr.GE_SS_Assignment_Group__c = 'abc@test.com';
        pr.Active__c=true;
        insert pr;

        //Inserting Data into Account
        Account acc = new Account();
        acc.Name = 'AMERICAN UNIVERSITY OF THE CARIBBEAN';
        acc.GE_ES_Competitor__c = 'NO';
        acc.GE_HQ_Site_Use_Code__c = 'BOTH';
        acc.GE_HQ_New_Account_Street__c = 'Test Street';
        acc.GE_HQ_New_Account_City__c = 'Test City';
        acc.GE_HQ_New_Account_State_Province__c = 'Test State';
        acc.GE_HQ_New_Account_Zip_Postal_Code__c = '598590';
        acc.GE_HQ_New_Account_Country__c = 'INDIA';
        acc.Phone = '934793749';
        acc.Type='Direct Customer';
        acc.RecordTypeId=AccRecId; 
        acc.Classification__c = 'Key Account';
        insert acc; 
        
        //Inserting Data into FS Project record
      
      GE_SS_Project__c fsp = new GE_SS_Project__c();
      fsp.Name = 'Test';
      fsp.GE_SS_Account__c = acc.id;
      fsp.GE_SS_Status__c = 'Open';
      fsp.GE_SS_Project_Region__c = pr.id;
      fsp.GE_SS_Type_of_Customer_Project__c = 'Greenfield';
      fsp.GE_SS_Country__c = 'INDIA';
      insert fsp;
      
     Id LocRecid = Schema.SObjectType.SVMXC__Site__c.getRecordTypeInfosByName().get('Field').getRecordTypeId();
      //Insert Location
      
        SVMXC__Site__c loc1 = new SVMXC__Site__c(RecordTypeId = LocRecid,
                                GE_SS_Project_Region__c = 'LAM',
                                Name = 'Test Field Loc',
                                SVMXC__Latitude__c = 37.662533,
                                SVMXC__Longitude__c = 121.874730,
                                Management_Country__c = 'Aruba');
                        insert loc1;
      

      
    //User record;
      Profile pf= [SELECT Id FROM Profile WHERE name= 'System Administrator' LIMIT 1  ];
         //Inserting User
         User usr1 = new User(LastName = 'Test User Account2',Isactive =true,Username = 'testuseraccount2@ge.com',Email = 'testuser@ge.com',Alias = 'ta2' ,CommunityNickname= 'TestCN2' ,TimeZoneSidKey = 'America/Los_Angeles',LocaleSidKey='en_US',EmailEncodingKey= 'ISO-8859-1',ProfileId = pf.Id, LanguageLocaleKey = 'en_US');
  
        insert usr1;
        
        //Inserting Data into Case record
        //Retriving Case 'FS-SS' Record Type
    Id rtIdCase = Schema.SObjectType.Case.getRecordTypeInfosByName().get('FS-SS').getRecordTypeId();
    //cs.RecordTypeId = rtIdCase;
    
    Case cs = new Case();
    cs.GE_SS_Project__c = fsp.id;
    cs.Subject = 'Test Case';
    cs.Status = 'Open';
    cs.GE_SM_HQ_State__c = 'CA';
    cs.GE_SS_Approver__c = usr1.id;
    cs.GE_SS_Planned_Start_Date__c = SYSTEM.TODAY();
    cs.GE_SS_Project_Region__c = pr.id;
    cs.GE_ES_Country__c = 'INDIA';
    cs.GE_Country__c = 'INDIA';
    cs.GE_SS_Field__c = loc1.id;
    cs.GE_Product_Category__c = 'Rental';
    cs.GE_SS_Product_Group__c = 'SURFACE TREE';
    cs.GE_SS_Job_Type__c = 'Inspection';
    cs.GE_SS_Job_Description__c = 'Test Job ignore';
    cs.AccountId = acc.id;
    cs.RecordTypeId = rtIdCase;
    insert cs;
    
    //Retriving Work Order 'SS Mobilize' Record Type
    Id rtId = Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('SS-Mobilize').getRecordTypeId();
    
    //Insert Mobilize Work Order
    SVMXC__Service_Order__c WOR = new SVMXC__Service_Order__c();
    WOR.SVMXC__Case__c = cs.id;
    WOR.GE_SS_Product_Category__c = 'Rental';
    WOR.SVMXC__Company__c = acc.id;
    //WOR.GE_SS_State__c = 'Released To FS';
    WOR.GE_SS_Approver__c = usr1.id;
    WOR.GE_SS_Product_Group__c = 'CONTROLS SYSTEM';
    WOR.GE_SS_Job_Description__c = 'Test Job';
    WOR.RecordTypeId = rtId;
    WOR.GE_SS_Project_Region__c = pr.id;
    WOR.GE_SS_Job_Location__c = 'Onshore';
    WOR.SVMXC__Country__c = 'INDIA';
    WOR.GE_SS_No_of_Drilling_Personnel__c = 3;
    //WOR.GE_SS_Field__c = loc.id;
    insert WOR;
    
    //Insert Daily WO
Id rtId1 = Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('SS-Daily').getRecordTypeId();
SVMXC__Service_Order__c WOD = new SVMXC__Service_Order__c();
    WOD.SVMXC__Case__c = cs.id;
    WOD.GE_SS_Product_Category__c = 'Rental';
    WOD.SVMXC__Company__c = acc.id;
  //  WOD.GE_SS_State__c = 'Released To FS';
    WOD.GE_SS_Approver__c = usr1.id;
    WOD.GE_SS_Product_Group__c = 'CONTROLS SYSTEM';
    WOD.GE_SS_Job_Description__c = 'Test Job';
    WOD.RecordTypeId = rtId1;
    WOD.GE_SS_Project_Region__c = pr.id;
    WOD.GE_SS_Job_Location__c = 'Onshore';
    WOD.SVMXC__Country__c = 'INDIA';
    //WOD.GE_SS_Field__c = loc.id;
    WOD.GE_SS_Parent_Work_Order__c = WOR.id;
    WOD.GE_SS_No_of_Drilling_Personnel__c = 3;
    insert WOD;
    
    //Insert Trip Description

    GE_SS_Trip_Description__c trp = new GE_SS_Trip_Description__c();
    trp.Name = 'Test Description';
    trp.GE_SS_Product_Category__c = 'Rental';
    insert trp;
    
    //Insert Trip WO
Id rtId2 = Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('SS-Trip').getRecordTypeId();

    SVMXC__Service_Order__c WOT = new SVMXC__Service_Order__c();
    WOT.SVMXC__Case__c = cs.id;
    WOT.GE_SS_Product_Category__c = 'Rental';
    WOT.SVMXC__Company__c = acc.id;
   // WOT.GE_SS_State__c = 'Released To FS';
    WOT.GE_SS_Approver__c = usr1.id;
    WOT.GE_SS_Product_Group__c = 'CONTROLS SYSTEM';
    WOT.GE_SS_Parent_Work_Order__c = WOR.id;
    WOT.RecordTypeId = rtId2;
    WOT.GE_SS_Trip_Description__c = trp.id;
    WOT.GE_SS_No_of_Drilling_Personnel__c = 3;

//Insert Service Team

    SVMXC__Service_Group__c st = new SVMXC__Service_Group__c();
    st.Name = 'Test Service Team';
    st.GE_HQ_P_L_Level__c = 'O&G > SS';
    insert st;
    
//Insert Technician record

    SVMXC__Service_Group_Members__c tech = new SVMXC__Service_Group_Members__c();
    tech.SVMXC__Service_Group__c = st.id;
    tech.Name = 'Test technician';
    tech.SVMXC__Salesforce_User__c = usr1.id;
    tech.GE_SM_HQ_SSO_ID__c = '57747498';
    insert tech;

//Insert Service tikcet
    GE_SS_Service_Ticket__c st1 = new GE_SS_Service_Ticket__c();
    st1.GE_SS_Service_Representative__c = tech.id;
    st1.GE_SS_Service_Start_Date__c = SYSTEM.TODAY();
    st1.GE_SS_Service_Finish_Date__c = SYSTEM.TODAY();
    st1.GE_SS_Work_Order__c = WOR.id;
    insert st1;

    //SVMX_DeleteFSProject_Case_Wo_Rec dfcw = new SVMX_DeleteFSProject_Case_Wo_Rec();
    //SVMX_DeleteFSProject_Case_Wo_Rec.deleteFsRec(fsp.id);
    SVMX_DeleteFSProject_Case_Wo_Rec.deleteCsRec(cs.id);
    //SVMX_DeleteFSProject_Case_Wo_Rec.deleteMobWoRec(WOR.id);
    
    }
    
    Public static Testmethod Void SVMX_DeleteFSProject_Case_Wo_Rec_testmethod3()
    {
        Id AccRecId=Schema.SObjectType.Account.getRecordTypeInfosByName().get('CMF Approved').getRecordTypeId();
        //Inserting Data Project Region
        GE_SS_Project_Region__c pr = new GE_SS_Project_Region__c();
        pr.Name = 'Test';
        pr.GE_SS_Assignment_Group__c = 'abc@test.com';
        pr.Active__c=true;
        insert pr;

        //Inserting Data into Account
        Account acc = new Account();
        acc.Name = 'AMERICAN UNIVERSITY OF THE CARIBBEAN';
        acc.GE_ES_Competitor__c = 'NO';
        acc.GE_HQ_Site_Use_Code__c = 'BOTH';
        acc.GE_HQ_New_Account_Street__c = 'Test Street';
        acc.GE_HQ_New_Account_City__c = 'Test City';
        acc.GE_HQ_New_Account_State_Province__c = 'Test State';
        acc.GE_HQ_New_Account_Zip_Postal_Code__c = '598590';
        acc.GE_HQ_New_Account_Country__c = 'INDIA';
        acc.Phone = '934793749';
        acc.Type='Direct Customer';
        acc.RecordTypeId=AccRecId; 
        acc.Classification__c = 'Key Account';
        insert acc; 
        
        //Inserting Data into FS Project record
      
      GE_SS_Project__c fsp = new GE_SS_Project__c();
      fsp.Name = 'Test';
      fsp.GE_SS_Account__c = acc.id;
      fsp.GE_SS_Status__c = 'Open';
      fsp.GE_SS_Project_Region__c = pr.id;
      fsp.GE_SS_Type_of_Customer_Project__c = 'Greenfield';
      fsp.GE_SS_Country__c = 'INDIA';
      insert fsp;
      
        Id LocRecid = Schema.SObjectType.SVMXC__Site__c.getRecordTypeInfosByName().get('Field').getRecordTypeId();
      //Insert Location
      
        SVMXC__Site__c loc1 = new SVMXC__Site__c(RecordTypeId = LocRecid,
                                GE_SS_Project_Region__c = 'LAM',
                                Name = 'Test Field Loc',
                                SVMXC__Latitude__c = 37.662533,
                                SVMXC__Longitude__c = 121.874730,
                                Management_Country__c = 'Aruba');
                        insert loc1;
      
    //User record;
      Profile pf= [SELECT Id FROM Profile WHERE name= 'System Administrator' LIMIT 1  ];
         //Inserting User
         User usr1 = new User(LastName = 'Test User Account2',Isactive =true,Username = 'testuseraccount2@ge.com',Email = 'testuser@ge.com',Alias = 'ta2' ,CommunityNickname= 'TestCN2' ,TimeZoneSidKey = 'America/Los_Angeles',LocaleSidKey='en_US',EmailEncodingKey= 'ISO-8859-1',ProfileId = pf.Id, LanguageLocaleKey = 'en_US');
  
        insert usr1;
        
        //Inserting Data into Case record
        //Retriving Case 'FS-SS' Record Type
    Id rtIdCase = Schema.SObjectType.Case.getRecordTypeInfosByName().get('FS-SS').getRecordTypeId();
    //cs.RecordTypeId = rtIdCase;
    
    Case cs = new Case();
    cs.GE_SS_Project__c = fsp.id;
    cs.Subject = 'Test Case';
    cs.Status = 'Open';
    cs.GE_SM_HQ_State__c = 'CA';
    cs.GE_SS_Approver__c = usr1.id;
    cs.GE_SS_Planned_Start_Date__c = SYSTEM.TODAY();
    cs.GE_SS_Project_Region__c = pr.id;
    cs.GE_ES_Country__c = 'INDIA';
    cs.GE_Country__c = 'INDIA';
    cs.GE_SS_Field__c = loc1.id;
    cs.GE_Product_Category__c = 'Rental';
    cs.GE_SS_Product_Group__c = 'SURFACE TREE';
    cs.GE_SS_Job_Type__c = 'Inspection';
   cs.GE_SS_Job_Description__c = 'Test Job ignore';
    cs.AccountId = acc.id;
    cs.RecordTypeId = rtIdCase;
    insert cs;
    
    //Retriving Work Order 'SS Mobilize' Record Type
    Id rtId = Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('SS-Mobilize').getRecordTypeId();
    
    //Insert Mobilize Work Order
    SVMXC__Service_Order__c WOR = new SVMXC__Service_Order__c();
    WOR.SVMXC__Case__c = cs.id;
    WOR.GE_SS_Product_Category__c = 'Rental';
    WOR.SVMXC__Company__c = acc.id;
    //WOR.GE_SS_State__c = 'Released To FS';
    WOR.GE_SS_Approver__c = usr1.id;
    WOR.GE_SS_Product_Group__c = 'CONTROLS SYSTEM';
    WOR.GE_SS_Job_Description__c = 'Test Job';
    WOR.RecordTypeId = rtId;
    WOR.GE_SS_Project_Region__c = pr.id;
    WOR.GE_SS_Job_Location__c = 'Onshore';
    WOR.SVMXC__Country__c = 'INDIA';
    WOR.GE_SS_No_of_Drilling_Personnel__c = 3;
    //WOR.GE_SS_Field__c = loc.id;
    insert WOR;
    
    //Insert Daily WO
Id rtId1 = Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('SS-Daily').getRecordTypeId();
SVMXC__Service_Order__c WOD = new SVMXC__Service_Order__c();
    WOD.SVMXC__Case__c = cs.id;
    WOD.GE_SS_Product_Category__c = 'Rental';
    WOD.SVMXC__Company__c = acc.id;
   // WOD.GE_SS_State__c = 'Released To FS';
    WOD.GE_SS_Approver__c = usr1.id;
    WOD.GE_SS_Product_Group__c = 'CONTROLS SYSTEM';
   WOD.GE_SS_Job_Description__c = 'Test Job';
    WOD.RecordTypeId = rtId1;
    WOD.GE_SS_Project_Region__c = pr.id;
    WOD.GE_SS_Job_Location__c = 'Onshore';
    WOD.SVMXC__Country__c = 'INDIA';
    //WOD.GE_SS_Field__c = loc.id;
    WOD.GE_SS_Parent_Work_Order__c = WOR.id;
    WOD.GE_SS_No_of_Drilling_Personnel__c = 3;
    insert WOD;
    
    //Insert Trip Description

    GE_SS_Trip_Description__c trp = new GE_SS_Trip_Description__c();
    trp.Name = 'Test Description';
    trp.GE_SS_Product_Category__c = 'Rental';
    insert trp;
    
    //Insert Trip WO
Id rtId2 = Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('SS-Trip').getRecordTypeId();

    SVMXC__Service_Order__c WOT = new SVMXC__Service_Order__c();
    WOT.SVMXC__Case__c = cs.id;
    WOT.GE_SS_Product_Category__c = 'Rental';
    WOT.SVMXC__Company__c = acc.id;
    //WOT.GE_SS_State__c = 'Released To FS';
    WOT.GE_SS_Approver__c = usr1.id;
    WOT.GE_SS_Product_Group__c = 'CONTROLS SYSTEM';
    WOT.GE_SS_Parent_Work_Order__c = WOR.id;
    WOT.RecordTypeId = rtId2;
    WOT.GE_SS_Trip_Description__c = trp.id;
    WOT.GE_SS_No_of_Drilling_Personnel__c = 3;

//Insert Service Team

    SVMXC__Service_Group__c st = new SVMXC__Service_Group__c();
    st.Name = 'Test Service Team';
    st.GE_HQ_P_L_Level__c = 'O&G > SS';
    insert st;
    
//Insert Technician record

    SVMXC__Service_Group_Members__c tech = new SVMXC__Service_Group_Members__c();
    tech.SVMXC__Service_Group__c = st.id;
    tech.Name = 'Test technician';
    tech.SVMXC__Salesforce_User__c = usr1.id;
    tech.GE_SM_HQ_SSO_ID__c = '57747498';
    insert tech;

//Insert Service tikcet
    GE_SS_Service_Ticket__c st1 = new GE_SS_Service_Ticket__c();
    st1.GE_SS_Service_Representative__c = tech.id;
    st1.GE_SS_Service_Start_Date__c = SYSTEM.TODAY();
    st1.GE_SS_Service_Finish_Date__c = SYSTEM.TODAY();
    st1.GE_SS_Work_Order__c = WOR.id;
    insert st1;

    //SVMX_DeleteFSProject_Case_Wo_Rec dfcw = new SVMX_DeleteFSProject_Case_Wo_Rec();
    //SVMX_DeleteFSProject_Case_Wo_Rec.deleteFsRec(fsp.id);
    //SVMX_DeleteFSProject_Case_Wo_Rec.deleteCsRec(cs.id);
    SVMX_DeleteFSProject_Case_Wo_Rec.deleteMobWoRec(WOR.id);
    
    }
}