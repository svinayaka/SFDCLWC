/*
Class Name        : GE_ERPResourceURLGenerator
Purpose/Overview  : Utility service to generate URL endpoints for backend ERP resources.
Test Class        : GE_ERPResourceURLGeneratorTest
Change History    : Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
                  : 2014-06-27    : Htut Zaw           : Inital creation
*/
public class GE_ERPResourceURLGenerator
{
  public GE_ERPResourceURLGenerator()
  {

  }

  /*
  Purpose/Overview  : Convenience method to determine if current user is a partner user.
  Input Param       : n/a
  Return Param      : True if user is partner; else false
  Exceptions        : n/a
  */
  private static Boolean isChannelPartner()
  {
    //Profile prof = [Select Name from Profile where Id = :userInfo.getProfileId() LIMIT 1];
    //String profileName = prof.name;
    // if (profileName == 'GE Channel Partner Community Member')
    //GE_COMMUNITY_PROFILES__c prof = GE_COMMUNITY_PROFILES__c.getInstance(userInfo.getProfileId().substring(0,15));

    if (UserInfo.getUserType() == 'PowerPartner')
    {
      return (true);
    }

    return (false);
  }

  /*
   Purpose/Overview  : Method to provide URL link to the SAP Order Persona screen. This will need to be enhanced in future
                       to handle case where users need to be directed to different backend systems based on their user record,
                       profile, etc.... This logic has not been defined yet.
   Input Param       : order - the order to generate the link for
                       encodeFlag - flag to URL encode the response or not
   Return Param      : the order persona URL
   Exceptions        : n/a
   */
  public static String getOrderPersonaURL(ID orderId, Boolean encodeFlag)
  {
    GE_ERP_Endpoints__c orgDef = GE_ERP_Endpoints__c.getOrgDefaults();
    String url;

    Order order = [SELECT Id, OrderNumber, GE_SOR_Sales_Order__c, GE_Quote__r.GE_SOR_Quote_Number__c, Account.GE_HQ_DUNS_Number__c FROM Order WHERE ID = :orderId];

    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // create URL for case where SAP order number exists in SFDC; this implies integration already performed previously //
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    if (order.GE_SOR_Sales_Order__c != null)
    {
      url = orgDef.SAP_Persona_BaseURL__c + '?frameless=TRUE&~transaction=*ZS197%20P_SAP_OD%3d' + order.GE_SOR_Sales_Order__c;
    }
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // create URL for case where SFDC order number is tied to Quote where SAP order number was received through integration //
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    else if (order.GE_Quote__r.GE_SOR_Quote_Number__c != null)
    {
      url = orgDef.SAP_Persona_BaseURL__c + '?frameless=TRUE&~transaction=*ZS197%20P_SFDC%3d' + order.OrderNumber + '%3bP_SAP_QT%3d' + order.GE_Quote__r.GE_SOR_Quote_Number__c;
    }
    ///////////////////////////////////////////////////////////////////////////////////////////////
    // create URL for case where this is new SAP order not based on previous quote or order data //
    ///////////////////////////////////////////////////////////////////////////////////////////////
    else
    {
      url = orgDef.SAP_Persona_BaseURL__c + '?frameless=TRUE&~transaction=*ZS197%20P_SFDC%3d' + order.OrderNumber + '%3bP_DUNS%3d' + order.Account.GE_HQ_DUNS_Number__c;
    }

    System.debug('** URL=[' + url + ']');
    if (encodeFlag && (url != null)) url = EncodingUtil.urlEncode(url, 'UTF-8');


    return url;
  }

  /*
   Purpose/Overview  : Method to provide URL link to the SAP Quote Persona screen. This will need to be enhanced in future
                       to handle case where users need to be directed to different backend systems based on their user record,
                       profile, etc.... This logic has not been defined yet.
   Input Param       : quote - the quote to generate the link for
                       encodeFlag - flag to URL encode the response or not
   Return Param      : the quote persona URL
   Exceptions        : n/a
   */
  public static String getQuotePersonaURL(ID quoteId, Boolean encodeFlag)
  {
    GE_ERP_Endpoints__c orgDef = GE_ERP_Endpoints__c.getOrgDefaults();
    String P_DUNS = null;
    String P_SFDC = null;
    String P_SAP = null;

    Quote quote = [SELECT Id, QuoteNumber, GE_SOR_Quote_Number__c, Opportunity.Account.GE_HQ_DUNS_Number__c FROM Quote WHERE ID = :quoteId];

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

    System.debug('** URL=[' + url + ']');
    if (encodeFlag && (url != null)) url = EncodingUtil.urlEncode(url, 'UTF-8');

    return url;
  }


}