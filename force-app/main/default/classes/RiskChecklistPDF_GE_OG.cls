/*
Class/Trigger Name     : RiskChecklistPDF_GE_OG
Used Where ?           : On Deal Desk Page, Button named 'Generate PDF'
Purpose/Overview       : This class will Create an attachmentunder Opportunity with statgus of all Risk Checklist
Scrum Team             : Transformation - Deal MGMT
Requirement Number     : R-23825
Author                 : Nitish Pandey
Created Date           : 26/Nov/2015
Test Class Name        : CreateDealDesk_GE_OG_Test
Code Coverage          : 93%
*/

global without sharing class RiskChecklistPDF_GE_OG{
    
    //Initializing Variable
    public static String Document_Type{get;set;}
    public static String Deviation_Level{get;set;} 
    public static String Opportunity_Id{get;set;}
    
    public static Opportunity oppty {get;set;}
    public static  List<Opportunitylineitem> opptyLineItem {get;set;}
    public  static List<Risk_Checklist_Deviation_ge_og__c> rcdList{get;set;}
    public static List<Risk_Checklist_Category_ge_og__c> rccLIST{get;set;}
    Public static String commPrimaryResource {get;set;}
    Public static String commercialPrimaryResource {get;set;}
    public static String dealDeskStatus{get;set;}
    public static String opId{get;set;} 
    public static String devLev{get;set;}
    public static String pdfName {get;set;}
    public static String contentType{get;set;}
    
    Pagereference  pg;
    Deal_Desk_ge_og__c dd;
    
    public RiskChecklistPDF_GE_OG(){
        devLev = Deviation_Level;
        
        String opptyId = RiskChecklistPDF_GE_OG.Opportunity_Id;
        if(opptyId == null || opptyId == '') {
            opptyId = apexpages.currentpage().getparameters().get('id');
        }
        if(Deviation_Level == null || Deviation_Level ==''){
            Deviation_Level = ApexPages.currentPage().getParameters().get('Deviation_Level');   
        }
        if(Document_Type == null || Document_Type ==''){
            Document_Type = ApexPages.currentPage().getParameters().get('Document_Type');   
        }
        commercialPrimaryResource = '';
        
        System.debug(LoggingLevel.Error,'opptyId >>'+opptyId);
        dd= [Select id, status_ge_og__c, name, deal_desk_opportunity_id_ge_og__c from Deal_Desk_ge_og__c where deal_desk_opportunity_id_ge_og__c =:opptyId and active_deal_desk_ge_og__c =true];
        dealDeskStatus = dd.status_ge_og__c;
        System.debug(LoggingLevel.Error,'dd Id >>'+dd.id);
        //Query on Opportunity
        oppty = [Select id, name, account.name, install_country_ge_og__c, quote_type_ge_og__c, region_ge_og__c, 
                 Owner.name, ge_legal_entity_ge_og__r.name, oppty_cm_ge_og__c, CurrencyIsoCode,
                 pipeline_amount_ge_og__c, bid_due_date_ge_og__c, has_commercial_primary_resource_ge_og__c from opportunity where id =: opptyId ];
        //query on opportunityLineItem
        opid = oppty.Id;
        OpptyLineItem =[select id, pricebookentry.name, quantity, totalprice from Opportunitylineitem where Opportunityid =:opptyId];
        
        rccLIST = [Select Id,rcl_category_ge_og__c,rcl_reviewer_ge_og__r.name,status_ge_og__c from Risk_Checklist_Category_ge_og__c where RCC_Opportunity_ge_og__c=:opptyId];
        //System.debug(LoggingLevel.Info ,rccLIST[0] + '>>> rccLIST >>> '+rccLIST.size());
        // dealDeskName = dd.name;
        
        if(oppty.has_commercial_primary_resource_ge_og__c){
            OpportunityTeamMember otm= [select User.name from OpportunityTeamMember where TeamMemberRole ='Commercial Primary Resource' and OpportunityId =: opptyId limit 1];
            commercialPrimaryResource = otm.User.name;
        }
        
        opId = opptyId;
        
        //name of PDF has to be same as Deal Desk auto number
        String pdfName ;
        
        
        //query on Deal desk Obejct
        
        if( Deviation_Level == 'All'){
            
            rcdList = [select id, risk_checklist_ge_og__c, rcl_deviation_level_ge_og__c, risk_checklist_category_id_ge_og__r.rcl_category_ge_og__c,
                       comments_ge_og__c, risk_checklist_category_id_ge_og__r.rcl_reviewer_ge_og__r.name,rcl_deviation_ge_og__c,deviation_reference_ge_og__r.deviation_ge_og__c,
                       checklist_reference_ge_og__r.question_ge_og__c from Risk_Checklist_Deviation_ge_og__c where 
                       //R-25788 - To print only active Risk module deviations
                       risk_checklist_category_id_ge_og__r.Is_Active_ge_og__c=true and
                       risk_checklist_category_id_ge_og__r.RCC_Opportunity_ge_og__c =: opptyId ];
            
            pdfName= dd.name;
           // System.debug(LoggingLevel.Error,'pdfName  ALL>>'+pdfName);
        }else{
            rcdList = [select id, risk_checklist_ge_og__c, rcl_deviation_level_ge_og__c, risk_checklist_category_id_ge_og__r.rcl_category_ge_og__c,
                       comments_ge_og__c, risk_checklist_category_id_ge_og__r.rcl_reviewer_ge_og__r.name,rcl_deviation_ge_og__c,deviation_reference_ge_og__r.deviation_ge_og__c,
                       checklist_reference_ge_og__r.question_ge_og__c from Risk_Checklist_Deviation_ge_og__c where 
                       //R-25788 - To print only active Risk module deviations
                       risk_checklist_category_id_ge_og__r.Is_Active_ge_og__c=true and
                       risk_checklist_category_id_ge_og__r.RCC_Opportunity_ge_og__c =: opptyId and rcl_deviation_level_ge_og__c > 0 ]; 
            pdfName= dd.name+'_deviation>0';
           // System.debug(LoggingLevel.Error,'pdfName >>'+pdfName);
        }
        
        if(Document_Type.equalsIgnoreCase('word')){
            contentType = 'application/vnd.ms-word#'+pdfName+'.doc';
        }else  if(Document_Type.equalsIgnoreCase('Excel')){
            contentType = 'application/vnd.ms-excel#'+pdfName+'.xls';
        }else{
            contentType = 'application/pdf'+pdfName+'.pdf';
        }
    }
    
    
    global class getFilterParameters{
        @InvocableVariable(required=false  label='Document_Type')
        public string Document_Type ;
        @InvocableVariable(required=false  label='Deviation_Level')
        public String Deviation_Level;
        @InvocableVariable(required=true  label='Opportunity_Id')
        public String Opportunity_Id;
    }
    
    
    @InvocableMethod(label='Generate Documents')
    global static void generateDocuments(List<getFilterParameters> inputparam) {
        
        getFilterParameters planinputs = inputparam [0] ; 
        
        System.debug('document_Type >> '+document_Type);
        System.debug('deviation_Level >>> '+deviation_Level);
        RiskChecklistPDF_GE_OG.Document_Type = planinputs.Document_Type;
        RiskChecklistPDF_GE_OG.Deviation_Level = planinputs.deviation_Level;
        RiskChecklistPDF_GE_OG.Opportunity_Id = planinputs.opportunity_Id;
        
        
        //Query on Risk Checklist Deviation
        // R-30541- To print only deviations whose devaiations are greater than one
        RiskChecklistPDF_GE_OG riskChecklistPDF_GE_OG = new RiskChecklistPDF_GE_OG();
        Id attid = riskChecklistPDF_GE_OG.GeneratePDF();
        PageReference pageRef = new PageReference('/servlet/servlet.FileDownload?file='+attid);
        pageRef.setRedirect(true);
        
    }
    
    //Method to generate PDF and Saving in Oppty
    
    public  Id GeneratePDF(){
        String opptyId = RiskChecklistPDF_GE_OG.opportunity_Id;
        //Pagereference used for getting the Content in a PDF format
        //Since we can not use this function on same page so, we have to create a new Page
        // pagereference  Pg  = new PageReference('/apex/RiskChecklistPDFAttachment_GE_OG?id='+dd.id); Kiru commetned 28/9
        
        pagereference  Pg  = new PageReference('/apex/RiskChecklistPDFAttachment_GE_OG?id='+opId+'&Deviation_Level='+ devLev+'&pdfName='+pdfName+'&Document_Type='+RiskChecklistPDF_GE_OG.Document_Type);
        
        if(Deviation_Level.equalsIgnoreCase('ALL')){
            pdfName= dd.name;   //name of PDF has to be same as Deal Desk auto number 
        }else{
            pdfName= dd.name+'_deviation>0';   //name of PDF has to be same as Deal Desk auto number
        }
        
        if(RiskChecklistPDF_GE_OG.Document_Type.equalsIgnoreCase('Word')){
            pdfName= pdfName+'.doc';
        }else  if(RiskChecklistPDF_GE_OG.Document_Type.equalsIgnoreCase('Excel')){
            pdfName= pdfName+'.xls';
        }else {
            pdfName= pdfName+'.pdf';
        }
        
        //Converting page into PDF
        Blob pdf1;
        if(!Test.isRunningTest()){
            if(RiskChecklistPDF_GE_OG.Document_Type.equalsIgnoreCase('pdf')){
                pdf1 = pg.getContentAsPDF(); 
            }else{
                pdf1 = pg.getContent();
            }
        }
        else{
            pdf1 = Blob.valueOf('Test');
        }
        //Also we need to check if there is already a attachment in the oppty with same name
        // Attachment insertedAttachment = new Attachment();
        Attachment[] insertedAttachment ;
        try{
            insertedAttachment = [select id,name from Attachment where parentId =: dd.deal_desk_opportunity_id_ge_og__c and name =: pdfName];
        }
        catch(exception e){
            
        }
        //inserting Attachment
        Attachment att=new Attachment();
        att.Body=Pdf1;
        att.Name= pdfName ;
        att.parentId=(opptyId);
        
        //Checking if there is already a PDF with same name
        //If there is a PDF, then deleet the old one and insert new one with same name
        //if(insertedAttachment.Name != null ){
        if(insertedAttachment.size() > 0 ){
            delete insertedAttachment;
            insert att;
        }
        else{
            insert att;
        }
        
        //Also make field 'PDF Generated' to True, to check if PDF is generated or not
        dd.PDF_Generated_ge_og__c = True;
        //Update dd;
        return att.Id;
        //redirect to the new attachemnt for downloading
        //  PageReference pageRef = new PageReference('/servlet/servlet.FileDownload?file='+att.id);
        // pageRef.setRedirect(true);
        // return pageRef;
    }
    
    
    
    
    
}