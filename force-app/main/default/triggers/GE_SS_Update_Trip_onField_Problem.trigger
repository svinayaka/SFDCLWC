trigger GE_SS_Update_Trip_onField_Problem on GE_SS_Field_Problem__c (After Update, After Insert) {

    Map<id, GE_SS_Field_Problem__c> mapFP = new Map<id, GE_SS_Field_Problem__c>();
    List<id> lstWOid = new List<id>();
    List<SVMXC__Service_Order__c> lstTripWOUpdate =  new List<SVMXC__Service_Order__c>();
    try
    {
    if(Trigger.IsUpdate || Trigger.IsInsert)
    {
        for(GE_SS_Field_Problem__c recFP : Trigger.new)
        {
            mapFP.Put(recFP.id, recFP);
            lstWOid.add(recFP.GE_SS_Work_Order__c);
        }
        
        Map<id, SVMXC__Service_Order__c> mapTWO = new Map<id, SVMXC__Service_Order__c>([select id, GE_SS_Uptime_Hours__c from SVMXC__Service_Order__c where GE_SM_HQ_Record_Type_Name__c = 'SS-Trip' and Id IN: lstWOid]);
        
        //Set<ID> soIDSet = mapTWO.keySet();
        Set<ID> soIDSet = new Set<ID>();
        for( String woID : mapTWO.keySet() )
        {
            soIDSet.add(woID);
        }
        System.debug('=========1'+soIDSet);
        
        AggregateResult[] sumDowntimeinFPLines = [select SUM(GE_SS_Downtime_Recorded_Against_VG__c) sumDowntime, GE_SS_Work_Order__c from GE_SS_Field_Problem__c where GE_SS_Work_Order__c IN: lstWOid AND (GE_SS_Type_of_Field_Problem__c = 'Minor' OR GE_SS_Type_of_Field_Problem__c = 'Major' OR GE_SS_Type_of_Field_Problem__c = 'Critical') Group by GE_SS_Work_Order__c];     
        
        for(AggregateResult ar : sumDowntimeinFPLines)
        {   
            
            SVMXC__Service_Order__c tmpTWO = new SVMXC__Service_Order__c();
            decimal intCount = (decimal)ar.get('sumDowntime');
            Id idTripWorkOrder = (ID)ar.get('GE_SS_Work_Order__c');
            soIDSet.remove(idTripWorkOrder);
            SVMXC__Service_Order__c tmpWO = new SVMXC__Service_Order__c (Id = idTripWorkOrder);
            tmpWO.GE_SS_Downtime_NPT_Hours__c = intCount;
            
            system.debug('tidTripWorkOrder--->' + idTripWorkOrder);
            
            system.debug('mapTWO--->' + mapTWO); 
            
            tmpTWO.GE_SS_Uptime_Hours__c = mapTWO.get(idTripWorkOrder).GE_SS_Uptime_Hours__c;
            
            system.debug('tmpTWO.GE_SS_Uptime_Hours__c--->' + tmpTWO.GE_SS_Uptime_Hours__c);
            
            if(tmpTWO.GE_SS_Uptime_Hours__c != null)
            tmpWO.GE_SS_Reliability__c = 100 - ((intCount / tmpTWO.GE_SS_Uptime_Hours__c) * 100);
            else
                tmpWO.GE_SS_Reliability__c = 0; 
            
            system.debug('--->>' + ((intCount/ tmpTWO.GE_SS_Uptime_Hours__c) * 100));
            system.debug('tmpWO.GE_SS_Reliability__c' + tmpWO.GE_SS_Reliability__c);
            
            lstTripWOUpdate.add(tmpWO);
        }
        System.debug('=========2'+soIDSet);
        for( String woID : mapTWO.keySet() )
        {
            if( soIDSet.contains(woID) )
            {
                SVMXC__Service_Order__c tmpWO = new SVMXC__Service_Order__c (Id = woID);
                tmpWO.GE_SS_Downtime_NPT_Hours__c = 0;
                lstTripWOUpdate.add(tmpWO);
            }
        }
    
        if( !lstTripWOUpdate.isEmpty() )
            Update lstTripWOUpdate;
    }
    }
    catch(exception ex)
    {
        system.debug('Error occured in Trigger GE_SS_Update_Trip_onField_Problem!' + ex.getMessage());
    }

}