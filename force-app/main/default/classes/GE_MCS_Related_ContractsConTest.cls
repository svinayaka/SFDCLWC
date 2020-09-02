/*
Description     :This test class covers the GE_MCS_Related_ContractsCon  Controller class
which include covering of various action function and business logic function. 
Functional Area : 
Created By      : Naveen Vuppu
Modified By     : Mohit Maheshwari
Release         : 

*/
/*
It will cover the below Classes
GE_PRM_Opty_NewButton_Override --- 98%
*/

@isTest
private class GE_MCS_Related_ContractsConTest{ 
 static testmethod void Test_GE_MCS_Related_Contracts_Method()
    {
        GE_MCS_Related_ContractsCon ctrt= new GE_MCS_Related_ContractsCon();   
    }
   
/*
    static testmethod void Test_GE_MCS_Related_Contracts_Method()
    {
        //Inserting a new Account
        //Account acc = [select Id, Name from Account where name = 'TestClassAccount'];
        Account acc= new Account();
         
            User u=[select id,firstname,lastname,email from User where id=:userinfo.getUserId()];   
            
            acc.Name='TestClassAccount';  
            
            Schema.DescribeSObjectResult accObj1 = Schema.SObjectType.Account; 
            Map<String,Schema.RecordTypeInfo> accByName1 = accObj1.getRecordTypeInfosByName();
            Schema.RecordTypeInfo rtByName_acc1 =  accByName1.get('CMF Approved');
            Id acc1=rtByName_acc1.getRecordTypeId();
            acc.RecordTypeId=acc1;
            acc.GE_OG_AccFin_Status__c='In Progress';
            acc.GE_HQ_Request_Status__c ='CMF Approved';
            acc.ShippingCountry ='ARGENTINA';
            acc.GE_PW_Phone_New_Request__c='(111)111-1111';
            insert acc ;
        System.assertEquals(acc.Name,'TestClassAccount');
        //Quering RecordType using Schema
        String NewSuprtCNRT = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Support Contracts').getRecordTypeId();
        //Inserting contract
        contract Cntrct = new contract();          
        Cntrct.Accountid = acc.id; 
        Cntrct.StartDate=system.today();
        //Cntrct.EndDate=system.today();
        Cntrct.recordtypeid=NewSuprtCNRT;
        insert Cntrct;   
        contract Cntrct2 = new contract();          
        Cntrct2.Accountid = acc.id; 
        Cntrct2.StartDate=system.today();
        //Cntrct2.EndDate=system.today();
        Cntrct2.recordtypeid=NewSuprtCNRT;
        insert Cntrct2;      
        //Inserting PRM Related contract record  
        Test.startTest();
        GE_MCS_Related_Contract__c rlcntr=new GE_MCS_Related_Contract__c();
        rlcntr.GE_MCS_Contract_Lookup__c=cntrct.id;
        rlcntr.GE_MCS_Contract_Master__c=Cntrct2.id;
        rlcntr.GE_MCS_Relationship__c='test';
        insert rlcntr;
        System.assertEquals(rlcntr.GE_MCS_Relationship__c,'test');
        Test.stopTest();
        apexpages.currentpage().getparameters().put('id' ,Cntrct.id);
        apexpages.currentpage().getparameters().put('contrid' ,rlcntr.id);
        //calling the Class using Standard Controller
        ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(Cntrct);
        GE_MCS_Related_ContractsCon ctrt= new GE_MCS_Related_ContractsCon(sc);      
        ctrt.getcontrz();
        PageReference pg;
        pg=ctrt.editContr();
        pg=ctrt.deleteRcontr();
        pg=ctrt.NewContr();
        
    }  
    
*/
    
}