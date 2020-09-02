public class GE_OG_GS_CC_Redact_Batch_Job {
    /*  This class is tied to R-21247
     *  This class will look for technican records that have credit card (CC) data and redact it if found
     *  Author: Matt Koshay 220009756 3/2015
     * 
     *  Test Coverage found in GE_OG_SVMXC_Service_Group_Members_Test
     * */
    
    // Constructor will run the redactTechCCData method
    public GE_OG_GS_CC_Redact_Batch_Job(){
        this.redactTechCCData();
    }    
    
    //Check if in sandbox or not:
    public Boolean isSandbox() {
        
        Boolean isSandbox = false;
        System.Debug('Current org URL: ' + URL.getSalesforceBaseUrl().getHost());
        System.Debug('Current org has .CS in it?: '+ URL.getSalesforceBaseUrl().getHost().contains('.cs'));
        
        // If the URL does NOT matche custom label of geog.my.salesforce.com 
        // and URL DOES contain .cs then set sandbox = true
        if(!URL.getSalesforceBaseUrl().getHost().equals(Label.GE_Oil_Gas_Production_URL)
           && URL.getSalesforceBaseUrl().getHost().contains('.cs')){
               isSandbox = true;
           }
        return isSandbox;
    }    
    
    public void redactTechCCData(){
        
        if (isSandbox())
        {
            System.debug('Executing Redaction since this is a non production sandbox');
            //Date myDate = Date.newInstance(1900, 1, 1);
            Integer count = 0;
            // Get all techs with CC data on their record and the CC redact checkbox is not ticked
            List<SVMXC__Service_Group_Members__c> techsWithCCData = new List<SVMXC__Service_Group_Members__c>();
            techsWithCCData = [select id,GE_OG_GS_CREDIT_CARD_EXPIRY_DATE__C, GE_OG_GS_CREDIT_CARD_NUMBER__C, GE_OG_GS_CREDIT_CARD_VERIFICATION_CODE__C 
                 from SVMXC__Service_Group_Members__c 
                 where ((GE_OG_GS_CREDIT_CARD_EXPIRY_DATE__C != null OR GE_OG_GS_CREDIT_CARD_NUMBER__C != null OR GE_OG_GS_CREDIT_CARD_VERIFICATION_CODE__C != null) 
                        AND GE_OG_GS_CC_Redact_Flag__c = false) ];
            
            // This list holds the tech records with updated redacted data
            List<SVMXC__Service_Group_Members__c> techsToUpdate = new List<SVMXC__Service_Group_Members__c>{};
                
                for(SVMXC__Service_Group_Members__c i: techsWithCCData){
                    System.debug('Updating ID: ' + i.Id);
                    i.GE_OG_GS_Credit_Card_Expiry_Date__c = Date.newInstance(1900, 1, 1);
                    i.GE_OG_GS_CREDIT_CARD_NUMBER__C = 'XXXXXXXXXXXXXX';
                    i.GE_OG_GS_CREDIT_CARD_VERIFICATION_CODE__C = 'XXXX';
                    i.GE_OG_GS_CC_Redact_Flag__c = true;
                    count++;
                }
            
            // Write updates to disk
            if(techsWithCCData.size() > 0)
            update techsWithCCData;            
            System.debug('Redaction Process Complete - ' + count +' records updated');
            
        }
        else{
            System.debug('Redact process not running - production sandbox detected');
        }
    } 
}