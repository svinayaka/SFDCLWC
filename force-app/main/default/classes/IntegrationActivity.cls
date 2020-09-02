public class IntegrationActivity{

    private string strObject {set; get;}
    private string strSource {set; get;}
    private string strTarget {set; get;}
    private string strStatus {set; get;}
    private string strStatusDetail {set; get;}
    private string strSubmittedBy {set; get;}
    private string SubmittedDate {set; get;}
    private String strSubmittedRecordId {set; get;}
    private string strDataFlow {set; get;}
    private string strRecordDesc {set; get;}
    private string strLgcyRecId {set; get;}
    private Id opptyId {set; get;}
    private Id accountId {set; get;}
    private Id contactId {set; get;}
    private Id installBaseId {set; get;}
    private Id requestTypeId {set; get;}

    public IntegrationActivity(){}

    public void setStrObject(String strObject){
        this.strObject = strObject;
    }
    
    public void setStrSource(String strSource){
    	this.strSource = strSource;
    }
    
    public void setStrTarget(String strTarget){
    	this.strTarget = strTarget;
    }

    public void setStrStatus(String strStatus){
    	this.strStatus = strStatus;
    }

    public void setStrStatusDetail(String strStatusDetail){
    	this.strStatusDetail = strStatusDetail;
    }

    public void setSubmittedDate(String SubmittedDate){
    	this.SubmittedDate = SubmittedDate;
    }

    public void setStrSubmittedRecordId(String strSubmittedRecordId){
    	this.strSubmittedRecordId = strSubmittedRecordId;
    }

    public void setStrDataFlow(String strDataFlow){
    	this.strDataFlow = strDataFlow;
    }

    public void setStrRecordDesc(String strRecordDesc){
    	this.strRecordDesc = strRecordDesc;
    }

    public void setStrLgcyRecId(String strLgcyRecId){
    	this.strLgcyRecId = strLgcyRecId;
    }

    public void insertIntegrationActivity(){
        GE_HQ_Integration_Activity__c objIntActivity = new GE_HQ_Integration_Activity__c();
        objIntActivity.GE_HQ_Object__c = strObject;
        objIntActivity.GE_HQ_Opportunity__c = opptyId;
        objIntActivity.GE_HQ_Source_Sys__c = strSource;
        objIntActivity.GE_HQ_Target_Sys__c = strTarget;
        objIntActivity.GE_HQ_Status__c = strStatus;
        objIntActivity.GE_HQ_Status_Dtl__c = strStatusDetail;            
        objIntActivity.GE_HQ_Submit_Dt__c = System.Now();
        objIntActivity.GE_HQ_Submit_By__c = UserInfo.getUserID();
        objIntActivity.GE_HQ_Sbt_Rcrd_ID__c = strSubmittedRecordId;
        objIntActivity.GE_HQ_Record_Desc__c = strRecordDesc;
        objIntActivity.GE_HQ_Data_Flow__c = strDataFlow;
        insert objIntActivity;
    }
}