public class Accounts_ContactsReparentHandler{
    public static List<SObject> reparentContacts(List<Contact> lstContacts, Account objNewParent){
        List<SObject> lstReturn = new List<Sobject>();
        for(Contact objContact: lstContacts){
            if(objContact.GE_OG_Site_LegalEntity_Account__c != null){
                if(objContact.Account.Account_Tier_GEOG__c == 'Country'){
                    objContact.AccountId = objNewParent.Id;
                }
                if(objContact.Account.Account_Tier_GEOG__c == 'Global'){
                    if(objNewParent.Member_of_GE_OG__c != null){
                        objContact.AccountId = objNewParent.Member_of_GE_OG__c;
                    }
                    else{
                        objContact.AccountId = objNewParent.Id;
                    }
                }
                if(objContact.Account.Account_Tier_GEOG__c == 'Regional'){
                    if(objNewParent.ParentId != null){
                        objContact.AccountId = objNewParent.ParentId;
                    }
                    else{
                        objContact.AccountId = objNewParent.Id;
                    }
                }
                
            }
        }
        lstReturn.addAll(lstContacts);
        return lstReturn;
    }
    
    public static List<SObject> reparentDM_Contracts(List<Contract> lstDmContracts, Account objNewParent){
        List<SObject> lstReturn = new List<Sobject>();
        for(Contract objContract: lstDmContracts){
            if(objContract.Commercial_Account_Name_GEOG__r.Account_Tier_GEOG__c == 'Country'){
                objContract.Commercial_Account_Name_GEOG__c = objNewParent.Id;
            }
            if(objContract.Commercial_Account_Name_GEOG__r.Account_Tier_GEOG__c == 'Regional'){
                objContract.Commercial_Account_Name_GEOG__c = objNewParent.ParentId;  
            }
            if(objContract.Commercial_Account_Name_GEOG__r.Account_Tier_GEOG__c == 'Global'){
                objContract.Commercial_Account_Name_GEOG__c = objNewParent.Member_of_GE_OG__c;
            }
        }
        lstReturn.addAll(lstDmContracts);
        return lstReturn;
    }
    
    public static List<SObject> reparentExe_Contracts(List<Contract> lstExeContracts, Account objNewParent){
        List<SObject> lstReturn = new List<Sobject>();
        for(Contract objContract: lstExeContracts){
            if(objContract.Commercial_Account_Name_GEOG__r.Account_Tier_GEOG__c == 'Country'){
                objContract.Commercial_Account_Name_GEOG__c = objNewParent.Id;
            }
            if(objContract.Commercial_Account_Name_GEOG__r.Account_Tier_GEOG__c == 'Regional'){
                objContract.Commercial_Account_Name_GEOG__c = objNewParent.ParentId;  
            }
            if(objContract.Commercial_Account_Name_GEOG__r.Account_Tier_GEOG__c == 'Global'){
                objContract.Commercial_Account_Name_GEOG__c = objNewParent.Member_of_GE_OG__c;
            }
        }
        lstReturn.addAll(lstExeContracts);
        return lstReturn;
    }
    
    public static List<SObject> reparentFrameAgr_Contracts(List<Contract> lstFAContracts, Account objNewParent){
        List<SObject> lstReturn = new List<Sobject>();
        for(Contract objContract: lstFAContracts){
            objContract.GE_PRM_Commercial_Account__c = objNewParent.Id;
            objContract.GE_Commercial_Member_Of_GE_OG__c = objNewParent.Member_of_GE_OG__c;
        }
        lstReturn.addAll(lstFAContracts);
        return lstReturn;
    }
}