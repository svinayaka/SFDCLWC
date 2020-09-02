//Test Class Name : GE_OG_TM_ScopeofSupply_Tgr_Test_V2



public class OpptyTriggerhelperClass {

    // Static variables are local to the context of a Web request  (or testMethod during a runTests call)  
    // Therefore, this variable will be initialized as false  
    // at the beginning of each Web request which  accesses it.  
    
    // One Static Variable per Trigger we plan to update
    private static boolean sBERadacreation = false;
    private static boolean cirrestriction= false;
    private static boolean GEDealexpressPathOpptyRedirect= false;
    private static boolean sBprmChannel = false;
    private static boolean sBTest = false;
    private static boolean sBAddLeaderToSalesTeam = false;
    private static boolean sBNumOFContactsforEmailid = false;
    private static boolean sBNumOFContactsforEmailidUpdate = false;
    private static boolean sBCreateDMRecord = false;
    private static boolean sBThreshold_Currency = false;
    private static boolean sBBmiProdDelete = false;
    private static boolean sBUpdateBMPriceMgmt = false;
    private static boolean sBOptimizer = false;
    private static boolean sBPIIApproveChkLstItms = false;
    private static boolean sBSyncFieldswithDM = false;
    private static boolean sBSyncFieldswithOppty = false;
    private static boolean sBCalcCustomerCreditLimit = false;
    private static boolean sBERamScoreUpdate = false;
    private static boolean sBRecallchecklistitems = false;
    private static boolean sBPolicyApprove = false;
    private static boolean sBRegionalApproval = false;
    private static boolean sBContractUpdate = false;
    private static boolean sBTMInstallationIDCounter = false;
    private static boolean sBOpportunitySharing = false;
    private static boolean sBPartnerOpptySharing = false;
    public  static boolean pIIUpdate = false;
    private  static boolean sTasktoCPR =false;
    private  static boolean Dealmgnmttgr =false;
    Private  Static Boolean sSynchfieldswithopty =false;
    private  static Boolean sSynchfieldafterinsert =false;
    Private  Static boolean sBPolicyApproveDMO =false;
    Private static  boolean  sUpdateRstatusToR3 =false;
    Private static Boolean SRegionalApprovalDMO =false;
    Private Static Boolean SPRMgenerateCOntracts =false;
    Private  Static boolean sBCalcdeviationscr =false;
    Private  Static boolean sBCalcdeviationlvl =false;
    Private  Static boolean sBUpdatechklststatus =false;
    Private  Static boolean sAUpdatechklststatus =false;
    Private Static boolean sProprevisioncrt = false;
    
    //added by vipin 
    Private Static boolean sOppty_OLI_BI = false;
    
    //R-22458 - Added by Madhuri on Date: 03/07/2015
    public static boolean opptyLeadP_L = false;
    
    //created for case 
    public static boolean CaseQuoteFlag= false;
    
    
    //added by Prasad Yadala 12/09/2014
    Public Static boolean afterUpdateSyncFieldswithDMFlg = false;
    
