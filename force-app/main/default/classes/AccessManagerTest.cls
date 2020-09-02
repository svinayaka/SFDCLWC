/*
Apex Class Name: AccessManagerTest
Used Where ? : Test Class for Edit AccessManager Process
Purpose/Overview : Testing and CodeCoverage
Functional Area : Testing                               
*/
@isTest()
Public class AccessManagerTest {
    
    public static testMethod void test1() {
        
        PageReference pageRef = Page.EditAccessManager;
        Test.setCurrentPage(pageRef);
        
        GE_OG_AccessManager__c am = new GE_OG_AccessManager__c(Is_Active__c= true,GE_OG_Super_User__c= UserInfo.getUserId());
        
        ApexPages.StandardController sc = new ApexPages.StandardController(am);
        EditAccessManager controller = new EditAccessManager(sc);
        
        controller.enabledAccessType.add(controller.allAccessType[0]);
        controller.enabledPermissionSets.add(controller.allPermissionSets[0]);
        controller.enabledManagedPackages.add(controller.allManagedPackages[0]);
        controller.enabledProfiles.add(controller.allProfiles[0]);
        controller.enabledGroups.add(controller.allGroups[0]);
        controller.enabledQueues.add(controller.allQueues[0]);         
        
        controller.save();
        
        AccessManager contAM = new AccessManager();
        pageRef = Page.AccessManager;
        Test.setCurrentPage(pageRef);
        
        contAM.accessSelected = 'Managed Package Dashboard';
        contAM.exportItems();
        
        contAM.accessSelected = 'Permission Set Dashboard';
        contAM.exportItems();
        
        contAM.accessSelected = 'Public Group Dashboard';
        contAM.exportItems();
        
        contAM.accessSelected = 'Queue Dashboard';
        contAM.exportItems();
        
        contAM.accessSelected = 'Managed Packages';
        contAM.searchUserString = UserInfo.getName();
        AccessManager.searchItems(contAM.searchUserString,contAM.accessSelected,null);
        contAM.userId = UserInfo.getUserId();
        contAM.Refresh();
        
        SelectOption[] temp = contAM.enableditems;
        contAM.enableditems = contAM.allitems;
        contAM.allitems = temp;
        contAM.saveItems();
        
        contAM.Refresh();
        temp = contAM.enableditems;
        contAM.enableditems = contAM.allitems;
        contAM.allitems = temp;
        contAM.saveItems();
        
        contAM.accessSelected = 'Permission Sets';
        contAM.Refresh();
        
        temp = contAM.enableditems;
        contAM.enableditems = contAM.allitems;
        contAM.allitems = temp;
        contAM.saveItems();
        
        contAM.Refresh();
        temp = contAM.enableditems;
        contAM.enableditems = contAM.allitems;
        contAM.allitems = temp;
        contAM.saveItems();
        
        contAM.accessSelected = 'Public Groups';
        contAM.searchTypes = 'Users';
        contAM.Refresh();
        
        temp = contAM.enableditems;
        contAM.enableditems = contAM.allitems;
        contAM.allitems = temp;
        contAM.saveItems();
        
        contAM.Refresh();
        temp = contAM.enableditems;
        contAM.enableditems = contAM.allitems;
        contAM.allitems = temp;
        contAM.saveItems();
        
        contAM.accessSelected = 'Queues';
        contAM.Refresh();
        
        temp = contAM.enableditems;
        contAM.enableditems = contAM.allitems;
        contAM.allitems = temp;
        contAM.saveItems();
        
        contAM.Refresh();
        temp = contAM.enableditems;
        contAM.enableditems = contAM.allitems;
        contAM.allitems = temp;
        contAM.saveItems();
        
        contAM.accessSelected = 'Profile/Role Updates';
        contAM.Refresh();
        AccessManager.searchRoles('aa');
        contAM.saveUser();
        
        contAM.cancelPage();
    }
    
    public static testMethod void testTiers() {
        
        PageReference pageRef = Page.EditAccessManager;
        Test.setCurrentPage(pageRef);
        
        GE_OG_AccessManager__c am = new GE_OG_AccessManager__c(Is_Active__c= true,GE_OG_Super_User__c= UserInfo.getUserId());
        
        ApexPages.StandardController sc = new ApexPages.StandardController(am);
        EditAccessManager controller = new EditAccessManager(sc);
        
        controller.enabledAccessType.add(controller.allAccessType[0]);
        controller.enabledPermissionSets.add(controller.allPermissionSets[0]);
        controller.enabledManagedPackages.add(controller.allManagedPackages[0]);
        controller.enabledProfiles.add(controller.allProfiles[0]);
        controller.enabledGroups.add(controller.allGroups[0]);
        controller.enabledQueues.add(controller.allQueues[0]);         
        
        controller.save();
        
        AccessManager contAM = new AccessManager();
        pageRef = Page.AccessManager;
        Test.setCurrentPage(pageRef);
        
        contAM.searchUserString = UserInfo.getName();
        AccessManager.searchItems(contAM.searchUserString,contAM.accessSelected,null);
        contAM.userId = UserInfo.getUserId();
        contAM.accessSelected = 'Tiers';
        contAM.Refresh();
  
        // if muser is not null{
        // if(muser Tier 1 is not null )
        // 	Run the save method
        // 
        // 	Assert you get a success message back
        // 	 List<Apexpages.Message> msgs = ApexPages.getMessages();
        //boolean b = false;
        //for(Apexpages.Message msg:msgs){
        //    if (msg.getDetail().contains('Search requires more characters')) b = true;
        //}
        //system.assert(b);
        // 	end if Tier 1 is not null
        // 	
         List<Apexpages.Message> msgs = new List<Apexpages.Message>();
        System.debug('mUser ' + contAM.mUser);
        if (contAM.muser != null){ 
            system.debug('Tier 1' + contAM.muser.GE_HQ_Tier_1_P_L__c);
            if (contAM.muser.GE_HQ_Tier_1_P_L__c != null)
                contAM.saveTiers();
            msgs = ApexPages.getMessages();
            boolean b = false;
            for(Apexpages.Message msg:msgs){
                if (msg.getDetail().contains('Tier(s) updated successfully!')) b = true;
            }
            system.assert(b);
            
        }
            //end if muser.GE_HQ_Tier_1_P_L__c <> null }
	
        // 	Set the muser Tier fields (all of them) to null
        // 	Run the save method and validate that you get an apex error message back (code below)
        //         
        // List<Apexpages.Message> msgs = ApexPages.getMessages();
        //boolean b = false;
        //for(Apexpages.Message msg:msgs){
        //    if (msg.getDetail().contains('Search requires more characters')) b = true;
        //}
        //system.assert(b);
        
        // end if muser is not null }
        
        contAM.mUser.GE_HQ_Tier_1_P_L__c = null; contAM.mUser.GE_HQ_Tier_2_P_L__c = null; contAM.mUser.GE_HQ_Tier_3_P_L__c = null;
        contAM.saveTiers();
        
        msgs = ApexPages.getMessages();
        boolean b = false;
        for(Apexpages.Message msg:msgs){
            if (msg.getDetail().contains('Tier 1 must be given a value.')) b = true;
        }
        system.assert(b);
        
           // end if muser <> null }
        
    }
}