public with sharing class GE_OG_Mobilization_Detail {

    public String ListOfCntrs { get; set; }

    public String getListOfCntrs() {
        return null;
    }

public void regionKeyPlayerCall(){}
private integer totalRecs = 0;
private integer OffsetSize = 0;
private integer LimitSize= 2;
public string countries1{get;set;}
public string countries{get;set;}
public string uppercountr{get;set;}
public string getURL{get;set;}
public boolean fpage{get;set;}
public boolean ppage{get;set;}
public boolean npage{get;set;}
public boolean lpage{get;set;}
public List<GE_HQ_Country__c> country1{get;set;}
//public GE_OG_Legal_Entity_Deal_Structure__c Legal_Entity_Deal{get;set;}
public list<GE_OG_Legal_Entity_Deal_Structure__c > Legal_Entity_Deal{get;set;}
public list<GE_OG_CountryMob__c > Country_Highlight{get;set;}
public list<GE_OG_Primary_Contacts__c >Primary_Contact {get;set;}
Public list <GE_HQ_Country__c> countrylist{get;set;}
List<GE_OG_Legal_Entity_Deal_Structure__c> acc{get;set;}

  public GE_OG_Mobilization_Detail(ApexPages.StandardController controller) {
  countries1=APexPages.currentPage().getParameters().get('countrys');
  System.debug('countries are------------'+countries1);
  country1=[select Id,Name from GE_HQ_Country__c where GE_HQ_ISO_Code__c=:countries1];
    if(country1.size() > 0){
  countries=country1[0].Name;
  System.debug('countries are------------'+countries);
  uppercountr = countries.touppercase();
  System.debug('countries are------------'+uppercountr);
  }
   countrylist= [select id,name,GE_OG_Finance_Country_Risk__c,GE_OG_Tax_ID_Format__c from GE_HQ_Country__c where name=:countries];
   System.debug('countrylist is----------'+countrylist);
   System.debug('countrylist is1----------'+countrylist.size());
   if (countrylist.size() > 0)
   {
  totalRecs = [select count() from GE_OG_Legal_Entity_Deal_Structure__c where CountryMobName__c=: countrylist[0].id];
  System.debug('--------------legal'+countrylist[0].id);
     Legal_Entity_Deal = [select Legal_Entity__c, POA_Holder__c,SSO__c from GE_OG_Legal_Entity_Deal_Structure__c where CountryMobName__c=: countrylist[0].id];
     System.debug('--------------legal'+countrylist[0].id);
      Country_Highlight = [select Country_Highlights__c,Country_guideline__c from GE_OG_CountryMob__c where CountryMobName__c=: countrylist[0].id];   
      Primary_Contact = [select  Contact_Number__c, Function__c,Name, Location__c from GE_OG_Primary_Contacts__c where CountryMobName__c=: countrylist[0].id];
      }
   if (countrylist.size() > 0 && Country_Highlight.size() > 0)
   {   
      getURL = Country_Highlight[0].Country_guideline__c ;
      }
 }
 

public String selectedCntryId  {set;get;}
public List<SelectOption> UserOptionList;
      
      //This var hold List of user
      public List<SelectOption> getListOfCntrs1()
    {
               //AggregateResult[] Cntrs = [select CountryMobName__r.name from GE_OG_Legal_Entity_Deal_Structure__c group by CountryMobName__r.name] ;
               List<GE_OG_Legal_Entity_Deal_Structure__c> Cntrs = [select CountryMobName__r.name from GE_OG_Legal_Entity_Deal_Structure__c where CountryMobName__r.name!=null ] ;
               UserOptionList = new List<SelectOption>();
               //UserOptionList .add(new SelectOption( ' ' ,'---Select---'));
               for(GE_OG_Legal_Entity_Deal_Structure__c u : Cntrs )
               {
                          UserOptionList.add(new SelectOption(u.CountryMobName__r.name, u.CountryMobName__r.name));
               }
               System.debug ('Countries are:'+UserOptionList);
              return UserOptionList ;
    }
 


  public List<GE_OG_Legal_Entity_Deal_Structure__c> getacclist()
  {
      countries=APexPages.currentPage().getParameters().get('countrys');
      country1=[select Id,Name from GE_HQ_Country__c where GE_HQ_ISO_Code__c=:countries1];
      if(country1.size() > 0){
      countries=country1[0].Name;
      uppercountr = countries.touppercase();
      }
      list <GE_HQ_Country__c> countrylist= [select id,name,GE_OG_Finance_Country_Risk__c,GE_OG_Tax_ID_Format__c from GE_HQ_Country__c where name=:countries];
      if (countrylist.size() > 0)
      acc =[select Legal_Entity__c, POA_Holder__c,SSO__c from GE_OG_Legal_Entity_Deal_Structure__c where CountryMobName__c=:countrylist[0].id LIMIT :LimitSize OFFSET :OffsetSize];
      System.debug('Values are ' + acc);
      return acc;

  }
   public GE_OG_Mobilization_Detail() {
   fpage=True;
   ppage=False;
   selectedCntryId ='';

  }

public void previous()
{
if(Offsetsize!=0)
OffsetSize = OffsetSize - LimitSize;
}
public void next()
{
if(Offsetsize<=totalRecs/LimitSize)
OffsetSize = OffsetSize + LimitSize;

}



}