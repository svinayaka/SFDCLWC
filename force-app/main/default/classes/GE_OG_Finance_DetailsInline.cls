/*    
Class Name        : GE_OG_Finance_DetailsInline
Purpose/Overview  : Used to display inline financeDetail page in Finance detail. 
Test Class        : GE_OG_Finance_DetailsInline_TEST
Change History    : 
*/

public class GE_OG_Finance_DetailsInline{
    Public List<PermissionSetAssignment> PRMProfile{get; set;}
    public string tier1 {get; set;}
    public string tier2 {get; set;}
    public string tier3 {get; set;}
    public string name {get; set;}
    public string cmfstatus {get; set;}
    public string countryrisk {get; set;}
    public String FinanceCredit{get; set;}
    public string FinanceRisk{get; set;}
    public string esccom{get; set;}
    public string level{get;set;}
    public string creditline{get;set;}
    public string comment{get;set;}
    public string emp{get;set;}
    public string business{get;set;}
    public string csales{get;set;}
    public string psales{get;set;}
    Public String ErrMsg{get; set;}
    public boolean isKycPermissionExist{get;set;}
    
    public string ActualCreditLimit{get; set;}
    //public string CreditLine{get; set;}
    //public string Comment{get; set;}
    public boolean chkflag{get; set;}
    
    public boolean advanflag{get; set;}  
    public boolean refreshPage {get; set;}  
    public boolean edit {get; set;}   
    public GE_OG_Finance_Details__c kyc {get; set;}
    public GE_OG_Finance_Details__c fin{get;set;}
    public List<GE_OG_BussTierToFince__c> lstbus;
    public GE_OG_Finance_Details__c complete;
    Public List<GE_OG_Finance_Details__c> Finesc = new List<GE_OG_Finance_Details__c>();
    
    //public List<GE_OG_Finance_Details__c>  tempfin {get;set;}
    public List<GE_OG_BussTierToFince__c> displaybus{get;set;}
    //public GE_OG_Fin_Histry__c finhistory{get;set;}
    public boolean ChkEscaComm {get; set;}
    String profileName = [select Name from profile where id = :userinfo.getProfileId()].Name;
    
    
    
    public GE_OG_Finance_DetailsInline(ApexPages.StandardController con )
    {
        kyc = (GE_OG_Finance_Details__c)con.getRecord();
        System.debug('****KYC Id****'+kyc.id);
        fin=[select id,GE_OG_Ad_Payment__c,name,GE_OG_KYC__c,GE_OG_Approx_yrs_in_Business__c,GE_OG_Escalation_Comments__c,GE_OG_Pre_Yr_Sales__c,GE_OG_Currnt_Yr_Sales__c,GE_OG_Approx_of_Employees__c,GE_OG_level1_met__c,GE_OG_Resubmitted__c,GE_OG_Comment__c,GE_OG_Cust_accepted__c,GE_OG_Tier1__c,GE_OG_Tier2__c,GE_OG_Tier3__c,GE_OG_Finance_Country_Risk__c,Ge_OG_Account_Status__c,GE_OG_BussToFin__r.Name,GE_OG_BussToFin__r.GE_OG_Fin_Credit_Lmt__c,GE_OG_BussToFin__r.GE_OG_Fin_Risk__c,GE_OG_Finan_TC__c,GE_OG_Finance_Credit_Limit__c,GE_HQ_Finance_Risk_Score__c,GE_OG_Finance_Status__c,GE_OG_Actual__c,GE_OG_Credit_Line_Request__c from GE_OG_Finance_Details__c where Id=:kyc.Id limit 1 ];
        tier1=fin.GE_OG_Tier1__c;
        tier2=fin.GE_OG_Tier2__c;
        tier3=fin.GE_OG_Tier3__c;
        countryrisk = fin.GE_OG_Finance_Country_Risk__c;
        name = fin.Name;
        cmfstatus = fin.Ge_OG_Account_Status__c;
        // System.debug('----------fin------------ '+fin);
        // System.debug('-----countryrisk --------'+countryrisk);
        //System.debug('-----profileName --------'+profileName);
        this.chkflag = false;
        this.refreshPage  = false; 
        this.advanflag = false;    
        this.ChkEscaComm = false;  
        PRMProfilePermissionSet();
         
    }
    
