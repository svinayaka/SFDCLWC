/*
Class Name: GE_OG_Case_RegionMatrixCounter
Purpose/Overview : To assign region based on country and business
Functional Area : Case Management
Author: Sandeep Rayavarapu
Created Date:  8/7/2014
Test Class Name :GE_OG_RegionMatrixtest                           
For the Requirement:R-18062

*/

Public with sharing  class GE_OG_Case_RegionMatrixCounter
{
//custom setting to fetch O&G Region
public static String regionPopulateByCountry(String SiteCountry){
        
         Map<String,String> mapcountryreg = new Map<String,String>();
        
         // Get a list of Country Region Mapping Custom Setting values 
        List<Country_Region_Mapping_ge_og__c> lstcountyregmap = Country_Region_Mapping_ge_og__c.getAll().values();
    
        // create a map of Country mapped with Region from Country Region Custom Setting List 
        for(Country_Region_Mapping_ge_og__c country : lstcountyregmap){
            mapcountryreg.put(country.country_name_ge_og__c.ToUpperCase(),country.region_ge_og__c);
        }
        
        //returning region Name from Map
        return (String.isBlank(SiteCountry)?SiteCountry:mapcountryreg.get(SiteCountry.ToUpperCase()));
    }

    List<string> RgnLst = new List<String>();
    List<string> RgnLstOG = new List<String>();
    
         
    
    //Case Region Matrix Logic starts
   Public void Reginfldspopulatin(List<case> NewList)
   {
   Id rcir= Schema.SObjectType.Case.getRecordTypeInfosByName().get('CIR').getRecordTypeId();
   Id rmcs= Schema.SObjectType.Case.getRecordTypeInfosByName().get('MC-TS').getRecordTypeId();
   set<id> unitserialnumber = new set<id>();
   set<id> accountid= new set<id>();
   
   
   for(case cs: newList) 
      {
          System.debug('Ashish--' + cs.accountId );
          unitserialnumber.add(cs.GE_OG_CIR_Unit_Serial_number__c);
          accountid.add(cs.accountid);
      }
      
      set<id> accfrominstallbase = new set<id>();
      map<id,GE_Installed_Base__c > mapinstallbase = new map<id,GE_Installed_Base__c >();
      for(GE_Installed_Base__c  gi:[select id,Account__c,GE_ES_Station_Name__c from GE_Installed_Base__c where id in:unitserialnumber])
      {
          mapinstallbase.put(gi.id,gi);
          accfrominstallbase.add(gi.account__c);
      }
      
      map<id,account> mapaccountinstallbase = new map<id,account>();
      for(account a:[select id,ShippingCountry,Shippingstate  from account where id in:accfrominstallbase])
      {
          mapaccountinstallbase.put(a.id,a);
      }
      map<id,account> mapaccount = new map<id,account>();
      for(account a:[select id,ShippingCountry,Shippingstate from account where id in:accountid])
      {
          mapaccount.put(a.id,a);
      }
      //recordtype rtypeCir=[Select id from recordtype where sobjecttype=:'Case' and name=:'CIR'];
      GE_OG_CaseContextController gcc = new GE_OG_CaseContextController();
      gcc.regionpopulation();
      gcc.accmap(accountid);
      for(case cs: newList) 
      {    
      if(cs.GE_OG_CIR_Unit_Serial_number__c!=null&&cs.accountid==null)
      {
            //GE_Installed_Base__c ib=[select id,Account__c,GE_ES_Station_Name__c from GE_Installed_Base__c where id =:cs.GE_OG_CIR_Unit_Serial_number__c];
            //account a=[select id,ShippingCountry,Shippingstate from account where id =:ib.Account__c];
            GE_Installed_Base__c ib=mapinstallbase.get(cs.GE_OG_CIR_Unit_Serial_number__c);
            account a=mapaccountinstallbase.get(mapinstallbase.get(cs.GE_OG_CIR_Unit_Serial_number__c).account__c);
            if(mapaccountinstallbase.containskey(mapinstallbase.get(cs.GE_OG_CIR_Unit_Serial_number__c).account__c)==true)
            {
            cs.accountid=a.id;
            cs.GE_OG_CIR_Site_Country__c=a.ShippingCountry;
            cs.GE_OG_CIR_State__c=a.Shippingstate;
            cs.GE_OG_CIR_Site_Name__c=ib.GE_ES_Station_Name__c;
            
            }
            
        }
        else if(cs.accountid!=null&&!(cs.recordtypeid==rmcs))
        {
            //account a=[select id,ShippingCountry,Shippingstate from account where id =:cs.accountid];
            account a=mapaccount.get(cs.accountid);
            cs.GE_OG_CIR_Site_Country__c=a.ShippingCountry;
            system.debug('......'+cs.account.ShippingCountry);
            system.debug('......'+cs.accountid);
            cs.GE_OG_CIR_Site_Country__c=a.ShippingCountry;
            
            cs.GE_OG_CIR_State__c=a.Shippingstate;
            
         }               
         if(cs.GE_OG_CIR_Site_Country__c != null&&(cs.recordtypeid==rcir))
         {
              RgnLst = gcc.returnInstSalesRegion(cs.GE_OG_Business_CIR__c,cs.GE_OG_CIR_Site_Country__c,cs.GE_OG_CIR_State__c,null,null,null) ;               
              cs.GE_OG_CIR_Region__c = RgnLst[0]; 
                                                                                                                 
         }
         else
         
         {
             if(!(cs.recordtypeid==rmcs))
             {   
              cs.GE_OG_CIR_Region__c ='';
              
              }
         }
          
          if(cs.accountid!=null  &&(cs.recordtypeid==rcir))
              {
             // account a=mapaccount.get(cs.accountid);
              RgnLstOG = gcc.returnSalesRegionHQ(cs.Tier_1_O_G__c,cs.AccountId,null,null,trigger.new);
              system.debug('............returnSalesRegionHQ............'+RgnLstOG[0]);
              cs.GE_O_G_Region__c=RgnLstOG[0];
             // cs.GE_O_G_Region__c=a.GE_OG_Region_Tier1__r.Name;
              }
              else
              {
                 if(!(cs.recordtypeid==rmcs))
                 {
                    cs.GE_O_G_Region__c='';
                  }
                   
              }

          
              
          if(cs.GE_OG_CIR_Site_Country__c!= null&&(cs.recordtypeid==rcir))
           {
          RgnLstOG = gcc.returnInstSalesRegion(cs.Tier_1_O_G__c,cs.GE_OG_CIR_Site_Country__c,cs.GE_OG_CIR_State__c,null,null,true) ;
          
          // RgnLstOG = cs.GE_O_G_Region__c != null ? RgnLst : gcc.returnInstSalesRegion(cs.Tier_1_O_G__c,cs.GE_OG_CIR_Site_Country__c,cs.GE_OG_CIR_State__c,null,null,true) ;              
         // cs.GE_O_G_Region__c = RgnLstOG[0] ;
          cs.GE_O_G_Region__c=RgnLstOG[0];
        
             system.debug('............returnInstSalesRegion.LIST...........'+RgnLstOG);
                 system.debug('............tier1............'+cs.Tier_1_O_G__c);
                 system.debug('............SiteCountry............'+cs.GE_OG_CIR_Site_Country__c);
                 system.debug('............State............'+cs.GE_OG_CIR_State__c);
           system.debug('............returnInstSalesRegion............'+RgnLstOG[0]); 
           }
          else
             {
                 if(!(cs.recordtypeid==rmcs))
                 {
                    cs.GE_O_G_Region__c='';
                  }
              }
              
             
       //populating O&G Region from custom settings
      
       if(cs.GE_OG_CIR_Site_Country__c!= null&&(cs.recordtypeid==rcir)){
                    cs.GE_O_G_Region__c= GE_OG_Case_RegionMatrixCounter.regionPopulateByCountry(cs.GE_OG_CIR_Site_Country__c);
                    system.debug('............Regioncustomsett............'+cs.GE_O_G_Region__c);
                 
            } else {
                     if(!(cs.recordtypeid==rmcs))
                     {
                      cs.GE_O_G_Region__c='';
                      }
                     system.debug('............Regioncustomsettelses............'+cs.GE_O_G_Region__c);
            }
            
        
          if(cs.GE_OG_Business_CIR__c=='Digital Solutions')
          {
          
              if(cs.accountid!=null&&(cs.recordtypeid==rcir))
              {
                RgnLstOG = gcc.returnSalesRegion(cs.GE_OG_Business_CIR__c,cs.AccountId,null,null,trigger.new);
                system.debug('........................'+RgnLstOG[0]);
                cs.GE_OG_CIR_Region__c = RgnLstOG[0];
              }
               else
              { 
                  if(!(cs.recordtypeid==rmcs))
                  {
                    cs.GE_OG_CIR_Region__c ='';
                  }
              }
          }
      }
   }
             
}