public with sharing class OpportunityCtrl {
    @AuraEnabled(cacheable=true)
    public static List<Opportunity> getOppList() {
        return [SELECT Id, Name, Type, StageName,
        Amount, LeadSource
            FROM Opportunity]; //  Where OwnerId=:UserInfo.getUserId() limit 20 
    }
    
    @AuraEnabled(cacheable=true)
    public static List<Opportunity> getAllOpptyList(){
        return [SELECT Id,Name,Type,StageName,Amount,LeadSource From Opportunity limit 20];
    }
    
    @AuraEnabled(cacheable=true)
    public static List<Opportunity> getMyTeamReqularOpptyList(){
        
       // Opportunity.Forecast_Basis_ge_og__c = 'Revenue Recognition';
       // 
        
       List<Opportunity> teamReqularOppLst;
       
        //if(Opportunity.Forecast_Basis_ge_og__c = 'Orders Recognition')
       		//teamReqularOppLst = [SELECT RecordTypeId,Name,AccountId,Account.Name,StageName,tier_2_ge_og__c,tier_3_ge_og__c,amount_ge_og__c,(SELECT TeamMemberRole,UserId,Name,Id FROM OpportunityTeamMembers ),ForecastCategoryName,CloseDate,Opportunity_Revenue_Forecast_ge_og__c,Pending_Revenue_ge_og__c,Synergy_Opportunity_ge_og__c,CreatedDate,CreatedById,CreatedBy.Name,Has_Revenue_Forecast_ge_og__c,quote_type_ge_og__c,sub_region_ge_og__c,Has_MMI_Demand_ge_og__c,Must_Win_ge_og__c,oppty_cm_ge_og__c,deal_path_ge_og__c,LastModifiedDate,opportunity_number_ge_og__c,tier_4_ge_og__c,Contains_ET_Product__c,Id,CurrencyIsoCode FROM Opportunity WHERE (Id in (SELECT OpportunityId FROM OpportunityTeamMember WHERE (((UserId = '0051H000009S5D2QAK')OR(UserId in ('005A0000005bPHJIA2'))))))AND(RecordType.Name != 'Targets')AND((Forecast_Basis_ge_og__c = 'Revenue Recognition')OR(Synergy_Opportunity_ge_og__c = 'Yes')OR(Has_Digital_Product_ge_og__c > 0)) ORDER BY Id LIMIT 101"];
       // else
            
    	teamReqularOppLst = [SELECT Name,opportunity_number_ge_og__c,OwnerId,Owner.Name,PartnerAccountId,PartnerAccount.Name,tier_2_ge_og__c,
                tier_3_ge_og__c,StageName,ForecastCategoryName,CloseDate,amount_ge_og__c,
                (SELECT Name,TeamMemberRole,UserId,Id FROM OpportunityTeamMembers LIMIT 500),
                IsClosed,is_confidential_ge_og__c,CreatedDate,AccountId,Account.Name,region_ge_og__c,MultiTier3_ge_og__c,
                Synergy_Opportunity_ge_og__c,CreatedById,CreatedBy.Name,quote_type_ge_og__c,opportunity_type_ge_og__c,sub_region_ge_og__c,
                Has_MMI_Demand_ge_og__c,Must_Win_ge_og__c,oppty_cm_ge_og__c,deal_path_ge_og__c,LastModifiedDate,has_cm_ge_og__c,Account.Id,
                tier_4_ge_og__c,Id,CurrencyIsoCode FROM Opportunity 
                WHERE (Id in (SELECT OpportunityId FROM OpportunityTeamMember 
                              WHERE (((UserId = '0051H000009S5D2QAK')OR(UserId in ('005A0000005bPHJIA2'))))))AND
                			  (RecordType.Name != 'Targets') ORDER BY Id LIMIT 51];
        
        return teamReqularOppLst;
    }
    
    @AuraEnabled(cacheable=true)
    public static Task GetTaskRecords(Id taskId) 
    {
       
        Task task = [SELECT Id, OwnerId, Status, Priority, ActivityDate, Type, WhatId, Subject, Description FROM Task WHERE Id =: taskId LIMIT 1];
        System.debug('task'+task);
        return task;
    }
    
    
    @AuraEnabled(cacheable=true)
    public static List<Opportunity> getMyTeamRevenueOpptyList(){
        
        List<Opportunity> teamRevenueOpptyList;
        teamRevenueOpptyList = [SELECT RecordTypeId,Name,AccountId,Account.Name,StageName,tier_2_ge_og__c,tier_3_ge_og__c,amount_ge_og__c,
        			(SELECT TeamMemberRole,UserId,Name,Id FROM OpportunityTeamMembers ),ForecastCategoryName,CloseDate,
        			Opportunity_Revenue_Forecast_ge_og__c,Pending_Revenue_ge_og__c,Synergy_Opportunity_ge_og__c,CreatedDate,
        			CreatedById,CreatedBy.Name,Has_Revenue_Forecast_ge_og__c,quote_type_ge_og__c,sub_region_ge_og__c,
        			Has_MMI_Demand_ge_og__c,Must_Win_ge_og__c,oppty_cm_ge_og__c,deal_path_ge_og__c,LastModifiedDate,
        			opportunity_number_ge_og__c,tier_4_ge_og__c,Id,CurrencyIsoCode FROM Opportunity //Contains_ET_Product__c,
        			WHERE (Id in (SELECT OpportunityId FROM OpportunityTeamMember 
        						WHERE (((UserId = '0051H000009S5D2QAK')OR(UserId in ('005A0000005bPHJIA2'))))))AND
        						(RecordType.Name != 'Targets')AND((Forecast_Basis_ge_og__c = 'Revenue Recognition')OR
        						(Synergy_Opportunity_ge_og__c = 'Yes')OR(Has_Digital_Product_ge_og__c > 0))
        						ORDER BY Id LIMIT 101];
        return teamRevenueOpptyList;
        
    }
    
    @AuraEnabled
    public static void saveTaskRecord(Task objTask){
        try{
             System.debug('objTask====>'+objTask);
            insert objTask;
            System.debug('objTask==11==>'+objTask);
        }
        catch(Exception ex) {
            throw new AuraHandledException(ex.getMessage());
        }
    }
    
    @AuraEnabled(cacheable=true)
    public static List<User> getUserNames(){
        return [SELECT Id,Name FROM User where isActive=True limit 50];
    }
    
    
    public class CustomSelectOptions{
        @AuraEnabled public String label {get;set;}
        @AuraEnabled public String value {get;set;}
    
        public CustomSelectOptions() {
            this.label = '';
            this.value = '';
        }
    
        public CustomSelectOptions(String lab, String val) {
            this.label = lab;
            this.value = val;
        }
    }
    
    @AuraEnabled(cacheable=true)
    public static List<CustomSelectOptions> getPicklistVal() {//String sObj, String field
        String sObj='Task';
        String field='Subject';    
        List<CustomSelectOptions> options = new List<CustomSelectOptions>();
        Map<String, Schema.SObjectField> fieldMap = Schema.getGlobalDescribe().get(sObj).getDescribe().fields.getMap();
        Schema.SObjectField sObjfield = fieldMap.get(field);
        Schema.DescribeFieldResult fieldDesc = sObjfield.getDescribe();
        List<Schema.PicklistEntry> ple = fieldDesc.getPicklistValues();
            for( Schema.PicklistEntry f : ple) {
                System.debug('f.getLabel()===>'+f.getLabel()+'<===f.getValue()===>'+f.getValue());
            options.add(new CustomSelectOptions(f.getLabel(), f.getValue()));
        }       
        return options;
    }
    
    @AuraEnabled(cacheable=true)
    public static List<Task> getTaskList(String recdId){
        System.debug('recdId===>'+recdId);
        return [SELECT ActivityDate,OwnerId,Priority,Id,RecordTypeId,Status,Subject,Type,WhatId FROM Task WHERE WhatId = '0061200000Xx0obAAB'];
    }
}