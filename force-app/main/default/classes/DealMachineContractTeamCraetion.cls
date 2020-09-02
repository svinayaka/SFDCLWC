global class DealMachineContractTeamCraetion {
    @InvocableMethod(label='DM Contract Team Creation' description='Create the DM Contract Team')
    public static void contractTeamDMContract(List<Id> conOppRelId){
        String sObjName = conOppRelId[0].getSObjectType().getDescribe().getName();
        List<Contract_Team__c> lstContractTeam = new List<Contract_Team__c>();
        List<Contract_Team__c> lstDeleteTeam = new List<Contract_Team__c>();
        List<Contract_Team__c> lstupdateOwner = new List<Contract_Team__c>();
        List<Opportunity_Contract_Relationship_GE_OG__c> lstOpptyConRel = new List<Opportunity_Contract_Relationship_GE_OG__c>();
        if(sObjName == 'Opportunity_Contract_Relationship_GE_OG__c'){
            lstOpptyConRel = [SELECT Id,Contract_ID_GE_OG__c,opportunity_ID_ge_og__c,Primary_Opportunity_GE_OG__c,                          Contract_ID_GE_OG__r.Primary_Contract_Manager__c
                            FROM Opportunity_Contract_Relationship_GE_OG__c
                            WHERE id IN: conOppRelId
                            LIMIT 1];
            Id contractId = null;
            Id OpptyId = null;
            Id primaryOwnerId = null;
            if(!lstOpptyConRel.isEmpty()){                            
                for(Opportunity_Contract_Relationship_GE_OG__c objRel: lstOpptyConRel){
                    contractId = objRel.Contract_ID_GE_OG__c;
                    OpptyId = objRel.opportunity_ID_ge_og__c;
                    primaryOwnerId = objRel.Contract_ID_GE_OG__r.Primary_Contract_Manager__c;
                }
                if(primaryOwnerId != null){
                    Contract_Team__c objConTeam = new Contract_Team__c();
                    objConTeam.Team_Role__c = 'Primary Contract Owner';
                    objConTeam.Contract__c = contractId;
                    objConTeam.Contract_Team_Member__c = primaryOwnerId;
                    lstContractTeam.add(objConTeam);
                }
                
                List<OpportunityTeamMember> lstDealTeam = new List<OpportunityTeamMember>();
                lstDealTeam =[SELECT Id, TeamMemberRole,OpportunityId, UserId
                                FROM OpportunityTeamMember
                                WHERE OpportunityId=: OpptyId AND (TeamMemberRole = 'Sales - Primary' OR TeamMemberRole = 'Commercial Primary Resource' OR TeamMemberRole = 'Contracts Manager')
                                LIMIT 50000];
                if(!lstDealTeam.isEmpty()){
                    for(OpportunityTeamMember objTeam: lstDealTeam){
                        Contract_Team__c objConTeam = new Contract_Team__c();
                        objConTeam.Team_Role__c = objTeam.TeamMemberRole;
                        objConTeam.Contract__c = contractId;
                        objConTeam.Contract_Team_Member__c = objTeam.userId;
                        lstContractTeam.add(objConTeam);
                    }
                }
            }
        }
        if(sObjName == 'Contract'){
            Contract objContract = [SELECT id,name,Primary_Contract_Manager__c
                                    FROM Contract where Id IN: conOppRelId
                                    LIMIT 1];
            
            List<Contract_Team__c> lstExistingOwner = [SELECT id, name, Contract__c, Team_Role__c, Contract_Team_Member__c
                                                        FROM Contract_Team__c
                                                        WHERE Team_Role__c ='Primary Contract Owner' AND Contract__c =:objContract.id
                                                        LIMIT 1];
            if(!lstExistingOwner.isEmpty()){        // Primary Contract Owner already present in the team
                if(objContract.Primary_Contract_Manager__c != null){      // Primary Con Owner is updated on Contract
                    //lstExistingOwner[0].Contract_Team_Member__c = objContract.Primary_Contract_Manager__c;
                    lstExistingOwner[0].Team_Role__c = 'Sales';
                    lstupdateOwner.add(lstExistingOwner[0]);
                    
                    Contract_Team__c objConTeam = new Contract_Team__c();
                    objConTeam.Team_Role__c = 'Primary Contract Owner';
                    objConTeam.Contract__c = objContract.id;
                    objConTeam.Contract_Team_Member__c = objContract.Primary_Contract_Manager__c;
                    lstContractTeam.add(objConTeam);
                }
                else{                                // Primary Con Owner is removed from Contract hence should be deleted from Contract Team
                    lstDeleteTeam.addAll(lstExistingOwner);
                }
            }
            else{                                    // Primary Con Owner is not present. So create it.
                if(objContract.Primary_Contract_Manager__c != null){
                    Contract_Team__c objConTeam = new Contract_Team__c();
                    objConTeam.Team_Role__c = 'Primary Contract Owner';
                    objConTeam.Contract__c = objContract.id;
                    objConTeam.Contract_Team_Member__c = objContract.Primary_Contract_Manager__c;
                    lstContractTeam.add(objConTeam);
                }
            }
            
        }
            if(!lstContractTeam.isEmpty()){
                try{
                    insert lstContractTeam;
                }
                catch(Exception e){
                    system.debug('Error while creating contract team '+e.getMessage());
                }
            }
            if(!lstupdateOwner.isEmpty()){
                try{
                    update lstupdateOwner;
                }
                catch(Exception e){
                    system.debug('Error while updating contract team '+e.getMessage());
                }
            }
            if(!lstDeleteTeam.isEmpty()){
                try{
                    delete lstDeleteTeam;
                }
                catch(Exception e){
                    system.debug('Error while deleting contract team '+e.getMessage());
                }
            }
    }
}