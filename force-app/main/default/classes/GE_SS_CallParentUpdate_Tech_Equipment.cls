public class GE_SS_CallParentUpdate_Tech_Equipment  {
    //@InvocableMethod
    //public static void callParentUpdateTechEquip(list<Id> lstRecordIds) {
    public void callParentUpdateTechEquip(list<Id> lstRecordIds) {
         
        System.debug('-------list of record to proceed: '+lstRecordIds);
        if(lstRecordIds != null && lstRecordIds.size() > 0){
            List<Work_Activity__c> lstTechAssingment = new List<Work_Activity__c>();
            Map<ID, Set<Work_Activity__c>> mapTechIDtoLstTA = new Map<ID, Set<Work_Activity__c>>();
            Map<Id, SVMXC__Service_Group_Members__c> mapTech = new Map<Id, SVMXC__Service_Group_Members__c>();
            List<SVMXC__Service_Group_Members__c> lstUpdateTech = new List<SVMXC__Service_Group_Members__c>();
            map<Id, SVMXC__Service_Group_Members__c> MapTechician = new map<Id, SVMXC__Service_Group_Members__c>();
            //List<GE_SS_Service_Ticket__c> lstrecServiceTkt = New List<GE_SS_Service_Ticket__c>();

            MapTechician.putAll([Select Id, GE_SS_Total_Actual_Days_in_Service__c from SVMXC__Service_Group_Members__c where Id IN: lstRecordIds]); //contains lookup to technician
            
             /* lstrecServiceTkt = [select id, GE_SS_Days_in_Service__c,GE_SS_Service_Representative__c,GE_SS_Service_Representative__r.id from GE_SS_Service_Ticket__c where GE_SS_Service_Representative__c IN: lstRecordIds];

        for(Id recTech : MapTechician.keyset()){   

            Decimal totaldaysInservice = 0.0;
            System.debug('-------------'+totaldaysInservice);
            for(GE_SS_Service_Ticket__c recServiceTkt : lstrecServiceTkt){
                System.debug('------S-ticket-------'+recServiceTkt);
              if(recServiceTkt.GE_SS_Service_Representative__r.id == recTech)
                 System.debug('-------both are same------'+totaldaysInservice);               
                totaldaysInservice = totaldaysInservice + recServiceTkt.GE_SS_Days_in_Service__c ;  
                 System.debug('-------------'+totaldaysInservice);              
            }
            
            SVMXC__Service_Group_Members__c lstTech = MapTechician.get(recTech);
            lsttech.GE_SS_Total_Actual_Days_in_Service__c  = totaldaysInservice;

            MapTechician.put(recTech,lstTech);
            system.debug('------->' + MapTechician);

        }
        
        if(!MapTechician.isempty()){
           update MapTechician.values();
        }
*/


            lstTechAssingment = [select Id, Technician_Equipment__c, GE_SS_Total_Days_in_Service__c, StartTime__c, EndTime__c from Work_Activity__c where Technician_Equipment__c IN: lstRecordIds];
            
            
            System.debug('lstTechAssingment: '+lstTechAssingment);
            
            for(Id TechId : lstRecordIds)
                mapTechIDtoLstTA.put(TechId, new Set<Work_Activity__c>());
            
            for(Work_Activity__c ObjTA : lstTechAssingment)
            {
                if(ObjTA.Technician_Equipment__c != null && ObjTA.GE_SS_Total_Days_in_Service__c != null && ObjTA.GE_SS_Total_Days_in_Service__c > 0)
                    System.debug('mapTechIDtoLstTA.containsKey(ObjTA.Technician_Equipment__c): '+mapTechIDtoLstTA.containsKey(ObjTA.Technician_Equipment__c));
                    if(!mapTechIDtoLstTA.containsKey(ObjTA.Technician_Equipment__c))
                        mapTechIDtoLstTA.put(ObjTA.Technician_Equipment__c, new Set<Work_Activity__c>());
                    System.debug('mapTechIDtoLstTA: '+mapTechIDtoLstTA);
                    mapTechIDtoLstTA.get(ObjTA.Technician_Equipment__c).add(ObjTA);
            }
            
            mapTech.putAll([Select Id, GE_SS_Total_Calendar_Days_Scheduled__c from SVMXC__Service_Group_Members__c where Id IN: mapTechIDtoLstTA.keySet()]);
            
            if(mapTechIDtoLstTA != null && mapTechIDtoLstTA.size() > 0)
            {
                for(Id idTech : mapTechIDtoLstTA.keySet())
                {
                    if(mapTech.containsKey(idTech))
                    {
                        integer intCount = 0;
                        Date startDateOfYear = Date.newInstance(System.now().year(), 1, 1);
                        Date endDateOfYear = Date.newInstance(System.now().year(), 12, 31);
                        for(Work_Activity__c objTech : mapTechIDtoLstTA.get(idTech))
                        {
                            /* System.debug('objTech.GE_SS_Total_Days_in_Service__c: '+objTech.GE_SS_Total_Days_in_Service__c);
                            if(objTech.GE_SS_Total_Days_in_Service__c != null && objTech.GE_SS_Total_Days_in_Service__c > 0)
                                intCount = intCount + objTech.GE_SS_Total_Days_in_Service__c.intValue(); */
                            
                            
                            System.debug('objTech.GE_SS_Total_Days_in_Service__c: '+objTech.GE_SS_Total_Days_in_Service__c);
                            System.debug('startDateOfYear: '+startDateOfYear);
                            System.debug('endDateOfYear: '+endDateOfYear);
                            System.debug('objTech.StartTime__c: '+objTech.StartTime__c);
                            System.debug('objTech.EndTime__c: '+objTech.EndTime__c);
                            if(objTech.StartTime__c != null && objTech.EndTime__c != null)
                            {
                                Date startDateValue = Date.newInstance(objTech.StartTime__c.year(), objTech.StartTime__c.month(), objTech.StartTime__c.day());
                                Date endDateValue = Date.newInstance(objTech.EndTime__c.year(), objTech.EndTime__c.month(), objTech.EndTime__c.day());
                                System.debug('startDateValue < startDateOfYear: '+ (startDateValue < startDateOfYear));
                                System.debug('endDateOfYear > endDateValue: '+ (endDateOfYear > endDateValue));
                                System.debug('startDateValue > startDateOfYear: '+ (startDateValue > startDateOfYear));
                                System.debug('endDateOfYear < endDateValue: '+ (endDateOfYear < endDateValue));
                                System.debug('startDateValue >= startDateOfYear: '+ (startDateValue >= startDateOfYear));
                                System.debug('endDateOfYear >= endDateValue: '+(endDateOfYear >= endDateValue));
                                if(!(endDateValue < startDateOfYear || startDateValue > endDateOfYear))
                                {
                                    if(startDateValue <= startDateOfYear && endDateOfYear > endDateValue)
                                    {
                                        intCount = intCount + startDateOfYear.daysBetween(endDateValue)+1;
                                    }
                                    else if(startDateValue >= startDateOfYear && endDateOfYear <= endDateValue )
                                    {
                                        
                                        intCount = intCount + startDateValue.daysBetween(endDateOfYear)+1;
                                    }
                                    else if(startDateValue >= startDateOfYear && endDateOfYear >= endDateValue)
                                    {
                                        intCount = intCount + startDateValue.daysBetween(endDateValue)+1;
                                    }
                                    else if(startDateValue < startDateOfYear && endDateOfYear < endDateValue)
                                    {
                                        intCount = intCount + startDateOfYear.daysBetween(endDateOfYear)+1;
                                    }
                                }
                            }
                        }
                        mapTech.get(idTech).GE_SS_Total_Calendar_Days_Scheduled__c = intCount;
                        lstUpdateTech.add(mapTech.get(idTech));
                    }
                    
                }
            }
            
            if(lstUpdateTech != null && lstUpdateTech.size() > 0)
                update lstUpdateTech;
        }
    }
}