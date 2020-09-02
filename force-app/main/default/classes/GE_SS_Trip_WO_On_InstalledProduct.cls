public class GE_SS_Trip_WO_On_InstalledProduct{

    public String idvalue{get;set;}
    SVMXC__Installed_Product__c objIP;
    public ID tmpID{get;set;}
    public boolean recordSize{get;set;}
    public String allrec{get;set;}
    public List<SVMXC__Service_Order__c> lstWorkOrder1{get;set;}
    public List<SVMXC__Service_Order_Line__c> lstWorkOrder{get;set;}
    
    public GE_SS_Trip_WO_On_InstalledProduct(ApexPages.StandardController controller) {
        SVMXC__Installed_Product__c objIP = (SVMXC__Installed_Product__c)controller.getRecord();
        System.debug('in controller');
        string IPname;
      // IPname= [select name from SVMXC__Installed_Product__c where id=:objIP.id];
       // objIP.Name;
       system.debug('objIP.Id !--->' + objIP.Id);
       tmpID = objIP.Id;
        recordSize=false;
        if(objIP.Id != null)
        {
            //lstWorkOrder = [select Id, SVMXC__Service_Order__r.Name, SVMXC__Service_Order__r.GE_SS_Parent_Work_Order__r.Name, SVMXC__Service_Order__r.GE_SM_HQ_Record_Type_Name__c, SVMXC__Service_Order__r.SVMXC__Order_Status__c, SVMXC__Service_Order__r.SVMXC__Order_Type__c,GE_SS_Delivered__c,GE_SS_Pre_installed__c,GE_SS_Usage_Type__c ,CreatedDate, LastModifiedBy.Name from  SVMXC__Service_Order_Line__c where SVMXC__Serial_Number__c=:objIP.Id AND SVMXC__Service_Order__r.GE_SM_HQ_Record_Type_Name__c = 'SS-Trip' order by createddate desc LIMIT 5];
        }
        
         tmpID = ApexPages.currentPage().getParameters().get('id');
         allRec = ApexPages.currentPage().getParameters().get('allrec');
         reload();
        
    }
        
  public void deleteWO()
 {
    // SVMXC__Installed_Product__c objIP = (SVMXC__Installed_Product__c)controller.getRecord();
    //// Case theCase = (Case) ctrl.getRecord();
   //  Id IPId = controller.getRecord().get('id'); 
     //String WOid= ApexPages.currentPage().getParameters().get('WOid'); 
     
    // SVMXC__Service_Order__c WO = [Select id from SVMXC__Service_Order__c where id =:WOid limit 1];
    // if(WO !=null && WO.id !=null){
    //  delete WO;
    // }
    //return null;
    
        Id tmpId = Id.valueOf(idvalue);
        SVMXC__Service_Order__c delWO = new SVMXC__Service_Order__c(id=tmpId);
        delete delWO;
        reload();
 } 
 
  public Pagereference editWO()
 {
    // SVMXC__Installed_Product__c objIP = (SVMXC__Installed_Product__c)controller.getRecord();
    //// Case theCase = (Case) ctrl.getRecord();
   //  Id IPId = controller.getRecord().get('id'); 
     String WOid= ApexPages.currentPage().getParameters().get('WOid'); 
     
    // SVMXC__Service_Order__c WO = [Select id from SVMXC__Service_Order__c where id =:WOid limit 1];
   //  if(WO !=null && WO.id !=null){
       //return new PageReference('/006/e?id='+WOid+'&retURL=/006/');
    pagereference pg = new PageReference('/'+WOid+'/e?retURL=%Fa' + WOid);
    pg.setredirect(true);
       return pg;
   //  }
    //return null;
 }  
 
 //public Pagereference displayAll()
// {
     //lstWorkOrder = [select Id, SVMXC__Service_Order__r.Name, SVMXC__Service_Order__r.GE_SS_Parent_Work_Order__r.Name, SVMXC__Service_Order__r.GE_SM_HQ_Record_Type_Name__c, SVMXC__Service_Order__r.SVMXC__Order_Status__c, SVMXC__Service_Order__r.SVMXC__Order_Type__c,GE_SS_Delivered__c,GE_SS_Pre_installed__c,GE_SS_Usage_Type__c ,CreatedDate, LastModifiedBy.Name from  SVMXC__Service_Order_Line__c where SVMXC__Serial_Number__c=:objIP.Id AND SVMXC__Service_Order__r.GE_SM_HQ_Record_Type_Name__c = 'SS-Trip' order by createddate desc];
     
     
 //}
 
 public void reload() {
         if(allrec == 'true') {
             lstWorkOrder = [select Id, SVMXC__Service_Order__r.Name,SVMXC__Service_Order__r.GE_SM_HQ_Actual_Start_Date__c,SVMXC__Service_Order__r.GE_SM_HQ_Actual_End_Date__c,SVMXC__Service_Order__r.GE_SS_Uptime_Hours__c,SVMXC__Service_Order__r.GE_SS_Downtime_NPT_Hours__c,SVMXC__Service_Order__r.GE_SS_Reliability__c, SVMXC__Service_Order__r.GE_SS_Parent_Work_Order__r.Name, SVMXC__Service_Order__r.GE_SM_HQ_Record_Type_Name__c, SVMXC__Service_Order__r.SVMXC__Order_Status__c, SVMXC__Service_Order__r.SVMXC__Order_Type__c, SVMXC__Service_Order__r.createdbyID,GE_SS_Delivered__c,GE_SS_Pre_installed__c,GE_SS_Usage_Type__c ,CreatedDate, LastModifiedBy.Name from  SVMXC__Service_Order_Line__c where SVMXC__Serial_Number__c=:tmpID AND SVMXC__Service_Order__r.GE_SM_HQ_Record_Type_Name__c = 'SS-Trip' order by createddate desc];
         }
         else if(tmpID != null){
            lstWorkOrder = [select Id,SVMXC__Service_Order__r.Name, SVMXC__Service_Order__r.GE_SM_HQ_Actual_Start_Date__c,SVMXC__Service_Order__r.GE_SM_HQ_Actual_End_Date__c,SVMXC__Service_Order__r.GE_SS_Uptime_Hours__c,SVMXC__Service_Order__r.GE_SS_Downtime_NPT_Hours__c,SVMXC__Service_Order__r.GE_SS_Reliability__c, SVMXC__Service_Order__r.GE_SS_Parent_Work_Order__r.Name, SVMXC__Service_Order__r.GE_SM_HQ_Record_Type_Name__c, SVMXC__Service_Order__r.SVMXC__Order_Status__c, SVMXC__Service_Order__r.SVMXC__Order_Type__c, SVMXC__Service_Order__r.createdbyID,GE_SS_Delivered__c,GE_SS_Pre_installed__c,GE_SS_Usage_Type__c ,CreatedDate, LastModifiedBy.Name from  SVMXC__Service_Order_Line__c where SVMXC__Serial_Number__c=:tmpID AND SVMXC__Service_Order__r.GE_SM_HQ_Record_Type_Name__c = 'SS-Trip' order by createddate desc LIMIT 5];
            List<SVMXC__Service_Order_Line__c> lstWorkOrderAll = [select Id, SVMXC__Service_Order__r.Name,SVMXC__Service_Order__r.GE_SM_HQ_Actual_Start_Date__c,SVMXC__Service_Order__r.GE_SM_HQ_Actual_End_Date__c,SVMXC__Service_Order__r.GE_SS_Uptime_Hours__c,SVMXC__Service_Order__r.GE_SS_Downtime_NPT_Hours__c,SVMXC__Service_Order__r.GE_SS_Reliability__c, SVMXC__Service_Order__r.GE_SS_Parent_Work_Order__r.Name, SVMXC__Service_Order__r.GE_SM_HQ_Record_Type_Name__c, SVMXC__Service_Order__r.SVMXC__Order_Status__c, SVMXC__Service_Order__r.SVMXC__Order_Type__c, SVMXC__Service_Order__r.createdbyID,GE_SS_Delivered__c,GE_SS_Pre_installed__c,GE_SS_Usage_Type__c ,CreatedDate, LastModifiedBy.Name from  SVMXC__Service_Order_Line__c where SVMXC__Serial_Number__c=:tmpID AND SVMXC__Service_Order__r.GE_SM_HQ_Record_Type_Name__c = 'SS-Trip'];
            if(lstWorkOrderAll.size() > 5)
                recordSize = true;
            else
                recordSize = false;
       }
    }
}


//select Id, SVMXC__Service_Order__r.Name, SVMXC__Service_Order__r.GE_SS_Parent_Work_Order__r.Name, SVMXC__Service_Order__r.GE_SM_HQ_Record_Type_Name__c, SVMXC__Service_Order__r.SVMXC__Order_Status__c, SVMXC__Service_Order__r.SVMXC__Order_Type__c,GE_SS_Delivered__c,GE_SS_Pre_installed__c,GE_SS_Usage_Type__c ,CreatedDate, LastModifiedBy.Name from  SVMXC__Service_Order_Line__c where SVMXC__Serial_Number__c=:objIP.Id AND SVMXC__Service_Order__r.GE_SM_HQ_Record_Type_Name__c = 'SS-Trip' order by createddate desc LIMIT 5