/*    
Class Name        : GE_MCS_ChangeOwner
Purpose/Overview  : Close all task when case has closed
Author            : Rajakumar Malla
Created Date      : 18 Jan 2013
Test Class        : GE_MCS_ChangeOwner_Test
*/
/*
Modified the Class for the Requriement R-21360

*/


public class GE_MCS_ChangeOwner 
{   public Id CaseId {get;set;}
    //public String CaseId {get;set;}
    public String UserId {get;set;}
    public String Action {get;set;}
    public String ErrorMsg {get;set;} 
    public boolean isBlank_SubType{get;set;}
    public boolean ccuser{get;set;}
    public boolean isBlank_PreOwner{get;set;}
    public static boolean fromVF = true;
    
    
    PageReference caseUrl;
    
    public GE_MCS_ChangeOwner()
    {
        Action = ApexPages.currentPage().getParameters().get('Action'); 
        CaseId = ApexPages.currentPage().getParameters().get('CaseId');  
       // CaseId = ESAPI.encoder().SFDC_HTMLENCODE(CaseId);
       // CaseId= string.escapesinglequotes(CaseId);  
        caseUrl = new PageReference('/'+CaseId);   
        
    }
    
    Public pageReference reDirect() 
    {    System.debug('Action is-----'+Action);
     fromVF = false;
     ccuser = false;
     If(Action == 'Accept') return ChangeOwnerName();
     else If(Action == 'Return')return PrevOwnerName(); 
     else if(Action == 'ccuser') 
     {
         ccuser = true;
         //return CaseUrl;
     }       
     caseUrl.setRedirect(True);        
     return caseUrl ; 
     
    }
    
    Public PageReference ChangeOwnerName() 
    {
        id MCSRecordTypeID = Schema.SObjectType.Case.getRecordTypeInfosByName().get('MCS - CS').getRecordTypeId(); 
        id Mctsid = Schema.SObjectType.Case.getRecordTypeInfosByName().get('MC-TS').getRecordTypeId();
        Case CaseId = [select RecordTypeId,status , GE_ES_Sub_Type__c, OwnerId from case where id =:CaseId];
        isBlank_SubType = false ;    
        
        /* if(CaseId.GE_ES_Sub_Type__c == null && (CaseId.RecordTypeId ==  MCSRecordTypeID  )){
        isBlank_SubType = true ;
        return null;
        }*/
        
        if(CaseId.recordtypeid==mctsid)
        {
            CaseId.status ='Open';
        }
        
        CaseId.Ownerid = UserInfo.getUserId();
        //Try {
        isBlank_SubType = false ; 
        fromVF = false;
        update CaseId;
        return caseUrl;
        // }
        // Catch(DMLException e) {            
        //ErrorMsg  =   e.getdmlMessage(0);          
        //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getdmlMessage(0))); 
        //     return caseUrl;              
        //  }
        
    }
    Public PageReference PrevOwnerName() 
    {
        id MCSRecordTypeID = Schema.SObjectType.Case.getRecordTypeInfosByName().get('MCS - CS').getRecordTypeId();
        Case CaseId = [select RecordTypeId,status ,GE_OG_MCS_Previous_Owner__c, GE_ES_Sub_Type__c, OwnerId from case where id =:CaseId];
        if(CaseId.GE_OG_MCS_Previous_Owner__c!=null&&CaseId.RecordTypeId ==  MCSRecordTypeID )
        {
            CaseId.Ownerid =CaseId.GE_OG_MCS_Previous_Owner__c;
            
            
            //user u=[select id,name from user where id=:CaseId.GE_OG_MCS_Previous_Owner__c];
            //CaseId.OwnerId=U.id ;
            update CaseId;
        }
        else
        {
            isBlank_PreOwner=true;
            return null;    
        }
        return caseUrl;
    }
    
}