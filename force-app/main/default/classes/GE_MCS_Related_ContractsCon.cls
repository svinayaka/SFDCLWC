/*Purpose/Overview : Requirement R-19211 Display related contracts for master detail and lockup relation for Contract records using this class in GE_MCS_Related_Contracts visulaforce page.
Functional Area :M&C SFDC
Author: Naveen Vuppu
Created Date: October 24, 2014
Test ClassName: GE_MCS_Related_ContractsConTest   
Modified By : 
Modified Date:
Reason:- 
*/
public class GE_MCS_Related_ContractsCon {
public GE_MCS_Related_ContractsCon() {
}

  /*  private List<GE_MCS_Related_Contract__c> contrz;
    public GE_MCS_Related_Contract__c editConRole { get; set; }
    private Contract cntact;
    Public Boolean psrender{get; set;}
    public String userid{get;set;}
    public GE_MCS_Related_ContractsCon(ApexPages.StandardController controller) {
            this.cntact=(Contract)controller.getRecord();
            userid = Userinfo.getUserId();
        list<PermissionSetAssignment> assignedps = new list<PermissionSetAssignment>();
        id id1 = [select id from permissionset where name = 'GE_Support_Contract_Access' limit 1].id; 
        assignedps  = [select Id from PermissionSetAssignment where AssigneeId =:userid and PermissionSetId =: id1];
        if(assignedps.size()>0){
        psrender=true;
        }
        else
        {
        psrender = false;
        
        }
       
        
    }
    // Display all related contract records functionality
    public List<GE_MCS_Related_Contract__c> getcontrz()
    {
        Contract con = [Select id,Name FROM Contract where id =:cntact.id];
        
                
        if(con.id==null)
            return null;
        contrz = [Select id, Name, GE_MCS_Contract_Lookup__c, GE_MCS_Contract_Master__c, GE_MCS_Relationship__c from GE_MCS_Related_Contract__c where GE_MCS_Contract_Lookup__r.id =: con.Id or GE_MCS_Contract_Master__r.id =:con.Id ];
        return contrz;
    }
    // Delete related contract record functionality
    public Pagereference deleteRcontr()
    {
        String contrid= ApexPages.currentPage().getParameters().get('contrid');    
        GE_MCS_Related_Contract__c contr = [Select id from GE_MCS_Related_Contract__c where id =:contrid limit 1];
        if(contr !=null && contr.id !=null){
            delete contr;
        }
        return null;
    }
    //Edit related contract record functionality
    public Pagereference editContr()
    {
        Contract con = [Select id,Name FROM Contract where id =:cntact.id];
        String contrid= ApexPages.currentPage().getParameters().get('contrid'); 
        PageReference neweditcont = new PageReference('/'+contrid+'/e?retURL=/'+con.id);
        neweditcont.setRedirect(true);
        return neweditcont;
    }
    //New related contract record functionality
    public Pagereference NewContr()
    {
        Contract con = [Select id,Name FROM Contract where id =:cntact.id]; 
        //PageReference newcont = new PageReference('/a6e/e?CF00Ng0000000rIAZ='+con.Name+'&retURL=/'+con.id+'&saveURL=/'+con.id);
       PageReference newcont = new PageReference('/a6g/e?CF00NZ0000001WRok='+con.Name+'&retURL=/'+con.id+'&saveURL=/'+con.id); 
        newcont.setRedirect(true);
        return newcont;
    }*/
}