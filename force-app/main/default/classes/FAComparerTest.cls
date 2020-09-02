@isTest(seeAllData=True)
public class FAComparerTest{

    static List<Contract> lstCon ;
    
    public static testMethod void testFAComparer() {
        PageReference pageRef = Page.FAComparer;
        Test.setCurrentPage(pageRef);
        
        createBaseData();
       
        FAComparer controller = new FAComparer();
        controller.searchString = 'Test FA';
        
        controller.submit();
        controller.getSearchedRecord();
        
        for(Contract c : lstCon){
            controller.addId = c.id;           
            controller.selectRecord();
        }
        
        controller.searchString = 'Test FA';
        controller.submit();
        controller.getSearchedRecord();
        
        for(FAComparer.Record r:controller.searchedRecordsList)
            r.selected = true;
        
        controller.selectRecords();
        
        controller.submit();
        controller.getSearchedRecord();
        controller.closePopup();
        
        controller.getMyPageBlockTable();
        
        controller.getSelectLabel();
        controller.getFieldList();
        
        controller.selectedLabel = 'Contract.GE_OG_Other_Indemnity__c';
        controller.addField();
        
        controller.showPopup();
        controller.selectedLabels = controller.selectLabels;
        controller.addFields();
        
        controller.exportAsXLS();
        controller.exportAsPDF();
        
        controller.searchedRecords = new List<FAComparer.Record>();
        for(integer i = 0;i<18;i++)
            controller.searchedRecords.add(new FAComparer.Record());
        
        controller.next();
        controller.previous();
        
        
        FAComparer.Record testRec1 = new FAComparer.Record();
        testRec1.id = '123456';
        String res = testRec1.label1;
        res = testRec1.label2;
        res = testRec1.label3;
        res = testRec1.label4;
        res = testRec1.label5;
        
        FAComparer.Record testRec2 = new FAComparer.Record();
        testRec2.id = '123456';
        Integer hashCode = testRec2.hashCode();
        testRec1.compareTo(testRec2);
        testRec2.equals(testRec1);      
        testRec2.selected = true;
        
        
        FAComparer.ObjectLabel obj1 = new FAComparer.ObjectLabel ();
        obj1.value = 'Name';
        obj1.apiName = 'Contract';
        obj1.fromObj = 'Contract';
        obj1.visible = true;
        
        FAComparer.ObjectLabel obj2 = new FAComparer.ObjectLabel ();
        obj2.value = 'Email';
        obj2.apiName = 'Contract';
        obj2.fromObj = 'Contract';
        obj2.visible = true;
        
        Integer hashCodeObj = obj1.hashCode();
        Integer res1 = obj1.compareTo(obj2);
        Boolean  res2 = obj1.equals(obj2);
        
        String resRecord = controller.record;
    }
    
    public static void createBaseData(){
     
        Account acc = new Account(Name='Test', GE_HQ_New_Account_Street__c='Test',GE_HQ_New_Account_City__c='Test',
                                    GE_HQ_New_Account_State_Province__c='Test',GE_HQ_New_Account_Zip_Postal_Code__c='Test',
                                    GE_HQ_New_Account_Country__c='BAHRAIN',GE_PW_Phone_New_Request__c='1234567890');
        insert acc;
        
        Map<String,Id> recTypeIds = new Map<String,Id>();
        for(RecordType rt:[Select Id, Name from RecordType where Name IN ('Master Frame Agreement','Finance & Pricing','Legal','Taxes') 
                                    AND SobjectType IN ('Contract','Contract_Summary__c')])
            recTypeIds.put(rt.Name,rt.Id);
        
        lstCon = new List<Contract>();
        
        for(Integer i=1; i<= 20; i++){
            Contract c = new Contract(RecordTypeId=recTypeIds.get('Master Frame Agreement'), Name = 'Test FA', GE_PRM_Business_Tier_1__c = 'Oil & Gas (O&G)',
                                        AccountId=acc.Id,GE_OG_Legal_Entity__c='AL SHAHEEN - GE SERVICES COMPANY',StartDate=date.newInstance(2014, 4, 9),
                                        GE_OG_FA_Type__c='T&C\'s',GE_OG_Contract_End_Date__c=date.newInstance(2014, 4, 9),Status='Draft', 
                                        GE_HQ_Buss_Tier1__c = 'PII;M&C;D&S' , 
                                        BillingCity = 'Faridabaad' , BillingCountry = 'India' , BillingPostalCode = '121003' , BillingState = 'Haryana', BillingStreet = 'ashoka',
                                        ShippingCity = 'Faridabaad' , ShippingCountry = 'India' , ShippingPostalCode = '121003' ,ShippingState = 'Haryana');
            
            lstCon.add(c);
        }
        insert lstCon;
        
        List<Contract_Summary__c> lstContractSummary = new List<Contract_Summary__c>();
        Contract_Summary__c cSummery;
        for(Integer j=1; j <= 10 ; j++){
            lstContractSummary.add(new Contract_Summary__c (GE_Contract_Name__c = lstCon[j].Id));
        }
        insert lstContractSummary;
        
    }
}