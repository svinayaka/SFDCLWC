/*
Class Name        : GE_OG_FinanceRetriggerController
Purpose/Overview  : Used For the Finance Retrigger Button.
Author            : Somanath Das
Test Class        : GE_OG_FinanceRetriggerTest
Change History    : Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
: 10th Oct 2013 : Malemleima Chanu   : Added the Risk type for the KYC insert.
: 12th Nov 2013 : Harsh Sharma       : Post Prod bug fix (Bug-0000016062)
: 10th Jan 2013 :Malemleima Chanu    : Added the Logic for the Account Modification KYC so that it 
doesnot contradict with the existing Logic.
: 24th Jan 2013 :malemleima Chanu : Added the Logic for resolving the Account Country and CMF, AMF name
Bug:0000016492 
:12th Feb 2014: Satya: Added Requested credit limit& Comments fields on this page for R-15576
:4th Oct 2014: Satyanarayana P for R-18999 Always process any countries marked with a KYC CIS flag "checked" as high risk.         
:10th Nov 2014: Satyanarayana P Added Tier4         
*/


public with sharing class GE_FinanceRetriggerController
{    
    public Account con;
    public Account AccountTier;
    public Account acc{get;set;}
    public string tier1{get;set;}
    public string tier2{get;set;}
    public string tier3{get;set;}
    public string tier4{get;set;}
    public string Businesstype{get;set;}
    public boolean creditq1 {get;set;}
    public boolean creditq2 {get;set;}
    //public string comments{get;set;}
    public String accid{get;set;}
    public string RiskType{get;set;}
    public boolean isLowRisk {get; set;}
    public boolean isHighRisk {get; set;}
    public GE_PRM_KYC_Termination_Checklist__c kycid{get;set;}
    //public GE_HQ_Country__c country=new GE_HQ_Country__c();
    public GE_HQ_Country__c vat{get;set;}
    public GE_OG_Finance_Details__c finc{get;set;}
    
    //variables for Customer finance assessment
    public boolean isCreditLevel2 {get; set;}
    public GE_PW_CMFtoISOCountryName__c QuoteToCMFCountryObj {get; set;}
    public GE_HQ_Country__c QuoteToCountryObj {get; set;}
    public GE_PW_CMFtoISOCountryName__c ShipToCMFCountryObj {get; set;}
    public GE_HQ_Country__c ShipToCountryObj {get; set;}
    public GE_PW_CMFtoISOCountryName__c BillToCMFCountryObj {get; set;}
    public GE_HQ_Country__c BillToCountryObj {get; set;}      
    public boolean isAllCountriesSame {get; set;}  
    public boolean isExistingCustomer {get; set;}
    public Account existingCustomerObj {get; set;}
    Boolean Countryresults;
    public boolean kycexist;
    public boolean fincexist;
    
    
    public GE_FinanceRetriggerController(ApexPages.StandardController controller)
    {   
        isLowRisk = false;
        isHighRisk = false;
        isCreditLevel2 = false;
        creditq1 = false;
        creditq2 = false;
        kycexist = false;
        fincexist = false;
        this.con=(Account)controller.getRecord();
        
        accid= ApexPages.currentPage().getParameters().get('accids');
        System.debug('*******************'+accid);
        con.id=accid;
        Tier1=con.GE_OG_Buss_Tier1__c;
        Tier2=con.GE_OG_Buss_Tier2__c;
        Tier3=con.GE_OG_Buss_Tier3__c;
        Tier4=con.GE_OG_Buss_Tier4__c;
        Businesstype=con.GE_PW_Select_Type_of_Business__c;
        
        acc=[Select Id,GE_HQ_New_Account_Country__c,GE_HQ_Request_Status__c,Name,GE_PW_Country_Bill_To__c,GE_PW_Country_Ship_To__c,GE_PW_Existing_Customer_New_Address__c,GE_PW_Street_Quote_To_Sold_To_HQ__c,ownerId,GE_PW_City_Quote_To_Sold_To_HQ__c,GE_PW_State_Province_Quote_To_Sold_To_HQ__c,GE_PW_Zip_Postal_Code_Quote_To_Sold_ToHQ__c,GE_PW_Country_Quote_To_Sold_To_HQ__c,ShippingCity,ShippingPostalCode,ShippingState,ShippingStreet,ShippingCountry,BillingCity,BillingState,BillingStreet,BillingPostalCode,BillingCountry,GE_HQ_Vat_Number__c,GE_HQ_DUNS_Number__c,GE_PW_Select_Type_of_Business__c,GE_OG_Buss_Tier1__c,GE_OG_Buss_Tier2__c,GE_OG_Buss_Tier3__c,GE_OG_Buss_Tier4__c,GE_HQ_Site_Use_Code__c, Oil_Gas_Parent_Account__c from Account where Id=:con.id ];
        system.debug('helllooooooooooo'+acc);
        
        String accCountry = '';
        String countrycodeName = '';
        if(!String.isBlank(acc.ShippingCountry))
            accCountry =acc.ShippingCountry; 
        else if(!String.isBlank(acc.BillingCountry))
            accCountry =acc.BillingCountry;     
        List<GEMDM__GEMDMCountryList__c> Country_Codes = [SELECT GEMDM__Country_Code__c,GEMDM__Country_Name__c FROM GEMDM__GEMDMCountryList__c where GEMDM__Country_Code__c =: accCountry];    
        if (Country_Codes.size() > 0) 
            countrycodeName=Country_Codes[0].GEMDM__Country_Name__c;
        else
            countrycodeName = acc.ShippingCountry;
        system.debug('hello---countrycodeName : '+countrycodeName );
        List<GE_PW_CMFtoISOCountryName__c> CMFtoISOCoun=new List<GE_PW_CMFtoISOCountryName__c>([select id,GE_PW_CMF_Name__c,GE_PW_AML_Name__c,GE_PW_Country__r.Id from GE_PW_CMFtoISOCountryName__c where GE_PW_CMF_Name__c=: countrycodeName]);
        Set<Id>CmftoIsoCounlookup = new Set<Id>(); 
        
        for(GE_PW_CMFtoISOCountryName__c CMF:CMFtoISOCoun){
            CmftoIsoCounlookup.add(cmf.GE_PW_Country__r.Id);
        }
        //Map<Id,GE_HQ_Country__c> countryVatMap=new  Map<Id,GE_HQ_Country__c>([select id,name,GE_PW_VAT_Format__c,GE_PW_VATApplicabl__c,GE_OG_Tax_ID_Format__c from GE_HQ_Country__c where Id =:CmftoIsoCounlookup]);  
        system.debug('*******CmftoIsoCounlookup '+CmftoIsoCounlookup); 
        if(acc.GE_HQ_Site_Use_Code__c=='BOTH'||acc.GE_HQ_Site_Use_Code__c=='SHIP_TO'|| acc.GE_HQ_Site_Use_Code__c== Null)//Modified for the Account if the Site Use Code is blank
        {
            if(!String.isBlank(acc.ShippingCountry))              
                vat=[Select GE_PW_VAT_Format__c,GE_PW_VATApplicabl__c from GE_HQ_Country__c where Id =:CmftoIsoCounlookup ];
        }
        
        if(acc.GE_HQ_Site_Use_Code__c=='BILL_TO')
        {
            if(!String.isBlank(acc.BillingCountry))              
                vat=[Select GE_PW_VATApplicabl__c,GE_PW_VAT_Format__c from GE_HQ_Country__c where Id =:CmftoIsoCounlookup ];
        }
        CheckRiskTpe(); 
        system.debug('Risk typeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee'+RiskType);   
        // Added the Condition In the Query so that its doesnot contradict with the Account Modification Part
        list<GE_OG_Finance_Details__c> finclist = new list<GE_OG_Finance_Details__c>();
        try{
            kycid=[Select Id,GE_HQ_Vat_Format_atchmnt__c,GE_HQ_VAT_Tax_ID__c,GE_HQ_Vat_Reason_Code__c,GE_HQ_Account__c,GE_HQ_Status__c,GE_PW_KYC_Type__c from GE_PRM_KYC_Termination_Checklist__c where GE_HQ_Account__c=:accid and GE_PW_KYC_Type__c!='Modify Account'];
            finclist=[Select Id,GE_OG_Actual__c,GE_OG_Cust_accepted__c,GE_OG_Comment__c,GE_OG_Credit_Line_Request__c,GE_OG_Currnt_Yr_Sales__c,GE_OG_Approx_of_Employees__c,GE_OG_Pre_Yr_Sales__c,GE_OG_Approx_yrs_in_Business__c,GE_OG_level1_met__c,GE_OG_Fast_Lane_Criteria__c from GE_OG_Finance_Details__c where GE_OG_Account__c=:acc.Id ];
            if (finclist.size() > 0)
            finc = finclist[0];
        }catch(Exception e){
            
        }        
        
        system.debug('current country -- '+acc.GE_HQ_New_Account_Country__c); 
        /*countrycodeName = '';
List<GEMDMCountryList__c> Country_Codes = [SELECT Country_Code__c,Country_Name__c FROM GEMDMCountryList__c where Country_Code__c =: acc.GE_HQ_New_Account_Country__c];    
if (Country_Codes.size() > 0) 
countrycodeName=Country_Codes[0].Country_Name__c;
else
countrycodeName = acc.GE_HQ_New_Account_Country__c;*/
        if (countrycodeName != '')
            countrycodeName = countrycodeName.toUpperCase();
        system.debug('Custom current country -- '+countrycodeName);
        set<string> countrylist = new Set<String>{'UNITED STATES','CANADA','AUSTRIA','UNITED KINGDOM','BELGIUM','FRANCE','GERMANY','ITALY','NETHERLANDS','SPAIN','DENMARK','FINLAND','NORWAY','SWEDEN'}; 
            
            Countryresults = countrylist.contains(countrycodeName);
        system.debug('Result current country -- '+Countryresults);
        
        if (acc.GE_PW_Select_Type_of_Business__c == 'Publically Traded Company' || acc.GE_PW_Select_Type_of_Business__c == 'Subsidiary of Public Traded Company' || Countryresults)
            isCreditLevel2 = true;
    }
    
    public Boolean getVatApplicable()
    {
        if (vat != null ) {
            if( vat.GE_PW_VATApplicabl__c!=false  )
                return true;
            else
                return false;
        } else 
            return false;
    }
    
    public Pagereference KycRedirect()
    {   
        if(kycid!=null)
        {
            kycexist = true;
            List<GE_OG_Finance_Details__c> checkFin=[Select Id,GE_OG_Actual__c,GE_OG_Cust_accepted__c,GE_OG_Comment__c,GE_OG_Credit_Line_Request__c,GE_OG_Currnt_Yr_Sales__c,GE_OG_Approx_of_Employees__c,GE_OG_Pre_Yr_Sales__c,GE_OG_Approx_yrs_in_Business__c,GE_OG_level1_met__c,GE_OG_Fast_Lane_Criteria__c from GE_OG_Finance_Details__c where GE_OG_Account__c=:acc.Id  AND GE_OG_KYC__c=:kycid.id AND GE_OG_Finance_Status__c != 'Finance Not Applicable' limit 1 ];
            if(checkFin.size()>0)
            { 
                fincexist = true;
                finc=[Select Id,GE_OG_Actual__c,GE_OG_Finance_Status__c,GE_OG_Cust_accepted__c,GE_OG_Comment__c,GE_OG_Credit_Line_Request__c,GE_OG_Currnt_Yr_Sales__c,GE_OG_Approx_of_Employees__c,GE_OG_Pre_Yr_Sales__c,GE_OG_Approx_yrs_in_Business__c,GE_OG_level1_met__c,GE_OG_Fast_Lane_Criteria__c from GE_OG_Finance_Details__c where GE_OG_Account__c=:acc.Id limit 1];
                finc.GE_OG_Finance_Status__c='Pending User Submission';
                kycid.GE_OG_Finance_checked__c=true;

                update finc;       
            }
            else {
                GE_OG_Finance_Details__c fin=new GE_OG_Finance_Details__c();
                fin.GE_OG_Account__c=acc.Id;
                fin.GE_OG_KYC__c=kycid.id;
                fin.GE_OG_Finance_Status__c='Pending User Submission';
                acc.GE_OG_AccFin_Status__c='In Progress';
                acc.Finance__c = finc.Name;
                
                kycid.GE_OG_Finance_checked__c=true;
                
                fin.GE_OG_Finance_Country_Risk__c=RiskType;
                insert fin;
            }           
            update acc; 
            update kycid;
        }  
        else
        {           
            kycexist = false;
            Schema.DescribeSObjectResult kycObj = Schema.SObjectType.GE_PRM_KYC_Termination_Checklist__c; 
            Map<String,Schema.RecordTypeInfo> rtMapByName = kycObj.getRecordTypeInfosByName();
            Schema.RecordTypeInfo rtByName =  rtMapByName.get('GE PW KYC Locked Record Type');
            Id kycRT=rtByName.getRecordTypeId();
            //GE_PRM_Recommendation__c recom=[select id,name from GE_PRM_Recommendation__c where GE_PRM_KYC_Page__c!='Completed' limit 1];
            String RecomId = System.Label.GE_HQ_Dummy_Recommendation_Id;  // Fetch the default Recommendation info to fill the MasterDetail relationship.
            GE_PRM_KYC_Termination_Checklist__c ky=new GE_PRM_KYC_Termination_Checklist__c();
            ky.RecordTypeId=kycRT;
            ky.GE_PRM_Recommendation__c=RecomId;
            
            System.debug('*******************in KYC new*********************************************');
            if(acc.GE_HQ_Site_Use_Code__c=='BOTH'||acc.GE_HQ_Site_Use_Code__c=='SHIP_TO')
            {            
                ky.GE_HQ_Account__c=accid;
                ky.GE_HQ_Sold_To_Street__c=String.valueof(acc.ShippingStreet);
                ky.GE_HQ_Sold_To_State__c=String.valueof(acc.ShippingState);
                ky.GE_HQ_Ship_To_Zip__c=String.valueof(acc.ShippingPostalCode);
                ky.GE_HQ_Sold_To_Country__c=String.valueof(acc.ShippingCountry);
                ky.GE_HQ_Sold_To_City__c=String.valueof(acc.ShippingCity);
                ky.GE_HQ_Bill_To_Street__c=String.valueof(acc.BillingStreet);
                ky.GE_HQ_Bill_To_State__c=String.valueof(acc.BillingState);
                ky.GE_HQ_Bill_To_Zip__c=String.valueof(acc.BillingPostalCode);
                ky.GE_HQ_Bill_To_Country__c=String.valueof(acc.BillingCountry);
                ky.GE_HQ_Bill_To_City__c=String.valueof(acc.BillingCity);
                ky.GE_HQ_Ship_To_Street__c=String.valueof(acc.ShippingStreet);
                ky.GE_HQ_Ship_To_State__c=String.valueof(acc.ShippingState);
                ky.GE_HQ_Ship_To_Zip__c=String.valueof(acc.ShippingPostalCode);
                ky.GE_HQ_Ship_To_Country__c=String.valueof(acc.ShippingCountry);
                ky.GE_HQ_Ship_To_City__c=String.valueof(acc.ShippingCity);
                ky.GE_OG_Finance_checked__c=true;
                //ky.GE_HQ_Status__c='Manual Due Diligence Approved';
                
                ky.GE_PW_Risk_Type__c = RiskType+' Risk'; 
                
                insert ky;            
                
                List<GE_OG_Finance_Details__c> checkFin=[Select Id,GE_OG_Actual__c,GE_OG_Cust_accepted__c,GE_OG_Comment__c,GE_OG_Credit_Line_Request__c,GE_OG_Currnt_Yr_Sales__c,GE_OG_Approx_of_Employees__c,GE_OG_Pre_Yr_Sales__c,GE_OG_Approx_yrs_in_Business__c,GE_OG_level1_met__c,GE_OG_Fast_Lane_Criteria__c from GE_OG_Finance_Details__c where GE_OG_Account__c=:acc.Id  AND GE_OG_KYC__c=:ky.id AND GE_OG_Finance_Status__c != 'Finance Not Applicable' limit 1 ];
                if(checkFin.size()>0)
                { 
                    finc=[Select Id,GE_OG_Finance_Status__c,GE_OG_Actual__c,GE_OG_Cust_accepted__c,GE_OG_Comment__c,GE_OG_Credit_Line_Request__c,GE_OG_Currnt_Yr_Sales__c,GE_OG_Approx_of_Employees__c,GE_OG_Pre_Yr_Sales__c,GE_OG_Approx_yrs_in_Business__c,GE_OG_level1_met__c,GE_OG_Fast_Lane_Criteria__c from GE_OG_Finance_Details__c where GE_OG_Account__c=:acc.Id limit 1];
                    finc.GE_OG_Finance_Status__c='Pending User Submission';
                    ky.GE_OG_Finance_checked__c=true;
                    System.debug('***********Finance Check***************'+finc);
                    update finc;             
                }
                else 
                {     
                    System.debug('*******************in KYC null else fin insert*********************************************');             
                    GE_OG_Finance_Details__c fin=new GE_OG_Finance_Details__c();
                    fin.GE_OG_Account__c=acc.Id;
                    fin.GE_OG_KYC__c=kycid.id;
                    fin.GE_OG_Finance_Status__c='Pending User Submission';
                    acc.GE_OG_AccFin_Status__c='In Progress';
                    acc.Finance__c = finc.Name;
                    kycid.GE_OG_Finance_checked__c=true;            
                    fin.GE_OG_Finance_Country_Risk__c= RiskType;
                    insert fin;
                }        
            }
            else 
            {
                ky.GE_HQ_Account__c=accid;
                ky.GE_HQ_Sold_To_Street__c=String.valueof(acc.BillingStreet);
                ky.GE_HQ_Sold_To_State__c=String.valueof(acc.BillingState);
                ky.GE_HQ_Ship_To_Zip__c=String.valueof(acc.BillingPostalCode);
                ky.GE_HQ_Sold_To_Country__c=String.valueof(acc.BillingCountry);
                ky.GE_HQ_Sold_To_City__c=String.valueof(acc.BillingCity);
                ky.GE_HQ_Bill_To_Street__c=String.valueof(acc.BillingStreet);
                ky.GE_HQ_Bill_To_State__c=String.valueof(acc.BillingState);
                ky.GE_HQ_Bill_To_Zip__c=String.valueof(acc.BillingPostalCode);
                ky.GE_HQ_Bill_To_Country__c=String.valueof(acc.BillingCountry);
                ky.GE_HQ_Bill_To_City__c=String.valueof(acc.BillingCity);
                ky.GE_HQ_Ship_To_Street__c=String.valueof(acc.ShippingStreet);
                ky.GE_HQ_Ship_To_State__c=String.valueof(acc.ShippingState);
                ky.GE_HQ_Ship_To_Zip__c=String.valueof(acc.ShippingPostalCode);
                ky.GE_HQ_Ship_To_Country__c=String.valueof(acc.ShippingCountry);
                ky.GE_HQ_Ship_To_City__c=String.valueof(acc.ShippingCity);
                //ky.GE_HQ_Status__c='Manual Due Diligence Approved';
                ky.GE_OG_Finance_checked__c=true;
                
                ky.GE_PW_Risk_Type__c = RiskType+' Risk'; 
                
                insert ky;  
                
                List<GE_OG_Finance_Details__c> checkFin=[Select Id,GE_OG_Actual__c,GE_OG_Cust_accepted__c,GE_OG_Comment__c,GE_OG_Credit_Line_Request__c,GE_OG_Currnt_Yr_Sales__c,GE_OG_Approx_of_Employees__c,GE_OG_Pre_Yr_Sales__c,GE_OG_Approx_yrs_in_Business__c,GE_OG_level1_met__c,GE_OG_Fast_Lane_Criteria__c from GE_OG_Finance_Details__c where GE_OG_Account__c=:acc.Id  AND GE_OG_KYC__c=:ky.id AND GE_OG_Finance_Status__c != 'Finance Not Applicable' limit 1 ];
                if(checkFin.size()>0)
                { 
                    finc=[Select Id,GE_OG_Finance_Status__c,GE_OG_Actual__c,GE_OG_Cust_accepted__c,GE_OG_Comment__c,GE_OG_Credit_Line_Request__c,GE_OG_Currnt_Yr_Sales__c,GE_OG_Approx_of_Employees__c,GE_OG_Pre_Yr_Sales__c,GE_OG_Approx_yrs_in_Business__c,GE_OG_level1_met__c,GE_OG_Fast_Lane_Criteria__c from GE_OG_Finance_Details__c where GE_OG_Account__c=:acc.Id limit 1];
                    finc.GE_OG_Finance_Status__c='Pending User Submission';
                    ky.GE_OG_Finance_checked__c=true;
                    System.debug('***********Finance Check***************'+finc);
                    update finc;             
                }
                else 
                {     
                    System.debug('*******************in KYC null else fin insert*********************************************');             
                    GE_OG_Finance_Details__c fin=new GE_OG_Finance_Details__c();
                    fin.GE_OG_Account__c=acc.Id;
                    fin.GE_OG_KYC__c=kycid.id;
                    fin.GE_OG_Finance_Status__c='Pending User Submission';
                    acc.GE_OG_AccFin_Status__c='In Progress';
                    acc.Finance__c = finc.Name;
                    kycid.GE_OG_Finance_checked__c=true;            
                    fin.GE_OG_Finance_Country_Risk__c= RiskType;
                    insert fin;
                }               
            }
            
        }
        return null;      
    }
    //********************** End of the KYC redirect Method
    
    public void CheckRiskTpe()
    {
        RiskType = '';
        if(acc.GE_PW_Country_Quote_To_Sold_To_HQ__c != null){
            QuoteToCMFCountryObj = [select id, GE_PW_CMF_Name__c, GE_PW_AML_Name__c, GE_PW_Country__c, GE_PW_Country_Name__c, GE_PW_ISO_Code__c from GE_PW_CMFtoISOCountryName__c where GE_PW_CMF_Name__c =: acc.GE_PW_Country_Quote_To_Sold_To_HQ__c limit 1];
        }
        
        if(acc.GE_PW_Country_Bill_To__c != null && acc.GE_PW_Country_Bill_To__c != ''){
            BillToCMFCountryObj = [select id, GE_PW_CMF_Name__c, GE_PW_AML_Name__c, GE_PW_Country__c, GE_PW_Country_Name__c, GE_PW_ISO_Code__c from GE_PW_CMFtoISOCountryName__c where GE_PW_CMF_Name__c =: acc.GE_PW_Country_Bill_To__c limit 1];
            System.debug('****BillToCMFCountryObj****'+BillToCMFCountryObj.GE_PW_Country__c);
        }            
        if(acc.GE_PW_Country_Ship_To__c != null && acc.GE_PW_Country_Ship_To__c != ''){
            ShipToCMFCountryObj = [select id, GE_PW_CMF_Name__c, GE_PW_AML_Name__c, GE_PW_Country__c, GE_PW_Country_Name__c, GE_PW_ISO_Code__c from GE_PW_CMFtoISOCountryName__c where GE_PW_CMF_Name__c =: acc.GE_PW_Country_Ship_To__c limit 1];
            System.debug('****ShipToCMFCountryObj****'+ShipToCMFCountryObj.GE_PW_Country__c);
        }            
        
        if(QuoteToCMFCountryObj != null){
            QuoteToCountryObj = [select id, GE_HQ_ISO_Code__c, GE_PW_ITC__c, GE_PW_CIS_Non_CIS__c, GE_HQ_Sanct_Cnty__c, GE_PW_VATApplicabl__c,  GE_PW_Risk_Type__c from GE_HQ_Country__c where id =: QuoteToCMFCountryObj.GE_PW_Country__c limit 1];
            
            if(QuoteToCountryObj.GE_PW_Risk_Type__c != null && QuoteToCountryObj.GE_PW_Risk_Type__c != ''){
                RiskType = QuoteToCountryObj.GE_PW_Risk_Type__c;       
            }
        }
        if(BillToCMFCountryObj !=null){
            System.debug('****CMFCountryObj****'+BillToCMFCountryObj);            
            BillToCountryObj = [select id, GE_HQ_ISO_Code__c, GE_PW_ITC__c, GE_PW_CIS_Non_CIS__c, GE_HQ_Sanct_Cnty__c, GE_PW_VATApplicabl__c,  GE_PW_Risk_Type__c, GE_PW_VAT_Format__c from GE_HQ_Country__c where id =: BillToCMFCountryObj.GE_PW_Country__c limit 1];                        
        }      
        if(ShipToCMFCountryObj !=null){
            System.debug('****ShipToCMFCountryObj****'+ShipToCMFCountryObj);            
            ShipToCountryObj = [select id, GE_HQ_ISO_Code__c, GE_PW_ITC__c, GE_PW_CIS_Non_CIS__c, GE_HQ_Sanct_Cnty__c, GE_PW_VATApplicabl__c,  GE_PW_Risk_Type__c, GE_PW_VAT_Format__c from GE_HQ_Country__c where id =: ShipToCMFCountryObj.GE_PW_Country__c limit 1];
        }
        
        system.debug('RiskType -----1---- : '+RiskType);
        if(QuoteToCountryObj != null)
            RiskType = QuoteToCountryObj.GE_PW_Risk_Type__c;
        system.debug('RiskType -----2---- : '+RiskType);                    
        if(acc.GE_PW_Country_Quote_To_Sold_To_HQ__c == acc.GE_PW_Country_Bill_To__c && acc.GE_PW_Country_Quote_To_Sold_To_HQ__c ==  acc.GE_PW_Country_Ship_To__c)
            isAllCountriesSame = true;
        else 
            isAllCountriesSame = false;            
        
        if(acc.GE_PW_Existing_Customer_New_Address__c != null){
            isExistingCustomer = true;  
            existingCustomerObj = [select id, name, shippingCountry from Account where id =: acc.GE_PW_Existing_Customer_New_Address__c];
        }                                
        if(isExistingCustomer == true){
            if(existingCustomerObj.ShippingCountry == acc.GE_PW_Country_Quote_To_Sold_To_HQ__c){
                if(RiskType == 'Low') isLowRisk = true;
                else if(RiskType == 'High') isHighRisk = true;               
            }
            else if(existingCustomerObj.ShippingCountry != acc.GE_PW_Country_Quote_To_Sold_To_HQ__c){
                isHighRisk = true;
                RiskType = 'High';               
            } 
        }        
        else{
            if(isAllCountriesSame == true && RiskType == 'Low'){
                isLowRisk = true;
                RiskType = 'Low';
            }
            else if( (isAllCountriesSame == true && RiskType == 'High') || isAllCountriesSame == false ){
                isHighRisk = true;      
                RiskType = 'High';                                                                                        
            }            
        }
        system.debug('RiskType -----3---- : '+RiskType);        
        
        List<GE_PW_CMFtoISOCountryName__c> CMFtoISO=new List<GE_PW_CMFtoISOCountryName__c>([select id,GE_PW_CMF_Name__c,GE_PW_Country__c from GE_PW_CMFtoISOCountryName__c where GE_PW_CMF_Name__c != null]);
        Map<String,String> riskMap=new  Map<String,String>();
        Map<Id,GE_HQ_Country__c> countryMap=new  Map<Id,GE_HQ_Country__c>([select id,name,GE_OG_Finance_Country_Risk__c,GE_OG_Tax_ID_Format__c from GE_HQ_Country__c where GE_OG_Finance_Country_Risk__c != null ]);
        
        for(GE_PW_CMFtoISOCountryName__c cmf:CMFtoISO){
            riskMap.put(cmf.GE_PW_CMF_Name__c,cmf.GE_PW_Country__c);
        }
        
        string countryId;
        if(!String.isBlank(acc.ShippingCountry)){
            countryId=riskMap.get(acc.shippingCountry);
        }
        else{
            countryId=riskMap.get(acc.BillingCountry);
        }
        GE_HQ_Country__c country=countryMap.get(countryId);
        
        if ( country != null ) {
            if(country.GE_OG_Finance_Country_Risk__c == 'Low'){
                RiskType = 'Low'; }
            
            else if(country.GE_OG_Finance_Country_Risk__c == 'Medium'){
                RiskType = 'Medium' ;
            }       
            else {
                RiskType = 'High' ;
            }
        }
        //Satya P Added 10/04/14 for R-18999 Always process any countries marked with a KYC CIS flag "checked" as high risk.        
        if(QuoteToCountryObj != null && QuoteToCountryObj.GE_PW_CIS_Non_CIS__c == true)
            RiskType = 'High' ;
        if(BillToCountryObj != null && BillToCountryObj.GE_PW_CIS_Non_CIS__c == true)
            RiskType = 'High' ;
        if(ShipToCountryObj != null && ShipToCountryObj.GE_PW_CIS_Non_CIS__c == true)
            RiskType = 'High' ;
        system.debug('RiskType -----4---- : '+RiskType);
    }
    
    public PageReference Submit()
    {
        
        boolean error = false;
        string URLId ='';
        List<GE_PRM_KYC_Termination_Checklist__c> kycidList = new List<GE_PRM_KYC_Termination_Checklist__c >();
        kycidList=[Select Id,GE_HQ_Vat_Format_atchmnt__c,GE_HQ_VAT_Tax_ID__c,GE_HQ_Vat_Reason_Code__c,GE_HQ_Account__c,GE_HQ_Status__c,
                   GE_PW_KYC_Type__c from GE_PRM_KYC_Termination_Checklist__c where GE_HQ_Account__c=:accid and GE_PW_KYC_Type__c!='Modify Account'];
         if (kycidList.size() > 0 )
        kycid = kycidList [0];
        String val3= acc.GE_OG_Buss_Tier3__c;
        String val5 = acc.GE_OG_Buss_Tier4__c; 
        if(acc.Oil_Gas_Parent_Account__c!=null)
            URLId = acc.Oil_Gas_Parent_Account__c;
        else
            URLId = acc.Id;
        if(creditq1 == false && creditq2 == false && isCreditLevel2 == false)  
        {
            if ( finc.GE_OG_Comment__c == Null && finc.GE_OG_Approx_of_Employees__c == Null && finc.GE_OG_Approx_yrs_in_Business__c == Null && finc.GE_OG_Currnt_Yr_Sales__c == Null && finc.GE_OG_Pre_Yr_Sales__c == Null)
            {
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'You must enter at least one value for any of these fields(Current Year Sales(Revenues),Previous Year Sales(Revenues),Approximate # of Employees,Approximate # Years in Business,Comments) in the Level 3 section to proceed.'));  
                error = true;
            }
        }       
        if (acc.GE_OG_Buss_Tier1__c == null)
        {       
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'You must enter Tier 1 P&L'));  
            error = true;       
        }
        if (acc.GE_OG_Buss_Tier2__c == null)
        {       
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'You must enter Tier 2 P&L'));  
            error = true;       
        }
        if (acc.GE_OG_Buss_Tier3__c == null)
        {       
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'You must enter Tier 3 P&L'));  
            error = true;       
        }
        if (acc.GE_OG_Buss_Tier4__c == null)
        {       
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'You must enter Tier 4 P&L'));  
            error = true;       
        }
         if ( (acc.GE_OG_Buss_Tier3__c == 'SS - Subsea' || acc.GE_OG_Buss_Tier3__c == 'SS - Offshore' || acc.GE_OG_Buss_Tier3__c == 'SS - Services' || acc.GE_OG_Buss_Tier3__c == 'SS - Well Stream' || acc.GE_OG_Buss_Tier3__c == 'D&S - AL' || acc.GE_OG_Buss_Tier3__c == 'D&S - PC' || acc.GE_OG_Buss_Tier3__c == 'D&S - Logging' || acc.GE_OG_Buss_Tier3__c == 'D&S - Drilling' || acc.GE_OG_Buss_Tier3__c == 'In Line Inspection' || acc.GE_OG_Buss_Tier3__c == 'Integrity Services') && acc.GE_OG_Buss_Tier4__c== null)
        {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Please Select Tier 4 P&L as N/A'));  
            error = true;  
         }
        if (error) 
            return null;
        else 
        {
            if (kycid != null )
            {        
                //kycid.GE_HQ_VAT_Tax_ID__c=VatID;
                //kycid.GE_HQ_Vat_Reason_Code__c=Vatreason;
                kycid.GE_HQ_Status__c='Manual Due Diligence Approved';
                finc.GE_OG_Finance_Status__c = 'In Progress';
                System.debug('*******************in KYC not null*********************************************');                  
                List<GE_OG_Finance_Details__c> fincList= new List<GE_OG_Finance_Details__c>();
                if (finc !=null) {
                    if(creditq1 == True)
                    {
                        if(creditq2 == False)
                        {
                            //finc.GE_OG_Finance_Status__c ='Completed';
                            finc.GE_OG_Resubmitted__c = False;
                            finc.GE_OG_Finan_TC__c = 'Advanced Payment';
                            finc.GE_OG_Finance_Credit_Limit__c = '$50,000';
                            finc.GE_OG_Actual__c ='$50,000';
                            finc.GE_OG_Cust_accepted__c = true;
                            acc.GE_OG_AccFin_Status__c='Completed';
                            acc.Finance__c = finc.Name;
                        }         
                    }
                    
                    if(creditq2 == True)
                    {
                        AccountTier=[Select Id,GE_OG_Buss_Tier1__c,GE_OG_Buss_Tier2__c,GE_OG_Buss_Tier3__c,GE_OG_Buss_Tier4__c From Account where Id=:kycid.GE_HQ_Account__c];
                        List<GE_OG_BussTierToFince__c> BussTierToFince = [SELECT Name,GE_OG_Buss_Tier_RL__r.Name,GE_OG_Buss_Tier_RL__c,GE_OG_Fin_Credit_Lmt__c,GE_OG_Fin_Ctry_Risk__c,GE_OG_Fin_Risk__c,GE_OG_Fin_TC__c FROM GE_OG_BussTierToFince__c where GE_OG_Buss_Tier_RL__r.Name =: AccountTier.GE_OG_Buss_Tier3__c and GE_OG_Fin_Risk__c ='Fast Lane' and GE_OG_Fin_Ctry_Risk__c = 'Low' limit 1 ];
                        if (BussTierToFince.size() > 0 )
                        {
                            finc.GE_OG_Finan_TC__c = BussTierToFince[0].GE_OG_Fin_TC__c;
                            finc.GE_OG_Finance_Credit_Limit__c = BussTierToFince[0].GE_OG_Fin_Credit_Lmt__c;
                            finc.GE_OG_Actual__c = BussTierToFince[0].GE_OG_Fin_Credit_Lmt__c;
                            finc.GE_HQ_Finance_Risk_Score__c = BussTierToFince[0].GE_OG_Fin_Risk__c;
                        }
                        finc.GE_OG_Finance_Status__c = 'In Progress';
                        if (acc.GE_HQ_Request_Status__c == 'CMF Approved' )
                            finc.GE_OG_Finance_Status__c = 'Completed';            
                        finc.GE_OG_Resubmitted__c = true;
                        finc.GE_OG_Fast_Lane_Criteria__c = true;
                        acc.GE_OG_AccFin_Status__c='Completed';
                        acc.Finance__c = finc.Name;
                    }
                    
                    if ( finc.GE_OG_Fast_Lane_Criteria__c == true )
                        finc.GE_OG_Finance_Status__c = 'Completed';     
                    
                    if(finc.GE_OG_Cust_accepted__c == true || finc.GE_OG_Fast_Lane_Criteria__c == true)           
                        finc.GE_OG_level1_met__c = 'Yes';                    
                    else
                        finc.GE_OG_level1_met__c = 'No'; 
                    system.debug(' checking for value......................................'+finc.GE_OG_level1_met__c);
                    system.debug(' Exit-update enter into submit '+finc); 
                    
                    update finc;
                    update kycid;
                    update acc;                
                    
                    
                    list<GE_OG_ERP_Detail__c> checkerp=[select id,GE_OG_ERP_Account__c,GE_OG_KYC__c from GE_OG_ERP_Detail__c where GE_OG_ERP_Account__c=:acc.id and GE_OG_KYC__c =: kycid.id];
                    if(checkerp.size()>0)
                    {
                        GE_OG_ERP_Detail__c ERPs = [select id,GE_OG_CoE_Rec_Finance_TCs__c from GE_OG_ERP_Detail__c where id=:checkerp[0].id ];
                        ERPs.GE_OG_CoE_Rec_Finance_TCs__c = finc.GE_OG_Finan_TC__c;
                        update ERPs;
                    }
                    acc.Finance__c = finc.Id;
                    update acc;
                   /* Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                    //email.setToAddresses(userid);
                    String[] userid= new String[]{UserInfo.getUserEmail()};
                        system.debug('*****Email Address of the User ************'+userid);
                    mail.setSubject('Finance Rereview');
                    mail.setToAddresses(userid);
                    mail.setHtmlBody('Finance Retrigger has been triggerd for Account:'+acc.Name);    
                    Messaging.SendEmailResult[] r = 
                        Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});*/
                    return new PageReference('/'+URLId);
                }
            }
         
            return new PageReference('/'+URLId);   
        }     
      
       
    }
    
    public pageReference GoBack(){
        kycid=[Select Id,GE_HQ_Vat_Format_atchmnt__c,GE_HQ_VAT_Tax_ID__c,GE_HQ_Vat_Reason_Code__c,GE_HQ_Account__c,GE_HQ_Status__c,GE_PW_KYC_Type__c from GE_PRM_KYC_Termination_Checklist__c where GE_HQ_Account__c=:accid and GE_PW_KYC_Type__c!='Modify Account'];
        finc=[Select Id,GE_OG_Actual__c,GE_OG_Cust_accepted__c,GE_OG_Comment__c,GE_OG_Credit_Line_Request__c,GE_OG_Currnt_Yr_Sales__c,GE_OG_Approx_of_Employees__c,GE_OG_Pre_Yr_Sales__c,GE_OG_Approx_yrs_in_Business__c,GE_OG_level1_met__c,GE_OG_Fast_Lane_Criteria__c from GE_OG_Finance_Details__c where GE_OG_Account__c=:acc.Id AND GE_OG_KYC__c=:kycid.id limit 1];
        list<GE_OG_ERP_Detail__c> newerp = [select id from GE_OG_ERP_Detail__c where GE_OG_KYC__c =: kycid.id limit 1];
        if (fincexist == false )
            delete finc;
        if (  kycexist == false )
        {           
            if (newerp.size() > 0)
                delete newerp[0];
            delete kycid;
        }
        acc.GE_PW_KYC_Status__c = '';       
        acc.GE_OG_Buss_Tier1__c = Tier1;
        acc.GE_OG_Buss_Tier2__c = Tier2;
        acc.GE_OG_Buss_Tier3__c = Tier3;
        acc.GE_OG_Buss_Tier4__c = Tier4;
        acc.GE_PW_Select_Type_of_Business__c = Businesstype;
        update acc;     
        
        //return new PageReference('/'+accid);
        string URLId ='';
        if(acc.Oil_Gas_Parent_Account__c!=null)
            URLId = acc.Oil_Gas_Parent_Account__c;
        else
            URLId = acc.Id;
            return new PageReference('/'+URLId); 
    }
    
    public void onchangeType_of_Business(){  
        //  Businesstype = acc.GE_PW_Select_Type_of_Business__c;
        if (acc.GE_PW_Select_Type_of_Business__c == 'Publically Traded Company' || acc.GE_PW_Select_Type_of_Business__c == 'Subsidiary of Public Traded Company' || Countryresults)
            isCreditLevel2 = true;
        else    
            isCreditLevel2 = false;
    }
    
}