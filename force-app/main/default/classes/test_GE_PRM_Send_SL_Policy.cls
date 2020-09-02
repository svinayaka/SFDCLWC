@isTest(seealldata=true)
public class test_GE_PRM_Send_SL_Policy {
    static testmethod void Testmethod1(){
    String  appObjPrefix = GE_PRM_Channel_Appointment__c.SObjectType.getDescribe().getKeyPrefix(); 
    Messaging.InboundEmail email = new Messaging.InboundEmail();
    GE_PRM_Channel_Appointment__c ch = [select id from GE_PRM_Channel_Appointment__c limit 1];
    email.subject = ch.id; 
    //email.plainTextBody = 'Approv'+'\n'+'Approv';    
    email.plainTextBody = 'certify'+'\n'+'certify'; 
    Messaging.InboundEnvelope envelope;    
    GE_PRM_Send_SL_Policy ssl = new GE_PRM_Send_SL_Policy();
    ssl.handleInboundEmail(email,envelope );    
    }
    
    static testmethod void Testmethod11(){
    String  appObjPrefix = GE_PRM_Channel_Appointment__c.SObjectType.getDescribe().getKeyPrefix(); 
    Messaging.InboundEmail email = new Messaging.InboundEmail();
    GE_PRM_Channel_Appointment__c ch = [select id from GE_PRM_Channel_Appointment__c limit 1];
    email.subject = ch.id; 
    //email.plainTextBody = 'Approv'+'\n'+'Approv';    
    email.plainTextBody = 'modify'+'\n'+'modify'; 
    Messaging.InboundEnvelope envelope;    
    GE_PRM_Send_SL_Policy ssl = new GE_PRM_Send_SL_Policy();
    ssl.handleInboundEmail(email,envelope );    
    }
}