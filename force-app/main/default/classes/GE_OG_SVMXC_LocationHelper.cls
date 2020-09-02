/*
Class Name                   - GE_OG_SVMXC_LocationHelper
Object Name                  - SVMXC__Site__c 
Created Date                 - 04-Oct-2016
*/


public with sharing class GE_OG_SVMXC_LocationHelper{

ID WellRectype=Schema.SObjectType.SVMXC__Site__c.getRecordTypeInfosByName().get('Well').getRecordTypeId(); 

 public void updateLocation(List<SVMXC__Site__c> lstLocs){

 Map<String,String> mapcountryreg = new Map<String,String>();

 // Get a list of Country Region Mapping Custom Setting values 
    List<Country_Region_Mapping_ge_og__c> lstcountyregmap = Country_Region_Mapping_ge_og__c.getAll().values();   

 // create a map of Country mapped with Region from Country Region Custom Setting List 

    for(Country_Region_Mapping_ge_og__c country : lstcountyregmap)
    {
        mapcountryreg.put(country.country_name_ge_og__c.ToUpperCase(),country.region_ge_og__c);
    }
  
 for(SVMXC__Site__c loc:lstLocs)
  {
      //if(loc.GE_PC_Well__c=true && loc.SVMXC__Country__c!= NULL && loc.SVMXC__Country__c!='')
      if((loc.GE_PC_Well__c==true || loc.GE_DTS__c==true) && loc.SVMXC__Country__c!= NULL && loc.SVMXC__Country__c!='')
      {    
        loc.GE_OG_Region__c = mapcountryreg.get((loc.SVMXC__Country__c).ToUpperCase());       
      }
  }    
 
 }
}