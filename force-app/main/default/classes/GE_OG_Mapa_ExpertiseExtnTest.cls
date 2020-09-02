@isTest
public class GE_OG_Mapa_ExpertiseExtnTest {
    
    public static testmethod void testMapaExpertise(){
        
        System.Test.startTest();
        GE_OG_GS_Fit_For_Job__c cs = GE_OG_GS_Fit_For_Job__c.getInstance('Record Types List');
        if(cs == NULL){
            cs = new GE_OG_GS_Fit_For_Job__c();
            cs.Name ='Record Types List';
            cs.GE_OG_GS_Record_Types_To_Apply__c = 'GS-Requirement';
            insert cs;
        }
        
        SVMXC__SVMX_Event__c event = new SVMXC__SVMX_Event__c();
        event.SVMXC__StartDateTime__c= System.today();
        event.SVMXC__EndDateTime__c=System.today() +10;
        event.Name='Apex test';
        
        insert event;
        
        MFSI_FormatDateTime MF1 = new MFSI_FormatDateTime();
        MF1.dateTimeValue = DateTime.newInstance(1997, 1, 31, 7, 8, 16);
        String result = MF1.getTimeZoneValue();
        MFSI_FormatDateTime MF2 = new MFSI_FormatDateTime();
        result = MF2.getTimeZoneValue();
        
        
        //Apexpages.StandardController sc = new Apexpages.StandardController();
        PageReference expertisePage = Page.GE_OG_Mapa_Expertise;
        Test.setCurrentPage(expertisePage);
        System.currentPageReference().getParameters().put('recordId',event.Id);
        GE_OG_Mapa_ExpertiseExtn controller = new GE_OG_Mapa_ExpertiseExtn();
        controller.getSkillInfo();
        List<SVMXC__Service_Group_Skills__c> sMaxExpertiseList = controller.getSMaxExpertiseList();    
        List<SVMXC__SVMX_Event__c> sMaxEventList = controller.getSMaxEventList();
        
        System.Test.stopTest();
        
    }
}