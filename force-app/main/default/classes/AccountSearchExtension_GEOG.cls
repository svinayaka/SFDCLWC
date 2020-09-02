public with sharing class AccountSearchExtension_GEOG 
{
    public string searchtext {get;set;}
    public List<Account> lstAccount {get;set;}
    public Account acc{get; set;}
    public Map<String, country_region_mapping_ge_og__c> countries= country_region_mapping_ge_og__c.getAll();
  
    private integer totalRecs = 0;     
    private integer index = 0;
    private integer blockSize = 50;
    public String selectedRegion{get;set;}    
    public String selectedCountry {get;set;}
    public List<selectOption> allCountry {get;set;}
    public boolean isCommercialAccount{get;set;}
    // Constructor of the class
    public AccountSearchExtension_GEOG(ApexPages.StandardController controller) 
    {
        searchtext = '';
        lstAccount = new List<Account>();
        isCommercialAccount = false;
        // LIMIT 2000 since max offset allowed is 2000
        totalRecs = [select count() from Account LIMIT 2000];
        fetchAllCountry();
        
    }
    Map<String, List<String>> MapRegionCountry;
    public void fetchAllCountry()
    {
        allCountry = new List<selectOption>();
        MapRegionCountry = new Map<String, List<String>>();
        //List<country_region_mapping_ge_og__c> listCodes = country_region_mapping_ge_og__c.getAll().values();
        List<country_region_mapping_ge_og__c> listCodes = [SELECT Id, country_name_ge_og__c, iso_code_ge_og__c, region_ge_og__c, status_ge_og__c FROM country_region_mapping_ge_og__c ORDER BY country_name_ge_og__c];      
        system.debug('===='+listCodes);
        allCountry.add(new SelectOption('None', 'None'));
         
        for(country_region_mapping_ge_og__c crm : listCodes){
            allCountry.add(new SelectOption(crm.country_name_ge_og__c,crm.country_name_ge_og__c));
            
            system.debug('===='+crm.region_ge_og__c);
            system.debug('===='+crm.country_name_ge_og__c);
            
            if(MapRegionCountry!=null && MapRegionCountry.get(crm.region_ge_og__c)!=null){
                MapRegionCountry.get(crm.region_ge_og__c).add(crm.country_name_ge_og__c);
            }
            else{
                List<String> lstCountry = new List<String>();
                lstCountry.add(crm.country_name_ge_og__c);
                MapRegionCountry.put(crm.region_ge_og__c, lstCountry);
            }   
        }
    }
    
    public pagereference search()
    {
        isCommercialAccount = true;
        system.debug('----blockSize-->>>>>>>'+blockSize );
        searchtext = searchtext + '*';
        for(String strRegion:MapRegionCountry.Keyset()){
         for(String strCountry : MapRegionCountry.get(strRegion)){
            if(strCountry == selectedCountry){
                selectedRegion = strRegion;
                break;
            }
         }
        }
        System.debug('------selectedRegion---'+selectedRegion);
        if(!Test.isRunningTest()){
        lstAccount  = [FIND: searchtext  IN NAME FIELDS RETURNING 
                         Account (Id, Name, Type, Classification__c, Owner.Name,Country_GEOG__c, GE_HQ_New_Account_Country__c, Region_GEOG__c, recordtype.name,Account_Tier_GEOG__c WHERE (Recordtype.Name = 'Relationship Account' AND (Account_Tier_GEOG__c = 'Country' OR Account_Tier_GEOG__c = 'Regional') AND (Region_GEOG__c =: selectedRegion or Country_GEOG__c = :selectedCountry))  LIMIT :blockSize OFFSET :index) ][0];
        searchtext = searchtext.subString(0,searchtext.length() - 1);
         }
         else{
         lstAccount  = [FIND: searchtext  IN NAME FIELDS RETURNING 
                         Account (Id, Name, Type, Classification__c, Owner.Name,Country_GEOG__c, GE_HQ_New_Account_Country__c, Region_GEOG__c, recordtype.name,Account_Tier_GEOG__c WHERE (Recordtype.Name = 'Relationship Account' AND (Account_Tier_GEOG__c = 'Country' OR Account_Tier_GEOG__c = 'Regional') AND (Region_GEOG__c =: selectedRegion or Country_GEOG__c = :selectedCountry)))][0];
        
         
        System.debug('******************'+lstAccount);       
        // Remove '*' 
        searchtext = searchtext.subString(0,searchtext.length() - 1);
      }
        
        return null;
        
    }
    
    public pagereference newacc(){
       return null;
    }
    
    public pagereference AddCntryAcc(){
       return null;
    }
    
    public pagereference selectAcc(){
       return null;
    }
    
    public void beginning()
    {
        index = 0;
        search();
    }
    
    public void previous()
    {
        index = index - blockSize;
        search();
    }
    
    public void next()
    {
        index = index + blockSize;
        search();
    }

    public void end()
    {
        index = totalrecs - math.mod(totalRecs,blockSize);
        search();
    }        
    
    public boolean getprev()
    {
        if(index == 0)
        return true;
        else
        return false;
    }  
    
    public boolean getnxt()
    {
        totalRecs =  lstAccount.size();
        if((index + blockSize) > totalRecs)
        return true;
        else
        return false;
    }   
}