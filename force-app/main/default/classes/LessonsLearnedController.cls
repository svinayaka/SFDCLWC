public with sharing class LessonsLearnedController{
public string workOrderId{get;set;}

public LessonsLearnedController(){
    workOrderId = ApexPages.currentPage().getParameters().get('workOrderId');
    
}

@AuraEnabled
    public static List<GE_OG_Lessons_Learnt__c> getLessonLearnedRecords(string field,string productCategory,String prodGroup,String jobType,String workOrder,String accName,String lessonLearned,
                                                                        String prodRegion,String Status,String country,String fsProject,String owner,String prodId,string installedProd,string productPart,string rigVessel,string well,String workOrderRecId){
        
        List<GE_OG_Lessons_Learnt__c> lessonLearnedList = new List<GE_OG_Lessons_Learnt__c>();
        String QRYSTR = 'SELECT GE_OG_Account__r.Name,GE_SS_Criticality__c,GE_OG_Country__c,GE_OG_Additional_Comments__c,GE_SS_Change_Implemented__c,GE_SS_Implemented_Date__c,GE_OG_Lesson_Description__c,GE_OG_Problem_Cause__c,GE_OG_Installed_Product__c,GE_OG_Job_Type__c,GE_OG_Location__r.Name,GE_OG_Project_Region__r.Name,GE_OG_Subject__c,GE_OG_Work_Order__r.Name,GE_SS_FS_Project__r.Name,GE_SS_Product_Category__c,GE_SS_Product__c,Id,Lessons_Learned_Type__c,Name,OwnerId,Owner.Name,Product_Group__c,Status__c,CreatedDate,GE_OG_Installed_Product__r.Name,GE_SS_Product__r.Name,GE_OG_Rig_Name__r.Name,GE_OG_Well__r.Name FROM GE_OG_Lessons_Learnt__c ';
        String strQuery;
        strQuery = QRYSTR;
        try{
            if(string.isNotBlank(field)){
                    strQuery+='where GE_OG_Location__r.Name =:field';
            }
            if(string.isNotBlank(productCategory) && productCategory != 'None'){
              if(!strQuery.contains('where')){
                  strQuery+= 'where GE_SS_Product_Category__c  =:productCategory';
              }
              else{
                  strQuery += ' AND GE_SS_Product_Category__c =:productCategory';
              }
            }
            if(string.isNotBlank(prodGroup) && prodGroup != 'None'){
              if(!strQuery.contains('where')){
                  strQuery+= 'where Product_Group__c =:prodGroup';
              }
              else{
                  strQuery += ' AND Product_Group__c =:prodGroup';
              }
            }
            if(string.isNotBlank(jobType) && jobType != 'None'){
              if(!strQuery.contains('where')){
                  strQuery+= 'where GE_OG_Job_Type__c =:jobType';
              }
              else{
                  strQuery += ' AND GE_OG_Job_Type__c =:jobType';
              }
            }
            if(string.isNotBlank(workOrder)){
              if(!strQuery.contains('where')){
                  strQuery+= 'where GE_OG_Work_Order__r.Name =:workOrder';
              }
              else{
                  strQuery += ' AND GE_OG_Work_Order__r.Name =:workOrder';
              }
            }
            if(string.isNotBlank(accName)){
              if(!strQuery.contains('where')){
                  strQuery+= 'where GE_OG_Account__r.Name =:accName';
              }
              else{
                  strQuery += ' AND GE_OG_Account__r.Name =:accName';
              }
            }
            if(string.isNotBlank(lessonLearned) && lessonLearned != 'None'){
              if(!strQuery.contains('where')){
                  strQuery+= 'where Lessons_Learned_Type__c =:lessonLearned';
              }
              else{
                  strQuery += ' AND Lessons_Learned_Type__c =:lessonLearned';
              }
            }
            if(string.isNotBlank(prodRegion)){
              if(!strQuery.contains('where')){
                  strQuery+= 'where GE_OG_Project_Region__r.Name =:prodRegion';
              }
              else{
                  strQuery += ' AND GE_OG_Project_Region__r.Name =:prodRegion';
              }
            }
            if(string.isNotBlank(Status) && Status != 'None'){
              if(!strQuery.contains('where')){
                  strQuery+= 'where Status__c =:Status';
              }
              else{
                  strQuery += ' AND Status__c =:Status';
              }
            }
            if(string.isNotBlank(fsProject)){
              if(!strQuery.contains('where')){
                  strQuery+= 'where GE_SS_FS_Project__r.Name =:fsProject';
              }
              else{
                  strQuery += ' AND GE_SS_FS_Project__r.Name =:fsProject';
              }
            }
            if(string.isNotBlank(owner)){
              if(!strQuery.contains('where')){
                  strQuery+= 'where Owner.Name =:owner';
              }
              else{
                  strQuery += ' AND Owner.Name =:owner';
              }
            }
            if(string.isNotBlank(prodId)){
              if(!strQuery.contains('where')){
                  strQuery+= 'where GE_SS_Product__c =:prodId';
              }
              else{
                  strQuery += ' AND GE_SS_Product__c =:prodId';
              }
            }
            if(string.isNotBlank(country) && country != 'None'){
              if(!strQuery.contains('where')){
                  strQuery+= 'where GE_OG_Country__c =:country';
              }
              else{
                  strQuery += ' AND GE_OG_Country__c =:country';
              }
            }
            if(string.isNotBlank(installedProd)){
              if(!strQuery.contains('where')){
                  strQuery+= 'where GE_OG_Installed_Product__r.Name =:installedProd';
              }
              else{
                  strQuery += ' AND GE_OG_Installed_Product__r.Name =:installedProd';
              }
            }
            if(string.isNotBlank(productPart)){
              if(!strQuery.contains('where')){
                  strQuery+= 'where GE_SS_Product__r.Name =:productPart';
              }
              else{
                  strQuery += ' AND GE_SS_Product__r.Name =:productPart';
              }
            }
            if(string.isNotBlank(rigVessel)){
              if(!strQuery.contains('where')){
                  strQuery+= 'where GE_OG_Rig_Name__r.Name =:rigVessel';
              }
              else{
                  strQuery += ' AND GE_OG_Rig_Name__r.Name =:rigVessel';
              }
            }
            if(string.isNotBlank(well)){
              if(!strQuery.contains('where')){
                  strQuery+= 'where GE_OG_Well__r.Name =:well';
              }
              else{
                  strQuery += ' AND GE_OG_Well__r.Name =:well';
              }
            }
            if(string.isNotBlank(workOrderRecId)){
                List<Case_LessonsLearned_Records__c> recordList = new List<Case_LessonsLearned_Records__c>();
                set<Id> insertedRecId = new set<Id>();
                recordList = [Select id,Lessons_Learned__c from Case_LessonsLearned_Records__c where Lessons_Learned__c != NULL LIMIT 10000];
                for(Case_LessonsLearned_Records__c caseLessonLearned:recordList){
                             insertedRecId.add(caseLessonLearned.Lessons_Learned__c);
                                          
                }
                if(!strQuery.contains('where')){
                  strQuery+= 'where Id NOT IN:insertedRecId';
              }
              else{
                  strQuery += ' AND Id NOT IN:insertedRecId';
              }
            }
            system.debug('----strQuery------'+strQuery);
            strQuery +=' LIMIT 200';
             lessonLearnedList = Database.query(strQuery); 
             system.debug('-lessonLearnedList-----'+lessonLearnedList);
           /*  if(string.isNotBlank(workOrderRecId)){
             
                 Map<Id,GE_OG_Lessons_Learnt__c> lessonLearnedMap = new Map<Id,GE_OG_Lessons_Learnt__c>();
                 List<Case_LessonsLearned_Records__c> recordList = new List<Case_LessonsLearned_Records__c>();
                 for(GE_OG_Lessons_Learnt__c lessonLearnedRec: lessonLearnedList){
                     lessonLearnedMap.put(lessonLearnedRec.id,lessonLearnedRec);             
                 }
                 recordList = [Select id,Lessons_Learned__c from Case_LessonsLearned_Records__c where Lessons_Learned__c IN:lessonLearnedMap.Keyset()];
                 //system.debug('-caseList-----'+caseList);
                 List<GE_OG_Lessons_Learnt__c> removeList = new List<GE_OG_Lessons_Learnt__c>();
                 for(Case_LessonsLearned_Records__c caseLessonLearned:recordList){
                     lessonLearnedMap.remove(caseLessonLearned.Lessons_Learned__c);
                                  
                 }
                 return lessonLearnedMap.values();
             }
             else{*/
                 return lessonLearnedList;
            // }
         }
         catch(Exception e) {
             throw new AuraHandledException(e.getMessage());
             
         }
    }

     @AuraEnabled
        public static List<Map<String, String>> getCountry(){
        List<Map<String, String>> countryValues= new List<Map<String, String>>();
        try
        {        
            Schema.DescribeFieldResult fieldResult = GE_OG_Lessons_Learnt__c.GE_OG_Country__c.getDescribe();
            List<Schema.PicklistEntry> plEntry = fieldResult.getPicklistValues();
            countryValues.add(new Map<String, String>{'value' => 'None', 'label' => 'None'});
            for(Schema.PicklistEntry ple : plEntry){
                     
                    countryValues.add(new Map<String, String>{'value' => ple.getLabel(), 'label' => ple.getLabel()});         
            }        
        }
        catch(Exception ex)
        {
            system.debug('------Error occured--'+ex.getMessage());
        }
        return countryValues;
    }
    @AuraEnabled
        public static List<Map<String, String>> getJobType(){
        List<Map<String, String>> jobTypeValues= new List<Map<String, String>>();
        try
        {        
            Schema.DescribeFieldResult fieldResult = GE_OG_Lessons_Learnt__c.GE_OG_Job_Type__c.getDescribe();
            List<Schema.PicklistEntry> plEntry = fieldResult.getPicklistValues();
            jobTypeValues.add(new Map<String, String>{'value' => 'None', 'label' => 'None'});
            for(Schema.PicklistEntry ple : plEntry){
                     
                    jobTypeValues.add(new Map<String, String>{'value' => ple.getLabel(), 'label' => ple.getLabel()});         
            }        
        }
        catch(Exception ex)
        {
            system.debug('------Error occured--'+ex.getMessage());
        }
        return jobTypeValues;
    }

@AuraEnabled
        public static List<Map<String, String>> getLessonLearnedType(){
        List<Map<String, String>> lessonLearnedValues= new List<Map<String, String>>();
        try
        {        
            Schema.DescribeFieldResult fieldResult = GE_OG_Lessons_Learnt__c.Lessons_Learned_Type__c.getDescribe();
            List<Schema.PicklistEntry> plEntry = fieldResult.getPicklistValues();
            lessonLearnedValues.add(new Map<String, String>{'value' => 'None', 'label' => 'None'});
            for(Schema.PicklistEntry ple : plEntry){
                     
                    lessonLearnedValues.add(new Map<String, String>{'value' => ple.getLabel(), 'label' => ple.getLabel()});         
            }        
        }
        catch(Exception ex)
        {
            system.debug('------Error occured--'+ex.getMessage());
        }
        return lessonLearnedValues;
    }

@AuraEnabled
        public static List<Map<String, String>> getProductCategory(){
        List<Map<String, String>> productCategoryValues= new List<Map<String, String>>();
        try
        {        
            Schema.DescribeFieldResult fieldResult = GE_OG_Lessons_Learnt__c.GE_SS_Product_Category__c.getDescribe();
            List<Schema.PicklistEntry> plEntry = fieldResult.getPicklistValues();
            productCategoryValues.add(new Map<String, String>{'value' => 'None', 'label' => 'None'});
            for(Schema.PicklistEntry ple : plEntry){
                     
                    productCategoryValues.add(new Map<String, String>{'value' => ple.getLabel(), 'label' => ple.getLabel()});         
            }        
        }
        catch(Exception ex)
        {
            system.debug('------Error occured--'+ex.getMessage());
        }
        return productCategoryValues;
    }

@AuraEnabled
        public static List<Map<String, String>> getProductGroup(){
        List<Map<String, String>> productGroupValues= new List<Map<String, String>>();
        try
        {        
            Schema.DescribeFieldResult fieldResult = GE_OG_Lessons_Learnt__c.Product_Group__c.getDescribe();
            List<Schema.PicklistEntry> plEntry = fieldResult.getPicklistValues();
            productGroupValues.add(new Map<String, String>{'value' => 'None', 'label' => 'None'});
            for(Schema.PicklistEntry ple : plEntry){
                     
                    productGroupValues.add(new Map<String, String>{'value' => ple.getLabel(), 'label' => ple.getLabel()});         
            }        
        }
        catch(Exception ex)
        {
            system.debug('------Error occured--'+ex.getMessage());
        }
        return productGroupValues;
    }

@AuraEnabled
        public static List<Map<String, String>> getStatus(){
        List<Map<String, String>> statusValues= new List<Map<String, String>>();
        try
        {        
            Schema.DescribeFieldResult fieldResult = GE_OG_Lessons_Learnt__c.Status__c.getDescribe();
            List<Schema.PicklistEntry> plEntry = fieldResult.getPicklistValues();
            statusValues.add(new Map<String, String>{'value' => 'None', 'label' => 'None'});
            for(Schema.PicklistEntry ple : plEntry){
                     
                    statusValues.add(new Map<String, String>{'value' => ple.getLabel(), 'label' => ple.getLabel()});         
            }        
        }
        catch(Exception ex)
        {
            system.debug('------Error occured--'+ex.getMessage());
        }
        return statusValues;
    }
    @AuraEnabled
        public static Boolean updateLessonLearned(List<GE_OG_Lessons_Learnt__c> editLessonLearned){
        try{
            system.debug('---editLessonLearned--'+editLessonLearned);
            update editLessonLearned;
            return true;
        }
        catch(Exception ex){
            throw new AuraHandledException(ex.getMessage());
            //return false;
        }
        
        
    }
    @AuraEnabled
        public static Map<String,String> getFieldSet(String fieldSetType){
        String fieldSetName;
        String ObjectName;
        System.debug('--fieldSetType ---'+fieldSetType );
        if(fieldSetType == 'SS_NPT'){
            fieldSetName = 'NPT_FieldSet_Lessons_Learned';
            ObjectName = 'Case';
        }
        else if(fieldSetType == 'SIR - CaM'){
            fieldSetName = 'SIR_CaM_fieldSet';
            ObjectName = 'Case';
        }
        else{
            fieldSetName = 'Lesson_Learned_Search';
            ObjectName = 'GE_OG_Lessons_Learnt__c';
        }
        
        
        Map<String,String> filedSetMap = new Map<String,String>();

        Map<String, Schema.SObjectType> GlobalDescribeMap = Schema.getGlobalDescribe(); 
        Schema.SObjectType SObjectTypeObj = GlobalDescribeMap.get(ObjectName);
        Schema.DescribeSObjectResult DescribeSObjectResultObj = SObjectTypeObj.getDescribe();
    
        //system.debug('====>' + DescribeSObjectResultObj.FieldSets.getMap().get(fieldSetName));
    
        Schema.FieldSet fieldSetObj = DescribeSObjectResultObj.FieldSets.getMap().get(fieldSetName);
    
        //List<Schema.FieldSetMember> fieldSetMemberList =  fieldSetObj.getFields();
        system.debug('fieldSetMemberList ====>' + fieldSetObj.getFields());  
        for(Schema.FieldSetMember fieldSetMemberObj : fieldSetObj.getFields())
        {
                system.debug('API Name ====>' + fieldSetMemberObj.getFieldPath()); //api name
                system.debug('Type ====>' + fieldSetMemberObj.getType());   //type - STRING,PICKLIST
                filedSetMap.put(fieldSetMemberObj.getFieldPath(),String.valueOf(fieldSetMemberObj.getType())+';'+fieldSetMemberObj.getLabel());
                
        }    
        return filedSetMap;
        
    }
    @AuraEnabled
    public static List<Case> getCaseRecords(String HSEProduct,String typeOfIssue,String customerEscalation,String workOrderNPT,String SSRegion,String nearMissEvent,String primaryFailure,String nonBHEvent,String recurrence,String CINNumber,
    String type,String lossOfProduction,String accntNameSIRCaM,String projectRegionSIRCaM,String field,String rigVesselName,String wellNumber,String partNo,String lostProdGas,String recType){
        
        List<Case> caseList = new List<Case>();
        String QRYSTR;
        String strQuery;
        strQuery = QRYSTR;
        try{
        system.debug('--recType --'+recType );
        
        List<Case_LessonsLearned_Records__c> recordList = new List<Case_LessonsLearned_Records__c>();
        set<Id> insertedRecId = new set<Id>();
        recordList = [Select id,Case__c from Case_LessonsLearned_Records__c where Case__c != NULL LIMIT 10000];
        for(Case_LessonsLearned_Records__c caseLessonLearned:recordList){
                     insertedRecId.add(caseLessonLearned.Case__c);
                                  
        }
        system.debug('--insertedRecId---'+insertedRecId);
         if(recType == 'SS_NPT'){
                strQuery = 'Select CaseNumber,Subject,Status,Account.Name,Contact.Name,GE_OG_MC_Con_Name__c,Owner.Name,GE_Region__c,GE_OG_EHS_Product_Safety_CIR__c,GE_OG_CIR_Type_of_Issue__c,GE_OG_Customer_Escalation_CIR__c,GE_NPT_Subsea_Services_Regions__c,GE_SS_Work_Order__r.Name,CIN_Number__c,GE_NPT_Near_Miss_Event__c,GE_NPT_Is_it_a_Non_GE_event__c,Reoccurence__c,GE_NPT_Primary_Failure_Classification__c from Case where RecordType.Name =:recType AND id NOT IN:insertedRecId' ;
                if(string.isNotBlank(HSEProduct) && typeOfIssue != 'None'){
                        strQuery+=' AND GE_OG_EHS_Product_Safety_CIR__c =:HSEProduct';
                }
                if(string.isNotBlank(typeOfIssue) && typeOfIssue != 'None'){
                  if(!strQuery.contains('where')){
                      strQuery+= 'where GE_OG_CIR_Type_of_Issue__c=:typeOfIssue';
                  }
                  else{
                      strQuery += ' AND GE_OG_CIR_Type_of_Issue__c=:typeOfIssue';
                  }
                }
                if(string.isNotBlank(customerEscalation) && customerEscalation!= 'None'){
                  if(!strQuery.contains('where')){
                      strQuery+= 'where GE_OG_Customer_Escalation_CIR__c =:customerEscalation';
                  }
                  else{
                      strQuery += ' AND GE_OG_Customer_Escalation_CIR__c =:customerEscalation';
                  }
                }
                if(string.isNotBlank(SSRegion) && SSRegion!= 'None'){
                  if(!strQuery.contains('where')){
                      strQuery+= 'where GE_NPT_Subsea_Services_Regions__c=:SSRegion';
                  }
                  else{
                      strQuery += ' AND GE_NPT_Subsea_Services_Regions__c =:SSRegion';
                  }
                }
                if(string.isNotBlank(workOrderNPT)){
                  if(!strQuery.contains('where')){
                      strQuery+= 'where GE_SS_Work_Order__r.Name =:workOrderNPT';
                  }
                  else{
                      strQuery += ' AND GE_SS_Work_Order__r.Name =:workOrderNPT';
                  }
                }
                if(string.isNotBlank(CINNumber)){
                  if(!strQuery.contains('where')){
                      strQuery+= 'where CIN_Number__c =:CINNumber';
                  }
                  else{
                      strQuery += ' AND CIN_Number__c =:CINNumber';
                  }
                }
                if(string.isNotBlank(nearMissEvent) && nearMissEvent!= 'None'){
                  if(!strQuery.contains('where')){
                      strQuery+= 'where GE_NPT_Near_Miss_Event__c=:nearMissEvent';
                  }
                  else{
                      strQuery += ' AND GE_NPT_Near_Miss_Event__c=:nearMissEvent';
                  }
                }
                
                if(string.isNotBlank(nonBHEvent) && nonBHEvent != 'None'){
                  if(!strQuery.contains('where')){
                      strQuery+= 'where GE_NPT_Is_it_a_Non_GE_event__c =:nonBHEvent';
                  }
                  else{
                      strQuery += ' AND GE_NPT_Is_it_a_Non_GE_event__c =:nonBHEvent';
                  }
                }                
                if(string.isNotBlank(recurrence) && recurrence!= 'None'){
                  if(!strQuery.contains('where')){
                      strQuery+= 'where Reoccurence__c=:recurrence';
                  }
                  else{
                      strQuery += ' AND Reoccurence__c=:recurrence';
                  }
                }
                 
                if(string.isNotBlank(primaryFailure) && primaryFailure!= 'None'){
                  if(!strQuery.contains('where')){
                      strQuery+= 'where GE_NPT_Primary_Failure_Classification__c=:primaryFailure';
                  }
                  else{
                      strQuery += ' AND GE_NPT_Primary_Failure_Classification__c=:primaryFailure';
                  }
                }                
                
            
            }
            else if(recType == 'SIR - CaM'){
            strQuery = 'Select GE_OG_Case_Issue_Type__c,Status,GE_Country__c,Priority,Type,GE_Product_Category__c,GE_Region__c,GE_ES_Sub_Type__c,Subject,SirCam_Aging__c,Lost_Production_Oil__c ,Account.Name,GE_SS_Field__r.Name,GE_SS_Rig_Vessel_Name__r.Name,GE_SS_Well_ID__r.Name,Lost_Production_Gas__c,GE_SS_Project_Region__c from Case where RecordType.Name =:recType AND id NOT IN:insertedRecId';

                if(string.isNotBlank(lossOfProduction)){
                        strQuery+='where Lost_Production_Oil__c =:lossOfProduction';
                }
                if(string.isNotBlank(type) && type!= 'None'){
                  if(!strQuery.contains('where')){
                      strQuery+= 'where Type=:type';
                  }
                  else{
                      strQuery += ' AND Type=:type';
                  }
                }                
               
                if(string.isNotBlank(accntNameSIRCaM)){
                  if(!strQuery.contains('where')){
                      strQuery+= 'where Account.Name =:accntNameSIRCaM';
                  }
                  else{
                      strQuery += ' AND Account.Name =:accntNameSIRCaM';
                  }
                }
                if(string.isNotBlank(field)){
                  if(!strQuery.contains('where')){
                      strQuery+= 'where GE_SS_Field__r.Name =:field';
                  }
                  else{
                      strQuery += ' AND GE_SS_Field__r.Name =:field';
                  }
                }
                if(string.isNotBlank(rigVesselName)){
                  if(!strQuery.contains('where')){
                      strQuery+= 'where GE_SS_Rig_Vessel_Name__r.Name =:rigVesselName';
                  }
                  else{
                      strQuery += ' AND GE_SS_Rig_Vessel_Name__r.Name =:rigVesselName';
                  }
                }
                if(string.isNotBlank(wellNumber)){
                  if(!strQuery.contains('where')){
                      strQuery+= 'where GE_SS_Well_ID__r.Name =:wellNumber';
                  }
                  else{
                      strQuery += ' AND GE_SS_Well_ID__r.Name =:wellNumber';
                  }
                }
                if(string.isNotBlank(lostProdGas)){
                  if(!strQuery.contains('where')){
                      strQuery+= 'where Lost_Production_Gas__c=:lostProdGas';
                  }
                  else{
                      strQuery += ' AND Lost_Production_Gas__c=:lostProdGas';
                  }
                }
                if(string.isNotBlank(projectRegionSIRCaM)){
                  if(!strQuery.contains('where')){
                      strQuery+= 'where GE_SS_Project_Region__c=:projectRegionSIRCaM';
                  }
                  else{
                      strQuery += ' AND GE_SS_Project_Region__c=:projectRegionSIRCaM';
                  }
                }
                
               
            
            }
             system.debug('----strQuery------'+strQuery);
             strQuery +=' LIMIT 200';
             caseList = Database.query(strQuery);
             //system.debug('---caseList----'+caseList[0]);
             
             /*Map<Id,Case> caseRecMap = new Map<Id,Case>();
                 List<Case_LessonsLearned_Records__c> recordList = new List<Case_LessonsLearned_Records__c>();
                 for(Case caseRec: caseList){
                     caseRecMap.put(caseRec.id,caseRec);             
                 }
                 recordList = [Select id,Case__c from Case_LessonsLearned_Records__c where Case__c IN:caseRecMap.Keyset()];
                 //system.debug('-caseList-----'+caseList);
                 
                 for(Case_LessonsLearned_Records__c caseLessonLearned:recordList){
                     caseRecMap.remove(caseLessonLearned.Case__c);
                                  
                 }
                 system.debug('caseMap---'+caseRecMap.values());*/
            return caseList;
             
         }
         catch(Exception e) {
             throw new AuraHandledException(e.getMessage());             
         }
    }
    @AuraEnabled
    public static String attachRecords(String selectedType,List<String> idList,String workOrderId){
       List<Case_LessonsLearned_Records__c> recordList = new List<Case_LessonsLearned_Records__c>();
       string returnMsg;
       
          try{
          recordList = [Select id from Case_LessonsLearned_Records__c where Case__c IN:idList OR Lessons_Learned__c IN:idList];
          if(recordList.size()>0){
              returnMsg='This record is already attached. Please select different record.';
          }
          else{
              for(String ids:idList){
                  
                  Case_LessonsLearned_Records__c record = new Case_LessonsLearned_Records__c();              
                  record.Work_Order__c = workOrderId;
                  if(selectedType == 'NPT Case' || selectedType == 'SIR-CaM'){
                     record.Case__c = Id.valueOf(ids);
                  }
                  else{
                     record.Lessons_Learned__c = Id.valueOf(ids);
                  }
                  system.debug('--record.Case__c--'+record.Case__c);
                  recordList.add(record);
              }
              database.insert(recordList);
              returnMsg = 'Successfully inserted the records.';
          }
          return returnMsg ;
          }
          catch(Exception e) {
            system.debug('---e.getMessage()-'+e.getMessage());
             throw new AuraHandledException(e.getMessage());
             
         }
    }
    
    @AuraEnabled
        public static Map<String,List<Map<String, String>>> getCasePickList(){
        Map<String,List<Map<String, String>>> mapPickListValues = new Map<String,List<Map<String, String>>>();
        List<Map<String, String>> HSEProductSafetyValues= new List<Map<String, String>>();
        List<Map<String, String>> primaryFailureValues= new List<Map<String, String>>();
        List<Map<String, String>> typeOfIssuesValues= new List<Map<String, String>>();
        List<Map<String, String>> subSeaServicesRegionValues= new List<Map<String, String>>();
        List<Map<String, String>> bhEventValues= new List<Map<String, String>>();
        List<Map<String, String>> CustomerEscalationValues= new List<Map<String, String>>();
        List<Map<String, String>> nearMissEventValues= new List<Map<String, String>>();
        List<Map<String, String>> reOccureneceValues= new List<Map<String, String>>();
        
               
        try
        {    
                   
            Schema.DescribeFieldResult HSEFieldResult = Case.GE_OG_EHS_Product_Safety_CIR__c.getDescribe();
            List<Schema.PicklistEntry> plEntry1 = HSEFieldResult.getPicklistValues();
            HSEProductSafetyValues.add(new Map<String, String>{'value' => 'None', 'label' => 'None'});
            for(Schema.PicklistEntry ple : plEntry1){
                     
                    HSEProductSafetyValues.add(new Map<String, String>{'value' => ple.getLabel(), 'label' => ple.getLabel()});         
            } 
            
            Schema.DescribeFieldResult primaryFailureFieldResult = Case.GE_NPT_Primary_Failure_Classification__c    .getDescribe();
            List<Schema.PicklistEntry> plEntry2 = primaryFailureFieldResult.getPicklistValues();
            primaryFailureValues.add(new Map<String, String>{'value' => 'None', 'label' => 'None'});
            for(Schema.PicklistEntry ple : plEntry2){
                     
                    primaryFailureValues.add(new Map<String, String>{'value' => ple.getLabel(), 'label' => ple.getLabel()});         
            } 
            
            Schema.DescribeFieldResult typeOfIssuesValuesResult = Case.GE_OG_CIR_Type_of_Issue__c.getDescribe();
            List<Schema.PicklistEntry> plEntry3 = typeOfIssuesValuesResult .getPicklistValues();
            typeOfIssuesValues.add(new Map<String, String>{'value' => 'None', 'label' => 'None'});
            for(Schema.PicklistEntry ple : plEntry3){
                     
                    typeOfIssuesValues.add(new Map<String, String>{'value' => ple.getLabel(), 'label' => ple.getLabel()});         
            }
            Schema.DescribeFieldResult subSeaServicesRegionResult= Case.GE_NPT_Subsea_Services_Regions__c.getDescribe();
            List<Schema.PicklistEntry> plEntry4 = subSeaServicesRegionResult.getPicklistValues();
            subSeaServicesRegionValues.add(new Map<String, String>{'value' => 'None', 'label' => 'None'});
            for(Schema.PicklistEntry ple : plEntry4){
                     
                    subSeaServicesRegionValues.add(new Map<String, String>{'value' => ple.getLabel(), 'label' => ple.getLabel()});         
            } 
            Schema.DescribeFieldResult bhEventResult= Case.GE_NPT_Is_it_a_Non_GE_event__c.getDescribe();
            List<Schema.PicklistEntry> plEntry5 = bhEventResult.getPicklistValues();
            bhEventValues.add(new Map<String, String>{'value' => 'None', 'label' => 'None'});
            for(Schema.PicklistEntry ple : plEntry5){
                     
                    bhEventValues.add(new Map<String, String>{'value' => ple.getLabel(), 'label' => ple.getLabel()});         
            } 
            Schema.DescribeFieldResult CustomerEscalationResult= Case.GE_OG_Customer_Escalation_CIR__c.getDescribe();
            List<Schema.PicklistEntry> plEntry6 = CustomerEscalationResult.getPicklistValues();
            CustomerEscalationValues.add(new Map<String, String>{'value' => 'None', 'label' => 'None'});
            for(Schema.PicklistEntry ple : plEntry6){
                     
                    CustomerEscalationValues.add(new Map<String, String>{'value' => ple.getLabel(), 'label' => ple.getLabel()});         
            } 
            Schema.DescribeFieldResult nearMissEventResult= Case.GE_NPT_Near_Miss_Event__c.getDescribe();
            List<Schema.PicklistEntry> plEntry7 = nearMissEventResult.getPicklistValues();
            nearMissEventValues.add(new Map<String, String>{'value' => 'None', 'label' => 'None'});
            for(Schema.PicklistEntry ple : plEntry7){
                     
                    nearMissEventValues.add(new Map<String, String>{'value' => ple.getLabel(), 'label' => ple.getLabel()});         
            } 
            Schema.DescribeFieldResult reOccureneceResult= Case.Reoccurence__c.getDescribe();
            List<Schema.PicklistEntry> plEntry8 = reOccureneceResult.getPicklistValues();
            reOccureneceValues.add(new Map<String, String>{'value' => 'None', 'label' => 'None'});
            for(Schema.PicklistEntry ple : plEntry8){
                     
                    reOccureneceValues.add(new Map<String, String>{'value' => ple.getLabel(), 'label' => ple.getLabel()});         
            }  
            mapPickListValues.put('HSEPRoductSafety',HSEProductSafetyValues);
            mapPickListValues.put('PrimaryFailure',primaryFailureValues);
            mapPickListValues.put('TypeOfIssue',typeOfIssuesValues);
            mapPickListValues.put('SubSeaServices',subSeaServicesRegionValues);
            mapPickListValues.put('BHEvent',bhEventValues);
            mapPickListValues.put('CustomerEscalation',CustomerEscalationValues);
            mapPickListValues.put('NearmissEvent',nearMissEventValues);
            mapPickListValues.put('Reoccurence',reOccureneceValues);
 
                 
        }
        catch(Exception ex)
        {
            system.debug('------Error occured--'+ex.getMessage());
        }
        return mapPickListValues;
    }
    
    
    
    
}