@isTest(seealldata= true)
private class GE_Channel_App_Content_Upload_Test
{  
 
    static testMethod void TestMethod1()
    {      
           Account acc = new Account(name='acc123');
           insert acc; 
           
           GE_PRM_Channel_Appointment__c channelapp = new GE_PRM_Channel_Appointment__c(GE_PRM_Account_Name__c = acc.id);
           insert channelapp;
           ApexPages.currentPage().getParameters().put('Caid',''+channelapp.ID);
           pagereference pageRef = new pagereference('/apex/GE_PRM_Channel_Appointment_View_Page?Caid='+channelapp.ID); 

           GE_Channel_Appointment_Content_Upload  controller = new GE_Channel_Appointment_Content_Upload();
           controller.usrProfileName='GE_ES';
           
           controller.BusinessTiervalue= 'HQ';
           ContentVersion abc =controller.mycontent;
           controller.getworkspaces();
           
           String nextPage = controller.array().getUrl();
           pageRef = new pagereference('/apex/GE_PRM_Channel_Appointment_View_Page?Caid='+channelapp.ID); 
           ApexPages.currentPage().getParameters().put('Caid',''+channelapp.ID);

           controller = new GE_Channel_Appointment_Content_Upload();
           controller.usrProfileName='GE_OG';
           controller.getBusinessTier();
    
           controller.BusinessTiervalue= 'OG';
           controller.getworkspaces();
           
           nextPage = controller.array().getUrl();
    
           pagereference pageRef1 = new pagereference('/apex/GE_Multi_Content_Upload?Caid='+channelapp.id); 
    
                  
           controller.mycontentList[0].title = 'testaccOG';
           controller.mycontentList[0].PathOnClient = 'test1.pdf';
           controller.workspace1=[select id, name from contentworkspace where name =: 'GE OG FA contracts'].id;
           controller.workspace2=[select id, name from contentworkspace where name =: 'GE OG FA contracts'].id;
           controller.workspace3=[select id, name from contentworkspace where name =: 'GE OG FA contracts'].id;
           controller.workspace4=[select id, name from contentworkspace where name =: 'GE OG FA contracts'].id;
           controller.workspace5=[select id, name from contentworkspace where name =: 'GE OG FA contracts'].id;
           system.debug('controller.workspace1==='+controller.workspace1);
            
           controller.workspacename1='EM';
           controller.workspacename2='GE Energy';
           controller.workspacename3='OG';
           controller.workspacename4='P&W';
           controller.workspacename5='HQ';
           controller.PnLvalue='test';

           controller.Regionvalue='Test';
           controller.Bt='Test';
           controller.Finallist.add(new ContentVersion(GE_PRM_Channel_Appointment__c = channelapp.id));
           controller.Finallist.add(new ContentVersion(GE_PRM_Channel_Appointment__c = channelapp.id));
           controller.upload();
           controller.workspace1=[select id, name from contentworkspace where name =: 'OG_HQ_TRAINING_MATERIALS'].id;
           controller.workspace2=[select id, name from contentworkspace where name =: 'OG_HQ_TRAINING_MATERIALS'].id;
           controller.workspace3=[select id, name from contentworkspace where name =: 'OG_HQ_TRAINING_MATERIALS'].id;
           controller.workspace4=[select id, name from contentworkspace where name =: 'OG_HQ_TRAINING_MATERIALS'].id;
           controller.workspace5=[select id, name from contentworkspace where name =: 'OG_HQ_TRAINING_MATERIALS'].id;
           controller.Finallist.add(new ContentVersion(GE_PRM_Channel_Appointment__c = channelapp.id));
           controller.Finallist.add(new ContentVersion(GE_PRM_Channel_Appointment__c = acc.id));
           controller.Finallist.add(new ContentVersion(GE_PRM_Channel_Appointment__c = channelapp.id));
           controller.upload();
           controller.cancel();
           controller.back();      
    }
    static testMethod void TestMethod2()
    {      
           Account acc = new Account(name='acc123');
           insert acc; 
           
           GE_PRM_Channel_Appointment__c channelapp = new GE_PRM_Channel_Appointment__c(GE_PRM_Account_Name__c = acc.id);
           insert channelapp;
           ApexPages.currentPage().getParameters().put('Caid',''+channelapp.ID);
           pagereference pageRef = new pagereference('/apex/GE_PRM_Channel_Appointment_View_Page?Caid='+channelapp.ID); 

           GE_Channel_Appointment_Content_Upload  controller = new GE_Channel_Appointment_Content_Upload();
           controller.usrProfileName='GE_ES';
           
           controller.BusinessTiervalue= 'HQ';
           ContentVersion abc =controller.mycontent;
           controller.getworkspaces();
           
           String nextPage = controller.array().getUrl();
           pageRef = new pagereference('/apex/GE_PRM_Channel_Appointment_View_Page?Caid='+channelapp.ID); 
           ApexPages.currentPage().getParameters().put('Caid',''+channelapp.ID);

           controller = new GE_Channel_Appointment_Content_Upload();
           controller.usrProfileName='GE_OG';
           controller.getBusinessTier();
    
           controller.BusinessTiervalue= 'OG';
           controller.getworkspaces();
           
           nextPage = controller.array().getUrl();
    
           pagereference pageRef1 = new pagereference('/apex/GE_Multi_Content_Upload?Caid='+channelapp.id); 
    
                  
           controller.mycontentList[0].title = 'testaccOG';
           controller.mycontentList[0].PathOnClient = 'test1.pdf';
           controller.workspace1=[select id, name from contentworkspace where name =: 'OG_HQ_TRAINING_MATERIALS'].id;
           controller.workspace2=[select id, name from contentworkspace where name =: 'OG_HQ_TRAINING_MATERIALS'].id;
           controller.workspace3=[select id, name from contentworkspace where name =: 'OG_HQ_TRAINING_MATERIALS'].id;
           controller.workspace4=[select id, name from contentworkspace where name =: 'OG_HQ_TRAINING_MATERIALS'].id;
           controller.workspace5=[select id, name from contentworkspace where name =: 'OG_HQ_TRAINING_MATERIALS'].id;
           system.debug('controller.workspace1==='+controller.workspace1);
            
           controller.workspacename1='EM';
           controller.workspacename2='GE Energy';
           controller.workspacename3='OG';
           controller.workspacename4='P&W';
           controller.workspacename5='HQ';
           controller.PnLvalue='test';

           controller.Regionvalue='Test';
           controller.Bt='Test';
           controller.Finallist.add(new ContentVersion(GE_PRM_Channel_Appointment__c = channelapp.id));
           controller.Finallist.add(new ContentVersion(GE_PRM_Channel_Appointment__c = channelapp.id));
           controller.workspacename1='EM';
           controller.workspacename2='GE Energy';
           controller.workspacename3='OG';
           controller.workspacename4='P&W';
           controller.workspacename5='HQ';
           controller.PnLvalue='test';
 
           controller.upload(); 
  
    }
    static testMethod void TestMethod3()
    {      
           Account acc = new Account(name='acc123');
           insert acc; 
           
           GE_PRM_Channel_Appointment__c channelapp = new GE_PRM_Channel_Appointment__c(GE_PRM_Account_Name__c = acc.id);
           insert channelapp;
           ApexPages.currentPage().getParameters().put('Caid',''+channelapp.ID);
           pagereference pageRef = new pagereference('/apex/GE_PRM_Channel_Appointment_View_Page?Caid='+channelapp.ID); 

           GE_Channel_Appointment_Content_Upload  controller = new GE_Channel_Appointment_Content_Upload();
           controller.usrProfileName='GE_ES';

           pageRef = new pagereference('/apex/GE_PRM_Channel_Appointment_View_Page?Caid='+channelapp.ID); 
           ApexPages.currentPage().getParameters().put('Caid',''+channelapp.ID);
          
           controller.cancel();
           controller.back();    
    }
     
   
}