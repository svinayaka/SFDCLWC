@isTest
private class GE_MultiUploadContentTest{  
      
 static testMethod void testMultiUploadContentTest1(){      
       Account acc = new Account(name='acc123');
       acc.Classification__c = 'Unclassified';
       acc.Type= 'Direct Customer';
       insert acc; 
       
       pagereference pageRef = new pagereference('/apex/GE_Content_PreScreening?Accid='+acc.ID); 
       system.test.setCurrentpage(pageRef); 
       
       GE_Content_Upload controller = new GE_Content_Upload();
       //controller.usrProfileName='GE_ES';
       
       controller.BusinessTiervalue= 'HQ';
       controller.Regionvalue = 'none';
       controller.PnLvalue = 'D&P';
       controller.BT ='test';
      // controller.getworkspaces();
       
       String nextPage = controller.array().getUrl();
       System.assertEquals('/apex/GE_Multi_Content_Upload?id='+acc.id, nextPage);
 

     
       pageRef = new pagereference('/apex/GE_Content_PreScreening?Accid='+acc.ID); 
       system.test.setCurrentpage(pageRef); 
       
       
       controller = new GE_Content_Upload();
       controller.usrProfileName='GE_OG';
       controller.getBusinessTier();
       //controller.getPnL();
       //controller.getRegion();
       //controller.PnLvalue= 'D&P';
       //controller.Regionvalue= 'none';
       controller.userTier2 = 'Lufkin';
       
       controller.BusinessTiervalue= 'OG';
       User u = [Select ID From User Where Profile.Name =  'System Administrator' and isActive =true Limit 1] ;
       System.runAs(u)
       {
       controller.getworkspaces();
       }
       
       nextPage = controller.array().getUrl();
       System.assertEquals('/apex/GE_Multi_Content_Upload?id='+acc.id, nextPage);
       
       pagereference pageRef1 = new pagereference('/apex/GE_Multi_Content_Upload?Accid='+acc.id); 
       system.test.setCurrentpage(pageRef1);
       
      // contentworkspace  cws = new contentworkspace();
      // cws.name = 'OG DTS Library';
       
              
       controller.mycontentList[0].title = 'testaccOG';
       controller.mycontentList[0].PathOnClient = 'test1.pdf';
       controller.workspace1=[select id, name from contentworkspace where name =: 'GE OG PRM PUBLIC'].id;
        controller.workspace2=[select id, name from contentworkspace where name =: 'GE OG PRM PUBLIC'].id;
        controller.workspace3=[select id, name from contentworkspace where name =: 'GE OG PRM PUBLIC'].id;
        controller.workspace4=[select id, name from contentworkspace where name =: 'GE OG PRM PUBLIC'].id;
        controller.workspace5=[select id, name from contentworkspace where name =: 'GE OG PRM PUBLIC'].id;

        controller.workspacename1='GE OG PRM PUBLIC';
        controller.workspacename2='GE OG PRM PUBLIC';
        controller.workspacename3='GE OG PRM PUBLIC';
        controller.workspacename4='GE OG PRM PUBLIC';
        controller.workspacename5='GE OG PRM PUBLIC';

        controller.upload();
      
}

