/*
Class Name          :   GE_OG_Start_ERP_Process_Controller
Used Where          :   GE_OG_ERP_Page
Purpose/Overview    :       
Functional Area     :   ERP
Author              :   Rekha N
Created Date        :
Test Class Name     :   Test_GE_OG_AccountProcess    
Change History      : 
Date Modified: Developer Name: Section/Page Block Modified/Added: Purpose/Overview of Change
*/
public with sharing class GE_OG_Start_ERP_Process_Controller{

    public GE_OG_ERP_Detail__c erpRecord;
    public GE_OG_ERP_Detail__c erp;
    public boolean erpAttachment{get;set;}
    public boolean erpTax{get;set;}
    public List<Attachment> erpDocs{get;set;}
    public string sdelAttachments {get; set;}
    public boolean erpCompleted {get;set;}
    public boolean erpPending {get;set;}
    public boolean startERPProcess {get;set;}
    transient public List<GE_OG_ERP_Advance_User__c> advUsers{get;set;}
    //public List<String> advList{get;set;}
    public List<SelectOption> options{get;set;}
    transient public GE_PRM_KYC_Termination_Checklist__c kyc{get;set;}
    public Account acc{get;set;}
    public boolean OracleERP {get;set;}
    public boolean CheckKYCexist{get;set;}

    
    public GE_OG_Start_ERP_Process_Controller(ApexPages.StandardController con){
        this.erp=(GE_OG_ERP_Detail__c)con.getRecord();
        
    }
    
    public pageReference LoadERP(){
        this.erpRecord=[select id,name, GE_OG_ERP_Account__c, GE_OG_KYC__c,RecordTypeId from GE_OG_ERP_Detail__c where id=:erp.id ];
        CheckKYCexist = false;
        If(this.erpRecord.GE_OG_KYC__c == null && this.erpRecord.GE_OG_ERP_Account__c !=null){
            system.debug('------------'+this.erpRecord.GE_OG_KYC__c);
            system.debug('----acc--------'+this.erpRecord.GE_OG_ERP_Account__c);
            List<GE_PRM_KYC_Termination_Checklist__c> lstKYC = new List<GE_PRM_KYC_Termination_Checklist__c>([  Select id, GE_HQ_Account__c from GE_PRM_KYC_Termination_Checklist__c where GE_HQ_Account__c = :this.erpRecord.GE_OG_ERP_Account__c]);
            system.debug('----kyc--------'+lstKYC );
            if(lstKYC.size()>0)
            {
                erpRecord.GE_OG_KYC__c = lstKYC[0].Id;
                update erpRecord;
                
            }
            else
            {
                CheckKYCexist= true;
                ApexPages.Message myMsg1 = new ApexPages.Message(ApexPages.Severity.ERROR, 'Finance for this selected Account has not been initiated/Completed.');
                ApexPages.addMessage(myMsg1);
                return null; 
            }
            
        }
       
        
        system.debug('***ERP Id***'+erp.id);
        GE_OG_ERP_Detail__c erpRec=[select id,name,GE_OG_ERP_Is_this_Customer_Tax_Exempt__c,GE_OG_Tier_3_PL__c,GE_OG_Tier_4_PL__c from GE_OG_ERP_Detail__c where id=:erp.id];
        if(erpRec.GE_OG_ERP_Is_this_Customer_Tax_Exempt__c=='No'){
            this.erpTax=true;
            this.erpAttachment=false;
        }else if(erpRec.GE_OG_ERP_Is_this_Customer_Tax_Exempt__c=='Yes'){
            this.erpTax=false;
            this.erpAttachment=true;
        }else{
            this.erpTax=false;
            this.erpAttachment=false;
        }
        //this.erpAttachment=false;
        //this.erpTax=false;
        startERPProcess=true;
        this.erpPending=false;
        this.erpCompleted=false;
        this.erpDocs=new List<Attachment>();
        erpDocs=[select id,name,parentId from Attachment where parentId=:erp.id];
        
        kyc=[select id,name,GE_HQ_Account__c from GE_PRM_KYC_Termination_Checklist__c where id=:erpRecord.GE_OG_KYC__c];
        acc=[select id,name,GE_OG_Buss_Tier3__c,GE_OG_Buss_Tier4__c from Account where id=:kyc.GE_HQ_Account__c];
        if (erpRec.GE_OG_Tier_3_PL__c == 'Flow & Process Technologies (Dresser)')
            advUsers=[select id,name,GE_OG_ERP_Advance_User__c, GE_OG_ERP_Tier_3__c from GE_OG_ERP_Advance_User__c where GE_OG_Tier_4_PL__c=:erpRec.GE_OG_Tier_4_PL__c];
        else
            advUsers=[select id,name,GE_OG_ERP_Advance_User__c, GE_OG_ERP_Tier_3__c from GE_OG_ERP_Advance_User__c where GE_OG_ERP_Tier_3__c=:erpRec.GE_OG_Tier_3_PL__c];           
        //if (acc.GE_OG_Buss_Tier3__c == 'Flow & Process Technologies (Dresser)')
        //    advUsers=[select id,name,GE_OG_ERP_Advance_User__c, GE_OG_ERP_Tier_3__c from GE_OG_ERP_Advance_User__c where GE_OG_Tier_4_PL__c=:acc.GE_OG_Buss_Tier4__c];                    
        //else
        //    advUsers=[select id,name,GE_OG_ERP_Advance_User__c, GE_OG_ERP_Tier_3__c from GE_OG_ERP_Advance_User__c where GE_OG_ERP_Tier_3__c=:acc.GE_OG_Buss_Tier3__c];
        if(advUsers.size()>0){
        options=new List<SelectOption>();
            for(GE_OG_ERP_Advance_User__c adv:advUsers){
                options.add(new SelectOption(adv.GE_OG_ERP_Advance_User__c,adv.GE_OG_ERP_Advance_User__c)); 
            }
        }
        Schema.DescribeSObjectResult erpObj = Schema.SObjectType.GE_OG_ERP_Detail__c; 
        Map<String,Schema.RecordTypeInfo> ERPMapByName = erpObj.getRecordTypeInfosByName();
       //Added for R-18814 by Satya
        Schema.RecordTypeInfo rtByName_Subsea = ERPMapByName.get('ERP Oracle');                   
        Id Subsea_Id=rtByName_Subsea.getRecordTypeId();
        //added by Rekha for R-18611
        Schema.RecordTypeInfo rtByName_OracleTier4 =  ERPMapByName.get('ERP Oracle-Tier4');
        Id oracleTier4_Id=rtByName_OracleTier4.getRecordTypeId();
        
        if (erpRecord.RecordTypeId==Subsea_Id || erpRecord.RecordTypeId==oracleTier4_Id) 
            this.OracleERP=false;
        else 
            this.OracleERP=true;
      
        return null;
    }
    
    public pageReference startERP(){
        startERPProcess=false;
        erpPending=true;
        return null;
    }
    
    public PageReference checkERPAttachment(){
        if(erp.GE_OG_ERP_Is_this_Customer_Tax_Exempt__c=='Yes'){
            erpAttachment=true;
            erpTax=false;
        }
        else{
            erpTax=true;
            erpAttachment=false;
        }    
        return null;
        
    }
    
    public PageReference addAttachment(){
     
        saveAttachment();
        Attachment a = new Attachment(parentId = erp.id);
        erpDocs.add(a); 
        return null;
    }
    
    public PageReference saveAttachment(){
     
        deleteAttachments();
        List<Attachment> saveAttachments = new List<Attachment>();
        for(Attachment a: erpDocs){
            if(a.id == null && a.parentId != null && a.name != null && a.body != null){
                saveAttachments.add(a);    
            }
        }
        
        if(saveAttachments.size()>0) 
            insert saveAttachments;
            
        erpDocs = [select id, name, ParentId  from Attachment where ParentId =: erp.id];    
         return null;            
    }
    
    public PageReference deleteAttachments(){
     
        String[] sdelattch;
        List<Attachment> delattch = new List<Attachment>();
        
        if(sdelAttachments != null)
            sdelattch = sdelAttachments.split(';');
        
        if(sdelattch != null)
            delattch = [Select id from Attachment where Id IN: sdelattch];
        
        if(delattch.size()>0)
            delete delattch;
            
         sdelAttachments = null;            
        //kycDocs = [select id, name, ParentId  from Attachment where ParentId =: kyc.id];             
         return null;
        
   }
   
   public PageReference populateSAP(){
   
       transient List<User> u=[select id,firstname,lastname,email from User where id=:erp.GE_OG_ERP_Sales_Person__c];
       if(u.size()>0){
       erp.GE_OG_ERP_Sales_Person_First_Name__c=u[0].firstName;
       erp.GE_OG_ERP_Sales_Person_Last_Name__c=u[0].lastName;
       erp.GE_OG_ERP_Sales_Person_Email__c=u[0].email;
       update erp;
       }
        return null;
       
   }

    public PageReference populateCSR(){
     
       transient List<User> u=[select id,firstname,lastname,email from User where id=:erp.GE_OG_ERP_CSR_Person__c];
       if(u.size()>0){
       erp.GE_OG_ERP_CSR_First_Name__c=u[0].firstName;
       erp.GE_OG_ERP_CSR_Last_Name__c=u[0].lastName;
       erp.GE_OG_ERP_CSR_Email__c=u[0].email;
       update erp;
       }
       return null;
       
   }
   
    public PageReference saveERPDetails(){
   
        if(erp.GE_OG_Advance_User__c==null){
            ApexPages.Message myMsg1 = new ApexPages.Message(ApexPages.Severity.ERROR, 'Please select Advance User!!');
            ApexPages.addMessage(myMsg1);
            return null;
        }
        else if(String.isBlank(erp.GE_OG_ERP_Sales_Person_ID__c) && (String.isBlank(erp.GE_OG_ERP_Sales_Person_First_Name__c) || String.isBlank(erp.GE_OG_ERP_Sales_Person_Last_Name__c) || String.isBlank(erp.GE_OG_ERP_Sales_Person_Email__c))){
            ApexPages.Message myMsg2 = new ApexPages.Message(ApexPages.Severity.ERROR, 'Please provide Sales Person Details or Sales Person ID!!');
            ApexPages.addMessage(myMsg2);
            return null;
        }
        else if(OracleERP && erp.GE_OG_ERP_CSR_Number__c==null && (erp.GE_OG_ERP_CSR_First_Name__c==null || erp.GE_OG_ERP_CSR_Last_Name__c==null || erp.GE_OG_ERP_CSR_Email__c==null)){
            ApexPages.Message myMsg3 = new ApexPages.Message(ApexPages.Severity.ERROR, 'Please provide CSR Person Details or CSR Number!!');
            ApexPages.addMessage(myMsg3);
            return null;
        }
        else{
        //String email=erp.GE_OG_Advance_User__c.substringBetween('<','>');
        //erp.GE_OG_Advance_User__c=email;
         if(!Test.isRunningTest()){ 
            update erp;
        }
        erpPending=false;
        erpCompleted=true;
        }
        return null;
        
    }
    
    /*public PageReference getAdvUsers(){
        GE_PRM_KYC_Termination_Checklist__c kyc=[select id,name,GE_HQ_Account__c from GE_PRM_KYC_Termination_Checklist__c where id=:erpRecord.GE_OG_KYC__c];
        Account acc=[select id,name,GE_OG_Buss_Tier3__c from Account where id=:kyc.GE_HQ_Account__c];
        advUsers=[select id,name,GE_OG_ERP_Advance_User__c, GE_OG_ERP_Tier_3__c from GE_OG_ERP_Advance_User__c where GE_OG_ERP_Tier_3__c=:acc.GE_OG_Buss_Tier3__c];
        if(advUsers.size()>0){
        options=new List<SelectOption>();
            for(GE_OG_ERP_Advance_User__c adv:advUsers){
                options.add(new SelectOption(adv.GE_OG_ERP_Advance_User__c,adv.GE_OG_ERP_Advance_User__c)); 
            }
        }
                
        return null;
    }*/
    
   
}