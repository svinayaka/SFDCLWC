/*
=======================================================================================================================================
Name       : TEST_GE_OG_PCOutboundWrapper 
Author     : Amit Kumar
Created On : 15th May 2015
Purpose    : To calculate code coverage for "GE_OG_PCOutboundWrapper"  Apex class
======================================================================================================================================
*/
@isTest(SeeAllData=true)
public class TEST_GE_OG_PCOutboundWrapper {
static testMethod void GE_OG_PCOutboundWrapper_ShipToAL(){
           test.startTest();
           try{
               Id woID;
              String  PC_ENVIRON = Label.GE_Integration_Environment; 
              List<ID> toUpdateWoId = new List<ID>();                                                                 //Work Order ID's  
              List<ID> toUpdateWdId = new List<ID>(); 
              //GE_OG_PCOutboundWrapper refObj = new GE_OG_PCOutboundWrapper();
            
              //New Location
              SVMXC__Site__c loc = new SVMXC__Site__c();
              loc.Name='Test Location'+system.now();
              loc.GE_AL_Well_Type__c='Drilling';
              insert loc;
                 
             
                 
              //Account Data Helper
              List<Account> acc= [Select id, Name, GE_HQ_DUNS_Number__c from Account where GE_HQ_Request_Status__c='CMF Approved' LIMIT 1];
             
              Id recTypeID= Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('SS-Mobilize').getRecordTypeId(); 
              RecordType rt = [Select id,Name From RecordType Where sObjectType = 'SVMXC__Service_Order__c' and RecordType.Name = 'SS-Mobilize'];
              //New Work Order                          
              SVMXC__Service_Order__c woObj = new SVMXC__Service_Order__c();   
              woObj.SVMXC__Site__c = loc.ID;
              woObj.SVMXC__Order_Status__c = 'Open';
              woObj.GE_PC_Branch__c = 'MCR(C22)';
              woObj.SVMXC__Company__c = acc[0].ID;
              woObj.GE_OG_AL_Ship_to_Account_Number__c = acc[0].ID;
              woObj.SVMXC__Street__c = 'Test Street';
              woObj.SVMXC__City__c = 'Test City';
              woObj.SVMXC__State__c = 'Test State';
              woObj.SVMXC__Zip__c = '77041';
              woObj.SVMXC__Country__c = 'United States';
              woObj.GE_PC_Phone_Number__c = '18324761123';
              woObj.SVMXC__Work_Performed__c = 'Test';     
              woObj.GE_SS_Customer_PO_number__c = '5555';
              woObj.GE_SS_Payment_Terms_Days_Net__c = 'NET 30';
              woObj.SVMXC__Order_Type__c = 'Services';
              woObj.RecordTypeId = rt.Id;
              insert woObj;
              
              
              
              String recordType= 'SS-Mobilize';
               //string AccessToken;
              String AccessToken;
              AccessToken='bearer 2338923';
          
              GE_OG_PCOutboundWrapper objWrap = new GE_OG_PCOutboundWrapper();
              objWrap.createProject(woObj.id,AccessToken,recordType);
              objWrap.updateWDStatus();
                  
              
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
              GE_OG_PCOutboundWrapper refObj = new GE_OG_PCOutboundWrapper();
              refObj.updateWDStatus();
            
              //New Location
              SVMXC__Site__c loc = new SVMXC__Site__c();
              loc.Name='Test Location'+system.now();
              loc.GE_AL_Well_Type__c='Drilling';
              insert loc;
             
                
              //Account Data Helper
              List<Account> acc= [Select id, Name, GE_HQ_DUNS_Number__c from Account where GE_HQ_Request_Status__c='CMF Approved' LIMIT 1];
              GE_OG_PCIntegrationUtility.ValidationResult validation_x = new  GE_OG_PCIntegrationUtility.ValidationResult();            
              //New Case              
              Id recTypeID= Schema.SObjectType.Case.getRecordTypeInfosByName().get('FS-PC').getRecordTypeId();// FS-PC
              /*Case csObj = new Case();
              csObj.Subject='Test';
              csObj.Description='Test Description';
              csObj.Status='New';
              csObj.Origin='Email';
              csObj.GE_PC_Branch__c='Fairfield';
              csObj.recordtypeid = recTypeID;
              csObj.accountid=Acc.Id; 
              csObj.GE_PW_PO__c='1234';
              insert csObj;
              Case retCs=[select id, CaseNumber  from Case where id=:csObj.id];*/
              
            
              
              List<Case> retCs=[select id, CaseNumber, GE_PW_PO__c from Case where RecordTypeId=:recTypeID LIMIT 1];
              System.debug('Befor Updating Case');
              retCs[0].accountid = acc[0].Id; 
              retCs[0].GE_PW_PO__c = '1234';
              retCs[0].GE_OG_DS_Bill_To_Address__c = 'Test Bill To Address';
              update retCs;               
              System.debug('Case-->'+retCs);
              
              //New Skill
              SVMXC__Skill__c sk = new SVMXC__Skill__c();
              sk.Name='Test Skill';
              insert sk;
              
            RecordType rt1 = [Select id,Name From RecordType Where sObjectType = 'SVMXC__Service_Order__c' and RecordType.Name = 'PC'];
            String recTypeName = rt1.Name;
              
              //RecordType rt = [SELECT Id FROM RecordType WHERE DeveloperName = 'D_S' AND sObjectType = 'SVMXC__Service_Order__c' LIMIT 1];  
                Id rt = Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('PC').getRecordTypeId();              
                //Id rt = Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('SS-Mobilize').getRecordTypeId();              
              //New Work Order                          
              SVMXC__Service_Order__c woObj = new SVMXC__Service_Order__c();   
              woObj.SVMXC__Site__c = loc.ID;
              woObj.SVMXC__Case__c = retCs[0].Id;
              woObj.SVMXC__Order_Status__c = 'Open';
              woObj.GE_PC_Branch__c = 'Fairfield';
              woObj.SVMXC__Company__c = acc[0].ID;
              woObj.SVMXC__Skill__c = sk.Id;
              woObj.GE_PC_Ship_to_Account__c = acc[0].ID;
              woObj.SVMXC__Street__c = 'Test Street';
              woObj.SVMXC__City__c = 'Test City';
              woObj.SVMXC__State__c = 'Test State';
              woObj.SVMXC__Zip__c = '77041';
              woObj.SVMXC__Country__c = 'United States';
              woObj.GE_PC_Phone_Number__c = '18324761123';
              woObj.SVMXC__Work_Performed__c = 'Test';     
              woObj.GE_SS_Customer_PO_number__c = '5555';
              woObj.GE_OG_Attachment_Id__c = sk.Id;
              woObj.RecordTypeId = rt1.Id;
              insert woObj;
              SVMXC__Service_Order__c retWOrder = [Select id, Name, SVMXC__Case__r.CaseNumber FROM SVMXC__Service_Order__c WHERE id=:woObj.Id ];
              System.debug('WorkOrder-->' +retWOrder);
              
              //New Attachment
              Attachment att = new Attachment();
              att.Name = String.valueOf(retWOrder.Id);
              att.ContentType = 'application/pdf';
              att.Body = Blob.valueof('Test Attachment');
              att.ParentId = retWOrder.Id;
              insert att;
              Attachment retAtt = [Select id, Name FROM Attachment WHERE id=:att.Id ];
              System.debug('Attachment--> '+retAtt);
              
               
              //New Part
              Product2 prod = new Product2();
              prod.Name  = 'FsoTypeAttach';
              prod.ProductCode = '1234';
              prod.GE_ES_P_L__c = 'D&S - PC';
              insert prod;
              Product2 retProd = [Select id, Name, ProductCode, GE_ES_P_L__c FROM Product2 WHERE id=:prod.Id ];
              System.debug('Product-->'+retProd);
              
               
              //New Work Detail
              SVMXC__Service_Order_Line__c wodet = new SVMXC__Service_Order_Line__c();
              wodet.SVMXC__Line_Type__c  = 'Parts';
              wodet.SVMXC__Product__c = retProd.Id;
              wodet.SVMXC__Actual_Quantity2__c = 10.00;
              wodet.SVMXC__Actual_Price2__c = 12.50;
              wodet.SVMXC__Line_Status__c = 'Open';
              wodet.SVMXC__Start_Date_and_Time__c = Datetime.newInstance(system.today().year(), system.today().month(), system.today().day() - 1, 1, 0, 0);
              wodet.SVMXC__End_Date_and_Time__c = Datetime.newInstance(system.today().year(), system.today().month(), system.today().day() + 1, 1, 0, 0);
              wodet.SVMXC__Service_Order__c = retWOrder.Id;             
              insert wodet;
             
               
              //New Work Detail
              SVMXC__Service_Order_Line__c wodet1 = new SVMXC__Service_Order_Line__c();
              wodet1.SVMXC__Line_Type__c  = 'Labor';
              wodet1.SVMXC__Product__c = retProd.Id;
              wodet1.SVMXC__Actual_Quantity2__c = 10.00;
              wodet1.SVMXC__Actual_Price2__c = 12.50;
              wodet1.SVMXC__Line_Status__c = 'Open';             
              wodet1.SVMXC__Start_Date_and_Time__c = Datetime.newInstance(system.today().year(), system.today().month(), system.today().day() - 1, 1, 0, 0);
              wodet1.SVMXC__End_Date_and_Time__c = Datetime.newInstance(system.today().year(), system.today().month(), system.today().day() + 1, 1, 0, 0);
              wodet.GE_PC_Flat_Rate__c = TRUE;
              wodet.GE_PC_Number_of_Days__c = 2;    
              wodet1.SVMXC__Service_Order__c = retWOrder.Id;
              insert wodet1;
              
              SVMXC__Service_Order_Line__c retWdet = [Select id, Name, SVMXC__Line_Type__c, SVMXC__Actual_Quantity2__c, SVMXC__Actual_Price2__c, SVMXC__Line_Status__c  FROM SVMXC__Service_Order_Line__c WHERE id=:wodet.Id ];
              System.debug('WorkDetail--> ' +retWdet);

              
              //string AccessToken;
              String AccessToken;
              AccessToken='bearer 2338923';
          
              GE_OG_PCOutboundWrapper objWrap = new GE_OG_PCOutboundWrapper();
              woID = retWOrder.Id;
              toUpdateWoId.add(woID);
              objWrap.submitToOracle(woID,AccessToken);
              objWrap.updateWDStatus();
              objWrap.bindWorkDetail(wodet,recTypeName);
              

                           
                test.stopTest();
           }
           catch(Exception e){
                System.debug('Exception :'+e.getMessage());
           } 
        }

