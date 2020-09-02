@isTest(SeeallData=True)
    public class GE_OG_MC_EventbeforeDelete_Test{
        Public Static TestMethod void E_OG_MC_EventbeforeDeleteTest(){
       
            List<Profile> ProfId = [select id,Name from Profile where name='GE_OG_SFDC_SMax_Gold--ReadOnly' limit 1];
            //String myprofile = ProfId[0].id;
           
            
            
               User userId1 = [SELECT id,name FROM USER WHERE profileId =:ProfId limit 1];
               
         
                                
            SVMXC__SVMX_Event__c svmxevent=new SVMXC__SVMX_Event__c();
            svmxevent.Name='Test';
            svmxevent.SVMXC__StartDateTime__c=Date.newInstance(2015, 1, 3);
            svmxevent.SVMXC__EndDateTime__c=Date.newInstance(2015, 1, 4);
            Insert svmxevent;
            SVMXC__SVMX_Event__c sobj = new SVMXC__SVMX_Event__c(
  Name = '1LO-150002776 Duke Energy - Vermillion Generating Stm HMI: north',// Subject
  SVMXC__StartDateTime__c=Date.newInstance(2015, 1, 3),
  SVMXC__EndDateTime__c=Date.newInstance(2015, 1, 4)
);
insert sobj;
       
List<SVMXC__SVMX_Event__c> eventslist=new List<SVMXC__SVMX_Event__c>();
eventslist.add(svmxevent);
eventslist.add(sobj);
//GE_HQ_WorkorderTechUnAssignment ob=new GE_HQ_WorkorderTechUnAssignment();
//GE_HQ_WorkorderTechUnAssignment.getTechnicianEmail(eventslist);
              
             try{
            delete sobj;
             }
             catch(Exception ex)
             {
                 
             }
           //System.assertEquals(false,svmxevent.Id == null);
      
 }
 }