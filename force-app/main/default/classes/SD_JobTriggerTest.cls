/*
========================================================
Author      : VijayaLakshmi Murukutla
Created On  : 17/OCT/2019
Purpose     : To make Test coverage for the implemented functionality on 
Apex Class:SD_Jobupdatephaseclass, SD_CustomJobTrigger,SD_JobTriggerHandler 

Modified By : Vijaya Lakshmi Murukutla
Modified On : 19/Nov/2019 to 20/Nov/2019
Purpose     : Refactring of the Test Class as part of the Requirement # R-33315 ,
Requirement Name (Technical - Update Test Classes - Remove hard coded IDs)

Modified By : Vijaya Lakshmi Murukutla
Modified On : 08/Jan/2020
Purpose     :To make Test coverage for the newly added functionality related to Requirement # R-33390(Job: Create new record type: 'Rotator Crew')
Trigger:SD_CustomJobTrigger, Apex Class:SD_JobTriggerHandler
========================================================
*/
@isTest
public class SD_JobTriggerTest { 
    static Id RotatorRecTypeId =Schema.SObjectType.FX5__Job__c.getRecordTypeInfosByDeveloperName().get('SD_Rotator_Crew').getRecordTypeId();
    static id SingleJobRecTypeId = Schema.SObjectType.FX5__Job__c.getRecordTypeInfosByDeveloperName().get('Service').getRecordTypeId();
    
    
    @testSetup static void methodName() {
        Id accRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
        
        Account AccountRec = new account(name='Relation_Account',recordtypeid=accRecordTypeId, Classification__c ='Stratagic',Type ='Direct Customer');
        insert AccountRec;
        
        FX5__Price_Book__c  pricebookrec = new FX5__Price_Book__c(name='Test_PB');
        insert pricebookrec;
        
        FX5__Well__c wellrec = new FX5__Well__c(name='BODY_WELL');
        insert wellrec;
        
        FX5__Well__c wellrec_v2 = new FX5__Well__c(name='BORE_WELL');
        insert wellrec_v2;
        
        Contact conrec = new Contact(FirstName = 'Test_FirstName',LastName = 'Test_Contact',Email = 'Test_Contact@testemail.com',AccountId = AccountRec.id);
        insert conrec;
        
        //Insert RorarotCrewJOB Record
        
        
        FX5__Job__c RotatorJob = new FX5__Job__c(FX5__Projected_Start_Date__c = System.now().addmonths(-6),
                                                 SD_Duration__c = 250,
                                                 recordtypeid= RotatorRecTypeId ,
                                                 Name= 'RotatorCrew_Rec',
                                                 SD_Qualifications_Met__c = 0.00,
                                                 FX5__Price_Book__c = [select id from FX5__Price_Book__c where name = 'Test_PB'].id,
                                                 FX5__CustomerAccount__c = [select id from Account where name = 'Relation_Account'].id,
                                                 FX5__Office__c= [select id from Account where name = 'Relation_Account'].id);
        
        insert RotatorJob ;
        
        //Insert Second RotatoryCrew Records
        
        FX5__Job__c RotatorJob_V2 = new FX5__Job__c(FX5__Projected_Start_Date__c = System.now().addmonths(-6),
                                                    SD_Duration__c = 250,
                                                    recordtypeid= RotatorRecTypeId ,
                                                    Name= 'RotatorCrew_Rec_V2',
                                                    SD_Qualifications_Met__c = 0.00,
                                                    FX5__Price_Book__c = [select id from FX5__Price_Book__c where name = 'Test_PB'].id,
                                                    FX5__CustomerAccount__c = [select id from Account where name = 'Relation_Account'].id,
                                                    FX5__Office__c= [select id from Account where name = 'Relation_Account'].id);
        
        insert RotatorJob_V2;
        
        //Insert CrewPlanning Records
        
        FX5__Crew_Planning__c creplanrec = new FX5__Crew_Planning__c(
            FX5__Job__c = RotatorJob.id,
            FX5__Crew_Member__c = conrec.id
        );
        
        
        FX5__Crew_Planning__c creplanrec_V2 = new FX5__Crew_Planning__c(
            FX5__Job__c = RotatorJob_V2.id,
            FX5__Crew_Member__c = conrec.id
        );
        
        Insert creplanrec;
        Insert creplanrec_V2 ;
        
        
        SD_Project__c projrec = new SD_Project__c(name='Test_Projrec');
        insert projrec ;
    }
    static testmethod void CheckInsert_Method(){   
        SD_Rig__c RigRec = new SD_Rig__c(name = 'Test_RIG');
        insert RigRec;
        
        FX5__Job__c singlejob = new FX5__Job__c(Name= 'Test Insert Job Operation',
                                                FX5__Projected_Start_Date__c = System.now(),
                                                RecordTypeid = SingleJobRecTypeId,
                                                SD_Duration__c = 2,
                                                //SD_Day_Job__c = true,
                                                SD_Qualifications_Met__c= 0.00,
                                                FX5__CustomerAccount__c = [select id from Account where name = 'Relation_Account'].id,
                                                FX5__Office__c= [select id from Account where name = 'Relation_Account'].id,
                                                FX5__Price_Book__c= [select id from FX5__Price_Book__c where name = 'Test_PB'].id,
                                                SD_Rig_Name__c = RigRec.id,
                                                SD_Primary_Customer_Contact_Name__c = [select id from Contact where LastName = 'Test_Contact'].id,
                                                //FX5__Primary_Job_Contact__c = [select id from Contact where LastName = 'Test_Contact'].id,
                                                FX5__Well__c = [select id from FX5__Well__c where name = 'BODY_WELL'].id);
        
        Test.starttest();
        insert singlejob;
        Test.stopTest();
        
    }
    
