@istest
private class GE_OG_MC_TS_NewControllerTest
{
 
 @testsetup
public static void settestdata ()
{
    String CIRrecType = Schema.SObjectType.Case.getRecordTypeInfosByName().get('MC-TS').getRecordTypeId();
    String CommAccrecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Relationship Account').getRecordTypeId();
     
        account a = new account();
        a.name='test';
        a.GE_HQ_DUNS_Number__c = 'GEGUL1012';
        a.RecordtypeId = CommAccrecType ;
        a.Classification__c = 'test';
        a.type = 'test'; 
        insert a;
        contact c1 = new contact();
        c1.FirstName='test';
        c1.MobilePhone='2222222222';
        c1.LastName='test';
        c1.accountid = a.id;
        c1.email='der@ge.com';
        insert c1;
        
        GE_Installed_Base__c gi = new GE_Installed_Base__c();
        gi.name='test';
        gi.Account__c=a.id;
        gi.GE_ES_Station_Name__c='test';
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
        C.GE_OG_Business_CIR__c = p.GE_OG_MCS_Business__c;        
        c.GE_ES_Sub_Type__c='MCS Sub Status';   
        c.accountid=a.id;   
        c.GE_OG_CIR_Unit_Serial_number__c=gi.id;  
        c.GE_OG_CIR_Assembly__c=p.GE_OG_MCS_Assembly__c;
        c.recordtypeid = CIRrecType;
        c.GE_OG_CIR_Component__c=p.GE_OG_MCS_Component__c;
        c.GE_OG_Sub_Business_CIR__c=p.GE_OG_MCS_Sub_Business__c;
        c.GE_OG_CIR_Item__c =  p.GE_OG_MCS_Item__c ;
        c.status= 'new';
        c.Origin='Email';
         c.GE_OG_MC_TS_Name_of_Site_Contact__c = 'test';
        c.GE_OG_CIR_Customer_Phone__c = '7676878888';
        insert c;
             
       
        
    
}

