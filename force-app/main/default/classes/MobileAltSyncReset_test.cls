@istest
    public class MobileAltSyncReset_test 
    {
        static testmethod void JobTest(){   
        Id accRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
        account a= new account(name='test',recordtypeid=accRecordTypeId, Classification__c ='test',Type ='test');
        insert a;
        FX5__Price_Book__c  pb    = new FX5__Price_Book__c(name='test');
        insert pb;
        FX5__Job__c job = new FX5__Job__c(name='test',SD_Qualifications_Met__c=0.00,FX5__CustomerAccount__c =a.id,FX5__Office__c=a.id,FX5__Price_Book__c=pb.id);
        insert job;
             SD_Rig__c rig=new SD_Rig__c(name='test');
            insert rig;
            FX5__Well__c well = new FX5__Well__c(name='test');
            insert well;
            job.SD_Rig_Name__c = rig.id;
            job.FX5__Well__c = well.id;
            job.SD_Sales_Order_Number__c ='13';
            job.SD_Estimated_Revenue__c = 100;
            job.SD_Stage__c = 'Complete';
            update job;
           test.startTest();
            MobileAltSyncReset mar = new MobileAltSyncReset();
            database.executeBatch(mar);
            test.stopTest();
    }
        static testmethod void JobTest1(){   
        Id accRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
        //Id jobRecordtype = Schema.SObjectType.FX5__Job__c.getRecordTypeInfosByName().get('Job Phase').getRecordTypeId();
            
            account a= new account(name='test',recordtypeid=accRecordTypeId, Classification__c ='test',Type ='test');
        insert a;
        FX5__Price_Book__c  pb    = new FX5__Price_Book__c(name='test');
        insert pb;
        FX5__Job__c job = new FX5__Job__c(name='test',SD_Qualifications_Met__c=0.00,FX5__CustomerAccount__c =a.id,FX5__Office__c=a.id,FX5__Price_Book__c=pb.id);
        insert job;
             
            system.debug('accRecordTypeId'+accRecordTypeId);
            system.debug('a.recordtypeid'+a.RecordTypeId);
            
            
        FX5__Job__c job1 = new FX5__Job__c(name='test',SD_Qualifications_Met__c=0.00,FX5__CustomerAccount__c =a.id,FX5__Office__c=a.id,FX5__Price_Book__c=pb.id);
        insert job1;
            
            SD_Rig__c rig=new SD_Rig__c(name='test');
            insert rig;
            FX5__Well__c well = new FX5__Well__c(name='test');
            insert well;
            job.SD_Rig_Name__c = rig.id;
            job.FX5__Well__c = well.id;
            job.SD_Sales_Order_Number__c ='13';
            job.SD_Estimated_Revenue__c = 100;
            job.SD_Stage__c = 'Complete';
            
              SD_Rig__c rig1=new SD_Rig__c(name='test');
            insert rig1;
            
            FX5__Well__c well1 = new FX5__Well__c(name='test');
            insert well1;
            
  FX5__Job__c job11 = new FX5__Job__c(name='test',SD_Qualifications_Met__c=0.00,FX5__Well__c=well1.id,SD_Rig_Name__c =rig1.id, FX5__CustomerAccount__c =a.id,FX5__Office__c=a.id,FX5__Price_Book__c=pb.id);
        insert job11;         
          job11.SD_Stage__c = 'Complete'; 
         
          job11.SD_Sales_Order_Number__c ='13';
            job11.SD_Estimated_Revenue__c = 100;
          update job11;
           
            update job;
           
                account a1=[select id,altsync__c from account where id=:a.id];
            system.debug('==========================================>account altsync'+a1.AltSync__c);
            test.startTest();
            MobileAltSyncReset mar = new MobileAltSyncReset();
            database.executeBatch(mar);
            test.stopTest();
    }
}