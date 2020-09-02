/* 
   This test class is used to track the changes done to the EquipHistoryData,when the intialization date,Status of the well history is changed.
*/

@isTest
private class GE_AL_EquipHistoryData_Test {

     public static testMethod void checkEquipDataHistory() {           
            ID Rtid=Schema.SObjectType.SVMXC__Installed_Product__c.getRecordTypeInfosByName().get('GE OG D&S Artificial Lift').getRecordTypeId();            
            List<SVMXC__Installed_Product__c> installprodList = new List<SVMXC__Installed_Product__c>();
            List<SVMXC__Installed_Product__c> oldInstallProdList = new List<SVMXC__Installed_Product__c>();            
            SVMXC__Installed_Product__c oldInstallProd= new SVMXC__Installed_Product__c(Name = 'Test IP',RecordTypeId=Rtid,SVMXC__Company__c='0011200001GKLin');
            insert oldInstallProd;
            oldInstallProdList.add(oldInstallProd);
            System.assertEquals(oldInstallProd.Name,'Test IP');
            update oldInstallProd;
            installprodList.add(oldInstallProd);            
            GE_AL_CreateEquipHitoryTriggerHandler.OnAfterUpdate(installprodList,oldInstallProdList) ;
     }
      
     public static testMethod void checkEquipDataHistory1() {         
        ID Rtid=Schema.SObjectType.SVMXC__Installed_Product__c.getRecordTypeInfosByName().get('GE OG D&S Artificial Lift').getRecordTypeId() ;        
        List<SVMXC__Installed_Product__c> installprodList = new List<SVMXC__Installed_Product__c>();
        List<SVMXC__Installed_Product__c> oldInstallProdList = new List<SVMXC__Installed_Product__c>();
        SVMXC__Site__c st = new SVMXC__Site__c(Name='Test Location');
         insert st;
         SVMXC__Site__c st1 = new SVMXC__Site__c(Name = 'Test Shipped to Location');
         insert st1;
        SVMXC__Installed_Product__c oldInstallProd= new SVMXC__Installed_Product__c ( Name = 'Test IP',
                                                                                                                                                  RecordTypeId=Rtid,
                                                                                                                                                  SVMXC__Status__c='Installed',
                                                                                                                                                  SVMXC__Site__c=st.id,
                                                                                                                                                  GE_AL_Shipped_From__c=st.id,
                                                                                                                                                  GE_AL_Shipped_To__c=st1.id,
                                                                                                                                                  GE_AL_Shipper_Number__c='1234',
                                                                                                                                                  SVMXC__Company__c='0011200001GKLin',
                                                                                                                                                  GE_AL_Receiver_Number__c='5678' );
        insert oldInstallProd;
        oldInstallProdList.add(oldInstallProd);
        oldInstallProd.SVMXC__Status__c='Shipped';        
        oldInstallProd.SVMXC__Site__c=st1.id;
        oldInstallProd.GE_AL_Shipped_From__c=st1.id;
        oldInstallProd.GE_AL_Shipped_To__c=st.id;
        oldInstallProd.GE_AL_Shipper_Number__c = '5678';
        oldInstallProd.GE_AL_Receiver_Number__c = '1234';
        oldInstallProd.GE_AL_Shipped_Date_and_Time__c = Date.today();
        oldInstallProd.GE_AL_Received_Date_and_Time__c = Date.today();
        oldInstallProd.GE_AL_Store_Run_Days__c = 100;       
        System.assertEquals( oldInstallProd.Name,'Test IP' ) ;
        update oldInstallProd;
        
        SVMXC__Installed_Product__c InstallProd= new SVMXC__Installed_Product__c( Name = 'Test IP1',
                                                                                                                                            RecordTypeId=Rtid,
                                                                                                                                            SVMXC__Status__c='abc',
                                                                                                                                            SVMXC__Site__c=st.id,
                                                                                                                                            GE_AL_Shipped_From__c=st.id,
                                                                                                                                            SVMXC__Company__c='0011200001GKLin',
                                                                                                                                            GE_AL_Shipped_To__c=st1.id);
        insert InstallProd;       
        installprodList.add(InstallProd);                
        InstallProd.SVMXC__Status__c='abcd';        
        InstallProd.SVMXC__Site__c=st1.id;
        InstallProd.GE_AL_Shipped_From__c=st1.id;
        InstallProd.GE_AL_Shipped_To__c=st1.id;
        System.assertEquals(InstallProd.Name,'Test IP1');
        update InstallProd;        
        GE_AL_CreateEquipHitoryTriggerHandler.OnAfterUpdate(installprodList,oldInstallProdList);         
     }
     
