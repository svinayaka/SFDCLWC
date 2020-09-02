public class SdDataTableController {    
    @AuraEnabled 
    public static List <FX5__Price_Book_Item__c> fetchPriceBookItem(id jobId) {
        
        FX5__Job__c jobObj= [Select id,FX5__Price_Book__c,SD_Product_Line__c From FX5__Job__c where id=: jobId];
        id pbookId= jobObj.FX5__Price_Book__c;
        string jobPlvalue= jobObj.SD_Product_Line__c;
        
        List<FX5__Price_Book_Item__c> PBItemlist = [SELECT Id,SD_PBI_Tier_4__c,SD_PBI_Tier_5__c,SD_PBI_Tier_6__c,SD_PBI_Tier_7__c,Name,FX5__Catalog_Description__c ,FX5__Catalog_Item__c,FX5__Discount_Percent__c   from FX5__Price_Book_Item__c where FX5__Price_Book__c=: pbookId 
                                                    AND (SD_PBI_Tier_3__c  =: jobPlvalue AND FX5__Ticket_Item_Record_Type__c != 'Labor') ORDER By Name];
        
        return PBItemlist;
    }
    
    // Modified By / On : Vijaya Murukutla /04.Oct.2019 , To set visibilities on fundamnetal and Qualification buttons on Job Lighnting page
  /*  
    public static FX5__Job__c getJobData(Id jobID){
        FX5__Job__c objJobRecord = [Select id,SD_Fundamentals_Added__c,SD_Fundamentals_To_Be_Added__c,SD_Job_Items_Added__c
                                    From FX5__Job__c  where id= :jobID];   
        return objJobRecord;
    }
   */
    public  static void UpdateBooleans(Id jobid, boolean value)
    {
     FX5__Job__c jobobj= [Select id,SD_Fundamentals_Added__c,SD_Fundamentals_To_Be_Added__c,SD_Job_Items_Added__c
     From FX5__Job__c  where id= :jobid];   
       if(value == true)
       {
       jobobj.SD_Job_Items_Added__c= value;
       jobobj.SD_Fundamentals_To_Be_Added__c= True;
       }
       
       else{
       
       jobobj.SD_Fundamentals_To_Be_Added__c= False;
       jobobj.SD_Fundamentals_Added__c= True;
       }
       
       Update jobobj;
       
    }
        
    @AuraEnabled    
    public static void UpdatepbookitmList(String pbookItemList,id jobId){
        
        List<SDJob_Items__c> lstJobItemsNew = new List<SDJob_Items__c>();
        List<FX5__Price_Book_Item__c> pbiList = (List<FX5__Price_Book_Item__c>)System.JSON.deserializeStrict(pbookItemList,List<FX5__Price_Book_Item__c>.class);
        set<ID> setPbookItemIds = new set<ID>();
        for(FX5__Price_Book_Item__c objPbookItem : pbiList){
                setPbookItemIds.add(objPbookItem.ID);
        }       
        // Declaration
        List<SDJob_Items__c> jobItemList= New List<SDJob_Items__c>();
        List<SDJob_Items__c> lstJobItemsExisted = [SELECT ID,NAME,SDPrice_Book_Item__c,SD_Job__c FROM SDJob_Items__c 
                                  WHERE SDPrice_Book_Item__c IN:setPbookItemIds AND SD_Job__c=:jobId];
        Set<ID> setJobItemsExisted = new Set<ID>();
        for(SDJob_Items__c objJI:lstJobItemsExisted ){
            setJobItemsExisted.add(objJI.SDPrice_Book_Item__c);
        }
        System.debug('setJobItemsExisted---> ' + setJobItemsExisted);
        System.debug('pbiList---> ' + pbiList);

        for(FX5__Price_Book_Item__c objPBI: pbiList){
            System.debug('IFLogic---> ' + setJobItemsExisted.Contains(objPBI.ID));
            if(!setJobItemsExisted.Contains(objPBI.ID)){
            System.debug('Eneter in to IF Logic---> ' + setJobItemsExisted.Contains(objPBI.ID));    
                SDJob_Items__c objNewJobItem1 = new SDJob_Items__c();
                objNewJobItem1.SD_Job__c = jobId;
                objNewJobItem1.SDPrice_Book_Item__c = objPBI.ID;
                System.debug('Price Book Item ID---> ' + objNewJobItem1.SDPrice_Book_Item__c);
                lstJobItemsNew.add(objNewJobItem1);
                System.debug('Insert Job Items List---> ' + lstJobItemsNew);
            }
        }
        Insert lstJobItemsNew;
        UpdateBooleans(jobId,true);
    }       
        
   /*     
        system.debug('JollypbookItemList'+pbookItemList);
        // List<String> pbiList = (List<String>)System.JSON.deserialize(pbookItemList,List<String>.class);
        for(FX5__Price_Book_Item__c pbi:pbiList)
        {
            SDJob_Items__c sdobj= new SDJob_Items__c();
            // sdobj.Name= pbi.Name;
            sdobj.SDPrice_Book_Item__c= pbi.id;
            sdobj.SD_Job__c= jobId;
            jobItemList.add(sdobj);
        }
        Insert jobItemList;
        UpdateBooleans(jobId,true);
    }  */
   
    @AuraEnabled  
    Public static void addqualificationItem(id currentjobId )
    { 
        Set<id> clitemidSet= New Set<id>();
         List<id> existingqualList = new List<id>();
         List<SD_Item_Qualification__c> itemQualificationList = new List<SD_Item_Qualification__c>();
         List<FX5__Qualification_Requirement__c> existingFQRList= new List<FX5__Qualification_Requirement__c>();
         list<id>delqid= new list<id>();
         Set<id> QluniqueSet= new Set<id>();
         existingFQRList= [Select id,FX5__Job__c,SD_Type__c,FX5__Qualification__c from  FX5__Qualification_Requirement__c where FX5__Job__c=: currentjobId AND SD_Type__c ='Fundamental'];
         
        for ( FX5__Qualification_Requirement__c qr : existingFQRList)
         {
             existingqualList.add(qr.FX5__Qualification__c);
         }

        List<FX5__Qualification_Requirement__c> qrList= new List<FX5__Qualification_Requirement__c>();
        List<SDJob_Items__c>  jobItemList= [Select id,Catalog_Item__c,SD_Job__c from SDJob_Items__c where SD_Job__c =: currentjobId ];
        system.debug('+++++++ListofJobItem'+jobItemList);
        
        for (SDJob_Items__c sd:jobItemList)
        {
            clitemidSet.add(sd.Catalog_Item__c);
        }
        
        itemQualificationList= [Select id,SD_Qualification__c from SD_Item_Qualification__c 
                                where SD_Catalog_Item__r.id IN: clitemidSet AND SD_Qualification__r.SD_Qualification_Type__c='Fundamental'] ;
        System.debug('+++++itemQualificationList'+itemQualificationList);  
      
         for(SD_Item_Qualification__c IQ:itemQualificationList)
         {
           QluniqueSet.add(IQ.SD_Qualification__c);  
         }
        
        List<FX5__Qualification__c> uniqueQualificationList= [Select id,SD_Active__c From FX5__Qualification__c where id IN:QluniqueSet  AND SD_Active__c = True];
        System.debug('+++++QluniqueSet'+QluniqueSet);
        
        
        for(id qlid : existingqualList)
            {
              if(!QluniqueSet.contains(qlid))
                {
                   delqid.add(qlid);
                }
            }
            
            system.debug('jollyto delquallist++++++'+delqid);
            system.debug('jollyto existingqualList++++++'+existingqualList);
            system.debug('jollyto QluniqueSet++++++'+QluniqueSet);
        
         if (delqid.size()>0)
         {
        List<FX5__Qualification_Requirement__c>QRdeletelist=[Select id,FX5__Job__c from FX5__Qualification_Requirement__c  where FX5__Qualification__c IN :delqid AND FX5__Job__c=: currentjobId ];
          
          delete QRdeletelist;
          
          
          }

        for(FX5__Qualification__c ql: uniqueQualificationList)
        {
            if (!existingqualList.contains(ql.id) )
            {
               FX5__Qualification_Requirement__c qr = new FX5__Qualification_Requirement__c();
                qr.FX5__Qualification__c= ql.id;
                qr.SD_Type__c='Fundamental';
                qr.FX5__Required__c = False; 
                qr.FX5__Job__c= currentjobId;
                qrList.add(qr); 
            }
        }
        Insert(qrList);
        system.debug('+++++qrList'+qrList);
        UpdateBooleans(currentjobId,false);
           
        
    }    
    @AuraEnabled
    public static List <FX5__Qualification__c> fetchQualification(id currentjobId) {
        List<FX5__Qualification__c> qList= new List<FX5__Qualification__c>();
        List<SD_Item_Qualification__c> itemQualificationList = new List<SD_Item_Qualification__c>();
        Set<id> clitemidSet= New Set<id>();
        Set<id> qIdSet= New Set<id>();
        List<SDJob_Items__c>  jobItemList= [Select id,Catalog_Item__c,SD_Job__c from SDJob_Items__c where SD_Job__c =: currentjobId ];
       
        for (SDJob_Items__c sd:jobItemList)
        {
            clitemidSet.add(sd.Catalog_Item__c);
        }
        
        itemQualificationList= [Select id,SD_Qualification__c from SD_Item_Qualification__c 
                                where SD_Catalog_Item__r.id IN: clitemidSet ];
        
        
        for(SD_Item_Qualification__c iqRecord : itemQualificationList)
        {
            qIdSet.add(iqRecord.SD_Qualification__c);
        }
        qList =[Select id,Name,SD_Qualification_Type__c,FX5__Abbreviation__c,SD_Qualification_Id__c,SD_Active__c from FX5__Qualification__c where id IN:qIdSet AND ((SD_Qualification_Type__c='Type 1' OR SD_Qualification_Type__c='Type 2')AND SD_Active__c= True)] ;
        return qList;
        
    }
    
    
     
    @AuraEnabled
    
    public static string updateqReqList(String qualificationList,id jobId) 
    { 
        string statusmessage ;
        List<FX5__Qualification_Requirement__c> qrList= new List<FX5__Qualification_Requirement__c>();
        List<FX5__Qualification_Requirement__c> existingQRList= new List<FX5__Qualification_Requirement__c>();
        List<FX5__Qualification__c> qList= new List<FX5__Qualification__c>();
        List<id> existingqualList = new List<id>();    
         existingQRList= [Select id,FX5__Job__c,FX5__Qualification__c from  FX5__Qualification_Requirement__c where FX5__Job__c=: jobId];

       
         for ( FX5__Qualification_Requirement__c qr : existingQRList)
         {
             existingqualList.add(qr.FX5__Qualification__c);
         }
              system.debug('++++++existingqualList'+existingqualList);
        
        qList = (List<FX5__Qualification__c>)System.JSON.deserializeStrict(qualificationList,List<FX5__Qualification__c>.class);
        System.debug('+++++++++selectedqlList'+qList);
        
        for(FX5__Qualification__c qlrecord:qList)
        {
            if (!existingqualList.contains(qlrecord.id))
            {

            FX5__Qualification_Requirement__c qrobj= new FX5__Qualification_Requirement__c();
            
           qrobj.FX5__Qualification__c= qlrecord.id;
          
            qrobj.FX5__Job__c= jobId;
            qrobj.SD_Type__c=qlrecord.SD_Qualification_Type__c;
            qrobj.FX5__Required__c = False; 
            qrList.add(qrobj);
           
             
            statusmessage='Qualification Requiremnts Added Successfully';
                
            }
            
            else{
                
                statusmessage ='Cannot add requirement qualification as you have selected an existing qualification';
              
            }
             
             
          
        }

        Insert qrList;
        return statusmessage;
      
    }
    // Get Job Details    
     // Begin : Added By vijaya on 09.10.2019  
    @AuraEnabled
    public static  FX5__Job__c fetchJobData(Id jobId){
            return [SELECT ID,SD_Job_Items_Added__c,SD_Fundamentals_Added__c,SD_Fundamentals_To_Be_Added__c FROM FX5__Job__c WHERE ID=:jobId];
    }
    
     // End : Added By vijaya on 09.10.2019  
    
}