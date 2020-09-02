/*
Class/Trigger Name     : ProspectingChecklistRecordCreation
Used Where ?           : Process builder to create records
Purpose/Overview       : Used to create Prospecting Checklist records for the predefined data available in Custom metadata. 
Scrum Team             : Transformation - OPPTY MGMT
Requirement Number     : R-31184
Author                 : Harsha C
Created Date           : 11/Jan/2019
Test Class Name        : 
Code Coverage          : 
*/
global class ProspectingChecklistRecordCreation {
    @InvocableMethod(label='Prospecting Checklist creation' description='TO create Prospecting Checklist Records')
    public Static void recordsOfProspectingChecklist(List<Id> ProjectId){
        List<Prospecting_Checklist_ge_og__c> listProspectingCHkList = new List<Prospecting_Checklist_ge_og__c>();
        try{
            Project_Prospecting_checklist__mdt[] prospectingChecklist =  [SELECT Risk_Guidance__c,Type__c,Label FROM Project_Prospecting_checklist__mdt] ;
            System.debug('prospectingChecklist Size ===== >'+prospectingChecklist.Size());
            for(Id projId : ProjectId){
                for (Project_Prospecting_checklist__mdt checklist : prospectingChecklist) {
                    Prospecting_Checklist_ge_og__c prospectingchklist = new Prospecting_Checklist_ge_og__c();
                    prospectingchklist.Type_ge_og__c = checklist.Label;
                    prospectingchklist.Risk_Guidance_ge_og__c = checklist.Risk_Guidance__c;
                    prospectingchklist.Project_ge_og__c = projId;
                    prospectingchklist.Factor_ge_og__c = checklist.Type__c;
                    listProspectingCHkList.add(prospectingchklist);
                }
            }
            
           Database.insert(listProspectingCHkList);
        }
        catch(Exception e){
            System.debug('Exception occured in line number : '+e.getLineNumber());
            System.debug('Exception Message : '+e.getMessage());
            System.debug('Exception cause :'+e.getCause());
        }
    }
    
 
}