    public void PRMProfilePermissionSet(){
         String Userid = UserInfo.getUserId();
        PRMProfile = new  List<PermissionSetAssignment>([SELECT AssigneeId, PermissionSet.Name FROM PermissionSetAssignment WHERE PermissionSet.Name= 'GE_PRM_KYC_Access' AND AssigneeId =: Userid Limit 1]);           
       
       System.debug('====PRMProfilePermissionSet==='+PRMProfile ); 
       if(PRMProfile!=null && PRMProfile.size()>0){
            isKycPermissionExist = true;
        }
        else{
            isKycPermissionExist = false;
        } 
    }
    
    Public PageReference Completed()
    {
        
        complete=new GE_OG_Finance_Details__c();
        fin.GE_OG_Finance_Status__c='Completed';
        complete=[select id,GE_OG_Cust_accepted__c,Ge_OG_Account_Status__c,GE_OG_Comment__c,GE_OG_Finance_Status__c,GE_OG_KYC__c from GE_OG_Finance_Details__c where Id=:kyc.Id limit 1 ];
        complete.GE_OG_Finance_Status__c='Completed';
        complete.GE_OG_Resubmitted__c = False;
        complete.GE_OG_Cust_accepted__c = False;
        update complete;
        
        return null; 
    }
    
    
    Public PageReference Rejected()
    {
        //String profileName = [select Name from profile where id = :userinfo.getProfileId()].Name;
        
        complete=new GE_OG_Finance_Details__c();
        fin.GE_OG_Finance_Status__c ='Pending User Review - On Hold';
        complete=[select id,GE_OG_Cust_accepted__c,Ge_OG_Account_Status__c,GE_OG_Finance_Status__c,GE_OG_Comment__c,GE_OG_KYC__c,GE_OG_Finance_Country_Risk__c from GE_OG_Finance_Details__c where Id=:kyc.Id limit 1 ];
        complete.GE_OG_Finance_Status__c='Pending User Review - On Hold';
        complete.GE_OG_Resubmitted__c = False;
        complete.GE_OG_Cust_accepted__c = False;
        update complete;
        
        return null;        
    }
    
    Public PageReference Resubmitted()
    {
        complete=new GE_OG_Finance_Details__c();
        fin.GE_OG_Finance_Status__c ='Submitted';
        fin.GE_OG_Resubmitted__c = TRUE;
        complete=[select id,GE_OG_Cust_accepted__c,GE_OG_Ad_Payment__c,GE_OG_Comment__c,Ge_OG_Account_Status__c,GE_OG_Finance_Status__c,GE_OG_KYC__c,GE_OG_Finance_Country_Risk__c from GE_OG_Finance_Details__c where Id=:kyc.Id limit 1 ];
        complete.GE_OG_Finance_Status__c='Submitted';
        complete.GE_HQ_Finance_Risk_Score__c=Null;
        complete.GE_OG_Finance_Credit_Limit__c=Null;
        complete.GE_OG_Actual__c=NUll;
        complete.GE_OG_Finan_TC__c=NUll;
        complete.GE_OG_Resubmitted__c = TRUE;
        update complete;
        refreshPage  = True;
        return null;        
    }
    
    /* Public PageReference check(){

complete=new GE_OG_Finance_Details__c();
fin.GE_OG_Finance_Status__c ='Completed';
fin.GE_OG_Resubmitted__c = False;
complete=[select id,Ge_OG_Account_Status__c,GE_OG_Finance_Status__c,GE_OG_KYC__c,GE_OG_Finance_Country_Risk__c from GE_OG_Finance_Details__c where GE_OG_KYC__c=:kyc.Id limit 1 ];
complete.GE_OG_Finance_Status__c='Completed';
complete.GE_OG_Resubmitted__c = False;
complete.GE_OG_Finan_TC__c = '$50,000';
complete.GE_OG_Finance_Credit_Limit__c = '$50,000';
complete.GE_OG_Ad_Payment__c = '$50,000';
complete.GE_OG_Cust_accepted__c = True;
// system.debug('----------Check Finance--------------'+complete);
update complete;
refreshPage  = True;
return null ;
}
*/
    