      static testMethod void GE_OG_PCOutboundWrapper3(){
           test.startTest();
           try{
              Id woID;              
              String  PC_ENVIRON = Label.GE_Integration_Environment; 
              List<ID> toUpdateWoId = new List<ID>();                                                                 //Work Order ID's  
              List<ID> toUpdateWdId = new List<ID>(); 
              GE_OG_PCOutboundWrapper refObj = new GE_OG_PCOutboundWrapper();
              String recordTypeName = 'FS-D&S';
              //New Location
              SVMXC__Site__c loc = new SVMXC__Site__c();
              loc.Name='Test Location'+system.now();
              loc.GE_AL_Well_Type__c='Drilling';
              insert loc;
                                                
              //Account Data Helper
              List<Account> acc= [Select id, Name, GE_HQ_DUNS_Number__c from Account where GE_HQ_Request_Status__c='CMF Approved' LIMIT 1];
                           
              //New Case              
              Id recTypeID= Schema.SObjectType.Case.getRecordTypeInfosByName().get('FS-D&S').getRecordTypeId();// FS-PC
              
              recordTypeName = Schema.SObjectType.Account.getRecordTypeInfosByName().get('FS-D&S').getRecordTypeId();
              
              
              List<Case> retCs=[select id, CaseNumber, SVMXC__Billing_Type__c, GE_PW_PO__c from Case where RecordTypeId=:recTypeID AND SVMXC__Billing_Type__c = 'Commissioning' LIMIT 1];
              System.debug('Befor Updating Case');
              retCs[0].accountid = acc[0].Id; 
              retCs[0].GE_PW_PO__c = '1234';
              retCs[0].GE_OG_DS_Bill_To_Address__c = 'Test Bill To Address';
              update retCs;               
              System.debug('Case-->'+retCs);
              
              //New Skill
              SVMXC__Skill__c sk = new SVMXC__Skill__c();
              sk.Name='Test Skill';
              insert sk;
                  
              Case csObj = new Case();
               
              csObj.Subject='Test';
              csObj.Description='Test Description';
              csObj.Status='New';
              csObj.Origin='Email';
              csObj.GE_PC_Branch__c='Fairfield';
              csObj.recordtypeid = recTypeID;
              csObj.Accountid=acc[0].Id; 
              csObj.GE_PW_PO__c='1234';
              csObj.SVMXC__Billing_Type__c ='Commissioning';
              insert csObj;
              Case retCs1=[select id, CaseNumber  from Case where id=:csObj.id];
              
              RecordType rt1 = [Select id,Name From RecordType Where sObjectType = 'SVMXC__Service_Order__c' and RecordType.Name = 'D&S'];
              String recTypeName = rt1.Name;
              
             // RecordType rt = [SELECT Id FROM RecordType WHERE DeveloperName = 'D&S' AND sObjectType = 'SVMXC__Service_Order__c' LIMIT 1];
             Id rt = Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('D&S').getRecordTypeId();
              //New Work Order                          
              SVMXC__Service_Order__c woObj = new SVMXC__Service_Order__c();   
              woObj.SVMXC__Site__c = loc.ID;
              woObj.SVMXC__Case__c = retCs[0].Id;
              woObj.SVMXC__Order_Status__c = 'Open';
              woObj.GE_PC_Branch__c = 'Fairfield';
              woObj.SVMXC__Company__c = acc[0].ID;
              woObj.SVMXC__Skill__c = sk.Id;
              woObj.GE_PC_Ship_to_Account__c = acc[0].ID;
              woObj.SVMXC__Street__c = 'Test Street';
              woObj.SVMXC__City__c = 'Test City';
              woObj.SVMXC__State__c = 'Test State';
              woObj.SVMXC__Zip__c = '77041';
              woObj.SVMXC__Country__c = 'United States';
              woObj.GE_PC_Phone_Number__c = '18324761123';
              woObj.SVMXC__Work_Performed__c = 'Test';     
              woObj.GE_SS_Customer_PO_number__c = '5555';
              woObj.GE_OG_Attachment_Id__c = sk.Id;
              woObj.RecordTypeId = rt1.Id;
              insert woObj;
              SVMXC__Service_Order__c retWOrder = [Select id, Name, SVMXC__Case__r.CaseNumber FROM SVMXC__Service_Order__c WHERE id=:woObj.Id ];
              System.debug('WorkOrder-->' +retWOrder);
              
              //New Attachment
              Attachment att = new Attachment();
              att.Name = String.valueOf(retWOrder.Id);
              att.ContentType = 'application/pdf';
              att.Body = Blob.valueof('Test Attachment');
              att.ParentId = retWOrder.Id;
              insert att;
              Attachment retAtt = [Select id, Name FROM Attachment WHERE id=:att.Id ];
              System.debug('Attachment--> '+retAtt);
              
               
              //New Part
              Product2 prod = new Product2();
              prod.Name  = 'FsoTypeAttach';
              prod.ProductCode = '1234';
              prod.GE_ES_P_L__c = 'D&S - PC';
              insert prod;
              Product2 retProd = [Select id, Name, ProductCode, GE_ES_P_L__c FROM Product2 WHERE id=:prod.Id ];
              System.debug('Product-->'+retProd);
              
               
              //New Work Detail
              //Set<ID> wdset = new Set<ID>();
              SVMXC__Service_Order_Line__c wodet = new SVMXC__Service_Order_Line__c();
              wodet.SVMXC__Line_Type__c  = 'Labor';
              wodet.SVMXC__Product__c = retProd.Id;
              wodet.SVMXC__Actual_Quantity2__c = 10.00;
              wodet.SVMXC__Actual_Price2__c = 12.50;
              wodet.SVMXC__Line_Status__c = 'Open';
              wodet.GE_AL_MFL_Extended_Price_Labor__c=100.00;
              wodet.GE_PC_Flat_Rate__c = TRUE;
              wodet.SVMXC__Start_Date_and_Time__c = Datetime.newInstance(system.today().year(), system.today().month(), system.today().day() - 1, 1, 0, 0);
              wodet.SVMXC__End_Date_and_Time__c = Datetime.newInstance(system.today().year(), system.today().month(), system.today().day() + 1, 1, 0, 0);
              wodet.SVMXC__Service_Order__c = retWOrder.Id;
              insert wodet;
              
            //  SVMXC__Service_Order_Line__c retWdet = [Select id, Name, SVMXC__Line_Type__c, SVMXC__Actual_Quantity2__c,SVMXC__Actual_Price2__c, SVMXC__Line_Status__c  FROM SVMXC__Service_Order_Line__c WHERE id=: wodet];
            //  System.debug('WorkDetail--> ' +retWdet);
               
          
              
              //string AccessToken;
              String AccessToken;
              AccessToken='bearer 2338923';
          
              GE_OG_PCOutboundWrapper objWrap = new GE_OG_PCOutboundWrapper();
              woID = woObj.Id;
              toUpdateWoId.add(woID);
              objWrap.submitToOracle(woID,AccessToken);
              objWrap.updateWDStatus();
              objWrap.bindWorkDetail(wodet,recTypeName);
              //String recordTypeName = 'FS-D&S';
              GE_OG_PCIntegrationUtility.updateWOStatus(toUpdateWoId, GE_OG_PCIntegrationUtility.DS_WO_OUTBOUND_STATUS);
              GE_OG_PCIntegrationUtility.ValidationResult validation_x = new  GE_OG_PCIntegrationUtility.ValidationResult();
              
              test.stopTest();
           }
           catch(Exception e){
                System.debug('Exception :'+e.getMessage());
           } 
      }
      
