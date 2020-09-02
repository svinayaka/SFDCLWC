/*    
Class Name        : GE_OG_MCS_DuplicateCustomerPO_Check
Purpose/Overview  : Test Class for GE_MCS_ChangeOwner
Author            : Raju Manche
Created Date      : 8 Apr 2015
Test Class        : Test_GE_OG_Case_Related
Requirement Name  : R-20954
*/
Public with sharing  class GE_OG_MCS_DuplicateCustomerPO_Check
{
    public void DuplicateCustomerPO_Check_method(case newcaseList)
    {
        Schema.DescribeSObjectResult d = Schema.SObjectType.Case; 
        Map<String,Schema.RecordTypeInfo> rtMapByName = d.getRecordTypeInfosByName();
        Schema.RecordTypeInfo rtByName =  rtMapByName.get('CIR');
        Id LegalRecId = rtByName.getRecordTypeId();   
        
        Case c = newcaseList;
        List<Case> CaseList2 = new List<Case>();
        List<List<case>> CaseListRam = new List<List<case>>();
        Boolean DupeFoundAllow = false; 
        
        String rtId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('MCS - CS').getRecordTypeId();
        String Casenum = '';
        if(c.GE_ES_PO__c != '' && c.GE_ES_PO__c != null &&c.RecordTypeId == rtId ){    
            CaseListRam = [Find :c.GE_ES_PO__c Returning Case(CaseNumber where GE_ES_PO__c = :c.GE_ES_PO__c AND id != :c.id AND (CreatedDate = TODAY OR CreatedDate = LAST_90_DAYS))];
            DupeFoundAllow = c.GE_MCS_Duplicate_PO_ok__c;
        } 
        for(List<case> cas : CaseListRam){
            CaseList2.addall(cas);
        }
        for(case ca : CaseList2){
            Casenum =  ca.CaseNumber+','+Casenum;            
        }
        if(CaseList2.size() > 0 && !DupeFoundAllow){

            c.addError('There is already a Case with same Customer PO# and the CaseNumbers are: '+CaseNum+'. Please check "Not Duplicate PO" if this is not a duplicate order!');        
        }
        
    }
}