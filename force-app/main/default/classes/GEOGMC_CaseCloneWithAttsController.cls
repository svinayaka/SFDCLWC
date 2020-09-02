/*
Type Name [Class/Trigger/Page Name] : Class - GEOGMC_CaseCloneWithAttsController
Purpose                             : Customize the standard clone functionality of Case Object
Overview                            : Include attachments when cloning an Case
Functional Area                     : Service
Author                              : RajaKumar Malla
Created Date                        : 16 Feb 2013
Test Class                          : GEOGMC_CaseCloneWithAttsControllerTest
Modified On/By                      : 24 June 2015 / By Avinash Choubey
Purpose                             : optimized code to prevent heap size error

*/

public without sharing class  GEOGMC_CaseCloneWithAttsController {
    
    
    String currentCaseId {get;set;}
    String whereClause{get;set;}
    String soql {get;set;}   
    String Subject {get;set;}
    String Subject1 {get;set;}
    String Subject2 {get;set;}
    Case ThreadId {get;set;}
    Integer position {get;set;}
    Case CloneCase {get;set;}
    Case CurrentCase{get;set;}
    
    
    public GEOGMC_CaseCloneWithAttsController (ApexPages.StandardController controller) {
        
        currentCaseId = ApexPages.currentPage().getParameters().get('Id'); 
        currentCaseId=String.escapeSingleQuotes(currentCaseId);
        whereClause= 'id=\''+currentCaseId +'\'';
        soql = GE_ES_Utils.getCreatableFieldsSOQL('Case', whereClause); 
        System.debug('soql :'+ soql );
        CurrentCase = (Case) Database.query(soql);
        System.debug('CurrentCase :'+ CurrentCase );        
        System.debug('currentCaseId----------'+currentCaseId);
        }
    
    public PageReference reDirect() {
       
        CloneCase = CurrentCase.clone(false, true);
        System.debug('CloneCase :'+ CloneCase );
        System.debug('Step0....a' );
        CloneCase.GE_HQ_SFDC_LEGACY_ID__c=null;
        CloneCase.Status=CurrentCase.Status;
        CloneCase.Legacy_Thread_ID__c= null;
        CloneCase.GE_HQ_LEGACY_AUTONUM__c= null;
        CloneCase.ClosedDate = null;
        CloneCase.Case_Age_Buffer__c=0;
        
        id rt=null;
        String rtname = '';
        System.debug('$$$$$ CurrentCase record type of case $$$'+ CurrentCase.recordTypeId);
       
        for(RecordType allrt : [select id,name from recordtype where sObjectType = 'Case' and Name in ('DS - CSR','MCS - CS')]) 
        {
            System.debug('$$$$$ Enter in record type of case $$$'+ allrt.Id);
            If( CurrentCase.RecordTypeId == allrt.Id)
                
            {               
                rt = allrt.id;
                rtname = allrt.name;
                CloneCase.GE_ES_IsueStrtDt__c = System.Today();                     
                
                If( CloneCase.Status == 'Closed'|| CloneCase.Status == 'Reopen' )
                {
                    CloneCase.Status = 'Open';
                    //CloneCase.Case_Age_Buffer__c=0;
                    
                }      
                
            }
            
        }    
        
        System.debug('Step0....b' );
        
        try {
            insert CloneCase ; 
        } catch (DmlException e) {
            System.debug('The following exception has occurred: ' + e.getMessage());
            return null;
        }
        
          System.debug(LoggingLevel.ERROR, 'Heap Size: ' + Limits.getHeapSize());  
         
       List<Attachment> insertAttList = new  List< Attachment>();
       Attachment att1;
            
        for(Attachment a: [select id, name, body from Attachment where ParentId = :currentCaseId ])
                {
                    att1 = new Attachment(name = a.name, body = a.body,  parentid = CloneCase.id);
                    insertAttList.add(att1);
                }
            System.debug(LoggingLevel.ERROR, 'Heap Size: ' + Limits.getHeapSize());   
/*if(Limits.getHeapSize() > = (Limits.getLimitHeapSize()-1000))
          {
              throw new TypeException() ;
              
              
          } */      
            List<FeedItem> insertFeedItem = new List<FeedItem>();
            FeedItem fi2 ;
            for(FeedItem ft: [Select Body,CommentCount,ContentData,ContentDescription,ContentFileName,ContentSize,ContentType,CreatedById,CreatedDate,Id,InsertedById,IsDeleted,LastModifiedDate,LikeCount,LinkUrl,ParentId,RelatedRecordId,SystemModstamp,Title,Type FROM FeedItem where ParentId = :currentCaseId and Type ='ContentPost'])
            {
                 fi2 = new FeedItem();
                fi2.body = ft.body;
                fi2.RelatedRecordId = ft.RelatedRecordId;
                fi2.Title = ft.Title;
                fi2.Type = ft.Type;
                fi2.ParentId = CloneCase.Id;
                insertFeedItem.add(fi2);
            }      
            System.debug(LoggingLevel.ERROR, 'Heap Size: ' + Limits.getHeapSize());
        
            if(insertFeedItem  != null && insertFeedItem.size() >0 ){
                insert insertFeedItem;
            }
       
           
            ThreadId = [select Id, GE_CASE_THREAD_ID__C from Case where Id = :CloneCase.Id ];
          
            Map<Id, EmailMessage> emList = new Map<Id, EmailMessage>();
             EmailMessage em2 ;
            for(EmailMessage em: [Select Id,FromAddress,FromName,MessageDate,Incoming,ToAddress,ParentId,CcAddress,BccAddress,Subject,TextBody,ActivityId,Status from EmailMessage where ParentId = :currentCaseId])
            {
                 em2 = new EmailMessage();
                em2.TextBody = em.TextBody;
                em2.FromAddress = em.FromAddress;
                em2.FromName = em.FromName;
                em2.MessageDate = em.MessageDate;
                em2.ToAddress = em.ToAddress;
                em2.CcAddress = em.CcAddress;
                em2.BccAddress = em.BccAddress;
                em2.ParentId = CloneCase.Id;
                em2.Status = em.Status;
                em2.Incoming =  em.Incoming;
                
                system.debug('Subject id------'+em.Subject); 
                if(em.Subject!=null)
                {                 
                    Subject = em.Subject;
                    If(Subject.contains('[ ref:')){
                        Position = Subject.Indexof('[ ref:');
                        Subject1 = Subject.Left(Position);
                        Subject2 = Subject.Right(Subject.Length()-Position-31);
                        em2.Subject = Subject1 + ' '+ ThreadId.GE_CASE_THREAD_ID__C+ ' '+ Subject2;
                    }
                    else{
                        em2.Subject = em.Subject;
                    }
                }
                emList.put(em.Id, em2);
                
               } 
            System.debug(LoggingLevel.ERROR, 'Heap Size: ' + Limits.getHeapSize());
            
            if(emList != null && emList.size()>0) {
                insert emList.values();
                for(Attachment a : [select id, name, ParentId, body from Attachment where ParentId in :emList.keySet()]){
                    if(emList.containsKey(a.ParentId)){
                        Attachment att2 = new Attachment(name = a.name, body = a.body,  parentid = emList.get(a.ParentId).id);    
                        insertAttList.add(att2);
                    }                             
                }
               
            }
            
            
            if(insertAttList != null & insertAttList.size() > 0)
            {
                insert insertAttList;
            }
         
        System.debug('rrrrrr CloneCase :'+ rtname);
        System.debug(LoggingLevel.ERROR, 'Heap Size: ' + Limits.getHeapSize());
        if(CloneCase.RecordTypeId==rt){ 
            if(rtname!='MCS - CS')
            {                  
                
                PageReference redirect = new PageReference('/'+CloneCase.id+'/e?retURL=%2F'+CloneCase.id);
                System.debug('$$redirect'+redirect);        
                redirect.setRedirect(true);
                return redirect;
            }        
            else{
                System.debug('$$Rec typemcs'+CloneCase.RecordType.Name);
                PageReference redirect = new PageReference('/'+CloneCase.id);                
                redirect.setRedirect(true);
                return redirect; 
            }       
        }
        else{
            System.debug('$$Rec typemcs'+CloneCase.RecordType.Name);
            PageReference redirect = new PageReference('/'+CloneCase.id);            
            redirect.setRedirect(true);
            return redirect; 
        }
        
    
    
    
    
    }
}