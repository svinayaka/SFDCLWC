/*
Class/Trigger Name     : Contract_Team_ FollowUnFollow
Purpose/Overview       : To Follow Or UnFollow an Contract from SKUID
Author                 : Geetha Karmarkar
Created Date           : 24/06/2019
*/
global without sharing class ContractFollowUnFollow_GE_OG{

    @InvocableMethod(label='Follow_Unfollow Contract' description='Follow_Unfollow Contract')
    public static void updateContractAsFollow_UnFollow(List<Id> contractId){
        
        
        List<Contract_Team__c> lstCTM = new List<Contract_Team__c>();
        List<Contract_Team__c> deleteCTM = new List<Contract_Team__c>();
        List<Contract_Team__c> followCTM = new List<Contract_Team__c>();
        
        Set<ID> setUserID = new Set<ID>();  
         
        ID loginUserID = UserInfo.getUserID();
        system.debug('contract id '+contractId);
        
         
        lstCTM = [Select ID, Name, Team_Role__c, Contract_Team_Member__c, Contract__c 
                from Contract_Team__c 
                where Contract__c in : contractId and Contract_Team_Member__c =: loginUserID];
        
        for(Contract_Team__c objCTM : lstCTM){
            setUserID.add(objCTM.Contract_Team_Member__c);
            if(objCTM.Contract_Team_Member__c==loginUserID && objCTM.Team_Role__c == 'Following'){
                deleteCTM.add(objCTM);  
            }
            else if(objCTM.Contract_Team_Member__c==loginUserID && objCTM.Team_Role__c != 'Following'){
                objCTM.addError('User already a Team Member of Contract Team with ' + objCTM.Team_Role__c + '.');
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
            for(ID obj : contractId){
                Contract_Team__c objCTM = new Contract_Team__c();
                objCTM.Contract__c= contractId[0];
                objCTM.Contract_Team_Member__c = loginUserID;
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