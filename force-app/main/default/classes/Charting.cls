global with sharing class Charting {
  public Charting ()
        {
        } 
/*

    public String ReportId{get; set;}
    public String pnlReportId{get; set;}
    public String pnlReportName{get; set;}
    public String tier2ReportId{get; set;}
    public String stageReportId{get; set;}
    public String DDUNS { get; set; }
    public GE_HQ_Account_Plan__c accountPlan {get;set;}
    public Integer theSelectedYear { get; set; }
    public String Tier1Value {get; set;}
    public String Tier2Value { get; set; } 
    public String Tier3Value { get; set; }
    public Integer Year;
    public boolean onloadpage;

    public Charting(ApexPages.StandardController controller) {
        this.accountPlan=(GE_HQ_Account_Plan__c)controller.getRecord();
        GE_HQ_Account_Plan__c accPlan = [select id,name,GE_HQ_DDUNS_fm__c,GE_HQ_DDUNS_Number__c from GE_HQ_Account_Plan__c where id=:accountPlan.Id];
        DDUNS = accPlan.GE_HQ_DDUNS_fm__c;
        Report r =[select id,name,developerName from Report where developerName='OG_Tier_1_O_G_Region_Current_Year'];
        ReportId=r.id;
        onloadpage = true;   
       Report pnlReport =[select id,name,developerName from Report where developerName='OG_Forecast_by_PL_Current_Year'];
        pnlReportId=pnlReport.id;
        pnlReportName =pnlReport.Name;
        
        Report tier2Report =[select id,name,developerName from Report where developerName='OG_Tier_2_Account_Region_Current_Year'];
        tier2ReportId=tier2Report.Id;
        
        Report stageReport =[select id,name,developerName from Report where developerName='OG_Oppty_by_Stage_Current_Year'];
        stageReportId=stageReport.Id;
    }

    public PageReference setTiers(){
        onloadpage = false;
        System.debug('Tier 1 Value='+accountPlan.GE_HQ_Buss_Tier__c);
        System.debug('Tier 2 Value = '+accountPlan.GE_OG_Tier_2_P_L__c);
        System.debug('Tier 3 Value = '+accountPlan.GE_OG_Tier_3_P_L__c);
        this.Tier1Value= accountPlan.GE_HQ_Buss_Tier__c;
        this.Tier2Value= accountPlan.GE_OG_Tier_2_P_L__c;
        this.Tier3Value= accountPlan.GE_OG_Tier_3_P_L__c;
        return null;
    }
        
    public integer getYear() 
        {
        return Year;
        }
  
    public void setYear(integer Year) 
        {
        this.Year = Year;
        }

      
        
    public List<SelectOption> getYears()
        {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('2009','2009'));
        options.add(new SelectOption('2010','2010'));
        options.add(new SelectOption('2011','2011'));
        options.add(new SelectOption('2012','2012'));
        options.add(new SelectOption('2013','2013'));
        options.add(new SelectOption('2014','2014'));
        return options;
        }
        
    public List<AggregateResult> getOppbyRegion() 
        {
        theYear = Date.today().year(); 
            System.debug('Year - '+theYear);
            System.debug('Tier 2 - '+Tier2Value);
            System.debug('Tier 3 - '+Tier3Value);
            set<string> stages = new Set<String>{'Active - High Probability','Active - Commit','Closed Won'};
            AggregateResult[] ClosedWonOppbyRegion;
            //Order By GE_Tier1_ARegion__c desc
        if (onloadpage  )

        ClosedWonOppbyRegion = [SELECT SUM(pipeline_amount_ge_og__c) Revenue,  GE_Tier1_ARegion__c region
                    FROM Opportunity
                    WHERE tier_1_ge_og__c = 'Oil & Gas (O&G)' AND GE_HQ_Prm_Opp__c = 'Yes'  AND CALENDAR_YEAR(CloseDate) = :theYear 
                                                  AND tier_2_ge_og__c!=null AND tier_3_ge_og__c!=null AND Account.GE_HQ_GE_Global_Duns__c =:DDUNS 
                                                  AND GE_Tier1_ARegion__c != null
                    GROUP BY GE_Tier1_ARegion__c ];
         else if ( (Tier2Value != null || Tier2Value != '') && (Tier3Value == ''|| Tier3Value == null))
            ClosedWonOppbyRegion = [SELECT SUM(pipeline_amount_ge_og__c) Revenue,  GE_Tier1_ARegion__c region
                    FROM Opportunity
                    WHERE tier_1_ge_og__c= 'Oil & Gas (O&G)' AND GE_HQ_Prm_Opp__c = 'Yes'  AND CALENDAR_YEAR(CloseDate) = :theYear 
                                                  AND tier_2_ge_og__c=: Tier2Value AND tier_3_ge_og__c!=null AND Account.GE_HQ_GE_Global_Duns__c =:DDUNS 
                                                  AND GE_Tier1_ARegion__c != null
                    GROUP BY GE_Tier1_ARegion__c];
         else
        ClosedWonOppbyRegion = [SELECT SUM(pipeline_amount_ge_og__c) Revenue,  GE_Tier1_ARegion__c region
                    FROM Opportunity
                    WHERE tier_1_ge_og__c= 'Oil & Gas (O&G)' AND GE_HQ_Prm_Opp__c = 'Yes'  AND CALENDAR_YEAR(CloseDate) = :theYear 
                                                  AND tier_2_ge_og__c=:Tier2Value AND tier_3_ge_og__c=:Tier3Value AND Account.GE_HQ_GE_Global_Duns__c =:DDUNS 
                                                  AND GE_Tier1_ARegion__c != null
                    GROUP BY GE_Tier1_ARegion__c];
        return ClosedWonOppbyRegion;
        }
                        

        
    public List<OppsClosedData> getData() 
        {
        List<OppsClosedData> theResults = new List<OppsClosedData>();
        AggregateResult[] OpptyRegion = getOppbyRegion();
        OppsClosedData closedOpp = null;
        
        for(AggregateResult ar: OpptyRegion) {
             closedOpp = new OppsClosedData();
                    closedOpp.Revenue = Double.valueOf(ar.get('Revenue'));
                    closedOpp.Region = String.valueOf(ar.get('region'));
                    System.debug('Closed Opp - '+closedOpp);
                    theResults.add(closedOpp);
        }
        return theResults;
        }

        
// By P&L

    public List<AggregateResult> getOppbyPnl()  {
        theYear = Date.today().year(); 
            set<string> stages = new Set<String>{'Active - High Probability','Active - Commit','Closed Won'};
        AggregateResult[] ClosedWonOppbypnl = [SELECT SUM(pipeline_amount_ge_og__c) Revenue,  tier_3_ge_og__c pnl
                    FROM Opportunity
                    WHERE tier_1_ge_og__c= 'Oil & Gas (O&G)' AND GE_HQ_Prm_Opp__c = 'Yes'  AND CALENDAR_YEAR(CloseDate) = :theYear 
                                                  AND tier_2_ge_og__c=:Tier2Value AND tier_3_ge_og__c=:Tier3Value AND Account.GE_HQ_GE_Global_Duns__c =:DDUNS 
                                                  AND tier_3_ge_og__c!= null
                    GROUP BY tier_3_ge_og__c Order By tier_3_ge_og__c asc];
        return ClosedWonOppbypnl;
        }
        
    public List<OppsClosedData> getPnlData()  {
        List<OppsClosedData> theResults = new List<OppsClosedData>();
        AggregateResult[] OpptyPnLData = getOppbyPnl();
        OppsClosedData closedOpp = null;
        
        for(AggregateResult ar: OpptyPnLData) {
             closedOpp = new OppsClosedData();
                    closedOpp.Revenue = Double.valueOf(ar.get('Revenue'));
                    closedOpp.Region = String.valueOf(ar.get('pnl'));
                    System.debug('Closed Opp - '+closedOpp);
                    theResults.add(closedOpp);
        }
        return theResults;
        }
        
        
   //Tier 2 Region Revenue
    
        public List<AggregateResult> getOppbytier2Region() 
        {
        theYear = Date.today().year(); 
            System.debug('Year - '+theYear);
            System.debug('Tier 2 - '+Tier2Value);
            System.debug('Tier 3 - '+Tier3Value);
            set<string> stages = new Set<String>{'Active - High Probability','Active - Commit','Closed Won'};
        AggregateResult[] ClosedWonOppbytier2Region = [SELECT SUM(pipeline_amount_ge_og__c) Revenue,  GE_Tier2_Pregion__c region
                    FROM Opportunity
                    WHERE tier_1_ge_og__c= 'Oil & Gas (O&G)' AND GE_HQ_Prm_Opp__c = 'Yes'  AND CALENDAR_YEAR(CloseDate) = :theYear 
                                                  AND tier_2_ge_og__c=:Tier2Value AND tier_3_ge_og__c=:Tier3Value AND Account.GE_HQ_GE_Global_Duns__c =:DDUNS 
                                                  AND GE_Tier2_Pregion__c != null
                    GROUP BY GE_Tier2_Pregion__c Order By GE_Tier2_Pregion__c desc];
        return ClosedWonOppbytier2Region;
        }
                        

        
    public List<OppsClosedData> getDatatier2() 
        {
        List<OppsClosedData> theResults = new List<OppsClosedData>();
        AggregateResult[] OpptyRegion = getOppbytier2Region();
        OppsClosedData closedOpp = null;
        
        for(AggregateResult ar: OpptyRegion) {
             closedOpp = new OppsClosedData();
                    closedOpp.Revenue = Double.valueOf(ar.get('Revenue'));
                    closedOpp.Region = String.valueOf(ar.get('region'));
                    System.debug('Closed Opp - '+closedOpp);
                    theResults.add(closedOpp);
        }
        return theResults;
        } 
 
 //stage       
        public List<AggregateResult> getOppbystage()  {
        theYear = Date.today().year(); 
            set<string> stages = new Set<String>{'Active - Low Probability','Active - Med. Probability','Active - High Probability','Active - Commit','Closed Won'};
        AggregateResult[] ClosedWonOppbystage ;
        //Order By StageName asc
        if (onloadpage)
        ClosedWonOppbystage = [SELECT SUM(pipeline_amount_ge_og__c) Revenue,  StageName stage
                    FROM Opportunity
                    WHERE tier_1_ge_og__c= 'Oil & Gas (O&G)' AND GE_HQ_Prm_Opp__c = 'Yes'  AND CALENDAR_YEAR(CloseDate) = :theYear 
                                                  AND tier_2_ge_og__c!= null AND tier_3_ge_og__c!=null AND Account.GE_HQ_GE_Global_Duns__c =:DDUNS 
                                                  AND StageName != null
                    GROUP BY StageName ];
         else if ( (Tier2Value != null || Tier2Value != '') && (Tier3Value == ''|| Tier3Value == null))
        ClosedWonOppbystage = [SELECT SUM(pipeline_amount_ge_og__c) Revenue,  StageName stage
                    FROM Opportunity
                    WHERE tier_1_ge_og__c= 'Oil & Gas (O&G)' AND GE_HQ_Prm_Opp__c = 'Yes'  AND CALENDAR_YEAR(CloseDate) = :theYear 
                                                  AND tier_2_ge_og__c=: Tier2Value AND tier_3_ge_og__c!=null AND Account.GE_HQ_GE_Global_Duns__c =:DDUNS 
                                                  AND StageName != null
                    GROUP BY StageName ];
         
         else
         ClosedWonOppbystage = [SELECT SUM(pipeline_amount_ge_og__c) Revenue,  StageName stage
                    FROM Opportunity
                    WHERE tier_1_ge_og__c= 'Oil & Gas (O&G)' AND GE_HQ_Prm_Opp__c = 'Yes'  AND CALENDAR_YEAR(CloseDate) = :theYear 
                                                  AND tier_2_ge_og__c=:Tier2Value AND tier_3_ge_og__c=:Tier3Value AND Account.GE_HQ_GE_Global_Duns__c =:DDUNS 
                                                  AND StageName != null
                    GROUP BY StageName];
        return ClosedWonOppbystage;
        }
        
    public List<OppsClosedData> getstageData()  {
        List<OppsClosedData> theResults = new List<OppsClosedData>();
        AggregateResult[] OpptystageData = getOppbystage();
        OppsClosedData closedOpp = null;
        
        for(AggregateResult ar: OpptystageData) {
             closedOpp = new OppsClosedData();
                    closedOpp.Revenue = Double.valueOf(ar.get('Revenue'));
                    closedOpp.Region = String.valueOf(ar.get('stage'));
                    System.debug('Closed Opp - '+closedOpp);
                    theResults.add(closedOpp);
        }
        return theResults;
        }  
    // Get the year for the stats from the URL, if possible
    private Integer theYear 
        {
        get 
            {
            if (Year != null)
                {
                theYear =   Integer.valueOf(Year);
                }
            else
                {
                theYear = Date.today().year();  
                Year = theYear;
                }   
            return theYear;
            }
        set;
        }
        

    // Wrapper class
    public class OppsClosedData {
        
        public Double Revenue { get; set; }
        public String Region { get; set; }

        public OppsClosedData() 
            {
            }
            
        public OppsClosedData(Integer rev, String Region) 
            {
            this.Revenue = rev;
            this.Region = region;
            }
        }
        */
        
        public static testmethod void Chartingtest(){
            Charting obj= new Charting(); 
        }
        
    }