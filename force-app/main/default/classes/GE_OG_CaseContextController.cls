/*
Class Name: GE_OG_CaseContextController 
Used In : Across multiple controllers for context variables
Purpose/Overview : To initialize the context variables that are useful in triggers
Functional Area : Case Management
Author: Sandeep Rayavarapu
Created Date:  8/7/2014
Test Class Name :GE_OG_RegionMatrixtest                              
For the Requirement:R-18062

*/
global with sharing  class GE_OG_CaseContextController {
   
  public Map<id,Account> AccMapInfo;
  public Map<Id,User> UserMapInfo;
  public MAP<String,String> mapState; 
  public MAP<String,String> mapCnt; 
  public MAP<String,Id> mapCntIds ;
            
  public MAP<String,String> mapISOSt; 
  public MAP<String,String> mapISOCnt ;            
  public MAP<String,Id> mapStIds; 
  
  //Maps to hold differet combinations of tier matrix values
  public Map<string,GE_HQ_Reg_Matrix__c> CntStRgTMap;
  public Map<string,GE_HQ_Reg_Matrix__c> CntRgTMap;
  public Map<string,GE_HQ_Reg_Matrix__c> CntStRgTFnMap;
  public Map<string,GE_HQ_Reg_Matrix__c> CntRgTFnMap;
  public Map<string,GE_HQ_Reg_Matrix__c> CntRgMap;   
  public Map<string,List<Period>> FYPrdMap;   
   Set<Id> cntIds = new Set<Id>();
        Set<Id> stIds = new Set<Id>();
        
        public Map<id,account> acctmap;
        
        public void accmap(set<id> acctset)
        {
        
            acctmap=new map<id,account>();
            for(account a:[select id,Name,ShippingCountry,ShippingState,GE_HQ_Country_Code__c ,GE_HQ_New_Account_Country__c,GE_HQ_New_Account_State_Province__c from Account where Id in:acctset])
            {
            
                acctmap.put(a.id,a);
            }
            
        }
    
    public void regionpopulation()
    {
    mapState = new Map<String,String>();        mapCnt = new Map<String,String>();        mapCntIds = new Map<String,Id>();                   mapISOSt = new Map<String,String>();        mapISOCnt = new Map<String,String>();                   mapStIds = new Map<String,Id>();        Set<Id> stIds = new Set<Id>();       Set<Id> cntIds = new Set<Id>();       Set<string> ststrcode = new Set<String>();       Set<string> tr1Set = new Set<string>();       Set<string> tr2Set = new Set<string>();
  List<GE_HQ_State__c> lstState =[Select Name ,GE_HQ_ISO_Code__c from GE_HQ_State__c limit 50000];
       for (GE_HQ_State__c lstStatel:lstState){
           mapState.put(lstStatel.GE_HQ_ISO_Code__c,lstStatel.Name); 
           mapStIds.put( lstStatel.Name,lstStatel.id);
       }
       
       //Building acountry ISO code map
       List<GE_HQ_Country__c> lstCnt =[Select Name ,GE_HQ_ISO_Code__c from GE_HQ_Country__c limit 50000];
       
       system.debug('lstCnt outside for loop..........'+lstCnt+'   '+lstCnt.size());
       for (GE_HQ_Country__c Cnt1:lstCnt){
       system.debug('lstCnt inside for loop..........'+lstCnt);
        system.debug('Cnt1 inside for loop..........'+Cnt1);
           mapCnt.put(Cnt1.Name,Cnt1.GE_HQ_ISO_Code__c);  
           system.debug('mapCnt inside for loop..........'+mapCnt);
           mapCntIds.put(Cnt1.Name,Cnt1.Id);
           system.debug('mapCntIds inside for loop..........'+mapCntIds);
           mapISOCnt.put(Cnt1.GE_HQ_ISO_Code__c,Cnt1.Name); 
           system.debug('mapISOCnt inside for loop..........'+mapISOCnt);
       }
       system.debug('mapISOCnt'+mapISOCnt);
       
                         
        
        //geting region matrix records for the corresponding tiers, countries, states
        List<GE_HQ_Reg_Matrix__c> RMLst = new List<GE_HQ_Reg_Matrix__c>();    
        //RMLst = [select GE_HQ_Region__r.Name,GE_HQ_Sub_Region__c,GE_HQ_Country__r.name,GE_HQ_State__r.name,GE_HQ_State__r.GE_HQ_ISO_Code__c,GE_HQ_Country__r.GE_HQ_ISO_Code__c,GE_HQ_Tier0__c,GE_HQ_Tier1__c,GE_HQ_Tier2__c,GE_HQ_Tier3__c  from GE_HQ_Reg_Matrix__c where (GE_HQ_Tier1__c in :T1str or GE_HQ_Tier2__c in :T2str) or (GE_HQ_Country__r.name in :cntstr or GE_HQ_State__r.name in :ststr ) or (((GE_HQ_Tier0__c = 'GE Energy (GEE, HQ)' or GE_HQ_Tier0__c = 'Global Growth Organization (GGO)') and GE_HQ_Tier1__c = null and GE_HQ_Tier2__c = null) and (GE_HQ_Country__r.name in :cntstr  or GE_HQ_State__r.name in :ststr )) order by GE_HQ_Country__r.name,GE_HQ_State__r.name];
        RMLst = [Select GE_HQ_Region__r.Name,GE_HQ_Sub_Region__c,GE_HQ_Country__r.name,GE_HQ_State__r.name,GE_HQ_State__r.GE_HQ_ISO_Code__c,GE_HQ_Region__r.GE_HQ_Function__c,
                 GE_HQ_Country__r.GE_HQ_ISO_Code__c,GE_HQ_Tier0__c,GE_HQ_Tier1__c,GE_HQ_Tier2__c,GE_HQ_Tier3__c,GE_HQ_Sub_Region__r.Name  from GE_HQ_Reg_Matrix__c   
              limit 10000];                   
        
        //Maps to hold differet combinations of tier matrix values
        CntStRgTMap = new Map<string,GE_HQ_Reg_Matrix__c>();
        CntRgTMap = new Map<string,GE_HQ_Reg_Matrix__c>();
        CntStRgTFnMap = new Map<string,GE_HQ_Reg_Matrix__c>();
        CntRgTFnMap = new Map<string,GE_HQ_Reg_Matrix__c>();
        CntRgMap = new Map<string,GE_HQ_Reg_Matrix__c>();        
        
        for(GE_HQ_Reg_Matrix__c RM : RMLst)
        {
            if(RM.GE_HQ_Tier3__c != null && RM.GE_HQ_Country__c != null && RM.GE_HQ_State__c != null)
            {
                if(!CntStRgTMap.containskey(RM.GE_HQ_Tier3__c+RM.GE_HQ_Country__r.name+RM.GE_HQ_State__r.name))
                {
                    CntStRgTMap.put(RM.GE_HQ_Tier3__c+RM.GE_HQ_Country__r.name+RM.GE_HQ_State__r.name,RM);
                    CntRgMap.put(RM.GE_HQ_Tier3__c+RM.GE_HQ_Country__r.name,RM);
                }    
                if(RM.GE_HQ_Region__r.GE_HQ_Function__c == 'Sales' || RM.GE_HQ_Region__r.GE_HQ_Function__c == 'Operations')
                if(!CntStRgTFnMap.containskey(RM.GE_HQ_Tier3__c+RM.GE_HQ_Country__r.name+RM.GE_HQ_State__r.name+RM.GE_HQ_Region__r.GE_HQ_Function__c))
                {
                    CntStRgTFnMap.put(RM.GE_HQ_Tier3__c+RM.GE_HQ_Country__r.name+RM.GE_HQ_State__r.name+RM.GE_HQ_Region__r.GE_HQ_Function__c,RM);
                    //CntRgMap.put(RM.GE_HQ_Tier2__c+RM.GE_HQ_Country__r.name+RM.GE_HQ_Region__r.GE_HQ_Function__c,RM);
                }        
            }
            
            if(RM.GE_HQ_Tier3__c != null && RM.GE_HQ_Country__c != null && RM.GE_HQ_State__c == null)
            {
                if(!CntRgTMap.containskey(RM.GE_HQ_Tier3__c+RM.GE_HQ_Country__r.name))
                CntRgTMap.put(RM.GE_HQ_Tier3__c+RM.GE_HQ_Country__r.name,RM);
                if(RM.GE_HQ_Region__r.GE_HQ_Function__c == 'Sales' || RM.GE_HQ_Region__r.GE_HQ_Function__c == 'Operations')
                if(!CntRgTFnMap.containskey(RM.GE_HQ_Tier3__c+RM.GE_HQ_Country__r.name+RM.GE_HQ_Region__r.GE_HQ_Function__c))
                CntRgTFnMap.put(RM.GE_HQ_Tier3__c+RM.GE_HQ_Country__r.name+RM.GE_HQ_Region__r.GE_HQ_Function__c,RM);
            }
            
            if(RM.GE_HQ_Tier2__c != null && RM.GE_HQ_Tier3__c == null &&RM.GE_HQ_Country__c != null && RM.GE_HQ_State__c != null)
            {
                if(!CntStRgTMap.containskey(RM.GE_HQ_Tier2__c+RM.GE_HQ_Country__r.name+RM.GE_HQ_State__r.name))
                {
                    CntStRgTMap.put(RM.GE_HQ_Tier2__c+RM.GE_HQ_Country__r.name+RM.GE_HQ_State__r.name,RM);
                    CntRgMap.put(RM.GE_HQ_Tier2__c+RM.GE_HQ_Country__r.name,RM);
                }    
                if(RM.GE_HQ_Region__r.GE_HQ_Function__c == 'Sales' || RM.GE_HQ_Region__r.GE_HQ_Function__c == 'Operations')
                if(!CntStRgTFnMap.containskey(RM.GE_HQ_Tier2__c+RM.GE_HQ_Country__r.name+RM.GE_HQ_State__r.name+RM.GE_HQ_Region__r.GE_HQ_Function__c))
                {
                    CntStRgTFnMap.put(RM.GE_HQ_Tier2__c+RM.GE_HQ_Country__r.name+RM.GE_HQ_State__r.name+RM.GE_HQ_Region__r.GE_HQ_Function__c,RM);
                    //CntRgMap.put(RM.GE_HQ_Tier2__c+RM.GE_HQ_Country__r.name+RM.GE_HQ_Region__r.GE_HQ_Function__c,RM);
                }        
            }
            
            if(RM.GE_HQ_Tier2__c != null && RM.GE_HQ_Tier3__c == null && RM.GE_HQ_Country__c != null && RM.GE_HQ_State__c == null)
            {
                if(!CntRgTMap.containskey(RM.GE_HQ_Tier2__c+RM.GE_HQ_Country__r.name))
                CntRgTMap.put(RM.GE_HQ_Tier2__c+RM.GE_HQ_Country__r.name,RM);
                if(RM.GE_HQ_Region__r.GE_HQ_Function__c == 'Sales' || RM.GE_HQ_Region__r.GE_HQ_Function__c == 'Operations')
                if(!CntRgTFnMap.containskey(RM.GE_HQ_Tier2__c+RM.GE_HQ_Country__r.name+RM.GE_HQ_Region__r.GE_HQ_Function__c))
                CntRgTFnMap.put(RM.GE_HQ_Tier2__c+RM.GE_HQ_Country__r.name+RM.GE_HQ_Region__r.GE_HQ_Function__c,RM);
            }
            
            if(RM.GE_HQ_Tier1__c != null && RM.GE_HQ_Tier2__c == null && RM.GE_HQ_Tier3__c == null && RM.GE_HQ_Country__c != null && RM.GE_HQ_State__c != null)
            {
                if(!CntStRgTMap.containskey(RM.GE_HQ_Tier1__c+RM.GE_HQ_Country__r.name+RM.GE_HQ_State__r.name))
                {
                    CntStRgTMap.put(RM.GE_HQ_Tier1__c+RM.GE_HQ_Country__r.name+RM.GE_HQ_State__r.name,RM);               
                    CntRgMap.put(RM.GE_HQ_Tier1__c+RM.GE_HQ_Country__r.name,RM);
                }    
                if(RM.GE_HQ_Region__r.GE_HQ_Function__c == 'Sales' || RM.GE_HQ_Region__r.GE_HQ_Function__c == 'Operations')
                if(!CntStRgTFnMap.containskey(RM.GE_HQ_Tier1__c+RM.GE_HQ_Country__r.name+RM.GE_HQ_State__r.name+RM.GE_HQ_Region__r.GE_HQ_Function__c))
                {
                    CntStRgTFnMap.put(RM.GE_HQ_Tier1__c+RM.GE_HQ_Country__r.name+RM.GE_HQ_State__r.name+RM.GE_HQ_Region__r.GE_HQ_Function__c,RM);
                    //CntRgMap.put(RM.GE_HQ_Tier1__c+RM.GE_HQ_Country__r.name+RM.GE_HQ_Region__r.GE_HQ_Function__c,RM);
                }    
            }
            
            if(RM.GE_HQ_Tier1__c != null && RM.GE_HQ_Tier2__c == null && RM.GE_HQ_Tier3__c == null && RM.GE_HQ_Country__c != null && RM.GE_HQ_State__c == null)
            {
                if(!CntRgTMap.containskey(RM.GE_HQ_Tier1__c+RM.GE_HQ_Country__r.name))
                CntRgTMap.put(RM.GE_HQ_Tier1__c+RM.GE_HQ_Country__r.name,RM);                
                if(RM.GE_HQ_Region__r.GE_HQ_Function__c == 'Sales' || RM.GE_HQ_Region__r.GE_HQ_Function__c == 'Operations')
                if(!CntRgTFnMap.containskey(RM.GE_HQ_Tier1__c+RM.GE_HQ_Country__r.name+RM.GE_HQ_Region__r.GE_HQ_Function__c))
                CntRgTFnMap.put(RM.GE_HQ_Tier1__c+RM.GE_HQ_Country__r.name+RM.GE_HQ_Region__r.GE_HQ_Function__c,RM);
            }
            
            if((RM.GE_HQ_Tier0__c == 'GE Energy (GEE, HQ)' || RM.GE_HQ_Tier0__c == 'Global Growth Organization (GGO)') &&  RM.GE_HQ_Tier1__c == null && RM.GE_HQ_Tier2__c == null && RM.GE_HQ_Tier3__c == null && RM.GE_HQ_Country__c != null && RM.GE_HQ_State__c != null)
            {
                if(!CntStRgTMap.containskey(RM.GE_HQ_Tier0__c+RM.GE_HQ_Country__r.name+RM.GE_HQ_State__r.name))               
                {
                    CntStRgTMap.put(RM.GE_HQ_Tier0__c+RM.GE_HQ_Country__r.name+RM.GE_HQ_State__r.name,RM);               
                    CntRgMap.put(RM.GE_HQ_Tier0__c+RM.GE_HQ_Country__r.name,RM);               
                }    
                if(RM.GE_HQ_Region__r.GE_HQ_Function__c == 'Sales' || RM.GE_HQ_Region__r.GE_HQ_Function__c == 'Operations')
                if(!CntStRgTFnMap.containskey(RM.GE_HQ_Tier0__c+RM.GE_HQ_Country__r.name+RM.GE_HQ_State__r.name+RM.GE_HQ_Region__r.GE_HQ_Function__c))
                {
                    CntStRgTFnMap.put(RM.GE_HQ_Tier0__c+RM.GE_HQ_Country__r.name+RM.GE_HQ_State__r.name+RM.GE_HQ_Region__r.GE_HQ_Function__c,RM);
                    CntRgMap.put(RM.GE_HQ_Tier0__c+RM.GE_HQ_Country__r.name+RM.GE_HQ_Region__r.GE_HQ_Function__c,RM);
                }    
                    
            }
            
            if((RM.GE_HQ_Tier0__c == 'GE Energy (GEE, HQ)' || RM.GE_HQ_Tier0__c == 'Global Growth Organization (GGO)') &&  RM.GE_HQ_Tier1__c == null && RM.GE_HQ_Tier2__c == null && RM.GE_HQ_Tier3__c == null && RM.GE_HQ_Country__c != null && RM.GE_HQ_State__c == null)
            {
                if(!CntRgTMap.containskey(RM.GE_HQ_Tier0__c+RM.GE_HQ_Country__r.name))
                CntRgTMap.put(RM.GE_HQ_Tier0__c+RM.GE_HQ_Country__r.name,RM);                
                if(RM.GE_HQ_Region__r.GE_HQ_Function__c == 'Sales' || RM.GE_HQ_Region__r.GE_HQ_Function__c == 'Operations')
                if(!CntRgTFnMap.containskey(RM.GE_HQ_Tier0__c+RM.GE_HQ_Country__r.name+RM.GE_HQ_Region__r.GE_HQ_Function__c))
                CntRgTFnMap.put(RM.GE_HQ_Tier0__c+RM.GE_HQ_Country__r.name+RM.GE_HQ_Region__r.GE_HQ_Function__c,RM);
            }
            
        }
    
    }
  
   public List<string> returnInstSalesRegion(string Tier,String cnt,String st,String SR, String SSR,Boolean Def)
  {
     system.debug('before Update Business & Country'+Tier+'  '+cnt);

      String TCnt,TCntISO,TSt,TStISO;
      Boolean TCntISOC,TStISOC;
      TCnt = cnt;
      Tst = st;
      system.debug('before Update TCnt & Tst '+TCnt +'  '+Tst );
      //TCntISO = TCnt != null ? mapISOCnt.get(TCnt.toUpperCase()) : TCntISO;
      //TCntISOC = TCnt != null ? mapISOCnt.containskey(TCnt.toUpperCase()) : false;
      system.debug('is null.... '+TCnt);
      system.debug('Map.... '+mapISOCnt.containskey(TCnt.toUpperCase()));
      if(TCnt != '' && TCnt !='null'){
          TCntISOC = mapISOCnt.containskey(TCnt.toUpperCase());
      }
      else{
          TCntISOC =false;
      }
      system.debug('beforeTCntISOC'+TCntISOC);
      TCntISO = (TCnt != null && TCntISOC)? mapISOCnt.get(TCnt.toUpperCase()) : TCntISO;
      system.debug('afterTCntISO'+TCntISO);
      system.debug('lastmap'+mapISOCnt.get(TCnt.toUpperCase())); 
      
      //TSt = AccMapInfo.get(Acc).ShippingState;
      //TStISO = TSt != null ?  mapISOSt.get(TSt) : TStISO;
      TStISOC = TSt != null ?  mapISOSt.containskey(TSt) : false;
      system.debug('beforeTStISOC'+TStISOC);
      TStISO = (TSt != null && TStISOC)? mapISOSt.get(TSt.toUpperCase()) : TStISO;
      system.debug('afterTStISO'+TStISO);
      
      List<String> SRgn = new List<String>();
      SRgn.add((TCnt != null && TSt != null && (CntStRgTMap.containskey(Tier+TCnt.toUpperCase()+TSt.toUpperCase()))) ? CntStRgTMap.get(Tier+TCnt.toUpperCase()+TSt.toUpperCase()).GE_HQ_Region__r.Name : (  TCnt != null && TCnt.length() == 2 && TCntISOC &&  TSt != null && TSt.length() == 2 && TStISOC && mapState.Containskey(TStISO) && CntStRgTMap.containskey(Tier+TCntISO+mapState.get(TStISO) ) ?  CntStRgTMap.get(Tier+TCntISO+mapState.get(TStISO) ).GE_HQ_Region__r.Name  : ( TCnt != null && TCnt.length() == 2 && TCntISOC &&  TSt != null && TSt.length() != 2  && CntStRgTMap.containskey(Tier+TCntISO+TSt.toUpperCase() ) ?  CntStRgTMap.get(Tier+TCntISO+TSt.toUpperCase()).GE_HQ_Region__r.Name : ( TCnt != null && TCnt.length() != 2 &&  TSt != null && TSt.length() == 2 && TStISOC && mapState.Containskey(TStISO) && CntStRgTMap.containskey(Tier+TCnt.toUpperCase()+mapState.get(TStISO) ) ?  CntStRgTMap.get(Tier+TCnt.toUpperCase()+mapState.get(TStISO) ).GE_HQ_Region__r.Name : ( TCnt != null  && CntRgTMap.containskey(Tier+TCnt.toUpperCase() ) ?  CntRgTMap.get(Tier+TCnt.toUpperCase() ).GE_HQ_Region__r.Name : ( TCnt != null && TCnt.length() == 2 && TCntISOC  && CntRgTMap.containskey(Tier+TCntISO ) ?  CntRgTMap.get(Tier+TCntISO).GE_HQ_Region__r.Name : ( cnt != null && cnt.length() == 2 && mapISOCnt.containskey(cnt.toUpperCase())  && CntRgTMap.containskey(Tier+mapISOCnt.get(cnt.toUpperCase())) ?  CntRgTMap.get(Tier+mapISOCnt.get(cnt.toUpperCase())).GE_HQ_Region__r.Name :( (Def == true &&  cnt != null && CntRgMap.containskey(Tier+TCnt.toUpperCase())) ? CntRgMap.get(Tier+TCnt.toUpperCase()).GE_HQ_Region__r.Name : (SR))))))) ));
      system.debug('SRgn'+SRgn);
      SRgn.add((TCnt != null && TSt != null && (CntStRgTMap.containskey(Tier+TCnt.toUpperCase()+TSt.toUpperCase()))) ? CntStRgTMap.get(Tier+TCnt.toUpperCase()+TSt.toUpperCase()).GE_HQ_Sub_Region__r.Name : (  TCnt != null && TCnt.length() == 2 && TCntISOC &&  TSt != null && TSt.length() == 2 && TStISOC && mapState.Containskey(TStISO) && CntStRgTMap.containskey(Tier+TCntISO+mapState.get(TStISO) ) ?  CntStRgTMap.get(Tier+TCntISO+mapState.get(TStISO) ).GE_HQ_Sub_Region__r.Name  : ( TCnt != null && TCnt.length() == 2 && TCntISOC &&  TSt != null && TSt.length() != 2  && CntStRgTMap.containskey(Tier+TCntISO+TSt.toUpperCase() ) ?  CntStRgTMap.get(Tier+TCntISO+TSt.toUpperCase()).GE_HQ_Sub_Region__r.Name : ( TCnt != null && TCnt.length() != 2 &&  TSt != null && TSt.length() == 2 && TStISOC && mapState.Containskey(TStISO) && CntStRgTMap.containskey(Tier+TCnt.toUpperCase()+mapState.get(TStISO) ) ?  CntStRgTMap.get(Tier+TCnt.toUpperCase()+mapState.get(TStISO) ).GE_HQ_Sub_Region__r.Name : ( TCnt != null  && CntRgTMap.containskey(Tier+TCnt.toUpperCase() ) ?  CntRgTMap.get(Tier+TCnt.toUpperCase() ).GE_HQ_Sub_Region__r.Name : ( TCnt != null && TCnt.length() == 2 && TCntISOC  && CntRgTMap.containskey(Tier+TCntISO ) ?  CntRgTMap.get(Tier+TCntISO).GE_HQ_Sub_Region__r.Name : ( cnt != null && cnt.length() == 2 && mapISOCnt.containskey(cnt.toUpperCase())  && CntRgTMap.containskey(Tier+mapISOCnt.get(cnt.toUpperCase()) ) ?  CntRgTMap.get(Tier+mapISOCnt.get(cnt.toUpperCase())).GE_HQ_Sub_Region__r.Name : ( (Def == true &&  cnt != null && CntRgMap.containskey(Tier+TCnt.toUpperCase())) ? CntRgMap.get(Tier+TCnt.toUpperCase()).GE_HQ_Sub_Region__r.Name :(SSR))))))) ));      
      
      system.debug('returnabcd'+SRgn);
      return SRgn;
      
      
  }
  
  
  
   public List<string> returnSalesRegion(string Tier,Id Acc,String SR, String SSR,list<case> newlist)
  {
  cntIds= new set<id>();
  stIds=new set<id>();
  AccMapInfo = acctmap;
    
    
    for(case cvar:newlist)
    {
    if(AccMapInfo.containskey(cvar.AccountId)==true)
    {
    String AcctState='';
            
            //Account country, state
            if(cvar.AccountId != null && ((AccMapInfo.get(cvar.AccountId).ShippingCountry != '' && AccMapInfo.get(cvar.AccountId).ShippingCountry != null) || AccMapInfo.get(cvar.AccountId).GE_HQ_Country_Code__c != null) )
            {
                if(AccMapInfo.get(cvar.AccountId).ShippingCountry != null && mapCnt.containskey(AccMapInfo.get(cvar.AccountId).ShippingCountry.toUppercase()))
                cntIds.add(mapCntIds.get(AccMapInfo.get(cvar.AccountId).ShippingCountry.toUppercase()));
                
                if(AccMapInfo.get(cvar.AccountId).ShippingCountry != null && mapISOCnt.containskey(AccMapInfo.get(cvar.AccountId).ShippingCountry.toUppercase()))
                cntIds.add(mapCntIds.get(mapISOCnt.get(AccMapInfo.get(cvar.AccountId).ShippingCountry.toUppercase())));
                
                if(AccMapInfo.get(cvar.AccountId).GE_HQ_Country_Code__c != null && mapISOCnt.containskey(AccMapInfo.get(cvar.AccountId).GE_HQ_Country_Code__c.toUppercase()))
                cntIds.add(mapCntIds.get(mapISOCnt.get(AccMapInfo.get(cvar.AccountId).GE_HQ_Country_Code__c.toUppercase())));
            }    
            
            if(cvar.AccountId != null && AccMapInfo.get(cvar.AccountId).ShippingState != '' && AccMapInfo.get(cvar.AccountId).ShippingState != null)
            {                                                                                                     
                AcctState = (AccMapInfo.get(cvar.AccountId).ShippingCountry != null && AccMapInfo.get(cvar.AccountId).ShippingCountry.length() == 2 && (AccMapInfo.get(cvar.AccountId).ShippingState).length() == 2) ? (AccMapInfo.get(cvar.AccountId).ShippingCountry+'-'+ AccMapInfo.get(cvar.AccountId).ShippingState) : ((AccMapInfo.get(cvar.AccountId).ShippingCountry != null && mapCnt.containskey(AccMapInfo.get(cvar.AccountId).ShippingCountry.toUpperCase()) && (AccMapInfo.get(cvar.AccountId).ShippingState).length() == 2)  ? (mapCnt.get(AccMapInfo.get(cvar.AccountId).ShippingCountry.toUpperCase())+'-'+AccMapInfo.get(cvar.AccountId).ShippingState) : AccMapInfo.get(cvar.AccountId).ShippingState );                        
                AcctState = AcctState.toUpperCase();                                   
                if(mapState.Containskey(AcctState))
                {
                    if(mapStIds.containskey(mapState.get(AcctState)))                    
                    stIds.add(mapStIds.get(mapState.get(AcctState)));
                    
                    mapISOSt.put(AccMapInfo.get(cvar.AccountId).ShippingState,AcctState);
                }  
                if(mapStIds.containskey(AcctState))                    
                stIds.add(mapStIds.get(AcctState));   
                   
            }
            
            //if the shipping country and state are null
            if(cvar.AccountId != null && AccMapInfo.get(cvar.AccountId).GE_HQ_New_Account_Country__c != '' && AccMapInfo.get(cvar.AccountId).GE_HQ_New_Account_Country__c != null )
            {
                if(mapCnt.containskey(AccMapInfo.get(cvar.AccountId).GE_HQ_New_Account_Country__c.toUpperCase()))
                cntIds.add(mapCntIds.get(AccMapInfo.get(cvar.AccountId).GE_HQ_New_Account_Country__c.toUpperCase()));
                
                if(mapISOCnt.containskey(AccMapInfo.get(cvar.AccountId).GE_HQ_New_Account_Country__c.toUpperCase()))
                cntIds.add(mapCntIds.get(mapISOCnt.get(AccMapInfo.get(cvar.AccountId).GE_HQ_New_Account_Country__c.toUpperCase())));
            } 
            if(cvar.AccountId != null && AccMapInfo.get(cvar.AccountId).ShippingState == null && AccMapInfo.get(cvar.AccountId).ShippingCountry == null && AccMapInfo.get(cvar.AccountId).GE_HQ_New_Account_State_Province__c != null )
            {                                                                                                     
                AcctState = (AccMapInfo.get(cvar.AccountId).GE_HQ_New_Account_Country__c != null && AccMapInfo.get(cvar.AccountId).GE_HQ_New_Account_Country__c.length() == 2 && AccMapInfo.get(cvar.AccountId).GE_HQ_New_Account_State_Province__c.length() == 2) ? (AccMapInfo.get(cvar.AccountId).GE_HQ_New_Account_Country__c+'-'+AccMapInfo.get(cvar.AccountId).GE_HQ_New_Account_State_Province__c) : ((AccMapInfo.get(cvar.AccountId).GE_HQ_New_Account_Country__c != null && mapCnt.containskey(AccMapInfo.get(cvar.AccountId).GE_HQ_New_Account_Country__c.toUpperCase()) && AccMapInfo.get(cvar.AccountId).GE_HQ_New_Account_State_Province__c.length() == 2) ? (mapCnt.get(AccMapInfo.get(cvar.AccountId).GE_HQ_New_Account_Country__c.toUpperCase())+'-'+AccMapInfo.get(cvar.AccountId).GE_HQ_New_Account_State_Province__c) : AccMapInfo.get(cvar.AccountId).GE_HQ_New_Account_State_Province__c);                        
                AcctState = AcctState.toUpperCase();                                      
                if(mapState.Containskey(AcctState))
                {
                    if(mapStIds.containskey(mapState.get(AcctState)))                    
                    stIds.add(mapStIds.get(mapState.get(AcctState)));
                    
                    mapISOSt.put(AccMapInfo.get(cvar.AccountId).GE_HQ_New_Account_State_Province__c,AcctState);
                }
                if(mapStIds.containskey(AcctState))                    
                stIds.add(mapStIds.get(AcctState));    
                                     
            }
            }
    }
     
      system.debug('regionmatrixmap------'+CntStRgTMap);
      String TCnt,TCntISO,TSt,TStISO;
      Boolean TCntISOC,TStISOC;
      
      if(AccMapInfo.containskey(acc)) 
        TCnt = AccMapInfo.get(Acc).ShippingCountry;
      TCntISOC = TCnt != null ?  mapISOCnt.containskey(TCnt.toUpperCase()) : false;
      TCntISO = (TCnt != null && TCntISOC)? mapISOCnt.get(TCnt.toUpperCase()) : TCntISO;
      
      if(AccMapInfo.containskey(acc)) 
        TSt = AccMapInfo.get(Acc).ShippingState;
      TStISOC = TSt != null ?  mapISOSt.containskey(TSt) : false;
      TStISO = (TSt != null && TStISOC) ?  mapISOSt.get(TSt) : TStISO;            
      List<String> SRgn = new List<String>();     
      String abc=null;
        if(AccMapInfo.containskey(acc))
      abc = AccMapInfo.get(Acc).GE_HQ_Country_Code__c;    
      SRgn.add((TCnt != null && TSt != null && (CntStRgTMap.containskey(Tier+TCnt.toUpperCase()+TSt.toUpperCase()))) ? CntStRgTMap.get(Tier+TCnt.toUpperCase()+TSt.toUpperCase()).GE_HQ_Region__r.Name : (  TCnt != null && TCnt.length() == 2 && TCntISOC &&  TSt != null && TSt.length() == 2 && TStISOC && mapState.Containskey(TStISO) && CntStRgTMap.containskey(Tier+TCntISO+mapState.get(TStISO) ) ?  CntStRgTMap.get(Tier+TCntISO+mapState.get(TStISO) ).GE_HQ_Region__r.Name  : ( TCnt != null && TCnt.length() == 2 && TCntISOC &&  TSt != null && TSt.length() != 2  && CntStRgTMap.containskey(Tier+TCntISO+TSt.toUpperCase() ) ?  CntStRgTMap.get(Tier+TCntISO+TSt.toUpperCase()).GE_HQ_Region__r.Name : ( TCnt != null && TCnt.length() != 2 &&  TSt != null && TSt.length() == 2 && TStISOC && mapState.Containskey(TStISO) && CntStRgTMap.containskey(Tier+TCnt.toUpperCase()+mapState.get(TStISO) ) ?  CntStRgTMap.get(Tier+TCnt.toUpperCase()+mapState.get(TStISO) ).GE_HQ_Region__r.Name : ( TCnt != null  && CntRgTMap.containskey(Tier+TCnt.toUpperCase() ) ?  CntRgTMap.get(Tier+TCnt.toUpperCase() ).GE_HQ_Region__r.Name : ( TCnt != null && TCnt.length() == 2 && TCntISOC  && CntRgTMap.containskey(Tier+TCntISO ) ?  CntRgTMap.get(Tier+TCntISO).GE_HQ_Region__r.Name : ( abc != null && abc.length() == 2 && mapISOCnt.containskey(abc.toUpperCase())  && CntRgTMap.containskey(Tier+mapISOCnt.get(abc.toUpperCase())) ?  CntRgTMap.get(Tier+mapISOCnt.get(abc.toUpperCase())).GE_HQ_Region__r.Name : (SR))))))) );
      SRgn.add((TCnt != null && TSt != null && (CntStRgTMap.containskey(Tier+TCnt.toUpperCase()+TSt.toUpperCase()))) ? CntStRgTMap.get(Tier+TCnt.toUpperCase()+TSt.toUpperCase()).GE_HQ_Sub_Region__r.Name : (  TCnt != null && TCnt.length() == 2 && TCntISOC &&  TSt != null && TSt.length() == 2 && TStISOC && mapState.Containskey(TStISO) && CntStRgTMap.containskey(Tier+TCntISO+mapState.get(TStISO) ) ?  CntStRgTMap.get(Tier+TCntISO+mapState.get(TStISO) ).GE_HQ_Sub_Region__r.Name  : ( TCnt != null && TCnt.length() == 2 && TCntISOC &&  TSt != null && TSt.length() != 2  && CntStRgTMap.containskey(Tier+TCntISO+TSt.toUpperCase() ) ?  CntStRgTMap.get(Tier+TCntISO+TSt.toUpperCase()).GE_HQ_Sub_Region__r.Name : ( TCnt != null && TCnt.length() != 2 &&  TSt != null && TSt.length() == 2 && TStISOC && mapState.Containskey(TStISO) && CntStRgTMap.containskey(Tier+TCnt.toUpperCase()+mapState.get(TStISO) ) ?  CntStRgTMap.get(Tier+TCnt.toUpperCase()+mapState.get(TStISO) ).GE_HQ_Sub_Region__r.Name : ( TCnt != null  && CntRgTMap.containskey(Tier+TCnt.toUpperCase() ) ?  CntRgTMap.get(Tier+TCnt.toUpperCase() ).GE_HQ_Sub_Region__r.Name : ( TCnt != null && TCnt.length() == 2 && TCntISOC  && CntRgTMap.containskey(Tier+TCntISO ) ?  CntRgTMap.get(Tier+TCntISO).GE_HQ_Sub_Region__r.Name : ( abc != null && abc.length() == 2 && mapISOCnt.containskey(abc.toUpperCase())  && CntRgTMap.containskey(Tier+mapISOCnt.get(abc.toUpperCase()) ) ?  CntRgTMap.get(Tier+mapISOCnt.get(abc.toUpperCase())).GE_HQ_Sub_Region__r.Name :(SSR)))))) ));
      system.debug('lastregion-----'+SRgn.size());
      system.debug('lastregion-----dev'+SRgn[0]);
      return SRgn;
      
  }
  
  
  public List<string> returnSalesRegionHQ(string Tier,Id Acc,String SR, String SSR,list<case> newlist)
  {
   cntIds= new set<id>();
  stIds=new set<id>();
  AccMapInfo = acctmap;
  for(case cvar:newlist)
    {
    if(AccMapInfo.containskey(cvar.AccountId)==true)
    {
    String AcctState='';
            
            //Account country, state
            if(cvar.AccountId != null && ((AccMapInfo.get(cvar.AccountId).ShippingCountry != '' && AccMapInfo.get(cvar.AccountId).ShippingCountry != null) || AccMapInfo.get(cvar.AccountId).GE_HQ_Country_Code__c != null) )
            {
                if(AccMapInfo.get(cvar.AccountId).ShippingCountry != null && mapCnt.containskey(AccMapInfo.get(cvar.AccountId).ShippingCountry.toUppercase()))
                cntIds.add(mapCntIds.get(AccMapInfo.get(cvar.AccountId).ShippingCountry.toUppercase()));
                
                if(AccMapInfo.get(cvar.AccountId).ShippingCountry != null && mapISOCnt.containskey(AccMapInfo.get(cvar.AccountId).ShippingCountry.toUppercase()))
                cntIds.add(mapCntIds.get(mapISOCnt.get(AccMapInfo.get(cvar.AccountId).ShippingCountry.toUppercase())));
                
                if(AccMapInfo.get(cvar.AccountId).GE_HQ_Country_Code__c != null && mapISOCnt.containskey(AccMapInfo.get(cvar.AccountId).GE_HQ_Country_Code__c.toUppercase()))
                cntIds.add(mapCntIds.get(mapISOCnt.get(AccMapInfo.get(cvar.AccountId).GE_HQ_Country_Code__c.toUppercase())));
            }    
            
            if(cvar.AccountId != null && AccMapInfo.get(cvar.AccountId).ShippingState != '' && AccMapInfo.get(cvar.AccountId).ShippingState != null)
            {                                                                                                     
                AcctState = (AccMapInfo.get(cvar.AccountId).ShippingCountry != null && AccMapInfo.get(cvar.AccountId).ShippingCountry.length() == 2 && (AccMapInfo.get(cvar.AccountId).ShippingState).length() == 2) ? (AccMapInfo.get(cvar.AccountId).ShippingCountry+'-'+ AccMapInfo.get(cvar.AccountId).ShippingState) : ((AccMapInfo.get(cvar.AccountId).ShippingCountry != null && mapCnt.containskey(AccMapInfo.get(cvar.AccountId).ShippingCountry.toUpperCase()) && (AccMapInfo.get(cvar.AccountId).ShippingState).length() == 2)  ? (mapCnt.get(AccMapInfo.get(cvar.AccountId).ShippingCountry.toUpperCase())+'-'+AccMapInfo.get(cvar.AccountId).ShippingState) : AccMapInfo.get(cvar.AccountId).ShippingState );                        
                AcctState = AcctState.toUpperCase();                                   
                if(mapState.Containskey(AcctState))
                {
                    if(mapStIds.containskey(mapState.get(AcctState)))                    
                    stIds.add(mapStIds.get(mapState.get(AcctState)));
                    
                    mapISOSt.put(AccMapInfo.get(cvar.AccountId).ShippingState,AcctState);
                }  
                if(mapStIds.containskey(AcctState))                    
                stIds.add(mapStIds.get(AcctState));   
                   
            }
            
            //if the shipping country and state are null
            if(cvar.AccountId != null && AccMapInfo.get(cvar.AccountId).GE_HQ_New_Account_Country__c != '' && AccMapInfo.get(cvar.AccountId).GE_HQ_New_Account_Country__c != null )
            {
                if(mapCnt.containskey(AccMapInfo.get(cvar.AccountId).GE_HQ_New_Account_Country__c.toUpperCase()))
                cntIds.add(mapCntIds.get(AccMapInfo.get(cvar.AccountId).GE_HQ_New_Account_Country__c.toUpperCase()));
                
                if(mapISOCnt.containskey(AccMapInfo.get(cvar.AccountId).GE_HQ_New_Account_Country__c.toUpperCase()))
                cntIds.add(mapCntIds.get(mapISOCnt.get(AccMapInfo.get(cvar.AccountId).GE_HQ_New_Account_Country__c.toUpperCase())));
            } 
            if(cvar.AccountId != null && AccMapInfo.get(cvar.AccountId).ShippingState == null && AccMapInfo.get(cvar.AccountId).ShippingCountry == null && AccMapInfo.get(cvar.AccountId).GE_HQ_New_Account_State_Province__c != null )
            {                                                                                                     
                AcctState = (AccMapInfo.get(cvar.AccountId).GE_HQ_New_Account_Country__c != null && AccMapInfo.get(cvar.AccountId).GE_HQ_New_Account_Country__c.length() == 2 && AccMapInfo.get(cvar.AccountId).GE_HQ_New_Account_State_Province__c.length() == 2) ? (AccMapInfo.get(cvar.AccountId).GE_HQ_New_Account_Country__c+'-'+AccMapInfo.get(cvar.AccountId).GE_HQ_New_Account_State_Province__c) : ((AccMapInfo.get(cvar.AccountId).GE_HQ_New_Account_Country__c != null && mapCnt.containskey(AccMapInfo.get(cvar.AccountId).GE_HQ_New_Account_Country__c.toUpperCase()) && AccMapInfo.get(cvar.AccountId).GE_HQ_New_Account_State_Province__c.length() == 2) ? (mapCnt.get(AccMapInfo.get(cvar.AccountId).GE_HQ_New_Account_Country__c.toUpperCase())+'-'+AccMapInfo.get(cvar.AccountId).GE_HQ_New_Account_State_Province__c) : AccMapInfo.get(cvar.AccountId).GE_HQ_New_Account_State_Province__c);                        
                AcctState = AcctState.toUpperCase();                                      
                if(mapState.Containskey(AcctState))
                {
                    if(mapStIds.containskey(mapState.get(AcctState)))                    
                    stIds.add(mapStIds.get(mapState.get(AcctState)));
                    
                    mapISOSt.put(AccMapInfo.get(cvar.AccountId).GE_HQ_New_Account_State_Province__c,AcctState);
                }
                if(mapStIds.containskey(AcctState))                    
                stIds.add(mapStIds.get(AcctState));    
                                     
            }
            }
    }
      system.debug('regionmatrixmap------'+CntStRgTMap);
      String TCntHQ,TCntISOHQ,TStHQ,TStISOHQ;
      Boolean TCntISOHQC,TStISOHQC;
      system.debug('SATYA Acct------'+acc+' map '+AccMapInfo);
      if(AccMapInfo.containskey(acc)) 
        TCntHQ = AccMapInfo.get(acc).GE_HQ_New_Account_Country__c ;
      
      TCntISOHQC =  TCntHQ != null ?   mapISOCnt.containskey(TCntHQ.toUpperCase()) : false;
      TCntISOHQ =  (TCntHQ != null && TCntISOHQC) ?  mapISOCnt.get(TCntHQ.toUpperCase()) : TCntISOHQ;
      
      if(AccMapInfo.containskey(acc))    
        TStHQ = AccMapInfo.get(Acc).GE_HQ_New_Account_State_Province__c;
      TStISOHQC = TStHQ != null ?  mapISOSt.containskey(TStHQ) : false;
      TStISOHQ = (TStHQ != null && TStISOHQC) ? mapISOSt.get(TStHQ) : TStISOHQ;     
      
      List<String> SRgn = new List<String>();
      SRgn.add((TCntHQ != null && TStHQ != null && (CntStRgTMap.containskey(Tier+TCntHQ.toUpperCase()+TStHQ.toUpperCase()))) ? CntStRgTMap.get(Tier+TCntHQ.toUpperCase()+TStHQ.toUpperCase()).GE_HQ_Region__r.Name : (  TCntHQ != null && TCntHQ.length() == 2 && TCntISOHQC &&  TStHQ != null && TStHQ.length() == 2 && mapISOSt.containskey(TStHQ) && mapState.Containskey(mapISOSt.get(TStHQ)) && CntStRgTMap.containskey(Tier+TCntISOHQ+mapState.get(mapISOSt.get(TStHQ)) ) ?  CntStRgTMap.get(Tier+TCntISOHQ+mapState.get(mapISOSt.get(TStHQ)) ).GE_HQ_Region__r.Name  : ( TCntHQ != null && TCntHQ.length() == 2 && TCntISOHQC &&  TStHQ != null && TStHQ.length() != 2  && CntStRgTMap.containskey(Tier+TCntISOHQ+TStHQ.toUpperCase() ) ?  CntStRgTMap.get(Tier+TCntISOHQ+TStHQ.toUpperCase()).GE_HQ_Region__r.Name : ( TCntHQ != null && TCntHQ.length() != 2 &&  TStHQ != null && TStHQ.length() == 2 && mapISOSt.containskey(TStHQ) && mapState.Containskey(mapISOSt.get(TStHQ)) && CntStRgTMap.containskey(Tier+TCntHQ.toUpperCase()+mapState.get(mapISOSt.get(TStHQ)) ) ?  CntStRgTMap.get(Tier+TCntHQ.toUpperCase()+mapState.get(mapISOSt.get(TStHQ)) ).GE_HQ_Region__r.Name : ( TCntHQ != null  && CntRgTMap.containskey(Tier+TCntHQ.toUpperCase() ) ?  CntRgTMap.get(Tier+TCntHQ.toUpperCase() ).GE_HQ_Region__r.Name : ( TCntHQ != null && TCntHQ.length() == 2 && TCntISOHQC  && CntRgTMap.containskey(Tier+TCntISOHQ ) ?  CntRgTMap.get(Tier+TCntISOHQ).GE_HQ_Region__r.Name : (SR))))) ));
      SRgn.add((TCntHQ != null && TStHQ != null && (CntStRgTMap.containskey(Tier+TCntHQ.toUpperCase()+TStHQ.toUpperCase()))) ? CntStRgTMap.get(Tier+TCntHQ.toUpperCase()+TStHQ.toUpperCase()).GE_HQ_Sub_Region__r.Name : (  TCntHQ != null && TCntHQ.length() == 2 && TCntISOHQC &&  TStHQ != null && TStHQ.length() == 2 && mapISOSt.containskey(TStHQ) && mapState.Containskey(mapISOSt.get(TStHQ)) && CntStRgTMap.containskey(Tier+TCntISOHQ+mapState.get(mapISOSt.get(TStHQ)) ) ?  CntStRgTMap.get(Tier+TCntISOHQ+mapState.get(mapISOSt.get(TStHQ)) ).GE_HQ_Sub_Region__r.Name  : ( TCntHQ != null && TCntHQ.length() == 2 && TCntISOHQC &&  TStHQ != null && TStHQ.length() != 2  && CntStRgTMap.containskey(Tier+TCntISOHQ+TStHQ.toUpperCase() ) ?  CntStRgTMap.get(Tier+TCntISOHQ+TStHQ.toUpperCase()).GE_HQ_Sub_Region__r.Name : ( TCntHQ != null && TCntHQ.length() != 2 &&  TStHQ != null && TStHQ.length() == 2 && mapISOSt.containskey(TStHQ) && mapState.Containskey(mapISOSt.get(TStHQ)) && CntStRgTMap.containskey(Tier+TCntHQ.toUpperCase()+mapState.get(mapISOSt.get(TStHQ)) ) ?  CntStRgTMap.get(Tier+TCntHQ.toUpperCase()+mapState.get(mapISOSt.get(TStHQ)) ).GE_HQ_Sub_Region__r.Name : ( TCntHQ != null  && CntRgTMap.containskey(Tier+TCntHQ.toUpperCase() ) ?  CntRgTMap.get(Tier+TCntHQ.toUpperCase() ).GE_HQ_Sub_Region__r.Name : ( TCntHQ != null && TCntHQ.length() == 2 && TCntISOHQC  && CntRgTMap.containskey(Tier+TCntISOHQ ) ?  CntRgTMap.get(Tier+TCntISOHQ).GE_HQ_Sub_Region__r.Name : (SSR))))) ));
      system.debug('lasthqvalue'+SRgn);
      return SRgn;
      }
     
  
  
  
    
  
}