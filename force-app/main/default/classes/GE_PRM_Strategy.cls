/*
Type Name [Class/Trigger/Page Name] : Class
Used Where ?                        : Used in the VF page  GE_PRM_Strategy
Purpose/Overview                    : Lists the Business Plans(Account Plans) for an Account.
Functional Area                     : PRM
Author                              : Pragyaa Dutta
Created Date                        : 3/2/2012
Test Class Name                     : Test_GE_PRM_Strategy                

Change History -
Date Modified   : Developer Name        : Method/Section Modified/Added     : Purpose/Overview of Change
*/

public with sharing class GE_PRM_Strategy 
    {
    public Id PartnerAccountId;
    public string sRedirectUrl {get;set;}
    public List<GE_HQ_Account_Plan__c> objAccountPlan {get;set;}
    public List<GE_HQ_Acc_AccPlan_Rel__c> objPlannedAccount {get; set; }
    public integer iAPsize {get;set;}
    
    
            
        public GE_PRM_Strategy(ApexPages.StandardController controller)
        {
        
        List<Account> objAccount = [Select Id, Name from Account Limit 1];
        Id userId = UserInfo.getUserId();
        
        PartnerAccountId  = [select id, AccountId from user where id=: userId].AccountId;
        //Fetching the Account ID of logged in Partner User
        
        
        objPlannedAccount = [select GE_HQ_Account_Plan__c from GE_HQ_Acc_AccPlan_Rel__c where GE_HQ_Account__c =: PartnerAccountId];
        
        
        Set<Id> setAccountPlanIds = new Set<Id>();
        for(Integer i = 0; i<objPlannedAccount.size(); i++){
            setAccountPlanIds.add(objPlannedAccount.get(i).GE_HQ_Account_Plan__c);
        }
        
        //Retrieving the Business Plans(Account Plans) for the particular Account
        objAccountPlan= [Select Id, Name, GE_PRM_Account__r.name, GE_PRM_Account__c, GE_PRM_Status__c, GE_PRM_Tier_1__c, GE_PRM_Year__c, GE_PRM_Channel_Sales_Manager__c from GE_HQ_Account_Plan__c where Id IN: setAccountPlanIds order by GE_PRM_Year__c desc];
        iAPsize = objAccountPlan.size();
                           
        if(objAccountPlan.size()>0)
        {
            sRedirectUrl = '/apex/GE_PRM_Strategy?Id='+ PartnerAccountId;
        }
        else
        {
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.INFO,'No Account Plans');
            ApexPages.addMessage(msg);
            sRedirectUrl = '/apex/GE_PRM_Strategy?Id='+ PartnerAccountId;
              
        }
                
        
        
        }
    }