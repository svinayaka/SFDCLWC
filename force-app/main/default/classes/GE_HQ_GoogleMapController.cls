public class GE_HQ_GoogleMapController{
    public GE_HQ_GoogleMapController(){}
    /*
    public Integer startRecord{get;set;}
    public Integer endRecord{get;set;}
    public boolean isFirst {get;set;}
    public boolean isLast {get;set;}
    public boolean isNext {get;set;}
    public boolean isPrev {get;set;}
    public String RowsperPage {get;set;}
    public Integer totalRecords {get;set;}
    public Integer ListIndex = 0;
    String ViewName='My GE Accounts';
    PageReference redUrl = new PageReference('/001/o');  
    
    public List<List<Account>> pagingAccounts = new List<List<Account>>();
        
    public void NextPage(){ 
        if(ListIndex<pagingAccounts.size()-1)
            ListIndex++; 
        if(ListIndex==pagingAccounts.size()-1){
            isNext=false;
            isLast=false;
        }                    
        if(ListIndex>=1){
            isPrev=true;
            isFirst =true;
        }                    
        startRecord=ListIndex*Integer.valueOf(RowsperPage)+1;
        endRecord=startRecord+pagingAccounts[ListIndex].size()-1;                                      
    }
    
    public void PrevPage(){ 
        if(ListIndex>=1)
            ListIndex--; 
        if(ListIndex==0){
            isPrev = false;
            isFirst = false;
        }             
        if(ListIndex<pagingAccounts.size()-1){
            isNext = true;
            isLast = true;
        }            
        startRecord=ListIndex*Integer.valueOf(RowsperPage)+1;
        endRecord=startRecord+pagingAccounts[ListIndex].size()-1;              
    }
    
    public void FirstPage(){
        if(ListIndex > 0){
            ListIndex = 0;
            isNext = true;
            isLast = true;
            isFirst = false;
            isPrev = false;
            startRecord=ListIndex*Integer.valueOf(RowsperPage)+1;
            endRecord=startRecord+pagingAccounts[ListIndex].size()-1;            
        }    
    }
    
    public void LastPage(){
        if(pagingAccounts.size() > 1){        
            ListIndex = pagingAccounts.size()-1;
            isNext = false;
            isLast = false;
            isFirst = true;
            isPrev = true;
            startRecord=ListIndex*Integer.valueOf(RowsperPage)+1;
            endRecord=startRecord+pagingAccounts[ListIndex].size()-1;
        }
    }
    
    public List<selectOption> RecordsPerPage{    
        set;
        get{
            List<SelectOption> myOptions = new List<SelectOption>();
            myOptions.add(new SelectOption('5','5'));
            myOptions.add(new SelectOption('10','10'));            
            return myOptions;
        }
    }
    
    public List<Account> accounts{get;set;}
    public AddressModel addressmodel {get;set;}
    public set<Id> accIds = new Set<Id>();
    public GE_HQ_GoogleMapController(ApexPages.StandardController stdController){
        totalRecords = 0;
        String MyGEAccountIds = ApexPages.currentPage().getParameters().get('AccIds');
        List<String> selectedAccIds = MyGEAccountIds.split(',');
        System.debug('****MyGEAccountIds****'+MyGEAccountIds);
        List<GE_HQ_Acc_AccPlan_Rel__c> myGEAccountsList = [select id,GE_HQ_Account__c from GE_HQ_Acc_AccPlan_Rel__c where id in: selectedAccIds];
        //accIds = new Set<Id>();
        for(GE_HQ_Acc_AccPlan_Rel__c myGEAccObj: myGEAccountsList){
            accIds.add(myGEAccObj.GE_HQ_Account__c);
        }
        accounts = new List<Account>();
        
        System.debug('****Accounts Size****'+accIds.size());                        
        if(accIds.size()>0){
            accounts = [select id, name, ShippingCity, ShippingCountry, ShippingPostalCode, ShippingState, ShippingStreet, Site, Website, GE_HQ_DUNS_Number__c,phone from Account where id in: accIds];
            totalRecords = accounts.size();
            RowsperPage ='5';
            refreshAccounts();            
        }            
        
        addressmodel = new AddressModel();
        for(Account acc: accounts){
            string address = acc.ShippingState != null ? acc.ShippingState.replaceall('\n','') :  '';
            if(address.trim().length() > 0 )
                address += ',';       
            address += acc.ShippingCity != null ? acc.ShippingCity : '';
            
            if(address.trim().length() > 0 )
                address += ',';       
            address += acc.ShippingState != null ? acc.ShippingState : '';

            if(address.trim().length() > 0 )
                address += ',';       
            address += acc.ShippingPostalCode != null ? acc.ShippingPostalCode : '';

            if(address.trim().length() > 0 )
                address += ',';       
            address += acc.ShippingCountry != null ? acc.ShippingCountry : '';
            
            addressmodel.add(address,
                             '',
                             '',
                             'Account Name:<h3><a href=/' + acc.id + ' target=_blank>' + acc.name + '</a></h3>' +
                             '<br/>' + 'DUNS Number:' + acc.GE_HQ_DUNS_Number__c + 
                             '<br /> Address:' + address);
        }
                           
    }
    
    public List<Account> getaccountRes()
    {
      if(pagingAccounts.size() > 0)
      return pagingAccounts[ListIndex];
      else
      return new List<Account>();
    }
    public void refreshAccounts(){
        System.debug('****RowsPerPage****'+RowsperPage);
        pagingAccounts = new List<List<Account>>();
        if(accIds.size()>0){
            ListIndex=0;    
            List<Account> accList = new List<Account>();
            for(Integer i=1;i<=accounts.size();i++){
                accList.add(accounts[i-1]);
                if(Math.mod(i,Integer.valueOf(RowsperPage)) == 0){
                    pagingAccounts.add(accList);
                    accList = new List<Account>();
                }
            }
            
            if(accList.size()>0&&Math.mod(accounts.size(),Integer.valueOf(RowsperPage))!=0)
                pagingAccounts.add(accList);
            if(pagingAccounts.size()>0){
                isFirst = false;
                isPrev = false;
                if(pagingAccounts.size()>1){
                    isNext = true;
                    isLast = true;
                }
                startRecord=ListIndex*Integer.valueOf(RowsperPage)+1;
                endRecord=startRecord+pagingAccounts[ListIndex].size()-1;
            }
        }            
    
    }
    public PageReference backToMyGEAccounts(){
    String ViewId;
     List<GE_HQ_Acc_AccPlan_Rel__c> Accplan = new List<GE_HQ_Acc_AccPlan_Rel__c>();
       String keyPref = GE_HQ_Acc_AccPlan_Rel__c.getsObjectType().getDescribe().keyPrefix;
        List<SelectOption> views = new ApexPages.StandardSetController(Accplan).getListViewOptions();
        For(SelectOption v: views)  If(v.getLabel() == ViewName) { ViewId = v.getValue(); break; }
        // Redirect to the Planned Account object.
        redUrl= (ViewId != Null) ? new PageReference('/'+keyPref+'?fcf='+ViewId.substring(0,15)) : new PageReference('/'+keyPref+'/o');
        redUrl.setRedirect(True);
        Return redUrl;
    }
    */
}