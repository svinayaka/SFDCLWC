@isTest(SeeAllData=true)
public class GE_OG_CustomOpportunityHelper_Test{
    static testmethod void test1(){ 
        Id custoppId;
        ID Rectype=Schema.SObjectType.Custom_Opportunity__c.getRecordTypeInfosByName().get('O&G').getRecordTypeId();
        Set<Id> commAccId = new Set<Id>() ;
        Test.StartTest();  
                User u1 = [SELECT Id FROM User WHERE GE_HQ_SSO_ID__c = '502534155' AND Profile.Name='GE_SS Field Service Admin' AND IsActive=TRUE  limit 1];
                Account acct = [Select Id, Oil_Gas_Parent_Account__c from Account where Oil_Gas_Parent_Account__c != null limit 1];                   
                Custom_Opportunity__c  custoppty = new Custom_Opportunity__c();
                custOppty.Name = 'Test Opportunity';
                custOppty.RecordtypeId = Rectype ;
                custOppty.GE_OG_Amount__c = 685;
                custOppty.GE_OG_Expected_Order_Date__c = date.today();
                custOppty.GE_OG_Forecast__c = 'Closed';
                custOppty.GE_OG_Opportunity_Currency__c = 'USD';
                custOppty.GE_OG_Tier2_PnL__c = 'Oil Field Equipment';
                custOppty.GE_OG_Tier3_PnL__c = 'Subsea Drilling Systems';
                custOppty.GE_OG_Opportunity_Summary__c = 'Testing Description';        
                custOppty.GE_OG_Stage__c = 'Pending Approval';    
                custOppty.GE_OG_LE_Account__c= acct.Id ;        
                custOppty.GE_OG_FromSmax__c=true;
                custOppty.GE_OG_CM__c = 10;         
                system.debug('Dummy Opptymax record is ' + custoppty )   ;                  
                System.runAs(u1) { 
                   insert custoppty;
                   system.debug('Dummy Opptymax record id and comm account name is ' + custoppty.Id + 'Account  '+ custoppty.GE_OG_Customer_Name__c )   ; 
                }                  
        Test.stopTest();
     }
     
     static testmethod void test2(){
        Test.startTest() ;            
                User u1 = [SELECT Id FROM User WHERE GE_HQ_SSO_ID__c = '502534155' AND Profile.Name='GE_SS Field Service Admin' AND IsActive=TRUE  limit 1]; 
                Custom_Opportunity__c opptyMaxRecords  = [SELECT 
                                                                                                           Id,GE_OG_LE_Account__c,Name,
                                                                                                           GE_OG_Amount__c,Country__c,
                                                                                                           GE_OG_Opportunity_Summary__c,
                                                                                                           GE_OG_Customer_Name__c,
                                                                                                           GE_OG_Expected_Order_Date__c,Primary_Tier_4__c,
                                                                                                           GE_OG_CM__c,GE_OG_Opportunity_Currency__c,
                                                                                                           GE_OG_Forecast__c,GE_OG_Stage__c,
                                                                                                           GE_OG_Tier2_PnL__c,GE_OG_Tier3_PnL__c,
                                                                                                           RecordTypeID,GE_OG_FromSmax__c,
                                                                                                           GE_OG_Opportunity_Elgible_Status__c,
                                                                                                           GE_OG_Opportunity_Number__c,
                                                                                                           GE_OG_Standard_Oppty__c,
                                                                                                           GE_SS_Expected_Order_Date__c
                                                                                                           FROM Custom_Opportunity__c 
                                                                                                           Where  GE_OG_Customer_Name__c != null AND
                                                                                                           GE_OG_Customer_Name__r.Recordtype.DeveloperName = 'Relationship_Account' AND 
                                                                                                           GE_OG_Standard_Oppty__c = null                                                                                                    
                                                                                                           AND Recordtype.DeveloperName = 'OG' LIMIT 1 ] ;                                                                                                   
                SVMXC__Service_Group_Members__c tech = [ Select ID,SVMXC__Service_Group__c from SVMXC__Service_Group_Members__c Where SVMXC__Salesforce_User__c =: u1.Id Limit 1];
                SVMXC__Service_Group__c serviceteamRec = [Select Id , GE_HQ_Resource_Director__c FROM SVMXC__Service_Group__c WHERE Id =: tech.SVMXC__Service_Group__c ]   ;        
                User u2 = [SELECT Id FROM User WHERE Id =: serviceteamRec.GE_HQ_Resource_Director__c ]; 
                
                Custom_Opportunity__Share recordShare = new Custom_Opportunity__Share() ;
                recordShare.parentId = opptyMaxRecords.Id ;
                recordShare.Accesslevel = 'Edit' ;
                recordShare.UserOrGroupId = U2.Id ; 
                insert  recordShare ;
                
                system.debug('Opptymax record to update' + opptyMaxRecords) ;               
                  System.runAs(u2){
                   Custom_Opportunity__c opptymaxToUpdate = new Custom_Opportunity__c() ;
                   opptymaxToUpdate.Id = opptyMaxRecords.Id ;
                   opptymaxToUpdate.GE_OG_ServiceTeam_Leader__c = u2.Id ;
                   opptymaxToUpdate.GE_OG_Opportunity_Elgible_Status__c  = 'Approved' ;
                   opptymaxToUpdate.GE_OG_Stage__c = 'Prospecting' ;
                   update opptymaxToUpdate ;
                 }  
         Test.stopTest() ;      
     }
 }