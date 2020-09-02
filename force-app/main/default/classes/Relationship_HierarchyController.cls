public class Relationship_HierarchyController{

    public String strAccId1 {get; set;}
    public String strAccName1  {get; set;}
    public String strCountry1 {get; set;}
    
    public String strAccId2 {get; set;}
    public String strAccName2  {get; set;}
    
    public String strAccId3 {get; set;}
    public String strAccName3  {get; set;}
    
    public List<selectOption> allCountry {get; set;}
    public List<selectOption> allRegion {get; set;}
    Map<String, List<String>>  MapRegionCountry = new Map<String, List<String>>();
    public String selectedCountry {get;set;}
    public String selectedRegion {get;set;}
    public List<Account> lstAccountResult {get; set;}
    public String strSlectedId {get; set;}
    public Boolean isCountry {get; set;}
    public Boolean isRegional {get; set;}
    public Boolean isGlobal {get; set;}
    public List<Account> lstCountryFinal {get; set;}
    public List<Account> lstRegionalFinal {get; set;}
    public List<Account> lstHQFinal {get; set;}
    
    public String strType {get; set;}
    public String strClassification {get; set;}
    public Boolean isLinkable {get; set;}
    public Account acc{get;set;}
    //public Contact con{get;set;}
    public Boolean isCountryCreated {get; set;}
    
    public Relationship_HierarchyController() {
        lstCountryFinal = new List<Account>();
        lstRegionalFinal = new List<Account>();
        lstHQFinal = new List<Account>();
        isCountry = false;
        isRegional = false;
        isGlobal = false;
        isLinkable = false;
        acc = new Account();
        //con = new Contact();
        strSlectedId = '';
        fetchAllCountry();
    }
    
    public void fetchAllCountry()
    {
        allRegion = new List<selectOption>();
        allCountry = new List<selectOption>();
        MapRegionCountry = new Map<String, List<String>>();
        List<country_region_mapping_ge_og__c> listCodes = country_region_mapping_ge_og__c.getAll().values();
       // listCodes.sort(); 
        system.debug('===='+listCodes);
        allCountry.add(new SelectOption('None','None'));
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
        for(String reg : MapRegionCountry.KeySet()){
            allRegion.add(new SelectOption(reg, reg));
        }
        system.debug('aaaallll country '+allCountry);
    }

    public PageReference seacrchForCountry(){
        String strLikeFilter = '%'+strAccName1+'%';
        String strQuery = ''; 
        String strRelationship = 'Relationship Account';  
        String strCountry = 'Country'; 
        String strCompetitor = 'Competitor';             
        if(strAccId1 != ''){
            strQuery = 'SELECT Id, Name, Type, Classification__c, Parent.Name,Owner.Name,Member_of_GE_OG__r.Name, Country_GEOG__c, GE_HQ_New_Account_Country__c, Region_GEOG__c, recordtype.name,Account_Tier_GEOG__c,Commercial_Account_IsDormant_GEOG__c, GE_OG_Primary_Sales__c FROM Account WHERE Id =\''+strAccId1 +'\' AND recordtype.Name = \''+strRelationship+'\' AND Account_Tier_GEOG__c=\''+strCountry+'\' AND Type!= \''+strCompetitor+'\' LIMIT 1';
        }   
        if(strAccName1 != '') {
            strQuery = 'SELECT Id, Name, Type, Classification__c, Parent.Name, Owner.Name,Member_of_GE_OG__r.Name, Country_GEOG__c, GE_HQ_New_Account_Country__c, Region_GEOG__c, recordtype.name,Account_Tier_GEOG__c,Commercial_Account_IsDormant_GEOG__c, GE_OG_Primary_Sales__c FROM Account WHERE Name LIKE \''+ strLikeFilter +'\' AND recordtype.Name = \''+strRelationship+'\' AND Account_Tier_GEOG__c=\''+strCountry+'\' AND Type!= \''+strCompetitor+'\' LIMIT 50000';
        }                   
        if(strCountry1 != '' && strCountry1 != null){
            strQuery = 'SELECT Id, Name, Type, Classification__c, Parent.Name, Owner.Name,Member_of_GE_OG__r.Name,Country_GEOG__c, GE_HQ_New_Account_Country__c, Region_GEOG__c, recordtype.name,Account_Tier_GEOG__c,Commercial_Account_IsDormant_GEOG__c,GE_OG_Primary_Sales__c FROM Account WHERE Country_GEOG__c = \''+strCountry1+'\' AND Name LIKE \''+ strLikeFilter +'\' AND recordtype.Name = \''+strRelationship+'\' AND Account_Tier_GEOG__c=\''+strCountry+'\' AND Type!= \''+strCompetitor+'\' LIMIT 50000';
        }
        lstAccountResult = Database.query(strQuery);
        PageReference pgRef = new PageReference('/apex/RelationHierachy_SearchResults?tier=Country');
        pgRef.setRedirect(false);
        return pgRef;
    }
    
    
    public PageReference seacrchForRegion(){
        String strLikeFilter = '%'+strAccName2+'%';
        String strQuery = ''; 
        String strRelationship = 'Relationship Account';  
        String strCountry = 'Regional';
        String strCompetitor = 'Competitor';              
        if(strAccId2 != ''){
            strQuery = 'SELECT Id, Name, Type, Parent.Name,Owner.Name,Member_of_GE_OG__r.Name, Classification__c, Country_GEOG__c, GE_HQ_New_Account_Country__c, Region_GEOG__c, recordtype.name,Account_Tier_GEOG__c, Commercial_Account_IsDormant_GEOG__c,GE_OG_Primary_Sales__c FROM Account WHERE Id =\''+strAccId2 +'\' AND recordtype.Name = \''+strRelationship+'\' AND Account_Tier_GEOG__c=\''+strCountry+'\' AND Type!= \''+strCompetitor+'\' LIMIT 1';
        }   
        if(strAccName2 != '') {
            strQuery = 'SELECT Id, Name, Type, Parent.Name,Owner.Name,Member_of_GE_OG__r.Name, Classification__c, Country_GEOG__c, GE_HQ_New_Account_Country__c, Region_GEOG__c, recordtype.name,Account_Tier_GEOG__c, Commercial_Account_IsDormant_GEOG__c,GE_OG_Primary_Sales__c FROM Account WHERE Name LIKE \''+ strLikeFilter +'\' AND recordtype.Name = \''+strRelationship+'\' AND Account_Tier_GEOG__c=\''+strCountry+'\' AND Type!= \''+strCompetitor+'\' LIMIT 50000';
        }                   
        lstAccountResult = Database.query(strQuery);
        PageReference pgRef = new PageReference('/apex/RelationHierachy_SearchResults?tier=Regional');
        pgRef.setRedirect(false);
        return pgRef;
    }
    
    public PageReference seacrchForHQ(){
        String strLikeFilter = '%'+strAccName3+'%';
        String strQuery = ''; 
        String strRelationship = 'Relationship Account';  
        String strCountry = 'Global'; 
        String strCompetitor = 'Competitor';             
        if(strAccId3 != ''){
            strQuery = 'SELECT Id, Name, Type, Parent.Name, Member_of_GE_OG__r.Name, Classification__c, Owner.Name,Country_GEOG__c, GE_HQ_New_Account_Country__c, Region_GEOG__c, recordtype.name,Account_Tier_GEOG__c, Commercial_Account_IsDormant_GEOG__c,GE_OG_Primary_Sales__c FROM Account WHERE Id =\''+strAccId3 +'\' AND recordtype.Name = \''+strRelationship+'\' AND Account_Tier_GEOG__c=\''+strCountry+'\' AND Type!= \''+strCompetitor+'\' LIMIT 1';
        }   
        if(strAccName3 != '') {
            strQuery = 'SELECT Id, Name, Type, Parent.Name, Member_of_GE_OG__r.Name, Classification__c, Owner.Name,Country_GEOG__c, GE_HQ_New_Account_Country__c, Region_GEOG__c, recordtype.name,Account_Tier_GEOG__c, Commercial_Account_IsDormant_GEOG__c,GE_OG_Primary_Sales__c FROM Account WHERE Name LIKE \''+ strLikeFilter +'\' AND recordtype.Name = \''+strRelationship+'\' AND Account_Tier_GEOG__c=\''+strCountry+'\' AND Type!= \''+strCompetitor+'\' LIMIT 50000';
        } 
        lstAccountResult = Database.query(strQuery); 
        PageReference pgRef = new PageReference('/apex/RelationHierachy_SearchResults?tier=Global');
        pgRef.setRedirect(false);
        return pgRef;
    }
    
    public PageReference processSelectedAccount(){
        String strTier = ApexPages.CurrentPage().getParameters().get('tier');  
        List<Account> lstSelectedAccount = new List<Account>();
        List<Account> lstRegional = new List<Account>();
        List<Account> lstHQ = new List<Account>();
        system.debug('selected id  '+strSlectedId); 
        if(strSlectedId != '' && strSlectedId != null){
           lstSelectedAccount = [select Id, Name, Type, ParentId, Parent.Name,Member_of_GE_OG__r.Name, Classification__c, Owner.Name,GE_OG_Primary_Sales__c, Commercial_Account_IsDormant_GEOG__c, Country_GEOG__c, GE_HQ_New_Account_Country__c, Region_GEOG__c, recordtype.name,Account_Tier_GEOG__c
                                FROM Account WHERE Id=: strSlectedId 
                                LIMIT 1];
        }
        if(strTier == 'Country' && lstSelectedAccount.size() > 0){
            isCountry = true;
            lstRegional = [select Id, Name, Type, ParentId, Parent.Name,Member_of_GE_OG__r.Name,Classification__c, Owner.Name,GE_OG_Primary_Sales__c, Commercial_Account_IsDormant_GEOG__c, Country_GEOG__c, GE_HQ_New_Account_Country__c, Region_GEOG__c, recordtype.name,Account_Tier_GEOG__c
                            FROM Account WHERE Id=: lstSelectedAccount[0].parentId
                            LIMIT 1];
            if(lstRegional.size() > 0){
                isRegional = true;
                lstHQ = [select Id, Name, Type, ParentId, Parent.Name,Member_of_GE_OG__r.Name, Classification__c, Owner.Name,GE_OG_Primary_Sales__c, Commercial_Account_IsDormant_GEOG__c, Country_GEOG__c, GE_HQ_New_Account_Country__c, Region_GEOG__c, recordtype.name,Account_Tier_GEOG__c
                            FROM Account WHERE Id=: lstRegional[0].parentId
                            LIMIT 1];
                if(lstHQ.size() > 0){
                    isGlobal = true;
                }
                else{
                    isGlobal = false;
                }
            }
            else{
                isRegional = false;
            }
            lstCountryFinal = lstSelectedAccount;
            lstRegionalFinal = lstRegional;
            lstHQFinal = lstHQ;
        }
        else if(strTier == 'Regional' && lstSelectedAccount.size() > 0){
            isRegional = true;
            lstHQ = [select Id, Name, Type, ParentId, Parent.Name,Member_of_GE_OG__r.Name, Classification__c, Owner.Name,GE_OG_Primary_Sales__c, Commercial_Account_IsDormant_GEOG__c , Country_GEOG__c, GE_HQ_New_Account_Country__c, Region_GEOG__c, recordtype.name,Account_Tier_GEOG__c
                            FROM Account WHERE Id=: lstSelectedAccount[0].parentId
                            LIMIT 1];
            if(lstHQ.size() > 0){
                    isGlobal = true;
            }        
            lstRegionalFinal = lstSelectedAccount;
            lstHQFinal = lstHQ;
        }
        else if(strTier == 'Global' && lstSelectedAccount.size() > 0){
            isGlobal = true;
            lstHQFinal = lstSelectedAccount;
        }
        if((lstRegionalFinal.size() <0 && lstHQFinal.size() < 0) ||(lstCountryFinal.size() <0 && lstHQFinal.size() < 0) || (lstRegionalFinal.size() <0 && lstCountryFinal.size() < 0)){
            isLinkable = false;
        }
        else{
            isLinkable = true;
        }
        PageReference prRef1 = new PageReference('/apex/Relationship_Hierarchy?tier='+strTier);
        prRef1.setRedirect(false);
        return prRef1;
    }
    
    public PageReference linkSelectedAccount(){
        List<Account> lstToUpdate = new List<Account>();
        String regionalName = '';
        String hqName = '';
        Integer count1 = 0;
        Integer count2 = 0;
        if(lstRegionalFinal.size() > 0){
           List<String> lstString = lstRegionalFinal[0].name.split('/');
           for(String objStr: lstString){
               if(count1 < lstString.size()-1){
                   regionalName += regionalName+objStr;
                   count1++;
               }
           }
        }
        if(lstHQFinal.size() > 0){
            List<String> lstString = lstHQFinal[0].name.split('/');
            for(String objStr: lstString){
               if(count2 < lstString.size()-1){
                   hqName += hqName+objStr;
                   count2++;
               }
            }
        }
        if(isCountry && isRegional){
            Account objCountry = lstCountryFinal[0];
            Account objRegion = new Account();
            if(lstRegionalFinal.size() == 1){
                objCountry.parentId = lstRegionalFinal[0].id;
                objCountry.name = regionalName + ' / '+ objCountry.Country_GEOG__c;
                objCountry.Classification__c = lstRegionalFinal[0].Classification__c;
                objCountry.Type = lstRegionalFinal[0].Type;
                objRegion = lstRegionalFinal[0];
            }
            if(lstHQFinal.size() == 1){
                objCountry.Member_of_GE_OG__c = lstHQFinal[0].id;
                objRegion.parentID = lstHQFinal[0].id;
                objRegion.name = hqName  + ' / '+ objRegion.Region_GEOG__c;
                objRegion.Classification__c = lstHQFinal[0].Classification__c;
                objRegion.Type = lstHQFinal[0].Type;
                objRegion.Member_of_GE_OG__c = lstHQFinal[0].id;
                
                objCountry.name = hqName + ' / '+ objCountry.Country_GEOG__c;
                objCountry.Classification__c = lstHQFinal[0].Classification__c;
                objCountry.Type = lstHQFinal[0].Type;
            }
            lstToUpdate.add(objCountry);
            lstToUpdate.add(objRegion);
        }
        else if(!isCountry && isRegional && isGlobal){
            Account objRegion = new Account();
            if(lstRegionalFinal.size() == 1){
               objRegion = lstRegionalFinal[0]; 
               if(lstHQFinal.size() == 1){
                   objRegion.name = hqName  + ' / '+objRegion.Region_GEOG__c;
                   objRegion.Member_of_GE_OG__c = lstHQFinal[0].id;
                   objRegion.Classification__c = lstHQFinal[0].Classification__c;
                   objRegion.Type = lstHQFinal[0].Type;
                   objRegion.parentId = lstHQFinal[0].id;
               }
            }
            lstToUpdate.add(objRegion);
        }
        else if(isCountry && isGlobal && !isRegional){
            Account objCountry = lstHQFinal[0];
            objCountry.Member_of_GE_OG__c = lstHQFinal[0].id;
            objCountry.name = hqName + ' / '+objCountry.Country_GEOG__c;
            objCountry.Classification__c = lstHQFinal[0].Classification__c;
            objCountry.Type = lstHQFinal[0].Type;
            lstToUpdate.add(objCountry);
        }
        if(!lstToUpdate.isEmpty()){
          try{
              update lstToUpdate;
          }
          catch(Exception e){
              system.debug('Exception while updating the accounts.... '+e.getMessage());
          }  
        }
        PageReference pgRef = new PageReference('/'+lstCountryFinal[0].id);
        return pgRef;
    }
    
    public PageReference goBack(){
        String strTier = ApexPages.CurrentPage().getParameters().get('tier'); 
        PageReference prRef1 = new PageReference('/apex/Relationship_Hierarchy?tier='+strTier);
        prRef1.setRedirect(false);
        return prRef1;
    }
    
    public PageReference createRelationshipAccount(){
        String strTier = ApexPages.CurrentPage().getParameters().get('tier');
        Id RelationshipRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
        try{
            acc.RecordTypeId = RelationshipRecordTypeId;
            if(strTier == 'Country'){
                acc.name += ' / '+ +selectedCountry;
            }
            else if(strTier == 'Regional'){
                acc.name += ' / '+ +selectedRegion;
                acc.Region_GEOG__c = selectedRegion;
            }
            else if(strTier == 'Global'){
                acc.name += ' / HQ';
            }
            insert acc;
            acc = [select Id, Name, Type, ParentId, Parent.Name,ownerId,Member_of_GE_OG__r.Name, Classification__c, Owner.Name,GE_OG_Primary_Sales__c, Commercial_Account_IsDormant_GEOG__c , Country_GEOG__c, GE_HQ_New_Account_Country__c, Region_GEOG__c, recordtype.name,Account_Tier_GEOG__c
                    FROM Account WHERE Id=: acc.id
                    LIMIT 1];
            system.debug('accccc details.... '+acc);
            system.debug('owner name '+acc.GE_OG_Primary_Sales__c);
            /*if(acc.id != null){
                insert con;
            }*/
        }
        catch(Exception e){
            system.debug('Exception while inserting account or contact.... '+e.getMessage());
        }
        if(strTier == 'Country'){
            isCountry = true;
            lstCountryFinal = new List<Account>();
            lstCountryFinal.add(acc);
        }
        else if(strTier == 'Regional'){
            isRegional = true;
            lstRegionalFinal = new List<Account>();
            lstRegionalFinal.add(acc);
        }
        else if(strTier == 'Global'){
            isGlobal = true;
            lstHQFinal = new List<Account>();
            lstHQFinal.add(acc);
        }
        system.debug('ist country '+lstCountryFinal);
        system.debug('list region '+lstRegionalFinal);
        system.debug('list HQ '+lstHQFinal);
        if((lstRegionalFinal.size() <0 && lstHQFinal.size() < 0) ||(lstCountryFinal.size() <0 && lstHQFinal.size() < 0) || (lstRegionalFinal.size() <0 && lstCountryFinal.size() < 0)){
            isLinkable = false;
        }
        else{
            isLinkable = true;
        }
        PageReference prRef1 = new PageReference('/apex/Relationship_Hierarchy?tier='+strTier);
        prRef1.setRedirect(false);
        return prRef1;
    }
    
    public PageReference populateValuesCountry(){
        acc = new Account();
        //con = new Contact();
        acc.Account_Tier_GEOG__c = 'Country';
        acc.name = strAccName1;
        acc.Country_GEOG__c = selectedCountry;
        system.debug('select country... '+selectedCountry);
        List<country_region_mapping_ge_og__c> lstRegions = [SELECT name, country_name_ge_og__c, region_ge_og__c
                             FROM country_region_mapping_ge_og__c where country_name_ge_og__c =: selectedCountry
                             LIMIT 1];
        acc.Region_GEOG__c = lstRegions[0].region_ge_og__c;
        selectedRegion = lstRegions[0].region_ge_og__c;
        PageReference prRef1 = new PageReference('/apex/CreateAccount?tier=Country');
        prRef1.setRedirect(false);
        return prRef1;
    }
    
    public PageReference populateValuesRegion(){
        isCountryCreated = false;
        if(acc != null && acc.Country_GEOG__c != null){
           isCountryCreated = true; 
        }
        acc = new Account();
        //con = new Contact();
        acc.Account_Tier_GEOG__c = 'Regional';
        acc.name = strAccName2;
        if(isCountryCreated){
            acc.Region_GEOG__c = selectedRegion;
        }
        acc.Region_GEOG__c = selectedRegion;
        PageReference prRef1 = new PageReference('/apex/CreateAccount?tier=Regional');
        prRef1.setRedirect(false);
        return prRef1;
    }
    
    public PageReference populateValuesHQ(){
        acc = new Account();
        //con = new Contact();
        acc.Account_Tier_GEOG__c = 'Global';
        acc.name = strAccName3;
        PageReference prRef1 = new PageReference('/apex/CreateAccount?tier=Global');
        prRef1.setRedirect(false);
        return prRef1;
    }
}