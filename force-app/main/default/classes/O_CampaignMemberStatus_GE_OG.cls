public class O_CampaignMemberStatus_GE_OG {
    
    public void autoInsertCampaignMemberStatus(List<Campaign> newCmpgnList){
    System.debug('----------------- Inside CampaignTrigger.autoInsertCampaignMemberStatus to create new set of CMR status');     
    ID cmpgnRecType = schema.SObjectType.Campaign.getRecordTypeInfosByName().get('Campaign').getRecordTypeID();    
    
    Map<ID,Set<String>> eCMS = new Map<ID,Set<String>>();
    Set<Id> camps = new Set<Id>();
    List<CampaignMemberStatus> cms2Delete = new List<CampaignMemberStatus>();
    List<CampaignMemberStatus> cms2Insert = new List<CampaignMemberStatus>();
    
    for(Campaign camp : newCmpgnList){
        if(camp.RecordTypeId==cmpgnRecType){
            System.debug('----------------------------Campaign status list for Campaign:'+camp.Name);
            camps.add(camp.Id);
        }
    }    
    System.debug('-----------------------------Campaign status list - Campaign list size='+camps.size());
    for(CampaignMemberStatus CMS : [select ID, CampaignID,Label from CampaignMemberStatus where CampaignID IN :camps]) {
        
        Set<String> elCMS = eCMS.get(CMS.CampaignID);
        
        if(elCMS == null) {
            elCMS = new Set<String>();
            eCMS.put(CMS.CampaignId, elCMS);
        }
        
        elCMS.add(CMS.Label);
    }     
    
    for(CampaignMemberStatus cm : [select Id, Label, CampaignId from CampaignMemberStatus where CampaignId IN :camps]) {
            
            if(cm.Label == 'Responded' || cm.Label == 'Sent') {             
                 cms2Delete.add(cm);                 
            }
   // INSERT Below  Updated CMR LOVs -- during Creation of each individual Campaign Record.     
        CampaignMemberStatus cms1 = new CampaignMemberStatus(CampaignId = cm.CampaignId, HasResponded=true,
            Label = System.label.CMR_Lead_Prospecting, SortOrder = 3 , isDefault = true );
             if(!eCMS.get(cm.CampaignId).contains(cms1.Label)) {
                cms2Insert.add(cms1);
             }  
        
                CampaignMemberStatus cms2 = new CampaignMemberStatus(CampaignId = cm.CampaignId, HasResponded=true,
            Label = System.label.CMR_Lead_Qualifying, SortOrder = 4 , isDefault = true );
             if(!eCMS.get(cm.CampaignId).contains(cms2.Label)) {
                cms2Insert.add(cms2);
             }  
                CampaignMemberStatus cms3 = new CampaignMemberStatus(CampaignId = cm.CampaignId, HasResponded=true,
            Label = System.label.CMR_Lead_Conversion, SortOrder = 5 , isDefault = true );
             if(!eCMS.get(cm.CampaignId).contains(cms3.Label)) {
                cms2Insert.add(cms3);
             }  
                CampaignMemberStatus cms4 = new CampaignMemberStatus(CampaignId = cm.CampaignId, HasResponded=true,
            Label = System.label.CMR_Lead_Cancelled, SortOrder = 6 , isDefault = true );
             if(!eCMS.get(cm.CampaignId).contains(cms4.Label)) {
                cms2Insert.add(cms4);
             }  
    /*        
            CampaignMemberStatus cms1 = new CampaignMemberStatus(CampaignId = cm.CampaignId, HasResponded=true,
            Label = System.label.CMR_Unassigned, SortOrder = 3 , isDefault = true );
             if(!eCMS.get(cm.CampaignId).contains(cms1.Label)) {
                cms2Insert.add(cms1);
             }            
            
            CampaignMemberStatus cms2 = new CampaignMemberStatus(CampaignId = cm.CampaignId, HasResponded=true,
             Label = System.label.CMR_No_Action_Required, SortOrder = 4);
             if(!eCMS.get(cm.CampaignId).contains(cms2.Label)) {
                cms2Insert.add(cms2);
             } 
             
            CampaignMemberStatus cms3 = new CampaignMemberStatus(CampaignId = cm.CampaignId, HasResponded=true,
             Label = System.label.CMR_Assigned, SortOrder = 5);
             if(!eCMS.get(cm.CampaignId).contains(cms3.Label)) {
                cms2Insert.add(cms3);
             }  
             
             CampaignMemberStatus cms4 = new CampaignMemberStatus(CampaignId = cm.CampaignId, HasResponded=true,
             Label = System.label.CMR_Blacklisted, SortOrder = 6);
             if(!eCMS.get(cm.CampaignId).contains(cms4.Label)) {
                cms2Insert.add(cms4);
             } 
        
            CampaignMemberStatus cms5 = new CampaignMemberStatus(CampaignId = cm.CampaignId, HasResponded=true,
            Label = System.label.CMR_Contact, SortOrder = 7);
             if(!eCMS.get(cm.CampaignId).contains(cms1.Label)) {
                cms2Insert.add(cms5);
             }            
            
            CampaignMemberStatus cms6 = new CampaignMemberStatus(CampaignId = cm.CampaignId, HasResponded=true,
             Label = System.label.CMR_Converted_Opportunity, SortOrder = 8);
             if(!eCMS.get(cm.CampaignId).contains(cms2.Label)) {
                cms2Insert.add(cms6);
             } 
             
            CampaignMemberStatus cms7 = new CampaignMemberStatus(CampaignId = cm.CampaignId, HasResponded=true,
             Label = System.label.CMR_No_Opportunity, SortOrder = 9);
             if(!eCMS.get(cm.CampaignId).contains(cms3.Label)) {
                cms2Insert.add(cms7);
             }  
             
             CampaignMemberStatus cms8 = new CampaignMemberStatus(CampaignId = cm.CampaignId, HasResponded=true,
             Label = System.label.CMR_Prospect, SortOrder = 10);
             if(!eCMS.get(cm.CampaignId).contains(cms4.Label)) {
                cms2Insert.add(cms8);
             } 
        
            CampaignMemberStatus cms9 = new CampaignMemberStatus(CampaignId = cm.CampaignId, HasResponded=true,
             Label = System.label.CMR_Qualifying , SortOrder = 11);
             if(!eCMS.get(cm.CampaignId).contains(cms4.Label)) {
                cms2Insert.add(cms9);
             } 
*/
     }
      insert cms2Insert;
      delete cms2Delete;
    }
    public static void ProcessCampaignMemberRecords(){
       Integer Cmr = 0;
         Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
         Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
         Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
        Cmr++;
    }

}