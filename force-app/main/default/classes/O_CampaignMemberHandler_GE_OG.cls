/*
Class/Trigger Name     : O_CampaignMemberHandler_GE_OG
Used Where ?           : O_CampaignMember_Trig_GE_OG trigger
Purpose/Overview       : Used for adding Leads/Contacts as "Campaign Member" to Campaign records
Scrum Team             : OPPTY MGMT
Requirement Number     : 
Author                 : Gourav Anand
Created Date           : 02/FEB/2017
Test Class Name        : O_CampaignMemberHandler_GE_OG_Test
Code Coverage          : 
*/

public class O_CampaignMemberHandler_GE_OG {

    Map<Id,Set<Id>> cmrLeadmap = new Map<Id,Set<Id>>();
    
    //Method to update Lead and Contact details during CMR creation
    public void updateContactLeadDetails(List<CampaignMember> newCMRlist){
        System.debug('------------------------Entering into O_CampaignMemberHandler_GE_OG.updateContactLeadDetails-->');
        Set<Id> campaignIdSet = new Set<Id>();
        Set<Id> contactIdSet = new Set<Id>();
        Set<Id> leadIdSet = new Set<Id>();
        CampaignMember updCMR = new CampaignMember();
        List<CampaignMember> updCMRList = new List<CampaignMember>();
        List<Contact> contactList = new List<Contact>();
        List<Lead> leadList = new List<Lead>();
        List<Contact> updContactList = new List<Contact>();
        List<Lead> updLeadList = new List<Lead>();
        Map<Id,CampaignMember> mapContactCMR = new Map<Id,CampaignMember>();
        Map<Id,CampaignMember> mapLeadCMR = new Map<Id,CampaignMember>();
        Map<Id,Contact> mapContact = new Map<Id,Contact>();
        Map<Id,Lead> mapLead = new Map<Id,Lead>();
        
        for (CampaignMember cmr:newCMRlist ){
            System.debug('------------>> CMR Id'+cmr.Id);
            campaignIdSet.add(cmr.CampaignId);
            
            if(cmr.ContactId != null){
               System.debug('------------>> Contact Id'+cmr.ContactId); 
               contactIdSet.add(cmr.ContactId); 
               mapContactCMR.put(cmr.ContactId, cmr);  
            }else if(cmr.LeadId != null){
               System.debug('------------>> Lead Id'+cmr.LeadId); 
               leadIdSet.add(cmr.LeadId);
               mapLeadCMR.put(cmr.LeadId, cmr); 
            }
        }
        
        contactList = [SELECT  Id, Name, GE_OG_Area_of_Interest__c,Tier_4_from_Webform__c,GE_OG_Comments__c,GE_OG_Inquiry_Type__c FROM Contact 
                        WHERE Id IN : contactIdSet];

    leadList = [SELECT Id, Name, area_of_interest_ge_og__c,Tier_4_from_Webform__c,Comments_ge_og__c,inquiry_type_ge_og__c FROM Lead 
                        WHERE Id IN : leadIdSet];
        
        if(contactList != null && contactList.size()>0) {
            for(Contact cntct:contactList){
               if(mapContactCMR.containsKey(cntct.Id)){
                        updCMR = mapContactCMR.get(cntct.Id);
                        updCMR.Area_of_Interest_ge_og__c = cntct.GE_OG_Area_of_Interest__c;
                        updCMR.Comments_ge_og__c = cntct.GE_OG_Comments__c;
                        updCMR.Inquiry_Type_ge_og__c = cntct.GE_OG_Inquiry_Type__c ;
                       if(String.valueOf(updCMR.Tier2_ge_og__c) == 'Digital Solutions')
                       {
                            updCMR.Tier_4_from_Webform__c = cntct.Tier_4_from_Webform__c ;
                       }
                       
                        //updCMR.CMR_Type_ge_og__c = 'Contact';
                       updCMR.Status='Lead Prospecting';
                        updCMRList.add(updCMR);
                  }
                
             }
        }
        if(leadList != null && leadList.size()>0){
            System.debug('------------>>>> leadList size:'+leadList.size());
             for(Lead lead:leadList){
                 if(mapLeadCMR.containsKey(lead.Id)){
                        updCMR = mapLeadCMR.get(lead.Id);
                        updCMR.Area_of_Interest_ge_og__c = lead.area_of_interest_ge_og__c;
                        updCMR.Comments_ge_og__c = lead.Comments_ge_og__c ;
                        updCMR.Inquiry_Type_ge_og__c = lead.inquiry_type_ge_og__c ;
                         if(String.valueOf(updCMR.Tier2_ge_og__c) == 'Digital Solutions')
                       {
                            updCMR.Tier_4_from_Webform__c = lead.Tier_4_from_Webform__c ;
                       }
                        updCMR.Tier_4_from_Webform__c = lead.Tier_4_from_Webform__c ;
                        System.debug('---------->> Creating CMR from Lead with Owner-:'+updCMR.Owner_ge_og__c);  
                        if(updCMR.Owner_ge_og__c == null)
                          updCMR.Status='Lead Prospecting';
                       else{
                           updCMR.Status='Lead Prospecting'; 
                            updCMR.Date_Assigned_ge_og__c=System.today();
                        }
                        //updCMR.CMR_Type_ge_og__c = 'Lead';
                   }
                  updCMRList.add(updCMR);
             }
        }
        
                              
    } 
    
