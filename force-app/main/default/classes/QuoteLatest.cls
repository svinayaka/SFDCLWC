global class QuoteLatest { 
  webService static String rtnQuoteId(String OpptyId) {
      Quote quoteObj= [select Id, OpportunityId from Quote where OpportunityId=:OpptyId ORDER BY CreatedDate desc Limit 1];
      return quoteObj.id; 
    }
}