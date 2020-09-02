/*
Class                  : O_CreateRevenueSchedule_GE_OG
Used Where ?           : Called by SKUID when user clicks on the Revenue Schedule wizard
Purpose/Overview       : Used to get the list of Revenue schedule lines associated to a particular Opportunity Product
Scrum Team             : Opportunity Management
Requirement Number     : R-26547
Author                 : Rupal Seth
Created Date           : 18/DEC/2017
Test Class Name        : O_CreateRevenueSchedule_GE_OG_Test
Code Coverage          : 
*/

@RestResource(urlMapping='/O_CreateRevenueSchedule_GE_OG/*')
global class O_CreateRevenueSchedule_GE_OG {
    
    // Method to return the list of Revenue schedule lines corresponding to a particular Oppty Product
    @HttpGet
    global static List<RevenueLinesWrapper> retrieveRevenueLines()
    {
        List<RevenueLinesWrapper> revenueLinesWrapperList = new List<RevenueLinesWrapper>();
        
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        
        String OpptyLineItemId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        
        system.debug('\n\n ==== OpptyLineItemId : ==== '+OpptyLineItemId);
        system.debug('req'+req);
        if(String.isNotBlank(OpptyLineItemId)){
            //logic to calculate rev schedule lines here
            revenueLinesWrapperList = processRevenueSchedule(req);
            system.debug('revenueLinesWrapperList'+revenueLinesWrapperList);
            if(revenueLinesWrapperList.isEmpty()){
                RevenueLinesWrapper revenueLinesWrapper = new RevenueLinesWrapper();
                revenueLinesWrapper.amount = 0;
                revenueLinesWrapper.prodName='';
                revenueLinesWrapper.Status='Error';
                revenueLinesWrapper.tier2value = '';
                revenueLinesWrapper.tier3value = '';
                RevenueLinesWrapper.Forecast = '';
                revenueLinesWrapperList.add(revenueLinesWrapper);
            }
            System.debug('\n\n Revenue lines JSON '+revenueLinesWrapperList); 
        }
        return revenueLinesWrapperList; 
    }
    
    global static List<RevenueLinesWrapper> processRevenueSchedule(RestRequest req){
        //Variable Initialization & declaration.
        List<RevenueLinesWrapper> revenueLinesWrapperList = new List<RevenueLinesWrapper>();
        
        system.debug('R*R request'+ req);
        String oppLineItemId = req.params.get('oppLineItemId');
        system.debug('R*R oppLineItemId--------'+oppLineItemId);
        String splitAmount = req.params.get('splitAmount');
        system.debug('R*R splitAmount--------'+splitAmount);
        String revStartDate = req.params.get('revStartDate');
        system.debug('R*R revStartDate--------'+revStartDate);
        String numOfInstallments = req.params.get('numOfInstallments');
        system.debug('R*R numOfInstallments--------'+numOfInstallments);
        String frequency = req.params.get('frequency');
        system.debug('R*R frequency--------'+frequency);
        String commitFlag = req.params.get('commitFlag');
        system.debug('R*R commitFlag---------'+commitFlag);
        String revForecast = req.params.get('RevForecast');
        
        Integer wrapSplitAmount = 0;
        
        List<OpportunityLineItem> oppItemList = new List<OpportunityLineItem>();
        oppItemList = getOpporutnityItemDetails(oppLineItemId);
        
        if(String.isNotBlank(frequency) && String.isNotBlank(numOfInstallments)
           && String.isNotBlank(splitAmount) && String.isNotBlank(revStartDate)){
               //Inside all not blank loop
               
               //wrapSplitAmount = (Decimal.ValueOf(splitAmount)).setScale(2)/(Decimal.ValueOf(numOfInstallments)).setScale(2);
               wrapSplitAmount = Math.round((Decimal.ValueOf(splitAmount)).setScale(2)/Integer.ValueOf(numOfInstallments));
               system.debug('R*R wrapSplitAmount--------'+wrapSplitAmount);
               
               if(frequency.toLowerCase()==(Label.RevSchedule_Yearly).toLowerCase()){
                   system.debug('R*R frequency after converting to lower case for yearly'+frequency);
                   for(integer i=0;i<Integer.ValueOf(numOfInstallments);i++){
                       system.debug('R*R i---------'+i);
                       RevenueLinesWrapper revWrapper = new RevenueLinesWrapper();
                       revWrapper.amount = wrapSplitAmount;
                       system.debug('R*R revWrapper.amount'+revWrapper.amount);
                       if(!oppItemList.isEmpty()){
                           revWrapper.tier2value = oppItemList.get(0).GE_PTier2_PL__c;
                           system.debug('R*R revWrapper.tier2value'+revWrapper.tier2value);
                           revWrapper.tier3value = oppItemList.get(0).GE_PTier3_PL__c;
                           system.debug('R*R revWrapper.tier3value'+revWrapper.tier3value);
                           revWrapper.prodName = oppItemList.get(0).product2.Name;
                           revWrapper.Forecast = revForecast;
                           system.debug('R*R revWrapper.prodName'+revWrapper.prodName);
                       }
                       //Outside oppItemList loop
                       system.debug('R*R revStartDate before date calculation'+revStartDate);
                       //added the following to initialize lastdate before calculation
                       revWrapper.StartDate = i==0?(Date.valueOf(revStartDate)):(Date.valueOf(revStartDate)).addYears(1);
                       revStartDate =  String.ValueOf(revWrapper.StartDate);
                       revWrapper.Status = 'Success';
                       revenueLinesWrapperList.add(revWrapper);
                   }
               }
               else if(frequency.toLowerCase()==(Label.RevSchedule_Quarterly).toLowerCase()){
                   system.debug('R*R frequency after converting to lower case for Quarterly'+frequency);
                   for(integer i=0;i<Integer.ValueOf(numOfInstallments);i++){
                       RevenueLinesWrapper revWrapper = new RevenueLinesWrapper();
                       revWrapper.amount = wrapSplitAmount;
                       system.debug('R*R revWrapper.amount'+revWrapper.amount);
                       if(!oppItemList.isEmpty()){
                           revWrapper.tier2value = oppItemList.get(0).GE_PTier2_PL__c;
                           system.debug('R*R revWrapper.tier2value'+revWrapper.tier2value);
                           revWrapper.tier3value = oppItemList.get(0).GE_PTier3_PL__c;
                           system.debug('R*R revWrapper.tier3value'+revWrapper.tier3value);
                           revWrapper.prodName = oppItemList.get(0).product2.Name;
                           system.debug('R*R revWrapper.prodName'+revWrapper.prodName);
                           revWrapper.Forecast = revForecast;
                       }
                       //Outside oppItemList loop
                       system.debug('R*R revStartDate before date calculation'+revStartDate);
                       revWrapper.StartDate = i==0?(Date.valueOf(revStartDate)):(Date.valueOf(revStartDate)).addMonths(3);
                       revStartDate =  String.ValueOf(revWrapper.StartDate);
                       revWrapper.Status = 'Success';
                       revenueLinesWrapperList.add(revWrapper);
                   }
               }
               else if(frequency.toLowerCase()==(Label.RevSchedule_Monthly).toLowerCase()){
                   system.debug('R*R frequency after converting to lower case for monthly'+frequency);
                   for(integer i=0;i<Integer.ValueOf(numOfInstallments);i++){
                       RevenueLinesWrapper revWrapper = new RevenueLinesWrapper();
                       revWrapper.amount = wrapSplitAmount;
                       system.debug('R*R revWrapper.amount'+revWrapper.amount);
                       if(!oppItemList.isEmpty()){
                           revWrapper.tier2value = oppItemList.get(0).GE_PTier2_PL__c;
                           system.debug('R*R revWrapper.tier2value'+revWrapper.tier2value);
                           revWrapper.tier3value = oppItemList.get(0).GE_PTier3_PL__c;
                           system.debug('R*R revWrapper.tier3value'+revWrapper.tier3value);
                           revWrapper.prodName = oppItemList.get(0).product2.Name;
                           system.debug('R*R revWrapper.prodName'+revWrapper.prodName);
                           revWrapper.Forecast =revForecast;
                       }
                       //Outside oppItemList loop
                        system.debug('R*R revStartDate before date calculation'+revStartDate);
                       //kiru changed this  from 1 to i - testing AND commented line 141
                       revWrapper.StartDate = i==0?(Date.valueOf(revStartDate)):(Date.valueOf(revStartDate)).addMonths(i);
                      // revStartDate =  String.ValueOf(revWrapper.StartDate);
                       revWrapper.Status = 'Success';
                       revenueLinesWrapperList.add(revWrapper);
                   }
               }
           }
        
        
        return revenueLinesWrapperList;
    }
    
    global static List<OpportunityLineItem> getOpporutnityItemDetails(String oppLineItemId){
        List<OpportunityLineItem> oppItemList = new List<OpportunityLineItem>();
        
        if(String.isNotBlank(oppLineItemId))
            oppItemList=[Select Id,Product2.Name,GE_PTier2_PL__c,GE_PTier3_PL__c
                         From OpportunityLineItem Where Id=: oppLineItemId];
        
        return oppItemList;
    }
    
    global class RevenueLinesWrapper
    {
        public String Status {get;set;}  
        public Decimal amount {get;set;}
        public Date StartDate {get;set;}
        public String prodName {get;set;}
        public String tier2value {get;set;}
        public String tier3value {get;set;}
        public String Forecast {get;set;}
        
        
    }
    
}