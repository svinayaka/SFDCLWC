/*
Type Name [Class/Trigger/Page Name] : Apex Trigger
Used Where ?                        : To Update the KYC Complete Flags on the Associated Account
Purpose/Overview                    : Once the KYC Status Reaches to KYC Complete the Associated Account should be Flagged as KYC Complete.
Functional Area                     : PRM
Author                              : Sanjay Kumar Patidar
Created Date                        : 7th July 2011
Test Class Name                     : Test_GE_PRM_Related_Triggers

Change History -
Date Modified   : Developer Name    : Method/Section Modified/Added     : Purpose/Overview of Change
01/12/2011        Elavarasan          Adding a logic to autopopulate the regional compliance manger field of KYC for R-6389
10/04/2011        Prasad Yadala       Adding logic to set Due Diligence on afa R-12262
12/27/2013        Pragyaa Dutta       Added logic to set Due Diligence Completed on RFA R-12347
01/22/2014        Prasad Yadala       Updated the rfa soql criteria for the bug 0000017350
01/31/2014        Prasad Yadala       Updated status picklist lovs for the requirement R-12442
*/

Trigger GE_PRM_KYC_Completed on GE_PRM_KYC_Termination_Checklist__c (Before Insert, Before Update) 
    {
    
    
    Set<Id> KYCAccountSet = new Set<Id>();
    /* //Variable Declaration
    List<Account> updateAccounts = new List<Account>();
    
    Logic to populate regional compliance manager start 
    
    Set<ID> recomIds = new Set<Id>();
    
    if(Trigger.isBefore){
        for(GE_PRM_KYC_Termination_Checklist__c kycObject: Trigger.New){
            if(kycObject.GE_PRM_Recommendation__c != null) {
                //Add recommendation Ids to the set 
                recomIds.add(kycObject.GE_PRM_Recommendation__c);
            }
        }
        
        //Query the recommendation object and assign it to the map
        Map<Id, GE_PRM_Recommendation__c> recomMap = new Map<Id, GE_PRM_Recommendation__c>([select id, GE_PRM_Regional_Compliance_Manager__c from GE_PRM_Recommendation__c where id IN: recomIds]);
        
        if(recomMap.size() > 0){
            for(GE_PRM_KYC_Termination_Checklist__c kyc: Trigger.New){
                //Assign the regional compliance manager of KYC value
                kyc.GE_PRM_Regional_Compliance_Manager__c = recomMap.get(kyc.GE_PRM_Recommendation__c).GE_PRM_Regional_Compliance_Manager__c;
            }
        }
    }
    
    /* Logic to populate regional compliance manager End    
    
    
    //Logic for due diligence to update afa when KYC user completes the kyc section 
    Set<Id> AccIds = new Set<Id>();
    
    //trigger the due diligence on afa when kyc updates the prm section
    if(Trigger.isbefore && Trigger.isupdate)
    for(GE_PRM_KYC_Termination_Checklist__c kyc: Trigger.New)
    {
        if(kyc.GE_PRM_Status__c != Trigger.oldMap.get(kyc.Id).GE_PRM_Status__c &&( kyc.GE_PRM_Status__c == 'Due Diligence Accepted'||kyc.GE_PRM_Status__c == 'KYC Passed'))
        {
            AccIds.add(kyc.GE_HQ_Account__c);
            kyc.GE_PRM_KYC_Completed_Time_Stamp__c = datetime.now();
        }    
    }
    List<GE_PRM_Appointment__c> ddLst = new List<GE_PRM_Appointment__c>();
    if(AccIds.size() > 0)
    {
        ddLst = [select id,GE_PRM_Due_Deligence__c,GE_PRM_Status__c,GE_PRM_Due_Diligence_Completion__c from GE_PRM_Appointment__c where GE_PRM_Due_Diligence_Completion__c = null and GE_PRM_Account_Name__c in: AccIds and GE_PRM_Afa_Type__c = 'Fast Track' and GE_PRM_Status__c != 'Approved' and GE_PRM_Status__c != 'Archived'];
    }
    List<GE_PRM_Appointment__c> finalafaLst = new List<GE_PRM_Appointment__c>();
    for(GE_PRM_Appointment__c app:ddLst)
    {
        app.GE_PRM_Due_Deligence__c = true;
        app.GE_PRM_Due_Diligence_Completion__c = datetime.now();
        app.GE_PRM_Refresh_from_CMF__c = true;
        finalafaLst.add(app);
    }
    
    if(finalafaLst.size() > 0)
    update finalafaLst;   
    
   //Added by Pragyaa- logic to set Due Diligence Completed on RFA R-12347
    List<GE_PRM_Recommendation__c> rrLst = new List<GE_PRM_Recommendation__c>();
    if(AccIds.size() > 0)
    {
        rrLst = [select id, GE_PRM_Status__c, GE_PRM_Due_Diligence_Completed__c from GE_PRM_Recommendation__c where GE_PRM_Account__c in: AccIds and GE_PRM_Status__c != 'Archived' and GE_PRM_Due_Diligence_Completed__c = null and GE_PRM_RFA_Type__c != null];
    }
    List<GE_PRM_Recommendation__c> finalrfaLst = new List<GE_PRM_Recommendation__c>();
    for(GE_PRM_Recommendation__c rfa:rrLst)
    {
        rfa.GE_PRM_Due_Diligence_Completed__c = datetime.now();
        finalrfaLst.add(rfa);
    }
    if(finalrfaLst.size() > 0)
    update finalrfaLst;
    //Logic End
    
    //Loop through the KYC Records to find the Completed One's.
    for(GE_PRM_KYC_Termination_Checklist__c KYC: Trigger.new)
        {
        if(KYC.GE_PRM_Status__c == 'KYC Passed' || KYC.GE_PRM_Status__c == 'Due Diligence Accepted')
            {
                //Add the Account Id to Set
                KYCAccountSet.add(KYC.GE_PRM_Account_Id__c);
            }
        }
    
    //Query the Account where the PRM KYC is not True.    
    List<Account>  KYCAccounts = new List<Account>([Select Id, Name, GE_HQ_KYC_Complete__c, GE_PRM_KYC_Completed__c from Account where Id IN:KYCAccountSet and GE_PRM_KYC_Completed__c != true]);
    
    //Update the Accounts and Update the KYC Flags to True.
    for(Account KYCtobeUpdate: KYCAccounts)
        {
            Account UpdateAccount = new Account(Id=KYCtobeUpdate.Id);
            UpdateAccount.GE_HQ_KYC_Complete__c = True;
            UpdateAccount.GE_PRM_KYC_Completed__c = True;
            updateAccounts.add(UpdateAccount);
        }
    
    if(updateAccounts.size() > 0)
        {
            //Update Statement.
            Update updateAccounts;
        } 
         */ 
                
    }