    static testMethod void testMultiUploadContentTest9(){      
       Account acc = new Account(name='acc123');
       acc.Classification__c = 'Unclassified';
       acc.Type= 'Direct Customer';
       insert acc; 
       
       pagereference pageRef = new pagereference('/apex/GE_Content_PreScreening?Accid='+acc.ID); 
       system.test.setCurrentpage(pageRef); 
       
       GE_Content_Upload controller = new GE_Content_Upload();
       //controller.usrProfileName='GE_ES';
       
       controller.BusinessTiervalue= 'HQ';
       controller.Regionvalue = 'none';
       controller.PnLvalue = 'D&P';
       controller.BT ='test';
      // controller.getworkspaces();
       
       String nextPage = controller.array().getUrl();
       System.assertEquals('/apex/GE_Multi_Content_Upload?id='+acc.id, nextPage);
 

     
       pageRef = new pagereference('/apex/GE_Content_PreScreening?Accid='+acc.ID); 
       system.test.setCurrentpage(pageRef); 
       
       
       controller = new GE_Content_Upload();
       controller.usrProfileName='GE_OG';
       controller.getBusinessTier();
       controller.userTier2 = 'Lufkin';
       
       controller.BusinessTiervalue= 'HQ';
       User u = [Select ID From User Where Profile.Name =  'System Administrator' and isActive =true Limit 1] ;
      System.runAs(u)
       { 
       controller.getworkspaces();
       }
       
       nextPage = controller.array().getUrl();
       System.assertEquals('/apex/GE_Multi_Content_Upload?id='+acc.id, nextPage);
       
       pagereference pageRef1 = new pagereference('/apex/GE_Multi_Content_Upload?Accid='+acc.id); 
       system.test.setCurrentpage(pageRef1);
         
       controller.mycontentList[0].title = 'testaccOG';
       controller.mycontentList[0].PathOnClient = 'test1.pdf';
       
       List<contentworkspace> lstworksp = new List<Contentworkspace>();
       lstworksp = [select id, name from contentworkspace where name =: 'HQ Commercial Excellence' limit 1];
       
       if(lstworksp.size()>0){
           controller.workspace1=lstworksp[0].id;
            controller.workspace2=lstworksp[0].id;
            controller.workspace3=lstworksp[0].id;
            controller.workspace4=lstworksp[0].id;
            controller.workspace5=lstworksp[0].id;

       }
        
       
        controller.workspacename1='HQ Commercial Excellence';
        controller.workspacename2='HQ Commercial Excellence';
        controller.workspacename3='HQ Commercial Excellence';
        controller.workspacename4='HQ Commercial Excellence';
        controller.workspacename5='HQ Commercial Excellence';

        controller.upload();
        controller.cancel();
        controller.back();
        Test.setCurrentPageReference(Page.GE_OG_Directory_Mobile); 
        GE_CodeUtilization cu = new GE_CodeUtilization();
        cu.insertCodeUtilization('test','visualforce page');
        cu.insertCodeUtilization(cu.captureVFPageName(), 'Visualforce Page');    
        controller.addCodeUtilization();
       
    }



