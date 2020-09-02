@isTest
private class BMUserSecuritiesInsertUpdateTest {
	
	static Integer batchSize = 100;
	
	public static testMethod void testSingleInsertValid(){
		/** 
			1 scenario: insert 1 new active record
		*/
		try{
			//delete existing records
			BMUserSecurity__c[] userSecurities = [SELECT Name FROM BMUserSecurity__c];
			delete userSecurities;
			
			BMUserSecurity__c bmSec = getBmSec();	
			insert bmSec;
			
			BMUserSecurity__c[] bmSecInserted = [SELECT APIUserName__c FROM BMUserSecurity__c where APIUserName__c ='BM API User'];
			
			System.assertEquals(bmSecInserted.size(),1);
			System.assertEquals(bmSecInserted[0].APIUserName__c,'BM API User');
		}
		catch(Exception e){
			System.debug('Exception in testSingleInsertValid: ' + e.getMessage());
		}
			
		
	}
	
	
	public static testMethod void testMultipleInsertInvalid(){
		/** 
			2 scenario: insert multiple active configs
		*/
		
		//delete existing records
		BMUserSecurity__c[] userSecurities = [SELECT Name FROM BMUserSecurity__c];
		delete userSecurities;
		
		userSecurities.clear();
		try{
			for(integer i=0;i<batchSize; i++){
				BMUserSecurity__c bmSec = getBmSec();				
				userSecurities.add(bmSec);
			}
			
			Test.startTest();
			insert userSecurities;
			Test.stopTest();		
			
		}
		catch(Exception e){
			System.assert(e != null);
			System.assert(e.getMessage().contains(BMGlobal.ERROR_MULTIPLE_ACTIVE_CONFIGS));
			
		}	
		
	}
	
	
	public static testMethod void testSecondActiveInsertInvalid(){
		/** 
			3 scenario: insert second active record
		*/
		
		//delete existing records
			//delete existing records
		BMUserSecurity__c[] userSecurities = [SELECT Name FROM BMUserSecurity__c];
		delete userSecurities;
		
		BMUserSecurity__c bmSec = getBmSec();	
		insert bmSec;
		
		bmSec.isActive__c = false;
		update bmSec;
		
		bmSec.isActive__c = true;
		update bmSec;
		
		try{
			BMUserSecurity__c bmSecSecond = getBmSec(); 	
			insert bmSecSecond;
		}
		catch(Exception e){
			System.assert(e != null);
			System.assert(e.getMessage().contains(BMGlobal.ERROR_MULTIPLE_ACTIVE_CONFIGS));
			
		}	
		
	}
		
	private static BMUserSecurity__c getBmSec(){
		BMUserSecurity__c bmSec = new BMUserSecurity__c();
		bmSec.isActive__c = true;		
		bmSec.APIUserName__c = 'BM API User';
		bmSec.APISubDomain__c = 'BM Endpoint';
		bmSec.APIUserPassword__c = 'BM password';
		bmSec.AdminEmail__c = 'email@email.com';	
		bmSec.BMSSLRequired__c = false;		
		return bmSec;	
	
	}
}