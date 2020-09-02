global without sharing class Clone_Account_Planning_Controller {

	public static list<string> NewlylCLonedPlanID = new list<string> (); 
	public static list<string> Error_List = new list<string>(); 

	global class cloneParameters{
		@InvocableVariable(required=true  label='Plan_year')
		public string Plan_year ;
		@InvocableVariable(required=true  label='Plan_status')
		public String Plan_status;
		@InvocableVariable(required=true  label='sourceId')
		public String sourceId;
	}

	@InvocableMethod(label='Clone Account Planning')
	global static List<string> copyChildRecords(list<cloneParameters>  inputparam) {
		cloneParameters planinputs = inputparam [0] ; 
		string ap_year = planinputs.Plan_year;
		string ap_status = planinputs.Plan_status;
		string ap_sourceid = planinputs.sourceId;

		List<Account_Planning__c> ap_acual = [SELECT id ,Account_Name_GEOG__c ,Status_GEOG__c,Executive_Summary_GEOG__c, Year_GEOG__c ,										Plan_Target_Geog__c, Executive_Sponsor_GEOG__c,name 
											 FROM Account_Planning__c 
											 WHERE id =: ap_sourceid];
		List<Key_Customer_Contacts__c> KCC_actual = [SELECT id ,name,Contact__c,Account_Planning__c 
													FROM Key_Customer_Contacts__c 
													WHERE Account_Planning__c =:ap_sourceid];
		List<Key_Project_ge_og__c> KProj_actual = [SELECT id ,name,Project_ge_og__c,Account_Plan_ge_og__c 
													FROM Key_Project_ge_og__c 
													WHERE Account_Plan_ge_og__c =:ap_sourceid];
		List<Key_Asset_ge_og__c> KAsset_actual = [SELECT id ,name,Asset_ge_og__c,Account_Planning_ge_og__c 
												 FROM Key_Asset_ge_og__c 
												 WHERE  Account_Planning_ge_og__c =:ap_sourceid];
			  
		List<Customer_Strategy_Map_item__c> cmsi_acual = [SELECT id ,name, RecordTypeId,old_cloneid__c,Status__c,Title__c,Applicable_Tier_2__c,			     									Applicable_Region__c,Description__c,Customer_Contact__c  
														 FROM Customer_Strategy_Map_item__c 
														 WHERE Account_Planning__c = :ap_sourceid];
		List<Customer_Strategy_Map_Contacts__c> cmsi_cont = [SELECT id , name ,Customer_Strategy_Map_item__c,Contact__c 
															FROM Customer_Strategy_Map_Contacts__c 
															WHERE Customer_Strategy_Map_item__c IN :cmsi_acual];
		List<Customer_Strategy_Map_Users__c> cmsi_user = [SELECT id , Customer_Strategy_Map_item__c,Strategy_Map_User__c 
														 FROM Customer_Strategy_Map_Users__c WHERE Customer_Strategy_Map_item__c IN :cmsi_acual];
	
		List<Account_Planning__c> cloned_AP = ap_acual.deepclone(false);
		cloned_AP[0].Status_GEOG__c= ap_status;
		cloned_AP[0].Year_GEOG__c = ap_year;
		cloned_AP[0].OwnerId= UserInfo.getUserId();
        cloned_AP[0].Source_Plan_ge_og__c= ap_sourceid;
		Savepoint sp = Database.setSavepoint();

		try{
			insert cloned_AP[0] ;
		}
		 catch(Exception e){
		 system.debug(e.getMessage());
		 Error_List.add(e.getMessage());
		 return Error_List;
		}
			
		
		string new_ap_id = cloned_AP[0].id;
		List<SObject> lstFinalChildren = new List<SObject>();		
		
		// KCC Cloning starts
		//List<Key_Customer_Contacts__c> cloned_kcc = new List<Key_Customer_Contacts__c>() ;
		List<Key_Customer_Contacts__c> cloned_kcc_temp = KCC_actual.deepclone(false);
		//system.debug('----cloned_csmi --'+cloned_kcc_temp);
		for(Key_Customer_Contacts__c Kcc :cloned_kcc_temp)
		{
			Kcc.Account_Planning__c= new_ap_id; 
			//cloned_kcc.add(Kcc);
			lstFinalChildren.add(Kcc);
		}
		//system.debug('@@@ final cloned_KCC old id stored @@@'+cloned_kcc);
        system.debug('@@@ final cloned_KCC old id stored @@@'+lstFinalChildren);

		//insert cloned_kcc;
		//lstFinalChildren.addAll(cloned_kcc);

		//  Key Project cloning begins              

		//List<Key_Project_ge_og__c> cloned_kProject = new List<Key_Project_ge_og__c>() ;
		List<Key_Project_ge_og__c> cloned_kProject_temp = KProj_actual.deepclone(false);
		system.debug('----cloned_csmi --'+cloned_kProject_temp);
		for(Key_Project_ge_og__c Kproj :cloned_kProject_temp)
		{
			Kproj.Account_Plan_ge_og__c= new_ap_id; 
			//cloned_kProject.add(Kproj);
			lstFinalChildren.add(Kproj);
		}
		//system.debug('@@@ final cloned_Kproject old id stored @@@'+cloned_kProject);
				
		//insert cloned_kProject;
		//lstFinalChildren.addAll(cloned_kProject_temp);

		// Key Asset cloning begins
		//List<Key_Asset_ge_og__c> cloned_kAsset = new List<Key_Asset_ge_og__c>() ;
		List<Key_Asset_ge_og__c> cloned_kAsset_temp = KAsset_actual.deepclone(false);
		system.debug('----cloned_csmi --'+cloned_kProject_temp);
		for(Key_Asset_ge_og__c KAst :cloned_kAsset_temp)
		{

		KAst.Account_Planning_ge_og__c= new_ap_id; 
		//cloned_kAsset.add(KAst);
		lstFinalChildren.add(KAst);
		}
		//system.debug('@@@ final cloned_kAsset old id stored @@@'+cloned_kAsset);
				
		//insert cloned_kAsset;
		//lstFinalChildren.addAll(cloned_kAsset_temp);
		
        try{
			insert lstFinalChildren;
		}
		catch(Exception e){
			Database.rollback(sp); 
			Error_List.add(e.getMessage());
			return Error_List;
		}
		

		//CSMI Cloning starts              
		List<Customer_Strategy_Map_item__c> cloned_csmi = new List<Customer_Strategy_Map_item__c> ();
		List<Customer_Strategy_Map_item__c> cloned_csmi_temp = cmsi_acual.clone();
		system.debug('----cloned_csmi --'+cloned_csmi_temp);
		for(Customer_Strategy_Map_item__c csmiWITH_oldid :cloned_csmi_temp)
		{
			csmiWITH_oldid.old_cloneid__c = csmiWITH_oldid.id;
			csmiWITH_oldid.id = Null; 
			csmiWITH_oldid.Account_Planning__c= new_ap_id; 
			cloned_csmi.add(csmiWITH_oldid); 	

		}
		//system.debug('@@@ final cloned_csmi old id stored @@@'+cloned_csmi);
				
		//insert cloned_csmi;
		//lstFinalChildren.addAll(cloned_csmi_temp);
	
		try{
			//insert lstFinalChildren;
			insert cloned_csmi;
            	
		}
		catch(Exception e){
            
            
			Database.rollback(sp); 
			Error_List.add(e.getMessage());
			return Error_List;
            
		}
        
		Map<Id,Id> CSMI_OLD_NEW_ID_MAP = new Map<Id,Id>();
		for(Customer_Strategy_Map_item__c old_new_ID:cloned_csmi)
		{
			CSMI_OLD_NEW_ID_MAP.put(old_new_ID.old_cloneid__c,old_new_ID.id);
		}
		// we are now gonna utilize the above block of code for copying/inserting grand child

        List<SObject> lstGrandChildren_CSMI = new List<SObject>();

		//List<Customer_Strategy_Map_Contacts__c> cloned_csmi_contact = new List<Customer_Strategy_Map_Contacts__c> ();
		List<Customer_Strategy_Map_Contacts__c> cloned_csmi_Contact_temp = cmsi_cont.clone();
		system.debug('--- cloned_csmi contacts - temperory ---'+cloned_csmi_Contact_temp);

		for(Customer_Strategy_Map_Contacts__c csmi_contactWITH_oldid :cloned_csmi_Contact_temp)
		{
			csmi_contactWITH_oldid.id = Null; 
			system.debug('old csmi in csmi-contact---'+csmi_contactWITH_oldid.Customer_Strategy_Map_item__c);
			csmi_contactWITH_oldid.Customer_Strategy_Map_item__c = CSMI_OLD_NEW_ID_MAP.get(csmi_contactWITH_oldid.Customer_Strategy_Map_item__c);
			//cloned_csmi_contact.add(csmi_contactWITH_oldid);
			lstGrandChildren_CSMI.add(csmi_contactWITH_oldid);
		}

		//system.debug('@@@ final cloned_csmi-contact with their coreeponding new CSMI @@@'+cloned_csmi_contact);
		//insert cloned_csmi_contact;
		//lstGrandChildren_CSMI.addAll(cloned_csmi_Contact_temp);
		
		// Insert CSMI-USER 
		//List<Customer_Strategy_Map_Users__c> cloned_csmi_user = new List<Customer_Strategy_Map_Users__c> ();
		List<Customer_Strategy_Map_Users__c> cloned_csmi_user_temp = cmsi_user.clone();
		system.debug('### cloned_csmi USER - temperory ###'+cloned_csmi_user_temp);

		for(Customer_Strategy_Map_Users__c csmi_userWITH_oldid :cloned_csmi_user_temp)
		{
			csmi_userWITH_oldid.id = Null; 
			csmi_userWITH_oldid.Customer_Strategy_Map_item__c = CSMI_OLD_NEW_ID_MAP.get(csmi_userWITH_oldid.Customer_Strategy_Map_item__c);
			//cloned_csmi_user.add(csmi_userWITH_oldid);
            lstGrandChildren_CSMI.add(csmi_userWITH_oldid);

		}
		//system.debug('@@@ final cloned_csmi-user with their coreeponding new CSMI @@@'+cloned_csmi_user);
		//insert cloned_csmi_user;
		//lstGrandChildren_CSMI.addAll(cloned_csmi_user_temp);
		try{
			insert lstGrandChildren_CSMI;
		}
		catch(Exception e){
			Database.rollback(sp);
			Error_List.add(e.getMessage());
			return Error_List;
		}

		if(new_ap_id !=''){
			NewlylCLonedPlanID.add(new_ap_id);
		}
		return NewlylCLonedPlanID;
	}                                     
}