      static testMethod void GE_OG_PCOutboundWrapper1(){
           test.startTest();
           try{
              Id woID;
              String  PC_ENVIRON = Label.GE_Integration_Environment; 
              List<ID> toUpdateWoId = new List<ID>();                                                                 //Work Order ID's  
              List<ID> toUpdateWdId = new List<ID>(); 
              //GE_OG_PCOutboundWrapper refObj = new GE_OG_PCOutboundWrapper();
            
              //New Location
              SVMXC__Site__c loc = new SVMXC__Site__c();
              loc.Name='Test Location'+system.now();
              loc.GE_AL_Well_Type__c='Drilling';
              insert loc;
                                                
              //Account Data Helper
              List<Account> acc= [Select id, Name, GE_HQ_DUNS_Number__c from Account where GE_HQ_Request_Status__c='CMF Approved' LIMIT 1];
                           
              //New Case              
              Id recTypeID= Schema.SObjectType.Case.getRecordTypeInfosByName().get('FS-D&S').getRecordTypeId();
              String recordTypeName = 'FS-D&S';
              GE_OG_PCIntegrationUtility.updateWOStatus(toUpdateWoId, GE_OG_PCIntegrationUtility.DS_WO_OUTBOUND_STATUS);
              GE_OG_PCIntegrationUtility.ValidationResult validation_x = new  GE_OG_PCIntegrationUtility.ValidationResult(); 
              
              Case csObj = new Case();
              csObj.Subject='Test';
              csObj.Description='Test Description';
              csObj.Status='New';
              csObj.Origin='Email';
              csObj.GE_PC_Branch__c='Fairfield';
              csObj.recordtypeid = recTypeID;
              csObj.accountid=Acc[0].Id; 
              csObj.GE_PW_PO__c='1234';
              insert csObj;
              
             system.debug('case details'+csobj.Recordtype.name);
                          
              //string AccessToken;
              String AccessToken;
              AccessToken='bearer 2338923';
              
              String recordType= 'SS-Mobilize';
          
              GE_OG_PCOutboundWrapper objWrap = new GE_OG_PCOutboundWrapper();
              objWrap.updateWDStatus();
              
              objWrap.createProject(csObj.Id,AccessToken,recordType);
                  
              
                test.stopTest();
           }
           catch(Exception e){
                System.debug('Exception :'+e.getMessage());
           } 
      }
      
