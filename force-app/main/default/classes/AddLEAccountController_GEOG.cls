public with sharing class AddLEAccountController_GEOG{
    public Account acc {get;set;}
    public boolean isEdit {get;set;}
    //public GE_Account_Prepopulate_OG__c cs {get;set;}

public AddLEAccountController_GEOG(ApexPages.StandardController controller){
         Id devRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('New Customer Request').getRecordTypeId();
         List<Account> lstAcc = new List<Account>();
         if(ApexPages.currentPage().getParameters().get('OG_Id')!=null){
            lstAcc = new List<Account>([Select Id,Region_GEOG__c, Type,Classification__c,Country_GEOG__c, Member_of_GE_OG__c from Account where Id =: ApexPages.currentPage().getParameters().get('OG_Id')]);
         }
         if(devRecordTypeId== ApexPages.currentPage().getParameters().get('RecordType')){
           
            acc = new Account();
            isEdit = true;
           // GEMDM__GE_MDM_Commercial_Hierarchy_Fields__c cs = GEMDM__GE_MDM_Commercial_Hierarchy_Fields__c.getInstance('Account Hierarchy Fields');
             
            //if(cs!=null){  
            if(!lstAcc.isEmpty()){ 
                acc.Region_GEOG__c = lstAcc[0].Region_GEOG__c;
                acc.Type = lstAcc[0].Type;
                
                acc.Name = ApexPages.currentPage().getParameters().get('acc2');
                acc.Classification__c = lstAcc[0].Classification__c;
                
                acc.Country_GEOG__c = lstAcc[0].Country_GEOG__c;
                acc.Member_of_GE_OG__c = lstAcc[0].Member_of_GE_OG__c;
                acc.Oil_Gas_Parent_Account__c =  ApexPages.currentPage().getParameters().get('OG_Id');
                acc.Account_Tier_GEOG__c = 'LE';
                acc.RecordTypeId = ApexPages.currentPage().getParameters().get('RecordType');
                acc.OwnerId = UserInfo.getUserId();
                system.debug('====acc======'+acc);
            } 
        }
        else{
          callpageredirect();
        }
    }
    
    public pageReference Save(){
         PageReference accPage;
            
           
         try{
         
          if (acc.Country_GEOG__c!= acc.GE_HQ_New_Account_Country__c)
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Commercial Country should be same as LE Country'));
                return null;
        } 
         
             acc.ShippingCountry = acc.GE_HQ_New_Account_Country__c;
             insert acc;
             accPage = new PageReference('/' + acc.Oil_Gas_Parent_Account__c);
             accPage.setRedirect(true);
            
         }catch(Exception ex){
             ApexPages.addMessages(ex);
         
         }
         return accPage ;
  

    } 
    
    public pagereference callpageredirect(){
           PageReference p = new PageReference('/001/e?retURL=%2F00Q%2Fo&RecordType='+ApexPages.currentPage().getParameters().get('RecordType')+'&ent=Account');
            p.getParameters().put('nooverride','1');
            return p;
    }

  
}