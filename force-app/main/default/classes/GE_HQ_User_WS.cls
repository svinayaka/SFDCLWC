/*    
Class Name        : GE_HQ_User_WS
Purpose/Overview  : Custom webservice for User integration
Author            : Lakshman Bugude
Created Date      : 17th August 2012
Test Class        : GE_HQ_User_WS_Test
Change History    : Date Modified		: Developer Name	: Action	: Purpose/Overview of Change
                  : 17th August 2012	: Lakshma Bugude	: Created	: Created the webservice to handle the incoming requests for User Integration
*/

/* CUSTOM WEBSERVICE DETAILS:

System Descriptions:-
~~~~~~~~~~~~~~~~~
IDM - Identity Management

// mention other system details here

Method Descripitons:-
~~~~~~~~~~~~~~~~~
InsertUser :   For Inserting the User
DeactivateUser :   For Deactivating the User

// mention other method details here

*/

global class GE_HQ_User_WS {
	Public Static Map<String, User> userStatusMap;
	Public Static Integer counter = 1;
	Public Static Result Res;

    webservice static Result InsertUser(Usr usr)
    {
        Res = new Result();

        if(!ValidateUser(usr)) {
            System.debug('--- Return Message ---' + Res);
            Res.Status = 'Failure';
            Res.UserName = usr.UserName;
            Return Res;
        }

        userStatusMap = new Map<String, User>();
        for(User usrObject : [Select UserName, FirstName, LastName, Email, GE_HQ_HC_Location__c, UserRoleId, ProfileId, UserPermissionsMobileUser, GE_HQ_Tier_1_P_L__c,
        							GE_HQ_Tier_2_P_L__c, IDM_Country__c, IDM_Department__c, IDM_State__c, IsActive, ForecastEnabled, DefaultCurrencyIsoCode,
    								EmailEncodingKey, CurrencyIsoCode, LanguageLocaleKey, LocaleSidKey, GE_HQ_IDM_Creation__c, TimeZoneSidKey, Alias, GE_HQ_SSO_ID__c
    								from User where username like :usr.username.split('@',2)[0]+'%']) {
            System.debug('Initial User Check --- '+usrObject );
            userStatusMap.put(usrObject.Username.toUpperCase(), usrObject);
        }
        System.debug('User Status Map --- '+userStatusMap);

        if([Select count() from User where GE_HQ_SSO_ID__c = :usr.SSOId] == 0) {
        	System.debug('--- Insert User ---');
        	InsertOrUpdateUserDetails(usr, 'Insert');
        } else {
        	System.debug('--- Update User ---');
        	InsertOrUpdateUserDetails(usr, 'Update');
        }
        return Res;
    }

    private static Boolean ValidateUser(Usr usr) {
        Res.StatusMsg = '';
        if(usr.SSOId == '' || usr.SSOId == Null) {
            Res.StatusMsg = Res.StatusMsg + 'SSO ID is Mandatory for User Creation/Updation' + '\n';
        }
        if (usr.FirstName == '' || usr.FirstName == Null) {
            Res.StatusMsg = Res.StatusMsg + 'First Name is Mandatory for User Creation/Updation' + '\n';
        }
        if (usr.LastName == '' || usr.LastName == Null) {
            Res.StatusMsg = Res.StatusMsg + 'Last Name is Mandatory for User Creation/Updation' + '\n';
        }
        if (usr.Email == '' || usr.Email == Null) {
            Res.StatusMsg = Res.StatusMsg + 'Email Id is Mandatory for User Creation/Updation' + '\n';
        }
        if (usr.UserName == '' || usr.UserName == Null) {
            Res.StatusMsg = Res.StatusMsg + 'User Id is Mandatory for User Creation/Updation' + '\n';
        }
        if (usr.ProfileId == '' || usr.ProfileId == Null) {
            Res.StatusMsg = Res.StatusMsg + 'Profile Id is Mandatory for User Creation/Updation' + '\n';
        } else if(CheckProfile(usr.ProfileId)) {
       		if (usr.UserRoleId == '' || usr.UserRoleId == Null) {
           		Res.StatusMsg = Res.StatusMsg + 'User Role Id is Mandatory for User Creation/Updation' + '\n';
       		}
       	}
        if (usr.FederationIdentifier == '' || usr.FederationIdentifier == Null) {
            Res.StatusMsg = Res.StatusMsg + 'Federation Identifier is Mandatory for User Creation/Updation' + '\n';
        }

        if (Res.StatusMsg == '') {
            return true;
        } else {
            return false;
        }
    }

	private static void InsertOrUpdateUserDetails(Usr usr, String action) {
		if(action == 'Insert') {
			User user = new User();
			UpdateUserDetails(user, usr, action, usr.UserName);
		} else if(action == 'Update') {
			List<User> UsrList = new List<User>([Select UserName, FirstName, LastName, Email, GE_HQ_HC_Location__c, UserRoleId, ProfileId, UserPermissionsMobileUser, GE_HQ_Tier_1_P_L__c,
    										GE_HQ_Tier_2_P_L__c, IDM_Country__c, IDM_Department__c, IDM_State__c, IsActive, ForecastEnabled, DefaultCurrencyIsoCode,
    										EmailEncodingKey, CurrencyIsoCode, LanguageLocaleKey, LocaleSidKey, GE_HQ_IDM_Creation__c, TimeZoneSidKey, Alias, GE_HQ_SSO_ID__c
    										from User where GE_HQ_SSO_ID__c = :usr.SSOId]);
			UpdateUserDetails(UsrList[0], usr, action, usr.UserName);
		}
	}

	private static void UpdateUserDetails(User user, Usr usr, String action, String UniqueUserName) {
		if(usr.UserName != UniqueUserName) {
			System.debug('--- Input User is not equal to Unique User ---');
			user.Username = UniqueUserName;
		} else {
			System.debug('--- Input User is equal to Unique User ---');
			user = SetUserDetails(user, usr, action, UniqueUserName);
		}
		if(Res.Status != 'Failure') {
			try {
				if(action == 'Insert') {
					insert user;
					Res.StatusMsg = 'User is successfully inserted';
					Res.UserName = user.Username;
				} else if(action == 'Update') {
					update user;
					Res.StatusMsg = 'User is successfully updated';
					Res.UserName = user.Username;
				}
				Res.Status = 'Success';
			} catch (Exception e) {
				System.debug('--- Catch Block ---' + e.getMessage());
				if(e.getMessage().contains('DUPLICATE_USERNAME')) {
					if(userStatusMap.get(UniqueUserName.toUpperCase()) != null) {
						if(!userStatusMap.get(UniqueUserName.toUpperCase()).isActive && (action == 'Insert' || userStatusMap.get(UniqueUserName.toUpperCase()).GE_HQ_SSO_ID__c == usr.SSOId)) {
							User usrObj = SetUserDetails(userStatusMap.get(UniqueUserName.toUpperCase()), usr, 'Update', UniqueUserName);
							usrObj.isActive = true;
							update usrObj;
							Res.Status = 'Success';
							Res.StatusMsg = 'There was an inactive user with the user id ' + UniqueUserName + '.\nThe user has been re-activated';
						} else {
							UniqueUserName = usr.UserName.split('@',2)[0] + '.' + counter + '@' + usr.UserName.split('@',2)[1];
							System.debug(counter + ' -- New Unique User -- ' + UniqueUserName);
							counter++;
							UpdateUserDetails(user, usr, action, UniqueUserName);
						}
					} else {
						UniqueUserName = usr.UserName.split('@',2)[0] + '.' + counter + '@' + usr.UserName.split('@',2)[1];
						System.debug(counter + ' -- New Unique User -- ' + UniqueUserName);
						counter++;
						UpdateUserDetails(user, usr, action, UniqueUserName);
					}
				} else {
					Res.Status = 'Failure';
					Res.StatusMsg = e.getMessage();
					Res.UserName = usr.UserName;
				}
			}
		}
	}
	
	private static User SetUserDetails(User user, Usr usr, String action, String UniqueUserName) {
		System.debug('--- User ---' + user);
		if(CheckProfile(usr.ProfileId)) {
			System.debug('-- Input Profile is not Chatter Profile --');
			if(action == 'Insert') {
				System.debug('--- Insert --- Setting Profile, Role, Mobile User, Content User, Forcast Enabled ---');
				user.ProfileId = String.valueOf(usr.ProfileId);
				user.UserRoleId = String.valueOf(usr.UserRoleId);
				user.UserPermissionsMobileUser = Boolean.valueOf(String.valueOf(usr.UserPermissionsMobileUser));
				user.UserPermissionsSFContentUser = Boolean.valueOf(String.valueOf(usr.UserPermissionsSFContentUser));
				user.ForecastEnabled = Boolean.valueOf(String.valueOf(usr.ForecastEnabled));
			} else if(action == 'Update') {
				if(CheckProfile(user.ProfileId)) {
					System.debug('--- Update --- Existing Profile is not Chatter Profile --');
					user.ProfileId = String.valueOf(usr.ProfileId);
					user.UserRoleId = String.valueOf(usr.UserRoleId);
				} else {
					System.debug('--- Update --- Existing Profile is Chatter Profile -- Setting Profile, Updating User and then Setting Role --');
					user.ProfileId = String.valueOf(usr.ProfileId);
					update user;
					user.UserRoleId = String.valueOf(usr.UserRoleId);
				}
                user.UserPermissionsMobileUser = Boolean.valueOf(String.valueOf(usr.UserPermissionsMobileUser));
                user.UserPermissionsSFContentUser = Boolean.valueOf(String.valueOf(usr.UserPermissionsSFContentUser));
                user.ForecastEnabled = Boolean.valueOf(String.valueOf(usr.ForecastEnabled));
			}
		} else {
			System.debug('-- Input Profile is Chatter Profile --');
			if(action == 'Insert') {
				System.debug('--- Insert --- Setting Profile ---');
				user.ProfileId = String.valueOf(usr.ProfileId);
			} else if(action == 'Update') {
				if(CheckProfile(user.ProfileId)) {
					System.debug('--- Update --- Existing Profile is not Chatter Profile --');
					Res.Status = 'Failure';
					Res.StatusMsg = 'User cannot be changed from Non-Chatter profile to Chatter profile';
					Res.UserName = usr.UserName;
				} else {
					System.debug('--- Update --- Existing Profile is Chatter Profile -- Setting only Profile --');
					user.ProfileId = String.valueOf(usr.ProfileId);
				}
			}
		}

		user.Username = UniqueUserName;

		user.GE_HQ_SSO_ID__c = String.valueOf(usr.SSOId);
		user.FirstName = String.valueOf(usr.FirstName);
		user.LastName = String.valueOf(usr.LastName);
		user.Email = String.valueOf(usr.Email);
		user.GE_HQ_HC_Location__c = String.valueOf(usr.UsrLocation);
		user.FederationIdentifier = String.valueOf(usr.FederationIdentifier);
		user.GE_HQ_Tier_1_P_L__c = String.valueOf(usr.Tier1);
		user.GE_HQ_Tier_2_P_L__c = String.valueOf(usr.Tier2);
		user.IDM_Country__c = String.valueOf(usr.IDMCountry);
		user.IDM_Department__c = String.valueOf(usr.IDMDepartment);
		user.IDM_State__c = String.valueOf(usr.IDMState);
		user.IsActive = Boolean.valueOf(String.valueOf(usr.IsActive));
		user.DefaultCurrencyIsoCode = String.valueOf(usr.DefaultCurrencyIsoCode);
		user.EmailEncodingKey = String.valueOf(usr.EmailEncodingKey);
		user.CurrencyIsoCode = String.valueOf(usr.CurrencyIsoCode);
		user.LanguageLocaleKey = String.valueOf(usr.LanguageLocaleKey);
		user.LocaleSidKey = String.valueOf(usr.LocaleSidKey);
		user.GE_HQ_IDM_Creation__c = Boolean.valueOf(String.valueOf(usr.IDMCreation));
		user.TimeZoneSidKey = String.valueOf(usr.TimeZoneSidKey);
		user.Alias = String.valueOf(usr.Alias);

		System.debug('--- Set User Details --- User Details ---' + user);

		return user;
	}

	// Returns TRUE if it is not chatter profile
    private static Boolean CheckProfile(String ProfileId) {
    	String ProfName = [Select Name from Profile where Id = :ProfileId].Name;
    	if(ProfName.toUpperCase().contains('CHATTER')) {
    		System.debug('-- This is Chatter Profile -- Returning False --');
    		return false;
    	} else {
    		System.debug('-- This is not Chatter Profile -- Returning True --');
    		return true;
    	}
    }

    webservice static Result DeactivateUser(Usr usr)
    {
        Res = new Result();
        Res.Status='Failure';
        Res.StatusMsg='';
        
        System.debug('---- User Input ----' + usr);
        
        if(usr.SSOId == '' || usr.SSOId == Null) {
            Res.StatusMsg = 'User SSO ID cannot be null for deactivating the users.';
            Res.UserName = 'No User Name';
            System.debug('--- Return Message ---' + Res);
            return Res;
        }

        System.debug('----SSO Id----' + usr.SSOId);
        list<User> user = [Select Id, Username, IsActive from User where GE_HQ_SSO_ID__c = :usr.SSOId limit 1];
        if(user == Null || user.size() <= 0)
        {
            Res.StatusMsg = 'There is no User record with SSO ' + usr.SSOId;
            Res.UserName = 'No User Name';
        } else if(!user[0].IsActive){
            Res.StatusMsg = 'The user with user name ' + user[0].Username + ' is already in inactive state';
            Res.UserName = user[0].Username;
        } else {
            user[0].IsActive = false;
            update user[0];

            Res.Status = 'Success';
            Res.StatusMsg = 'The user with user name ' + user[0].Username + ' has been successfully de-activated from SFDC';
            Res.UserName = user[0].Username;
        }
        System.debug('--- Return Message ---' + Res);
        Return Res;
    }

    global Class Result {
        webservice String Status;
        webservice String StatusMsg;
        webservice String UserName;
    }
    
    global Class Usr {
        webservice String SSOId;
        webservice String FirstName;
        webservice String LastName;
        webservice String Email;
        webservice String UsrLocation;
        webservice String UserName;
        webservice String UserRoleId;
        webservice String ProfileId;
        webservice String UserPermissionsSFContentUser;
        webservice String UserPermissionsMobileUser;
        webservice String FederationIdentifier;
        webservice String Tier1;
        webservice String Tier2;
        webservice String IDMCountry;
        webservice String IDMDepartment;
        webservice String IDMState;
        // Following fields are hard coded at webMethods
        webservice String IsActive;
        webservice String ForecastEnabled;
        webservice String DefaultCurrencyIsoCode;
        webservice String EmailEncodingKey;
        webservice String CurrencyIsoCode;
        webservice String LanguageLocaleKey;
        webservice String LocaleSidKey;
        webservice String IDMCreation;
        webservice String TimeZoneSidKey;
        webservice String Alias;
    }
}