    static testmethod void CheckUpdate_Method(){   
        SD_Rig__c RigRec = new SD_Rig__c(name = 'Test_RIG');
        insert RigRec;
        
        id SingleJobRecTypeId = Schema.SObjectType.FX5__Job__c.getRecordTypeInfosByDeveloperName().get('Service').getRecordTypeId();
        
        FX5__Job__c singlejob = new FX5__Job__c(Name= 'Test_Insert_Job_Operation',
                                                FX5__Projected_Start_Date__c = System.now(),
                                                SD_Duration__c = 2,
                                                //SD_Day_Job__c = true,
                                                FX5__Projected_End_Date__c = System.now(),
                                                RecordTypeid = SingleJobRecTypeId,
                                                SD_Qualifications_Met__c= 0.00,
                                                FX5__CustomerAccount__c = [select id from Account where name = 'Relation_Account'].id,
                                                FX5__Office__c= [select id from Account where name = 'Relation_Account'].id,
                                                FX5__Price_Book__c= [select id from FX5__Price_Book__c where name = 'Test_PB'].id,
                                                SD_Rig_Name__c = RigRec.id,
                                                SD_Sales_Order_Number__c = '87908',
                                                SD_Estimated_Revenue__c = 100,
                                                SD_Primary_Customer_Contact_Name__c = [select id from Contact where LastName = 'Test_Contact'].id,
                                                //FX5__Primary_Job_Contact__c = [select id from Contact where LastName = 'Test_Contact'].id,
                                                FX5__Well__c = [select id from FX5__Well__c where name = 'BODY_WELL'].id,
                                                SD_Rotator_Crew__c= [select id from FX5__Job__c where name = 'RotatorCrew_Rec' and RecordtypeId =: RotatorRecTypeId ].id);
        
        Test.starttest();
        insert singlejob;
        singlejob.FX5__Projected_Start_Date__c = System.now().adddays(1);
        singlejob.FX5__Well__c = [select id from FX5__Well__c where name = 'BORE_WELL'].id;
        singlejob.SD_Rotator_Crew__c = [select id from FX5__Job__c where name = 'RotatorCrew_Rec_V2' and RecordtypeId =: RotatorRecTypeId ].id;
        
        singlejob.SD_Stage__c='Execution';
        singlejob.SD_Product_Line__c = 'PP';
        singlejob.SD_Sub_Product_Line__c = 'Cementing';
        singlejob.SD_Product_Family__c = 'Cementing';
        singlejob.SD_Job_Type__c = 'Casing Cementing';
        singlejob.SD_Sub_Job_Type__c = 'Conductor';
        
        Update singlejob;
        Test.stopTest();
        
    }
    