    //save mthod for escalation comments
    public PageReference saveesc()
    {
        esccom=ApexPages.currentPage().getParameters().get('esccom');
        if (esccom == '' )
            ChkEscaComm = true;
        else {
            complete = new GE_OG_Finance_Details__c();
            complete=[select id,GE_OG_Escalation_Comments__c from GE_OG_Finance_Details__c where Id=:kyc.Id limit 1 ];
            complete.GE_OG_Escalation_Comments__c=esccom;
            System.Savepoint savPointObj=Database.setSavepoint();
            update complete;
        }     
        refreshPage  = true;
        return null;   
    }
    //savemethod for Requestor inputs  
    
    public PageReference savereq() 
    {    
        
        level=ApexPages.currentPage().getParameters().get('level'); 
        creditline=ApexPages.currentPage().getParameters().get('creditline'); 
        comment=ApexPages.currentPage().getParameters().get('comment'); 
        emp=ApexPages.currentPage().getParameters().get('emp'); 
        business=ApexPages.currentPage().getParameters().get('business'); 
        csales=ApexPages.currentPage().getParameters().get('csales'); 
        psales=ApexPages.currentPage().getParameters().get('psales');
        
        complete = new GE_OG_Finance_Details__c();
        complete=[select id,GE_OG_Cust_accepted__c,GE_OG_Credit_Line_Request__c,GE_OG_Currnt_Yr_Sales__c,GE_OG_Approx_of_Employees__c,GE_OG_Approx_yrs_in_Business__c,GE_OG_Comment__c,GE_OG_level1_met__c,GE_OG_Tier2__c,GE_OG_Tier3__c,GE_OG_Finance_Country_Risk__c,GE_OG_Finance_Credit_Limit__c,GE_HQ_Finance_Risk_Score__c,GE_OG_BussToFin__r.Name,GE_OG_BussToFin__r.GE_OG_Fin_Credit_Lmt__c,GE_OG_BussToFin__r.GE_OG_Fin_Risk__c ,GE_OG_BussToFin__r.GE_OG_Fin_TC__c,GE_OG_Actual__c from GE_OG_Finance_Details__c where Id=:kyc.Id limit 1 ];  
        
        complete.GE_OG_level1_met__c=level;
        complete.GE_OG_Credit_Line_Request__c=creditline;
        complete.GE_OG_Comment__c=comment;
        complete.GE_OG_Approx_of_Employees__c=emp;
        complete.GE_OG_Approx_yrs_in_Business__c=business;
        complete.GE_OG_Currnt_Yr_Sales__c=csales;
        complete.GE_OG_Pre_Yr_Sales__c=psales; 
        System.Savepoint savPointObj=Database.setSavepoint();
        
        update complete;
        
        refreshPage  = true;
        return null;
    }
    public PageReference saveData() 
    {    
        //this.chkflag = false;                    
        FinanceRisk=ApexPages.currentPage().getParameters().get('FinanceRisk');
        FinanceCredit=ApexPages.currentPage().getParameters().get('FinanceCredit');
        ActualCreditLimit = ApexPages.currentPage().getParameters().get('ActualCreditLimit');  
        
        
        
        
        // String profileName = [select Name from profile where id = :userinfo.getProfileId()].Name;
        
        complete = new GE_OG_Finance_Details__c();
        complete=[select id,GE_OG_Cust_accepted__c,GE_OG_Credit_Line_Request__c,GE_OG_Currnt_Yr_Sales__c,GE_OG_Approx_of_Employees__c,GE_OG_Approx_yrs_in_Business__c,GE_OG_Comment__c,GE_OG_level1_met__c,GE_OG_Tier2__c,GE_OG_Tier3__c,GE_OG_Finance_Country_Risk__c,GE_OG_Finance_Credit_Limit__c,GE_HQ_Finance_Risk_Score__c,GE_OG_BussToFin__r.Name,GE_OG_BussToFin__r.GE_OG_Fin_Credit_Lmt__c,GE_OG_BussToFin__r.GE_OG_Fin_Risk__c ,GE_OG_BussToFin__r.GE_OG_Fin_TC__c,GE_OG_Actual__c from GE_OG_Finance_Details__c where Id=:kyc.Id limit 1 ];  
        complete.GE_HQ_Finance_Risk_Score__c=FinanceRisk;
        complete.GE_OG_Finance_Credit_Limit__c=FinanceCredit;
        complete.GE_OG_Actual__c=ActualCreditLimit;
        
        
        
        
        
        
        // system.debug('complete123---------'+complete);
        System.Savepoint savPointObj=Database.setSavepoint();
        
        // update complete;// check   --------------------
        //system.debug('-------tier33333----'+complete.GE_HQ_Finance_Risk_Score__c);
        system.debug('--------tier33333---'+complete.GE_OG_Cust_accepted__c);
        
        /************************* To Collect the data from Business Tier and display the T&Cs *******************/
        
        
        lstbus = new List<GE_OG_BussTierToFince__c>();
        lstbus = [select id ,Name,GE_OG_Buss_Tier_RL__r.Name ,GE_OG_Fin_Ctry_Risk__c,GE_OG_Fin_Risk__c,GE_OG_Fin_Credit_Lmt__c,GE_OG_Fin_TC__c from GE_OG_BussTierToFince__c
                  where (Name =:complete.GE_OG_Tier3__c OR Name =:complete.GE_OG_Tier2__c) AND  
                  GE_OG_Fin_Ctry_Risk__c =:complete.GE_OG_Finance_Country_Risk__c  AND 
                  GE_OG_Fin_Risk__c = :complete.GE_HQ_Finance_Risk_Score__c  AND
                  GE_OG_Fin_Credit_Lmt__c =:complete.GE_OG_Finance_Credit_Limit__c limit 1 ] ;
        
        // system.debug('lstbus-----------'+lstbus.size());
        if(!(lstbus.size()>0))
        {
            chkflag = true;
            // Database.rollback(savPointObj);
        }
        
        else{
            chkflag = false;
            complete.GE_OG_Finan_TC__c = lstbus[0].GE_OG_Fin_TC__c;
            update complete;
            
            list<GE_OG_ERP_Detail__c> checkerp=[select id,GE_OG_ERP_Account__c,GE_OG_KYC__c from GE_OG_ERP_Detail__c where GE_OG_ERP_Account__c=: kyc.id];
            if(checkerp.size()>0)
            {
                GE_OG_ERP_Detail__c ERPs = [select id,GE_OG_CoE_Rec_Finance_TCs__c from GE_OG_ERP_Detail__c where id=:checkerp[0].id ];
                ERPs.GE_OG_CoE_Rec_Finance_TCs__c = complete.GE_OG_Finan_TC__c;
                update ERPs;
            }
            refreshPage  = true;
            //system.debug('complete---------'+complete);
        }       
        // edit = false;
        
        return null;
        
        
    }
    
