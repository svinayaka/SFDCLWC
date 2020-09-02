public class AddNewAccountExt_GEOG{

    public Account acc{get;set;}
    public Contact con{get;set;}
        
    public String selectedCountry {get;set;}
    public List<selectOption> allCountry {get;set;}
    public String selectedRegion {get;set;}
    public List<selectOption> allRegion {get;set;}
    public Account fetchacc{get;set;} 
    pageReference pg;
    public boolean isEdit{get;set;}

    public AddNewAccountExt_GEOG(ApexPages.StandardController controller) 
    {
        acc = new account();
        con = new contact();
        fetchacc = new account();
        fetchAllCountry();
        isEdit = true;
        Id devRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
        if(String.IsBlank(ApexPages.currentPage().getParameters().get('id'))){
            if(!String.IsBlank(ApexPages.currentPage().getParameters().get('name')))
            {
               acc.Name = ApexPages.currentPage().getParameters().get('name');
            }
            
            if(!String.IsBlank(ApexPages.currentPage().getParameters().get('region')))
            {
               selectedRegion= ApexPages.currentPage().getParameters().get('region');
            }
            if(!String.IsBlank(ApexPages.currentPage().getParameters().get('Country')))
            {
               selectedCountry= ApexPages.currentPage().getParameters().get('Country');
            }
            isEdit = true;
            acc.Name = ApexPages.currentPage().getParameters().get('name');
        }
        else{
            isEdit = false;
            String accId = ApexPages.currentPage().getParameters().get('id');
            fetchacc = [Select Id, Name, Type, Classification__c, Owner.Name,Country_GEOG__c, ParentId, Member_of_GE_OG__c, Member_of_GE_OG__r.Name, GE_HQ_New_Account_Country__c, Region_GEOG__c, recordtype.name,Account_Tier_GEOG__c from Account WHERE id =:accId];
            System.debug('=============='+fetchacc);
            System.debug('=============='+fetchacc.Classification__c);
            acc.Classification__c = fetchacc.Classification__c;
            acc.Type = fetchacc.Type;
            acc.Member_of_GE_OG__c = fetchacc.Member_of_GE_OG__c;
            acc.ParentId = ApexPages.currentPage().getParameters().get('id');
            
            if(fetchacc.Member_of_GE_OG__r.Name.lastIndexOf('/ HQ')!=-1){
                acc.Name = fetchacc.Member_of_GE_OG__r.Name.Substring(0, fetchacc.Member_of_GE_OG__r.Name.lastIndexOf('/ HQ'));
            }
            else{
                acc.Name = fetchacc.Member_of_GE_OG__r.Name; 
            }
        }
        selectedRegion = ApexPages.currentPage().getParameters().get('region');
        selectedCountry = ApexPages.currentPage().getParameters().get('Country');
        
        acc.Account_Tier_GEOG__c = 'Country'; 
        acc.RecordTypeId = devRecordTypeId;
            
    }
    Map<String, List<String>> MapRegionCountry;
    public void fetchAllCountry()
    {
        allRegion = new List<selectOption>();
        allCountry = new List<selectOption>();
        MapRegionCountry = new Map<String, List<String>>();
        List<country_region_mapping_ge_og__c> listCodes = country_region_mapping_ge_og__c.getAll().values(); 
        system.debug('===='+listCodes);
        allCountry.add(new SelectOption('None','None'));
        for(country_region_mapping_ge_og__c crm : listCodes){
            if(crm.region_ge_og__c == ApexPages.currentPage().getParameters().get('region')){
                allCountry.add(new SelectOption(crm.country_name_ge_og__c,crm.country_name_ge_og__c));
            }
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
        for(String reg : MapRegionCountry.KeySet()){
            allRegion.add(new SelectOption(reg, reg));
        }
        //allRegion.add(MapRegionCountry.KeySet());
    }
    
    public pageReference Save() {
        
        try{
            //acc.Name = acc.Name  +' / '+selectedCountry;
            acc.Region_GEOG__c = selectedRegion;
            acc.Country_GEOG__c=selectedCountry;
            acc.Is_Created_From_Deal_Machine__c = true;
            system.debug('name boefore insert   '+acc.name);
            insert acc;
            
            list<Contact> lstcon = new list<Contact>([Select Id from contact where email=:con.Email]);
            
            if(lstcon!=null && lstcon.size()>0){
                    ContactAccountSharing__c objConAcc = new ContactAccountSharing__c(Account_GEOG__c=acc.Id, Contact_GEOG__c=lstcon[0].Id, Primary_Contact_GE_OG__c=true);
                    insert objConAcc;
            }
            else{
                con.accountId = acc.Id;
                con.GE_PRM_Primary_Contact__c = true;
                insert con;
            }
        }
        catch(Exception e){
            Apexpages.addMessage(new Apexpages.message(ApexPages.Severity.Error, e.getMessage()));
            return null;
        }
        return new pageReference('/'+acc.Id);
    }
    
    public pageReference Cancel() {
        pg = new pageReference('/001/o');
        return pg;
    }
}