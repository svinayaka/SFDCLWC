/*
Class Name        : GE_CreateOrderWS
Purpose/Overview  : Webservice used to create an order based on a given quote id. Also create Order from Case.
Test Class        : GE_CreateOrderWSTest
Change History    : Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
                  : 2014-04-11    : Htut Zaw           : Inital creation
*/
global class GE_CreateOrderWS
{
  /*
  Purpose/Overview  : Method to Create Order from Quote
  Input Param       : QuoteId
  Return Param      : OrderId
  Exceptions        : NA
  */
  webservice static String creatOrder(String QuoteId)
  {
    Quote quoteObj = null;
    Opportunity opptyObj = null;
    Case caseObj = null;

    quoteObj = [select Id, OpportunityId from Quote where id = :QuoteId LIMIT 1];
    opptyObj = [select Id, AccountId from Opportunity where id = :quoteObj.OpportunityId LIMIT 1];

    /////////////////////////////////////////////////////////////////////////////
    // try to get case associated to oppty but nullify if any SOQL query error //
    /////////////////////////////////////////////////////////////////////////////
    try
    {
      caseObj = [select Id from Case where ParentId = null AND Opportunity_Name__c = :opptyObj.Id LIMIT 1];
    }
    catch (Exception e)
    {
      // do nothing for now as this assumes special case where Case is not associatted to an oppty
      caseObj = null;
    }

    Order newOrder = new Order(
      GE_Quote__c = quoteObj.Id,
      Status = 'NA',
      AccountId = opptyObj.AccountId,
      EffectiveDate = date.today());

    if ((caseObj != null) && (caseObj.Id != null)) newOrder.Case__c = caseObj.Id;

    insert newOrder;

    return newOrder.id;
  }

  /*
  Purpose/Overview  : Method to Create an Order from a Case
  Input Param       : CaseId
  Return Param      : OrderId
  Exceptions        : NA
  */
  webservice static String createOrderForCase(String caseId)
  {
    Case cs = [SELECT Id, AccountId, Origin FROM Case WHERE Id = :caseId LIMIT 1];
    Order ord = new Order(
      AccountId = cs.AccountId,
      EffectiveDate = date.today(),
      Status = 'NA',
      Case__c = cs.Id);
    insert ord;

    return ord.Id;
  }
}