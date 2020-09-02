/*
Class Name        : GE_QuoteSyncWS
Purpose/Overview  : Web service exposed to receive SAP Quote header and PDF object details.
Author            : Htut Zaw
Test Class        : GE_QuoteSyncWSTest
Change History    : Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
                  : 2014-04-11    : Htut Zaw           : Inital creation
*/
global with sharing class GE_QuoteSyncWS
{
  // inner class to provide a response structure for the service
  global class Status
  {
    public Status()
    {
      statusCode = 0;
      errorMsg = null;

    }

    webservice Integer statusCode;      // error code; to be defined by application logic
    webservice String errorMsg;    // a string description of the error
  }

  // inner class to provide a structure fo all inbound data values for the service
  global class QuoteData
  {
    webservice String sfdcQuoteNum;
    webservice String quoteNum;
    webservice String soldToAccountNum;
    webservice String soldToAccountName;
    webservice Date   quoteExpireDate;
    webservice Double quoteAmountOC;
    webservice String quoteName;
    webservice String quoteStatus;
    webservice String fileDisplayName;
    webservice String fileOriginalName;
    webservice Datetime   fileCreatedOn;
    webservice Datetime   fileModifiedOn;
    webservice String fileBase64;
    webservice String currencyIsoCode;
    webservice String accountMgrId;
    webservice String accountMgrName;
    webservice String sorSystemID;
    webservice Datetime   sorCreatedOn;
    webservice String sorCreatedBy;
    webservice Datetime  sorLastModOn;
    webservice String sorLastModBy;
  }

  /*
  Purpose/Overview  : The web service method to save Quote header details and generate the Quote PDF document
  Input Param       : quoteData - the inner class of the inbound SFDC web service values
  Return Param      : the web service status
  Exceptions        : GE_WebServiceException
  */
  webservice static Status saveQuote(QuoteData quoteData)
  {

    Status wsStatus = new Status();
    Quote quote = null;

    ///////////////////////////////////
    // check for required parameters //
    ///////////////////////////////////
    if ((quoteData.quoteNum == null) || (quoteData.quoteNum.length() == 0))
    {
      wsStatus.statusCode = 3;
      wsStatus.errorMsg = 'ERP Quote number must be provided';
      return wsStatus;
    }

    ///////////////////////////////////
    // check for required parameters //
    ///////////////////////////////////
    if ((quoteData.sfdcQuoteNum == null) || (quoteData.sfdcQuoteNum.length() == 0))
    {
      wsStatus.statusCode = 4;
      wsStatus.errorMsg = 'SFDC Quote number must be provided';
      return wsStatus;
    }

    try
    {

      if (quoteData.fileOriginalName != null) System.debug('fileOriginalName=' + quoteData.fileOriginalName);
      if (quoteData.fileCreatedOn != null) System.debug('fileCreatedOn=' + quoteData.fileCreatedOn);
      if (quoteData.fileModifiedOn != null) System.debug('fileModifiedOn=' + quoteData.fileModifiedOn);
      if (quoteData.fileDisplayName != null) System.debug('fileDisplayName=' + quoteData.fileDisplayName);

      /////////////////////////////////////////////////////
      // Insert or update quote - Are we doing updates?? //
      /////////////////////////////////////////////////////
      quote = [SELECT Id, QuoteNumber, CurrencyIsoCode FROM Quote WHERE QuoteNumber = :quoteData.sfdcQuoteNum];

      Double convRate = 1;
      if (quote.currencyIsoCode != 'USD')
      {
        convRate = [SELECT ConversionRate FROM CurrencyType WHERE IsoCode = :quote.currencyIsoCode].ConversionRate;
      }

      if (quoteData.quoteNum != null) quote.GE_SOR_Quote_Number__c = quoteData.quoteNum;
      if (quoteData.quoteName != null) quote.GE_RFQ_Reference__c = quoteData.quoteName;
      if (quoteData.quoteStatus != null) quote.GE_SOR_Quote_Status__c = quoteData.quoteStatus;
      if (quoteData.soldToAccountNum != null) quote.GE_SOR_Sold_To_AccountNumber__c = quoteData.soldToAccountNum;
      if (quoteData.soldToAccountName != null) quote.GE_SOR_Sold_To_AccountName__c = quoteData.soldToAccountName;
      if (quoteData.quoteExpireDate != null) quote.ExpirationDate = quoteData.quoteExpireDate;
      if (quoteData.quoteAmountOC != null) quote.GE_SOR_Grand_Total__c = quoteData.quoteAmountOC*convRate;
      if (quoteData.accountMgrId != null) quote.GE_SOR_Account_ManagerID__c = quoteData.accountMgrId;
      if (quoteData.accountMgrName != null) quote.GE_SOR_Account_ManagerName__c = quoteData.accountMgrName;
      if (quoteData.sorSystemID != null) quote.GE_SOR_SystemID__c = quoteData.sorSystemID;
      if (quoteData.sorCreatedOn != null) quote.GE_SOR_CreatedOn__c = quoteData.sorCreatedOn;
      if (quoteData.sorCreatedBy != null) quote.GE_SOR_CreatedBy__c = quoteData.sorCreatedBy;
      if (quoteData.sorLastModOn != null) quote.GE_SOR_ModifiedOn__c = quoteData.sorLastModOn;
      if (quoteData.sorLastModBy != null) quote.GE_SOR_ModifiedBy__c = quoteData.sorLastModBy;

      update quote;

    }
    catch (QueryException e)
    {
      System.debug('ERROR: Could not retrieve quote number ' + quoteData.sfdcQuoteNum);
      wsStatus.statusCode = 1;
      wsStatus.errorMsg = 'Could not retrieve quote number ' + quoteData.sfdcQuoteNum;
      return wsStatus;
    }
    catch (Exception e)
    {
      System.debug('ERROR: Web service call failed CAUSE=[' + e.getCause() + '] MSG=[' + e.getMessage() + '] TYPE_NAME=' + e.getTypeName() + ']');
      throw new GE_WebServiceException('Web service call failed CAUSE=[' + e.getCause() + '] MSG=[' + e.getMessage() + '] TYPE_NAME=' + e.getTypeName() + ']', e);
    }


    try
    {
      ///////////////////////////////
      // Attach quote PDF document //
      ///////////////////////////////
      if ((quote != null) && (quoteData.fileBase64 != null) && (quoteData.fileBase64.length() != 0))
      {
        QuoteDocument quoteDoc = new QuoteDocument();

        quoteDoc.QuoteId = quote.Id;

        //quoteDoc.Name = quoteName;        // This is a non-writable field
        quoteDoc.Document = EncodingUtil.base64Decode(quoteData.fileBase64);
        //quoteDoc.GrandTotal = total;      // This is a non-writable field

        insert quoteDoc;
      }
      else
      {
        System.debug('WARNING: Skipping quote attachment for SFDC quote: ' + quoteData.sfdcQuoteNum);
        wsStatus.errorMsg = 'WARNING: Skipping quote attachment for SFDC quote: ' + quoteData.sfdcQuoteNum;
      }

      return wsStatus;
    }
    catch (StringException e)
    {
      wsStatus.statusCode = 2;
      wsStatus.errorMsg = 'Could not decode quote base64 data';
      return wsStatus;
    }
    catch (Exception e)
    {
      throw new GE_WebServiceException('Web service call failed CAUSE=[' + e.getCause() + '] MSG=[' + e.getMessage() + '] TYPE_NAME=' + e.getTypeName() + ']', e);
    }

  }

}