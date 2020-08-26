trigger GE_SS_Calculate_Actual_Days on GE_SS_Service_Ticket__c (After Insert, After Update, After Delete)
{
    List<Id> lstRecordIds = new List<Id>();
    if(Trigger.isInsert || Trigger.isUpdate)
    {
        for(GE_SS_Service_Ticket__c  objST : Trigger.New)
        {
            if(objST.GE_SS_Service_Representative__c != null)
                lstRecordIds.add(objST.GE_SS_Service_Representative__c);
        }
    }
    else if(Trigger.isDelete)
    {
        for(GE_SS_Service_Ticket__c  objST : Trigger.old)
        {
            if(objST.GE_SS_Service_Representative__c != null)
                lstRecordIds.add(objST.GE_SS_Service_Representative__c);
        }
    }
    GE_SS_CallParentUpdateIB_ST objCls =  new GE_SS_CallParentUpdateIB_ST();
    if(lstRecordIds != null && lstRecordIds.size() > 0 )
        objCls.callParentUpdateTechEquip(lstRecordIds);
}