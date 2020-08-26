trigger CreateCommunityUser on Predix_Community_Access_Request__c (After Update) {
for (Predix_Community_Access_Request__c pca :Trigger.new)
{
if(pca.GE_OG_Predix_Request_Status__c =='Approved')
{

List<Profile> pf = [Select id,name from Profile where name ='II Partner Community User' limit 1];

account acc = [select name,id from account where name= 'Predix Test 1'];

Contact con= new Contact( AccountId = acc.Id,  Phone=pca.GE_OG_Contact_Phone__c ,FirstName= pca.GE_OG_Customer_First_Name__c, LastName= pca.GE_OG_Customer_Last_Name__c,email=pca.GE_OG_Contact_Email__c);

//Contact con = [select id,name,email,lastname,firstname,accountid from contact where accountid=:accid limit 1];
insert con;
if(pf != null && pf.size()>0)
{
User comUser = new User(contactId=con.Id, username=con.Email+'.'+Label.SFDC_Org_Name +'.predix', firstname=con.FirstName,
lastname=con.LastName, email=con.Email,communityNickname = con.LastName +'_'+Label.SFDC_Org_Name + '_' + 'predix',
alias = string.valueof(con.FirstName.substring(0,1) + con.LastName.substring(0,1)), profileid = pf[0].Id, emailencodingkey='UTF-8',
languagelocalekey='en_US', localesidkey='en_US', timezonesidkey='America/Los_Angeles',GE_HQ_Tier_3_P_L__c = 'test');
Database.DMLOptions dlo = new Database.DMLOptions();
dlo.EmailHeader.triggerUserEmail= true;

Database.saveresult sr = Database.insert(comUser ,dlo);
//insert comUser;
 if (sr.isSuccess()) {
        // Operation was successful, so get the ID of the record that was processed
        //System.debug('Successfully inserted account. Account ID: ' + sr.getId());
    }
    else {
        // Operation failed, so get all errors                
        for(Database.Error err : sr.getErrors()) {
            System.debug('The following error has occurred.');                    
            System.debug(err.getStatusCode() + ': ' + err.getMessage());
            System.debug('User fields that affected this error: ' + err.getFields());
        }
        }
        }
}
}
}