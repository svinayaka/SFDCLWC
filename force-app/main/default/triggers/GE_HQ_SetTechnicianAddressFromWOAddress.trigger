trigger GE_HQ_SetTechnicianAddressFromWOAddress on SVMXC__Service_Order__c (after update) {

/* commenting tied to R-24282

    Set<Id> techIdSet = new Set<Id>();
    
    for (SVMXC__Service_Order__c wo : trigger.new)
    {
        SVMXC__Service_Order__c beforeUpdate = trigger.oldMap.get(wo.Id);
        
        if (wo.SVMXC__Group_Member__c != null)
        {
            if (wo.GE_SM_HQ_Set_Technician_Location_To_Site__c != beforeUpdate.GE_SM_HQ_Set_Technician_Location_To_Site__c)
            {
                techIdSet.add(wo.SVMXC__Group_Member__c);
            }
        }
    }
    
    if (techIdSet.size() > 0)
    {
        Map<Id, SVMXC__Service_Group_Members__c> techMap = new Map<Id, SVMXC__Service_Group_Members__c>([SELECT Id, GE_SM_HQ_Home_Street__c, GE_SM_HQ_Home_City__c, GE_SM_HQ_Home_State__c, GE_SM_HQ_Home_Zip__c, GE_SM_HQ_Home_Country__c, GE_SM_HQ_Home_Longitude__c, GE_SM_HQ_Home_Latitude__c, SVMXC__Longitude__c, SVMXC__Latitude__c, SVMXC__City__c, SVMXC__State__c, SVMXC__Street__c, SVMXC__Country__c, SVMXC__Zip__c FROM SVMXC__Service_Group_Members__c WHERE Id IN :techIdSet ]);
        
        for (SVMXC__Service_Order__c wo : trigger.new)
        {
            SVMXC__Service_Order__c beforeUpdate = trigger.oldMap.get(wo.Id);
            
            if (wo.SVMXC__Group_Member__c != null)
            {
                SVMXC__Service_Group_Members__c tech = techMap.get(wo.SVMXC__Group_Member__c);
                if (wo.GE_SM_HQ_Set_Technician_Location_To_Site__c && ! beforeUpdate.GE_SM_HQ_Set_Technician_Location_To_Site__c)
                {
                    tech.SVMXC__City__c = wo.SVMXC__City__c;
                    tech.SVMXC__State__c = wo.SVMXC__State__c;
                    tech.SVMXC__Street__c = wo.SVMXC__Street__c;
                    tech.SVMXC__Country__c = wo.SVMXC__Country__c;
                    tech.SVMXC__Zip__c = wo.SVMXC__Zip__c;
                    tech.SVMXC__Longitude__c = wo.SVMXC__Longitude__c;
                    tech.SVMXC__Latitude__c = wo.SVMXC__Latitude__c;
                }
                else if (! wo.GE_SM_HQ_Set_Technician_Location_To_Site__c &&  beforeUpdate.GE_SM_HQ_Set_Technician_Location_To_Site__c)
                {
                    tech.SVMXC__City__c = tech.GE_SM_HQ_Home_City__c;
                    tech.SVMXC__State__c = tech.GE_SM_HQ_Home_State__c;
                    tech.SVMXC__Street__c = tech.GE_SM_HQ_Home_Street__c;
                    tech.SVMXC__Country__c = tech.GE_SM_HQ_Home_Country__c;
                    tech.SVMXC__Zip__c = tech.GE_SM_HQ_Home_Zip__c;
                    tech.SVMXC__Longitude__c = tech.GE_SM_HQ_Home_Longitude__c;
                    tech.SVMXC__Latitude__c = tech.GE_SM_HQ_Home_Latitude__c;
                }
            }
        } 
        
        update techMap.values();
    }
    */
}