      static testMethod void GE_OG_PCOutboundWrapper2(){
           test.startTest();
           try{
              Id woID;
              String  PC_ENVIRON = Label.GE_Integration_Environment; 
              List<ID> toUpdateWoId = new List<ID>();                                                                 //Work Order ID's  
              List<ID> toUpdateWdId = new List<ID>(); 
              //GE_OG_PCOutboundWrapper refObj = new GE_OG_PCOutboundWrapper();
            
              //New Location
              SVMXC__Site__c loc = new SVMXC__Site__c();
              loc.Name='Test Location'+system.now();
              loc.GE_AL_Well_Type__c='Drilling';
              insert loc;
                                                
              //Account Data Helper
              List<Account> acc= [Select id, Name, GE_HQ_DUNS_Number__c from Account where GE_HQ_Request_Status__c='CMF Approved' LIMIT 1];
              RecordType rt2 = [Select id,Name From RecordType Where sObjectType = 'Case' and RecordType.Name = 'FS-D&S'];
                
                           
                           
              //New Case              
              Id recTypeID= Schema.SObjectType.Case.getRecordTypeInfosByName().get('D&S').getRecordTypeId();
              Case csObj = new Case();
              csObj.Subject='Test';
              csObj.Description='Test Description';
              csObj.Status='New';
              csObj.Origin='Email';
              csObj.GE_PC_Branch__c='Fairfield';
              csObj.recordtypeid = rt2.Id;
              csObj.accountid=Acc[0].Id; 
              csObj.GE_PW_PO__c='1234';
              insert csObj;
              System.debug('Case--> '+csObj);
              System.debug('rt2@@@ '+csObj.recordtypeid);
              
            //New Skill
              SVMXC__Skill__c sk = new SVMXC__Skill__c();
              sk.Name='Test Skill';
              insert sk;
               
              RecordType rt1 = [Select id,Name From RecordType Where sObjectType = 'SVMXC__Service_Order__c' and RecordType.Name = 'D&S'];
              String recTypeName = rt1.Name;
               
              Id recTypeID2= Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('D&S').getRecordTypeId(); 
              //New Work Order                          
              SVMXC__Service_Order__c woObj = new SVMXC__Service_Order__c();   
              woObj.SVMXC__Site__c = loc.ID;
              woObj.SVMXC__Case__c = csObj.Id;
              woObj.SVMXC__Order_Status__c = 'Open';
              woObj.GE_PC_Branch__c = 'Fairfield';
              woObj.SVMXC__Company__c = csObj.ID;
              woObj.SVMXC__Skill__c = sk.Id;
              woObj.GE_PC_Ship_to_Account__c = acc[0].ID;
              woObj.SVMXC__Street__c = 'Test Street';
              woObj.SVMXC__City__c = 'Test City';
              woObj.SVMXC__State__c = 'Test State';
              woObj.SVMXC__Zip__c = '77041';
              woObj.SVMXC__Country__c = 'United States';
              woObj.GE_PC_Phone_Number__c = '18324761123';
              woObj.SVMXC__Work_Performed__c = 'Test';     
              woObj.GE_SS_Customer_PO_number__c = '5555';
              woObj.GE_OG_Attachment_Id__c = sk.Id;
              woObj.recordtypeid=rt1.Id;
              insert woObj;
              String recordTypeName = 'D&S';
              
              SVMXC__Service_Order__c retWOrder = [Select id, Name, SVMXC__Case__r.CaseNumber FROM SVMXC__Service_Order__c WHERE id=:woObj.Id ];
              System.debug('WorkOrder-->' +retWOrder);
              
              //New Attachment
              Attachment att = new Attachment();
              att.Name = String.valueOf(retWOrder.Id);
              att.ContentType = 'application/pdf';
              att.Body = Blob.valueof('Test Attachment');
              att.ParentId = retWOrder.Id;
              insert att;
              
              
              Attachment retAtt = [Select id, Name FROM Attachment WHERE id=:att.Id ];
              System.debug('Attachment--> '+retAtt);
              //New Part
              Product2 prod = new Product2();
              prod.Name  = 'FsoTypeAttach';
              prod.ProductCode = '1234';
              prod.GE_ES_P_L__c = 'D&S - PC';
              prod.RecordType.Name = 'ServiceMax';
              insert prod;
              Product2 retProd = [Select id, Name, ProductCode, GE_ES_P_L__c FROM Product2 WHERE id=:prod.Id ];
              System.debug('Product-->'+retProd);
              
             
               //New Work Detail
               
              SVMXC__Service_Order_Line__c wodet = new SVMXC__Service_Order_Line__c();
              wodet.SVMXC__Line_Type__c  = 'Labor';
             // wodet.SVMXC__Product__c = retProd.Id;
              wodet.GE_AL_MFL_Extended_Price_Labor__c=100.00;
              wodet.SVMXC__Product__c = retProd.Id;
              wodet.SVMXC__Actual_Quantity2__c = 10.00;
              wodet.GE_PC_Flat_Rate__c = TRUE;
              wodet.SVMXC__Actual_Price2__c = 12.50;
              wodet.SVMXC__Line_Status__c = 'Open';
              wodet.SVMXC__Start_Date_and_Time__c = Datetime.newInstance(system.today().year(), system.today().month(), system.today().day() - 1, 1, 0, 0);
              wodet.SVMXC__End_Date_and_Time__c = Datetime.newInstance(system.today().year(), system.today().month(), system.today().day() + 1, 1, 0, 0);
              wodet.SVMXC__Service_Order__c = retWOrder.Id;
            //  wodet.recordtypeid=recTypeID1;
              insert wodet;
             system.debug('case details'+csobj.Recordtype.name);
                          
              //string AccessToken;
              String AccessToken;
              AccessToken='bearer 2338923';
          
              GE_OG_PCOutboundWrapper objWrap = new GE_OG_PCOutboundWrapper();
              objWrap.submitToOracle(woObj.id,AccessToken);
              objWrap.updateWDStatus();
              objWrap.bindWorkDetail(wodet,recTypeName);
              GE_OG_PCIntegrationUtility.updateWOStatus(toUpdateWoId, GE_OG_PCIntegrationUtility.DS_WO_OUTBOUND_STATUS);
              GE_OG_PCIntegrationUtility.ValidationResult validation_x = new  GE_OG_PCIntegrationUtility.ValidationResult(); 
                  
              
                test.stopTest();
           }
           catch(Exception e){
                System.debug('Exception :'+e.getMessage());
           } 
      }
      static testMethod void GE_OG_PCOutboundWrapper4(){
           test.startTest();
           try{
              Id woID;
              String  PC_ENVIRON = Label.GE_Integration_Environment; 
              List<ID> toUpdateWoId = new List<ID>();                                                                 //Work Order ID's  
              List<ID> toUpdateWdId = new List<ID>(); 
              //GE_OG_PCOutboundWrapper refObj = new GE_OG_PCOutboundWrapper();
              
            
              //New Location
              SVMXC__Site__c loc = new SVMXC__Site__c();
              loc.Name='Test Location'+system.now();
              loc.GE_AL_Well_Type__c='Drilling';
              insert loc;
                                                
              //Account Data Helper
              List<Account> acc= [Select id, Name, GE_HQ_DUNS_Number__c from Account where GE_HQ_Request_Status__c='CMF Approved' LIMIT 1];
                 
              RecordType rt1 = [Select id,Name From RecordType Where sObjectType = 'SVMXC__Service_Order__c' and RecordType.Name = 'SS-Mobilize'];
              
              String recTypeName = rt1.Name;
                 
              Id recTypeID= Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('SS-Mobilize').getRecordTypeId(); 
              //New Work Order                          
              SVMXC__Service_Order__c woObj = new SVMXC__Service_Order__c();   
              woObj.SVMXC__Site__c = loc.ID;
              woObj.SVMXC__Order_Status__c = 'Open';
              woObj.GE_PC_Branch__c = 'MCR(C22)';
              woObj.SVMXC__Company__c = acc[0].ID;
              woObj.GE_PC_Ship_to_Account__c = acc[0].ID;
              woObj.SVMXC__Street__c = 'Test Street';
              woObj.SVMXC__City__c = 'Test City';
              woObj.SVMXC__State__c = 'Test State';
              woObj.SVMXC__Zip__c = '77041';
              woObj.SVMXC__Country__c = 'United States';
              woObj.GE_PC_Phone_Number__c = '18324761123';
              woObj.SVMXC__Work_Performed__c = 'Test';     
              woObj.GE_SS_Customer_PO_number__c = '5555';
              woObj.GE_SS_Payment_Terms_Days_Net__c = 'NET 30';
              woObj.RecordTypeId = rt1.Id;
              insert woObj;
              String recordType= 'SS-Mobilize';
            
              
              SVMXC__Service_Order__c retWOrder = [Select id, Name, SVMXC__Case__r.CaseNumber FROM SVMXC__Service_Order__c WHERE id=:woObj.Id ];
              System.debug('WorkOrder-->' +retWOrder);
              
              //New Attachment
              Attachment att = new Attachment();
              att.Name = String.valueOf(retWOrder.Id);
              att.ContentType = 'application/pdf';
              att.Body = Blob.valueof('Test Attachment');
              att.ParentId = retWOrder.Id;
              insert att;
              
              
              Attachment retAtt = [Select id, Name FROM Attachment WHERE id=:att.Id ];
              System.debug('Attachment--> '+retAtt);
              //New Part
              Product2 prod = new Product2();
              prod.Name  = 'FsoTypeAttach';
              prod.ProductCode = '1234';
              prod.GE_ES_P_L__c = 'D&S - PC';
              prod.RecordType.Name = 'ServiceMax';
              insert prod;
              Product2 retProd = [Select id, Name, ProductCode, GE_ES_P_L__c FROM Product2 WHERE id=:prod.Id ];
              System.debug('Product-->'+retProd);
              
              Id recTypeIDwd= Schema.SObjectType.SVMXC__Service_Order_Line__c.getRecordTypeInfosByName().get('Estimate').getRecordTypeId(); 
                                 
               //New Work Detail
              SVMXC__Service_Order_Line__c wodet = new SVMXC__Service_Order_Line__c();
              wodet.SVMXC__Line_Type__c  = 'Labor';
              wodet.GE_SS_Billable_Days__c = 1;
              wodet.CurrencyIsoCode ='British Pound';
              wodet.GE_DRL_Daily_Rate__c=100.00;
              wodet.SVMXC__Product__c = retProd.Id;             
              wodet.SVMXC__Actual_Quantity2__c = 10.00;
              wodet.SVMXC__Actual_Price2__c = 12.50;
              wodet.SVMXC__Line_Status__c = 'Open';
              wodet.GE_PC_Flat_Rate__c = TRUE;
              wodet.GE_SS_Service_Start_Date__c = Date.today() - 1;
              wodet.GE_SS_Service_End_Date__c= Date.today() + 1;
              wodet.SVMXC__Service_Order__c = retWOrder.Id;
              wodet.recordtypeid=recTypeIDwd;
              insert wodet;
                                      
              //string AccessToken;
              String AccessToken;
              AccessToken='bearer 2338923';
          
              GE_OG_PCOutboundWrapper objWrap = new GE_OG_PCOutboundWrapper();
              objWrap.submitToOracle(woObj.id,AccessToken);
              objWrap.updateWDStatus();
              objWrap.bindWorkDetail(wodet,recTypeName);
              
                test.stopTest();
           }
           catch(Exception e){
                System.debug('Exception :'+e.getMessage());
           } 
      }
       static testMethod void GE_OG_PCOutboundWrapper5(){
           test.startTest();
           try{
               Id woID;
              String  PC_ENVIRON = Label.GE_Integration_Environment; 
              List<ID> toUpdateWoId = new List<ID>();                                                                 //Work Order ID's  
              List<ID> toUpdateWdId = new List<ID>(); 
              //GE_OG_PCOutboundWrapper refObj = new GE_OG_PCOutboundWrapper();
            
              //New Location
              SVMXC__Site__c loc = new SVMXC__Site__c();
              loc.Name='Test Location'+system.now();
              loc.GE_AL_Well_Type__c='Drilling';
              insert loc;
                 
             
                 
              //Account Data Helper
              List<Account> acc= [Select id, Name, GE_HQ_DUNS_Number__c from Account where GE_HQ_Request_Status__c='CMF Approved' LIMIT 1];
             
              Id recTypeID= Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('SS-Mobilize').getRecordTypeId(); 
              RecordType rt = [Select id,Name From RecordType Where sObjectType = 'SVMXC__Service_Order__c' and RecordType.Name = 'SS-Mobilize'];
              //New Work Order                          
              SVMXC__Service_Order__c woObj = new SVMXC__Service_Order__c();   
              woObj.SVMXC__Site__c = loc.ID;
              woObj.SVMXC__Order_Status__c = 'Open';
              woObj.GE_PC_Branch__c = 'MCR(C22)';
              woObj.SVMXC__Company__c = acc[0].ID;
              woObj.GE_PC_Ship_to_Account__c = acc[0].ID;
              woObj.SVMXC__Street__c = 'Test Street';
              woObj.SVMXC__City__c = 'Test City';
              woObj.SVMXC__State__c = 'Test State';
              woObj.SVMXC__Zip__c = '77041';
              woObj.SVMXC__Country__c = 'United States';
              woObj.GE_PC_Phone_Number__c = '18324761123';
              woObj.SVMXC__Work_Performed__c = 'Test';     
              woObj.GE_SS_Customer_PO_number__c = '5555';
              woObj.GE_SS_Payment_Terms_Days_Net__c = 'NET 30';
              woObj.SVMXC__Order_Type__c = 'Services';
              woObj.RecordTypeId = rt.Id;
              insert woObj;
              
              
              
              String recordType= 'SS-Mobilize';
               //string AccessToken;
              String AccessToken;
              AccessToken='bearer 2338923';
          
              GE_OG_PCOutboundWrapper objWrap = new GE_OG_PCOutboundWrapper();
              objWrap.createProject(woObj.id,AccessToken,recordType);
              objWrap.updateWDStatus();
                  
              
                test.stopTest();
           }
           catch(Exception e){
                System.debug('Exception :'+e.getMessage());
           } 
       }
       //Start
       static testMethod void GE_OG_PCOutboundWrapper6(){
           test.startTest();
           try{
              Id woID;
              String  PC_ENVIRON = Label.GE_Integration_Environment; 
              List<ID> toUpdateWoId = new List<ID>();                                                                 //Work Order ID's  
              List<ID> toUpdateWdId = new List<ID>(); 
              //GE_OG_PCOutboundWrapper refObj = new GE_OG_PCOutboundWrapper();
            
              //New Location
              SVMXC__Site__c loc = new SVMXC__Site__c();
              loc.Name='Test Location'+system.now();
              loc.GE_AL_Well_Type__c='Drilling';
              insert loc;
                                                
              //Account Data Helper
              List<Account> acc= [Select id, Name, GE_HQ_DUNS_Number__c from Account where GE_HQ_Request_Status__c='CMF Approved' LIMIT 1];
             
              RecordType rt1 = [Select id,Name From RecordType Where sObjectType = 'SVMXC__Service_Order__c' and RecordType.Name = 'D&S'];
              String recTypeName = rt1.Name;
              RecordType rtProd = [Select id From RecordType Where sObjectType = 'Product2' and RecordType.Name = 'ServiceMax'];
              Id recTypeID = Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('D&S').getRecordTypeId(); 
              //New Work Order                          
              SVMXC__Service_Order__c woObj = new SVMXC__Service_Order__c();   
              woObj.SVMXC__Site__c = loc.ID;
              woObj.SVMXC__Order_Status__c = 'Open';
              woObj.GE_PC_Branch__c = 'MCR(C22)';
              woObj.SVMXC__Company__c = acc[0].ID;
              woObj.GE_PC_Ship_to_Account__c = acc[0].ID;
              woObj.SVMXC__Street__c = 'Test Street';
              woObj.SVMXC__City__c = 'Test City';
              woObj.SVMXC__State__c = 'Test State';
              woObj.SVMXC__Zip__c = '77041';
              woObj.SVMXC__Country__c = 'United States';
              woObj.GE_PC_Phone_Number__c = '18324761123';
              woObj.SVMXC__Work_Performed__c = 'Test';     
              woObj.GE_SS_Customer_PO_number__c = '5555';
              woObj.GE_SS_Payment_Terms_Days_Net__c = 'NET 30';
              woObj.SVMXC__Order_Type__c = 'Services';
              //woObj.recordtype.name = recTypeID;
              woObj.RecordTypeId = rt1.Id;
              
              insert woObj;
              
              Product2 prod = new Product2();
              prod.Name  = 'FsoTypeAttach';
              prod.ProductCode = '1234';
              prod.GE_ES_P_L__c = 'D&S - PC';
              prod.RecordTypeId = rtProd.Id;
              //prod.RecordType.Name = 'ServiceMax';
              System.debug('Product-->'+rtProd);
              insert prod;
              Product2 retProd = [Select id, Name, ProductCode, GE_ES_P_L__c FROM Product2 WHERE id=:prod.Id ];
              System.debug('Product-->'+retProd);
              
              Id recTypeIDwd= Schema.SObjectType.SVMXC__Service_Order_Line__c.getRecordTypeInfosByName().get('Estimate').getRecordTypeId(); 
                
               RecordType rtWod = [Select id From RecordType Where sObjectType = 'SVMXC__Service_Order_Line__c' and RecordType.Name = 'Estimate']; //New                
               //New Work Detail
              SVMXC__Service_Order_Line__c wodet = new SVMXC__Service_Order_Line__c();
              wodet.SVMXC__Line_Type__c  = 'Labor';
              wodet.GE_AL_MFL_Extended_Price_Labor__c=100.00;
              wodet.GE_SS_Billable_Days__c = 1;
              wodet.CurrencyIsoCode ='GBP';
              wodet.GE_DRL_Daily_Rate__c=100.00;
              wodet.SVMXC__Product__c = retProd.Id; 
              wodet.GE_PC_Flat_Rate__c = TRUE;            
              wodet.SVMXC__Actual_Quantity2__c = 10.00;
              wodet.SVMXC__Actual_Price2__c = 12.50;
              wodet.SVMXC__Line_Status__c = 'Open';
              wodet.GE_SS_Service_Start_Date__c = Date.today() - 1;
              wodet.GE_SS_Service_End_Date__c= Date.today() + 1;
              wodet.SVMXC__Service_Order__c = woObj.Id;
              wodet.RecordTypeId = rtWod.Id;
              //wodet.recordtypeid=recTypeIDwd;
              insert wodet;
              System.debug('Product-->'+rtWod);
              String recordType= 'SS-Mobilize';
              String recordType1= 'D&S';
               //string AccessToken;
              String AccessToken;
              AccessToken='bearer 2338923';
                
              GE_OG_PCOutboundWrapper objWrap = new GE_OG_PCOutboundWrapper();
              //objWrap.createProject(woObj.id,AccessToken,recordType);
              //objWrap.bindWorkDetail(wodet,recordType1);
              objWrap.updateWDStatus();
              objWrap.bindWorkDetail(wodet,recTypeName);
              String recordTypeName = 'FS-D&S';
              GE_OG_PCIntegrationUtility.updateWOStatus(toUpdateWoId, GE_OG_PCIntegrationUtility.DS_WO_OUTBOUND_STATUS);
              GE_OG_PCIntegrationUtility.ValidationResult validation_x = new  GE_OG_PCIntegrationUtility.ValidationResult();
              
                  
              
                test.stopTest();
           }
           catch(Exception e){
                System.debug('Exception :'+e.getMessage());
           } 
       }
static testMethod void GE_OG_PCOutboundWrapper7(){
                   
                List<Account> acc= [Select id, Name, GE_HQ_DUNS_Number__c from Account where GE_HQ_Request_Status__c='CMF Approved' LIMIT 1];
                List<ID> toUpdateWdId = new List<ID>();
                //New Location
                SVMXC__Site__c loc = new SVMXC__Site__c();
                loc.Name='Test Location'+system.now();
                loc.GE_AL_Well_Type__c='Drilling';
                insert loc;
                
                 RecordType rtCase = [Select id,Name From RecordType Where sObjectType = 'Case' and RecordType.Name = 'FS-D&S'];
                Id caseId = rtCase.Id;
                String caseRTName = rtCase.Name;
                  Case csObj = new Case();
                  csObj.Subject='Test';
                  csObj.Description='Test Description';
                  csObj.Status='New';
                  csObj.Origin='Email';
                  csObj.GE_PC_Branch__c='Fairfield';
                  csObj.RecordTypeId = rtCase.Id;
                  csObj.accountid = Acc[0].Id; 
                  csObj.GE_PW_PO__c='1234';
                  insert csObj;
RecordType rtProd = [Select id From RecordType Where sObjectType = 'Product2' and RecordType.Name = 'ServiceMax'];
                Product2 prod = new Product2();
                prod.Name  = 'FsoTypeAttach';
                prod.ProductCode = '1234';
                prod.GE_ES_P_L__c = 'D&S - PC';
                prod.RecordTypeId = rtProd.Id;
                insert prod;
                Product2 retProd = [Select id, Name, ProductCode, GE_ES_P_L__c FROM Product2 WHERE id=:prod.Id ];
                System.debug('Product-->'+retProd);

                Id recTypeID = Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('D&S').getRecordTypeId();
                System.debug('recTypeID'+recTypeID);
                RecordType rt = [Select id,Name From RecordType Where sObjectType = 'SVMXC__Service_Order__c' and RecordType.Name = 'D&S'];
                
                String recTypeName = rt.Name;
                //New Work Order                          
                SVMXC__Service_Order__c woObj = new SVMXC__Service_Order__c();   
                woObj.SVMXC__Site__c = loc.ID;
                woObj.SVMXC__Order_Status__c = 'Open';
                woObj.GE_PC_Branch__c = 'MCR(C22)';
                woObj.SVMXC__Company__c = acc[0].ID;
                woObj.GE_PC_Ship_to_Account__c = acc[0].ID;
                woObj.SVMXC__Street__c = 'Test Street';
                woObj.SVMXC__City__c = 'Test City';
                woObj.SVMXC__State__c = 'Test State';
                woObj.SVMXC__Zip__c = '77041';
                woObj.SVMXC__Country__c = 'United States';
                woObj.GE_PC_Phone_Number__c = '18324761123';
                woObj.SVMXC__Work_Performed__c = 'Test';     
                woObj.GE_SS_Customer_PO_number__c = '5555';
                //woObj.GE_SS_Payment_Terms_Days_Net__c = 'NET 30';
                woObj.SVMXC__Order_Type__c = 'Services';
                woObj.SVMXC__Skill__c = 'a3SA0000003gBIy';

                woObj.RecordTypeId = rt.Id;
                test.startTest();    
                insert woObj;
                               
                Id recTypeIDwd= Schema.SObjectType.SVMXC__Service_Order_Line__c.getRecordTypeInfosByName().get('Estimate').getRecordTypeId(); 
                RecordType rtWod = [Select id From RecordType Where sObjectType = 'SVMXC__Service_Order_Line__c' and RecordType.Name = 'Estimate']; //New Work Detail
                SVMXC__Service_Order_Line__c wodet = new SVMXC__Service_Order_Line__c();
                wodet.SVMXC__Line_Type__c  = 'Labor';
                wodet.GE_AL_MFL_Extended_Price_Labor__c = 100.00;
                wodet.GE_SS_Billable_Days__c = 1;
                wodet.GE_DS_Mark_up__c=25;
                wodet.CurrencyIsoCode = 'GBP';
                wodet.GE_DRL_Daily_Rate__c=100.00;
                wodet.SVMXC__Product__c = retProd.Id;             
                wodet.SVMXC__Actual_Quantity2__c = 10.00;
                wodet.SVMXC__Actual_Price2__c = 12.50;
                wodet.SVMXC__Line_Status__c = 'Open';
                wodet.GE_DS_Submit_to_Oracle__c = true;
                wodet.GE_PC_Flat_Rate__c = true;
                wodet.SVMXC__Billable_Quantity__c = 12;
                wodet.GE_DS_Non_Billable_Hours__c = 0;
                wodet.GE_DS_Overtime_Hrs__c = 0;
                wodet.GE_DRL_Daily_Rate__c = 1700;
                wodet.GE_DRL_Overtime__c = 0;
                wodet.GE_SS_Service_Start_Date__c = Date.today() - 1;
                wodet.GE_SS_Service_End_Date__c= Date.today() + 1;
                wodet.SVMXC__Service_Order__c = woObj.Id;
                wodet.RecordTypeId = rtWod.Id;
                insert wodet;
                test.stopTest(); 
                toUpdateWdId.add(wodet.Id);

                String recordTypeName= 'D&S';
                //string AccessToken;
                String AccessToken;
                AccessToken='bearer 2338923';


                GE_OG_PCOutboundWrapper objWrap = new GE_OG_PCOutboundWrapper();
                GE_OG_PCWOPublish.WorkDetail_element workdetail_x1 = new GE_OG_PCWOPublish.WorkDetail_element();
                workdetail_x1.LineQuantity = wodet.SVMXC__Actual_Quantity2__c;                                           //Line Quantity
                workdetail_x1.LineNumber = wodet.Name;                                                                   //Line number
                workdetail_x1.LineType = wodet.SVMXC__Line_Type__c;                                                      //Line Type
                workdetail_x1.LineStatus = wodet.SVMXC__Line_Status__c;

                System.debug('wodet.SVMXC__Line_Type__c'+wodet.SVMXC__Line_Type__c);
                System.debug('wodet.GE_AL_MFL_Extended_Price_Labor__c' + wodet.GE_AL_MFL_Extended_Price_Labor__c);
                System.debug('recordTypeName****'+recTypeName);
                objWrap.bindWorkDetail(wodet,recTypeName);
                //objWrap.createProject(csObj.id,AccessToken,caseRTName);
                objWrap.updateWDStatus();
                         
          }               
           
