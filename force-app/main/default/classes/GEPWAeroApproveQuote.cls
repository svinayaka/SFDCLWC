global class GEPWAeroApproveQuote{

 WebService static void ApproveAndClone(string id) 
  {
    Quote quote= [Select ID,NAME,CURRENCYISOCODE,RECORDTYPEID,CREATEDBYID,OPPORTUNITYID,PRICEBOOK2ID,CONTACTID,ISSYNCING,SHIPPINGHANDLING,TAX,STATUS,EXPIRATIONDATE,DESCRIPTION,LINEITEMCOUNT,BILLINGSTREET,BILLINGCITY,BILLINGSTATE,BILLINGPOSTALCODE,BILLINGCOUNTRY,SHIPPINGSTREET,SHIPPINGCITY,SHIPPINGSTATE,SHIPPINGPOSTALCODE,SHIPPINGCOUNTRY,QUOTETOSTREET,QUOTETOCITY,QUOTETOSTATE,QUOTETOPOSTALCODE,QUOTETOCOUNTRY,ADDITIONALSTREET,ADDITIONALCITY,ADDITIONALSTATE,ADDITIONALPOSTALCODE,ADDITIONALCOUNTRY,BILLINGNAME,SHIPPINGNAME,QUOTETONAME,ADDITIONALNAME,EMAIL,PHONE,FAX,DISCOUNT,GRANDTOTAL,GE_PW_AERO_STAGE__C From Quote where Id=:id];
    List<Quote > siblingQtsLst= new List<Quote >();
    List<String> sts=new List<String>();
    sts.add('R3');
    if(quote.GE_PW_Aero_Stage__c=='R2') 
        sts.add('R2');
    else if(quote.GE_PW_Aero_Stage__c=='R1')
        sts.add('R1');
    //Approve the current quote and Abandon the siblings at same stage    
    for (quote  siblingQuote : [Select ID,Status From Quote where OPPORTUNITYID = :quote.OPPORTUNITYID and GE_PW_Aero_Stage__c IN :sts])//=:quote.GE_PW_Aero_Stage__c]) 
    {
       if(siblingQuote.ID==quote.ID)
          {
             siblingQuote.Status='Approved';
          }
       else
          {
             siblingQuote.Status='Abandoned';
          }
       siblingQtsLst.add(siblingQuote);
    }
    update siblingQtsLst;
    //clone quote at R2 into R3 and then update the status of R2 quote
    if(quote.GE_PW_Aero_Stage__c=='R2')
    {
        Quote  clonedCopy = quote.clone(false, true);
        clonedCopy.Status='Draft';           
        clonedCopy.GE_PW_Aero_Stage__c='R3';
        insert(clonedCopy);
                
        List<QuoteLineItem > items = new List<QuoteLineItem >();
        for (QuoteLineItem  ql : [Select Id, LineNumber, CurrencyIsoCode, CreatedById,  SystemModstamp, QuoteId, PricebookEntryId, Quantity, UnitPrice, Discount, HasRevenueSchedule, HasQuantitySchedule, Description, ServiceDate, HasSchedule, ListPrice, Subtotal, TotalPrice,GE_PW_Aero_Cost__c,GE_PW_AS_Inst_Bs__c  FROM QuoteLineItem where QuoteId = :id]) 
        {
            QuoteLineItem newQl = ql.clone(false,true);
            newQl.QuoteId  = clonedCopy.id;
            items.add(newQl);
        }
        insert items;
     }
     //When approved at R3 the quote is synced to the opportunity
     else if(quote.GE_PW_Aero_Stage__c=='R3')
     {
          Opportunity parentOpp=[Select ID,SyncedQuoteId  From Opportunity where Id= :quote.OPPORTUNITYID];
          parentOpp.SyncedQuoteId = quote.Id;
          update parentOpp;
     }

  }
}