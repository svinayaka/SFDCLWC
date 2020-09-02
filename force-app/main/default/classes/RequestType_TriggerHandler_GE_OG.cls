/*
Class/Trigger Name     : RequestType_TriggerHandler_GE_OG
Used Where ?           : Call From RequestTypeTrigger_GE_OG Trigger
Purpose/Overview       : Used for Update Request Type Record
Scrum Team             : Transformation - OPPTY MGMT
Requirement Number     : R-23328 / R-23725
Author                 : Mohit Maheshwari
Created Date           : 07/Dec/2015
Test Class Name        : 
Code Coverage          : 
*/

public without sharing class RequestType_TriggerHandler_GE_OG{

    public void UpdateEquipementDesc(List<GE_ES_Request_Type__c> NewList, Map<ID,GE_ES_Request_Type__c> mapold){
        ID requestRecordTypeID = Util_GE_OG.getRecordTypeDetails('GE_ES_Request_Type__c',System.Label.FSE_Check_List).getRecordTypeId();
        
        Map<String,Double> mapfencetime = new Map<String,Double>();
        Map<String,Double> mapfencetimeturnkey = new Map<String,Double>();
        Map<String,String> mapCcountryISO = new Map<String,String>();
        
        // Get a list of Country Region Mapping Custom Setting values 
        List<Country_Region_Mapping_ge_og__c> lstcountyfenctime = Country_Region_Mapping_ge_og__c.getAll().values();
    
        // create a map of Country mapped with Region from Country Region Custom Setting List 
        for(Country_Region_Mapping_ge_og__c countyfenctime : lstcountyfenctime){
            mapfencetime.put(countyfenctime.country_name_ge_og__c.ToUpperCase(),countyfenctime.fence_fime_days_ge_og__c);
            mapfencetimeturnkey.put(countyfenctime.country_name_ge_og__c.ToUpperCase(),countyfenctime.fence_time_days_turnkey_ge_og__c);
            mapCcountryISO.put(countyfenctime.country_name_ge_og__c.ToUpperCase(),countyfenctime.iso_code_ge_og__c.ToUpperCase());
        }
        
        Set<ID> setInstalledID = new Set<ID>();
        Set<String> setOppID = new Set<String>();
        Map<ID,Opportunity> mapOpportunity;
        Map<ID,GE_Installed_Base__c> mapInstallbase; 
        for(GE_ES_Request_Type__c objrequest : NewList){
            if(objrequest.RecordTypeID == requestRecordTypeID){
                if(mapold==null || (objrequest.GIB_Serial_Number_1__c!=null))
                    setInstalledID.add(objrequest.GIB_Serial_Number_1__c);
                if(mapold==null || (objrequest.GIB_Serial_Number_2__c!=null))
                    setInstalledID.add(objrequest.GIB_Serial_Number_2__c);
                if(mapold==null || (objrequest.GIB_Serial_Number_3__c!=null))
                    setInstalledID.add(objrequest.GIB_Serial_Number_3__c);
                if(mapold==null || (objrequest.GIB_Serial_Number_4__c!=null))
                    setInstalledID.add(objrequest.GIB_Serial_Number_4__c);
                if(mapold==null || (objrequest.GIB_Serial_Number_5__c!=null))
                    setInstalledID.add(objrequest.GIB_Serial_Number_5__c);
                
                setOppID.add(objrequest.Opportunity__c);    
            }
        }
        if(setInstalledID.size()>0){
            mapInstallbase = new Map<ID,GE_Installed_Base__c>([Select ID, GE_ES_Technology__c, GE_ES_Equip_Model__c from GE_Installed_Base__c where ID in : setInstalledID]);
        }
        if(setOppID.size()>0){
            mapOpportunity = new Map<ID,Opportunity>([Select ID, is_turn_key_ge_og__c, opportunity_gfs_execution_date_ge_og__c, primary_country_ge_og__c, delivery_date_ge_og__c, HasOpportunityLineItem, closeDate, (Select ID, GE_ES_Product_Services__c from OpportunityLineItems order by CreatedDate asc limit 1) from Opportunity where ID in : setOppID]);   
        }
        
        for(GE_ES_Request_Type__c objrequest : NewList){
            if(objrequest.RecordTypeID == requestRecordTypeID){
                if(mapInstallbase != null){
                    objrequest.GE_OG_Equipment_Description_1__c = getEquipmentDescription(objrequest.GIB_Serial_Number_1__c, setInstalledID, mapInstallbase);
                    objrequest.GE_OG_Equipment_Description_2__c = getEquipmentDescription(objrequest.GIB_Serial_Number_2__c, setInstalledID, mapInstallbase);
                    objrequest.GE_OG_Equipment_Description_3__c = getEquipmentDescription(objrequest.GIB_Serial_Number_3__c, setInstalledID, mapInstallbase);
                    objrequest.GE_OG_Equipment_Description_4__c = getEquipmentDescription(objrequest.GIB_Serial_Number_4__c, setInstalledID, mapInstallbase);
                    objrequest.GE_OG_Equipment_Description_5__c = getEquipmentDescription(objrequest.GIB_Serial_Number_5__c, setInstalledID, mapInstallbase);
                }
                else{
                    objrequest.GE_OG_Equipment_Description_1__c = (objrequest.GIB_Serial_Number_1__c == null ? null : objrequest.GE_OG_Equipment_Description_1__c);
                    objrequest.GE_OG_Equipment_Description_2__c = (objrequest.GIB_Serial_Number_2__c == null ? null : objrequest.GE_OG_Equipment_Description_2__c);
                    objrequest.GE_OG_Equipment_Description_3__c = (objrequest.GIB_Serial_Number_3__c == null ? null : objrequest.GE_OG_Equipment_Description_3__c);
                    objrequest.GE_OG_Equipment_Description_4__c = (objrequest.GIB_Serial_Number_4__c == null ? null : objrequest.GE_OG_Equipment_Description_4__c);
                    objrequest.GE_OG_Equipment_Description_5__c = (objrequest.GIB_Serial_Number_5__c == null ? null : objrequest.GE_OG_Equipment_Description_5__c);
                }
                
                if(mapOpportunity!=null && 
                    mapOpportunity.containskey(objrequest.Opportunity__c)){
                        objrequest.GE_OG_Expected_Delivery_Date__c = mapOpportunity.get(objrequest.Opportunity__c).delivery_date_ge_og__c;
                        if(!String.isBlank(mapOpportunity.get(objrequest.Opportunity__c).primary_country_ge_og__c) && 
                            mapCcountryISO.containskey(mapOpportunity.get(objrequest.Opportunity__c).primary_country_ge_og__c)  && mapOpportunity.get(objrequest.Opportunity__c).HasOpportunityLineItem){
                            objrequest.GE_OG_OG_Primary_Country__c = mapCcountryISO.get(mapOpportunity.get(objrequest.Opportunity__c).primary_country_ge_og__c);
                            objrequest.GE_OG_Execution_Date_GFS__c = Util_GE_OG.CalculateOpportunityGFSExcetuionDate(mapOpportunity.get(objrequest.Opportunity__c).is_turn_key_ge_og__c, mapOpportunity.get(objrequest.Opportunity__c).primary_country_ge_og__c, mapOpportunity.get(objrequest.Opportunity__c).delivery_date_ge_og__c, mapOpportunity.get(objrequest.Opportunity__c).CloseDate, mapfencetime, mapfencetimeturnkey);
                        }
                        else{
                            objrequest.GE_OG_OG_Primary_Country__c = '';
                            objrequest.GE_OG_Execution_Date_GFS__c = null;
                        }
                     objrequest.GE_OG_Expected_Delivery_Date__c = mapOpportunity.get(objrequest.Opportunity__c).delivery_date_ge_og__c;
                        
                             
                }
                if(objrequest.GE_OG_Intervent_Type__c!=null && 
                    objrequest.GE_OG_Intervent_Description__c!=null && 
                    objrequest.GE_OG_Week_Duration_days_week__c!=null && 
                    objrequest.GE_OG_Shift_Duration_hours_day__c!=null && 
                    objrequest.GE_OG_Shifts__c!=null && 
                    objrequest.GE_OG_Offshore__c!=null && 
                    objrequest.GE_OG_Board_Lodging__c!=null && 
                    objrequest.GE_OG_Lodging_Type__c!=null && 
                    objrequest.GE_OG_Local_Transportation__c!=null && 
                    objrequest.GE_OG_Emergency_Flag__c!=null && 
                    objrequest.GE_OG_Overlap_Days__c!=null && 
                    objrequest.GIB_Serial_Number_1__c!=null && 
                    objrequest.GE_OG_Execution_Date_GFS__c!=null && 
                    objrequest.GE_OG_Expected_Delivery_Date__c!=null)
                {
                    objrequest.GE_OG_ITO_Checklist_Ready__c = 'Yes';        
                }
                else{ 
                    objrequest.GE_OG_ITO_Checklist_Ready__c = 'No';
                    objrequest.export_to_erp_ge_og__c = false;
                }    
            }
        }
    }
    
    public string getEquipmentDescription(ID SerialNo, Set<ID> setInstalledID, Map<ID,GE_Installed_Base__c> mapInstallbase){
        String tech = '';
        String equip = '';
        String detail = '';
        if(SerialNo!=null && setInstalledID.contains(SerialNo)){
            tech = mapInstallbase.get(SerialNo).GE_ES_Technology__c;
            equip = mapInstallbase.get(SerialNo).GE_ES_Equip_Model__c;
            if(!String.isBlank(tech))
                detail = tech;
            if(!String.isBlank(equip))
               if(!String.isBlank(detail))
                   detail = detail + '-' + equip;
               else
                   detail = equip;
            if(!String.isBlank(detail))
                return detail; 
        }
        return null;
    }
    
    /*
    public Date CalculateOpportunityGFSExcetuionDate(Opportunity objOpp, Map<String,Double> mapfencetime, Map<String,Double> mapfencetimeturnkey){
        
        if(!(String.IsBlank(objOpp.primary_country_ge_og__c))){
            Double fencedays = 0.0;
            if(objOpp.HasOpportunityLineItem){
                if(objOpp.OpportunityLineItems[0].GE_ES_Product_Services__c == 'Turn Key'){
                    fencedays = (mapfencetimeturnkey.containsKey(objOpp.primary_country_ge_og__c)?mapfencetimeturnkey.get(objOpp.primary_country_ge_og__c):0.0);    
                }
                else{
                    fencedays = (mapfencetime.containsKey(objOpp.primary_country_ge_og__c)?mapfencetime.get(objOpp.primary_country_ge_og__c):0.0);
                }
                if(objOpp.delivery_date_ge_og__c!=null){
                    if(objOpp.closeDate.addDays(fencedays.intValue())>=objOpp.delivery_date_ge_og__c){
                        return objOpp.closeDate.addDays(fencedays.intValue());  
                    }
                    else{
                        return objOpp.delivery_date_ge_og__c;
                    }   
                }
                else{
                    return objOpp.closeDate.addDays(fencedays.intValue());
                }   
            }
            return null;
        }
        return null;
    }
    */ 
    //Created for new Digital Deal - Sales Actions Checklist in opportunities
    public void afterInsertFunctionality(List<GE_ES_Request_Type__c> newReqType){
    
    /*After Insert of Request Type record add all the Digital Checklist Questions*/        
    Digital_deal_Sales_actions__mdt[] custMetQues = [SELECT DeveloperName,MasterLabel,Questions_ge_og__c,Stage_ge_og__c FROM Digital_deal_Sales_actions__mdt where Stage_ge_og__c !='']; 
    List<Digital_Deal_Sales_Actions_ge_og__c> lstDigType= new List<Digital_Deal_Sales_Actions_ge_og__c>();
    // Iterate through Request Type records
    for (GE_ES_Request_Type__c listInsertedRT: newReqType) {
         // Iterate through Custom Metadata records
         for (Digital_deal_Sales_actions__mdt custMetaQues : custMetQues) {
                System.debug('Inside For Loop');
                 if(listInsertedRT.RecordTypeId == Label.Digital_Deal_Record_TypeID){
                     System.debug('Inside RecordType Loop');
                     Digital_Deal_Sales_Actions_ge_og__c objDigType = new Digital_Deal_Sales_Actions_ge_og__c();
                     objDigType.Questions_ge_og__c=custMetaQues.Questions_ge_og__c;
                     objDigType.Stage_ge_og__c=custMetaQues.Stage_ge_og__c;
                     objDigType.Request_Type_ge_og__c=listInsertedRT.Id; 
                     System.debug('objDigType'+objDigType);
                     lstDigType.add(objDigType);
                     System.debug('lstDigType'+lstDigType);
                  }
            }
            
            Database.SaveResult[] srList = Database.insert(lstDigType, false);
            // Iterate through each returned result
            for (Database.SaveResult sr : srList) {
                if (sr.isSuccess()) {
                    // Operation was successful, so get the ID of the record that was processed
                    System.debug('Successfully inserted ID: ' + sr.getId());
                    //listtier2.add(sr.id);
                }
                else {
                    // Operation failed, so get all errors                
                    for(Database.Error err : sr.getErrors()) {
                        System.debug('The following error has occurred.');                    
                        System.debug(err.getStatusCode() + ': ' + err.getMessage());
                        System.debug('fields that affected this error: ' + err.getFields());
                    }
                }
            }
        }
    }
}