@istest
public class Test_eRAD_Custom_Report_Cntrl 
{
     public static eRAD__c eradCreate()
     {
        
        account acc = new account();
        acc.RecordTypeId = Util_GE_OG.getRecordTypeDetails('Account','Relationship Account').getRecordTypeId();
        acc.name = 'Test Account';
        acc.Account_Tier_GEOG__c = 'Country';
        acc.Classification__c= 'Strategic';
        acc.Type = 'Direct Customer';
        acc.ShippingCountry = 'India';
        acc.Region_GEOG__c = 'India';
        insert acc;
        
        opportunity Oppty = CommonTestDataFactory_GE_OG.createOppty('TestOppty', acc.id);
        
        eRad__c radObj = new eRad__c();
        radObj.Name = 'Test eRad';
        radObj.Opportunity__c = Oppty.id;
        return radObj;
    }
      
    public static testMethod void RAD_Class_Method_1()
    {
        erad__c eradobj = eradCreate();
        eradobj.Capex_Category_Weight__c = '10%';
        eradobj.Opex_Category_weight__c = '20%';
        eradobj.Commercial_Category_weight__c = '10%';
        eradobj.Reference_Category_Weight__c = '10%';
        eradObj.Relation_Category_Weight__c = '10%';
        eradObj.Technical_Category_weight__c = '40%';
        eradobj.Capex_Score__c = '2.0';
        eradobj.Opex_Score__c = '2.0';
        eradobj.Commercial_Score__c = '2.0';
        eradobj.References_Score__c = '2.0';
        eradobj.Relations_Score__c = '2.0';
        eradobj.Technical_Score__c = '2.0';
        insert eradobj;
        Competitor__c com = new Competitor__c();
        com.eRAD__c =eradobj.id;
        com.Competitor__c = 'XXXX';
        com.Capex_Score__c = '2.0';
        com.Opex_Score__c = '2.0';
        com.Commercial_Score__c = '2.0';
        com.References_Score__c = '2.0';
        com.Relations_Score__c = '2.0';
        com.Technical_Score__c = '2.0';
        insert com;
        test.startTest();
            ApexPages.StandardController stdOppObj = new ApexPages.standardController(eradobj);
            eRAD_Custom_Report_Cntrl radreportClass = new eRAD_Custom_Report_Cntrl(stdOppObj);
            radreportClass.getData();
        test.stopTest();
    }
    
    public static testMethod void RAD_Class_Method_2()
    {
        erad__c eradobj = eradCreate();
        insert eradobj;
        Competitor__c com = new Competitor__c();
        com.eRAD__c =eradobj.id;
        com.Competitor__c = 'XXXX';
        insert com;
        Competitor__c com1 = new Competitor__c();
        com1.eRAD__c =eradobj.id;
        com1.Competitor__c = 'XXXX';
        insert com1;
        competitor__c com2 = new Competitor__c();
        com2.eRAD__c =eradobj.id;
        com2.Competitor__c = 'XXXX';
        insert com2;
        test.startTest();
            ApexPages.StandardController stdOppObj = new ApexPages.standardController(eradobj);
            eRAD_Custom_Report_Cntrl radreportClass = new eRAD_Custom_Report_Cntrl(stdOppObj);
            radreportClass.getData();
        test.stopTest();
    }
}