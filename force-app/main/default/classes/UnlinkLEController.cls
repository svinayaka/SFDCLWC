/********
Class Name  : UnlinkLEController
Created Date: 12/09/2016
Author      : Geetha Karmarkar
Purpose     : This contains the functionality to uncheck "Compliance Ready" flag whenever a legal entity is unlinked. 
              Compliance Ready flag will be unchecked in Commercial Hierarchy as follows
              1> If the LE to be unlinked is the only LE in the entire Commercial hierarchy, Compliance Ready flag is unchecked for the
                 entire hierarchy
              2> If it is the only LE for the Country level account, Compliance Ready is unchecked only for that related Country level 
                 account.
              3> If scenario 2 and the corresponding Regional Account does not contain other LE accounts, Compliance Ready is also checked
                 for the Regional Account
********/
global class UnlinkLEController{
    
    webservice static void uncheckCommercialReady(String strAccountId){
        List<Account> lstFinal = new List<Account>();
        List<Account> lstAllCountry = new List<Account>();
        List<Account> lstHQ = new List<Account>();
        List<Account> lstAllRegional = new List<Account>();
        List<Account> lstAccount = [select id,Oil_Gas_Parent_Account__c,Number_of_Child_LEs_GEOG__c from Account where id=: strAccountId LIMIT 1];
        system.debug('Account id '+lstAccount[0].id);
        system.debug('oil gas parent '+lstAccount[0].Oil_Gas_Parent_Account__c);
        List<Account> lstCountry = [select id,parentId,Number_of_Child_LEs_GEOG__c from Account where id =: lstAccount[0].Oil_Gas_Parent_Account__c LIMIT 1];
        List<Account> lstChildren = [select id,parentId,Number_of_Child_LEs_GEOG__c  from Account where Oil_Gas_Parent_Account__c =: lstCountry[0].id AND id !=: strAccountId 
                                     AND Account_Status__c='CC Approved' LIMIT 50000];
        
        Boolean flag = true;
        Boolean flagHQ = true;
        if(lstChildren.isEmpty()){
            lstFinal.addAll(lstCountry);
            List<Account> lstRegional = [select id,parentId,Number_of_Child_LEs_GEOG__c  from Account where id =: lstCountry[0].parentId LIMIT 1];
            if(lstRegional.size() > 0){
                lstAllCountry = [select id,Compliance_Ready__c,parentId,Number_of_Child_LEs_GEOG__c  from Account where parentId =: lstRegional[0].id AND id !=: lstCountry[0].id LIMIT 50000];
            }
            for(Account objAccount: lstAllCountry){
                if(objAccount.Compliance_Ready__c){
                    flag =  false;
                }
            }
            if(flag){
                lstFinal.addAll(lstRegional);
            
            if(lstRegional.size() > 0){
                lstHQ = [select id,parentId,Number_of_Child_LEs_GEOG__c from Account where id =: lstRegional[0].parentId LIMIT 1];
            }
            if(lstHQ.size() > 0){
                lstAllRegional = [select id,Compliance_Ready__c,parentId,Number_of_Child_LEs_GEOG__c   from Account where parentId =: lstHQ[0].id AND id!=: lstRegional[0].id LIMIT 50000];
            }
            for(Account objAccount: lstAllRegional){
                if(objAccount.Compliance_Ready__c){
                    flagHQ =  false;
                }
            } 
            if(flagHQ){
                lstFinal.addAll(lstHQ);
            } 
            //Removed update part
            }
        }
        
        System.debug('lstFinal size'+lstFinal.size());
        System.debug('lstFinal size'+lstFinal);
        if(lstFinal.size() > 0){
                for(Account objAccount: lstFinal){
                    objAccount.Compliance_Ready__c= false;
                    //objAccount.Number_of_Child_LEs_GEOG__c = 0;
                    System.debug('objAccount.Number_of_Child_LEs_GEOG__c val'+objAccount.Number_of_Child_LEs_GEOG__c);
                    if(objAccount.Number_of_Child_LEs_GEOG__c > 0){
                    objAccount.Number_of_Child_LEs_GEOG__c = (objAccount.Number_of_Child_LEs_GEOG__c -1);
                    }
                    else
                    {
                        objAccount.Number_of_Child_LEs_GEOG__c = 0;
                    }
                }
                try{
                    system.debug('final list to update....### '+lstFinal);
                    update lstFinal;
                }
                catch(Exception e){
                    system.debug('Exception while updation... '+e.getMessage());
                }
        }
        return;
    }
}