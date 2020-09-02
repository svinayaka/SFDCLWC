public class GE_SS_ToolForecast_workdetails_moblize {

    public List<SVMXC__Service_Order_Line__c> lsttoolfrWD{get; set;}
    public Id Aid {get;set;}
    public String idval{get;set;}
    public String redirectURL{get;set;}
    public boolean recordSize{get;set;}
   public String allRec{get;set;}
    
    public GE_SS_ToolForecast_workdetails_moblize(ApexPages.StandardController controller) {
        System.debug('in controller');
        recordSize=false;
        lsttoolfrWD = new list<SVMXC__Service_Order_Line__c>();
        
         Aid = ApexPages.currentPage().getParameters().get('id');
         allRec = ApexPages.currentPage().getParameters().get('allrec');
        init();
    }
    
    public void deleteRec() {
        system.debug('---- '+idval);
        Id Id1 = Id.valueOf(idval);
        SVMXC__Service_Order_Line__c rec = new SVMXC__Service_Order_Line__c(id=Id1);
        delete rec;
        init();
    }
    
    public void init() {
         if(allRec == 'true') {
             lsttoolfrWD= [select id,name,RecordType.Name,SVMXC__Line_Type__c,GE_OG_SS_Product_Description__c,SVMXC__Start_Date_and_Time__c,SVMXC__End_Date_and_Time__c, SVMXC__Product__c, GE_AL_Part_Description__c, SVMXC__Requested_Quantity2__c, GE_SS_Tool_Forecast_Status__c, GE_SS_Tools_Forecast_Start_Date__c, GE_SS_Tools_Forecast_End_Date__c  from  SVMXC__Service_Order_Line__c where SVMXC__Service_Order__c=: Aid and RecordType.Name = 'Tools Forecast' order by name desc];
         }
         else if(Aid != null){
            lsttoolfrWD= [select id,name,RecordType.Name,SVMXC__Line_Type__c,GE_OG_SS_Product_Description__c,SVMXC__Start_Date_and_Time__c,SVMXC__End_Date_and_Time__c, SVMXC__Product__c, GE_AL_Part_Description__c, SVMXC__Requested_Quantity2__c, GE_SS_Tool_Forecast_Status__c, GE_SS_Tools_Forecast_Start_Date__c, GE_SS_Tools_Forecast_End_Date__c  from  SVMXC__Service_Order_Line__c where SVMXC__Service_Order__c=: Aid and RecordType.Name = 'Tools Forecast' order by name desc LIMIT 5];
            List<SVMXC__Service_Order_Line__c> lsttoolfrWDAll = [select id,name,RecordType.Name,SVMXC__Line_Type__c,GE_AL_Part_Description__c,GE_OG_SS_Product_Description__c,SVMXC__Start_Date_and_Time__c,SVMXC__End_Date_and_Time__c  from  SVMXC__Service_Order_Line__c where SVMXC__Service_Order__c=: Aid and RecordType.Name = 'Tools Forecast' order by name desc];
            if(lsttoolfrWDAll.size() > 5)
                recordSize = true;
            else
                recordSize = false;
       }
    }
     
}