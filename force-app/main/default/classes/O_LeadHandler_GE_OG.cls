/*
Class/Trigger Name     : O_LeadHandler_GE_OG
Used Where ?           : 
Purpose/Overview       : Used for Lead records to update the CMRs status
Scrum Team             : OPPTY MGMT
Requirement Number     : 
Author                 : Gourav Anand
Created Date           : 22/FEB/2017
Test Class Name        : O_Campaign_GE_OG_Test
Code Coverage          : 
*/

public class O_LeadHandler_GE_OG {

    //To update the CMRs status when Lead is dispositioned as Blacklisted
    public void updateBlacklistedLeadCMR(List<Lead> newLeadList, Map<Id,Lead> oldLeadMap){
        System.debug('----------O_LeadHandler_GE_OG.updateBlacklistedLeadCMR'+newLeadList.size());
        Set<Id> leadIDs = new Set<Id>();
        Set<Id> leadBlkIDs = new Set<Id>();
        String prvStatus = '';
        List<CampaignMember> updCmpgnMem = new List<CampaignMember>();
        for(Lead lead:newLeadList){
            prvStatus = oldLeadMap.get(lead.Id).Status;
            System.debug('------------------------->> lead Status:'+lead.Custom_Status_ge_og__c+' & '+lead.Status);
            if(lead.Status=='Active' && lead.Custom_Status_ge_og__c =='Blacklisted'){
                System.debug('----------------Going to Disposition Lead on Dispositioning CMRs');
                lead.Status='Blacklisted';
                leadIDs.add(lead.Id);
            }
        }
        if(leadIDs != null && leadIDs.size()>0){
        	List<CampaignMember> CMRlist = [Select Id, Status, Status_ge_og__c,LeadId from CampaignMember where LeadId in:leadIDs and Status !='Blacklisted'];
            System.debug('----------O_LeadHandler_GE_OG.updateBlacklistedLeadCMR CMRList'+CMRlist);
            for(CampaignMember cmr:CMRlist){
                cmr.Status_ge_og__c='Blacklisted';
                cmr.Status='Blacklisted';
                cmr.Date_Dispositioned_ge_og__c=System.today();
                updCmpgnMem.add(cmr);
            }
        }
        System.debug('----------O_LeadHandler_GE_OG.updateBlacklistedLeadCMR updCmpgnMem'+updCmpgnMem);
        if(updCmpgnMem !=null && updCmpgnMem.size()>0){
            update updCmpgnMem;
        }
    }
}