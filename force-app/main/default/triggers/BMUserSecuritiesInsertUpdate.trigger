trigger BMUserSecuritiesInsertUpdate on BMUserSecurity__c (before insert, before update){
	if(Trigger.isBefore)
		if(Trigger.isInsert || Trigger.isUpdate){
			//check new records for duplicates
			for(integer i=0;i<Trigger.new.size()-1;i++){
				for(integer j=i+1;j<Trigger.new.size();j++)		
					if((Trigger.new[i].isActive__c == true) && (Trigger.new[j].isActive__c== true)){
						Trigger.new[i].addError(BMGlobal.ERROR_MULTIPLE_ACTIVE_CONFIGS);	
					}						
					
			}
			//check the old records
			Set<Id> activeConfigs = new Set<Id>();
			for(BMUserSecurity__c bmsec: Trigger.new){
				if(bmsec.isActive__c == true)
					if(Trigger.isUpdate && (bmsec.isActive__c != Trigger.oldMap.get(bmSec.Id).isActive__c))
						activeConfigs.add(bmSec.Id);
					else if (Trigger.isInsert)
						activeConfigs.add(bmSec.Id);				
			}
			if(activeConfigs.size()>0){
				BMUserSecurity__c[] userSecurities = [SELECT Name FROM BMUserSecurity__c WHERE isActive__c = true];
				if(userSecurities.size()>0)
					for(BMUserSecurity__c bmsec: Trigger.new){
						bmsec.addError(BMGlobal.ERROR_MULTIPLE_ACTIVE_CONFIGS);
					}
			}			
		}	
}