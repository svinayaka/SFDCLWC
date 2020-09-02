public class GE_OG_AccountTriggerHandlerMethods {

     public void checkForOpportunitiesBeforeUnlink(List<Account> newAccnts, Map<Id, Account> AccountOldMap){   
        String loggedinUser = UserInfo.getName();
        if(loggedinUser == 'Merge User' ){
            return;
        }
     Set<Id> setFlagAccId = new Set<Id>();
     Set<Id> setFlagAccIdForContr = new Set<Id>();
     Set<Id> setParentIds = new Set<Id>();
     Map<Id,Account> mapAccParent = new Map<Id, Account>();
     Id devRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('CMF Approved').getRecordTypeId();
        for(Account acc: newAccnts){
            system.debug('new acc id and parent '+acc.id+' '+acc.Oil_Gas_Parent_Account__c);
            Account oldAcc = AccountOldMap.get(acc.id);
            system.debug('Old parent '+oldAcc.Oil_Gas_Parent_Account__c);
            system.debug('New parent '+acc.Oil_Gas_Parent_Account__c);
            if(((oldAcc.Oil_Gas_Parent_Account__c!= acc.Oil_Gas_Parent_Account__c) && acc.RecordTypeId==devRecordTypeId && acc.Account_Status__c=='CC Approved')){
                setFlagAccId.add(acc.Id);
                if(oldAcc.Oil_Gas_Parent_Account__c!= null){
                    setFlagAccIdForContr.addAll(setFlagAccId);
                }
        
                if(acc.Oil_Gas_Parent_Account__c != null){
                    setParentIds.add(acc.Oil_Gas_Parent_Account__c);
                }
            }         
        }
        
        if(setFlagAccId.isEmpty()==false && setParentIds.isEmpty()==false){
        system.debug('22 '+setFlagAccIdForContr);
        List<Account> parentAccountsList = [select id, Country_GEOG__c, name, Account_Tier_GEOG__c,
                                            Account_Status__c, Member_of_GE_OG__c 
                                            From Account where id in: setParentIds
                                            LIMIT 50000];
        for(Account accChild: newAccnts){
            for(Account accParent: parentAccountsList){
                if(accChild.Oil_Gas_Parent_Account__c== accParent.id){
                    mapAccParent.put(accChild.id, accParent);
                }
            }
        }
        
        for(Account objNew: newAccnts){
                Account oldAcc = AccountOldMap.get(objNew.id);
                if(objNew.Oil_Gas_Parent_Account__c != null){
                    
                    if(oldAcc.ShippingCountry != mapAccParent.get(objNew.id).Country_GEOG__c){
                            objNew.addError('Legal Entity and the Commercial Account should belong to the same country. '+'Legal Entity Country ' +oldAcc.ShippingCountry+'. Commercial Account Country '+mapAccParent.get(objNew.id).Country_GEOG__c);
                            return;
                    }
                }
                system.debug('values..... LE: '+objNew.Member_of_GE_OG__c+' Parent: '+mapAccParent.get(objNew.id).Member_of_GE_OG__c);
                if(oldAcc.Member_of_GE_OG__c == mapAccParent.get(objNew.id).Member_of_GE_OG__c){
                    setFlagAccId.remove(objNew.Id);
                }
            }
        }
                                        
        system.debug('Compliance AccIds::'+ setFlagAccId); 
     
        if(setFlagAccId.isEmpty()==false || setFlagAccIdForContr.isEmpty() == false){
            Map<Id,List<Opportunity>> mapAccOppty = new Map<Id,List<Opportunity>>();
            Map<Id,List<Contract>> mapAccContr = new Map<Id,List<Contract>>();String msgOppty ='';
            String output = '';
            String outputDispositioned = ''; 
            String msgDispositioned = ''; 
            String msgSupportTicket = '';
            String msgContr = '';
            String outputContr = '';
        system.debug('checking the oppty');
        
        List<Account> lstOldAccounts = [select id, Oil_Gas_Parent_Account__r.Name, name, Oil_Gas_Parent_Account__c,Account_Tier_GEOG__c,
                                        Account_Status__c 
                                        From Account where id in:AccountOldMap.keySet()];
        
        List<Account> lstLEAccounts = new List<Account>();
        List<Contract> lstChannelContracts = new List<Contract>();
        List<String> lstStatus = new List<String>();
        String allStatus = Label.Channels_Active_Statuses;
        lstStatus = allStatus.split(',');
        system.debug('status values '+lstStatus);
        List<Id> lstRecTypeIds = new List<Id>();
        Id channelMasterId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Channel Master Agreement').getRecordTypeId();
        Id channelAddnId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Channel Addendum Agreement').getRecordTypeId();
        lstRecTypeIds.add(channelAddnId);
        lstRecTypeIds.add(channelMasterId);
        List<Opportunity> lstFinal = new List<Opportunity>();
        if(setFlagAccId.isEmpty()==false){
            lstFinal =[SELECT id,accountId,StageName,name,opportunity_number_ge_og__c,legal_entity_ge_og__c,end_user_ge_og__c
                                    FROM Opportunity where legal_entity_ge_og__c IN:newAccnts
                                    LIMIT 50000];
        }
        system.debug('contract list 76 '+setFlagAccIdForContr);
        if(setFlagAccIdForContr.isEmpty()==false){
            system.debug('contract list 78 '+setFlagAccIdForContr);
            lstChannelContracts = [SELECT id, name, AccountId, Status,ContractNumber
                                    FROM Contract
                                    WHERE AccountId IN:setFlagAccIdForContr AND Status IN:lstStatus AND RecordTypeId IN:lstRecTypeIds
                                    LIMIT 50000];
            
        }
        if(setFlagAccId.isEmpty() == false){
        mapAccOppty = new Map<Id,List<Opportunity>>();
         for(Opportunity objOppty: lstFinal){
            if(objOppty.legal_entity_ge_og__c!= null){
                if(mapAccOppty.get(objOppty.legal_entity_ge_og__c)!= null){
                    List<Opportunity> lstOppty = mapAccOppty.get(objOppty.legal_entity_ge_og__c);
                    lstOppty.add(objOppty);
                    mapAccOppty.put(objOppty.legal_entity_ge_og__c, lstOppty);
                }
                else{
                    List<Opportunity> lstTemp = new List<Opportunity>();
                    lstTemp.add(objOppty);
                    mapAccOppty.put(objOppty.legal_entity_ge_og__c, lstTemp);
                }
            }
         }
        
        Integer i=1;
         for(Account objAccount: newAccnts){
            if(mapAccOppty.get(objAccount.id) != null){
                for(Opportunity oppty: mapAccOppty.get(objAccount.id)){
                    output += oppty.opportunity_number_ge_og__c; 
                    if(oppty.StageName == 'Closed Won' || oppty.StageName == 'Closed Lost' || oppty.StageName == 'Cancelled') 
                    { 
                    outputDispositioned += oppty.opportunity_number_ge_og__c; 
                    } 
                    if(i < mapAccOppty.get(objAccount.id).size()){
                    if(oppty.StageName == 'Closed Won' || oppty.StageName == 'Closed Lost' || oppty.StageName == 'Cancelled') 
                    { 
                    outputDispositioned += ', '; 
                    } 
                    output += ', '; 
                    } 
                    i++;
                }
                if(outputDispositioned != ''){ 
                    msgDispositioned = 'These opportunities '+outputDispositioned+' are already Dispositioned, and therefore this Legal Entity can not be unlinked.'; 
                    msgSupportTicket = ' Please create Support Ticket https://geog--c.na18.visual.force.com/apex/OG_Support_Tab?sfdc.tabName=01rA0000000JqAQ and ask Commercial Excellence team for assistance.';
                }
                                
                if(mapAccOppty.get(objAccount.id).size() > 0){
                    msgOppty = 'This Legal Entity can not be Added to/ Unlinked from this commercial Account because it is associated with opportunities: '+output+' in the Account Legal Entity/ End User Legal Entity field. \r\nPlease FIRST ensure you are certain you need to Unlink this Legal Entity from its Commercial Account. If you are not Primary Sales for this Commercial Account, you MUST contact the Primary Sales and agree that the Legal entity is incorrectly linked.\r\nYou may then remove the Account Legal Entity from the opportunity and save.\r\n'+ msgDispositioned +msgSupportTicket+'\r\n';
                    //objAccount.addError('This Legal Entity can not be Added to/ Unlinked from this commercial Account because it is associated with opportunities: '+output+' in the Account Legal Entity/ End User Legal Entity field. \r\nPlease FIRST ensure you are certain you need to Unlink this Legal Entity from its Commercial Account. If you are not Primary Sales for this Commercial Account, you MUST contact the Primary Sales and agree that the Legal entity is incorrectly linked.\r\nYou may then remove the Account Legal Entity/ End User Legal Entity from the opportunity and save.\r\n'+ msgDispositioned +msgSupportTicket);
                }
            }
         }
         }//Close here
         if(!setFlagAccIdForContr.isEmpty()){
            mapAccContr = new Map<Id,List<Contract>>();
         for(Contract objContr: lstChannelContracts){
            if(objContr.AccountId!= null){
                if(mapAccContr.get(objContr.AccountId)!= null){
                    List<Contract> lstCont = mapAccContr.get(objContr.AccountId);
                    lstCont.add(objContr);
                    mapAccContr.put(objContr.AccountId, lstCont);
                }
                else{
                    List<Contract> lstTemp = new List<Contract>();
                    lstTemp.add(objContr);
                    mapAccContr.put(objContr.AccountId, lstTemp);
                }
            }
            
         }
        
        Integer i=1;
         for(Account objAccount: newAccnts){
            if(mapAccContr.get(objAccount.id) != null){
                for(Contract contr: mapAccContr.get(objAccount.id)){
                    outputContr += contr.ContractNumber; 
                    if(i < mapAccContr.get(objAccount.id).size()){
                        outputContr += ', '; 
                    } 
                    i++;
                }
                               
                if(mapAccContr.get(objAccount.id).size() > 0){
                    msgContr ='This Legal Entity cannot be Added to/ Unlinked from this commercial Account because it has active Channel Contracts (Contract system IDs: '+outputContr+'). FIRST ensure you are certain you need to Unlink this Legal Entity from its Commercial Account.  If you are not the Sales/Channel Manager listed on the contract(s), you MUST contact the Sales/Channel Manager and agree that the Legal entity is incorrectly linked. The Sales/Channel Manager will need to work with the Channels team to Non-Renew or Terminate the active contracts.\r\n';
                    //objAccount.addError('This Legal Entity can not be Added to/ Unlinked from this commercial Account because it is associated with Channel Contracts: '+output+' in the Account Name field. \r\nPlease FIRST ensure you are certain you need to Unlink this Legal Entity from its Commercial Account. If you are not Primary Sales for this Commercial Account, you MUST contact the Primary Sales and agree that the Legal entity is incorrectly linked.\r\nYou may then remove the Account Name from the Contract and save.\r\n');
                }
            }
         }
        }
        for(Account objAccount: newAccnts){
            if(mapAccContr.get(objAccount.id) != null || mapAccOppty.get(objAccount.id) != null){
                objAccount.addError(msgOppty+'\r\n'+msgContr);
            }
        }
    }
        
    }
    
    public void uncheckComplianceReady(List<Account> newAccnts, Map<Id, Account> AccountOldMap){
    List<Account> lstLEAccounts = new List<Account>();
    Set<Id> setCountryIds = new Set<Id>();
    Set<Id> setRegIds = new Set<Id>();
    Set<Id> setHqIds = new Set<Id>();
    Set<Id> finalCountrylst = new Set<Id>();
    Set<Id> finalRegionlst = new Set<Id>();
    Set<Id> finalHqlst = new Set<Id>();
    List<Account> lstCountryToUncheck = new List<Account>();
    List<Account> lstRegionToUncheck = new List<Account>();
    List<Account> lstHQToUncheck = new List<Account>();
    List<Account> finalListToUpdate = new List<Account>();
    List<Account> lstCountryOthers = new List<Account>();
    List<Account> lstReg  = new List<Account>();
    List<Account> lstHq = new List<Account>();
    List<Account> lstRegOthers = new List<Account>();
    Map<Id,List<Account>> mapCountryOtherLEs = new Map<Id,List<Account>>();
    Map<Id,List<Account>> mapRegionCountries = new Map<Id,List<Account>>();
    Map<Id,List<Account>> mapHqRegions = new Map<Id,List<Account>>();
    
    for(Account objAccount: newAccnts){
        //if(objAccount.Account_Tier_GEOG__c == 'LE' && objAccount.Account_Status__c == 'CC Approved' && (objAccount.Oil_Gas_Parent_Account__c != //AccountOldMap.get(objAccount.id).Oil_Gas_Parent_Account__c)){
        Account oldAcc = AccountOldMap.get(objAccount.id);
        if(objAccount.Account_Tier_GEOG__c == 'LE' && oldAcc.Account_Status__c == 'CC Approved' && (objAccount.Account_Status__c != oldAcc.Account_Status__c || objAccount.Oil_Gas_Parent_Account__c != oldAcc.Oil_Gas_Parent_Account__c)){
            lstLEAccounts.add(objAccount);
        }
    }
    system.debug('list display '+lstLEAccounts);
    if(lstLEAccounts.size()>0){
        for(Account objAccount: lstLEAccounts){
            //Contains parent Account ids of LEs in trigger.new
            setCountryIds.add(AccountOldMap.get(objAccount.id).Oil_Gas_Parent_Account__c);
            system.debug('Country id '+AccountOldMap.get(objAccount.id).Oil_Gas_Parent_Account__c);
        }
        List<Account> lstCountry =  [select id,parentId,Compliance_Ready__c 
                                        from Account 
                                        where id IN: setCountryIds LIMIT 50000];
                                        
        List<Account> lstChildren = [select id,parentId,Oil_Gas_Parent_Account__c,Compliance_Ready__c
                                     from Account where Oil_Gas_Parent_Account__c IN: lstCountry AND id NOT IN: lstLEAccounts 
                                    AND Account_Status__c='CC Approved' LIMIT 50000];
        for(Account accChildren: lstChildren){
            if(mapCountryOtherLEs.get(accChildren.Oil_Gas_Parent_Account__c)!= null){
                mapCountryOtherLEs.get(accChildren.Oil_Gas_Parent_Account__c).add(accChildren);
            }
            else{
                List<Account> lstTemp = new List<Account>();
                lstTemp.add(accChildren);
                mapCountryOtherLEs.put(accChildren.Oil_Gas_Parent_Account__c, lstTemp);
            }
        }
        for(Account acc: lstCountry){
            List<Account> lst = mapCountryOtherLEs.get(acc.Id);
            if(lst == null || lst.isEmpty()){
                lstCountryToUncheck.add(acc);
            }
            
        }
        if(!lstCountryToUncheck.isEmpty()){
            /*lstCountryToUncheck =  [select id,parentId ,Compliance_Ready__c
                                        from Account where id IN: finalCountrylst LIMIT 50000];*/
            for(Account obj: lstCountryToUncheck){
                if(obj.parentId != null){
                    setRegIds.add(obj.parentId);
                }
            }
            if(!setRegIds.isEmpty()){
                lstReg = [select id,parentId,Compliance_Ready__c 
                                        from Account where id IN: setRegIds LIMIT 50000];
            }
            if(!setRegIds.isEmpty() && !lstCountryToUncheck.isEmpty()){
                lstCountryOthers = [select id,parentId,Compliance_Ready__c 
                                        from Account where parentId IN: setRegIds AND Id NOT IN: lstCountryToUncheck
                                        LIMIT 50000];
            }
            for(Account objCountry: lstCountryOthers){
                if(mapRegionCountries.get(objCountry.parentId) != null){
                    mapRegionCountries.get(objCountry.parentId).add(objCountry);
                }
                else{
                    List<Account> lstTemp = new List<Account>();
                    lstTemp.add(objCountry);
                    mapRegionCountries.put(objCountry.parentId, lstTemp);
                }
            }
            for(Account acc: lstReg){
                List<Account> lst = mapRegionCountries.get(acc.Id);
                Boolean flagForRegion = true;
                if(lst != null){
                    for(Account obj: lst){
                        if(obj.Compliance_Ready__c){
                            flagForRegion = false;
                        }
                    }
                }
                if(flagForRegion){
                    lstRegionToUncheck.add(acc);
                }
            }                           
        }
        if(!lstRegionToUncheck.isEmpty()){
            /*lstRegionToUncheck =  [select id,parentId ,Compliance_Ready__c
                                        from Account where id IN: finalRegionlst LIMIT 50000];*/
            for(Account obj: lstRegionToUncheck){
                if(obj.parentId != null){
                    setHqIds.add(obj.parentId);
                }
            }
            
            if(!setHqIds.isEmpty()){
                lstHq = [select id,parentId,Compliance_Ready__c 
                                        from Account where id IN: setHqIds LIMIT 50000];
            }
            
            if(!setHqIds.isEmpty() && !lstRegionToUncheck.isEmpty()){
               lstRegOthers = [select id,parentId,Compliance_Ready__c 
                                        from Account where parentId IN: setHqIds AND Id NOT IN: lstRegionToUncheck
                                        LIMIT 50000]; 
            }
            for(Account objReg: lstRegOthers){
                if(mapHqRegions.get(objReg.parentId) != null){
                    mapHqRegions.get(objReg.parentId).add(objReg);
                }
                else{
                    List<Account> lstTemp = new List<Account>();
                    lstTemp.add(objReg);
                    mapHqRegions.put(objReg.parentId, lstTemp);
                }
            }
            for(Account acc: lstHq){
                List<Account> lst = mapHqRegions.get(acc.Id);
                Boolean flagForHq = true;
                if(lst != null){
                    for(Account obj: lst){
                        if(obj.Compliance_Ready__c){
                            flagForHq = false;
                        }
                    }
                }
                if(flagForHq){
                    lstHQToUncheck.add(acc);
                }
            }                           
        }
        /*if(!finalHqlst.isEmpty()){
            lstHQToUncheck = [select id,parentId ,Compliance_Ready__c
                                        from Account where id IN: finalHqlst LIMIT 50000];
        }*/
        if(!lstCountryToUncheck.isEmpty()){
            finalListToUpdate.addAll(lstCountryToUncheck);
        }
        if(!lstRegionToUncheck.isEmpty()){
                finalListToUpdate.addAll(lstRegionToUncheck);
        }
        if(!lstHQToUncheck.isEmpty()){
                finalListToUpdate.addAll(lstHQToUncheck);
        }   
        if(!finalListToUpdate.isEmpty()){
            for(Account resultAccount: finalListToUpdate){
                resultAccount.Compliance_Ready__c= false;
            }
            try{
                update finalListToUpdate;
            }
            catch(Exception e){
                system.debug('Error while unchecking compliance ready '+e.getMessage());
            }
        }
    }

    }
    
    //Change Commercial level account names If Global Account name and type Changed
    //Rahul's Code....
/*public void NameAndTypeChnage(List<Account> oldAccnts, List<Account> newAccnts, Map<Id, Account> AccountOldMap){
    
    Id devRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
    Set<String> tierSetAll = new Set<String>{'Country','Regional','LE'};
    List<Account> updActLst = new List<Account>();
    Set<Id> globalAccountIdNameChanged = new set<Id>();
    Set<Id> globalAccountIdTypeChanged = new set<Id>();
    Set<Id> globalAccountIdClasifChanged = new set<Id>();
    Set<Id> leAccountIdTypeChanged = new set<Id>();
    Set<Id> leAccountIdClasifChanged = new set<Id>();
    Set<Id> countryAccountIdClasifChanged = new set<Id>();
    Set<Id> globalAccountIdAll = new set<Id>();
    Set<Id> leAccountIdClasifAll = new set<Id>();
    
    Set<Id> hqIds = new Set<Id>();
    List<Account> lstHierarchy = new List<Account>();
    List<Account> lstTemp = new List<Account>();
    List<Account> lstLEs = new List<Account>();
    for(Account act : newAccnts)
    {
        
        String oldValPrece = (AccountOldMap.get(act.id).name).split('/')[0];
        String newValPrece = (act.name).split('/')[0];
        String Oldacttype = AccountOldMap.get(act.id).Type;
        String OldactClasif = AccountOldMap.get(act.id).Classification__c ;
        
        if(Oldacttype != act.Type && act.Type == 'Channel Partner'){
            if(act.Account_Tier_GEOG__c == 'Global'){
                hqIds.add(act.id);
            }
            else{
                if(act.Member_of_GE_OG__c != null){
                    hqIds.add(act.Member_of_GE_OG__c);
                }
                else if(act.Member_of_GE_OG__c == null && act.Account_Tier_GEOG__c == 'Country'){
                    lstTemp.add(act);
                }
            }
        }
        if(lstTemp.size() > 0){
            lstLEs = [select id,name, type
                    FROM Account
                    WHERE Oil_Gas_Parent_Account__c IN: lstTemp
                    LIMIT 50000];
        }
        if(hqIds.size() > 0){
            lstHierarchy = [select id,name, type
                            FROM Account
                            WHERE Member_of_GE_OG__c IN: hqIds OR id IN: hqIds
                            LIMIT 50000];
            if(lstHierarchy.size() > 0){
                for(Account obj: lstHierarchy){
                    obj.type = 'Channel Partner';
                }
                
            }
        }
        if(lstLEs.size() > 0){
            for(Account objToUpdate: lstLEs){
                objToUpdate.type = 'Channel Partner';
            }
            lstHierarchy.addAll(lstLEs);
        }
        
        
        if('Global' == act.Account_Tier_GEOG__c && devRecordTypeId == act.RecordTypeId  && !oldValPrece.equalsIgnoreCase(newValPrece))
        {
            globalAccountIdNameChanged.add(act.Id);
            globalAccountIdAll.add(act.Id);
        }
        if('Global' == act.Account_Tier_GEOG__c && devRecordTypeId == act.RecordTypeId  && Oldacttype != act.Type && act.Type != 'Channel Partner')
        {
            globalAccountIdTypeChanged.add(act.Id);
            globalAccountIdAll.add(act.Id);
        }
        
        //Added - Venkatesh
        if('Global' == act.Account_Tier_GEOG__c && devRecordTypeId == act.RecordTypeId  && OldactClasif != act.Classification__c)
        {
            globalAccountIdClasifChanged.add(act.Id);
            globalAccountIdAll.add(act.Id);
        }
              
        //Changes for Country Account Type change - Pallavi Sharma
        if('Country' == act.Account_Tier_GEOG__c && devRecordTypeId == act.RecordTypeId  && Oldacttype != act.Type && act.Type != 'Channel Partner'){
            leAccountIdTypeChanged.add(act.Id);
            leAccountIdClasifAll.add(act.Id);
        }
        //End Pallavi Sharma
        
        //Changes for Reginal and Country level Account Classification change - venkatesh
        
        if('Regional' == act.Account_Tier_GEOG__c && devRecordTypeId == act.RecordTypeId  && OldactClasif != act.Classification__c){
            
            countryAccountIdClasifChanged.add(act.Id);
        }
        
        if('Country' == act.Account_Tier_GEOG__c && devRecordTypeId == act.RecordTypeId  && OldactClasif != act.Classification__c){
            leAccountIdClasifChanged.add(act.Id);
            leAccountIdClasifAll.add(act.Id);
        }
        
    }
    if(lstHierarchy.size() > 0){ system.debug('####LISTSIZE####'+lstHierarchy.size());
        try{
          update lstHierarchy;
        }
        catch(Exception e){
            system.debug('Exception in updating Accounts to Active '+e.getMessage());
        }
    }
    //If Name or type change on Global Account
    if(globalAccountIdAll.size()>0)
    {
        for(Account cumAct : [select Id,Name,Account_Tier_GEOG__c,RecordTypeId,ParentId,Member_of_GE_OG__c,Member_of_GE_OG__r.name,Member_of_GE_OG__r.Type,Member_of_GE_OG__r.Classification__c from Account where Member_of_GE_OG__c in: globalAccountIdAll and Account_Tier_GEOG__c in : tierSetAll ])
        {
            String oldValPrece = (AccountOldMap.get(cumAct.Member_of_GE_OG__c).name).split('/')[0];
            String newValPrece = (cumAct.Member_of_GE_OG__r.Name).split('/')[0];
            String chldActName = cumAct.Name;
            system.debug('child name after split ...... '+chldActName.split('/')[0]);
            system.debug('child name matches??????? ...... '+chldActName.split('/')[0].equalsIgnoreCase(oldValPrece));
            //if(cumAct.RecordTypeId == devRecordTypeId && chldActName.split('/')[0].equalsIgnoreCase(oldValPrece) && globalAccountIdNameChanged.contains(cumAct.Member_of_GE_OG__c))
            if(cumAct.RecordTypeId == devRecordTypeId && globalAccountIdNameChanged.contains(cumAct.Member_of_GE_OG__c))
            {
                chldActName = newValPrece;
                cumAct.name = chldActName;
            }
            if(globalAccountIdTypeChanged.contains(cumAct.Member_of_GE_OG__c))
            {
                cumAct.Type = cumAct.Member_of_GE_OG__r.Type;  
            }
            
            // Classification changes at Global Level---Venkat Added
            if(globalAccountIdClasifChanged.contains(cumAct.Member_of_GE_OG__c))
            {
                cumAct.Classification__c = cumAct.Member_of_GE_OG__r.Classification__c;  
            }   
    
           
            updActLst.add(cumAct);
        }
        
        
    }
    
    
    // Classification changes at Country and Regional Level---Venkat Added
     if(!countryAccountIdClasifChanged.isEmpty()){
        for(Account childAcc : [SELECT Id, parent.Classification__c FROM Account 
                                WHERE ParentId in: countryAccountIdClasifChanged 
                                AND Account_Tier_GEOG__c in : tierSetAll ])
        {
            childAcc.Classification__c = childAcc.parent.Classification__c;
            updActLst.add(childAcc);
        }
    }
    
    if(leAccountIdClasifAll.size() > 0){
        for(Account childAcc : [SELECT Id, Oil_Gas_Parent_Account__r.Type,Oil_Gas_Parent_Account__r.Classification__c,Type,Classification__c
                                FROM Account 
                                WHERE Oil_Gas_Parent_Account__c in: leAccountIdTypeChanged 
                                AND Account_Tier_GEOG__c in : tierSetAll ]){
            if(leAccountIdClasifChanged.contains(childAcc.Oil_Gas_Parent_Account__c))
            {
                childAcc.Classification__c = childAcc.Oil_Gas_Parent_Account__r.Classification__c; 
            }
            if(leAccountIdTypeChanged.contains(childAcc.Oil_Gas_Parent_Account__c))
            {
                childAcc.Type = childAcc.Oil_Gas_Parent_Account__r.Type;  
            }
            updActLst.add(childAcc);
        }
    }
    
    
    system.debug('==========updActLst==========='+updActLst);
    if(updActLst.size()>0)
    {
        ClsAvoidTriggerRecursion.Var_Static_ManageFinanceDetailTrgr = false;
        for(Account objAcc: updActLst ){
            system.debug('list items@@@@ '+objAcc.id+' '+objAcc.name);
        }
        update updActLst;
        }

    }*/
    
    
    /*This method is to update Team member role on change of Account Owner. 
    The new Owner added will become 'Sales - Primary' and any team member with 'Sales - Primary' role prior will be 'Sales' 
    Created By: Niranjana Venkatesh 
    Requirement Number: R-24714 */
    
    public void UpdateTeamMemberRole(List<Account> oldAccnts, List<Account> newAccnts, Map<Id, Account> AccountOldMap){
    Set<Id> AccIds= new Set<Id>();
    Set<Id> AccOwnerId= new Set<Id>();
        for(Account acc: newAccnts){
            Account oldAcc = AccountOldMap.get(acc.id);
            if(oldAcc.OwnerId!= acc.OwnerId){
                AccIds.add(acc.Id);
                if(acc.OwnerId != Null)
                AccOwnerId.add(acc.OwnerId);
            }         
        }
        if(AccIds.size()>0){
            List<AccountTeamMember> ListAccTeamMember = new List<AccountTeamMember>();
            List<AccountTeamMember> updateTeamMemberRole = new List<AccountTeamMember>();
            List<AccountTeamMember> deleteInactiveTeamMember = new List<AccountTeamMember>();
           /* for(Account acc: newAccnts){
                ListAccTeamMember = [select id,AccountId,UserId,User.isActive,TeamMemberRole from AccountTeamMember where AccountId in :AccIds and UserId<>:acc.OwnerId and TeamMemberRole = 'Sales - Primary'];                  
            }*/
            
             ListAccTeamMember = [select id,AccountId,UserId,User.isActive,TeamMemberRole from AccountTeamMember where AccountId in :AccIds and UserId<>:AccOwnerId and TeamMemberRole = 'Sales - Primary'];                  
            
            system.debug('ListAccTeamMember:: '+ListAccTeamMember );
            
            for(AccountTeamMember act:ListAccTeamMember){
                if(act.User.isActive==false){
                    deleteInactiveTeamMember.add(act);    
                }
                else
                if(act.User.isActive==true){
                    act.TeamMemberRole = 'Sales';
                    updateTeamMemberRole.add(act);
                }
            }
            
            system.debug('deleteInactiveTeamMember:: '+deleteInactiveTeamMember);
            
            if(deleteInactiveTeamMember.isEmpty()==false)
            {
                delete deleteInactiveTeamMember;
            }
            if(updateTeamMemberRole.isEmpty() == false)
            {
                update updateTeamMemberRole;
            }
        } 
    }
    
    public void CheckComplianceReadyFlag(List<Account> oldAccnts, List<Account> newAccnts, Map<Id, Account> AccountOldMap){
        Set<Id> setFlagAccId = new Set<Id>();
        Id cmfRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('CMF Approved').getRecordTypeId();
        for(Account acc: newAccnts){
            Account oldAcc = AccountOldMap.get(acc.id);
            if(((oldAcc.Account_Status__c != acc.Account_Status__c || oldAcc.RecordTypeId!= acc.RecordTypeId || oldAcc.Oil_Gas_Parent_Account__c!= acc.Oil_Gas_Parent_Account__c) && acc.RecordTypeId==cmfRecordTypeId  && acc.Account_Status__c=='CC Approved')){
                setFlagAccId.add(acc.Id);
            }         
        }
     system.debug('Compliance AccIds::'+ setFlagAccId);   
     
        List<Account> lstAccountToUpdate = new List<Account>();
        Set<Id> setAccountId = new Set<Id>();
        if(setFlagAccId.isEmpty()==false){
        // Rollup at country level from LE level

        for(AggregateResult aggresult: [SELECT Oil_Gas_Parent_Account__c, COUNT(Id) cnt FROM Account WHERE ID IN:setFlagAccId AND Account_Tier_GEOG__c = 'LE' AND Account_Status__c = 'CC Approved' GROUP BY Oil_Gas_Parent_Account__c])
        {
            if((Integer)aggresult.get('cnt') != null && (Integer)aggresult.get('cnt') > 0)
            {
                setAccountId.add((Id)aggresult.get('Oil_Gas_Parent_Account__c'));
            }
        }
        system.debug('country level from LE level::'+ setAccountId);
        // Rollup at Regional level from LE level
        for(AggregateResult aggresult:[SELECT Oil_Gas_Parent_Account__r.ParentId parentAccount, COUNT(Id) cnt
                                       FROM Account
                                       WHERE ID IN:setFlagAccId AND Account_Tier_GEOG__c = 'LE' AND Account_Status__c = 'CC Approved'
                                       GROUP BY Oil_Gas_Parent_Account__r.ParentId])
        {
            if((Integer)aggresult.get('cnt') != null && (Integer)aggresult.get('cnt') > 0)
            {
                setAccountId.add((Id)aggresult.get('parentAccount'));
            }
        }
        system.debug('Regional level from LE level::'+ setAccountId);
        // Rollup at Global level from LE level
        for(AggregateResult aggresult:[SELECT Oil_Gas_Parent_Account__r.Parent.ParentId parentAccount, COUNT(Id) cnt
                                       FROM Account
                                       WHERE ID IN:setFlagAccId AND Account_Tier_GEOG__c = 'LE' AND Account_Status__c = 'CC Approved'
                                       GROUP BY Oil_Gas_Parent_Account__r.Parent.ParentId])
        {
            if((Integer)aggresult.get('cnt') != null && (Integer)aggresult.get('cnt') > 0)
           {
                setAccountId.add((Id)aggresult.get('parentAccount'));
            }
        }
        system.debug('Global level from LE level::'+ setAccountId);
        for(Account objAccount:[SELECT Id, Compliance_Ready__c
                                FROM Account
                                WHERE ID IN:setAccountId])
        {
            objAccount.Compliance_Ready__c = true;
            lstAccountToUpdate.add(objAccount);
        }
        system.debug('lstAccountToUpdate LE level::'+ lstAccountToUpdate);
        if(!lstAccountToUpdate.isEmpty())
        {
           try{
               update lstAccountToUpdate;
           }
           catch(DmlException e)
           {
                system.debug('Error while updating: '+e.getMessage());
           }
        }
       }
         
    }
    
    public void CheckGovernmentEntityFlag(List<Account> oldAccnts, List<Account> newAccnts, Map<Id, Account> AccountOldMap){
        Set<Id> setAccId = new Set<Id>();
        Set<Id> setOldParentAccId = new Set<Id>();
        Id relRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
        //List<Account> NewAccountList = [Select id,name,Account_Tier_GEOG__c,RecordTypeId,RecordType.Name,Account_Status__c,Member_of_GE_OG__c,Oil_Gas_Parent_Account__c,GE_HQ_GOVT_FLG2__c from Account where id in: newAccnts];
        for(Account acc: newAccnts){
            Account oldAcc = AccountOldMap.get(acc.id);
            if(((oldAcc.GE_HQ_GOVT_FLG2__c != acc.GE_HQ_GOVT_FLG2__c || oldAcc.Oil_Gas_Parent_Account__c!= acc.Oil_Gas_Parent_Account__c) && acc.RecordTypeId!=relRecordTypeId)){
                setAccId.add(acc.Id);
                if((oldAcc.Oil_Gas_Parent_Account__c!= acc.Oil_Gas_Parent_Account__c) && oldAcc.Oil_Gas_Parent_Account__c!=null ){
                setOldParentAccId.add(oldAcc.Oil_Gas_Parent_Account__c);
                }
            }         
        }
        system.debug('Government flag AccIds::'+ setAccId );
        system.debug('Government flag setOldParentAccId::'+ setOldParentAccId); 
     
        List<Account> lstAccountToUpdate = new List<Account>();
        Set<Id> setAccountId = new Set<Id>();
        Integer LEAccCount = 0;
        Integer OldLEAccCount = 0;
        
        if(setAccId.isEmpty()==false){
      
        List<Account> ChildAccountLst= [Select id,name,RecordTypeId,RecordType.Name,Account_Status__c,Member_of_GE_OG__c,Oil_Gas_Parent_Account__c,GE_HQ_GOVT_FLG2__c,Oil_Gas_Parent_Account__r.GE_HQ_GOVT_FLG2__c from Account where id in: setAccId];       
        
        for(AggregateResult aggresult: [SELECT Oil_Gas_Parent_Account__c, COUNT(Id) cnt FROM Account WHERE ID IN:setAccId GROUP BY Oil_Gas_Parent_Account__c])
        {
            if((Integer)aggresult.get('cnt') != null && (Integer)aggresult.get('cnt') > 0)
            {
                setAccountId.add((Id)aggresult.get('Oil_Gas_Parent_Account__c'));
            }
        }
        
        List<Account> ParentAccountLst= [Select id,name,RecordTypeId,RecordType.Name,Account_Status__c,Member_of_GE_OG__c,Oil_Gas_Parent_Account__c,GE_HQ_GOVT_FLG2__c,Oil_Gas_Parent_Account__r.GE_HQ_GOVT_FLG2__c from Account where id in: setAccountId];
        
        List<Account> OldParentAccountLst =[Select id,name,RecordTypeId,RecordType.Name,Account_Status__c,Member_of_GE_OG__c,Oil_Gas_Parent_Account__c,GE_HQ_GOVT_FLG2__c,Oil_Gas_Parent_Account__r.GE_HQ_GOVT_FLG2__c from Account where id in: setOldParentAccId];
        system.debug('OldParentAccountLst ::'+ OldParentAccountLst); 
        for(Account objAccount:ParentAccountLst)
        {
            for(AggregateResult aggresult: [SELECT Oil_Gas_Parent_Account__c, COUNT(id) cnt FROM Account WHERE Oil_Gas_Parent_Account__c =:ParentAccountLst and GE_HQ_GOVT_FLG2__c=true GROUP BY Oil_Gas_Parent_Account__c])
        {
            if((Integer)aggresult.get('cnt') != null && (Integer)aggresult.get('cnt') > 0)
            {
                 LEAccCount=(Integer)aggresult.get('cnt');
                 system.debug('=============LEAccCount====='+LEAccCount);
            }
        }  
        }
        for(Account objAccount:OldParentAccountLst)
        {
            for(AggregateResult aggresult: [SELECT Oil_Gas_Parent_Account__c, COUNT(id) cnt FROM Account WHERE Oil_Gas_Parent_Account__c =:OldParentAccountLst and GE_HQ_GOVT_FLG2__c=true GROUP BY Oil_Gas_Parent_Account__c])
        {
            if((Integer)aggresult.get('cnt') != null && (Integer)aggresult.get('cnt') > 0)
            {
                 OldLEAccCount=(Integer)aggresult.get('cnt');
                 system.debug('=============LEAccCount====='+OldLEAccCount);
            }
        }      
            if(OldLEAccCount==0){
                objAccount.GE_HQ_GOVT_FLG2__c=false;
                lstAccountToUpdate.add(objAccount);
                system.debug('=============lstAccountToUpdate11111111====='+lstAccountToUpdate);       
            }
            
        }
        
        
        for(Account objAccount:ParentAccountLst)
        { 
            for(Account chdAcc: ChildAccountLst )
                {
                 if(chdAcc.Oil_Gas_Parent_Account__c!=null){
                  if(chdAcc.Oil_Gas_Parent_Account__c== objAccount.id)
                  {
            
                      if(chdAcc.GE_HQ_GOVT_FLG2__c==true && objAccount.GE_HQ_GOVT_FLG2__c == false)
                        {
                        objAccount.GE_HQ_GOVT_FLG2__c = true;
                        lstAccountToUpdate.add(objAccount);
                        } 
                      else if(LEAccCount==0 && chdAcc.GE_HQ_GOVT_FLG2__c==false && objAccount.GE_HQ_GOVT_FLG2__c == true) 
                        {
                        objAccount.GE_HQ_GOVT_FLG2__c = false;
                        lstAccountToUpdate.add(objAccount);
                        }                       
                   }
                  }
                  else
                  {
                      if(LEAccCount==0 && chdAcc.GE_HQ_GOVT_FLG2__c==false && objAccount.GE_HQ_GOVT_FLG2__c == true) 
                        {
                        objAccount.GE_HQ_GOVT_FLG2__c = false;
                        lstAccountToUpdate.add(objAccount);
                        }                       
                      
                      
                  } 
                  
                  
            }
        }
        // update
        system.debug('===========lstAccountToUpdate======'+lstAccountToUpdate);
        
        if(!lstAccountToUpdate.isEmpty())
        {
           try{
               update lstAccountToUpdate;
           }
           catch(DmlException e)
           {
                
                system.debug('Error while updating: '+e.getMessage());

           }
        }
        
       }  
    }
    
    public void AccountStrengthAndNameChangeCompliaceReady(Map<Id, Account> AccountOldMap, List<Account> newAccnts){
    Set<Id> setAccIdre = new Set<Id>();
    List<Account> lstNewAccs = new List<Account>();
    Set<Id> setUserIDs = new Set<Id>();
    Set<Account> UpdateAccntsList= new Set<Account>();
    Map<Id,Integer> mapAccountId_CountAccountTeamMember = new Map<Id,Integer>();
    Id RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();

        for(Account accnt: newAccnts){
        //Logic to set Compliance Ready as "False" if "Finance Lock" or "Compliance Lock" on the Account is set to "true"
              if(accnt.Finance_Lock_GEOG__c == True || accnt.Compliance_Lock_GEOG__c == True){
                accnt.Compliance_Ready__c = False;
            }
            
            /*Logic to Append Country/ Region/ HQ starts*/
            if(!(accnt.name.contains('/HQ')) && !(accnt.name.contains('/ HQ')) && accnt.Account_Tier_GEOG__c == 'Global' && !(accnt.Type == 'Competitor')){
                accnt.name = accnt.name+' / HQ';
            }
            if(!(accnt.name.contains('/'+ accnt.Region_GEOG__c)) && !(accnt.name.contains('/ '+ accnt.Region_GEOG__c)) && accnt.Account_Tier_GEOG__c == 'Regional' && !(accnt.Type == 'Competitor')){
                accnt.name = accnt.name.split('/')[0]+' / '+accnt.Region_GEOG__c;
                
            } 
            if(!(accnt.name.contains('/'+ accnt.Country_GEOG__c)) && !(accnt.name.contains('/ '+ accnt.Country_GEOG__c)) && accnt.Account_Tier_GEOG__c == 'Country' && !(accnt.Type == 'Competitor')){
                accnt.name = accnt.name.split('/')[0]+' / '+accnt.Country_GEOG__c;
            }
            /*Logic to Append Country/ Region/ HQ ends*/
            
            if(Trigger.isUpdate){
                Account oldAcc= AccountOldMap.get(accnt.id);
                if(oldAcc.OwnerId != accnt.OwnerId){
                    accnt.Previous_Owner__c = oldAcc.OwnerId;
                }
                if((oldAcc.OwnerId != accnt.OwnerId || ((oldAcc.GE_ES_Primary_Industry__c == null && accnt.GE_ES_Primary_Industry__c != null) || (oldAcc.GE_ES_Primary_Industry__c != null && accnt.GE_ES_Primary_Industry__c == null)) || oldAcc.Compliance_Ready__c!= accnt.Compliance_Ready__c || (oldAcc.Team_MeMber_Added__c != accnt.Team_MeMber_Added__c)) && accnt.RecordTypeId==RecordTypeId){
                    setAccIdre.add(accnt.id);
                    lstNewAccs.add(accnt);
                }
            }
            else if(Trigger.isInsert){
                for(Account obj: newAccnts){
                    setAccIdre.add(obj.Id);
                    lstNewAccs.add(accnt);
                }
            }
        }
           
           if(!lstNewAccs.isEmpty()){
                for(Account obj: lstNewAccs){
                    setUserIDs.add(obj.OwnerId);
                }
                Map<id,User> newUserMap = new Map<id,User>([Select id,name from User where ID IN: setUserIDs Limit 50000]);
                system.debug('account id is '+setAccIdre);
                List<AccountContactRelation> getContactList = [Select id, GE_OG_Primary_Contact__c,IsDirect,ContactID,AccountID from AccountContactRelation where AccountId IN: setAccIdre and GE_OG_Primary_Contact__c = true limit 50000];
                Map<Id,AccountContactRelation> mapAccAndAccConRel = new Map<Id,AccountContactRelation>();
                for(AccountContactRelation objAccConRel: getContactList){
                    mapAccAndAccConRel.put(objAccConRel.AccountId, objAccConRel);
                }
                for(AggregateResult aggResult:[SELECT COUNT(Id) cnt,AccountId
                                       FROM AccountTeamMember
                                       WHERE AccountId IN: setAccIdre
                                       GROUP BY AccountId limit 50000])
                {
                    if((Id)aggresult.get('AccountId') != null)
                    {
                        mapAccountId_CountAccountTeamMember.put((Id)aggresult.get('AccountId'),(Integer)aggresult.get('cnt'));
                    }
                }
                Map<String,Acc_Invalid_Sales_Primary_User__c> AccOwnerName = Acc_Invalid_Sales_Primary_User__c.getall();
                Map<id,boolean> InvlaidUserMap= new Map<id,boolean>();
                for(Account acc : lstNewAccs){
                    String strOwnerName = newUserMap.get(acc.ownerId).name;
                    if(AccOwnerName.get(strOwnerName) != null){
                        InvlaidUserMap.put(acc.Id, true);
                    }
                }
                for(Account accntObj : lstNewAccs){
                    Account oldAcc= AccountOldMap.get(accntObj.id);
                    /*if((oldAcc.OwnerId!= accntObj.OwnerId) && (InvlaidUserMap.get(accntObj.id)== null)){
                        accntObj.Team_MeMber_Added__c = true;
                    }*/
                    if(InvlaidUserMap.get(accntObj.Id) ==true || (accntObj.Type== null || accntObj.Classification__c==null)){      
                        accntObj.Strength__c= 'Low'; 
                        if(InvlaidUserMap.get(accntObj.Id) ==true){
                            accntObj.Team_MeMber_Added__c = false;
                        }
                    }    
                    else if(accntObj.Type!= null && accntObj.Classification__c!=null){
                        accntObj.Strength__c= 'Low';
                            
                            if(accntObj.GE_ES_Primary_Industry__c != null && mapAccAndAccConRel.get(accntObj.Id) != null)
                            {   
                                 accntObj.Strength__c= 'Medium';
                                 
                                 if(accntObj.Compliance_Ready__c == True && mapAccountId_CountAccountTeamMember.containskey(accntObj.Id) && mapAccountId_CountAccountTeamMember.get(accntObj.Id) != null && mapAccountId_CountAccountTeamMember.get(accntObj.Id) > = 1)
                                    
                                 {
                                     accntObj.Strength__c= 'High';
                                 }
                            } 
                    }

                }
        }
    //closing bracket removed here.
}

    @InvocableMethod
    public static void redFlagReasonTransformationLogic (List<Account> accNewList)
    {   
        
        Map<String,String> transformationMap = new Map<String,String>();
        List<GE_MDM_AccountFieldTransformation__c> transformationInfoList = GE_MDM_AccountFieldTransformation__c.getAll().values();
        List<String> existingFlagReasons ;
        List<String> newFlagReasons = new List<String>();
        List<Id> accIdList = new List<Id>();
        List<Account> updateList = new List<Account>();
        
        for(Account acc : accNewList)
        {
            accIdList.add(acc.Id);
        }
        
        for(GE_MDM_AccountFieldTransformation__c trans : transformationInfoList)
        {
            transformationMap.put(trans.Reason_Code__c, trans.Reason_Name__c);
        }
        
        for(Account acc :[Select Id,Watchlist_Flag_Reason__c From Account Where Id IN : accIdList ] )
        {
            if(!String.isBlank(acc.Watchlist_Flag_Reason__c))
            {
                //acc.Watchlist_Flag_Reason__c = transformationMap.get(acc.Watchlist_Flag_Reason__c);
                
                existingFlagReasons = acc.Watchlist_Flag_Reason__c.split(';');
                
                for( Integer i = 0; i < existingFlagReasons.size(); i++)
                {
                    if(transformationMap.containsKey(existingFlagReasons[i]))
                    {
                            newFlagReasons.add(transformationMap.get(existingFlagReasons[i]));
                    }
                }
                
                acc.Watchlist_Flag_Reason__c = String.join(newFlagReasons,';');
                
            }
            updateList.add(acc);
        }
            
        update updateList;
    }

}