    //added by Mohit
    @TestVisible private static boolean getStageReasonUpdate = false;
    @TestVisible private static boolean getReginfldspopulatin = false;
    @TestVisible private static boolean getupdateBMIStatus = false;
    @TestVisible private static boolean getStageReasonAfterUpdate = false;
    @TestVisible private static boolean getUpdateRequestDelievery = false;
    @TestVisible private static boolean geteTax_CTC_CFM = false;
    @TestVisible private static boolean getRollUpCurrencyCalculation = false;
    @TestVisible private static boolean getupdatingPrmryQuote = false;
    @TestVisible private static boolean getbigMachineProdDeleteError = false;
    @TestVisible private static boolean sgetupdateTier2 = false;
    @TestVisible private static boolean getscalcExchangeRatesOnOLI = false;
    @TestVisible private static boolean getsRollUpCurrencyCalculation = false;
    @TestVisible private static boolean getsupdatingbmiProductDelete = false;
    @TestVisible private static boolean sgetfctupdateOpptyfrmOLI = false;
    @TestVisible private static boolean sgetupdateDOA1 = false;
    @TestVisible private static boolean sgetupdateDOA2 = false;
    @TestVisible private static boolean getsupdatingLineItemCmPercentage = false;
    @TestVisible private static boolean sgetscopeOfSupplyLogic = false;
    @TestVisible private static boolean sgetupdatingLineItemCmPercentage = false;
    @TestVisible private static boolean sgetupdateDOA3 = false;
    @TestVisible private static boolean sgetThresholdCurrency = false;
    @TestVisible private static boolean saftergetupdateTier2 = false;
    @TestVisible private static boolean saftergetupdateDOA1 = false;
    @TestVisible private static boolean safterupdategetupdatOLICmPercentage = false;
    @TestVisible private static boolean saftergetupdatingLineItemCmPercentage = false;
    @TestVisible private static boolean saftergetscopeOfSupplyLogic = false;
    @TestVisible private static boolean saftergetfctupdateOpptyfrmOLI = false;
    @TestVisible private static boolean supdategetscopeOfSupplyLogic = false;
    @TestVisible private static boolean sgetdeletefctupdateOpptyfrmOLI = false;
    @TestVisible private static boolean sdeletegetupdateDOA1 = false;
    @TestVisible private static boolean safterupDPInt = false;
    @TestVisible private static boolean safterupCurPLMatch = false;
    @TestVisible private static boolean safterupsyncwithDM = false;
    @TestVisible private static boolean safterupCrDMRec = false;
    
    
    /************ Added by Madhuri - R-22458 on Date: 03/07/2015 *****/
    
    public static boolean getOpptyLeadP_L() {
        return opptyLeadP_L;
    }
    
    public static void setOpptyLeadP_L(){
        opptyLeadP_L = true;
    }
    
    /****************************************************************/
    
    /****** start method by Mohit *****/
    
    public static boolean safterupCrDMRec(){
        return safterupCrDMRec;
    }
    
    public static void setsafterupCrDMRec(){
        safterupCrDMRec = true;
    }
    
    public static boolean safterupsyncwithDM(){
        return safterupsyncwithDM;
    }
    
    public static void setsafterupsyncwithDM(){
        safterupsyncwithDM = true;
    }
    
    public static boolean safterupCurPLMatch(){
        return safterupCurPLMatch;
    }
    
    public static void setsafterupCurPLMatch(){
        safterupCurPLMatch = true;
    }
    
    public static boolean safterupDPInt(){
        return safterupDPInt;
    }
    
    public static void setsafterupDPInt(){
        safterupDPInt = true;
    }
    
    public static boolean sdeletegetupdateDOA1() {
        return sdeletegetupdateDOA1;
    }
    
    public static void setsdeletegetupdateDOA1(){
        sdeletegetupdateDOA1 = true;
    }
    
    public static boolean sgetdeletefctupdateOpptyfrmOLI() {
        return sgetdeletefctupdateOpptyfrmOLI;
    }
    
    public static void setsgetdeletefctupdateOpptyfrmOLI(){
        sgetdeletefctupdateOpptyfrmOLI = true;
    }
    
    public static boolean supdategetscopeOfSupplyLogic() {
        return supdategetscopeOfSupplyLogic;
    }
    
    public static void setsupdategetscopeOfSupplyLogic(){
        supdategetscopeOfSupplyLogic = true;
    }
    
    public static boolean saftergetfctupdateOpptyfrmOLI() {
        return saftergetfctupdateOpptyfrmOLI;
    }
    
    public static void setsaftergetfctupdateOpptyfrmOLI(){
        saftergetfctupdateOpptyfrmOLI = true;
    }
    
    public static boolean saftergetscopeOfSupplyLogic() {
        return saftergetscopeOfSupplyLogic;
    }
    
