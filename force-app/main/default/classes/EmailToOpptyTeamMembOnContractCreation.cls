public class EmailToOpptyTeamMembOnContractCreation {
    @InvocableMethod(label='SendMailToContractOwner' description='TO create contract Record from Opportunity')
    public Static void SendMailToContractOwner (List<Opportunity_Contract_Relationship_GE_OG__c> Opportunity_Contract_RelationshipID){
         
        LIST<OpportunityTeamMember> opptyTeamList = new List<OpportunityTeamMember>();    
        set<Id> ocrId = new Set<Id>();
        set<Id> opptyId = new Set<Id>();
        LIST<Id> ocrList = new List<Id>();
        Map<Id,List<Id>> contractandUserMap = new Map<Id,List<Id>>();
        Map<Id,List<Id>> DealteamUserMap = new Map<Id,List<Id>>();
        Map<Id,List<Id>> DealCPRUserMap = new Map<Id,List<Id>>();
        Map<Id,List<Id>> OCRWithTeam = new Map<Id,List<Id>>();
        Map<Id,Opportunity_Contract_Relationship_GE_OG__c> opptywithOCR = new Map<Id,Opportunity_Contract_Relationship_GE_OG__c>();
        Map<Id,Opportunity_Contract_Relationship_GE_OG__c> ocrMap = new Map<Id,Opportunity_Contract_Relationship_GE_OG__c>();
        Map<Id,List<Id>> oCRwithCPR = new  Map<Id,List<Id>>();
		Map<Id,List<Id>> oCRwithCPRcreate_cont = new  Map<Id,List<Id>>();
        for(Opportunity_Contract_Relationship_GE_OG__c ocID : Opportunity_Contract_RelationshipID){
            ocrList.add(ocId.Id);
        }
        System.debug('ocrList >>> '+ocrList);
        
        try{
            List<Opportunity_Contract_Relationship_GE_OG__c> opcont=[select id,Contract_ID_GE_OG__c,opportunity_ID_ge_og__c,Primary_Opportunity_GE_OG__c,
                                                                     opportunity_ID_ge_og__r.Name, opportunity_ID_ge_og__r.Account.Name, opportunity_ID_ge_og__r.Account.Type,
                                                                     opportunity_ID_ge_og__r.region_ge_og__c, opportunity_ID_ge_og__r.tier_2_ge_og__c, Contract_ID_GE_OG__r.Name,
                                                                     Contract_ID_GE_OG__r.ContractNumber, Contract_ID_GE_OG__r.Status,Contract_ID_GE_OG__r.OwnerId,opportunity_ID_ge_og__r.deal_path_ge_og__c,
                                                                     opportunity_ID_ge_og__r.Owner.Name,Contract_ID_GE_OG__r.Contract_Type_Entered__c,Contract_ID_GE_OG__r.Owner.Name from Opportunity_Contract_Relationship_GE_OG__c
                                                                     where id IN:ocrList];
            for(Opportunity_Contract_Relationship_GE_OG__c ocr:opcont)
            {
                opptyId.add(ocr.opportunity_ID_ge_og__c);
                opptywithOCR.put(ocr.opportunity_ID_ge_og__c,ocr);
            }
            System.debug('opptywithOCR >>> '+opptywithOCR);
            
            List <OpportunityTeamMember> optyTeamMemeber = [Select Id,Name,OpportunityId,UserId,TeamMemberRole,User.Email from OpportunityTeamMember where OpportunityId IN : opptyId];
            for(OpportunityTeamMember otm:optyTeamMemeber){
                String teammemberRole = otm.TeamMemberRole;
                System.debug('teammemberRole >> '+teammemberRole);
                if(teammemberRole.equalsIgnoreCase('Commercial Primary Resource')){
                    List<Id> userId = new List<Id>();
                    System.debug('Inside 38 >>> '+(otm.UserId));
                    userId.add(otm.UserId);
                    DealCPRUserMap.put(otm.OpportunityId,userId);
                }
                if(teammemberRole.equalsIgnoreCase('Sales - Primary')){
                    List<Id> userId = new List<Id>();
                    userId.add(otm.UserId);
                             
                    DealteamUserMap.put(otm.OpportunityId,userId);
                }
            }
            System.debug('DealCPRUserMap >>> '+DealCPRUserMap);
            System.debug('DealteamUserMap >>> '+DealteamUserMap);
            for(Id opp : opptyId ){ 
                if(opptywithOCR.get(opp).Primary_Opportunity_GE_OG__c){
                    OCRWithTeam.put(opptywithOCR.get(opp).Id,DealteamUserMap.get(opp)); 
					oCRwithCPRcreate_cont.put(opptywithOCR.get(opp).Id, DealCPRUserMap.get(opp)) ;
                }else{
                    oCRwithCPR.put(opptywithOCR.get(opp).Id, DealCPRUserMap.get(opp)) ;
                    
                }
            }
            System.debug('OCRWithTeam >>  '+OCRWithTeam);
            
            for(Opportunity_Contract_Relationship_GE_OG__c ocr:opcont){
                
                if(!ocr.Primary_Opportunity_GE_OG__c){
                    ocrId.add(ocr.Id); 
                    List<String> ContractEmailSet = new List<String>();
                    ContractEmailSet.add(ocr.Contract_ID_GE_OG__r.OwnerId);
                    contractandUserMap.put(ocr.Id, ContractEmailSet);
                    ocrMap.put(ocr.Id,ocr);
                    
                }
            }
            System.debug('contractandUserMap>>>>'+contractandUserMap);
            
            
            if(contractandUserMap.size() > 0){
                SendMailToOptyTeam_Helper sendEmail = new SendMailToOptyTeam_Helper();
                sendEmail.EmailNotificationonOptyAndAsset(contractandUserMap); 
            }
            
            if(OCRWithTeam.size()>0){
                SendMailToOptyTeam_Helper sendEmail1 = new SendMailToOptyTeam_Helper();
                sendEmail1.EmailNotificationonOptyandnewcontract(OCRWithTeam); 
				sendEmail1.EmailNotificationonOptyandnewcontract(oCRwithCPRcreate_cont); 
            }
            
            if(oCRwithCPR.size()>0){
                SendMailToOptyTeam_Helper sendEmail2 = new SendMailToOptyTeam_Helper();
                sendEmail2.EmailNotificationonOptyAndAsset(oCRwithCPR);   
            }
            
        }catch(Exception e){
            System.debug('Exception occured in line number : '+e.getLineNumber());
            System.debug('Exception Message : '+e.getMessage());
            System.debug('Exception cause :'+e.getCause());
        }
        
        
    }
}