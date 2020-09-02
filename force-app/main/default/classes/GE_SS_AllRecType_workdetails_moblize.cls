public with sharing class GE_SS_AllRecType_workdetails_moblize{

    public List<SVMXC__Service_Order_Line__c> lsttoolfrWD{get; set;}
    public Id Aid {get;set;}
    public String idval{get;set;}
    public String redirectURL{get;set;}
    public boolean recordSize{get;set;}
    public String allRec{get;set;}
    
    public GE_SS_AllRecType_workdetails_moblize(ApexPages.StandardController controller) {
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
            lsttoolfrWD= [SELECT Id,Name,
                                                 RecordType.Name,SVMXC__Line_Type__c,
                                                 SVMXC__Start_Date_and_Time__c,SVMXC__End_Date_and_Time__c,
                                                 SVMXC__Serial_Number__c,SVMXC__Serial_Number__r.Name,
                                                 GE_SS_Product_Name__c,GE_SS_Product_Description__c,
                                                 GE_SS_Quantity__c,GE_SS_Delivered__c,GE_SS_Used__c, 
                                                 Tools_Product_Name__c,Tools_Product_Description__c,SVMXC__Requested_Quantity2__c,
                                                 Delivered_To__c,Backload__c,GE_Shipped_Date_to_Customer__c,GE_Shipped_Date_to_GE__c
                                                 FROM  SVMXC__Service_Order_Line__c 
                                                 WHERE SVMXC__Service_Order__c=: Aid AND
                                                 (RecordType.Name = 'Tools' OR RecordType.Name = 'Equipment' OR RecordType.Name = 'Spares') Order by Name desc];
         
         }
         else if(Aid != null) {           
            lsttoolfrWD = [SELECT Id,Name,
                                                  RecordType.Name,SVMXC__Line_Type__c,
                                                  SVMXC__Start_Date_and_Time__c,SVMXC__End_Date_and_Time__c,
                                                  SVMXC__Serial_Number__c,SVMXC__Serial_Number__r.Name,
                                                  GE_SS_Product_Name__c,GE_SS_Product_Description__c,
                                                  GE_SS_Quantity__c,GE_SS_Delivered__c,GE_SS_Used__c,
                                                  Tools_Product_Name__c,Tools_Product_Description__c,SVMXC__Requested_Quantity2__c,
                                                  Delivered_To__c,Backload__c,GE_Shipped_Date_to_Customer__c,GE_Shipped_Date_to_GE__c
                                                  FROM SVMXC__Service_Order_Line__c 
                                                  WHERE SVMXC__Service_Order__c =: Aid AND 
                                                  (RecordType.Name = 'Tools' OR RecordType.Name = 'Equipment' OR RecordType.Name = 'Spares') Order by Name desc LIMIT 5 ];
           
            List<SVMXC__Service_Order_Line__c> lsttoolfrWDAll = [ SELECT Id,Name 
                                                                                                                        FROM  SVMXC__Service_Order_Line__c
                                                                                                                        WHERE SVMXC__Service_Order__c =: Aid AND 
                                                                                                                        ( RecordType.Name = 'Tools' OR 
                                                                                                                          RecordType.Name = 'Equipment' OR
                                                                                                                          RecordType.Name = 'Spares' ) ] ;            
            
            if(lsttoolfrWDAll.size() > 5)
                recordSize = true;
            else
                recordSize = false;
       }
    }
     
}