    public static void setsaftergetscopeOfSupplyLogic(){
        saftergetscopeOfSupplyLogic = true;
    }
    
    public static boolean saftergetupdatingLineItemCmPercentage() {
        return saftergetupdatingLineItemCmPercentage;
    }
    
    public static void setsaftergetupdatingLineItemCmPercentage(){
        saftergetupdatingLineItemCmPercentage = true;
    }
    
    public static boolean safterupdategetupdatOLICmPercentage() {
        return safterupdategetupdatOLICmPercentage;
    }
    
    public static void setsafterupdategetupdatOLICmPercentage(){
        safterupdategetupdatOLICmPercentage = true;
    }
    
    public static boolean saftergetupdateDOA1() {
        return saftergetupdateDOA1;
    }
    
    public static void setsaftergetupdateDOA1(){
        saftergetupdateDOA1 = true;
    }
    
    public static boolean saftergetupdateTier2() {
        return saftergetupdateTier2;
    }
    
    public static void setsaftergetupdateTier2(){
        saftergetupdateTier2 = true;
    }
    
    public static boolean sgetThresholdCurrency() {
        return sgetThresholdCurrency;
    }
    
    public static void setsgetThresholdCurrency(){
        sgetThresholdCurrency = true;
    }
    
    public static boolean sgetupdateDOA3() {
        return sgetupdateDOA3;
    }
    
    public static void setsgetupdateDOA3(){
        sgetupdateDOA3 = true;
    }
    
    public static boolean sgetupdatingLineItemCmPercentage() {
        return sgetupdatingLineItemCmPercentage;
    }
    
    public static void setsgetupdatingLineItemCmPercentage(){
        sgetupdatingLineItemCmPercentage = true;
    }
    
    public static boolean sgetscopeOfSupplyLogic() {
        return sgetscopeOfSupplyLogic;
    }
    
    public static void setsgetscopeOfSupplyLogic(){
        sgetscopeOfSupplyLogic = true;
    }
    
    public static boolean getsupdatingLineItemCmPercentage() {
        return getsupdatingLineItemCmPercentage;
    }
    
    public static void setgetsupdatingLineItemCmPercentage(){
        getsupdatingLineItemCmPercentage = true;
    }
    
    public static boolean sgetupdateDOA2() {
        return sgetupdateDOA2;
    }
    
    public static void setsgetupdateDOA2(){
        sgetupdateDOA2 = true;
    }
    
    public static boolean sgetupdateDOA1() {
        return sgetupdateDOA1;
    }
    
    public static void setsgetupdateDOA1(){
        sgetupdateDOA1 = true;
    }
    
    public static boolean sgetfctupdateOpptyfrmOLI() {
        return sgetfctupdateOpptyfrmOLI;
    }
    
    public static void setsgetfctupdateOpptyfrmOLI(){
        sgetfctupdateOpptyfrmOLI = true;
    }
    
    public static boolean getsupdatingbmiProductDelete() {
        return getsupdatingbmiProductDelete;
    }
    
    public static void setgetsupdatingbmiProductDelete(){
        getsupdatingbmiProductDelete = true;
    }
    
    public static boolean getsRollUpCurrencyCalculation() {
        return getsRollUpCurrencyCalculation;
    }
    
    public static void setgetsRollUpCurrencyCalculation(){
        getsRollUpCurrencyCalculation = true;
    }

    
    public static boolean getscalcExchangeRatesOnOLI() {
        return getscalcExchangeRatesOnOLI;
    }
    
    public static void setgetcalcExchangeRatesOnOLI(){
        getscalcExchangeRatesOnOLI = true;
    }
    
    public static boolean sgetupdateTier2() {
        return sgetupdateTier2;
    }
    
    public static void setgetupdateTier2(){
        sgetupdateTier2 = true;
    }
    
    public static boolean getbigMachineProdDeleteError() {
        return getbigMachineProdDeleteError;
    }
    
