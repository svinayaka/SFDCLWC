/**********************************************************************
Class Name : GE_SS_Labor_Atchmnts_workdtls_moblizeWO
Test Class Name : GE_SS_Creating_TaskWorkDtls_Test
Created By : Raju Manche
Dated : 28/Nov/2017
Description:R-23728 - SS-Oracle ERP Integration Part 2/3-Integration changes

*//////////////////////////////////////////////////////////////////////////////////////////
public class GE_SS_Labor_Atchmnts_workdtls_moblizeWO{
    
    public List<Attachment> lsttoolfrWD{get; set;}
    public String woParentName{get;set;}
    public Id Aid {get;set;}
    public String idval{get;set;}
    public String redirectURL{get;set;}
    public boolean recordSize{get;set;}
    public String allRec{get;set;}
    
    public GE_SS_Labor_Atchmnts_workdtls_moblizeWO(ApexPages.StandardController controller) {
        System.debug('in controller');
        recordSize=false;
        lsttoolfrWD = new list<Attachment>();
        
        Aid = ApexPages.currentPage().getParameters().get('id');
        allRec = ApexPages.currentPage().getParameters().get('allrec');
        //woParentName=[select id,name from SVMXC__Service_Order__c  where id=:Aid].Name;
        woParentName = ' Service Ticket Report';
        
        init();
    }
    
    public void deleteRec() {
        system.debug('---- '+idval);
        Id Id1 = Id.valueOf(idval);
        Attachment rec = new Attachment(id=Id1);
        delete rec;
        init();
    }
    
    public void init() {
        string s1 = '%'+woParentName+'%';
        if(allRec == 'true') {
            //String squery='select Id, Name, ContentType, Body from  Attachment where ParentId=: Aid and name like'%'+woParentName+'%' order by name desc';
            
            lsttoolfrWD= [select Id, Name, ContentType,LastModifiedDate,CreatedBy.name,Description,BodyLength, Body from  Attachment where ParentId=: Aid and name like :s1  order by name desc];
        }
        else if(Aid != null){
            lsttoolfrWD= [select Id, Name, ContentType,LastModifiedDate,CreatedBy.name,Description,BodyLength,  Body from  Attachment  where ParentId=: Aid  and name like :s1 order by name desc LIMIT 5];
            List<Attachment> lsttoolfrWDAll = [select Id, Name,LastModifiedDate,CreatedBy.name, Description,BodyLength, ContentType, Body from Attachment where ParentId=: Aid and name like :s1 order by name desc];
            if(lsttoolfrWDAll.size() > 5)
                recordSize = true;
            else
                recordSize = false;
        }
    }
    
}