    static testMethod void testMultiUploadContentTest7(){      
       Account acc = new Account(name='acc123');
       acc.Classification__c = 'Unclassified';
       acc.Type= 'Direct Customer';
       insert acc; 
       
       String contractRecordTypeMasterId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Channel Master Agreement').getRecordTypeId();
        contract Cnt = new contract(); 
       // Cntrct.GE_ES_User_Lead_Sales_Person__c = chnlManr.id; 
        Cnt .Accountid = acc.id; 
        Cnt .GE_PRM_Region__c ='US South';
        Cnt .GE_PRM_Business_Tier_1__c = 'Oil & Gas (O&G)'; 
        Cnt .Status = 'Awaiting Review before to be sent to channel'; 
        Cnt .recordtypeid = contractRecordTypeMasterId;
        Cnt .ContractTerm = 12;
        Cnt .GE_PRM_Tier_2__c = 'Drilling & Surface (D&S)';
        Cnt .GE_PRM_Tier_3__c = 'Artificial Lift (AL)';
        Cnt .GE_PRM_Tier_4__c = 'Artificial Lift (AL)';     
        Cnt .GE_OG_Evergreen__c = true;
        Cnt .BillingStreet =  'Test';
        Cnt .BillingCity =  'Test';
        Cnt .BillingState =  'Test';
        Cnt .BillingPostalCode =  'Test';
        Cnt .BillingCountry =  'Test';
        Cnt .ShippingStreet =  'Test';
        Cnt .ShippingCity =  'Test';
        Cnt .ShippingState =  'Test';
        Cnt .ShippingPostalCode =  'Test';
        Cnt .ShippingCountry =  'Test';
        insert Cnt;
       
       pagereference pageRef = new pagereference('/apex/GE_Content_PreScreening?Contrid='+Cnt.ID); 
       system.test.setCurrentpage(pageRef); 
       
       GE_Content_Upload controller = new GE_Content_Upload();
       //controller.usrProfileName='GE_ES';
       
       controller.BusinessTiervalue= 'HQ';
      // controller.getworkspaces();
       
       String nextPage = controller.array().getUrl();
       System.assertEquals('/apex/GE_Multi_Content_Upload?id='+Cnt.id, nextPage);
 

     
       pageRef = new pagereference('/apex/GE_Content_PreScreening?Contrid='+Cnt.ID); 
       system.test.setCurrentpage(pageRef); 
       
       
       controller = new GE_Content_Upload();
       controller.usrProfileName='GE_OG';
       controller.getBusinessTier();
       //controller.getPnL();
       //controller.getRegion();
       //controller.PnLvalue= 'D&P';
       //controller.Regionvalue= 'none';
      // controller.userTier2 = 'Lufkin';
       
       controller.BusinessTiervalue= 'OG';
       //controller.getworkspaces();
       
       nextPage = controller.array().getUrl();
       System.assertEquals('/apex/GE_Multi_Content_Upload?id='+Cnt.id, nextPage);
       
       pagereference pageRef1 = new pagereference('/apex/GE_Multi_Content_Upload?Contrid='+Cnt.id); 
       system.test.setCurrentpage(pageRef1);
              
       controller.mycontentList[0].title = 'testaccOG';
       controller.mycontentList[0].PathOnClient = 'test1.pdf';
       controller.workspace1=[select id, name from contentworkspace where name =: 'GE OG PRM PUBLIC'].id;
        controller.workspace2=[select id, name from contentworkspace where name =: 'GE OG PRM PUBLIC'].id;
        controller.workspace3=[select id, name from contentworkspace where name =: 'GE OG PRM PUBLIC'].id;
        controller.workspace4=[select id, name from contentworkspace where name =: 'GE OG PRM PUBLIC'].id;
        controller.workspace5=[select id, name from contentworkspace where name =: 'GE OG PRM PUBLIC'].id;

        controller.workspacename1='GE OG PRM PUBLIC';
        controller.workspacename2='GE OG PRM PUBLIC';
        controller.workspacename3='GE OG PRM PUBLIC';
        controller.workspacename4='GE OG PRM PUBLIC';
        controller.workspacename5='GE OG PRM PUBLIC';

        controller.upload();
        
        
    }

static testMethod void testMultiUploadContentTest6(){      
        
       
        
       
       upsert new GE_Configuration_Setting__c(Name = 'OG Counter',GE_OG_SS_WSIDCntr__c=0,GE_OG_PII_OIDCnt__c=0,GE_OGGS_Oppty_ID__c=0,GE_OG_Oppty_Id_Counter__c=0,GE_OG_DTS_OpptyID__c=0) Name; 
        upsert new GE_Profile__c(Name='GE_ES System Integration',Profile_SFDC_ID__c='00eA0000000EHeBIAW',Profile_Name__c='GE_ES System Integration') Name;
        
       // Create Member Account
        Account acc1 = CommonTestDataFactory_GE_OG.createAccount ('TestAccount Member');
        system.assertEquals('TestAccount Member',acc1.Name);
        
        //Createing an Account 
        Account acc = CommonTestDataFactory_GE_OG.createCommercialParentAccountWithMember ('TestAccount Relation', acc1.ID);
        system.assertEquals('TestAccount Relation',acc.Name);
        
        project_ge_og__c prj = new project_ge_og__c();
        prj.Name = 'TestProject1';
        prj.GE_OG_SS_First_Oil_Date__c=Date.today();
        prj.project_account_ge_og__c = acc.id;
        insert prj;
        
        //Creating an Opportunity
        Opportunity opp = CommonTestDataFactory_GE_OG.createOppty('Testopportunity',acc.ID);
        system.assertEquals('Testopportunity',opp.Name);
       
       pagereference pageRef = new pagereference('/apex/GE_Content_PreScreening?Oppid='+opp.ID); 
       system.test.setCurrentpage(pageRef); 
       
       GE_Content_Upload controller = new GE_Content_Upload();
       //controller.usrProfileName='GE_ES';
       
       controller.BusinessTiervalue= 'HQ';
      // controller.getworkspaces();
       
       String nextPage = controller.array().getUrl();
       System.assertEquals('/apex/GE_Multi_Content_Upload?id='+opp.id, nextPage);
 

     
       pageRef = new pagereference('/apex/GE_Content_PreScreening?Oppid='+opp.ID); 
       system.test.setCurrentpage(pageRef); 
       
       
       controller = new GE_Content_Upload();
       controller.usrProfileName='GE_OG';
       controller.getBusinessTier();
       //controller.getPnL();
       //controller.getRegion();
       //controller.PnLvalue= 'D&P';
       //controller.Regionvalue= 'none';
       //controller.userTier2 = 'Lufkin';
       
       controller.BusinessTiervalue= 'OG';
       //controller.getworkspaces();
       
       nextPage = controller.array().getUrl();
       System.assertEquals('/apex/GE_Multi_Content_Upload?id='+opp.id, nextPage);
       
       pagereference pageRef1 = new pagereference('/apex/GE_Multi_Content_Upload?Oppid='+opp.id); 
       system.test.setCurrentpage(pageRef1);
              
       controller.mycontentList[0].title = 'testaccOG';
       controller.mycontentList[0].PathOnClient = 'test1.pdf';
       controller.workspace1=[select id, name from contentworkspace where name =: 'GE OG PRM PUBLIC'].id;
        controller.workspace2=[select id, name from contentworkspace where name =: 'GE OG PRM PUBLIC'].id;
        controller.workspace3=[select id, name from contentworkspace where name =: 'GE OG PRM PUBLIC'].id;
        controller.workspace4=[select id, name from contentworkspace where name =: 'GE OG PRM PUBLIC'].id;
        controller.workspace5=[select id, name from contentworkspace where name =: 'GE OG PRM PUBLIC'].id;

        controller.workspacename1='GE OG PRM PUBLIC';
        controller.workspacename2='GE OG PRM PUBLIC';
        controller.workspacename3='GE OG PRM PUBLIC';
        controller.workspacename4='GE OG PRM PUBLIC';
        controller.workspacename5='GE OG PRM PUBLIC';

        controller.upload();

}

static testMethod void testMultiUploadContentTest2(){
       RecordType rt = [select id,Name from RecordType where SobjectType='Account' and Name='Relationship Account' Limit 1];        
       Account acc = new Account(name='acc123',Classification__c='Strategic',type='Direct Customer');   
       acc.RecordTypeId = rt.Id; 
       insert acc; 
       RecordType gen = [Select Id From RecordType  where SobjectType='GE_Installed_Base__c' and id='012A00000003aOw'];     
       GE_Installed_Base__c inst = new GE_Installed_Base__c(RecordType=gen , Account__c=acc.id);
       insert inst;
       
       pagereference pageRef = new pagereference('/apex/GE_Content_PreScreening?instid='+inst.ID); 
       system.test.setCurrentpage(pageRef); 
       
       GE_Content_Upload controller = new GE_Content_Upload();
       controller.usrProfileName='GE_ES';
       controller.getBusinessTier();
       //controller.getPnL();
       //controller.getRegion();
       //controller.PnLvalue= 'DE';
       //controller.Regionvalue= 'Asia';
         controller.userTier2 = 'DTS';
         
       User u = [Select ID From User Where Profile.Name =  'System Administrator' and isActive =true Limit 1] ;
       System.runAs(u)
       {
       controller.getworkspaces();
       }
       
       List<contentworkspace> CWS = new List<contentworkspace>();
       
       contentworkspace cw = new contentworkspace();
       //cw.name = 'OG DTS Library';
      
       
       String nextPage = controller.array().getUrl();
       System.assertEquals('/apex/GE_Multi_Content_Upload?id='+inst.id, nextPage);
       
       pagereference pageRef1 = new pagereference('/apex/GE_Multi_Content_Upload?instid='+inst.id); 
       system.test.setCurrentpage(pageRef1);
              
       controller.mycontentList[0].title = 'testinst';
       controller.mycontentList[0].PathOnClient = 'test1.pdf';
        controller.workspace1=[select id, name from contentworkspace where name =: 'GE OG PRM PUBLIC'].id;
      controller.workspace2=[select id, name from contentworkspace where name =: 'GE OG PRM PUBLIC'].id;
        controller.workspace3=[select id, name from contentworkspace where name =: 'GE OG PRM PUBLIC'].id;
        controller.workspace4=[select id, name from contentworkspace where name =: 'GE OG PRM PUBLIC'].id;
        controller.workspace5=[select id, name from contentworkspace where name =: 'GE OG PRM PUBLIC'].id; 

       controller.workspacename1='GE OG PRM PUBLIC';
     controller.workspacename2='GE OG PRM PUBLIC';
        controller.workspacename3='GE OG PRM PUBLIC';
        controller.workspacename4='GE OG PRM PUBLIC';
        controller.workspacename5='GE OG PRM PUBLIC'; 

       controller.upload();
    }   
       static testMethod void testMultiUploadContentTest3(){     
       RecordType rt = [select id,Name from RecordType where SobjectType='Account' and Name='Relationship Account' Limit 1];        
       Account acc = new Account(name='acc123',Classification__c='Strategic',type='Direct Customer');   
       acc.RecordTypeId = rt.Id; 
       acc.Classification__c = 'Unclassified';
       insert acc;
       Contact cont = new Contact(FirstName='conName', LastName='lastCon', AccountId=acc.Id, GE_ES_I_Agree_picklist__c='Yes' , MobilePhone='9876543211',Email='abc@gmail.com');
       insert cont;
       pagereference pageRef = new pagereference('/apex/GE_Content_PreScreening?Contid='+Cont.ID); 
       system.test.setCurrentpage(pageRef); 
       
       GE_Content_Upload controller = new GE_Content_Upload();
       controller.usrProfileName='GE_ES';
       controller.getBusinessTier();
       //controller.getPnL();
       //controller.getRegion();
       //controller.PnLvalue= 'DE';
       //controller.Regionvalue= 'Asia';
        controller.userTier2 = 'Measurement & Control (M&C)';
        
         User u = [Select ID From User Where Profile.Name =  'System Administrator' and isActive =true Limit 1] ;
       System.runAs(u)
       {
       controller.getworkspaces();
       }
       
   
       String nextPage = controller.array().getUrl();
       System.assertEquals('/apex/GE_Multi_Content_Upload?id='+cont.id, nextPage);
       
       pagereference pageRef1 = new pagereference('/apex/GE_Multi_Content_Upload?contid='+cont.id); 
       system.test.setCurrentpage(pageRef1);
              
       controller.mycontentList[0].title = 'testcont';
       controller.mycontentList[0].PathOnClient = 'test1.pdf';
        controller.workspace1=[select id, name from contentworkspace where name =: 'GE OG PRM PUBLIC'].id;
        controller.workspace2=[select id, name from contentworkspace where name =: 'GE OG PRM PUBLIC'].id;
        controller.workspace3=[select id, name from contentworkspace where name =: 'GE OG PRM PUBLIC'].id;
        controller.workspace4=[select id, name from contentworkspace where name =: 'GE OG PRM PUBLIC'].id;
        controller.workspace5=[select id, name from contentworkspace where name =: 'GE OG PRM PUBLIC'].id;

       controller.workspacename1='GE OG PRM PUBLIC';
        controller.workspacename2='GE OG PRM PUBLIC';
        controller.workspacename3='GE OG PRM PUBLIC';
        controller.workspacename4='GE OG PRM PUBLIC';
        controller.workspacename5='GE OG PRM PUBLIC';

controller.upload();


    
  /* GE_Content_Upload kycc=new GE_Content_Upload();
       
   kycc.upload();
   kycc.array();
   kycc.cancel();
   kycc.back();*/

}

