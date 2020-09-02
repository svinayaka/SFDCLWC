/*************************************************************************************************************************************************************
@ Class:          GE_OG_InvokeFSProjectDetailMgmtBatch
@ Version:        1.0
@ Author:         Mani(manikandan.c@bhge.com)
@ Purpose:        To invoke the batch job to upsert Product, IP and Work Detail
/*************************************************************************************************************************************************************/

global without sharing class GE_OG_InvokeFSProjectDetailMgmtBatch{
    
    /*@methodName- executeTMProcessing
*@description- Method to call the Batch class to upsert Product, IP and Work Detail.
*@param- null
*@return- batch Id */
    public static void executeFSPDProcessing(){
        apexclass tmclass = [SELECT Id FROM ApexClass WHERE Name ='GE_OG_FSProjectDetail_Management'];
        List<AsyncApexJob> tmbatchList = [SELECT ApexClassId, status FROM AsyncApexJob WHERE ApexClassId =: tmclass.id AND Status NOT IN ('Completed','Aborted','Failed')];
        if(tmbatchList.size() == 0){
            GE_OG_FSProjectDetail_Management b = new GE_OG_FSProjectDetail_Management();
            ID batchprocessid=Database.executeBatch(b,1); 
        }
    }
    public PageReference closePopup() {
        String FSProjectDetailObjIdLink = '/'+ GE_OG_FS_Project_Detail__c.sobjecttype.getDescribe().getKeyPrefix();
        PageReference reference=new PageReference(FSProjectDetailObjIdLink);
        reference.setRedirect(true);
        return reference; 
    }
}