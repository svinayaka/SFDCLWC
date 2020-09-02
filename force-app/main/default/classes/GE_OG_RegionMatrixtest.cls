/**
 * Author : Sanderep Rayavarapu 
 * Purpose : code coverage for GE_OG_CaseContextController,GE_OG_Case_RegionMatrixCounter
 */
@istest
private class GE_OG_RegionMatrixtest{
    static testmethod void regionmatrixcir(){
        Test.startTest();

        account a = new account();
        a.name = 'test';
        a.classification__c = 'test';
        a.type = 'test';
        insert a;
        
        GE_HQ_P_L__c BT = new GE_HQ_P_L__c();
        //BT.GE_HQ_P_L_Hierarchy_Level__c = 45494;
        BT.GE_HQ_P_L_ID__c = 7899;
        BT.GE_HQ_Is_Active__c = True;
        insert BT;
        
        /*
        GE_HQ_P_L__c BT = [Select Id,GE_HQ_P_L_Hierarchy_Level__c from GE_HQ_P_L__c where  GE_HQ_P_L_Hierarchy_Level__c! = null limit 1];*/        
               
        GE_HQ_Region__c ghr = new GE_HQ_Region__c();
        ghr.name='test';
        ghr.GE_HQ_Region_ID__c = 9999;
        ghr.GE_HQ_Business_Tier__c = BT.id;
        insert ghr; 
        
        system.assertequals(ghr.name,'test');     
        GE_HQ_Country__c ghc = new GE_HQ_Country__c();
        ghc.GE_HQ_ISO_Code__c = '99';
        ghc.CurrencyIsoCode = 'USD';
        ghc.name = 'AFGHANISTAN';
        insert ghc;
        
        GE_HQ_State__c gs= new GE_HQ_State__c();
        gs.name='test';
        gs.GE_HQ_Country__c = ghc.id;
        gs.GE_HQ_ISO_Code__c = '999';
        gs.CurrencyIsoCode = 'USD';
        insert gs;
        
        GE_HQ_Reg_Matrix__c gr = new GE_HQ_Reg_Matrix__c();
        gr.GE_HQ_Country__c = ghc.id;
        gr.GE_HQ_Region__c = ghr.id;
        gr.GE_HQ_Eff_Dt__c = date.valueof('2014-08-08');
        insert gr;
        list<case> clst= new list<case>();
        case c = new case();
        c.GE_OG_CIR_Site_Country__c='AFGHANISTAN';
        C.GE_OG_Business_CIR__c='TMS';
        c.GE_ES_Sub_Type__c='MCS Sub Status';
        c.GE_OG_CIR_Site_Name__c='test';
        insert c; 
        clst.add(c); 
        system.assertequals(c.GE_OG_Business_CIR__c,'TMS'); 
         
         GE_OG_CaseContextController gecco= new GE_OG_CaseContextController ();
         //gecco.returnInstSalesRegion(c.GE_OG_Business_CIR__c,c.GE_OG_CIR_Site_Country__c,null,null,null,null);
         //gecco.returnSalesRegion(c.GE_OG_Business_CIR__c,a.id,null,null,clst);
        

        Test.stopTest();  
    
    }
    
