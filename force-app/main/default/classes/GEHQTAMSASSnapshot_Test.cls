@isTest
private class GEHQTAMSASSnapshot_Test
{
/*
    static testMethod void GEHQTAMSASSnapshot_Test()
    {
         // Creating a new Account Plan
        GE_HQ_Account_Plan__c AccPlan = new GE_HQ_Account_Plan__c();
        AccPlan.GE_HQ_Business_Tier1__c = 'ES';
        // R-24261  GE_HQ_P_L__c  Deleted 
        //AccPlan.GE_HQ_P_L__c = 'ES > MCS';
        Insert AccPlan;
        
        // Creating a new Account
        Account Acc1 = new Account(Name = 'Test account',BillingCountry = 'USA',ShippingCountry = 'USA',ShippingState = 'AT',ShippingCity = 'TestShipping City',ShippingStreet = 'Test Shipping Street',ShippingPostalCode = '101010');
        Insert Acc1;
        
        // Creating the junction object record to connect the Account and Account Plan
        GE_HQ_Acc_AccPlan_Rel__c AccPlanRel = new GE_HQ_Acc_AccPlan_Rel__c();
        AccPlanRel.GE_HQ_Account__c = Acc1.Id;
        AccPlanRel.GE_HQ_Account_Plan__c = AccPlan.Id;
        Insert AccPlanRel;
        
        List<GE_HQ_TAM_SAS_Snap__c> TSSnapList= new List<GE_HQ_TAM_SAS_Snap__c>();
        
        String[] Pnl = new String[]{'Env','Dresser','HQ','Industrial','MCS','Nuclear','PGS'};
        For(Integer i=0; i< Pnl.size(); i++)
        {
            GE_HQ_TAM_SAS_Snap__c TSSrec = new GE_HQ_TAM_SAS_Snap__c(GE_HQ_Acc_Planning__c=AccPlan.Id, GE_HQ_Tier2_P_L__c= Pnl[i], GE_HQ_Year__c='2011', GE_HQ_Type__c='SAS', GE_HQ_TAM_SAS_SumVal__c=500 );
            TSSnapList.add(TSSrec);
        } // List of TSSnapRecords are created.
        

        
        PageReference pageRef = Page.GEHQTAMSASSnapshot;
        Test.setCurrentPageReference(pageRef);
        //Setting the page's Id to the id of Account plan.
        ApexPages.currentPage().getParameters().put('id', AccPlan.Id);
        
        ApexPages.StandardController con = new ApexPages.StandardController(AccPlan);
        
        GEHQTAMSASSnapshotController FC = new GEHQTAMSASSnapshotController(con);
        FC.getPnLs();
        FC.getTAMSASRecords();
        Insert TSSnapList;        // Insert TSSnapRecs. and then again call the function.
        FC.SelectedYear='';
        FC.SelectedPnL='%';
        FC.SelectedType = '%';
        FC.Find();
        FC.getTAMSASRecords();
        FC.getNext();
        FC.TAMSASRecords = FC.getTAMSASRecords();    // To run the else conditions in the block.
        FC.getPrev();
        FC.getLast();
        FC.getNext();
        FC.getNext();
        FC.getFirst();
        FC.getPrev();
        FC.Save();
        
        List<GE_HQ_TAM_SAS__c> TSrecs = new List<GE_HQ_TAM_SAS__c>();
        For(Integer i=0; i< Pnl.size()-1; i++)
        {
            TSrecs.add(new GE_HQ_TAM_SAS__c(GE_HQ_Account__c=Acc1.Id, GE_HQ_Tier2_P_L__c=Pnl[i], GE_HQ_Type__c='SAS',GE_HQ_Year__c='2011',GE_HQ_Value__c=200) );
        }
        Insert TSrecs;
        FC.Refresh();
    }
    */
}