/*
Class Name        : GE_PartCommQuoteControllerExt
Purpose/Overview  : Used as an extension of the standard Quote controller for use with All Quotes View VF page
Author            : Htut Zaw
Test Class        : GE_PartCommQuoteControllerExtTest
Change History    : Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
                  : 06.06.2014    : Htut Zaw           : All                           : Initial Creation
*/
public with sharing class GE_PartCommQuoteControllerExt
{

  private final Quote qt;

  public GE_PartCommQuoteControllerExt(ApexPages.StandardSetController controller)
  {
    this.qt = (Quote)controller.getRecord();
  }
  public ApexPages.StandardSetController quoteRecords
  {
    get {

      if (quoteRecords == null)
      {
        date d = system.today().addDays(-90);
        return new ApexPages.StandardSetController(Database.getQueryLocator(
          [SELECT Id, name, QuoteNumber, Status, OpportunityId, Opportunity.Name, Opportunity.Account.Name, ExpirationDate, GE_SOR_Grand_Total__c, CreatedDate 
             FROM Quote 
            WHERE CreatedDate >= :d 
            ORDER BY CreatedDate DESC]));
      }

      return quoteRecords;
    }
    private set;
  }
  public List<Quote> getQuotePagination()
  {
    return (List<Quote>) quoteRecords.getRecords();
  }
}