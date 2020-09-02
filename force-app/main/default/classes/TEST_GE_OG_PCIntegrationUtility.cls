/*
=======================================================================================================================================
Name       : TEST_GE_OG_PCIntegrationUtility 
Author     : Amit Kumar
Created On : 13th May 2015
Purpose    : To calculate code coverage for "GE_OG_PCIntegrationUtility"  Apex class
======================================================================================================================================
*/
@isTest(seeAllData=true)
public class TEST_GE_OG_PCIntegrationUtility {        
    static testMethod void GE_OG_PCIntegrationUtility(){
           test.startTest(); 
           try
           {    
                    GE_OG_PCIntegrationUtility intUtil = new GE_OG_PCIntegrationUtility();
                    Integer soaTimeOut=GE_OG_PCIntegrationUtility.PC_SOA_TIMEOUT;
                    String log_desc=GE_OG_PCIntegrationUtility.LOG_DESCRIPTION;
                    String payloadErr=GE_OG_PCIntegrationUtility.LOG_PAYLOAD_ERR;
                    String sfmSucc=GE_OG_PCIntegrationUtility.SFM_SUCCESS_MSG;
                    String sfmErr=GE_OG_PCIntegrationUtility.SFM_ERROR_MSG;
                    String woStat=GE_OG_PCIntegrationUtility.WO_STATUS_OUTBOUND;
                    String woStatInb=GE_OG_PCIntegrationUtility.WO_STATUS_INBOUND;
                    String inbErrMsg=GE_OG_PCIntegrationUtility.INBOUND_ERROR_MSG;
                    String outErrMsg=GE_OG_PCIntegrationUtility.INBOUND_EXE_MSG;
                    String statCancel=GE_OG_PCIntegrationUtility.SVMX_LINESTATUS_CANCELED;
                    String statOra=GE_OG_PCIntegrationUtility.SVMX_LINESTATUS_ORACLE;
                    String pbName=GE_OG_PCIntegrationUtility.PC_PRICEBOOK_NAME;
                   
                    GE_OG_PCWOPublish.ProcessWorkOrder_pt processRequest_x = new GE_OG_PCWOPublish.ProcessWorkOrder_pt();
                    GE_OG_PCWOPublish.ProcessWorkOrderDetails_element wdetail_x=new GE_OG_PCWOPublish.ProcessWorkOrderDetails_element();
                    GE_OG_PCWOPublish.ProcessWorkOrderDetailsResponse_element processResponse_x= new GE_OG_PCWOPublish.ProcessWorkOrderDetailsResponse_element();
                    Map<string,string> inputHeader=new Map<string,string>();
                    processRequest_x.inputHttpHeaders_x = inputHeader;
                    GE_OG_PCWOPublish.Account_element account_x = new GE_OG_PCWOPublish.Account_element();
                    GE_OG_PCWOPublish.Location_element location_x = new GE_OG_PCWOPublish.Location_element(); 
                    GE_OG_PCWOPublish.InstalledProduct_element installedproduct_x = new GE_OG_PCWOPublish.InstalledProduct_element();
                    GE_OG_PCWOPublish.Case_element case_xl = new GE_OG_PCWOPublish.Case_element();
                    GE_OG_PCWOPublish.WorkOrder_element workorder_x = new GE_OG_PCWOPublish.WorkOrder_element();
                    GE_OG_PCWOPublish.ShipToAddress_element shipToAdd_x = new GE_OG_PCWOPublish.ShipToAddress_element(); 
                    GE_OG_PCWOPublish.WorkDetail_element workdetail_x = new GE_OG_PCWOPublish.WorkDetail_element();
                    GE_OG_PCWOPublish.Product_element product_x = new GE_OG_PCWOPublish.Product_element();
                    GE_OG_PCWOPublish.ServiceTeam_element technician_x = new GE_OG_PCWOPublish.ServiceTeam_element();
                    List<GE_OG_PCWOPublish.Location_element> location_xItem = new List<GE_OG_PCWOPublish.Location_element>();
                    List<GE_OG_PCWOPublish.InstalledProduct_element>  installedproduct_xItem = new List<GE_OG_PCWOPublish.InstalledProduct_element>();
                    List<GE_OG_PCWOPublish.Case_element> case_xItem = new List<GE_OG_PCWOPublish.Case_element>();
                    List<GE_OG_PCWOPublish.WorkOrder_element> workorder_xItem = new List<GE_OG_PCWOPublish.WorkOrder_element>();
                    List<GE_OG_PCWOPublish.WorkDetail_element> workdetail_xItem = new List<GE_OG_PCWOPublish.WorkDetail_element>();
                                  
                    //New Location
                    SVMXC__Site__c loc = new SVMXC__Site__c();
                    loc.Name='Test Location';
                    loc.SVMXC__Country__c='United States';
                    loc.GE_AL_Well_Type__c='Drilling';
                    insert loc;
                    SVMXC__Site__c retLoc = [SELECT Id, Name, SVMXC__Country__c, GE_AL_Well_Type__c FROM SVMXC__Site__c WHERE id=:loc.id];
                    location_x.country=retLoc.SVMXC__Country__c;
                    location_xItem .add(location_x); 
                    account_x.Location=location_xItem ;
               
                    //Account Data Helper
                    List<Account> acc= [Select id, Name, GE_HQ_DUNS_Number__c from Account where GE_HQ_Request_Status__c='CMF Approved' LIMIT 1];
                    account_x.AccountName=acc[0].Name;             
               
                    //Populate Installed product
                    installedproduct_x.WellID='IgateWell';
                    installedproduct_xItem.add(installedproduct_x);
                    location_x.InstalledProduct=installedproduct_xItem;
             
                    //Populate case
                    case_xl.CaseType='IgateCase';
                    case_xItem.add(case_xl);
                    location_x.Case_x=case_xItem;
                    
                    //Populate work order
                    workorder_x.OrderType='IgateOrder';
                    workorder_xItem.add(workorder_x);
                    Case_xl.WorkOrder=workorder_xItem; 
            
                    //Populate ship to
                    shipToAdd_x.Street='IgateStreet';
                    shipToAdd_x.City='Houston';
                    shipToAdd_x.State='Texas';
                    shipToAdd_x.Zip='77041';
                    shipToAdd_x.Country='USA';
                    shipToAdd_x.PhoneNumber='8324551753';
                    workorder_x.ShipToAddress=shipToAdd_x; 
            
                    //Populate work detail
                    workdetail_x.LineQuantity=1;                
                    workdetail_xItem.add(workdetail_x);
                    workorder_x.WorkDetail=workdetail_xItem; 
           
                    //Populate product/pricebook
                    product_x.ProductName='testProductName';
                    product_x.PriceBook='Standard Pricebook';
               
                    //Populate service team
                    technician_x.ServiceTeamName='IgateTeam';
                    workorder_x.ServiceTeam=technician_x; 
            
                    //Populate product price book
                    product_x.PriceBook='IgateBook';
                    workdetail_x.Product=product_x; 
                   //GE_OG_PCIntegrationUtility.validateWOPayload(account_x);
                    
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
                    woObj.SVMXC__Closed_By__c=UserInfo.getUserId();
                    woObj.GE_OG_Attachment_Id__c=sk.Id;
                    insert woObj;
                    SVMXC__Service_Order__c retWOrder = [Select id, Name, GE_OG_Attachment_Id__c , SVMXC__Order_Status__c, SVMXC__Case__r.CaseNumber FROM SVMXC__Service_Order__c WHERE id=:woObj.Id ];
              
              //New Attachment
              Attachment att = new Attachment();
              att.Name = String.valueOf(retWOrder.Id);            
              att.ContentType = 'application/pdf';
              att.Body = Blob.valueof('Test Attachment');
              att.ParentId = retWOrder.Id;
              insert att;
              
              
              List<Attachment> retAtt = [Select id FROM Attachment WHERE Id=:att.Id];
              string outBodyy = GE_OG_PCIntegrationUtility.getEmailBodyOutFailure(retWOrder);
              GE_OG_PCIntegrationUtility.validateWOPayload(account_x,retWOrder.Id);
              
              
            
              System.debug('Attachment--> '+retAtt);              
              
                    Id woID=retWOrder.Id;
                    String AccessToken;
                    String environ;
                    String cred;
                    String soaep;
                    String dmzep;
                    AccessToken='bearer 2338923';
                    String SOAADMIN = 'GE SOA Admin';
                    String SOASERVER = 'Oracle fusion';
                    system.AssertEquals(SOASERVER,'Oracle fusion');
          
                    datetime logdate=system.now();
                    List<ID> woIds=new List<ID>();
                    woIds.add(woID);    
                    
                    
                    
                    SVMXC__Service_Order__c objWo = [SELECT Id, Name, SVMXC__Case__r.CaseNumber FROM SVMXC__Service_Order__c where id=:woID];
                    GE_OG_PCIntegrationUtility newobjutil = new GE_OG_PCIntegrationUtility();
                    GE_OG_PCIntegrationUtility.insertLog('Dev','Test',logdate,objWo.ID);
                    GE_OG_PCIntegrationUtility.insertLog('Dev','Test',logdate,null); //added by Rajesh
                    string outBody = GE_OG_PCIntegrationUtility.getEmailBodyOutFailure(objWo);
                    List<String> recpt = new List<String>();
                    recpt.add('kmp@ge.com');
                    List<String> ccrecpt = new List<String>();
                    ccrecpt.add('kmp1@ge.com');
                    GE_OG_PCIntegrationUtility.sendTemplatedEmail(UserInfo.getUserId(),'test','test',outBody);
                    GE_OG_PCIntegrationUtility.updateWOStatus(woIds,'Sent to Oracle');

                    GE_OG_PCIntegrationUtility.insertcaseLog('Dev','Test',logdate,retCs.ID); //added by Rajesh

               /*----*/
              String caseInbFailureEmail =  GE_OG_PCIntegrationUtility.getCaseEmailBodyInbFailure(csObj);
              String caseOutFailureEmail =  GE_OG_PCIntegrationUtility.getCaseEmailBodyOutFailure(csObj); 
              List<Case> csList = New List<Case>();
                    csList.add(csObj);
                    GE_OG_PCIntegrationUtility.notifyCaseInboundFailure(csList,'Error');
               /*----*/
               
                    /*Id wdrecTypeID= Schema.SObjectType.Case.getRecordTypeInfosByName().get('Usage/Consumption').getRecordTypeId();
                    SVMXC__Service_Order_Line__c objwd = new SVMXC__Service_Order_Line__c();
                    objwd.GE_SS_Related_Work_Order__c=objWo.Id;
                    objwd.recordtypeid=wdrecTypeID;
                    objwd.SVMXC__Line_Type__c='Labor';
                    objwd.SVMXC__Activity_Type__c = 'Install/Replace';
                    objwd.SVMXC__Line_Status__c='Sent to Oracle';
                    insert objwd;
                    
                    SVMXC__Service_Order_Line__c objWrkD = [Select Id, Name from  SVMXC__Service_Order_Line__c where id=:objwd.Id];
                    string inbwdbody= GE_OG_PCIntegrationUtility.getEmailBodyInbFailure(objWrkD);
                    GE_OG_PCIntegrationUtility.sendTemplatedEmail(UserInfo.getUserId(),'test','test',inbwdbody);*/
                    
                    string inbBody = GE_OG_PCIntegrationUtility.getEmailBodyInbFailure(objWo);  
                    GE_OG_PCIntegrationUtility.sendTemplatedEmail(UserInfo.getUserId(),'test','test', inbBody);
                    GE_OG_PCIntegrationUtility.updateWOStatus(woIds,'Sent to Oracle'); 
                    List<SVMXC__Service_Order__c> woList = New List<SVMXC__Service_Order__c>();
                    woList.add(woObj);
                    GE_OG_PCIntegrationUtility.notifyInboundFailure(woList,'Error');
                    
                    
                    Id recType= Schema.SObjectType.Case.getRecordTypeInfosByName().get('FS-D&S').getRecordTypeId();
                    Case obj = new Case();
                    obj.Subject='Test';
                    obj.Description='Test Description';
                    obj.Status='New';
                    obj.Origin='Email';
                    obj.recordtypeid = recType;
                    obj.accountid=acc[0].Id; 
                    obj.GE_OG_DS_Region__c=null;
                    obj.GE_ES_Project_Number__c= null;
                    insert obj;
                    Case rec=[select id, CaseNumber  from Case where id=:obj.id]; 
                
                    SVMXC__Service_Order__c woObj1 = new SVMXC__Service_Order__c();   
                    woObj1.SVMXC__Site__c = loc.ID;
                    woObj1.SVMXC__Case__c = obj.Id;
                    woObj1.SVMXC__Order_Status__c = 'Open';
                    woObj1.GE_PC_Branch__c = 'Fairfield';
                    woObj1.SVMXC__Company__c = acc[0].ID;
                    woObj1.SVMXC__Skill__c = sk.Id;
                    woObj1.SVMXC__Closed_By__c=UserInfo.getUserId();
                    woObj1.GE_OG_Attachment_Id__c=sk.Id;
                    woObj1.SVMXC__Order_Type__c='Services';
                    insert woObj1;
                    
                    
                    GE_OG_PCIntegrationUtility.getDMZAccessToken();
                    SVMXC__Service_Order_Line__c wd = new SVMXC__Service_Order_Line__c();
                    List<SVMXC__Service_Order_Line__c> wdList = new List<SVMXC__Service_Order_Line__c>();
                    wd.SVMXC__Service_Order__c =woObj.id;
                    wd.SVMXC__Service_Order__r.SVMXC__Case__r.id =obj.id;                
                    wd.SVMXC__Product__c=null;
                    insert wd;
                    wdList.add(wd);
                    insert wdList;
                    
                    //GE_OG_PCIntegrationUtility.notifyInboundFailureWD(wdList,'Error');
                    //GE_OG_PCIntegrationUtility.getEmailBodyInbFailure(wd);    
                    //GE_OG_PCIntegrationUtility.getEmailBodyInbFailure(woObj1);
                    
                    SVMXC__Service_Order_Line__c wd1 = new SVMXC__Service_Order_Line__c();
                    List<SVMXC__Service_Order_Line__c> wdList1 = new List<SVMXC__Service_Order_Line__c>();
                    wd1.SVMXC__Service_Order__c =woObj.id;
                    wd1.SVMXC__Service_Order__r.SVMXC__Case__r.id =obj.id;                
                    wd1.GE_AL_MFL_Extended_Price_Labor__c =0.00;
                    wd1.SVMXC__Line_Type__c = 'Labor';
                    wd1.GE_SS_SO_Line_Number__c = 'Test LineNumber';
                    wd1.GE_DS_SO_line_status__c  = 'Open';                  
                    insert wd1;
                    wdList1.add(wd1);
                    //insert wdList1;
                    GE_OG_PCIntegrationUtility.validateWOPayload(account_x,retWOrder.Id);
                    
                    //Kamala
                    
                    //New Attachment
                  Attachment att1 = new Attachment();
                  att1.Name = String.valueOf(wd1.Id);            
                  att1.ContentType = 'application/pdf';
                  att1.Body = Blob.valueof('Test Attachment');
                  att1.ParentId = wd1.Id;
                  insert att1;
              
                  List<Attachment> retAtt1 = [Select id FROM Attachment WHERE Id=:att1.Id];
                    
                    string inbwdBody = GE_OG_PCIntegrationUtility.getEmailBodyInbFailure(wd1);  
                    GE_OG_PCIntegrationUtility.sendTemplatedEmail(UserInfo.getUserId(),'test','test', inbwdBody);
                    //GE_OG_PCIntegrationUtility.updateWOStatus(woIds,'Sent to Oracle'); 
                    
                    GE_OG_PCIntegrationUtility.insertLog('Dev','Test',logdate,wd1.ID);
                    GE_OG_PCIntegrationUtility.notifyInboundFailureWD(Wdlist1, 'Error');
                    
            
                    environ ='Dev';
                    soaep=GE_OG_PCIntegrationUtility.getEndpointBaseSOA(environ);
                    dmzep=GE_OG_PCIntegrationUtility.getEndpointBaseDMZ(environ);
                    AccessToken = GE_OG_PCIntegrationUtility.getDMZAccessToken();
                    
                    environ ='QA';
                    soaep=GE_OG_PCIntegrationUtility.getEndpointBaseSOA(environ);
                    dmzep=GE_OG_PCIntegrationUtility.getEndpointBaseDMZ(environ);
                    AccessToken = GE_OG_PCIntegrationUtility.getDMZAccessToken();
            
                    environ ='Prod';
                    soaep = GE_OG_PCIntegrationUtility.getEndpointBaseSOA(environ);
                    dmzep = GE_OG_PCIntegrationUtility.getEndpointBaseDMZ(environ);
                    AccessToken = GE_OG_PCIntegrationUtility.getDMZAccessToken();
                    test.stopTest();
        }
        catch(Exception e){
            System.debug('Exception :'+e.getMessage());
        }           
            
    }
     
}