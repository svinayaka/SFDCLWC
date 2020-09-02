global with sharing class UpdateContactAddress {

   webservice static String DisplayAddressDetails(String ContactId) {
      String ShippingAddress='';
      String ResultAddress='';
      
      Contact con=[Select id,name,GE_OG_Site_LegalEntity_Account__c from Contact where id=:ContactId];
      Account acc=[SELECT id,name,BillingStreet,BillingCity,BillingState,BillingPostalCode,
      BillingCountry,ShippingStreet,ShippingCity,ShippingState,ShippingPostalCode,
      ShippingCountry from Account where id=:con.GE_OG_Site_LegalEntity_Account__c];
       
      if(String.valueof(acc.ShippingStreet)!=null) 
          ShippingAddress = acc.ShippingStreet;
             if(String.valueof(acc.ShippingCity)!=null)
                 ShippingAddress = ShippingAddress+' '+acc.ShippingCity; 
                     if(String.valueof(acc.ShippingState)!=null)
                          ShippingAddress = ShippingAddress+' '+acc.ShippingState; 
                              if(String.valueof(acc.ShippingPostalCode)!=null)
                                  ShippingAddress = ShippingAddress+' '+acc.ShippingPostalCode;
                                      if(String.valueof(acc.ShippingCountry)!=null)
                                          ShippingAddress = ShippingAddress+' '+acc.ShippingCountry; 
      
   /*   if(acc.ShippingAddress==null){
          ShippingAddress='';
      }*/
                                          
     if(ShippingAddress!='')
         ResultAddress = ShippingAddress; 
      else if(ShippingAddress=='')
         ResultAddress = 'Is Blank';

   return ResultAddress;
   }
   
   webservice static String DisplayButtons(String ContactId) {
      String ShippingAddress='';
      String ResultButtons='';

      Contact con=[Select id,name,GE_OG_Site_LegalEntity_Account__c from Contact where id=:ContactId];
      Account acc=[SELECT id,name,BillingStreet,BillingCity,BillingState,BillingPostalCode,
      BillingCountry,ShippingStreet,ShippingCity,ShippingState,ShippingPostalCode,
      ShippingCountry from Account where id=:con.GE_OG_Site_LegalEntity_Account__c];
          
      if(String.valueof(acc.ShippingStreet)!=null) 
          ShippingAddress = acc.ShippingStreet;
             if(String.valueof(acc.ShippingCity)!=null)
                 ShippingAddress = ShippingAddress+' '+acc.ShippingCity; 
                     if(String.valueof(acc.ShippingState)!=null)
                          ShippingAddress = ShippingAddress+' '+acc.ShippingState; 
                              if(String.valueof(acc.ShippingPostalCode)!=null)
                                  ShippingAddress = ShippingAddress+' '+acc.ShippingPostalCode;
                                      if(String.valueof(acc.ShippingCountry)!=null)
                                          ShippingAddress = ShippingAddress+' '+acc.ShippingCountry; 
                                          
   /*  if(acc.ShippingAddress==null){
          ShippingAddress='';
      }    */                                  
                                          
     if(ShippingAddress!='')
         ResultButtons = 'ShipTo'; 
     else if(ShippingAddress=='')
         ResultButtons = 'None';

   return ResultButtons;
   }

   
   webservice static String UpdateShippingAddress(String ContactId) {
       
      Contact con=[Select id,name,GE_OG_Site_LegalEntity_Account__c,GE_OG_Country__c,MailingStreet,MailingCity,MailingState,MailingPostalCode,
      MailingCountry from Contact where id=:ContactId];
      Account acc=[SELECT id,name,BillingStreet,BillingCity,BillingState,BillingPostalCode,
      BillingCountry,ShippingStreet,ShippingCity,ShippingState,ShippingPostalCode,
      ShippingCountry from Account where id=:con.GE_OG_Site_LegalEntity_Account__c];
      
      con.MailingStreet = acc.ShippingStreet;
      con.MailingCity = acc.ShippingCity;
      con.MailingState = acc.ShippingState;
      con.MailingPostalCode = acc.ShippingPostalCode;
      con.MailingCountry = acc.ShippingCountry;
      con.GE_OG_Country__c = acc.ShippingCountry;
      
      try {
         update con;
      }
      catch (DmlException e) {
         return e.getMessage();
      }
      
      return 'Success';
   }
   
}