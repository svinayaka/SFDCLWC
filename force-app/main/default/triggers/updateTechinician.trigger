//Inactivating this Trigger as part of R-26370 as this functionality is not in use

trigger updateTechinician on Work_Activity__c (After Insert, After Update, After Delete) {

    List<Id> lstRecordIds = new List<Id>();
    if(Trigger.isInsert || Trigger.isUpdate)
    {
        for(Work_Activity__c  ObjTA : Trigger.New)
        {
            if(ObjTA.Technician_Equipment__c != null)
                lstRecordIds.add(ObjTA.Technician_Equipment__c);
        }
    }
    else if(Trigger.isDelete)
    {
        for(Work_Activity__c  ObjTA : Trigger.old)
        {
            if(ObjTA.Technician_Equipment__c != null)
                lstRecordIds.add(ObjTA.Technician_Equipment__c);
        }
    }
    GE_SS_CallParentUpdate_Tech_Equipment objCls =  new GE_SS_CallParentUpdate_Tech_Equipment();
    if(lstRecordIds != null && lstRecordIds.size() > 0 )
        objCls.callParentUpdateTechEquip(lstRecordIds);
}