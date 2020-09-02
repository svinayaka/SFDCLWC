@istest(seealldata=true)
private class GE_OG_MCTS_CaseEditControllerTest
{
    static testmethod void testDynamicPicklist()
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
        case c = new case();        
        c.GE_OG_CIR_Site_Country__c='AFGHANISTAN';        
        C.GE_OG_Business_CIR__c='TMS';        
        c.GE_ES_Sub_Type__c='MCS Sub Status';   
        c.accountid=null;   
        c.GE_OG_CIR_Unit_Serial_number__c=gi.id;  
        insert c; 

        apexpages.currentpage().getparameters().put('id',c.id);
        apexpages.standardcontroller  sc = new apexpages.standardcontroller(c); 
        GE_OG_MCTS_CaseEditController ge = new GE_OG_MCTS_CaseEditController(sc);
        
        ge.assembly='Radiography';
        ge.component='Digital X-ray';
        ge.item='CR100';
        ge.itemdescription='NA';
        ge.itemdescription='NA';
        ge.autorun();
        
        ge.getcomponentsSelectList();
        ge.getitemsSelectList1();
        ge.getitemdescriptionsSelectList1();
        ge.getitemdescription1sSelectList1();
        ge.makeNullValues();
        ge.makeNullValues1();
        ge.makeNullValues2();
        ge.makeNullValues3();
        ge.makeNullValues4();
        ge.makeNullValues5();
        ge.savecase();
    
    
    
    
    }


}