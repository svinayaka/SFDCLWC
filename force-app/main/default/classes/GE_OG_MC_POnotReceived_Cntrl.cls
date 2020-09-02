public class GE_OG_MC_POnotReceived_Cntrl {
    public String MCSRecId{get;set;}
    public SVMXC__Service_Order__c woObj{get;set;}
    public Boolean flag{get;set;}
    public GE_OG_MC_POnotReceived_Cntrl(ApexPages.StandardController controller) {
        flag = false;
        woObj = (SVMXC__Service_Order__c) controller.getRecord();
        woObj = [select id,RecordTypeID from SVMXC__Service_Order__c where id=: woObj.id];
        MCSRecId =  Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('MCS').getRecordTypeId();
        if(MCSRecId == woObj.RecordTypeID){
            //if(woObj.GE_OG_MC_PO_Not_Received__c == true ){
                //flag = true;
            //}
            //else
            {
                flag = false;
            }
        }
    }

}