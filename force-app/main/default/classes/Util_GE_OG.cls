/*
Class/Trigger Name     : Util_GE_OG
Used Where ?           : DealDeskTriggerHandler_GE_OG class , OpportunityTrigger_GE_OG trigger
Purpose/Overview       : Used for returning record type info based on Object and record type name
Scrum Team             : Transformation - OPPTY MGMT
Requirement Number     : R-23281
Author                 : Sanath Kumar Dheram
Created Date           : 16/SEP/2015
Test Class Name        : Util_GE_OG_Test
Code Coverage          : 83%
*/
public without sharing class Util_GE_OG
{
    // Variable to handle insertion of Opportunity Owner into the Opportunity Team
    public static boolean isFromOppTriggerInsert = false;
    
    // Method to return Record type details by object name and record type name
    public static Schema.RecordTypeInfo getRecordTypeDetails(String objectName, String recordTypeName)
    {
        Schema.RecordTypeInfo recordtypeInfo;
        
        // Check if objectName and recordTypeName is not null and is not blank
        if(!String.IsBlank(objectName) && !String.IsBlank(recordTypeName))
        {
            recordtypeInfo = Schema.getGlobalDescribe().get(objectName).getDescribe().getRecordTypeInfosByName().get(recordTypeName);
            return recordtypeInfo ;
        }
        else
            return recordtypeInfo ;
    }
    
    //Method to Populate region on the basis of Country
    public static String regionPopulateByCountry(String installCountry){
        
         Map<String,String> mapcountryreg = new Map<String,String>();
        
         // Get a list of Country Region Mapping Custom Setting values 
        List<Country_Region_Mapping_ge_og__c> lstcountyregmap = Country_Region_Mapping_ge_og__c.getAll().values();
    
        // create a map of Country mapped with Region from Country Region Custom Setting List 
        for(Country_Region_Mapping_ge_og__c country : lstcountyregmap){
            mapcountryreg.put(country.country_name_ge_og__c.ToUpperCase(),country.region_ge_og__c);
        }
        
        //returning region Name from Map
        return (String.isBlank(installCountry)?installCountry:mapcountryreg.get(installCountry.ToUpperCase()));
    }
    
    
    // method to calculate GFS Excecution Date On Opportunity And Request Type
    public static Date CalculateOpportunityGFSExcetuionDate(Boolean isTurnKey, String PrimaryCountry, Date deliveryDate, Date expectedOrderDate, Map<String,Double> mapfencetime, Map<String,Double> mapfencetimeturnkey){
        Double fencedays;
        if(isTurnKey){
            fencedays = (mapfencetimeturnkey.containsKey(PrimaryCountry)?mapfencetimeturnkey.get(PrimaryCountry):0.0);    
        }
        else{
            fencedays = (mapfencetime.containsKey(PrimaryCountry)?mapfencetime.get(PrimaryCountry):0.0);
        }
        //if(deliveryDate!=null){ the changes made during IQ testing
        if (deliveryDate != null && expectedOrderDate != null){
            if(expectedOrderDate.addDays(fencedays.intValue())>=deliveryDate){
                return expectedOrderDate.addDays(fencedays.intValue());  
            }
            else{
                return deliveryDate;
            }   
        }
        else{
            return expectedOrderDate.addDays(fencedays.intValue());
        }
        return null;    
    }
    
    // For R-24506, method to create dynamic query and using Object Name and 
    public static sObject queryObjectFields(String recordId) {
        String objectName = '';
        
        String keyCode = recordId.subString(0,3);
        Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe();
        for(Schema.SObjectType objectInstance : gd.values())
        {
            if(objectInstance.getDescribe().getKeyPrefix() == keyCode)
            {
                System.debug('Id is related to object: '+ objectInstance.getDescribe().getName());
                objectName = objectInstance.getDescribe().getName();
            }
        }
        
        
        Map <String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        Map <String, Schema.SObjectField> fieldMap = schemaMap.get(objectName).getDescribe().fields.getMap();
        String objectQuery = 'select ';
        //Create a Dynamic query 
        for(Schema.SObjectField sfield : fieldMap.Values())
        {
            schema.describefieldresult dfield = sfield.getDescribe();
            
             if(objectName=='User' && dfield.getName()!='ProfilePhotoId')
              objectQuery +=  dfield.getName() +', ' ;
        }
        
        String newQuery = objectQuery.subString(0,objectQuery.Length()-2);
        System.debug('\n\n NEW QUERY '+newQuery);
        newQuery += ' from ' + objectName + ' where Id = \''+recordId+'\'';        
        System.debug('\n\n FINAL NEW QUERY '+newQuery );
        sObject objectRecords = Database.query(newQuery );
        System.debug('\n\n Records '+objectRecords);
        return objectRecords ;
    }

    /*
    * Author - Kiru
    * Req= R-29621
    * Restrict creating Opportunity when user choose a country that has the restrcited checkbox in custom settings
    */
    public static void restrictCountryOnOppty(List<Opportunity> newlstOpp){

           //Added as part of the REquirement R-29621. Added by Kiru
        List<country_region_mapping_ge_og__c> countryregionlist = [Select country_name_ge_og__c, status_ge_og__c from country_region_mapping_ge_og__c where Restricted_Country_ge_og__c = TRUE];
        if(countryregionlist!=null && countryregionlist.size()>0){
            for(Opportunity opp : newlstOpp){
                for(country_region_mapping_ge_og__c restrictedcountry : countryregionlist){
                    if(opp.install_country_ge_og__c == restrictedcountry.country_name_ge_og__c){
                        opp.install_country_ge_og__c.adderror(System.Label.Opportunity_RestrictedCountry_Error_Message);
                    } 
                }
                
            } 
        }

    }
    
   
}