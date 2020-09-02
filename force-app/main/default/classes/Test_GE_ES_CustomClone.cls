/*
Type Name [Class/Trigger/Page Name] : Class
Used Where ?                        : Test Class for GE_ES_CustomClone
Purpose/Overview                    : Code Coverage
Functional Area                     : Cross Functional
Author                              : Sanjay Patidar
Created Date                        : 
Test Class Name                     : None.
Limitation                          : 

Change History -
Date Modified   : Developer Name        : Method/Section Modified/Added     : Purpose/Overview of Change
*/

@isTest(seealldata=true)
public class Test_GE_ES_CustomClone {
    static testMethod void GE_ES_CustomClone_Test() {
        //Create a Custom Clone Record
        GE_ES_Custom_Clone__c customClone = new GE_ES_Custom_Clone__c (GE_ES_Object_Name__c = 'Commercial Vetting', GE_ES_Object_API_Name__c = 'GE_PRM_Commercial_Vetting__c');
        insert customClone;
        //Assert the Record
        system.assertEquals('Commercial Vetting', customClone.GE_ES_Object_Name__c);
        
        //Selecting an account
        Account acc=[select id,name,GE_HQ_Request_Status__c from Account where Name like '%testclassaccount%' limit 1];
        
        //Create a Custom Clone Detail Records
        List<GE_ES_Custom_Clone_Detail__c> customCloneDetailList = new List<GE_ES_Custom_Clone_Detail__c>();               
        
        //Create a Integer Type Exception
        GE_ES_Custom_Clone_Detail__c strValue = new GE_ES_Custom_Clone_Detail__c();
        strValue.GE_ES_API_Name__c = 'GE_PRM_Status__c';
        strValue.GE_ES_Label__c = 'Status';
        strValue.GE_ES_Data_Type__c = 'String';
        strValue.GE_ES_Default_Value__c = 'In Progress';
        strValue.GE_ES_Custom_Clone__c = customClone.Id;
        //Add to the List
        customCloneDetailList.add(strValue);
        
        //Create a Integer Type Exception
        GE_ES_Custom_Clone_Detail__c integerValue = new GE_ES_Custom_Clone_Detail__c();
        integerValue.GE_ES_API_Name__c = 'GE_PRM_of_sales_people_selling_GE__c';
        integerValue.GE_ES_Label__c = '# of sales people selling GE?';
        integerValue.GE_ES_Data_Type__c = 'Integer';
        integerValue.GE_ES_Default_Value__c = '0';
        integerValue.GE_ES_Custom_Clone__c = customClone.Id;
        //Add to the List
        customCloneDetailList.add(integerValue);
        
        //Create a boolean Type Exception
        GE_ES_Custom_Clone_Detail__c booValue = new GE_ES_Custom_Clone_Detail__c();
        booValue.GE_ES_API_Name__c = 'GE_PRM_I_Certify_above_information_true__c';
        booValue.GE_ES_Label__c = 'I Certify the above information is true';
        booValue.GE_ES_Data_Type__c = 'Boolean';
        booValue.GE_ES_Default_Value__c = 'False';
        booValue.GE_ES_Custom_Clone__c = customClone.Id;                
        
        //Add to the List
        customCloneDetailList.add(booValue);
        
        //Create a String Type Exception
        GE_ES_Custom_Clone_Detail__c StringValue2 = new GE_ES_Custom_Clone_Detail__c();
        StringValue2.GE_ES_API_Name__c = 'GE_PRM_Account__c';
        StringValue2.GE_ES_Label__c = 'Status';
        StringValue2.GE_ES_Data_Type__c = 'String';
        StringValue2.GE_ES_Default_Value__c = String.valueOf(acc.id);
        StringValue2.GE_ES_Custom_Clone__c = customClone.Id;
        //Add to the List
        customCloneDetailList.add(StringValue2);
        
        //Insert the Child Clone Detail Exceptions
        insert customCloneDetailList;
        
        //Create a Child Object for the Related List
        GE_ES_Custom_Clone__c customCloneChild = new GE_ES_Custom_Clone__c (GE_ES_Object_Name__c = 'Recommendation', GE_ES_Object_API_Name__c = 'GE_PRM_Recommendation__c', 
                                                                            GE_ES_Parent_Object__c = customClone.Id, GE_ES_Where_Field__c = 'GE_PRM_Commercial_Vetting__c');
        insert customCloneChild;
        //Assert the Record
        system.assertEquals('Recommendation', customCloneChild.GE_ES_Object_Name__c);
        
        Schema.DescribeSObjectResult des = Schema.SObjectType.GE_PRM_Recommendation__c; 
        Map<String,Schema.RecordTypeInfo> rtMapByName = des.getRecordTypeInfosByName();
        Schema.RecordTypeInfo rtExpressByName =  rtMapByName.get('Express RFA'); 
        Id Expressrectypeid = rtExpressByName.getRecordTypeId();
        
        //Create a Custom Clone Detail Records
        List<GE_ES_Custom_Clone_Detail__c> customCloneChildDetailList = new List<GE_ES_Custom_Clone_Detail__c>();
        
        //Create a String Type Exception
        GE_ES_Custom_Clone_Detail__c childStringValue = new GE_ES_Custom_Clone_Detail__c();
        childStringValue.GE_ES_API_Name__c = 'GE_PRM_Status__c';
        childStringValue.GE_ES_Label__c = 'Status';
        childStringValue.GE_ES_Data_Type__c = 'String';
        childStringValue.GE_ES_Default_Value__c = 'In Progress';
        childStringValue.GE_ES_Custom_Clone__c = customCloneChild.Id;
        //Add to the List
        customCloneChildDetailList.add(childStringValue);
        
        //Create a String Type Exception
        GE_ES_Custom_Clone_Detail__c childStringValue2 = new GE_ES_Custom_Clone_Detail__c();
        childStringValue2.GE_ES_API_Name__c = 'GE_PRM_Account__c';
        childStringValue2.GE_ES_Label__c = 'Account';
        childStringValue2.GE_ES_Data_Type__c = 'String';
        childStringValue2.GE_ES_Default_Value__c = String.valueOf(acc.id);
        childStringValue2.GE_ES_Custom_Clone__c = customCloneChild.Id;
        //Add to the List
        customCloneChildDetailList.add(childStringValue2);
        
        //Create a String Type Exception
        GE_ES_Custom_Clone_Detail__c childStringValue3 = new GE_ES_Custom_Clone_Detail__c();
        childStringValue3.GE_ES_API_Name__c = 'RecordTypeId';
        childStringValue3.GE_ES_Label__c = 'RecordType';
        childStringValue3.GE_ES_Data_Type__c = 'String';
        childStringValue3.GE_ES_Default_Value__c = String.valueOf(Expressrectypeid);
        childStringValue3.GE_ES_Custom_Clone__c = customCloneChild.Id;
        //Add to the List
        customCloneChildDetailList.add(childStringValue3);
        
        //Create a Integer Type Exception
        GE_ES_Custom_Clone_Detail__c childintegerValue = new GE_ES_Custom_Clone_Detail__c();
        childintegerValue.GE_ES_API_Name__c = 'GE_PRM_Engineering_Resources__c';
        childintegerValue.GE_ES_Label__c = 'Engineering Resources allocated to GE';
        childintegerValue.GE_ES_Data_Type__c = 'Integer';
        childintegerValue.GE_ES_Default_Value__c = '0';
        childintegerValue.GE_ES_Custom_Clone__c = customCloneChild.Id;
        //Add to the List
        customCloneChildDetailList.add(childintegerValue);
        
        //Create a boolean Type Exception
        GE_ES_Custom_Clone_Detail__c childbooValue = new GE_ES_Custom_Clone_Detail__c();
        childbooValue.GE_ES_API_Name__c = 'GE_PRM_Confirm_Partner_Account_Info__c';
        childbooValue.GE_ES_Label__c = 'Confirm Partner Account Info';
        childbooValue.GE_ES_Data_Type__c = 'Boolean';
        childbooValue.GE_ES_Default_Value__c = 'False';
        childbooValue.GE_ES_Custom_Clone__c = customCloneChild.Id;                
        
        //Add to the List
        customCloneChildDetailList.add(childbooValue);
        
        //Insert the Child Clone Detail Exceptions
        insert customCloneChildDetailList;
        
        //creating a commercial vetting
        GE_PRM_Commercial_Vetting__c CV = new GE_PRM_Commercial_Vetting__c(GE_PRM_Account__c=acc.id,GE_PRM_Status__c='In Progress',GE_PRM_of_sales_people_selling_GE__c = 2, GE_PRM_I_Certify_above_information_true__c = False  );
        insert CV;
        //Assert the Record
        system.assertEquals('In Progress', CV.GE_PRM_Status__c);
        
        GE_PRM_Recommendation__c Rec = new GE_PRM_Recommendation__c(GE_PRM_Account__c=acc.id,GE_PRM_Commercial_Vetting__c = CV.id,GE_PRM_Status__c = 'In Progress',GE_PRM_Confirm_Partner_Account_Info__c = true,GE_PRM_Engineering_Resources__c=15,RecordTypeId = Expressrectypeid);
        insert Rec;
        //Assert the Record
        system.assertEquals('In Progress', Rec.GE_PRM_Status__c);
        
        PageReference pageRef = Page.GE_ES_CustomClone;
        
        Test.setCurrentPage(pageRef);
        
        //Add Parameters to the Page Url
        ApexPages.currentPage().getParameters().put('ParentId', CV.Id);
        GE_ES_CustomClone controller = new GE_ES_CustomClone();
        controller = new GE_ES_CustomClone();
        controller.ParentCloneId = CV.id;
        controller.getcloneOptions();
        controller.cloneOptionsList.get(0).selected = true;
        List<GE_ES_Custom_Clone__c> selectedCloneOptions = new List<GE_ES_Custom_Clone__c>();
        selectedCloneOptions.add(customCloneChild);
        controller.processSelected();
        controller.cancelClone();
    }     
}