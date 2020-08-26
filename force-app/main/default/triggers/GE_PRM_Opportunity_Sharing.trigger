trigger GE_PRM_Opportunity_Sharing on Opportunity (before insert, after insert, after update, before update) {
/*
//101 soql error below flag is added
    if(OpptyTriggerhelperClass.pIIUpdate == false){
        //Instantiate the Custom Setting GE Profile
        List<GE_Profile__c> profile = GE_Profile__c.getall().values();
        Map<Id, String> mapProfile = new Map<Id, String>();
    
        for (GE_Profile__c profilename: profile ) {
            if(profilename.Profile_SFDC_ID__c != null)
                 mapProfile.put(profilename.Profile_SFDC_ID__c, profilename.Profile_Name__c);
        }
        system.debug('Profile Map -'+mapProfile);
        Id LoggedinProfileId = UserInfo.getProfileId();
        String LoggedinProfileName = mapProfile.get(LoggedinProfileId);
        system.debug('Logged in Profile Name-'+LoggedinProfileName );

        if(Trigger.isInsert) {
            User partUsr = new User();
            partUsr = [Select id,accountId,GE_HQ_Tier_3_P_L__c from User where id =: UserInfo.getUserId()];

        
            for (Opportunity o : trigger.new) {
                if (trigger.isBefore) {

                    if(UserInfo.getUserType() == 'PowerPartner' && (LoggedinProfileName  == 'Channel Partner DR/VAR/Reseller user' || LoggedinProfileName  == 'Channel Partner Leader user - DR')) {
                        o.GE_ES_Customer_Type__c = 'Channel Partner';
                        //if (partUsr.GE_HQ_Tier_3_P_L__c != 'Flow & Process Technologies (Dresser)')
                            o.GE_HQ_Prm_Opp__c = 'No';               
                    }                         
                    if(UserInfo.getUserType() == 'PowerPartner' && (LoggedinProfileName  == 'Channel Partner Sales Rep user' ||  LoggedinProfileName  == 'Channel Partner Leader user - SR')) {
                        o.GE_ES_Customer_Type__c = 'Channel-Sales Representative';                
                    }
                }
            }
            
            if(UserInfo.getUserType() == 'PowerPartner') {
                if(trigger.isAfter) {
                    Set<Id> AccountId = new Set<Id>();
                    Set<Id> OpptyId = new Set<Id>();
                    for (Opportunity o : trigger.new) {
                        system.debug('***PartnerAccounts***'+o.Account.isPartner);
                        if(o.Account.isPartner == true) {
                            AccountId.add(o.AccountId);
                            OpptyId.add(o.Id);
                        }                        
                    }                
                    system.debug('****AccountId****'+AccountId);
                    system.debug('****OpptyId****'+OpptyId);
                
                    String recordTypeId = Schema.SObjectType.GE_PW_Key_Players__c.getRecordTypeInfosByName().get('GE PW Key Player').getRecordTypeId();
                    list<GE_PW_Key_Players__c> PRMKeyPlayers = new list<GE_PW_Key_Players__c>();
                    List<GE_PW_Key_Players__c> kp = new List<GE_PW_Key_Players__c>();
                
                    kp = [Select Id, GE_PW_Account__c, GE_PW_Opportunity__c from GE_PW_Key_Players__c where GE_PW_Account__r.Id IN: AccountId and GE_PW_Opportunity__r.Id IN: OpptyId];                    
                   
                    system.debug('key players'+kp);    
                    system.debug('key players size'+kp.size());
                
                    for(Opportunity opty : trigger.new) {
                        GE_PW_Key_Players__c keyPlayersObject = new GE_PW_Key_Players__c();
                        keyPlayersObject.GE_PW_Account__c = partUsr.accountId;
                        keyPlayersObject.GE_PW_Opportunity__c = opty.Id;
                        keyPlayersObject.RecordTypeId = recordTypeId;
                        keyPlayersObject.GE_PW_WIWS_KR__c = 'Channel Partner Sales Rep';
                        PRMKeyPlayers.add(keyPlayersObject);
                
                        //Inserting Key Players Records
                        if(kp.size() > 0) {
                            //insert PRMKeyPlayers;
                        }
                        else {
                            insert PRMKeyPlayers;
                        }
                    }
                }
            }
        }
       
    
    if(Trigger.isUpdate)
        {
        //if(GEESGlobalContextController.PRMfirstRun)
            
            Map<Id,String> PartnerUser = new Map<Id,String>(); 
            set<Id> CreatedbyId = new set<Id>();    
            for (Opportunity o : trigger.new) 
                {
                CreatedbyId.add(o.CreatedbyId);
                }   
            //List<User> u = new List<User>([Select Id, UserType from User where Id IN:CreatedbyId]);
            
                            
            if(Trigger.isBefore)
                {
                if(GEESGlobalContextController.PRMBeforeUpdatefirstRun)
                {   
                for(User pu:[Select Id, UserType from User where Id IN:CreatedbyId and isactive = true])
                    {
                    system.debug('Inside');
                    if(pu.UserType == 'PowerPartner')
                        {   
                        PartnerUser.put(pu.Id, pu.UserType);    
                        }
                    }
                
                Id usrId = UserInfo.getUserId();
                User partusr = [Select Id, UserType from User where Id =:usrId and isactive = true];
                               
                // This is for Channel Manager Changes the Account for the Opportunity Created by Parter, but is NOT the Owner.
                for(Integer i=0;i<Trigger.new.size();i++)
                    {
                    Boolean pCreatedby = PartnerUser.containsKey(trigger.new[i].CreatedbyId);
                    system.debug('****pCreatedby**'+pCreatedby);
                    if((trigger.new[i].AccountId != trigger.old[i].AccountId) && trigger.new[i].OwnerId != UserInfo.getUserId() && pCreatedby == true)
                        {
                         trigger.new[i].AccountId.addError('You do not currently own this opportunity. Only the owner can change the account on the opportunity.');
                        }
                    if((trigger.new[i].AccountId != trigger.old[i].AccountId) && trigger.new[i].OwnerId != UserInfo.getUserId() && pCreatedby == false && partusr.UserType == 'PowerPartner')
                        {
                         trigger.new[i].AccountId.addError('You do not currently own this opportunity. Only the owner can change the account on the opportunity.');
                        }   
                    }
                GEESGlobalContextController.PRMBeforeUpdatefirstRun = false; 
                } 
                }          
            if(Trigger.isAfter)
                {
                if(GEESGlobalContextController.PRMAfterUpdatefirstRun)
                {   
                for(User pu:[Select Id, UserType from User where Id IN:CreatedbyId and isactive = true])
                    {
                    system.debug('Inside');
                    if(pu.UserType == 'PowerPartner')
                        {   
                        PartnerUser.put(pu.Id, pu.UserType);    
                        }
                    }      
                list<OpportunityShare > OpptyShareList = new list<OpportunityShare >();
                list<AccountShare> AccountShareList = new list<AccountShare>();
                list<AccountTeamMember> AccountTeamList = new list<AccountTeamMember>();
                list<OpportunityTeamMember> OpportunityTeamList = new list<OpportunityTeamMember>();
                list<GE_PW_Key_Players__c> PRMKeyPlayers = new list<GE_PW_Key_Players__c>();
                String recordTypeId = Schema.SObjectType.GE_PW_Key_Players__c.getRecordTypeInfosByName().get('GE PW Key Player').getRecordTypeId();
                
                for(Opportunity OpptyObject : Trigger.New)
                    {
                    Boolean pCreatedby = PartnerUser.containsKey(OpptyObject.CreatedbyId);      
                    // This is for Partner User, If changes the Owner (Shares to Channel Manager)
                    if(pCreatedby == true && OpptyObject.ownerid != OpptyObject.createdById)
                        {
                        //Initialising Account Share Object
                        AccountShare accountShareObject = new AccountShare ();
                        accountShareObject.AccountId = OpptyObject.AccountId;
                        accountShareObject.CaseAccessLevel = 'None';
                        accountShareObject.AccountAccessLevel = 'Read';
                        accountShareObject.OpportunityAccessLevel = 'None';
                        accountShareObject.UserOrGroupId = OpptyObject.CreatedById;
                        accountShareList.add(accountShareObject);
                    
                        //Inserting Account Share records
                        if(accountShareList.size() > 0)
                            {
                            insert accountShareList;
                            }
        
                        //Initialising Account Share Object
                        AccountTeamMember accountTeamObject = new AccountTeamMember();
                        accountTeamObject.AccountId = OpptyObject.AccountId;
                        accountTeamObject.TeamMemberRole = 'Channel Partner Sales Rep';
                        accountTeamObject.UserId = OpptyObject.CreatedById;
                        AccountTeamList.add(accountTeamObject);
        
                       //Inserting Account Team Records
                        if(AccountTeamList.size() > 0)
                            {
                            insert AccountTeamList;
                            }
                        
                          //Initialising Opportunity Team Object
                        OpportunityTeamMember opportunityTeamObject = new OpportunityTeamMember();
                        opportunityTeamObject.OpportunityId = OpptyObject.Id;
                        opportunityTeamObject.TeamMemberRole = 'Channel Partner Sales Rep';
                        opportunityTeamObject.UserId = OpptyObject.CreatedById;
                        OpportunityTeamList.add(opportunityTeamObject);
            
                       //Inserting Opportunity Team Records
                        if(OpportunityTeamList.size() > 0)
                            {
                            insert OpportunityTeamList;
                            }
                    
                        //Initialising Opportunity Share Object
                        OpportunityShare optyShareObject = new OpportunityShare (); 
                        optyShareObject.OpportunityAccessLevel = 'Edit';
                        optyShareObject.OpportunityId = OpptyObject.Id;
                        optyShareObject.UserOrGroupId = OpptyObject.CreatedById;
                        OpptyShareList.add(optyShareObject);
    
                        //Inserting leadshare records
                        if(OpptyShareList.size() > 0)
                            {
                            insert OpptyShareList;
                            }
                        }
                    }
                GEESGlobalContextController.PRMAfterUpdatefirstRun = false; 
                }
            //GEESGlobalContextController.PRMfirstRun = false;    
                }
        } 
        }
        */
            }