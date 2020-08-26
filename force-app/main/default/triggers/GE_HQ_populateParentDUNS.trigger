trigger GE_HQ_populateParentDUNS on Account (before insert, before update) {

  //Code to skip trigger

    OG_Trigger_fire_Decision__c lstObj = OG_Trigger_fire_Decision__c.getValues('GE_HQ_populateParentDUNS');
       
    if(lstObj!=null && lstObj.isActive__c == true && lstObj.Object_Name__c=='Account'){
     
        return;  
    }
    else{
        Id devRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('CMF Approved').getRecordTypeId();
        for(Account accParent:Trigger.New)
        {
            if(accParent.RecordTypeId == devRecordTypeId){
        
                    IF(
                    ((accParent.GE_HQ_DUNS_Number__c==accParent.GE_HQ_HQ_Parent_Duns__c) && (accParent.GE_HQ_DUNS_Number__c==accParent.GE_HQ_Dom_Ult_Duns__c) && (accParent.GE_HQ_DUNS_Number__c==accParent.GE_HQ_Glo_Ult_Duns__c) && (accParent.GE_HQ_GE_Global_Duns__c!=Null) && (accParent.GE_HQ_DUNS_Number__c!=accParent.GE_HQ_GE_Global_Duns__c))||
                    ((accParent.GE_HQ_HQ_Parent_Duns__c==null)&&(accParent.GE_HQ_DUNS_Number__c==accParent.GE_HQ_Dom_Ult_Duns__c)&&(accParent.GE_HQ_DUNS_Number__c==accParent.GE_HQ_Glo_Ult_Duns__c)&&(accParent.GE_HQ_GE_Global_Duns__c==null)&&(accParent.GE_HQ_DUNS_Number__c!=accParent.GE_HQ_GE_Global_Duns__c))||
                    ((accParent.GE_HQ_HQ_Parent_Duns__c==null)&&(accParent.GE_HQ_Dom_Ult_Duns__c==null)&&(accParent.GE_HQ_DUNS_Number__c==accParent.GE_HQ_Glo_Ult_Duns__c)&&(accParent.GE_HQ_GE_Global_Duns__c!=null)&&(accParent.GE_HQ_DUNS_Number__c!=accParent.GE_HQ_GE_Global_Duns__c))||
                    ((accParent.GE_HQ_DUNS_Number__c==accParent.GE_HQ_HQ_Parent_Duns__c)&&(accParent.GE_HQ_Dom_Ult_Duns__c==null)&&(accParent.GE_HQ_DUNS_Number__c==accParent.GE_HQ_Glo_Ult_Duns__c)&&(accParent.GE_HQ_GE_Global_Duns__c!=null)&&(accParent.GE_HQ_DUNS_Number__c!=accParent.GE_HQ_GE_Global_Duns__c))||
                    ((accParent.GE_HQ_HQ_Parent_Duns__c==null)&&(accParent.GE_HQ_Dom_Ult_Duns__c==null)&&(accParent.GE_HQ_DUNS_Number__c==accParent.GE_HQ_Glo_Ult_Duns__c)&&(accParent.GE_HQ_GE_Global_Duns__c!=null)&&(accParent.GE_HQ_DUNS_Number__c!=accParent.GE_HQ_GE_Global_Duns__c))||
                    ((accParent.GE_HQ_DUNS_Number__c==accParent.GE_HQ_HQ_Parent_Duns__c)&&(accParent.GE_HQ_Dom_Ult_Duns__c==null)&&(accParent.GE_HQ_Glo_Ult_Duns__c==null)&&(accParent.GE_HQ_GE_Global_Duns__c!=null)&&(accParent.GE_HQ_DUNS_Number__c!=accParent.GE_HQ_GE_Global_Duns__c))||
                    ((accParent.GE_HQ_HQ_Parent_Duns__c==null)&&(accParent.GE_HQ_Dom_Ult_Duns__c==null)&&(accParent.GE_HQ_Glo_Ult_Duns__c==null)&&(accParent.GE_HQ_GE_Global_Duns__c!=null)&&(accParent.GE_HQ_DUNS_Number__c!=accParent.GE_HQ_GE_Global_Duns__c))||
                    ((accParent.GE_HQ_DUNS_Number__c==accParent.GE_HQ_HQ_Parent_Duns__c)&&(accParent.GE_HQ_DUNS_Number__c==accParent.GE_HQ_Dom_Ult_Duns__c)&&(accParent.GE_HQ_Glo_Ult_Duns__c==null)&&(accParent.GE_HQ_GE_Global_Duns__c!=null)&&(accParent.GE_HQ_DUNS_Number__c!=accParent.GE_HQ_GE_Global_Duns__c))
                    )
                    {
                    accParent.Parent_Duns__c = accParent.GE_HQ_GE_Global_Duns__c;

                    System.debug('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'+accParent.Parent_Duns__c);
                    }

                    ELSE IF(
                    ((accParent.GE_HQ_DUNS_Number__c==accParent.GE_HQ_HQ_Parent_Duns__c)&&(accParent.GE_HQ_DUNS_Number__c==accParent.GE_HQ_Dom_Ult_Duns__c)&&(accParent.GE_HQ_DUNS_Number__c!=accParent.GE_HQ_Glo_Ult_Duns__c)&&(accParent.GE_HQ_GE_Global_Duns__c==null)&&(accParent.GE_HQ_Glo_Ult_Duns__c==null))||
                    ((accParent.GE_HQ_DUNS_Number__c==accParent.GE_HQ_HQ_Parent_Duns__c)&&(accParent.GE_HQ_DUNS_Number__c==accParent.GE_HQ_Dom_Ult_Duns__c)&&(accParent.GE_HQ_DUNS_Number__c!=accParent.GE_HQ_Glo_Ult_Duns__c)&&(accParent.GE_HQ_Glo_Ult_Duns__c!=null))||
                    ((accParent.GE_HQ_HQ_Parent_Duns__c==null)&&(accParent.GE_HQ_Dom_Ult_Duns__c==null)&&(accParent.GE_HQ_DUNS_Number__c!=accParent.GE_HQ_Glo_Ult_Duns__c)&&(accParent.GE_HQ_GE_Global_Duns__c==null)&&(accParent.GE_HQ_Glo_Ult_Duns__c!=null))||
                    ((accParent.GE_HQ_HQ_Parent_Duns__c==null)&&(accParent.GE_HQ_Dom_Ult_Duns__c==null)&&(accParent.GE_HQ_DUNS_Number__c!=accParent.GE_HQ_Glo_Ult_Duns__c)&&(accParent.GE_HQ_Glo_Ult_Duns__c!=null))||
                    ((accParent.GE_HQ_DUNS_Number__c==accParent.GE_HQ_HQ_Parent_Duns__c)&&(accParent.GE_HQ_Dom_Ult_Duns__c==null)&&(accParent.GE_HQ_DUNS_Number__c!=accParent.GE_HQ_Glo_Ult_Duns__c)&&(accParent.GE_HQ_Glo_Ult_Duns__c!=null))||
                    ((accParent.GE_HQ_DUNS_Number__c==accParent.GE_HQ_HQ_Parent_Duns__c)&&(accParent.GE_HQ_Dom_Ult_Duns__c==null)&&(accParent.GE_HQ_DUNS_Number__c!=accParent.GE_HQ_HQ_Parent_Duns__c))
                    )
                    {
                    accParent.Parent_Duns__c = accParent.GE_HQ_Glo_Ult_Duns__c;
                    System.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@'+accParent.Parent_Duns__c);
                    }

                    ELSE IF(
                    ((accParent.GE_HQ_DUNS_Number__c==accParent.GE_HQ_HQ_Parent_Duns__c)&&(accParent.GE_HQ_DUNS_Number__c!=accParent.GE_HQ_Dom_Ult_Duns__c)&&(accParent.GE_HQ_Dom_Ult_Duns__c!=null))||
                    ((accParent.GE_HQ_HQ_Parent_Duns__c==null)&&(accParent.GE_HQ_DUNS_Number__c!=accParent.GE_HQ_Dom_Ult_Duns__c)&&(accParent.GE_HQ_Dom_Ult_Duns__c!=null))
                    )
                    {
                    accParent.Parent_Duns__c = accParent.GE_HQ_Dom_Ult_Duns__c;
                    System.debug('####################################'+accParent.Parent_Duns__c);

                    }

                    ELSE IF((accParent.GE_HQ_DUNS_Number__c!=accParent.GE_HQ_HQ_Parent_Duns__c)&&(accParent.GE_HQ_HQ_Parent_Duns__c!=null))
                    {
                    accParent.Parent_Duns__c = accParent.GE_HQ_HQ_Parent_Duns__c;
                    System.debug('$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$'+accParent.Parent_Duns__c);

                    }
                    ELSE
                    {
                    accParent.Parent_Duns__c ='No Parent';
                    System.debug('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'+accParent.Parent_Duns__c);

                    }
                    System.debug('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^'+accParent.Parent_Duns__c);
                    }
                }   
        }
}