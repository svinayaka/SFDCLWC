/**
* 
* Class/Trigger Name--: GE_OG_PRM_TriggerHandler
* Object Name         : Channel Appointment
* Purpose/Overview----: Handler Clas GE_OG_PRM_TriggerHandler would process all the Trigger requests coming from GE_OG_ContactTrigger
                        All Logic to be processed in the Handler Class or Helper Classes being called from this Handler Class
* Functional Area-----: PRM
* Author--------------: 
* Created Date--------: 7/23/2014
* Test Class Name-----: Test_GE_PRM_Channel_Appointment_Class
* Change History -
* Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
**/


Public  without sharing class GE_OG_PRM_TriggerHandler 
{
    public void OnBeforeInsert(List<GE_PRM_Channel_Appointment__c> newObjects){
        // EXECUTE BEFORE INSERT LOGIC
    }
    public void OnAfterInsert(List<GE_PRM_Channel_Appointment__c> newObjects){
        // EXECUTE AFTER INSERT LOGIC
        GE_OG_PRM_GenerateRiskPath Rskpath= new GE_OG_PRM_GenerateRiskPath();
        //commenting out below method which is not in used after 15.7 release. 
    }
    public void OnBeforeUpdate(List<GE_PRM_Channel_Appointment__c> oldObjects, List<GE_PRM_Channel_Appointment__c> newObjects, Map<Id, GE_PRM_Channel_Appointment__c> newObjectMap){
     }
    public void OnAfterUpdate(List<GE_PRM_Channel_Appointment__c> oldObjects, List<GE_PRM_Channel_Appointment__c> newObjects, Map<Id, GE_PRM_Channel_Appointment__c> Oldmap){
        GE_OG_PRM_GenerateRiskPath Rskpath= new GE_OG_PRM_GenerateRiskPath();
        Rskpath.generateRisk(oldObjects,newObjects,Oldmap);
        GE_PRM_GenerateContracts Gnrtctrct =new GE_PRM_GenerateContracts ();
        Gnrtctrct.createcontracts(newObjects,Oldmap);
    }
    public void OnBeforeDelete(List<GE_PRM_Channel_Appointment__c> ObjectsToDelete, Map<Id, GE_PRM_Channel_Appointment__c> oldObjectMap){
        // BEFORE DELETE LOGIC
    }
    public void OnAfterDelete(List<GE_PRM_Channel_Appointment__c> deletedObjects, Map<Id, GE_PRM_Channel_Appointment__c> oldObjectMap){
        // AFTER DELETE LOGIC
    }
    public void OnUndelete(List<GE_PRM_Channel_Appointment__c> restoredObjects){
        // AFTER UNDELETE LOGIC
    }
     /* ------------------------ Start ---------------------------------
       Trigger : GE_OG_PRM_ChannelApptTrigger
       Description : If 'Was ever High?' on LE = True, then 'Was Ever High?' on Channel Appt should = True 
                     OR 
                     If the Risk Rating on Channel Appt is High, 'Was Ever High?' on Channel Appt should = True
                     Check if the field ‘Was Ever High’ has a value (checked), if yes, end the code execution 
                     If the field is blank, and the latest value got saved to ‘Latest Risk Rating’ is ‘High’, then tick the ‘Was Ever High’ field
       ------------------------- End ---------------------------------- */ 
    Public void UpdateWasEverHigh(List<GE_PRM_Channel_Appointment__c> newAppointments,Map<Id, GE_PRM_Channel_Appointment__c> oldMap){
        List<GE_PRM_Channel_Appointment__c> lst_Channel_Appointment_Ids = new List<GE_PRM_Channel_Appointment__c>();
        Set<Id> Set_Account_Ids = new Set<Id>();
        List<Account> List_Account_Was_Ever_High = new List<Account>();
        Map<Id,GE_PRM_Channel_Appointment__c> MapOfChannelAppointment = new Map<Id,GE_PRM_Channel_Appointment__c>();          
            for(GE_PRM_Channel_Appointment__c  newAppt: newAppointments){
                    if(newAppt.Was_Ever_High__c == true && newAppt.GE_PRM_Account_Name__r.Was_Ever_High__c != true){                           
                            system.debug('&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&'+newAppt.GE_PRM_Account_Name__r.Was_Ever_High__c);
                            //newAppt.GE_PRM_Account_Name__r.Was_Ever_High__c = true;
                            Set_Account_Ids.add(newAppt.GE_PRM_Account_Name__c);                            
                    }                   
                    else if(newAppt.GE_PRM_Account_Name__r.Was_Ever_High__c == true){                           
                            system.debug('&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&'+newAppt.GE_PRM_Account_Name__r.Was_Ever_High__c);
                            newAppt.Was_Ever_High__c = true;                          
                    }
                    if(oldMap.get(newAppt.id).GE_PRM_Risk_rating__c != newAppt.GE_PRM_Risk_rating__c)
                    {
                       MapOfChannelAppointment.put(newAppt.GE_PRM_Account_Name__c,newAppt);
                       Set_Account_Ids.add(newAppt.GE_PRM_Account_Name__c);  
                    }
                 
                }
             
             if(!Set_Account_Ids.isEmpty() || Set_Account_Ids!=Null){
                system.debug('&&&&&&&&&&&&&&&&&&&'+Set_Account_Ids);
                 for(Account Acct : [Select id,Was_Ever_High__c,Latest_Risk_Rating__c from Account WHERE Id IN : Set_Account_Ids AND Account_Status__c=:'CC Approved'])
                 {
                   // Acct.Was_Ever_High__c = true;
                    system.debug('MapOfChannelAppointment#########'+MapOfChannelAppointment);
                    if(!MapOfChannelAppointment.isEmpty()){
                        if(Acct.Id==MapOfChannelAppointment.get(Acct.Id).GE_PRM_Account_Name__c)
                        {
                          Acct.Latest_Risk_Rating__c = MapOfChannelAppointment.get(Acct.Id).GE_PRM_Risk_rating__c;                          
                        }
                        if(MapOfChannelAppointment.get(Acct.Id).Was_Ever_High__c==true){
                          Acct.Was_Ever_High__c = True;
                        }
                     }
                    List_Account_Was_Ever_High.add(Acct);
                 }
                 system.debug('%%%%%%%%%%%%%%%%%%%'+List_Account_Was_Ever_High);
             }
             if(!List_Account_Was_Ever_High.isEmpty())
             {
                update List_Account_Was_Ever_High;
             }
    }
    
    public void updateIPIPOnLEAccount(List<GE_PRM_Channel_Appointment__c> newAppointments, Map<Id, GE_PRM_Channel_Appointment__c> oldMap){
        Set<Id> leAccountIds = new Set<Id>();
        List<GE_PRM_Channel_Appointment__c> lstChannelAppointments = new List<GE_PRM_Channel_Appointment__c>();
        Map<id, List<GE_PRM_Channel_Appointment__c>> mapAccountChAppt = new Map<id, List<GE_PRM_Channel_Appointment__c>>();
        Map<Id,Account> mapAccountIdAccount = new Map<Id, Account>();
        List<Account> lstAccountsFromMap = new List<Account>();
        List<Account> lstAccountsToUpdate = new List<Account>();
         Id CMFrecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('CMF Approved').getRecordTypeId();
        for(GE_PRM_Channel_Appointment__c objAppointment: newAppointments){
            if(objAppointment.GE_PRM_Last_Spirit_Letter_signed_date__c != oldMap.get(objAppointment.id).GE_PRM_Last_Spirit_Letter_signed_date__c
            || objAppointment.GE_PRM_Last_Site_visit_signed_date__c != oldMap.get(objAppointment.id).GE_PRM_Last_Site_visit_signed_date__c
            || objAppointment.GE_PRM_Deloitte_report_order_date__c != oldMap.get(objAppointment.id).GE_PRM_Deloitte_report_order_date__c
            || objAppointment.GE_PRM_Last_Deloitte_report_cmpltd_date__c != oldMap.get(objAppointment.id).GE_PRM_Last_Deloitte_report_cmpltd_date__c
            || objAppointment.GE_PRM_KYC_DD_Approved_Date__c != oldMap.get(objAppointment.id).GE_PRM_KYC_DD_Approved_Date__c
            || objAppointment.Negative_News_Search_Date__c != oldMap.get(objAppointment.id).Negative_News_Search_Date__c){
                leAccountIds.add(objAppointment.GE_PRM_Account_Name__c);
            }
        }
        if(!leAccountIds.isEmpty()){
            lstChannelAppointments = [SELECT Id, name, GE_PRM_Last_Spirit_Letter_signed_date__c, 
                                    GE_PRM_Last_Site_visit_signed_date__c,GE_PRM_Deloitte_report_order_date__c, 
                                    GE_PRM_Last_Deloitte_report_cmpltd_date__c, GE_PRM_KYC_DD_Approved_Date__c, 
                                    Negative_News_Search_Date__c, GE_PRM_Account_Name__c
                                    FROM GE_PRM_Channel_Appointment__c
                                    WHERE GE_PRM_Account_Name__c IN: leAccountIds
                                    LIMIT 50000];
        }
        if(!lstChannelAppointments.isEmpty()){
            List<GE_PRM_Channel_Appointment__c> lstAppts = new List<GE_PRM_Channel_Appointment__c>();
            for(GE_PRM_Channel_Appointment__c objAppt: lstChannelAppointments){
                if(mapAccountChAppt.containsKey(objAppt.GE_PRM_Account_Name__c)){
                    lstAppts = mapAccountChAppt.get(objAppt.GE_PRM_Account_Name__c);
                    lstAppts.add(objAppt);
                    mapAccountChAppt.put(objAppt.GE_PRM_Account_Name__c, lstAppts);
                } 
                else{
                    mapAccountChAppt.put(objAppt.GE_PRM_Account_Name__c, new List<GE_PRM_Channel_Appointment__c>());
                    lstAppts.add(objAppt);
                    mapAccountChAppt.put(objAppt.GE_PRM_Account_Name__c, lstAppts);
                }   
            }
        }
        system.debug('map ch contents..... '+mapAccountChAppt);
        
        if(mapAccountChAppt.keySet() != null){
            lstAccountsFromMap = [SELECT id, name, Latest_Deloitte_Report_Completed_Date__c, Latest_Deloitte_Report_Request_Date__c,
                                  Latest_Spirit_Letter_Signed_Date__c, Latest_Negative_News_Search_Date__c, Latest_KYC_DD_Approved_Date__c,
                                  Latest_Site_Visit_Signed_Date__c, RecordTypeId
                                  FROM Account
                                  WHERE id IN: mapAccountChAppt.keySet()
                                  LIMIT 50000];
        }
        if(!lstAccountsFromMap.isEmpty()){
            for(Account objAccount: lstAccountsFromMap){
                if(!mapAccountIdAccount.containsKey(objAccount.id)){
                        mapAccountIdAccount.put(objAccount.Id, objAccount);
                } 
            }
        }
        for(GE_PRM_Channel_Appointment__c objAppointment: newAppointments){
            Account objAccountUpdate = mapAccountIdAccount.get(objAppointment.GE_PRM_Account_Name__c);
            List<GE_PRM_Channel_Appointment__c> lstAppointments = new List<GE_PRM_Channel_Appointment__c>();
            if(objAppointment.GE_PRM_Last_Spirit_Letter_signed_date__c != oldMap.get(objAppointment.id).GE_PRM_Last_Spirit_Letter_signed_date__c){
                lstAppointments = mapAccountChAppt.get(objAppointment.GE_PRM_Account_Name__c);
                Date maxSpiritLetterDate = lstAppointments[0].GE_PRM_Last_Spirit_Letter_signed_date__c;
                for(Integer i=1; i < lstAppointments.size(); i++){
                    if(lstAppointments[i].GE_PRM_Last_Spirit_Letter_signed_date__c > maxSpiritLetterDate || maxSpiritLetterDate == null){
                        maxSpiritLetterDate = lstAppointments[i].GE_PRM_Last_Spirit_Letter_signed_date__c;
                    }
                }
                if((objAccountUpdate.Latest_Spirit_Letter_Signed_Date__c == null) || (maxSpiritLetterDate > objAccountUpdate.Latest_Spirit_Letter_Signed_Date__c)){
                    objAccountUpdate.Latest_Spirit_Letter_Signed_Date__c = maxSpiritLetterDate;
                }
            }
            
            if(objAppointment.GE_PRM_Last_Site_visit_signed_date__c != oldMap.get(objAppointment.id).GE_PRM_Last_Site_visit_signed_date__c){
                lstAppointments = mapAccountChAppt.get(objAppointment.GE_PRM_Account_Name__c);
                Date maxSiteVisitDate = lstAppointments[0].GE_PRM_Last_Site_visit_signed_date__c;
                for(Integer i=1; i < lstAppointments.size(); i++){
                    if(lstAppointments[i].GE_PRM_Last_Site_visit_signed_date__c > maxSiteVisitDate || maxSiteVisitDate == null){
                        maxSiteVisitDate = lstAppointments[i].GE_PRM_Last_Site_visit_signed_date__c;
                    }
                }
                if((objAccountUpdate.Latest_Site_Visit_Signed_Date__c == null) || (maxSiteVisitDate > objAccountUpdate.Latest_Site_Visit_Signed_Date__c)){
                    objAccountUpdate.Latest_Site_Visit_Signed_Date__c = maxSiteVisitDate;
                }
            }
            
            if(objAppointment.GE_PRM_Deloitte_report_order_date__c != oldMap.get(objAppointment.id).GE_PRM_Deloitte_report_order_date__c){
                lstAppointments = mapAccountChAppt.get(objAppointment.GE_PRM_Account_Name__c);
                Date maxDelReqDate = lstAppointments[0].GE_PRM_Deloitte_report_order_date__c;
                for(Integer i=1; i < lstAppointments.size(); i++){
                    if(lstAppointments[i].GE_PRM_Deloitte_report_order_date__c > maxDelReqDate || maxDelReqDate == null){
                        maxDelReqDate = lstAppointments[i].GE_PRM_Deloitte_report_order_date__c;
                    }
                }
                if((objAccountUpdate.Latest_Deloitte_Report_Request_Date__c == null) || (maxDelReqDate > objAccountUpdate.Latest_Deloitte_Report_Request_Date__c)){
                    objAccountUpdate.Latest_Deloitte_Report_Request_Date__c = maxDelReqDate;
                }
            }
            
            if(objAppointment.GE_PRM_Last_Deloitte_report_cmpltd_date__c != oldMap.get(objAppointment.id).GE_PRM_Last_Deloitte_report_cmpltd_date__c){
                lstAppointments = mapAccountChAppt.get(objAppointment.GE_PRM_Account_Name__c);
                Date maxDelComplDate = lstAppointments[0].GE_PRM_Last_Deloitte_report_cmpltd_date__c;
                for(Integer i=1; i < lstAppointments.size(); i++){
                    if(lstAppointments[i].GE_PRM_Last_Deloitte_report_cmpltd_date__c > maxDelComplDate || maxDelComplDate == null){
                        maxDelComplDate = lstAppointments[i].GE_PRM_Last_Deloitte_report_cmpltd_date__c;
                    }
                }
                if((objAccountUpdate.Latest_Deloitte_Report_Completed_Date__c == null) || (maxDelComplDate > objAccountUpdate.Latest_Deloitte_Report_Completed_Date__c)){
                    objAccountUpdate.Latest_Deloitte_Report_Completed_Date__c = maxDelComplDate;
                }
            }
            
            if(objAppointment.GE_PRM_KYC_DD_Approved_Date__c != oldMap.get(objAppointment.id).GE_PRM_KYC_DD_Approved_Date__c){
                lstAppointments = mapAccountChAppt.get(objAppointment.GE_PRM_Account_Name__c);
                Date maxKYCAppDate = lstAppointments[0].GE_PRM_KYC_DD_Approved_Date__c;
                for(Integer i=1; i < lstAppointments.size(); i++){
                    if(lstAppointments[i].GE_PRM_KYC_DD_Approved_Date__c > maxKYCAppDate || maxKYCAppDate == null){
                        maxKYCAppDate = lstAppointments[i].GE_PRM_KYC_DD_Approved_Date__c;
                    }
                }
                if((objAccountUpdate.Latest_KYC_DD_Approved_Date__c == null) || (maxKYCAppDate > objAccountUpdate.Latest_KYC_DD_Approved_Date__c)){
                    objAccountUpdate.Latest_KYC_DD_Approved_Date__c = maxKYCAppDate;
                }
            }
            
            if(objAppointment.Negative_News_Search_Date__c != oldMap.get(objAppointment.id).Negative_News_Search_Date__c){
                lstAppointments = mapAccountChAppt.get(objAppointment.GE_PRM_Account_Name__c);
                Date maxNegSearchDate = lstAppointments[0].Negative_News_Search_Date__c;
                for(Integer i=1; i < lstAppointments.size(); i++){
                    if(lstAppointments[i].Negative_News_Search_Date__c > maxNegSearchDate || maxNegSearchDate == null){
                        maxNegSearchDate = lstAppointments[i].Negative_News_Search_Date__c;
                    }
                }
                if((objAccountUpdate.Latest_Negative_News_Search_Date__c == null) || (maxNegSearchDate > objAccountUpdate.Latest_Negative_News_Search_Date__c)){
                    objAccountUpdate.Latest_Negative_News_Search_Date__c = maxNegSearchDate;
                }
            }
            if(objAccountUpdate != null && objAccountUpdate.RecordTypeId == CMFrecordTypeId){
                lstAccountsToUpdate.add(objAccountUpdate);
            }
        }
        
        if(!lstAccountsToUpdate.isEmpty()){
            try{
                update lstAccountsToUpdate;
            }
            catch(Exception e){
                system.debug('Error while updating accounts '+e.getMessage());
            }
        }
    }
    
}