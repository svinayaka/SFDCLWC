public class GE_OG_NewTech_UsrNotFoundExt {

	private ApexPages.StandardController sc;
    private SVMXC__Service_Group_Members__c technician; 
    private boolean validId = false;
    
    public Schema.SObjectType objType {get;set;}
    
    public Id recId {
            get{
                if(apexpages.currentpage().getparameters().get('techId')==null)
                    recId='';
                else
                    recId =apexpages.currentpage().getparameters().get('techId');                
                return recId;
            }
            set;}
    
    public GE_OG_NewTech_UsrNotFoundExt (ApexPages.StandardController sc) {
        this.sc = sc;
        recId =apexpages.currentpage().getparameters().get('techId');
        if(recId != null){
            objType = recId.getSobjectType();
            if(objType == Schema.SVMXC__Service_Group_Members__c.getSObjectType()){
                System.debug('Object Type: ' + objType);
                validId = true;
            }
        }
        else
            System.debug('Bad URL parameter - not a technician type ID');
                
    }
    
    public PageReference submit(){
        If(validId){
            String url = '/'+recId;
            System.debug('In Submit If condition: want to go to ');
            return (new PageReference (url));
        }
            
        else{
         	System.debug('In Submit Else condition');   
            return (new PageReference ('/'));
        }
    }
}