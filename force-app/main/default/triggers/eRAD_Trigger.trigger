trigger eRAD_Trigger on eRAD__c (before insert,after insert,before update,after update) {
    set<id> Opptyids = new Set<id>();
    set<id> Opids = new Set<id>();
    List<Competitor__c> compList = new List<Competitor__c>();
    Map<id,Erad__c> eraMap = new Map<id,eRad__c>();
    List<eRad__c> radlist = new LIst<eRad__c>();
    
    Public Map<Id,OpportunityTeamMember> oppMemberMap = new Map<Id,OpportunityTeamMember>();
    
    
    
    if(trigger.isBefore && trigger.isInsert){
        for(eRad__c rad : trigger.New){
            if(rad.Opportunity__c != null ){
                Opids.add(rad.Opportunity__c);
            }
        }
        
        //R-23908
       //Populating Oppty Members to Find out ComOps_Manager__c
        For ( OpportunityTeamMember otm : [Select Id,OpportunityId,UserId, TeamMemberRole From OpportunityTeamMember Where
         TeamMemberRole ='Primary Commercial Manager' and OpportunityId in: Opids])
         {
             oppMemberMap.put(otm.OpportunityId,otm);
         }
         
         
        Map<id,Opportunity> opMap = new Map<id,Opportunity>([select id,name,OwnerId,Amount from Opportunity where id IN: opids]);
        if(opMap.size() > 0){
            for(eRad__c rad : trigger.New){
                if(opMap.containskey(rad.Opportunity__c))
                if(rad.status__c == 'Sales Mode'){
                    String coseName = 'Closed bid eRad for'+' '+opMap.get(rad.Opportunity__c).Name;
                    if(coseName.length() > 80)
                    rad.Name = coseName.substring(0,80);
                    else
                    rad.Name = coseName;
                }
                if(rad.status__c == 'Active Bid'){
                    String coseName = 'Active bid eRad for'+' '+opMap.get(rad.Opportunity__c).Name;
                    if(coseName.length() > 80)
                    rad.Name = coseName.substring(0,80);
                    else
                    rad.Name = coseName;
                }
                if(rad.Sales_Manager__c == null)
                rad.Sales_Manager__c = opMap.get(rad.Opportunity__c).OwnerId;
                if(rad.ComOps_Manager__c == null && oppMemberMap.Get(rad.Opportunity__c)!=null)
                //rad.ComOps_Manager__c = opMap.get(rad.Opportunity__c).GE_ES_Commercial_Primary_Resource__c ;
                rad.ComOps_Manager__c = oppMemberMap.Get(rad.Opportunity__c).UserId;
            }
        }
        
    }
    if(trigger.isafter && trigger.isinsert){
        for(eRad__c rad : trigger.New){
            if(rad.status__c =='Sales mode'){
                Opptyids.add(rad.Opportunity__c);
            }
        }
        if(Opptyids.size() >0)
        radlist = [select id,Status__c,recordtypeid,Capex_Category_Weight__c,Opportunity__c from eRad__c where Opportunity__c IN: Opptyids and Status__c = 'Active Bid'];
        if(radlist.size() > 0){
            for(eRad__c rad : radlist){
                if(rad.recordtypeid == Schema.SObjectType.eRad__c.getRecordTypeInfosByName().get('TMS - CSA').getRecordTypeId())
                    rad.recordtypeid = Schema.SObjectType.eRad__c.getRecordTypeInfosByName().get('TMS- CSA Read Only').getRecordTypeId();
                else if(rad.recordtypeid == Schema.SObjectType.eRad__c.getRecordTypeInfosByName().get('Subsea').getRecordTypeId())
                    rad.recordtypeid = Schema.SObjectType.eRad__c.getRecordTypeInfosByName().get('Subsea Read Only').getRecordTypeId();
                else if(rad.recordtypeid == Schema.SObjectType.eRad__c.getRecordTypeInfosByName().get('TMS New Units/Opex').getRecordTypeId())
                    rad.recordtypeid = Schema.SObjectType.eRad__c.getRecordTypeInfosByName().get('TMS - New Units Read Only').getRecordTypeId();
            }
        }
        update radlist;
    }
    if(trigger.isUpdate && trigger.isBefore){
        for(eRad__c rad : trigger.New){
            if(rad.Opportunity__c != null){
                if(trigger.oldmap.get(rad.id).Opportunity__c != rad.Opportunity__c){
                    rad.adderror('Opportunity Cannot be changed.');
                }
            }
        }
        for(eRad__c erd : trigger.New){
            if(erd.Status__c == 'Sales Mode' && (erd.Approval_Status__c == 'Submit For Approval' && trigger.oldmap.get(erd.id).Approval_Status__c != 'Submit For Approval')){
                erd.eRAD_Sales_Date__c = System.today();
            }else if(erd.Status__c == 'ComOps Mode' && (erd.Approval_Status__c == 'Submit For Approval' && trigger.oldmap.get(erd.id).Approval_Status__c != 'Submit For Approval')){
                erd.eRAD_ComOps_Date__c = System.today();
            }else if(erd.Status__c == 'Approved' && trigger.oldmap.get(erd.id).Status__c != 'Approved'){
                erd.eRAD_Approved_Date__c = System.today();
            }
        }
    }
    set<id> eradid = new Set<id>();
    List<competitor__c> competlist = new List<competitor__c>();
    if(trigger.isUpdate && trigger.isafter){
        for(eRad__c rad : trigger.New){
            if(rad.Opportunity_Status__c == 'Closed Won' && trigger.oldmap.get(rad.id).tender_format_tms__c != rad.tender_format_tms__c && (rad.tender_format_tms__c == 'Single source' || rad.tender_format_tms__c == 'Single source with FA' || rad.tender_format_tms__c == 'Private Bid with negotiation without competition')){
                eradid.add(rad.id);
            }
        }
        if(eradid.size() > 0){
            competlist = [select id from Competitor__c where eRAD__c IN: eradid];
        }
        if(competlist.size() > 0){
            delete competlist;
        }
    }
    
    if(trigger.isAfter && trigger.isInsert){
        for(eRAD__c er : trigger.new){
            if(er.Opportunity_Status__c == 'Closed Won' || er.Opportunity_Status__c == 'Closed Lost'){
                        system.debug('Came inside eRAD Trigger');
                eRADTriggerHandler_GE_OG.calculateProductUnits(trigger.new);
            }
        }
    }
}