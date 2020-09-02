public class GE_SS_SiRCAM_Cases_Mobilize {

    public List<Case> lstScamCase{get; set;}
    public Id Aid {get;set;}
    public String idval{get;set;}
    public String redirectURL{get;set;}
    public boolean recordSize{get;set;}
    public String allRec{get;set;}
    
    public GE_SS_SiRCAM_Cases_Mobilize(ApexPages.StandardController controller) {
        System.debug('in controller');
        recordSize=false;
        lstScamCase = new list<Case>();
        
         Aid = ApexPages.currentPage().getParameters().get('id');
         allRec = ApexPages.currentPage().getParameters().get('allrec');
        init();
    }
    
    public void deleteRec() {
        system.debug('---- '+idval);
        Id Id1 = Id.valueOf(idval);
        Case rec = new Case(id=Id1);
        delete rec;
        init();
    }
    
    public void init() {
         if(allRec == 'true') {
             lstScamCase = [select id, CaseNumber, Status, Type, GE_ES_Sub_Type__c, Subject, Description, GE_SS_Root_Cause_Details__c, GE_Customer_Resolutuion_message__c, GE_SS_Case_Creation_Date__c from  Case where GE_SS_Work_Order__c=: Aid and RecordType.Name = 'SIR - CaM' order by CaseNumber desc];
         }
         else if(Aid != null){
            lstScamCase = [select id, CaseNumber, Status, Type, GE_ES_Sub_Type__c, Subject, Description, GE_SS_Root_Cause_Details__c, GE_Customer_Resolutuion_message__c, GE_SS_Case_Creation_Date__c from  Case where GE_SS_Work_Order__c=: Aid and RecordType.Name = 'SIR - CaM' order by CaseNumber desc LIMIT 5];
            List<Case> lstScamCaseAll = [select id, CaseNumber, Status, Type, GE_ES_Sub_Type__c, Subject, Description, GE_SS_Root_Cause_Details__c, GE_Customer_Resolutuion_message__c, GE_SS_Case_Creation_Date__c from  Case where GE_SS_Work_Order__c=: Aid and RecordType.Name = 'SIR - CaM' order by CaseNumber desc];
            if(lstScamCaseAll.size() > 5)
                recordSize = true;
            else
                recordSize = false;
       }
    }
     
}