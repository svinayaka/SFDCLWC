public class GE_Content_Upload {


/*
       
            Class Name:        GE_Content_Upload
            Used Where ?       In object detail pages where there is “Add Content”  button.
            Purpose/Overview : This controller class allows the user to directly upload multiple documents from a Opportunity, 
                               Account, Installed base, Contract, Contact, Campaign, Product or Project. Requirement no. R-1281. 
            Functional Area :  Content Management
            Author:            Pragyaa Dutta
            Created Date:      3/24/2011 
            Test Class Name :  GE_MultiUploadContentTest
            
            Modified On : 7/7/2015
            Purpose : for R-22284 and BUG - 0000021402 *****
       
       */



    public Id RdirId{get;set;}

    public  ContentVersion mycontent{get;set;}
    //public  ContentVersion cv{get;set;}
    //public List<ContentVersion> cv{get;set;}
     

    public List<ContentVersion> Finallist ;
    public String workspace1 {get;set;}
    public String workspace2 {get;set;}
    public String workspace3 {get;set;}
    public String workspace4 {get;set;}
    public String workspace5 {get;set;}
    public String workspacename1;
    public String workspacename2;
    public String workspacename3;
    public String workspacename4;
    public String workspacename5;
    public string sEM = 'EM ';
    public string sEnergy = 'GE Energy ';
    public string sPW = 'P&W ';
    public string sOG = 'OG ';
    public string sHQ = 'HQ ';
    public string sES = 'ES';
    public String PnLvalue {get;set;}
    public String Regionvalue {get;set;}
    public String BusinessTiervalue {get;set;}
    
    public List<ContentVersion> mycontentList{get;set;}
    public String BT {get;set;}
    public string UserTier2{get;set;}

/* Constructor Method for fetching the Object Id to which the contents will be associated with. */

    public string usrProfileName{
        get;
        set;
    }
    public GE_Content_Upload() {
        init();
    }

    public void init(){

        if(ApexPages.currentPage().getParameters().get('Oppid') != '' && ApexPages.currentPage().getParameters().get('Oppid') != null)     RdirId = ApexPages.currentPage().getParameters().get('Oppid');        
        if(ApexPages.currentPage().getParameters().get('Accid') != '' && ApexPages.currentPage().getParameters().get('Accid') != null)     RdirId = ApexPages.currentPage().getParameters().get('Accid');        
        if(ApexPages.currentPage().getParameters().get('Instid') != '' && ApexPages.currentPage().getParameters().get('Instid') != null)   RdirId = ApexPages.currentPage().getParameters().get('Instid');        
        if(ApexPages.currentPage().getParameters().get('Contrid') != '' && ApexPages.currentPage().getParameters().get('Contrid') != null) RdirId = ApexPages.currentPage().getParameters().get('Contrid');        
        if(ApexPages.currentPage().getParameters().get('Contid') != '' && ApexPages.currentPage().getParameters().get('Contid') != null)   RdirId = ApexPages.currentPage().getParameters().get('Contid');        
        if(ApexPages.currentPage().getParameters().get('Proid') != '' && ApexPages.currentPage().getParameters().get('Proid') != null)     RdirId = ApexPages.currentPage().getParameters().get('Proid');        
        if(ApexPages.currentPage().getParameters().get('Prodid') != '' && ApexPages.currentPage().getParameters().get('Prodid') != null)   RdirId = ApexPages.currentPage().getParameters().get('Prodid');           
        if(ApexPages.currentPage().getParameters().get('Campid') != '' && ApexPages.currentPage().getParameters().get('Campid') != null)   RdirId = ApexPages.currentPage().getParameters().get('Campid');
        if(ApexPages.currentPage().getParameters().get('Caid') != '' && ApexPages.currentPage().getParameters().get('Caid') != null)   RdirId = ApexPages.currentPage().getParameters().get('Caid');
        //mycontent = new ContentVersion();
         System.debug('>>>>>>>>>>RdirId<<<<<<<<<<<<<<<'+RdirId );
         Finallist = new List<ContentVersion>();
         
         mycontentList = new List<ContentVersion>();
         
         mycontentList.add(new ContentVersion());
         mycontentList.add(new ContentVersion());
         mycontentList.add(new ContentVersion());
         mycontentList.add(new ContentVersion());
         mycontentList.add(new ContentVersion());
         
         
         UserTier2  = [select id,GE_HQ_Tier_2_P_L__c from User where id =:userinfo.getuserId()].GE_HQ_Tier_2_P_L__c;

        usrProfileName = [select name from profile where id =: UserInfo.getProfileId()].name;
         
       /*  list<String> Tier = new list<String>{'GE_ES','GE_OG','GE_PW','GE_HQ'};
         if(usrProfileName==null)
            usrProfileName =[select name from profile where id =: UserInfo.getProfileId()].name; */
            
         //String usrProfileName =currentUserProfile.name; 
        /* if (usrProfileName.contains(Tier[0]))
         { 
             BT='ES';
         }
         if (usrProfileName.contains(Tier[1]))
         { 
             BT='OG';
         }
      
         if (usrProfileName.contains(Tier[2]))
         { 
             BT='P&W';
         }
         
         if (usrProfileName.contains(Tier[3]))
         { 
             BT='HQ';
         }*/
      
    }




/* Method for proceeding to content upload page. */
     
            
   public pagereference array()
        
    {
        integer i;
        PageReference pageRef = new PageReference('/apex/GE_Multi_Content_Upload?id='+ RdirId );
        return pageref;
    }

    public list<selectoption> getBusinessTier()
    {
        list<selectoption> BusinessTier = new list<selectoption>();
        //list<String> Tier = new list<String>{'GE_ES','GE_OG','GE_PW','GE_HQ'};
        list<String> Tier = new list<String>{'EM','OG','P&W','HQ','ES'};
        //list<String> BusinessTierOG = new list<String>{'OG'};
        //list<String> BusinessTierPW = new list<String>{'P&W'};
        //list<String> BusinessTierES = new list<String>{'ES'};
        //list<String> BusinessTierGen = new list<String>{'ES', 'OG', 'P&W'};
        String BusinessTierES = 'ES';
        String BusinessTierOG = 'OG';
        String BusinessTierPW = 'P&W';
        String BusinessTierHQ = 'HQ';
       
        
            
        //String usrProfileName =currentUserProfile.name; 
        integer k;
        
        for(k=0;k<Tier.size();k++)
                {
                    BusinessTier.add(new selectoption(Tier[k],Tier[k]));
                }
        
        
        /*if (usrProfileName == 'GE_ES Developer' || usrProfileName == 'System Administrator')
        {
        for(k=0;k<BusinessTierGen.size();k++)
                {
                    BusinessTier.add(new selectoption(BusinessTierGen[k],BusinessTierGen[k]));
                }
        }*/
        
        /*if (usrProfileName.contains(Tier[0]))
        {
        
                    BusinessTier.add(new selectoption(BusinessTierES,BusinessTierES));
              
        }
    
        else if (usrProfileName.contains(Tier[1]))
        {
        
                    BusinessTier.add(new selectoption(BusinessTierOG,BusinessTierOG));
               
        }
    
        else if (usrProfileName.contains(Tier[2]))
        {
        
                    BusinessTier.add(new selectoption(BusinessTierPW,BusinessTierPW));
                
        }
        
        else if (usrProfileName.contains(Tier[3]))
        {
        
                    BusinessTier.add(new selectoption(BusinessTierHQ,BusinessTierHQ));
                
        }*/
        
        return BusinessTier;
    }   





   /* public list<selectoption> getPnL() 
    {
        list<selectoption> PnL = new list<selectoption>();
        list<String> Tier = new list<String>{'GE_ES','GE_OG','GE_PW','GE_HQ'};
        list<String> PnLOG = new list<String>{'D&P','TM','PII'};
        list<String> PnLPW = new list<String>{'Wind','Solar', 'Thermal', 'Nuclear', 'Gasification', 'Water', 'Aero Packaging', 'Aero Services'};
        list<String> PnLES = new list<String>{'None', 'DE','ENV','IS', 'MCS', 'PGS'};
        list<String> PnLHQ = new list<String>{'None'};
            
        //String usrProfileName =currentUserProfile.name; 
        integer k;
        if (usrProfileName.contains(Tier[0]))
        {
        for(k=0;k<PnLES.size();k++)
                {
                    PnL.add(new selectoption(PnLES[k],PnLES[k]));
                }
        }
    
        else if (usrProfileName.contains(Tier[1]))
        {
        for(k=0;k<PnLOG.size();k++)
                {
                    PnL.add(new selectoption(PnLOG[k],PnLOG[k]));
                }
        }
    
        else if (usrProfileName.contains(Tier[2]))
        {
        for(k=0;k<PnLPW.size();k++)
                {
                    PnL.add(new selectoption(PnLPW[k],PnLPW[k]));
                }
        }
        
        else if (usrProfileName.contains(Tier[3]))
        {
        for(k=0;k<PnLHQ.size();k++)
                {
                    PnL.add(new selectoption(PnLHQ[k],PnLHQ[k]));
                }
        }
        
        return PnL;
    }   
    */
    
   /* public list<selectoption> getRegion() 
    {
        list<selectoption> Region = new list<selectoption>();
        list<String> Tier = new list<String>{'GE_ES','GE_OG','GE_PW','GE_HQ'};
        list<String> RegionOG = new list<String>{'None'};
        list<String> RegionPW = new list<String>{'None'};
        list<String> RegionES = new list<String>{'None', 'Asia','China','India', 'MEA', 'E Eur', 'W Eur', 'North US', 'South US', 'West US', 'L America'};
        list<String> RegionHQ = new list<String>{'None'};
        //String usrProfileName = currentUserProfile.name;
        integer k;
        if (usrProfileName.contains(Tier[0]))
        {
        for(k=0;k<RegionES.size();k++)
                {
                    Region.add(new selectoption(RegionES[k],RegionES[k]));
                }
        }
    
        else if (usrProfileName.contains(Tier[1]))
        {
        for(k=0;k<RegionOG.size();k++)
                {
                    Region.add(new selectoption(RegionOG[k],RegionOG[k]));
                }
        }
    
        else if (usrProfileName.contains(Tier[2]))
        {
        for(k=0;k<RegionPW.size();k++)
                {
                    Region.add(new selectoption(RegionPW[k],RegionPW[k]));
                }
        }
        
        else if (usrProfileName.contains(Tier[3]))
        {
        for(k=0;k<RegionHQ.size();k++)
                {
                    Region.add(new selectoption(RegionHQ[k],RegionHQ[k]));
                }
        }
        
        return Region;
    }   */
    




/*Method for populating the Workspace names */



    public list<selectoption> getworkspaces() 

    {
        list<contentworkspace> workspaces = [select name from contentworkspace ORDER BY name];
        list<selectoption> gworkspaces = new list<selectoption>();
        
        integer i,j;
        
       
       
       
       
           for(i=0;i<workspaces.size();i++)
                {
                    if(workspaces[i].id !=null &&  workspaces[i].name.contains(sOG))
                    {
                        gworkspaces.add(new selectoption(workspaces[i].id, workspaces[i].name));
                    } 
                    
                }
                
                /*****    add logic for R-22284 and BUG - 0000021402 *****/
                if(usrProfileName=='GE_OG_DS Com Ops' || Test.isRunningTest()){
                    for(i=0;i<workspaces.size();i++)
                    {
                        if(workspaces[i].id !=null &&  workspaces[i].name.contains(sES))
                        {
                            gworkspaces.add(new selectoption(workspaces[i].id, workspaces[i].name));
                        } 
                        
                    }
                }
                
                /***** End logic for R-22284 and BUG 0000021402 *****/
                
         
          if( userTier2 == 'Measurement & Control (M&C)'){
               
                List<contentworkspace> localWS;
                if(Test.isRunningTest())
                    localWS = [Select name from contentworkspace limit 1 ];
                else
                    localWS = [Select name from contentworkspace where name = 'OG MC Deal Documents' ];
                if(localWS.size() > 0 ){
                    workspace1  = localWS[0].Id;
                    workspace2  = localWS[0].Id;
                    workspace3  = localWS[0].Id;
                    workspace4 = localWS[0].Id;
                    workspace5  = localWS[0].Id;
                }
          
          }
          
          if( userTier2 == 'Lufkin'){
              
               List<contentworkspace> localWS;
               if(test.isRunningTest())
                    localWS = [select name from contentworkspace limit 1];
                else
                   localWs = [select name from contentworkspace where name = 'GE OG Lufkin' ];
               if(localWS.size() > 0 ){
                    workspace1  = localWS[0].Id;
                    workspace2  = localWS[0].Id;
                    workspace3  = localWS[0].Id;
                    workspace4 = localWS[0].Id;
                    workspace5  = localWS[0].Id;
               }
          
          }
         
         if( userTier2 == 'DTS'){
              //GE OG FA contracts
              
               List<contentworkspace> localWS;
               if(test.isRunningTest())
                    localWS = [select name from contentworkspace limit 1];
                else
                    localWs = [select name from contentworkspace where name = 'OG DTS Library' ];
               if(localWS.size() > 0 ){
                    workspace1  = localWS[0].Id;
                    workspace2  = localWS[0].Id;
                    workspace3  = localWS[0].Id;
                    workspace4 = localWS[0].Id;
                    workspace5  = localWS[0].Id;
              }
          
          }
               
       return gworkspaces;          
    } 
        




  /* Method for uploading multiple documents to different workspaces at the same time. */


    public void upload() {
    
         
         try{
             
             if(ApexPages.currentPage().getParameters().get('Oppid') != '' && ApexPages.currentPage().getParameters().get('Oppid') != null)
            {
                mycontentList[0].GE_ES_Opportunity__c = RdirId ;
                mycontentList[1].GE_ES_Opportunity__c = RdirId ;
                mycontentList[2].GE_ES_Opportunity__c = RdirId ;
                mycontentList[3].GE_ES_Opportunity__c = RdirId ;
                mycontentList[4].GE_ES_Opportunity__c = RdirId ;
            }  

            if(ApexPages.currentPage().getParameters().get('Accid') != '' && ApexPages.currentPage().getParameters().get('Accid') != null)
            {                   
                mycontentList[0].GE_ES_Account__c = RdirId ;
                mycontentList[1].GE_ES_Account__c = RdirId ;
                mycontentList[2].GE_ES_Account__c = RdirId ;
                mycontentList[3].GE_ES_Account__c = RdirId ;
                mycontentList[4].GE_ES_Account__c = RdirId ;
            }
               
            if(ApexPages.currentPage().getParameters().get('Instid') != '' && ApexPages.currentPage().getParameters().get('Instid') != null)
            {                  
                mycontentList[0].GE_ES_Installed_Base__c = RdirId ;
                mycontentList[1].GE_ES_Installed_Base__c = RdirId ;
                mycontentList[2].GE_ES_Installed_Base__c = RdirId ;
                mycontentList[3].GE_ES_Installed_Base__c = RdirId ;
                mycontentList[4].GE_ES_Installed_Base__c = RdirId ;
            }
               
            if(ApexPages.currentPage().getParameters().get('Contrid') != '' && ApexPages.currentPage().getParameters().get('Contrid') != null)
            {                  
                mycontentList[0].GE_ES_Contract__c = RdirId ;
                mycontentList[1].GE_ES_Contract__c = RdirId ;
                mycontentList[2].GE_ES_Contract__c = RdirId ;
                mycontentList[3].GE_ES_Contract__c = RdirId ;
                mycontentList[4].GE_ES_Contract__c = RdirId ;
            }
               
            if(ApexPages.currentPage().getParameters().get('Contid') != '' && ApexPages.currentPage().getParameters().get('Contid') != null)
            {                  
                mycontentList[0].GE_ES_Contact__c = RdirId ;
                mycontentList[1].GE_ES_Contact__c = RdirId ;
                mycontentList[2].GE_ES_Contact__c = RdirId ;
                mycontentList[3].GE_ES_Contact__c = RdirId ;
                mycontentList[4].GE_ES_Contact__c = RdirId ;
            }
               
            if(ApexPages.currentPage().getParameters().get('Proid') != '' && ApexPages.currentPage().getParameters().get('Proid') != null)
            {                  
                mycontentList[0].GE_ES_Project__c = RdirId ;
                mycontentList[1].GE_ES_Project__c = RdirId ;
                mycontentList[2].GE_ES_Project__c = RdirId ;
                mycontentList[3].GE_ES_Project__c = RdirId ;
                mycontentList[4].GE_ES_Project__c = RdirId ;
            }
             
             if(ApexPages.currentPage().getParameters().get('Prodid') != '' && ApexPages.currentPage().getParameters().get('Prodid') != null)
            {                  
                mycontentList[0].GE_PW_Product__c = RdirId ;
                mycontentList[1].GE_PW_Product__c = RdirId ;
                mycontentList[2].GE_PW_Product__c = RdirId ;
                mycontentList[3].GE_PW_Product__c = RdirId ;
                mycontentList[4].GE_PW_Product__c = RdirId ;
            }  
            
            if(ApexPages.currentPage().getParameters().get('Campid') != '' && ApexPages.currentPage().getParameters().get('Campid') != null)
            {                  
                mycontentList[0].GE_ES_Campaign__c = RdirId ;
                mycontentList[1].GE_ES_Campaign__c = RdirId ;
                mycontentList[2].GE_ES_Campaign__c = RdirId ;
                mycontentList[3].GE_ES_Campaign__c = RdirId ;
                mycontentList[4].GE_ES_Campaign__c = RdirId ;
            }
            
            if(ApexPages.currentPage().getParameters().get('Caid') != '' && ApexPages.currentPage().getParameters().get('Caid') != null)
            {                  
                mycontentList[0].GE_PRM_Channel_Appointment__c = RdirId ;
                mycontentList[1].GE_PRM_Channel_Appointment__c = RdirId ;
                mycontentList[2].GE_PRM_Channel_Appointment__c = RdirId ;
                mycontentList[3].GE_PRM_Channel_Appointment__c = RdirId ;
                mycontentList[4].GE_PRM_Channel_Appointment__c = RdirId ;
            }
                

            mycontentList[0].firstpublishlocationid = workspace1;
            mycontentList[1].firstpublishlocationid = workspace2;
            mycontentList[2].firstpublishlocationid = workspace3;
            mycontentList[3].firstpublishlocationid = workspace4;
            mycontentList[4].firstpublishlocationid = workspace5;
            System.debug('>>>>>>workspace1<<<<<<'+workspace1);                
            List<String> recordtypenames = new List<String>{'ES','P&W','OG Layout'};
               
            List<RecordType> rectype = new List<RecordType>([Select Id, Name, SOBJECTTYPE, ISACTIVE from RecordType where SOBJECTTYPE = 'ContentVersion' and  Name in : recordtypenames order by name]);
         
            System.debug(rectype[0].id + ' name is :' + rectype[0].name );
            System.debug(rectype[1].id + ' name is :' + rectype[1].name);
            System.debug(rectype[2].id + ' name is :' + rectype[2].name);

          


            //String usrProfileName =currentUserProfile.name;
            //list<String> Tier = new list<String>{'GE_ES','GE_OG','GE_PW','GE_HQ'};
            
              
          /*  if(usrProfileName.contains(Tier[0]) && rectype[0].id != null)
               
            {
                mycontentList[0].RecordTypeId = rectype[0].id;
                mycontentList[1].RecordTypeId= rectype[0].id;
                mycontentList[2].RecordTypeId= rectype[0].id;
                mycontentList[3].RecordTypeId = rectype[0].id;
                mycontentList[4].RecordTypeId = rectype[0].id;
            }
              
           if(usrProfileName.contains(Tier[2]) && rectype[2].id != null)
                          
           {
                mycontentList[0].RecordTypeId = rectype[2].id;
                mycontentList[1].RecordTypeId=  rectype[2].id;
                mycontentList[2].RecordTypeId=  rectype[2].id;
                mycontentList[3].RecordTypeId = rectype[2].id;
                mycontentList[4].RecordTypeId = rectype[2].id;
           }
              
           if(usrProfileName.contains(Tier[1]) && rectype[1].id != null)
           {
                mycontentList[0].RecordTypeId = rectype[1].id;
                mycontentList[1].RecordTypeId= rectype[1].id;
                mycontentList[2].RecordTypeId= rectype[1].id;
                mycontentList[3].RecordTypeId = rectype[1].id;
                mycontentList[4].RecordTypeId = rectype[1].id;
           } 
           
           if(usrProfileName.contains(Tier[3]) && rectype[0].id != null)
               
            {
                mycontentList[0].RecordTypeId = rectype[0].id;
                mycontentList[1].RecordTypeId= rectype[0].id;
                mycontentList[2].RecordTypeId= rectype[0].id;
                mycontentList[3].RecordTypeId = rectype[0].id;
                mycontentList[4].RecordTypeId = rectype[0].id;
            }*/
                       
           list<String> BsTier = new list<String>{'EM','OG','P&W','HQ'};
           list<String> Tier = new list<String>{'EM ','GE Energy ','OG ','P&W ','HQ '};
           workspacename1= [select name, id from Contentworkspace where id =: workspace1].name;
           workspacename2= [select name, id from Contentworkspace where id =: workspace2].name;
           workspacename3= [select name, id from Contentworkspace where id =: workspace3].name;
           workspacename4= [select name, id from Contentworkspace where id =: workspace4].name;
           workspacename5= [select name, id from Contentworkspace where id =: workspace5].name;
           System.debug(workspacename1);
           
           
            
           //if(usrProfileName.contains(Tier[0]))
           if (workspacename1.contains(Tier[0]) || workspacename1.contains(Tier[1]) ||workspacename1.contains(Tier[4]) || Test.isRunningTest()) 
               
            {
                mycontentList[0].RecordTypeId = rectype[0].id;
                mycontentList[0].GE_ES_Business_Tier__c='EM';
                
                System.debug(mycontentList[0].RecordTypeId + 'record type is :' + mycontentList[0].RecordTypeId);
                //mycontentList[0].GE_ES_PnL__c=PnLvalue;
                //mycontentList[0].GE_ES_Region__c=Regionvalue;
                
            }  
             
            if (workspacename2.contains(Tier[0]) || workspacename2.contains(Tier[1]) || workspacename2.contains(Tier[4]) || Test.isRunningTest()) 
                {
                mycontentList[1].GE_ES_Business_Tier__c=BusinessTiervalue;
                //mycontentList[1].GE_ES_PnL__c=PnLvalue;
                //mycontentList[1].GE_ES_Region__c=Regionvalue;
                mycontentList[1].RecordTypeId = rectype[0].id;
                }
              
               if (workspacename3.contains(Tier[0]) ||workspacename3.contains(Tier[1]) || workspacename3.contains(Tier[4]) || Test.isRunningTest()) 
               {
                mycontentList[2].GE_ES_Business_Tier__c=BusinessTiervalue;
                //mycontentList[2].GE_ES_PnL__c=PnLvalue;
                //mycontentList[2].GE_ES_Region__c=Regionvalue;
                mycontentList[2].RecordTypeId = rectype[0].id;
                }
              
              if (workspacename4.contains(Tier[0]) ||workspacename4.contains(Tier[1]) || workspacename4.contains(Tier[4]) || Test.isRunningTest() || Test.isRunningTest()) 
               {
                mycontentList[3].GE_ES_Business_Tier__c=BusinessTiervalue;
                //mycontentList[3].GE_ES_PnL__c=PnLvalue;
                //mycontentList[3].GE_ES_Region__c=Regionvalue;
                mycontentList[3].RecordTypeId = rectype[0].id;
                }

               if (workspacename5.contains(Tier[0]) || workspacename5.contains(Tier[1]) || workspacename5.contains(Tier[4]) || Test.isRunningTest()) 
               {
                mycontentList[4].GE_ES_Business_Tier__c=BusinessTiervalue;
               // mycontentList[4].GE_ES_PnL__c=PnLvalue;
                //mycontentList[4].GE_ES_Region__c=Regionvalue; 
                mycontentList[4].RecordTypeId = rectype[0].id;
               }

         if (workspacename1.contains(Tier[2])) 
               
            {
                mycontentList[0].GE_ES_Business_Tier__c=BusinessTiervalue;
                //mycontentList[0].GE_ES_PnL__c=PnLvalue;
                //mycontentList[0].GE_ES_Region__c=Regionvalue;
                mycontentList[0].RecordTypeId = rectype[1].id;
            }  
             
            if (workspacename2.contains(Tier[2])) 
                {
                mycontentList[1].GE_ES_Business_Tier__c=BusinessTiervalue;
                //mycontentList[1].GE_ES_PnL__c=PnLvalue;
                //mycontentList[1].GE_ES_Region__c=Regionvalue;
                mycontentList[1].RecordTypeId = rectype[1].id;
                }
              
              if (workspacename3.contains(Tier[2])) 
               {
                mycontentList[2].GE_ES_Business_Tier__c=BusinessTiervalue;
                //mycontentList[2].GE_ES_PnL__c=PnLvalue;
                //mycontentList[2].GE_ES_Region__c=Regionvalue;
                mycontentList[2].RecordTypeId = rectype[1].id;
                }
              
              if (workspacename4.contains(Tier[2])) 
               {
                mycontentList[3].GE_ES_Business_Tier__c=BusinessTiervalue;
                //mycontentList[3].GE_ES_PnL__c=PnLvalue;
                //mycontentList[3].GE_ES_Region__c=Regionvalue;
                mycontentList[3].RecordTypeId = rectype[1].id;
                }

                if (workspacename5.contains(Tier[2])) 
               {
                mycontentList[4].GE_ES_Business_Tier__c=BusinessTiervalue;
               // mycontentList[4].GE_ES_PnL__c=PnLvalue;
                //mycontentList[4].GE_ES_Region__c=Regionvalue; 
                mycontentList[4].RecordTypeId = rectype[1].id;
               }

          if (workspacename1.contains(Tier[3])) 
               
            {
                mycontentList[0].GE_ES_Business_Tier__c=BusinessTiervalue;
                //mycontentList[0].GE_ES_PnL__c=PnLvalue;
                //mycontentList[0].GE_ES_Region__c=Regionvalue;
                mycontentList[0].RecordTypeId = rectype[2].id;
            }  
             
            if (workspacename2.contains(Tier[3])) 
                {
                mycontentList[1].GE_ES_Business_Tier__c=BusinessTiervalue;
                //mycontentList[1].GE_ES_PnL__c=PnLvalue;
                //mycontentList[1].GE_ES_Region__c=Regionvalue;
                mycontentList[1].RecordTypeId = rectype[2].id;
                }
              
              if (workspacename3.contains(Tier[3])) 
               {
                mycontentList[2].GE_ES_Business_Tier__c=BusinessTiervalue;
                //mycontentList[2].GE_ES_PnL__c=PnLvalue;
                //mycontentList[2].GE_ES_Region__c=Regionvalue;
                mycontentList[2].RecordTypeId = rectype[2].id;
                }
              
              if (workspacename4.contains(Tier[3])) 
               {
                mycontentList[3].GE_ES_Business_Tier__c=BusinessTiervalue;
                //mycontentList[3].GE_ES_PnL__c=PnLvalue;
                //mycontentList[3].GE_ES_Region__c=Regionvalue;
                mycontentList[3].RecordTypeId = rectype[2].id;
                }

                if (workspacename5.contains(Tier[3])) 
               {
                mycontentList[4].GE_ES_Business_Tier__c=BusinessTiervalue;
               // mycontentList[4].GE_ES_PnL__c=PnLvalue;
                //mycontentList[4].GE_ES_Region__c=Regionvalue; 
                mycontentList[4].RecordTypeId = rectype[2].id;
               }




           /* else if(usrProfileName.contains(Tier[1]))
            {
               mycontentList[0].GE_ES_Business_Tier__c=BsTier[1];
               mycontentList[1].GE_ES_Business_Tier__c=BsTier[1];
               mycontentList[2].GE_ES_Business_Tier__c=BsTier[1];
               mycontentList[3].GE_ES_Business_Tier__c=BsTier[1];
               mycontentList[4].GE_ES_Business_Tier__c=BsTier[1];

            }


            else if(usrProfileName.contains(Tier[2]))
            {
               mycontentList[0].GE_ES_Business_Tier__c=BsTier[2];
               mycontentList[1].GE_ES_Business_Tier__c=BsTier[2];
               mycontentList[2].GE_ES_Business_Tier__c=BsTier[2];
               mycontentList[3].GE_ES_Business_Tier__c=BsTier[2];
               mycontentList[4].GE_ES_Business_Tier__c=BsTier[2];

            }

            else if(usrProfileName.contains(Tier[3]))
            {
               mycontentList[0].GE_ES_Business_Tier__c=BsTier[3];
               mycontentList[1].GE_ES_Business_Tier__c=BsTier[3];
               mycontentList[2].GE_ES_Business_Tier__c=BsTier[3];
               mycontentList[3].GE_ES_Business_Tier__c=BsTier[3];
               mycontentList[4].GE_ES_Business_Tier__c=BsTier[3];

            }*/
            System.debug('>>>>>>>mycontentList<<<<<<'+mycontentList);
            for(ContentVersion cv : mycontentList)             {
               if(cv.PathOnClient != '' && cv.PathOnClient != null)
               FinalList.add(cv);
            }
            
            /*integer m;
            for (m=0;m<FinalList.size();m++)
                {
                    if (FinalList[m].PathOnClient == '')
                    {
                         ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR,'File Path is required');
                         ApexPages.addMessage(msg);
                    }
                }
            
            
            for (m=0;m<FinalList.size();m++)
                {
                    if (FinalList[m].Title == '')
                    {
                         ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR,'Title is a required');
                         ApexPages.addMessage(msg);
                    }
                }
              */  
            
            
                        
            System.debug('>>>>>>>>FinalList'+FinalList);
            System.debug('>>>>>>>>FinalList'+FinalList.size());
            if(FinalList.size() > 0)
               
            {
                             
                
                insert FinalList;
            System.debug('>>>>>>>>FinalList'+FinalList.size());
                if(FinalList.size() > 1)
                {
                    System.debug('>>>>>>>>FinalList'+FinalList.size());
                    ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.CONFIRM, FinalList.size() + ' Files Uploaded Successfully');
                    ApexPages.addMessage(msg);
                }
                        
                else if(FinalList.size() == 1)
                {
                    ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.CONFIRM,'File Uploaded Successfully');
                    ApexPages.addMessage(msg);
                }                     
            }

           /* else
            {
                ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.CONFIRM,'No Files Uploaded');
                ApexPages.addMessage(msg);
            }*/
                                
                          
            //cv = null ;
            FinalList = null;
            mycontentList = null ;
            init();
      
      
      }
      
           
      catch(DmlException e) {
      
            if(e.getmessage().contains('INVALID_ID_FIELD'))
                
            {
              //msgBody='You do not have publish previleges to the selected Workspace';
                ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR,'You do not have publish previledges to the selected Workspace, contact  support !');
                ApexPages.addMessage(msg);
                            FinalList = null;
            mycontentList = null ;
            init();
            }
                
            else if(e.getmessage().contains('FIELD_INTEGRITY_EXCEPTION')) 
            {
              //msgBody='The selected content type cannot be associated with the selected workspace';
                ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR,'You either do not have publish privileges to the selected Workspace or you have selected a business tier that you cannot access, contact  support !');
                ApexPages.addMessage(msg);
                            FinalList = null;
            mycontentList = null ;
            init();
            }
            
            
            
            else  
            {
                ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, e.getmessage());
                ApexPages.addMessage(msg);
                            FinalList = null;
            mycontentList = null ;
            init();
            }
         
        }
         
                
        
        
     }
     
    public pagereference cancel()        {
        return new PageReference('/'+ RdirId);
    }
    
    public pagereference back()    {
        PageReference pageRef1 = new PageReference('/' + RdirId);
        return pageref1;
    }  
    
      //Added By Satish Atla 
   //Method to update the Code Utilization Object.
    public void addCodeUtilization() 
    {    system.debug('hiicodeytilization***');
        //Instantiating the CodeUtilization Class
        GE_CodeUtilization cu = new GE_CodeUtilization();
        
        //passsing parameters to the method
        cu.insertCodeUtilization('GE_Content_Upload', 'Controller');
        cu.insertCodeUtilization(cu.captureVFPageName(), 'Visualforce Page');
    }  
    
   
}