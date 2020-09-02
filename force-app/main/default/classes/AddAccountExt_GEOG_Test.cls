@isTest 
public class AddAccountExt_GEOG_Test{ 
    static testMethod void AddAccountTest() {
        
        Account oGAct=AccountTestDataFactory.createRegionalAccountWithDunsNum('TestaccountAustralia','Strategic','Direct Customer','GEGUL999');
        
        //Contact con1=AccountTestDataFactory.createContact(oGAct.id,'first','test');
         Contact con1 = new Contact();
        con1.FirstName='first';
        con1.LastName='test';
        con1.Email='terst@test.com';
        con1.AccountId = oGAct.Id;
        con1.GE_OG_Contact_Audience__c = 'Sales / ITO';
     
        //Contact con1=AccountTestDataFactory.createContact(oGAct.Id,'first','test');
        
        
        PageReference myVfPage = Page.AddNewAccount_GEOG;
  
        

        Test.setCurrentPage(myVfPage);
        ApexPages.StandardController stdOppObj = new ApexPages.standardController(oGAct);
        AddAccountExt_GEOG addacc = new AddAccountExt_GEOG(stdOppObj);
        addacc.con = con1;
        addacc.save();
        addacc.Cancel();
    }

}