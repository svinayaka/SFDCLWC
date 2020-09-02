global class BatchContractTeamNotifyController implements Database.Batchable<sObject>,DataBase.Stateful{
    global List<Id> lstNotifyUserIds = new List<Id>();
    global Map<Id,List<Id>> mapKeyDateUserIds = new Map<Id,List<Id>>();
    global Database.QueryLocator start(Database.BatchableContext BC){
        String strToday = String.valueOf(system.today());
        String strQuery = 'select id, Name, Contract__c, Date__c, Date_Type__c,Description__c,Email_Trigger_Date__c,Reminder__c,Contract__r.Primary_Contract_Manager__c FROM Key_Date__c where Email_Trigger_Date__c='+strToday;
        return Database.getQueryLocator(strQuery);
    }
    
    global void execute(Database.BatchableContext BC, List<Key_Date__c> scope){
        List<Id> lstContracts = new List<Id>();
        List<String> teamRoles = new List<String>();
        Map<Id,List<Id>> mapContractKeyDates = new Map<Id,List<Id>>();
        String strRoles = Label.DM_Contract_Team_Roles;
        teamRoles = strRoles.split(',');
        for(Key_Date__c objKDate: scope){
            if(objKDate.Contract__c != null){
                if(mapContractKeyDates.get(objKDate.Contract__c) != null){
                    mapContractKeyDates.get(objKDate.Contract__c).add(objKDate.id);
                }
                else{
                    List<Id> tempList = new List<Id>();
                    tempList.add(objKDate.id);
                    mapContractKeyDates.put(objKDate.Contract__c,tempList);
                }
                lstContracts.add(objKDate.Contract__c);
                if(objKDate.Contract__r.Primary_Contract_Manager__c != null){
                    lstNotifyUserIds.add(objKDate.Contract__r.Primary_Contract_Manager__c);
                    if(mapKeyDateUserIds.get(objKDate.id) != null){
                        mapKeyDateUserIds.get(objKDate.id).add(objKDate.Contract__r.Primary_Contract_Manager__c);
                    }
                    else{
                        List<Id> tempList = new List<Id>();
                        tempList.add(objKDate.Contract__r.Primary_Contract_Manager__c);
                        mapKeyDateUserIds.put(objKDate.id,tempList);
                    }
                }
            }
        }
        List<Contract_Team__c> lstContractTeam = new List<Contract_Team__c>();
        if(!lstContracts.isEmpty()){
            lstContractTeam =[SELECT Id,Name,Contract__c,Contract_Team_Member__c,Team_Role__c
                                FROM Contract_Team__c
                                WHERE Contract__c IN:lstContracts AND Team_Role__c IN:teamRoles
                                LIMIT 50000];
            if(!lstContractTeam.isEmpty()){
                for(Contract_Team__c objTeam: lstContractTeam){
                    lstNotifyUserIds.add(objTeam.Contract_Team_Member__c);
                    List<Id> lstKD  = mapContractKeyDates.get(objTeam.Contract__c);
                    for(Id kId: lstKD){
                        if(mapKeyDateUserIds.get(kId) != null){
                            mapKeyDateUserIds.get(kId).add(objTeam.Contract_Team_Member__c);
                        }
                        else{
                            List<Id> lstTemp = new List<Id>();
                            lstTemp.add(objTeam.Contract_Team_Member__c);
                            mapKeyDateUserIds.put(kId,lstTemp);
                        }
                    }
                }
            }
        }
    }
    
    global void finish(Database.BatchableContext BC){
        EmailTemplate emailTemp = [SELECT id,body,subject,htmlValue FROM EmailTemplate WHERE developerName = 'Notify_Contract_Team_Key_Dates_VF'];
        OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'commercial.excellence@bakerhughes.com'];
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        if(!lstNotifyUserIds.isEmpty()){
            for(Id keyId : mapKeyDateUserIds.keySet()){
                for(Id userId: mapKeyDateUserIds.get(keyId)){
                    Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
                    message.TargetObjectId = userId;
                    message.WhatId = keyId;
                    message.optOutPolicy = 'FILTER';
                    message.setSaveAsActivity(false);
                    if(emailTemp != null){
                        message.TemplateId = emailTemp.Id;
                    }
                    if(owea.size() > 0){
                        message.setOrgWideEmailAddressId(owea.get(0).Id);
                    }
                    mails.add(message); 
                }
            }
            Messaging.SendEmailResult[] results = Messaging.sendEmail(mails);
            if (results[0].success) {
                System.debug('The email was sent successfully.');
            } else {
                System.debug('The email failed to send: '
                             + results[0].errors[0].message);
            }
        }
    }
}