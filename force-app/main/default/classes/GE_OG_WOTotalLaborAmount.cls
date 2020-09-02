/**
Class Name: GE_OG_WOTotalLaborAmount
Used Where: GE_OG_SVMXCServiceOrderTriggerHandler
Purpose/Overview: A class to update the 'Total Labor Amount' field on Work Order.
Created Date: 17-AUG-2016
Test Class Name:  
Date Modified: 
*/
public class GE_OG_WOTotalLaborAmount
{
    public void UpdateTotalAmount(List<SVMXC__Service_Order__c>  newList)
    {
        List<SVMXC__Service_Order__c>  woList= new List<SVMXC__Service_Order__c>();
        set<id> woidset = new set<id>();
        set<id> caseidset = new set<id>();
        for(SVMXC__Service_Order__c wo :newlist)
        {
            woidset.add(wo.id);
            
        }
        List<SVMXC__Service_Order__c> updatewo= new List<SVMXC__Service_Order__c>();
        List<SVMXC__Service_Order_Line__c> wdList= new List<SVMXC__Service_Order_Line__c>();
        wdList=[Select Id,GE_DRL_Daily_Rate__c,GE_DRL_Overtime__c,SVMXC__Line_Type__c,GE_AL_MFL_Extended_Price_Labor__c,SVMXC__Service_Order__r.GE_DS_Overtime__c,SVMXC__Billable_Quantity__c ,
        SVMXC__Service_Order__r.GE_DS_Daily_Rate__c,GE_DS_Overtime_Hrs__c,GE_DS_Non_Billable_Hours__c,SVMXC__Total_Line_Price__c,SVMXC__Billable_Line_Price__c from SVMXC__Service_Order_Line__c where 
        SVMXC__Service_Order__r.id in: woidset AND (SVMXC__Line_Type__c='Labor' OR SVMXC__Line_Type__c='Expenses' )];
                
        Decimal wdTotalLinePrice=0;     
        for(SVMXC__Service_Order__c wo :newlist)
        {
           wo.GE_DS_Total_Labor_Amount__c=0;
            for(SVMXC__Service_Order_Line__c wd :wdList)
            {
            
                if(wd.SVMXC__Line_Type__c=='Labor'){
                if(wd.GE_AL_MFL_Extended_Price_Labor__c!=null){
                wo.GE_DS_Total_Labor_Amount__c += wd.GE_AL_MFL_Extended_Price_Labor__c; }
                else
                wo.adderror('The MFL Extended Price is Blank on Labor Line');
                }
                else{
                wdTotalLinePrice=wd.SVMXC__Billable_Line_Price__c;
                wo.GE_DS_Total_Labor_Amount__c += wdTotalLinePrice; 
                }
                wdTotalLinePrice=0;
            }
            updatewo.add(wo);
        }
        
      //Update 'Total Labor Amount' on Work Order
                
    }
    
}