public class GE_SS_Auto_InstalledBase_Creation implements Queueable {
    List<SVMXC__Installed_Product__c> ipRecords= new List<SVMXC__Installed_Product__c>();

    public GE_SS_Auto_InstalledBase_Creation(List<SVMXC__Installed_Product__c> listRelated){
        this.ipRecords = listRelated;
    }
    
    
    public void execute(QueueableContext context) {
        List<GE_Installed_Base__c> recordsToInsertOrUpdate = new List<GE_Installed_Base__c>() ;
        List<IP_To_IB_Mapping__mdt> mappingFieldList = new  List<IP_To_IB_Mapping__mdt>() ;
        Map<String,IP_To_IB_Mapping__mdt> mappingFieldMap = new Map<String,IP_To_IB_Mapping__mdt>() ;           
        Map<Id,GE_Installed_Base__c > installedBaseWithIpMap = new Map<Id,GE_Installed_Base__c >() ;
        Map<String,Id> installedBaseRecordTypesMap = new Map<String,Id>() ;   
        Set<Id> ipIdSet = new Set<Id>() ;
        Set<Id> ipRecordTypeIdSet = new Set<Id>() ;
        
        for(SVMXC__Installed_Product__c recIp : ipRecords ){
                   ipIdSet.add(recIp.Id) ;
        }
        
        for(RecordType installedBaseRecordTypes : [SELECT 
                                                            Id,Name,
                                                            DeveloperName 
                                                            FROM Recordtype
                                                            Where Sobjecttype = 'GE_Installed_Base__c' 
                                                            AND isActive = True]){
            installedBaseRecordTypesMap.put(installedBaseRecordTypes.DeveloperName,installedBaseRecordTypes.Id) ;                                                                          
        }
        
        for(RecordType installedProductRecordTypes : [SELECT 
                                                            Id,Name,
                                                            DeveloperName 
                                                            FROM Recordtype
                                                            Where Sobjecttype = 'SVMXC__Installed_Product__c' 
                                                            AND isActive = True]){
            if(installedProductRecordTypes.DeveloperName == 'GE_SS_Subsea_Tools' || installedProductRecordTypes.DeveloperName == 'GE_OG_SS'){
                ipRecordTypeIdSet.add(installedProductRecordTypes.Id);
            }                                                                         
        } 
              
        //Query for metadata records
        for(IP_To_IB_Mapping__mdt metaDataRecords : [SELECT
                                                           Label,IB_Record_Type_API_Name__c,
                                                           Source_IP_Fields__c,Target_IB_Fields__c ,Mapping_Type__c
                                                           FROM IP_To_IB_Mapping__mdt  WHERE Active__c = True]){
            if(metaDataRecords .Mapping_Type__c == 'Field Mapping'){                                               
                mappingFieldList.add(metaDataRecords);
            }else{    
                mappingFieldMap.put(metaDataRecords.Label,metaDataRecords) ; 
             }                                                  
        }        
        
        for(GE_Installed_Base__c insBase : [SELECT Id,
                                                   Name,GE_SS_Installed_Product__c 
                                                   FROM GE_Installed_Base__c 
                                                   WHERE 
                                                   GE_SS_Installed_Product__c IN : ipIdSet]){
                 installedBaseWithIpMap.put(insBase.GE_SS_Installed_Product__c,insBase) ;
        }          
       
        for(SVMXC__Installed_Product__c records : ipRecords){
           if(ipRecordTypeIdSet.contains(records.RecordtypeId)){
              if(installedBaseWithIpMap.size() == 0 ){
                 GE_Installed_Base__c installedBaseRecords = new GE_Installed_Base__c() ; 
                 if(records.GE_SS_Product_Category__c != '' && mappingFieldMap.containsKey(records.GE_SS_Product_Category__c)){
                         installedBaseRecords.RecordtypeId = installedBaseRecordTypesMap.get(mappingFieldMap.get(records.GE_SS_Product_Category__c).IB_Record_Type_API_Name__c);
                 }
                 for(Integer i=0 ; i < mappingFieldList.size() ; i++){ 
                     String targetField = String.valueOf(mappingFieldList.get(i).Target_IB_Fields__c);
                     String sourceField = String.ValueOf(mappingFieldList.get(i).Source_IP_Fields__c);                       
                     installedBaseRecords.put(targetField,records.get(sourceField));                                        
                  }
                     recordsToInsertOrUpdate.add(installedBaseRecords) ;
              }else{
                  GE_Installed_Base__c installedBaseRecordsToUpdate = new GE_Installed_Base__c() ;
                  installedBaseRecordsToUpdate.Id = installedBaseWithIpMap.get(records.Id).Id ;
                  if(records.GE_SS_Product_Category__c != ''  &&  mappingFieldMap.containsKey(records.GE_SS_Product_Category__c)){
                     installedBaseRecordsToUpdate.RecordtypeId = installedBaseRecordTypesMap.get(mappingFieldMap.get(records.GE_SS_Product_Category__c).IB_Record_Type_API_Name__c);
                  }
                  for(Integer i=0 ; i < mappingFieldList.size() ; i++){ 
                     String targetField = String.valueOf(mappingFieldList.get(i).Target_IB_Fields__c);
                     String sourceField = String.ValueOf(mappingFieldList.get(i).Source_IP_Fields__c);                       
                     installedBaseRecordsToUpdate.put(targetField,records.get(sourceField));                                        
                  }
                     recordsToInsertOrUpdate.add(installedBaseRecordsToUpdate)  ;
               }
             }                                          
           }        
        
        if(recordsToInsertOrUpdate.size() > 0){
            try{
                upsert recordsToInsertOrUpdate;
                System.debug('IB records successfully inserted/updated') ;                
            }catch(Exception e){
                System.debug('There is an error while the insertion/updation of installed base record' + e.getMessage()) ;
             }
        }         
    }
}