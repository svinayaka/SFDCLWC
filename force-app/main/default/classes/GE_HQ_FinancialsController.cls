/*    
Class Name        : GE_HQ_FinancialsController
Purpose/Overview  : This VF section shows all the 'Closed won', Pipeline amount and market penetration details of an Account Plan (Displays the values from the Accont related Opptys' pipeline info and the forecasteds SAS info inserted at Account Plan level
Author            : Jayadev Rath
Test Class        : GE_HQ_FinancialsController_Test 
Change History    : Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
                  : Felix Release : Jayadev Rath       : Created : Created the class to provide the financial overview of a particular Account Plan
                  : 24th Oct 2011 : Jayadev Rath       : Updated the UI side (the tab name) and the values as currency format.
*/
Public class GE_HQ_FinancialsController
{
    String AccPlanningID;
    Public Integer NoOfRows=5;
    Set<id> AllAccountids = new Set<id>();

    // Pacing Variables
    Private Integer NextCountPacing=0;
    Public Integer TotalPacingRecords{get;set;}
    Public Integer StartRecPacing{get;set;}
    Public Integer EndRecpacing{get;set;}
    Public Boolean renderFirstPacing{get;set;}
    Public Boolean renderPrevPacing{get;set;}
    Public Boolean renderNextPacing{get;set;}
    Public Boolean renderLastPacing{get;set;}

    //Pipeline Variables:-
    Public Integer TotalPipelineRecords{get;set;}
    Private Integer NextCountPL=0;
    Public Integer StartRecPL{get;set;}
    Public Integer EndRecPL{get;set;}
    Public Boolean renderFirstPL{get;set;}
    Public Boolean renderPrevPL{get;set;}
    Public Boolean renderNextPL{get;set;}
    Public Boolean renderLastPL{get;set;}

    //Penetrating(PT) Variables:-
    Public Integer TotalPTRecords{get;set;}
    Private Integer NextCountPT=0;
    Public Integer StartRecPT{get;set;}
    Public Integer EndRecPT{get;set;}
    Public Boolean renderFirstPT{get;set;}
    Public Boolean renderPrevPT{get;set;}
    Public Boolean renderNextPT{get;set;}
    Public Boolean renderLastPT{get;set;}

    // Inner class to hold only the required parameters to be shown in the page
    Public Class FinancialRec
    {
        Public String PnL{get;set;}
        Public Integer Year{get;set;}
        Public Integer Value{get;set;} //Currency.newInstance
        // Constructor to set the variables
        Public FinancialRec(Integer Year,Double Value, String PnL) {
            this.PnL=PnL;  this.Year=Year;  this.Value = Integer.valueOf( Value);
        }
    }
    
    // Constructor to get the Account Plan Id and find the Account details
    Public GE_HQ_FinancialsController(ApexPages.StandardController controller) {
        // Fetch the Account Plan id from the Apex page.
        AccPlanningID= ApexPages.currentPage().getParameters().get('id');
        // Get all the Accounts related to the Account Plan
        List<GE_HQ_Acc_AccPlan_Rel__c> AllListOfAccounts = [Select Id,GE_HQ_Account__c from GE_HQ_Acc_AccPlan_Rel__c where GE_HQ_Account_Plan__c = :AccPlanningID ];
        // Get the account Ids from the accounts
        for(GE_HQ_Acc_AccPlan_Rel__c acc: AllListOfAccounts)
            AllAccountids.add(acc.GE_HQ_Account__c);
    }

    // Get the records for Pacing/Closed won tab
    Public List<FinancialRec> getPacingRecs()
    {
        // Get all the Opptys whose stage comes in 'Active - Commit','Closed Won','Closed - Partially Won' and the pipeline amount is not 0.
        List<AggregateResult> PacingOppList=[Select CALENDAR_YEAR(Closedate) Year, SUM( Pipeline_Amount_ge_og__c) Value, COUNT(Pipeline_Amount_ge_og__c) Record_Count,tier_2_ge_og__c PnL from Opportunity where StageName in ('Active - Commit','Closed Won','Closed - Partially Won') and Pipeline_Amount_ge_og__c <> 0 and (AccountId in :AllAccountids or end_user_ge_og__c in :AllAccountids ) group by tier_2_ge_og__c,CALENDAR_YEAR(CloseDate) Order by tier_2_ge_og__c,CALENDAR_YEAR(CloseDate) DESC ];
        TotalPacingRecords=PacingOppList.Size();
        // If no records found return null to notify no records found.
        if(PacingOppList.size() == 0) return null;

        List<FinancialRec> PR=new List<FinancialRec>();
        // Add the Pacing records to the Variable to be displyed in the page
        for(Integer i=0;i < NoOfRows && (NextCountPacing+i < TotalPacingRecords); i++) {
            PR.add(new FinancialRec((Integer) PacingOppList[NextCountPacing+i].get('Year'),(Double) PacingOppList[NextCountPacing+i].get('Value'),(String)PacingOppList[NextCountPacing+i].get('PnL')));
        }
        if(NextCountPacing <= 0) {
            renderFirstPacing=False;    
            renderPrevPacing=False;
        }
        else {
            renderFirstPacing=True;    
            renderPrevPacing=True;
        }
        if(NextCountPacing >= (TotalPacingRecords - NoOfRows)) {
            renderLastPacing=False;    
            renderNextPacing=False;
        }
        else {
            renderLastPacing=True;    
            renderNextPacing=True;
        }
        StartRecPacing=(TotalPacingRecords == 0)?0:NextCountPacing+1;
        if(StartRecPacing+NoOfRows >TotalPacingRecords)
            EndRecPacing=TotalPacingRecords;
        else
            EndRecPacing=StartRecPacing+NoOfRows-1;
        return PR;
    }
    // Get next set of records
    Public void getNextPacing() {
        if(NextCountPacing+NoOfRows <= TotalPacingRecords)
            NextCountPacing+=NoOfRows;
        else
            NextCountPacing = TotalPacingRecords - NoOfRows;
    }
    // Get previous set of records
    Public void getPrevPacing() {
        if(NextCountPacing-NoOfRows >=0)
            NextCountPacing-=NoOfRows;
        else
            NextCountPacing=0;
    }
    // Get the first set of records
    Public void getFirstPacing() {
        NextCountPacing=0;
    }
    // Get the last set of records
    Public void getLastPacing() {
        NextCountPacing=TotalPacingRecords - NoOfRows;
    }


    // For Fetching Pipeline records (Opptys whose stage is not in 'Closed Won','Closed Lost','Abandoned - Closed/Lost','Abandoned','Cancelled','Duplicate' get the pipeline amount
    Public List<FinancialRec> getPipelineRecs() {
        List<AggregateResult> PipelineOppList=[Select CALENDAR_YEAR(Closedate) Year, SUM( Pipeline_Amount_ge_og__c) Value, COUNT(Pipeline_Amount_ge_og__c) Record_Count,tier_2_ge_og__c PnL from Opportunity where StageName NOT in ('Closed Won','Closed Lost','Abandoned - Closed/Lost','Abandoned','Cancelled','Duplicate') and Pipeline_Amount_ge_og__c <> 0 and (AccountId in :AllAccountids or end_user_ge_og__c in :AllAccountids ) group by tier_2_ge_og__c,CALENDAR_YEAR(CloseDate) Order by tier_2_ge_og__c,CALENDAR_YEAR(CloseDate) DESC ];
        TotalPipelineRecords=PipelineOppList.size();
        // If no records found return null to notify no records found.
        if(PipelineOppList.size() == 0) return null;
        // Get the records to be displayed in the page
        List<FinancialRec> PL=new List<FinancialRec>();
        for(Integer i=0;i < NoOfRows && (NextCountPL+i < TotalPipelineRecords); i++) {
            PL.add(new FinancialRec((Integer) PipelineOppList[NextCountPL+i].get('Year'),(Double) PipelineOppList[NextCountPL+i].get('Value'),(String) PipelineOppList[NextCountPL+i].get('PnL')));
        }
        if(NextCountPL <= 0) {
            renderFirstPL=False;    
            renderPrevPL=False;
        }
        else {
            renderFirstPL=True;    
            renderPrevPL=True;
        }
        if(NextCountPL >= (TotalPipelineRecords - NoOfRows)) {
            renderLastPL=False;    
            renderNextPL=False;
        }
        else {
            renderLastPL=True;    
            renderNextPL=True;
        }
        StartRecPL=(TotalPipelineRecords == 0)?0:NextCountPL+1;
        if(StartRecPL+NoOfRows > TotalPipelineRecords)
            EndRecPL=TotalPipelineRecords;
        else
            EndRecPL=StartRecPL+NoOfRows -1;
        return PL;
    }
    // Get next set of records
    Public void getNextPipeline() {
        if(NextCountPL+NoOfRows <= TotalPipelineRecords)
            NextCountPL+=NoOfRows;
        else
            NextCountPL = TotalPipelineRecords - NoOfRows;
    }
    // Get previous set of records
    Public void getPrevPipeline() {
        if(NextCountPL-NoOfRows >=0)
            NextCountPL-=NoOfRows;
        else
            NextCountPL=0;
    }
    // Get the first set of records
    Public void getFirstPipeline() {
        NextCountPL=0;
    }
    // Get the last set of records
    Public void getLastPipeLine() {
        NextCountPL=TotalPipelineRecords - NoOfRows;
    }


    // For Fetching Penetrating records
    /*Public List<FinancialRec> getPenetratingRecs() {
        List<FinancialRec> PTOppList = new List<FinancialRec>();
        List<AggregateResult> PacingOppList=[Select CALENDAR_YEAR(Closedate) Year, SUM( Pipeline_Amount_ge_og__c) Value, COUNT(Pipeline_Amount_ge_og__c) Record_Count,tier_2_ge_og__c PnL from Opportunity where StageName in ('Active - Commit','Closed Won','Closed - Partially Won') and Pipeline_Amount_ge_og__c <> 0 and (AccountId in :AllAccountids or end_user_ge_og__c in :AllAccountids ) group by tier_2_ge_og__c,CALENDAR_YEAR(CloseDate) Order by tier_2_ge_og__c,CALENDAR_YEAR(CloseDate) DESC ];
        // List<GE_HQ_Forecasted_SAS__c> SASList = [Select GE_HQ_Tier2_PL__c,GE_HQ_Year__c,GE_HQ_SAS_Value__c from GE_HQ_Forecasted_SAS__c where GE_HQ_Account_Plan__c =:AccPlanningID];
        List<GE_HQ_Forecasted_SAS__c> SASList = [Select GE_HQ_Buss_Tier1__c,GE_HQ_Year__c,GE_HQ_SAS_Value__c from GE_HQ_Forecasted_SAS__c where GE_HQ_Account_Plan__c =:AccPlanningID];
        For(AggregateResult pol : PacingOppList) {
            FinancialRec newPenetrationRec=null;
            For(GE_HQ_Forecasted_SAS__c sasRec:SASList ) {
                // When the PnL of Pacing record and the TAM/SAS Snapshot record match, then calculate the penetration value else put it as 0.
                // if(sasRec.GE_HQ_Tier2_PL__c == (String) pol.get('PnL') && Integer.valueOf(sasRec.GE_HQ_Year__c) == (Integer) pol.get('Year') ) {
                If(sasRec.GE_HQ_Buss_Tier1__c == (String) pol.get('PnL') && Integer.valueOf(sasRec.GE_HQ_Year__c) == (Integer) pol.get('Year') ) {
                    Double PTValue;
                    if(sasRec.GE_HQ_SAS_Value__c == Null || sasRec.GE_HQ_SAS_Value__c <= 0 || pol.get('Value') ==Null || (Double)pol.get('Value') <=0 )
                        PTValue = 0;    // If any of the values is 0, then the penetration value is to be shown as 0.
                    else
                        PTValue = ( (Double) pol.get('Value')/sasRec.GE_HQ_SAS_Value__c ) * 100;    //Penetration value= Pacing value/SAS value in %
                    newPenetrationRec= new FinancialRec((Integer) pol.get('Year'), PTValue, (String) pol.get('PnL') );
                    break;
                }
            }
            if(newPenetrationRec != null)
                PTOppList.add(newPenetrationRec);        // In TAM/SAS Snapshot object one record with the same PnL and Year exists, so add with the calculated Penetration value else set penetration value to 0.
            else
                PTOppList.add( new FinancialRec((Integer) pol.get('Year'), 0, (String) pol.get('PnL') ));
        }
        TotalPTRecords=PTOppList.size();
        // If no records found return null to notify no records found.
        if(PTOppList.size() == 0) return null;
            
        List<FinancialRec> PT=new List<FinancialRec>();
        for(Integer i=0;i < NoOfRows && (NextCountPT+i < TotalPTRecords); i++) {
            PT.add( PTOppList[NextCountPT+i] );
        }

        if(NextCountPT <= 0) {
            renderFirstPT=False;    
            renderPrevPT=False;
        }
        else {
            renderFirstPT=True;    
            renderPrevPT=True;
        }
        if(NextCountPT >= (TotalPTRecords - NoOfRows)) {
            renderLastPT=False;    
            renderNextPT=False;
        }
        else {
            renderLastPT=True;    
            renderNextPT=True;
        }
        StartRecPT=(TotalPTRecords == 0)?0:NextCountPT+1;
        if(StartRecPT+NoOfRows > TotalPTRecords)
            EndRecPT=TotalPTRecords;
        else
            EndRecPT=StartRecPT+NoOfRows -1;
        return PT;
    }*/
    
    // Get next set of records
    /*Public void getNextPT() {
        if(NextCountPT+NoOfRows <= TotalPTRecords)
            NextCountPT+=NoOfRows;
        else
            NextCountPT = TotalPTRecords - NoOfRows;
    }*/
    
    // Get previous set of records
    /*Public void getPrevPT() {
        if(NextCountPT-NoOfRows >=0)
            NextCountPT-=NoOfRows;
        else
            NextCountPT=0;
    } */
    // Get the first set of records
    /*Public void getFirstPT() {
        NextCountPT=0;
    }*/
    // Get the last set of records
    /*Public void getLastPT() {
        NextCountPT=TotalPTRecords - NoOfRows;
    }*/
}