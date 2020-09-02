global class MobileAltSyncReset implements Database.batchable<Id>
{
global Iterable<id> start(Database.batchableContext info)
{
 		set<id> RemoveDuplicateIds = new set<id>();
	set<id> AccountContactSetStillNeedToBeTrue = new set<id>();
	list<id> AccountContactsNeedToMakeFalse = new list<id>();
	 
	 for(FX5__Job__c j: [select id,SD_Account_Manager__c,FX5__Well__c,SD_Rig_Name__c,FX5__CustomerAccount__c,SD_Primary_Customer_Contact_Name__c,FX5__Primary_Job_Contact__c from FX5__Job__c  where SD_Stage__c !='Complete'])
	 {
		 AccountContactSetStillNeedToBeTrue.add(j.SD_Account_Manager__c);
		 AccountContactSetStillNeedToBeTrue.add(j.FX5__CustomerAccount__c);
		 AccountContactSetStillNeedToBeTrue.add(j.SD_Primary_Customer_Contact_Name__c);
		 AccountContactSetStillNeedToBeTrue.add(j.FX5__Primary_Job_Contact__c);
		 AccountContactSetStillNeedToBeTrue.add(j.FX5__Well__c);
		 AccountContactSetStillNeedToBeTrue.add(j.SD_Rig_Name__c);
		 
	 }
	 
	for(FX5__Job__c j: [select id,SD_Rig_Name__c,FX5__Well__c,SD_Account_Manager__c,FX5__CustomerAccount__c,SD_Primary_Customer_Contact_Name__c,FX5__Primary_Job_Contact__c,
	SD_Account_Manager__r.Altsync__c,FX5__CustomerAccount__r.Altsync__c,SD_Rig_Name__r.altsync__c,FX5__Well__r.Altsync__c,SD_Primary_Customer_Contact_Name__r.Altsync__C,FX5__Primary_Job_Contact__r.Altsync__c

	from FX5__Job__c where SD_Stage__c = 'Complete' AND 
	(SD_Account_Manager__c not in:AccountContactSetStillNeedToBeTrue  OR
	FX5__CustomerAccount__c not in: AccountContactSetStillNeedToBeTrue OR
	SD_Primary_Customer_Contact_Name__c not in: AccountContactSetStillNeedToBeTrue OR
	FX5__Primary_Job_Contact__c not in: AccountContactSetStillNeedToBeTrue OR
	FX5__Well__c not in : AccountContactSetStillNeedToBeTrue OR
	SD_Rig_Name__c not in: AccountContactSetStillNeedToBeTrue) AND
	(SD_Rig_Name__r.Altsync__c =true OR FX5__Well__r.Altsync__c =true OR SD_Account_Manager__r.Altsync__c = true OR FX5__CustomerAccount__r.Altsync__c = true OR SD_Primary_Customer_Contact_Name__r.Altsync__C=true OR  FX5__Primary_Job_Contact__r.altsync__c=true )])
	{
		if((!AccountContactSetStillNeedToBeTrue.contains(j.SD_Account_Manager__c)) && j.SD_Account_Manager__r.Altsync__c == true)
		 AccountContactsNeedToMakeFalse.add(j.SD_Account_Manager__c);
		 
		if((!AccountContactSetStillNeedToBeTrue.contains(j.FX5__CustomerAccount__c)) && j.FX5__CustomerAccount__r.Altsync__c==true)
		AccountContactsNeedToMakeFalse.add(j.FX5__CustomerAccount__c);

		if((!AccountContactSetStillNeedToBeTrue.contains(j.SD_Primary_Customer_Contact_Name__c)) && j.SD_Primary_Customer_Contact_Name__r.Altsync__C==true)
		AccountContactsNeedToMakeFalse.add(j.SD_Primary_Customer_Contact_Name__c);

		if((!AccountContactSetStillNeedToBeTrue.contains(j.FX5__Well__c)) && j.FX5__Well__r.Altsync__c==true)
		AccountContactsNeedToMakeFalse.add(j.FX5__Well__c);
		
		if((!AccountContactSetStillNeedToBeTrue.contains(j.SD_Rig_Name__c)) && j.SD_Rig_Name__r.Altsync__c==true)
		AccountContactsNeedToMakeFalse.add(j.SD_Rig_Name__c);
	 }

 
    if(AccountContactsNeedToMakeFalse.size()>0)
    {
    	RemoveDuplicateIds.addAll(AccountContactsNeedToMakeFalse); 
        AccountContactsNeedToMakeFalse.clear();
        
        AccountContactsNeedToMakeFalse.addAll(RemoveDuplicateIds);
    }
return AccountContactsNeedToMakeFalse;
}
   

 global void execute(Database.batchableContext info,List<Id> scope)
 {
 system.debug('test');
	  List<Account> updateAccountList = new List<Account>();
	  List<Contact> updateContactList = new List<contact>();
	  List<FX5__Well__c> updateWellList = new List<FX5__Well__c>();
	  List<SD_Rig__c>  updateRigList = new List<SD_Rig__c>();
	  
	 for (id i :scope)
	 {

		 String ids = string.valueof(i);
		 
		 if(ids.substring(0, 3) == '001')
		 {
			 Account A= new Account();
			 A.id=i;
			 A.Altsync__C = false;
			 updateAccountList.add(A); 
		 }
		 
		 else
		 {	if(ids.substring(0, 3) == 'aC7')
			{
			FX5__Well__c w= new FX5__Well__c();
			 w.id=i;
			 w.Altsync__C = false;
			 updateWellList.add(w);
			System.debug(updateWellList);			 
			}
			if(ids.substring(0, 3) == 'aCP')
			{
			SD_Rig__c r= new SD_Rig__c();
			 r.id=i;
			 r.Altsync__C = false;
			 updateRigList.add(r); 
			}
			if(ids.substring(0, 3)== '003')
			{			
			 Contact C= new Contact();
			 C.id=i;
			 C.Altsync__C = false;
			 updateContactList.add(C); 
			}
		 }
     }
		
		if(updateAccountList.size()>0)
		database.update(updateAccountList,false);

		if(updateContactList.size()>0)
		database.update(updateContactList,false);
		
		if(updateWellList.size()>0)
		database.update(updateWellList,false);

		if(updateRigList.size()>0)
		database.update(updateRigList,false);

	 }

 global void finish(Database.batchableContext info)
 {

 }
}