    public PageReference display()
    {
        
        complete = new GE_OG_Finance_Details__c();
        complete=[select id,GE_OG_Tier3__c,GE_OG_Finance_Country_Risk__c,GE_OG_Finance_Credit_Limit__c,GE_OG_Comment__c,GE_HQ_Finance_Risk_Score__c,GE_OG_BussToFin__r.Name,GE_OG_BussToFin__r.GE_OG_Fin_Credit_Lmt__c,GE_OG_BussToFin__r.GE_OG_Fin_Risk__c ,GE_OG_BussToFin__r.GE_OG_Fin_TC__c from GE_OG_Finance_Details__c where Id=:kyc.Id limit 1 ];  
        // system.debug('complete id:---'+complete.id);
        
        displaybus = new List<GE_OG_BussTierToFince__c>();
        displaybus = [select id ,Name,GE_OG_Buss_Tier_RL__r.GE_HQ_Parent_P_L_Name__r.Name,GE_OG_Buss_Tier_RL__r.Name ,GE_OG_Fin_Ctry_Risk__c,GE_OG_Fin_Risk__c,GE_OG_Fin_Credit_Lmt__c,GE_OG_Fin_TC__c from GE_OG_BussTierToFince__c
                      where  GE_OG_Fin_Ctry_Risk__c =:complete.GE_OG_Finance_Country_Risk__c  AND 
                      GE_OG_Fin_Risk__c = :complete.GE_HQ_Finance_Risk_Score__c  AND
                      GE_OG_Fin_Credit_Lmt__c =:complete.GE_OG_Finance_Credit_Limit__c] ;
        
        //system.debug('----additional T&Cs------'+displaybus)  ; 
        return null;    
    }
    
