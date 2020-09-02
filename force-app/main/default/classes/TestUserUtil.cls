public with sharing class TestUserUtil {
    @future 
  public static void createTestUser(){
  
   Profile sales = [SELECT Id FROM Profile WHERE Name = 'OG_Sales/Comm Ops'];

    User u = new User();
    u.Username = 'testuserSK@gmail.com';
    u.LastName = 'sales';
    u.Email = 'testuser11@gmail.com';
    u.Alias = 'testusr';
    u.CommunityNickname = 'test_user';
    u.TimeZoneSidKey = 'GMT';
    u.LocaleSidKey = 'en_US';
    u.EmailEncodingKey = 'UTF-8';
    u.ProfileId = sales.Id;
    u.LanguageLocaleKey = 'en_US';
    u.IsActive=True; 
    insert u;

    PermissionSet ps = [SELECT Id FROM PermissionSet WHERE Name = 'PRM_Contractual_Team'];
    PermissionSetAssignment psa = new PermissionSetAssignment();
    psa.AssigneeId = u.Id;
    psa.PermissionSetId = ps.Id;
    insert psa;

   // return u;
  }  
    
    }   
 
 /*   
    public static User testuser;

public static void initTest() {

    testuser = getSalesmen();
    
}

public static User getSalesmen() {

    if (TestUtil.testuser != null) {
        return TestUtil.testuser;
    }

    Profile sales = [SELECT Id FROM Profile WHERE Name = 'OG_Sales/Comm Ops'];

    User u = new User();
    u.Username = 'testuser1.com';
    u.LastName = 'sales';
    u.Email = 'testuser1@test.com';
    u.Alias = 'testusr';
    u.CommunityNickname = 'sales';
   // u.TimeZoneSidKey = 'GMT';
    //u.LocaleSidKey = 'en_GB';
    u.EmailEncodingKey = 'UTF-8';
    u.ProfileId = sales.Id;
    u.LanguageLocaleKey = 'en_US';
    u.IsActive=False; 
    insert u;

    PermissionSet ps = [SELECT Id FROM PermissionSet WHERE Name = 'PRM_Contractual_Team'];
    PermissionSetAssignment psa = new PermissionSetAssignment();
    psa.AssigneeId = u.Id;
    psa.PermissionSetId = ps.Id;
    insert psa;

    return u;
}

}*/