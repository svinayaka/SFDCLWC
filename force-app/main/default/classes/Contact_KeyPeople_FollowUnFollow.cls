/*
Class/Trigger Name     : Contact_KeyPeople_ FollowUnFollow
Purpose/Overview       : To Follow Or UnFollow a Contact from SKUID
Author                 : Geetha Karmarkar
Created Date           : 10/09/2019
*/
global without sharing class Contact_KeyPeople_FollowUnFollow {

    @InvocableMethod(label='Follow_Unfollow ContactKP' description='Follow_Unfollow Contact')
    public static void updateContactFollow_UnFollow(List<Id> contactId){
        
        
        List<GEOG_Contact_Team__c> lstCTM = new List<GEOG_Contact_Team__c>();
        List<GEOG_Contact_Team__c> deleteCTM = new List<GEOG_Contact_Team__c>();
        List<GEOG_Contact_Team__c> followCTM = new List<GEOG_Contact_Team__c>();
        
        Set<ID> setUserID = new Set<ID>();  
         
        ID loginUserID = UserInfo.getUserID();
        system.debug('contact id '+contactId);
        
         
        lstCTM = [Select ID, Name, Team_Role__c, Contact_Team_Member__c, Contact__c
                from GEOG_Contact_Team__c
                where Contact__c in : contactId and Contact_Team_Member__c=: loginUserID];
        
        for(GEOG_Contact_Team__c objCTM : lstCTM){
            setUserID.add(objCTM.Contact_Team_Member__c);
            if(objCTM.Contact_Team_Member__c==loginUserID && objCTM.Team_Role__c == 'Following'){
                deleteCTM.add(objCTM);  
            }
            else if(objCTM.Contact_Team_Member__c==loginUserID && objCTM.Team_Role__c != 'Following'){
                objCTM.addError('User already a Team Member of Contact Team with ' + objCTM.Team_Role__c + '.');
            }
        }
        
        if(deleteCTM.size()>0){
            try{
                delete deleteCTM;
            }
            catch(Exception e){
                system.debug('Error in deletion of Team Member');
            }
        }
        
        if(!setUserID.contains(loginUserID)){
            for(ID obj : contactId){
                GEOG_Contact_Team__c objCTM = new GEOG_Contact_Team__c();
                objCTM.Contact__c= contactId[0];
                objCTM.Contact_Team_Member__c= loginUserID;
                objCTM .Team_Role__c = 'Following';
                followCTM.add(objCTM );
            }
            if(followCTM.size()>0){
                try{
                    insert followCTM;
                }
                catch(Exception e){
                    system.debug('Error in insertion of Team Member');
                }
            }   
        }
        
    } 
      
}