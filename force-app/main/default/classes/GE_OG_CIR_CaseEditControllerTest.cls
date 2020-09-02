@istest(seeAlldata=true)
private class GE_OG_CIR_CaseEditControllerTest
{

    static testmethod void caseeditControllerTest()
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
        c.GE_OG_Business_CIR__c='Digital Solutions';
        c.GE_OG_Sub_Business_CIR__c='Control Solutions';
        c.GE_OG_CIR_Assembly__c='Controls Connect Support';
        c.GE_OG_CIR_Component__c='Health Advisor Request';    
        c.GE_OG_CIR_Item__c='NA';
        c.GE_ES_Sub_Type__c='MCS Sub Status';   
        c.accountid=null;   
        c.status='New';
        c.GE_OG_CIR_Unit_Serial_number__c=gi.id;  
        insert c; 

        apexpages.currentpage().getparameters().put('id',c.id);
        apexpages.standardcontroller  sc = new apexpages.standardcontroller(c); 
        
        GE_OG_CIR_CaseEditController ge = new GE_OG_CIR_CaseEditController(sc);
        ge.Businesscir='Digital Solutions';
        ge.SubBusinesscir='Control Solutions';
        ge.assembly='Controls Connect Support';
        ge.getcomponentsSelectList();
        ge.component='Health Advisor Request'; 
        ge.getitemsSelectList1();
        ge.item='NA';
        set<String> s= new Set<String>();
        List<GE_OG_Product_Hierarchy1__c> phlist = new List<GE_OG_Product_Hierarchy1__c>();
        s.add(ge.component);
        ge.cancel();

        ge.save(); 
        