          static testMethod void GE_OG_PCOutboundWrapper8(){
            test.startTest();
            try{

                List<Account> acc= [Select id, Name, GE_HQ_DUNS_Number__c from Account where GE_HQ_Request_Status__c='CMF Approved' LIMIT 1];
                List<ID> toUpdateWdId = new List<ID>();
                //New Location
                SVMXC__Site__c loc = new SVMXC__Site__c();
                loc.Name='Test Location'+system.now();
                loc.GE_AL_Well_Type__c='Drilling';
                insert loc;

                Id recTypeID = Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('D&S').getRecordTypeId();
                System.debug('recTypeID'+recTypeID);
                RecordType rt = [Select id,Name From RecordType Where sObjectType = 'SVMXC__Service_Order__c' and RecordType.Name = 'SS-Mobilize'];
                RecordType rtProd = [Select id From RecordType Where sObjectType = 'Product2' and RecordType.Name = 'ServiceMax'];
                String recTypeName = rt.Name;
                //New Work Order                          
                SVMXC__Service_Order__c woObj = new SVMXC__Service_Order__c();   
                woObj.SVMXC__Site__c = loc.ID;
                woObj.SVMXC__Order_Status__c = 'Open';
                woObj.GE_PC_Branch__c = 'MCR(C22)';
                woObj.SVMXC__Company__c = acc[0].ID;
                woObj.GE_PC_Ship_to_Account__c = acc[0].ID;
                woObj.SVMXC__Street__c = 'Test Street';
                woObj.SVMXC__City__c = 'Test City';
                woObj.SVMXC__State__c = 'Test State';
                woObj.SVMXC__Zip__c = '77041';
                woObj.SVMXC__Country__c = 'United States';
                woObj.GE_PC_Phone_Number__c = '18324761123';
                woObj.SVMXC__Work_Performed__c = 'Test';     
                woObj.GE_SS_Customer_PO_number__c = '5555';
                woObj.GE_SS_Payment_Terms_Days_Net__c = 'NET 30';
                woObj.SVMXC__Order_Type__c = 'Services';
                woObj.SVMXC__Skill__c = 'a3SA0000003gBIy';

                woObj.RecordTypeId = rt.Id;
                insert woObj;

                Product2 prod = new Product2();
                prod.Name  = 'FsoTypeAttach';
                prod.ProductCode = '1234';
                prod.GE_ES_P_L__c = 'D&S - PC';
                prod.RecordTypeId = rtProd.Id;
                insert prod;
                Product2 retProd = [Select id, Name, ProductCode, GE_ES_P_L__c FROM Product2 WHERE id=:prod.Id ];
                System.debug('Product-->'+retProd);

                Id recTypeIDwd= Schema.SObjectType.SVMXC__Service_Order_Line__c.getRecordTypeInfosByName().get('Estimate').getRecordTypeId(); 
                RecordType rtWod = [Select id From RecordType Where sObjectType = 'SVMXC__Service_Order_Line__c' and RecordType.Name = 'Estimate']; //New Work Detail
                SVMXC__Service_Order_Line__c wodet = new SVMXC__Service_Order_Line__c();
                wodet.SVMXC__Line_Type__c  = 'Labor';
                wodet.GE_AL_MFL_Extended_Price_Labor__c = 100.00;
                wodet.GE_SS_Billable_Days__c = 1;
                wodet.GE_DS_Mark_up__c=25;
                wodet.CurrencyIsoCode = 'GBP';
                wodet.GE_DRL_Daily_Rate__c=100.00;
                wodet.SVMXC__Product__c = retProd.Id;             
                wodet.SVMXC__Actual_Quantity2__c = 10.00;
                wodet.SVMXC__Actual_Price2__c = 12.50;
                wodet.SVMXC__Line_Status__c = 'Open';
                wodet.GE_DS_Submit_to_Oracle__c = true;
                wodet.GE_PC_Flat_Rate__c = true;
                wodet.SVMXC__Billable_Quantity__c = 12;
                wodet.GE_DS_Non_Billable_Hours__c = 0;
                wodet.GE_DS_Overtime_Hrs__c = 0;
                wodet.GE_DRL_Daily_Rate__c = 1700;
                wodet.GE_DRL_Overtime__c = 0;
                wodet.GE_SS_Service_Start_Date__c = Date.today() - 1;
                wodet.GE_SS_Service_End_Date__c= Date.today() + 1;
                wodet.SVMXC__Service_Order__c = woObj.Id;
                wodet.RecordTypeId = rtWod.Id;
                insert wodet;
                toUpdateWdId.add(wodet.Id);

                String recordTypeName= 'D&S';
                //string AccessToken;
                String AccessToken;
                AccessToken='bearer 2338923';


                GE_OG_PCOutboundWrapper objWrap = new GE_OG_PCOutboundWrapper();
                GE_OG_PCWOPublish.WorkDetail_element workdetail_x1 = new GE_OG_PCWOPublish.WorkDetail_element();
                workdetail_x1.LineQuantity = wodet.SVMXC__Actual_Quantity2__c;                                           //Line Quantity
                workdetail_x1.LineNumber = wodet.Name;                                                                   //Line number
                workdetail_x1.LineType = wodet.SVMXC__Line_Type__c;                                                      //Line Type
                workdetail_x1.LineStatus = wodet.SVMXC__Line_Status__c;

                System.debug('wodet.SVMXC__Line_Type__c'+wodet.SVMXC__Line_Type__c);
                System.debug('wodet.GE_AL_MFL_Extended_Price_Labor__c' + wodet.GE_AL_MFL_Extended_Price_Labor__c);
                System.debug('recordTypeName****'+recTypeName);
                objWrap.bindWorkDetail(wodet,recTypeName);
                objWrap.submitToOracle(woObj.Id,AccessToken);
                objWrap.updateWDStatus();


                test.stopTest();
           }
           
           catch(Exception e){
              System.debug('Exception :'+e.getMessage());
           }
          }
           
