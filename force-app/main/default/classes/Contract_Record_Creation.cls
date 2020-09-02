/*
Class/Trigger Name     : Contract_Record_Creation
Used Where ?           : Process builder to create records
Purpose/Overview       : Used to createContract_Record_Creation  records . 
Scrum Team             : Transformation - OPPTY MGMT
Requirement Number     : R-32173
Author                 : Harsha C
Created Date           : 20/June/2019
Test Class Name        : Contract_Record_Creation_Test
Code Coverage          : 87
*/

global class Contract_Record_Creation {
    @InvocableMethod(label='contract Record creation' description='TO create contract Record from Opportunity')
    public Static void contractRecordCreation (List<Id> OpportunityId){
        LIST<Contract> contractList = new List<Contract>();
        LIST<Contract> SuccesscontractList = new List<Contract>(); 
        List<Opportunity_Contract_Relationship_GE_OG__c> opconList = new List<Opportunity_Contract_Relationship_GE_OG__c>();
        List<Opportunity> oppList = new List<Opportunity>();
        System.debug('Welcome To the Contract_Record_Creation class');
        map<id,Contract> optycontract = new map<id,Contract>();
        set<Id> opId = new Set<Id>();
        try{
            for(Id optyId : OpportunityId){
                opId.add(optyId);
            }
            List<Opportunity> opp = [Select Id,name,AccountId,account_type_ge_og__c,
                                     ge_legal_entity_ge_og__c,region_ge_og__c,sub_region_ge_og__c,
                                     sub_industry_ge_og__c,primary_industry_ge_og__c,install_country_ge_og__c,
                                     tier_2_ge_og__c,tier_3_ge_og__c,Amount,legal_entity_ge_og__c,primary_country_ge_og__c from Opportunity where Id IN:opId];
            System.debug('opp in contract record creation class >>>> '+opp);
            
            Map<Id,Opportunity> optymap = new map<id,Opportunity>();
            for(Opportunity op : opp){
                
                optymap.put(op.Id,op);
                op.create_Contract_Record_ge_og__c = false;
                op.Contract_Created_GE_OG__c = true;
                oppList.add(op);
                
            }
            
            
            for(Id OpptyId : opId){
                Opportunity opty = optymap.get(OpptyId);
                Contract con = new Contract();
                String contractName = 'C - '+opty.Name;
                if(contractName.length() > 80){
                  contractName = contractName.substring(0, 79) ;  
                }
                con.Name = contractName;
                con.Commercial_Account_Name_GEOG__c = opty.AccountId;
                con.Account_Type__c = opty.account_type_ge_og__c;
                con.GE_Legal_Entities__c = opty.ge_legal_entity_ge_og__c;
                con.Account_Legal_Entity__c = opty.legal_entity_ge_og__c;
                con.AccountId = opty.legal_entity_ge_og__c;
                con.Contract_Region__c = opty.region_ge_og__c;
                con.Country_GEOG__c = opty.primary_country_ge_og__c;
                con.Contract_Sub_Region__c = opty.sub_region_ge_og__c;
                con.GE_PRM_Tier_2__c = opty.tier_2_ge_og__c;
                con.GE_PRM_Business_Tier_1__c = 'Oil & Gas';
                con.Tier3_PandL_GEOG__c = opty.tier_3_ge_og__c;
                con.Industry_GEOG__c = opty.primary_industry_ge_og__c;
                con.Sub_Industry_GEOG__c = opty.sub_industry_ge_og__c;
                con.GE_MCS_Contract_Amount__c = opty.Amount;
                con.Is_Created_From_DM__c = true;
                con.Linked_Opportunity_Id__c = opty.Id;
                con.Status = 'Draft';
                //con.GE_OG_Contract_End_Date__c = system.today();
                //con.GE_OG_Evergreen__c = true;
                con.RecordTypeId= Schema.SObjectType.Contract.getRecordTypeInfosByDeveloperName().get('Deal_Machine_Contract').getRecordTypeId();
                contractList.add(con);
                
                optycontract.put(OpptyId,con);
                
            }
            Database.SaveResult[]  SaveResultListContract;
            if(!contractList.isEmpty()){
                SaveResultListContract = Database.insert(contractList, false);
                System.debug('SaveResultListContract >>>> '+SaveResultListContract);
                for(integer i =0; i<contractList.size();i++){
                    If(SaveResultListContract[i].isSuccess()){
                        SuccesscontractList.add(contractList.get(i)); 
                    }
                }
            }
            System.debug('SuccesscontractList >>>> '+SuccesscontractList);
            
            for(Contract c :SuccesscontractList){
                Opportunity_Contract_Relationship_GE_OG__c oppcon = new Opportunity_Contract_Relationship_GE_OG__c();
                oppcon.Contract_ID_GE_OG__c = c.Id;
                oppcon.Primary_Opportunity_GE_OG__c = true;
                oppcon.opportunity_ID_ge_og__c = c.Linked_Opportunity_Id__c;
                opconList.add(oppcon);
            }
            Database.insert(opconList);
            Database.update(oppList);
            
        }catch(Exception e){
            System.debug('Exception occured in line number : '+e.getLineNumber());
            System.debug('Exception Message : '+e.getMessage());
            System.debug('Exception cause :'+e.getCause());
        }
    }
   
}