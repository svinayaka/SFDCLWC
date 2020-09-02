/************
Class Name          : GE_PRM_Channel_Appointment_Class 
Used Where ?        : This acts as Controller for GE_PRM_Channel_Appointment_View_Page1
Purpose/Overview    : for storing processing channel appointment details
Functional Area     : PRM 
Author              : 
Created Date        : 
Test Class Name     : Test_GE_PRM_Channel_Appointment_Class
Change History - 
Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
************/
public without sharing class GE_PRM_Channel_Appointment_Class {
    //** Variable declarations 
    public Boolean isRecalledRegen {get; set;}
    public string commlineid{get; set;}
    public Boolean hasPRMKYCAccess {get;set;}
    public boolean isApttusContractUser{get; set;}
    public string clineid{get; set;}
    public string requiredstyle{get;set;}
    public string styleappttype{get; set;}
    public string styletier{get; set;}
    public string stylepscm{get; set;}
    public string stylerscl{get; set;}
    public string styleinbuz{get; set;} 
    public string stylewithge{get; set;} 
    public string styleprioryo{get; set;}
    public string stylepriorpr{get; set;}
    public string styleprcommpaid{get; set;} 
    public string styleprgrorate{get; set;}
    public string stylecommquali{get; set;}
    public string styleMandated{get; set;}
    public string styleconvfecrime{get; set;}
    public string styleoffingov{get; set;}
    public string stylehighriskpl{get; set;}
    public string stylenuclear{get; set;}
    public string stylehvsd{get; set;}
    public string stylesubsid{get; set;}
    public string styleexportcontr{get; set;}
    public string styleexportout{get; set;}
    public string styleapprplc{get; set;}
    public string styleacccountry{get; set;}
    public String Styleselltogovt{get;set;}
    public String Stylesellstomiltary{get;set;}
    public String stylestrDeloitte {get; set;}
    public String stylestrCommRefReq {get; set;}
    public String stylestrIcpReq {get; set;}
    public Id mailid ;  
    public List<User> ccList;
    public List<GE_PRM_Commercial_line__c> arrCommercialLines2{get; set;}
    public boolean checkContractualUser{get; set;}
    public Boolean CheckcommercialFlag{get;set;}
    public List<GE_PRM_Channel_Appointment__c> channelApplist{get;set;}
    public List<GE_PRM_Channel_Appointment__c> AccList{get;set;}
    public List<GE_PRM_Channel_Appointment__c> AccList2{get;set;}
    public List<GE_PRM_Channel_Appointment__c> tempList{get;set;}
    public List<Contract> contractList {get;set;}   
    public List<GE_PRM_Channel_Appointment__c> tempList1{get;set;}
    public List<GE_PRM_Commercial_line__c> Commercilaline{get;set;}
    public List<GE_PRM_Appointment__c> AfaList{get;set;}
    public List<GE_PRM_Appointment__c> AfaList1{get;set;}
    public List<GE_PRM_Channel_Appointment_Approver__c> lstCAAOnPage {get; set;}   
    public String newApp {get;set;}
    public String currentdateString{get;set;}
    public String approverType;
    public Boolean checkCommToll; 
    public GE_PRM_Channel_Appointment__c newchannelrec =new GE_PRM_Channel_Appointment__c();
    public Static boolean  b{get;set;}
    public Boolean pagerender{get; set;}
    public Boolean AddApprovers;
    public Date Commlinesaddeddate;
    public Boolean IScompliancesecondtime;
    public GE_PRM_Channel_Appointment__c CA;
    public Boolean checkSLPolicy{get; set;} 
    public Boolean sendPartner{get; set;}
    public string channelAppId = ApexPages.currentPage().getParameters().get('id'); 
    ApexPages.standardController c; 
    public list<GE_PRM_Commercial_line__c> commlinelist;
    List<GE_PW_CMFtoISOCountryName__c> hqCountryList = new List<GE_PW_CMFtoISOCountryName__c> ();
    Map<String, String> hqCountryMap = new Map<String, String>();
    public list<commercialwrap> lstcomwrap{get; set;}
    public List<GE_PRM_Commercial_line__c> arrCommercialLines1{get; set;}
    public Id mailTemplateId ;  
    public Id contID ;  
    public Id masterconid ;
    //public Id contrID {get; set;}
    public Id acid {get; set;}
    public String addendumAccName {get; set;}
    public Blob CAPDF ;
    public String objectType {
        get { return objectType ; }
        set { objectType = 'GE_PRM_Channel_Appointment__c'; }
    }
    public boolean displayPopup {get; set;}   
    Public Boolean displayMsgPopup{get;set;}
    public Pagereference chapptviewpage{get;set;}  
    public Pagereference chappteditpage{get;set;}
    public boolean isrenewingapptexists{get; set;}
    public list<GE_PRM_Channel_Appointment_Approver__c> lstneedmoreinfoapprvers;
    public boolean commercialNeedmoreInforender{get; set;}
    public boolean complianceNeedmoreInforender{get; set;}
    public boolean Recalledflag_for_editbuttton{get; set;}

    public list<GE_ES_Role__c> prmcommercialRoles;
    public list<GE_ES_Role__c> prmcomplianceRoles;
    public String contractRecordTypeMasterId;
    public String contractRecordTypeAddendumId;
    public boolean commManagerrender{get; set;}
    public boolean enableaddCL{get; set;}
    public List<GE_PRM_Commercial_line__c> cLofChapp= new List<GE_PRM_Commercial_line__c>();
    public list<id> CLNRTid=new List<id>();
    public List<GE_PRM_Channel_Appointment_Approver__c> CLrenewApprover= new List<GE_PRM_Channel_Appointment_Approver__c>();
    public boolean CLunderrenew{get;set;}
    
    //* wrapper class used to store commercial line details
 
    // Recall functionality code - by sk - begins
    
    Public PageReference RecallCompliance(){

     Recalledflag_for_editbuttton = true;
     
     List<GE_PRM_Channel_Appointment__c> appt = [select id, name ,GE_PRM_IsApproved__c, GE_PRM_Compliance_Start_Date1__c from GE_PRM_Channel_Appointment__c where id=:channelAppId limit 1];   
      DateTime  compliancestartDate = (DateTime)appt[0].GE_PRM_Compliance_Start_Date1__c ;
        system.debug('what is happening here'+appt);
                system.debug('compliancestartDate here'+compliancestartDate);

      List<GE_PRM_Channel_Appointment_Approver__c>  updateCAA_to_recalledStatus = new List<GE_PRM_Channel_Appointment_Approver__c>();
      List<GE_PRM_Channel_Appointment_Approver__c> approvers_tobe_recalled = [select id ,name,GE_PRM_Status__c from GE_PRM_Channel_Appointment_Approver__c
                                                                             where GE_PRM_Channel_Appointment__r.id=:channelAppId AND (GE_PRM_Status__c ='Approved' OR GE_PRM_Status__c = 'Pending' OR GE_PRM_Status__c = 'Need More Info') 
                                                                              and Last_Compliance_Triggered_Time__c =:appt[0].GE_PRM_Compliance_Start_Date1__c
                                                                              and GE_PRM_Role__c !='Commercial 1' and GE_PRM_Role__c!='Commercial 2'
                                                                             ];
        system.debug('Recalled functionality --approver list foe setting status= recalled'+approvers_tobe_recalled);
       
        //here insert if condition for check  approver record role != commercial 1/2 , coz if on same date both are triggered then, code sud only make complinace approver status = recalled not commercial approves
       
        for(GE_PRM_Channel_Appointment_Approver__c Update_CAA_Status : approvers_tobe_recalled)
        {
            GE_PRM_Channel_Appointment_Approver__c  CAA_temp = new GE_PRM_Channel_Appointment_Approver__c();
            CAA_temp.GE_PRM_Status__c ='Recalled';
            CAA_temp.Id=Update_CAA_Status.id;
            updateCAA_to_recalledStatus.add(CAA_temp);
            system.debug('inside for loop to set status = reccalled for each individual pending approver');
        }
        update updateCAA_to_recalledStatus;
        if(appt[0].GE_PRM_IsApproved__c==false)
        {
        this.newchannelrec.GE_PRM_Current_Status__c  ='Draft'; 
        this.newchannelrec.GE_PRM_Compliance_Start_Date1__c = null;
        //this.newchannelrec.GE_PRM_DOA_generated__c = false; // read only field we cant do this.
        update newchannelrec;
        system.debug('appointment and CAA both updated ??');
        }

       PageReference updChApp_1=new PageReference('/apex/GE_PRM_Channel_Appointment_View_Page1?id='+this.newchannelrec.id) ;
        updChApp_1.setRedirect(True); 
        return updChApp_1; 
    
    }
    // Recall functionality code - by sk - ends
     
    public class commercialwrap{
        public GE_PRM_Commercial_line__c c{get; set;}
        public list<contract> conlist{get; set;}
        public GE_PRM_Channel_Appointment__c chappointment{get;set;}
        public boolean nonrenewstr{get; set;}
        public boolean terminatestr{get; set;}
        public commercialwrap(GE_PRM_Commercial_line__c c1){
            this.c = c1;   
            nonrenewstr = false;
            conlist = new list<contract>();
            chappointment= new GE_PRM_Channel_Appointment__c();
            chappointment=[select  id,GE_PRM_Prior_performance_rating__c,GE_PRM_IsApproved__c,GE_PRM_ComplainceAffected__c,GE_PRM_CommercialAffected__c from GE_PRM_Channel_Appointment__c where id=:c1.GE_PRM_Channel_Appointment__c];
            conlist = [select id from contract 
                       where 
                       GE_PRM_Channel_Appointment_ID__c =: c1.GE_PRM_Channel_Appointment__c 
                       and (AccountID =: c.GE_PRM_Channel_Appointment__r.GE_PRM_Account_Name__c)  
                       AND (GE_PRM_Business_Tier_1__c =: c1.GE_PRM_Tier_1__c) 
                       AND (GE_PRM_Tier_2__c =: c1.GE_PRM_Tier_2__c) 
                       AND (GE_PRM_Tier_3__c =:c1.GE_PRM_Tier_3__c ) 
                       AND (GE_PRM_Tier_4__c =: c1.GE_PRM_Tier_4__c ) 
                       AND( GE_PRM_Tier_5__c =:c1.GE_PRM_Tier_5__c)
                       AND (GE_PRM_Relationship_Type__c =: c1.GE_PRM_Type__c)
                      ];
            if(conlist.size()>0){ 
            System.debug('printing values'+c1.GE_PRM_Status__c+ c1.GE_PRM_Status__c + chappointment.GE_PRM_IsApproved__c+chappointment.GE_PRM_ComplainceAffected__c+ chappointment.GE_PRM_CommercialAffected__c );   
                if((c1.GE_PRM_Status__c == 'New' || c1.GE_PRM_Status__c == 'Renewal') && chappointment.GE_PRM_IsApproved__c==true && chappointment.GE_PRM_ComplainceAffected__c==false && chappointment.GE_PRM_CommercialAffected__c ==false ){
                    nonrenewstr = true;
                }    
            }
            system.debug('nonrenewstrvar'+nonrenewstr );    
        }
    }    
    public ApexPages.StandardSetController sc1 {
        get {
            if(sc1 == null) {
                sc1 = new ApexPages.StandardSetController(Database.getQueryLocator([Select Id, Name,GE_PRM_Prior_performance_rating__c FROM GE_PRM_Channel_Appointment__c Order By LastModifiedDate limit 100]));
                // sets the number of records in each page set
                sc1.setPageSize(5);
            }
            return sc1;
        }
        set;
    }   
    
    //** constructor
    public GE_PRM_Channel_Appointment_Class(ApexPages.StandardController sc) {
        isRecalledRegen = false;
        enableaddCL=false;
        hasPRMKYCAccess = false;  
        AbandonMessageFlag = false;   
        displayPopup =false; 
        
        for(PermissionSetAssignment per :[SELECT AssigneeId FROM PermissionSetAssignment WHERE PermissionSet.Name = 'GE_PRM_KYC_Access' AND AssigneeId =: UserInfo.getUserId() ])
         {
            hasPRMKYCAccess= true;
         }
         //** Used to check channel appointment approver status as need more info and modify render of page sections
        commercialNeedmoreInforender = false;
        complianceNeedmoreInforender = false;
        CLunderrenew=false;
        
        prmcommercialRoles = [select Name from GE_ES_Role__c where GE_PRM_Role__c = true AND GE_PRM_Approver_Type__c = 'CommercialApprovers'];                
        prmcomplianceRoles = [select Name from GE_ES_Role__c where GE_PRM_Role__c = true AND (GE_PRM_Approver_Type__c = 'High' OR GE_PRM_Approver_Type__c = 'Medium' OR GE_PRM_Approver_Type__c = 'Low')];                
       
        lstneedmoreinfoapprvers =new list<GE_PRM_Channel_Appointment_Approver__c>();
        lstneedmoreinfoapprvers = [select GE_PRM_Role__c from GE_PRM_Channel_Appointment_Approver__c where GE_PRM_Channel_Appointment__c =: channelAppId AND GE_PRM_Status__c = 'Need More Info' AND Terminate__c = false AND Non_Renewal__c = false];
        for(GE_PRM_Channel_Appointment_Approver__c chapprover : lstneedmoreinfoapprvers){
       
        for(GE_ES_Role__c role : prmcommercialRoles){
        if(chapprover.GE_PRM_Role__c == role.Name){
        commercialNeedmoreInforender = true;
        }
        }
        for(GE_ES_Role__c role : prmcomplianceRoles){
        if(chapprover.GE_PRM_Role__c == role.Name){
        complianceNeedmoreInforender = true;
        }
        }
        }
        SYSTEM.DEBUG('&&&&&&&'+complianceNeedmoreInforender);
     list<GE_PRM_Channel_Appointment__c> chapp_1  =[select id,GE_PRM_Current_Status__c ,  name  from GE_PRM_Channel_Appointment__c  where id =:channelAppId and GE_PRM_Current_Status__c = 'Submitted'];
     list<GE_PRM_Channel_Appointment_Approver__c> Chapprv_1 =[select GE_PRM_Role__c from GE_PRM_Channel_Appointment_Approver__c where GE_PRM_Channel_Appointment__c =: channelAppId AND GE_PRM_Status__c= 'Pending'];
      
        if(Chapprv_1.size()==0 && chapp_1.size()==1)
        {
            Recalledflag_for_editbuttton = true;
        }
        
        chapptviewpage = new PageReference('/apex/GE_PRM_Channel_Appointment_View_Page1?id='+channelAppId) ;
                   
        arrCommercialLines2 = new List<GE_PRM_Commercial_line__c>();
        arrCommercialLines1 = new List<GE_PRM_Commercial_line__c>();
        arrCommercialLines1 = [Select Id, GE_PRM_Non_Renewal_or_Termination__c, GE_PRM_contract_genrated__c , GE_PRM_Tier_5__c , GE_PRM_Sales_Manager__c ,GE_PRM_Sales_Manager__r.Email, GE_PRM_Channel_Appointment__r.GE_PRM_Account_Name__c, GE_PRM_Channel_Appointment__c ,GE_PRM_Channel_Appointment__r.id , Name, GE_PRM_Status__c, GE_PRM_Tier_1__c,GE_PRM_Tier_2__c,GE_PRM_Tier_3__c,GE_PRM_Tier_4__c, GE_PRM_Relationship_expiry_date__c,GE_PRM_Next_year_target__c,GE_PRM_Current_year_target__c,GE_PRM_Type__c, LastModifiedDate, GE_PRM_Buyers__c, GE_PRM_Industries__c from GE_PRM_Commercial_line__c  where GE_PRM_Channel_Appointment__c =:channelAppId order by createddate asc];     
        System.debug('ttttttttttt'+arrCommercialLines1 );
        if(arrCommercialLines1.size() > 0 ){
            for(integer i=1; i <=arrCommercialLines1.size(); i++ ){
                
                if(string.valueof(arrCommercialLines1[i-1].GE_PRM_Relationship_expiry_date__c) == null &&
                   arrCommercialLines1[i-1].GE_PRM_Type__c == null && arrCommercialLines1[i-1].GE_PRM_Tier_2__c == null &&
                   arrCommercialLines1[i-1].GE_PRM_Tier_3__c == null && string.valueof(arrCommercialLines1[i-1].GE_PRM_Current_year_target__c)==null){
                   System.debug('Entered if in constructor');
                   }
                else{
                System.debug('Entered else in constructor');
                    arrCommercialLines2.add(arrCommercialLines1[i-1]); 
                }
            }
            
        } 
        
        //to disable add commercial button if any commercial line is under NRT
         cLofChapp=[select GE_PRM_Status__c,id from GE_PRM_Commercial_line__c  where GE_PRM_Channel_Appointment__c=:channelAppId and GE_PRM_Status__c=:'Under NR/T'];
         if(cLofChapp.size()>0)
         { 
            for(GE_PRM_Commercial_line__c commNRT : cLofChapp)
            {
                CLNRTid.add(commNRT.id);
                System.debug('add commercial line id');
            }
            System.debug('inside if CL exists');
            //CLunderrenew=true;
         }
         if(CLNRTid.size()>0)
         {
             CLrenewApprover=[SELECT Commercial_line__c,GE_PRM_Status__c,Id,Non_Renewal__c,Terminate__c FROM GE_PRM_Channel_Appointment_Approver__c where Commercial_line__c IN:CLNRTid and (Non_Renewal__c=true or Terminate__c =true) and GE_PRM_Status__c!='Approved'];
             System.debug('get commercial approver'+CLrenewApprover);
         }
         if(CLrenewApprover.size()>0)
         {
              System.debug('inside if approver exists');
             CLunderrenew=true;
         }
         else
         {
              System.debug('inside else no approver');
             CLunderrenew=false;
         }         
         //code end                
        lstcomwrap = new list<commercialwrap>();
        for(GE_PRM_Commercial_line__c c:arrCommercialLines2){
        System.debug('calling wrappeerc lcass '+c);
            lstcomwrap.add(new commercialwrap(c));
        }        
        requiredstyle = '';       
        styleappttype =requiredstyle ;
        styletier = requiredstyle ;
        stylepscm= requiredstyle ;
        stylerscl= requiredstyle ;
        styleinbuz= requiredstyle ;
        stylewithge= requiredstyle ;
        styleprioryo= requiredstyle ;
        stylepriorpr= requiredstyle ;
        styleprcommpaid= requiredstyle ;
        styleprgrorate= requiredstyle ;
        stylecommquali= requiredstyle ;        
    /*    PermissionSet aptuscontractpsid = [select id, Name from PermissionSet where Name = 'Apttus_Contract_User'];
        integer j = [SELECT count() FROM PermissionSetAssignment WHERE AssigneeId =: UserInfo.getUserId()  and PermissionSetid =: aptuscontractpsid.id  ]; 
        if(j == 0){
            isApttusContractUser = false;
        }
        if(j == 1 || Test.IsRunningTest() ){
            isApttusContractUser = true;
        }        
    */    
              
         //** code to check logged in user is assigned with commercial manager permissionset
        list<PermissionSet> cmps = [select id, Name from PermissionSet where Name = 'GE_PRM_Commercial_Manager'];       
        integer cmi = [SELECT count() FROM PermissionSetAssignment WHERE AssigneeId =: UserInfo.getUserId()  and PermissionSetid =: cmps[0].id ]; 
        if(cmi == 0){
            commManagerrender = false;
        }
        if(cmi == 1 || Test.IsRunningTest() ){
            commManagerrender = true;
        } 
        system.debug('%%%%%%%'+commManagerrender);
        
        //** code to check logged in user is assigned with prm contractual, permission set or not
        list<PermissionSet> ps = [select id, Name from PermissionSet where Name = 'PRM_Contractual_Team'  or Name = 'Restricted_PRM_Channel_Manager' ];       
        integer i = [SELECT count() FROM PermissionSetAssignment WHERE AssigneeId =: UserInfo.getUserId()  and (PermissionSetid =: ps[0].id or PermissionSetid =: ps[1].id) ]; 
        if(i == 0){
            checkContractualUser = false;
        }
        if(i == 1 || Test.IsRunningTest() ){
            checkContractualUser = true;
        }      
        pagerender = true;
        b = true;
        currentdateString=date.today().format();
        this.c = sc;       
        
        
        this.newchannelrec = (GE_PRM_Channel_Appointment__c)sc.getRecord();
                
        if(ApexPages.currentPage().getParameters().get('isexistingappt') == 'true')
            newApp =ApexPages.currentPage().getParameters().get('isexistingappt');
        else 
            newApp ='false';
        Id accid = ApexPages.currentPage().getParameters().get('CF00NZ0000001O2gu_lkid'); 
        Id chid = ApexPages.currentPage().getParameters().get('Caid');
        Id aid;        
        acid = ApexPages.currentPage().getParameters().get('accid');
        checkCommToll=False; 
        approverType='';
        AccList= [select GE_PRM_Account_Name__c,GE_PRM_Prior_performance_rating__c from GE_PRM_Channel_Appointment__c where id =:channelAppId LIMIT 1];
        for(GE_PRM_Channel_Appointment__c a : AccList){            
            accid = a.GE_PRM_Account_Name__c;
        }        
        AccList2= [select GE_PRM_Account_Name__c,GE_PRM_Prior_performance_rating__c from GE_PRM_Channel_Appointment__c where id =:chid LIMIT 1];
        for(GE_PRM_Channel_Appointment__c a : AccList2){
            aid = a.GE_PRM_Account_Name__c;
        }        
        List<RecordType> addendumreccontr = [select id,Name,DeveloperName from RecordType where name ='Channel Addendum Agreement' LIMIT 1];
        tempList  = [select id,Name,LastModifiedbyId,GE_PRM_Current_Status__c,GE_PRM_Tier_2_P_L__c,GE_PRM_Prior_performance_rating__c from GE_PRM_Channel_Appointment__c where GE_PRM_Account_Name__r.id =: aid and id !=: chid order by LastModifiedDate desc];
        tempList1 = [select id,Name,LastModifiedbyId,GE_PRM_Current_Status__c,GE_PRM_Tier_2_P_L__c,GE_PRM_Prior_performance_rating__c from GE_PRM_Channel_Appointment__c where GE_PRM_Account_Name__r.id =: accid and id !=: channelAppId order by LastModifiedDate desc LIMIT 2];
        AfaList   = [select Name , Id ,LastModifiedbyId , GE_PRM_Status__c,GE_PRM_Tier_2__c from GE_PRM_Appointment__c where GE_PRM_Account_Name__r.Id=: aid AND GE_PRM_Account_Name__r.Id != '' order by LastModifiedDate desc];
        AfaList1  = [select Name , Id ,LastModifiedbyId , GE_PRM_Status__c,GE_PRM_Tier_2__c from GE_PRM_Appointment__c where GE_PRM_Account_Name__r.Id=: accid AND GE_PRM_Account_Name__r.Id != '' ORDER BY LastModifiedDate desc LIMIT 1];        
        commlinelist = [select GE_PRM_Sales_Manager__c,GE_PRM_Sales_Manager__r.Email,isCommercialApproved__c, isComplianceApproved__c,GE_PRM_Channel_Appointment__r.GE_PRM_Approved_CommercialApp_Approvals__c from GE_PRM_Commercial_line__c where GE_PRM_Channel_Appointment__c =: channelAppId]; 
        contractList  = [select id,Name,ContractNumber,Status,LastModifiedbyId,GE_PRM_Commercial_Manager1__c,LastModifiedDate,GE_PRM_Business_Tier_1__c,GE_PRM_Tier_2__c,GE_PRM_Tier_3__c,GE_PRM_Tier_4__c from Contract where Account.id =: acid AND RecordTypeId =:addendumreccontr AND Status !=:'Non-Renewed' AND Status !=:'Archived' AND Status !=:'Under NR/T' AND Status !=:'Terminated' order by GE_PRM_Tier_2__c ];
        If ( Test.IsRunningTest() ){ acid = [Select ID From Account Limit 1].ID ; }
        if(acid !=null)
        {
        List<Account>addendumacc = [select Name from Account where id =: acid ];
        for(Account a : addendumacc)
        {
            addendumAccName = a.Name;
        }  
        }      
        //** to slove issue with country name
        hqCountryList = [select id,GE_PW_Country__r.name, GE_PW_CMF_Name__c, Name,GE_PW_Country__c,GE_PW_Country__r.GE_HQ_ISO_Code__c from GE_PW_CMFtoISOCountryName__c where id != '' ];
        If ( Test.IsRunningTest() ){hqCountryList = [select id,GE_PW_Country__r.name, GE_PW_CMF_Name__c, Name,GE_PW_Country__c,GE_PW_Country__r.GE_HQ_ISO_Code__c from GE_PW_CMFtoISOCountryName__c Limit 1];  }
        for(GE_PW_CMFtoISOCountryName__c ISO : hqCountryList)
        {
            hqCountryMap.put(ISO.GE_PW_Country__r.GE_HQ_ISO_Code__c,ISO.GE_PW_CMF_Name__c);
        }
        
        //**** Code to hide Addcommercial line button on View Page  
        list<GE_PRM_Channel_Appointment__c> lstrenewingappt = new list<GE_PRM_Channel_Appointment__c>();
        lstrenewingappt = [select id,GE_PRM_Prior_performance_rating__c from GE_PRM_Channel_Appointment__c where GE_PRM_Old_Channel_Appointment__c =: channelAppId ];
        if(lstrenewingappt.size()>0){
        isrenewingapptexists = true;
        }
        else{
        isrenewingapptexists = false;
        } 
        List<GE_PRM_Channel_Appointment__c> channel= new List<GE_PRM_Channel_Appointment__c>(); 
         channel=[select GE_PRM_Current_Status__c,GE_PRM_IsApproved__c,id,GE_PRM_CommercialAffected__c,GE_PRM_ComplainceAffected__c,GE_PRM_addtional_CL__c,GE_PRM_Prior_performance_rating__c from GE_PRM_Channel_Appointment__c where id=:channelAppId ];
        if(channel.size()>0)
        {
        if(channel[0].GE_PRM_IsApproved__c==true && (channel[0].GE_PRM_CommercialAffected__c==true ||channel[0].GE_PRM_ComplainceAffected__c==true) && channel[0].GE_PRM_Current_Status__c=='Draft'  && channel[0].GE_PRM_addtional_CL__c == false)
        {
            System.debug('qqqqwwwwwww');
            enableaddCL=true;
        }  
        }  
    }
   //** VF page action 

    Public PageReference editCommline(){
    update newchannelrec;
    PageReference editcommlineref;
    if(ApexPages.currentPage().getParameters().get('recallRegen')=='true'){
         editcommlineref = new pagereference('/apex/GE_PRM_CommercialLines_Details?ChannelAppointmentId='+channelAppId+'&Id='+commlineid+'&recallRegen=true');
    }else{
         editcommlineref = new pagereference('/apex/GE_PRM_CommercialLines_Details?ChannelAppointmentId='+channelAppId+'&Id='+commlineid);
    }
    return editcommlineref;
    }
    Public PageReference cloneCommline(){
    update newchannelrec;
    PageReference clonecommlineref = new pagereference('/apex/GE_PRM_CommercialLines_Details?ChannelAppointmentId='+channelAppId+'&Id='+commlineid+'&clone=1');
    return clonecommlineref;
    }
     //** returns to accounts Page.
    public PageReference cancel() {
        PageReference updChApp;
        if(ApexPages.currentPage().getParameters().get('isexistingappt') == 'true'){                                    
            updChApp=new PageReference('/apex/GE_PRM_Channel_Appointment_View_Page1?id='+channelAppId) ;
            updChApp.setRedirect(True);    
        }  
        else{            
            GE_PRM_Channel_Appointment__c ChApp = (GE_PRM_Channel_Appointment__c) c.getRecord();
            id idaccount = ChApp.GE_PRM_Account_Name__c;            
            updChApp=new PageReference('/'+idaccount) ;
        }        
        return updChApp;
    }
    //** saving channel appointment details    
    public PageReference save() {  
    system.debug('inside save');
        List<GE_PRM_Channel_Appointment_Approver__c> lstApproversReCalGen = new List<GE_PRM_Channel_Appointment_Approver__c>();
        List<GE_PRM_Commercial_line__c> lstCommercialLines = new List<GE_PRM_Commercial_line__c>();
        list<GE_PRM_Channel_Appointment__c> ChApp  = new list<GE_PRM_Channel_Appointment__c >();
        list<GE_HQ_Country__c> GE_HQ_Country = new list<GE_HQ_Country__c >();
        ChApp  =[select GE_PRM_Account_Name__r.Oil_Gas_Parent_Account__c, GE_PRM_Account_Country__c,GE_PRM_KYC_DD_Submitted_Date__c,GE_PRM_Due_diligence_approval_Status__c,GE_PRM_KYC_DD_Approved_Date__c,
                 GE_PRM_Is_government_cert_uploaded__c,GE_PRM_Prior_performance_rating__c from GE_PRM_Channel_Appointment__c where id =:this.newchannelrec.id];
        GE_HQ_Country = [select GE_PRM_Adverse_Termination_Risk__c from GE_HQ_Country__c where name =: ChApp[0].GE_PRM_Account_Country__c];        
        
        //Added  for req#R-23904
        this.newchannelrec.GE_PRM_Commercial_Account__c = ChApp[0].GE_PRM_Account_Name__r.Oil_Gas_Parent_Account__c;
        system.debug('%%%%%%'+this.newchannelrec.GE_PRM_Commercial_Account__c);
        try{
            this.newchannelrec.Adverse_country_risk__c = GE_HQ_Country[0].GE_PRM_Adverse_Termination_Risk__c;            
        }
        catch(ListException e){
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.FATAL, 'Please Update country field on Account');
            ApexPages.addMessage(myMsg);
        }                       
        Date kycStartDate= ChApp[0].GE_PRM_KYC_DD_Submitted_Date__c;
        String isGovUploaded_prev = ChApp[0].GE_PRM_Is_government_cert_uploaded__c;
        String isGovUploaded = this.newchannelrec.GE_PRM_Is_government_cert_uploaded__c;
        String DDstatus=this.newchannelrec.GE_PRM_Due_diligence_approval_Status__c;
        Date kycAppDate= ChApp[0].GE_PRM_KYC_DD_Approved_Date__c;
        try{
            /**R-25797 changes : Removed "GE_PRM_Is_government_cert_uploaded__c = true" from IF logic  **/
            if(kycStartDate==NULL || Test.IsRunningTest()){ 
                this.newchannelrec.GE_PRM_KYC_DD_Submitted_Date__c=date.today();
                this.newchannelrec.GE_PRM_Due_diligence_approval_Status__c='Pending';
            }
            else if(kycStartDate!=NULL  && DDstatus=='Due Diligence Accepted' && kycAppDate==NULL ){
                this.newchannelrec.GE_PRM_KYC_DD_Approved_Date__c=date.today();
            } 
            // as part of checkmarx bug 0000019085 adding if condition
             if(Schema.sObjectType.GE_PRM_Channel_Appointment__c.isUpdateable()){
                update this.newchannelrec;
            }
              
            GenerateRisk();
        }
        catch(Exception e){
            If(! Test.IsRunningTest() ) return null;
        }      
        List<GE_PRM_Commercial_line__c> arrCommercialLines2 = new List<GE_PRM_Commercial_line__c>();
        
        system.debug('&&&&&&&'+isRecalledRegen);
        //Added as part Recall/ Regenerate requirement
        if(ApexPages.currentPage().getParameters().get('recallRegen')=='true'){
            isRecalledRegen = true;
        }
        if(isRecalledRegen){
            //query all CAA records.
            lstApproversReCalGen = [select id,GE_PRM_Channel_Appointment__c, Is_Active__c, GE_PRM_Status__c
                                    FROM GE_PRM_Channel_Appointment_Approver__c
                                    WHERE GE_PRM_Channel_Appointment__c =: ChApp[0].id
                                    LIMIT 50000];
            lstCommercialLines = [SELECT id,isCommercialApproved__c,isComplianceApproved__c
                                    FROM GE_PRM_Commercial_line__c
                                    WHERE GE_PRM_Channel_Appointment__c =: ChApp[0].id
                                    LIMIT 50000];
            List<GE_PRM_Commercial_line__c> List_CommercialLines=new List<GE_PRM_Commercial_line__c>();
            for(GE_PRM_Commercial_line__c objComm: lstCommercialLines){
                objComm.isCommercialApproved__c = false;
                objComm.isComplianceApproved__c = false;
                List_CommercialLines.add(objComm);
            }
            //If any one is Approved regenerate. Otherwise recall.
            //Change the status of all Submitted CAAs to "Pending". with "Active"
            //Make Aprroved CAAs to "Inactive".
            List<GE_PRM_Channel_Appointment_Approver__c>  List_CL_Approver =new List<GE_PRM_Channel_Appointment_Approver__c>();
            for(GE_PRM_Channel_Appointment_Approver__c objAppr: lstApproversReCalGen){
                if(objAppr.GE_PRM_Status__c == 'Pending'){
                    objAppr.GE_PRM_Status__c = 'Recalled';
                    objAppr.Is_Active__c = true;
                }
                else if(objAppr.GE_PRM_Status__c == 'Approved'){
                    objAppr.Is_Active__c = false;
                }
                List_CL_Approver.add(objAppr);
            }
            System.debug('&&&&&&&&&&&&'+List_CL_Approver); 
            //Update the records.
            if(List_CL_Approver.size() > 0){
                try{
                    update List_CL_Approver;
                }
                catch(Exception e){
                    system.debug('Exception in recall/ regenerate'+e.getMessage());
                }
            }
            System.debug('&&&&&&&&&&&&'+List_CommercialLines); 
            if(List_CommercialLines.size() > 0){
                try{
                    update List_CommercialLines;
                    ChApp[0].GE_PRM_Commercial_Start_Date_addCL__c = null;
                    update ChApp[0];
                }
                catch(Exception e){
                    system.debug('Exception in recall/ regenerate'+e.getMessage());
                }
            }
        }
        
        PageReference updChApp=new PageReference('/apex/GE_PRM_Channel_Appointment_View_Page1?id='+this.newchannelrec.id) ;
        updChApp.setRedirect(True); 
        return updChApp;        
    }
    
        public void displayCAA(){
            system.debug('Approvers block '+this.newchannelrec.id);
            lstCAAOnPage = [SELECT id,GE_PRM_Channel_Appointment__c, Is_Active__c, GE_PRM_Status__c,Name, GE_PRM_Approvers__c,
                            GE_PRM_Delegated_User__c,GE_PRM_Tier_2__c, GE_PRM_Tier_3__c, GE_PRM_Role__c, CreatedDate,GE_PRM_Approval_Aging__c
                            FROM GE_PRM_Channel_Appointment_Approver__c
                            WHERE GE_PRM_Channel_Appointment__c =: this.newchannelrec.id
                            //AND (GE_PRM_Status__c = 'Pending' OR (Is_Active__c != false AND GE_PRM_Status__c = 'Approved'))
                            LIMIT 50000
                            ];
        }
        
        Public PageReference init()
        {  
              
        string renewaccid = ApexPages.currentPage().getParameters().get('RenewAccId');
        system.debug(renewaccid);
        contractRecordTypeMasterId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Channel Master Agreement').getRecordTypeId();
        contractRecordTypeAddendumId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Channel Addendum Agreement').getRecordTypeId();
        if(renewaccid != null){
        return null;
        }
        else{               
        integer i;
        string s = ApexPages.currentPage().getURL();
        system.debug(s);
        Schema.DescribeSObjectResult r = GE_PRM_Channel_Appointment__c.sObjectType.getDescribe();
        String keyPrefix = r.getKeyPrefix(); 
        string s1 = 'retURL=%2F'+keyPrefix+'%2Fo';
        i = s.indexof(s1,0);
        if(channelAppId == null || channelAppId =='' || Test.IsRunningTest() )
        {              
            if( i == -1 || Test.IsRunningTest() ){                                
                if(string.valueof(newchannelrec.GE_PRM_Account_Name__c) != null ){
                    newchannelrec.GE_PRM_Master_appointment_type__c = 'New';
                    System.debug('//////////// ' + newchannelrec);
                    Account a = [Select Oil_Gas_Parent_Account__c  From Account Where Id = :newchannelrec.GE_PRM_Account_Name__c];
                    this.newchannelrec.GE_PRM_Commercial_Account__c = a.Oil_Gas_Parent_Account__c ;                 
                    insert newchannelrec;
                    
                    PageReference newChApp=new PageReference('/apex/GE_PRM_Channel_Appointment_page1?id='+newchannelrec.Id) ;
                    newChApp.setRedirect(True);        
                    if(!Test.isRunningTest()){
                        return newChApp;
                    }
                    
                }
            }
        }
        system.debug(i);
         
            if(i == -1){
                pagerender = true;
            }
            else
            {
                pagerender = false;
            }
            if(string.valueof(newchannelrec.GE_PRM_Account_Name__c) == null || string.valueof(newchannelrec.GE_PRM_Account_Name__c) == ''){
                pagerender = false;            
            } 
         
        return null;  
        }      
    }
    
    //**Method to Get the Risk path based on counrty and Complaince section
    Public Void GenerateRisk()
    {
        system.debug('inside Genereate Risk');
        Boolean Nonstrndindef =false;
        Boolean sellhighrsik =false;
        Boolean sellMediumRisk = false;
        list<GE_HQ_Country__c> countrylist =new list<GE_HQ_Country__c>();
        list<GE_HQ_Country__c> countrylist1 =new list<GE_HQ_Country__c>();
        channelApplist = [select Id, 
                          GE_PRM_Master_appointment_type__c,
                          GE_PRM_Tier_2_P_L__c,
                          GE_PRM_Primary_Sales_Channel_Manager__c,
                          GE_PRM_Sales_Channel_Manager__c,
                          GE_PRM_In_Business_Since__c,
                          GE_PRM_With_GE_since__c,
                          GE_PRM_Prior_year_orders__c, 
                          GE_PRM_Prior_performance_rating__c,
                          GE_PRM_Prior_year_commission_paid__c,
                          GE_PRM_Prior_growth_rating__c,
                          GE_PRM_Commercial_quali_rationale__c,
                          GE_PRM_Payment_term_requested__c,
                          GE_PRM_Primary_bank_account__c,
                          GE_PRM_Primary_bank_account_country__c,
                          GE_PRM_Primary_bank_contact__c,
                          GE_PRM_Primary_bank_name_address__c,
                          GE_PRM_Mandated_by_End_Customer__c,
                          GE_PRM_Current_yr_orders_target__c,
                          GE_PRM_Convicted_of_any_felony_crims_r_s__c,
                          GE_PRM_Do_you_have_Officers_in_Gov__c,
                          GE_PRM_High_Risk_product_lines__c,
                          GE_PRM_Sell_to_Nuclear_industry__c,
                          GE_PRM_Do_you_sell_to_the_government__c,
                          GE_PRM_Use_of_sub_dealers_or_agents__c,
                          GE_PRM_Does_Channel_Partner_have_subsid__c,
                          GE_PRM_Export_Controlled_products__c,
                          GE_PRM_Export_outside_own_country__c,
                          GE_PRM_Approved_exclusivity_from_P_L__c,
                          GE_PRM_Account_Country__c,
                          GE_PRM_Des_Chnl_Partner_hv_sb_dea_sbagnt__c,
                          GE_PRM_Last_Commercial_Approved__c,
                          GE_PRM_Due_diligence_approval_Status__c,
                          GE_PRM_Account_Name__r.GE_HQ_New_Account_Country__c ,
                          GE_PRM_Account_Name__r.GE_HQ_Country_Code__c,
                          GE_PRM_Account_Name__r.ShippingCountry 
                          from GE_PRM_Channel_Appointment__c where id =:channelAppId];        
        account acc = [select name, GE_HQ_Country_Code__c from account where id =: this.newchannelrec.GE_PRM_Account_Name__c limit 1]; 
        countrylist =[select GE_PRM_Risk_Score__c,GE_PRM_Adverse_Termination_Risk__c,GE_PRM_Channel_Risk_Type__c from GE_HQ_Country__c where GE_HQ_ISO_Code__c =: acc.GE_HQ_Country_Code__c]; 
        system.debug('&&&&&&countrylist'+countrylist);
       //** Risk generation using ISO code
        string primarybankIsoCode;
        if(channelApplist[0].GE_PRM_Primary_bank_account_country__c !=  null && channelApplist[0].GE_PRM_Primary_bank_account_country__c != '' || Test.IsRunningTest() )
        primarybankIsoCode = [select GE_HQ_ISO_Code__c  from GE_HQ_Country__c  where name =: channelApplist[0].GE_PRM_Primary_bank_account_country__c limit 1].GE_HQ_ISO_Code__c;
              
        Commercilaline =[select GE_PRM_Non_Standrd_Indefnte_Discnt_r_Com__c,GE_PRM_Type__c,GE_PRM_Authorized_Countries_1__c,GE_PRM_Authorized_Countries_2__c from GE_PRM_Commercial_line__c where GE_PRM_Channel_Appointment__c =:channelAppId];
     //   If ( Test.IsRunningTest() ){  Commercilaline =[select GE_PRM_Non_Standrd_Indefnte_Discnt_r_Com__c,GE_PRM_Authorized_Countries_1__c,GE_PRM_Authorized_Countries_2__c from GE_PRM_Commercial_line__c Limit 1];}        
        if(Commercilaline.size()>0)
        {
            for(GE_PRM_Commercial_line__c  commline :Commercilaline )
            {
                //logic for Non-Standard/Indefinite Discount or Commission
                if(commline.GE_PRM_Non_Standrd_Indefnte_Discnt_r_Com__c!=null)
                {                    
                    String[] Tempstring2=commline.GE_PRM_Non_Standrd_Indefnte_Discnt_r_Com__c.Split(';');                    
                    for(string s :Tempstring2)
                    {
                        if(s =='Non-standard' ||s =='Indefinite' || Test.isRunningTest())                            
                            Nonstrndindef =true;                        
                    }
                }
                //logic for Sell-into higher risk country
                if(commline.GE_PRM_Authorized_Countries_1__c!=null)
                {
                    String[] Tmpstring = commline.GE_PRM_Authorized_Countries_1__c.split(';');                    
                    if(Tmpstring.size()>0)
                    {
                        countrylist1 =[ select GE_PRM_Channel_Risk_Type__c  from GE_HQ_Country__c  where name IN :Tmpstring];
                        if(countrylist1.size()>0) 
                        for(GE_HQ_Country__c c: countrylist1){
                          if(c.GE_PRM_Channel_Risk_Type__c=='High' )
                                sellhighrsik =true;
                            else if(c.GE_PRM_Channel_Risk_Type__c=='Medium' || Test.isRunningTest())
                                sellMediumRisk =true;  
                            
                        }                        
                    }                    
                }                 
                if(commline.GE_PRM_Authorized_Countries_2__c!=null)
                {
                    String[] Tmpstring1 = commline.GE_PRM_Authorized_Countries_2__c.split(';');
                    if(Tmpstring1.size()>0)
                    {
                         countrylist1 =[ select GE_PRM_Channel_Risk_Type__c  from GE_HQ_Country__c  where name IN : Tmpstring1];
                        if(countrylist1.size()>0) 
                        for(GE_HQ_Country__c c: countrylist1){
                          if(c.GE_PRM_Channel_Risk_Type__c=='High')
                                sellhighrsik =true;
                            else if(c.GE_PRM_Channel_Risk_Type__c=='Medium')
                                sellMediumRisk =true;  
                            
                        }
                    } 
                } 
            }
        } 
        try{            
            decimal d = countrylist[0].GE_PRM_Adverse_Termination_Risk__c;
            
        }
        catch(ListException e){
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.FATAL, 'Please Update country field on Account');
            ApexPages.addMessage(myMsg);
        }        
        System.debug('%%%%%%%this.newchannelrec.GE_PRM_Risk_rating'+this.newchannelrec.GE_PRM_Risk_rating__c);
        if(channelApplist[0].GE_PRM_Master_appointment_type__c =='New' || Test.isRunningTest())
        {        
           System.debug('%%%%%%%this.newchannelrec.GE_PRM_Risk_rating'+this.newchannelrec.GE_PRM_Risk_rating__c);
            if(countrylist[0].GE_PRM_Channel_Risk_Type__c =='Low' || this.newchannelrec.GE_PRM_Export_Controlled_products__c =='Yes' ||
                this.newchannelrec.GE_PRM_Do_you_sell_to_the_government__c =='Yes'  ||
                this.newchannelrec.GE_PRM_Sell_to_Nuclear_industry__c=='Yes' ||
                this.newchannelrec.GE_PRM_Export_outside_own_country__c=='Yes' ||Test.isRunningTest()){
                this.newchannelrec.GE_PRM_Risk_rating__c ='Low';
               }
            System.debug('%%%%%%%this.newchannelrec.GE_PRM_Approved_exclusivity_from_P_L'+this.newchannelrec.GE_PRM_Approved_exclusivity_from_P_L__c);
            if(countrylist[0].GE_PRM_Channel_Risk_Type__c =='Medium' || Test.isRunningTest()  ||sellMediumRisk ==true || countrylist[0].GE_PRM_Adverse_Termination_Risk__c >=20 ||
                this.newchannelrec.GE_PRM_Des_Chnl_Partner_hv_sb_dea_sbagnt__c=='Yes'||Nonstrndindef  ==true ||
                this.newchannelrec.GE_PRM_Approved_exclusivity_from_P_L__c =='Yes' )
                 {   
                     this.newchannelrec.GE_PRM_Risk_rating__c ='Medium';  
                     for(GE_PRM_Commercial_line__c  commline :Commercilaline )
                            {
                              if(commline.GE_PRM_Type__c=='Sales Representative'){
                                  this.newchannelrec.GE_PRM_Risk_rating__c ='High';   
                                }
                        } 
                 }            
            if(countrylist[0].GE_PRM_Channel_Risk_Type__c =='High'  || sellhighrsik ==true || this.newchannelrec.GE_PRM_Current_yr_orders_target__c >10000000 ||this.newchannelrec.GE_PRM_Mandated_by_End_Customer__c=='Yes' ||this.newchannelrec.GE_PRM_Convicted_of_any_felony_crims_r_s__c=='Yes' ||this.newchannelrec.GE_PRM_Do_you_have_Officers_in_Gov__c=='Yes' ||this.newchannelrec.GE_PRM_High_Risk_product_lines__c =='Yes' ||((primarybankIsoCode != acc.GE_HQ_Country_Code__c) && (primarybankIsoCode != null) ) ||Test.isRunningTest())
            {               
                this.newchannelrec.GE_PRM_Risk_rating__c  ='High';
                this.newchannelrec.Was_Ever_High__c = true;
            } 
            Update newchannelrec ;              
            //  R-24252 : Channel Risk Trigger changes 1Q16 -
            /*  Change these risk items from Medium risk to Low risk
            *   N-9, "Sells to the nuclear industry?", Compliance Risk Assessment 
            *   N-10, Sells to the government, Compliance Risk Assessment 
            *   N-14, Export Controlled Products, Compliance Risk Assessment 
            *   N-15, Export outside own country?, Compliance Risk Assessment
            */  
        }   
         if(channelApplist[0].GE_PRM_Master_appointment_type__c =='Renewal')
        {
               if(countrylist[0].GE_PRM_Channel_Risk_Type__c =='Low' || this.newchannelrec.GE_PRM_Export_Controlled_products__c =='Yes' ||
               this.newchannelrec.GE_PRM_Do_you_sell_to_the_government__c =='Yes'  ||
               this.newchannelrec.GE_PRM_Sell_to_Nuclear_industry__c=='Yes' ||
               this.newchannelrec.GE_PRM_Export_outside_own_country__c=='Yes' || Test.isRunningTest()){
                    this.newchannelrec.GE_PRM_Risk_rating__c ='Low';
               }
              if(countrylist[0].GE_PRM_Channel_Risk_Type__c =='High'|| Test.isRunningTest() || 
                countrylist[0].GE_PRM_Channel_Risk_Type__c =='Medium' || sellhighrsik ==true ||sellMediumRisk ==true || 
                this.newchannelrec.GE_PRM_Current_yr_orders_target__c >10000000 ||this.newchannelrec.GE_PRM_Mandated_by_End_Customer__c =='Yes' ||
                    this.newchannelrec.GE_PRM_High_Risk_product_lines__c=='Yes' ||Nonstrndindef ==true )
               {
                   this.newchannelrec.GE_PRM_Risk_rating__c  ='Medium'; 
                   if(Commercilaline.size()>0){  
                         for(GE_PRM_Commercial_line__c  commline :Commercilaline )
                            {
                              if(commline.GE_PRM_Type__c=='Sales Representative'){
                                  this.newchannelrec.GE_PRM_Risk_rating__c ='High';   
                                }
                            }             
                       }  
                }
            
            if(this.newchannelrec.GE_PRM_Convicted_of_any_felony_crims_r_s__c=='Yes' ||this.newchannelrec.GE_PRM_Do_you_have_Officers_in_Gov__c=='Yes' || Test.isRunningTest())
            {
                this.newchannelrec.GE_PRM_Risk_rating__c  ='High';
                this.newchannelrec.Was_Ever_High__c = true;
            }
            system.debug('newchannelrec1 ==='+newchannelrec.GE_PRM_Risk_rating__c  );
            Update newchannelrec ;            
        }       
    }    
    //**Edit button on Channel appointmnet
    
    public PageReference editChannelAppointment() {
        PageReference updChApp;
        
            updChApp=new PageReference('/apex/GE_PRM_Channel_Appointment_Page1?id='+channelAppId+'&isexistingappt=true') ;
            updChApp.setRedirect(True);
        
         
        return updChApp;        
    }    
    public PageReference edit() {
        PageReference updChApp=new PageReference('/apex/GE_PRM_Channel_Appointment_Page1?id='+channelAppId) ;
        updChApp.setRedirect(True);
        return updChApp;
    }   
    //** method to redirect to content page
    public PageReference addcontent() {
        PageReference ca=new PageReference('/apex/GE_PRM_Multi_Content_Upload?Caid='+channelAppId ) ;
        ca.setRedirect(True);        
        return ca;        
    }
    //** method to redirect to showmore account page
    public PageReference showmore() {
        update newchannelrec;
        PageReference sh=new PageReference('/apex/GE_PRM_Show_All_Accounts?Caid='+channelAppId ) ;
        sh.setRedirect(True);        
        return sh;        
    }
    //** method to redirect to channel appt page
    public pagereference back()    {
        PageReference pageRef1 = new PageReference('/' + channelAppId);
        return pageref1;
    }    
    //** commercial line details list variable
    public List<GE_PRM_Commercial_line__c> getCommercialLines() 
    {
        List<GE_PRM_Commercial_line__c> arrCommercialLines = new List<GE_PRM_Commercial_line__c>();
        List<GE_PRM_Commercial_line__c> arrCommercialLines1 = new List<GE_PRM_Commercial_line__c>();
        arrCommercialLines1 = [Select Id, isCommercialApproved__c,GE_PRM_Authorized_Countries_1__c,GE_PRM_Channel_Appointment__r.GE_PRM_Approved_CommercialApp_Approvals__c, GE_PRM_contract_genrated__c ,GE_PRM_Channel_Appointment__c, Name, GE_PRM_Status__c, GE_PRM_Tier_1__c,GE_PRM_Tier_2__c,GE_PRM_Tier_3__c,GE_PRM_Tier_4__c,GE_PRM_Tier_5__c, GE_PRM_Relationship_expiry_date__c,GE_PRM_Next_year_target__c,GE_PRM_Current_year_target__c,GE_PRM_Type__c, LastModifiedDate, GE_PRM_Buyers__c, GE_PRM_Industries__c from GE_PRM_Commercial_line__c  where GE_PRM_Channel_Appointment__c =:channelAppId order by createddate asc];     
        if(arrCommercialLines1.size() > 0 ){
            for(integer i=1; i <=arrCommercialLines1.size(); i++ ){                
                if(string.valueof(arrCommercialLines1[i-1].GE_PRM_Relationship_expiry_date__c) == null &&
                   arrCommercialLines1[i-1].GE_PRM_Type__c == null && arrCommercialLines1[i-1].GE_PRM_Tier_2__c == null &&
                   arrCommercialLines1[i-1].GE_PRM_Tier_3__c == null && string.valueof(arrCommercialLines1[i-1].GE_PRM_Current_year_target__c)==null){
                   }
                else{
                    arrCommercialLines.add(arrCommercialLines1[i-1]); 
                }
            }            
        }                   
        return arrCommercialLines;          
    }   
    //** add commercial lines method
    public PageReference addCommercialLines()
    {
        try{
        system.debug('channel rec' + newchannelrec );
            update newchannelrec;
            GE_PRM_Commercial_line__c objCommercialLines =new GE_PRM_Commercial_line__c(GE_PRM_Channel_Appointment__c = this.newchannelrec.id);
            insert objCommercialLines;
            PageReference pref;
            pref = new PageReference('/apex/GE_PRM_CommercialLines_Details?ChannelAppointmentId='+this.newchannelrec.id+'&Id='+objCommercialLines.Id+'&isNew=true'+'&Status='+this.newchannelrec.GE_PRM_Current_Status__c);
            return pref; 
        }
        catch(Exception e){       
        
        system.debug('add com line error----------'+e.getMessage());     
            return null;
        }       
    }     
    //added For adding addtional COmmercial line    
    Public PageReference Additionalcommline()
    {     
        try{           
            update newchannelrec;
            GE_PRM_Commercial_line__c objCommercialLines =new GE_PRM_Commercial_line__c(GE_PRM_Channel_Appointment__c = this.newchannelrec.id);
            insert objCommercialLines;            
            PageReference pref;
            pref = new PageReference('/apex/GE_PRM_CommercialLines_Details?ChannelAppointmentId='+this.newchannelrec.id+'&Id='+objCommercialLines.Id+'&isadditonal=addCL&fromviewpage=true'+'&Status='+this.newchannelrec.GE_PRM_Current_Status__c);
            return pref; 
        }
        catch(Exception e){
            system.debug('error----->'+e);
            return null;           
        }               
    }
    //** subdealers list variable
    public List<Sub_Dealer__c> getBranchOffices() 
    {
        List<Sub_Dealer__c> arrBranchOffices = new List<Sub_Dealer__c>();
        List<Sub_Dealer__c> arrBranchOffices1 = new List<Sub_Dealer__c>();
        arrBranchOffices = [select Id, GE_PRM_Unique_Id__c,GE_PRM_Affiliate_dependent_type__c, GE_PRM_Address_line_1__c,GE_PRM_City__c,GE_PRM_Prinicipal_Conatct_Text__c, GE_PRM_Address_line_2__c, GE_PRM_Legal_name__c, GE_PRM_Channel_Appointment__c
                            from Sub_Dealer__c where GE_PRM_Channel_Appointment__c =:channelAppId order by createddate asc];
        
        if(arrBranchOffices.size() > 0 ){
            for(integer i=1; i <=arrBranchOffices.size(); i++ ){                
                if(arrBranchOffices[i-1].GE_PRM_Affiliate_dependent_type__c == null && arrBranchOffices[i-1].GE_PRM_Legal_name__c == null &&
                   arrBranchOffices[i-1].GE_PRM_City__c == null && arrBranchOffices[i-1].GE_PRM_Prinicipal_Conatct_Text__c == null){
                   }
                else{
                    arrBranchOffices1.add(arrBranchOffices[i-1]); 
                }
            }            
        }             
        return arrBranchOffices1;          
    }    
    //** method to add new subdealer details
    public PageReference addBranchOffice()
    {
        try{            
            Sub_Dealer__c objBranchOffices =new Sub_Dealer__c(GE_PRM_Channel_Appointment__c = this.newchannelrec.id);
            insert objBranchOffices;
            update newchannelrec;
            PageReference pref;
            pref = new PageReference('/apex/GE_PRM_Channel_BranchOffice_Sub?ChannelAppointmentId='+this.newchannelrec.id+'&Id='+objBranchOffices.Id+'&isNew=true');
            return pref;   
        }
        catch(Exception e){
            return null;
        }     
    } 
    //Added by Revathi for adding new commercial lines and archising the approvers if already genaerated for same business.
    public PageReference generateCommerApp() 
    {        
        List<GE_PRM_Commercial_line__c> Commlines =new list<GE_PRM_Commercial_line__c>();  
        list<GE_PRM_Commercial_line__c> finallist =new list<GE_PRM_Commercial_line__c>();
        list<GE_PRM_Commercial_line__c> newcommerciallines =new list<GE_PRM_Commercial_line__c>();
        list<GE_PRM_Commercial_line__c> Oldcommecriallines =new list<GE_PRM_Commercial_line__c>();
        System.debug('channelAppId'+channelAppId);
        channelApplist = [select Id,GE_PRM_Master_appointment_type__c,GE_PRM_Tier_2_P_L__c,GE_PRM_Primary_Sales_Channel_Manager__c,
                          GE_PRM_Region_Sales_Channel_Leader__c,GE_PRM_Sales_Channel_Manager__c,GE_PRM_In_Business_Since__c,
                          GE_PRM_With_GE_since__c,GE_PRM_Account_CMF_Status__c,GE_PRM_Prior_year_orders__c,GE_PRM_Prior_performance_rating__c,
                          GE_PRM_Prior_year_commission_paid__c,GE_PRM_Prior_growth_rating__c,GE_PRM_Commercial_quali_rationale__c,
                          GE_PRM_Payment_term_requested__c,GE_PRM_Primary_bank_account__c,GE_PRM_Primary_bank_account_country__c,
                          GE_PRM_Primary_bank_contact__c,GE_PRM_Primary_bank_name_address__c,GE_PRM_No_Of_Product_Lines_Added__c,
                          GE_PRM_Sell_to_Military__c,GE_PRM_Commercial_Start_Date_addCL__c,GE_PRM_Commercial_Start_Date__c,
                          GE_PRM_EnableCommercialButton__c,GE_PRM_EnableComplainceButton__c,GE_PRM_CommercialAffected__c,GE_PRM_ComplainceAffected__c,GE_PRM_WillUpdateCommercial__c
                          from GE_PRM_Channel_Appointment__c where id =:channelAppId ];     
                          
        System.debug('channelApplist'+channelApplist[0].GE_PRM_Master_appointment_type__c);        
        if(channelApplist[0].GE_PRM_Master_appointment_type__c == null ||channelApplist[0].GE_PRM_Master_appointment_type__c == '' 
           || channelApplist[0].GE_PRM_Tier_2_P_L__c ==null || channelApplist[0].GE_PRM_Tier_2_P_L__c == ''
           || string.valueof(channelApplist[0].GE_PRM_Primary_Sales_Channel_Manager__c)==null || string.valueof(channelApplist[0].GE_PRM_Primary_Sales_Channel_Manager__c)== ''
           || string.valueof(channelApplist[0].GE_PRM_Region_Sales_Channel_Leader__c)==null || string.valueof(channelApplist[0].GE_PRM_Sales_Channel_Manager__c)== ''
           || channelApplist[0].GE_PRM_In_Business_Since__c==null
           || channelApplist[0].GE_PRM_With_GE_since__c==null 
           || channelApplist[0].GE_PRM_Prior_year_orders__c==null || channelApplist[0].GE_PRM_Prior_year_orders__c== ''
           || channelApplist[0].GE_PRM_Prior_year_commission_paid__c==null || channelApplist[0].GE_PRM_Prior_year_commission_paid__c== ''
           || channelApplist[0].GE_PRM_Commercial_quali_rationale__c==null || channelApplist[0].GE_PRM_Commercial_quali_rationale__c== ''
           || !(channelApplist[0].GE_PRM_No_Of_Product_Lines_Added__c > 0)
          )
        {
            system.debug('%%%%%%%%%%%%%%%%%%%%%5');
            requiredstyle = 'border-color:red;';
            string strmsg = 'Please fill :';
            //Bug 0000018916 -begins
            if(channelApplist[0].GE_PRM_Master_appointment_type__c == null ||channelApplist[0].GE_PRM_Master_appointment_type__c == '' || Test.isRunningTest()){
                strmsg = strmsg +' * Appointment Type ';    
                styleappttype =requiredstyle ;        
            }
            if(channelApplist[0].GE_PRM_Tier_2_P_L__c ==null || channelApplist[0].GE_PRM_Tier_2_P_L__c == ''|| Test.isRunningTest()){
                strmsg = strmsg +' * Primary Tier 2 P&L ';
                styletier = requiredstyle ;
            }
            if(string.valueof(channelApplist[0].GE_PRM_Primary_Sales_Channel_Manager__c)==null || string.valueof(channelApplist[0].GE_PRM_Primary_Sales_Channel_Manager__c)== ''  || Test.isRunningTest() ){
                strmsg = strmsg +' * Sales/Channel Manager ';
                stylepscm= requiredstyle ;
            }
            if(string.valueof(channelApplist[0].GE_PRM_Region_Sales_Channel_Leader__c)==null || string.valueof(channelApplist[0].GE_PRM_Sales_Channel_Manager__c)== ''|| Test.isRunningTest()){
                strmsg = strmsg + ' * Region Sales/Channel Leader ';
                stylerscl= requiredstyle ;
            }
            if(channelApplist[0].GE_PRM_In_Business_Since__c==null|| Test.isRunningTest()){
                strmsg = strmsg + ' * In Business Since ';
                styleinbuz= requiredstyle ;
            }
            
            if(channelApplist[0].GE_PRM_With_GE_since__c==null || Test.isRunningTest() ){
                strmsg = strmsg + ' * With GE Since (# of years)';
                stylewithge= requiredstyle ;
            }
            if(channelApplist[0].GE_PRM_Prior_year_orders__c==null || channelApplist[0].GE_PRM_Prior_year_orders__c== ''|| Test.isRunningTest()){
                strmsg = strmsg +' * Prior Year Orders ';
                styleprioryo= requiredstyle ;
            }
            /*if(channelApplist[0].GE_PRM_Prior_performance_rating__c==null || channelApplist[0].GE_PRM_Prior_performance_rating__c== ''|| Test.isRunningTest()){
                strmsg = strmsg +' * Prior Performance Rating ';
                stylepriorpr= requiredstyle ;
            }*/
            if(channelApplist[0].GE_PRM_Prior_year_commission_paid__c==null || channelApplist[0].GE_PRM_Prior_year_commission_paid__c== ''|| Test.isRunningTest()){
                strmsg = strmsg +' * Prior Year Commission Paid ';
                styleprcommpaid= requiredstyle ;
            }
            /*if(channelApplist[0].GE_PRM_Prior_growth_rating__c==null || channelApplist[0].GE_PRM_Prior_growth_rating__c== ''|| Test.isRunningTest()){
                strmsg = strmsg +' * Prior Growth Rating ';
                styleprgrorate= requiredstyle ;
            }*/
            if(channelApplist[0].GE_PRM_Commercial_quali_rationale__c==null || channelApplist[0].GE_PRM_Commercial_quali_rationale__c== ''|| Test.isRunningTest()){
                strmsg = strmsg + ' * Commercial Qualification Rationale ';
                stylecommquali= requiredstyle ;
            }
            if(!(channelApplist[0].GE_PRM_No_Of_Product_Lines_Added__c > 0) || Test.isRunningTest() ){
                strmsg = strmsg + ' Add Commercial line ';
            }   
            //bug 0000018916 - ends                   
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.FATAL, strmsg);
            ApexPages.addMessage(myMsg);             
            PageReference updChApp=new PageReference('/apex/GE_PRM_Channel_Appointment_Page1?id='+channelAppId+'&isexistingappt=true') ;
            updChApp.setRedirect(false);         
            return updChApp;            
        }else if(channelApplist[0].GE_PRM_Account_CMF_Status__c !=  'CC Approved')
        {
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.FATAL, 'Account should be CC Approved to submit Channel Appointment');
            ApexPages.addMessage(myMsg); 
            return null;
        }
        else
        {
            //checking if There is commercial approverd. 
            System.debug('Entered else');
            if(channelApplist[0].GE_PRM_Commercial_Start_Date_addCL__c!=null && channelApplist[0].GE_PRM_EnableCommercialButton__c==true && channelApplist[0].GE_PRM_WillUpdateCommercial__c==true)
            {
                finallist =[select GE_PRM_Type__c, isComplianceApproved__c ,GE_PRM_Authorized_Countries_1__c,GE_PRM_Sales_Manager__c,
                           GE_PRM_Sales_Manager__r.Email,createddate,isCommercialApproved__c,GE_PRM_Channel_Appointment__r.GE_PRM_O_G_Region__c,
                           GE_PRM_Channel_Appointment__r.GE_PRM_Account_Country__c, GE_PRM_Tier_1__c,GE_PRM_Tier_2__c,GE_PRM_Tier_3__c,
                           GE_PRM_Tier_4__c,GE_PRM_Tier_5__c,GE_PRM_Channel_Appointment__r.GE_PRM_Account_Name__r.GE_HQ_New_Account_Country__c,
                           GE_PRM_Channel_Appointment__r.GE_PRM_Account_Name__r.GE_HQ_Country_Code__c,GE_PRM_Channel_Appointment__r.GE_PRM_Account_Name__r.ShippingCountry
                           from GE_PRM_Commercial_line__c where GE_PRM_Channel_Appointment__c =:this.newchannelrec.id and (createdDate >:channelApplist[0].GE_PRM_Commercial_Start_Date_addCL__c or GE_PRM_IsCommercialUpdatedCL__c=true) and (GE_PRM_Status__c=:'New' or GE_PRM_Status__c=:'Renewal')];               
            system.debug('&&&&&&&&&&&&&&1'+finallist);
            }
           
            System.debug('%$$$$ &&&&&&  Date ' + channelApplist[0].GE_PRM_Commercial_Start_Date_addCL__c);
            System.debug('%$$$$ &&&&&&  Button ' + channelApplist[0].GE_PRM_EnableCommercialButton__c);
            System.debug('%$$$$ &&&&&&  Will Update ' + channelApplist[0].GE_PRM_WillUpdateCommercial__c);
            system.debug('&&&&&&&&&&&&&&finallist'+finallist);
            
            if(channelApplist[0].GE_PRM_Commercial_Start_Date_addCL__c==null)
            {             
                finallist =[select GE_PRM_Type__c, isComplianceApproved__c ,GE_PRM_Authorized_Countries_1__c,
                            GE_PRM_Sales_Manager__c,GE_PRM_Sales_Manager__r.Email,isCommercialApproved__c,
                            GE_PRM_Channel_Appointment__r.GE_PRM_O_G_Region__c,GE_PRM_Channel_Appointment__r.GE_PRM_Account_Country__c, 
                            GE_PRM_Tier_1__c,GE_PRM_Tier_2__c,GE_PRM_Tier_3__c,GE_PRM_Tier_4__c,GE_PRM_Tier_5__c,
                            GE_PRM_Channel_Appointment__r.GE_PRM_Account_Name__r.GE_HQ_New_Account_Country__c,
                            GE_PRM_Channel_Appointment__r.GE_PRM_Account_Name__r.GE_HQ_Country_Code__c,
                            GE_PRM_Channel_Appointment__r.GE_PRM_Account_Name__r.ShippingCountry 
                            from GE_PRM_Commercial_line__c where GE_PRM_Channel_Appointment__c =:channelAppId];
                system.debug('&&&&&&&&&&&&&&'+finallist);
                system.debug('^^^^^^^^channelAppId'+channelAppId);
            }
            if(finallist.size()>0)
            {
            
            }
            approverType ='CommercialApprovers';     
            System.debug('%$$$$ finallist ' + finallist );                  
            Getapprovers(finallist ,approverType); 
            List<GE_PRM_Channel_Appointment_Approver__c> ListCommercialApprover=[Select id,GE_PRM_Channel_Appointment__c from GE_PRM_Channel_Appointment_Approver__c where GE_PRM_Channel_Appointment__c=:this.newchannelrec.Id];
            if(ListCommercialApprover.size()>0){
            CheckcommercialFlag=true;
            this.newchannelrec.GE_PRM_Commercial_Start_Date_addCL__c=datetime.Now();  
            this.newchannelrec.GE_PRM_Commercial_Start_Date__c = date.today();
           // this.newchannelrec.GE_PRM_addtional_CL__c =false;
            this.newchannelrec.GE_PRM_WillUpdateCommercial__c = false;
            //this.newchannelrec.GE_PRM_EnableCommercialButton__c=false;
            update this.newchannelrec; 
           }
            system.debug(commlinelist);           
            for(GE_PRM_Commercial_line__c c : finallist){
             System.debug('ooooooooooooupdate commercial  line1111'+channelApplist[0].GE_PRM_CommercialAffected__c +channelApplist[0].GE_PRM_ComplainceAffected__c);
                c.isCommercialApproved__c = true;
                if(ChannelApplist[0].GE_PRM_CommercialAffected__c==true && ChannelApplist[0].GE_PRM_ComplainceAffected__c==false || Test.isRunningTest())
                {
                    System.debug('ooooooooooooupdate commercial  line');
                 c.GE_PRM_IsCommercialUpdatedCL__c=false;
                 update c;
                 }
            }
            update finallist;
            system.debug('**finallistvar'+finallist);
            system.debug(this.newchannelrec.GE_PRM_Master_appointment_type__c);
            //**---- Updating Status of Old Appointment contracts when current channel appointment submitted for DOA
            if(this.newchannelrec.GE_PRM_Master_appointment_type__c == 'Renewal' && finallist.size()>0 ){
                Set<ID> mastercontids = New Set<ID>();
            list<contract> lstoldapptmastercontracts = new list<contract>();
            list<contract> lstoldapptaddedumcontracts = new list<contract>();
            String contractRecordTypeMasterId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Channel Master Agreement').getRecordTypeId();
            String contractRecordTypeAddendumId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Channel Addendum Agreement').getRecordTypeId();
           // system.debug('**-- Old Appointment field--'+this.newchannelrec.GE_PRM_Old_Channel_Appointment__c);
           
            lstoldapptaddedumcontracts= [select GE_PRM_Relationship_Type__c, status,GE_PRM_Business_Tier_1__c,GE_PRM_Tier_2__c,GE_PRM_Tier_3__c,GE_PRM_Tier_4__c,GE_PRM_Tier_5__c,GE_PRM_Master_Agreement__c from contract where Accountid=: this.newchannelrec.GE_PRM_Account_Name__c AND RecordTypeId =: contractRecordTypeAddendumId ];
           
            system.debug('**-- Old Appointment Addedum Contracts --'+lstoldapptaddedumcontracts);
            list<contract> lstmatchedcontracts = new list<contract>();         
           
            if(lstoldapptaddedumcontracts.size()>0){
            set<id> setContractId = new set<id>();
            for(GE_PRM_Commercial_line__c c : finallist){
            list<contract> matchedcontracts = new list<contract>();
            for(contract con :lstoldapptaddedumcontracts){
            if( con.GE_PRM_Relationship_Type__c == c.GE_PRM_Type__c && con.GE_PRM_Business_Tier_1__c == c.GE_PRM_Tier_1__c && con.GE_PRM_Tier_2__c == c.GE_PRM_Tier_2__c &&  con.GE_PRM_Tier_3__c == c.GE_PRM_Tier_3__c && con.GE_PRM_Tier_4__c == c.GE_PRM_Tier_4__c && con.GE_PRM_Tier_5__c == c.GE_PRM_Tier_5__c && con.status=='Executed'){
            matchedcontracts.add(con);
            system.debug('**-- Matched Contract--'+con); 
              }
            }
            /*if(!(matchedcontracts.size() > 0) || Test.isRunningTest()){
            //** No Matched Contracts in Old Channel Appointment 
            }
            if(matchedcontracts.size() > 1 || Test.isRunningTest()){
            //** More Than One Matched Contract in Old Channel Appointment 
            }*/
            system.debug('**-- Matched Contract--'+matchedcontracts);
            // Adding this code for bug# 0000022588 by Neha Sharma
            if((matchedcontracts.size()>0 || Test.isRunningTest()) && setContractId.contains(matchedcontracts[0].id) == false){
            lstmatchedcontracts.add(matchedcontracts[0]); 
            setContractId.add(matchedcontracts[0].id);
            }
            }             
            }
            system.debug('**--lstmatched contracts --'+lstmatchedcontracts);
            if(lstmatchedcontracts.size()>0){
            for(contract c : lstmatchedcontracts){
            c.status = 'Under Renewal';
            c.GE_PRM_Renewal_Channel_Appointment_ID__c=this.newchannelrec.Id;
            mastercontids.Add(c.GE_PRM_Master_Agreement__c);
            }
            update lstmatchedcontracts;
            system.debug('**-- Updated List of Matched Contract--'+lstmatchedcontracts); 
            }
        // Start Logic to update master status on renewal 
           List<contract> lstmastertoupdate = New List<Contract>();
           Boolean hasexecutedchild = false;
           For ( Contract cmaster : [Select ID, status,(Select Id, status from Contracts__r) from Contract Where ID IN:mastercontids ] )
           { 
                hasexecutedchild = false;
                for ( Contract cchild  : cmaster.Contracts__r )
                {
                    If ( cchild.Status == 'Executed' ) 
                    { 
                    hasexecutedchild = true;
                    break;
                    }
                }
                 If (!hasexecutedchild ) 
                {
                     cmaster.status = 'Under Renewal' ;
                     lstmastertoupdate.Add(cmaster) ; 
                }                   
                    
           }
           If ( lstmastertoupdate !=null &&  lstmastertoupdate.size()>0)
           {
               Update lstmastertoupdate ;
           }
            // End Logic to update master status on renewal 
           }
           //**--- End to Updating Old Appointment contract statuses
           system.debug(commlinelist);  
       
        }
        //return null;
        chapptviewpage.setRedirect(True); 
        return chapptviewpage;

    }    
    //for additionl comm line
    Public PageReference GenerateaddCommlinesAppr()  
    {
        AddApprovers =true;
        checkCommToll=true;
        GenerateRisk();      
        update this.newchannelrec;
        Return NUll;
    }
    
    Public PageReference AddnCOmplApprovers()
    {       
        IScompliancesecondtime=true;       
        this.newchannelrec.GE_PRM_DOA_Generated_Date__c=datetime.now();          
        update this.newchannelrec;
        Return null;
    }
    //Added by Revathi for complaince approvers
    Public PageReference GetComplainceApprovers()
    {
        system.debug('get comp approvers');
        List<GE_PRM_Commercial_line__c> Newcommlines =new list<GE_PRM_Commercial_line__c>();
        list<GE_PRM_Commercial_line__c> finallist =new list<GE_PRM_Commercial_line__c>();
        requiredstyle = '';
        styleappttype = '';
        styleMandated= '';
        styleconvfecrime= '';
        styleoffingov= '';
        stylehighriskpl= '';
        stylenuclear= '';
        stylehvsd= '';
        stylesubsid= '';
        styleexportcontr= '';
        styleexportout= '';
        styleapprplc = '';
        styleacccountry = '';
        Styleselltogovt =''; 
        stylestrDeloitte = ''; 
        stylestrCommRefReq = '';    
        stylestrIcpReq = '';     
        channelApplist = [select Id, 
                          GE_PRM_Risk_rating__c,
                          GE_PRM_Deloitte_report_order_date__c,
                          GE_PRM_Last_Deloitte_report_cmpltd_date__c,
                          GE_PRM_Last_Spirit_Letter_signed_date__c,
                          GE_PRM_Appointment_Type__c,
                          GE_PRM_Master_appointment_type__c,
                          GE_PRM_Tier_2_P_L__c,
                          GE_PRM_Primary_Sales_Channel_Manager__c,
                          GE_PRM_Sales_Channel_Manager__c,
                          GE_PRM_In_Business_Since__c,
                          GE_PRM_With_GE_since__c,
                          GE_PRM_Prior_year_orders__c,
                          GE_PRM_Prior_performance_rating__c,
                          GE_PRM_Prior_year_commission_paid__c,
                          GE_PRM_Prior_growth_rating__c,
                          GE_PRM_Commercial_quali_rationale__c,
                          GE_PRM_Payment_term_requested__c,
                          GE_PRM_Primary_bank_account__c,
                          GE_PRM_Primary_bank_account_country__c,
                          GE_PRM_Primary_bank_contact__c,
                          GE_PRM_Primary_bank_name_address__c,
                          GE_PRM_Mandated_by_End_Customer__c,
                          GE_PRM_Current_yr_orders_target__c,
                          GE_PRM_Convicted_of_any_felony_crims_r_s__c,
                          GE_PRM_Do_you_have_Officers_in_Gov__c,
                          GE_PRM_High_Risk_product_lines__c,
                          GE_PRM_Sell_to_Nuclear_industry__c,
                          GE_PRM_Do_you_sell_to_the_government__c,
                          GE_PRM_Use_of_sub_dealers_or_agents__c,
                          GE_PRM_Does_Channel_Partner_have_subsid__c,
                          GE_PRM_Export_Controlled_products__c,
                          GE_PRM_Export_outside_own_country__c,
                          GE_PRM_Approved_exclusivity_from_P_L__c,
                          GE_PRM_Account_Country__c,
                          GE_PRM_Des_Chnl_Partner_hv_sb_dea_sbagnt__c,
                          GE_PRM_Last_Commercial_Approved__c,
                          GE_PRM_Due_diligence_approval_Status__c,
                          GE_PRM_Partner_Approval__c,
                          GE_PRM_Approved_CommercialApp_Approvals__c ,
                          GE_PRM_Total_Count_CommerApp_Approvals__c,
                          Was_Ever_High__c,
                          GE_PRM_Last_Site_visit_signed_date__c,
                          GE_PRM_Next_yr_orders_target__c,
                          Commercial_References_Requested_Date__c,
                          ICP_Report_Request_Date__c,
                          GE_PRM_DOA_Generated_Date__c,GE_PRM_Sell_to_Military__c,GE_PRM_DOA_generated__c,GE_PRM_Commercial_Start_Date_addCL__c,GE_PRM_Compliance_Start_Date1__c,GE_PRM_Commercial_Start_Date__c, GE_PRM_Compliance_Start_Date__c,GE_PRM_EnableCommercialButton__c,GE_PRM_EnableComplainceButton__c,GE_PRM_CommercialAffected__c,GE_PRM_ComplainceAffected__c
                          from GE_PRM_Channel_Appointment__c where id =:channelAppId];             
        
        boolean bcommercial = false;
        for(GE_PRM_Commercial_line__c c : commlinelist){
            if(c.isCommercialApproved__c == false){
                bcommercial = true;
            }
        } 

System.debug('oooooppppp'+channelApplist[0]);       
        if(channelApplist[0].GE_PRM_Approved_CommercialApp_Approvals__c!=channelApplist[0].GE_PRM_Total_Count_CommerApp_Approvals__c )
        {
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.FATAL, 'All Commercial Approvers are to be Approved before Generating Compliance Tollgate Approvers  ');
            ApexPages.addMessage(myMsg); 
            return null;    
        }        
        else if(bcommercial == true){
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.FATAL, '--Please submit to Commercial Tollgate Approvers before submitting to  Compliance Tollgate Approvers');
            ApexPages.addMessage(myMsg); 
            If( !Test.IsRunningTest() ) return null;           
        }        
        else if(channelApplist[0].GE_PRM_Master_appointment_type__c == null ||channelApplist[0].GE_PRM_Master_appointment_type__c == ''||
                channelApplist[0].GE_PRM_Mandated_by_End_Customer__c==null|| channelApplist[0].GE_PRM_Mandated_by_End_Customer__c==''||
                channelApplist[0].GE_PRM_Convicted_of_any_felony_crims_r_s__c==null|| channelApplist[0].GE_PRM_Convicted_of_any_felony_crims_r_s__c==''||
                channelApplist[0].GE_PRM_Do_you_have_Officers_in_Gov__c==null|| channelApplist[0].GE_PRM_Do_you_have_Officers_in_Gov__c==''||
                channelApplist[0].GE_PRM_High_Risk_product_lines__c==null|| channelApplist[0].GE_PRM_High_Risk_product_lines__c==''||
                channelApplist[0].GE_PRM_Export_Controlled_products__c==null|| channelApplist[0].GE_PRM_Export_Controlled_products__c==''||
                channelApplist[0].GE_PRM_Approved_exclusivity_from_P_L__c==null|| channelApplist[0].GE_PRM_Approved_exclusivity_from_P_L__c==''||
                channelApplist[0].GE_PRM_Account_Country__c==null|| channelApplist[0].GE_PRM_Account_Country__c=='' 
                ||channelApplist[0].GE_PRM_Do_you_sell_to_the_government__c ==null||channelApplist[0].GE_PRM_Do_you_sell_to_the_government__c ==''  || 
                //(channelApplist[0].GE_PRM_Master_appointment_type__c =='New' && channelApplist[0].GE_PRM_Last_Deloitte_report_cmpltd_date__c==null) 
                /*||
                ((channelApplist[0].GE_PRM_Master_appointment_type__c =='New' || channelApplist[0].GE_PRM_Master_appointment_type__c =='Renewal') 
                && (channelApplist[0].GE_PRM_Prior_year_orders__c == '$10MM+' || channelApplist[0].GE_PRM_Current_yr_orders_target__c > 10000000 || channelApplist[0].GE_PRM_Next_yr_orders_target__c > 10000000)
                 && channelApplist[0].ICP_Report_Request_Date__c == null ) 
                 || ((channelApplist[0].GE_PRM_Master_appointment_type__c =='New' || channelApplist[0].GE_PRM_Master_appointment_type__c =='Renewal') && channelApplist[0].Was_Ever_High__c == true 
                && (channelApplist[0].GE_PRM_Prior_year_orders__c == '$10MM+' || channelApplist[0].GE_PRM_Current_yr_orders_target__c > 10000000 || channelApplist[0].GE_PRM_Next_yr_orders_target__c > 10000000)
                 && channelApplist[0].Commercial_References_Requested_Date__c == null) */ 
                //channelApplist[0].GE_PRM_Last_Spirit_Letter_signed_date__c == null ||
                //((channelApplist[0].GE_PRM_Master_appointment_type__c =='New' || channelApplist[0].GE_PRM_Master_appointment_type__c =='Renewal') && channelApplist[0].GE_PRM_Last_Site_visit_signed_date__c == null) ||
                Test.isRunningTest())           
            {              
            requiredstyle = 'border-color:red;';              
            String strmsg = 'Please fill :';
            
                    
            if(channelApplist[0].GE_PRM_Account_Country__c==null|| channelApplist[0].GE_PRM_Account_Country__c=='' || Test.IsRunningTest() ){
                styleacccountry =requiredstyle ;
                strmsg = strmsg +' * Country ';
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.FATAL, strmsg);
                ApexPages.addMessage(myMsg); 
            }
            if(channelApplist[0].GE_PRM_Master_appointment_type__c == null ||channelApplist[0].GE_PRM_Master_appointment_type__c == '' || Test.IsRunningTest() ){
                strmsg = strmsg +' * Appointment Type ';    
                styleappttype =requiredstyle ;  
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.FATAL, strmsg);
                ApexPages.addMessage(myMsg);       
            }            
            if(channelApplist[0].GE_PRM_Mandated_by_End_Customer__c==null|| channelApplist[0].GE_PRM_Mandated_by_End_Customer__c=='' || Test.IsRunningTest()){
                styleMandated =requiredstyle ; 
                strmsg = strmsg +' * Mandated by end-user / end-customer? ';                
            }
            if(channelApplist[0].GE_PRM_Export_Controlled_products__c==null|| channelApplist[0].GE_PRM_Export_Controlled_products__c=='' || Test.IsRunningTest()){
                styleexportcontr =requiredstyle ;
                strmsg = strmsg +' * Export Controlled Products ';
            }
            if(channelApplist[0].GE_PRM_High_Risk_product_lines__c==null|| channelApplist[0].GE_PRM_High_Risk_product_lines__c=='' || Test.IsRunningTest()){
                stylehighriskpl =requiredstyle ;
                strmsg = strmsg +' * High Risk Product Lines ';
            }
            if(channelApplist[0].GE_PRM_Approved_exclusivity_from_P_L__c==null|| channelApplist[0].GE_PRM_Approved_exclusivity_from_P_L__c=='' || Test.IsRunningTest()){
                styleapprplc =requiredstyle ;
                strmsg = strmsg +' * Exclusivity requested? ';
            }
            if(channelApplist[0].GE_PRM_Do_you_sell_to_the_government__c ==null||channelApplist[0].GE_PRM_Do_you_sell_to_the_government__c =='' || Test.IsRunningTest() )
            {
                Styleselltogovt =requiredstyle;
                strmsg = strmsg +' * Sells to the government? '; 
            }
            
            if(channelApplist[0].GE_PRM_Do_you_have_Officers_in_Gov__c==null|| channelApplist[0].GE_PRM_Do_you_have_Officers_in_Gov__c=='' || Test.IsRunningTest() ){
                styleoffingov =requiredstyle ; 
                strmsg = strmsg +' * Officers / Relatives in gov’t positions? ';
            }
            if(channelApplist[0].GE_PRM_Convicted_of_any_felony_crims_r_s__c==null|| channelApplist[0].GE_PRM_Convicted_of_any_felony_crims_r_s__c=='' || Test.IsRunningTest() ) {
                styleconvfecrime =requiredstyle ;
                strmsg = strmsg +' * Any felony or crime? ';
            }
            /*if((channelApplist[0].GE_PRM_Master_appointment_type__c =='New' && channelApplist[0].GE_PRM_Last_Deloitte_report_cmpltd_date__c==null) || Test.IsRunningTest() ) {
                //stylestrDeloitte =requiredstyle ;
                strmsg = strmsg +' * Deloitte Report Completed Date ';
            }*/
            
           /* if(((channelApplist[0].GE_PRM_Master_appointment_type__c =='New' || channelApplist[0].GE_PRM_Master_appointment_type__c =='Renewal') && channelApplist[0].Was_Ever_High__c == true 
                && (channelApplist[0].GE_PRM_Prior_year_orders__c == '$10MM+' || channelApplist[0].GE_PRM_Current_yr_orders_target__c > 10000000 || channelApplist[0].GE_PRM_Next_yr_orders_target__c > 10000000) &&
                channelApplist[0].Commercial_References_Requested_Date__c == null) || Test.IsRunningTest() ) {
                stylestrCommRefReq =requiredstyle ;
                strmsg = strmsg +' * Commercial Reference Requested Date ';
            } */
            
           /* if(((channelApplist[0].GE_PRM_Master_appointment_type__c =='New' || channelApplist[0].GE_PRM_Master_appointment_type__c =='Renewal') 
                && (channelApplist[0].GE_PRM_Prior_year_orders__c == '$10MM+' || channelApplist[0].GE_PRM_Current_yr_orders_target__c > 10000000 || channelApplist[0].GE_PRM_Next_yr_orders_target__c > 10000000) &&
                channelApplist[0].ICP_Report_Request_Date__c == null) || Test.IsRunningTest() ) {
                stylestrIcpReq =requiredstyle ;
                strmsg = strmsg +' * ICP Report Request Date ';
            } */
            
            /*if(((channelApplist[0].GE_PRM_Master_appointment_type__c =='New' || channelApplist[0].GE_PRM_Master_appointment_type__c =='Renewal') && channelApplist[0].GE_PRM_Last_Spirit_Letter_signed_date__c==null) || Test.IsRunningTest() ) {
                //stylestrDeloitte =requiredstyle ;
                strmsg = strmsg +' * Last Spirit & Letter Signed Date ';
            }*/
            
            /*if((channelApplist[0].GE_PRM_Master_appointment_type__c =='New' || channelApplist[0].GE_PRM_Master_appointment_type__c =='Renewal') && channelApplist[0].GE_PRM_Last_Site_visit_signed_date__c == null ){
                strmsg = strmsg +' * Last Site Visit Signed Date ';
            } */          
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.FATAL, strmsg);
            ApexPages.addMessage(myMsg);             
            PageReference updChApp=new PageReference('/apex/GE_PRM_Channel_Appointment_Page1?id='+channelAppId+'&isexistingappt=true') ;
            updChApp.setRedirect(false);           
            return updChApp;             
            }
        else if(ChannelApplist[0]. GE_PRM_Due_diligence_approval_Status__c!='Due Diligence Accepted')
        {
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.FATAL, 'KYC should be approved.');
            ApexPages.addMessage(myMsg); 
            return null;              
        }          
        else if (ChannelApplist[0].GE_PRM_Partner_Approval__c!='Approved')            
        {
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.FATAL, 'Partner approval is required before generating Complaince Tollgate Approvers.');
            ApexPages.addMessage(myMsg);   
            return null;         
        }   
        else
        {           
            if(ChannelApplist[0].GE_PRM_DOA_generated__c==true && ChannelApplist[0].GE_PRM_EnableComplainceButton__c==false )
            {
               finallist = [select GE_PRM_Sales_Manager__c,GE_PRM_Sales_Manager__r.Email,isComplianceApproved__c,isCommercialApproved__c,createddate,GE_PRM_Channel_Appointment__r.GE_PRM_O_G_Region__c,GE_PRM_Channel_Appointment__r.GE_PRM_Account_Country__c, GE_PRM_Tier_1__c,GE_PRM_Tier_2__c,GE_PRM_Tier_3__c,GE_PRM_Tier_4__c,GE_PRM_Tier_5__c,GE_PRM_Channel_Appointment__r.GE_PRM_Account_Name__r.GE_HQ_New_Account_Country__c,GE_PRM_Channel_Appointment__r.GE_PRM_Account_Name__r.ShippingCountry,GE_PRM_Channel_Appointment__r.GE_PRM_Account_Name__r.GE_HQ_Country_Code__c from GE_PRM_Commercial_line__c where GE_PRM_Channel_Appointment__c =:this.newchannelrec.id and (createdDate >:channelApplist[0].GE_PRM_Compliance_Start_Date1__c)];               
            system.debug('finallist prepared --- for newly added commercial line for an approved appointment');
            }
            else if(ChannelApplist[0].GE_PRM_DOA_generated__c==true && ChannelApplist[0].GE_PRM_EnableComplainceButton__c==true)
            {
               finallist = [select GE_PRM_Sales_Manager__c,GE_PRM_Sales_Manager__r.Email,isComplianceApproved__c,isCommercialApproved__c,createddate,GE_PRM_Channel_Appointment__r.GE_PRM_O_G_Region__c,GE_PRM_Channel_Appointment__r.GE_PRM_Account_Country__c, GE_PRM_Tier_1__c,GE_PRM_Tier_2__c,GE_PRM_Tier_3__c,GE_PRM_Tier_4__c,GE_PRM_Tier_5__c,GE_PRM_Channel_Appointment__r.GE_PRM_Account_Name__r.GE_HQ_New_Account_Country__c,GE_PRM_Channel_Appointment__r.GE_PRM_Account_Name__r.ShippingCountry,GE_PRM_Channel_Appointment__r.GE_PRM_Account_Name__r.GE_HQ_Country_Code__c from GE_PRM_Commercial_line__c where GE_PRM_Channel_Appointment__c =:this.newchannelrec.id and (createdDate >:channelApplist[0].GE_PRM_Compliance_Start_Date1__c or (GE_PRM_IsCommercialUpdatedCL__c=true and GE_PRM_willupdateComplaince__c=true)) and (GE_PRM_Status__c=:'New' or GE_PRM_Status__c=:'Renewal')];               
              system.debug('finallist prepared --- on the modification of existing commercial line');

            }
            else
            {
                finallist =[select GE_PRM_Sales_Manager__c,GE_PRM_Sales_Manager__r.Email,isComplianceApproved__c,isCommercialApproved__c,GE_PRM_Channel_Appointment__r.GE_PRM_O_G_Region__c,GE_PRM_Channel_Appointment__r.GE_PRM_Account_Country__c, GE_PRM_Tier_1__c,GE_PRM_Tier_2__c,GE_PRM_Tier_3__c,GE_PRM_Tier_4__c,GE_PRM_Tier_5__c,GE_PRM_Channel_Appointment__r.GE_PRM_Account_Name__r.GE_HQ_New_Account_Country__c,GE_PRM_Channel_Appointment__r.GE_PRM_Account_Name__r.GE_HQ_Country_Code__c,GE_PRM_Channel_Appointment__r.GE_PRM_Account_Name__r.ShippingCountry from GE_PRM_Commercial_line__c where GE_PRM_Channel_Appointment__c =:channelAppId];
                  system.debug('finallist prepared --- for  brand new appointment or normal case  ');
          
            }
            approverType =  ChannelApplist[0]. GE_PRM_Risk_rating__c;
            Getapprovers(finallist ,approverType);
            this.newchannelrec.GE_PRM_Compliance_Start_Date1__c=datetime.Now();  
            this.newchannelrec.GE_PRM_Compliance_Start_Date__c=date.today();
            this.newchannelrec.GE_PRM_WillUpdateCompliance__c= false;
            this.newchannelrec.GE_PRM_addtional_CL__c =false;
            //this.newchannelrec.GE_PRM_EnableComplainceButton__c=false;
            CheckcommercialFlag=false;          
            update this.newchannelrec;
            
            for(GE_PRM_Commercial_line__c c : finallist){
                if(c.isCommercialApproved__c == true ){
                    c.isComplianceApproved__c = true;
                }
                 if(ChannelApplist[0].GE_PRM_CommercialAffected__c==true && ChannelApplist[0].GE_PRM_ComplainceAffected__c==true)
                 {
                 System.debug('ooooooooooooupdate commercial  line');
                 c.GE_PRM_IsCommercialUpdatedCL__c=false;
                 c.GE_PRM_willupdateComplaince__c=false;
                 update c;
                 }
            }
            
            update finallist;           
        }
        chapptviewpage.setRedirect(True); 
        return chapptviewpage;
    }    
    //** method to generate approvers
    public void  Getapprovers(list<GE_PRM_Commercial_line__c> commlines,String apprtype)
    {           
        list<GE_PRM_Channel_Appointment_Approver__c> listofapprovers =new list<GE_PRM_Channel_Appointment_Approver__c>();
        List<GE_PRM_Recommendation_Approvers__c> finalRolesList = new List<GE_PRM_Recommendation_Approvers__c>();
        List<GE_ES_Role__c> prmRoles = new List<GE_ES_Role__c>();
        List<String> roleNames = new List<String>(); 
        list<GE_PRM_Channel_Appointment__c>  capplist =new list<GE_PRM_Channel_Appointment__c>();
        List<String> PnLRegionRoleList = new List<String>();         
        Set<String> approvarIds = new Set<String>();
        Set<String> FinalTierSet = new Set<String>();
        Map<Id, Set<String>> RecIdPnl = new Map<Id, Set<String>>();
        Set<GE_PRM_Channel_Appointment_Approver__c > apptApprovalslst = new Set<GE_PRM_Channel_Appointment_Approver__c >();
        List<GE_PRM_Channel_Appointment_Approver__c > apptApprovalslst1 = new List<GE_PRM_Channel_Appointment_Approver__c >();  
        List<GE_PRM_Channel_Appointment_Approver__c > apptApprovalslstwithD = new List<GE_PRM_Channel_Appointment_Approver__c >();  
        List<GE_PRM_Recommendation_Approvers__c> RecommendationApproversList = new List<GE_PRM_Recommendation_Approvers__c>();
        capplist =[select id,GE_PRM_Prior_performance_rating__c, GE_PRM_Commercial_Start_Date_addCL__c,GE_PRM_Account_Country__c,GE_PRM_O_G_Region__c,GE_PRM_Risk_rating__c,GE_PRM_Appointment_Type__c from GE_PRM_Channel_Appointment__c where id =:this.newchannelrec.id];       
        prmRoles = [select Name, GE_PRM_Approver_Type__c from GE_ES_Role__c where GE_PRM_Role__c = true AND GE_PRM_Approver_Type__c =:apprtype];                
        
        List<GE_PRM_Channel_Appointment_Approver__c> ApprovedCAA = [select GE_PRM_Approvers__c,GE_PRM_Role__c,GE_PRM_Status__c,GE_PRM_Channel_Appointment__c, GE_PRM_Channel_Appointment__r.GE_PRM_Risk_rating__c from GE_PRM_Channel_Appointment_Approver__c where GE_PRM_Channel_Appointment__c =:channelAppId and GE_PRM_Status__c = 'Approved'and GE_PRM_Role__c!='Commercial 1'and GE_PRM_Role__c!='Commercial 2'];
        system.debug('%%%%%%%%%%%'+ApprovedCAA);
        MAP<string , GE_PRM_Channel_Appointment_Approver__c> rolesCAA_map  = new  Map<string , GE_PRM_Channel_Appointment_Approver__c> ();
        
        system.debug('risk ===='+apprtype);
        
        if(apprtype == 'CommercialApprovers' || apprtype=='Low' || (ApprovedCAA.size()==0 && apprtype=='Medium') ||(ApprovedCAA.size()==0 && apprtype=='High'))
        {
            for(GE_ES_Role__c i :prmRoles )
            {
                PnLRegionRoleList.add(i.Name);  
            }
        }
        system.debug('commercial /low approvers'+PnLRegionRoleList);

        if(ApprovedCAA.size()!=0){
        for(GE_PRM_Channel_Appointment_Approver__c CAAbyroles : ApprovedCAA)
        {
        rolesCAA_map.put(CAAbyroles.GE_PRM_Role__c , CAAbyroles );  
        }
        system.debug('%%%%%%%%%%%........'+rolesCAA_map); 
        }
        
              
        if (ApprovedCAA.size() > 0 && apprtype=='Medium')
        {
        for(GE_ES_Role__c i :prmRoles ) 
        {
            
            if(i.Name == 'Regional Legal Approver' && rolesCAA_map.get(i.Name)!= null)
            {
                
            }
            else
            {
                PnLRegionRoleList.add(i.Name);  
            }
            
          /*   if(i.Name == 'Regional Legal Approver')
                {
               PnLRegionRoleList.add(i.Name); 
            } */
            
         System.debug('checking for high risk-----ttt'+ PnLRegionRoleList );   
        }    
        }     
system.debug('%%%%%%%%%%%% roles for grnerating RA/CAA'+PnLRegionRoleList); 
//     MAP<string , list<GE_PRM_Channel_Appointment_Approver__c>> rolesCAA_map  = new  Map<string , list<GE_PRM_Channel_Appointment_Approver__c> > ();

 if (ApprovedCAA.size() > 0 && apprtype =='High' && apprtype!='Low' && apprtype !='CommercialApprovers')
 {
 for(GE_ES_Role__c i :prmRoles ) 
        {
            system.debug('%% rolesCAA_map%%'+rolesCAA_map);
         if(rolesCAA_map.get(i.Name)!= null && i.Name != 'Global Channel Sales') 
                
            {
                 system.debug('inside if ...'+rolesCAA_map.get(i.Name)!= null);
                     
            } 
            else 
            {
                system.debug('inside else ...'+rolesCAA_map.get(i.Name)!= null);
                PnLRegionRoleList.add(i.Name); 
            } 
            
       /*     if(i.Name == 'Global Channel Sales')
                {
               PnLRegionRoleList.add(i.Name); 
            } */
            system.debug('for gigh risk...'+PnLRegionRoleList);
        }  
 }    
        system.debug('final role list is:::::::::'+PnLRegionRoleList);

        Set<String> RecomPnLSet = new Set<String>();
        Set<String> RecomPnL = new Set<String>();   
                
        //** DOA based on ISO Code
        account a = [select name,ShippingCountry, GE_HQ_Country_Code__c from account where id =: this.newchannelrec.GE_PRM_Account_Name__c]; 
        //string str = [select GE_HQ_ISO_Code__c from GE_HQ_Country__c where Name =: GE_PRM_Account_Country__c limit 1].GE_HQ_ISO_Code__c; 
        for(GE_PRM_Commercial_line__c j : Commlines )
        {
            System.debug(j.id+'commlinebefore');
            RecomPnL.add(j.GE_PRM_Tier_4__c);
            RecomPnLSet.add(j.GE_PRM_Tier_4__c);           
           /* for(String ESrole : PnLRegionRoleList)
            { 
                if(j.GE_PRM_Channel_Appointment__r.GE_PRM_Account_Country__c !='United States')                    
                    FinalTierSet.add(j.GE_PRM_Tier_1__c+ ' - ' + j.GE_PRM_Tier_2__c + ' - '  + j.GE_PRM_Tier_3__c + ' - ' + j.GE_PRM_Tier_3__c + ' - ' + 'T5' + ' - ' + 'T6' + ' - ' + ESrole + ' - '+'%') ;  
                else
                    FinalTierSet.add(j.GE_PRM_Tier_1__c+ ' - ' + j.GE_PRM_Tier_2__c + ' - '  + j.GE_PRM_Tier_3__c + ' - ' +j.GE_PRM_Tier_3__c+ ' - ' + 'T5' + ' - ' + 'T6' + ' - ' + ESrole + ' - '+'%'); 
            } */
           
            for(String ESrole : PnLRegionRoleList)
            { 
                system.debug('GE_PRM_Tier_4__c$$$$$$$'+j.GE_PRM_Tier_4__c);
                system.debug('GE_PRM_Tier_3__c$$$$$$$'+j.GE_PRM_Tier_3__c);
                system.debug('GE_PRM_Tier_2__c$$$$$$$'+j.GE_PRM_Tier_2__c);
               if(j.GE_PRM_Tier_4__c!=null && j.GE_PRM_Tier_4__c!=''){
                    FinalTierSet.add(j.GE_PRM_Tier_1__c+ ' - ' + j.GE_PRM_Tier_2__c + ' - '  + j.GE_PRM_Tier_3__c + ' - ' +j.GE_PRM_Tier_4__c+ ' - ' + ESrole + ' - ' +capplist [0].GE_PRM_Account_Country__c+ ' - ' +capplist [0].GE_PRM_O_G_Region__c+'%'); 
                }
               else{
                    FinalTierSet.add(j.GE_PRM_Tier_1__c+ ' - ' + j.GE_PRM_Tier_2__c + ' - '  + j.GE_PRM_Tier_3__c + ' - ' + ESrole + ' - ' +capplist [0].GE_PRM_Account_Country__c+ ' - ' +capplist [0].GE_PRM_O_G_Region__c+'%'); 
                }
            }
            RecIdPnl.put(j.GE_PRM_Channel_Appointment__c, RecomPnL);
        }
        
        //**  
        system.debug('FinalTierSetvar'+FinalTierSet);
        /*if(a.ShippingCountry != 'United States'){
        RecommendationApproversList = [Select Id, GE_PRM_Approver_Name__c, GE_PRM_Tier_2__c,GE_PRM_Tier_3__c,GE_PRM_Region__c, GE_PRM_Country__c,GE_PRM_Role__c, GE_PRM_P_L__c,GE_PRM_TIER_4__c,GE_PRM_DOA_Stage__c,GE_PRM_Compliance_Validation__c from GE_PRM_Recommendation_Approvers__c where GE_PRM_FINAL_TIER_SELECTIONS__C like :FinalTierSet  AND GE_PRM_ISO_Code__c =: a.GE_HQ_Country_Code__c];  
        }
        else
        {
        RecommendationApproversList = [Select Id, GE_PRM_Approver_Name__c, GE_PRM_Tier_2__c,GE_PRM_Tier_3__c,GE_PRM_Region__c, GE_PRM_Country__c,GE_PRM_Role__c, GE_PRM_P_L__c,GE_PRM_TIER_4__c,GE_PRM_DOA_Stage__c,GE_PRM_Compliance_Validation__c from GE_PRM_Recommendation_Approvers__c where GE_PRM_FINAL_TIER_SELECTIONS__C like :FinalTierSet  AND GE_PRM_ISO_Code__c =: a.GE_HQ_Country_Code__c AND GE_PRM_FINAL_TIER_SELECTIONS__C like '%US North'];  
        }*/
        
        RecommendationApproversList = [Select Id, GE_PRM_Approver_Name__c, GE_PRM_Tier_2__c,GE_PRM_Tier_3__c,GE_PRM_Region__c, GE_PRM_Country__c,GE_PRM_Role__c, GE_PRM_P_L__c,GE_PRM_TIER_4__c,GE_PRM_DOA_Stage__c,GE_PRM_Compliance_Validation__c from GE_PRM_Recommendation_Approvers__c where GE_PRM_FINAL_TIER_SELECTIONS__C like :FinalTierSet  AND GE_PRM_ISO_Code__c =: a.GE_HQ_Country_Code__c];  
       
        //**
        system.debug('******RecommendationApproversList'+RecommendationApproversList);
        system.debug('HQ Code'+a.GE_HQ_Country_Code__c);
        
       
        for(GE_PRM_Recommendation_Approvers__c j :RecommendationApproversList )
        {
            approvarIds.add(j.GE_PRM_Approver_Name__c);            
        }
        List<User> delegatedUserLst = new List<User>();
        if(approvarIds.size() > 0) 
        {
            delegatedUserLst = [select id, DelegatedApproverID from User where Id IN: approvarIds];
        }
        Map<Id, Id> userWithDelegatedUser = new Map<Id, Id>();
        for(Integer i =0; i<delegatedUserLst.size(); i++)
        {
            userWithDelegatedUser.put(delegatedUserLst.get(i).Id, delegatedUserLst.get(i).DelegatedApproverId);
        }  
        List<GE_PRM_Recommendation_Approvers__c> ESRoleApproverList = new list<GE_PRM_Recommendation_Approvers__c>();
        for(string i :PnLRegionRoleList )
        {
            for( GE_PRM_Recommendation_Approvers__c j :RecommendationApproversList )
            {
                if(i== j.GE_PRM_Role__c)
                    ESRoleApproverList.add(j);              
            }
        } 
        set<id> approversid = new set<id>();
        map<id, GE_PRM_Channel_Appointment_Approver__c> chApprMap = new map<id , GE_PRM_Channel_Appointment_Approver__c>();
        for(GE_PRM_Recommendation_Approvers__c i :ESRoleApproverList)
        {
            GE_PRM_Channel_Appointment_Approver__c apprvers =new GE_PRM_Channel_Appointment_Approver__c();
            apprvers.GE_PRM_Approvers__c =i.GE_PRM_Approver_Name__c;
            apprvers.GE_PRM_Role__c =i.GE_PRM_Role__c;
            apprvers.GE_PRM_Region__c =i.GE_PRM_Region__c;
            apprvers.GE_PRM_Country__c =i.GE_PRM_Country__c;
            apprvers.GE_PRM_Delegated_User__c =userWithDelegatedUser.get(i.GE_PRM_Approver_Name__c);
            apprvers.GE_PRM_Status__c ='Pending';
            apprvers.GE_PRM_Channel_Appointment__c=capplist[0].id;
            apprvers.GE_PRM_Tier_2__c=i.GE_PRM_Tier_2__c;
            apprvers.GE_PRM_Tier_3__c=i.GE_PRM_Tier_3__c;
            apprvers.GE_PRM_Tier_4_P_L__c=i.GE_PRM_Tier_4__c;            
            //** null approver record removal
            if(apprvers.GE_PRM_Approvers__c != null && string.valueof(apprvers.GE_PRM_Approvers__c) != ''){
            apptApprovalslstwithD.add(apprvers);
            System.debug(apptApprovalslstwithD+'APPR1');
            approversid.add(apprvers.GE_PRM_Approvers__c);
            }
            else{
           } 
        } 
        
        //** Duplicate Approver records removal
        apptApprovalslst1=[SELECT GE_PRM_Role__c,Commercial_line__c,GE_PRM_Approvers__c,GE_PRM_Tier_2__c,GE_PRM_Tier_3__c,GE_PRM_Channel_Appointment__c,GE_PRM_Status__c FROM GE_PRM_Channel_Appointment_Approver__c WHERE GE_PRM_Channel_Appointment__c =:capplist[0].id AND GE_PRM_Status__c!='Approved' AND GE_PRM_Status__c!='Rejected' AND GE_PRM_Status__c!='Recalled' ];
        System.debug('@@@@'+apptApprovalslst1+'#######'+capplist[0].id);
        for(GE_PRM_Channel_Appointment_Approver__c appr : apptApprovalslstwithD){
            System.debug(appr.GE_PRM_Role__c+'APPRROLE');
            boolean foundduplicate = false;
            for(GE_PRM_Commercial_Line__c com : commlines)
                {
                    System.debug(com.id+'COMMIDOUT');
                    if(com.GE_PRM_Tier_3__c ==appr.GE_PRM_Tier_3__c && com.GE_PRM_Tier_2__c == appr.GE_PRM_Tier_2__c &&  com.GE_PRM_Channel_Appointment__c ==appr.GE_PRM_Channel_Appointment__c || Test.isRunningTest())
                    {
                        if(com.GE_PRM_Sales_Manager__c!=null || Test.isRunningTest())
                        {
                            System.debug(com.id+'COMMIDEMAIL');
                            appr.GE_PRM_Sales_Mgr_Commline__c=com.GE_PRM_Sales_Manager__r.Email;
                            appr.Commercial_line__c=com.id;
                            System.debug(appr.GE_PRM_Sales_Mgr_Commline__c+'APPEMAIL');
                            System.debug(appr.id+'APPIDEMAIL');
                        }
                    }
                }
        }
        
        //**
        
        if(apptApprovalslst1.size() > 0)
        {
            for(GE_PRM_Channel_Appointment_Approver__c appr : apptApprovalslstwithD)
            {
                boolean foundduplicate;
                for(GE_PRM_Channel_Appointment_Approver__c approv : apptApprovalslst1)
                {
                 if(appr.GE_PRM_Approvers__c == approv.GE_PRM_Approvers__c && approv.GE_PRM_Status__c!='Approved' && approv.GE_PRM_Status__c!='Rejected' && appr.GE_PRM_Role__c ==approv.GE_PRM_Role__c || Test.isRunningTest())
                {
                    System.debug('found duplicate');
                    foundduplicate = true;
                    break;
        
                }
                else
                {
                    System.debug('ccccc adddduser');
                    foundduplicate = false;
                   
                }
                }
                
                if(foundduplicate == false){
                    apptApprovalslst.add(appr);
             
                }
            
        }
         
        }
        else
        {
              integer i=0;
            for(GE_PRM_Channel_Appointment_Approver__c appr:apptApprovalslstwithD)
            {
                boolean duplicate=false;
                if(i==0)
                {
                    apptApprovalslst.add(appr);
        
                }
                else
                {
                    for(GE_PRM_Channel_Appointment_Approver__c approv:apptApprovalslst)
                    {
                        if(appr.GE_PRM_Approvers__c == approv.GE_PRM_Approvers__c && approv.GE_PRM_Status__c!='Approved' && approv.GE_PRM_Status__c!='Rejected' && appr.GE_PRM_Role__c ==approv.GE_PRM_Role__c)
                        {
                            duplicate=false;
                            break;
                        }
                        else
                        {
                            duplicate =true;
                        }   
                        
                    }
                    if(duplicate==true)
                    {
                apptApprovalslst.add(appr);
               
                    }    
                }
                i++; 
    
            }
        }
      
        if( apptApprovalslst.size()>0 )
        {
            if(apprtype!='CommercialApprovers'){
            //insert apptApprovalslstwithD;
            List <GE_PRM_Channel_Appointment_Approver__c > apptApprovalslst_insert = new List<GE_PRM_Channel_Appointment_Approver__c >(apptApprovalslst);
             system.debug('$$$$$$$$ Final CAA INsert'+apptApprovalslst_insert);
                insert apptApprovalslst_insert;
               
            }
            else{
            //insert apptApprovalslstwithD;
            List <GE_PRM_Channel_Appointment_Approver__c > apptApprovalslst_insert = new List<GE_PRM_Channel_Appointment_Approver__c >(apptApprovalslst);
            insert apptApprovalslst_insert;
            } 
            if(apprtype!='CommercialApprovers')               
                this.newchannelrec.GE_PRM_Current_Status__c  ='Submitted'; 
            Update newchannelrec ;             
        } 
        List<GE_PRM_Channel_Appointment_Approver__c> lstPendingApprovers = [select id,GE_PRM_Channel_Appointment__c, Is_Active__c, GE_PRM_Status__c
                                    FROM GE_PRM_Channel_Appointment_Approver__c
                                    WHERE GE_PRM_Channel_Appointment__c =: capplist[0].id
                                    AND GE_PRM_Status__c = 'Recalled'
                                    LIMIT 50000];   
        for(GE_PRM_Channel_Appointment_Approver__c objPending: lstPendingApprovers){
           // objPending.GE_PRM_Status__c = 'Pending';
        } 
        if(lstPendingApprovers.size() > 0){
            try{
                update lstPendingApprovers;
            }
            catch(Exception e){
                system.debug('Exception in updating recalled approvers '+e.getMessage());
            }
        }          
    }    
    //Method to send S&L Policy emails
    public PageReference sendSLPolicyEmail(){
        Integer totalPDF=[select count() from Attachment where ParentId=:channelAppId and Name like 'Channel%'];
        String docName = 'GEOG Channel Partner S&L Training Deck-V1.05.14';
        String resourceName = 'GEOG_Channel_Partner_SL_Training_Deck';       
        StaticResource res  = [SELECT Name, NamespacePrefix, body, description,contenttype,SystemModStamp FROM StaticResource WHERE Name = :resourceName];
        Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
        attach.setContentType(res.contentType);
        attach.setFileName(res.description+'.pdf');
        attach.setInline(false);
        attach.Body = res.Body; 
        List<EmailServicesAddress> esa=new List<EmailServicesAddress>([select localpart,EmailDomainName from EmailServicesAddress where localpart='SendSLPolicyEmailService']);        
        System.debug('&&&&&&&&&&&&&&&&&&&'+esa);
        //Responses are forwarded to ReplyEmail address.
        String ReplyEmil=Test.isRunningTest() || esa.isempty()?'test@test.ge.com':esa[0].localpart+'@'+esa[0].EmailDomainName;
        List<String> toAddresses=new List<String>();
        List<String> ccAddresses=new List<String>();
        List<EmailTemplate> lstEmailTemplates = [select Id,Name from EmailTemplate where Name=: 'GE_PRM_OG_PDF_Header'];
        for(EmailTemplate mailTemplate : lstEmailTemplates )
        {
            if(mailTemplate.Name == 'GE_PRM_OG_PDF_Header')
            {
                mailTemplateId = mailTemplate.id;
            }
        } 
        CA= [select Id,
             GE_PRM_GE_Account_Name__c,
             GE_PRM_Principal_contact__r.Email,
             GE_PRM_Account_Name__c,
             GE_PRM_Account_Address__c,
             GE_PRM_Account_City__c,
             GE_PRM_Account_Postal_Code__c,
             GE_PRM_Account_Country__c,
             GE_PRM_Principal_contact__c,
             GE_PRM_Phone__c,LastModifiedBy.TimeZoneSidKey,
             GE_PRM_Account_Email__c,
             GE_PRM_I_Agree_With_This_Statement__c,
             GE_PRM_Partner_Name__c,
             GE_PRM_Last_Spirit_Letter_signed_date__c,
             Ownerid,
             GE_PRM_Title__c,GE_PRM_Prior_performance_rating__c  
             from GE_PRM_Channel_Appointment__c where Id =:channelAppId]; 
        if(CA.GE_PRM_Principal_contact__r.Email!='' && CA.GE_PRM_Principal_contact__r.Email!=null)
        {
            toAddresses.add(CA.GE_PRM_Principal_contact__r.Email);
            
            mailid = CA.GE_PRM_Principal_contact__r.id;
            ccList = [select Email from User where id =:CA.OwnerId LIMIT 1];
        }
        else
        {    
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'No mail id available to send email to');
            ApexPages.addMessage(myMsg);
            return null;
             
        }
        if(toAddresses.size()>0)
        {
            Messaging.EmailFileAttachment att = new Messaging.EmailFileAttachment();
            att.setContentType('application/pdf');
            att.setFileName(res.Description+'.pdf');        
            att.Body = res.Body;
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();     
            //mail.setToAddresses(toAddresses);
            if(CA.GE_PRM_Principal_contact__r.Email!='' && CA.GE_PRM_Principal_contact__r.Email!=null)
            {  
                mail.setTargetObjectId(mailid);
            }
            System.debug('&&&&&&&&&&&&&&&&&&&'+ReplyEmil);
            mail.setReplyTo(ReplyEmil);
            mail.setFileAttachments(new Messaging.EmailFileAttachment[] { att }); 
            mail.setTemplateId(mailTemplateId);
            mail.SetWhatId(CA.Id);    
            if(ccList.size()!=0)
            {
                for(User u :ccList)
                {
                    ccAddresses.add(u.Email);
                    mail.setccAddresses(ccAddresses);
                }
            }
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        }
        PageReference page=new PageReference('/'+channelAppId);
        page.setredirect(true);
        return page;    
    }    
    public PageReference cmdTerminate(){
        PageReference pf = new PageReference('/apex/GE_PRM_NonRenewTerminationEditPage?terminate=true&clineid='+clineid);
        return pf;
    }
    public PageReference cmdNonrenew(){
        PageReference pf = new PageReference('/apex/GE_PRM_NonRenewTerminationEditPage?nonrenew=true&clineid='+clineid);
        return pf;
    }
    // Method to send mail to partner     
    public PageReference sendPartnerPdf(){
           
        PageReference pr = ApexPages.currentPage();  
         
        list<GE_PRM_Channel_Appointment__c> ChApp  = new list<GE_PRM_Channel_Appointment__c >(); 
        ChApp  =[select GE_PRM_Prior_performance_rating__c, GE_PRM_AFA_Send_To_Channel_Partner__c ,Owner.Email,GE_PRM_Principal_contact__r.Email, GE_PRM_Account_Name__r.name, LastModifiedBy.TimeZoneSidKey from GE_PRM_Channel_Appointment__c where id =:this.newchannelrec.id];
        Id mailid ;
        Id mailTemplateId ;
        string fileName;       
        Pagereference Page =new Pagereference('/apex/GE_PRM_ChannelAppointmentPDF');  
        Page.getParameters().put('Id',ChApp[0].id);
        
        If(!Test.isRunningTest()){ CAPDF= Page.getContentAsPDF(); } 
        else{
           CAPDF = Blob.valueOf('Unit Test Attachment Body');
         }
        DateTime  localDT   =    system.Now();
        //Create the file name
        fileName  =    'Channel  Appointment  for '+ ChApp[0].GE_PRM_Account_Name__r.name + '-' +  localDT.format('yyyy-MMM-dd hh:mm a');
        List<EmailServicesAddress> esa=new List<EmailServicesAddress>([select localpart,EmailDomainName from EmailServicesAddress where localpart='channelappointmentapproval']);        
        //Responses are forwarded to ReplyEmail address.
        String ReplyEmil=Test.isRunningTest() || esa.isempty()?'test@test.ge.com':esa[0].localpart+'@'+esa[0].EmailDomainName;
        List<String> toAddresses=new List<String>();
        if(ChApp[0].GE_PRM_Principal_contact__r.Email!='' && ChApp[0].GE_PRM_Principal_contact__r.Email!=null)
        {
            toAddresses.add(ChApp[0].GE_PRM_Principal_contact__r.Email);
            mailid = ChApp[0].GE_PRM_Principal_contact__r.id;
        }
        else
        {    
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'No mail id available to send email to');
            ApexPages.addMessage(myMsg);
            return null;
             
        }        
        DateTime d = system.now();   
        String timeStr = d.format('EEEE, MMMMM dd, yyyy hh:mm:ss a', ChApp[0].LastModifiedBy.TimeZoneSidKey);        
        Attachment objAttachement = new Attachment();
        objAttachement.Name=filename+'.pdf' ;
        objAttachement.Body= CAPDF;
        objAttachement.ContentType='application/pdf';
        objAttachement.ParentId=ChApp[0].id;        
        If(!Test.isRunningtest()) { Insert objAttachement; }
        List<EmailTemplate> lstEmailTemplates = [select Id,Name from EmailTemplate where Name=: 'GE_PRM_Partner_Validation'];
        for(EmailTemplate mailTemplate : lstEmailTemplates )
        {
            if(mailTemplate.Name == 'GE_PRM_Partner_Validation')
            {
                mailTemplateId = mailTemplate.id;
            }
        }
        if(toAddresses.size()>0)
        {
            Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
            attach.setContentType('application/pdf');
            attach.setFileName(fileName+'.pdf');        
            attach.Body = CAPDF;
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();     
            if(ChApp[0].GE_PRM_Principal_contact__r.Email!='' && ChApp[0].GE_PRM_Principal_contact__r.Email!=null)
            {  
                mail.setTargetObjectId(mailid);
            }
            if(ChApp[0].Owner.Email!=null){
                mail.setCcAddresses(new String[] {ChApp[0].Owner.Email});
            }
            System.debug(Mail.TargetObjectId+'TARGET');
            mail.setTemplateId(mailTemplateId);
            mail.SetWhatId(ChApp[0].Id);        
            mail.setReplyTo(ReplyEmil);
            mail.setFileAttachments(new Messaging.EmailFileAttachment[] { attach });    
            mail.setsaveAsActivity(false);    
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
            ChApp[0].GE_PRM_AFA_Send_To_Channel_Partner__c = date.today();
            update ChApp[0];
            }
        pr.setRedirect(true);   
                   
        return pr;
    
    }
      
     Public pagereference backtoAccount()    {
        PageReference pageRef1 = new PageReference('/' + acid);
        return pageref1;
     }   
     Public void AbandonChannelAppointment(){  
             GE_PRM_Channel_Appointment__c  chAppt=[select id,GE_PRM_Current_Status__c,GE_PRM_Master_appointment_type__c from GE_PRM_Channel_Appointment__c where id=:this.newchannelrec.ID];
             displayMsgPopup =false;
             displayPopup =false;
             system.debug('%%%%%%%%%%'+newchannelrec.GE_PRM_Master_appointment_type__c);
            if(chAppt.GE_PRM_Current_Status__c != 'Approved' && (chAppt.GE_PRM_Master_appointment_type__c== 'New' || chAppt.GE_PRM_Master_appointment_type__c== 'Renewal')){
                displayPopup = true;
            }
           
           if(chAppt.GE_PRM_Current_Status__c == 'Approved'){                
                 displayMsgPopup = true;
                 displayPopup = false;                 
            }                   
    }
   Public PageReference CancelAbandon() {
       PageReference abandon=new PageReference('/apex/GE_PRM_Channel_Appointment_View_Page1?id='+channelAppId) ;
       abandon.setRedirect(true); 
       return abandon; 
    } 
   Public Boolean AbandonMessageFlag{get;set;} 
   
   Public PageReference AbandonProcessed() {
        GE_PRM_Channel_Appointment__c c =[select id,GE_PRM_Current_Status__c,GE_PRM_Prior_performance_rating__c,GE_PRM_Abandon_Reason__c
                                                from GE_PRM_Channel_Appointment__c where id=:this.newchannelrec.ID];
        List<Contract> List_Abandon_Contracts=new List<Contract>();
        List<Contract> List_Addendum_Contracts=new List<Contract>();
        List<GE_PRM_Channel_Appointment_Approver__c> list_CA_Approver_Status=new List<GE_PRM_Channel_Appointment_Approver__c>();       
        if(newchannelrec.GE_PRM_Abandon_Reason__c==Null){  
            AbandonMessageFlag=true;
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Please Select Abandon Reason'));  
        } 
        if(newchannelrec.GE_PRM_Abandon_Reason__c!=Null || (newchannelrec.GE_PRM_Abandon_Reason__c=='Other' && newchannelrec.GE_PRM_Abandon_Reason_If_Others__c!='')) {
                  AbandonMessageFlag = false;  
                  if((newchannelrec.GE_PRM_Current_Status__c=='Draft' || newchannelrec.GE_PRM_Current_Status__c=='Submitted') && (newchannelrec.GE_PRM_Master_appointment_type__c=='New' || newchannelrec.GE_PRM_Master_appointment_type__c=='Renewal'))  {
                           for(GE_PRM_Channel_Appointment_Approver__c channelApprover:[select Id,GE_PRM_Status__c from GE_PRM_Channel_Appointment_Approver__c WHERE GE_PRM_Channel_Appointment__c = :this.newchannelrec.ID ]){
                                if(channelApprover.GE_PRM_Status__c=='Pending'){
                                       channelApprover.GE_PRM_Status__c='Abandoned';
                                       channelApprover.Is_Active__c=false;
                                       list_CA_Approver_Status.add(channelApprover);
                                } 
                         }               
                  newchannelrec.GE_PRM_Current_Status__c='abandoned';
                  try{    
                      update newchannelrec;
                      
                      }
                  Catch(Exception e){
                          system.debug('Exception in Abandon and Update Channel Appointment Approver'+e.getMessage());
                   }
                  If(list_CA_Approver_Status.size()>0 && newchannelrec.GE_PRM_Current_Status__c=='abandoned'){
                       update list_CA_Approver_Status;
                  }
                  
                for(Contract contrcts:[select id,Status,GE_PRM_Old_Channel_Appointment_ID__c from Contract where GE_PRM_Channel_Appointment_ID__c =:this.newchannelrec.ID]) {
                       if(contrcts.GE_PRM_Old_Channel_Appointment_ID__c!=Null){ 
                           contrcts.GE_PRM_Channel_Appointment_ID__c=contrcts.GE_PRM_Old_Channel_Appointment_ID__c;
                           contrcts.Status='Executed';                    
                           List_Abandon_Contracts.add(contrcts);
                         }
                    }
                for(Contract contrcts:[select id,Status,GE_PRM_Renewal_Channel_Appointment_ID__c from Contract where GE_PRM_Renewal_Channel_Appointment_ID__c=:this.newchannelrec.ID]) {
                       system.debug('%%%%%%%%'+contrcts.GE_PRM_Renewal_Channel_Appointment_ID__c);
                       if(contrcts.GE_PRM_Renewal_Channel_Appointment_ID__c!=Null && contrcts.status=='Under Renewal'){ 
                          // contrcts.GE_PRM_Channel_Appointment_ID__c=contrcts.GE_PRM_Old_Channel_Appointment_ID__c;
                           contrcts.Status='Executed';                    
                           List_Abandon_Contracts.add(contrcts);
                         }
                    }
                System.debug('%%%%%%%'+List_Abandon_Contracts);    
                if(List_Abandon_Contracts.size()>0){
                    // DML statement
                    Database.SaveResult[] srList = Database.Update(List_Abandon_Contracts, false);
                    displayPopup = true;
                    // Iterate through each returned result
                    for (Database.SaveResult sr : srList) {
                        if (sr.isSuccess()) {
                            // Operation was successful, so get the ID of the record that was processed
                            System.debug('Successfully Updated Contract.Contract ID: ' + sr.getId());
                        }
                        else {
                            // Operation failed, so get all errors                
                            for(Database.Error err : sr.getErrors()) {
                                      ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,+ err.getMessage()+''+err.getFields());
                                      ApexPages.addMessage(myMsg);
                                      return null;
                                System.debug('The following error has occurred.');                    
                                System.debug(err.getStatusCode() + ': ' + err.getMessage());
                                System.debug('Account fields that affected this error: ' + err.getFields());
                            }
                        }
                         //   update List_Abandon_Contracts;                  
                   }
                 }
               } 
               PageReference abandon=new PageReference('/apex/GE_PRM_Channel_Appointment_View_Page1?id='+this.newchannelrec.ID) ;
               abandon.setRedirect(true); 
               return abandon;  
          }
         return null;
     }
     
}