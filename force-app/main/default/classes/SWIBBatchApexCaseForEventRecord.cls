global class SWIBBatchApexCaseForEventRecord implements Database.batchable<sobject>, Database.stateful 
{    
    private List<Case> sortList;
    private Integer sortNum;
    //Database.SaveResult[] srList;

    public string rtypeCir{ get; set; }
    public string rtypeNPT{ get; set; }
    public string rtypeCaM{ get; set; }
    public string rtypeSCM{ get; set; }
    public string rtypeSM{ get; set; }
    public string rtypeSXT{ get; set; }
      public string rtypeSC{ get; set; }
      public string rtypeSEM{ get; set; }
//public List<GE_Installed_Base__c> lstGESNEquipName {get;set;}

    Public List<Case> lstGECombinedList {get;set;}
    public List<Case> lstGESNEquipNameCIR {get;set;}
    public List<Case> lstGESNEquipNameNPT {get;set;}
    public List<Case> lstGESNEquipNameCam {get;set;}
    public List<string> lstGESNEquipName {get;set;}
    public List<string> lstAllowedRecordTypeIDs {get;set;}
        
    global Map<Id, String> errorMap {get; set;}
    global Map<Id, SObject> IdToSObjectMap {get; set;}
    
//public List<ID> lstGESNEquipNameCIR {get;set;}

//public List<GE_Installed_Base__c> lstIB {get;set;} 

    Public string queryString;
    
    public SWIBBatchApexCaseForEventRecord()
    {
     errorMap = new Map<Id, String>();
     IdToSObjectMap = new Map<Id, SObject>();
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
    
    //global Iterable<Sobject> start(Database.batchableContext info){ 
    // //  Iterable<SObject> myIter = (Iterable<SObject>) new CustomIterable();
     //  system.debug('myIter ------' + myIter );
     //  return myIter; 
   //}  
    
    global void execute(database.batchablecontext bd, list<SObject> scope)
    { 
       List<SWIBEventRecord__c> lstSWIBEventRecord = new List<SWIBEventRecord__c>();
        
        
       // List<SWIBEventRecord__c> queryResult = DataBase.Query('Select Event_Record_Number__c , Event_End_Date__c, Record_Type__c, Failure_Mode__c, Notes__c , Name FROM SWIBEventRecord__c');
       //  Map<Event_Record_Number__c, List<SWIBEventRecord__c>> mapQueryResult = DataBase.Query('Select Event_Record_Number__c , Event_End_Date__c, Record_Type__c, Failure_Mode__c, Notes__c  Name FROM SWIBEventRecord__c');
        Map<String, ID> CasesOrderMap = new Map<String, ID>();        
        Map<String, ID> SWOrderMap = new Map<String, ID>(); 
        
         
        //List<Case> allCases = [Select id From case where id in :caseId];
        Map<String, GE_Installed_Base__c> caseIdMap = new Map<String, GE_Installed_Base__c>([Select id,name From GE_Installed_Base__c LIMIT 49999]);
   
        /*for(Case caseIdStore:allCases)
        {
            caseIdMap.put(caseIdStore.ID,allCases);
        }*/
        for(SObject tmpRec : scope)    
        {
          
          Case tmpCase = (Case)tmpRec; // type cast to case
         
          
          //testing
           CasesOrderMap.put(String.valueOf(tmpCase.CaseNumber), tmpCase.Id);
           system.debug('CasesOrderMap ---->' + CasesOrderMap );
          
          //select records from SWIBRecord
           
       //   for(SWIBEventRecord__c tmpSWIB :[SELECT Event_Record_Number__c , ID FROM SWIBEventRecord__c LIMIT 1000])
      //    {
       //       SWOrderMap.Put(tmpSWIB.Event_Record_Number__c,tmpSWIB.ID);
       //       system.debug('SWOrderMap ---->' + SWOrderMap);
        //  }
          //testing
          
          SWIBEventRecord__c objSWIBEventRec = new SWIBEventRecord__c(); // create new rec
         // rtypeCir=[Select id from recordtype where sobjecttype='Case' and name='CIR'].id;
         // rtypeNPT=[Select id from recordtype where sobjecttype='Case' and name='SS_NPT'].id;
        //  rtypeCaM=[Select id from recordtype where sobjecttype='Case' and name='SIR - CaM'].id;
          system.debug('rtypeCir==' + rtypeCir); 
           system.debug('rtypeNPT==' + rtypeNPT); 
            system.debug('rtypeCaM==' + rtypeCaM); 
           
          string strDesc = tmpCase.Description;     
          //tmpRec.Event_Record_Number__c;          
           // for(SWIBEventRecord__c tmpER : queryResult)
           // {
          // mapQueryResult.get()
           // if(tmpER.Event_Record_Number__c == tmpCase.CaseNumber)
            //   {
                objSWIBEventRec.Event_Record_Number__c = tmpCase.CaseNumber;
                objSWIBEventRec.Event_Description__c = strDesc;//'New Updated from batch'  ;
                objSWIBEventRec.Event_End_Date__c =  tmpCase.GE_OG_CIR_Case_Closure_Date__c;
                objSWIBEventRec.Record_Type__c = tmpCase.RecordType.Name;       
                objSWIBEventRec.RecordTypeID__C = tmpCase.ID;
               /* if(tmpCase.RecordTypeId == rtypeCir || tmpCase.RecordTypeId == rtypeNPT)
                {
                    objSWIBEventRec.Event_Start_Date__c = tmpcase.GE_OG_Issue_Event_Date_CIR__c;
                }
                else
                {
                    objSWIBEventRec.Event_Start_Date__c = tmpCase.GE_SS_Case_Creation_Date__c;
                }*/
                if(tmpCase.RecordTypeId == rtypeCir)
                {
                  //  GE_Installed_Base__c tmpIB = [SELECT Name FROM GE_Installed_Base__c where id = :tmpcase.GE_OG_CIR_Unit_Serial_number__r.Name];
                    
                    objSWIBEventRec.Event_Type__c = tmpCase.GE_OG_CIR_Type_of_Issue__c;
                    objSWIBEventRec.Event_Start_Date__c = tmpcase.GE_OG_Issue_Event_Date_CIR__c;
                    //objSWIBEventRec.SWIB_GE_S_N_Equip_Name__c = tmpcase.GE_OG_CIR_Unit_Serial_number__c;
                    /* on 10/19/2016 commented by sonali rathore
                    objSWIBEventRec.SWIB_GE_S_N_Equip_Name__c = tmpcase.GE_OG_CIR_Unit_Serial_number__r.Name;
                    */
                    objSWIBEventRec.GE_Equipment_Name_Lkp__c = tmpcase.GE_OG_CIR_Unit_Serial_number__c;
                    
                    system.debug('text---->' + tmpcase.GE_OG_CIR_Unit_Serial_number__r.Name);
                 
                  
                    
                    
                }else if(tmpCase.RecordTypeId == rtypeNPT){
                    objSWIBEventRec.Event_Type__c = tmpCase.GE_OG_CIR_Type_of_Issue__c;
                    objSWIBEventRec.Well_ID__c = tmpCase.GE_NPT_Well_Name_ID__c;
                    objSWIBEventRec.Event_Start_Date__c = tmpcase.GE_OG_Issue_Event_Date_CIR__c;
                     //objSWIBEventRec.GE_Equipment_Name_Lkp__c = tmpcase.GE_NPT_Unit_Serial_Number__c;
                     if(caseIdMap.containskey(tmpCase.GE_NPT_Unit_Serial_Number__c) )
                     {
                         objSWIBEventRec.GE_Equipment_Name_Lkp__c = caseIdMap.get(tmpcase.GE_NPT_Unit_Serial_Number__c).Id;
                     }else
                     {
                         objSWIBEventRec.GE_Equipment_Name_Lkp__c = null;
                     }
                   
                   
                    
                  
                }
                else
                {   objSWIBEventRec.Event_Type__c = tmpCase.Type;
                    objSWIBEventRec.Event_Start_Date__c = tmpCase.GE_SS_Case_Creation_Date__c;
                    //objSWIBEventRec.GE_Equipment_Name_Lkp__c = tmpcase.GE_Serial_Number__c;
                    if(caseIdMap.containskey(tmpcase.GE_Serial_Number__c))
                     {
                         objSWIBEventRec.GE_Equipment_Name_Lkp__c = caseIdMap.get(tmpcase.GE_Serial_Number__c).Id;
                     }else
                     {
                         objSWIBEventRec.GE_Equipment_Name_Lkp__c = null;
                     }
                    
                  
                }
                lstSWIBEventRecord.Add(objSWIBEventRec);
              //  }
           // }
        }
        //update scope;
       
        if(lstSWIBEventRecord != null && lstSWIBEventRecord.Size() > 0 )//if list contains Records
            {
                List<Database.SaveResult> srList = Database.Insert(lstSWIBEventRecord,false);
                Integer index = 0;
                System.Debug('SWIBRunBatchApex SIZE: ' + lstSWIBEventRecord.size());
                System.Debug('SWIBRunBatchApex: Records Inserted in Custom Object--SWIBEventRecord--' + lstSWIBEventRecord);
                
                for(Database.SaveResult tmpSR : srList){
                if(!tmpSR.isSuccess() ){
                    String errMsg = tmpSR.getErrors()[0].getMessage();
                    StatusCode errCode = tmpSR.getErrors()[0].getStatusCode();
                    system.debug('Error code on insert ---->' + tmpSR.getErrors()[0]);
                 
                   if(tmpSR.getErrors()[0].getStatusCode() != StatusCode.DUPLICATE_VALUE)
                    {
                      system.debug('Entered if--->');
                      errorMap.put(lstSWIBEventRecord[index].Id, errMsg);
                      IdToSObjectMap.put(lstSWIBEventRecord[index].Id, lstSWIBEventRecord[index]);
                      system.debug('lstSWIBEventRecord['+index+'].Id' + lstSWIBEventRecord[index].Id);
                    }  
                }
                index++;
            }
            } 
        else System.Debug('No records to Insert!');
        
       
    }
    
    Public void finish(database.batchableContext bc)
    {
      //Send an email to the User after batch completes 
       if(!errorMap.isEmpty() ||Test.isRunningTest() )
       {
          AsyncApexJob a = [SELECT id, ApexClassId,
                       JobItemsProcessed, TotalJobItems,
                       NumberOfErrors,CreatedDate, CompletedDate, CreatedBy.Email
                       FROM AsyncApexJob
                       WHERE id = :BC.getJobId()];
                       
                       
        String body = 'Your batch job '
             + 'SWIBRunBatchApex '
             + 'has finished. \n' 
             + 'There were '
             + errorMap.size()
             + ' errors. Please find the error list attached.';
             
            // Creating the CSV file
            String finalstr = 'Id, Name, Error \n';
            String subject = 'Case - Apex Batch Error List';
            String attName = 'Case Insert - Errors.csv';
            
            system.Debug('errorMap.KeySet:' + errorMap.keySet());
            
            for(Id id  : errorMap.keySet()){
                string err = errorMap.get(id);
                SWIBEventRecord__c tmpSWIB = (SWIBEventRecord__c) IdToSObjectMap.get(id);
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
            //email.setToAddresses( new String[] {'richa.chauhan@birlasoft.com'} );
              OrgWideEmailAddress owa = [select Id, Address, DisplayName from OrgWideEmailAddress WHERE Id=: Label.GE_OG_SER_OrganizationWideEmailLabel LIMIT 1];
            email.setOrgWideEmailAddressId(owa.id);
        
            String toAddress = Label.GEOGSWIBUserDL;
            String[] toAdd = toAddress.split(',');
            email.setToAddresses(toAdd);
            email.setPlainTextBody( body );
            email.setHtmlBody('Please find below the list of records which failed insertion.<br/><br/> Batch Submission Date/Time:' + a.CreatedDate+'<br/> Batch Completion Date/Time: '+a.CompletedDate+'<br/><br/>');
            email.setFileAttachments(new Messaging.EmailFileAttachment[] {efa});
 
            // Sends the email
            Messaging.SendEmailResult [] r = 
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});   
           
    }      //end of if
    /*else
    {
         //In case of no errors, send successful completion mail
         Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage(); 
         String subject = 'Case - Apex Batch Success List';
         email.setHTMLBody('The batch SWIBBatchApexCaseForEventRecord has completed successfully.');
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
            
            ///Send Mail
            AsyncApexJob a = [SELECT Id, CreatedDate, CompletedDate FROM AsyncApexJob WHERE Id = :BC.getJobId()];
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
       // OrgWideEmailAddress owa = [select Id, Address, DisplayName from OrgWideEmailAddress WHERE Id=: Label.GE_OG_SER_OrganizationWideEmailLabel LIMIT 1];
        //mail.setOrgWideEmailAddressId(owa.id);
        
       // String toAddress = Label.GEOGOHRUserDL;
       // String[] toAdd = toAddress.split(',');
        mail.setToAddresses(new String[] {'richa.chauhan@birlasoft.com'});
        //mail.setCCAddresses();
        mail.setSubject('User Data Updated from SWIB Batch');
        mail.setHtmlBody('Please find below the list of records which failed insertion.<br/><br/> Batch Submission Date/Time:' + a.CreatedDate+'<br/> Batch Completion Date/Time: '+a.CompletedDate+'<br/><br/>Total Number of Case Records: '+lstSWIBEventRecord.size()+'<br/>Number of Case Records Processed: '+lstSWIBEventRecord.size()+'<br/><br/>');
        
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        }
     }

    }} //end of for //end of if*/
    }//end of method finish
 
 public string tmpQuery{get;set;}
 
 Public string CreateBatchSOQL()
  {
       
 rtypeCir=[Select id from recordtype where sobjecttype='Case' and name='CIR'].id;
 rtypeNPT=[Select id from recordtype where sobjecttype='Case' and name='SS_NPT'].id;
 rtypeCaM=[Select id from recordtype where sobjecttype='Case' and name='SIR - CaM'].id;
 
 lstAllowedRecordTypeIDs = new List<string>();
 lstAllowedRecordTypeIDs.Add(rtypeCir);
 lstAllowedRecordTypeIDs.Add(rtypeNPT);
 lstAllowedRecordTypeIDs.Add(rtypeCaM);
   
 rtypeSCM=[Select id from recordtype where sobjecttype=:'GE_Installed_Base__c' and name=:'Subsea Control Module'].id;
 rtypeSM=[Select id from recordtype where sobjecttype=:'GE_Installed_Base__c' and name=:'Subsea Manifold'].id;
 rtypeSXT=[Select id from recordtype where sobjecttype=:'GE_Installed_Base__c' and name=:'Subsea Xmas Tree'].id;
 rtypeSC =[Select id from recordtype where sobjecttype=:'GE_Installed_Base__c' and name=:'Subsea Choke'].id;
 rtypeSEM = Schema.SObjectType.GE_Installed_Base__c.getRecordTypeInfosByName().get('Subsea Electronic Module').getRecordTypeId();
 
  //List<GE_Installed_Base__c> lstIB = [SELECT Name, recordTypeID FROM GE_Installed_Base__c WHERE recordTypeID =: rtypeSCM OR recordTypeID =: rtypeSM OR recordTypeID =: rtypeSXT];
  //system.debug('-----------lstIB---------------' + lstIB);
  //system.debug('-----------lstIB size---------------' + lstIB.size());
  
  lstGESNEquipName = new List<string>();
  try{
  for(GE_Installed_Base__c tmpName : [SELECT Name FROM GE_Installed_Base__c  WHERE recordTypeID =: rtypeSCM OR recordTypeID =: rtypeSM OR recordTypeID =: rtypeSXT OR recordTypeID =: rtypeSC OR recordTypeID=:rtypeSEM LIMIT 100])
  {
      
      lstGESNEquipName.Add(tmpName.Name);        
  }
  }
  catch(exception ex)
  {
     System.debug('The following exception has occurred: ' + ex.getMessage());

  }
  system.debug('----------------lstGESNEquipName------------------------' + lstGESNEquipName);
 //SELECT Name,RecordTypeId,LastActivityDate,ID FROM GE_Installed_Base__c order by LastActivityDate
 
//SELECT LastActivityDate,Name,GE_SS_Job_Type__c, GE_SS_Job_Description__c FROM SVMXC__Service_Order__c WHERE 
 //GE_OG_MC_Serial_Nmber__c ='M064340-1' AND SVMXC__Order_Status__c ='Closed' AND recordtype = :
 
  List<Case> lstGESNEquipNameCIR = new List<Case>();
  List<Case> lstGESNEquipNameNPT = new List<Case>();
  List<Case> lstGESNEquipNameCam = new List<Case>();
  
  
  //tmpQuery = 'SELECT CaseNumber,Description,LastModifiedDate,status,GE_OG_CIR_Type_of_Issue__c,GE_OG_CIR_Case_Closure_Date__c,RecordTypeId,RecordType.Name FROM Case where status= \'Closed\' and RecordTypeId = :rtypeCir and GE_OG_CIR_Unit_Serial_number__c IN :lstGESNEquipName';
 // tmpQuery = 'SELECT CaseNumber,Description,LastModifiedDate,status,GE_OG_CIR_Type_of_Issue__c,GE_OG_CIR_Case_Closure_Date__c,RecordTypeId,RecordType.Name FROM Case where status= \'Closed\' and RecordTypeId = :rtypeCir and RecordTypeId = :rtypeNPT and RecordTypeId = :rtypeCaM';
    tmpQuery = 'SELECT CaseNumber,Description,LastModifiedDate,status,GE_OG_CIR_Unit_Serial_number__r.Name, GE_OG_CIR_Unit_Serial_number__c ,GE_Serial_Number__c,GE_NPT_Unit_Serial_Number__c,GE_NPT_Well_Name_ID__c,Type,GE_OG_CIR_Type_of_Issue__c,GE_OG_CIR_Case_Closure_Date__c,RecordTypeId,RecordType.Name,GE_OG_Issue_Event_Date_CIR__c,GE_SS_Case_Creation_Date__c FROM Case where status= \'Closed\' and RecordTypeId IN :lstAllowedRecordTypeIDs';
  system.debug('tmpQuery soqlquery--->' + tmpQuery);
  return tmpQuery;
  }   
}