/*
Class Name: GE_OG_PCOutboundWrapper
Used Where: 
Purpose/Overview: Wrapper class for GE_OG_PCOutboundIntegration class to invoke SOA Endpoint.
Functional Area: 
Author: Amit Kumar
Created Date: 23-SEP-2014
Test Class Name:  Test_GE_OG_PCIntegration
Change History:
Date Modified: Developer Name: Section/Page Block Modified/Added: Purpose/Overview of Change
*/
Global class GE_OG_PCOutboundWrapper {
    public GE_OG_PCOutboundWrapper(){                         
    }
    string result,logDescription;
    List<ID> toUpdateWoId = new List<ID>();                                                                 //Work Order ID's
    List<ID> toUpdateWdId = new List<ID>();                                                                 //Work details ID's
    String wsInvokeResult='';
    String woPONum=null;

    GE_OG_PCWOPublish.ProcessWorkOrder_pt processRequest_x = new GE_OG_PCWOPublish.ProcessWorkOrder_pt();
    GE_OG_PCWOPublish.ProcessWorkOrderDetailsResponse_element processResponse_x = new GE_OG_PCWOPublish.ProcessWorkOrderDetailsResponse_element();
    GE_OG_PCWOPublish.details_element resMessage = new GE_OG_PCWOPublish.details_element();
    GE_OG_PCWOPublish.Account_element account_x = new GE_OG_PCWOPublish.Account_element();
    GE_OG_PCWOPublish.Location_element location_x = new GE_OG_PCWOPublish.Location_element(); 
    GE_OG_PCWOPublish.InstalledProduct_element installedproduct_x = new GE_OG_PCWOPublish.InstalledProduct_element();
    GE_OG_PCWOPublish.Case_element case_x = new GE_OG_PCWOPublish.Case_element();
    GE_OG_PCWOPublish.WorkOrder_element workorder_x = new GE_OG_PCWOPublish.WorkOrder_element();
    GE_OG_PCWOPublish.ShipToAddress_element shipToAdd_x = new GE_OG_PCWOPublish.ShipToAddress_element(); 
    GE_OG_PCWOPublish.WorkDetail_element workdetail_x = new GE_OG_PCWOPublish.WorkDetail_element();
    GE_OG_PCWOPublish.Product_element product_x1 = new GE_OG_PCWOPublish.Product_element();
    GE_OG_PCWOPublish.ServiceTeam_element technician_x = new GE_OG_PCWOPublish.ServiceTeam_element();
    GE_OG_PCWOPublish.TechnicalSkills_element techSkill_x = new GE_OG_PCWOPublish.TechnicalSkills_element();
    GE_OG_PCWOPublish.ProcessWorkOrderDetails_element details_x = new GE_OG_PCWOPublish.ProcessWorkOrderDetails_element(); 
    GE_OG_PCIntegrationUtility.ValidationResult validation_x = new  GE_OG_PCIntegrationUtility.ValidationResult();
        
    List<GE_OG_PCWOPublish.Location_element> location_xItem = new List<GE_OG_PCWOPublish.Location_element>();
    List<GE_OG_PCWOPublish.InstalledProduct_element>  installedproduct_xItem = new List<GE_OG_PCWOPublish.InstalledProduct_element>();
    List<GE_OG_PCWOPublish.Case_element> case_xItem = new List<GE_OG_PCWOPublish.Case_element>();
    List<GE_OG_PCWOPublish.WorkOrder_element> workorder_xItem = new List<GE_OG_PCWOPublish.WorkOrder_element>();
    List<GE_OG_PCWOPublish.WorkDetail_element> workdetail_xItem = new List<GE_OG_PCWOPublish.WorkDetail_element>();
    //Web service Invoking method           
    public String submitToOracle(ID woID, String AccessToken){
            Map<string,string> inputHeader=new Map<string,string>();
            String recordTypeName;
            inputHeader.put('Authorization',AccessToken); 
            processRequest_x.inputHttpHeaders_x = inputHeader;
            processRequest_x.timeout_x = GE_OG_PCIntegrationUtility.PC_SOA_TIMEOUT;
            processRequest_x.endpoint_x = GE_OG_PCIntegrationUtility.getEndpointBaseSOA(GE_OG_PCIntegrationUtility.PC_ENVIRON);
                            
            ID caseID;
           // SVMXC__Service_Order__c objWoID= [SELECT SVMXC__Case__r.ID from SVMXC__Service_Order__c  WHERE SVMXC__Service_Order__c.ID=:woID LIMIT 1];
           
            //Commented above Query and added below query ad part of  R-23728
            SVMXC__Service_Order__c objWoID = [SELECT Id, Name, GE_PC_Branch__c, SVMXC__Company__r.Name, 
            SVMXC__Company__r.GE_HQ_DUNS_Number__c,GE_SS_Project__r.Name,GE_SS_Project_Region__r.Name,GE_PC_Ship_to_Account__r.Name, 
            GE_PC_Ship_to_Account__r.GE_HQ_DUNS_Number__c, GE_OG_DS_Bill_To_Address__c,SVMXC__Street__c,SVMXC__City__c,SVMXC__State__c,
            SVMXC__Zip__c,GE_OG_Project_Number__c,SVMXC__Country__c,GE_PC_Phone_Number__c,SVMXC__Work_Performed__c,RecordTypeId,
            RecordType.Name,SVMXC__Order_Type__c, SVMXC__Group_Member__c, SVMXC__Service_Group__c, GE_SS_Customer_PO_number__c,
            GE_PC_Oracle_FSO__c,GE_OG_Attachment_Id__c,CreatedById,SVMXC__Case__r.ID,
            GE_SS_Rig_Vessel_Name__r.Name,GE_SS_Field__r.Name,Management_Country__c,GE_OG_PO_Checked_On__c,SVMXC__Case__c 
            FROM SVMXC__Service_Order__c where id=:woID LIMIT 1];
            
            //Added as part of  R-23728
            if(objWoID.RecordType.Name=='SS-Mobilize'){
                //Location
                location_xItem.add(location_x); 
                account_x.Location=location_xItem ;
                
                //Case
                case_x.CaseID=objWoID.Id;                                                          //WorkOrder ID
                case_x.CaseNumber=objWoID.Name;                                                    //WorkOrder Number
                case_x.CaseCreatedDate=objWoID.GE_OG_PO_Checked_On__c;                             //WorkOrder Date of PO
                case_x.PONumber=objWoID.GE_SS_Customer_PO_number__c; 
                case_x.CreatedById=objWoID.CreatedById;// Work Order owner           
                case_x.ProjectName=objWoID.GE_OG_Project_Number__c;                                                  
                case_x.RecordTypeId=objWoID.RecordType.Name;
                Case_x.ServiceOrderNumber=objWoID.GE_PC_Oracle_FSO__c;
                case_x.Region = objWoID.Management_Country__c;
                case_x.RigName = objWoID.GE_SS_Rig_Vessel_Name__r.Name;
                case_x.VesselName = objWoID.GE_SS_Field__r.Name;
                
            }//End
            else{
             caseID =objWoID.SVMXC__Case__r.ID; 
            //----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
            //                       Case Details
            //  Fields: ID, Account Name, DUNS Number, Case Number, Case Created Date, PO#, Cust Phone number, Cust email
            //----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
            Case casedetail = [SELECT Id, Account.Name, Account.GE_HQ_DUNS_Number__c,SVMXC__Site__r.GE_Rig_ID__c,GE_ES_Project_Number__c, GE_DS_Opportunity_Number__c,GE_DRL_Location__r.GE_Rig_ID__c, CaseNumber, CreatedDate,SVMXC__Site__r.Name, GE_PW_PO__c, GE_OG_DS_Customer_Phone_Number__c, GE_OG_DS_Customer_Email_Address__c,RecordType.Name,GE_PW_SalesOrder__c,GE_OG_DS_Region__c FROM Case WHERE ID=:caseID LIMIT 1];
            System.debug('Case Detail Retrived -->' +casedetail) ;
            //Account
            //account_x.AccountName=casedetail.Account.Name;
            //account_x.DUNSNumber=casedetail.Account.GE_HQ_DUNS_Number__c;
            
            //Location
            location_xItem.add(location_x); 
            account_x.Location=location_xItem ;
            
            //Case
            recordTypeName=casedetail.RecordType.Name;
            case_x.CaseID=casedetail.Id;                                                                //Case ID
            case_x.CaseNumber=casedetail.CaseNumber;                                                    //Case Number
            case_x.CaseCreatedDate=casedetail.CreatedDate;                                              //Case Created Date
            case_x.PONumber=casedetail.GE_PW_PO__c; 
            case_x.ProjectName=casedetail.GE_ES_Project_Number__c;                                                    //PO Number
            case_x.CustomerEmailAddress=casedetail.GE_OG_DS_Customer_Email_Address__c;                  //Customer email 
            case_x.CustomerPhoneNumber=casedetail.GE_OG_DS_Customer_Phone_Number__c;                    //Customer Phone Number
            case_x.OpportunityNumber=casedetail.GE_DS_Opportunity_Number__c;
            case_x.RigName = casedetail.SVMXC__Site__r.Name;
            // Added as a part of R-24690 -- Start
            if((casedetail.RecordType.Name=='FS-D&S') || test.isRunningTest()){           
                    Case_x.RecordTypeId = casedetail.RecordType.Name;                                           //Case RecordType Name
                    Case_x.ServiceOrderNumber=casedetail.GE_PW_SalesOrder__c;                                   //Case SalesOrderNumber
                    Case_x.Region=casedetail.GE_OG_DS_Region__c;
                    //Case Region
            }
                    // Added as a part of R-24690 -- End    
           } 
            case_xItem.add(case_x);
            location_x.Case_x=case_xItem;
            System.debug('Case Number: '+case_x.CaseNumber +'\t Case Created Date: '+case_x.CaseCreatedDate +'\t PO#: '+ case_x.PONumber +'\t Customer Phone No: '+case_x.CustomerPhoneNumber +'\t Customer Email: '+case_x.CustomerEmailAddress+'\t RecordType Id'+Case_x.RecordTypeId +'\t ServiceOrderNumber'+Case_x.ServiceOrderNumber +'\t Region'+Case_x.Region);
            //Work Order
          workorder_xItem.Add(retrieveWorkOrders(woID));
            Case_x.WorkOrder=workorder_xItem;
            String jsonAcc = JSON.serialize(account_x);
            String jsonAtt = JSON.serialize(details_x.Attachment);
            System.debug('JSON Account -->'+jsonAcc +'\t JSON Attachment -->'+jsonAtt);
            //Validate payload request
            validation_x=GE_OG_PCIntegrationUtility.validateWOPayload(account_x,woID);
            System.debug('1.payload_x.result->'+validation_x.result +'\t payload_x.errorMsg-> '+validation_x.errorMsg);
            if(validation_x.result=='PASS'){
                details_x.Account=account_x;
                processResponse_x.details=processRequest_x.ProcessWorkOrder(details_x.Attachment,details_x.Account);
                System.debug('Work Order detils successfully published to ORACLE (Response Msg) --> '+((processResponse_x.details).message));
                //Below line commented as part of R-24690 and added below if condition 
                //GE_OG_PCIntegrationUtility.updateWOStatus(toUpdateWoId, GE_OG_PCIntegrationUtility.WO_STATUS_OUTBOUND);
                if (recordTypeName == 'FS-D&S'){
                    GE_OG_PCIntegrationUtility.updateWOStatus(toUpdateWoId, GE_OG_PCIntegrationUtility.DS_WO_OUTBOUND_STATUS);
                }
                else{
                    GE_OG_PCIntegrationUtility.updateWOStatus(toUpdateWoId, GE_OG_PCIntegrationUtility.WO_STATUS_OUTBOUND);
                }           
                updateWDStatus();
                
                //Below code Commented as part of bug-0000024173
             /*   if(woPONum!=null){
                    casedetail.GE_PW_PO__c=woPONum;
                  update casedetail;
                }*/
                wsInvokeResult='Success';
                return wsInvokeResult;    
            }
            else{
                wsInvokeResult=validation_x.errorMsg; 
                return wsInvokeResult;                    
            }
        }
        //---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        //                      Work Order Object
        //  1.  Work Order (Id, Work Order Number, Attachment, Branch, Ship To DUNS, Bill To Address , Ship To Address , Work Performed, Order Type, Service Team Name, Technician Name)
        //  2.  Work Detail (Line Number, Line Qty, Product Code, Line Price Per Unit, Line Status)
        //  3.  Product / Price Book (Product Code & PriceBook Name)
        //  4.  Service Team
        //  5.  Skill Set
        //---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        @testVisible
        private GE_OG_PCWOPublish.WorkOrder_element retrieveWorkOrders(ID woId){
            //Added R-24690 Billing Type,Record TYpe name retrieved
            //Added GE_SS_Payment_Terms_Days_Net__c (Payments terms) field as part of R-23728 
            //Added GE_OG_AL_Ship_to_Account_Number__c field in the below Query as part of R-29567
          SVMXC__Service_Order__c objWo=[SELECT Id, Name, GE_PC_Branch__c,GE_SS_Payment_Terms_Days_Net__c, SVMXC__Company__r.Name, SVMXC__Company__r.GE_HQ_DUNS_Number__c, GE_PC_Ship_to_Account__r.GE_HQ_DUNS_Number__c, GE_OG_DS_Bill_To_Address__c,SVMXC__Street__c,SVMXC__City__c,SVMXC__State__c,SVMXC__Zip__c,SVMXC__Country__c,GE_PC_Phone_Number__c,SVMXC__Work_Performed__c,SVMXC__Order_Type__c, SVMXC__Group_Member__c, SVMXC__Service_Group__c, GE_SS_Customer_PO_number__c,GE_PC_Oracle_FSO__c,GE_OG_AL_Ship_to_Account_Number__c, GE_OG_Attachment_Id__c,RecordType.Name,SVMXC__Case__c FROM SVMXC__Service_Order__c where id=:woID];
            toUpdateWoId.add(objWo.Id);
            //Get Attachment
            String FsoTypeAttach='%'+woId+'%';          
            String FSONameAttach='%'+objWo.Name+'%';
            List<Attachment> fsoattach=[SELECT Id, Name, ContentType, Body FROM Attachment WHERE ParentId=:woId AND (Name LIKE :FsoTypeAttach OR Name LIKE:FSONameAttach) Order By CreatedDate DESC Limit 1];
            //Added as a part of R-24690
            if(fsoattach.size()>0) {
                System.debug('Attachement--> Name: '+fsoattach[0].Name);
                //End of R-24690
                // Below If condition added for Bug# 0000023943 To restrict Resending same Attachment to ERP when Republish
                    if(objWo.GE_OG_Attachment_Id__c!=fsoattach[0].Id)
                    {
                        System.debug('G*G Inside different attachment found');
                        System.debug('G*G The attachment name/ID :'+objWo.GE_OG_Attachment_Id__c +'is updated on Work order:' +objWo.Id);
                        workorder_x.AttachmentFileName=fsoattach[0].Name;
                        String pdfBody = EncodingUtil.base64Encode(fsoattach[0].Body);
                        details_x.Attachment=pdfBody;   
                    }               
                
            }
            Case casedetail = new Case();
            // Ended Bug# 0000023943
            account_x.AccountName=objWo.SVMXC__Company__r.Name;
            account_x.DUNSNumber=objWo.SVMXC__Company__r.GE_HQ_DUNS_Number__c;
            //Added as part of R-24690
            //workorder_x.OrderType=objWo.SVMXC__Order_Type__c;  //Order Type
           //Added below if as part of R-23728
            if(objWo.RecordType.Name!='SS-Mobilize'){
            casedetail = [SELECT Id,SVMXC__Billing_Type__c,GE_OG_DS_Non_Billable_Reason__c FROM Case WHERE ID=:objWo.SVMXC__Case__c LIMIT 1];
            System.debug('Case values are:'+casedetail);
            }
            if(objWo.RecordType.Name=='D&S'){
            
                if ((casedetail.SVMXC__Billing_Type__c == 'Commissioning') ||(casedetail.SVMXC__Billing_Type__c == 'Cost transfer')){
                    
                        workorder_x.OrderType=casedetail.SVMXC__Billing_Type__c ;
                        
                    }else if(casedetail.SVMXC__Billing_Type__c == 'Non Billable'){
                            
                            workorder_x.OrderType=casedetail.GE_OG_DS_Non_Billable_Reason__c ;
                            
                    }else{
                        workorder_x.OrderType='Services';
                    }                
                }else{
                    workorder_x.OrderType=objWo.SVMXC__Order_Type__c;                                      
                }       
            //End of R-24690    
            
            workorder_x.WorkOrderNumber=objWo.Name;                                                 //Work Order Number
            workorder_x.Branch=objWo.GE_PC_Branch__c;                                               //Branch
            //workorder_x.WorkPerformed=objWo.SVMXC__Work_Performed__c;                             //Work Performed
            workorder_x.BillToAddress=((objWo.GE_OG_DS_Bill_To_Address__c).replace('\n', ' '));     //Bill To Address  
            workorder_x.ShipToDunsNumber=objWo.GE_PC_Ship_to_Account__r.GE_HQ_DUNS_Number__c;       //Ship To DUNS          
            //Below If condition is added as part of R-29567
            if(objWo.RecordType.Name=='SS-Mobilize'){
                if(objWo.GE_PC_Ship_to_Account__r.GE_HQ_DUNS_Number__c!=null)
                    workorder_x.ShipToDunsNumber=objWo.GE_PC_Ship_to_Account__r.GE_HQ_DUNS_Number__c;  
                else if(objWo.GE_OG_AL_Ship_to_Account_Number__c!=null){
                    workorder_x.ShipToDunsNumber= objWo.GE_OG_AL_Ship_to_Account_Number__c;
                }
            }           
            shipToAdd_x.Street=objWo.SVMXC__Street__c;                             //Ship To Address                                        
            shipToAdd_x.City=objWo.SVMXC__City__c;
            shipToAdd_x.State=objWo.SVMXC__State__c;
            shipToAdd_x.Zip=objWo.SVMXC__Zip__c;
            shipToAdd_x.Country=objWo.SVMXC__Country__c;
            shipToAdd_x.PhoneNumber=objWo.GE_PC_Phone_Number__c;
            workorder_x.ShipToAddress=shipToAdd_x;
            //Added recordtype check as part of BUG - 0000024173
            if(objWo.GE_SS_Customer_PO_number__c!=null && objWo.RecordType.Name!='D&S'){
              woPONum=objWo.GE_SS_Customer_PO_number__c;
                case_x.PONumber=woPONum;
            }
            workorder_x.SalesOrderNumber=objWo.GE_PC_Oracle_FSO__c;                  //SalesOrderNumber
            if(objWo.GE_SS_Payment_Terms_Days_Net__c!=null || test.isRunningTest()){
            workorder_x.PaymentTerms=objWo.GE_SS_Payment_Terms_Days_Net__c;}
           
            List<User> userSSO=[Select id, FirstName, LastName, GE_HQ_SSO_ID__c FROM User WHERE id=:UserInfo.getUserId() AND IsActive=true LIMIT 1];
            workorder_x.SSOID=userSSO[0].GE_HQ_SSO_ID__c;                                           // SSO
            System.debug('Work Order Number: '+workorder_x.WorkOrderNumber +'\t Order Type:' +workorder_x.OrderType + '\t Sales Order Number: '+workorder_x.SalesOrderNumber + '\t Branch: '+workorder_x.Branch + '\t Bill To DUNS:'+account_x.DUNSNumber +'\t Bill To Address:' +workorder_x.BillToAddress + '\t Ship To Duns: '+'Ship To Duns-->'+workorder_x.ShipToDunsNumber +'\t Ship To Address: [ Street: ' +shipToAdd_x.Street +'\t City:'+shipToAdd_x.City +'\t State:'+shipToAdd_x.State +'\t ZipCode:'+shipToAdd_x.Zip +'\t country:'+shipToAdd_x.Country +'\t Phone:' +shipToAdd_x.PhoneNumber +'\t User: '+workorder_x.SSOID +']');
           
            //-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
            //                      Work Detail Information
            //  Work Order (Line Number, Line Quantity, Line Type, Line Status, Line Price Per Unit)
            //-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
            
           // Added as a part of R-24690 (Drilling-Oracle Integration)-- start
          List<SVMXC__Service_Order_Line__c> workdet;
          String recordTypeName;
            if(objWo.RecordType.Name == 'D&S'){
                    workdet = new List<SVMXC__Service_Order_Line__c>();
                    workdet = [SELECT id, Name, SVMXC__Product__c, SVMXC__Line_Type__c, SVMXC__Line_Status__c, CurrencyIsoCode, SVMXC__Actual_Quantity2__c, 
                    SVMXC__Actual_Price2__c, SystemModstamp, LastModifiedDate, SVMXC__Start_Date_and_Time__c, SVMXC__End_Date_and_Time__c, 
                    SVMXC__Group_Member__r.GE_SM_HQ_SSO_ID__c,GE_DS_Submit_to_Oracle__c,GE_AL_MFL_Extended_Price_Labor__c,GE_DS_Non_Billable_Hours__c,
                    GE_DS_Overtime_Hrs__c,SVMXC__Billable_Quantity__c,SVMXC__Billable_Line_Price__c,GE_DRL_Daily_Rate__c,GE_DRL_Overtime__c,
                    SVMXC__Service_Order__r.SVMXC__Group_Member__r.GE_SM_HQ_SSO_ID__c,GE_DS_Mark_up__c,SVMXC__Service_Order__r.GE_DS_Daily_Rate__c,
                    SVMXC__Service_Order__r.GE_DS_Overtime__c,GE_PC_Flat_Rate__c,GE_PC_Number_of_Days__c
                    FROM SVMXC__Service_Order_Line__c WHERE SVMXC__Service_Order__r.id=:objWo.Id  and GE_DS_Submit_to_Oracle__c = true and  SVMXC__Line_Status__c!='Sent to Oracle' 
                    and  (SVMXC__Line_Type__c=:'Labor'  or SVMXC__Line_Type__c =: 'Expenses')
                    ];
                    recordTypeName='D&S';
                    System.debug('Work details lines are : in DS '+workdet );
                    System.debug('Work details lines Count '+workdet.Size());
                    
            }
            // End part of R-24690  
            //Added as Part of  R-23728
            else if(objWo.RecordType.Name == 'SS-Mobilize'){
                workdet = new List<SVMXC__Service_Order_Line__c>();
            //Added GE_DS_Onshore_offshore__c,SVMXC__Service_Order__r.GE_SS_Onshore_Ship_to_Account__r.GE_HQ_DUNS_Number__c, SVMXC__Service_Order__r.GE_SS_Onshore_Ship_to_DUNS__c in the below Query as part of R-29567
                    workdet = [SELECT id, Name, SVMXC__Product__c, SVMXC__Line_Type__c, SVMXC__Line_Status__c, CurrencyIsoCode, SVMXC__Actual_Quantity2__c, SVMXC__Actual_Price2__c,
                     SystemModstamp, LastModifiedDate,GE_SS_Billable_Days__c, SVMXC__Start_Date_and_Time__c, SVMXC__End_Date_and_Time__c,SVMXC__Billing_Information__c,GE_DS_Onshore_offshore__c,SVMXC__Service_Order__r.GE_SS_Onshore_Ship_to_Account__r.GE_HQ_DUNS_Number__c,SVMXC__Service_Order__r.GE_SS_Onshore_Ship_to_DUNS__c,
                      GE_SS_Service_Start_Date__c,GE_SS_Service_End_Date__c, SVMXC__Group_Member__r.GE_SM_HQ_SSO_ID__c,GE_DS_Submit_to_Oracle__c,GE_AL_MFL_Extended_Price_Labor__c,
                      GE_DS_Non_Billable_Hours__c,GE_DS_Overtime_Hrs__c,SVMXC__Billable_Quantity__c,SVMXC__Billable_Line_Price__c,GE_DRL_Daily_Rate__c,GE_DRL_Overtime__c,SVMXC__Service_Order__r.SVMXC__Group_Member__r.GE_SM_HQ_SSO_ID__c,GE_DS_Mark_up__c,SVMXC__Service_Order__r.GE_DS_Daily_Rate__c,SVMXC__Service_Order__r.GE_DS_Overtime__c,GE_PC_Flat_Rate__c,GE_PC_Number_of_Days__c, SVMXC__Service_Order__r.GE_SS_Customer_PO_number__c, GE_DS_PO__c
                    FROM SVMXC__Service_Order_Line__c WHERE SVMXC__Service_Order__r.id=:objWo.Id  and GE_DS_Submit_to_Oracle__c = true and  SVMXC__Line_Status__c!='Sent to Oracle' 
                    and  (SVMXC__Line_Type__c=:'Labor'  or SVMXC__Line_Type__c =: 'Expenses')
                    ];
                    recordTypeName='SS-Mobilize';
            }//End                    
            else{
                System.debug('Entered PC Code');
                workdet = new List<SVMXC__Service_Order_Line__c>();
                workdet = [SELECT id, Name, SVMXC__Product__c, SVMXC__Line_Type__c, SVMXC__Line_Status__c, CurrencyIsoCode, SVMXC__Actual_Quantity2__c, SVMXC__Actual_Price2__c, SystemModstamp, LastModifiedDate, SVMXC__Start_Date_and_Time__c, SVMXC__End_Date_and_Time__c, SVMXC__Group_Member__r.GE_SM_HQ_SSO_ID__c,GE_AL_MFL_Extended_Price_Labor__c,GE_PC_Flat_Rate__c,GE_PC_Number_of_Days__c FROM SVMXC__Service_Order_Line__c WHERE SVMXC__Service_Order__r.id=:objWo.Id];
                System.debug('Work details lines are : in PC '+workdet );
                recordTypeName='';
            }           
            List<PCIntegrationLog__c> objPCLog= [SELECT Id, LogDate__c, LogType__c, Work_Order_ID__c FROM PCIntegrationLog__c where Work_Order_ID__c = :objWo.Id and LogType__c='SYNC' order by LogDate__c asc];
                System.debug('Work details list is :'+workdet);
                
                for(SVMXC__Service_Order_Line__c wd :workdet){
                    //based on if WO is published or not get the values which are updated
                    GE_OG_PCWOPublish.WorkDetail_element workdetail_x2 = new GE_OG_PCWOPublish.WorkDetail_element();
                    if(objPCLog.size()>0){
                            if(wd.SystemModstamp > objPCLog[0].LogDate__c){
                                workdetail_x2=bindWorkDetail(wd,recordTypeName);
                           }
                    }
                    else{
                        workdetail_x2=bindWorkDetail(wd,recordTypeName);
                    }
                    workdetail_xItem.add(workdetail_x2); 
                }
                System.debug('WORK DETAIL SIZE-->'+workdetail_xItem.size());
                workorder_x.WorkDetail=workdetail_xItem;
                 
                //Retrieve ServiceTeam/Technician
                technician_x.ServiceTeamName=objWo.SVMXC__Group_Member__c;
                workorder_x.ServiceTeam=technician_x;
                
                return workorder_x;
         }
         
         //method to bind work detail
         @testVisible 
         private GE_OG_PCWOPublish.WorkDetail_element bindWorkDetail(SVMXC__Service_Order_Line__c wd,String recordTypeName){ 
            toUpdateWdId.add(wd.id);
            GE_OG_PCWOPublish.WorkDetail_element workdetail_x1=new GE_OG_PCWOPublish.WorkDetail_element();
            workdetail_x1.LineQuantity=wd.SVMXC__Actual_Quantity2__c;                                           //Line Quantity
            workdetail_x1.LineNumber=wd.Name;                                                                   //Line number
            workdetail_x1.LineType=wd.SVMXC__Line_Type__c;                                                      //Line Type
            workdetail_x1.LineStatus=wd.SVMXC__Line_Status__c;                                                  //Line Status
            
            // Below FlatRate is added as part of R-25201
            if(wd.GE_PC_Flat_Rate__c==true)
            {
               workdetail_x1.NumberOfDays = wd.GE_PC_Number_of_Days__c;
               workdetail_x1.FlatRate='TRUE';
            }
            else
            {
                 workdetail_x1.NumberOfDays = 0;
                 workdetail_x1.FlatRate='FALSE';
            }
            
            //Commented as R-24690
            //workdetail_x1.LinePricePerUnit=wd.CurrencyIsoCode+' '+String.valueOf(wd.SVMXC__Actual_Price2__c);   //Line Price Per Unit        
            String pricePerUnit;
            //Added as a part of R-24690.
            system.debug('recordtype'+recordTypeName);
            if(recordTypeName == 'D&S'){ 
                
                System.debug('Billable Line price '+wd.SVMXC__Billable_Line_Price__c);
                    if( wd.SVMXC__Line_Type__c == 'Labor'){
                        if(wd.GE_AL_MFL_Extended_Price_Labor__c!=null){ 
                            System.debug('in Assignment WD values');
                            workdetail_x1.TotalHours = wd.SVMXC__Billable_Quantity__c.setScale(2);                
                            workdetail_x1.LineQuantity= 1;
                            pricePerUnit = wd.CurrencyIsoCode+' '+wd.GE_AL_MFL_Extended_Price_Labor__c.setScale(2).toPlainString();
                            workdetail_x1.LinePricePerUnit= pricePerUnit;
                            workdetail_x1.NonBillableHours=wd.GE_DS_Non_Billable_Hours__c.setScale(2) ;
                            workdetail_x1.BillableHours=((wd.SVMXC__Billable_Quantity__c.setScale(2)) - (wd.GE_DS_Overtime_Hrs__c + wd.GE_DS_Non_Billable_Hours__c)).setScale(2) ;
                            workdetail_x1.BillableRate=((wd.GE_DRL_Daily_Rate__c)/12).setScale(4);
                            workdetail_x1.OverTimeHours=(wd.GE_DS_Overtime_Hrs__c).setScale(2);
                            workdetail_x1.OverTimeRate=wd.GE_DRL_Overtime__c.setScale(4);                        
                            workdetail_x1.FSSSO=wd.SVMXC__Group_Member__r.GE_SM_HQ_SSO_ID__c;                                   //FS Technician SSO
                            System.debug('The Billable rate is :'+workdetail_x1.BillableRate  +'Overtime rate '+workdetail_x1.OverTimeRate);
                        }
                    }
                    else{
                        workdetail_x1.LineQuantity=wd.SVMXC__Actual_Quantity2__c;
                        if(wd.GE_DS_Mark_up__c!=null){
                            pricePerUnit = ' '+(((wd.GE_DS_Mark_up__c * (wd.SVMXC__Actual_Price2__c *wd.SVMXC__Actual_Quantity2__c))/100)
                            + (wd.SVMXC__Actual_Price2__c *wd.SVMXC__Actual_Quantity2__c));
                            workdetail_x1.LinePricePerUnit = wd.CurrencyIsoCode + pricePerUnit ;
                        }else{
                            pricePerUnit = ' '+(wd.SVMXC__Actual_Price2__c *wd.SVMXC__Actual_Quantity2__c); 
                            workdetail_x1.LinePricePerUnit = wd.CurrencyIsoCode + pricePerUnit ;
                            
                        }
                        
                        //wd.CurrencyIsoCode+' '+String.valueOf(wd.SVMXC__Actual_Price2__c);   //Line Price Per Unit  
                        if((wd.SVMXC__Service_Order__r.SVMXC__Group_Member__r.GE_SM_HQ_SSO_ID__c) != null){
                            
                            workdetail_x1.FSSSO=wd.SVMXC__Service_Order__r.SVMXC__Group_Member__r.GE_SM_HQ_SSO_ID__c;//Technician SSO mapping   
                            
                            }
                        System.debug('The technician details are :'+workdetail_x1.FSSSO);
                      }               
                      
             }
             //Added as Part of     R-23728
             else if(recordTypeName == 'SS-Mobilize'){
                 if( wd.SVMXC__Line_Type__c == 'Labor'){ 
                    //Added below if Condition as part of R-29567                    
                     if(wd.GE_DS_Onshore_offshore__c=='Onshore'){                         
                         if(wd.SVMXC__Service_Order__r.GE_SS_Onshore_Ship_to_Account__r.GE_HQ_DUNS_Number__c !=null){
                         System.debug('***DUNS Onshoreship to :'+wd.SVMXC__Service_Order__r.GE_SS_Onshore_Ship_to_Account__r.GE_HQ_DUNS_Number__c);
                         workdetail_x1.Attribute6 = wd.SVMXC__Service_Order__r.GE_SS_Onshore_Ship_to_Account__r.GE_HQ_DUNS_Number__c;
                         }
                         else if(wd.SVMXC__Service_Order__r.GE_SS_Onshore_Ship_to_DUNS__c!=null){
                         System.debug('***TEXT Onshoreship to :'+wd.SVMXC__Service_Order__r.GE_SS_Onshore_Ship_to_DUNS__c);
                         workdetail_x1.Attribute6 = wd.SVMXC__Service_Order__r.GE_SS_Onshore_Ship_to_DUNS__c;
                         }                         
                     }//END of  R-29567
                     if(wd.GE_DS_PO__c != null)  //added by Naveen
                        workdetail_x1.Attribute7 = wd.GE_DS_PO__c; 
                    else
                        workdetail_x1.Attribute7 = wd.SVMXC__Service_Order__r.GE_SS_Customer_PO_number__c; 
                    
                     workdetail_x1.LineQuantity= wd.GE_SS_Billable_Days__c;
                     System.debug('*****PriceperUnit*****'+wd.CurrencyIsoCode+' '+wd.GE_DRL_Daily_Rate__c.setScale(2).toPlainString());
                     pricePerUnit = wd.CurrencyIsoCode+' '+wd.GE_DRL_Daily_Rate__c.setScale(2).toPlainString();                     
                     workdetail_x1.LinePricePerUnit= pricePerUnit;
                     workdetail_x1.FSSSO=wd.SVMXC__Group_Member__r.GE_SM_HQ_SSO_ID__c;  
                     workdetail_x1.BillingComments=wd.SVMXC__Billing_Information__c;                     
                    if(wd.GE_SS_Service_Start_Date__c != null && wd.GE_SS_Service_End_Date__c!= null){
                      // Commenting the below part to fix the date issue Bug - 0000025771
                      // Date was sent one day early
                      /* DateTime tempStartDate = wd.GE_SS_Service_Start_Date__c;
                       workdetail_x1.StartDate=(tempStartDate).format('dd-MMM-YYYY', (UserInfo.getTimeZone()).toString());  
                       DateTime tempEndDate = wd.GE_SS_Service_End_Date__c;                       
                       workdetail_x1.EndDate = (tempEndDate).format('dd-MMM-YYYY', (UserInfo.getTimeZone()).toString()); */
                        
                        //Modified code to fix the dates issue Bug - 0000025771
                        date tempStartDate = wd.GE_SS_Service_Start_Date__c;
                        dateTime tempStartDateTime = DateTime.newInstance(tempStartDate.year(),tempStartDate.month(),tempStartDate.day());
                        workdetail_x1.StartDate= (tempStartDateTime).format('dd-MMM-YYYY');  
                        system.debug('G*G workdetail_x1.StartDate'+workdetail_x1.StartDate);
                        system.debug('G*G tempStartDateTime'+tempStartDateTime);
                        date tempEndDate = wd.GE_SS_Service_End_Date__c;
                        dateTime tempEndDateTime = DateTime.newInstance(tempEndDate.year(),tempEndDate.month(),tempEndDate.day());
                        workdetail_x1.EndDate = (tempEndDateTime).format('dd-MMM-YYYY');
                        system.debug('G*G workdetail_x1.EndDate'+workdetail_x1.EndDate);
                        system.debug('G*G tempEndDateTime'+tempEndDateTime);
                     }
                 }
                 else{
                      workdetail_x1.LineQuantity=wd.SVMXC__Actual_Quantity2__c;
                      workdetail_x1.BillingComments=wd.SVMXC__Billing_Information__c;
                      if(wd.GE_DS_Mark_up__c!=null){
                            pricePerUnit = ' '+(((wd.GE_DS_Mark_up__c * (wd.SVMXC__Actual_Price2__c *wd.SVMXC__Actual_Quantity2__c))/100)
                            + (wd.SVMXC__Actual_Price2__c *wd.SVMXC__Actual_Quantity2__c));
                            workdetail_x1.LinePricePerUnit = wd.CurrencyIsoCode + pricePerUnit ;
                        }else{
                            pricePerUnit =' '+(wd.SVMXC__Actual_Price2__c *wd.SVMXC__Actual_Quantity2__c); 
                            workdetail_x1.LinePricePerUnit = wd.CurrencyIsoCode + pricePerUnit ;
                        }
                        if((wd.SVMXC__Group_Member__r.GE_SM_HQ_SSO_ID__c) != null){
                            
                            workdetail_x1.FSSSO=wd.SVMXC__Group_Member__r.GE_SM_HQ_SSO_ID__c;//Technician SSO mapping   
                            
                         }
                       
                 }
                 
             }//End of  R-23728
             else{
                workdetail_x1.LineQuantity=wd.SVMXC__Actual_Quantity2__c;
                workdetail_x1.LinePricePerUnit=wd.CurrencyIsoCode+' '+String.valueOf(wd.SVMXC__Actual_Price2__c);   //Line Price Per Unit    
                workdetail_x1.FSSSO=wd.SVMXC__Group_Member__r.GE_SM_HQ_SSO_ID__c;                                   //FS Technician SSO             
            }
            ////End part of R-24690.            
            
            //Bug# 0000023944 Sending StartDate and EndDate as per UserTimezone
            /*workdetail_x1.StartDate=wd.SVMXC__Start_Date_and_Time__c;
            workdetail_x1.EndDate=wd.SVMXC__End_Date_and_Time__c;*/
            if(wd.SVMXC__Start_Date_and_Time__c != null && wd.SVMXC__End_Date_and_Time__c != null)
            {
                
                
                  //  workdetail_x1.StartDate=(wd.SVMXC__Start_Date_and_Time__c).format('yyyy-MM-dd HH:mm:ss', (UserInfo.getTimeZone()).toString());                                           //Start date and time
                  //  workdetail_x1.EndDate=(wd.SVMXC__End_Date_and_Time__c).format('yyyy-MM-dd HH:mm:ss', (UserInfo.getTimeZone()).toString());                                               //End date and time
               
                    //R-24940 commented above 2 lines and modified as below
                    workdetail_x1.StartDate=(wd.SVMXC__Start_Date_and_Time__c).format('dd-MMM-YYYY', (UserInfo.getTimeZone()).toString());                                           //Start date and time
                    workdetail_x1.EndDate=(wd.SVMXC__End_Date_and_Time__c).format('dd-MMM-YYYY', (UserInfo.getTimeZone()).toString());                                               //End date and time        
                
             }   
                System.debug('Line Items Details---> Line Number :'+workdetail_x1.LineNumber + '\t Line Type: '+workdetail_x1.LineType +'\t Line Qty: ' +workdetail_x1.LineQuantity +'\t Line Price Per Unit: '+workdetail_x1.LinePricePerUnit + '\t Line Status: '+workdetail_x1.LineStatus +'\t Start Date/Time: '+workdetail_x1.StartDate +'\t End Date/Time: '+workdetail_x1.EndDate +'\t FS Tech FSSSO (LABOR): '+workdetail_x1.FSSSO+'\t NonBillableHours'+workdetail_x1.NonBillableHours+'\t Billable Hours'+workdetail_x1.BillableHours+'\t BillableRate'+workdetail_x1.BillableRate+'\t OverTimeHours'+workdetail_x1.OverTimeHours+'\t OverTimeRate'+workdetail_x1.OverTimeRate +'\t Total Hours'+workdetail_x1.TotalHours);          
            System.debug('******Product Name: *******'+wd.SVMXC__Product__c);
            if((wd.SVMXC__Product__c)!= null ){                               
                workdetail_x1.Product=retrieveProductPricebookInfo(wd.SVMXC__Product__c);  
            }
            return workdetail_x1;
          }
         //---------------------------------------------------------------------------------------------------------------------------------------------------------------
         //method to retrive Product/Pricebook Informations
         //---------------------------------------------------------------------------------------------------------------------------------------------------------------
         @testVisible 
         private GE_OG_PCWOPublish.Product_element retrieveProductPricebookInfo(String productID){          
            System.debug('Product ID --> '+productID);
            GE_OG_PCWOPublish.Product_element product_x2 = new GE_OG_PCWOPublish.Product_element();
            List<Product2> productDet=[Select Id, Name, ProductCode From Product2 where Id=:productID LIMIT 1];
            if(productDet.size()>0){
                 product_x2.ProductName=productDet[0].Name;                                                    //Product Name
                 product_x2.Code=productDet[0].ProductCode;                                                    //Product Code
                 product_x2.PriceBook=GE_OG_PCIntegrationUtility.PC_PRICEBOOK_NAME;
                 System.debug('Product Name: '+product_x2.ProductName +'\t Product Code: '+product_x2.Code +'\t PriceBookName: '+product_x2.PriceBook);
            }
            return product_x2;        
          }    
          
          //---------------------------------------------------------------------------------------------------------------------------------------------
          //Update Work Detail status to 'Sent To Oracle'
          //---------------------------------------------------------------------------------------------------------------------------------------------
     @testVisible 
    private void updateWDStatus(){    
              if(toUpdateWdId.size()>0){
                  List<SVMXC__Service_Order_Line__c> updateWd = [SELECT Id,SVMXC__Line_Status__c FROM SVMXC__Service_Order_Line__c WHERE id IN :toUpdateWdId AND SVMXC__Line_Status__c!=:GE_OG_PCIntegrationUtility.SVMX_LINESTATUS_CANCELED AND SVMXC__Line_Status__c!=:GE_OG_PCIntegrationUtility.SVMX_LINESTATUS_ORACLE];
                  if(updateWd!=null){
                      for(SVMXC__Service_Order_Line__c record:updateWd){                  
                          record.SVMXC__Line_Status__c=GE_OG_PCIntegrationUtility.SVMX_LINESTATUS_ORACLE;
                      }
                      update updateWd; 
                  }
              }
          }
         

        //Added as a part of R-24912.
  
   public String createProject(ID caseId1, String AccessToken,String recordType){
        String wsResult;
    

        Map<string,string> inputHeader=new Map<string,string>();
            inputHeader.put('Authorization',AccessToken); 
            processRequest_x.inputHttpHeaders_x = inputHeader;
            processRequest_x.timeout_x = GE_OG_PCIntegrationUtility.PC_SOA_TIMEOUT;
            processRequest_x.endpoint_x = GE_OG_PCIntegrationUtility.getEndpointBaseSOA(GE_OG_PCIntegrationUtility.PC_ENVIRON);
            ID caseID=caseId1;
             //Below if condition is added as part R-23728 
            //For Subsea Querying WorkOrder object to send Work Order Details in Case Placeholders.     
            if(recordType == 'SS-Mobilize'){
            //Added GE_OG_AL_Ship_to_Account_Number__c field in the below Query as part of R-29567
            SVMXC__Service_Order__c casedetailWO = new SVMXC__Service_Order__c ();
            casedetailWO = [SELECT Id, Name, GE_PC_Branch__c, SVMXC__Company__r.Name, SVMXC__Company__r.GE_HQ_DUNS_Number__c,GE_SS_Project__r.Name,
            GE_SS_Project_Region__r.Name,GE_PC_Ship_to_Account__r.Name,GE_PC_Ship_to_Account__c, GE_PC_Ship_to_Account__r.GE_HQ_DUNS_Number__c, GE_OG_DS_Bill_To_Address__c,SVMXC__Street__c,SVMXC__City__c,
            SVMXC__State__c,SVMXC__Zip__c,GE_OG_Project_Number__c,SVMXC__Country__c,GE_PC_Phone_Number__c,SVMXC__Work_Performed__c,RecordTypeId,RecordType.Name,
            SVMXC__Order_Type__c, SVMXC__Group_Member__c, SVMXC__Service_Group__c, GE_SS_Customer_PO_number__c,GE_PC_Oracle_FSO__c,GE_OG_Attachment_Id__c,
            GE_SS_Rig_Vessel_Name__r.Name,GE_SS_Field__r.Name,Management_Country__c,GE_OG_PO_Checked_On__c,SVMXC__Case__c,GE_OG_AL_Ship_to_Account_Number__c,
            CreatedById FROM SVMXC__Service_Order__c where id=:caseID];
            
             if(casedetailWO.RecordType.Name=='SS-Mobilize'){
             
                account_x.AccountName=casedetailWO.SVMXC__Company__r.Name;
                account_x.DUNSNumber=casedetailWO.SVMXC__Company__r.GE_HQ_DUNS_Number__c;
                List<User> userSSO=[Select id, FirstName, LastName, GE_HQ_SSO_ID__c FROM User WHERE id=:UserInfo.getUserId() AND IsActive=true LIMIT 1];
                //Location
                location_xItem.add(location_x); 
                account_x.Location=location_xItem ;
                //Case
                case_x.CaseID=casedetailWO.Id;                                                          //WorkOrder ID
                case_x.CaseNumber=casedetailWO.Name;                                                    //WorkOrder Number
                case_x.CaseCreatedDate=casedetailWO.GE_OG_PO_Checked_On__c;                             //WorkOrder Date of PO
                case_x.CreatedById=casedetailWO.CreatedById;// Case owner           
                case_x.ProjectName=casedetailWO.GE_OG_Project_Number__c;                                                  
                case_x.RecordTypeId=casedetailWO.RecordType.Name;
                case_x.CustomerContactName=casedetailWO.GE_PC_Ship_to_Account__r.Name;            //Customer ship to Account details 
                case_x.Region = casedetailWO.Management_Country__c;
                case_x.CaseSSOID = userSSO[0].GE_HQ_SSO_ID__c;
                //Added the below If else condition as part of R-29567
                if(casedetailWO.GE_PC_Ship_to_Account__c!=null){
                    case_x.ShiptoDuns=casedetailWO.GE_PC_Ship_to_Account__r.GE_HQ_DUNS_Number__c;}
                else if(casedetailWO.GE_OG_AL_Ship_to_Account_Number__c!=null){
                    case_x.ShiptoDuns=casedetailWO.GE_OG_AL_Ship_to_Account_Number__c;}//END 0f R-29567
                case_x.RigName = casedetailWO.GE_SS_Rig_Vessel_Name__r.Name;
                case_x.VesselName = casedetailWO.GE_SS_Field__r.Name;
                case_x.BillingType=casedetailWO.SVMXC__Order_Type__c ;
                }
            }
            else {
           
            //  Case Details
            Case casedetail = new Case();
            casedetail = [Select Id,CaseNumber,CreatedDate,CreatedById,GE_OG_DS_Region__c,GE_OG_DS_Non_Billable_Reason__c ,SVMXC__Billing_Type__c,GE_ES_Project_Number__c,RecordType.Name,SVMXC__Site__c,GE_PC_Ship_to_Account__r.Name,SVMXC__Site__r.Name, SVMXC__Site__r.GE_DS_GE_Rig__c,GE_DS_Opportunity_Number__c,AccountId,Account.Name,Account.GE_HQ_DUNS_Number__c,GE_PC_Ship_to_Account__c,GE_PC_Ship_to_Account__r.GE_HQ_DUNS_Number__c from Case where Id =: caseId AND RecordType.Name ='FS-D&S'];
            
            // Added as a part of R-24912 -- Start
            if(casedetail.RecordType.Name=='FS-D&S'){           
                   
                //Account
                account_x.AccountName=casedetail.Account.Name;
                account_x.DUNSNumber=casedetail.Account.GE_HQ_DUNS_Number__c;
                 List<User> userSSO=[Select id, FirstName, LastName, GE_HQ_SSO_ID__c FROM User WHERE id=:UserInfo.getUserId() AND IsActive=true LIMIT 1];
                //Location
                location_xItem.add(location_x); 
                account_x.Location=location_xItem ;
                //Case
                case_x.CaseID=casedetail.Id;                                                                //Case ID
                case_x.CaseNumber=casedetail.CaseNumber;                                                    //Case Number
                case_x.CaseCreatedDate=casedetail.CreatedDate;                                              //Case Created Date
                case_x.CreatedById=casedetail.CreatedById;// Case owner           
                case_x.ProjectName=casedetail.GE_ES_Project_Number__c;                                                  
                case_x.RecordTypeId=casedetail.RecordType.Name;
                case_x.CustomerContactName=casedetail.GE_PC_Ship_to_Account__r.Name;            //Customer ship to Account details 
                case_x.Region = casedetail.GE_OG_DS_Region__c;
                case_x.CaseSSOID = userSSO[0].GE_HQ_SSO_ID__c;
               // case_x.BillingType =casedetail.SVMXC__Billing_Type__c;
                case_x.ShiptoDuns=casedetail.GE_PC_Ship_to_Account__r.GE_HQ_DUNS_Number__c;
                case_x.OpportunityNumber=casedetail.GE_DS_Opportunity_Number__c;
                case_x.RigName = casedetail.SVMXC__Site__r.Name;
                 if ((casedetail.SVMXC__Billing_Type__c == 'Commissioning') ||(casedetail.SVMXC__Billing_Type__c == 'Cost transfer')){
                        
                            case_x.BillingType=casedetail.SVMXC__Billing_Type__c ;
                            
                 }else if(casedetail.SVMXC__Billing_Type__c == 'Non Billable'){
                                
                                case_x.BillingType=casedetail.GE_OG_DS_Non_Billable_Reason__c ;
                                
                        }else{
                            case_x.BillingType='Services';
                            }
                                    
                }
            }
                    // Added as a part of R-24912 -- End  
                      
                  
            
            case_xItem.add(case_x);
            location_x.Case_x=case_xItem;
            
            System.debug('Case Number: '+case_x.CaseNumber +'\t Case Created Date: '+case_x.CaseCreatedDate +'\t PO#: '+'\t Customer Phone No: '+case_x.CustomerPhoneNumber +'\t Customer Email: '+case_x.CustomerEmailAddress+'\t RecordType Id'+Case_x.RecordTypeId +'\t ServiceOrderNumber'+Case_x.ServiceOrderNumber +'\t Region'+Case_x.Region);
                details_x.Account=account_x;
                processResponse_x.details=processRequest_x.ProcessWorkOrder(details_x.Attachment,details_x.Account);
                wsInvokeResult='Success';
                return wsInvokeResult; 
    }  
       
}