    public static void setgetbigMachineProdDeleteError(){
        getbigMachineProdDeleteError = true;
    }
    
    public static boolean getupdatingPrmryQuote() {
        return getupdatingPrmryQuote;
    }
    
    public static void setgetupdatingPrmryQuote(){
        getupdatingPrmryQuote = true;
    }
    
    public static boolean getRollUpCurrencyCalculation() {
        return getRollUpCurrencyCalculation;
    }
    
    public static void setgetRollUpCurrencyCalculation(){
        getRollUpCurrencyCalculation = true;
    }
    
    public static boolean getStageReasonUpdate() {
        return getStageReasonUpdate;
    }
    
    public static void setStageReasonUpdate(){
        getStageReasonUpdate = true;
    }
    
    public static boolean getReginfldspopulatin() {
        return getReginfldspopulatin;
    }
    
    public static void setReginfldspopulatin(){
        getReginfldspopulatin= true;
    }
    
    public static boolean getupdateBMIStatus() {
        return getupdateBMIStatus;
    }
    
    public static void setupdateBMIStatus(){
        getupdateBMIStatus = true;
    }
    
    public static boolean getStageReasonAfterUpdate() {
        return getStageReasonAfterUpdate;
    }
    
    public static void setStageReasonAfterUpdate(){
        getStageReasonAfterUpdate = true;
    }
    
    public static boolean getUpdateRequestDelievery() {
        return getUpdateRequestDelievery;
    }
    
    public static void setUpdateRequestDelievery(){
        getUpdateRequestDelievery = true;
    }
    
    public static boolean geteTax_CTC_CFM() {
        return geteTax_CTC_CFM;
    }
    
    public static void setgeteTax_CTC_CFM(){
        geteTax_CTC_CFM = true;
    }
    
    /****** finish method by Mohit *****/
    
    public static boolean cirrestriction() {
       return sBAddLeaderToSalesTeam;
   }  
   
  public static boolean GEDealexpressPathOpptyRedirect() {
       return GEDealexpressPathOpptyRedirect;
   } 
   
 public static void setGEDealexpressPathOpptyRedirect() {
       GEDealexpressPathOpptyRedirect = true;
   }  

public static void setcirrestriction() {
       sBAddLeaderToSalesTeam = true;
   }
 

   
    Public static boolean sBCalcdeviationscr ()
    {
     return sBCalcdeviationscr;
    }
    Public static boolean sBCalcdeviationlvl ()
    {
     return sBCalcdeviationlvl;
    }
    Public static boolean sBERadacreation()
    {
     return sBERadacreation;
    }
    
    Public static boolean sBUpdatechklststatus ()
    {
     return sBUpdatechklststatus;
    }
    
     Public static boolean sAUpdatechklststatus ()
    {
     return sAUpdatechklststatus;
    }
    Public Static Boolean SPRMgenerateCOntracts ()
    {
    
    Return SPRMgenerateCOntracts ;
    }
    Public Static Boolean SRegionalApprovalDMO ()
    {
    Return SRegionalApprovalDMO ;
    }
    Public Static Boolean SProposalRevisionDMO ()
    {
    Return sProprevisioncrt ;
    }
    Public Static boolean sUpdateRstatusToR3 ()
    {
    Return sUpdateRstatusToR3 ;
    }
    
    Public static boolean sBPolicyApproveDMO ()
    {
    Return sBPolicyApproveDMO ;
    }
    
    public static boolean sSynchfieldafterinsert()
    {
    return sSynchfieldafterinsert;
    }

    public static boolean sBAddLeaderToSalesTeam() {
        return sBAddLeaderToSalesTeam;
    }
    
     public static boolean sBTest() {
        return sBTest;
    }
     public static boolean sBprmChannel() {
        return sBprmChannel;
    }
    
