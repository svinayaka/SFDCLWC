global class SWIBBatchApexWOForEventRecord implements database.batchable<sobject>, Database.stateful 
{    
    private List<Case> sortList;
    private Integer sortNum;
     Database.SaveResult[] srList;

    public string rtypeDaily{ get; set; }
    public string rtypeMobilize{ get; set; }
    public string rtypeTrip{ get; set; }
    public string rtypeSCM{ get; set; }
    public string rtypeSM{ get; set; }
    public string rtypeSXT{ get; set; }
//public List<GE_Installed_Base__c> lstGESNEquipName {get;set;}

    //Public List<Case> lstGECombinedList {get;set;}
    public List<Case> lstGESNEquipNameCIR {get;set;}
    public List<Case> lstGESNEquipNameNPT {get;set;}
    public List<Case> lstGESNEquipNameCam {get;set;}
    public List<string> lstGESNEquipName {get;set;}
    public List<string> lstAllowedWORecordTypids {get;set;}
//public List<ID> lstGESNEquipNameCIR {get;set;}

    global Map<Id, String> errorMapWO {get; set;}
    global Map<Id, SObject> IdToSObjectMapWO {get; set;}
    

    Public string queryString;
    
    global SWIBBatchApexWOForEventRecord()//constructor
    {
        errorMapWO = new Map<Id, String>();
        IdToSObjectMapWO  = new Map<Id, SObject>();    
    }
    
    
    Public void setQry()
    {
        this.queryString = CreateBatchSOQL();
        //queryString = 'SELECT CaseNumber,Description,LastModifiedDate,status,GE_OG_CIR_Type_of_Issue__c,GE_OG_CIR_Case_Closure_Date__c,RecordTypeId,RecordType.Name FROM Case where status= \'Closed\'';
    }
    
    global database.querylocator start(database.batchableContext bc)
    {
        setQry();
        system.debug('queryString------------------ ' + queryString );
        return database.getquerylocator(queryString);
    }
    
    global void execute(database.batchablecontext bd, list<SVMXC__Service_Order_Line__c> scope)
    { 
        system.debug('Batch Execute called------------------ ' );
        List<SWIBEventRecord__c > lstSWIBEventRecord = new List<SWIBEventRecord__c >();
        
        
       // List<SWIBEventRecord__c> queryResult = DataBase.Query('Select Event_Record_Number__c , Event_End_Date__c, Record_Type__c, Failure_Mode__c, Notes__c , Name FROM SWIBEventRecord__c');
      //  Map<Event_Record_Number__c, List<SWIBEventRecord__c>> mapQueryResult = DataBase.Query('Select Event_Record_Number__c , Event_End_Date__c, Record_Type__c, Failure_Mode__c, Notes__c  Name FROM SWIBEventRecord__c');
        system.debug('query result--->' + scope);        
        
        String tmpIB;
            
        map<Id,SVMXC__Site__c> mapSiteMapID= new map<Id,SVMXC__Site__c>();
        map<Id,SVMXC__Installed_Product__c> mapIBnameSerialNumber = new map<id,SVMXC__Installed_Product__c>();
        for (SVMXC__Service_Order_Line__c woSitemapKey : scope){
            mapSiteMapID.put(woSitemapKey.SVMXC__Service_Order__r.GE_SS_Well_ID__c, null);
            mapIBnameSerialNumber.put(woSitemapKey.SVMXC__Serial_Number__c, null);
        }
        
        mapSiteMapID.remove(null);
        mapIBnameSerialNumber.remove(null);
        mapSiteMapID.putAll([SELECT Id, Name FROM SVMXC__Site__c WHERE Id In : mapSiteMapID.keySet()]);
        mapIBnameSerialNumber.putAll([SELECT Id, Name FROM SVMXC__Installed_Product__c WHERE id IN :mapIBnameSerialNumber.keySet()]);
        
        for(SObject tmpRec: scope)
        {
          SVMXC__Service_Order_Line__c tmpWO= (SVMXC__Service_Order_Line__c)tmpRec; // type cast to WO object SVMXC__Service_Order_Line__c
         // SWIBEventRecord__c objSWIBEventRec = new SWIBEventRecord__c (); // create new rec
          if(tmpWO.SVMXC__Serial_Number__c != Null)
          {
           
           system.debug('tmpWO.SVMXC__Service_Order__r.Name --->' + tmpWO.SVMXC__Service_Order__r.Name);
           system.debug('tmpWO.SVMXC__Service_Order__r.Name --->' + tmpWO.SVMXC__Serial_Number__c);
           SWIBEventRecord__c objSWIBEventRec = new SWIBEventRecord__c (); // create new rec
          
           
           string strWO_desc = tmpWO.SVMXC__Service_Order__r.GE_SS_Job_Description__c;     
          //tmpRec.Event_Record_Number__c;          
           // for(SWIBEventRecord__c tmpER : queryResult)
           // {
          // mapQueryResult.get()
           // if(tmpER.Event_Record_Number__c == tmpCase.CaseNumber)
            //   {
                Date dateWO;
                Date dateWOstartDate;
                String tmpWellID;
                
                //SVMXC__Installed_Product__c tmpIB = [SELECT Name  FROM SVMXC__Installed_Product__c where id = :tmpWO.case_line__r.GE_SS_Serial_Number__c AND Name != '' LIMIT 1];
                if(tmpWO.SVMXC__Serial_Number__c != Null || tmpWO.SVMXC__Serial_Number__c != '')
                {   if(mapIBnameSerialNumber.get(tmpWO.SVMXC__Serial_Number__c).Name != Null || mapIBnameSerialNumber.get(tmpWO.SVMXC__Serial_Number__c).Name != '')
                        //tmpIB  = mapIBnameSerialNumber.get(tmpWO.SVMXC__Serial_Number__c).Name;
                    tmpIB  = mapIBnameSerialNumber.get(tmpWO.SVMXC__Serial_Number__c).Id;
                }
                
                if(tmpWO.SVMXC__Service_Order__r.GE_SS_Well_ID__c != Null || tmpWO.SVMXC__Service_Order__r.GE_SS_Well_ID__c != '')
                {
                  if(mapSiteMapID.ContainsKey(tmpWO.SVMXC__Service_Order__r.GE_SS_Well_ID__c)) tmpWellID = mapSiteMapID.get(tmpWO.SVMXC__Service_Order__r.GE_SS_Well_ID__c).Name;
                    
                   // tmpWellID = [SELECT name FROM SVMXC__Site__c where id= :tmpWO.SVMXC__Service_Order__r.GE_SS_Well_ID__c LIMIT 1];
                }   
                //objSWIBEventRec.Event_Record_Number__c = tmpIB.Name;
                //objSWIBEventRec.SWIB_GE_S_N_Equip_Name__c = tmpIB;
                
                objSWIBEventRec.GE_Equipment_Name_Lkp__c = tmpIB;
                
                objSWIBEventRec.Event_Record_Number__c = tmpWO.SVMXC__Service_Order__r.Name + '**' + tmpIB; //append Serial Number for uniqueness
                DateTime datetimeWO = tmpWO.SVMXC__Service_Order__r.GE_SM_HQ_Actual_End_Date__c;
                DateTime datetimeWOstartDate = tmpWO.SVMXC__Service_Order__r.GE_SM_HQ_Actual_Start_Date__c;
                if(datetimeWO != Null)
                dateWO = date.newinstance(datetimeWO.year(), datetimeWO.month(), datetimeWO.day());
                
                if(datetimeWOstartDate != Null)
                dateWOstartDate = date.newinstance(datetimeWOstartDate.year(), datetimeWOstartDate.month(), datetimeWOstartDate.day());
                
               objSWIBEventRec.Event_Description__c = strWO_desc;
                
                if(dateWO != Null)
                objSWIBEventRec.Event_End_Date__c =  dateWO;
                
                if(dateWOstartDate != Null)
                {
                    objSWIBEventRec.Event_Start_Date__c =  dateWOstartDate;
                }
                
                objSWIBEventRec.Record_Type__c = tmpWO.SVMXC__Service_Order__r.RecordType.Name;       
                objSWIBEventRec.RecordTypeID__C = tmpWO.SVMXC__Service_Order__r.ID;
                if(tmpWO.SVMXC__Service_Order__r.GE_SS_Well_ID__c != Null ) { objSWIBEventRec.Well_ID__c = tmpWellID;
                }
                else
                {
                    objSWIBEventRec.Well_ID__c = '';
                }        
               // objSWIBEventRec.Event_Type__c = tmpWO.SVMXC__Service_Order__r.GE_SS_Job_Type__c;
               // objSWIBEventRec.Event_Type__c = tmpWorkOrder.Case_Line__c;
                
                lstSWIBEventRecord.Add(objSWIBEventRec);
                system.debug('SWIB event record number---->' + objSWIBEventRec.Event_Record_Number__c);
                system.debug('SWIB records to be inserted---->' + lstSWIBEventRecord);
              //  }
           // }
         }//end of if
        }// end of for
        //update scope;
       
        if(lstSWIBEventRecord != null && lstSWIBEventRecord.Size() > 0 )//if list contains Records
            {
                List<Database.SaveResult> srList = Database.Insert(lstSWIBEventRecord,false);
                Integer index = 0;
                System.Debug('SWIBRunBatchApexWO SIZE: ' + lstSWIBEventRecord.size());
                System.Debug('SWIBRunBatchApexWO: Records Inserted in Custom Object--SWIBEventRecord--' + lstSWIBEventRecord);
                system.debug('srList---->' + srList);
                  for(Database.SaveResult tmpSR : srList){
                if(!tmpSR.isSuccess()){
                    String errMsg = tmpSR.getErrors()[0].getMessage();
                    StatusCode errCode = tmpSR.getErrors()[0].getStatusCode();
                    system.debug('Error code on insert ---->' + tmpSR.getErrors()[0]);
                 
                   if(tmpSR.getErrors()[0].getStatusCode() != StatusCode.DUPLICATE_VALUE)
                    {
                      system.debug('Entered if--->');
                      errorMapWO.put(lstSWIBEventRecord[index].Id, errMsg);
                      IdToSObjectMapWO.put(lstSWIBEventRecord[index].Id, lstSWIBEventRecord[index]);
                      system.debug('lstSWIBEventRecord['+index+'].Id' + lstSWIBEventRecord[index].Id);
                    }  
                }
                index++;
            }
           } 
       
     
    }
    
    Public void finish(database.batchableContext bc)
    {
    
     //Send an email to the User after batch completes 
     
       if(!errorMapWO.isEmpty() )
       {
        
            AsyncApexJob a = [SELECT id, ApexClassId,
                       JobItemsProcessed, TotalJobItems,
                       NumberOfErrors, CompletedDate, CreatedDate, CreatedBy.Email
                       FROM AsyncApexJob
                       WHERE id = :BC.getJobId()];
                     
                       
        String body = 'Your batch job '
             + 'SWIBRunBatchApexWO '
             + 'has finished. \n' 
             + 'There were '
             + errorMapWO.size()
             + ' errors. Please find the error list attached.';
             
            // Creating the CSV file
            String finalstr = 'Id, Name, Error \n';
            String subject = 'Work Order - Apex Batch Error List';
            String attName = 'Work Order Insert - Errors.csv';
            
            system.Debug('errorMapWO.KeySet:' + errorMapWO.keySet());
            
            for(Id id  : errorMapWO.keySet()){
                string err = errorMapWO.get(id);
                SWIBEventRecord__c tmpSWIB = (SWIBEventRecord__c) IdToSObjectMapWO .get(id);
                string recordString = '"'+id+'","'+ tmpSWIB.Event_Record_Number__c+'","'+err+'"\n';
                finalstr = finalstr +recordString;
               } 
          
           // Define the email
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage(); 
 
            // Create the email attachment    
            Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
            efa.setFileName(attName);
            efa.setBody(Blob.valueOf(finalstr));
 
            // Sets the paramaters of the email
            email.setSubject( subject ); 
           // email.setToAddresses( new String[] {'richa.chauhan@birlasoft.com'} );
             OrgWideEmailAddress owa = [select Id, Address, DisplayName from OrgWideEmailAddress WHERE Id=: Label.GE_OG_SER_OrganizationWideEmailLabel LIMIT 1];
             email.setOrgWideEmailAddressId(owa.id);
        
            String toAddress = Label.GEOGSWIBUserDL;
            String[] toAdd = toAddress.split(',');
            email.setToAddresses(toAdd);
            email.setPlainTextBody( body );
            email.setFileAttachments(new Messaging.EmailFileAttachment[] {efa});
             email.setHtmlBody('Please find below the list of records which failed insertion.<br/><br/> Batch Submission Date/Time:' + a.CreatedDate+'<br/> Batch Completion Date/Time: '+a.CompletedDate+'<br/><br/>');
            // Sends the email
            Messaging.SendEmailResult [] r = 
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});   
           
    }      //end of if
   /* else
    {
         //In case of no errors, send successful completion mail
         Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage(); 
         String subject = 'Work Order - Apex Batch Success List';
         email.setHTMLBody('Success');
         email.setSubject( subject ); 
         //email.setToAddresses( new String[] {'richa.chauhan@birlasoft.com'} );
         OrgWideEmailAddress owa = [select Id, Address, DisplayName from OrgWideEmailAddress WHERE Id=: Label.GE_OG_SER_OrganizationWideEmailLabel LIMIT 1];
         email.setOrgWideEmailAddressId(owa.id);
        
        String toAddress = Label.GEOGSWIBUserDL;
        String[] toAdd = toAddress.split(',');
        email.setToAddresses(toAdd);
         
         // Sends the email
         Messaging.SendEmailResult [] r = 
         Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});   
         
        
    }*/
    // Iterate through each returned result
  /* if(srList != null && srList.size() > 0)
    {for (Database.SaveResult sr : srList) {

     if (sr.isSuccess()) 
     {
        System.debug('Successfully inserted Record ID: ' + sr.getId());
     }
     else 
     {
     
        // get all errors               
        for(Database.Error err : sr.getErrors()) 
        {
            System.debug('The following error has occurred.');                   
            System.debug(err.getStatusCode() + ': ' + err.getMessage());
            System.debug('Fields that returned this error: ' + err.getFields());
        }
     }

    }} //end of for //end of if*/
    }
 
 public string tmpQuery{get;set;}
  Public string CreateBatchSOQL()
  {
       
 rtypeDaily=[Select id from recordtype where sobjecttype='SVMXC__Service_Order__c' and name='SS-Daily'].id;
 rtypeMobilize=[Select id from recordtype where sobjecttype='SVMXC__Service_Order__c' and name='SS-Mobilize'].id;
 rtypeTrip=[Select id from recordtype where sobjecttype='SVMXC__Service_Order__c' and name='SS-Trip'].id;
 
 lstAllowedWORecordTypids = new List<string>();
 lstAllowedWORecordTypids.Add('SS-Daily');
 lstAllowedWORecordTypids.Add('SS-Mobilize');
 lstAllowedWORecordTypids.Add('SS-Trip');
 
   
 //rtypeSCM=[Select id from recordtype where sobjecttype=:'GE_Installed_Base__c' and name=:'Subsea Control Module'].id;
 //rtypeSM=[Select id from recordtype where sobjecttype=:'GE_Installed_Base__c' and name=:'Subsea Manifold'].id;
// rtypeSXT=[Select id from recordtype where sobjecttype=:'GE_Installed_Base__c' and name=:'Subsea Xmas Tree'].id;
 
 
 // List<GE_Installed_Base__c> lstIB = [SELECT Name, recordTypeID FROM GE_Installed_Base__c WHERE recordTypeID =: rtypeSCM OR recordTypeID =: rtypeSM OR recordTypeID =: rtypeSXT];
 // system.debug('-----------lstIB---------------' + lstIB);
 // system.debug('-----------lstIB size---------------' + lstIB.size());
  
  /*lstGESNEquipName = new List<string>();
  try{
  for(GE_Installed_Base__c tmpName : [SELECT Name FROM GE_Installed_Base__c  WHERE recordTypeID =: rtypeSCM OR recordTypeID =: rtypeSM OR recordTypeID =: rtypeSXT LIMIT 100])
  {
      
      lstGESNEquipName.Add(tmpName.Name);        
  }
  }
  catch(exception ex)
  {
     System.debug('The following exception has occurred: ' + ex.getMessage());

  }*/
  system.debug('----------------lstGESNEquipName------------------------' + lstGESNEquipName);
 //SELECT Name,RecordTypeId,LastActivityDate,ID FROM GE_Installed_Base__c order by LastActivityDate
 
//SELECT LastActivityDate,Name,GE_SS_Job_Type__c, GE_SS_Job_Description__c FROM SVMXC__Service_Order__c WHERE 
 //GE_OG_MC_Serial_Nmber__c ='M064340-1' AND SVMXC__Order_Status__c ='Closed' AND recordtype = :
 
  List<Case> lstGESNEquipNameCIR = new List<Case>();
  List<Case> lstGESNEquipNameNPT = new List<Case>();
  List<Case> lstGESNEquipNameCam = new List<Case>();
  
  
 tmpQuery = 'SELECT SVMXC__Serial_Number__c, case_line__r.GE_SS_Serial_Number__c,SVMXC__Service_Order__r.Name, SVMXC__Service_Order__r.RecordType.Name, SVMXC__Service_Order__r.GE_SM_HQ_Actual_End_Date__c,  SVMXC__Service_Order__r.GE_SM_HQ_Actual_Start_Date__c, SVMXC__Service_Order__r.GE_SS_Job_Type__c,SVMXC__Service_Order__r.GE_SS_Job_Description__c, SVMXC__Service_Order__r.GE_SS_Well_ID__c, SVMXC__Service_Order__r.GE_SM_HQ_Record_Type_Name__c FROM SVMXC__Service_Order_Line__c where SVMXC__Service_Order__r.SVMXC__Order_Status__c = \'closed\' and SVMXC__Service_Order__r.GE_SM_HQ_Record_Type_Name__c IN: lstAllowedWORecordTypids';// and RecordTypeId  IN :lstAllowedWORecordTypids' ;
  
 // tmpQuery = 'SELECT case_line__r.GE_SS_Serial_Number__c FROM SVMXC__Service_Order_Line__c';// where SVMXC__Service_Order__r.SVMXC__Order_Status__c = \'closed\' and RecordTypeId  IN :lstAllowedWORecordTypids'; 
  
  system.debug('tmpQuery soqlquery--->' + tmpQuery);
  return tmpQuery;
  }   
}