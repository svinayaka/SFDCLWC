/*    
Class Name        : GE_HQ_Get_Region
Purpose/Overview  : This Class works as a component to fetch the Region for a particular combination of Country+Business Tier+State+Function
Author            : Jayadev Rath
Test Class        : GE_HQ_Get_Region_Test
Change History    : Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
                  : 16th Dec 2011 : Jayadev Rath       : Created : Created for BC S-04199
                  : 17 dec 2013   : Revathi Veesam      :                               :Modified as a part of R-15296
                  : 03 sep 2014    :Tarani Dasari     : Modofied MCS risk region population as part of R-18436
                  : 26 Sep 2014   : Tarani Dasari    : Added logic for DTS Oppotunity records Risk region population as part of R-18281
                  : 7  Nov 2014     Pradeep Rao Yadagiri : finding reason for too many soql query exception while running test class 
                  : 15-Dec-2014     Satyanarayana Pusuluri Receive email notification when changes are made to Business Tier object for R-19699
*/
Public class GE_HQ_Get_Region {
    
    Public Static String[] getRegion(String Tier_Id, String Country_Id, String State_Id,String InputFunction) {
        system.debug('in GE_HQ_Get_Region ');
        String[] Result = new String[4]; // First var contains name and second contains the SFDC Id
        //String ErrMsg = null;  // error will be sent in result[0]
        String ChildId = null;
        
        // If Tier_Id is null return error message.
        if(Tier_Id == Null ) { 
            Result[0]='Invalid Tier Information'; 
            Result[1]=Null; 
            Result[2]=Null;
            Result[3]=Null;
            return Result; 
        } //Setting the region's SFDC id to null
        
        // Getting all the Tier_ids
        Map<Id,GE_HQ_P_L__c> BTList = new Map<Id,GE_HQ_P_L__c>([Select Id,Name,GE_HQ_P_L_Hierarchy_Level__c,GE_HQ_Parent_P_L_Name__c,GE_HQ_Inherit_Region__c from GE_HQ_P_L__c where GE_HQ_Is_Active__c= True limit 1000]);
        Set<String> AllTiers = new Set<String>();
        // Get all Business Tier names
        for(Id tier: BTList.keySet()){
            If(BTList.get(tier).Name != Null) AllTiers.add(BTList.get(tier).Name.toUpperCase());
            // If the Names are matching, this is our required record to start our search.
            If(Tier_Id.toUpperCase() == BTList.get(tier).Name.toUpperCase()) ChildId = tier;
            // BTList.get(tier).GE_HQ_Parent_P_L_Name__c;
        }
        if(!AllTiers.contains(Tier_Id.toUpperCase())) { 
            Result[0]='Tier information not found. Please provide correct Information'; 
            Result[1]=Null;
            Result[2]=Null;
            Result[3]=Null; 
            return Result; 
        }
        
        String CountryCode;
        // Getting all Country info
        Map<String, GE_HQ_Country__c> Countries = new Map<String, GE_HQ_Country__c>([Select Id,Name,GE_HQ_ISO_Code__c from GE_HQ_Country__c limit 1000]);
        Set<String> AllCountries = new Set<String>();
        Set<String> AllCountriesISOCodes = new Set<String>();
        Map<String, String> CountryISOCodes = new Map<String, String>();
        Map<String, String> ISOCodesCountry = new Map<String, String>();
        
        for(Id Cntry: Countries.keySet() ) {
            If (Countries.get(Cntry).Name !=Null ) { 
                AllCountries.add(Countries.get(Cntry).Name.toUpperCase()); 
                AllCountriesISOCodes.add(Countries.get(Cntry).GE_HQ_ISO_Code__c.toUpperCase());
                CountryISOCodes.put(Countries.get(Cntry).Name.toUpperCase(), Countries.get(Cntry).GE_HQ_ISO_Code__c);
                ISOCodesCountry.put(Countries.get(Cntry).GE_HQ_ISO_Code__c, Countries.get(Cntry).Name.toUpperCase());
            }
        }
        
        if(Country_Id == Null || (!AllCountries.contains(Country_Id.toUpperCase()) && !AllCountriesISOCodes.contains(Country_Id.toUpperCase()))) { 
            Result[0]='Invalid Country Information';  
            Result[1]=Null;
            Result[2]=Null;
            Result[3]=Null; 
            return Result; 
        }else if(Country_Id!=null && AllCountries.contains(Country_Id.toUpperCase())){
            CountryCode = CountryISOCodes.get(Country_Id.toUpperCase());
        } else if(Country_Id!=null && AllCountriesISOCodes.contains(Country_Id.toUpperCase())){
            CountryCode = Country_Id.toUpperCase();
            Country_Id  = ISOCodesCountry.get(Country_Id.toUpperCase());
        }
        
        // Getting all the functions.
        List<Schema.PicklistEntry> Functions = Schema.sObjectType.GE_HQ_Region__c.Fields.GE_HQ_Function__c.getPickListValues();
        Set<String> AllFunctions = new Set<String>();
        for(Schema.PicklistEntry f: Functions) {
            AllFunctions.add(f.getLabel().toUpperCase());
        }
        if(InputFunction== Null || !AllFunctions.contains(InputFunction.toUpperCase())) { InputFunction= 'Sales'; }
        
        // Get the Tier_Id's SFDC id and its parent Ids.
        List<Id> ParentIds = new List<Id>();
        // ChildId will never be null at this point, Coz, if it is null then no Tier_Id can exist and an error message will be thrown.
        ParentIds.add(ChildId); // This should also be searched.
        boolean isBubbleUP= BTList.get(ChildId).GE_HQ_Inherit_Region__c;
        if(isBubbleUP){
            while(ChildId != Null) {
                // Get the parent of the Tier record and add its Id also for searching
                Id Parent = BTList.get(ChildId).GE_HQ_Parent_P_L_Name__c;
                If(Parent != Null) ParentIds.add(Parent);
                ChildId = Parent; //BTList.get(ChildId).GE_HQ_Parent_P_L_Name__c;
            }
        }
        
        
        // limit the following by 1 result 
        System.debug('======Function====>>>'+InputFunction);
        System.debug('======Country_Id=====>>>>'+Country_Id);
        System.debug('======ParentIds====>>>>'+ParentIds );
        // If required limit the res by 1.. to reduce no of records

        Map<String, GE_HQ_State__c> States = new Map<String, GE_HQ_State__c> ([Select Id, Name, GE_HQ_ISO_Code__c from GE_HQ_State__c limit 1000]);
        Set<String> AllStates = new Set<String>();
        Map<String, String> stateISOCodes = new Map<String, String>();
        for(Id St: States.keySet()) {
            if(States.get(St).Name != Null) { 
                AllStates.add(States.get(St).Name.toUpperCase()); 
                stateISOCodes.put(States.get(St).GE_HQ_ISO_Code__c, States.get(St).Name.toUpperCase());
            }
        }
        if(State_Id != null && State_Id.length() == 2) State_Id = stateISOCodes.get(CountryCode + '-' + State_Id.toUpperCase());
        
        System.debug('======StateIds====>>>>'+State_Id );
        List<GE_HQ_Reg_Matrix__c> Suitable_Regions ;
        // change the query as per state availability
        if(State_Id == Null || !AllStates.contains(State_Id.toUpperCase() )){ 
            Suitable_Regions = [Select Id,GE_HQ_Region__c,GE_HQ_Sub_Region__c,GE_HQ_Region__r.Parent_Region__r.Name, GE_HQ_Region__r.Name from GE_HQ_Reg_Matrix__c where GE_HQ_Status__c= 'Active' and GE_HQ_Region__r.GE_HQ_Function__c = :InputFunction and GE_HQ_Country__r.Name = :Country_Id and GE_HQ_Region__r.GE_HQ_Business_Tier__c in :ParentIds Order by GE_HQ_Region__r.GE_HQ_Business_Tier__r.GE_HQ_P_L_Hierarchy_Level__c Desc];
        }else{
            Suitable_Regions = [Select Id,GE_HQ_Region__c,GE_HQ_Sub_Region__c,GE_HQ_Region__r.Parent_Region__r.Name, GE_HQ_Region__r.Name from GE_HQ_Reg_Matrix__c where GE_HQ_Status__c= 'Active' and GE_HQ_Region__r.GE_HQ_Function__c = :InputFunction and GE_HQ_Country__r.Name = :Country_Id and GE_HQ_State__r.Name like :State_Id and GE_HQ_Region__r.GE_HQ_Business_Tier__c in :ParentIds Order by GE_HQ_Region__r.GE_HQ_Business_Tier__r.GE_HQ_P_L_Hierarchy_Level__c Desc];
        }
        //temp with out status conditon
        //List<GE_HQ_Reg_Matrix__c> Suitable_Regions = [Select Id, GE_HQ_Region__r.Name from GE_HQ_Reg_Matrix__c where GE_HQ_Region__r.GE_HQ_Function__c = :InputFunction and GE_HQ_Country__r.Name = :Country_Id and GE_HQ_State__r.Name like :State_Id and GE_HQ_Region__r.GE_HQ_Business_Tier__c in :ParentIds Order by GE_HQ_Region__r.GE_HQ_Business_Tier__r.GE_HQ_P_L_Hierarchy_Level__c Desc];
        System.debug('=======Suitable_Regions==========>>>>> ::'+Suitable_Regions);
        
        //
        for(GE_HQ_Reg_Matrix__c g:Suitable_Regions ){        
        system.debug(g.GE_HQ_Region__r.Name);
        }
            //
        if(Suitable_Regions == Null || Suitable_Regions.size() <=0) {
            Result[0]='No Region exists for this combination. Please provide correct values.'; 
            Result[1]=Null;
            Result[2]=Null;
            Result[3]=Null; 
            return Result; 
        }
        System.debug('=====Parent_Region__c====>>>'+Suitable_Regions[0].GE_HQ_Region__r.Parent_Region__c);
        if(Suitable_Regions[0].GE_HQ_Region__r.Parent_Region__c!=null){
            Result[0] = Suitable_Regions[0].GE_HQ_Region__r.Parent_Region__r.Name;
            Result[1] = Suitable_Regions[0].GE_HQ_Region__r.Parent_Region__c;
            Result[2] = Suitable_Regions[0].GE_HQ_Region__r.Name;
            Result[3] = Suitable_Regions[0].GE_HQ_Region__c;
        }else{
            Result[0] = Suitable_Regions[0].GE_HQ_Region__r.Name;
            Result[1] = Suitable_Regions[0].GE_HQ_Region__c;
            Result[2] = null;
            Result[3] = null;
        }
        
        System.debug('=====Final Result===return====>>>'+Result);
        Return Result;
    }

    Public GE_HQ_Get_Region() {//ApexPages.StandardController controller 
    //Region = 'abc';
    }
    
    Public String InputFunction {get;set;}
    Public String Country {get;set;}
    Public String Tier {get;set;}
    Public String State {get;set;}
    Public String Region {get;set;}
    Public String RegionId {get;set;}
    Public String SubRegion {get;set;}
    Public String SubRegionId {get;set;}
    
    Public PageReference FindRegion() {
        String[] Res = getRegion(Tier, Country, State, InputFunction);
        System.debug('=====inside findRegion()==0==>>>'+Res[0]);
        System.debug('=====inside findRegion()==1==>>>'+Res[1]);
        System.debug('=====inside findRegion()==2==>>>'+Res[2]);
        System.debug('=====inside findRegion()==3==>>>'+Res[3]);
        Region = Res[0];
        RegionId = Res[1];
        SubRegion=Res[2];
        SubRegionId=Res[3];
        return null;
    }
    
    //Commented below code for Clean up
    //----------------------------------------------------- RISK PROCESS-------------------------------------------//
    //Author : kirtesh Jain
    //Purpose : To fatch Region value from Region object for correspondence Logic of Tier basis
    
     /*public static Map<Id,Id> getRegionIdForSpecificTier( List<Opportunity> OppRecords ) {
        //Opportunity OppRecord = new Opportunity();
       
        Id idVal;
        Map<Id,Id> optyNRegnMap=new Map<Id,Id>();
        
        //Prepare a map of region ids as values and tier values as key
        Map<String,Id> tierNRgnIdMap=new Map<String,Id>();
        //Added where cluase in the query as part of presit bug 18801 by Tarani.
        List<GE_HQ_Region__c> Regionlist=[Select Id,Name,GE_HQ_Derived_Tier_1__c,GE_HQ_Derived_Tier_2__c,GE_HQ_Derived_Tier_3__c,GE_HQ_Function__c,GE_OG_GS_Hub__c,Hierarchy_Level__c from GE_HQ_Region__c where GE_HQ_Derived_Tier_1__c='Oil & Gas (O&G)']; 
        for(GE_HQ_Region__c obj:Regionlist)
        {
            String key=''; 
     
            if(obj.GE_HQ_Derived_Tier_1__c!=null && obj.GE_HQ_Derived_Tier_1__c!='')
            key=key+obj.GE_HQ_Derived_Tier_1__c+'-';
            if(obj.GE_HQ_Derived_Tier_2__c!=null && obj.GE_HQ_Derived_Tier_2__c!='')
            key=key+obj.GE_HQ_Derived_Tier_2__c+'-';
            if(obj.GE_HQ_Derived_Tier_3__c!=null && obj.GE_HQ_Derived_Tier_3__c!='')
            key=key+obj.GE_HQ_Derived_Tier_3__c;
            
          
                
            if(key.endsWith('-'))
            key=key+obj.Name+'-'+obj.GE_HQ_Function__c;
            else
            key=key+'-'+obj.Name+'-'+obj.GE_HQ_Function__c;
            
            //add to map
            if(tierNRgnIdMap.get(key)==null)
            tierNRgnIdMap.put(key,obj.Id);
            else if(tierNRgnIdMap.get(key)!=null && obj.Hierarchy_Level__c=='Top Level Region')
            tierNRgnIdMap.put(key,obj.Id);
            
        }
                
        for(Opportunity OppRecord:OppRecords)
        {
            idVal=null;

         //Modifed the below condition for MCS as part of R-18436
            if( OppRecord.tier_2_ge_og__c ==  'Measurement & Control (M&C)'){
            idVal=getRegionID( OppRecord.GE_Tier2_Pregion__c , OppRecord,tierNRgnIdMap );
            } 
            if( OppRecord.tier_2_ge_og__c == 'Turbo Machinery'||OppRecord.GE_OG_rectype__c == 'OG TMS Unit Opportunity'||OppRecord.GE_OG_rectype__c == 'OG DTS Unit Opportunity'){
                 idVal=getRegionID( OppRecord.GE_OG_TM_Commercial_Center__c, OppRecord,tierNRgnIdMap) ;
            }
            if( OppRecord.tier_2_ge_og__c== 'PII Pipeline Solutions'  ){
                 idVal=getRegionID( OppRecord.GE_OG_PII_Ops_Region__c, OppRecord,tierNRgnIdMap) ;
            }

            if( OppRecord.tier_2_ge_og__c=='Drilling & Surface (D&S)' ){
                 idVal=getRegionID( OppRecord.GE_Tier2_IRegion__c, OppRecord,tierNRgnIdMap) ;
            }   
            
            if(OppRecord.tier_2_ge_og__c=='Subsea (SS)' ){
                 idVal=getRegionID( OppRecord.GE_Tier1_IRegion__c, OppRecord,tierNRgnIdMap) ;
            }  
         //Code added by revathi for Lufkin
         
            if( OppRecord.tier_2_ge_og__c=='Lufkin')
            {
            idVal=getRegionID( OppRecord.GE_Tier2_Pregion__c, OppRecord,tierNRgnIdMap) ;
            }          
          // Added logic for DTS Oppotunity records Risk region population as part of R-18281
            if(OppRecord.GE_OG_rectype__c == 'OG DTS Opportunity')
            {
            if(OppRecord.tier_4_ge_og__c=='DOS - New Units' ||OppRecord.tier_4_ge_og__c=='DOS - Installation')
            {
            idVal=getRegionID( OppRecord.GE_OG_TM_Commercial_Center__c, OppRecord,tierNRgnIdMap) ;
            }
            else{
            idVal=getRegionID( OppRecord.GE_Tier2_ERegion__c,OppRecord,tierNRgnIdMap) ;
            }
            } 
            //OG GS ---> Tier 3 + Hub
            //(Hub is picked up based upon End User Country. We are going to load the Tier 3 Hub values to Region object)
            //Data load done -Kirtesh 
            if( OppRecord.tier_2_ge_og__c == 'Global Services (GS)'|| OppRecord.GE_OG_rectype__c == 'OG TMS Service Opportunity'||OppRecord.GE_OG_rectype__c == 'OG DTS Service Opportunity' ){
                System.debug('******************OppRecord.Lead_PL__c***'+OppRecord.Lead_PL__c+'********OppRecord.Lead_PL__c**'+OppRecord.Lead_PL__r.Name);
                  if(OppRecord.Lead_PL__c == null || OppRecord.Lead_PL__c == Label.GS_PL_Record_Id || OppRecord.Lead_PL__c == Label.DTSS_PL_Record_Id || OppRecord.Lead_PL__c == Label.TMSS_PL_Record_Id  ){
                        idVal= getRegionID( OppRecord.GE_Tier2_ERegion__c , OppRecord, tierNRgnIdMap) ;
                  }else{
                        idVal=getGlobalServicesRegionId( OppRecord.GE_Tier2_ERegion__c , OppRecord, Regionlist) ;
                        
                  }
            }
            
            optyNRegnMap.put(OppRecord.Id,idVal);
        } 

        System.debug('--------optyNRegnMap--------'+optyNRegnMap);
        return optyNRegnMap;
   } 
     
     
  public static string getRegionID(string RegionName ,Opportunity OppRecord,Map<String,Id> tierNRgnIdMap){
    
    System.debug('------RegionName------'+RegionName);
    
    
    if(OppRecord.tier_2_ge_og__c ==  'Measurement & Control (M&C)' ||  OppRecord.tier_2_ge_og__c == 'Global Services (GS)' || Opprecord.GE_OG_rectype__c == 'OG TMS Service Opportunity'||Opprecord.GE_OG_rectype__c == 'OG DTS Service Opportunity'||OppRecord.tier_2_ge_og__c ==  'Lufkin')
    {
        if(tierNRgnIdMap.get(OppRecord.tier_1_ge_og__c+'-'+OppRecord.tier_2_ge_og__c+'-'+RegionName+'-Sales')!=null)
            return tierNRgnIdMap.get(OppRecord.tier_1_ge_og__c+'-'+OppRecord.tier_2_ge_og__c+'-'+RegionName+'-Sales');
        else if(tierNRgnIdMap.get(OppRecord.tier_1_ge_og__c+'-'+RegionName+'-Sales')!=null)
            return tierNRgnIdMap.get(OppRecord.tier_1_ge_og__c+'-'+RegionName+'-Sales');
                    
        /*for(GE_HQ_Region__c obj:Regionlist)
        {
                if(obj.GE_HQ_Derived_Tier_1__c == OppRecord.tier_1_ge_og__c && obj.GE_HQ_Derived_Tier_2__c == OppRecord.tier_2_ge_og__c && obj.Name == RegionName  && obj.GE_HQ_Function__c=='Sales')
                {
                    return obj.Id;
                }
        }*/     
    }
         // Added "DTS Opportuntiy" Condition also as part of R-18281
        /*  else if(OppRecord.GE_OG_rectype__c  == 'OG DTS Opportunity')
          {
            if(OppRecord.tier_4_ge_og__c=='DOS - New Units' ||OppRecord.tier_4_ge_og__c=='DOS - Installation')
            {
            if(tierNRgnIdMap.get(OppRecord.tier_1_ge_og__c+'-'+OppRecord.tier_2_ge_og__c+'-'+RegionName+'-Risk Process')!=null)
            return tierNRgnIdMap.get(OppRecord.tier_1_ge_og__c+'-'+OppRecord.tier_2_ge_og__c+'-'+RegionName+'-Risk Process');
        else if(tierNRgnIdMap.get(OppRecord.tier_1_ge_og__c+'-'+RegionName+'-Risk Process')!=null)
            return tierNRgnIdMap.get(OppRecord.tier_1_ge_og__c+'-'+RegionName+'-Risk Process');     
            }
            else
            {
            if(tierNRgnIdMap.get(OppRecord.tier_1_ge_og__c+'-'+OppRecord.tier_2_ge_og__c+'-'+RegionName+'-Sales')!=null)
            return tierNRgnIdMap.get(OppRecord.tier_1_ge_og__c+'-'+OppRecord.tier_2_ge_og__c+'-'+RegionName+'-Sales');
        else if(tierNRgnIdMap.get(OppRecord.tier_1_ge_og__c+'-'+RegionName+'-Sales')!=null)
            return tierNRgnIdMap.get(OppRecord.tier_1_ge_og__c+'-'+RegionName+'-Sales');
            }
          }
    else if(OppRecord.tier_2_ge_og__c == 'Turbo Machinery' || OppRecord.GE_OG_rectype__c  == 'OG TMS Unit Opportunity'||OppRecord.GE_OG_rectype__c  == 'OG DTS Unit Opportunity')
    {
        if(tierNRgnIdMap.get(OppRecord.tier_1_ge_og__c+'-'+OppRecord.tier_2_ge_og__c+'-'+RegionName+'-Risk Process')!=null)
            return tierNRgnIdMap.get(OppRecord.tier_1_ge_og__c+'-'+OppRecord.tier_2_ge_og__c+'-'+RegionName+'-Risk Process');
        else if(tierNRgnIdMap.get(OppRecord.tier_1_ge_og__c+'-'+RegionName+'-Risk Process')!=null)
            return tierNRgnIdMap.get(OppRecord.tier_1_ge_og__c+'-'+RegionName+'-Risk Process');     
        /*for(GE_HQ_Region__c obj:Regionlist)
        {
                if(obj.GE_HQ_Derived_Tier_1__c == OppRecord.tier_1_ge_og__c && obj.GE_HQ_Derived_Tier_2__c == OppRecord.tier_2_ge_og__c && obj.Name == RegionName  && obj.GE_HQ_Function__c=='Risk Process')
                {
                    return obj.Id;
                }
        }*/     
    //code added for new TMS and DTS opportunities
   /* else
    if(OppRecord.GE_OG_rectype__c  == 'OG TMS Unit Opportunity'||OppRecord.GE_OG_rectype__c  == 'OG DTS Unit Opportunity')
    {    
        if(tierNRgnIdMap.get(OppRecord.tier_1_ge_og__c+'-Turbo Machinery'+'-'+RegionName+'-Risk Process')!=null)
            return tierNRgnIdMap.get(OppRecord.tier_1_ge_og__c+'-Turbo Machinery'+'-'+RegionName+'-Risk Process');
        else if(tierNRgnIdMap.get(OppRecord.tier_1_ge_og__c+'-'+RegionName+'-Risk Process')!=null)
            return tierNRgnIdMap.get(OppRecord.tier_1_ge_og__c+'-'+RegionName+'-Risk Process');     
      
    }*/
     //code end added for new TMS and DTS opportunities
   /* else
    if(OppRecord.tier_2_ge_og__c== 'PII Pipeline Solutions')
    {
        if(tierNRgnIdMap.get(OppRecord.tier_1_ge_og__c+'-'+OppRecord.tier_2_ge_og__c+'-'+RegionName+'-Operations')!=null)
            return tierNRgnIdMap.get(OppRecord.tier_1_ge_og__c+'-'+OppRecord.tier_2_ge_og__c+'-'+RegionName+'-Operations');
        else if(tierNRgnIdMap.get(OppRecord.tier_1_ge_og__c+'-'+RegionName+'-Operations')!=null)
            return tierNRgnIdMap.get(OppRecord.tier_1_ge_og__c+'-'+RegionName+'-Operations');
                    
        /*for(GE_HQ_Region__c obj:Regionlist)
        {
                if(obj.GE_HQ_Derived_Tier_1__c == OppRecord.tier_1_ge_og__c && obj.GE_HQ_Derived_Tier_2__c == OppRecord.tier_2_ge_og__c && obj.Name == RegionName  && obj.GE_HQ_Function__c=='Operations')
                {
                    return obj.Id;
                }
        }*/                 
   /* }else if(OppRecord.tier_2_ge_og__c=='Drilling & Surface (D&S)' )
    {
        
        
        
        if(tierNRgnIdMap.get(OppRecord.tier_1_ge_og__c+'-'+OppRecord.tier_2_ge_og__c+'-'+RegionName+'-Sales')!=null)
            return tierNRgnIdMap.get(OppRecord.tier_1_ge_og__c+'-'+OppRecord.tier_2_ge_og__c+'-'+RegionName+'-Sales');
        else if(tierNRgnIdMap.get(OppRecord.tier_1_ge_og__c+'-'+RegionName+'-Sales')!=null)
            return tierNRgnIdMap.get(OppRecord.tier_1_ge_og__c+'-'+RegionName+'-Sales');
     
     }else if( OppRecord.tier_2_ge_og__c=='Subsea (SS)'){
            
            if(tierNRgnIdMap.get(OppRecord.tier_1_ge_og__c+'-'+RegionName+'-Sales')!=null)
                    return tierNRgnIdMap.get(OppRecord.tier_1_ge_og__c+'-'+RegionName+'-Sales');
    }
 
     return null;
  }
  
  public static string getGlobalServicesRegionId(string RegionName , Opportunity OppRecord, List<GE_HQ_Region__c> Regionlist){
    
     
   
        String strHub='';
        for(GE_HQ_Region__c obj:Regionlist)
        {
            if( obj.Name ==  RegionName &&  obj.GE_HQ_Derived_Tier_2__c == OppRecord.tier_2_ge_og__c  && obj.GE_HQ_Function__c == 'Sales')
                {
                    strHub= obj.GE_OG_GS_Hub__c;
                    break;
                    
                }   
        }
    
        if(strHub!='' ){
            
            string tier3Hub =    OppRecord.tier_3_ge_og__c+' - '+strHub;
      
            for(GE_HQ_Region__c obj:Regionlist)
            {    
                if(obj.Name == tier3Hub && obj.GE_HQ_Function__c == 'Risk Process')
                    {
                        return obj.Id; 
                    }   
            }
        }
         return null;
  
    }
  
    public static void NotifyUsersOnInsertBusinessTier(List<GE_HQ_P_L__c> btiers) {
        String BusineesTierNotifyUsers = Label.BusineesTierNotifyUser;
        if ( BusineesTierNotifyUsers != '' ) {
            String changesMade = 'Please note the following changes in O&G Business Tier:-<br/><br/>';
            String stringSubject;
            Set<Id> businessTierIds = new Set<Id>();
            for(GE_HQ_P_L__c btier: btiers) {
              businessTierIds.add(btier.GE_HQ_Parent_P_L_Name__c);
            }
            id CreatedByids = null;
            Map<String, GE_HQ_P_L__c> chainBTs = new Map<String, GE_HQ_P_L__c>([SELECT Id, Name,CreatedByid, GE_HQ_Is_Active__c, GE_HQ_P_L_ID__c,GE_OG_Comments__c,
                                              GE_HQ_Parent_P_L_Name__r.Name,
                                              GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__r.Name,
                                              GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__r.Name,
                                              GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__r.Name,
                                              GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__r.Name,
                                              GE_HQ_P_L_Hierarchy_Level__c FROM GE_HQ_P_L__c WHERE Id IN :businessTierIds]);
            GE_HQ_P_L__c newBusinessTier = new GE_HQ_P_L__c();
            for(GE_HQ_P_L__c newBts: btiers) {
                System.debug('New Business tier value:>>>>>'+newBts);
                if(newBts.GE_HQ_P_L_Hierarchy_Level__c == 0) {
                    changesMade += 'New Business Tier <b>'+newBts.Name+'</b> has been added at <b>'+'Business Tier 0</b><br/>';
                    //changesMade += 'If there are any questions regarding the enclosed O&G Business Tier updates please contact '+ chainBTs.get(newBts.GE_HQ_Parent_P_L_Name__c).CreatedBy.Name +' at '+ newBts.CreatedBy.Email+'<br/><br/>';   
                }
                if(newBts.GE_HQ_P_L_Hierarchy_Level__c == 1) {
                    changesMade += 'New Business Tier <b>'+newBts.Name+'</b> has been added at <b>'+'Business Tier 1</b><br/>';
                    changesMade += 'Business Tier 0 Parent P&L Name :<b>'+chainBTs.get(newBts.GE_HQ_Parent_P_L_Name__c).Name+'</b><br/>';
                    //changesMade += 'If there are any questions regarding the enclosed O&G Business Tier updates please contact '+ newBts.CreatedBy.Name +' at '+ newBts.CreatedBy.Email+'<br/><br/>';   
                }
                if(newBts.GE_HQ_P_L_Hierarchy_Level__c == 2) {
                    changesMade += 'New Business Tier <b>'+newBts.Name+'</b> has been added at <b>'+'Business Tier 2</b><br/>';
                    changesMade += 'Business Tier 1 Parent P&L Name :<b>'+chainBTs.get(newBts.GE_HQ_Parent_P_L_Name__c).Name+'</b><br/>';
                    changesMade += 'Business Tier 0 : <b>'+chainBTs.get(newBts.GE_HQ_Parent_P_L_Name__c).GE_HQ_Parent_P_L_Name__r.Name+'</b><br/>'; 
                    //changesMade += 'If there are any questions regarding the enclosed O&G Business Tier updates please contact '+ newBts.CreatedBy +' at '+ newBts.CreatedBy.Email+'<br/><br/>';    
                }
                if(newBts.GE_HQ_P_L_Hierarchy_Level__c == 3) {
                    changesMade += 'New Business Tier <b>'+newBts.Name+'</b> has been added at <b>'+'Business Tier 3</b><br/>';
                    changesMade += 'Business Tier 2 Parent P&L Name :<b>'+chainBTs.get(newBts.GE_HQ_Parent_P_L_Name__c).Name+'</b><br/>';
                    changesMade += 'Business Tier 1 :<b>'+chainBTs.get(newBts.GE_HQ_Parent_P_L_Name__c).GE_HQ_Parent_P_L_Name__r.Name+'</b><br/>';
                    changesMade += 'Business Tier 0 :<b>'+chainBTs.get(newBts.GE_HQ_Parent_P_L_Name__c).GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__r.Name+'</b><br/>';
                    //changesMade += 'If there are any questions regarding the enclosed O&G Business Tier updates please contact '+ newBts.CreatedBy.Name +' at '+ newBts.CreatedBy.Email+'<br/><br/>';   
                }
                if(newBts.GE_HQ_P_L_Hierarchy_Level__c == 4) {
                    changesMade += 'New Business Tier <b>'+newBts.Name+'</b> has been added at <b>'+'Business Tier 4</b><br/>';
                    changesMade += 'Business Tier 3 Parent P&L Name :<b>'+chainBTs.get(newBts.GE_HQ_Parent_P_L_Name__c).Name+'</b><br/>';
                    changesMade += 'Business Tier 2 :<b>'+chainBTs.get(newBts.GE_HQ_Parent_P_L_Name__c).GE_HQ_Parent_P_L_Name__r.Name+'</b><br/>';
                    changesMade += 'Business Tier 1 :<b>'+chainBTs.get(newBts.GE_HQ_Parent_P_L_Name__c).GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__r.Name+'</b><br/>';
                    changesMade += 'Business Tier 0 :<b>'+chainBTs.get(newBts.GE_HQ_Parent_P_L_Name__c).GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__r.Name+'</b><br/>';                                     
                    //changesMade += 'If there are any questions regarding the enclosed O&G Business Tier updates please contact '+ newBts.CreatedBy.Name +' at '+ newBts.CreatedBy.Email+'<br/><br/>';   
                }
                if(newBts.GE_HQ_P_L_Hierarchy_Level__c == 5) {
                    changesMade += 'New Business Tier <b>'+newBts.Name+'</b> has been added at <b>'+'Business Tier 5</b><br/>';
                    changesMade += 'Business Tier 4 Parent P&L Name :<b>'+chainBTs.get(newBts.GE_HQ_Parent_P_L_Name__c).Name+'</b><br/>';
                    changesMade += 'Business Tier 3 :<b>'+chainBTs.get(newBts.GE_HQ_Parent_P_L_Name__c).GE_HQ_Parent_P_L_Name__r.Name+'</b><br/>';
                    changesMade += 'Business Tier 2 :<b>'+chainBTs.get(newBts.GE_HQ_Parent_P_L_Name__c).GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__r.Name+'</b><br/>';
                    changesMade += 'Business Tier 1 :<b>'+chainBTs.get(newBts.GE_HQ_Parent_P_L_Name__c).GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__r.Name+'</b><br/>';
                    changesMade += 'Business Tier 0 :<b>'+chainBTs.get(newBts.GE_HQ_Parent_P_L_Name__c).GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__r.Name+'</b><br/>';
                    //changesMade += 'If there are any questions regarding the enclosed O&G Business Tier updates please contact '+ newBts.CreatedBy.Name +' at '+ newBts.CreatedBy.Email+'<br/><br/>';   
                }
                changesMade += 'P&L ID : <b>'+newBts.GE_HQ_P_L_ID__c+'</b> <br/>';
                changesMade += 'Is Active? : <b>'+newBts.GE_HQ_Is_Active__c+'</b><br/>';  
                changesMade += 'Comments : <b>'+newBts.GE_OG_Comments__c+'</b><br/><br/><br/>';  
                CreatedByids = newBts.CreatedByid;  
            }

            User currentUser = [select id, firstname, lastname, email FROM User WHERE id =: CreatedByids ];

            changesMade += 'If there are any questions regarding the enclosed O&G Business Tier updates please contact '+currentUser.firstname+' '+currentUser.lastname+' at '+currentUser.email+'<br/><br/>';
            changesMade += 'Thank You!<br/>'+'<b>GE Oil and Gas Team</b>';
            changesMade = changesMade.replace('null','Blank');
            String urlCode = String.valueof(URL.getSalesforceBaseUrl().toExternalForm());
            if(urlCode.contains('geog--ogdev')) {
                stringSubject = 'Automated Email Notification: O&G Business Tiers Inserted in DEV by '+currentUser.firstname+' '+currentUser.lastname+' - '+System.now().format('MM-dd-yyyy'); 
                System.debug('Printing for OGDEV:>>>'+stringSubject);
            }
            
            else if(urlCode.contains('geog--ogtest')) {
                stringSubject = 'Automated Email Notification: O&G Business Tiers Inserted in TEST by '+currentUser.firstname+' '+currentUser.lastname+' - '+System.now().format('MM-dd-yyyy'); 
                System.debug('Printing for OGTEST:>>>'+stringSubject);
            }
            
            else if(urlCode.contains('geog.my')) {
                stringSubject = 'Automated Email Notification: O&G Business Tiers Inserted in Production by '+currentUser.firstname+' '+currentUser.lastname+' - '+System.now().format('MM-dd-yyyy'); 
                System.debug('Printing for Production:>>>'+stringSubject);
            }
            String nonSFMails = Label.BusineesTierNotifyUser;
            System.debug('non sf emails'+nonSFMails);
            List<String> listOfNonSFUsers = nonSFMails.split(',');

            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage(); 
            String[] toAddresses =  nonSFMails.split(',');
            mail.setToAddresses(toAddresses);
            mail.setSubject(stringSubject);
            mail.setHtmlBody(changesMade);
            if(!Test.isRunningTest())
                Messaging.sendEmail(new Messaging.SingleEMailMessage[]{mail});
            
        }
    }
    
    public static void NotifyUsersOnUpdateBusinessTier(List<GE_HQ_P_L__c> btiers, List<GE_HQ_P_L__c> btiersOld){
        String BusineesTierNotifyUsers = Label.BusineesTierNotifyUser;
        if ( BusineesTierNotifyUsers != '' ) {
            String changesMade = 'Please note the following changes in O&G Business Tier:-<br/><br/>';
            String stringSubject;
            Set<Id> businessTierIds = new Set<Id>();
            Set<Id> oldListBTs = new Set<Id>();
            
            for(GE_HQ_P_L__c previousBT: btiersOld) {
              oldListBTs.add(previousBT.GE_HQ_Parent_P_L_Name__c);
            }
            
            for(GE_HQ_P_L__c btier: btiers) {
              businessTierIds.add(btier.GE_HQ_Parent_P_L_Name__c);
            }
            
            id LastModifiedByids = null;
            Map<String, GE_HQ_P_L__c> chainBTs = new Map<String, GE_HQ_P_L__c>([SELECT Id, Name,GE_HQ_Is_Active__c, GE_HQ_P_L_ID__c,LastModifiedByid,GE_OG_Comments__c,
                                              GE_HQ_Parent_P_L_Name__r.Name,
                                              GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__r.Name,
                                              GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__r.Name,
                                              GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__r.Name,
                                              GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__r.Name,
                                              GE_HQ_P_L_Hierarchy_Level__c FROM GE_HQ_P_L__c WHERE Id IN :businessTierIds]);

            Map<String,GE_HQ_P_L__c> oldBTiersName = new Map<String, GE_HQ_P_L__c>([SELECT Id, Name,GE_HQ_Is_Active__c, GE_HQ_P_L_ID__c,
                                                  GE_HQ_Parent_P_L_Name__r.Name,
                                              GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__r.Name,
                                              GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__r.Name,
                                              GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__r.Name,
                                              GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__r.Name,
                                              GE_HQ_P_L_Hierarchy_Level__c FROM GE_HQ_P_L__c WHERE Id IN :oldListBTs]);
            
            for(GE_HQ_P_L__c newBts: btiers) {
                GE_HQ_P_L__c oldBTiers = new GE_HQ_P_L__c();
                for(GE_HQ_P_L__c oldBT: btiersOld) {
                    oldBTiers = oldBT;
                }
               
                System.debug('Old business tier value:>>>>>'+oldBTiers.GE_HQ_Parent_P_L_Name__c);
                if(newBts.GE_HQ_P_L_Hierarchy_Level__c == 0) {
                    if(oldBTiers.Name != newBts.Name) {
                        changesMade += 'P&L Name been changed from <b>'+oldBTiers.Name+'</b> to <b>'+newBts.Name+'</b><br/>';                     
                    }                
                    if(oldBTiers.Name == newBts.Name) {
                      changesMade += 'Business Tier 0 P&L Name :<b>'+newBts.Name+'</b><br/>';
                    }
                }
                
                if(newBts.GE_HQ_P_L_Hierarchy_Level__c == 1) {
                    if(oldBTiers.Name != newBts.Name) {
                      changesMade += 'Business Tier 1 P&L Name been changed from <b>'+oldBTiers.Name+'</b> to <b>'+newBts.Name+'</b><br/>';
                    }
                    if(oldBTiers.Name == newBts.Name) {
                      changesMade += 'Business Tier 1 P&L Name :<b>'+newBts.Name+'</b><br/>';
                    }
                    
                    if(oldBTiers.GE_HQ_Parent_P_L_Name__c != newBts.GE_HQ_Parent_P_L_Name__c) {
                      changesMade += 'Parent P&L Name of <b>'+oldBTiers.Name+'</b> has been changed from <b>'+oldBTiersName.get(oldBTiers.GE_HQ_Parent_P_L_Name__c).Name+'</b>(Hierarchy '+oldBTiers.GE_HQ_P_L_Hierarchy_Level__c+') to <b>'+chainBTs.get(newBts.GE_HQ_Parent_P_L_Name__c).Name+'</b><br/>';
                      changesMade += 'Business Tier 0 Parent P&L Name :<b>'+chainBTs.get(newBts.GE_HQ_Parent_P_L_Name__c).Name+'</b><br/>';
                    }
                    if(oldBTiers.GE_HQ_Parent_P_L_Name__c == newBts.GE_HQ_Parent_P_L_Name__c) {
                      changesMade += 'Business Tier 0 Parent P&L Name :<b>'+chainBTs.get(newBts.GE_HQ_Parent_P_L_Name__c).Name+'</b><br/>';
                    }
                }
                
                if(newBts.GE_HQ_P_L_Hierarchy_Level__c == 2) {
                    if(oldBTiers.Name != newBts.Name) {
                      changesMade += 'Business Tier 2 P&L Name been changed from <b>'+oldBTiers.Name+'</b> to <b>'+newBts.Name+'</b><br/>';
                    }
                    if(oldBTiers.Name == newBts.Name) {
                      changesMade += 'Business Tier 2 P&L Name :<b>'+newBts.Name+'</b><br/>';
                    }
                    
                    if(oldBTiers.GE_HQ_Parent_P_L_Name__c != newBts.GE_HQ_Parent_P_L_Name__c) {
                      changesMade += 'Parent P&L Name of <b>'+oldBTiers.Name+'</b> has been changed from <b>'+oldBTiersName.get(oldBTiers.GE_HQ_Parent_P_L_Name__c).Name+'</b>(Hierarchy '+oldBTiers.GE_HQ_P_L_Hierarchy_Level__c+') to <b>'+chainBTs.get(newBts.GE_HQ_Parent_P_L_Name__c).Name+'</b><br/>';
                      changesMade += 'Business Tier 1 Parent P&L Name :<b>'+chainBTs.get(newBts.GE_HQ_Parent_P_L_Name__c).Name+'</b><br/>';
                    }
                    if(oldBTiers.GE_HQ_Parent_P_L_Name__c == newBts.GE_HQ_Parent_P_L_Name__c) {
                      changesMade += 'Business Tier 1 Parent P&L Name :<b>'+chainBTs.get(newBts.GE_HQ_Parent_P_L_Name__c).Name+'</b><br/>';
                    }
                    changesMade += 'Business Tier 0 : <b>'+chainBTs.get(newBts.GE_HQ_Parent_P_L_Name__c).GE_HQ_Parent_P_L_Name__r.Name+'</b><br/>'; 
                }
                
                if(newBts.GE_HQ_P_L_Hierarchy_Level__c == 3) {
                    if(oldBTiers.Name != newBts.Name) {
                      changesMade += 'Business Tier 3 P&L Name been changed from <b>'+oldBTiers.Name+'</b> to <b>'+newBts.Name+'</b><br/>';
                    }
                    if(oldBTiers.Name == newBts.Name) {
                      changesMade += 'Business Tier 3 P&L Name :<b>'+newBts.Name+'</b><br/>';
                    }
                    
                    if(oldBTiers.GE_HQ_Parent_P_L_Name__c != newBts.GE_HQ_Parent_P_L_Name__c) {
                      changesMade += 'Parent P&L Name of <b>'+oldBTiers.Name+'</b> has been changed from <b>'+oldBTiersName.get(oldBTiers.GE_HQ_Parent_P_L_Name__c).Name+'</b>(Hierarchy '+oldBTiers.GE_HQ_P_L_Hierarchy_Level__c+') to <b>'+chainBTs.get(newBts.GE_HQ_Parent_P_L_Name__c).Name+'</b><br/>';
                      changesMade += 'Business Tier 2 Parent P&L Name <b>'+chainBTs.get(newBts.GE_HQ_Parent_P_L_Name__c).Name+'</b><br/>';
                    }
                    if(oldBTiers.GE_HQ_Parent_P_L_Name__c == newBts.GE_HQ_Parent_P_L_Name__c) {
                      changesMade += 'Business Tier 2 Parent P&L Name :<b>'+chainBTs.get(newBts.GE_HQ_Parent_P_L_Name__c).Name+'</b><br/>';
                    }
                    changesMade += 'Business Tier 1 :<b>'+chainBTs.get(newBts.GE_HQ_Parent_P_L_Name__c).GE_HQ_Parent_P_L_Name__r.Name+'</b><br/>';
                    changesMade += 'Business Tier 0 :<b>'+chainBTs.get(newBts.GE_HQ_Parent_P_L_Name__c).GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__r.Name+'</b><br/>';                                        
                }
                
                if(newBts.GE_HQ_P_L_Hierarchy_Level__c == 4) {
                    if(oldBTiers.Name != newBts.Name) {
                      changesMade += 'Business Tier 4 P&L Name been changed from <b>'+oldBTiers.Name+'</b> to <b>'+newBts.Name+'</b><br/>';
                    }
                    if(oldBTiers.Name == newBts.Name) {
                      changesMade += 'Business Tier 4 P&L Name :<b>'+newBts.Name+'</b><br/>';
                    }
                    
                    if(oldBTiers.GE_HQ_Parent_P_L_Name__c != newBts.GE_HQ_Parent_P_L_Name__c) {
                      changesMade += 'Parent P&L Name of <b>'+oldBTiers.Name+'</b> has been changed from <b>'+oldBTiersName.get(oldBTiers.GE_HQ_Parent_P_L_Name__c).Name+'</b>(Hierarchy '+oldBTiers.GE_HQ_P_L_Hierarchy_Level__c+') to <b>'+chainBTs.get(newBts.GE_HQ_Parent_P_L_Name__c).Name+'</b><br/>';
                      changesMade += 'Business Tier 3 Parent P&L Name :<b>'+chainBTs.get(newBts.GE_HQ_Parent_P_L_Name__c).Name+'</b><br/>';
                    }
                    if(oldBTiers.GE_HQ_Parent_P_L_Name__c == newBts.GE_HQ_Parent_P_L_Name__c) {
                      changesMade += 'Business Tier 3 Parent P&L Name :<b>'+chainBTs.get(newBts.GE_HQ_Parent_P_L_Name__c).Name+'</b><br/>';
                    }
                    
                    changesMade += 'Business Tier 2 :<b>'+chainBTs.get(newBts.GE_HQ_Parent_P_L_Name__c).GE_HQ_Parent_P_L_Name__r.Name+'</b><br/>';
                    changesMade += 'Business Tier 1 :<b>'+chainBTs.get(newBts.GE_HQ_Parent_P_L_Name__c).GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__r.Name+'</b><br/>';
                    changesMade += 'Business Tier 0 :<b>'+chainBTs.get(newBts.GE_HQ_Parent_P_L_Name__c).GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__r.Name+'</b><br/>';                
                    
                }
                
                if(newBts.GE_HQ_P_L_Hierarchy_Level__c == 5) {
                    if(oldBTiers.Name != newBts.Name) {
                      changesMade += 'Business Tier 5 P&L Name been changed from <b>'+oldBTiers.Name+'</b> to <b>'+newBts.Name+'</b><br/>';
                    }
                    if(oldBTiers.Name == newBts.Name) {
                      changesMade += 'Business Tier 5 P&L Name :<b>'+newBts.Name+'</b><br/>';
                    }
                    
                    if(oldBTiers.GE_HQ_Parent_P_L_Name__c != newBts.GE_HQ_Parent_P_L_Name__c) {
                      changesMade += 'Parent P&L Name of <b>'+oldBTiers.Name+'</b> has been changed from <b>'+oldBTiersName.get(oldBTiers.GE_HQ_Parent_P_L_Name__c).Name+'</b>(Hierarchy '+oldBTiers.GE_HQ_P_L_Hierarchy_Level__c+') to <b>'+chainBTs.get(newBts.GE_HQ_Parent_P_L_Name__c).Name+'</b><br/>';
                      changesMade += 'Business Tier 4 Parent P&L Name :<b>'+chainBTs.get(newBts.GE_HQ_Parent_P_L_Name__c).Name+'</b><br/>';
                    }
                    if(oldBTiers.GE_HQ_Parent_P_L_Name__c == newBts.GE_HQ_Parent_P_L_Name__c) {
                      changesMade += 'Business Tier 4 Parent P&L Name :<b>'+chainBTs.get(newBts.GE_HQ_Parent_P_L_Name__c).Name+'</b><br/>';
                    }
                    
                    changesMade += 'Business Tier 3 :<b>'+chainBTs.get(newBts.GE_HQ_Parent_P_L_Name__c).GE_HQ_Parent_P_L_Name__r.Name+'</b><br/>';
                    changesMade += 'Business Tier 2 :<b>'+chainBTs.get(newBts.GE_HQ_Parent_P_L_Name__c).GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__r.Name+'</b><br/>';
                    changesMade += 'Business Tier 1 :<b>'+chainBTs.get(newBts.GE_HQ_Parent_P_L_Name__c).GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__r.Name+'</b><br/>';                    
                    changesMade += 'Business Tier 0 :<b>'+chainBTs.get(newBts.GE_HQ_Parent_P_L_Name__c).GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__r.Name+'</b><br/>';
                }
                
                if(oldBTiers.GE_HQ_P_L_ID__c != newBts.GE_HQ_P_L_ID__c) {
                  changesMade += 'P&L ID been changed from <b>'+oldBTiers.GE_HQ_P_L_ID__c+'</b> to <b>'+newBts.GE_HQ_P_L_ID__c+'</b><br/>';
                }
                if(oldBTiers.GE_HQ_P_L_ID__c == newBts.GE_HQ_P_L_ID__c) {
                  changesMade += 'P&L ID : <b>'+newBts.GE_HQ_P_L_ID__c+'</b><br/>';
                }
                if(oldBTiers.GE_HQ_Is_Active__c != newBts.GE_HQ_Is_Active__c) {
                  changesMade += 'Is Active changed from <b>'+oldBTiers.GE_HQ_Is_Active__c+'</b> to <b>'+newBts.GE_HQ_Is_Active__c+'</b><br/>';
                }
                if(oldBTiers.GE_HQ_Is_Active__c == newBts.GE_HQ_Is_Active__c) {
                  changesMade += 'Is Active : <b>'+newBts.GE_HQ_Is_Active__c+'</b><br/>';
                }   
                changesMade += 'Comments : <b>'+newBts.GE_OG_Comments__c+'</b><br/><br/><br/>';  
                LastModifiedByids = newBts.LastModifiedByid;
            }
            
            User currentUser = [select id, firstname, lastname, email FROM User WHERE id =: LastModifiedByids ];

            changesMade += 'If there are any questions regarding the enclosed O&G Business Tier updates please contact '+currentUser.firstname+' '+currentUser.lastname+' at '+currentUser.email+'<br/><br/>';
            //changesMade += 'If there are any questions regarding the enclosed O&G Business Tier updates please contact Admin <br/><br/>';
            changesMade += 'Thank You!<br/>'+'<b>GE Oil and Gas Team</b>';
            changesMade = changesMade.replace('null','Blank');
        
            String urlCode = String.valueof(URL.getSalesforceBaseUrl().toExternalForm());
            if(urlCode.contains('geog--ogdev')) {
                stringSubject = 'Automated Email Notification: O&G Business Tiers updated in DEV by '+currentUser.firstname+' '+currentUser.lastname+' - '+System.now().format('MM-dd-yyyy'); 
                System.debug('Printing for OGDEV:>>>'+stringSubject);
            }
            
            else if(urlCode.contains('geog--ogtest')) {
                stringSubject = 'Automated Email Notification: O&G Business Tiers updated in TEST by '+currentUser.firstname+' '+currentUser.lastname+' - '+System.now().format('MM-dd-yyyy'); 
                System.debug('Printing for OGTEST:>>>'+stringSubject);
            }
            
            else if(urlCode.contains('geog.my')) {
                stringSubject = 'Automated Email Notification: O&G Business Tiers updated in Production by '+currentUser.firstname+' '+currentUser.lastname+' - '+System.now().format('MM-dd-yyyy'); 
                System.debug('Printing for Production:>>>'+stringSubject);
            }
            String nonSFMails = Label.BusineesTierNotifyUser;
            System.debug('non sf emails'+nonSFMails);
            List<String> listOfNonSFUsers = nonSFMails.split(',');

            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage(); 
            String[] toAddresses =  nonSFMails.split(',');
            mail.setToAddresses(toAddresses);
            mail.setSubject(stringSubject);
            mail.setHtmlBody(changesMade);
            if(!Test.isRunningTest())
                Messaging.sendEmail(new Messaging.SingleEMailMessage[]{mail});
        }
    }
    
    public static void NotifyUsersOnDeleteBusinessTier(List<GE_HQ_P_L__c> oldBTstoDelete) {
        String BusineesTierNotifyUsers = Label.BusineesTierNotifyUser;
        if ( BusineesTierNotifyUsers != '' ) {
            String changesMade = 'Please note the following changes in O&G Business Tier:-<br/><br/>';
            String stringSubject;
            Set<Id> lstId = new Set<Id>();
            GE_HQ_P_L__c aboutToDeleteBTs = new GE_HQ_P_L__c();
            Decimal i;
            for(GE_HQ_P_L__c deleteBTs: oldBTstoDelete){
                lstId.add(deleteBTs.Id);
                i = deleteBTs.GE_HQ_P_L_Hierarchy_Level__c;
            }
            
            id LastModifiedByids = null;
            
            Map<String,GE_HQ_P_L__c> oldBTiersName = new Map<String, GE_HQ_P_L__c>([SELECT Id, Name,GE_HQ_Is_Active__c, GE_HQ_P_L_ID__c,LastModifiedByid,GE_OG_Comments__c,
                                              GE_HQ_Parent_P_L_Name__r.Name,
                                              GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__r.Name,
                                              GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__r.Name,
                                              GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__r.Name,
                                              GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__r.Name,
                                              GE_HQ_P_L_Hierarchy_Level__c FROM GE_HQ_P_L__c WHERE GE_HQ_P_L_Hierarchy_Level__c <= :i]);

            for(GE_HQ_P_L__c aboutToDeleteBTsCopy: oldBTstoDelete) {
                System.debug('Business Tier deleted:>>>>>>'+aboutToDeleteBTsCopy.Id);
                if(aboutToDeleteBTsCopy.GE_HQ_P_L_Hierarchy_Level__c == 0) {
                      changesMade += 'P&L Name <b>'+aboutToDeleteBTsCopy.Name+' </b>has been Deleted at <b>Business Tier 0</b><br/><br/><br/>';
                }
                if(aboutToDeleteBTsCopy.GE_HQ_P_L_Hierarchy_Level__c == 1) {
                      changesMade += 'P&L Name <b>'+aboutToDeleteBTsCopy.Name+' </b>has been Deleted at <b>Business Tier 1</b><br/>';
                      changesMade += 'Business Tier 0 Parent P&L Name :<b>'+oldBTiersName.get(aboutToDeleteBTsCopy.GE_HQ_Parent_P_L_Name__c).Name+'</b><br/>';
                }
                if(aboutToDeleteBTsCopy.GE_HQ_P_L_Hierarchy_Level__c == 2) {
                      changesMade += 'P&L Name <b>'+aboutToDeleteBTsCopy.Name+' </b>has been Deleted at <b>Business Tier 2</b><br/>';
                      changesMade += 'Business Tier 1 Parent P&L Name :<b>'+oldBTiersName.get(aboutToDeleteBTsCopy.GE_HQ_Parent_P_L_Name__c).Name+'</b><br/>';
                      changesMade += 'Business Tier 0 : <b>'+oldBTiersName.get(aboutToDeleteBTsCopy.GE_HQ_Parent_P_L_Name__c).GE_HQ_Parent_P_L_Name__r.Name+'</b><br/>'; 
                }
                if(aboutToDeleteBTsCopy.GE_HQ_P_L_Hierarchy_Level__c == 3) {
                      changesMade += 'P&L Name <b>'+aboutToDeleteBTsCopy.Name+' </b>has been Deleted at <b>Business Tier 3</b><br/><br/>';
                      changesMade += 'Business Tier 2 Parent P&L Name :<b>'+oldBTiersName.get(aboutToDeleteBTsCopy.GE_HQ_Parent_P_L_Name__c).Name+'</b><br/>';
                      changesMade += 'Business Tier 1 :<b>'+oldBTiersName.get(aboutToDeleteBTsCopy.GE_HQ_Parent_P_L_Name__c).GE_HQ_Parent_P_L_Name__r.Name+'</b><br/>';
                      changesMade += 'Business Tier 0 :<b>'+oldBTiersName.get(aboutToDeleteBTsCopy.GE_HQ_Parent_P_L_Name__c).GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__r.Name+'</b><br/>';
                }
                if(aboutToDeleteBTsCopy.GE_HQ_P_L_Hierarchy_Level__c == 4) {
                      changesMade += 'P&L Name <b>'+aboutToDeleteBTsCopy.Name+' </b>has been Deleted at <b>Business Tier 4</b><br/>';
                      changesMade += 'Business Tier 3 Parent P&L Name :<b>'+oldBTiersName.get(aboutToDeleteBTsCopy.GE_HQ_Parent_P_L_Name__c).Name+'</b><br/>';
                      changesMade += 'Business Tier 2 :<b>'+oldBTiersName.get(aboutToDeleteBTsCopy.GE_HQ_Parent_P_L_Name__c).GE_HQ_Parent_P_L_Name__r.Name+'</b><br/>';
                      changesMade += 'Business Tier 1 :<b>'+oldBTiersName.get(aboutToDeleteBTsCopy.GE_HQ_Parent_P_L_Name__c).GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__r.Name+'</b><br/>';
                      changesMade += 'Business Tier 0 :<b>'+oldBTiersName.get(aboutToDeleteBTsCopy.GE_HQ_Parent_P_L_Name__c).GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__r.Name+'</b><br/>';                
                    
                }
                if(aboutToDeleteBTsCopy.GE_HQ_P_L_Hierarchy_Level__c == 5) {
                    changesMade += 'P&L Name <b>'+aboutToDeleteBTsCopy.Name+' </b>has been Deleted at <b>Business Tier 5</b><br/><br/>';
                    changesMade += 'Business Tier 4 Parent P&L Name :<b>'+oldBTiersName.get(aboutToDeleteBTsCopy.GE_HQ_Parent_P_L_Name__c).Name+'</b><br/>';
                    changesMade += 'Business Tier 3 :<b>'+oldBTiersName.get(aboutToDeleteBTsCopy.GE_HQ_Parent_P_L_Name__c).GE_HQ_Parent_P_L_Name__r.Name+'</b><br/>';
                    changesMade += 'Business Tier 2 :<b>'+oldBTiersName.get(aboutToDeleteBTsCopy.GE_HQ_Parent_P_L_Name__c).GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__r.Name+'</b><br/>';
                    changesMade += 'Business Tier 1 :<b>'+oldBTiersName.get(aboutToDeleteBTsCopy.GE_HQ_Parent_P_L_Name__c).GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__r.Name+'</b><br/>';
                    changesMade += 'Business Tier 0 :<b>'+oldBTiersName.get(aboutToDeleteBTsCopy.GE_HQ_Parent_P_L_Name__c).GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__r.GE_HQ_Parent_P_L_Name__r.Name+'</b><br/>';
                }
                
                changesMade += 'P&L ID : <b>'+aboutToDeleteBTsCopy.GE_HQ_P_L_ID__c+'</b><br/>';
                changesMade += 'Is Active? : <b>'+aboutToDeleteBTsCopy.GE_HQ_Is_Active__c+'</b><br/>'; 
                changesMade += 'Comments : <b>'+aboutToDeleteBTsCopy.GE_OG_Comments__c+'</b><br/><br/><br/>';                     
                LastModifiedByids = aboutToDeleteBTsCopy.LastModifiedByid;  
            }
            
            User currentUser = [select id, firstname, lastname, email FROM User WHERE id =: LastModifiedByids ];
            changesMade += 'If there are any questions regarding the enclosed O&G Business Tier updates please contact '+currentUser.firstname+' '+currentUser.lastname+' at '+currentUser.email+'<br/><br/>';
//            changesMade += 'If there are any questions regarding the enclosed O&G Business Tier updates please contact Admin <br/><br/>';
            changesMade += 'Thank You!<br/>'+'<b>GE Oil and Gas Team</b>';
            changesMade = changesMade.replace('null','Blank');
          
            String urlCode = String.valueof(URL.getSalesforceBaseUrl().toExternalForm());
            if(urlCode.contains('geog--ogdev')) {
                stringSubject = 'Automated Email Notification: O&G Business Tiers deleted in DEV by '+currentUser.firstname+' '+currentUser.lastname+' - '+System.now().format('MM-dd-yyyy'); 
                System.debug('Printing for OGDEV:>>>'+stringSubject);
            }
              
            else if(urlCode.contains('geog--ogtest')) {
                stringSubject = 'Automated Email Notification: O&G Business Tiers deleted in TEST by '+currentUser.firstname+' '+currentUser.lastname+' - '+System.now().format('MM-dd-yyyy'); 
                System.debug('Printing for OGTEST:>>>'+stringSubject);
            }
              
            else if(urlCode.contains('geog.my')) {
                stringSubject = 'Automated Email Notification: O&G Business Tiers deleted in Production by '+currentUser.firstname+' '+currentUser.lastname+' - '+System.now().format('MM-dd-yyyy'); 
                System.debug('Printing for Production:>>>'+stringSubject);
            }
            String nonSFMails = Label.BusineesTierNotifyUser;
            System.debug('non sf emails'+nonSFMails);
            List<String> listOfNonSFUsers = nonSFMails.split(',');
      
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage(); 
            String[] toAddresses =  nonSFMails.split(',');
            mail.setToAddresses(toAddresses);
            mail.setSubject(stringSubject);
            mail.setHtmlBody(changesMade);
            if(!Test.isRunningTest())
                Messaging.sendEmail(new Messaging.SingleEMailMessage[]{mail});
        }
    }*/