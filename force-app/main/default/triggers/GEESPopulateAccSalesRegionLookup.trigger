trigger GEESPopulateAccSalesRegionLookup on Account (before insert, before update) {

  //Code to skip trigger

    OG_Trigger_fire_Decision__c lstObj = OG_Trigger_fire_Decision__c.getValues('GEESPopulateAccSalesRegionLookup');
       
    if(lstObj!=null && lstObj.isActive__c == true && lstObj.Object_Name__c=='Account'){
     
        return;  
    }
    else{
    
    /*
    Description: Populates the Sales Region lookup field on Account based on information stored in the GE_ES_Country_State_Sales_Region__c
    configuration table.  Also uses a Custom Label called "RP_CountryWithStates" to determine whether the GE_HQ_Country_Code__c specified on the
    Account is one that uses States to determine the Region or not
    */
    
    List<Account> accountsToProcess = new List<Account>();
    
    Set<String> countryWithState = new Set<String>();
        
    Set<String> country_stList = new Set<String>();
    
    for (Account a : trigger.new) {
       
        
        if (a.GE_HQ_Country_Code__c == null)
            continue;
                           
        if (trigger.isInsert){
        
        if (a.GE_HQ_Country_Code__c != null){
        for(String s : Label.RP_CountryWithStates.split(';')) 
        {
            countryWithState.add(s.toUpperCase());
        }
    
        system.debug('\n\n\n\n\n\n' + countryWithState);


        if(countryWithState.contains(a.GE_HQ_Country_Code__c.toUpperCase())) {
            if (a.ShippingState == null)
                country_stList.add(a.GE_HQ_Country_Code__c.toUpperCase());
            else
                country_stList.add(a.GE_HQ_Country_Code__c.toUpperCase()+'_'+a.ShippingState.toUpperCase());
        } else {
            country_stList.add(a.GE_HQ_Country_Code__c.toUpperCase());
        }   
   
        accountsToProcess.add(a);
        system.debug('\n\n\n\n\n\n' + country_stList);

        }
            
        }
        else if(trigger.isUpdate){
        if(((a.GE_HQ_Country_Code__c != null) && (trigger.oldmap.get(a.Id).GE_HQ_Country_Code__c != a.GE_HQ_Country_Code__c))
         || ((a.ShippingState != null) && (trigger.oldmap.get(a.Id).ShippingState != a.ShippingState))){
for(String s : Label.RP_CountryWithStates.split(';')) 
        {
            countryWithState.add(s.toUpperCase());
        }
    
        system.debug('\n\n\n\n\n\n' + countryWithState);

      if(countryWithState.contains(a.GE_HQ_Country_Code__c.toUpperCase())) {
            if (a.ShippingState == null)
                country_stList.add(a.GE_HQ_Country_Code__c.toUpperCase());
            else
                country_stList.add(a.GE_HQ_Country_Code__c.toUpperCase()+'_'+a.ShippingState.toUpperCase());
        } else {
            country_stList.add(a.GE_HQ_Country_Code__c.toUpperCase());
        }   
   
        accountsToProcess.add(a);
            system.debug('\n\n\n\n\n\n' + country_stList);

        }

        }
    }
        
    
    if (accountsToProcess.size() > 0) {    
        Map<String,Id> coutryStToRegion = new Map<String,Id>();
        Map<String,Id> coutryStToSubRegion = new Map<String,Id>(); /* Added by Jayaraju Nulakachandanam */
        for (GE_ES_Country_State_Sales_Region__c coStRegion : [SELECT GE_ES_Country_Name__c, GE_ES_Country_State__c, GE_ES_Sales_Region__c, GE_ES_Sub_Region__c, GE_ES_State_Provence__c FROM GE_ES_Country_State_Sales_Region__c where GE_ES_Country_State__c in :country_stList]) {
            coutryStToRegion.put(coStRegion.GE_ES_Country_State__c, coStRegion.GE_ES_Sales_Region__c);
            coutryStToSubRegion.put(coStRegion.GE_ES_Country_State__c, coStRegion.GE_ES_Sub_Region__c); /* Added by Jayaraju Nulakachandanam */

        }
        
        system.debug('\n\n\n\n\n\n' + coutryStToRegion);
        
        for (Account a : accountsToProcess) {           
            String s;
            if (countryWithState.contains(a.GE_HQ_Country_Code__c.toUpperCase())) { //this is a country with states
                s = a.GE_HQ_Country_Code__c+'_'+a.ShippingState;
            } else {
                s = a.GE_HQ_Country_Code__c;
            }
     System.debug('value of s--->'+s);
            if(s != null) {
                s = s.toUpperCase();            
                if (trigger.isInsert) {
                    a.GE_ES_Sales_Region__c = coutryStToRegion.get(s);
                    a.GE_ES_Sub_Region__c = coutryStToSubRegion.get(s); /* Added by Jayaraju Nulakachandanam */

                } else if (trigger.isUpdate && (trigger.oldmap.get(a.Id).GE_HQ_Country_Code__c != a.GE_HQ_Country_Code__c  || trigger.oldmap.get(a.Id).ShippingState != a.ShippingState)) {
                    a.GE_ES_Sales_Region__c = coutryStToRegion.get(s);
                    a.GE_ES_Sub_Region__c = coutryStToSubRegion.get(s); /* Added by Jayaraju Nulakachandanam */
                                   }
            } else {
                a.GE_ES_Sales_Region__c = null;
                a.GE_ES_Sub_Region__c = null; /* Added by Jayaraju Nulakachandanam */
                System.debug('No matching Sales Region found for the Country/State'+a.GE_HQ_Country_Code__c+'/'+a.ShippingState);
            } 
        }
    }
}
}