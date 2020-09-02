@isTest(seealldata=true)
public class Test_GE_MCS_CloseCaseController{

    static testMethod void GE_MCS_CloseCaseController()
       {
            RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'MCS - CS' limit 1];
            List<case>caseli=new List<Case>();
            Case csobj1=new Case();
            csobj1.Subject='Email';
            //csobj.Status='Closed';
            //csobj1.Origin='Email';
            csobj1.Origin='Email - Grobycc';
            csobj1.CurrencyIsoCode='USD';
            csobj1.GE_ES_PO__c='test';
            csobj1.GE_ES_Shop_Order__c='test';
            csobj1.recordTypeid = rt.id;       
            csobj1.GE_ES_Sub_Type__c = 'RFQ processing';
            csobj1.GE_ES_Customer_Request_Date__c = Date.Today().adddays(20);
            //insert csobj1;
            caseli.add(csobj1);
            Case csobj2=new Case();
            csobj2.Subject='Email';
            //csobj.Status='Closed';
            //csobj1.Origin='Email';
            csobj2.Origin='Email - rsweb';
            csobj2.CurrencyIsoCode='USD';
            csobj2.GE_ES_PO__c='test';
            csobj2.GE_ES_Shop_Order__c='test';
            csobj2.recordTypeid = rt.id;       
            csobj2.GE_ES_Sub_Type__c = 'RFQ processing';
            csobj2.GE_ES_Customer_Request_Date__c = Date.Today().adddays(20);
            //insert csobj1;
            caseli.add(csobj2);
            Case csobj23=new Case();
            csobj23.Subject='Email';
            //csobj.Status='Closed';
            //csobj1.Origin='Email';
            csobj23.Origin='Email - EnergyCS';
            csobj23.CurrencyIsoCode='USD';
            csobj23.GE_ES_PO__c='test';
            csobj23.GE_ES_Shop_Order__c='test';
            csobj23.recordTypeid = rt.id;       
            csobj23.GE_ES_Sub_Type__c = 'RFQ processing';
            csobj23.GE_ES_Customer_Request_Date__c = Date.Today().adddays(20);
            //insert csobj1;
            caseli.add(csobj23);
            Case csobj24=new Case();
            csobj24.Subject='Email';
            //csobj.Status='Closed';
            //csobj1.Origin='Email';
            csobj24.Origin='Email - CSFPTKR';
            csobj24.CurrencyIsoCode='USD';
            csobj24.GE_ES_PO__c='test';
            csobj24.GE_ES_Shop_Order__c='test';
            csobj24.recordTypeid = rt.id;       
            csobj24.GE_ES_Sub_Type__c = 'RFQ processing';
            csobj24.GE_ES_Customer_Request_Date__c = Date.Today().adddays(20);
            //insert csobj1;
            caseli.add(csobj24);
            Case csobj25=new Case();
            csobj25.Subject='Email';
            //csobj.Status='Closed';
            //csobj1.Origin='Email';
            csobj25.Origin='Email - CustSVCCN';
            csobj25.CurrencyIsoCode='USD';
            csobj25.GE_ES_PO__c='test';
            csobj25.GE_ES_Shop_Order__c='test';
            csobj25.recordTypeid = rt.id;       
            csobj25.GE_ES_Sub_Type__c = 'RFQ processing';
            csobj25.GE_ES_Customer_Request_Date__c = Date.Today().adddays(20);
            //insert csobj1;
            caseli.add(csobj25);
            Case csobj26=new Case();
            csobj26.Subject='Email';
            //csobj.Status='Closed';
            //csobj1.Origin='Email';
            csobj26.Origin='Email - CC IT IND';
            csobj26.CurrencyIsoCode='USD';
            csobj26.GE_ES_PO__c='test';
            csobj26.GE_ES_Shop_Order__c='test';
            csobj24.recordTypeid = rt.id;       
            csobj26.GE_ES_Sub_Type__c = 'RFQ processing';
            csobj26.GE_ES_Customer_Request_Date__c = Date.Today().adddays(20);
            //insert csobj1;
            caseli.add(csobj26);
            Case csobj27=new Case();
            csobj27.Subject='Email';
            //csobj.Status='Closed';
            //csobj1.Origin='Email';
            csobj27.Origin='Email - Brasil Sensing';
            csobj27.CurrencyIsoCode='USD';
            csobj27.GE_ES_PO__c='test';
            csobj27.GE_ES_Shop_Order__c='test';
            csobj27.recordTypeid = rt.id;       
            csobj27.GE_ES_Sub_Type__c = 'RFQ processing';
            csobj27.GE_ES_Customer_Request_Date__c = Date.Today().adddays(20);
            //insert csobj1;
            caseli.add(csobj27);
            Case csobj28=new Case();
            csobj28.Subject='Email';
            //csobj.Status='Closed';
            //csobj1.Origin='Email';
            csobj28.Origin='Email - BentlyGulf';
            csobj28.CurrencyIsoCode='USD';
            csobj28.GE_ES_PO__c='test';
            csobj28.GE_ES_Shop_Order__c='test';
            csobj28.recordTypeid = rt.id;       
            csobj28.GE_ES_Sub_Type__c = 'RFQ processing';
            csobj28.GE_ES_Customer_Request_Date__c = Date.Today().adddays(20);
            //insert csobj1;
            caseli.add(csobj28);
            Case csobj29=new Case();
            csobj29.Subject='Email';
            //csobj.Status='Closed';
            //csobj1.Origin='Email';
            csobj29.Origin='Email Taunton';
            csobj29.CurrencyIsoCode='USD';
            csobj29.GE_ES_PO__c='test';
            csobj29.GE_ES_Shop_Order__c='test';
            csobj29.recordTypeid = rt.id;       
            csobj29.GE_ES_Sub_Type__c = 'RFQ processing';
            csobj29.GE_ES_Customer_Request_Date__c = Date.Today().adddays(20);
            //insert csobj1;
            caseli.add(csobj29);
            insert caseli;
                                                           
