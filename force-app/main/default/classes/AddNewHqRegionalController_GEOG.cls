public class AddNewHqRegionalController_GEOG{

    public Account acc{get;set;}
    public Contact con{get;set;}
    public string propPickValSelected {get; set;}
    pageReference pg;
    public boolean isEdit{get;set;}

    public AddNewHqRegionalController_GEOG(ApexPages.StandardController controller){
        acc = new account();
        con = new contact();
        isEdit = true;
        Id devRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
        if(String.IsBlank(ApexPages.currentPage().getParameters().get('id'))){
            if(!String.IsBlank(ApexPages.currentPage().getParameters().get('name')))
            {
               acc.Name = ApexPages.currentPage().getParameters().get('name');
            }

            isEdit = true;
            acc.Name = ApexPages.currentPage().getParameters().get('name');
            
             /*
            List<contact> lstCon = [SELECT Id, AccountId,LastName,firstName,Title,Phone,Email,MailingStreet,MailingCity,MailingState,MailingCountry FROM Contact WHERE Account.name =: acc.Name];
           
            if(!lstCon.isEmpty())
            {
                con = lstCon[0];
            }
            */
        }

        acc.RecordTypeId = devRecordTypeId;
    }

    public List<SelectOption> getPickLstValue(){
        List<SelectOption> options = new List<SelectOption>();
        Schema.DescribeFieldResult fieldResult = Account.Account_Tier_GEOG__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for(Schema.PicklistEntry f : ple)
        {
            if(f.getValue() != 'Country' && f.getValue() != 'LE')
            {
                options.add(new SelectOption(f.getlabel(),f.getValue()));
            }
        } 
        return options;           
    }
    public list<Contact> lstcon = new list<Contact>();
    public pageReference Save() {
        list<account> existedacc = new list<account>();
        try{
            existedacc =[select id,name,Region_GEOG__c, Account_Tier_GEOG__c from account where Name =: acc.Name and Account_Tier_GEOG__c=:propPickValSelected ];
            
            if(existedacc.size()>0)
            {
             ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Account with same name already exist at HQ/Region level'));
              return null;
            }
            if (propPickValSelected == 'Global'){
                acc.Name = acc.Name +' / HQ';
            }
            
            if (propPickValSelected == 'Regional'){
                acc.Name = acc.Name +' / '+acc.Region_GEOG__c;
            }
            
            acc.Account_Tier_GEOG__c =  propPickValSelected;
            acc.Region_GEOG__c = acc.Region_GEOG__c;
            insert acc;
            
            lstcon = new list<Contact>([Select Id,AccountID from contact where email=:con.Email]);
            
            if(lstcon!=null && lstcon.size()>0){
                    ContactAccountSharing__c objConAcc = new ContactAccountSharing__c(Account_GEOG__c=acc.Id, Contact_GEOG__c=lstcon[0].Id, Primary_Contact_GE_OG__c=true);
                    insert objConAcc;
            }
            else{
                con.accountId = acc.Id;
                con.GE_PRM_Primary_Contact__c = true;
                insert con;
            }
        }
        catch(Exception e){
            Apexpages.addMessage(new Apexpages.message(ApexPages.Severity.Error, e.getMessage()));
            return null;
        }
        return new pageReference('/'+acc.Id);
    }
    
    public pageReference Cancel() {
        pg = new pageReference('/001/o');
        return pg;
    }
}