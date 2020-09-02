/*
*   Name    : GE_OG_PC_Timesheet.cls
*   Author  : Lourduraja Louissantiagu
*/

public class GE_OG_PC_Timesheet
{   

    public SVMXC_Timesheet__c timesheet{get;set;}
    public List<SVMXC_Timesheet__c> tsheet{get;set;}
    Public Id TimeEntryId {get;set;}
       
   private String sortDirection = 'ASC';
   private String sortExp = 'Technician__c';

   
   public date startdate {get;set;}
   public date enddate {get;set;}
   string userid ;
   string profileId;
   string profileName;
   
   string sortFullExp ;
  
   public String sortExpression
   {
     get
     {
        return sortExp;
     }
     set
     {
       //if the column is clicked on then switch between Ascending and Descending modes
       if (value == sortExp)
         sortDirection = (sortDirection == 'ASC')? 'DESC' : 'ASC';
       else
         sortDirection = 'ASC';
       sortExp = value;
     }
   }

 public String getSortDirection()
 {
    //if not column is selected 
    if (sortExpression == null || sortExpression == '')
      return 'ASC';
    else
     return sortDirection;
 }

 public void setSortDirection(String value)
 {  
   sortDirection = value;
 }
    @TestVisible
    class TimeSheetWrapper
    {
        public boolean isSelect{get;set;}
        public SVMXC_Timesheet__c objTimeSheet{get;set;}
        public TimeSheetWrapper()
        {
            isSelect = false;
            objTimeSheet = new SVMXC_Timesheet__c();
        }
    }
    
    public List<TimeSheetWrapper>  wrprList{get;set;}  //transient
    
    public GE_OG_PC_Timesheet()
    {
        userid      =  userinfo.getuserid();
        profileId = userinfo.getProfileId();
        string str = 'Select Id,Name from Profile where Id=\''+profileId+'\'';
        List<Profile> lstProfile = Database.query(str);
        for(Profile lst: lstProfile)
        {
            profileName = lst.Name;
        }   
        sortFullExp = sortExpression  + ' ' + sortDirection;
        init();
                                   
    }
    
    
    Public void init(){
        
        timesheet = new SVMXC_Timesheet__c();
        wrprList = new List<TimeSheetWrapper>();
        tsheet = new List<SVMXC_Timesheet__c>();
        
        string query = 'SELECT Id, Name, Technician__c,Total_Hours__c,Total_Billable_Hours__c, Total_Nonbillable_Hours__c,' + 
        'Start_Date__c, End_Date__c, CreatedById, CreatedBy.name, OwnerId, Owner.name, Kronos_Billable_Hours__c,(SELECT Id,GE_PC_Account__c,GE_PC_Site__c,CreatedById,CreatedBy.name,GE_PC_Job_Code__c,GE_PC_Earnings_Code__c,Activity__c,End_Date_Time__c,Is_Billable__c,Start_Date_Time__c,Technician__c,Timesheet__c,Name,GE_DS_Work_Order__c,GE_DS_Work_Order__r.id,GE_DS_Work_Order__r.Name,Work_Order_Number__c,Total_Time__c FROM Time_Entries__r),'+ 
        'Kronos_OverTime_Hours__c,GE_OG_DS_Status__c,Technician__r.Name FROM SVMXC_Timesheet__c WHERE '; 
        
        if(profileName=='GE_PC_Titanium Service Manager')
        {       
            query = query+'GE_OG_DS_Status__c NOT IN(' + '\'Approved\'' +') AND ';
        }
        query = query+'( Technician__r.SVMXC__Service_Group__r.GE_OG_DS_Service_Leader_1__c = \''+  userid + '\' or ' +
        'Technician__r.SVMXC__Service_Group__r.GE_OG_DS_Service_Leader_2__c = \''+  userid + '\' or ' +
        'Technician__r.SVMXC__Service_Group__r.GE_PC_Service_Leader_3__c = \''+  userid + '\' or ' +
        'Technician__r.SVMXC__Service_Group__r.GE_PC_Service_Leader_4__c = \''+  userid + '\' or ' +
        'Technician__r.SVMXC__Service_Group__r.GE_PC_Service_Leader_5__c = \''+  userid + '\' or ' +
        'Technician__r.SVMXC__Service_Group__r.GE_PC_Service_Leader_6__c = \''+  userid + '\' or ' +
        'Technician__r.SVMXC__Service_Group__r.GE_PC_Service_Leader_7__c = \''+  userid + '\' or ' +
        'Technician__r.SVMXC__Salesforce_User__r.id = \''+  userid + '\' or ' +
        ' GE_DS_Manager__c = \''+  userid + '\')'+ 
        ' and Start_Date__c = LAST_WEEK ' + ' order by ' +  sortFullExp; 

        
        //Added for Testing purpose
       /* if(Test.isRunningTest())
        query=query = 'SELECT Id, Name, Technician__c,Total_Hours__c,Total_Billable_Hours__c, Total_Nonbillable_Hours__c,' + 
        'Start_Date__c, End_Date__c, CreatedById,CreatedBy.name, OwnerId, Owner.name, Kronos_Billable_Hours__c,(SELECT Id,GE_PC_Account__c,GE_PC_Site__c,CreatedById,CreatedBy.name,GE_PC_Job_Code__c,GE_PC_Earnings_Code__c,Activity__c,End_Date_Time__c,Is_Billable__c,Start_Date_Time__c,Technician__c,Timesheet__c,Name,GE_DS_Work_Order__c,GE_DS_Work_Order__r.id,GE_DS_Work_Order__r.Name,Work_Order_Number__c,Total_Time__c FROM Time_Entries__r),'+ 
        'Kronos_OverTime_Hours__c,GE_OG_DS_Status__c,Technician__r.Name FROM SVMXC_Timesheet__c WHERE GE_OG_DS_Status__c NOT IN(' +        
        '\'Approved\'' +')'+
        ' and Start_Date__c = LAST_WEEK ' + ' order by ' +  sortFullExp; */
        
        system.debug('&&&& INIT() '+ query);
        tsheet = Database.query(query);
        
                                   
        for(SVMXC_Timesheet__c objTimeShet : tsheet)
        {
            TimeSheetWrapper objWrp = new TimeSheetWrapper();
            objWrp.objTimeSheet = objTimeShet;
            wrprList.add(objWrp);
            
            system.debug('wrprList values : ' + wrprList);
        }
        
    }
    

