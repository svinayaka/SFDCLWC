@isTest(seealldata=true)
public class Nonprmuser_Ch_Cntrct_restriction_test {
    
    @isTest
    
    static void test_contract_restriction(){
        TestUserUtil.createTestUser();
             Contract ctr = [select id, name ,status, GE_PRM_Without_Cause__c from Contract  where  RecordType.Name = 'Channel Master Agreement' limit 1];
                      ctr.GE_PRM_Without_Cause__c ='30 days';

        try
        {
   			update ctr;
        }
        catch(exception e)
        {
            system.debug('display any error if found :P'+e);
        }
system.debug('&&&&&&&& after update'+ctr.id);
        
        try
        {
            ctr.GE_PRM_Without_Cause__c ='30 days';
            update ctr;
        }
        catch(exception e)
        {
            system.debug('display any error if found in second time :P'+e);
        }
system.debug('&&&&&&&& after update for second tome to make recusive () = false'+ctr.id);
        
    }       
/*         @isTest
 static void test_underNRT_contract_restriction(){
         Contract ctr = [select id, name ,status, GE_PRM_Without_Cause__c from Contract  where  RecordType.Name = 'Channel Addendum Agreement' and Status ='Under NR/T' limit 1];
                      ctr.GE_PRM_Without_Cause__c ='30 days';

        try
        {
   			update ctr;
        }
        catch(exception e)
        {
            system.debug('display any error if found :P'+e);
        }
        */
     /*    Test.startTest();
        Account GlobalAcc = AccountTestDataFactory.createRelationshipAccountGlobal('Master Account Global / HQ','Customer');
        
        Account countryact =AccountTestDataFactory.createRelationshipAccount ('Test Country Account');
        system.debug('country account is'+countryact);
        Account Legalact  = AccountTestDataFactory.createLegalEntityAccount1('Test Legal Entity', countryact.id,'Direct Customer');
        system.debug('country account is'+Legalact); 
        Contract cntrct = new Contract();
        id channeladdendum_ID1 = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Channel Addendum Agreement').getRecordTypeId();
        id channeladdendum_ID2 = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Channel Master Agreement').getRecordTypeId();
        system.debug('record type id c.addendum'+channeladdendum_ID1); 
        cntrct.name='test contract';
        cntrct.Status='Generate Draft';
        //cntrct.Status='Under Renewal';
        cntrct.AccountId=GlobalAcc.Id;
        cntrct.RecordTypeId = channeladdendum_ID2;
        cntrct.GE_PRM_Without_Cause__c ='30 days';
        system.debug('&&&&&&&&+befor insert'); 
        try{
            
        insert cntrct;  
        system.debug('insert .......'+cntrct.id);
       
      //  Integer start = System.Now().millisecond();
       // while(System.Now().millisecond()< start+1000){ 
            
            //checkRecursive.runbefore = true;
            cntrct.GE_PRM_Without_Cause__c ='45 days';
            update cntrct;
        }
        catch(Exception e){System.debug('exception is'+e);}
        system.debug('&&&&&&&&+after update/ '+cntrct.GE_PRM_Without_Cause__c);
             Test.stopTest();
            system.debug('&&&&&&&&+after update/ insert'+cntrct.AccountId);
       // }
  */      
   // }
    }