        static testMethod void GE_OG_PCOutboundWrapper9(){
            test.startTest();
            try{

                List<Account> acc= [Select id, Name, GE_HQ_DUNS_Number__c from Account where GE_HQ_Request_Status__c='CMF Approved' LIMIT 1];
                List<ID> toUpdateWdId = new List<ID>();
                //New Location
                SVMXC__Site__c loc = new SVMXC__Site__c();
                loc.Name='Test Location'+system.now();
                loc.GE_AL_Well_Type__c='Drilling';
                insert loc;

                Id recTypeID = Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('D&S').getRecordTypeId();
                System.debug('recTypeID'+recTypeID);
                RecordType rt = [Select id,Name From RecordType Where sObjectType = 'SVMXC__Service_Order__c' and RecordType.Name = 'SS-Mobilize'];
                RecordType rtProd = [Select id From RecordType Where sObjectType = 'Product2' and RecordType.Name = 'ServiceMax'];
                String recTypeName = rt.Name;
                //New Work Order                          
                SVMXC__Service_Order__c woObj = new SVMXC__Service_Order__c();   
                woObj.SVMXC__Site__c = loc.ID;
                woObj.SVMXC__Order_Status__c = 'Open';
                woObj.GE_PC_Branch__c = 'MCR(C22)';
                woObj.SVMXC__Company__c = acc[0].ID;
                woObj.GE_PC_Ship_to_Account__c = acc[0].ID;
                woObj.SVMXC__Street__c = 'Test Street';
                woObj.SVMXC__City__c = 'Test City';
                woObj.SVMXC__State__c = 'Test State';
                woObj.SVMXC__Zip__c = '77041';
                woObj.SVMXC__Country__c = 'United States';
                woObj.GE_PC_Phone_Number__c = '18324761123';
                woObj.SVMXC__Work_Performed__c = 'Test';     
                woObj.GE_SS_Customer_PO_number__c = '5555';
                woObj.GE_SS_Payment_Terms_Days_Net__c = 'NET 30';
                woObj.SVMXC__Order_Type__c = 'Services';
                woObj.SVMXC__Skill__c = 'a3SA0000003gBIy';

                woObj.RecordTypeId = rt.Id;
                insert woObj;

                Product2 prod = new Product2();
                prod.Name  = 'FsoTypeAttach';
                prod.ProductCode = '1234';
                prod.GE_ES_P_L__c = 'D&S - PC';
                prod.RecordTypeId = rtProd.Id;
                insert prod;
                Product2 retProd = [Select id, Name, ProductCode, GE_ES_P_L__c FROM Product2 WHERE id=:prod.Id ];
                System.debug('Product-->'+retProd);

                Id recTypeIDwd= Schema.SObjectType.SVMXC__Service_Order_Line__c.getRecordTypeInfosByName().get('Estimate').getRecordTypeId(); 
                RecordType rtWod = [Select id From RecordType Where sObjectType = 'SVMXC__Service_Order_Line__c' and RecordType.Name = 'Estimate']; //New Work Detail
                SVMXC__Service_Order_Line__c wodet = new SVMXC__Service_Order_Line__c();
                wodet.SVMXC__Line_Type__c  = 'Expenses';
                wodet.GE_AL_MFL_Extended_Price_Labor__c = 100.00;
                wodet.GE_SS_Billable_Days__c = 1;
                wodet.GE_DS_Mark_up__c=25;
                wodet.CurrencyIsoCode = 'GBP';
                wodet.GE_DRL_Daily_Rate__c=100.00;
                wodet.SVMXC__Product__c = retProd.Id;             
                wodet.SVMXC__Actual_Quantity2__c = 10.00;
                wodet.SVMXC__Actual_Price2__c = 12.50;
                wodet.SVMXC__Line_Status__c = 'Open';
                wodet.GE_DS_Submit_to_Oracle__c = true;
                wodet.GE_PC_Flat_Rate__c = true;
                wodet.SVMXC__Billable_Quantity__c = 12;
                wodet.GE_DS_Non_Billable_Hours__c = 0;
                wodet.GE_DS_Overtime_Hrs__c = 0;
                wodet.GE_DRL_Daily_Rate__c = 1700;
                wodet.GE_DRL_Overtime__c = 0;
                wodet.GE_SS_Service_Start_Date__c = Date.today() - 1;
                wodet.GE_SS_Service_End_Date__c= Date.today() + 1;
                wodet.SVMXC__Service_Order__c = woObj.Id;
                wodet.RecordTypeId = rtWod.Id;
                insert wodet;
                toUpdateWdId.add(wodet.Id);

                String recordTypeName= 'D&S';
                //string AccessToken;
                String AccessToken;
                AccessToken='bearer 2338923';


                GE_OG_PCOutboundWrapper objWrap = new GE_OG_PCOutboundWrapper();
                GE_OG_PCWOPublish.WorkDetail_element workdetail_x1 = new GE_OG_PCWOPublish.WorkDetail_element();
                workdetail_x1.LineQuantity = wodet.SVMXC__Actual_Quantity2__c;                                           //Line Quantity
                workdetail_x1.LineNumber = wodet.Name;                                                                   //Line number
                workdetail_x1.LineType = wodet.SVMXC__Line_Type__c;                                                      //Line Type
                workdetail_x1.LineStatus = wodet.SVMXC__Line_Status__c;

                System.debug('wodet.SVMXC__Line_Type__c'+wodet.SVMXC__Line_Type__c);
                System.debug('wodet.GE_AL_MFL_Extended_Price_Labor__c' + wodet.GE_AL_MFL_Extended_Price_Labor__c);
                System.debug('recordTypeName****'+recTypeName);
                objWrap.bindWorkDetail(wodet,recTypeName);
                objWrap.updateWDStatus();


                test.stopTest();
           }
           
           catch(Exception e){
              System.debug('Exception :'+e.getMessage());
           }
        }
        