     public static testMethod void subSeaIPIBFunctionalityCheck() {         
        Id Rtid = Schema.SObjectType.SVMXC__Installed_Product__c.getRecordTypeInfosByName().get('Subsea Equipment').getRecordTypeId() ;        
        List<SVMXC__Installed_Product__c> installprodList = new List<SVMXC__Installed_Product__c>();
        List<SVMXC__Installed_Product__c> oldInstallProdList = new List<SVMXC__Installed_Product__c>();
        SVMXC__Site__c st = new SVMXC__Site__c(Name='Test Location');
         insert st;
         SVMXC__Site__c st1 = new SVMXC__Site__c(Name = 'Test Shipped to Location');
         insert st1;
        SVMXC__Installed_Product__c oldInstallProd= new SVMXC__Installed_Product__c ( Name = 'Test IP',
                                                                                                                                                  RecordTypeId=Rtid,
                                                                                                                                                  SVMXC__Status__c='Installed',
                                                                                                                                                  SVMXC__Site__c=st.id,
                                                                                                                                                  GE_AL_Shipped_From__c=st.id,
                                                                                                                                                  GE_AL_Shipped_To__c=st1.id,
                                                                                                                                                  GE_AL_Shipper_Number__c='1234',
                                                                                                                                                  SVMXC__Company__c='0011200001GKLin',
                                                                                                                                                  GE_AL_Receiver_Number__c='5678' );
        insert oldInstallProd;
        oldInstallProdList.add(oldInstallProd);
        oldInstallProd.SVMXC__Status__c='Shipped';        
        oldInstallProd.SVMXC__Site__c=st1.id;
        oldInstallProd.GE_AL_Shipped_From__c=st1.id;
        oldInstallProd.GE_AL_Shipped_To__c=st.id;
        oldInstallProd.GE_AL_Shipper_Number__c = '5678';
        oldInstallProd.GE_AL_Receiver_Number__c = '1234';
        oldInstallProd.GE_AL_Shipped_Date_and_Time__c = Date.today();
        oldInstallProd.GE_AL_Received_Date_and_Time__c = Date.today();
        oldInstallProd.GE_AL_Store_Run_Days__c = 100;  
        oldInstallProd.SVMXC__Company__c='0011200001GKLin';     
        System.assertEquals( oldInstallProd.Name,'Test IP' ) ;
        update oldInstallProd;
        
        SVMXC__Installed_Product__c InstallProd= new SVMXC__Installed_Product__c( Name = 'Test IP1',
                                                                                                                                            RecordTypeId=Rtid,
                                                                                                                                            SVMXC__Status__c='abc',
                                                                                                                                            SVMXC__Site__c=st.id,
                                                                                                                                            GE_AL_Shipped_From__c=st.id,
                                                                                                                                            SVMXC__Company__c='0011200001GKLin',
                                                                                                                                            GE_AL_Shipped_To__c=st1.id);
        insert InstallProd;       
        installprodList.add(InstallProd);                
        InstallProd.SVMXC__Status__c='abcd';        
        InstallProd.SVMXC__Site__c=st1.id;
        InstallProd.GE_AL_Shipped_From__c=st1.id;
        InstallProd.GE_AL_Shipped_To__c=st1.id;
        InstallProd.SVMXC__Company__c='0011200001GKLin';
        System.assertEquals(InstallProd.Name,'Test IP1');
        update InstallProd;                
     }
     
     
}