     public void Go(){
        boolean check = false ;
        tsheet = new List<SVMXC_Timesheet__c>();
        wrprList = new List<TimeSheetWrapper>();
        sortFullExp = sortExpression  + ' ' + sortDirection;
        
        system.debug('ProfileName'+profileName);
        
       // If (timesheet.Start_Date__c==null && timesheet.End_Date__c==null && timesheet.Technician__c == null)
       // {
         //  init();
       // }
        
        If((timesheet.End_Date__c < timesheet.Start_Date__c) && (timesheet.Technician__c == null || timesheet.Technician__c != null))
        {
        CheckDate1();
        }
        
        string query = 'SELECT Id, Name, Technician__c,Total_Hours__c,Total_Billable_Hours__c, Total_Nonbillable_Hours__c,' + 
        'Start_Date__c, End_Date__c, CreatedById, CreatedBy.name, OwnerId, Owner.name, Kronos_Billable_Hours__c,(SELECT id,GE_PC_Account__c,GE_PC_Site__c,CreatedById,CreatedBy.name,GE_PC_Job_Code__c,GE_PC_Earnings_Code__c,Activity__c,End_Date_Time__c,Is_Billable__c,Start_Date_Time__c,Technician__c,Timesheet__c,Name,GE_DS_Work_Order__c,Work_Order_Number__c,GE_DS_Work_Order__r.id,GE_DS_Work_Order__r.Name,Total_Time__c FROM Time_Entries__r ';  
        
        If ( sortExpression.contains('GE_PC_Account__c') || sortExpression.contains('Start_Date_Time__c') || sortExpression.contains('End_Date_Time__c') )
        {
        query = query + ' order by ' +  sortFullExp ;  
        check = true;  
        }   
        
        query = query + '), Kronos_OverTime_Hours__c,GE_OG_DS_Status__c,Technician__r.Name FROM SVMXC_Timesheet__c WHERE ';
        if(profileName=='GE_PC_Titanium Service Manager')
        {
          query = query + 'GE_OG_DS_Status__c NOT IN (' + '\'Approved\'' + ')'+' AND ';
        }

        query = query + '( Technician__r.SVMXC__Service_Group__r.GE_OG_DS_Service_Leader_1__c = \''+  userid + '\' or ' +
        'Technician__r.SVMXC__Service_Group__r.GE_OG_DS_Service_Leader_2__c = \''+  userid + '\' or ' +
        'Technician__r.SVMXC__Service_Group__r.GE_PC_Service_Leader_3__c = \''+  userid + '\' or ' +
        'Technician__r.SVMXC__Service_Group__r.GE_PC_Service_Leader_4__c = \''+  userid + '\' or ' +
        'Technician__r.SVMXC__Service_Group__r.GE_PC_Service_Leader_5__c = \''+  userid + '\' or ' +
        'Technician__r.SVMXC__Service_Group__r.GE_PC_Service_Leader_6__c = \''+  userid + '\' or ' +
        'Technician__r.SVMXC__Service_Group__r.GE_PC_Service_Leader_7__c = \''+  userid + '\' or ' +
        'Technician__r.SVMXC__Salesforce_User__r.id = \''+  userid + '\' or ' +
        
        ' GE_DS_Manager__c = ' + '\''+ userid +'\' )';
        
        If (timesheet.Start_Date__c==null && timesheet.End_Date__c==null && timesheet.Technician__c!=null)
        {
        query = query + ' and Start_Date__c = LAST_WEEK ' + ' and Technician__c = \'' + timesheet.Technician__c +  '\'';
        }
        else If (timesheet.Start_Date__c!=null && timesheet.End_Date__c!=null && timesheet.Technician__c==null)
        {
        query = query +' and Start_Date__c >= '+  String.ValueOf(timesheet.Start_Date__c).removeStart('00') +' And ' + 'End_Date__c <= ' +  String.ValueOf(timesheet.End_Date__c).removeStart('00');   
        }
         else If (timesheet.Start_Date__c!=null && timesheet.End_Date__c!=null && timesheet.Technician__c!=null)
        {
        query = query +' and Start_Date__c >= '+  String.ValueOf(timesheet.Start_Date__c).removeStart('00') +' And ' + 'End_Date__c <= ' +  String.ValueOf(timesheet.End_Date__c).removeStart('00') + ' and Technician__c = \'' + timesheet.Technician__c +  '\'';   
        }
        else
        {
        query = query + ' and Start_Date__c = LAST_WEEK ';
        }
        
        If (  sortExpression.contains('Start_Date__c') || sortExpression.contains('End_Date__c') )
        {
        query = query + ' order by ' +  sortFullExp ;    
        }
        
          
        system.debug('&&&& GO() '+ query);
        tsheet = Database.query(query);
        
             
        for(SVMXC_Timesheet__c objTimeShet : tsheet)
        {
            TimeSheetWrapper objWrp = new TimeSheetWrapper();
            //Added because objWrp is a Private variable which is not accessible in test class
            If(test.isRunningTest()){objWrp.isSelect=true;}
            objWrp.objTimeSheet = objTimeShet;
            wrprList.add(objWrp);
        }
    
    //}
    
    }
    
