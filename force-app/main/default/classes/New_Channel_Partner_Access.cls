public class New_Channel_Partner_Access{
    public static Account acct{get;set;}
    public String address{get;set;}
    public static List<ContactWrap> contactList;
    //public static Contact PrimaryCont{get;set;}
    public String RWprofiles{get;set;}
    public String RWstatuses{get;set;}
    //public String RWPrimaryList{get;set;}
    //public String email{get;set;}
    //public String communitiesProfile{get;set;}
    public String isPartnerAcc{get;set;}
    public static Integer PrimCont1{get;set;} 
    
    public New_Channel_Partner_Access(ApexPages.StandardController controller) {
        if (!Test.isRunningTest())
            controller.addFields(new List<String>{'Id','ShippingStreet','ShippingCity','ShippingState','ShippingCountry','ShippingPostalCode','IsPartner'});
        New_Channel_Partner_Access.acct = (Account)controller.getRecord();
        if (!Test.isRunningTest()) {
            address = acct.ShippingStreet+', '+acct.ShippingCity+', '+acct.ShippingState+', '+acct.ShippingCountry+', '+acct.ShippingPostalCode;
            address = address.replace('null, ','').replace('null','');
        } else
            address = 'justTest';
        isPartnerAcc = acct.IsPartner?'IS':'IS NOT';
        
        List<String> profileslist = new List<String>();
        profileslist.add('--select Access Level--');
        for(Schema.PicklistEntry ple:Contact.RW_Profile__c.getDescribe().getPicklistValues())
            profileslist.add(ple.getLabel());
        profileslist.sort();
        RWprofiles = JSON.serialize(profileslist);
        
        List<String> statuslist = new List<String>();
        for(Schema.PicklistEntry ple:Contact.RW_Access__c.getDescribe().getPicklistValues())
            statuslist.add(ple.getLabel());
        statuslist.sort();
        RWstatuses = JSON.serialize(statuslist);
    }
    
    public class ContactWrap{
        public Boolean RWenabled{get;set;}
        public Boolean RWchange{get;set;}
        public Contact conc{get;set;}
        public String email{get;set;}
        public String RWaccess{get;set;}
        public String RWprofile{get;set;}
        public Boolean RWprimary{get;set;}
        public String ssoid{get;set;}
    }

    @RemoteAction
    public static List<ContactWrap> getContactList(String accountId) {
        contactList = new List<ContactWrap>();
        for(Contact con:[Select Id, AccountId, Account.IsPartner, FirstName, LastName, Name, Email, Title, GE_PRM_SSO_ID__c, RW_isPrimary__c, RW_Access__c, RW_Profile__c, RW_Change__c from Contact where AccountId=:accountId Order By RW_isPrimary__c desc, RW_Access__c desc, GE_PRM_Sso_Id__c Nulls LAST, Name]){
            ContactWrap cw = new ContactWrap();
            cw.conc = con;
            cw.RWprofile = con.RW_Profile__c;
            if(cw.RWprofile==null)
                cw.RWprofile = '--select Access Level--';
            cw.RWaccess = con.RW_Access__c;
            if(cw.RWaccess==null)
                cw.RWaccess = 'No Access';
            cw.RWprimary = con.RW_isPrimary__c;
            cw.RWchange = con.RW_Change__c;
            cw.RWenabled = false;
            if(cw.RWaccess=='Active')
                cw.RWenabled = true;
            cw.email = con.Email;
            cw.ssoid = con.GE_PRM_SSO_ID__c;
            contactList.add(cw);
        }
        return contactList;
    }

    @RemoteAction
    public static String activate(ContactWrap cw){
        String cmess1 = '';
        if(!cw.conc.Account.IsPartner){
            return 'ERROR: Cannot activate RelayWare access. The Account is not a valid Partner.';
        } else if(cw.ssoid==null){
            return 'ERROR: Cannot Activate Partner without SSO. Create SSO and add to contact.';
        } else if(cw.RWenabled && cw.RWaccess == cw.conc.RW_Access__c && cw.RWprimary == cw.conc.RW_isPrimary__c && cw.RWprofile == cw.conc.RW_Profile__c){
            return 'ERROR: Partner already Activated with same settings!!';
        } else {
            cmess1 = activateRWUser(cw);
            return cmess1;
        }
    }
    
    @RemoteAction
    public static String changeEmail(ContactWrap cw, String email){
        cw.conc.Email = email;
        cw.conc.RW_Change__c = true;
        update cw.conc;
        return 'New email address has been set for';
    }
    
    @RemoteAction
    public static String changeSSO(ContactWrap cw, String sso){
        cw.conc.GE_PRM_SSO_ID__c = sso;
        cw.conc.RW_Change__c = true;
        update cw.conc;
        return 'New SSO has been set for';
    }
    
    private static String activateRWUser(ContactWrap cw) {
        PrimCont1 = [Select Count() from Contact where AccountId=:cw.conc.account.id AND RW_isPrimary__c=true limit 1];
        String conmess = '';
        cw.conc.RW_Change__c = true;
        cw.conc.RW_Access__c = cw.RWAccess;
        cw.conc.RW_Profile__c = cw.RWProfile;
        if(cw.RWAccess == 'De-Activated'){
            cw.conc.RW_isPrimary__c = false;
            conmess = 'DEACTIVATED: Access disabled for contact';
        } else {
            if(!cw.RWprimary && (Primcont1 == 0 ||(Primcont1 == 1 && cw.conc.RW_isPrimary__c))){
                cw.conc.RW_isPrimary__c = true;
                cw.conc.RW_Profile__c = 'Management User';
                conmess = 'NOTE: Request submitted with changes - Contact made PRIMARY (due to first contact). If you do not wish this, Activate the Primary contact, then make this partner Not Primary. it takes sometime for the changes to take effect for contact:';
            } else {
                cw.conc.RW_isPrimary__c = cw.RWprimary;
                conmess = cw.RWprimary?'PSUBMITTED: Request submitted. Until you receive a confirmation E-mail, please do not initiate other actions for contact:':'NSUBMITTED: Request submitted. Until you receive a confirmation E-mail, please do not initiate other actions for contact:';
            }
        }
        update cw.conc;
        return conmess;
    }
}