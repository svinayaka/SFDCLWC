/**
* 
* Class/Trigger Name--: GE_OG_MCS_EventupdateWO
* Used Where ?--------: When 'Subject' field of ServiceMax Event is updated.
* Purpose/Overview----: WorkOrder 'Subject' field should populate the same value as of related ServiceMax Event 'Subject' field.
* Functional Area-----: M&C ServiceMax
* Author--------------: Somanath dash
* Created Date--------: 
* Test Class Name-----: GE_OG_MCS_EventupdateWO_Test
* Change History -
* Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
**/



public class GE_OG_MCS_EventupdateWO{
    
    //public Static Integer HasEventAlreadyUpdatedWO=0;
    ID Rectype=Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('MCS').getRecordTypeId();
    Set<id> WhatIdset = new Set<id>();
    Map<Id, SVMXC__Service_Order__c> WOMap=new Map<Id, SVMXC__Service_Order__c>();
    List<SVMXC__Service_Order__c> finalWOListtoUpdate =new List<SVMXC__Service_Order__c>();
    Set<ID> uniqueWOIDs = new SET<ID>();  
    
    //Instantiate the CCodeUtilization Class
    GE_CodeUtilization cu = new GE_CodeUtilization();      
    
    
    public void afterupdatesvmxevent(List<SVMXC__SVMX_Event__c> oldSVMXEvent,List<SVMXC__SVMX_Event__c> newSVMXEvent,Map<Id, SVMXC__SVMX_Event__c> newObjectMap){ 
        
        for(SVMXC__SVMX_Event__c event:newSVMXEvent){
            WhatIdset.add(event.SVMXC__WhatId__c);                       
        }
        
        if(WhatIdset!=null)System.debug('Size::'+WhatIdset.size());
        
        WOMap.putall([Select id,RecordtypeId,Name,GE_OG_MC_Subject__c from SVMXC__Service_Order__c where ID in :WhatIdset and RecordTypeId=:Rectype]);
        System.debug('HErrrrrreeeeee is the map---> size '+WOMap.size()+' WO map list '+WOMap); 
        
        //list<SVMXC__Service_Order__c> toUpdate;
        
        if(WOMap.size()>0){
            System.debug('oldSVMXEvent Size::'+oldSVMXEvent.size());
            for(SVMXC__SVMX_Event__c event:oldSVMXEvent){
                // edit related to Bug 0000022295 - only use events that have a What Id
                System.debug('ID of the event being Processed: ' + event.Id);
                if(event.SVMXC__WhatId__c != null){
                    //adding try/catch with Bug 0000022295
                    try{
                        if(WOMap.get(event.SVMXC__WhatId__c).RecordTypeId==Rectype){
                            if(newObjectMap.get(event.id).SVMXC__Service_Order__c!=Null&&newObjectMap.get(event.id).Name!=Null){                            
                                if(event.Name!=newObjectMap.get(event.id).Name)
                                {
                                    // To avoide duplicate Workorders  
                                    if(!uniqueWOIDs.contains(event.SVMXC__WhatId__c))
                                    {   
                                        WOMap.get(event.SVMXC__WhatId__c).GE_OG_MC_Subject__c=newObjectMap.get(event.id).Name; 
                                        finalWOListtoUpdate.add(WOMap.Values());
                                        uniqueWOIDs.add(event.SVMXC__WhatId__c);
                                        system.debug('wolist during addition '+finalWOListtoUpdate);
                                        system.debug('wolist during addition '+uniqueWOIDs);
                                        //Class the insert insertCodeUtilization Method
    									cu.insertCodeUtilization('GE_OG_MCS_EventupdateWO', 'Apex Class');
                                    }
                                }
                            } 
                        }
                    } // added exception handling with bug 0000022295
                    Catch(Exception e){
                        System.debug('Exception caught.  Bad WhatId (' + event.SVMXC__WhatId__c + ') tied to Event Id: '+event.Id);                        
                    }
                }// end edit for bug 0000022295
                
            }               
        }
        system.debug('$$$$ Is it updateing work order $$$$$ at last '+finalWOListtoUpdate);
        //if(GE_OG_MCS_WOupdateEvent.check <=1)
        
        if(finalWOListtoUpdate.size()>0)
            update finalWOListtoUpdate;
        
        
        // HasEventAlreadyUpdatedWO++;      
        system.debug('$$$$ Is it updateing work order $$$$$'+finalWOListtoUpdate);
        
        
    }
    
}