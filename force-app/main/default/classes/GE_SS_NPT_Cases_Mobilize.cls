public class GE_SS_NPT_Cases_Mobilize {

    public List<Case> lstNPTCase{get; set;}
    public Id Aid {get;set;}
    public String idval{get;set;}
    public String redirectURL{get;set;}
    public boolean recordSize{get;set;}
    public String allRec{get;set;}
    
    public GE_SS_NPT_Cases_Mobilize(ApexPages.StandardController controller) {
        System.debug('in controller');
        recordSize=false;
        lstNPTCase = new list<Case>();
        
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
             lstNPTCase = [select id, CaseNumber, Status, GE_NPT_Near_Miss_Event__c, GE_NPT_Downtime_hours__c, GE_NPT_Primary_Failure_Classification__c, Secondary_Failure_Classification__c, Tertiary_Failure_Classification__c, Subject, Description from  Case where GE_SS_Work_Order__c=: Aid and RecordType.Name = 'SS_NPT' order by CaseNumber desc];
         }
         else if(Aid != null){
            lstNPTCase = [select id, CaseNumber, Status, GE_NPT_Near_Miss_Event__c, GE_NPT_Downtime_hours__c, GE_NPT_Primary_Failure_Classification__c, Secondary_Failure_Classification__c, Tertiary_Failure_Classification__c, Subject, Description from  Case where GE_SS_Work_Order__c=: Aid and RecordType.Name = 'SS_NPT' order by CaseNumber desc LIMIT 5];
            List<Case> lstNPTCaseAll = [select id, CaseNumber, Status, GE_NPT_Near_Miss_Event__c, GE_NPT_Downtime_hours__c, GE_NPT_Primary_Failure_Classification__c, Secondary_Failure_Classification__c, Tertiary_Failure_Classification__c, Subject, Description from  Case where GE_SS_Work_Order__c=: Aid and RecordType.Name = 'SS_NPT' order by CaseNumber desc];
            if(lstNPTCaseAll.size() > 5)
                recordSize = true;
            else
                recordSize = false;
       }
    }
     
}