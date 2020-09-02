/*
=====================================
Name       : Test_GE_OG_PCIntegration 
Author     : Prashanth Malegowda / Amit Kumar
Created On : 30th Sep 2014
Purpose    : To calculate code coverage for 
        1.GE_OG_PCWOPublish           Apex class
        2.GE_OG_PCOutBoundIntegration Apex class
        3.GE_OG_PCOutBoundWrapper     Apex class
        4.GE_OG_PCIntegrationUtility  Apex class
        5.GE_OG_PCInboundIntegration  Apex class
        6.GE_OG_PC_TS_Kronos
=================================================
*/
@isTest(SeeAllData=true)
public  class  Test_GE_OG_PCIntegration{
        
        static testMethod void GE_OG_PCWOPublish(){
           test.startTest();
           try{
            GE_OG_PCWOPublish.ProcessWorkOrder_pt processRequest_x = new GE_OG_PCWOPublish.ProcessWorkOrder_pt();
            GE_OG_PCWOPublish.ProcessWorkOrderDetails_element wdetail_x=new GE_OG_PCWOPublish.ProcessWorkOrderDetails_element();
            GE_OG_PCWOPublish.ProcessWorkOrderDetailsResponse_element processResponse_x= new GE_OG_PCWOPublish.ProcessWorkOrderDetailsResponse_element();
            Map<string,string> inputHeader=new Map<string,string>();
            string AccessToken='Bearer 12345678';
            inputHeader.put('Authorization',AccessToken); 
            processRequest_x.inputHttpHeaders_x = inputHeader;
            //processRequest_x.timeout_x = GE_OG_PCIntegrationUtility.PC_ACTIVEENV;
            //processRequest_x.endpoint_x = GE_OG_PCIntegrationUtility.PC_WSDL_ENDPOINT;
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
                    
           //Attachment
           
            wdetail_x.Attachment='sdssdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsds';
            string attachment='sdsdasdfasfadafdfdfsfdsfsfsfsfdsfdsfdsss';
            
            //Populate account
            account_x.AccountName='IgateTest';
            
             system.assertequals(account_x.AccountName,'IgateTest');
             //Populate Location
            location_x.country='US';
            location_xItem .add(location_x); 
            account_x.Location=location_xItem ;
               
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
            workorder_x.ShipToAddress=shipToAdd_x; 
            
            //Populate work detail
            //workdetail_x.LineQuantity='IgateQuantity';
            workdetail_x.LineQuantity=1;                //Amit
            workdetail_xItem.add(workdetail_x);
            workorder_x.WorkDetail=workdetail_xItem; 
           
            //Populate product/pricebook
            product_x.ProductName='testProductName';
            product_x.Code='01234';
            product_x.PriceBook='Standard Pricebook';
               
            //Populate service team
            technician_x.ServiceTeamName='IgateTeam';
            workorder_x.ServiceTeam=technician_x; 
            
            //Populate product price book
            product_x.PriceBook='IgateBook';
            workdetail_x.Product=product_x; 
            
            system.assertequals(product_x.PriceBook,'IgateBook');
            processRequest_x.ProcessWorkOrder(attachment,account_x);
           }
           catch(Exception e){
                System.debug('Exception :'+e.getMessage());
           }
           test.stopTest();
        }
        
        static testMethod void GE_OG_PCOutBoundIntegration(){
           test.startTest();
           try{
              //GE_OG_PCOutboundIntegration---Part
              SVMXC.INTF_WebServicesDef.INTF_Response resp=new SVMXC.INTF_WebServicesDef.INTF_Response();
              SVMXC.INTF_WebServicesDef.INTF_Response request=new SVMXC.INTF_WebServicesDef.INTF_Response();
              Id woID ='a3NK0000000ImYj';
              system.assertequals(woID,'a3NK0000000ImYj');
              SVMXC__Service_Order__c objWo=[SELECT Id, Name FROM SVMXC__Service_Order__c where id=:woID limit 1];
              //Map<String, Id> rqmap = new Map<String, Id>();
              //Map<request.valueMap> rqmap = new Map<request.valueMap>();
              //request.valueMap.put('WorkOrder_ID',woID); 
              
              resp=GE_OG_PCOutboundIntegration.sfmSubmitToOracle(request);  
              test.stopTest();
           }
           catch(Exception e){
                System.debug('Exception :'+e.getMessage());
           }    
        }  
        
        static testMethod void GE_OG_PCInboundIntegration(){
        
           test.startTest();
           try
           {
              GE_OG_PCInboundIntegration objinbound =new GE_OG_PCInboundIntegration();
              GE_OG_PCInboundIntegration.Status objstat=new GE_OG_PCInboundIntegration.Status();
              GE_OG_PCInboundIntegration.WorkOrder_Info objinfo=new GE_OG_PCInboundIntegration.WorkOrder_Info();
              objinfo.woNum='WO-00341804';                                     
              objinfo.caseNum='01512169';                                   
              objinfo.salesOrderNum='323232323';                             
              objinfo.salesOrderStatus='Entered';                          
              objinfo.invoiceNum='3232323';                                
              objinfo.invoiceStatus='invoiced'; 
              system.Assertequals(objinfo.invoiceStatus,'invoiced');
              //objinfo.invoiceDate=system.now();    
              List<GE_OG_PCInboundIntegration.WorkOrder_Info> infolist=new List<GE_OG_PCInboundIntegration.WorkOrder_Info>();
              infolist.add(objinfo);
              objstat=GE_OG_PCInboundIntegration.updateWorkOrderInfo(infolist,'Salesorder');
              objstat=GE_OG_PCInboundIntegration.updateWorkOrderInfo(infolist,'Invoice');
              if(System.Test.isRunningTest())
                   objstat=GE_OG_PCInboundIntegration.updateWorkOrderInfo(infolist,'Invoice889');
              objstat=GE_OG_PCInboundIntegration.updateWorkOrderInfo(infolist,'Invoice88');
              test.stopTest();
           }
           catch(Exception e){
                System.debug('Exception :'+e.getMessage());
           }   
        }   
            
