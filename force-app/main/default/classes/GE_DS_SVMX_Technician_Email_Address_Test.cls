@isTest(SeeAllData=true)
public class GE_DS_SVMX_Technician_Email_Address_Test{
     public static TestMethod void svmxWoTest(){
      
      Set<Id> techIds = new Set<Id>();
      
       List<SVMXC__Service_Order__c> wol = new List<SVMXC__Service_Order__c>();
     
     Id DSRecordtype =  Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('D&S').getRecordTypeId();
      Id DSCase =  Schema.SObjectType.Case.getRecordTypeInfosByName().get('FS-D&S').getRecordTypeId();
       test.startTest();
       
      case cas = new case();
      cas.RecordTypeId= DSCase;
          
      insert cas;
      
      Account acc = new Account(Name='Test Account');
      Insert acc;
      
      SVMXC__Site__c loc=new SVMXC__Site__c(name='test loc');
      Insert loc;
      
      Profile chnlMagrId = [select id from Profile where name = 'GE_DS_Titanium Service Manager'];  
      
      User chnlManr = new User(firstname = 'channel1', lastname = 'manager1', profileId = chnlMagrId.Id,email = 'chnmanager123@ge.com', alias = 'chnUsr',Title = 'Channel Manager', Username = 'channelmagr123@ge.com', CommunityNickname = 'chuse1', TimeZoneSidKey = 'America/New_York', LocaleSidKey = 'en_US',  EmailEncodingKey= 'ISO-8859-1', LanguageLocaleKey= 'en_US');
       insert chnlManr;
       
      //User u= new User(Username='tset@hjm.com',LastName='xyz',Alias='abc',EmailEncodingKey='General US & Western Europe (ISO-8859-1, ISO-LATIN-1)',TimeZoneSidKey='(GMT+05:30) India Standard Time (Asia/Kolkata)',Email='tsete@ge.com');
      //insert u;
     
      User u = new User(firstname = 'channel1', lastname = 'manager1', profileId = chnlMagrId.Id,email = 'chnmanager123@ge.com', alias = 'chnUsr',Title = 'Channel Manager', Username = 'channelmagr143@ge.com', CommunityNickname = 'chuse1', TimeZoneSidKey = 'America/New_York', LocaleSidKey = 'en_US',  EmailEncodingKey= 'ISO-8859-1', LanguageLocaleKey= 'en_US');
      
      SVMXC__Service_Group__c st= new SVMXC__Service_Group__c(name='Test Team',SVMXC__Active__c=true,SVMXC__Email__c='test.ds@ge.com',GE_HQ_Resource_Director__c=userinfo.getuserId());
      insert st;

        SVMXC__Service_Group_Members__c tech1= new SVMXC__Service_Group_Members__c(name='Test Tech',
        
               SVMXC__Street__c = 'test Home street',
               SVMXC__City__c = 'test home city',
               SVMXC__State__c = 'test home state',
               SVMXC__Country__c = 'United States',
               SVMXC__Zip__c = 'test home zip',
               SVMXC__Longitude__c = 1.1,
               SVMXC__Latitude__c = 1.2,           
               GE_SM_HQ_SSO_ID__c = '124',
               GE_SM_HQ_Regional_Manager__c = 'test Manager',
               SVMXC__Email__c = 'xyx@servicemax.com',SVMXC__Service_Group__c=st.id,SVMXC__Salesforce_User__c=chnlManr.id);
        insert tech1;
        
         SVMXC__Service_Order__c wo4 = new SVMXC__Service_Order__c(RecordTypeId = DSRecordtype,SVMXC__Case__c = cas.id,SVMXC__Order_Status__c = 'open',GE_DS_Country_WkPerformed__c = 'India',GE_DS_Previous_Technician_Email__c='ahj.rt@ht.com',GE_SM_HQ_Dispatched_Outside_Territory__c=true);
        insert wo4;
        SVMXC__Service_Order__c wo1 = new SVMXC__Service_Order__c(SVMXC__Service_Group__c = st.id,SVMXC__Group_Member__c=tech1.id,RecordTypeId = DSRecordtype,SVMXC__Case__c = cas.id,SVMXC__Order_Status__c = 'open',GE_DS_Country_WkPerformed__c = 'India',GE_DS_Previous_Technician_Email__c='ahj.rt@ht.com',GE_SM_HQ_Dispatched_Outside_Territory__c=true);
        insert wo1;
        SVMXC__Service_Group_Members__c tech2=new SVMXC__Service_Group_Members__c(Name='Test1',SVMXC__Active__c=true,SVMXC__Enable_Scheduling__c=true,SVMXC__Email__c='testgh@gth.com',GE_SM_HQ_Regional_Manager__c='Test Mgr',GE_SM_HQ_SSO_ID__c='659852141',SVMXC__Service_Group__c=st.id);
        insert tech2;
        /*
        SVMXC__Service_Order__c wo2=new SVMXC__Service_Order__c(SVMXC__Company__c=acc.id,SVMXC__Site__c =loc.id,RecordTypeId=DSRecordtype,GE_DS_Country_WkPerformed__c='India',SVMXC__Case__c=cas.id,  SVMXC__Order_Status__c='Open');
        insert wo2;
        */
        test.stopTest();
        //wo2.SVMXC__Service_Group__c=st.id;
        wo1.SVMXC__Group_Member__c=tech2.id;
        update wo1;
        //wol.add(wo);
        //wol.add(wo1);
          
     
     
     }


}