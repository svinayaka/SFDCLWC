@istest
private class GE_OG_MCTStoCIR_CaseTransferCtrlTest
{
    static testmethod void testTransferCase()
    {
        test.starttest();
        account a = new account();
        a.name='test';
        insert a;
        
        GE_Installed_Base__c gi = new GE_Installed_Base__c();
        gi.name='test';
        gi.Account__c=a.id;
        insert gi;
         system.assertequals(gi.name,'test');
         
        GE_OG_Product_Hierarchy1__c p = new GE_OG_Product_Hierarchy1__c();
        p.GE_OG_MCS_Assembly__c = 'Remote Visual Inspection';
        p.GE_OG_MCS_Business__c = 'Subsea (SS)';
        p.GE_OG_MCS_Component__c ='Video Borescopes';
        p.GE_OG_MCS_Item_Description1__c='Air Hose';
        p.GE_OG_MCS_Item_Description__c ='Accessory';
        p.GE_OG_MCS_Item__c = 'Flying Probe';
        p.GE_OG_MCS_Sub_Business__c='Inspection Technologies';
        p.Name ='OG_Prod_Hier__1341';
        insert p;
        
        case c = new case();        
        c.GE_OG_CIR_Site_Country__c='AFGHANISTAN';        
        C.GE_OG_Business_CIR__c='TMS';        
        c.GE_ES_Sub_Type__c='MCS Sub Status';   
        c.accountid=null;   
        c.GE_OG_CIR_Unit_Serial_number__c=gi.id;  
        insert c; 

        apexpages.currentpage().getparameters().put('id',c.id);
        apexpages.standardcontroller  sc = new apexpages.standardcontroller(c); 
        GE_OG_MCTStoCIR_CaseTransferController ge = new GE_OG_MCTStoCIR_CaseTransferController(sc);
        case Cs= ge.cObject;
        Boolean Ad = ge.refreshPage;
        String x= ge.componentvalue;
        String x1= ge.itemvalue;
        
        ge.assembly = p.GE_OG_MCS_Assembly__c;
        ge.SubBusinesscir=p.GE_OG_MCS_Sub_Business__c;
        ge.Businesscir=p.GE_OG_MCS_Business__c;
        ge.component =p.GE_OG_MCS_Component__c;   
        ge.item = p.GE_OG_MCS_Item__c;
        ge.getitemsSelectList1();
        ge.getcomponentsSelectList();
        ge.component='Fuses';
        ge.getitemsSelectList1();
        ge.jobtypeToController();
        ge.businessToController();
        ge.subbusinessToController();
        ge.savecaseCir();
        
        ge.makeNullValues();
        Apexpages.currentPage().getParameters().put('two','Control Solutions');
        ge.makeNullValues1();
        
        Apexpages.currentPage().getParameters().put('two','FPT- Valve Projects');
        ge.makeNullValues1();
        ge.makeNullValues2();
        ge.makeNullValues3();
        ge.makeNullValues4();
        ge.subbusinessToController();
        ge.jobtypeToController();
        ge.businessToController();
    
    test.stoptest();
    
    }


}