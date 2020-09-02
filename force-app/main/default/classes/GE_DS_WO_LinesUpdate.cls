/**
Class Name: GE_DS_WO_LinesUpdate
Used Where: 
Purpose/Overview: A class to update all the Work detail lines with the OverTime rate & Daily rate as per work order information.
Author: Sathyanarayana Borugula
Created Date: 17-AUG-2016
Test Class Name:  
Date Modified: 
*/
public without sharing class GE_DS_WO_LinesUpdate{

    Set<Id> woId = new Set<Id>();
    List<SVMXC__Service_Order__c> newList;
    List<SVMXC__Service_Order__c> newWoList;
    List<SVMXC__Service_Order_Line__c> wdList;
    private static boolean flag = true;
    //Map<Id,List<SVMXC__Service_Order_Line__c>> wodetailMap = new Map<Id,List<SVMXC__Service_Order_Line__c>>();
    
    public void updateLineItemRates(List<SVMXC__Service_Order__c> newObjects ,List<SVMXC__Service_Order__c> oldObjects){
        
        
        ID DRLRectypeId=Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('D&S').getRecordTypeId();
        
        System.debug( 'From the trigger : Before' +newObjects+'Size is :'+newObjects.size());
        System.debug( 'From the trigger : Before old values are ' +oldObjects+'Size is :'+oldObjects.size());
            if(newObjects.size()>0 && flag == true){
            System.debug( 'From the trigger : ' + newObjects);
                wdList= new List<SVMXC__Service_Order_Line__c>();
                    for(SVMXC__Service_Order__c oldObj :oldObjects){
                        for(SVMXC__Service_Order__c  woObj :newObjects){
                            if(woObj.id == oldObj.id && DRLRectypeId == woObj.RecordTypeId && (woObj.GE_DS_Daily_Rate__c!= oldObj.GE_DS_Daily_Rate__c || woObj.GE_DS_Overtime__c!= oldObj.GE_DS_Overtime__c)){
                                        woId.add(oldObj.id);                                                        
                                    }
                                }
                }
                System.debug('The work Order lines are :'+ woId);
                 wdList = [Select Id,GE_DRL_Daily_Rate__c,GE_DRL_Overtime__c,SVMXC__Service_Order__r.GE_DS_Overtime__c,SVMXC__Service_Order__r.GE_DS_Daily_Rate__c ,
                             SVMXC__Billable_Quantity__c,GE_DS_Overtime_Hrs__c,GE_DS_Non_Billable_Hours__c from SVMXC__Service_Order_Line__c where SVMXC__Service_Order__r.id in: woId AND SVMXC__Line_Type__c='Labor' ];
                    if(wdList.size()>0){
                    
                     System.debug('The work detail lines are : '+wdList );
                     for(SVMXC__Service_Order_Line__c wd :wdList)
                     {
                        
                        System.debug('in the loop old values are ' + wd.GE_DRL_Daily_Rate__c+ 'over time :'+ wd.GE_DRL_Overtime__c);
                            wd.GE_DRL_Daily_Rate__c = wd.SVMXC__Service_Order__r.GE_DS_Daily_Rate__c;
                            wd.GE_DRL_Overtime__c= wd.SVMXC__Service_Order__r.GE_DS_Overtime__c;
                            if(wd.SVMXC__Billable_Quantity__c != null && wd.GE_DS_Overtime_Hrs__c != null && wd.GE_DS_Non_Billable_Hours__c != null &&
                               wd.SVMXC__Service_Order__r.GE_DS_Daily_Rate__c != null && wd.SVMXC__Service_Order__r.GE_DS_Overtime__c != null ){
                               //Decimal price=0.00;
                              // price= (((wd.SVMXC__Billable_Quantity__c - (wd.GE_DS_Overtime_Hrs__c + wd.GE_DS_Non_Billable_Hours__c )) * (wd.SVMXC__Service_Order__r.GE_DS_Daily_Rate__c/ 12))+ (wd.SVMXC__Service_Order__r.GE_DS_Overtime__c * wd.GE_DS_Overtime_Hrs__c )).setScale(2);
                               wd.GE_AL_MFL_Extended_Price_Labor__c =(((wd.SVMXC__Billable_Quantity__c - (wd.GE_DS_Overtime_Hrs__c + wd.GE_DS_Non_Billable_Hours__c ))*(wd.SVMXC__Service_Order__r.GE_DS_Daily_Rate__c/ 12))+ (wd.SVMXC__Service_Order__r.GE_DS_Overtime__c * wd.GE_DS_Overtime_Hrs__c )).setScale(2);
                               System.debug('Price MFL 2 :' + wd.GE_AL_MFL_Extended_Price_Labor__c);
                           }
                           else{
                           if(wd.GE_DS_Overtime_Hrs__c == null || wd.GE_DS_Non_Billable_Hours__c == null){
                               if(wd.GE_DS_Overtime_Hrs__c == null){
                                   wd.GE_DS_Overtime_Hrs__c =0;}
                               if(wd.GE_DS_Non_Billable_Hours__c ==null){ 
                                   wd.GE_DS_Non_Billable_Hours__c =0;}
                           Decimal price=0.00;
                               price= (((wd.SVMXC__Billable_Quantity__c - (wd.GE_DS_Overtime_Hrs__c + wd.GE_DS_Non_Billable_Hours__c )) * (wd.SVMXC__Service_Order__r.GE_DS_Daily_Rate__c/ 12))+ (wd.SVMXC__Service_Order__r.GE_DS_Overtime__c * wd.GE_DS_Overtime_Hrs__c )).setScale(2);
                               wd.GE_AL_MFL_Extended_Price_Labor__c =price;
                                }
                             }
                     
                        } 
                 }
             System.debug('The updated work details list is : '+wdList );
             update wdList;
             flag = false;           
        }    
        
    }
    public static void deleteTasklines(List<SVMXC__Service_Order_Line__c> oldWDlbr){
        ID DRLRectypeId=Schema.SObjectType.SVMXC__Service_Order_Line__c.getRecordTypeInfosByName().get('Drilling RecordType').getRecordTypeId();
        Set<ID> wdlbrIDs = new Set<Id>();         
        List<SVMXC__Service_Order_Line__c> oldWDtaskList = new List<SVMXC__Service_Order_Line__c> ();
        for(SVMXC__Service_Order_Line__c wdLabor :oldWDlbr){
            wdlbrIDs.add(wdLabor.Id);
        }
        if(!wdlbrIDs.isEmpty()){
            oldWDtaskList = [select id,name,SVMXC__Work_Detail__c from SVMXC__Service_Order_Line__c where SVMXC__Work_Detail__c=:wdlbrIDs and recordtypeId=:DRLRectypeId and SVMXC__Line_Type__c='Task'];
        }
        if(!oldWDtaskList.isEmpty()){
            delete oldWDtaskList;
        }
    }
}