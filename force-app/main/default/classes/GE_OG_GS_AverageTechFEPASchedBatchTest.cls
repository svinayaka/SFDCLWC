@isTest(SeeAllData=true)
    private class GE_OG_GS_AverageTechFEPASchedBatchTest {

        public static String CRON_EXP = '0 0 0 15 3 ? 2022';
        public static Decimal score = null;
        public static SVMXC__Service_Order__c wo1;
        public static SVMXC__Service_Order__c wo2;
        
        static testMethod void testSchedule() {
                
            
            String jobId = System.schedule('GE_OG_GS_AverageTechFEPAScheduleBatchTest', CRON_EXP, new GE_OG_GS_AverageTechFEPAScheduleBatch());
             
            CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId];

            System.assertEquals(CRON_EXP, ct.CronExpression);
            System.assertEquals(0, ct.TimesTriggered);

            System.assertEquals('2022-03-15 00:00:00', String.valueOf(ct.NextFireTime));
        }
        
        
        @isTest static void test() {
            score = 3.0;
            ID Rectype = Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('GS-Requirement').getRecordTypeId();
            List<SVMXC__Service_Order__c> woList = new List<SVMXC__Service_Order__c>();
            
            SVMXC__Service_Group__c team = new SVMXC__Service_Group__c();
            team.Name = 'Test Team';
            team.GE_HQ_P_L_Level__c = 'Turbomachinery Solutions';
            insert team;
            
            SVMXC__Service_Group_Members__c tech = new SVMXC__Service_Group_Members__c();
            tech.SVMXC__Service_Group__c = team.Id;
            tech.Name = 'Test Tech';
            tech.GE_OG_GS_Average_FEPA_Score__c = -1;
            insert tech;
            

            SVMXC__Service_Order__c wo = new SVMXC__Service_Order__c();
            wo.GE_OG_GS_FEPA__c = '6';
            wo.GE_SM_HQ_Schedule_End_Date2__c = system.today().addDays(-10);
            wo.SVMXC__Order_Status__c = 'Completed';
            wo.SVMXC__Group_Member__c = tech.Id;
            wo.GE_OG_GS_Skill_Requirement__c = 'Test Skill';
            wo.SVMXC__Country__c = 'United States';
            wo.Region__c = 'Test';
            wo.RecordTypeId = Rectype;
            woList.add(wo);
            
            wo1 = new SVMXC__Service_Order__c();
            wo1.GE_OG_GS_FEPA__c = '6';
            wo1.GE_SM_HQ_Schedule_End_Date2__c = system.today().addDays(-9);
            wo1.SVMXC__Order_Status__c = 'Assigned';
            wo1.SVMXC__Group_Member__c = tech.Id;
            wo1.SVMXC__Country__c = 'United States';
            wo1.Region__c = 'Test';
            wo1.GE_OG_GS_Skill_Requirement__c = 'Test Skill';
            wo1.RecordTypeId = Rectype;
            woList.add(wo1);
            
            wo2 = new SVMXC__Service_Order__c();
            wo2.GE_OG_GS_FEPA__c = '4';
            wo2.GE_SM_HQ_Schedule_End_Date2__c = system.today().addDays(-8);
            wo2.SVMXC__Order_Status__c = 'Assigned';
            wo2.SVMXC__Group_Member__c = tech.Id;
            wo2.SVMXC__Country__c = 'United States';
            wo2.Region__c = 'Test';
            wo2.GE_OG_GS_Skill_Requirement__c = 'Test Skill';
            wo2.RecordTypeId = Rectype;
            woList.add(wo2);
            
            insert woList;

            tech = [SELECT Id, GE_OG_GS_Average_FEPA_Score__c FROM SVMXC__Service_Group_Members__c WHERE Id = :tech.Id LIMIT 1];
            
            Test.startTest();
            GE_OG_GS_AverageTechFEPAScheduleBatch batch = new GE_OG_GS_AverageTechFEPAScheduleBatch();
            GE_OG_GS_AverageTechFEPAScheduleBatch.TechCalc wrapper = new GE_OG_GS_AverageTechFEPAScheduleBatch.TechCalc(tech);
            wrapper.addScore(score);
            wrapper.addCount();
            Decimal d = wrapper.getAverage();
            batch.query = 'SELECT Id, GE_OG_GS_Average_FEPA_Score__c FROM SVMXC__Service_Group_Members__c WHERE Id = \'' + tech.Id + '\'';
            Database.executeBatch(batch);
            system.assertEquals(-1, tech.GE_OG_GS_Average_FEPA_Score__c);
            Test.stopTest();
    }
}