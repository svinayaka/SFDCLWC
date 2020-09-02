public class GE_SS_CallParentUpdateIB_ST  {
    //@InvocableMethod
    //public static void callParentUpdateTechEquip(list<Id> lstRecordIds) {
    public void callParentUpdateTechEquip(list<Id> lstRecordIds) {
        System.debug('list of record to proceed: '+lstRecordIds);
        if(lstRecordIds != null && lstRecordIds.size() > 0)
        {
            List<GE_SS_Service_Ticket__c> lstServiceTicket = new List<GE_SS_Service_Ticket__c>();

            Map<ID, Set<GE_SS_Service_Ticket__c>> mapTechIDtoLstST = new Map<ID, Set<GE_SS_Service_Ticket__c>>();
            Map<Id, SVMXC__Service_Group_Members__c> mapTech = new Map<Id, SVMXC__Service_Group_Members__c>();
            List<SVMXC__Service_Group_Members__c> lstUpdateTech = new List<SVMXC__Service_Group_Members__c>();

            lstServiceTicket = [select Id, GE_SS_Status__c, GE_SS_Project_Region__r.Name, GE_SS_Service_Representative__c, GE_SS_Days_in_Service__c, GE_SS_Service_Finish_Date__c, GE_SS_Service_Start_Date__c,GE_SS_Work_Order__r.SVMXC__Billing_Type__c  from GE_SS_Service_Ticket__c where GE_SS_Service_Representative__c IN: lstRecordIds ];
            
            System.debug('lstServiceTicket: '+lstServiceTicket);
            
            for(GE_SS_Service_Ticket__c ObjST : lstServiceTicket)
            {
                if(ObjST.GE_SS_Service_Representative__c != null && ObjST.GE_SS_Days_in_Service__c != null && ObjST.GE_SS_Days_in_Service__c > 0 && (ObjST.GE_SS_Work_Order__r.SVMXC__Billing_Type__c=='Intercompany Billable'||ObjST.GE_SS_Work_Order__r.SVMXC__Billing_Type__c=='Billable'||ObjST.GE_SS_Work_Order__r.SVMXC__Billing_Type__c=='Cost transfer'||ObjST.GE_SS_Work_Order__r.SVMXC__Billing_Type__c=='Non Billable'))
                    System.debug('mapTechIDtoLstST.containsKey(ObjST.GE_SS_Service_Representative__c): '+mapTechIDtoLstST.containsKey(ObjST.GE_SS_Service_Representative__c));
                    if(!mapTechIDtoLstST.containsKey(ObjST.GE_SS_Service_Representative__c))
                        mapTechIDtoLstST.put(ObjST.GE_SS_Service_Representative__c, new Set<GE_SS_Service_Ticket__c>());
                    System.debug('mapTechIDtoLstST: '+mapTechIDtoLstST);
                    mapTechIDtoLstST.get(ObjST.GE_SS_Service_Representative__c).add(ObjST);
            }
            
            mapTech.putAll([Select Id, GE_SS_Total_Actual_Days_in_Service__c from SVMXC__Service_Group_Members__c where Id IN: lstRecordIds]);
            Set<Id> UpdatedTechId = new Set<Id>();
            if(mapTechIDtoLstST != null && mapTechIDtoLstST.size() > 0)
            {
                for(Id idTech : mapTechIDtoLstST.keySet())
                {
                    if(mapTech.containsKey(idTech))
                    {
                        integer intCount = 0;
                        Date startDateOfYear = Date.newInstance(System.now().year(), 1, 1);
                        Date endDateOfYear = Date.newInstance(System.now().year(), 12, 31);
                        
                        for(GE_SS_Service_Ticket__c objST : mapTechIDtoLstST.get(idTech))
                        {
                            
                            /*
                            if(objST.GE_SS_Days_in_Service__c != null && objST.GE_SS_Days_in_Service__c > 0)
                                intCount = intCount + objST.GE_SS_Days_in_Service__c.intValue(); */
                            System.debug('objST.GE_SS_Days_in_Service__c: '+objST.GE_SS_Days_in_Service__c);
                            System.debug('startDateOfYear: '+startDateOfYear);
                            System.debug('endDateOfYear: '+endDateOfYear);
                            System.debug('objST.GE_SS_Service_Start_Date__c: '+objST.GE_SS_Service_Start_Date__c);
                            System.debug('objST.GE_SS_Service_Finish_Date__c: '+objST.GE_SS_Service_Finish_Date__c);
                            if(objST.GE_SS_Service_Start_Date__c != null && objST.GE_SS_Service_Finish_Date__c != null 
                            && (objST.GE_SS_Status__c == 'Complete' || objST.GE_SS_Status__c == 'Client Invoiced') && objST.GE_SS_Project_Region__r.Name != 'TRAINING' && objST.GE_SS_Project_Region__r.Name !='GLOBAL FS TRAINING' )
                            {
                                System.debug('objST.GE_SS_Service_Start_Date__c < startDateOfYear: '+ (objST.GE_SS_Service_Start_Date__c < startDateOfYear));
                                System.debug('endDateOfYear > objST.GE_SS_Service_Finish_Date__c: '+ (endDateOfYear > objST.GE_SS_Service_Finish_Date__c));
                                System.debug('objST.GE_SS_Service_Start_Date__c > startDateOfYear: '+ (objST.GE_SS_Service_Start_Date__c > startDateOfYear));
                                System.debug('endDateOfYear < objST.GE_SS_Service_Finish_Date__c: '+ (endDateOfYear < objST.GE_SS_Service_Finish_Date__c));
                                System.debug('objST.GE_SS_Service_Start_Date__c >= startDateOfYear: '+ (objST.GE_SS_Service_Start_Date__c >= startDateOfYear));
                                System.debug('endDateOfYear >= objST.GE_SS_Service_Finish_Date__c: '+(endDateOfYear >= objST.GE_SS_Service_Finish_Date__c));
                                if(!(objST.GE_SS_Service_Finish_Date__c < startDateOfYear || objST.GE_SS_Service_Start_Date__c > endDateOfYear))
                                {
                                    if(objST.GE_SS_Service_Start_Date__c <= startDateOfYear && endDateOfYear > objST.GE_SS_Service_Finish_Date__c)
                                    {
                                        intCount = intCount + startDateOfYear.daysBetween(objST.GE_SS_Service_Finish_Date__c)+1;
                                    }
                                    else if(objST.GE_SS_Service_Start_Date__c >= startDateOfYear && endDateOfYear <= objST.GE_SS_Service_Finish_Date__c )
                                    {
                                        intCount = intCount + objST.GE_SS_Service_Start_Date__c.daysBetween(endDateOfYear)+1;
                                    }
                                    else if(objST.GE_SS_Service_Start_Date__c >= startDateOfYear && endDateOfYear >= objST.GE_SS_Service_Finish_Date__c)
                                    {
                                        intCount = intCount + objST.GE_SS_Service_Start_Date__c.daysBetween(objST.GE_SS_Service_Finish_Date__c)+1;
                                    }
                                    else if(objST.GE_SS_Service_Start_Date__c < startDateOfYear && endDateOfYear < objST.GE_SS_Service_Finish_Date__c)
                                    {
                                        intCount = intCount + startDateOfYear.daysBetween(endDateOfYear)+1;
                                    }
                                }
                            }
                            
                        }
                        mapTech.get(idTech).GE_SS_Total_Actual_Days_in_Service__c = intCount;
                        lstUpdateTech.add(mapTech.get(idTech));
                        UpdatedTechId.add(mapTech.get(idTech).Id);
                    }
                    
                }
            }
            
            
            List<SVMXC__Service_Group_Members__c> lstUpdateTechfinal = new List<SVMXC__Service_Group_Members__c>();
            for(SVMXC__Service_Group_Members__c objTech : mapTech.values())
            {
                if(!UpdatedTechId.contains(objTech.Id))
                    objTech.GE_SS_Total_Actual_Days_in_Service__c = 0;
                lstUpdateTechfinal.add(objTech);
            }
            
            if(lstUpdateTechfinal != null && lstUpdateTechfinal.size() > 0)
                update lstUpdateTechfinal;
        }
    }
}