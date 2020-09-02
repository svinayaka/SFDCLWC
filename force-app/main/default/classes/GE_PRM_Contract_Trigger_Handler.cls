Public Class GE_PRM_Contract_Trigger_Handler
{   
    //Public boolean isRunFromBatch = false;
   // set<id> setAcId = new set<id>();
   /* Public void update_acc_hier(List<Contract> triggernew,map<id,contract> oldmap)
    {
        Id devRecordTypeId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Channel Addendum Agreement').getRecordTypeId();
        if(isRunFromBatch==false){
            for(contract c : triggernew)
            {
                if(c.RecordtypeId == devRecordTypeId && c.status != oldmap.get(c.id).status){
                    if(c.GE_Commercial_Member_Of_GE_OG__c != null){
                        setAcId.add(c.GE_Commercial_Member_Of_GE_OG__c );
                    }
                    else if(c.GE_PRM_Commercial_Account__c != null){
                        setAcId.add(c.GE_PRM_Commercial_Account__c );
                    }
                }
            }
        }
        else
        {
            for(contract c : triggernew)
            {
                if(c.RecordtypeId == devRecordTypeId){
                    if(c.GE_Commercial_Member_Of_GE_OG__c != null){
                        setAcId.add(c.GE_Commercial_Member_Of_GE_OG__c );
                    }
                    else if(c.GE_PRM_Commercial_Account__c != null){
                        setAcId.add(c.GE_PRM_Commercial_Account__c );
                    }
                }
            }
        }
        system.debug('setAcId=='+setAcId);
        if(setAcId.size()>0)
            UpdateAccHierarchy(setAcId);
 
        
    }  
    public void update_acc_hier_OnDelete(list<contract> lstContract)
    {
        set<id> setAcId = new set<id>();
        for(contract objContr : lstContract)
        {
            if(objContr.GE_PRM_Commercial_Account__c != null)
                setAcId.add(objContr.GE_PRM_Commercial_Account__c );
        }
        if(setAcId.size()>0)
            UpdateAccHierarchy(setAcId);
    }  
    public void UpdateAccHierarchy(set<id> setAccId)
    {   
        Id devRecordTypeId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Channel Addendum Agreement').getRecordTypeId();
        list<Account> lstAcToUpdate = new list<Account>();
        if(setAccId.size()>0)
        {
            Map<Id, Contract> mapContract = new Map<Id, Contract>();
            List<Contract> lstContract = new List<Contract>([select id, GE_PRM_Commercial_Account__c, GE_Commercial_Member_Of_GE_OG__c from Contract where (status = 'Executed' OR status='Under NR/T' OR status='Under Renewal') and (GE_Commercial_Member_Of_GE_OG__c  in : setAccId or GE_PRM_Commercial_Account__c  in : setAccId) and RecordTypeId =:devRecordTypeId]);
             system.debug('lstContract============'+lstContract);
            system.debug('setAccId============'+setAccId);
            Map<Id, Account> mapAccounts = new Map<Id, Account>([Select Id, Type from Account where Id in : setAccId and (Account_Tier_GEOG__c = 'Global' OR Account_Tier_GEOG__c = 'Country')]);
            system.debug('mapAccounts============'+mapAccounts);
            for(Contract con : lstContract){
                if(con.GE_Commercial_Member_Of_GE_OG__c !=null)
                    mapContract.put(con.GE_Commercial_Member_Of_GE_OG__c, con);
                else if(con.GE_PRM_Commercial_Account__c !=null)
                    mapContract.put(con.GE_PRM_Commercial_Account__c, con);
            }   
           
            System.debug('==========objAc ============'+mapContract);
            
            for(Id accId : setAccId)
            {
                Account objacc;
                if(mapAccounts.get(accId)!=null)
                {   
                    objacc = mapAccounts.get(accId);
                    system.debug('===========objacc====='+objacc);
                }
                if(mapContract.get(accId)!=null){
                   objacc.type ='Channel Partner' ;
                }   
                else if(objacc.Type == 'Channel Partner')
                {   
                     //objacc.type ='Direct Customer' ;
                } 
                
                lstAcToUpdate.add(objacc);
            }
            
            system.debug('lstAcToUpdate===='+lstAcToUpdate);
            if(lstAcToUpdate.size()>0)
                update lstAcToUpdate;
        }
    
    }
    
    public void activeInactiveOnTerminate(List<Contract> lstNewContracts, Map<id,Contract> mapOldContracts){
        Set<Id> setCommIds = new Set<Id>();
        Set<Id> setHqs = new Set<Id>();
        Set<Id> setSelectedHqs = new Set<Id>();
        
        Set<Id> setCoomIdsForInactive = new Set<Id>();
        Set<Id> setHqsForInactive = new Set<Id>();
        Set<Id> setSelectedHqsForInactive = new Set<Id>();
        List<Account> lstSelectedAccounts = new List<Account>();
        List<Contract> lstExecutedContracts = new List<Contract>();
        List<Contract> otherExecutedContracts = new List<Contract>();
        List<Account> lstSelectedAccountsInactive = new List<Account>();
        Map<Id,Id> mapCommercialIdHQAccount = new Map<Id,Id>();
        Map<Id,Id> mapCommercialIdHQAccountForInactive = new Map<Id,Id>();
        
        
        List<Account> lstTempForActive = new List<Account>();
        List<Account> lstTempForActiveInacitve = new List<Account>();
        
        for(Contract newContract: lstNewContracts){
        
            if(newContract.status != mapOldContracts.get(newContract.id).status && (newContract.status ==  'Executed' || newContract.status ==  'Under Renewal' || newContract.status ==  'Under NR/T') && (mapOldContracts.get(newContract.id).status != 'Executed' && mapOldContracts.get(newContract.id).status != 'Under NR/T' && mapOldContracts.get(newContract.id).status != 'Under Renewal')){
                if(newContract.GE_PRM_Commercial_Account__c != null){
                    setCommIds.add(newContract.GE_PRM_Commercial_Account__c);
                }
            }
            else if(newContract.status != mapOldContracts.get(newContract.id).status && (newContract.status !=  'Executed' && newContract.status !=  'Under Renewal' && newContract.status !=  'Under NR/T') && (mapOldContracts.get(newContract.id).status == 'Executed' || mapOldContracts.get(newContract.id).status == 'Under NR/T' || mapOldContracts.get(newContract.id).status == 'Under Renewal')){
                if(newContract.GE_PRM_Commercial_Account__c != null){
                    setCoomIdsForInactive.add(newContract.GE_PRM_Commercial_Account__c);
                }
            }
        }
        if(setCommIds.size() > 0){
            List<Account> lstCommercials = [select id, name, Member_of_GE_OG__c,Account_status__c 
                                            FROM Account
                                            WHERE id IN:setCommIds];
            for(Account objCommercial: lstCommercials){
                if(objCommercial.Member_of_GE_OG__c != null){
                    setHqs.add(objCommercial.Member_of_GE_OG__c);
                }
                else{
                    lstTempForActive.add(objCommercial);
                }
            }
            if(setHqs.size() > 0){
                List<Account>lstAllRelationshipAccounts = [select id,Account_status__c,Member_of_GE_OG__c from Account where Member_of_GE_OG__c IN:setHqs 
                                                         AND RecordType.Name = 'Relationship Account'
                                                         LIMIT 50000];
                for(Account obj: lstAllRelationshipAccounts){
                    if(mapCommercialIdHQAccount.containsKey(obj.id)){
                        Id hq = obj.Member_of_GE_OG__c;
                    }
                    else{
                        Id hq = null;
                        hq = obj.Member_of_GE_OG__c;
                        mapCommercialIdHQAccount.put(obj.Id,hq);
                
                    }
                }
            }
        }
        if(setCoomIdsForInactive.size() > 0){
            List<Account> lstCommercialsForInactive = [select id, name, Member_of_GE_OG__c,Account_status__c, ParentId
                                                                    FROM Account
                                                                    WHERE id IN:setCoomIdsForInactive];
            
            for(Account objCommercialForInactive: lstCommercialsForInactive){
                if(objCommercialForInactive.Member_of_GE_OG__c != null){
                    setHqsForInactive.add(objCommercialForInactive.Member_of_GE_OG__c);
                }
                else{
                    lstTempForActiveInacitve.add(objCommercialForInactive);
                }
            }
            if(setHqsForInactive.size() > 0){
                List<Account>lstAllRelationshipAccounts = [select id,Account_status__c,Member_of_GE_OG__c from Account where Member_of_GE_OG__c IN:setHqsForInactive AND RecordType.Name = 'Relationship Account' LIMIT 50000];
                lstExecutedContracts = [SELECT id,status
                                FROM Contract
                                WHERE GE_PRM_Commercial_Account__c IN: lstAllRelationshipAccounts AND (status = 'Executed' OR status = 'Under Renewal' OR status = 'Under NR/T')
                                AND RecordType.Name = 'Channel Addendum Agreement'
                                LIMIT 50000];
                if(lstExecutedContracts.isEmpty()){
                    for(Account obj: lstAllRelationshipAccounts){
                        if(mapCommercialIdHQAccountForInactive.containsKey(obj.id)){
                            Id hq = obj.Member_of_GE_OG__c;
                        }
                        else{
                            Id hq = null;
                            hq = obj.Member_of_GE_OG__c;
                            mapCommercialIdHQAccountForInactive.put(obj.Id,hq);
                    
                        }
                    }
                }
            }
         
            
        }
        for(Contract newContract: lstNewContracts){
        
            if(newContract.status != mapOldContracts.get(newContract.id).status && (newContract.status ==  'Executed' || newContract.status ==  'Under Renewal' || newContract.status ==  'Under NR/T') && (mapOldContracts.get(newContract.id).status != 'Executed' && mapOldContracts.get(newContract.id).status != 'Under NR/T' && mapOldContracts.get(newContract.id).status != 'Under Renewal')){
                if(mapCommercialIdHQAccount.get(newContract.GE_PRM_Commercial_Account__c) != null){
                    Id hqId = mapCommercialIdHQAccount.get(newContract.GE_PRM_Commercial_Account__c);
                    setSelectedHqs.add(hqId);
                }
            }
            else if(newContract.status != mapOldContracts.get(newContract.id).status && (newContract.status !=  'Executed' && newContract.status !=  'Under Renewal' && newContract.status !=  'Under NR/T') && (mapOldContracts.get(newContract.id).status == 'Executed' || mapOldContracts.get(newContract.id).status == 'Under NR/T' || mapOldContracts.get(newContract.id).status == 'Under Renewal')){
                if(lstExecutedContracts.isEmpty()){
                    if(mapCommercialIdHQAccountForInactive.get(newContract.GE_PRM_Commercial_Account__c) != null){
                        Id hqIdInactive = mapCommercialIdHQAccountForInactive.get(newContract.GE_PRM_Commercial_Account__c);
                        setSelectedHqsForInactive.add(hqIdInactive);
                    }
                }
            }
        }
        if(setSelectedHqs.size() > 0){
            lstSelectedAccounts = [select id, Account_Status__c
                                    FROM Account
                                    WHERE (Member_of_GE_OG__c IN: setSelectedHqs OR id IN:setSelectedHqs) AND Recordtype.Name = 'Relationship Account'
                                    LIMIT 50000];
            if(lstSelectedAccounts.size() > 0){
                for(Account objToUpdate: lstSelectedAccounts){
                    objToUpdate.Account_Status__c = 'Active';
                    objToUpdate.Active_Channel_Partner__c = TRUE;
                }
                
            }
        }
        if(lstTempForActive.size() > 0){
            for(Account objToUpdate: lstTempForActive){
                objToUpdate.Account_Status__c = 'Active';
                objToUpdate.Active_Channel_Partner__c = TRUE;
            }
            lstSelectedAccounts.addAll(lstTempForActive);
        }
        if(lstSelectedAccounts.size() > 0){
            try{
                update lstSelectedAccounts;
            }
            catch(Exception e){
                system.debug('Exception in updating Accounts to Active '+e.getMessage());
            }
        }
        
        if(setSelectedHqsForInactive.size() > 0){
            lstSelectedAccountsInactive = [select id, Account_Status__c
                                    FROM Account
                                    WHERE (Member_of_GE_OG__c IN: setSelectedHqsForInactive OR id IN: setSelectedHqsForInactive) AND Recordtype.Name = 'Relationship Account'
                                    LIMIT 50000];
            if(lstSelectedAccountsInactive.size() > 0){
                for(Account objToUpdate: lstSelectedAccountsInactive){
                    objToUpdate.Active_Channel_Partner__c = FALSE;
                }
                
            }
        }
        if(lstTempForActiveInacitve.size() > 0){
            
            otherExecutedContracts = [SELECT id,status
                                FROM Contract
                                WHERE GE_PRM_Commercial_Account__c IN: lstTempForActiveInacitve AND (status = 'Executed' OR status = 'Under Renewal' OR status = 'Under NR/T')
                                AND RecordType.Name = 'Channel Addendum Agreement'
                                LIMIT 50000];
            if(otherExecutedContracts.isEmpty()){
                for(Account objToUpdate: lstTempForActiveInacitve){
                objToUpdate.Active_Channel_Partner__c = FALSE;
            }
            }                   
            
            lstSelectedAccountsInactive.addAll(lstTempForActiveInacitve);
        }
        if(lstSelectedAccountsInactive.size() > 0){
            try{
                update lstSelectedAccountsInactive;
            }
            catch(Exception e){
                system.debug('Exception in updating Accounts to Inactive '+e.getMessage());
            }
        }
        
    } */

    public static void handlePRMExecutedContracts(List<Contract> conlist,List<Id> accList)
    {
        List<Account> accountList = new List<Account>();
        for(Account acc : [Select Id,Type,Active_Channel_Partner__c From Account Where Id IN : accList AND Classification__c != 'Strategic' AND Classification__c != 'Key Account'])
        {
            acc.Type = 'Channel Partner';
            acc.Active_Channel_Partner__c = true;
            acc.Classification__c = 'Unclassified'; 
            accountList.add(acc);
        }
        
        update accountList;
        
    }   
    public static void handlePRMArchivedContracts(Map<Id,Contract> memberOfContractMap,Map<Id,Contract> leContractMap )
    {
        List<Id> accountIdList = new List<Id>();
        List<Account> accountUpdateList = new List<Account>();
        List<Id> commAccList = new List<Id>();
        String prmAddendumId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('PRM Addendum').getRecordTypeId();
        List<Contract> existingContracts = new List<Contract>();

        
        for(Contract con : [Select Id, RecordType.Name, AccountId, Status From Contract Where AccountId IN : leContractMap.keySet() AND (Status = 'Executed' OR Status = 'Under Modification' OR Status = 'Under Renewal' OR Status = 'Under NR/T')AND RecordTypeId =: prmAddendumId])
        {
            leContractMap.remove(con.AccountId);
        }
        
        
        for(Contract con : [Select Id, RecordType.Name,GE_Commercial_Member_Of_GE_OG__c,GE_PRM_Commercial_Account__c,Status From Contract Where GE_Commercial_Member_Of_GE_OG__c IN:memberOfContractMap.keySet() AND (Status = 'Executed' OR Status = 'Under Modification' OR Status = 'Under Renewal' OR Status = 'Under NR/T') AND RecordTypeId =: prmAddendumId])
        {
            if(con.GE_Commercial_Member_Of_GE_OG__c != null)
            {
                memberOfContractMap.remove(con.GE_Commercial_Member_Of_GE_OG__c);
            }
            
            
            
        }
        
        if(!leContractMap.isEmpty())
        {
            for(Account acc : [Select Id,GE_HQ_Channel_Representative__c,Oil_Gas_Parent_Account__c From Account Where Id IN: leContractMap.keySet()])
            {
                acc.GE_HQ_Channel_Representative__c = 'No';
                //acc.Oil_Gas_Parent_Account__r.Active_Channel_Partner__c = false;
                commAccList.add(acc.Oil_Gas_Parent_Account__c);
                accountUpdateList.add(acc);
            }
        }
        
        if(!commAccList.isEmpty())
        {
             for(Account acc : [Select Id,Type,Active_Channel_Partner__c From Account Where Id IN : commAccList AND (Classification__c != 'Strategic' OR Classification__c != 'Key Account')])
            {
                //acc.Type = 'Channel Partner';
                acc.Active_Channel_Partner__c = false;
                    
                accountUpdateList.add(acc);
            }
        }
        
        if(!memberOfContractMap.isEmpty())
        {
            for(Account acc : [Select Id,Type,Active_Channel_Partner__c From Account Where Id IN : memberOfContractMap.keySet() AND (Classification__c != 'Strategic' OR Classification__c != 'Key Account')])
            {
                //acc.Type = 'Channel Partner';
                acc.Active_Channel_Partner__c = false;
                    
                accountUpdateList.add(acc);
            }
        }
        if(!accountUpdateList.isEmpty())
        {
            update accountUpdateList;
        }
        
    }

     public static void  handlePRMCancelledContracts(List<Contract> conlist)
    {
        String prmAddendumId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('PRM Addendum').getRecordTypeId(); 
        String prmAmmendId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('PRM Amendment').getRecordTypeId();     
        String prmMasterId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('PRM Master Agreement').getRecordTypeId();
        Map<Id,Contract> mastercancelled = new Map<Id,Contract>();
        Map<Id,Contract> amendcancelled = new Map<Id,Contract>();
        Map<Id,Contract> addendumcancelled = new Map<Id,Contract>();
        List<Contract> retList =  new List<Contract>();
        
        for(Contract con : conlist)
        {
            if(con.recordtypeid == prmMasterId && con.Status == 'Cancelled')
            {
                mastercancelled.put(con.Id,con);
            }
            if(con.recordtypeid == prmAmmendId && con.Status == 'Cancelled')
            {
                amendcancelled.put(con.Id,con);
            }
            if(con.recordtypeid == prmAddendumId && con.Status == 'Cancelled')
            {
                addendumcancelled.put(con.Id,con);
            }
        }
        
        if(!mastercancelled.isEmpty())
        {
            List<Contract> relatedToMaster = new List<Contract>();
            
            relatedToMaster = [Select Id, Name,recordtypeid,Status, PRM_Master_Agreement__c From Contract Where PRM_Master_Agreement__c IN : mastercancelled.keySet()   ];
            
            if(!relatedToMaster.isEmpty())
            {
                for(Contract con : relatedToMaster)
                {
                    if(mastercancelled.containsKey(con.PRM_Master_Agreement__c) && (con.recordtypeid == prmAmmendId || con.recordtypeid == prmAddendumId)&& con.Status != 'Cancelled')
                    {
                        mastercancelled.get(con.PRM_Master_Agreement__c).addError('You cannot cancel a Master Contract if there are any related Addendum or Amendments which are not Cancelled.');
                    }
                }
            }
        }
        
        if(!addendumcancelled.isEmpty())
        {
            List<Contract> relatedToaddendum = new List<Contract>();
            List<PRM_Commercial_Line_GE_OG__c> relCommLine  = new List<PRM_Commercial_Line_GE_OG__c>();
            
            relatedToaddendum = [Select Id, Name,Status ,PRM_Addendum_Contract__c From Contract Where PRM_Addendum_Contract__c IN : addendumcancelled.keySet() AND recordtypeid =: prmAmmendId ];
            
            if(!relatedToaddendum.isEmpty())
            {
                for(Contract con : relatedToaddendum)
                {
                    if(addendumcancelled.containsKey(con.PRM_Addendum_Contract__c)&& con.Status != 'Cancelled')
                    {
                        addendumcancelled.get(con.PRM_Addendum_Contract__c).addError('You cannot cancel Addendum Contract if there are any related Commercial Lines which are not Abandoned or Amendments which are not Cancelled.');
                    }
                }
            }
            relCommLine = [Select Id, PRM_Addendum_ID__c,PRM_Status__c from PRM_Commercial_Line_GE_OG__c Where PRM_Addendum_ID__c IN : addendumcancelled.keySet()];
            if(!relCommLine.isEmpty())
            {
                for(PRM_Commercial_Line_GE_OG__c con : relCommLine)
                {
                    if(addendumcancelled.containsKey(con.PRM_Addendum_ID__c) && con.PRM_Status__c != 'Abandoned')
                    {
                        addendumcancelled.get(con.PRM_Addendum_ID__c).addError('You cannot cancel Addendum Contract if there are any related Commercial Lines which are not Abandoned or Amendments which are not Cancelled.');
                    }
                }
            }
            
            
        }
        
        if(!amendcancelled.isEmpty())
        {
            //List<Contract> relatedToamend = new List<Contract>();
            List<PRM_Commercial_Line_GE_OG__c> relCommLine  = new List<PRM_Commercial_Line_GE_OG__c>();
            
            
            relCommLine = [Select Id, PRM_Amendment_ID__c,PRM_Status__c from PRM_Commercial_Line_GE_OG__c Where PRM_Amendment_ID__c IN : amendcancelled.keySet()];
            if(!relCommLine.isEmpty())
            {
                for(PRM_Commercial_Line_GE_OG__c con : relCommLine)
                {
                    if(amendcancelled.containsKey(con.PRM_Amendment_ID__c)&& con.PRM_Status__c != 'Abandoned')
                    {
                        amendcancelled.get(con.PRM_Amendment_ID__c).addError('You cannot cancel Amendment Contract if there are any related Commercial Lines which are not Abandoned.');
                    }
                }
            }
            
            
        }
        
    return ;    
    }
     
 }