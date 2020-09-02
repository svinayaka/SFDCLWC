@isTest
private class Test_InlineAcountHerachy_TestUtilities{  
  static testMethod void InlineAcountHerachy() {
    Profile p = [select id from profile where name='System Administrator']; 
        User u = new User(alias = 'standt', email='standarduser@ge.com', 
            emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='en_US', 
            localesidkey='en_US', profileid = p.Id, timezonesidkey='America/Los_Angeles', username='userRCJ@testorg.com');

        System.runAs(u){   
        

      List<Account> acc1= new List<Account>();
        Integer numAccts;
        for(Integer i=0;i<5;i++) {
           Account accAux         = new Account();
        accAux.Name         = 'test account';
        accAux.ShippingStreet     = '1 Main St.';
        accAux.ShippingState    = 'VA';
        accAux.ShippingPostalCode  = '12345';
        accAux.ShippingCountry    = 'USA';
        accAux.ShippingCity      = 'Anytown';
        accAux.Description      = 'This is a test account';
        accAux.BillingStreet    = '1 Main St.';
        accAux.BillingState      = 'VA';
        accAux.BillingPostalCode  = '12345';
        accAux.BillingCountry     = 'USA';
        accAux.BillingCity      = 'Anytown';
        accAux.AnnualRevenue    = 10000;
        accAux.ParentId        = null;
            acc1.add(accAux);
        }
        //insert acc1;
        List<Account> testAccList = new List<Account>();
        testAccList.addAll(acc1);
  
 
        InlineAcountHerachy_TestUtilities IAH = new InlineAcountHerachy_TestUtilities();
        IAH.createRandomWord();
        String objName = 'Account';
        Set<String> ftc = new set<String>{'name','billingstate'};
        ftc.add('ShippingStreet');
        ftc.add('Description');
        //ftc.add('GE_PRM_Profile__c');
        //ftc.add('Id');
        String crudType = 'create';
                      
        Test.startTest();
        IAH.checkObjectCrud(objName,ftc,crudType);
        IAH.createAccounts(5,ftc);
        Test.stopTest();            
        
        IAH.updateAccountList(ftc);
}
}

 static testMethod void InlineAcountHerachy2() {
    Profile p = [select id from profile where name='System Administrator']; 
        User u = new User(alias = 'standt', email='standarduser@ge.com', 
            emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='en_US', 
            localesidkey='en_US', profileid = p.Id, timezonesidkey='America/Los_Angeles', username='userRCJ@testorg.com');

        System.runAs(u){   
        InlineAcountHerachy_TestUtilities IAH = new InlineAcountHerachy_TestUtilities();
        IAH.createRandomWord();
        String objName = 'Contact';
        Set<String> ftc = new set<String>{'name','billingcountry'};       
        String crudType = 'Update';
        
       IAH.checkObjectCrud(objName,ftc,crudType);       
        IAH.createAccounts(5,ftc);
        IAH.updateAccountList(ftc);
}
}
}