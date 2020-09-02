global class QuoteToOrder { 
  webService static String creatOrder(String QuoteId) {

      Quote quoteObj= [select Id, OpportunityId from Quote where id=:QuoteId];
      Opportunity opptyObj= [select Id, AccountId from Opportunity where id=:quoteObj.OpportunityId];
      Order newOrder = new Order(
                      GE_Quote__c = quoteObj.Id,
                      AccountId = opptyObj.AccountId,
                      Status = 'A - Not Yet Processed',
                      EffectiveDate = date.today());
      insert newOrder;
      
      return newOrder.id; 
    }
}