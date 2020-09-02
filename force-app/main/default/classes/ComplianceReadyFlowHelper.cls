public class ComplianceReadyFlowHelper{
    public static void checkComplianceOnMergeCreate(id accountId, String accountTier){
        List<Account> lstCountry = new List<Account>();
        List<Account> lstRegion = new List<Account>();
        List<Account> lstHQ = new List<Account>();
        List<Account> lstFinal = new List<Account>();
        String strRegion = '';
        
        if(accountTier == 'Country' || accountTier == 'Regional'){
            if(accountTier == 'Country'){
                lstCountry = [select id, name, Compliance_Ready__c, parentId
                            FROM Account
                            WHERE id =: accountId];
                if(!lstCountry.isEmpty()){
                    lstRegion = [select id, name, Compliance_Ready__c, parentId
                                FROM Account
                                WHERE id =: lstCountry[0].parentId];
                    if(!lstRegion.isEmpty()){
                        strRegion = lstRegion[0].id;
                        lstFinal.add(lstRegion[0]);
                    }
                }
            }
            
            if(accountTier == 'Regional'){
                lstRegion = [select id, name, Compliance_Ready__c, parentId
                            FROM Account
                            WHERE id =: accountId];
            }
                
                if(!lstRegion.isEmpty()){
                    lstHQ = [select id, name, Compliance_Ready__c, parentId
                            FROM Account
                            WHERE id =: lstRegion[0].parentId];
                    if(!lstHQ.isEmpty()){
                        lstFinal.add(lstHQ[0]);
                    }
                }
            
        }
        if(!lstFinal.isEmpty()){
            for(Account objAccount: lstFinal){
                if(objAccount.Compliance_Ready__c != true){
                    objAccount.Compliance_Ready__c = true;
                }
            }
            try{
                update lstFinal;
                for(Account acc: lstFinal){
                system.debug('list contents..... '+acc.name+'  '+acc.Compliance_Ready__c);
                }
            }
            catch(Exception e){
                system.debug('Error while updating compliance ready '+e.getMessage());
            }
        }
    }
    
    
}