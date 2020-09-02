public class SVMXC_WorkOrderLinesAfter {
    
    //Method for sync Trip work detail on updation of Mob WO Work detail
    public static void syncTripWOLineswithMobWOLines (List<SVMXC__Service_Order_Line__c> clList) { 
    system.debug('entered trigger function update');
        try
        { system.debug('Entered trigger func update');
            integer a;
            Set<String> WorkDetailRTNames = new Set<String>();
            WorkDetailRTNames.add('Equipment');
            WorkDetailRTNames.add('Spares');
            WorkDetailRTNames.add('Tools');
            
            Set<String> WORTNames = new Set<String>();
            WORTNames.add('SS-Mobilize');
            //WORTNames.add('SS-Daily');
            WORTNames.add('SS-Trip');
           // a = 1 / 0;
            system.debug('Entered trigger func');
            Map<String, SVMXC__Service_Order_Line__c> mapIdToMobWorkOrderLine = new Map<String, SVMXC__Service_Order_Line__c>();
            
            if(clList != null && clList.size() > 0)
            {
                List<SVMXC__Service_Order_Line__c> lstMobWorkOrderLine = new List<SVMXC__Service_Order_Line__c>();
                for(SVMXC__Service_Order_Line__c objMobWorkOrderLine : clList)
                {
                    if(WorkDetailRTNames.contains(objMobWorkOrderLine.GE_HQ_Record_Type_Name__c)){
                        lstMobWorkOrderLine.add(objMobWorkOrderLine);
                        mapIdToMobWorkOrderLine.put(objMobWorkOrderLine.Id, objMobWorkOrderLine);
                    }
                }
                if(lstMobWorkOrderLine != null && lstMobWorkOrderLine.size() > 0)
                {
                   /* Map<String, SVMXC__Service_Order_Line__c> mapIdToMobWorkOrderLine = new Map<String, SVMXC__Service_Order_Line__c>();
                    
                    for(SVMXC__Service_Order_Line__c objWorkOrderLine : lstMobWorkOrderLine)
                        mapIdToMobWorkOrderLine.put(objWorkOrderLine.Id, objWorkOrderLine);*/
                    
                    List<SVMXC__Service_Order_Line__c> lstTripWODetail = new List<SVMXC__Service_Order_Line__c>();
                    lstTripWODetail = [Select SVMXC__Actual_Quantity2__c, SVMXC__Line_Status__c, GE_OG_SS_Product_Name__c, GE_OG_SS_Product_Description__c, SVMXC__Product__c, SVMXC__Serial_Number__c, GE_SS_Pre_installed__c, GE_SS_Usage_Type__c, GE_HQ_Record_Type_Name__c, SVMXC__Work_Detail__c from SVMXC__Service_Order_Line__c where SVMXC__Work_Detail__c IN: lstMobWorkOrderLine AND GE_HQ_Record_Type_Name__c IN: WorkDetailRTNames AND SVMXC__Service_Order__r.GE_SM_HQ_Record_Type_Name__c IN: WORTNames];
                    
                    if(lstTripWODetail != null && lstTripWODetail.size() > 0)
                    {
                        for(SVMXC__Service_Order_Line__c objTripWOLine : lstTripWODetail)
                        { system.debug('Entered Trip order exists func');
                            if(mapIdToMobWorkOrderLine.containskey(objTripWOLine.SVMXC__Work_Detail__c))//Case_Line__c--->SVMXC__Work_Detail__c(lookup to Work detail)
                            {
                                objTripWOLine.SVMXC__Serial_Number__c = mapIdToMobWorkOrderLine.get(objTripWOLine.SVMXC__Work_Detail__c).SVMXC__Serial_Number__c;
                                objTripWOLine.SVMXC__Product__c = mapIdToMobWorkOrderLine.get(objTripWOLine.SVMXC__Work_Detail__c).SVMXC__Product__c;
                                objTripWOLine.GE_SS_Related_Work_Order__c = mapIdToMobWorkOrderLine.get(objTripWOLine.SVMXC__Work_Detail__c).SVMXC__Service_Order__c;
                                
                                if(objTripWOLine.GE_HQ_Record_Type_Name__c == 'Spares')
                                {
                                    objTripWOLine.SVMXC__Actual_Quantity2__c = mapIdToMobWorkOrderLine.get(objTripWOLine.SVMXC__Work_Detail__c).SVMXC__Actual_Quantity2__c;
                                    //objWOLine.SVMXC__Line_Status__c = mapIdToCaseLine.get(objWOLine.Case_Line__c).SVMXC__Line_Status__c;
                                }
                                else if(objTripWOLine.GE_HQ_Record_Type_Name__c == 'Equipment')
                                {
                                    objTripWOLine.GE_SS_Pre_installed__c = mapIdToMobWorkOrderLine.get(objTripWOLine.SVMXC__Work_Detail__c).GE_SS_Pre_installed__c;
                                    //objWOLine.SVMXC__Line_Status__c = 'Open';
                                }
                                else if(objTripWOLine.GE_HQ_Record_Type_Name__c == 'Tools')
                                {
                                    objTripWOLine.GE_SS_Usage_Type__c = mapIdToMobWorkOrderLine.get(objTripWOLine.SVMXC__Work_Detail__c).GE_SS_Usage_Type__c;
                                    //objWOLine.SVMXC__Line_Status__c = 'Open';
                                }
                                
                            }
                        }
                        
                        update lstTripWODetail;
                    }
                }
            }
        }
        catch(Exception ex)
        {
            System.debug('In exception of Method syncTripWOLineswithMobWOLines');
        }
    }
    
    //Method for sync work detail(Trip) on insert of Work detail Line on Mobilize WO
   public static void syncWOLineswithMobWOLinesInsert (List<SVMXC__Service_Order_Line__c> clList) { 
    system.debug('entered trigger function insert');
    integer a;
    
        try
        { 
        system.debug('Entered trigger func insert');
       
            Set<String> WorkDetailRTNames = new Set<String>();
            WorkDetailRTNames.add('Equipment');
            WorkDetailRTNames.add('Spares');
            WorkDetailRTNames.add('Tools');
            
            Set<String> WORTNames = new Set<String>();
            WORTNames.add('SS-Mobilize');
           // WORTNames.add('SS-Daily');
            WORTNames.add('SS-Trip');
            
            Id rtSparesId = Schema.SObjectType.SVMXC__Service_Order_Line__c.getRecordTypeInfosByName().get('Spares').getRecordTypeId();
            Id rtToolsId = Schema.SObjectType.SVMXC__Service_Order_Line__c.getRecordTypeInfosByName().get('Tools').getRecordTypeId();
            Id rtEquipmentId = Schema.SObjectType.SVMXC__Service_Order_Line__c.getRecordTypeInfosByName().get('Equipment').getRecordTypeId();

            
            if(clList != null && clList.size() > 0)
            {
                List<SVMXC__Service_Order_Line__c> lstMobWOLine = new List<SVMXC__Service_Order_Line__c>();//create new list
                Set<String> setMobWOId = new Set<String>();
                
                
                for(SVMXC__Service_Order_Line__c objMobWOLine : clList) //extrat all MOb WO WD lines
                {  system.debug('entered objMobWOLine for');
                    if(WorkDetailRTNames.contains(objMobWOLine.GE_HQ_Record_Type_Name__c)) // if the WD lines contain RT--> tools,spares,Equipment
                    {
                        setMobWOId.add(objMobWOLine.SVMXC__Service_Order__c); //then extract the MOb WO id and add it in set
                        lstMobWOLine.add(objMobWOLine); //add Wd line in list
                    }
                    system.debug('setMobWOId--->' + setMobWOId);
                    system.debug('lstMobWOLine--->' + lstMobWOLine);
                }
                
                if(lstMobWOLine != null && lstMobWOLine.size() > 0) //if wd line list is not empty
                {
                    
                    List<SVMXC__Service_Order__c> lstWorkOrder = new List<SVMXC__Service_Order__c>(); // create new list for Trip WO
                    
                    List<SVMXC__Service_Order_Line__c> lstWODetail = new List<SVMXC__Service_Order_Line__c>(); //new liste for Trip WD line
                    //get parent Mob. WO of Trip WO
                    lstWorkOrder = [Select Id, GE_SS_Parent_Work_Order__c from SVMXC__Service_Order__c where GE_SM_HQ_Record_Type_Name__c IN: WORTNames and GE_SS_Parent_Work_Order__c IN: setMobWOId];//need to filter Trip WO only? //extract all WO where MO Wo is parent
                    system.debug('lstWorkOrder --->' + lstWorkOrder );
                    if(lstWorkOrder != null && lstWorkOrder.size() > 0) //if there exists Child WO orders i.e. TRIP WO
                    {
                        Map<String, List<SVMXC__Service_Order__c>> mapMobWOToLstWorkOrder = new Map<String, List<SVMXC__Service_Order__c>>();
                        
                        for(SVMXC__Service_Order__c objWorkOrder : lstWorkOrder) //for all the Trip WO
                        {
                            if(!mapMobWOToLstWorkOrder.containsKey(objWorkOrder.GE_SS_Parent_Work_Order__c))// does not contain MO WO id
                                mapMobWOToLstWorkOrder.put(objWorkOrder.GE_SS_Parent_Work_Order__c, new List<SVMXC__Service_Order__c>()); //then add MO WO id as key, with new list as value
                            mapMobWOToLstWorkOrder.get(objWorkOrder.GE_SS_Parent_Work_Order__c).add(objWorkOrder); //get(parent WO ID) and add trip WO as value
                        }
                        
                        system.debug('mapMobWOToLstWorkOrder--->' + mapMobWOToLstWorkOrder);
                        for(SVMXC__Service_Order_Line__c ObjMOWOLine : lstMobWOLine) //add MOB WD line
                        {
                            system.debug('ObjMOWOLine.SVMXC__Service_Order__c--->' + ObjMOWOLine.SVMXC__Service_Order__c);
                            system.debug('mapMobWOToLstWorkOrder.get(ObjMOWOLine.SVMXC__Service_Order__c)--->' + mapMobWOToLstWorkOrder.get(ObjMOWOLine.SVMXC__Service_Order__c));
                            for(SVMXC__Service_Order__c ObjWorkOrder : mapMobWOToLstWorkOrder.get(ObjMOWOLine.SVMXC__Service_Order__c)) //for MOB WD line's parent WO//GE_DS_Parent_Work_Detail__c//SVMXC__Work_Detail__c
                            {
                                system.debug('ObjWorkOrder--->' + ObjWorkOrder);
                                SVMXC__Service_Order_Line__c objTripWorkDetail = new SVMXC__Service_Order_Line__c();
                                
                                objTripWorkDetail.SVMXC__Serial_Number__c = ObjMOWOLine.SVMXC__Serial_Number__c;
                                objTripWorkDetail.SVMXC__Product__c = ObjMOWOLine.SVMXC__Product__c;
                                objTripWorkDetail.SVMXC__Service_Order__c = ObjWorkOrder.Id; //?? 
                                objTripWorkDetail.SVMXC__Work_Detail__c = ObjMOWOLine.Id;//Case_Line__c---> GE_DS_Parent_Work_Detail__c //SVMXC__Work_Detail__c??
                                objTripWorkDetail.GE_SS_Related_Work_Order__c = ObjWorkOrder.Id;
                                objTripWorkDetail.GE_OG_SS_Product_Name__c = ObjMOWOLine.GE_SS_Product_Name__c;
                                objTripWorkDetail.GE_OG_SS_Product_Description__c = ObjMOWOLine.GE_SS_Product_Description__c;
                               // objTripWorkDetail.SVMXC__Service_Order__c = ObjMOWOLine.SVMXC__Service_Order__c;//GE_SS_Case__c--->SVMXC__Service_Order__c ??

                                if(ObjMOWOLine.GE_HQ_Record_Type_Name__c == 'Spares')
                                {
                                    objTripWorkDetail.SVMXC__Actual_Quantity2__c = ObjMOWOLine.SVMXC__Actual_Quantity2__c;
                                    objTripWorkDetail.SVMXC__Line_Status__c = ObjMOWOLine.SVMXC__Line_Status__c;
                                    objTripWorkDetail.RecordTypeId = rtSparesId; //RecordTypeId --->RecordType?
                                }
                                else if(ObjMOWOLine.GE_HQ_Record_Type_Name__c == 'Tools')
                                {   
                                    objTripWorkDetail.GE_SS_Usage_Type__c = ObjMOWOLine.GE_SS_Usage_Type__c;
                                    objTripWorkDetail.SVMXC__Line_Status__c = 'Open';
                                    objTripWorkDetail.RecordTypeId = rtToolsId;//?
                                }
                                else if(ObjMOWOLine.GE_HQ_Record_Type_Name__c == 'Equipment')
                                {
                                    objTripWorkDetail.GE_SS_Pre_installed__c = ObjMOWOLine.GE_SS_Pre_installed__c;
                                    objTripWorkDetail.SVMXC__Line_Status__c = 'Open';
                                    objTripWorkDetail.RecordTypeId = rtEquipmentId;//?
                                }
                                
                                lstWODetail.add(objTripWorkDetail);
                                system.debug('lstWODetail--->' + lstWODetail);
                               
                            }
                            
                        }
                    }
                    
                    if(lstWODetail != null && lstWODetail.size() > 0)
                    {
                        insert lstWODetail;
                    }
                }
                     //a = 1 / 0;
           }
             
        }
        catch(Exception ex)
        {
            System.debug('In exception of Method syncWOLineswithMobWOLinesInsert');
        }
    }      
    
     //Method for update FS Project in installed product on updation and creation of Mobilize Work Order lines
    public static void updateInstalledProducts (List<SVMXC__Service_Order_Line__c> clList, Map<Id, SVMXC__Service_Order_Line__c> oldWorkDetailLineRecord)
    {
        Set<String> WOLinesRTNames = new Set<String>();
        WOLinesRTNames.add('Equipment');
        WOLinesRTNames.add('Spares');
        WOLinesRTNames.add('Tools');
        system.debug('Entered updateFSProjectInIB');
        try
        {
            if(clList != null && clList.size() > 0)
            { system.debug('Entered cllist if');
                List<SVMXC__Service_Order_Line__c> lstMobWOLine = new List<SVMXC__Service_Order_Line__c>();
                Set<String> setWOId = new Set<String>();
                Set<String> setIBId = new Set<String>();
                for(SVMXC__Service_Order_Line__c objMobWOLine : clList)
                {  system.debug('Entered objMobWOLine for');
                   system.debug('objMobWOLine.GE_HQ_Record_Type_Name__c---->'+ objMobWOLine.GE_HQ_Record_Type_Name__c);
                    if(WOLinesRTNames.contains(objMobWOLine.GE_HQ_Record_Type_Name__c))
                    {   
                        lstMobWOLine.add(objMobWOLine);
                        setWOId.add(objMobWOLine.SVMXC__Service_Order__c);//SVMXC__Work_Detail__c
                        setIBId.add(objMobWOLine.SVMXC__Serial_Number__c);
                    }
                }
                system.debug('lstMobWOLine--->'+ lstMobWOLine);
                system.debug('setWOId--->'+ setWOId);
                system.debug('setIBId--->'+ setIBId);
                
                if(lstMobWOLine != null && lstMobWOLine.size() > 0)
                { system.debug('Entered objMobWOLine if');
                    List<SVMXC__Service_Order__c> lstWO = new List<SVMXC__Service_Order__c>();
                    lstWO = [Select Id, GE_SS_Project__c, Management_Country__c, GE_SS_Project_Region__c, SVMXC__Company__c from SVMXC__Service_Order__c where Id IN: setWOId];
                    Map<Id, SVMXC__Installed_Product__c> mapIdToIB = new Map<Id, SVMXC__Installed_Product__c>();
                    mapIdToIB.putAll([Select Id, GE_SS_FS_Project__c, GE_SS_Quantity__c, SVMXC__Status__c   from SVMXC__Installed_Product__c where Id IN: setIBId]);
                    if(lstWO != null && lstWO.size() > 0  && mapIdToIB != null && mapIdToIB.size() > 0)
                    { system.debug('Entered lstWO if');
                        map<String, SVMXC__Service_Order__c> mapWOIdToFSProjectId = new map<String, SVMXC__Service_Order__c>();
                       
                        for(SVMXC__Service_Order__c objWO : lstWO)
                        { system.debug('Entered lstWO objWO for');
                            mapWOIdToFSProjectId.put(objWO.Id, objWO);
                            system.debug('mapWOIdToFSProjectId--->' + mapWOIdToFSProjectId);
                         }
                        for(SVMXC__Service_Order_Line__c objWOLine2 : lstMobWOLine)
                        { system.debug('Entered lstWO objWOLine2 for');
                            if(mapWOIdToFSProjectId.containsKey(objWOLine2.SVMXC__Service_Order__c) && mapWOIdToFSProjectId.get(objWOLine2.SVMXC__Service_Order__c) != null && mapIdToIB.containsKey(objWOLine2.SVMXC__Serial_Number__c) && mapIdToIB.get(objWOLine2.SVMXC__Serial_Number__c) != null)
                            {
                                mapIdToIB.get(objWOLine2.SVMXC__Serial_Number__c).GE_SS_FS_Project__c = mapWOIdToFSProjectId.get(objWOLine2.SVMXC__Service_Order__c).GE_SS_Project__c;
                                system.debug('mapIdToIB--->' + mapIdToIB.get(objWOLine2.SVMXC__Serial_Number__c).GE_SS_FS_Project__c);
                            }
                            mapIdToIB.get(objWOLine2.SVMXC__Serial_Number__c).SVMXC__Status__c = objWOLine2.GE_SS_IP_Status__c;
                            //added by NS for Smart Ops Project
                            mapIdToIB.get(objWOLine2.SVMXC__Serial_Number__c).GE_OG_SS_Current_Activity_Status__c = objWOLine2.GE_SS_IP_Current_Activity_Status__c; 
                            mapIdToIB.get(objWOLine2.SVMXC__Serial_Number__c).GE_SS_Field__c = objWOLine2.GE_SS_Field__c;
                            mapIdToIB.get(objWOLine2.SVMXC__Serial_Number__c).GE_SS_Well__c = objWOLine2.GE_SS_Well__c;
                            mapIdToIB.get(objWOLine2.SVMXC__Serial_Number__c).SVMXC__Company__c = mapWOIdToFSProjectId.get(objWOLine2.SVMXC__Service_Order__c).SVMXC__Company__c;
                            mapIdToIB.get(objWOLine2.SVMXC__Serial_Number__c).GE_SS_Project_Region__c = mapWOIdToFSProjectId.get(objWOLine2.SVMXC__Service_Order__c).GE_SS_Project_Region__c;
                            mapIdToIB.get(objWOLine2.SVMXC__Serial_Number__c).GE_SS_Management_Country__c = mapWOIdToFSProjectId.get(objWOLine2.SVMXC__Service_Order__c).Management_Country__c;
                            
                            mapIdToIB.get(objWOLine2.SVMXC__Serial_Number__c).GE_SS_Description_of_Rework__c = objWOLine2.GE_SS_New_Rework__c ;
                            mapIdToIB.get(objWOLine2.SVMXC__Serial_Number__c).GE_AL_Condition__c = objWOLine2.GE_SS_New_Condition__c ; 
                            mapIdToIB.get(objWOLine2.SVMXC__Serial_Number__c).GE_SS_Returned__c = objWOLine2.GE_SS_New_Returned__c ;
                            if (objWOLine2.GE_HQ_Record_Type_Name__c == 'Equipment' || objWOLine2.GE_HQ_Record_Type_Name__c == 'Tools') {                                
                                mapIdToIB.get(objWOLine2.SVMXC__Serial_Number__c).GE_SS_Used__c = objWOLine2.GE_SS_Used__c ;
                            }
                            if (objWOLine2.GE_HQ_Record_Type_Name__c == 'Spares') {                             
                                mapIdToIB.get(objWOLine2.SVMXC__Serial_Number__c).GE_SS_Quantity__c = objWOLine2.SVMXC__Actual_Quantity2__c;
                                if(oldWorkDetailLineRecord.size() == 0){//Start of insert Block of Class SVMXC_WorkDetailsAfter
                                    if (mapIdToIB.get(objWOLine2.SVMXC__Serial_Number__c).GE_SS_Qty_Used__c == null){
                                        mapIdToIB.get(objWOLine2.SVMXC__Serial_Number__c).GE_SS_Qty_Used__c = objWOLine2.GE_SS_Qty_Consumed__c;
                                    }else {
                                     Decimal quantityUsed = mapIdToIB.get(objWOLine2.SVMXC__Serial_Number__c).GE_SS_Qty_Used__c;                        
                                        if (objWOLine2.GE_SS_Qty_Consumed__c != null) {
                                            quantityUsed = quantityUsed + objWOLine2.GE_SS_Qty_Consumed__c;
                                            mapIdToIB.get(objWOLine2.SVMXC__Serial_Number__c).GE_SS_Qty_Used__c = quantityUsed;
                                        }                            
                                    }
                                }else{//Start of Update Block of Class SVMXC_WorkDetailsAfter
                                    Decimal currentQuantityUsed2 , previousQuantityUsed2;
                                    if (mapIdToIB.get(objWOLine2.SVMXC__Serial_Number__c).GE_SS_Qty_Used__c == null){
                                        currentQuantityUsed2 = 0;
                                    }else{
                                        currentQuantityUsed2 = mapIdToIB.get(objWOLine2.SVMXC__Serial_Number__c).GE_SS_Qty_Used__c;
                                    }                   
                                    if (oldWorkDetailLineRecord.get(objWOLine2.Id).GE_SS_Qty_Consumed__c == null){
                                        previousQuantityUsed2 = 0;
                                    }else{
                                        previousQuantityUsed2 = oldWorkDetailLineRecord.get(objWOLine2.Id).GE_SS_Qty_Consumed__c;
                                    } 
                                    
                                    if (objWOLine2.GE_SS_Qty_Consumed__c != null) {
                                        mapIdToIB.get(objWOLine2.SVMXC__Serial_Number__c).GE_SS_Qty_Used__c = (currentQuantityUsed2 - (previousQuantityUsed2 - objWOLine2.GE_SS_Qty_Consumed__c));
                                    } 
                                }//End of Update Block of Class SVMXC_WorkDetailsAfter
                            }        
 
                        }
                        
                        update mapIdToIB.values();
                    }
                }
            }
        }
        catch(Exception ex)
        {
            System.debug('exception in method updateFSProjectInIB');
        }
    } 
   
}