    //To automate CMR transition through various status as per set criteria
    public void automateCMRstatusTransition(List<CampaignMember> newCMRlist, Map<Id,CampaignMember> oldCMRmap){
        
      //To dispose through various status as per set criteria
        checkUpdateDispositionedCMR(newCMRlist, oldCMRmap);
        for(CampaignMember cmr:newCMRlist){
            
            if(cmr.Status !='Lead Cancelled' && cmr.Status !='Lead Conversion' ){
                
                if((cmr.Status_ge_og__c== null || cmr.Status_ge_og__c=='') && cmr.Has_Tier_P_L_ge_og__c && (cmr.ContactId!=null || cmr.LeadId!=null)){
                System.debug('--------->>>Going to update CMR status: Lead Prospecting');
                cmr.Status='Lead Prospecting';
                cmr.Status_ge_og__c='';
            }
            if((cmr.Status=='Lead Prospecting' && oldCMRmap.get(cmr.Id).Owner_ge_og__c == null &&cmr.Owner_ge_og__c != null)||(cmr.Status=='Lead Prospecting' &&oldCMRmap.get(cmr.Id).Owner_ge_og__c !=cmr.Owner_ge_og__c))
            {
                cmr.Date_Assigned_ge_og__c=System.today();
            }
            if( cmr.Last_Name_and_Email_check__c && cmr.Has_Campaign__c && cmr.Has_CMR_Owner_ge_og__c  && cmr.Last_Activity_Date_ge_og__c!=null){
                  System.debug('--------->>>Going to update CMR status: Lead Prospecting');    
                   cmr.Status='Lead Qualifying';
                    cmr.Status_ge_og__c='Lead Qualifying';
                  cmr.Status_ge_og__c='';
                    if(oldCMRmap.get(cmr.Id).Owner_ge_og__c != cmr.Owner_ge_og__c)
                    {
                        cmr.Date_Assigned_ge_og__c=System.today();
                    } 
                    
                    if(cmr.Date_Qualifiying_Started_ge_og__c==null)
                       cmr.Date_Qualifiying_Started_ge_og__c=System.today();
                    
                    
                }
                else{
                    system.debug('CMR Status : Lead Prospecting as Lead Qualifying criteria did not match');
                    cmr.Status='Lead Prospecting';
                    cmr.Status_ge_og__c='';
                }
                
            }
            
            
        }
        
    }
    