    static testmethod void testmethod1()
    {
        test.starttest();
        
     case  c=[select id,GE_OG_CIR_Site_Name__c ,GE_OG_CIR_Defect_Code_Lev_1__c ,GE_OG_CIR_Defect_Code_Lev_2__c ,GE_OG_CIR_Defect_Code_Lev_3__c 
            ,status,Subject,GE_OG_CIR_Safer_case__c,GE_OG_CIR_Customer_Phone__c ,GE_OG_CIR_Link_to_CIN_Cal__c,GE_OG_CIR_Customer_Contact_Name__c ,GE_OG_CIR_Customer_Address__c,GE_OG_CIR_Customer_Email__c,RecordTypeId,OwnerId,Description,GE_OG_Actions_Taken_To_Resolve_befor_CIR__c,GE_OG_Issue_Event_Date_CIR__c,
             GE_OG_Customer_Want_Date_CIR__c,GE_OG_CIR_Specific_Deliverable_Required__c,
             casenumber,GE_OG_Customer_Impact_CIR__c,GE_OG_CIR_Impact_on_Customer_Description__c,
             GE_OG_EHS_Product_Safety_CIR__c,GE_OG_Escalation_Level_CIR__c,GE_OG_Front_Line_case_Reference_CIR__c,GE_OG_Link_to_CIR_Handbook_and_Videos__c,GE_OG_Business_CIR__c
             ,GE_OG_Sub_Business_CIR__c,GE_OG_Customer_Escalation_CIR__c,GE_OG_GE_Executive_Request_CIR__c,GE_OG_CIR_Type_of_Issue__c,
             accountid,GE_OG_Account_Name_Only_If_Not_List_CIR__c,
             GE_OG_MC_Con_Name__c,GE_OG_MC_Con_Phone__c,GE_OG_MC_Con_Email__c,GE_OG_CIR_State__c,GE_OG_Project_Name_CIR__c,
             GE_OG_Project_Sales_Order_ID_CIR__c,GE_OG_M_C_Job_Number_CIR__c, GE_OG_CIR_Site_Country__c,GE_OG_CIR_Unit_Serial_number__c,
             GE_OG_CIR_M_C_Job_Type__c,GE_OG_CIR_M_C_Location_of_Mfg_Service__c,GE_OG_CIR_Region__c,GE_OG_Confirm_Escalated_CIR__c,
             GE_OG_CIR_Case_Manager_Function__c,GE_OG_CIR_Assembly__c,GE_OG_CIR_Component__c,GE_OG_CIR_Item__c,GE_OG_Item_Description_CIR__c,
             GE_OG_Resolution_Committed_date_CIR__c,GE_OG_Resolution_Forecasted_Date_CIR__c,GE_OG_Correction_CIR__c,
             GE_OG_CIR_Case_Re_opened_Date__c,GE_OG_Case_Update_CIR__c,
             GE_OG_Customer_Feedback_CIR__c,GE_OG_CIR_Case_Resolution_Date__c,GE_OG_CIR_Case_Closure_Date__c,GE_OG_Case_Cancellation_Note_CIR__c,
             GE_OG_Send_Back_Reason_Description_CIR__c,GE_OG_CIN_CIR__c,
             GE_OG_Gensuite_Link_CIR__c,
             GE_OG_CIR_NC_Screening__c,GE_OG_NCA_RCA_value_CIR__c from case ];
             
            GE_OG_Product_Hierarchy1__c p = [SELECT CreatedById,CreatedDate,CurrencyIsoCode,GE_OG_MCS_Assembly__c,GE_OG_MCS_Business__c,GE_OG_MCS_Component__c,GE_OG_MCS_Item_Description1__c,GE_OG_MCS_Item_Description__c,GE_OG_MCS_Item__c,GE_OG_MCS_Sub_Business__c,Id,IsDeleted,LastActivityDate,LastModifiedById,LastModifiedDate,Name,OwnerId FROM GE_OG_Product_Hierarchy1__c];
             c.GE_OG_Business_CIR__c = 'TMS';
            c.GE_OG_Sub_Business_CIR__c= 'New Units';
             update c;
              contact con = [select id, name,email from contact];
        apexpages.currentpage().getparameters().put('id',c.id);
        Apexpages.currentPage().getParameters().put('two','New Units');
         apexpages.currentpage().getparameters().put('cas4_lkid',c.accountid);
        //apexpages.currentpage().getparameters().put('cas3_lkid',con.id);
         
        
        
         GE_OG_MC_TS_NewController ge = new GE_OG_MC_TS_NewController(new apexpages.standardcontroller(c));
         ge.makeNullValues();
         ge.autoRun();
         
         c.GE_OG_Business_CIR__c = 'Subsea (SS)';
         c.GE_OG_Sub_Business_CIR__c= 'D&S - Drilling';
          c.GE_OG_MC_TS_Name_of_Site_Contact__c = 'test';
        c.GE_OG_CIR_Customer_Phone__c = '7676878888';
         update c;
          ge = new GE_OG_MC_TS_NewController( new apexpages.standardcontroller(c));
         ge.makeNullValues();
             c.GE_OG_Sub_Business_CIR__c= 'Controls';
             update c; 
             ge = new GE_OG_MC_TS_NewController(new apexpages.standardcontroller(c));
             ge.assembly = p.GE_OG_MCS_Assembly__c;
             ge.Subbusinessmcts=p.GE_OG_MCS_Sub_Business__c;
             ge.Businessmcts=p.GE_OG_MCS_Business__c;
             ge.component =p.GE_OG_MCS_Component__c;   
            ge.item = p.GE_OG_MCS_Item__c;
            ge.itemdescription = p.GE_OG_MCS_Item_Description__c;
            ge.itemdescription1 = p.GE_OG_MCS_Item_Description1__c; 
            
             ge.getcomponentsSelectList();
             ge.getitemsSelectList1();
             
             ge.getitemdescriptionsSelectList1();
            ge.getitemdescription1sSelectList1();
             
        GE_OG_Product_Hierarchy1__c p1 = new GE_OG_Product_Hierarchy1__c();
        p1.GE_OG_MCS_Assembly__c = 'Remote Visual Inspection';
        p1.GE_OG_MCS_Business__c = 'Subsea (SS)';
        p1.GE_OG_MCS_Component__c ='Video Borescopes';
        p1.GE_OG_MCS_Item_Description1__c='Air Hose';
        p1.GE_OG_MCS_Item_Description__c ='Accessory';
        p1.GE_OG_MCS_Item__c = 'Flying Probe';
        p1.GE_OG_MCS_Sub_Business__c='Inspection Technologies';
        p1.Name ='OG_Prod_Hier__1341';
        insert p1;
        ge.getitemsSelectList1();
         ge.getitemdescriptionsSelectList1();
         ge.getitemdescription1sSelectList1();
        ge.savecase();
        
       
       // String x=ge.SelectedFields;
        
       // ge.jobtypeToController();
       string test1=  ge.assembly ;
         string test2=    ge.Subbusinessmcts;
       string test3=      ge.Businessmcts;
        string test4=     ge.component ;   
        string test5=   ge.item ;
            string test6=ge.itemdescription ;
            string test7=ge.itemdescription1 ;  
    //List<SelectOption>    abh =   ge.options4;
      case  cde = ge.cObject ;
     Boolean  xsw = ge.refreshPage ;
     string  fdf=ge.componentvalue;
     string fd=ge.descriptionvalue;
        
        
       // ge.cancel();
        Apexpages.currentPage().getParameters().put('one','TMS');
        ge.makeNullValues();
        Apexpages.currentPage().getParameters().put('one','Subsea (SS)');
        ge.makeNullValues();
        Apexpages.currentPage().getParameters().put('one','Drilling');
        ge.makeNullValues();
        
        Apexpages.currentPage().getParameters().put('two','CMS');
        ge.makeNullValues1();
        Apexpages.currentPage().getParameters().put('two','DT');
        ge.makeNullValues1();
        Apexpages.currentPage().getParameters().put('two','Controls');
        ge.makeNullValues1();
        Apexpages.currentPage().getParameters().put('two','Control Solutions');
        ge.makeNullValues1();
        Apexpages.currentPage().getParameters().put('two','test');
        ge.makeNullValues1();
        
        Apexpages.currentPage().getParameters().put('three','test');
        ge.makeNullValues2();
        ge.makeNullValues3();
        ge.makeNullValues4();
        ge.makeNullValues5();
        
       
       
        test.stoptest();
            }
 
 
  

}