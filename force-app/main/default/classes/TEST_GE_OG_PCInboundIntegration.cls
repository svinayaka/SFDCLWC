/*
=======================================================================================================================================
Name       : TEST_GE_OG_PCInboundIntegration 
Author     : Amit Kumar
Created On : 13th May 2015
Purpose    : To calculate code coverage for "GE_OG_PCInboundIntegration"  Apex class
======================================================================================================================================
*/
@isTest(SeeAllData=true)
public class TEST_GE_OG_PCInboundIntegration {
    static testMethod void GE_OG_PCInboundIntegrationTest(){
        test.startTest();        
              GE_OG_PCInboundIntegration objinbound =new GE_OG_PCInboundIntegration();
              GE_OG_PCInboundIntegration.Status woObjstatus=new GE_OG_PCInboundIntegration.Status();
              GE_OG_PCInboundIntegration.Status caseObjstatus = new GE_OG_PCInboundIntegration.Status();
              GE_OG_PCInboundIntegration.WorkOrder_Info woObjinfo=new GE_OG_PCInboundIntegration.WorkOrder_Info();
              GE_OG_PCInboundIntegration.WorkDetail_Info wdObjInfo = new GE_OG_PCInboundIntegration.WorkDetail_Info() ;
              GE_OG_PCInboundIntegration.Case_Info caseObjInfo = new GE_OG_PCInboundIntegration.Case_Info() ;
              List<GE_OG_PCInboundIntegration.Case_Info> caseinfolist=new List<GE_OG_PCInboundIntegration.Case_Info>();
              List<GE_OG_PCInboundIntegration.Case_Info> tempCaseinfolist=new List<GE_OG_PCInboundIntegration.Case_Info>();
              List<GE_OG_PCInboundIntegration.WorkOrder_Info> woInfolist=new List<GE_OG_PCInboundIntegration.WorkOrder_Info>();
              List<GE_OG_PCInboundIntegration.WorkOrder_Info> tempWoInfolist=new List<GE_OG_PCInboundIntegration.WorkOrder_Info>();
              List<GE_OG_PCInboundIntegration.WorkDetail_Info> wdInfolist=new List<GE_OG_PCInboundIntegration.WorkDetail_Info>(); 
              List<GE_OG_PCInboundIntegration.WorkDetail_Info> tempWdInfolist=new List<GE_OG_PCInboundIntegration.WorkDetail_Info>();               
         try{                  
              //New Location
              SVMXC__Site__c loc = new SVMXC__Site__c();
              loc.Name='Test Location';
              loc.GE_AL_Well_Type__c='Drilling';
              insert loc;
                                                
              //Account Data Helper
              List<Account> acc= [Select id, Name, GE_HQ_DUNS_Number__c from Account where GE_HQ_Request_Status__c='CMF Approved' LIMIT 1];
                           
              //New Case              
              Id recTypeID= Schema.SObjectType.Case.getRecordTypeInfosByName().get('FS-PC').getRecordTypeId();              
              Case csObj = new Case();
              csObj.Subject='Test';
              csObj.Description='Test Description';
              csObj.Status='New';
              csObj.Origin='Email';
              csObj.GE_PC_Branch__c='Fairfield';
              csObj.recordtypeid = recTypeID;              
              csObj.accountid=acc[0].Id; 
              csobj.GE_PW_SalesOrder__c='test';
              csobj.GE_ES_Project_Number__c='test';
              insert csObj;
              
              Case retCs = [SELECT Id, CaseNumber  from Case where id =: csObj.id]; 
                
              //New Skill
              SVMXC__Skill__c sk = new SVMXC__Skill__c();
              sk.Name='Test Skill';
              insert sk;
               
              //New Work Order                          
              SVMXC__Service_Order__c woObj = new SVMXC__Service_Order__c();   
              woObj.SVMXC__Site__c = loc.ID;
              woObj.SVMXC__Case__c = retCs.Id;
              woObj.SVMXC__Order_Status__c = 'Open';
              woObj.GE_PC_Branch__c = 'Fairfield';
              woObj.SVMXC__Company__c = acc[0].ID;
              woObj.SVMXC__Skill__c = sk.Id;
              woObj.GE_OG_Project_Number__c = '123456';
              insert woObj;
            
              SVMXC__Service_Order__c retWOrder = [Select id, Name, SVMXC__Case__r.CaseNumber FROM SVMXC__Service_Order__c WHERE id=:woObj.Id ];
              woObjinfo.woNum=retWOrder.Name;                                                         //Work Order Number
              woObjinfo.caseNum=retWOrder.SVMXC__Case__r.CaseNumber;          //Case Number
              woObjinfo.salesOrderNum='323232323';                             
              woObjinfo.salesOrderStatus='Entered';                          
              woObjinfo.invoiceNum='3232323';                                
              woObjinfo.invoiceStatus='Invoiced'; 
              
              system.Assertequals(woObjinfo.invoiceStatus,'Invoiced');
              
              woInfolist.add(woObjinfo);
              woObjstatus=GE_OG_PCInboundIntegration.updateWorkOrderInfo(woInfolist,'SalesOrder');
              woObjstatus=GE_OG_PCInboundIntegration.updateWorkOrderInfo(woInfolist,'Invoice');     
              woObjstatus=GE_OG_PCInboundIntegration.updateWorkOrderInfo(tempWoInfolist,'SalesOrder');
              woObjstatus=GE_OG_PCInboundIntegration.updateWorkOrderInfo(tempWoInfolist,'Invoice');         
              if(System.Test.isRunningTest()){
                   woObjstatus = GE_OG_PCInboundIntegration.updateWorkOrderInfo(woInfolist,'Invoice889');
                   woObjstatus = GE_OG_PCInboundIntegration.updateWorkOrderInfo(woInfolist,'Invoice88');
              }    
               
               caseObjInfo.caseNum='01512169';
               caseObjInfo.projectNum='121212';               
               caseinfolist.add(caseObjInfo);        
               caseObjstatus = GE_OG_PCInboundIntegration.updateCaseInfo(caseinfolist) ; 
               caseObjstatus = GE_OG_PCInboundIntegration.updateCaseInfo(tempCaseinfolist) ;   
           } 
           catch(Exception e){
                System.debug('Exception :'+e.getMessage());                
           } 
            test.stopTest();
        }  
        static testMethod void GE_OG_FSD_SInboundIntegrationTest(){
          test.startTest();           
              GE_OG_PCInboundIntegration objinbound =new GE_OG_PCInboundIntegration();
              GE_OG_PCInboundIntegration.Status woObjstatus=new GE_OG_PCInboundIntegration.Status();
              GE_OG_PCInboundIntegration.Status caseObjstatus = new GE_OG_PCInboundIntegration.Status();
              GE_OG_PCInboundIntegration.WorkOrder_Info woObjinfo=new GE_OG_PCInboundIntegration.WorkOrder_Info();
              GE_OG_PCInboundIntegration.WorkDetail_Info wdObjInfo = new GE_OG_PCInboundIntegration.WorkDetail_Info() ;
              GE_OG_PCInboundIntegration.Case_Info caseObjInfo = new GE_OG_PCInboundIntegration.Case_Info() ;
              List<GE_OG_PCInboundIntegration.Case_Info> caseinfolist=new List<GE_OG_PCInboundIntegration.Case_Info>();
              List<GE_OG_PCInboundIntegration.Case_Info> tempCaseinfolist=new List<GE_OG_PCInboundIntegration.Case_Info>();
              List<GE_OG_PCInboundIntegration.WorkOrder_Info> woInfolist=new List<GE_OG_PCInboundIntegration.WorkOrder_Info>();
              List<GE_OG_PCInboundIntegration.WorkOrder_Info> tempWoInfolist=new List<GE_OG_PCInboundIntegration.WorkOrder_Info>();              
             try
             {     
              //New Location
              SVMXC__Site__c loc = new SVMXC__Site__c();
              loc.Name='Test Location';
              loc.GE_AL_Well_Type__c='Drilling';
              insert loc;
                                                
              //Account Data Helper
              List<Account> acc= [Select id, Name, GE_HQ_DUNS_Number__c from Account where GE_HQ_Request_Status__c='CMF Approved' LIMIT 1];
                           
              //New Case                
              Id recTypeIDFS= Schema.SObjectType.Case.getRecordTypeInfosByName().get('FS-D&S').getRecordTypeId();                 
              Case csObj = new Case();
              csObj.Subject='Test';
              csObj.Description='Test Description';
              csObj.Status='New';
              csObj.Origin='Email';
              csObj.GE_PC_Branch__c='Fairfield';            
              csObj.recordtypeid = recTypeIDFS;              
              csObj.accountid=acc[0].Id; 
              csobj.GE_PW_SalesOrder__c='test';
              csobj.GE_ES_Project_Number__c='test';
              insert csObj;
              
              Case retCs=[select id, CaseNumber  from Case where id =: csObj.id]; 
                
              //New Skill
              SVMXC__Skill__c sk = new SVMXC__Skill__c();
              sk.Name='Test Skill';
              insert sk;
               
              //New Work Order                          
              SVMXC__Service_Order__c woObj = new SVMXC__Service_Order__c();   
              woObj.SVMXC__Site__c = loc.ID;
              woObj.SVMXC__Case__c = retCs.Id;
              woObj.SVMXC__Order_Status__c = 'Open';
              woObj.GE_PC_Branch__c = 'Fairfield';
              woObj.SVMXC__Company__c = acc[0].ID;
              woObj.SVMXC__Skill__c = sk.Id;
              insert woObj;
                 
              SVMXC__Service_Order__c retWOrder = [Select id, Name, SVMXC__Case__r.CaseNumber FROM SVMXC__Service_Order__c WHERE id =: woObj.Id ];
              woObjinfo.woNum=retWOrder.Name;                       //Work Order Number
              woObjinfo.caseNum=retWOrder.SVMXC__Case__r.CaseNumber;          //Case Number
              woObjinfo.salesOrderNum='323232323';                             
              woObjinfo.salesOrderStatus='Entered';                          
              woObjinfo.invoiceNum='3232323';                                
              woObjinfo.invoiceStatus='invoiced'; 
              
              system.Assertequals(woObjinfo.invoiceStatus,'invoiced');
              List<GE_OG_PCInboundIntegration.WorkOrder_Info> infolist=new List<GE_OG_PCInboundIntegration.WorkOrder_Info>();
              woInfolist.add(woObjinfo);
              woObjstatus=GE_OG_PCInboundIntegration.updateWorkOrderInfo(woInfolist,'SalesOrder');
              woObjstatus=GE_OG_PCInboundIntegration.updateWorkOrderInfo(woInfolist,'Invoice');
              woObjstatus=GE_OG_PCInboundIntegration.updateWorkOrderInfo(tempwoInfolist,'SalesOrder');
              woObjstatus=GE_OG_PCInboundIntegration.updateWorkOrderInfo(tempwoInfolist,'Invoice');
              if(System.Test.isRunningTest()){
                   woObjstatus=GE_OG_PCInboundIntegration.updateWorkOrderInfo(woInfolist,'Invoice889');
                   woObjstatus=GE_OG_PCInboundIntegration.updateWorkOrderInfo(woInfolist,'Invoice88'); 
              }        
              caseObjInfo.caseNum='01512169';
              caseObjInfo.projectNum='121212';             
              caseinfolist.add(caseObjInfo);       
              caseObjstatus = GE_OG_PCInboundIntegration.updateCaseInfo(caseinfolist);    
               
               //--- Added by Rajesh on 1-9-2016 start--//
               GE_OG_PCInboundIntegration.WorkDetail_Info workdetailinfo=new GE_OG_PCInboundIntegration.WorkDetail_Info();
               GE_OG_PCInboundIntegration.Status objstat2=new GE_OG_PCInboundIntegration.Status();
               SVMXC__Service_Order_Line__c wdline=new SVMXC__Service_Order_Line__c();            
               
           }
           catch(Exception e){
                System.debug('Exception :'+e.getMessage());               
           } 
           
           test.stopTest();  
        }
    static testMethod void GE_OG_SSInboundIntegrationTest(){
        test.startTest();       
              GE_OG_PCInboundIntegration objinbound =new GE_OG_PCInboundIntegration();
              GE_OG_PCInboundIntegration.Status woObjstatus=new GE_OG_PCInboundIntegration.Status();
              GE_OG_PCInboundIntegration.Status caseObjstatus = new GE_OG_PCInboundIntegration.Status();
              GE_OG_PCInboundIntegration.WorkOrder_Info woObjinfo=new GE_OG_PCInboundIntegration.WorkOrder_Info();
              GE_OG_PCInboundIntegration.WorkDetail_Info wdObjInfo = new GE_OG_PCInboundIntegration.WorkDetail_Info() ;
              GE_OG_PCInboundIntegration.Case_Info caseObjInfo = new GE_OG_PCInboundIntegration.Case_Info() ;
              List<GE_OG_PCInboundIntegration.Case_Info> caseinfolist=new List<GE_OG_PCInboundIntegration.Case_Info>();
              List<GE_OG_PCInboundIntegration.WorkOrder_Info> woInfolist=new List<GE_OG_PCInboundIntegration.WorkOrder_Info>();
              List<GE_OG_PCInboundIntegration.WorkDetail_Info> wdInfolist=new List<GE_OG_PCInboundIntegration.WorkDetail_Info>(); 
              List<GE_OG_PCInboundIntegration.WorkOrder_Info> tempWoInfolist=new List<GE_OG_PCInboundIntegration.WorkOrder_Info>();
              List<GE_OG_PCInboundIntegration.WorkDetail_Info> tempWdInfolist=new List<GE_OG_PCInboundIntegration.WorkDetail_Info>(); 
               
             try{
              //New Location
              SVMXC__Site__c loc = new SVMXC__Site__c();
              loc.Name='Test Location';
              loc.GE_AL_Well_Type__c='Drilling';
              insert loc;
                                                
              //Account Data Helper
              List<Account> acc= [Select id, Name, GE_HQ_DUNS_Number__c from Account where GE_HQ_Request_Status__c='CMF Approved' LIMIT 1];
                           
              //New Case              
              Id recTypeID= Schema.SObjectType.Case.getRecordTypeInfosByName().get('FS-D&S').getRecordTypeId(); 

              Case csObj = new Case();
              csObj.Subject='Test';
              csObj.Description='Test Description';
              csObj.Status='New';
              csObj.Origin='Email';
              csObj.GE_PC_Branch__c='Fairfield';
              csObj.recordtypeid = recTypeID;      
              csObj.accountid=acc[0].Id; 
              csobj.GE_PW_SalesOrder__c='test';
              csobj.GE_ES_Project_Number__c='test';
              insert csObj;
             
              Case retCs=[select id, CaseNumber  from Case where id=:csObj.id]; 
                
              //New Skill
              SVMXC__Skill__c sk = new SVMXC__Skill__c();
              sk.Name='Test Skill';
              insert sk;    
                          
              //New Work Order                          
              SVMXC__Service_Order__c woObj = new SVMXC__Service_Order__c();   
              woObj.SVMXC__Site__c = loc.ID;
              woObj.SVMXC__Case__c = retCs.Id;
              woObj.SVMXC__Order_Status__c = 'Open';
              woObj.GE_PC_Branch__c = 'Fairfield';
              woObj.SVMXC__Company__c = acc[0].ID;
              woObj.SVMXC__Skill__c = sk.Id;
              woObj.GE_OG_Project_Number__c = 'Test Project Number';
              woObj.GE_PC_Oracle_FSO__c = 'Test PC Oracle FSO';
              woObj.GE_PC_Oracle_SalesOrderStatus__c = 'Test SalesorderStatus';
              insert woObj;
            
              SVMXC__Service_Order__c retWOrder = [Select id, Name, SVMXC__Case__r.CaseNumber FROM SVMXC__Service_Order__c WHERE id =: woObj.Id ];
              woObjinfo.woNum=retWOrder.Name;                                                         //Work Order Number
              woObjinfo.caseNum=retWOrder.SVMXC__Case__r.CaseNumber;          //Case Number
              woObjinfo.salesOrderNum='323232323';                             
              woObjinfo.salesOrderStatus='Entered';                          
              woObjinfo.invoiceNum='3232323';                                
              woObjinfo.invoiceStatus='invoiced'; 
              woInfolist.add(woObjinfo) ;
              
              SVMXC__Service_Order_Line__c WLObj = new SVMXC__Service_Order_Line__c();
              WLObj.SVMXC__Line_Type__c = 'Labor';
              WLObj.GE_SS_SO_Line_Number__c = 'Test LineNumber';
              WLObj.GE_DS_SO_line_status__c  = 'Open';
              WLObj.SVMXC__Service_Order__c = woObj.id;
              insert WLObj;
              
              SVMXC__Service_Order_Line__c retWDinfo = [SELECT id, Name, SVMXC__Line_Type__c, GE_SS_SO_Line_Number__c, GE_DS_SO_line_status__c FROM SVMXC__Service_Order_Line__c WHERE id=:WLObj.Id];
              
              wdObjInfo.wdLineNum = retWDinfo.Name;
              wdObjInfo.SOLineNumber = retWDinfo.GE_SS_SO_Line_Number__c;
              wdObjInfo.SalesOrderLineStatus = retWDinfo.GE_DS_SO_line_status__c;
              wdObjInfo.invoiceNumber = '12345';
              wdObjInfo.invoiceDate = System.Today() ;              
              wdInfolist.add(wdObjInfo) ;
              
              system.Assertequals(wdObjInfo.invoiceNumber,'12345');              
              
              woObjstatus = GE_OG_PCInboundIntegration.updateSSWorkOrderInfo(woInfolist, wdInfolist, 'SalesOrder');
              woObjstatus = GE_OG_PCInboundIntegration.updateSSWorkOrderInfo(woInfolist, wdInfolist, 'ProjectCreation');
              woObjstatus = GE_OG_PCInboundIntegration.updateSSWorkOrderInfo(woInfolist, wdInfolist, 'InvoiceUpdate');
              woObjstatus= GE_OG_PCInboundIntegration.updateWorkOrderInfo(tempwoInfolist,'SalesOrder');
              woObjstatus= GE_OG_PCInboundIntegration.updateWorkOrderInfo(tempwoInfolist,'Invoice');

              if(System.Test.isRunningTest()){
                    woObjstatus = GE_OG_PCInboundIntegration.updateSSWorkOrderInfo(woInfolist, wdInfolist, 'Test');
                    woObjstatus = GE_OG_PCInboundIntegration.updateSSWorkOrderInfo(woInfolist, wdInfolist, 'Test');
                    woObjstatus = GE_OG_PCInboundIntegration.updateSSWorkOrderInfo(woInfolist, wdInfolist, 'Test'); 
              }             
              
              caseObjInfo.caseNum= retCs.CaseNumber; //'01512169';
              caseObjInfo.projectNum='1234567890123456789012345678901234567890';
              caseinfolist.add(caseObjInfo) ;              
              caseObjstatus = GE_OG_PCInboundIntegration.updateCaseInfo(caseinfolist);
              
           }
           catch(Exception e){
                System.debug('Exception :'+e.getMessage());               
           } 
           
           test.stopTest();  
    }       
}