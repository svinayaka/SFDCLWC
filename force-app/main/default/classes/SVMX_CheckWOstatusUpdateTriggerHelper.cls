public class SVMX_CheckWOstatusUpdateTriggerHelper{

    Set<Id> svoid = new Set<id>();
    Set<Id> svoinsertid = new Set<Id>(); 
    Set<Id> cs = new Set<id>();
    Set<Id> csinsertid = new Set<id>();
    Set<Id> techid = new Set<Id>();
    List<SVMXC__Service_Order__c> updatedWOfecthlst = new List<SVMXC__Service_Order__c>();
    Map<id,List<SVMXC__Service_Order__c>> mapclwolst = new Map<id,List<SVMXC__Service_Order__c>>();
    Map<id,List<SVMXC__Service_Order__c>> mapallwolst = new Map<id,List<SVMXC__Service_Order__c>>();
    Map<Id,Case> mapcase = new Map<Id,Case>();
    Id rtId = Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('D&S').getRecordTypeId();
    Id dsrtId = Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('MCS').getRecordTypeId();     

    public void updateCaseonWorkOrderCloseAfterInsert(List<SVMXC__Service_Order__c> insertedWOlst){
    
        System.debug('******Inside Class******');
        //System.debug('******updatedWOlst List******'+updatedWOlst);
    
        /*for(SVMXC__Service_Order__c wo:updatedWOlst)
        {
            if(wo.SVMXC__Order_Status__c!=null && wo.RecordtypeId==rtId)
            {
                svoid.add(wo.id);
                if (wo.SVMXC__Case__c != null)
                {
                    cs.add(wo.SVMXC__Case__c);
                }
                System.debug('******SVoiD size******'+svoid.size());
                System.debug('******cs size******'+cs.size());
            }
        }*/
        
        for(SVMXC__Service_Order__c wo:insertedWOlst)
        {
        
            if(wo.SVMXC__Order_Status__c != null && (wo.RecordTypeId == rtId || wo.RecordTypeId == dsrtId))
            {
            //fetching wo&case records for 'All Work Order Closed' checkbox update on insert of wo
                svoinsertid.add(wo.id);
                if (wo.SVMXC__Case__c != null)
                csinsertid.add(wo.SVMXC__Case__c);
            }  
        }
        
        //if(svoid.size() > 0 || svoinsertid.size()>0)
        //svoinsertid.addAll(svoid);
        System.debug('******svoinsertid size******'+svoinsertid.size());
        //if(cs.size() >0 || csinsertid.size() >0)
        //csinsertid.addAll(cs);
        System.debug('******csinsertid size******'+csinsertid.size());
        if(svoinsertid.size() > 0 && csinsertid.size()>0)
        {
            system.debug('here1');
            updatedWOfecthlst = [select id, Name, SVMXC__Order_Status__c,SVMXC__Case__c,SVMXC__Case__r.GE_OG_DS_All_Work_Orders_Closed__c, RecordTypeId from SVMXC__Service_Order__c where SVMXC__Case__c IN :csinsertid and (RecordTypeId =:rtId or RecordTypeId =:dsrtId )];
             
            for(SVMXC__Service_Order__c s:updatedWOfecthlst)
            {
                //collecting the wo records that are closed/canceled/completed for case
                if (s.SVMXC__Order_Status__c == 'Closed' || s.SVMXC__Order_Status__c == 'Canceled' || s.SVMXC__Order_Status__c == 'Completed')
                {
                    system.debug('here2');
                    if(mapclwolst.containsKey(s.SVMXC__Case__c))
                        mapclwolst.get(s.SVMXC__Case__c).add(s);
                    else
                        mapclwolst.put(s.SVMXC__Case__c, new List<SVMXC__Service_Order__c>{s});
                }
                    
                //collecting all the wo records of case
                system.debug('here3');
                if(mapallwolst.containsKey(s.SVMXC__Case__c))
                    mapallwolst.get(s.SVMXC__Case__c).add(s);
                else
                    mapallwolst.put(s.SVMXC__Case__c, new List<SVMXC__Service_Order__c>{s});
                    
                    System.debug('******* mapclwolst ***********'+mapclwolst);
                    System.debug('******* mapallwolst ***********'+mapallwolst);
                    
            }
              
            for(SVMXC__Service_Order__c s:updatedWOfecthlst)
            {   
                //comparing closed wo records with all wo records for case
                if(mapclwolst.containskey(s.SVMXC__Case__c) && mapclwolst.get(s.SVMXC__Case__c).size() == mapallwolst.get(s.SVMXC__Case__c).size())
                {  
                    System.debug('******* Inside if ***********');
                    system.debug('here4');
                    Case csupt = new Case(Id = s.SVMXC__Case__c);
                    csupt.GE_OG_DS_All_Work_Orders_Closed__c = true;
                    csupt.Status='Pending Billing';
                    mapcase.put(s.SVMXC__Case__c,csupt);
                }
                else
                {
                    System.debug('******* Inside else ***********');
                    system.debug('here5');                          
                    Case csuptf = new Case(Id = s.SVMXC__Case__c);
                    csuptf.GE_OG_DS_All_Work_Orders_Closed__c = false;
                    mapcase.put(s.SVMXC__Case__c,csuptf);
                }
            }
        }
        
         if(mapcase.size() >0) 
        update mapcase.values();
        
        
    }
    
     public void updateCaseonWorkOrderCloseAfterUpdate(List<SVMXC__Service_Order__c> updatedWOlst, List<SVMXC__Service_Order__c> beoforeupdateWOlst){
    
        System.debug('******Inside Class******');
        //System.debug('******updatedWOlst List******'+updatedWOlst);
        for (SVMXC__Service_Order__c wo1:beoforeupdateWOlst)
        {
            for(SVMXC__Service_Order__c wo:updatedWOlst)
            {
                if(wo.SVMXC__Order_Status__c!= wo1.SVMXC__Order_Status__c)
                {
                    if(wo.SVMXC__Order_Status__c!=null && (wo.RecordtypeId==rtId || wo.RecordtypeId==dsrtId))
                    {
                        svoid.add(wo.id);
                        if (wo.SVMXC__Case__c != null)
                        {
                            cs.add(wo.SVMXC__Case__c);
                        }
                    System.debug('******SVoiD size******'+svoid.size());
                    System.debug('******cs size******'+cs.size());
                    }
                }
            }
        }
        /*for(SVMXC__Service_Order__c wo:insertedWOlst)
        {
        
            if(wo.SVMXC__Order_Status__c != null && wo.RecordTypeId == rtId)
            {
            //fetching wo&case records for 'All Work Order Closed' checkbox update on insert of wo
                svoinsertid.add(wo.id);
                if (wo.SVMXC__Case__c != null)
                csinsertid.add(wo.SVMXC__Case__c);
            }  
        }*/
        
        //if(svoid.size() > 0 || svoinsertid.size()>0)
        //svoinsertid.addAll(svoid);
        //System.debug('******svoinsertid size******'+svoinsertid.size());
        //if(cs.size() >0 || csinsertid.size() >0)
        //csinsertid.addAll(cs);
        //System.debug('******csinsertid size******'+csinsertid.size());
        if(svoid.size() > 0 && cs.size()>0)
        {
            system.debug('here1');
            updatedWOfecthlst = [select id, Name, SVMXC__Order_Status__c,SVMXC__Case__c,SVMXC__Case__r.GE_OG_DS_All_Work_Orders_Closed__c, RecordTypeId from SVMXC__Service_Order__c where SVMXC__Case__c IN :cs and (RecordTypeId =:rtId or RecordTypeId =:dsrtId)];
             
            for(SVMXC__Service_Order__c s:updatedWOfecthlst)
            {
                //collecting the wo records that are closed/canceled/completed for case
                if (s.SVMXC__Order_Status__c == 'Closed' || s.SVMXC__Order_Status__c == 'Canceled' || s.SVMXC__Order_Status__c == 'Completed')
                {
                    system.debug('here2');
                    if(mapclwolst.containsKey(s.SVMXC__Case__c))
                        mapclwolst.get(s.SVMXC__Case__c).add(s);
                    else
                        mapclwolst.put(s.SVMXC__Case__c, new List<SVMXC__Service_Order__c>{s});
                }
                    
                //collecting all the wo records of case
                system.debug('here3');
                if(mapallwolst.containsKey(s.SVMXC__Case__c))
                    mapallwolst.get(s.SVMXC__Case__c).add(s);
                else
                    mapallwolst.put(s.SVMXC__Case__c, new List<SVMXC__Service_Order__c>{s});
                    
                    System.debug('******* mapclwolst ***********'+mapclwolst);
                    System.debug('******* mapallwolst ***********'+mapallwolst);
                    
            }
              
            for(SVMXC__Service_Order__c s:updatedWOfecthlst)
            {   
                //comparing closed wo records with all wo records for case
                if(mapclwolst.containskey(s.SVMXC__Case__c) && mapclwolst.get(s.SVMXC__Case__c).size() == mapallwolst.get(s.SVMXC__Case__c).size())
                {  
                    System.debug('******* Inside if ***********');
                    system.debug('here4');
                    Case csupt = new Case(Id = s.SVMXC__Case__c);
                    csupt.GE_OG_DS_All_Work_Orders_Closed__c = true;
                    csupt.Status='Closed';
                    //csupt.Status='Pending Billing';
                    mapcase.put(s.SVMXC__Case__c,csupt);
                }
                else
                {
                    System.debug('******* Inside else ***********');
                    system.debug('here5');                          
                    Case csuptf = new Case(Id = s.SVMXC__Case__c);
                    csuptf.GE_OG_DS_All_Work_Orders_Closed__c = false;
                    csuptf.Status='Open';
                    mapcase.put(s.SVMXC__Case__c,csuptf);
                }
            }
        }
        
         if(mapcase.size() >0) 
        update mapcase.values();
        
        
    }

}