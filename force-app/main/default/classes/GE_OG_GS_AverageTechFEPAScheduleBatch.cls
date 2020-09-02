/*
 * Author:      Chris Hurd (chris.hurd@bolt-data.com)
 * Date:        2016-03-10
 * Purpose:     Calculate average FEPA score from last three closed work orders assigned to technician.
 *
 * History:
 * Date         Modifier        Notes
 *-------------|---------------|-----------------------------------------------------------------------------------
 */
 global class GE_OG_GS_AverageTechFEPAScheduleBatch implements Database.Batchable<sObject>, Schedulable {
    
    public String query = 'SELECT Id, GE_OG_GS_Average_FEPA_Score__c, SVMXC__Service_Group__c FROM SVMXC__Service_Group_Members__c WHERE SVMXC__Service_Group__r.GE_HQ_P_L_Level__c = \'Turbomachinery Solutions\'';
    
    global GE_OG_GS_AverageTechFEPAScheduleBatch() {
        
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List<SVMXC__Service_Group_Members__c> scope) {
        Map<Id, TechCalc> techMap = new Map<Id, TechCalc>();
        for (SVMXC__Service_Group_Members__c tech : scope)
        {
            
            if(tech.GE_OG_GS_Average_FEPA_Score__c != null){
                {
                    if(tech.GE_OG_GS_Average_FEPA_Score__c < 1){
                        tech.GE_OG_GS_Average_FEPA_Score__c = -1;
                        techMap.put(tech.Id, new TechCalc(tech));
                        system.debug('@@@mapvalues'+techMap);
                    }
                    else if(tech.GE_OG_GS_Average_FEPA_Score__c > 1){
                        techMap.put(tech.Id, new TechCalc(tech));
                        system.debug('@@@mapvalues'+techMap);
                    }
                }
            }
            else
            {
                system.debug('@@@mapvalues'+techMap);
                tech.GE_OG_GS_Average_FEPA_Score__c = -1;
                techMap.put(tech.Id, new TechCalc(tech));
                system.debug('@@@mapvalues'+techMap);
            }
        }

        for (SVMXC__Service_Order__c wo : [SELECT Id, GE_OG_GS_FEPA__c, SVMXC__Group_Member__c 
            FROM SVMXC__Service_Order__c 
            WHERE SVMXC__Group_Member__c IN :techMap.keySet() 
            AND SVMXC__Order_Status__c IN ('Completed', 'Assigned', 'Assigned – Warning') 
            AND GE_OG_GS_FEPA__c != null AND GE_SM_HQ_Schedule_End_Date2__c >= LAST_N_DAYS:180 ORDER BY GE_SM_HQ_Schedule_End_Date2__c DESC])
        {
            if (wo.GE_OG_GS_FEPA__c != null && wo.GE_OG_GS_FEPA__c.isNumeric())
            {
                system.debug('@@@mapvalues'+techMap);
                system.debug('@@@FEPA'+wo.GE_OG_GS_FEPA__c);
                techMap.get(wo.SVMXC__Group_Member__c).addScore(Decimal.valueOf(wo.GE_OG_GS_FEPA__c));
                system.debug('@@@mapvalues'+techMap);
                system.debug('@@@FEPA'+wo.GE_OG_GS_FEPA__c);
            }
            else
            {
                system.debug('@@@mapvalues'+techMap);
                techMap.get(wo.SVMXC__Group_Member__c).addCount();
                system.debug('@@@FEPA'+wo.GE_OG_GS_FEPA__c);
            }
        }

        for (SVMXC__Service_Group_Members__c tech : scope)
        { 
            if(techMap != null && techMap.containsKey(tech.Id))
            tech.GE_OG_GS_Average_FEPA_Score__c = techMap.get(tech.Id).getAverage();
        }

        Database.SaveResult[] results = Database.update(scope, false);

    }
    
    global void finish(Database.BatchableContext BC) {
        
    }


    global void execute(SchedulableContext sc)
    {
        GE_OG_GS_AverageTechFEPAScheduleBatch batch = new GE_OG_GS_AverageTechFEPAScheduleBatch();
        database.executeBatch(batch, 50);  
    }


    public class TechCalc
    {
        public SVMXC__Service_Group_Members__c tech;
        public List<Decimal> scores = new List<Decimal>();
        public Integer count = 0;

        public TechCalc(SVMXC__Service_Group_Members__c tech)
        {
            this.tech = tech;
        }

        public void addScore(Decimal score)
        {
            if (count <= 3)
            {
                scores.add(score);
                ++count;
            }
        }

        public void addCount()
        {
            ++count;
        }

        public Decimal getAverage()
        {
            if (! scores.isEmpty())
            {
                Decimal total = 0;

                for (Decimal s : scores)
                {
                    total += s;
                }

                return (total / scores.size()).setScale(0);
            }
        
            return -1;
        }
    }
    
}