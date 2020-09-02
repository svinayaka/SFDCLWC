/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest(seealldata=true)
private class GE_HQ_SetTechnicianAddressFromWOAddTest {

    static testMethod void myUnitTest() {
        
        SVMXC__Service_Group__c team = new SVMXC__Service_Group__c(
           Name = 'test'
        );
        
        insert team;
        
        SVMXC__Service_Group_Members__c tech = new SVMXC__Service_Group_Members__c(
           SVMXC__Street__c = 'test Home street',
           SVMXC__City__c = 'test home city',
           SVMXC__State__c = 'test home state',
           SVMXC__Country__c = 'United States',
           SVMXC__Zip__c = 'test home zip',
           SVMXC__Longitude__c = 1.1,
           SVMXC__Latitude__c = 1.2,
           SVMXC__Service_Group__c = team.Id,
           GE_SM_HQ_SSO_ID__c = '123',
           GE_SM_HQ_Regional_Manager__c = 'test Manager'
        );
        
        insert tech;
        
        SVMXC__Skill__c skill=new SVMXC__Skill__c();
    
        insert skill;
        
        SVMXC__Service_Order__c wo = new SVMXC__Service_Order__c(
           SVMXC__Street__c = 'test wo street',
           SVMXC__City__c = 'test wo city',
           SVMXC__State__c = 'test wo state',
           SVMXC__Skill__c=skill.id,
           SVMXC__Country__c = 'Canada',
           SVMXC__Zip__c = 'test wo zip',
           SVMXC__Longitude__c = 3.1,
           SVMXC__Latitude__c = 3.2,
           GE_OG_MC_Service_Region__c = 'China',
            GE_OG_MC_Business_Unit__c='BN',
           
           SVMXC__Group_Member__c = tech.Id
        );
        
        insert wo;
        
        Test.startTest();
        
        wo.GE_SM_HQ_Set_Technician_Location_To_Site__c = true;
        
        update wo;
        
        tech = [SELECT Id, SVMXC__City__c, SVMXC__Street__c, SVMXC__State__c, SVMXC__Zip__c, SVMXC__Country__c, SVMXC__Longitude__c, SVMXC__Latitude__c FROM SVMXC__Service_Group_Members__c WHERE Id = :tech.Id LIMIT 1];
/*        
        system.assertEquals(wo.SVMXC__City__c, tech.SVMXC__City__c);
        system.assertEquals(wo.SVMXC__State__c, tech.SVMXC__State__c);
        system.assertEquals(wo.SVMXC__Street__c, tech.SVMXC__Street__c);
        system.assertEquals(wo.SVMXC__Country__c, tech.SVMXC__Country__c);
        system.assertEquals(wo.SVMXC__Zip__c, tech.SVMXC__Zip__c);
        system.assertEquals(wo.SVMXC__Longitude__c, tech.SVMXC__Longitude__c);
        system.assertEquals(wo.SVMXC__Latitude__c, tech.SVMXC__Latitude__c);
*/        
        wo.GE_SM_HQ_Set_Technician_Location_To_Site__c = false;
        
        update wo;
        
        tech = [SELECT Id, SVMXC__City__c, GE_SM_HQ_Home_City__c, SVMXC__Street__c, GE_SM_HQ_Home_Street__c, SVMXC__State__c, GE_SM_HQ_Home_State__c, SVMXC__Zip__c, GE_SM_HQ_Home_Zip__c, SVMXC__Country__c, GE_SM_HQ_Home_Country__c, SVMXC__Longitude__c, GE_SM_HQ_Home_Longitude__c,  SVMXC__Latitude__c, GE_SM_HQ_Home_Latitude__c FROM SVMXC__Service_Group_Members__c WHERE Id = :tech.Id LIMIT 1];
        
/*        system.assertEquals(tech.GE_SM_HQ_Home_City__c, tech.SVMXC__City__c);
        system.assertEquals(tech.GE_SM_HQ_Home_State__c, tech.SVMXC__State__c);
        system.assertEquals(tech.GE_SM_HQ_Home_Street__c, tech.SVMXC__Street__c);
        system.assertEquals(tech.GE_SM_HQ_Home_Country__c, tech.SVMXC__Country__c);
        system.assertEquals(tech.GE_SM_HQ_Home_Zip__c, tech.SVMXC__Zip__c);
        system.assertEquals(tech.GE_SM_HQ_Home_Longitude__c, tech.SVMXC__Longitude__c);
        system.assertEquals(tech.GE_SM_HQ_Home_Latitude__c, tech.SVMXC__Latitude__c);
*/        
        Test.stopTest();
        
    }
    
}