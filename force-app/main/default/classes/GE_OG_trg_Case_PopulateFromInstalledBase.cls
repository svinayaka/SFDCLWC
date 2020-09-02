/*
Class Name: 
Used In : 
Purpose/Overview : 
Functional Area : Case
Author: CaseTeam
Test Class Name : 
*/

/*
S.NO         MethodName                                                     operation
1.           populateCaseFromInstalledBase                                      beforeInsert
2.           assignmentGroupFieldInsertion                                     beforeInsert
3.           assignmentGroupFieldUpdation                                 beforeUpdate

*/




public class GE_OG_trg_Case_PopulateFromInstalledBase {

/*
  this method is for 'beforeInsert'
  Modified from Trigger:GE_HQ_PopulateCaseFromInstalledBase.
  Purpose:
  TestClassName:
*/

public void populateCaseFromInstalledBase(List<case>  newcaseList)
{
List<Case>  newcaseList1= (List<Case>)newcaseList;
    Set<Id> ibIdSet = new Set<Id>();
   
    if(GEESUtil.caseRecTypes==null)
    {
    GEESUtil.getAssociatedCaseRecordTypeIDforRecordTypeName();
   
    }
     Schema.RecordTypeInfo rtByName =  GEESUtil.caseRecTypes.get('FS-PGS');
     Schema.RecordTypeInfo rtByName1 =  GEESUtil.caseRecTypes.get('FS-MCS');
      Id PGSRecordTypeID = rtByName.getRecordTypeId();
      Id MCSRecordTypeID = rtByName1.getRecordTypeId();
      
      for (Case caseObj : newcaseList1)
    {
      if (caseObj.RecordTypeId == MCSRecordTypeID || caseobj.RecordTypeId == PGSRecordTypeID)
      {
         ibIdSet.add(caseObj.Installed_Base__c);
      }
    }
    
    if (ibIdSet.size() > 0)
    {
    Map<Id, GE_Installed_Base__c> ibMap = new Map<Id, GE_Installed_Base__c>([SELECT Id, Account__c, GE_ES_Account_City__c, GE_ES_Account_Country__c, 
         GE_ES_Site_Street_Address__c, GE_ES_Site_Zip_Code__c, GE_ES_Account_State_Province__c, GE_ES_Account_Manager__r.Name,
         GE_ES_CSA_Site_Manager__c, GE_ES_Service_Manager__c, GE_ES_Station_Name__c FROM GE_Installed_Base__c WHERE Id IN :ibIdSet ]);
         
         for (Case caseObj : newcaseList1)
      {
      
      if ((caseObj.RecordTypeId == MCSRecordTypeID || caseobj.RecordTypeId == PGSRecordTypeID) && ibMap.containsKey(caseObj.Installed_Base__c))
        {
          GE_Installed_Base__c ib = ibMap.get(caseObj.Installed_Base__c);
                caseObj.AccountId = ib.Account__c;
                caseObj.GE_SM_HQ_City__c = ib.GE_ES_Account_City__c;
                caseObj.GE_ES_Country__c = ib.GE_ES_Account_Country__c;
                caseObj.GE_SM_HQ_Street__c = ib.GE_ES_Site_Street_Address__c;
                caseObj.GE_SM_HQ_State__c = ib.GE_ES_Account_State_Province__c;
                caseObj.GE_SM_HQ_Zip__c = ib.GE_ES_Site_Zip_Code__c;
                caseObj.GE_SM_HQ_Site_Name__c = ib.GE_ES_Station_Name__c;
        }
      }
    }
      

}

/*
  this method is for 'beforeInsert'
  Modified from Trigger:AssignmentGroupFieldUpdation.
  Purpose:Removed--> GE SS Set Assignment Group (Casefieldupdate)
         on GE SS Project Region Changed (Workflow rule)
         GE SS Project Region New(deactivated workflow)
         Included subtype mandatory logic for mcs record type
  TestClassName:AssignmentGroupFieldUpdationTest  
*/

public void assignmentGroupFieldInsertion(List<case>  newcaseList)
{
     User SystemIntUsr = new User();
     SystemIntUsr = [Select id,Name from User where id =: UserInfo.getUserId()];
     
     
     if(SystemIntUsr.Name != 'System Integration') 
     {
      if(GEESUtil.caseRecTypes==null)
        {
    GEESUtil.getAssociatedCaseRecordTypeIDforRecordTypeName();
   
         }
         List<Case>  newcaseList1= (List<Case>)newcaseList;
     Schema.RecordTypeInfo rtByName =  GEESUtil.caseRecTypes.get('FS-SS');
     Schema.RecordTypeInfo rtByName1 =  GEESUtil.caseRecTypes.get('MCS - CS');
      Id FSRecordTypeID = rtByName.getRecordTypeId();
      Id MCSCSRecordTypeID = rtByName1.getRecordTypeId();
      for(Case c:newcaseList1){       
                if(c.GE_ES_Sub_Type__c==null && c.recordtypeid==MCSCSRecordTypeID&&c.origin.contains('Email')==false)
                {                                 
                    c.addError(' "Sub Type" field is mandatory ');                         
                }
            }
            
            List<GE_SS_Project_Region__c> pgrList= New List<GE_SS_Project_Region__c>();

set<id> caseids = New set<id>();

for(Case cids:newcaseList1){

if(cids.recordtypeid==FSRecordTypeID){
caseids.add(cids.GE_SS_Project_Region__c);
}
}


if(caseids.size()>0)
{
pgrList =[select GE_SS_Assignment_Group__c from GE_SS_Project_Region__c where id in : caseids];


if(pgrList.size()>0){

for(Case c:newcaseList1){

if(c.recordtypeid==FSRecordTypeID)
{

c.GE_SS_Assignment_Group__c = pgrList[0].GE_SS_Assignment_Group__c;

}
}
}
}
     }

}

/*
  this method is for 'beforeUpdate'
  Modified from Trigger:AssignmentGroupFieldUpdation.
  Purpose:Removed--> GE SS Set Assignment Group (Casefieldupdate)
         on GE SS Project Region Changed (Workflow rule)
         GE SS Project Region New(deactivated workflow)
         Included subtype mandatory logic for mcs record type
  TestClassName:AssignmentGroupFieldUpdationTest  
*/

public void assignmentGroupFieldUpdation(List<Case>  newcaseList,Map<Id,Case>  newMapCase,Map<Id,Case>  oldMapCase)
{
     User SystemIntUsr = new User();
     SystemIntUsr = [Select id,Name from User where id =: UserInfo.getUserId()];
     if(SystemIntUsr.Name != 'System Integration') 
     {
      if(GEESUtil.caseRecTypes==null)
        {
    GEESUtil.getAssociatedCaseRecordTypeIDforRecordTypeName();
   
         }
         List<Case>  newcaseList1= (List<Case>)newcaseList;
         Map<Id,Case>  newMapCase1=(Map<Id,Case>)newMapCase;
         Map<Id,Case>  oldMapCase1=(Map<Id,Case>)oldMapCase;
     Schema.RecordTypeInfo rtByName =  GEESUtil.caseRecTypes.get('FS-SS');
     Schema.RecordTypeInfo rtByName1 =  GEESUtil.caseRecTypes.get('MCS - CS');
      Id FSRecordTypeID = rtByName.getRecordTypeId();
      Id MCSCSRecordTypeID = rtByName1.getRecordTypeId();
      for(Case c:newcaseList1)
            {
                //Case beforeUpdatecaseOld=oldMapCase1.get(c.OwnerId);
                Case beforeUpdatecase = newMapCase1.get(c.Id);
                String currentRequestURL = URL.getCurrentRequestUrl().toExternalForm();
                boolean checkurl = currentRequestURL.Contains('retURL=%2F') ;
                system.debug('aaaa ---> '+currentRequestURL+' bbbb '+ checkurl );
System.debug('beforeupdatecase'+beforeUpdatecase );
              if (GE_MCS_ChangeOwner.fromVF == true&&c.origin!=null ) {
                if(c.GE_ES_Sub_Type__c==null && c.origin.contains('Email')==false&&c.recordtypeid==MCSCSRecordTypeID && oldMapCase1.get(c.id).ownerid==c.OwnerId )
                {    
                   //User partUsr = new User();
                    //partUsr = [Select id,UserType from User where id =: c.OwnerId];                                                        
                    //if (partUsr.UserType != 'PowerPartner')
                        c.addError('"Sub Type" field is mandatory ');                                   
                }
              }  
            }
            
            List<GE_SS_Project_Region__c> pgrList= New List<GE_SS_Project_Region__c>();

set<id> caseids = New set<id>();

for(Case cids:newcaseList1){

if(cids.recordtypeid==FSRecordTypeID){
caseids.add(cids.GE_SS_Project_Region__c);
}
}


if(caseids.size()>0)
{
pgrList =[select GE_SS_Assignment_Group__c from GE_SS_Project_Region__c where id in : caseids];


if(pgrList.size()>0){

for(Case c:newcaseList1){

if(c.recordtypeid==FSRecordTypeID)
{

c.GE_SS_Assignment_Group__c = pgrList[0].GE_SS_Assignment_Group__c;

}
}
}
}
     }

}


}