     public static boolean sBNumOFContactsforEmailid() {
        return sBNumOFContactsforEmailid;
    }
     public static boolean sBNumOFContactsforEmailidUpdate() {
        return sBNumOFContactsforEmailidUpdate;
    }

    public static boolean sBCreateDMRecord() {
        return sBCreateDMRecord;
    }
    
    public static boolean sBThreshold_Currency() {
        return sBThreshold_Currency;
    }
    
    public static boolean sBBmiProdDelete() {
        return sBBmiProdDelete;
    }
    
    public static boolean sBUpdateBMPriceMgmt() {
        return sBUpdateBMPriceMgmt;
    }
    
    public static boolean sBOptimizer() {
        return sBOptimizer;
    }
    
    public static boolean sBPIIApproveChkLstItms() {
        return sBPIIApproveChkLstItms;
    }
    
    public static boolean sBSyncFieldswithDM() {
        return sBSyncFieldswithDM;
    }
    
    public static boolean sBSyncFieldswithOppty() {
        return sBSyncFieldswithOppty;
    }
    
    public static boolean sBCalcCustomerCreditLimit() {
        return sBCalcCustomerCreditLimit;
    }
    
    public static boolean sBERamScoreUpdate() {
        return sBERamScoreUpdate;
    }
    
    public static boolean sBRecallchecklistitems() {
        return sBRecallchecklistitems;
    }
    
    public static boolean sBPolicyApprove() {
        return sBPolicyApprove;
    }
    
    public static boolean sBRegionalApproval() {
        return sBRegionalApproval;
    }
    
    public static boolean sBContractUpdate() {
        return sBContractUpdate;
    }
    
    public static boolean sBTMInstallationIDCounter() {
        return sBTMInstallationIDCounter;
    }
    
    public static boolean sBOpportunitySharing() {
        return sBOpportunitySharing;
    }
    
    public static boolean sBPartnerOpptySharing() {
        return sBPartnerOpptySharing;
    }

   public static boolean sTasktoCPR ()
   {
   
    return sTasktoCPR ;
    
    }
    
    public static boolean sDealmgnmttgr ()
    {   
    return Dealmgnmttgr;  
    }
    
    Public static boolean sSynchfieldswithopty ()
    {
    return sSynchfieldswithopty ;
    }
    
    //Added by vipin
    public static boolean sOppty_OLI_BI() {
       return sOppty_OLI_BI;
    }
    
    public static void setsOppty_OLI_BI() {
       sOppty_OLI_BI=true;
    }
   
    // By setting the variable to true, it maintains this  new value throughout the 
    // duration of the request  (or testMethod)  

    public static void setsBAddLeaderToSalesTeam() {
        sBAddLeaderToSalesTeam = true;
    }
    
     public static void setsBTest() {
        sBTest = true;
    }
    public static void setsBERadacreation() {
        sBERadacreation = true;
    }
    
     public static void setsBprmChannel() {
        sBprmChannel = true;
    }
      public static void setsBNumOFContactsforEmailid() {
        sBNumOFContactsforEmailid = true;
    }
    public static void setsBNumOFContactsforEmailidUpdate() {
        sBNumOFContactsforEmailidUpdate = true;
    }
    
    public static void setsBCreateDMRecord() {
        sBCreateDMRecord = true;
    }
    
    public static void setsBThreshold_Currency() {
        sBThreshold_Currency = true;
    }
    
    public static void setsBBmiProdDelete() {
        sBBmiProdDelete = true;
    }
    
    public static void setsBUpdateBMPriceMgmt() {
        sBUpdateBMPriceMgmt = true;
    }
    
    public static void setsBOptimizer() {
        sBOptimizer = true;
    }
    
    public static void setsBPIIApproveChkLstItms() {
        sBPIIApproveChkLstItms = true;
    }
    
    public static void setsBSyncFieldswithDM() {
        sBSyncFieldswithDM = true;
    }
    
    public static void setsBSyncFieldswithOppty() {
        sBSyncFieldswithOppty = true;
    }
    