        pagereference pg=ge.makeNullValues();
        pagereference pg1=ge.makeNullValues1();
        pagereference pg2=ge.makeNullValues2();
        pagereference pg3=ge.makeNullValues3();
        pagereference pg4=ge.makeNullValues4();
        pagereference pg6=ge.makeNullValues6();
        pagereference pg7=ge.makeNullValues7();
        ge.subbusinessToController();
        ge.jobtypeToController();
        ge.businessToController();
        test.stoptest();

    }
 
        static testmethod void caseeditControllerTest1()
        {
        test.starttest();       
        Account a = [select Id, Name from Account where name = 'TestClassAccount'];
        GE_Installed_Base__c gi = new GE_Installed_Base__c();
        gi.name='test';
        gi.Account__c=a.id;
        insert gi;
        system.assertequals(gi.name,'test');

        case c = new case();        
        c.GE_OG_CIR_Site_Country__c='AFGHANISTAN';        
        c.GE_OG_Business_CIR__c='Digital Solutions';
        c.GE_OG_Sub_Business_CIR__c='Control Solutions';
        c.GE_OG_CIR_Assembly__c='Controls Connect Support';
        c.GE_OG_CIR_Component__c='Health Advisor Request';    
        c.GE_OG_CIR_Item__c='NA';     
        c.GE_ES_Sub_Type__c='MCS Sub Status';   
        c.accountid=a.id;   
        insert c; 
        apexpages.currentpage().getparameters().put('id',c.id);
        Apexpages.currentPage().getParameters().put('two','New Units');
        apexpages.standardcontroller  sc = new apexpages.standardcontroller(c);  
        GE_OG_CIR_CaseEditController ge = new GE_OG_CIR_CaseEditController(sc);
        ge.getcomponentsSelectList();
        ge.component='Fuses';
        ge.getitemsSelectList1();
        ge.cancel();
        ge.save(); 
        test.stoptest();
            }
  
    static testmethod void caseeditControllerTest_Duplicate()
    {
        test.starttest();
        Account a = [select Id, Name from Account where name = 'TestClassAccount'];
        GE_Installed_Base__c gi = new GE_Installed_Base__c();
        gi.name='test';
        gi.GE_ES_Station_Name__c='test';
        gi.Account__c=a.id;
        insert gi;
        system.assertequals(gi.name,'test');
        List<Case>csList=new List<Case>();
        case c = new case();        
        c.GE_OG_CIR_Site_Country__c='AFGHANISTAN';        
        c.GE_OG_Business_CIR__c='Digital Solutions';
        c.GE_OG_Sub_Business_CIR__c='Control Solutions';
        c.GE_OG_CIR_Assembly__c='Controls Connect Support';
        c.GE_OG_CIR_Component__c='Health Advisor Request';    
        c.GE_OG_CIR_Item__c='NA';        
        c.GE_ES_Sub_Type__c='MCS Sub Status';   
        c.accountid=null;           
        c.status='New';
        c.GE_OG_CIR_Unit_Serial_number__c=gi.id; 
        c.GE_OG_Escalation_Level_CIR__c='Priority'; 
        insert c; 
        /*
        csList.add(c);
        case cs = new case();        
        cs.GE_OG_CIR_Site_Country__c='AFGHANISTAN';        
        Cs.GE_OG_Business_CIR__c='TMS';        
        cs.GE_ES_Sub_Type__c='MCS Sub Status';   
        //c.accountid=null;   
        cs.accountid=a.id;   
        cs.status='New';
        cs.GE_OG_CIR_Unit_Serial_number__c=gi.id;  
        cs.GE_OG_Escalation_Level_CIR__c='Priority';
        csList.add(cs);
        insert csList;
        */
        apexpages.currentpage().getparameters().put('id',c.id);
        apexpages.standardcontroller  sc = new apexpages.standardcontroller(c);         
        GE_OG_CIR_CaseEditController ge = new GE_OG_CIR_CaseEditController(sc);         
        ge.Businesscir='Digital Solutions';
        ge.SubBusinesscir='Control Solutions';
        ge.assembly='Controls Connect Support';
        ge.getcomponentsSelectList();
        ge.component='Health Advisor Request'; 
        ge.getitemsSelectList1();
        ge.item='NA';
        
        ge.cancel();
        ge.save(); 
        pagereference pg=ge.makeNullValues();
        pagereference pg1=ge.makeNullValues1();
        pagereference pg2=ge.makeNullValues2();
        pagereference pg3=ge.makeNullValues3();
        pagereference pg4=ge.makeNullValues4();
        pagereference pg6=ge.makeNullValues6();
        pagereference pg7=ge.makeNullValues7();
        ge.subbusinessToController();
        ge.jobtypeToController();
        ge.businessToController();        
        test.stoptest();
    }
    static testmethod void caseeditControllerTest_DuplicateOne()
    {
        test.starttest();
        Account a = [select Id, Name from Account where name = 'TestClassAccount'];
        GE_Installed_Base__c gi = new GE_Installed_Base__c();
        gi.name='test';
        gi.GE_ES_Station_Name__c='test';
        gi.Account__c=a.id;
        insert gi;
        system.assertequals(gi.name,'test');
        List<Case>csList=new List<Case>();
        case c = new case();        
        c.GE_OG_CIR_Site_Country__c='AFGHANISTAN';        
        c.GE_OG_Business_CIR__c='Digital Solutions';
        c.GE_OG_Sub_Business_CIR__c='Inspection Technologies';
        c.GE_OG_CIR_Assembly__c='Radiography';
        c.GE_OG_CIR_Component__c='CT (Computed Tomography)';    
        c.GE_OG_CIR_Item__c='NA';        
        c.GE_ES_Sub_Type__c='MCS Sub Status';   
        c.accountid=null;           
        c.status='New';
        c.GE_OG_CIR_Unit_Serial_number__c=gi.id; 
        c.GE_OG_Escalation_Level_CIR__c='Priority'; 
        insert c; 
        
        apexpages.currentpage().getparameters().put('id',c.id);
        apexpages.standardcontroller  sc = new apexpages.standardcontroller(c);         
        GE_OG_CIR_CaseEditController ge = new GE_OG_CIR_CaseEditController(sc);         
        ge.Businesscir='Digital Solutions';
        ge.SubBusinesscir='Inspection Technologies';
        ge.assembly='Radiography';
        ge.getcomponentsSelectList();
        ge.component='CT (Computed Tomography)'; 
        List<SelectOption> selList = ge.getitemsSelectList1();
        ge.item='NA';
        
        ge.cancel();
        ge.save(); 
        pagereference pg=ge.makeNullValues();
        pagereference pg1=ge.makeNullValues1();
        pagereference pg2=ge.makeNullValues2();
        pagereference pg3=ge.makeNullValues3();
        pagereference pg4=ge.makeNullValues4();
        pagereference pg6=ge.makeNullValues6();
        pagereference pg7=ge.makeNullValues7();
        ge.subbusinessToController();
        ge.jobtypeToController();
        ge.businessToController();        
        test.stoptest();
    }
    
    static testmethod void caseeditControllerTest_DuplicateTwo()
    {
        test.starttest();
        Account a = [select Id, Name from Account where name = 'TestClassAccount'];
        GE_Installed_Base__c gi = new GE_Installed_Base__c();
        gi.name='test';
        gi.GE_ES_Station_Name__c='test';
        gi.Account__c=a.id;
        insert gi;
        system.assertequals(gi.name,'test');
        List<Case>csList=new List<Case>();
        case c = new case();        
        c.GE_OG_CIR_Site_Country__c='AFGHANISTAN';        
        c.GE_OG_Business_CIR__c='Turbomachinery & Process Solutions';
        c.GE_OG_Sub_Business_CIR__c='PVS';
        c.GE_OG_CIR_Assembly__c='PUMP';
        c.GE_OG_CIR_Component__c='Not Listed';    
        c.GE_OG_CIR_Item__c='NA';        
       
        c.GE_OG_CIR_M_C_Location_of_Mfg_Service__c='Bari';
        c.accountid=null;           
        c.status='New';
        c.GE_OG_CIR_Unit_Serial_number__c=gi.id; 
        c.GE_OG_Escalation_Level_CIR__c='Priority'; 
        insert c; 
        
        apexpages.currentpage().getparameters().put('id',c.id);
        apexpages.standardcontroller  sc = new apexpages.standardcontroller(c);         
        GE_OG_CIR_CaseEditController ge1 = new GE_OG_CIR_CaseEditController(sc);         
        ge1.Businesscir='Turbomachinery & Process Solutions';
        ge1.SubBusinesscir='PVS';
        ge1.assembly='PUMP';
        ge1.getcomponentsSelectList();
        ge1.component='Not Listed'; 
        List<SelectOption> selList = ge1.getitemsSelectList1();
        ge1.item='NA';
        
        ge1.cancel();
        ge1.save(); 
        pagereference pg=ge1.makeNullValues();      
        test.stoptest();
    }
}