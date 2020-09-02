/*
Class Name: ProductandPriceBookEnrty_GE_OG_Test
Author: Mohit Maheshwari
Created Date: 13/Oct/2015
*/
@isTest
private class ProductandPriceBookEnrty_GE_OG_Test{

    static testMethod void productBookEntryAutomation() {
    
        Test.startTest();
        
        List<Profile> lstProfile = new List<Profile>();
        lstProfile = [Select ID, Name from profile where Name in ('System Administrator', 'GE_ES Developer')];
        
        List<profile_permission_ge_og__c> lstcustomSet = new List<profile_permission_ge_og__c>();
        
        for(Profile objprofile : lstProfile){
            profile_permission_ge_og__c objprofileset = new profile_permission_ge_og__c();
            objprofileset.profile_id_ge_og__c = objprofile.ID;
            if(objprofile.name == 'System Administrator')
                objprofileset.Name = 'System Administrator';
            else
                objprofileset.Name = 'GE_ES Developer';
            lstcustomSet.add(objprofileset);
        }
        
        if(lstcustomSet.size()>0)
            insert lstcustomSet;
        
        //Creating Product with servicemax product and updating record
        
        CommonTestDataFactory_GE_OG objCTDF =  new CommonTestDataFactory_GE_OG();
        
        Product2 objprod = CommonTestDataFactory_GE_OG.createProducts('TestProduct1','YES');
        
       // system.assertEquals('TestProduct1',objprod.Name);
       // system.assertEquals('YES',objprod.is_service_max_ge_og__c);
        
      //  objprod.is_service_max_ge_og__c = 'NO';
        //system.assertEquals('NO',objprod.is_service_max_ge_og__c);
     //   update objprod;
        
       // objprod.is_service_max_ge_og__c = 'YES';
       // system.assertEquals('YES',objprod.is_service_max_ge_og__c);
       // update objprod;
        
      Product2  objprod2 = CommonTestDataFactory_GE_OG.createProducts('TestProduct2','NO');
       // system.assertEquals('NO',objprod.is_service_max_ge_og__c);
        //update objprod;
        
        objprod.IsActive = False;
        update objprod;
       // system.assertEquals(False,objprod.IsActive);
        
        objprod2.IsActive = True;
        update objprod2;
     //   system.assertEquals(True,objprod.IsActive);
        
        delete objprod;
        
        Test.stopTest();        
         
       
    }
}