        static testMethod void GE_OG_PCOutboundWrapper10(){
            test.startTest();
            try{

                List<Account> acc= [Select id, Name, GE_HQ_DUNS_Number__c from Account where GE_HQ_Request_Status__c='CMF Approved' LIMIT 1];
                List<ID> toUpdateWdId = new List<ID>();
                //New Location
                SVMXC__Site__c loc = new SVMXC__Site__c();
                loc.Name='Test Location'+system.now();
                loc.GE_AL_Well_Type__c='Drilling';
                insert loc;

                Id recTypeID = Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('D&S').getRecordTypeId();
                System.debug('recTypeID'+recTypeID);
                RecordType rt = [Select id,Name From RecordType Where sObjectType = 'SVMXC__Service_Order__c' and RecordType.Name = 'D&S'];
                RecordType rtProd = [Select id From RecordType Where sObjectType = 'Product2' and RecordType.Name = 'ServiceMax'];
                String recTypeName = rt.Name;
                //New Work Order                          
                SVMXC__Service_Order__c woObj = new SVMXC__Service_Order__c();   
                woObj.SVMXC__Site__c = loc.ID;
                woObj.SVMXC__Order_Status__c = 'Open';
                woObj.GE_PC_Branch__c = 'MCR(C22)';
                woObj.SVMXC__Company__c = acc[0].ID;
                woObj.GE_PC_Ship_to_Account__c = acc[0].ID;
                woObj.SVMXC__Street__c = 'Test Street';
                woObj.SVMXC__City__c = 'Test City';
                woObj.SVMXC__State__c = 'Test State';
                woObj.SVMXC__Zip__c = '77041';
                woObj.SVMXC__Country__c = 'United States';
                woObj.GE_PC_Phone_Number__c = '18324761123';
                woObj.SVMXC__Work_Performed__c = 'Test';     
                woObj.GE_SS_Customer_PO_number__c = '5555';
                woObj.GE_SS_Payment_Terms_Days_Net__c = 'NET 30';
                woObj.SVMXC__Order_Type__c = 'Services';
                woObj.SVMXC__Skill__c = 'a3SA0000003gBIy';

                woObj.RecordTypeId = rt.Id;
                insert woObj;

                Product2 prod = new Product2();
                prod.Name  = 'FsoTypeAttach';
                prod.ProductCode = '1234';
                prod.GE_ES_P_L__c = 'D&S - PC';
                prod.RecordTypeId = rtProd.Id;
                insert prod;
                Product2 retProd = [Select id, Name, ProductCode, GE_ES_P_L__c FROM Product2 WHERE id=:prod.Id ];
                System.debug('Product-->'+retProd);

                Id recTypeIDwd= Schema.SObjectType.SVMXC__Service_Order_Line__c.getRecordTypeInfosByName().get('Estimate').getRecordTypeId(); 
                RecordType rtWod = [Select id From RecordType Where sObjectType = 'SVMXC__Service_Order_Line__c' and RecordType.Name = 'Estimate']; //New Work Detail
                SVMXC__Service_Order_Line__c wodet = new SVMXC__Service_Order_Line__c();
                wodet.SVMXC__Line_Type__c  = 'Expenses';
                wodet.GE_AL_MFL_Extended_Price_Labor__c = 100.00;
                wodet.GE_SS_Billable_Days__c = 1;
                wodet.GE_DS_Mark_up__c=25;
                wodet.CurrencyIsoCode = 'GBP';
                wodet.GE_DRL_Daily_Rate__c=100.00;
                wodet.SVMXC__Product__c = retProd.Id;             
                wodet.SVMXC__Actual_Quantity2__c = 10.00;
                wodet.SVMXC__Actual_Price2__c = 12.50;
                wodet.SVMXC__Line_Status__c = 'Open';
                wodet.GE_DS_Submit_to_Oracle__c = true;
                wodet.GE_PC_Flat_Rate__c = true;
                wodet.SVMXC__Billable_Quantity__c = 12;
                wodet.GE_DS_Non_Billable_Hours__c = 0;
                wodet.GE_DS_Overtime_Hrs__c = 0;
                wodet.GE_DRL_Daily_Rate__c = 1700;
                wodet.GE_DRL_Overtime__c = 0;
                wodet.GE_SS_Service_Start_Date__c = Date.today() - 1;
                wodet.GE_SS_Service_End_Date__c= Date.today() + 1;
                wodet.SVMXC__Service_Order__c = woObj.Id;
                wodet.RecordTypeId = rtWod.Id;
                insert wodet;
                toUpdateWdId.add(wodet.Id);

                String recordTypeName= 'D&S';
                //string AccessToken;
                String AccessToken;
                AccessToken='bearer 2338923';


                GE_OG_PCOutboundWrapper objWrap = new GE_OG_PCOutboundWrapper();
                GE_OG_PCWOPublish.WorkDetail_element workdetail_x1 = new GE_OG_PCWOPublish.WorkDetail_element();
                workdetail_x1.LineQuantity = wodet.SVMXC__Actual_Quantity2__c;                                           //Line Quantity
                workdetail_x1.LineNumber = wodet.Name;                                                                   //Line number
                workdetail_x1.LineType = wodet.SVMXC__Line_Type__c;                                                      //Line Type
                workdetail_x1.LineStatus = wodet.SVMXC__Line_Status__c;

                System.debug('wodet.SVMXC__Line_Type__c'+wodet.SVMXC__Line_Type__c);
                System.debug('wodet.GE_AL_MFL_Extended_Price_Labor__c' + wodet.GE_AL_MFL_Extended_Price_Labor__c);
                System.debug('recordTypeName****'+recTypeName);
                objWrap.bindWorkDetail(wodet,recTypeName);
                objWrap.updateWDStatus();


                test.stopTest();
           }
           
           catch(Exception e){
              System.debug('Exception :'+e.getMessage());
           }
        }
        
        static testMethod void GE_OG_PCOutboundWrapper11(){
           
       }
       
       static testMethod void GE_OG_PCOutboundWrapperIntegration(){
           test.startTest();
           try{
            Id woID;
            String  PC_ENVIRON = Label.GE_Integration_Environment; 
            List<ID> toUpdateWoId = new List<ID>();                                                                 //Work Order ID's
            List<ID> toUpdateWdId = new List<ID>(); 
            /*if(PC_ENVIRON=='Dev'){
                //woID='a3NK0000000ImYj';
                woID = 'a3N120000003sju' ;
                toUpdateWoId.add('a3MK00000007G3q');
            }*/
          /*  else if(PC_ENVIRON=='QA'){
                //woID='a3Ng00000001zuV';
                woID='a3N120000003sju';
                toUpdateWoId.add('a3Mg0000000UfSW');
            }
            else if(PC_ENVIRON=='Prod'){
                //woID='a3N1200000024VY';
                woID='a3N120000003sju';
                toUpdateWoId.add('a3M12000001NrFS');
            }*/
               
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
   }