public with sharing class OG_FA_Content_Display_On_Contract{
    public List <ContentVersion> contentList {get; set;}
    //public string conTier2Split 
    public Contract contract1;
    string userTier1;
    string userTier2;
    string contractTier2;
    public boolean viewAccess{get;set;}
    string contractPermissionSetId;
    //string pSetAssignment;
    List<PermissionSetAssignment> pSetAssignment = new List<PermissionSetAssignment>();
    
    public OG_FA_Content_Display_On_Contract(ApexPages.standardController controller){
        this.contract1=(Contract)controller.getRecord();
        this.viewAccess =false;
    }
    
    public void init(){
        
        try{
            //Get the Tier values for User and Contract
            string contractTier2 = [select GE_HQ_Buss_Tier1__c from Contract where id=:contract1.id limit 1].GE_HQ_Buss_Tier1__c;
            
            //As GE_HQ_Buss_Tier1__c is Multi select Picklist so we need to divide in Array.
            string[] Tier2Array = new string[]{};
                
                if(contractTier2 != null){
                    Tier2Array = contractTier2.split(';');
                }
            
            
            system.debug('Contract tier 2---' +contractTier2);
            
            string userId = userInfo.getUserID();
            System.debug('*********'+userId);
            string userTier1 = [select GE_HQ_Tier_1_P_L__c from User where id=:userId limit 1].GE_HQ_Tier_1_P_L__c;
            string userTier2 = [select GE_HQ_Tier_2_P_L__c from User where id=:userId limit 1].GE_HQ_Tier_2_P_L__c;
            system.debug('User Tier 1---' +userTier1);
            system.debug('User Tier 2---' +userTier2);
            
            //Id profileid = [select id from Profile where Name =:'GE_HQ Account Director' LIMIT 1].id;
            Id profileid = [select id from Profile where Name =:'OG_Sales/Comm Ops' LIMIT 1].id;
            
            Id Userprofid = [select profileId from User where id=:userid limit 1].profileId;
            
            
            //fetch ID of FA Manager permission set
            string contractPermissionSetId = [select Id from PermissionSet where Label = 'FA Manager'].Id;
            // fetch all user assignments of this permission set
            
            pSetAssignment = [select Id , AssigneeId from PermissionSetAssignment where PermissionSetId =: contractPermissionSetId];
            
            boolean MatchedTier2 = false ;
            
            if(userTier2 != null && contractTier2 != null){
                
                for( string tier2 :  Tier2Array){
                    if(userTier2.contains(tier2) ){
                        MatchedTier2 = true ;
                        break;
                    }
                }
                
                
                
                if( MatchedTier2 == true){
                    system.debug('Tier 2 equated------');
                    //iterate the contents from the library
                    contentList = [Select Title,ContentDocumentId,GE_ES_PnL__c,ContentModifiedById,ContentModifiedDate from ContentVersion where ContentVersion.GE_ES_Contract__c =: contract1.id];
                    if(contentList.size() > 0){
                        this.viewAccess = true;
                    }    
                }
            }
            contentList = [Select Title,ContentDocumentId,GE_ES_PnL__c,ContentModifiedById,ContentModifiedDate from ContentVersion where ContentVersion.GE_ES_Contract__c =: contract1.id];            
            if(profileid == Userprofid)
            {
                if(contentList.size() > 0 ){
                    this.viewAccess = true;
                } 
                system.debug('Account DIrector profile----------'+this.viewAccess+'List Size+++'+contentList.size());
            }
            
            for(PermissionSetAssignment psa : pSetAssignment)
            {
                System.debug(psa);
                //String psaID = psa.Id;
                try{
                    if(psa.AssigneeId != null)
                    {
                        System.debug(psa.Id);
                        String appId = 'id'+psa.AssigneeId;
                        if(userTier1=='HQ' || appId.contains(userId)){
                            //iterate the contents from the library
                            System.debug('***********iterate the contents from the library*********');
                            if(contentList.size() > 0 ){
                                this.viewAccess = true;
                            }    
                            system.debug('in HQ----------'+this.viewAccess+'List Size+++'+contentList.size());
                        }
                    }
                }catch(Exception e)
                {
                    System.debug(e);
                }
                
            }
            
            
            
            
        }catch(exception e){}
    }             
}