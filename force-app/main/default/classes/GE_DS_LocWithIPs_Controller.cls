/*
================================================================
Class Name      : GE_DS_LocWithIPs_Controller
Author          : Jagan Mohan Cherlakola
Created Date    : 12/12/2013
Reason          : This Class is used with 'GE_DS_LocWithIPs' page to display the configuration of Installed Products on Location.
Test Class      : GE_DS_LocWithIPs_ControllerTest
================================================================
*/


public class GE_DS_LocWithIPs_Controller {

    Public string loc_id{get;set;}
    
     List<SVMXC__Installed_Product__c> ips = new  List<SVMXC__Installed_Product__c>();
     List<SVMXC__Installed_Product__c> ipList = new  List<SVMXC__Installed_Product__c>();
     public Boolean expand{get;set;}
     public integer x{get;set;}


    public GE_DS_LocWithIPs_Controller(ApexPages.StandardController controller) {
    
    loc_id = apexpages.currentpage().getparameters().get('id');
    expand= true;
     //getIps();
     System.debug('***'+loc_id);
     x=0;

    }
    
   /* public GE_DS_LocWithIPs_Controller(){
     loc_id = apexpages.currentpage().getparameters().get('id');
     getIps();
     System.debug('***'+loc_id);
     
     }*/
    
    
     public List<SVMXC__Installed_Product__c> getIps()
             {
             
                // nandAttachments = new List<CustomAttachment>();
                System.debug('***'+loc_id);
               
                 
                 ips = [SELECT ID,Name,SVMXC__Product_Name__c,SVMXC__Serial_Lot_Number__c,SVMXC__Status__c,SVMXC__City__c,SVMXC__Country__c from SVMXC__Installed_Product__c  where SVMXC__Site__c = :loc_id ];
                System.debug('**'+ips);
             
                /* for(SVMXC__Installed_Product__c ip  : ips )
                    {
                        ipList.add(ip);
                    }
                    return ipList;
             */
             return ips;
             
             }
    
    
     public String sortBy { get; set; }
    
    public String sortDir { get; set; }
    
    
     public PageReference empty() { return null; }
   
    
    
    @TestVisible private List<SObject> sortList(List<SObject> cleanList)
    {
    
     if (sortBy == null) { return cleanList; }
    
     List<SObject> resultList = new List<SObject>();
    
     Map<Object, List<SObject>> objectMap = new Map<Object, List<SObject>>();
    
    for (SObject item : cleanList) {
    if (objectMap.get(item.get(sortBy)) == null) {
    objectMap.put(item.get(sortBy), new List<SObject>());
    }
    objectMap.get(item.get(sortBy)).add(item);
    }
    
    List<Object> keys = new List<Object>(objectMap.keySet());
    keys.sort();
    
    for(Object key : keys) {
    resultList.addAll(objectMap.get(key));
    }
    
    cleanList.clear();
    
    if (sortDir == 'ASC') {
    for (SObject item : resultList) {
    cleanList.add(item);
    }
    } else {
    for (Integer i = resultList.size()-1; i >= 0; i--) {
    cleanList.add(resultList[i]);
    }
    }
    
    return cleanList;
    }

}