global class ProjectStageAutomation_RecortypeChange {
    @InvocableMethod(label='ProjectStageAutomation_RecortypeChange' description='Automate the project stages')
     public static void stageautomationforRecordtypechange(List<Id> projectId){
    system.debug('enter method');
    list<ProjectOpportunities_ge_og__c> prjopptyLst=new list<ProjectOpportunities_ge_og__c>();
    list<Opportunity> opptylst=[select id,StageName,tier_2_ge_og__c,Amount_USD_ge_og__c,opportunity_project_ge_og__c from opportunity where opportunity_project_ge_og__c in : projectId and opportunity_project_ge_og__r.RecordType.DeveloperName = 'Joint_Pursuit_Project'];
    if(opptylst.Size()>0)
    {
        system.debug('enter if');
        For(Opportunity opp:opptylst){
        system.debug('enter for loop'+opp);
            ProjectOpportunities_ge_og__c prjopp=new ProjectOpportunities_ge_og__c();
            prjopp.Opportunity_ge_og__c=opp.id;
            prjopp.Opportunity_Amount__c=opp.Amount_USD_ge_og__c;
            prjopp.Opportunity_Stage_ge_og__c=opp.StageName;
            prjopp.Project_ge_og__c=opp.opportunity_project_ge_og__c;
            prjopp.Tier_2_ge_og__c=opp.tier_2_ge_og__c;
            prjopptyLst.add(prjopp);
            
        }
        insert prjopptyLst;
    }
        
    }
    }