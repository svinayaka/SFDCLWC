/*    
Trigger Name      : GE_HQ_UpdateIBwhen_IBM_Approved
Purpose/Overview  :  To update Sales Channel & Sales Manger of Ib with Installed Base Modification Request when its status is approved
Author            : Rekha.N
Change History    : Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
                  : 17th May 2012 : Rekha N            : Created: Created for the R-8278, BC S-05874
Test Class        : GE_HQ_UpdateIBwhen_IBM_Approved_Test
                  
*/
trigger GE_HQ_UpdateIBwhen_IBM_Approved on GE_HQ_IB_Mod_Request__c (after insert,after update) { 


    public list<GE_Installed_Base__c> IbRec=new list<GE_Installed_Base__c>();
    Map<Id,GE_Installed_Base__c> IbMap = new Map<Id,GE_Installed_Base__c>();
    Set<Id> IbIds = new Set<Id>();
    
    for(GE_HQ_IB_Mod_Request__c Ibmodify: Trigger.new){
        if(Ibmodify.GE_HQ_Status__c == 'Approved'){
            IbIds.add(Ibmodify.GE_HQ_Installed_Base__c);
        }
    }
    
    if( IbIds!=null && IbIds.size()>0){
    
        IbMap = new Map<Id,GE_Installed_Base__c>([Select id,name,GE_ES_Sales_Region__c,GE_ES_Sales_Channel__c,GE_ES_Account_Manager__c from GE_Installed_Base__c where id in :IbIds ]);    
        //M-->IbRec =[Select id,name,GE_ES_Sales_Region__c,GE_ES_Sales_Channel__c,GE_ES_Account_Manager__c from GE_Installed_Base__c where id=:Ibmodify.GE_HQ_Installed_Base__c limit 1 ];         
        
        
        for(GE_HQ_IB_Mod_Request__c Ibmodify: Trigger.new){  
         
            if(IbMap!= null && IbMap.containskey(Ibmodify.GE_HQ_Installed_Base__c)){
            
                GE_Installed_Base__c Ib=IbMap.get(Ibmodify.GE_HQ_Installed_Base__c); 
                               
                if(Ibmodify.GE_HQ_Status__c == 'Approved'){   
                
                   if(Ibmodify.GE_HQ_Sales_Chnl__c != null && Ibmodify.GE_HQ_Sales_Mgr__c != null){               
                       Ib.GE_ES_Sales_Channel__c = Ibmodify.GE_HQ_Sales_Chnl__c; 
                       Ib.GE_ES_Account_Manager__c = Ibmodify.GE_HQ_Sales_Mgr__c;
                   } else if (Ibmodify.GE_HQ_Sales_Chnl__c != null && Ibmodify.GE_HQ_Sales_Mgr__c == null){
                       Ib.GE_ES_Sales_Channel__c = Ibmodify.GE_HQ_Sales_Chnl__c; 
                   } 
                   else if (Ibmodify.GE_HQ_Sales_Chnl__c == null && Ibmodify.GE_HQ_Sales_Mgr__c != null){
                       Ib.GE_ES_Account_Manager__c = Ibmodify.GE_HQ_Sales_Mgr__c;
                   }
                   IbRec.add(Ib);
                 }
             }  
          } 
          
        update IbRec;
          
    }      
}