       static testMethod void testMultiUploadContentTest4(){     
       
       //Contract contr = new Contract(Account=acc, AccountId=acc.id, ContractTerm=4);
       
       //insert contr;
       //Commenting to avoid error April 7th,2017
       //Campaign camp = new Campaign(name='camp1234');
       //insert camp;
       
       // Create Member Account
        Account acc1 = CommonTestDataFactory_GE_OG.createAccount ('TestAccount Member');
        system.assertEquals('TestAccount Member',acc1.Name);
        
        //Createing an Account 
        Account acc = CommonTestDataFactory_GE_OG.createCommercialParentAccountWithMember ('TestAccount Relation', acc1.ID);
        system.assertEquals('TestAccount Relation',acc.Name);
        
        project_ge_og__c prj = new project_ge_og__c();
        prj.Name = 'TestProject1';
        prj.GE_OG_SS_First_Oil_Date__c=Date.today();
        prj.project_account_ge_og__c = acc.id;
        insert prj;
        
        
       Product2 prod = new Product2(name='prod123',CurrencyIsoCode='INR');
       insert prod;
    
       //pagereference pageRef = new pagereference('/apex/GE_Content_PreScreening?Campid='+Camp.ID); 
       //system.test.setCurrentpage(pageRef); 
       GE_Content_Upload controller = new GE_Content_Upload();
       controller = new GE_Content_Upload();
       controller.usrProfileName='GE_ES';
       controller.getBusinessTier();
       //controller.getPnL();
       //controller.getRegion();
       //controller.PnLvalue= 'DE';
       //controller.Regionvalue= 'Asia';
      // controller.getworkspaces();
       
       String nextPage = controller.array().getUrl();
       //System.assertEquals('/apex/GE_Multi_Content_Upload?id='+camp.id, nextPage);
       
       //pagereference pageRef1 = new pagereference('/apex/GE_Multi_Content_Upload?campid='+camp.id); 
       //system.test.setCurrentpage(pageRef1);
              
       controller.mycontentList[0].title = 'testcamp';
       controller.mycontentList[0].PathOnClient = 'test1.pdf';
       controller.workspace1=[select id, name from contentworkspace where name =: 'GE OG PRM PUBLIC'].id;
        controller.workspace2=[select id, name from contentworkspace where name =: 'GE OG PRM PUBLIC'].id;
        controller.workspace3=[select id, name from contentworkspace where name =: 'GE OG PRM PUBLIC'].id;
        controller.workspace4=[select id, name from contentworkspace where name =: 'GE OG PRM PUBLIC'].id;
        controller.workspace5=[select id, name from contentworkspace where name =: 'GE OG PRM PUBLIC'].id;

       controller.workspacename1='GE OG PRM PUBLIC';
        controller.workspacename2='GE OG PRM PUBLIC';
        controller.workspacename3='GE OG PRM PUBLIC';
        controller.workspacename4='GE OG PRM PUBLIC';
        controller.workspacename5='GE OG PRM PUBLIC';

       controller.upload();

       //Added pagereference as camp is commented
       pagereference pageRef = new pagereference('/apex/GE_Content_PreScreening?proid='+prj.ID); 
       system.test.setCurrentpage(pageRef); 
       
       controller = new GE_Content_Upload();
       controller.usrProfileName='GE_ES';
       controller.getBusinessTier();
       //controller.getPnL();
       //controller.getRegion();
       //controller.PnLvalue= 'DE';
       //controller.Regionvalue= 'Asia';
       //controller.getworkspaces();
       
       nextPage = controller.array().getUrl();
       System.assertEquals('/apex/GE_Multi_Content_Upload?id='+prj.id, nextPage);
       
       pagereference pageRef1 = new pagereference('/apex/GE_Multi_Content_Upload?proid='+prj.id); 
       system.test.setCurrentpage(pageRef1);
              
       controller.mycontentList[0].title = 'testpro';
       controller.mycontentList[0].PathOnClient = 'test1.pdf';
        controller.workspace1=[select id, name from contentworkspace where name =: 'GE OG PRM PUBLIC'].id;
        controller.workspace2=[select id, name from contentworkspace where name =: 'GE OG PRM PUBLIC'].id;
        controller.workspace3=[select id, name from contentworkspace where name =: 'GE OG PRM PUBLIC'].id;
        controller.workspace4=[select id, name from contentworkspace where name =: 'GE OG PRM PUBLIC'].id;
        controller.workspace5=[select id, name from contentworkspace where name =: 'GE OG PRM PUBLIC'].id;

       controller.workspacename1='GE OG PRM PUBLIC';
        controller.workspacename2='GE OG PRM PUBLIC';
        controller.workspacename3='GE OG PRM PUBLIC';
        controller.workspacename4='GE OG PRM PUBLIC';
        controller.workspacename5='GE OG PRM PUBLIC';

       controller.upload();

       
       
       pageRef = new pagereference('/apex/GE_Content_PreScreening?prodid='+prod.ID); 
       system.test.setCurrentpage(pageRef); 
       
       controller = new GE_Content_Upload();
       controller.usrProfileName='GE_ES';
       controller.getBusinessTier();
       //controller.getPnL();
       //controller.getRegion();
       //controller.PnLvalue= 'DE';
       //controller.Regionvalue= 'Asia';
       //controller.getworkspaces();
       
       nextPage = controller.array().getUrl();
       System.assertEquals('/apex/GE_Multi_Content_Upload?id='+prod.id, nextPage);
       
       pageRef1 = new pagereference('/apex/GE_Multi_Content_Upload?prodid='+prod.id); 
       system.test.setCurrentpage(pageRef1);
              
       controller.mycontentList[0].title = 'testprod';
       controller.mycontentList[0].PathOnClient = 'test1.pdf';
        controller.workspace1=[select id, name from contentworkspace where name =: 'GE OG PRM PUBLIC'].id;
        controller.workspace2=[select id, name from contentworkspace where name =: 'GE OG PRM PUBLIC'].id;
        controller.workspace3=[select id, name from contentworkspace where name =: 'GE OG PRM PUBLIC'].id;
        controller.workspace4=[select id, name from contentworkspace where name =: 'GE OG PRM PUBLIC'].id;
        controller.workspace5=[select id, name from contentworkspace where name =: 'GE OG PRM PUBLIC'].id;

       controller.workspacename1='GE OG PRM PUBLIC';
        controller.workspacename2='GE OG PRM PUBLIC';
        controller.workspacename3='GE OG PRM PUBLIC';
        controller.workspacename4='GE OG PRM PUBLIC';
        controller.workspacename5='GE OG PRM PUBLIC';

       controller.upload();
       
                  
       
       
       
       pageRef = new pagereference('/apex/GE_Content_PreScreening?prodid='+prod.ID); 
       system.test.setCurrentpage(pageRef); 
       
       controller = new GE_Content_Upload();
       controller.usrProfileName='GE_PW';
       controller.getBusinessTier();
       //controller.getPnL();
       //controller.getRegion();
       //controller.PnLvalue= 'DE';
       //controller.Regionvalue= 'Asia';
       controller.BusinessTiervalue= 'P&W';
       controller.getworkspaces();
       
       nextPage = controller.array().getUrl();
       System.assertEquals('/apex/GE_Multi_Content_Upload?id='+prod.id, nextPage);
       
       pageRef1 = new pagereference('/apex/GE_Multi_Content_Upload?prodid='+prod.id); 
       system.test.setCurrentpage(pageRef1);
              
       controller.mycontentList[0].title = 'testprod';
       controller.mycontentList[0].PathOnClient = 'test1.pdf';
        controller.workspace1=[select id, name from contentworkspace where name =: 'GE OG PRM PUBLIC'].id;
        controller.workspace2=[select id, name from contentworkspace where name =: 'GE OG PRM PUBLIC'].id;
        controller.workspace3=[select id, name from contentworkspace where name =: 'GE OG PRM PUBLIC'].id;
        controller.workspace4=[select id, name from contentworkspace where name =: 'GE OG PRM PUBLIC'].id;
        controller.workspace5=[select id, name from contentworkspace where name =: 'GE OG PRM PUBLIC'].id;

       controller.workspacename1='GE OG PRM PUBLIC';
        controller.workspacename2='GE OG PRM PUBLIC';
        controller.workspacename3='GE OG PRM PUBLIC';
        controller.workspacename4='GE OG PRM PUBLIC';
        controller.workspacename5='GE OG PRM PUBLIC';

       controller.upload();
       
    
 /*  GE_Content_Upload kycc=new GE_Content_Upload();
       
   kycc.upload();
   kycc.array();
   kycc.cancel();
   kycc.back();*/
       
       
       
       

 }
 static testMethod void testMultiUploadContentTest5(){      
       Account acc = new Account(name='acc123');
       acc.Classification__c = 'Unclassified';
       acc.Type= 'Direct Customer';
       insert acc; 
       
       GE_PRM_Channel_Appointment__c channelapp = new GE_PRM_Channel_Appointment__c(GE_PRM_Account_Name__c = acc.id);
       insert channelapp;
       
       pagereference pageRef = new pagereference('/apex/GE_PRM_Channel_Appointment_View_Page?Caid='+channelapp.ID); 
       system.test.setCurrentpage(pageRef); 
       
       GE_Content_Upload controller = new GE_Content_Upload();
       controller.usrProfileName='GE_ES';
       
       controller.BusinessTiervalue= 'HQ';
       controller.getworkspaces();
       
       String nextPage = controller.array().getUrl();
       System.assertEquals('/apex/GE_Multi_Content_Upload?id='+channelapp.id, nextPage);
 

     
       pageRef = new pagereference('/apex/GE_PRM_Channel_Appointment_View_Page?Caid='+channelapp.ID); 
       system.test.setCurrentpage(pageRef); 
       
       
       controller = new GE_Content_Upload();
       controller.usrProfileName='GE_OG';
       controller.getBusinessTier();
       //controller.getPnL();
       //controller.getRegion();
       //controller.PnLvalue= 'D&P';
       //controller.Regionvalue= 'none';
       controller.BusinessTiervalue= 'OG';
       controller.getworkspaces();
       
       nextPage = controller.array().getUrl();
       System.assertEquals('/apex/GE_Multi_Content_Upload?id='+channelapp.id, nextPage);
       
       pagereference pageRef1 = new pagereference('/apex/GE_Multi_Content_Upload?Caid='+channelapp.id); 
       system.test.setCurrentpage(pageRef1);
              
       controller.mycontentList[0].title = 'testaccOG';
       controller.mycontentList[0].PathOnClient = 'test1.pdf';
       controller.workspace1=[select id, name from contentworkspace where name =: 'GE OG PRM PUBLIC'].id;
        controller.workspace2=[select id, name from contentworkspace where name =: 'GE OG PRM PUBLIC'].id;
        controller.workspace3=[select id, name from contentworkspace where name =: 'GE OG PRM PUBLIC'].id;
        controller.workspace4=[select id, name from contentworkspace where name =: 'GE OG PRM PUBLIC'].id;
        controller.workspace5=[select id, name from contentworkspace where name =: 'GE OG PRM PUBLIC'].id;

        controller.workspacename1='GE OG PRM PUBLIC';
        controller.workspacename2='GE OG PRM PUBLIC';
        controller.workspacename3='GE OG PRM PUBLIC';
        controller.workspacename4='GE OG PRM PUBLIC';
        controller.workspacename5='GGE OG PRM PUBLIC';

       controller.upload();

}


}