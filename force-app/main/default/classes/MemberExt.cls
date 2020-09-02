public class MemberExt {
    
    public List<TM_Price_Proposal__c> memList {get;set;}
    public ApexPages.StandardSetController standardController;
    public Id memId{get;set;}
    public boolean show_LC{get;set;}
    public boolean Hide_LC{get;set;}
    
    public MemberExt(ApexPages.StandardSetController standardController){
        show_LC=false;
        Hide_LC=false;
        this.standardController = standardController;
        
        
    }
    public PageReference init() {
        PageReference result;
        
        if(standardController.getSelected().size()==0){
            Hide_LC=true;
          
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'Select a Record and Try Again'));
            
            
        }else if(standardController.getSelected().size()>1){
            Hide_LC=true;
           
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'Select only One Record and Try Again '));
            
        }else{
            show_LC=true;
            Hide_LC=false;
            for (TM_Price_Proposal__c mem : (List<TM_Price_Proposal__c>)standardController.getSelected()){ 
                memId=mem.Id;
            }
        }
        
        return result;
    }
    public PageReference cancel() {
        PageReference cancel = standardController.cancel();
        return cancel;
    }
    public PageReference  apexMethod() {
        String para = Apexpages.currentPage().getParameters().get('node');
        memId=para;
        PageReference pf;
        // pf.setRedirect(true);
        return pf;
    }
    @AuraEnabled
    public static string getInsertRecord(TM_Price_Proposal__c ref) { 
        
        insert ref;
        if(ref.Id!=null){
            return ref.Id;
        }else{
            return null;
        }
    }
    public PageReference getAddToFavorite() { 
        PageReference result;   
        
        if(standardController.getSelected().size()==0){
            Hide_LC=true;
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'Select a Record and Try Again'));
            
            
        }else{
            show_LC=true;
            Hide_LC=false;
            HttpRequest req = new HttpRequest();
            Http http = new Http();
            string point=Url.getOrgDomainUrl().toExternalForm()+
                    '/services/data/v45.0/ui-api/favorites';
            req.setHeader('Authorization', 'OAuth ' + UserInfo.getSessionId());
            req.setHeader('Content-Type','application/json');
            req.setMethod('GET');
            req.setEndpoint(point);
            
            List<TM_Price_Proposal__c> selectedlist=(List<TM_Price_Proposal__c>)standardController.getSelected();
            for (TM_Price_Proposal__c mem :[select id,name from TM_Price_Proposal__c where id =:selectedlist ]){ 
                
                Map<String,String> postBody = new Map<String,String>();
                postBody.put('name',mem.Name);
                postBody.put('target',mem.Id);
                postBody.put('targetType','Record');
                String reqBody = JSON.serialize(postBody);
                system.debug('reqBody'+reqBody);
                req.setBody(reqBody);
                
                HTTPResponse res = http.send(req);
                
                system.debug(res);
            }
           ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM, 'Record Added To Favorite')); 
        }
       
        return result;
    }
}