           // ApexPages.StandardController sController1 = new ApexPages.StandardController(csobj1); 
            
            //GE_CloseCaseController csc1 = new GE_CloseCaseController(sController1);
             GE_MCSCloseCaseController.Originalpage1(csobj1.id);
    }
    static testMethod void GE_MCS_CloseCaseController1()
    {
            RecordType rt = [select id,name from recordtype where sObjectType = 'Case' and Name = 'MCS - CS' limit 1];
            User userId = [select id,name from User where profile.name ='GE_ES Sales Mgr_MCS-SI' AND isactive=true limit 1];
            List<case>caseli=new List<Case>();
            Case csobj1=new Case();
            csobj1.Subject='Email';
            csobj1.Origin='Email';
            //csobj1.Origin='Email - rviservice';
            csobj1.CurrencyIsoCode='USD';
            //csobj1.GE_ES_PO__c='test';
            csobj1.GE_ES_Shop_Order__c='test';
            csobj1.recordTypeid = rt.id;
            csobj1.GE_ES_Sub_Type__c = 'RFQ processing';
            csobj1.GE_ES_PO__c='123456';
            csobj1.GE_ES_Customer_Request_Date__c = Date.Today().adddays(20);
            csobj1.GE_MCS_Duplicate_PO_ok__c = true;
        try{
            insert csobj1;
        }           
        catch(exception e){
            
        }
            //caseli.add(csobj1);
            Case csobj2=new Case();
            csobj2.Subject='Email';
            csobj2.Origin='Email';
            //csobj1.Origin='Email - rviservice';
            csobj2.CurrencyIsoCode='USD';
            //csobj2.GE_ES_PO__c='test';
            csobj2.GE_ES_Shop_Order__c='test';
            csobj2.recordTypeid = rt.id;
            csobj2.GE_ES_Sub_Type__c = 'RFQ processing';
            csobj2.GE_ES_PO__c='123456';
            csobj2.GE_ES_Customer_Request_Date__c = Date.Today().adddays(20);
          try{
            insert csobj2;
       }           
        catch(exception e){
            
        } 
        csobj2.GE_ES_PO__C='1234567';
          try{
        update csobj2;
       }           
        catch(exception e){
            
        } 
       
            //caseli.add(csobj2);
            //System.runAs(userId){
            //insert caseli;
            
            
            //}
                       
            //GE_MCSCloseCaseController.Originalpage1(csobj1.id);
    }

    
}