    //Method for dispositioning Campaign- Abort
    public void checkUpdateDispositionedCMR(List<CampaignMember> newCMRlist, Map<Id,CampaignMember> oldCMRMap){
        System.debug('--------->>Entering into O_CampaignMemberHandler_GE_OG.checkUpdateAbortedStatus:'+newCMRlist.size());
        Set<Id> removeCmrIDs = new Set<Id>();
        Set<Id> updLeadIDs = new Set<Id>();
        Set<Id> leadIds = new Set<Id>();
    if(newCMRlist.Size()>0){
            // Iterate Over updated CampaignMember and dispose based on criteria mentioned
            for(CampaignMember cmr: newCMRlist){
                String strCustomStatus = cmr.Status_ge_og__c;
                String prvCstmStatus = oldCMRMap.get(cmr.Id).Status_ge_og__c;
                System.debug('------->>Earlier stage before updating '+cmr.FirstName+' '+cmr.LastName+'; Cstm Status:'+prvCstmStatus+'->'
                             +strCustomStatus+'; Std. Status:'+oldCMRMap.get(cmr.Id).Status+'->'+cmr.Status);
                String disposition_reason = '';
                
        if((strCustomStatus!=null||strCustomStatus!='') && strCustomStatus=='Lead Conversion'  && cmr.Status !='Lead Qualifying' && cmr.Status !='Lead Conversion'){
                        System.debug('----->> Going to disposition current CMR: No oppty');
                        cmr.addError('A CMR needs to be in Lead Qualifying status in order to be dispositioned'); 
        }    
        if((strCustomStatus!=null||strCustomStatus!='') && strCustomStatus=='Lead Cancelled' && cmr.Status !='Lead Conversion'){
                        System.debug('----->> Going to disposition current CMR: Lead Cancelled');
                        cmr.Status = strCustomStatus;
                      cmr.Date_Dispositioned_ge_og__c= System.today();
                        //To store Leads and update status to Lead Cancelled for these leads
                      /**  if(cmr.LeadId!=null){
                            leadIds.add(cmr.LeadId);
                            removeCmrIDs.add(cmr.Id);
                        } **/
                     if(String.isBlank(cmr.Dispostion_Reason_ge_og__c)){
                        cmr.addError(System.Label.CMR_Disposition_Error);
                    }
                        if(cmr.Dispostion_Reason_ge_og__c == 'Blacklisted')
                        {
                            leadIds.add(cmr.LeadId);
                            removeCmrIDs.add(cmr.Id);
                        }                   
                    
                }/*else if((strCustomStatus!=null||strCustomStatus!='') && strCustomStatus=='Lead Cancelled' && cmr.Status=='Lead Cancelled'){
                        System.debug('----->> Going to disposition: Lead Cancelled coming from Lead Disposition');
                        cmr.Status = strCustomStatus;
                      cmr.Date_Dispositioned_ge_og__c= System.today();
                        //To store Leads and update status to Lead Cancelled for these leads
                                            
                } */
              /**  else if((cmr.Status=='Lead Qualifying' && strCustomStatus!=null||strCustomStatus!='') && (strCustomStatus=='Lead Cancelled'||strCustomStatus=='Lead Cancelled'))
                {
                    system.debug('cmr.Status'+cmr.Status);
                    system.debug('strCustomStatus'+strCustomStatus);
                    if(String.isBlank(cmr.Dispostion_Reason_ge_og__c)){
                        cmr.addError(System.Label.CMR_Disposition_Error);
                    }
                    else{
                        System.debug('----->> Going to disposition: Lead Cancelled or Lead Cancelled');
                        cmr.Status = strCustomStatus;
                        cmr.Date_Dispositioned_ge_og__c= System.today();
                        
                    }
                } **/
        if(cmr.Status=='Lead Qualifying' && strCustomStatus!=null && strCustomStatus=='Lead Conversion'){
                    System.debug('----->> Going to disposition: Contact or Lead Conversion'); 
                    cmr.Status = strCustomStatus;
                    cmr.Dispostion_Reason_ge_og__c = '';
                    cmr.Date_Dispositioned_ge_og__c= System.today();
                    
                }
             /**   else if(strCustomStatus!=null && strCustomStatus=='Lead Cancelled'){
                    if(cmr.Status !='Lead Prospecting'){
                        cmr.addError('Lead Prospecting campaign can only be dispositioned for *Lead Cancelled* status');
                    }else{  
                      System.debug('----->> Going to disposition: Lead Cancelled'); 
                      cmr.Status = strCustomStatus;
                        cmr.Date_Dispositioned_ge_og__c= System.today();
                    }
                    
                } **/
                /** if((cmr.Status!='Lead Cancelled' ||cmr.Status!='Lead Cancelled' ||cmr.Status!='Lead Cancelled'||cmr.Status!='Lead Cancelled'||cmr.Status!='Lead Conversion') && cmr.Status != cmr.Status_ge_og__c)
                    cmr.Status_ge_og__c=''; **/
                  
            }
                
        }
        //Logic to update the status of Leads when related CMRs are Lead Cancelled
        List<Lead> updLeads = new List<Lead>();
        System.debug('----------------Logic to fire Lead Blaklist in CMR handler'+leadIds);  
        if(leadIds !=null && leadIds.size()>0){
          List<Lead> leadList = [Select Id,Status,FirstName,Email from Lead where Id in : leadIds and Status !='Lead Cancelled'];
          if(leadList !=null && leadList.size()>0){
            for(Lead lead:leadList){
             System.debug('----------------Lead to be black Listed:'+lead.FirstName+'; Email:'+lead.Email);  
             lead.Status='Blacklisted';
             lead.Custom_Status_ge_og__c='Blacklisted';   
             updLeads.add(lead);
            
           }
           update updLeads; 
           System.debug('----- removeCMRids:'+removeCmrIDs); 
           
           List<CampaignMember> cmrBlckListed = [Select Id,Status,Status_ge_og__c from CampaignMember where LeadId IN : leadIds AND ID NOT IN :removeCmrIDs AND Status_ge_og__c !='Lead Cancelled'];
           List<CampaignMember> updCmrBlckListed = new List<CampaignMember>();
           if(cmrBlckListed !=null && cmrBlckListed.size()>0){
            System.debug('------------------Remaining CMRs to be blaclisted size='+cmrBlckListed.size());   
            for(CampaignMember cmr : cmrBlckListed) {
                cmr.Status_ge_og__c='Lead Cancelled';
                cmr.Status='Lead Cancelled';
                cmr.Date_Dispositioned_ge_og__c=System.today();
                cmr.Dispostion_Reason_ge_og__c = 'Blacklisted';
                updCmrBlckListed.add(cmr);
            }
            if(updCmrBlckListed !=null && updCmrBlckListed.size()>0){
                System.debug('==--------------Going to update CMRs for Lead Cancelled Lead');
                update updCmrBlckListed;  
            } 
          }    
         } 
        }
    } 

  
}