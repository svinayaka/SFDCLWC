@istest(SeeAllData=true)
public class GE_OG_SVMXC_Service_Group_Members_Test {
  
    // have to use seealldata=true because of dependent ServiceMax code it is dependent on (seed configurationdata)
    static testMethod void verrifyTechCCDataRedact() {
        // Create a ServiceTeam
        SVMXC__Service_Group__c serviceTeam = new SVMXC__Service_Group__c(Name='Matt\'s awesome team');
        
        List<SVMXC__Service_Group__c> serviceTeamList = new List<SVMXC__Service_Group__c>{};
        serviceTeamList.add(serviceTeam);
        
        test.startTest();
        
        insert serviceTeam;
                    
        // Create Technican record with dummy credit card data
        //Map<String, Schema.RecordTypeInfo> techRecordTypeInfo = 
          //  Schema.SObjectType.SVMXC__Service_Group_Members__c.getDescribe().getRecordTypeInfosByName();
        //String techRecordTypeId = techRecordTypeInfo.get('GE OG GS Employee').getRecordTypeId();
        
        SVMXC__Service_Group_Members__c tech = new SVMXC__Service_Group_Members__c(
            Name='Test Tech',
            SVMXC__Service_Group__c=serviceTeam.Id,          
            GE_OG_GS_CREDIT_CARD_EXPIRY_DATE__C=Date.newInstance(1981, 12, 27),
            GE_OG_GS_CREDIT_CARD_NUMBER__C = '123456789',
            GE_OG_GS_CREDIT_CARD_VERIFICATION_CODE__C = '1234',
        GE_HQ_SFDC_LEGACY_ID__c = '@#$jdi@!#I&^*ddk',
        GE_SM_HQ_SSO_ID__c = '#66%^8$#@');
        
        List<SVMXC__Service_Group_Members__c> newTechs = new List<SVMXC__Service_Group_Members__c>{};
        newTechs.add(tech);
            
        insert newTechs;
        
        test.stopTest();
        
        // run the code that should redact the Credit Card data.  Constructor should run the redact method
        GE_OG_GS_CC_Redact_Batch_Job job = new GE_OG_GS_CC_Redact_Batch_Job();
        
        // get the tech data after the redact process runs
        List<SVMXC__Service_Group_Members__c> techList = [Select Name, GE_OG_GS_CREDIT_CARD_EXPIRY_DATE__C,
                                                          GE_OG_GS_CREDIT_CARD_NUMBER__C,
                                                          GE_OG_GS_CREDIT_CARD_VERIFICATION_CODE__C,
                                                          GE_OG_GS_CC_Redact_Flag__c
                                                          from SVMXC__Service_Group_Members__c 
                                                          where Id In: newTechs];     
        // If in a sandbox
        if(!URL.getSalesforceBaseUrl().getHost().equals(Label.GE_Oil_Gas_Production_URL)
           && URL.getSalesforceBaseUrl().getHost().contains('.cs'))
        {        
            // if in a sandbox the job should update the data
            for(SVMXC__Service_Group_Members__c i : techList){
                System.assertEquals('XXXXXXXXXXXXXX', i.GE_OG_GS_CREDIT_CARD_NUMBER__C);
                System.assertEquals('XXXX', i.GE_OG_GS_CREDIT_CARD_VERIFICATION_CODE__C);
                System.assert(i.GE_OG_GS_CC_Redact_Flag__c);
            }
        }
        else{
            // if in production the data should not be updated
            for(SVMXC__Service_Group_Members__c i : techList){
                System.assertEquals('123456789', i.GE_OG_GS_CREDIT_CARD_NUMBER__C);
                System.assertEquals('1234', i.GE_OG_GS_CREDIT_CARD_VERIFICATION_CODE__C);
                System.assert(!i.GE_OG_GS_CC_Redact_Flag__c);
            }
        }
        
     }
     
     //R-24803 added by Nehal 
     static testMethod void RegionCustomSettingtestmethod(){
 
        Country_Region_Mapping_ge_og__c cr = new Country_Region_Mapping_ge_og__c();
        cr.name = 'test';
        cr.country_name_ge_og__c = 'test';
        cr.region_ge_og__c = 'test';
        insert cr;
        
        String regionName = TechnicianRegionUpdate_GE_OG.regionPopulateByCountry('test');
        system.assertEquals('test',cr.region_ge_og__c);
        
        SVMXC__Service_Group__c serviceTeam = new SVMXC__Service_Group__c(Name = 'testTeam');
        
        List<SVMXC__Service_Group__c> serviceTeamList = new List<SVMXC__Service_Group__c>{};
        serviceTeamList.add(serviceTeam);
        
        test.startTest();
        
        insert serviceTeam;
                    
        SVMXC__Service_Group_Members__c tech = new SVMXC__Service_Group_Members__c(
            Name='Test Tech',
            SVMXC__Service_Group__c=serviceTeam.Id,          
        GE_SM_HQ_SSO_ID__c = '&8*$$56^');
        
        List<SVMXC__Service_Group_Members__c> newTechs = new List<SVMXC__Service_Group_Members__c>{};
        newTechs.add(tech);
            
        insert newTechs;
        System.assertEquals('Test Tech',tech.name);
       
        delete newTechs;
        System.assertEquals('Test Tech',tech.name);
        
        undelete newTechs;
        
        test.stopTest();
        
 }
 
     
     
}