    public PageReference deleteRecords(){
        
        SVMXC_Time_Entry__c timeEntry  = [Select id from SVMXC_Time_Entry__c where id =:TimeEntryId];
        delete timeEntry;
        Go();
        return Null;
        
    }

    public PageReference saveit()
    {
        List<SVMXC_Timesheet__c> tsheetToSave = new List<SVMXC_Timesheet__c>();
        List<TimeSheetWrapper> temp = new List<TimeSheetWrapper>();
        
        temp = wrprList;
        system.debug('Temp Values : ' + temp);
        wrprList = new List<TimeSheetWrapper>();
       // PageReference pr = New PageReference('/apex/GE_OG_PC_TimeSheetTreeView?id=005A0000005ZEPB');
       Integer count = 0; 
         for(TimeSheetWrapper wrprObj : temp)
         {
            if(wrprObj.isSelect == true)
            {
                count = count+1;
                ApexPages.getMessages().clear();
                wrprObj.objTimeSheet.GE_OG_DS_Status__c = 'Approved';
                tsheetToSave.Add(wrprObj.objTimeSheet);   
               // pr.setRedirect(true); 
               // return pr;
            }
            else{
                wrprList.add(wrprObj);        
            }
        }
        if(count==0){
           CheckSelection();
           }
        else{
          CheckSuccess();
        }
        if(tsheetToSave.size() > 0)
            update tsheetToSave;
           
         return null;
        
        
    }
    
    public Void CheckSelection(){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Please select TimeSheet to approve'));
        } 
        
       public Void CheckSuccess(){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Confirm,'TimeSheet Approved'));
        }     
        
          public Void Checkdate(){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Please Select Technician to review the time Sheet for the Current Week or Please select Start/End Dates and Technician for the Previous Weeks'));
        } 
        
           public Void CheckDate1(){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Start Date should be greater then End Date'));
        } 
    
}