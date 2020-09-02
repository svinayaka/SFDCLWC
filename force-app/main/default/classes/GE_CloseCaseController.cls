/*    
Class Name      : GE_CloseCaseController
Purpose/Overview  : Ability to close multiple activities at ones.
Author            : Lakshmi Prasanna Kethu
Created Date      : 28 Jan 2013
Test Class        : GE_CloseCaseController_Test
*/
public with sharing class GE_CloseCaseController
{
    public String caseid{get;set;}
    public GE_CloseCaseController(ApexPages.StandardController controller) 
    {

    }
    
    public pageReference originalpage() 
    {
         caseid = apexpages.CurrentPage().getParameters().get('id');
         PageReference orpage = new PageReference('/'+caseid+'/s?cas7=Closed&nooverride=1&retURL=/'+caseId);
         orpage.setRedirect(true);
         return orpage;             
    }
    
}