    public static void setsBCalcCustomerCreditLimit() {
        sBCalcCustomerCreditLimit = true;
    }
    
    public static void setsBERamScoreUpdate() {
        sBERamScoreUpdate = true;
    }
    
    public static void setsBRecallchecklistitems() {
        sBRecallchecklistitems = true;
    }
    
    public static void setsBPolicyApprove() {
        sBPolicyApprove = true;
    }
    
    public static void setsBRegionalApproval() {
        sBRegionalApproval = true;
    }
    
    public static void setsBContractUpdate() {
        sBContractUpdate = true;
    }
    
    public static void setsBTMInstallationIDCounter() {
        sBTMInstallationIDCounter = true;
        
        system.debug('/// now we are in sBTMInstallationIDCounter method ///');
    }
    
    public static void setsBOpportunitySharing() {
        sBOpportunitySharing = true;
    }
    
    public static void setsBPartnerOpptySharing() {
        sBPartnerOpptySharing = true;
    }
    
    public static void setssTasktoCPR()
    {
    sTasktoCPR  =true;
    }
    
    
    public static void setssDealmgnmttgr()
    {
    Dealmgnmttgr =true;
    }
    public static void setsSynchfieldswithopty()
    {
    sSynchfieldswithopty =true;
    }
    public static void SetsSynchfieldafterinsert()
    {
    sSynchfieldafterinsert =true;
    }
    
    Public static void setsBPolicyApproveDMO()
    {
    sBPolicyApproveDMO =true;
    }
   Public static void SetsUpdateRstatusToR3()
   {
   sUpdateRstatusToR3 =true;
   
   } 
   Public Static void SetSRegionalApprovalDMO()
   {
   SRegionalApprovalDMO =true;
   }
   Public Static void SetSProposalRevisionDMO()
   {
   sProprevisioncrt =true;
   }
   
  Public static void setSPRMgenerateCOntracts()
  {
  SPRMgenerateCOntracts =true;
  } 
   Public static void setsSBCalcdeviationscr ()
    {
      sBCalcdeviationscr =true;
    }
    Public static void setsSBCalcdeviationlvl ()
    {
      sBCalcdeviationlvl =true;
    }
    Public static void setsSBUpdatechklststatus ()
    {
      sBUpdatechklststatus =true;
    }
   
   Public static void setsSAUpdatechklststatus ()
    {
      sAUpdatechklststatus =true;
    }
    // Added for Cases
    private static boolean sbeforeinsertbeforeupdatecaseCounterregionpopltion= false;
    private static boolean sbeforeupdatestatuschange= false;
    private static boolean sbeforeInsertbeforeUpdatePrePopulateParent = false;
    private static boolean sbeforeUpdateassignmentGroupField = false;
    
    Public static boolean sbeforeinsertbeforeupdatecaseCounterregionpopltion () {
        return sbeforeinsertbeforeupdatecaseCounterregionpopltion;
    }
    
    public static void setsbeforeinsertbeforeupdatecaseCounterregionpopltion() {
        sbeforeinsertbeforeupdatecaseCounterregionpopltion= true;
    }

    Public static boolean sbeforeupdatestatuschange () {
        return sbeforeupdatestatuschange;
    }
   
    public static void setsbeforeupdatestatuschange() {
        sbeforeupdatestatuschange= true;
    } 
    
    Public static boolean sbeforeInsertbeforeUpdatePrePopulateParent () {
        return sbeforeInsertbeforeUpdatePrePopulateParent;
    }
    
    public static void setsbeforeInsertbeforeUpdatePrePopulateParent() {
        sbeforeInsertbeforeUpdatePrePopulateParent= true;
    }

    Public static boolean sbeforeUpdateassignmentGroupField () {
        return sbeforeUpdateassignmentGroupField;
    }
    
    public static void setsbeforeUpdateassignmentGroupField() {
        sbeforeUpdateassignmentGroupField= true;
    }    
}