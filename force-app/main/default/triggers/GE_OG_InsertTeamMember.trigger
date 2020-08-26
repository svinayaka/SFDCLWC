trigger GE_OG_InsertTeamMember on Account(after update, after insert, before insert) {

  OG_Trigger_fire_Decision__c lstObj = OG_Trigger_fire_Decision__c.getValues('GE_OG_InsertTeamMember');
       
    if(lstObj!=null && lstObj.isActive__c == true && lstObj.Object_Name__c=='Account'){
       
        return;  
    }
    else{
     if(trigger.isBefore){
        list<String> accountName = new list<String>();
        Id devRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
        for(Account acc :Trigger.new){
            if(acc.IsLeadAccount_GEOG__c == true){
                    acc.RecordTypeId =devRecordTypeId;
                    acc.Account_Tier_GEOG__c = 'Country';
                    acc.Classification__c = 'Unclassified'; 
                    acc.Type = 'Direct Customer';
            }   
            if(acc.Account_Tier_GEOG__c == 'Country' && acc.RecordTypeId == devRecordTypeId){
               if(trigger.isUpdate && Trigger.oldMap.get(acc.Id).Name != acc.Name)
                {
                    accountName.add(acc.Name);
                }
                else if(trigger.isInsert)
                {
                    accountName.add(acc.Name);
                } 
               // accountName.add(acc.Name); 
            }
        } 
          
        List<Account> lstAccount = new list<Account>();
        if(accountName.size()>0){
        lstAccount = [Select Id, Name from Account where Name in : accountName and Account_Tier_GEOG__c = 'Country' and RecordTypeId = : devRecordTypeId]; }
        if(lstAccount.size()>0){
            Trigger.new[0].addError('This Account name is already exist.');  
           
        }   
    } 
    if(trigger.isAfter){ 
         Integer newcnt = 0;
         Integer newcnt0 = 0;
         List<AccountTeamMember> lstAccTeamMember = new List<AccountTeamMember>();
         Set<Id> setOwnerId = new Set<Id>();
         AccountShare[] newShare = new AccountShare[]{};
         List<Account> lstTemp = new List<Account>();
         List<Account> lstToUpdate = new List<Account>();
         Id devRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
         ID systemIntegrationUser = System.Label.System_Integration_User_ID;
         Set<Id> setAccIdre = new Set<Id>();
         Set<Id> setUserIDs = new Set<Id>();
         system.debug('systemIntegrationUser:'+systemIntegrationUser);
         
         for(Account acc :Trigger.new){
         if(Trigger.IsInsert==true || (Trigger.IsUpdate==true && Trigger.oldMap.get(acc.Id).OwnerId!= acc.OwnerId)){
         setAccIdre.add(acc.Id);
         system.debug('acc.OwnerId:'+acc.OwnerId);
             if(acc.OwnerId != systemIntegrationUser){
                     if(trigger.isInsert){
                          if(acc.RecordTypeId == devRecordTypeId){
                            AccountTeamMember objATM = new AccountTeamMember(AccountId=acc.Id, UserId=acc.OwnerId, TeamMemberRole = 'Sales - Primary') ;
                            lstAccTeamMember.add(objATM);
                            lstTemp.add(acc);
                        }   
                     }
                     else{
                         String OldactOwner = trigger.oldMap.get(acc.id).OwnerId;
                         if(acc.RecordTypeId == devRecordTypeId && acc.OwnerId != OldactOwner){
                            AccountTeamMember objATM = new AccountTeamMember(AccountId=acc.Id, UserId=acc.OwnerId, TeamMemberRole = 'Sales - Primary') ;
                            lstAccTeamMember.add(objATM);
                            lstTemp.add(acc);
                        }
                     }
                 }
            }
         }
         system.debug('lstAccTeamMember:'+lstAccTeamMember);
         
         
         if(lstAccTeamMember.size()>0){
             if(!setAccIdre.isEmpty()){
                for(Account obj: trigger.new){
                    setUserIDs.add(obj.OwnerId);
                }
             }
             Map<id,User> newUserMap = new Map<id,User>([Select id,name from User where ID IN: setUserIDs Limit 50000]);
            
            Map<String,Acc_Invalid_Sales_Primary_User__c> AccOwnerName = Acc_Invalid_Sales_Primary_User__c.getall();
            Map<id,boolean> InvlaidUserMap= new Map<id,boolean>();
            for(Account acc : trigger.new){
                String strOwnerName = newUserMap.get(acc.ownerId).name;
                if(AccOwnerName.get(strOwnerName) != null){
                    InvlaidUserMap.put(acc.Id, true);
                }
            }
             Database.SaveResult[] lsr = Database.insert(lstAccTeamMember,false);
             system.debug('lsr :'+lsr);
             for(Database.SaveResult sr:lsr) {
                if(!sr.isSuccess()) {
                    Database.Error emsg =sr.getErrors()[0];
                    system.debug('\n\nERROR ADDING TEAM MEMBER:'+emsg);
                } else {
                    
                    for(Account acc :lstTemp){
                        if(trigger.isUpdate){
                            Account oldAcc = trigger.oldMap.get(acc.id);
                            if(oldAcc.ownerId !=  acc.ownerId){
                        Account newCopy = new Account(id=acc.id);
                        if(InvlaidUserMap.get(acc.Id) == null){
                            newCopy.Team_MeMber_Added__c = true;
                        }
                        lstToUpdate.add(newCopy);
                    
                        try{
                            if(!lstToUpdate.isEmpty()){
                                update lstToUpdate;
                            }
                        }
                        catch(Exception e){
                            system.debug('exception in Team MEmber Added field '+e.getMessage());
                        }
                    }
                    }
                    }
                    }
                    
                    newShare.add(new AccountShare(UserOrGroupId=lstAccTeamMember[newcnt].UserId, AccountId=lstAccTeamMember[newcnt].Accountid, AccountAccessLevel='Read',OpportunityAccessLevel='Read'));
                }
                newcnt++;
            }
        
            Database.SaveResult[] lsr0 =Database.insert(newShare,false);
            system.debug('lsr0:'+lsr0);
            //insert the new shares Integer newcnt0=0;
            for(Database.SaveResult sr0:lsr0) {
                if(!sr0.isSuccess()) {
                    Database.Error emsg0 = sr0.getErrors()[0];
                    system.debug('\n\nERROR ADDING SHARING:'+newShare[newcnt0]+'::'+emsg0); 
                } 
                newcnt0++; 
            }
        }
    }
    }