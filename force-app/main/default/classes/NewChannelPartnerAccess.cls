public class NewChannelPartnerAccess {
public NewChannelPartnerAccess() {
}
/*
    public final Account acct{get;set;}
    public String address{get;set;}
    public List<ContactWrap> contactList{get;set;}
    public List<SelectOption> profileList{get;set;}
    private Map<String,Id> profileMap;
    public String userId{get;set;}
    public String email{get;set;}
    
    public NewChannelPartnerAccess(ApexPages.StandardController controller) {
        if (!Test.isRunningTest())
            controller.addFields(new List<String>{'ShippingStreet','ShippingCity','ShippingState','ShippingCountry','ShippingPostalCode'});
        this.acct = (Account)controller.getRecord();
        if (!Test.isRunningTest()) {
            address = acct.ShippingStreet;
            address += '<br/>'+acct.ShippingCity+', '+acct.ShippingState;
            address += '<br/>'+acct.ShippingCountry;
            address += '<br/>'+acct.ShippingPostalCode;
            address = address.replace('null','');
        } else
            address = 'justTest';
        setContactlist();
        profileList = new List<SelectOption>();
        profileList.add(new SelectOption('','--None Selected--'));
        profileMap = new Map<String,Id>();
        for(Profile p:[Select Name From Profile where UserLicense.Name = 'Gold Partner' and Name != 'Gold Partner User']){
            profileList.add(new SelectOption(p.Name,p.Name));
            profileMap.put(p.Name,p.Id);
        }
        profileList.sort();
    }
    
    public class ContactWrap{
        public Boolean selected{get;set;}
        public Boolean created{get;set;}
        public Boolean enabled{get;set;}
        public Contact conc{get;set;}
        public String email{get;set;}
        public String profile{get;set;}
        public Id userId{get;set;}
        public String tier1PnL{get;set;}
        public String tier2PnL{get;set;}
    }
    
    public PageReference runback() {return null;}
    
    private void setContactlist(){
    
        contactList = new List<ContactWrap>();
        Set<Id> contactIds = new Set<Id>();
        for(Contact con:[Select Id, FirstName, LastName, Name, Email, Title, Tier_1_P_L__c,  Tier_2_P_L__c from Contact where AccountId=:acct.Id]){
            ContactWrap cw = new ContactWrap();
            cw.conc = con;
            cw.profile = '';
            cw.created = false;
            cw.selected = false;
            cw.email = con.Email;
            cw.tier1PnL = con.Tier_1_P_L__c;
            cw.tier2PnL = con.Tier_2_P_L__c;
            contactList.add(cw);
            contactIds.add(con.Id);
        }
        for(User u:[Select Id, ContactId, Email, Profile.Name, isActive from User where ContactId IN :contactIds]){
            for(ContactWrap cw:contactList){
                if(cw.conc.Id.equals(u.ContactId)){
                    cw.profile = u.Profile.Name;
                    cw.created = true;
                    cw.selected = u.isActive;
                    cw.enabled = u.isActive;
                    cw.email = u.Email;
                    cw.userId = u.Id;
                }
            }
        }
    }
    
    public PageReference confirm() {
        if(!acct.IsPartner){
            acct.IsPartner = true;
            update acct;
        }
        for(ContactWrap cw:contactList){
            if(cw.created||(!cw.created&&cw.selected)){
                if(cw.profile==null||''.equals(cw.profile)){
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Please select appropriate profile for selected contact(s)'));
                    return null;
                }    
            }
        }
        for(ContactWrap cw:contactList){
            if(cw.created){
                updateUser(cw);
            } else if(!cw.created&&cw.selected) {
                createUser(cw.conc.Id, cw.conc.email, cw.conc.firstName, cw.conc.lastName, profileMap.get(cw.profile), cw.tier1PnL, cw.tier2PnL);
            }
        }
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Request submitted successfully!!!'));
        return null;
    }
    
    public PageReference cancel() {
        PageReference pr = new PageReference('/'+acct.Id);
        pr.setRedirect(true);
        return pr;
    }
    
    public pageReference resetPwd(){
        System.resetPassword(userId,true);
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'A new password has been sent via email. The user will be required to enter a new password upon initial login to salesforce.com.'));
        return null;
    }
    
    public pageReference changeEmailCtrl(){
        updateEmail(userId, email);
        setContactlist();
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'New email has been set, click Reset Password to generate and send a new password to this email address.'));
        return null;
    }
    
    private void updateEmail(Id userId, String email) {
        User u = new User(Id = userId, email=email);
        if (!Test.isRunningTest())
            update u;
    }
    
    private void updateUser(ContactWrap cw) {
        User bU = [Select Id, isActive from User where Id =:cw.userId];
        User u = new User(Id = cw.userId, profileid = profileMap.get(cw.profile), isActive = cw.selected, GE_HQ_Tier_1_P_L__c = cw.tier1PnL, GE_HQ_Tier_2_P_L__c = cw.tier2PnL);
        if (!Test.isRunningTest())
            update u;
        if(u.isActive&&!bU.isActive)
            System.resetPassword(cw.userId,true);
    }
    
    @future(callout=false)
    private static void createUser(String contactId, String email, String firstName, String lastName, Id profileId, String tier1PnL, String tier2PnL) {
        Database.DMLOptions dmo = new Database.DMLOptions();
        dmo.EmailHeader.triggerUserEmail = true;
        String username = email;
        Integer ssoId;
        SFDC_Support_Case__c sso;
        try { 
            sso = [Select User_SSO__c from SFDC_Support_Case__c where Type__c = 'Counter' AND Application__c = 'NewChannelPartnerAccess' Limit 1];
            ssoId = Integer.valueOf(sso.User_SSO__c);
            ssoId++;
        } catch(Exception e){
            insert new SFDC_Support_Case__c(Type__c = 'Counter',Application__c = 'NewChannelPartnerAccess',User_SSO__c = '100000');
            ssoId = 100000;
        }
        User u = new User(alias = 'standt', email=email, 
            emailencodingkey='UTF-8',firstName=firstName, lastname=lastname, languagelocalekey='en_US', 
            localesidkey='en_US', profileid = profileId, contactId=contactId,
            timezonesidkey='America/Los_Angeles', username=username, GE_HQ_SSO_ID__c= 'P-'+ssoId,
            GE_HQ_Tier_1_P_L__c = tier1PnL, GE_HQ_Tier_2_P_L__c = tier2PnL);
        
        u.setOptions(dmo);
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.saveAsActivity = false;
        try {
            insert u;
        } catch(DmlException de1){
            try {
                u.username = u.username + '.og';
                insert u;
            } catch(DmlException de2){
                mail.setSubject('New Channel Partner SFDC Access Request : Failed');
                mail.setTargetObjectId(UserInfo.getUserId());
                mail.setPlainTextBody
                ('Sorry we encountered an error while processing this request.\n'+
                'Please log a Support Ticket to get more information.');
                Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
                return;
            }
        }
        mail.setTargetObjectId(u.id);
        mail.setUseSignature(false);
        mail.setBccSender(true);
        EmailTemplate et=[Select id from EmailTemplate where DeveloperName='Email_to_Partner_User'];
        mail.setTemplateId(et.id);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
        
        if(sso==null)
            sso = [Select User_SSO__c from SFDC_Support_Case__c where Type__c = 'Counter' AND Application__c = 'NewChannelPartnerAccess' Limit 1];
        sso.User_SSO__c = String.valueOf(ssoId);
        update sso;
    }
    */
}