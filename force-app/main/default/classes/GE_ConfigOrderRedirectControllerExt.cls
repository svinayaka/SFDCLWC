/*
Class Name        : GE_ConfigOrderRedirectControllerExt
Purpose/Overview  : Controller extension used by the button on Order page to route new page to SAP Persona screen.
Test Class        : GE_ConfigOrderRedirectControllerExtTest
Change History    : Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
                  : 2014-04-11    : Htut Zaw           : Inital creation
*/
public with sharing class GE_ConfigOrderRedirectControllerExt
{
  private Order order;

  public GE_ConfigOrderRedirectControllerExt(ApexPages.StandardController stdController)
  {
    this.order = (Order)stdController.getRecord();
  }

  public PageReference redirectToPage()
  {
    String url = GE_ERPResourceURLGenerator.getOrderPersonaURL(order.Id, false);

    System.debug('** URL=[' + url + ']');

    PageReference p = new PageReference(url);
    return p;
  }
}