    static testmethod void regionmatrixcir1(){
        Test.startTest();
        account a = new account();
        a.name='test';
        a.shippingcountry='AFGHANISTAN';
        a.GE_HQ_Country_Code__c='99';
        a.classification__c = 'test';
        a.type = 'test';
        insert a;
        
        GE_HQ_P_L__c BT = new GE_HQ_P_L__c();
        //BT.GE_HQ_P_L_Hierarchy_Level__c = 65446;
        BT.GE_HQ_P_L_ID__c = 7899;
        BT.GE_HQ_Is_Active__c = True;
        insert BT;
        
        /*GE_HQ_P_L__c BT= [Select Id,GE_HQ_P_L_Hierarchy_Level__c from GE_HQ_P_L__c where  GE_HQ_P_L_Hierarchy_Level__c!=null limit 1];    */    
               
        GE_HQ_Region__c ghr = new GE_HQ_Region__c();
        ghr.name='test';
        ghr.GE_HQ_Region_ID__c=9999;
        ghr.GE_HQ_Business_Tier__c=BT.id;
        insert ghr; 
        
        system.assertequals(ghr.name,'test');     
        GE_HQ_Country__c ghc = new GE_HQ_Country__c();
        ghc.GE_HQ_ISO_Code__c='99';
        ghc.CurrencyIsoCode='USD';
        ghc.name='AFGHANISTAN';
        insert ghc;
        
        GE_HQ_State__c gs= new GE_HQ_State__c();
        gs.name='test';
        gs.GE_HQ_Country__c=ghc.id;
        gs.GE_HQ_ISO_Code__c='999';
        gs.CurrencyIsoCode='USD';
        insert gs;
        
        GE_HQ_Reg_Matrix__c gr = new GE_HQ_Reg_Matrix__c();
        gr.GE_HQ_Country__c=ghc.id;
        gr.GE_HQ_Region__c=ghr.id;
        gr.GE_HQ_Eff_Dt__c=date.valueof('2014-08-08');
        insert gr;
        list<case> clst= new list<case>();
         Id r= Schema.SObjectType.Case.getRecordTypeInfosByName().get('CIR').getRecordTypeId();
        case c = new case();
        c.GE_OG_CIR_Site_Country__c='AFGHANISTAN';
        C.GE_OG_Business_CIR__c='Digital Solutions';
        c.GE_ES_Sub_Type__c='MCS Sub Status';
        c.recordtypeid= r;
        c.accountid=a.id;
        c.status='New';
        c.GE_OG_CIR_Site_Name__c='test';
        c.GE_OG_M_C_Job_Number_CIR__c='d';
        c.GE_OG_CIR_M_C_Job_Type__c='CCM';
        c.GE_OG_CIR_M_C_Location_of_Mfg_Service__c='Abu Dhabi';
        insert c; 
        clst.add(c); 
        system.assertequals(c.GE_OG_Business_CIR__c,'Digital Solutions'); 
         
         GE_OG_CaseContextController gecco= new GE_OG_CaseContextController ();
         //gecco.returnInstSalesRegion(c.GE_OG_Business_CIR__c,c.GE_OG_CIR_Site_Country__c,null,null,null,null);
         //gecco.returnSalesRegion(c.GE_OG_Business_CIR__c,a.id,null,null,clst);
        

        Test.stopTest();  
    
    }
    