    Public PageReference EscalateToFinance()
    {    
        complete=new GE_OG_Finance_Details__c();
        List<GE_OG_Escalation_Team__c> Escalation_Team_Details = new List<GE_OG_Escalation_Team__c>();
        GE_OG_Finance_Details__c objFinDetails = [SELECT Id,GE_OG_Account__c FROM GE_OG_Finance_Details__c WHERE Id =: kyc.Id];
        Account kycrecords = [select id,name from Account where Id =: objFinDetails.GE_OG_Account__c];
        Account acc=[select id,name,GE_HQ_New_Account_Country__c,ShippingCountry,BillingCountry,GE_OG_Region_Tier1__c from Account where id =: kycrecords.Id];
        GE_HQ_Region__c accregion = new GE_HQ_Region__c();
        if (acc.GE_OG_Region_Tier1__c != null ) 
             accregion = [select id,name from GE_HQ_Region__c where id =: acc.GE_OG_Region_Tier1__c ];
        //system.debug('  finance tier '+ fin.GE_OG_Tier3__c + 'region '+accregion.name);
        try {
        
            if (accregion != null)
                Escalation_Team_Details = [SELECT GE_OG_Finance_Contact_Email__c,GE_OG_Region__c,GE_OG_PL_Tier_3__c FROM GE_OG_Escalation_Team__c where GE_OG_PL_Tier_3__c =: fin.GE_OG_Tier3__c and GE_OG_Region__c =:accregion.name limit 1  ];   
            else
                Escalation_Team_Details = [SELECT GE_OG_Finance_Contact_Email__c,GE_OG_Region__c,GE_OG_PL_Tier_3__c FROM GE_OG_Escalation_Team__c where GE_OG_PL_Tier_3__c =: fin.GE_OG_Tier3__c and GE_OG_Region__c =:'' limit 1  ];
            system.debug('  finance esclation 1 '+Escalation_Team_Details);
            if ( Escalation_Team_Details.size() < 1 )
                Escalation_Team_Details = [SELECT GE_OG_Finance_Contact_Email__c,GE_OG_Region__c,GE_OG_PL_Tier_3__c FROM GE_OG_Escalation_Team__c where GE_OG_PL_Tier_3__c =: fin.GE_OG_Tier3__c and GE_OG_Region__c =:'' limit 1  ];    
            system.debug('  finance esclation 2 '+Escalation_Team_Details);
            //List<GE_OG_Escalation_Team__c> Escalation_Team_Details =  GE_OG_Escalation_Team__c.getall().values();    
            complete=[select id,GE_OG_Cust_accepted__c,GE_OG_Resubmitted__c,Ge_OG_Account_Status__c,GE_OG_Escalate_Email__c,GE_OG_Comment__c,GE_OG_Finance_Status__c,GE_OG_Escalation_Comments__c,GE_OG_KYC__c from GE_OG_Finance_Details__c where GE_OG_KYC__c=:kyc.Id limit 1 ];
            if (complete.GE_OG_Escalation_Comments__c == null || complete.GE_OG_Escalation_Comments__c == '' )
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'There is no Finance Escalation Comments !!! Please Save Finance Escalation Comments'));                            
            else {
                complete.GE_OG_Finance_Status__c = 'Escalated';
                if ( Escalation_Team_Details.size() > 0 )
                    complete.GE_OG_Escalate_Email__c= Escalation_Team_Details[0].GE_OG_Finance_Contact_Email__c;
                else
                    complete.GE_OG_Escalate_Email__c= 'NotFound@email.com';
                complete.GE_OG_Resubmitted__c = TRUE;
                update complete;   
                refreshPage  = true;                    
            }   
        } catch (exception e) {}   
        
        return null; 
    }      
    
}