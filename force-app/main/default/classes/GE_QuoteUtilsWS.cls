/*
Class Name        : GE_QuoteUtilsWS
Purpose/Overview  : Webservice used by javascript actions to retrieve latest Quote Id for a given opportunity id.
Test Class        : GE_QuoteUtilsWSTest
Change History    : Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
                  : 2014-04-11    : Htut Zaw           : Inital creation
*/
global class GE_QuoteUtilsWS
{
  webService static String rtnQuoteId(String OpptyId)
  {
    Quote quoteObj = [select Id, OpportunityId from Quote where OpportunityId = :OpptyId ORDER BY CreatedDate desc Limit 1];
    return quoteObj.id;
  }
}