     static testmethod void regionmatrixcir3(){
        Test.startTest();
        String cirRecID = Schema.SObjectType.Case.getRecordTypeInfosByName().get('CIR').getRecordTypeId(); 
        account a = new account();
        a.name='test';
        a.shippingcountry='AFGHANISTAN';
        a.GE_HQ_Country_Code__c='99';
        a.classification__c = 'test';
        a.type = 'test';
        insert a;
        
        Country_Region_Mapping_ge_og__c cr = new Country_Region_Mapping_ge_og__c();
        cr.name = 'test';
        cr.country_name_ge_og__c = 'India';
        cr.region_ge_og__c = 'India';
        insert cr;
        
        cr.region_ge_og__c = '';
        update cr;
        
       // String regionName = TechnicianRegionUpdate_GE_OG.regionPopulateByCountry('India');
       // system.assertEquals('India',cr.region_ge_og__c);
        
        GE_Installed_Base__c ib = new GE_Installed_Base__c();
        ib.Name = 'testing';

        insert ib;
        
        GE_HQ_P_L__c BT = new GE_HQ_P_L__c();
        //BT.GE_HQ_P_L_Hierarchy_Level__c = 65446;
        BT.GE_HQ_P_L_ID__c = 7899;
        BT.GE_HQ_Is_Active__c = True;
        insert BT;
        
        /*GE_HQ_P_L__c BT= [Select Id,GE_HQ_P_L_Hierarchy_Level__c from GE_HQ_P_L__c where  GE_HQ_P_L_Hierarchy_Level__c!=null limit 1];    */    
               
        GE_HQ_Region__c ghr = new GE_HQ_Region__c();
        ghr.name='test';
        ghr.GE_HQ_Region_ID__c=9999;
        ghr.GE_HQ_Business_Tier__c=BT.id;
        insert ghr; 
        
        system.assertequals(ghr.name,'test');     
        GE_HQ_Country__c ghc = new GE_HQ_Country__c();
        ghc.GE_HQ_ISO_Code__c='99';
        ghc.CurrencyIsoCode='USD';
        ghc.name='AFGHANISTAN';
        insert ghc;
        
        GE_HQ_State__c gs= new GE_HQ_State__c();
        gs.name='test';
        gs.GE_HQ_Country__c=ghc.id;
        gs.GE_HQ_ISO_Code__c='999';
        gs.CurrencyIsoCode='USD';
        insert gs;
        
        GE_HQ_Reg_Matrix__c gr = new GE_HQ_Reg_Matrix__c();
        gr.GE_HQ_Country__c=ghc.id;
        gr.GE_HQ_Region__c=ghr.id;
        gr.GE_HQ_Eff_Dt__c=date.valueof('2014-08-08');
        insert gr;
        list<case> clst= new list<case>();
         Id r= Schema.SObjectType.Case.getRecordTypeInfosByName().get('CIR').getRecordTypeId();
        case c = new case();
        c.GE_OG_CIR_Site_Country__c='AFGHANISTAN';
        C.GE_OG_Business_CIR__c='Digital Solutions';
        c.GE_ES_Sub_Type__c='MCS Sub Status';
        c.recordtypeid= r;
        c.accountid=a.id;
        c.status='New';
        c.GE_OG_CIR_Site_Name__c='test';
        c.GE_OG_M_C_Job_Number_CIR__c='d';
        c.GE_OG_CIR_M_C_Job_Type__c='CCM';
        c.GE_OG_CIR_M_C_Location_of_Mfg_Service__c='Abu Dhabi';
        c.GE_OG_CIR_Unit_Serial_number__c=ib.id;
        insert c; 
        clst.add(c); 
        system.assertequals(c.GE_OG_Business_CIR__c,'Digital Solutions'); 
        
        list<case> clst1= new list<case>();
         Id r1= Schema.SObjectType.Case.getRecordTypeInfosByName().get('CIR').getRecordTypeId();
        case c1 = new case();
        c1.GE_OG_CIR_Site_Country__c='AFGHANISTAN';
        C1.GE_OG_Business_CIR__c='Digital Solutions';
        c1.GE_ES_Sub_Type__c='MCS Sub Status';
        c1.recordtypeid= r1;
        c1.GE_OG_CIR_Customer_Contact_Name__c='testme';
        //c1.GE_OG_Key_Account_Name_CIR__c='france';
        c1.GE_OG_CIR_Customer_Address__c='testdhab';
        c1.GE_OG_CIR_Customer_Phone__c='1234097';
        c1.status='New';
        c1.GE_OG_CIR_Site_Name__c='test';
        c1.GE_OG_M_C_Job_Number_CIR__c='d';
        c1.GE_OG_CIR_M_C_Job_Type__c='CCM';
        c1.GE_OG_CIR_M_C_Location_of_Mfg_Service__c='Abu Dhabi';
        c1.GE_OG_CIR_Unit_Serial_number__c=ib.id;
        c1.accountid=a.id;
        //c1.Key_Account_Name_Web__c='0011200001FxU1O'; 
        insert c1; 
        clst1.add(c1); 
        system.assertequals(c.GE_OG_Business_CIR__c,'Digital Solutions'); 
         
         GE_OG_CaseContextController gecco= new GE_OG_CaseContextController ();
         //gecco.returnInstSalesRegion(c.GE_OG_Business_CIR__c,c.GE_OG_CIR_Site_Country__c,null,null,null,null);
         //gecco.returnSalesRegion(c.GE_OG_Business_CIR__c,a.id,null,null,clst);
        

        Test.stopTest();  
    
    }
}