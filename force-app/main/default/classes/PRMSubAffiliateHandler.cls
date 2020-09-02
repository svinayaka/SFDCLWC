public class PRMSubAffiliateHandler {
    public void subAffiliateOnInsert(List<PRM_Sub_Affiliate__c> subAff){
        set<ID> suAffId = new set<ID>();
        Map<ID,PRM_Channel_Appointment_GE_OG__c> chAppList = new Map<ID,PRM_Channel_Appointment_GE_OG__c>();
        
        for(PRM_Sub_Affiliate__c subAffiliate : subAff){
            suAffId.add(subAffiliate.PRM_Channel_Appointment__c);
        }
        
        for(PRM_Channel_Appointment_GE_OG__c prmCh : [select id,PRM_Any_use_of_Sub_dealers_or_Sub_Agents__c,PRM_Any_Branch_Office_or_Subsidiaries__c,(select id,PRM_Active__c,PRM_Channel_Appointment__c,PRM_Channel_Appointment__r.PRM_Any_use_of_Sub_dealers_or_Sub_Agents__c,PRM_Affiliate_Dependent_Type__c,PRM_Channel_Appointment__r.PRM_Any_Branch_Office_or_Subsidiaries__c from Sub_Affiliates__r where PRM_Active__c=true) from PRM_Channel_Appointment_GE_OG__c where id in :suAffId]){
            for(PRM_Sub_Affiliate__c sub : prmCh.Sub_Affiliates__r){
                if(sub.PRM_Affiliate_Dependent_Type__c == 'Branch' || sub.PRM_Affiliate_Dependent_Type__c == 'Subsidiary'){
                    List<PRM_Sub_Affiliate__c> prmSubAff = prmCh.Sub_Affiliates__r;
                    prmCh.Branch_Count__c = prmSubAff.size();
                    system.debug('Branch: '+prmCh.Branch_Count__c);
                    if(prmCh.Branch_Count__c > 0){
                        prmCh.PRM_Any_Branch_Office_or_Subsidiaries__c = 'Yes';
                        system.debug('Branch Value: '+prmCh.PRM_Any_Branch_Office_or_Subsidiaries__c);
                    }
                    else{
                        prmCh.PRM_Any_Branch_Office_or_Subsidiaries__c = 'No';
                        system.debug('Branch Value: '+prmCh.PRM_Any_Branch_Office_or_Subsidiaries__c);
                    }
                    chAppList.put(prmCh.id,prmCh);
                }
                else if(sub.PRM_Affiliate_Dependent_Type__c == 'Sub-Dealer' || sub.PRM_Affiliate_Dependent_Type__c == 'Sub-Agent'){
                    List<PRM_Sub_Affiliate__c> prmSubAffs = prmCh.Sub_Affiliates__r;
                    prmCh.Sub_Agent_Dealer_Count__c = prmSubAffs.size();
                    system.debug('Sub-Dealer: '+prmCh.Sub_Agent_Dealer_Count__c);
                    if(prmCh.Sub_Agent_Dealer_Count__c > 0){
                        prmCh.PRM_Any_use_of_Sub_dealers_or_Sub_Agents__c = 'Yes';
                        system.debug('Dealer value: '+prmCh.PRM_Any_use_of_Sub_dealers_or_Sub_Agents__c);
                    }
                    else{
                        prmCh.PRM_Any_use_of_Sub_dealers_or_Sub_Agents__c = 'No';
                        system.debug('Sub-Dealer value: '+prmCh.PRM_Any_use_of_Sub_dealers_or_Sub_Agents__c);
                    }
                    chAppList.put(prmCh.id,prmCh);
                }
            }
        }
        
        update chAppList.values();
        system.debug('Updated value: '+chAppList.values());
    }
    
    public void subAffiliateBranchUpdate(List<PRM_Sub_Affiliate__c> subAff,Map<ID,PRM_Sub_Affiliate__c> subAffOld){
        set<ID> suAffId = new set<ID>();
        Map<ID,PRM_Channel_Appointment_GE_OG__c> chAppList = new Map<ID,PRM_Channel_Appointment_GE_OG__c>();
        
        for(PRM_Sub_Affiliate__c subAffiliate : subAff){
            if(subAffiliate.PRM_Affiliate_Dependent_Type__c != subAffOld.get(subAffiliate.id).PRM_Affiliate_Dependent_Type__c || subAffiliate.PRM_Active__c != subAffOld.get(subAffiliate.id).PRM_Active__c){
                suAffId.add(subAffiliate.PRM_Channel_Appointment__c);
            }
        }
        
        List<PRM_Channel_Appointment_GE_OG__c> prm_chApp = new List<PRM_Channel_Appointment_GE_OG__c> ([select id,PRM_Any_use_of_Sub_dealers_or_Sub_Agents__c,PRM_Any_Branch_Office_or_Subsidiaries__c,(select id,PRM_Active__c,PRM_Channel_Appointment__c,PRM_Channel_Appointment__r.PRM_Any_use_of_Sub_dealers_or_Sub_Agents__c,PRM_Affiliate_Dependent_Type__c,PRM_Channel_Appointment__r.PRM_Any_Branch_Office_or_Subsidiaries__c from Sub_Affiliates__r where PRM_Active__c=true and PRM_Affiliate_Dependent_Type__c in ('Branch','Subsidiary')) from PRM_Channel_Appointment_GE_OG__c where id in :suAffId]);
        for(PRM_Channel_Appointment_GE_OG__c prmCh : prm_chApp){
            List<PRM_Sub_Affiliate__c> prmSubAff = prmCh.Sub_Affiliates__r;
            prmCh.Branch_Count__c = prmSubAff.size();
            system.debug('Branch: '+prmCh.Branch_Count__c);
            if(prmCh.Branch_Count__c > 0){
                prmCh.PRM_Any_Branch_Office_or_Subsidiaries__c = 'Yes';
                system.debug('Branch Value: '+prmCh.PRM_Any_Branch_Office_or_Subsidiaries__c);
            }
            else{
                prmCh.PRM_Any_Branch_Office_or_Subsidiaries__c = 'No';
                system.debug('Branch Value: '+prmCh.PRM_Any_Branch_Office_or_Subsidiaries__c);
            }
            chAppList.put(prmCh.id,prmCh);
        }
        update chAppList.values();
    }
    
    public void subAffiliateDealerUpdate(List<PRM_Sub_Affiliate__c> subAff,Map<ID,PRM_Sub_Affiliate__c> subAffOld){
        set<ID> suAffId = new set<ID>();
        Map<ID,PRM_Channel_Appointment_GE_OG__c> chAppList = new Map<ID,PRM_Channel_Appointment_GE_OG__c>();
        
        for(PRM_Sub_Affiliate__c subAffiliate : subAff){
            if(subAffiliate.PRM_Affiliate_Dependent_Type__c != subAffOld.get(subAffiliate.id).PRM_Affiliate_Dependent_Type__c || subAffiliate.PRM_Active__c != subAffOld.get(subAffiliate.id).PRM_Active__c){
                suAffId.add(subAffiliate.PRM_Channel_Appointment__c);
            }
        }
        
        List<PRM_Channel_Appointment_GE_OG__c> prm_chApps = new List<PRM_Channel_Appointment_GE_OG__c> ([select id,PRM_Any_use_of_Sub_dealers_or_Sub_Agents__c,PRM_Any_Branch_Office_or_Subsidiaries__c,(select id,PRM_Active__c,PRM_Channel_Appointment__c,PRM_Channel_Appointment__r.PRM_Any_use_of_Sub_dealers_or_Sub_Agents__c,PRM_Affiliate_Dependent_Type__c,PRM_Channel_Appointment__r.PRM_Any_Branch_Office_or_Subsidiaries__c from Sub_Affiliates__r where PRM_Active__c=true and PRM_Affiliate_Dependent_Type__c in ('Sub-Dealer','Sub-Agent')) from PRM_Channel_Appointment_GE_OG__c where id in :suAffId]);
        for(PRM_Channel_Appointment_GE_OG__c prmCh : prm_chApps){
            List<PRM_Sub_Affiliate__c> prmSubAffs = prmCh.Sub_Affiliates__r;
            prmCh.Sub_Agent_Dealer_Count__c = prmSubAffs.size();
            system.debug('Sub-Dealer: '+prmCh.Sub_Agent_Dealer_Count__c);
            if(prmCh.Sub_Agent_Dealer_Count__c > 0){
                prmCh.PRM_Any_use_of_Sub_dealers_or_Sub_Agents__c = 'Yes';
                system.debug('Dealer value: '+prmCh.PRM_Any_use_of_Sub_dealers_or_Sub_Agents__c);
            }
            else{
                prmCh.PRM_Any_use_of_Sub_dealers_or_Sub_Agents__c = 'No';
                system.debug('Sub-Dealer value: '+prmCh.PRM_Any_use_of_Sub_dealers_or_Sub_Agents__c);
            }
            chAppList.put(prmCh.id,prmCh);
            system.debug('ChAppList: '+chAppList);
        }
        update chAppList.values();
    }
}