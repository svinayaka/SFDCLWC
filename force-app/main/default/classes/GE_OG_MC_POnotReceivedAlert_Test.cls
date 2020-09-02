@isTest
private class GE_OG_MC_POnotReceivedAlert_Test {
    static testmethod void GE_OG_MC_POnotReceivedAlerttest(){
        
        List<SVMXC__Service_Order__c> work=new List<SVMXC__Service_Order__c>();
        List<SVMXC__Service_Order__c> work1=new List<SVMXC__Service_Order__c>();
        Id RecId =  Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('MCS').getRecordTypeId();
        SVMXC__Skill__c skill=new SVMXC__Skill__c(Name='Test');insert skill;
        Date d = Date.today();
        for(integer i=0;i<10;i++ ){
            SVMXC__Service_Order__c w=new SVMXC__Service_Order__c();
            //w.GE_OG_MC_PO_Not_Received__c=true; 
            w.RecordtypeID=RecId;
            w.SVMXC__Skill__c=skill.id;
            work.add(w);
        }
        insert work;    
        for(SVMXC__Service_Order__c w:work){
            Integer noOfDays;
            w.GE_OG_PO_Checked_On__c=Date.today().addDays(-7);
            work1.add(w);
            noOfDays = w.GE_OG_PO_Checked_On__c.daysBetween(d);
            System.assertequals(noOfDays,7);
        }
        update work1;
        
        Test.startTest();
        GE_OG_MC_POnotReceivedAlert c = new GE_OG_MC_POnotReceivedAlert();
        Database.executeBatch(c,200);
        
        Test.stopTest();
    }
    
}