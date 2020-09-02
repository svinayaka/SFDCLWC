@isTest(SeeAllData=true)
public class GE_OG_PC_Timesheet_Test {
    
    public String userid{get;set;}
    public String sortFullExp{get;set;}
    public SVMXC_Timesheet__c timesheet;
    public List<SVMXC_Timesheet__c> tSheetList{get;set;}
    Public static Id TimeEntryId {get;set;}
    Public String sortDirection = 'ASC';
    private String sortExp = 'Technician__c';
    public date startdate {get;set;}
    public date enddate {get;set;}
    public static GE_OG_PC_Timesheet t1 = new GE_OG_PC_Timesheet();
    public String profileName = 'GE_PC_Titanium Service Manager';
    
    
    public static void insertRecords()
    {
        //ServiceTeam Insert
        SVMXC__Service_Group__c team = new SVMXC__Service_Group__c();
        team.name='Test Team';
       
        team.GE_OG_DS_Service_Leader_1__c = UserInfo.getUserId();
        team.GE_OG_DS_Service_Leader_2__c= UserInfo.getUserId();
        team.GE_PC_Service_Leader_3__c= UserInfo.getUserId();
        team.GE_PC_Service_Leader_4__c= UserInfo.getUserId();
        team.GE_PC_Service_Leader_5__c= UserInfo.getUserId();
        team.GE_PC_Service_Leader_6__c = UserInfo.getUserId();
        team.GE_PC_Service_Leader_7__c= UserInfo.getUserId();
        
        team.GE_OG_DS_Billing_Admin_Email__c='test@test.com';
        team.GE_HQ_P_L_Level__c='O&G > D&S';
        team.GE_HQ_Resource_Director__c=UserInfo.getUserId();
        team.GE_OG_DS_Service_Leader_1__c = UserInfo.getUserId();
        insert team;
        
        //Technician Insert     
        SVMXC__Service_Group_Members__c tech = new SVMXC__Service_Group_Members__c(
        SVMXC__Service_Group__c = team.Id,
        Name = 'SVMX Tech',
        SVMXC__Active__c = true,
        SVMXC__Enable_Scheduling__c = true,
        SVMXC__Email__c = 'test.abc@xyz.com',
        GE_SM_HQ_SSO_ID__c = '123456737',
        SVMCX_Status__c = 'Active GE',
        GE_SM_HQ_Regional_Manager__c = 'SVMX',
        GE_SM_HQ_Manager_Email__c = 'test.abc@xyz.com',
        SVMXC_Function__c = 'Services',
        GE_SM_HQ_Controls_EmpType__c = 'Field Engineer', 
        SVMXC__Salesforce_User__c = UserInfo.getUserId()
        );
        insert tech;
        
        //Timesheet Insert 
        
        
         SVMXC_Timesheet__c timesheet = new SVMXC_Timesheet__c();
         timesheet.End_Date__c = Date.today();      
         timesheet.GE_OG_DS_Status__c = 'New';
         timesheet.Start_Date__c = system.today() - 7 ;
         timesheet.Technician__c = tech.id;
         timesheet.GE_DS_Manager__c = UserInfo.getUserId();
         insert timesheet;
        
        
          
        SVMXC_Time_Entry__c te=new SVMXC_Time_Entry__c(
        Timesheet__c=timesheet.id, 
        Technician__c=tech.id,
        Start_Date_Time__c=System.now()-1,
        End_Date_Time__c=System.now(),
        Activity__c='Troubleshooting'
        );
        insert te;
        TimeEntryId =  te.id;
        

        System.debug('aaaaaaaaa '+timesheet.Start_Date__c +' leader is '+timesheet.Technician__r.SVMXC__Service_Group__r.GE_OG_DS_Service_Leader_1__c +'timesheet.GE_OG_DS_Status__c '+timesheet.GE_OG_DS_Status__c  );
    }
    
