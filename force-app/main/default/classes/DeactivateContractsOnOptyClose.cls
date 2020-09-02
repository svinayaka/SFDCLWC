/*
Class/Trigger Name     : DeactivateContractsOnOptyClose
Used Where ?           : Process builder to create records
Purpose/Overview       : Used to Deactivate Contracts On Opty Close records . 
Scrum Team             : Transformation - OPPTY MGMT
Requirement Number     : R-32213
Author                 : Harsha C
Created Date           : 24/June/2019
Test Class Name        : Contract_Record_Creation_Test
Code Coverage          : 76%
*/

global class DeactivateContractsOnOptyClose {
    @InvocableMethod(label='contract Record Deactivation' description='TO Deactivate contract Record from Opportunity')
    public Static void contractRecordCreation (List<Id> OpportunityId){
        set<Id> opId = new Set<Id>();
        set<Id> opConIdSet = new Set<Id>();
        LIST<Contract> SuccesscontractList = new List<Contract>(); 
        System.debug('Inside DeactivateContractsOnOptyClose >>> '+OpportunityId);
        List<Contract> oppconId = new List<Contract>();
        try{
            List<Opportunity_Contract_Relationship_GE_OG__c> optyContarctRelation = [Select Id,Name,Contract_ID_GE_OG__c,
                                                                                     Contract_ID_GE_OG__r.Status,
                                                                                     Primary_Opportunity_GE_OG__c,  opportunity_ID_ge_og__c,opportunity_ID_ge_og__r.stage_ge_og__c from Opportunity_Contract_Relationship_GE_OG__c 
                                                                                     where opportunity_ID_ge_og__c  IN :OpportunityId and Primary_Opportunity_GE_OG__c = true and opportunity_ID_ge_og__r.StageName != 'Closed Won'];
            
            System.debug('optyContarctRelation >>> '+optyContarctRelation);
            for(Opportunity_Contract_Relationship_GE_OG__c opconr :optyContarctRelation ){
                if((opconr.Contract_ID_GE_OG__r.Status=='Draft' || opconr.Contract_ID_GE_OG__r.Status=='In Progress')&&
                   (opconr.opportunity_ID_ge_og__r.stage_ge_og__c == 'Closed Lost'|| opconr.opportunity_ID_ge_og__r.stage_ge_og__c =='Cancelled') ){
                    Contract con = new Contract(); con.Id = opconr.Contract_ID_GE_OG__c; con.Status = 'Cancelled';con.Is_Status_Automation__c = true;oppconId.add(con);
                }
            }
            Database.SaveResult[]  SaveResultListContract;
            if(!oppconId.isEmpty()){
                SaveResultListContract = Database.update(oppconId);
                System.debug('SaveResultListContract >>>> '+SaveResultListContract);
                for(integer i =0; i<oppconId.size();i++){ If(SaveResultListContract[i].isSuccess()){SuccesscontractList.add(oppconId.get(i)); 
                    }
                }
            }
            List<Contract> contList = new List<Contract>();
                
            for(Contract c : SuccesscontractList){
                c.Is_Status_Automation__c = false; contList.add(c);
                
            }System.debug('contList >>> '+contList); 
            Database.update(contList);
            
        }catch(Exception e){
            System.debug('Exception occured in line number : '+e.getLineNumber());
            System.debug('Exception Message : '+e.getMessage());
            System.debug('Exception cause :'+e.getCause());
        }
    }
}