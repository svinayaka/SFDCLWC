trigger AccountComplianceReady_GEOG on Account (Before insert, Before update, after insert, after update) {
//Code to skip trigger

    OG_Trigger_fire_Decision__c lstObj = OG_Trigger_fire_Decision__c.getValues('AccountComplianceReady_GEOG');
       
    if(lstObj!=null && lstObj.isActive__c == true && lstObj.Object_Name__c=='Account'){
       return;  
    }
    else{
        if (Trigger.isBefore) {
            if (trigger.isinsert || trigger.isUpdate){
                for(Account a : Trigger.New) {
                    if(a.Finance_Lock_GEOG__c == True || a.Compliance_Lock_GEOG__c == True){
                        a.Compliance_Ready__c = False;
                     }
                     //Ensure that the Global Account name have /HQ or not, If not exist then need to append.
                    if(!(a.name.contains('/HQ')) && !(a.name.contains('/ HQ')) && a.Account_Tier_GEOG__c == 'Global'){
                        a.name = a.name+' / HQ';
                    }
                    if(!(a.name.contains('/'+ a.Region_GEOG__c)) && !(a.name.contains('/ '+ a.Region_GEOG__c)) && a.Account_Tier_GEOG__c == 'Regional'){
                        a.name = a.name+' / '+a.Region_GEOG__c;
                    }        
                }
             }
        }
        

        
        //Swtich Contacts from Commericcal Contry level to LE level
        if(trigger.isAfter){
            if (trigger.isinsert || trigger.isUpdate){
                Set<String> setOilGasParentAccIds = new Set<String>();
                  Map<String, Account> mapLEAccount = new Map<String, Account>(); // Oil_Gas_Parent_Account__c, LeAccount
                  for (Account a : trigger.new){
                    if(a.Oil_Gas_Parent_Account__c!=null){
                        setOilGasParentAccIds.add(a.Oil_Gas_Parent_Account__c);
                        mapLEAccount.put(a.Oil_Gas_Parent_Account__c, a);
                    }
                  }
                  
                  //Fetch all contacts created on contry level commercial account
                  List<Contact> listCon = new List<Contact>([Select Id, AccountId, Account.Account_Tier_GEOG__c from Contact where Account.Account_Tier_GEOG__c = 'Country' and AccountId in :setOilGasParentAccIds]);
                  
                  //Update Contact
                  List<Contact> lstUpdateCon = new list<Contact>();
                  for(Contact con1 : listCon){
                    if(con1.Account.Account_Tier_GEOG__c == 'Country' && mapLEAccount.get(con1.AccountId)!=null)
                    {
                        con1.AccountId = mapLEAccount.get(con1.AccountId).Id;
                        lstUpdateCon.add(con1);
                    }
                  }
                  if(lstUpdateCon.size()>0){
                    update lstUpdateCon;
                  }
            
            }
        }
        
        //Change Commercial level account names If Global Account name Changed
        
       
        //Chnage the Account Type from Global To all levels
        
        //Change Commercial level account names If Global Account name and type Changed
        //Rahul's Code....
        if(trigger.isAfter && trigger.isUpdate)
        {
            Id devRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
            Set<String> tierSetAll = new Set<String>{'Country','Regional','LE'};
            List<Account> updActLst = new List<Account>();
            Set<Id> globalAccountIdNameChanged = new set<Id>();
            Set<Id> globalAccountIdTypeChanged = new set<Id>();
            Set<Id> leAccountIdTypeChanged = new set<Id>();
            Set<Id> globalAccountIdAll = new set<Id>();
            for(Account act : Trigger.new)
            {
                String oldValPrece = (trigger.oldMap.get(act.id).name).split('/')[0];
                String newValPrece = (act.name).split('/')[0];
                String Oldacttype = trigger.oldMap.get(act.id).Type;
                if('Global' == act.Account_Tier_GEOG__c && devRecordTypeId == act.RecordTypeId  && !oldValPrece.equalsIgnoreCase(newValPrece))
                {
                    globalAccountIdNameChanged.add(act.Id);
                    globalAccountIdAll.add(act.Id);
                }
                if('Global' == act.Account_Tier_GEOG__c && devRecordTypeId == act.RecordTypeId  && Oldacttype != act.Type)
                {
                    globalAccountIdTypeChanged.add(act.Id);
                    globalAccountIdAll.add(act.Id);
                }
                //Changes for Country Account Type change - Pallavi Sharma
                if('Country' == act.Account_Tier_GEOG__c && devRecordTypeId == act.RecordTypeId  && Oldacttype != act.Type){
                    leAccountIdTypeChanged.add(act.Id);
                }
                //End Pallavi Sharma
            }
            //If Name or type change on Global Account
            if(globalAccountIdAll.size()>0)
            {
                for(Account cumAct : [select Id,Name,Account_Tier_GEOG__c,RecordTypeId,ParentId,Member_of_GE_OG__c,Member_of_GE_OG__r.name,Member_of_GE_OG__r.Type from Account where Member_of_GE_OG__c in: globalAccountIdAll and Account_Tier_GEOG__c in : tierSetAll ])
                {
                    String oldValPrece = (trigger.oldMap.get(cumAct.Member_of_GE_OG__c).name).split('/')[0];
                    String newValPrece = (cumAct.Member_of_GE_OG__r.Name).split('/')[0];
                    String chldActName = cumAct.Name;
                    if(cumAct.RecordTypeId == devRecordTypeId && chldActName.split('/')[0].equalsIgnoreCase(oldValPrece) && globalAccountIdNameChanged.contains(cumAct.Member_of_GE_OG__c))
                    {
                        chldActName = newValPrece + chldActName.removeStartIgnoreCase(oldValPrece);
                        cumAct.name = chldActName;
                    }
                    if(globalAccountIdTypeChanged.contains(cumAct.Member_of_GE_OG__c))
                    {
                        cumAct.Type = cumAct.Member_of_GE_OG__r.Type;  
                    }
                    updActLst.add(cumAct);
                }
                
                
            }
            //Changes for Country Account Type change - Pallavi Sharma
            //If Type change on Country Account
            if(!leAccountIdTypeChanged.isEmpty()){
                for(Account childAcc : [SELECT Id, Oil_Gas_Parent_Account__r.Type 
                                        FROM Account 
                                        WHERE Oil_Gas_Parent_Account__c in: leAccountIdTypeChanged 
                                        AND Account_Tier_GEOG__c in : tierSetAll ])
                {
                    childAcc.Type = childAcc.Oil_Gas_Parent_Account__r.Type;  
                    updActLst.add(childAcc);
                }
            }
            //End Pallavi Sharma
            
            if(updActLst.size()>0)
            {
                ClsAvoidTriggerRecursion.Var_Static_ManageFinanceDetailTrgr = false;
                update updActLst;
            }
        }
    }
}