@IsTest
public class ProjectStage_RecortypeChangeTest{

public static testMethod void testProjectautomation1(){

Project_ge_og__c fullStreamProject = CommonTestDataFactory_GE_OG.createProjectOG('Test full stream');

Account acc=CommonTestDataFactory_GE_OG.createAccount('testaccount');
opportunity oppty=CommonTestDataFactory_GE_OG.createOppty('testopty',acc.id);
oppty.opportunity_project_ge_og__c=fullStreamProject.id;
update oppty;

fullStreamProject.RecordTypeId = Schema.SObjectType.Project_ge_og__c.getRecordTypeInfosByName().get('Joint Pursuit Project').getRecordTypeId();
update fullStreamProject;
list<id> prjlst=new list<Id>();
prjlst.add(fullStreamProject.id);
//insert prjlst;

ProjectStageAutomation_RecortypeChange.stageautomationforRecordtypechange(prjlst);}
}