    static testmethod void CheckDelete_Method(){   
        FX5__Job__c singlejob = new FX5__Job__c(Name= 'Test Insert Job Operation',
                                                FX5__Projected_Start_Date__c = System.now(),
                                                RecordTypeid = SingleJobRecTypeId,
                                                SD_Duration__c = 2,
                                                SD_Qualifications_Met__c= 0.00,
                                                FX5__CustomerAccount__c = [select id from Account where name = 'Relation_Account'].id,
                                                FX5__Office__c= [select id from Account where name = 'Relation_Account'].id,
                                                FX5__Price_Book__c= [select id from FX5__Price_Book__c where name = 'Test_PB'].id,
                                                SD_Primary_Customer_Contact_Name__c = [select id from Contact where LastName = 'Test_Contact'].id,
                                                FX5__Well__c = [select id from FX5__Well__c where name = 'BODY_WELL'].id);
        insert singlejob;
        
        Test.starttest();
        Delete singlejob;
        Undelete singlejob;
        Test.stopTest();
        
    }
    static testmethod void PPJobQualification(){
        SD_Rig__c RigRec = new SD_Rig__c(name = 'Test_RIG');
        insert RigRec;
        
        FX5__Job__c singlejob = new FX5__Job__c(Name= 'Test Insert Job Operation',
                                                FX5__Projected_Start_Date__c = System.now(),
                                                RecordTypeid = SingleJobRecTypeId,
                                                SD_Duration__c = 2,
                                                SD_Qualifications_Met__c= 0.00,
                                                SD_Sales_Order_Number__c = '1234',
                                                SD_Estimated_Revenue__c = 100,
                                                FX5__CustomerAccount__c = [select id from Account where name = 'Relation_Account'].id,
                                                FX5__Office__c= [select id from Account where name = 'Relation_Account'].id,
                                                FX5__Price_Book__c= [select id from FX5__Price_Book__c where name = 'Test_PB'].id,
                                                SD_Primary_Customer_Contact_Name__c = [select id from Contact where LastName = 'Test_Contact'].id,
                                                FX5__Well__c = [select id from FX5__Well__c where name = 'BODY_WELL'].id,
                                                SD_Project__c = [select id from SD_Project__c where name = 'Test_Projrec'].id);
        insert singlejob;
        
        FX5__Qualification__c QualRec = 
            new FX5__Qualification__c(name='test',FX5__Abbreviation__c='PP1',SD_Active__c=true,
                                      SD_Qualification_Id__c='PP1',SD_Qualification_Type__c='Type 1',SD_Product_Family__c='Cementing;Coiled Tubing',
                                      SD_Sub_Product_Line__c='Cementing',SD_Sub_Job_Type__c='Conductor',SD_Job_Type__c='Casing Cementing');
        insert QualRec;
        
        FX5__Qualification__c QualRec_V2= 
            new FX5__Qualification__c(name='test',FX5__Abbreviation__c='PP2',SD_Active__c=true,
                                      SD_Qualification_Id__c='PP2',SD_Qualification_Type__c='Type 1',SD_Product_Family__c='Cementing',
                                      SD_Sub_Product_Line__c='Cementing',SD_Sub_Job_Type__c='Conductor',SD_Job_Type__c='Casing Cementing');
        insert QualRec_V2;
        
        singlejob.SD_Rig_Name__c = RigRec.id;
        singlejob.SD_Stage__c='Execution';
        singlejob.SD_Product_Line__c='PP';
        singlejob.SD_Sub_Product_Line__c='Cementing';
        singlejob.SD_Product_Family__c='Cementing';
        singlejob.SD_Job_Type__c='Casing Cementing';
        singlejob.SD_Sub_Job_Type__c='Conductor';
        Test.startTest();
        update singlejob;
        Test.StopTest();
    } 
}