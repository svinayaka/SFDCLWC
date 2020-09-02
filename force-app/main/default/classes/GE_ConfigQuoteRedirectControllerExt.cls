/*
Class Name        : GE_ConfigQuoteRedirectControllerExt
Purpose/Overview  : Controller extension used by the button on Quote page to route new page to SAP Persona screen.
Test Class        : GE_ConfigQuoteRedirectControllerExtTest
Change History    : Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
                  : 2014-06-11    : Htut Zaw           : Inital creation
*/
public with sharing class GE_ConfigQuoteRedirectControllerExt
{
  private Quote quote;

  public GE_ConfigQuoteRedirectControllerExt(ApexPages.StandardController stdController)
  {
    this.quote = (Quote)stdController.getRecord();
    //this.quote = [SELECT Id, QuoteNumber, GE_SOR_Quote_Number__c, Opportunity.Account.GE_HQ_DUNS_Number__c From quote WHERE Id = :quote.Id];
  }


  public PageReference redirectToPage()
  {
    String url = GE_ERPResourceURLGenerator.getQuotePersonaURL(quote.Id, false);

/*
    GE_ERP_Endpoints__c orgDef = GE_ERP_Endpoints__c.getOrgDefaults();
    String P_DUNS = null;
    String P_SFDC = null;
    String P_SAP = null;

 
    // set SAP parameters
    P_DUNS = quote.Opportunity.Account.GE_HQ_DUNS_Number__c;
    P_SFDC = quote.QuoteNumber;

    if (quote.GE_SOR_Quote_Number__c != null)
    {
      P_SAP = quote.GE_SOR_Quote_Number__c;
    }

    String url = '';

    //////////////////////////////////////////////////////////////////////////////////////////////////////////
    // handle case for channel partners accessing a quote, this needs to be routed through DMZ and not sure //
    // full URL at this time so keeping separate from other logic                                           //
    //////////////////////////////////////////////////////////////////////////////////////////////////////////
    if (isChannelPartner())
    {
      url = orgDef.DMZ_Persona_BaseURL__c + '?frameless=TRUE&~transaction=*ZS196%20P_DUNS%3d' + P_DUNS + '%3bP_SFDC%3d' + P_SFDC;
      if (P_SAP != null)
      {
        url += '%3bP_SAP%3d' + P_SAP;
      }
    }
    /////////////////////////////////////////////////////////
    // handle internal CCR users and non-community members //
    /////////////////////////////////////////////////////////
    else
    {
      url = orgDef.SAP_Persona_BaseURL__c + '?frameless=TRUE&~transaction=*ZS196%20P_DUNS%3d' + P_DUNS + '%3bP_SFDC%3d' + P_SFDC;
      if (P_SAP != null)
      {
        url += '%3bP_SAP%3d' + P_SAP;
      }
    }
*/
    System.debug('** URL=[' + url + ']');

    PageReference p = new PageReference(url);
    return p;
  }

}