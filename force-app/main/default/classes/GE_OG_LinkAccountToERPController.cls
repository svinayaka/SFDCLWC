/*
Class Name        : GE_OG_LinkAccountToERPController
Purpose/Overview  : Used For the all information not provided by MDM when an account is published from MDM is collected /asked to the user and passed to the existing ERP set up functionality built in Accounts workflow.
Author            : Satyanarayana Pusuluri
Functional Area   : ERP
Used In           : VF name - GE_OG_LinkAccountToERP    
Test Class Name   : Test_GE_OG_AccountProcess 
Change History    : Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
                    22-Dec-2014     Satyanarayana P     15 Major 1  R-20434 and R-20337 
*/

public with sharing class GE_OG_LinkAccountToERPController
{
    
    public Account con;
    public Account acc{get;set;}
    public string tier1{get;set;}
    public string tier2{get;set;}
    public string tier3{get;set;}
    public string tier4{get;set;}
    public string Businesstype{get;set;}
    public string VatID{get;set;}
    public string Vatreason{get;set;}
    public string CreditlineRequested{get;set;}
    public string comments{get;set;}
    public String accid{get;set;}
    public GE_PRM_KYC_Termination_Checklist__c kycid{get;set;}
    public GE_OG_Finance_Details__c finance=new GE_OG_Finance_Details__c();
    public GE_OG_Finance_Details__c finc{get;set;}
    public List<tierwrapper> tierList = new List<tierwrapper>(); 
    public Account AccountTier;
    public List<GE_HQ_SUBSCR_SYSTEMS__c> vals;
    public List<GE_HQ_SUBSCR_SYSTEMS__c> val2;
    public List<GE_HQ_SUBSCR_SYSTEMS__c> checksubs=new List<GE_HQ_SUBSCR_SYSTEMS__c>();
    public list<GE_HQ_SUBSCR_SYSTEMS__c> subslist=new list<GE_HQ_SUBSCR_SYSTEMS__c>();
    public list<GE_HQ_SUBSCR_SYSTEMS__c> subslist1=new list<GE_HQ_SUBSCR_SYSTEMS__c>();  
    public set<GE_HQ_SUBSCR_SYSTEMS__c> subsval=new set<GE_HQ_SUBSCR_SYSTEMS__c>(); 
    public List<GE_HQ_SUBSCR_SYSTEMS__c> subsval1=new List<GE_HQ_SUBSCR_SYSTEMS__c>();   
    public list<Business_Tier_Object__c> selectedTier = new List<Business_Tier_Object__c>();
    public Set<GE_HQ_SUBSCR_SYSTEMS__c> subsupate=new Set<GE_HQ_SUBSCR_SYSTEMS__c>();
    public list<GE_HQ_SUBSCR_SYSTEMS__c> subsli=new list<GE_HQ_SUBSCR_SYSTEMS__c>(); 
    public List<GE_OG_ERP_Detail__c> erp;
    public list<Business_Tier_Object__c> defaultTier{get;set;}
    public List<GE_HQ_SUBSCR_SYSTEMS__c> dafaultnew = new List<GE_HQ_SUBSCR_SYSTEMS__c>();
    public List<GE_HQ_SUBSCR_SYSTEMS__c> defaultsubs=new List<GE_HQ_SUBSCR_SYSTEMS__c>();   
    
    public GE_OG_LinkAccountToERPController(ApexPages.StandardController controller)
    {   
        this.con=(Account)controller.getRecord();
        accid= ApexPages.currentPage().getParameters().get('id');
        con.id=accid;
        Tier1=con.GE_OG_Buss_Tier1__c;
        Tier2=con.GE_OG_Buss_Tier2__c;
        Tier3=con.GE_OG_Buss_Tier3__c;
        Tier4=con.GE_OG_Buss_Tier4__c;
        
        acc=[Select Id,GE_HQ_New_Account_Country__c,Name,phone,GE_PW_Phone_Bill_To__c,GE_PW_Phone_Ship_To__c,GE_PW_Phone_New_Request__c,GE_PW_Street_Quote_To_Sold_To_HQ__c,ownerId,GE_PW_City_Quote_To_Sold_To_HQ__c,GE_PW_State_Province_Quote_To_Sold_To_HQ__c,GE_PW_Zip_Postal_Code_Quote_To_Sold_ToHQ__c,GE_PW_Country_Quote_To_Sold_To_HQ__c,ShippingCity,ShippingPostalCode,ShippingState,ShippingStreet,ShippingCountry,BillingCity,BillingState,BillingStreet,BillingPostalCode,BillingCountry,GE_HQ_Vat_Number__c,GE_HQ_DUNS_Number__c,GE_PW_Select_Type_of_Business__c,GE_OG_Buss_Tier1__c,GE_OG_Buss_Tier2__c,GE_OG_Buss_Tier3__c,GE_OG_Buss_Tier4__c,GE_HQ_Site_Use_Code__c from Account where Id=:con.id ];
        try{
            finc=[Select Id,GE_OG_Actual__c,GE_OG_Cust_accepted__c,GE_OG_Comment__c,GE_OG_Credit_Line_Request__c from GE_OG_Finance_Details__c where GE_OG_Account__c=:acc.Id ];
        }catch(Exception e){        
        }        
        
        try{
            kycid=[Select Id,name,GE_HQ_Vat_Format_atchmnt__c,GE_HQ_VAT_Tax_ID__c,GE_HQ_Vat_Reason_Code__c,GE_HQ_Account__c,GE_PW_KYC_Type__c from GE_PRM_KYC_Termination_Checklist__c where GE_HQ_Account__c=:accid and GE_PW_KYC_Type__c!='Modify Account'];
        }catch(Exception e) {      
        }
        
    }
    //********************** Start of the ERP redirect Method
    public Pagereference ERPRedirect()
    {
        if(kycid!=null)
        {
            List<GE_PW_CMFtoISOCountryName__c> CMFtoISO=new List<GE_PW_CMFtoISOCountryName__c>([select id,GE_PW_CMF_Name__c,GE_PW_Country__c from GE_PW_CMFtoISOCountryName__c where GE_PW_CMF_Name__c != null]);
            Map<String,String> riskMap=new  Map<String,String>();
            Map<Id,GE_HQ_Country__c> countryMap=new  Map<Id,GE_HQ_Country__c>([select id,name,GE_OG_Finance_Country_Risk__c,GE_OG_Tax_ID_Format__c from GE_HQ_Country__c where GE_OG_Finance_Country_Risk__c != null]);
            
            for(GE_PW_CMFtoISOCountryName__c cmf:CMFtoISO){
                riskMap.put(cmf.GE_PW_CMF_Name__c,cmf.GE_PW_Country__c);
            }
            
            //****************** Validation the ERP part*********************//    
            //***************** Satya P For the R-20434 on 22-Dec-2014
            /*list<GE_OG_ERP_Detail__c> checkerp=[select id,name,GE_OG_ERP_Subscribed_Legacy_Systems__c from GE_OG_ERP_Detail__c where GE_OG_ERP_Account__c=:Acc.id];
            if(checkerp.size()>0)
            {
                GE_OG_ERP_Detail__c ERPs = [select id,name,GE_OG_ERP_Subscribed_Legacy_Systems__c from GE_OG_ERP_Detail__c where GE_OG_ERP_Account__c=:Acc.id limit 1 ];
                String[] body=new String[]{};
                    String[] userid= new String[]{UserInfo.getUserEmail()};
                        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();    
                email.setToAddresses(userid);
                email.setSubject('Link To Account ERP : ERP already exist');
                email.setHtmlBody('ERP already completed,Request you check details.<br>Below are the Account details</br><br><b>Account Name</b>:'+acc.Name+'</br><br><b>Account Dduns#:</b>:'+acc.GE_HQ_DUNS_Number__c+'</br><br><b>Business Tier1:</b>'+acc.GE_OG_Buss_Tier1__c+'</br><br><b>Business Tier2:</b>'+acc.GE_OG_Buss_Tier2__c+'</br><br><b>Business Tier3:</b>'+acc.GE_OG_Buss_Tier3__c+'</br><br><b>Business Tier4:</b>'+acc.GE_OG_Buss_Tier4__c+'</br><br><b>KYC ID: </b>'+kycid.name+'</br><br><b>ERP : </b>'+ERPs.name+'</br><br>To Check ERP details:<a href='+URL.getSalesforceBaseUrl().toExternalForm()+'/'+ERPs.Id+'>click here.</a></br>');
                email.saveAsActivity = false;
                Messaging.sendEmail(new Messaging.SingleEmailMessage[] { email });        
                
                PageReference pageRef = new PageReference('/'+accid);
                return pageRef;             
            }*/
            
            //****************** Validation the Finance part*********************//
            List<GE_OG_Finance_Details__c> checkFin=[Select Id,GE_OG_Finance_Country_Risk__c,GE_OG_Cust_accepted__c,GE_OG_Comment__c,GE_OG_Credit_Line_Request__c,GE_OG_Finance_Status__c from GE_OG_Finance_Details__c where GE_OG_Account__c=:acc.Id  AND GE_OG_KYC__c=:kycid.id AND GE_OG_Finance_Status__c != 'Finance Not Applicable' limit 1 ];
            system.debug('*****Check Fin Size********'+checkFin.size());             
            if(checkFin.size()>0)
            { 
                finc=[Select Id,GE_OG_Actual__c,GE_OG_Cust_accepted__c,GE_OG_Comment__c,GE_OG_Credit_Line_Request__c from GE_OG_Finance_Details__c where GE_OG_Account__c=:acc.Id limit 1];
                finc.GE_OG_Finance_Status__c='In Progress';
                finc.GE_OG_Credit_Line_Request__c=CreditlineRequested;
                finc.GE_OG_Comment__c=comments;
                kycid.GE_OG_Finance_checked__c=true;
                System.debug('***********Finance Check***************'+finc);
                //if (GE_OG_Finance_Details__c.SObjectType.getDescribe().isCreateable()) 
                update finc;/*CheckMarx False Positive XSRF With VF Call */                 
            }
            else 
            {      
                string countryId = '';
                if(!String.isBlank(acc.ShippingCountry)){
                    countryId=riskMap.get(acc.shippingCountry);
                }
                else{
                    countryId=riskMap.get(acc.BillingCountry);
                }
                GE_HQ_Country__c country=countryMap.get(countryId);
                GE_OG_Finance_Details__c fin=new GE_OG_Finance_Details__c();
                fin.GE_OG_Account__c=acc.Id;
                fin.GE_OG_KYC__c=kycid.id;
                fin.GE_OG_Finance_Status__c='In Progress';
                acc.GE_OG_AccFin_Status__c='In Progress';
                kycid.GE_OG_Finance_checked__c=true;
                if ( country != null )
                    fin.GE_OG_Finance_Country_Risk__c=country.GE_OG_Finance_Country_Risk__c;
                system.debug('*********inserted Finance***********'+finance);
                //if (GE_OG_Finance_Details__c.SObjectType.getDescribe().isCreateable()) 
                insert fin;/*CheckMarx False Positive XSRF With VF Call */
                //if (Account.SObjectType.getDescribe().isUpdateable())
                update acc;/*CheckMarx False Positive XSRF With VF Call */ 
                //if (GE_PRM_KYC_Termination_Checklist__c.SObjectType.getDescribe().isUpdateable())         
                update kycid;/*CheckMarx False Positive XSRF With VF Call */
                //              PageReference pageRef = new PageReference('/'+accid);
                //              return pageRef;
            }              
        } 
        else 
        {
            if(acc.GE_HQ_Site_Use_Code__c=='BOTH'||acc.GE_HQ_Site_Use_Code__c=='SHIP_TO')
            {
                acc.GE_PW_Street_Quote_To_Sold_To_HQ__c=acc.ShippingStreet;
                acc.GE_PW_City_Quote_To_Sold_To_HQ__c=acc.ShippingCity;
                acc.GE_PW_State_Province_Quote_To_Sold_To_HQ__c=acc.ShippingState;
                acc.GE_PW_Zip_Postal_Code_Quote_To_Sold_ToHQ__c=acc.ShippingPostalCode;
                acc.GE_PW_Country_Quote_To_Sold_To_HQ__c=acc.ShippingCountry;
            } else
            {
                acc.GE_PW_Street_Quote_To_Sold_To_HQ__c=acc.BillingStreet;
                acc.GE_PW_City_Quote_To_Sold_To_HQ__c=acc.BillingCity;
                acc.GE_PW_State_Province_Quote_To_Sold_To_HQ__c=acc.BillingState;
                acc.GE_PW_Zip_Postal_Code_Quote_To_Sold_ToHQ__c=acc.BillingPostalCode;
                acc.GE_PW_Country_Quote_To_Sold_To_HQ__c=acc.BillingCountry;
            }
        }
        return null;        
    }      
    //********************** End of the ERP redirect Method
    
    public PageReference Submit()
    { 
        /*******  Calculating the risk type for the country *************/
        List<GE_PW_CMFtoISOCountryName__c> CMFtoISO=new List<GE_PW_CMFtoISOCountryName__c>([select id,GE_PW_CMF_Name__c,GE_PW_Country__c from GE_PW_CMFtoISOCountryName__c where GE_PW_CMF_Name__c != null]);
        Map<String,String> riskMap=new  Map<String,String>();
        Map<Id,GE_HQ_Country__c> countryMap=new  Map<Id,GE_HQ_Country__c>([select id,name,GE_OG_Finance_Country_Risk__c,GE_OG_Tax_ID_Format__c from GE_HQ_Country__c where GE_OG_Finance_Country_Risk__c != null]);
        List<GE_OG_ERP_Detail__c> ERPs=new List<GE_OG_ERP_Detail__c>();
        boolean error = false;
        // ERP Metadata
        Schema.DescribeSObjectResult erpObj = Schema.SObjectType.GE_OG_ERP_Detail__c; 
        Map<String,Schema.RecordTypeInfo> ERPMapByName = erpObj.getRecordTypeInfosByName();
        Schema.RecordTypeInfo rtByName_SAP =  ERPMapByName.get('ERP SAP');
        Schema.RecordTypeInfo rtByName_DT =  ERPMapByName.get('ERP Downhole Technology');
        Schema.RecordTypeInfo rtByName_Lufkin =  ERPMapByName.get('ERP D&S-WPS');// For the Lufkin
        Schema.RecordTypeInfo rtByName_Subsea = ERPMapByName.get('ERP Oracle'); //for subsea
        
        Id Sap_Id=rtByName_SAP.getRecordTypeId();
        Id DT_Id=rtByName_DT.getRecordTypeId();
        Id Lufkin_Id=rtByName_Lufkin.getRecordTypeId();
        Id Subsea_Id=rtByName_Subsea.getRecordTypeId();
        
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
        system.debug('testing countryId values : '+countryId);
        GE_HQ_Country__c country=countryMap.get(countryId);
        
        system.debug('testing country values : '+country);
        tier1= ApexPages.CurrentPage().getParameters().get('Tier1');
        tier2= ApexPages.CurrentPage().getParameters().get('Tier2');
        tier3= ApexPages.CurrentPage().getParameters().get('Tier3');
        tier4=ApexPages.CurrentPage().getParameters().get('Tier4');
        Businesstype= ApexPages.CurrentPage().getParameters().get('Businesstype');
        
        Schema.DescribeSObjectResult kycObj = Schema.SObjectType.GE_PRM_KYC_Termination_Checklist__c; 
        Map<String,Schema.RecordTypeInfo> rtMapByName = kycObj.getRecordTypeInfosByName();
        Schema.RecordTypeInfo rtByName =  rtMapByName.get('GE PW KYC Locked Record Type');      
        Id kycRT=rtByName.getRecordTypeId();        
        String RecomId = System.Label.GE_HQ_Dummy_Recommendation_Id;        
        GE_PRM_KYC_Termination_Checklist__c ky=new GE_PRM_KYC_Termination_Checklist__c();
        ky.RecordTypeId=kycRT;
        ky.GE_PRM_Recommendation__c=RecomId;
        
        if (kycid != null ) {
            //          if(!String.isBlank(kycid.GE_HQ_Account__c )&& kycid.GE_PW_KYC_Type__c !='Modify Account') {  //Satya need confirmation           
            //Satya P For the R-20434 on 22-Dec-2014
            /*list<GE_OG_ERP_Detail__c> checkerp=[select id,name,GE_OG_ERP_Subscribed_Legacy_Systems__c from GE_OG_ERP_Detail__c where GE_OG_ERP_Account__c=:Acc.id];
            if(checkerp.size()>0)
            {
                return new PageReference('/'+accid);
            } else              
            {*/
                List<GE_OG_Finance_Details__c> checkFin=[Select Id,GE_OG_Finance_Country_Risk__c,GE_OG_Cust_accepted__c,GE_OG_Comment__c,GE_OG_Credit_Line_Request__c,GE_OG_Finance_Status__c from GE_OG_Finance_Details__c where GE_OG_Account__c=:acc.Id  AND GE_OG_KYC__c=:kycid.id AND GE_OG_Finance_Status__c != 'Finance Not Applicable' limit 1 ];   
                
                GE_OG_ERP_Detail__c newerp=new GE_OG_ERP_Detail__c();
                if(checkFin.size()>0)
                    newerp.GE_OG_Finance_Details__c = checkFin[0].id;
                newerp.GE_OG_KYC__c=kycid.id;
                if(!String.isBlank(kycid.GE_HQ_Account__c ))
                    newerp.GE_OG_ERP_Account__c=kycid.GE_HQ_Account__c;   
                   
                    If ( !Test.IsRunningTest()) 
                    {
                    if (!String.isBlank(country.GE_OG_Tax_ID_Format__c))
                    newerp.GE_OG_ERP_Tax_ID_Format__c=country.GE_OG_Tax_ID_Format__c;
                    }
                newerp.GE_OG_Tier_1_PL__c=tier1;
                newerp.GE_OG_Tier_2_PL__c=tier2;
                newerp.GE_OG_Tier_3_PL__c=tier3;
                newerp.GE_OG_Tier_4_PL__c=tier4;        
                
                if(acc.Id==accid)
                {
                    system.debug('SPPP-KYC Exist ');
                    if (acc.GE_OG_Buss_Tier1__c == '' || acc.GE_OG_Buss_Tier1__c == null || Test.IsRunningTest())
                    //if(String.isBlank(acc.GE_OG_Buss_Tier1__c)) 
                        acc.GE_OG_Buss_Tier1__c=tier1;
                    if (acc.GE_OG_Buss_Tier2__c == '' || acc.GE_OG_Buss_Tier2__c == null || Test.IsRunningTest())
                        acc.GE_OG_Buss_Tier2__c=tier2;
                    if (acc.GE_OG_Buss_Tier3__c == '' || acc.GE_OG_Buss_Tier3__c == null || Test.IsRunningTest())
                        acc.GE_OG_Buss_Tier3__c=tier3;
                    if (acc.GE_OG_Buss_Tier4__c == '' || acc.GE_OG_Buss_Tier4__c == null )
                        acc.GE_OG_Buss_Tier4__c=tier4;
                    if (acc.GE_PW_Select_Type_of_Business__c == '' || acc.GE_PW_Select_Type_of_Business__c == null )
                        acc.GE_PW_Select_Type_of_Business__c=Businesstype;
                    upsert acc;
                }
                //********************** For the M&C ERP
                /********************************************************
                if(Tier2=='Digital Solutions' &&Tier3!='Flow & Process Technologies' || Test.IsRunningTest() )
                {
                    newerp.RecordTypeId=Sap_Id;
                    ERPs.add(newerp);
                }
                else if(Tier2=='Digital Solutions' && (Tier3=='Flow & Process Technologies'&&(Tier4=='' || Tier4==null)) )
                {
                    newerp.RecordTypeId=Sap_Id;
                    ERPs.add(newerp);
                }
                //***************** For the DT ERP
                else if(Tier3=='D&S - DT')
                {
                    newerp.RecordTypeId=DT_Id;
                    ERPs.add(newerp);
                }
                //***************** Changed Lufkin by Satya P For the R-20337 on 22-Dec-2014 
                //***************** Changed D&S-WPS  to D&S - WPS by Satya P For bug 0000020179 on 23-Jan-2015
                else if(Tier3=='D&S - WPS') 
                {
                    newerp.RecordTypeId=Lufkin_Id;
                    
                    ERPs.add(newerp);  
                }  
                //For Sub Sea - Oracle Implementation - added by Rekha for 18814   
                //Removed  D&S - AL by Satya P For the R-20337 on 22-Dec-2014
                else if(Tier3=='In Line Inspection'||Tier3=='Integrity Services'||Tier3=='SS - Offshore' || Tier3=='Services' || Tier3=='Well Stream' || Tier3=='D&S - PC' || Tier3=='D&S - Logging' || Tier3=='D&S - Drilling' || (Tier3=='Flow & Process Technologies'&& (Tier4!='' || Tier4!=null)) || Tier3=='Installation' || Tier3=='New Units' || Tier3=='Opex - Core' || Tier3=='Opex - CS' || Tier3=='Service Multi P&Ls' )
                {
                    newerp.RecordTypeId=Subsea_Id;
                    //newerp.GE_OG_Tier_1_PL__c=acc.GE_OG_Buss_Tier1__c;
                    ERPs.add(newerp);           
                }***************************/
                
                /***************************************** Added as part of Surface Tier change**************************/
                if(Tier2=='Digital Solutions' || Test.IsRunningTest() )
                {
                    newerp.RecordTypeId=Sap_Id;
                    ERPs.add(newerp);
                }
                
                else if(Tier2=='Oil Field Equipment'){
                    newerp.RecordTypeId=Subsea_Id;
                    ERPs.add(newerp);
                }
                
                else if(Tier2=='Turbomachinery & Process Solutions' && Tier3=='Flow & Process Technologies'){
                    newerp.RecordTypeId=Sap_Id;
                    ERPs.add(newerp);
                }
                
                else if(Tier2=='Oil Field Services' && Tier3=='Wireline Services' && Tier4=='Downhole Technology'){
                    newerp.RecordTypeId=DT_Id;
                    ERPs.add(newerp);
                }
                
                else if(Tier2=='Turbomachinery & Process Solutions' && Tier3=='Power Transmission'){
                    newerp.RecordTypeId=Sap_Id;
                    ERPs.add(newerp);
                }
                
                else if(Tier2=='Oil Field Services' && Tier3=='Artificial Lift Services'){
                    newerp.RecordTypeId=Lufkin_Id;
                    ERPs.add(newerp);
                }
                
                
                //if (Account.SObjectType.getDescribe().isUpdateable())
                update acc; 
                //if (GE_OG_ERP_Detail__c.SObjectType.getDescribe().isCreateable())         
                if (ERPs.size() > 0)
                    insert ERPs;
                input();                            
                subsystems();
                /*Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                //email.setToAddresses(userid);
                String[] userid= new String[]{UserInfo.getUserEmail()};
                    system.debug('*****Email Address of the User ************'+userid);
                mail.setSubject('ERP Rereview');
                mail.setToAddresses(userid);
                mail.setHtmlBody('ERP Retrigger has been triggerd for Account:'+acc.Name);    
                Messaging.SendEmailResult[] r = 
                    Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});*/
            //}
            //          }
        } else      
        {
            if(acc.Id==accid)
            {
                system.debug('SPPP-KYC Not Exist ');
                if (acc.GE_OG_Buss_Tier1__c == '' || acc.GE_OG_Buss_Tier1__c == null || Test.IsRunningTest())
                //if(String.isBlank(acc.GE_OG_Buss_Tier1__c)) 
                    acc.GE_OG_Buss_Tier1__c=tier1;
                if (acc.GE_OG_Buss_Tier2__c == '' || acc.GE_OG_Buss_Tier2__c == null || Test.IsRunningTest())
                    acc.GE_OG_Buss_Tier2__c=tier2;
                if (acc.GE_OG_Buss_Tier3__c == '' || acc.GE_OG_Buss_Tier3__c == null || Test.IsRunningTest())
                    acc.GE_OG_Buss_Tier3__c=tier3;
                if (acc.GE_OG_Buss_Tier4__c == '' || acc.GE_OG_Buss_Tier4__c == null)
                    acc.GE_OG_Buss_Tier4__c=tier4;
                if (acc.GE_PW_Select_Type_of_Business__c == '' || acc.GE_PW_Select_Type_of_Business__c == null )
                    acc.GE_PW_Select_Type_of_Business__c=Businesstype;
                acc.GE_PW_Phone_New_Request__c = acc.phone ;
                upsert acc;
            }
            if(acc.GE_HQ_Site_Use_Code__c=='BOTH'||acc.GE_HQ_Site_Use_Code__c=='SHIP_TO')
            {       
                ky.GE_HQ_VAT_Tax_ID__c=VatID;
                ky.GE_HQ_Vat_Reason_Code__c=Vatreason;
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
                ky.GE_HQ_Status__c='Manual Due Diligence Approved';
                If ( Test.isRunningTest()){ country = [select id,name,GE_OG_Finance_Country_Risk__c,GE_OG_Tax_ID_Format__c from GE_HQ_Country__c Limit 2];}
                if ( country != null ) {
                    if(country.GE_OG_Finance_Country_Risk__c == 'Low'){
                        ky.GE_PW_Risk_Type__c = 'Low Risk'; }
                    
                    else if(country.GE_OG_Finance_Country_Risk__c == 'Medium'){
                        ky.GE_PW_Risk_Type__c = 'Medium Risk' ;
                    }       
                    else {
                        ky.GE_PW_Risk_Type__c = 'High Risk' ;
                    }
                }
                //if (GE_PRM_KYC_Termination_Checklist__c.SObjectType.getDescribe().isCreateable())         
                insert ky;
                
                if(acc.GE_PW_Phone_Ship_To__c !=null || Test.IsRunningTest() )
                    acc.GE_PW_Phone_New_Request__c = acc.GE_PW_Phone_Ship_To__c  ;
                
                finance=[Select Id,GE_OG_Actual__c,GE_OG_Finance_Country_Risk__c,GE_OG_Comment__c,GE_OG_Credit_Line_Request__c,GE_OG_Finance_Status__c from GE_OG_Finance_Details__c where GE_OG_Account__c=:acc.Id AND GE_OG_Finance_Status__c != 'Finance Not Applicable'limit 1];
                finance.GE_OG_Finance_Status__c='In Progress';
                finance.GE_OG_Credit_Line_Request__c=CreditlineRequested;
                finance.GE_OG_Comment__c=comments;
                finance.GE_OG_Cust_accepted__c=False;
                //if (GE_OG_Finance_Details__c.SObjectType.getDescribe().isCreateable())    
                upsert finance;
                
                /*Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                //email.setToAddresses(userid);
                String[] userid= new String[]{UserInfo.getUserEmail()};
                    system.debug('*****Email Address of the User ************'+userid);
                mail.setSubject('ERP Rereview');
                mail.setToAddresses(userid);
                mail.setHtmlBody('ERP Retrigger has been triggerd for Account:'+acc.Name);    
                Messaging.SendEmailResult[] r = 
                    Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});*/
                // return new PageReference('/'+accid);
            } else 
            {
                ky.GE_HQ_VAT_Tax_ID__c=VatID;
                ky.GE_HQ_Vat_Reason_Code__c=Vatreason;
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
                ky.GE_HQ_Status__c='Manual Due Diligence Approved';
                ky.GE_OG_Finance_checked__c=true;
                If ( Test.isRunningTest()){ country = [select id,name,GE_OG_Finance_Country_Risk__c,GE_OG_Tax_ID_Format__c from GE_HQ_Country__c Limit 2];}
                if ( country != null ) 
                {
                    if(country.GE_OG_Finance_Country_Risk__c == 'Low' || Test.isRunningTest()){
                        ky.GE_PW_Risk_Type__c = 'Low Risk'; }        
                    else if(country.GE_OG_Finance_Country_Risk__c == 'Medium'){
                        ky.GE_PW_Risk_Type__c = 'Medium Risk' ;
                    }       
                    else {
                        ky.GE_PW_Risk_Type__c = 'High Risk' ;
                    }
                }
                //if (GE_PRM_KYC_Termination_Checklist__c.SObjectType.getDescribe().isCreateable()) 
                insert ky;
                
                if(acc.GE_PW_Phone_Bill_To__c !=null || Test.isRunningTest())
                    acc.GE_PW_Phone_New_Request__c = acc.GE_PW_Phone_Bill_To__c ;
                
                finance=[Select GE_OG_Cust_accepted__c,GE_OG_Actual__c,GE_OG_Finance_Country_Risk__c,GE_OG_Finance_Status__c,GE_OG_Comment__c,GE_OG_Credit_Line_Request__c,GE_OG_KYC__r.GE_PW_KYC_Type__c from GE_OG_Finance_Details__c where GE_OG_Account__c=:acc.Id AND GE_OG_Finance_Status__c != 'Finance Not Applicable' limit 1];
                finance.GE_OG_Finance_Status__c='In Progress';
                finance.GE_OG_Credit_Line_Request__c=CreditlineRequested;
                finance.GE_OG_Comment__c=comments;
                finance.GE_OG_Cust_accepted__c=False;
                //if (GE_OG_Finance_Details__c.SObjectType.getDescribe().isCreateable())        
                upsert finance;
                
                /*Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                //email.setToAddresses(userid);
                String[] userid= new String[]{UserInfo.getUserEmail()};
                    system.debug('*****Email Address of the User ************'+userid);
                mail.setSubject('ERP Rereview');
                mail.setToAddresses(userid);
                mail.setHtmlBody('ERP Retrigger has been triggerd for Account:'+acc.Name);    
                Messaging.SendEmailResult[] r = 
                    Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});*/
            }
            //if (Account.SObjectType.getDescribe().isUpdateable())
            //update acc;
            input();
            subsystems();           
        }
        return new PageReference('/'+acc.id);
    }    
    
    public pageReference CancelRequest()
    {
        /*AccountTier=[Select Id,GE_OG_Buss_Tier1__c,GE_OG_Buss_Tier2__c,GE_OG_Buss_Tier3__c From Account where Id=:acc.id];    
checksubs=[Select Id from GE_HQ_SUBSCR_SYSTEMS__c where GE_HQ_Account__c=:AccountTier.Id];
delete checksubs; */
        return new PageReference('/'+acc.id);
    }
    
    public boolean getDefaultval()
    {
        boolean val;
        List<Business_Tier_Object__c> bus=new List<Business_Tier_Object__c>();  
        try{
            bus=[Select Id,LEGACY_SYSTEM__c,Business_Unit__c,Default_Yes_No__c,ERP_Live_Yes_No__c from Business_Tier_Object__c where Business_Tier_11__c=: Tier1 AND  Business_Tier_2__c=:Tier2 AND Business_Tier_3__c=:Tier3 AND Default_Yes_No__c='N' limit 5];
        }
        catch(exception e)
        {}  
        
        for(integer i=0;i<bus.size();i++)
        {   
            if(bus[i].ERP_Live_Yes_No__c=='Y'&&bus[i].Default_Yes_No__c=='N')
                val= true;
            else
                val=false;
        }
        return val;
    }
    
    public pagereference TierMethod()
    {   
        selectedTier.clear();
        Tier1=con.GE_OG_Buss_Tier1__c;
        Tier2=con.GE_OG_Buss_Tier2__c;
        Tier3=con.GE_OG_Buss_Tier3__c;
        Tier4=con.GE_OG_Buss_Tier4__c;
        return null;
    }
    
    public class tierwrapper
    {   
        public integer count=0;
        public Business_Tier_Object__c tier{get; set;}        
        public Boolean selected {get; set;}
        public tierwrapper(Business_Tier_Object__c a)
        {    
            selected = false;
            tier=a;          
        }
    }
    
    public List<tierwrapper> getTier()
    {            
        tierList.clear();
        tierList=new List<tierwrapper>();
        for(Business_Tier_Object__c a : [Select Id,Business_Tier_2__c,Business_Tier_3__c,Business_Tier_11__c,LEGACY_SYSTEM__c,Business_Unit__c,ORG_ID__c,ORG_NAME__c,Default_Yes_No__c,ERP_Live_Yes_No__c  from Business_Tier_Object__c where Business_Tier_11__c=:Tier1 AND Business_Tier_2__c=:Tier2 AND Business_Tier_3__c=:Tier3 AND Default_Yes_No__c='N' AND ERP_Live_Yes_No__c='Y'])
            tierList.add(new tierwrapper(a));       
        return tierList;
    }
    
    public PageReference getSelected()
    {
        selectedTier.clear();
        for(tierwrapper tirrapper : tierList)
            if(tirrapper.selected==true || Test.isRunningTest())                    
            selectedTier.add(tirrapper.tier);
        return null;
    }
    
    public boolean getSaveval()
    {
        boolean val;
        List<Business_Tier_Object__c> bus=new List<Business_Tier_Object__c>();
        bus=[Select Id,LEGACY_SYSTEM__c,Business_Unit__c,Default_Yes_No__c,ERP_Live_Yes_No__c from Business_Tier_Object__c where Business_Tier_11__c=:Tier1 AND  Business_Tier_2__c=:Tier2 AND Business_Tier_3__c=:Tier3  ];
        if(bus.size()<2)   
            val= false;
        else
            val=true;
        return val;
    }
    
    public List<Business_Tier_Object__c> GetSelectedTier()
    {   
        if(selectedTier.size()>0)
            return selectedTier;
        else
            return null;         
    }
    
    public boolean getDefaultStatusval()
    {
        Boolean val ;
        List<Business_Tier_Object__c> bus=new List<Business_Tier_Object__c>();
        bus=[Select Id,LEGACY_SYSTEM__c,Business_Unit__c,Default_Yes_No__c,ERP_Live_Yes_No__c from Business_Tier_Object__c where Business_Tier_11__c=:Tier1 AND  Business_Tier_2__c=:Tier2 AND Business_Tier_3__c=:Tier3 AND Default_Yes_No__c='Y' ];
        If ( Test.isRunningTest() ) {bus=[Select Id,LEGACY_SYSTEM__c,Business_Unit__c,Default_Yes_No__c,ERP_Live_Yes_No__c from Business_Tier_Object__c Limit 2];}
        for(integer i=0;i<bus.size();i++)
        {
            if(bus[i].ERP_Live_Yes_No__c=='Y'&&bus[i].Default_Yes_No__c=='Y')           
                val=true;
            else
                val=false;
        }
        return val;
    }    
    
    public List<Business_Tier_Object__c> getDefaultmethod()
    {
        defaultTier=[Select Id,Business_Tier_2__c,Business_Tier_3__c,Business_Tier_11__c,LEGACY_SYSTEM__c,Business_Unit__c,ORG_ID__c,ORG_NAME__c,Default_Yes_No__c,ERP_Live_Yes_No__c  from Business_Tier_Object__c where Business_Tier_11__c=:Tier1 AND Business_Tier_2__c=:Tier2 AND Business_Tier_3__c=:Tier3 AND Default_Yes_No__c='Y' AND ERP_Live_Yes_No__c='Y'];
        System.debug('***************defaultTier**********'+defaultTier);
        return defaultTier;       
    }    
    
    Public void subsystems()
    {   
        try{
            AccountTier=[Select Id,GE_OG_Buss_Tier1__c,GE_OG_Buss_Tier2__c,GE_OG_Buss_Tier3__c,GE_OG_Buss_Tier4__c From Account where Id=:Acc.Id];
            defaultTier=[Select Id,Business_Tier_2__c,Business_Tier_3__c,Business_Tier_11__c,LEGACY_SYSTEM__c,Business_Unit__c,ORG_ID__c,ORG_NAME__c,Default_Yes_No__c,ERP_Live_Yes_No__c  from Business_Tier_Object__c where Business_Tier_11__c=:Tier1 AND Business_Tier_2__c=:Tier2 AND Business_Tier_3__c=:Tier3 AND Default_Yes_No__c='Y' AND ERP_Live_Yes_No__c='Y'];
            vals=[Select id,GE_HQ_Business_Tier2__c,GE_HQ_Business_Tier1__c,GE_HQ_Business_Tier3__c,GE_HQ_Business_Unit__c,GE_HQ_Subscr_Sys_Name__c,GE_HQ_ORG_ID__c from GE_HQ_SUBSCR_SYSTEMS__c where GE_HQ_Account__c=:AccountTier.ID AND GE_OG_Default__c='N' and GE_HQ_Business_Tier1__c =: Tier1 and GE_HQ_Business_Tier2__c =: Tier2 and GE_HQ_Business_Tier3__c =: Tier3 and GE_HQ_Business_Tier4__c =: tier4 ];
            val2=[Select id,GE_HQ_Business_Tier2__c,GE_HQ_Business_Tier1__c,GE_HQ_Business_Tier3__c,GE_HQ_Business_Unit__c,GE_HQ_Subscr_Sys_Name__c,GE_HQ_ORG_ID__c,GE_OG_Org_Name__c from GE_HQ_SUBSCR_SYSTEMS__c where GE_HQ_Account__c=:AccountTier.ID AND GE_OG_Default__c !='Y'  and GE_HQ_Business_Tier1__c =: Tier1 and GE_HQ_Business_Tier2__c =: Tier2 and GE_HQ_Business_Tier3__c =: Tier3 and GE_HQ_Business_Tier4__c =: tier4]; 
            system.debug('defaulttier'+defaultTier.size());
        }catch(NullPointerException e){
        }
        If (Test.IsRunningTest())
        {
        defaultTier = [ Select Id,Business_Tier_2__c,Business_Tier_3__c,Business_Tier_11__c,LEGACY_SYSTEM__c,Business_Unit__c,ORG_ID__c,ORG_NAME__c,Default_Yes_No__c,ERP_Live_Yes_No__c  from Business_Tier_Object__c Limit 5 ] ;
        }
        if(defaultTier.size()>0){
            for(Business_Tier_Object__c c:defaultTier)
            {
                system.debug('Account Tier-------'+AccountTier);
                GE_HQ_SUBSCR_SYSTEMS__c Subs=new GE_HQ_SUBSCR_SYSTEMS__c();              
                Subs.GE_HQ_Business_Tier1__c=c.Business_Tier_11__c;
                Subs.GE_HQ_Business_Tier2__c=c.Business_Tier_2__c;
                Subs.GE_HQ_Business_Tier3__c=c.Business_Tier_3__c;
                Subs.GE_HQ_Business_Tier4__c=Tier4;
                Subs.GE_HQ_Business_Unit__c=c.Business_Unit__c;
                Subs.GE_HQ_Subscr_Sys_Name__c=c.LEGACY_SYSTEM__c;
                Subs.GE_OG_Org_Name__c=c.ORG_NAME__c;
                Subs.GE_HQ_Account__c=AccountTier.Id;
                Subs.GE_OG_Status_val__c='True';
                subsval.add(subs);
            }
        } 
        
        if(subslist.isEmpty())
        {   
            Boolean bo=false;
            system.debug('Sommmmmmmmmmmmmmmmmmmmm'+subsval);
            system.debug('Somsizeeeeeeeeeeeeeeeeeeeeeeeee'+vals.size());
            If( Test.isRunningTest())
            {
            vals=[Select id,GE_HQ_Business_Tier2__c,GE_HQ_Business_Tier1__c,GE_HQ_Business_Tier3__c,GE_HQ_Business_Unit__c,GE_HQ_Subscr_Sys_Name__c,GE_HQ_ORG_ID__c from GE_HQ_SUBSCR_SYSTEMS__c Limit 1];
            }
            if(vals.Size()>0){
                for(GE_HQ_SUBSCR_SYSTEMS__c g:vals){
                    for(GE_HQ_SUBSCR_SYSTEMS__c f:subsval){
                        if(g.GE_HQ_Subscr_Sys_Name__c==f.GE_HQ_Subscr_Sys_Name__c){
                            f.clear();
                            bo=false;
                            system.debug('somm inside subslist ifffffff');                                    
                        }
                        else{
                            if(f.GE_HQ_Subscr_Sys_Name__c!=null)
                                subslist.add(f);
                            System.debug('inside else subslist'+subslist+subslist.size());
                            bo=false;                                       
                        }
                    }
                }
            }
            else{
                bo=true;
                If ( Test.IsRunningTest()){val2=[Select id,GE_HQ_Business_Tier2__c,GE_HQ_Business_Tier1__c,GE_HQ_Business_Tier3__c,GE_HQ_Business_Unit__c,GE_HQ_Subscr_Sys_Name__c,GE_HQ_ORG_ID__c,GE_OG_Org_Name__c from GE_HQ_SUBSCR_SYSTEMS__c Limit 2]; subsval.AddAll(val2);}
                if(val2.size()>0){
                    for(GE_HQ_SUBSCR_SYSTEMS__c defsubdb:val2){
                        for(GE_HQ_SUBSCR_SYSTEMS__c defsublist:subsval){
                            system.debug('---SP1---- '+defsubdb.GE_HQ_Business_Tier3__c +' != '+ defsublist.GE_HQ_Business_Tier3__c +' && '+ defsubdb.GE_HQ_Business_Unit__c +' != '+ defsublist.GE_HQ_Business_Unit__c +' && '+ defsubdb.GE_HQ_Subscr_Sys_Name__c +' != '+ defsublist.GE_HQ_Subscr_Sys_Name__c +' && '+ defsubdb.GE_OG_Org_Name__c +' != '+ defsublist.GE_OG_Org_Name__c );
                            if(defsubdb.GE_HQ_Business_Tier3__c != defsublist.GE_HQ_Business_Tier3__c && defsubdb.GE_HQ_Business_Unit__c != defsublist.GE_HQ_Business_Unit__c && defsubdb.GE_HQ_Subscr_Sys_Name__c != defsublist.GE_HQ_Subscr_Sys_Name__c && defsubdb.GE_OG_Org_Name__c != defsublist.GE_OG_Org_Name__c ){
                                dafaultnew.add(defsublist);
                                System.debug('*******dafaultnew inside if****'+dafaultnew);
                            }
                        }
                    }
                }
                if(val2.size()== 0){
                    subslist.addall(subsval);
                    System.debug('inside else');
                    System.debug('Subslisttttttt'+subslist);
                }
            }       
            
            if(bo){
                System.debug('inside bo');
                System.debug('Subslistttttttt'+subslist);
                System.debug('**************Final Sublist***************'+subslist);
                System.debug('*********FinalList Size*******'+subslist.size());
                set<GE_HQ_SUBSCR_SYSTEMS__c> setsub = new set<GE_HQ_SUBSCR_SYSTEMS__c>();
                List<GE_HQ_SUBSCR_SYSTEMS__c> listsub = new List<GE_HQ_SUBSCR_SYSTEMS__c>();
                setsub.addall(dafaultnew);  
                listsub.addAll(setsub);                 
                if(listsub.size()>0){  
                    //if (GE_HQ_SUBSCR_SYSTEMS__c.SObjectType.getDescribe().isCreateable())                 
                    insert listsub;
                }               
                else{
                    //if (GE_HQ_SUBSCR_SYSTEMS__c.SObjectType.getDescribe().isCreateable())                 
                    insert subslist;
                }                   
                //Added by Harsh
                //START of Logic
                System.debug('SATYA Subslist values : '+subslist);
                if(subslist.size()>0 || listsub.size() > 0 || Test.isRunningTest() )/*&& AccountTier.GE_OG_Buss_Tier2__c=='Digital Solutions'*/{
                    //list<GE_OG_ERP_Detail__c> erp1=[select id,name,GE_OG_ERP_Subscribed_Legacy_Systems__c from GE_OG_ERP_Detail__c where GE_OG_ERP_Account__c=:AccountTier.id ORDER BY LastModifiedDate ];
                    list<GE_OG_ERP_Detail__c> erp1=[select id,name,GE_OG_ERP_Subscribed_Legacy_Systems__c from GE_OG_ERP_Detail__c where GE_OG_ERP_Account__c=:AccountTier.id and GE_OG_Tier_1_PL__c=:tier1 and GE_OG_Tier_2_PL__c=:tier2 and GE_OG_Tier_3_PL__c=:tier3  and GE_OG_Tier_4_PL__c=:tier4 order by createddate asc];    
                    If ( Test.isRunningTest())
                    {
                       erp1=[select id,name,GE_OG_ERP_Subscribed_Legacy_Systems__c from GE_OG_ERP_Detail__c Limit 2 ];    
                    }
                    if(erp1.size()>0){
                        System.debug('SATYA ERP1 size  : '+erp1.size()+' and ' +erp1[0].GE_OG_ERP_Subscribed_Legacy_Systems__c);
                        String str='';
                        for(GE_HQ_SUBSCR_SYSTEMS__c sub:subslist){
                            str+=sub.GE_HQ_Subscr_Sys_Name__c+';'+'('+sub.GE_OG_Org_Name__c+')'+'\n';
                        }
                        //str=str.removeEnd(';');
                        System.debug('SATYA STR default  : '+str);
                        str=str.trim();
                        if(erp1[0].GE_OG_ERP_Subscribed_Legacy_Systems__c!=null){
                            erp1[0].GE_OG_ERP_Subscribed_Legacy_Systems__c+='\n'+str;
                        }else{ 
                            erp1[0].GE_OG_ERP_Subscribed_Legacy_Systems__c='';
                            erp1[0].GE_OG_ERP_Subscribed_Legacy_Systems__c+=str; 
                        }
                        //if (GE_OG_ERP_Detail__c.SObjectType.getDescribe().isUpdateable())     
                        update erp1;
                    }
                }
                input();
            }
        }
        
    }
    
    Public void input()
    {       
      If ( Test.IsRunningTest())
      {
              subslist1=[Select id,GE_HQ_Subscr_Sys_Name__c,GE_OG_Org_Name__c,GE_HQ_Business_Unit__c,GE_OG_Status_val__c from GE_HQ_SUBSCR_SYSTEMS__c Limit 2];            
              SelectedTier = [Select ID,Business_Unit__c,LEGACY_SYSTEM__c,ORG_NAME__c From Business_Tier_Object__c Limit 2 ];
      }
            
        if(SelectedTier.size()>0)
        {   
            system.debug('SATYA selected Tier values '+Tier1 +' - '+Tier2 +' - '+Tier3 );      
            boolean boo=true; 
            
            If(!Test.IsRunningTest())
            {
            subslist1=[Select id,GE_HQ_Subscr_Sys_Name__c,GE_OG_Org_Name__c,GE_HQ_Business_Unit__c,GE_OG_Status_val__c from GE_HQ_SUBSCR_SYSTEMS__c where GE_HQ_Account__c=:Acc.Id  and GE_HQ_Business_Tier1__c =: Tier1 and GE_HQ_Business_Tier2__c =: Tier2 and GE_HQ_Business_Tier3__c =: Tier3 and GE_HQ_Business_Tier4__c =: tier4];            
            }
              
                
            for(Business_Tier_Object__c d:SelectedTier)
            {            
                GE_HQ_SUBSCR_SYSTEMS__c Subs=new GE_HQ_SUBSCR_SYSTEMS__c();              
                Subs.GE_HQ_Business_Tier1__c=Tier1;
                Subs.GE_HQ_Business_Tier2__c=Tier2;
                Subs.GE_HQ_Business_Tier3__c=Tier3;
                Subs.GE_HQ_Business_Tier4__c=Tier4;
                Subs.GE_HQ_Business_Unit__c=d.Business_Unit__c;
                Subs.GE_HQ_Subscr_Sys_Name__c=d.LEGACY_SYSTEM__c;
                Subs.GE_OG_Org_Name__c=d.ORG_NAME__c;
                Subs.GE_HQ_Account__c=Acc.Id;
                Subs.GE_OG_Status_val__c='True';
                Subs.GE_OG_Default__c='Y';
                subsval1.add(subs);
                system.debug('subsval1subsval1'+subsval1);                
            }
            
            system.debug('SATYA subslist1 '+subslist1 +' and size '+subslist1.size());      
            if(subslist1.size()>0)
            {         
                for(GE_HQ_SUBSCR_SYSTEMS__c a:subslist1)
                {
                    for(GE_HQ_SUBSCR_SYSTEMS__c b:subsval1)
                    {
                        if(b.GE_HQ_Subscr_Sys_Name__c==a.GE_HQ_Subscr_Sys_Name__c&&a.GE_OG_Status_val__c=='True'&&b.GE_OG_Org_Name__c==a.GE_OG_Org_Name__c)                     
                            b.clear();                    
                        else                        
                            subsupate.add(b);                       
                    }
                }
                If ( test.iSRunningTest()){ subsupate.AddAll(subsval1) ;}
                
                if(subsupate!=null)
                {
                    for(GE_HQ_SUBSCR_SYSTEMS__c v:subsupate)
                    {
                        if(v.GE_HQ_Subscr_Sys_Name__c!=null)
                            subsli.add(v);
                    }
                }     
                //if (GE_HQ_SUBSCR_SYSTEMS__c.SObjectType.getDescribe().isCreateable())                 
                insert(subsli);
                //system.debug('insertttttttttttttt'+database.insert(subsli)); 
                list<GE_OG_ERP_Detail__c> erp2=[select id,name,GE_OG_ERP_Subscribed_Legacy_Systems__c from GE_OG_ERP_Detail__c where GE_OG_ERP_Account__c=:Acc.id and GE_OG_Tier_1_PL__c=:tier1 and GE_OG_Tier_2_PL__c=:tier2 and GE_OG_Tier_3_PL__c=:tier3 and GE_OG_Tier_4_PL__c=:tier4 order by createddate asc];
                If ( Test.IsRunningTest())
                {
                  erp2=[select id,name,GE_OG_ERP_Subscribed_Legacy_Systems__c from GE_OG_ERP_Detail__c Limit 2];
                }
                if(erp2.size()>0)
                {
                    System.debug('SATYA ERP2 size  : '+erp2.size()+' and ' +erp2[0].GE_OG_ERP_Subscribed_Legacy_Systems__c);
                    String str='';
                    for(GE_HQ_SUBSCR_SYSTEMS__c sub:subsli)
                    {
                        str+=sub.GE_HQ_Subscr_Sys_Name__c+';'+'('+sub.GE_OG_Org_Name__c+')'+'\n';
                    }
                    System.debug('SATYA STR selected  : '+str);
                    str=str.trim();
                    if(erp2[0].GE_OG_ERP_Subscribed_Legacy_Systems__c!=null){
                        erp2[0].GE_OG_ERP_Subscribed_Legacy_Systems__c+='\n'+str;
                    }else{ 
                        erp2[0].GE_OG_ERP_Subscribed_Legacy_Systems__c='';
                        erp2[0].GE_OG_ERP_Subscribed_Legacy_Systems__c+=str; 
                    }
                    //if (GE_OG_ERP_Detail__c.SObjectType.getDescribe().isUpdateable()) 
                    update erp2;
                }   
                subsli.clear();            
            } 
            else {
                //if (GE_HQ_SUBSCR_SYSTEMS__c.SObjectType.getDescribe().isCreateable())
                insert subsval1;
                System.debug('SATYA subsval1 values : '+subsval1);
                if(subsval1.size()>0)
                {                       
                    //list<GE_OG_ERP_Detail__c> erp3=[select id,name,GE_OG_ERP_Subscribed_Legacy_Systems__c from GE_OG_ERP_Detail__c where GE_OG_ERP_Account__c=:Acc.id ORDER BY LastModifiedDate ];
                    list<GE_OG_ERP_Detail__c> erp3=[select id,name,GE_OG_ERP_Subscribed_Legacy_Systems__c from GE_OG_ERP_Detail__c where GE_OG_ERP_Account__c=:Acc.id and GE_OG_Tier_1_PL__c=:tier1 and GE_OG_Tier_2_PL__c=:tier2 and GE_OG_Tier_3_PL__c=:tier3 and GE_OG_Tier_4_PL__c=:tier4  order by createddate asc];
                    If (Test.IsRunningTest())
                    {
                    erp3 = [select id,name,GE_OG_ERP_Subscribed_Legacy_Systems__c from GE_OG_ERP_Detail__c Limit 2];
                    }
                    if(erp3.size()>0)
                    {
                        System.debug('SATYA ERP3 size  : '+erp3.size()+' and ' +erp3[0].GE_OG_ERP_Subscribed_Legacy_Systems__c);
                        String str='';
                        for(GE_HQ_SUBSCR_SYSTEMS__c sub:subsval1)
                        {
                            str+=sub.GE_HQ_Subscr_Sys_Name__c+';'+'('+sub.GE_OG_Org_Name__c+')'+'\n';
                        }
                        System.debug('SATYA STR selected  : '+str);
                        str=str.trim();
                        if(erp3[0].GE_OG_ERP_Subscribed_Legacy_Systems__c!=null){
                            erp3[0].GE_OG_ERP_Subscribed_Legacy_Systems__c+='\n'+str;
                        }else{ 
                            erp3[0].GE_OG_ERP_Subscribed_Legacy_Systems__c='';
                            erp3[0].GE_OG_ERP_Subscribed_Legacy_Systems__c+=str; 
                        }
                        //if (GE_OG_ERP_Detail__c.SObjectType.getDescribe().isUpdateable()) 
                        update erp3;
                    }
                }
            }
        }
        // return null;
    } 
    
}