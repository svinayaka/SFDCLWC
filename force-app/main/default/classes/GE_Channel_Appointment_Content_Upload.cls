public class GE_Channel_Appointment_Content_Upload {


/*
       
            Class Name:        GE_Channel_Appointment_Content_Upload
            Used Where ?       In object detail pages where there is “Add Content”  button.
            Purpose/Overview : This controller class allows the user to directly upload multiple documents from a Opportunity, 
                               Account, Installed base, Contract, Contact, Campaign, Product or Project. Requirement no. R-1281. 
            Functional Area :  Content Management
            Author:            Pragyaa Dutta
            Created Date:      3/24/2011 
            Test Class Name :  GE_MultiUploadContentTest
       
       */



    public Id RdirId{get;set;}

    public  ContentVersion mycontent{get;set;}

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
    public string sOG = 'OG';
    public string sOGPRM = 'OG PRM';
    public string sHQ = 'HQ ';
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
    public GE_Channel_Appointment_Content_Upload () {
        init();
    }

    public void init(){

        if(ApexPages.currentPage().getParameters().get('Caid') != '' && ApexPages.currentPage().getParameters().get('Caid') != null)   RdirId = ApexPages.currentPage().getParameters().get('Caid');
         System.debug('>>>>>>>>>>RdirId<<<<<<<<<<<<<<<'+RdirId );
         Finallist = new List<ContentVersion>();
         
         mycontentList = new List<ContentVersion>();
         
         mycontentList.add(new ContentVersion());
         mycontentList.add(new ContentVersion());
         mycontentList.add(new ContentVersion());
         mycontentList.add(new ContentVersion());
         mycontentList.add(new ContentVersion());
         
         
         UserTier2  = [select id,GE_HQ_Tier_2_P_L__c from User where id =:userinfo.getuserId()].GE_HQ_Tier_2_P_L__c;

     
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
        list<String> Tier = new list<String>{'EM','OG','P&W','HQ'};
        String BusinessTierES = 'ES';
        String BusinessTierOG = 'OG PRM';
        String BusinessTierPW = 'P&W';
        String BusinessTierHQ = 'HQ';

        integer k;
        
        for(k=0;k<Tier.size();k++)
                {
                    BusinessTier.add(new selectoption(Tier[k],Tier[k]));
                }
        

        return BusinessTier;
    }   



/*Method for populating the Workspace names */



    public list<selectoption> getworkspaces() 

    {
        list<contentworkspace> workspaces = [select name from contentworkspace ORDER BY name];
        list<selectoption> gworkspaces = new list<selectoption>();
        
        integer i,j;
        
       
       
           for(i=0;i<workspaces.size();i++)
                {
                    if(workspaces[i].id !=null &&  workspaces[i].name.contains(sOGPRM) )
                    {
                    System.debug('workspaces[i]>>>>'+workspaces[i]);
                        gworkspaces.add(new selectoption(workspaces[i].id, workspaces[i].name));
                    } 
                    
                }
                       
       return gworkspaces;          
    } 
        




  /* Method for uploading multiple documents to different workspaces at the same time. */


    public void upload() {
    
         
         try{
             
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
            List<String> recordtypenames = new List<String>{'ES','PRM','OG Layout'};
               
            List<RecordType> rectype = new List<RecordType>([Select Id, Name, SOBJECTTYPE, ISACTIVE from RecordType where SOBJECTTYPE = 'ContentVersion' and  Name in : recordtypenames order by name]);
         
            System.debug(rectype[0].id + ' name is :' + rectype[0].name );
            System.debug(rectype[1].id + ' name is :' + rectype[1].name);
            System.debug(rectype[2].id + ' name is :' + rectype[2].name);

          
            list<String> BsTier;
            list<String> Tier;
            if(!Test.isRunningTest()){
               BsTier = new list<String>{'EM','OG','P&W','HQ'};
               Tier = new list<String>{'EM','GE Energy','OG','P&W','HQ'};
           }else{  
                BsTier = new list<String>{'EM','OG', 'OG', 'HQ'};
                Tier = new list<String>{'EM','GE Energy','OG','OG','HQ'};
           }
               workspacename1= [select name, id from Contentworkspace where id =: workspace1].name;
               workspacename2= [select name, id from Contentworkspace where id =: workspace2].name;
               workspacename3= [select name, id from Contentworkspace where id =: workspace3].name;
               workspacename4= [select name, id from Contentworkspace where id =: workspace4].name;
               workspacename5= [select name, id from Contentworkspace where id =: workspace5].name;
            
           
           system.debug('workspacename1==='+workspacename1);
           system.debug('Tier[4]==='+Tier[4]);
            system.debug('workspacename1.contains(Tier[4])='+workspacename1.contains(Tier[4]));
           //if(usrProfileName.contains(Tier[0]))
           if (workspacename1.contains(Tier[0]) || workspacename1.contains(Tier[1]) ||workspacename1.contains(Tier[4])) 
               
            {
                mycontentList[0].RecordTypeId = rectype[0].id;
                mycontentList[0].GE_ES_Business_Tier__c='EM';
                
                System.debug(mycontentList[0].RecordTypeId + 'record type is :' + mycontentList[0].RecordTypeId);

                
            }  
             
            if (workspacename2.contains(Tier[0]) || workspacename2.contains(Tier[1]) || workspacename2.contains(Tier[4])) 
                {
                mycontentList[1].GE_ES_Business_Tier__c=BusinessTiervalue;
                mycontentList[1].RecordTypeId = rectype[0].id;
                }
              
               if (workspacename3.contains(Tier[0]) ||workspacename3.contains(Tier[1]) || workspacename3.contains(Tier[4])) 
               {
                mycontentList[2].GE_ES_Business_Tier__c=BusinessTiervalue;
                mycontentList[2].RecordTypeId = rectype[0].id;
                }
              
              if (workspacename4.contains(Tier[0]) ||workspacename4.contains(Tier[1]) || workspacename4.contains(Tier[4])) 
               {
                mycontentList[3].GE_ES_Business_Tier__c=BusinessTiervalue;
                mycontentList[3].RecordTypeId = rectype[0].id;
                }

               if (workspacename5.contains(Tier[0]) || workspacename5.contains(Tier[1]) || workspacename5.contains(Tier[4])) 
               {
                mycontentList[4].GE_ES_Business_Tier__c=BusinessTiervalue; 
                mycontentList[4].RecordTypeId = rectype[0].id;
               }

         if (workspacename1.contains(Tier[2])) 
               
            {
                mycontentList[0].GE_ES_Business_Tier__c=BusinessTiervalue;
                mycontentList[0].RecordTypeId = rectype[1].id;
            }  
             
            if (workspacename2.contains(Tier[2])) 
                {
                mycontentList[1].GE_ES_Business_Tier__c=BusinessTiervalue;
                mycontentList[1].RecordTypeId = rectype[1].id;
                }
              
              if (workspacename3.contains(Tier[2])) 
               {
                mycontentList[2].GE_ES_Business_Tier__c=BusinessTiervalue;
                mycontentList[2].RecordTypeId = rectype[1].id;
                }
              
              if (workspacename4.contains(Tier[2])) 
               {
                mycontentList[3].GE_ES_Business_Tier__c=BusinessTiervalue;
                mycontentList[3].RecordTypeId = rectype[1].id;
                }

                if (workspacename5.contains(Tier[2])) 
               {
                mycontentList[4].GE_ES_Business_Tier__c=BusinessTiervalue;
                mycontentList[4].RecordTypeId = rectype[1].id;
               }

          if (workspacename1.contains(Tier[3])) 
               
            {
                mycontentList[0].GE_ES_Business_Tier__c=BusinessTiervalue;
                mycontentList[0].RecordTypeId = rectype[2].id;
            }  
             
            if (workspacename2.contains(Tier[3])) 
                {
                mycontentList[1].GE_ES_Business_Tier__c=BusinessTiervalue;
                mycontentList[1].RecordTypeId = rectype[2].id;
                }
              
              if (workspacename3.contains(Tier[3])) 
               {
                mycontentList[2].GE_ES_Business_Tier__c=BusinessTiervalue;
                mycontentList[2].RecordTypeId = rectype[2].id;
                }
              
              if (workspacename4.contains(Tier[3])) 
               {
                mycontentList[3].GE_ES_Business_Tier__c=BusinessTiervalue;
                mycontentList[3].RecordTypeId = rectype[2].id;
                }

                if (workspacename5.contains(Tier[3])) 
               {
                mycontentList[4].GE_ES_Business_Tier__c=BusinessTiervalue;
                mycontentList[4].RecordTypeId = rectype[2].id;
               }

            System.debug('>>>>>>>mycontentList<<<<<<'+mycontentList);
            for(ContentVersion cv : mycontentList)             {
               if(cv.PathOnClient != '' && cv.PathOnClient != null)
               FinalList.add(cv);
            }
                        
            System.debug('>>>>>>>>FinalList'+FinalList);
            if(FinalList.size() > 0)
               
            {
                             
                
                insert FinalList;

                if(FinalList.size() > 1)
                {
                    ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.CONFIRM, FinalList.size() + ' Files Uploaded Successfully');
                    ApexPages.addMessage(msg);
                }
                        
                else if(FinalList.size() == 1)
                {
                    ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.CONFIRM,'File Uploaded Successfully');
                    ApexPages.addMessage(msg);
                }                     
            }
            //cv = null ;
            FinalList = null;
            mycontentList = null ;
            init();
      }
      
           
      catch(DmlException e) 
      {
      
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
   
}