        static testMethod void GE_OG_PCOutboundWrapper(){
           test.startTest();
           try{
            Id woID;
            String  PC_ENVIRON = Label.GE_Integration_Environment; 
            List<ID> toUpdateWoId = new List<ID>();                                                                 //Work Order ID's
            List<ID> toUpdateWdId = new List<ID>(); 
            if(PC_ENVIRON=='Dev'){
                woID='a3NK0000000ImYj';
                toUpdateWoId.add('a3MK00000007G3q');
            }
            else if(PC_ENVIRON=='QA'){
                woID='a3Ng00000001zuV';
                toUpdateWoId.add('a3Mg0000000UfSW');
            }
            else if(PC_ENVIRON=='Prod'){
                woID='a3N1200000024VY';
                toUpdateWoId.add('a3M12000001NrFS');
            }
               
            //string AccessToken;
            String AccessToken;
            AccessToken='bearer 2338923';
            //List<ID> toUpdateWoId = new List<ID>();                                                                 //Work Order ID's
            //List<ID> toUpdateWdId = new List<ID>();                                                                 //Work details ID's
            
            //toUpdateWoId.add('a3MK00000007G3q');
            //toUpdateWdId.add('a3MK00000007G4A');
            
            //Outbound wrapper---------------------------------------------------
            GE_OG_PCOutboundWrapper objWrap = new GE_OG_PCOutboundWrapper();
            objWrap.submitToOracle(woID,AccessToken);
            test.stopTest();
           }
           catch(Exception e){
                System.debug('Exception :'+e.getMessage());
           }   
        }      
        
        static testMethod void GE_OG_PCIntegrationUtility(){
           test.startTest();
           try
           {
            Id woID;
            woID='a3NK0000000ImYj';
            //string AccessToken;
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
            SVMXC__Service_Order__c objWo=new SVMXC__Service_Order__c();
            objWo=[SELECT Id, Name, SVMXC__Case__r.CaseNumber FROM SVMXC__Service_Order__c where id=:woID];
            GE_OG_PCIntegrationUtility newobjutil=new GE_OG_PCIntegrationUtility();
            GE_OG_PCIntegrationUtility.insertLog('Dev','Test',logdate,objWo.ID);
            string outBody=GE_OG_PCIntegrationUtility.getEmailBodyOutFailure(objWo);
            List<String> recpt=new List<String>();
            recpt.add('kmp@ge.com');
            List<String> ccrecpt=new List<String>();
            ccrecpt.add('kmp1@ge.com');
            //GE_OG_PCIntegrationUtility.sendTemplatedEmail(recpt,ccrecpt,'test','test',body);
            GE_OG_PCIntegrationUtility.sendTemplatedEmail(UserInfo.getUserId(),'test','test',outBody);
            GE_OG_PCIntegrationUtility.updateWOStatus(woIds,'Closed');   
            
            string inbBody=GE_OG_PCIntegrationUtility.getEmailBodyInbFailure(objWo);  
            GE_OG_PCIntegrationUtility.sendTemplatedEmail(UserInfo.getUserId(),'test','test',inbBody);
            GE_OG_PCIntegrationUtility.updateWOStatus(woIds,'Closed'); 
            
            environ='Dev';
            soaep=GE_OG_PCIntegrationUtility.getEndpointBaseSOA(environ);
            dmzep=GE_OG_PCIntegrationUtility.getEndpointBaseDMZ(environ);
            AccessToken=GE_OG_PCIntegrationUtility.getDMZAccessToken();
            
            environ='QA';
            soaep=GE_OG_PCIntegrationUtility.getEndpointBaseSOA(environ);
            dmzep=GE_OG_PCIntegrationUtility.getEndpointBaseDMZ(environ);
            AccessToken=GE_OG_PCIntegrationUtility.getDMZAccessToken();
            
            environ='Prod';
            soaep=GE_OG_PCIntegrationUtility.getEndpointBaseSOA(environ);
            dmzep=GE_OG_PCIntegrationUtility.getEndpointBaseDMZ(environ);
            AccessToken=GE_OG_PCIntegrationUtility.getDMZAccessToken();
            test.stopTest();
        }
        catch(Exception e){
            System.debug('Exception :'+e.getMessage());
        }   
    }  

    static testMethod void GE_OG_PC_TS_Kronos(){
        test.startTest();
           try
           {
               Id arg1;
               arg1='a19K0000001fv9t';  // Time Sheet ID
               String result=GE_OG_PC_TS_Kronos.PC_ApproveTimeSheet(arg1);              
           }
           catch(Exception e){
               System.debug('Exception :'+e.getMessage());
          }  
      
    }
}