/*
Class Name          : Test_GE_PRM_Agreement_Triggerhandler
Used Where ?        : Used for code coverage of Agreement Trigger Handler
Functional Area     : Agreement
Author              : Neha Gupta
Created Date        : 19/2/2015.
Change History - 
Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
*/

@isTest
 public class Test_GE_PRM_Agreement_Triggerhandler{
 
 static testmethod void  createTest2(){
           Test.StartTest();   
         
           GE_PRM_Agreement_Triggerhandler test2 = new GE_PRM_Agreement_Triggerhandler();
         test2 .pusedomethod2();  
         
           Test.StopTest();
    }
    
  /**
  
     
     static testMethod void Test_GE_PRM_Agreement_Triggerhandler4() {
   GE_PRM_Agreement_Triggerhandler aggTH=new  GE_PRM_Agreement_Triggerhandler ();
    Map<String,Schema.RecordTypeInfo> RecordTypeInfo = Schema.getGlobalDescribe().get('Apttus__APTS_Agreement__c').getDescribe().getRecordTypeInfosByName();
    String  recordTypeIDm = RecordTypeInfo.get('Channel Master Agreement').getRecordTypeId();
    //Map<String,Schema.RecordTypeInfo> RecordTypeInfoc = Schema.getGlobalDescribe().get('Apttus__APTS_Agreement__c').getDescribe().getRecordTypeInfosByName();
    String  recordTypeIDc = RecordTypeInfo.get('Channel Addendum Agreement').getRecordTypeId();      
    Apttus__APTS_Agreement__c masteragg1 =new Apttus__APTS_Agreement__c();
    masteragg1.recordtypeID = recordTypeIDm;
    masteragg1.Name='Test1 Master Agreement';
    //insert masteragg;
    try 
    {
        insert masteragg1;  
    }
        catch(DmlException e) 
    {
        system.assert(false,e.getMessage()+' '+ e.getLineNumber());
    }


    Apttus__APTS_Agreement__c channelagg1 =new Apttus__APTS_Agreement__c();
    channelagg1.recordtypeID = recordTypeIDc;
    channelagg1.Name='Test Channel Agreement';
    channelagg1.GE_PRM_Limitations__c=true;
    channelagg1.GE_PRM_Arbitration_location__c='Houston, TX';
    channelagg1.GE_PRM_If_Other_Governing_Law__c='test';
    channelagg1.GE_PRM_Arbitation_Loc_If_Other__c='999.99';
    channelagg1.Apttus__Parent_Agreement__c=masteragg1.id;
    //channelagg1.GE_OG_PRM_Limitation_Exclusion_Text__c='Test';
    //insert channelagg;
    try 
    {
        insert channelagg1;  
    }
        catch(DmlException e) 
    {
        system.assert(false,e.getMessage()+' '+ e.getLineNumber());
    }
    
    map<id,Apttus__APTS_Agreement__c> masteraggmap1= new  map<id,Apttus__APTS_Agreement__c>();
    masteraggmap1.put(masteragg1.id,masteragg1);
    masteragg1.GE_PRM_Governing_Law__c='State of New York';
    channelagg1.GE_PRM_Arbitration_location__c='Houston, TX';
    channelagg1.GE_PRM_Arbitation_Loc_If_Other__c='test';
    //update masteragg;
    try 
    {
        update masteragg1;  
    }
        catch(DmlException e) 
    {
        system.assert(false,e.getMessage()+' '+ e.getLineNumber());
    }
    
    update channelagg1;  
        delete masteragg1;
        undelete masteragg1;
   }
   **/
 }