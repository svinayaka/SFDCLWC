@istest
public class GE_OG_AccountTeamMemberUpdate_Batch_Test{
    static testMethod void batchAccount(){
    
        List<AccountTeamMember> scope  = new List<AccountTeamMember>();
        List<Account> acc = new List<Account>();
        user u = [select id,name from user where id=:UserInfo.getUserId() limit 1];
       
        /*Account oGAct = new Account();
        oGAct.Name='TestAccount1';
        oGAct.GE_HQ_DUNS_Number__c='GEGUL9999';
        oGAct.Account_Tier_GEOG__c = 'Country';
        insert oGAct; */
        
        
         Account oGAct =AccountTestDataFactory.createRelationshipAccount('TestAccount1','GEGUL9999','Country','Direct Customer','Strategic');
        
        /* Account oGAct1 = new Account();
        oGAct1.Name='TestAccount3';
        oGAct1.GE_HQ_DUNS_Number__c='555126948';
        oGAct1.Account_Tier_GEOG__c = 'Country';
        insert oGAct1;  */
        
        Account oGAct1 =AccountTestDataFactory.createRelationshipAccount('TestAccount3','555126948','Country','Direct Customer','Strategic');
        
        acc.add(oGAct);
        acc.add(oGAct1);
 
        /* AccountTeamMember acct= new AccountTeamMember();
        acct.AccountId = oGAct.Id;
        acct.TeamMemberRole  = 'Sales - Primary';
        acct.userid=u.Id;
        insert acct;
         */
        AccountTeamMember acct=AccountTestDataFactory.createAccountTeamMember(oGAct.Id,'Sales - Primary');
        
      
       /*  AccountTeamMember acct1= new AccountTeamMember();
        acct1.AccountId = oGAct1.Id;
        acct1.TeamMemberRole  = 'Sales';
        acct1.userid=u.Id;
        insert acct1; */
        
        AccountTeamMember acct1=AccountTestDataFactory.createAccountTeamMember(oGAct1.Id,'Sales');
        
        /* AccountTeamMember acct2= new AccountTeamMember();
        acct2.AccountId = oGAct1.Id;
        acct2.TeamMemberRole  = 'Sales';
        acct2.userid=u.Id;
        insert acct2; */
        
        AccountTeamMember acct2=AccountTestDataFactory.createAccountTeamMember(oGAct1.Id,'Sales');
        
        
        scope.add(acct);
        scope.add(acct1);
        scope.add(acct2);

          
        Set<ID> setAccId = new Set<ID>();
        setAccId.add(oGAct.id);
        setAccId.add(oGAct1.id);
        
        test.starttest();
        GE_OG_AccountTeamMemberUpdate_Batch batch = new  GE_OG_AccountTeamMemberUpdate_Batch();
        batch.isRunForAll = true;
        ID batchprocessid = Database.executeBatch(batch);
        Database.BatchableContext BC;
        batch.execute(BC,acc);
        batch.start(BC);
        test.stoptest();
    }
    
    static testMethod void batchAccount1(){
        
          test.starttest();
    
        List<AccountTeamMember> scope  = new List<AccountTeamMember>();
        List<Account> acc = new List<Account>();
        user u = [select id,name from user where id=:UserInfo.getUserId() limit 1];
       
        /* Account oGAct = new Account();
        oGAct.Name='TestAccount1';
        oGAct.GE_HQ_DUNS_Number__c='GEGUL9999';
        oGAct.Account_Tier_GEOG__c = 'Country';
        insert oGAct;  */
        
         Account oGAct =AccountTestDataFactory.createRelationshipAccount('TestAccount1','GEGUL9999','Country','Direct Customer','Strategic');
         
         
        /* Account oGAct1 = new Account();
        oGAct1.Name='TestAccount3';
        oGAct1.GE_HQ_DUNS_Number__c='555126948';
        oGAct1.Account_Tier_GEOG__c = 'Country';
        insert oGAct1; 
         */
        
        Account oGAct1 =AccountTestDataFactory.createRelationshipAccount('TestAccount3','555126948','Country','Direct Customer','Strategic');
        
        acc.add(oGAct);
        acc.add(oGAct1);
        
        
      /* AccountTeamMember acct= new AccountTeamMember();
        acct.AccountId = oGAct.Id;
        acct.TeamMemberRole  = 'Sales - Primary';
        acct.userid=u.Id;
        insert acct; */
      
      AccountTeamMember acct=AccountTestDataFactory.createAccountTeamMember(oGAct.Id,'Sales - Primary');
      
       /*  AccountTeamMember acct1= new AccountTeamMember();
        acct1.AccountId = oGAct1.Id;
        acct1.TeamMemberRole  = 'Sales - Primary';
        acct1.userid=u.Id;
        insert acct1; */
        
        AccountTeamMember acct1=AccountTestDataFactory.createAccountTeamMember(oGAct1.Id,'Sales');
        
        /* AccountTeamMember acct2= new AccountTeamMember();
        acct2.AccountId = oGAct1.Id;
        acct2.TeamMemberRole  = 'Sales';
        acct2.userid=u.Id;
        insert acct2 */
        
        AccountTeamMember acct2=AccountTestDataFactory.createAccountTeamMember(oGAct1.Id,'Sales');
        
        scope.add(acct);
        scope.add(acct1);
        scope.add(acct2);
    
        Set<ID> setAccId = new Set<ID>();
        // setAccId.add(oGAct.id);
        // setAccId.add(oGAct1.id);
        
      
  String query  = 'Select Id, OwnerId,(SELECT AccountId,Id,TeamMemberRole,UserId FROM AccountTeamMembers where TeamMemberRole =:Sales - Primary order by LastModifiedDate desc) from Account where Id in:setAccId limit 1'; 
 

        GE_OG_AccountTeamMemberUpdate_Batch batch = new  GE_OG_AccountTeamMemberUpdate_Batch();
        batch.isRunForAll = false;
        ID batchprocessid = Database.executeBatch(batch);
        Database.BatchableContext BC;
        batch.execute(BC,acc);
        batch.start(BC);
        test.stoptest();
    }

}