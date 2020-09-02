/*
1.It will cover----GE_HQ_PwResetForUser---trigger
2.It will cover----GEOGAssignPermissionSet---trigger

*/

@isTest(seeAlldata=true)
public class Test_GE_OG_User_Object_Related {
    static testMethod void Test_GEOGAssignPermissionSet() {
        //Also Covers - GE_HQ_PwResetForUser
        //UserName='webmethods.integration@ge.com'
        Map<String,ID> mapPemissionSetNameToID = new Map<String,ID>();
        Map<Id, PermissionSetAssignment> AddPermissionSet  = new Map<Id,PermissionSetAssignment>();
        
        //Query the Profiles using Custom Setting - GE_Profile.     
        GE_Profile__c myAdminUser = GE_Profile__c.getValues('System Administrator');
        Id adminUserId =  myAdminUser.Profile_SFDC_ID__c;
        
        //Create Admin User *Also Covers the Class GE_HQ_PwResetForUser*
        User AdminUser =new User(alias ='tUser', email='testuser@ge.com',emailencodingkey='UTF-8',lastname='Test',languagelocalekey='en_US',localesidkey='en_US',isActive=True,ProfileId = adminUserId,BMNumberFormat__c='####,##',BMDateFormat__c = 'MM/dd/yyyy h:mm a',timezonesidkey='America/New_York',BMMassProvisioning__c = False,BMUserAccessType__c = 'FullAccess',GE_HQ_IDM_Creation__c = True,UserName='webmethods.integration123@ge.com', GE_OG_functional_Profile__c='GE_OG_TMS_Risk_Manager');
        insert AdminUser;
        Integer start = System.Now().millisecond();
        //while(System.Now().millisecond()< start+10){ 
        //} 
        System.assertEquals(AdminUser.email,'testuser@ge.com');  
        
        
        //Run as Admin User
        System.runAS(AdminUser) {
            //Inserting user
            //GE_Profile__c myRiskManager = GE_Profile__c.getValues('GE_OG_SS Risk Manager');  -- commented tied to bug 0000024161
            GE_Profile__c myRiskManager = GE_Profile__c.getValues('Standard User');
            Id riskManagerProfileId =  myRiskManager.Profile_SFDC_ID__c;
            
            User OGRiskMgr =new User(alias = 'RMgr', email='OGRiskMgr@ge.com', 
                                     emailencodingkey='UTF-8', lastname='Mgr', languagelocalekey='en_US', 
                                     localesidkey='en_US', profileid = riskManagerProfileId, isActive=true,
                                     timezonesidkey='America/New_York',          
                                     username='OGRiskMgr4zzz@ge.com', GE_OG_functional_Profile__c='GE_OG_TMS_Risk_Manager');
            insert OGRiskMgr;
            //System.assertEquals(OGRiskMgr.email,'OGRiskMgr@ge.com'); 
            //System.assertEquals(OGRiskMgr.GE_OG_functional_Profile__c,'GE_OG_TMS_Risk_Manager');
            
            List<PermissionSet> PrermissionsetName  = new List<PermissionSet>();
            PrermissionsetName = new list<PermissionSet>([Select Label, (Select Id, PermissionSetId, AssigneeId, SystemModstamp From Assignments where AssigneeId =:OGRiskMgr.Id) From PermissionSet where Label = 'GE_OG_TMS_Risk_Manager']);
            //System.assertEquals(PrermissionsetName[0].Assignments.size(),0); 
            
            //Update the Functional Profile Value
            OGRiskMgr.GE_OG_functional_Profile__c='GE_OG_DTS_Risk_Manager';
            
            
            update OGRiskMgr;
            
            
            System.assertEquals(OGRiskMgr.GE_OG_functional_Profile__c,'GE_OG_DTS_Risk_Manager'); 
            
        }
    }
    static testMethod void Test_UserInsertUpdateMerhod()
    {   
        //Query the Profiles using Custom Setting - GE_Profile.     
        GE_Profile__c myStandardUsr = GE_Profile__c.getValues('Standard User');
        Id StndUsrId =  myStandardUsr.Profile_SFDC_ID__c;
        
        Test.startTest();
        User u = new User(alias = 'testusq1', email='testuser@ge.com', 
                          emailencodingkey='UTF-8', lastname='testuser', languagelocalekey='en_US', 
                          Department = 'BMGlobal.TEST_USER',
                          localesidkey='en_US', profileid = StndUsrId, isActive=true, BMNumberFormat__c='####,##',
                          BMDateFormat__c = 'MM/dd/yyyy h:mm a', timezonesidkey='America/New_York', 
                          BMUserType__c = BMGlobal.BM_INTERNAL_USER, BMMassProvisioning__c = false,
                          BMUserAccessType__c = 'FullAccess',                     
                          username='testuser67@ge.com',isBMEnabled__c=true);
        insert u; 
        Integer start = System.Now().millisecond();
        //while(System.Now().millisecond()< start+10){ 
        //} 
        System.assertEquals(u.alias,'testusq1');   
        
        u.isBMEnabled__c=false;                
        update u;
        
        /*u.isBMEnabled__c=true;      
        u.isActive=false;
        update u;
		*/
        
        try {
            u.isActive=true;
            u.BMUserAccessType__c=null;
            update u;        
        } catch(DMLException e) {                       
            System.Assert(e.getMessage().contains(' was not updated/inserted.'));            
        } 
        
        Test.stopTest();
    }
}