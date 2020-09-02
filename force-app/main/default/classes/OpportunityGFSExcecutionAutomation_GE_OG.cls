/*
Class/Trigger Name     : OpportunityGFSExcecutionAutomation_GE_OG
Used Where ?           : Call From OpportunityTriggerHandler_GE_OG
Purpose/Overview       : Used for Update Request Type Record If Oppty Updates
Scrum Team             : Transformation - OPPTY MGMT
Requirement Number     : R-23328 / R-23725
Author                 : Mohit Maheshwari
Created Date           : 07/Dec/2015
Test Class Name        : 
Code Coverage          : 
*/
public without Sharing Class OpportunityGFSExcecutionAutomation_GE_OG{
    public void CalculateOpportunityGFSExcetuionDate(List<Opportunity> lstOpp, Map<ID,Opportunity> oldOppMap){
        
        //Get the RecordTypeId of O&G recordtype
        Id oppOGRecordTypeId = Util_GE_OG.getRecordTypeDetails('Opportunity',System.Label.O_G).getRecordTypeId();
        
        Set<ID> setOppIDs = new Set<ID>();
        
        Map<String,Double> mapfencetime = new Map<String,Double>();
        Map<String,Double> mapfencetimeturnkey = new Map<String,Double>();
        Map<String,String> mapCcountryISO = new Map<String,String>();
        Map<ID,OpportunityLineItem> mapOPP_OLI = new Map<ID, OpportunityLineItem>();
        
        // Get a list of Country Region Mapping Custom Setting values 
        List<Country_Region_Mapping_ge_og__c> lstcountyfenctime = Country_Region_Mapping_ge_og__c.getAll().values();
    
        // create a map of Country mapped with Region from Country Region Custom Setting List 
        for(Country_Region_Mapping_ge_og__c countyfenctime : lstcountyfenctime){
            mapfencetime.put(countyfenctime.country_name_ge_og__c.ToUpperCase(),countyfenctime.fence_fime_days_ge_og__c);
            mapfencetimeturnkey.put(countyfenctime.country_name_ge_og__c.ToUpperCase(),countyfenctime.fence_time_days_turnkey_ge_og__c);
            mapCcountryISO.put(countyfenctime.country_name_ge_og__c.ToUpperCase(),countyfenctime.iso_code_ge_og__c.ToUpperCase());
        }

        for(Opportunity objOpp : lstOpp){
            if(objOpp.HasOpportunityLineItem && objOpp.RecordTypeID == oppOGRecordTypeId){
                setOppIDs.add(objOpp.ID);
            }
            /*****Begin of Logic Primary Country ISO Update *****/
            if(!String.isBlank(objOpp.primary_country_ge_og__c) && String.isBlank(objOpp.primary_country_iso_ge_og__c)){
                objOpp.primary_country_iso_ge_og__c = (mapCcountryISO.containskey(objOpp.primary_country_ge_og__c) ? mapCcountryISO.get(objOpp.primary_country_ge_og__c):'');   
            }
            else if(objOpp.primary_country_ge_og__c != oldOppMap.get(objOpp.ID).primary_country_ge_og__c){
                objOpp.primary_country_iso_ge_og__c = (mapCcountryISO.containskey(objOpp.primary_country_ge_og__c) ? mapCcountryISO.get(objOpp.primary_country_ge_og__c):'');
            }
            else if(String.isBlank(objOpp.primary_country_ge_og__c)){
                objOpp.primary_country_iso_ge_og__c = '';
            }
            /*****End of Logic Primary Country ISO Update *****/
        }
        
        if(setOppIDs.size()>0){
            List<Opportunity> lstOpp_OLI = new List<Opportunity>();
            lstOpp_OLI = [Select ID, (Select ID, GE_ES_Product_Services__c from OpportunityLineItems order by CreatedDate asc limit 1) from Opportunity where ID in : setOppIDs];
            if(lstOpp_OLI.size()>0){
                for(Opportunity objOpp : lstOpp_OLI){
                    system.debug('==== \n\n ==  objOpp '+objOpp+' ==  \n\n ');
                    for(OpportunityLineItem objOLI : objOpp.OpportunityLineItems){
                        if(!oldOppMap.get(objOpp.ID).HasOpportunityLineItem){
                            Boolean booladd = addProductInMap(objOLI.GE_ES_Product_Services__c, false, false);
                                if(booladd){
                                    mapOPP_OLI.put(objOpp.ID, objOLI);
                                }
                        }
                        else{
                            Boolean booladd = addProductInMap(objOLI.GE_ES_Product_Services__c, oldOppMap.get(objOpp.ID).is_turn_key_ge_og__c, true);
                                if(booladd){
                                    mapOPP_OLI.put(objOpp.ID, objOLI);
                                }
                            }
                    }
                }
            }
        }
        
        for(Opportunity objOpp : lstOpp){
            if(setOppIDs.contains(objOpp.ID)){
                if((objOpp.closeDate != oldOppMap.get(objOpp.ID).CloseDate || 
                    objOpp.StageName != oldOppMap.get(objOpp.ID).StageName ||
                    objOpp.primary_country_ge_og__c != oldOppMap.get(objOpp.ID).primary_country_ge_og__c || 
                    objOpp.delivery_date_ge_og__c != oldOppMap.get(objOpp.ID).delivery_date_ge_og__c || mapOPP_OLI.containskey(objOpp.ID)) && objOpp.RecordTypeID == oppOGRecordTypeId) 
                {
                    if(mapOPP_OLI.containskey(objOpp.ID) && String.isBlank(mapOPP_OLI.get(objOpp.ID).GE_ES_Product_Services__c)){
                        objOpp.is_turn_key_ge_og__c = false;        
                    }
                    else if(mapOPP_OLI.containskey(objOpp.ID) && mapOPP_OLI.get(objOpp.ID).GE_ES_Product_Services__c == 'Turn Key'){
                        objOpp.is_turn_key_ge_og__c = True;
                    }
                    else if(mapOPP_OLI.containskey(objOpp.ID) &&  mapOPP_OLI.get(objOpp.ID).GE_ES_Product_Services__c != 'Turn Key'){
                        objOpp.is_turn_key_ge_og__c = false;
                    }
                    if(!String.isBlank(objOpp.primary_country_ge_og__c)){
                        //objOpp.primary_country_iso_ge_og__c = (mapCcountryISO.containskey(objOpp.primary_country_ge_og__c) ? mapCcountryISO.get(objOpp.primary_country_ge_og__c):'');   
                        
                        objOpp.opportunity_gfs_execution_date_ge_og__c = Util_GE_OG.CalculateOpportunityGFSExcetuionDate(objOpp.is_turn_key_ge_og__c, objOpp.primary_country_ge_og__c, objOpp.delivery_date_ge_og__c, objOpp.closeDate, mapfencetime, mapfencetimeturnkey);
                    }
                    else{
                        objOpp.primary_country_iso_ge_og__c = '';
                        objOpp.opportunity_gfs_execution_date_ge_og__c = null;
                    }
                    
                    system.debug('Not Update Requeset Type from Oppty In Oppty Class ' + objOpp.ID);
                }
            }
            else if(!objOpp.HasOpportunityLineItem && 
                objOpp.HasOpportunityLineItem != oldOppMap.get(objOpp.ID).HasOpportunityLineItem && 
                objOpp.RecordTypeID == oppOGRecordTypeId){
                    system.debug('Not Update Requeset Type from Oppty In Oppty Class ' + objOpp.ID);
                    objOpp.opportunity_gfs_execution_date_ge_og__c = null;
                    objOpp.is_turn_key_ge_og__c = false;
            }
            else if(objOpp.RecordTypeID == oppOGRecordTypeId){
                objOpp.opportunity_gfs_execution_date_ge_og__c = null;
                objOpp.is_turn_key_ge_og__c= false;
            }
        }
    }
    
    public Boolean addProductInMap(String productservice, Boolean isTurnKey, Boolean hasProduct){
        if(!hasProduct){
            return true;
        }
        else{
            if(!String.isBlank(productservice)){
                if(productservice.toUpperCase() == 'TURN KEY' && isTurnKey){
                    return false;   
                }   
                else if(productservice.toUpperCase() == 'TURN KEY' &&  !isTurnKey){
                    return true;    
                }
                else if(productservice.toUpperCase() != 'TURN KEY' &&  isTurnKey){
                    return true;
                }    
            }
            else
                return true;
        }
        
        return false;
    }
    
    public void updateRequestType(List<Opportunity> lstOpp, Map<ID,Opportunity> oldOppMap){
        
        //Get the RecordTypeId of O&G recordtype
        Id oppOGRecordTypeId = Util_GE_OG.getRecordTypeDetails('Opportunity',System.Label.O_G).getRecordTypeId();
        ID requestRecordTypeID = Util_GE_OG.getRecordTypeDetails('GE_ES_Request_Type__c',System.Label.FSE_Check_List).getRecordTypeId();

        Set<ID> setOppIDs = new Set<ID>();
        
        for(Opportunity objOpp : lstOpp){
            if((objOpp.closeDate != oldOppMap.get(objOpp.ID).CloseDate ||
                    objOpp.StageName != oldOppMap.get(objOpp.ID).StageName ||
                    objOpp.primary_country_ge_og__c != oldOppMap.get(objOpp.ID).primary_country_ge_og__c || 
                    objOpp.delivery_date_ge_og__c != oldOppMap.get(objOpp.ID).delivery_date_ge_og__c || 
                    objOpp.is_turn_key_ge_og__c != oldOppMap.get(objOpp.ID).is_turn_key_ge_og__c || 
                    objOpp.opportunity_gfs_execution_date_ge_og__c != oldOppMap.get(objOpp.ID).opportunity_gfs_execution_date_ge_og__c || 
                    objOpp.is_turn_key_ge_og__c != oldOppMap.get(objOpp.ID).is_turn_key_ge_og__c) && oppOGRecordTypeId == objOpp.RecordTypeID)
            {
                setOppIDs.add(objOpp.ID);           
            }
        }
        
        
        if(setOppIDs.size()>0){
            List<GE_ES_Request_Type__c> lstrequestType = new List<GE_ES_Request_Type__c>();
            List<GE_ES_Request_Type__c> lstupdataerequestType = new List<GE_ES_Request_Type__c>();
            lstrequestType = [Select ID, export_to_erp_ge_og__c, request_type_islocked_ge_og__c, GE_OG_Execution_Date_GFS__c, GE_OG_Expected_Delivery_Date__c, GE_OG_OG_Primary_Country__c from GE_ES_Request_Type__c where RecordTypeID =: requestRecordTypeID and Opportunity__c in :  setOppIDs];
            for(GE_ES_Request_Type__c objRequest : lstrequestType){
                objrequest.request_type_islocked_ge_og__c= true;
                lstupdataerequestType.add(objRequest);
            }
            if(lstupdataerequestType.size()>0)
                update lstupdataerequestType;
        }
        
    }
}