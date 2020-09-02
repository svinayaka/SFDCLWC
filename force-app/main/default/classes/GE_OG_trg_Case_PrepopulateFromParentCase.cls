/*
Class Name: GE_OG_trg_Case_PrepopulateFromParentCase
Used In : 
Purpose/Overview :  Used to populate the Opportunity field on the Child Case from the Parent Case if the Parent Case SubType = 'RFQ Processing'
Functional Area : Case
Author: CaseTeam
Test Class Name : GE_MCS_Prepopulate_from_ParentCaseTest
Change History    : Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
 2014-04-11    : Htut Zaw           : Initial Creation
  2014-06-25    : Htut Zaw           : Removed setting the Child SubType the same as Parent
*/

/*
S.NO         MethodName                                                     operation
1.           prePopulateCaseFromParentCase                                      beforeInsert,beforeUpdate
           
*/




public class GE_OG_trg_Case_PrepopulateFromParentCase {

/*
  this method is for 'beforeInsert','beforeUpdate'
  Modified from Trigger:GE_MCS_Prepopulate_from_ParentCase.
  Purpose:Used to populate the Opportunity field on the Child Case from the Parent Case if the Parent Case SubType = 'RFQ Processing'
  TestClassName:GE_MCS_Prepopulate_from_ParentCaseTest
*/

public void prePopulateCaseFromParentCase(List<case>  newcaseList)
{
    List<Case>  newcaseList1= (List<Case>)newcaseList;
    map<id,Case> kids = new map<id,Case>();
    map<id,Case> parents = new map<id,Case>();
     if(GEESUtil.caseRecTypes==null)
    {
    GEESUtil.getAssociatedCaseRecordTypeIDforRecordTypeName();
   
    }
     Schema.RecordTypeInfo rtByName =  GEESUtil.caseRecTypes.get('MCS - CS');
      Id MCSRecordTypeID = rtByName.getRecordTypeId();
      for(Case kc : newcaseList1){
        if(kc.ParentId!=null && kc.RecordTypeId == MCSRecordTypeID)
            kids.put(kc.ParentId,kc);
    }
    for(Case pc : [select Opportunity_Name__c,GE_ES_Sub_Type__c,Id from Case where id in : kids.keyset()]){
        parents.put(pc.id,pc);
    }
    for(Case c : kids.values()){
        if (parents.get(c.ParentId).GE_ES_Sub_Type__c == 'RFQ Processing') {
            c.Opportunity_Name__c = parents.get(c.ParentId).Opportunity_Name__c;
        }
}
}
}