     public static void insertRecordss(GE_OG_PC_Timesheet tsheet)
    {
        //ServiceTeam Insert
        SVMXC__Service_Group__c team = new SVMXC__Service_Group__c();
        team.name='Test Team';
       
        team.GE_OG_DS_Service_Leader_1__c = UserInfo.getUserId();
        team.GE_OG_DS_Service_Leader_2__c= UserInfo.getUserId();
        team.GE_PC_Service_Leader_3__c= UserInfo.getUserId();
        team.GE_PC_Service_Leader_4__c= UserInfo.getUserId();
        team.GE_PC_Service_Leader_5__c= UserInfo.getUserId();
        team.GE_PC_Service_Leader_6__c = UserInfo.getUserId();
        team.GE_PC_Service_Leader_7__c= UserInfo.getUserId();
        
        team.GE_OG_DS_Billing_Admin_Email__c='test@test.com';
        team.GE_HQ_P_L_Level__c='O&G > D&S';
        team.GE_HQ_Resource_Director__c=UserInfo.getUserId();
        team.GE_OG_DS_Service_Leader_1__c = UserInfo.getUserId();
        insert team;
        
        //Technician Insert     
        SVMXC__Service_Group_Members__c tech = new SVMXC__Service_Group_Members__c(
        SVMXC__Service_Group__c = team.Id,
        Name = 'SVMX Tech',
        SVMXC__Active__c = true,
        SVMXC__Enable_Scheduling__c = true,
        SVMXC__Email__c = 'test.abc@xyz.com',
        GE_SM_HQ_SSO_ID__c = '123456747',
        SVMCX_Status__c = 'Active GE',
        GE_SM_HQ_Regional_Manager__c = 'SVMX',
        GE_SM_HQ_Manager_Email__c = 'test.abc@xyz.com',
        SVMXC_Function__c = 'Services',
        GE_SM_HQ_Controls_EmpType__c = 'Field Engineer', 
        SVMXC__Salesforce_User__c = UserInfo.getUserId()
        );
        insert tech;
        
        //Timesheet Insert 
        
        
         SVMXC_Timesheet__c timesheet = new SVMXC_Timesheet__c();
         
         //timesheet.End_Date__c = null;      
          timesheet.GE_OG_DS_Status__c = 'New';
         //timesheet.Start_Date__c=null;
         timesheet.Technician__c = tech.id;
         insert timesheet;
         tsheet.timesheet = timesheet;
        
        
        GE_OG_PC_Timesheet.TimeSheetWrapper objWrp = new GE_OG_PC_Timesheet.TimeSheetWrapper();
        objWrp.isSelect = true;
        objWrp.objTimeSheet = timesheet;
        tsheet.wrprList.add(objWrp);
        
          
        SVMXC_Time_Entry__c te=new SVMXC_Time_Entry__c(
        Timesheet__c=timesheet.id, 
        Technician__c=tech.id,
        Start_Date_Time__c=System.now()-1,
        End_Date_Time__c=System.now(),
        Activity__c='Troubleshooting'
        );
        insert te;
        TimeEntryId =  te.id;
        

        System.debug('aaaaaaaaa '+timesheet.Start_Date__c +' leader is '+timesheet.Technician__r.SVMXC__Service_Group__r.GE_OG_DS_Service_Leader_1__c +'timesheet.GE_OG_DS_Status__c '+timesheet.GE_OG_DS_Status__c  );
    }
    
    @isTest
    public static void testInit()
    {
        GE_OG_PC_Timesheet objTimeSheet = new GE_OG_PC_Timesheet();
        
        insertRecords();
       
         List<SVMXC_Timesheet__c> tSheetList = new List<SVMXC_Timesheet__c>();
        
    }
    
    @isTest
    public static void testGo()
    {
        Test.startTest();
        GE_OG_PC_Timesheet tsheet =  new GE_OG_PC_Timesheet();
        insertRecords();
       // insertRecordss();
        tsheet.Go();                               
        Test.stopTest();        
    }
    
    @isTest
    public static void testGo1()
    {
        Test.startTest();
        GE_OG_PC_Timesheet tsheet =  new GE_OG_PC_Timesheet();
        //insertRecords();
        insertRecordss(tsheet);
        tsheet.Go();                               
        Test.stopTest();        
    }

    @isTest
    public static void testDeleteRecords()
    {
        Test.startTest();
        GE_OG_PC_Timesheet tsheet =  new GE_OG_PC_Timesheet();                       
        insertRecords();
        tsheet.startdate =  Date.today();
        tsheet.enddate =  Date.today();
        tsheet.sortExpression = 'Technician__c';
        tsheet.setSortDirection('abc');
         tsheet.setSortDirection('');
        String s = tsheet.getSortDirection();
        tsheet.TimeEntryId = TimeEntryId;
        tsheet.deleteRecords();
        tsheet.saveit(); 
        
        
        Test.stopTest();
        
    }    

     @isTest
    public static void testsaveit()
    {
        Test.startTest();
        GE_OG_PC_Timesheet tsheet =  new GE_OG_PC_Timesheet();        
        tsheet.saveit();        
        insertRecords();
        tsheet.checkSuccess();
        Test.stopTest();
        
    }
      @isTest
       public static Void testCheckSuccess(){
            t1.CheckSuccess();
        }     
      @isTest
       public static Void testCheckdate(){
            t1.Checkdate();
        } 
      @isTest
       public static Void testCheckDate1(){
            t1.CheckDate1();
       } 
    @isTest
    public static void testWraper(){       
        GE_OG_PC_Timesheet tsw = new GE_OG_PC_Timesheet(); 
    }
    
    @isTest
    public static void testTimeSheetWrapper()
    {
   //timesheet= new SVMXC_Timesheet__c ();
        GE_OG_PC_Timesheet.TimeSheetWrapper wrpr = new GE_OG_PC_Timesheet.TimeSheetWrapper();
        wrpr.isSelect = true;
     //wrpr.GE_OG_DS_Status__c = 'Approved';
        
    }
   @isTest
    public static void testDeleteRecordss()
    {
        Test.startTest();
        GE_OG_PC_Timesheet tsheet =  new GE_OG_PC_Timesheet();                       
        insertRecords();
        tsheet.startdate =  Date.today();
        tsheet.enddate =  Date.today();
        tsheet.sortExpression = '';
        tsheet.setSortDirection('abc');
         tsheet.setSortDirection('');
        String s = tsheet.getSortDirection();
        tsheet.TimeEntryId = TimeEntryId;
        tsheet.deleteRecords();
        tsheet.saveit(); 
        
        
        Test.stopTest();
        
    }    
        
}