public with sharing class GE_OG_CustomOpportunityHelper{   
    @future 
    public static void insertStandardOpportunity(Set<Id> opptyMaxRecordIdSet){
        List<Opportunity> opportunityRecordToInsertList = new List<Opportunity>();  
        List<Custom_Opportunity__c> opptyMaxRecordList = new List<Custom_Opportunity__c>(); 
        List<Custom_Opportunity__c> opptyMaxRecordDynamicList = new List<Custom_Opportunity__c>();      
        List<Custom_Opportunity__c> opptyMaxRecordToUpdatelist = new List<Custom_Opportunity__c>();
        Map<String,Opportunity> newlyInsertedOpportunityRecordMap = new Map<String,Opportunity>();
        List<Opportunity_to_OpptyMax__mdt> opptyMaxToOpportunityMappingFieldList = new  List<Opportunity_to_OpptyMax__mdt>() ;
        Set<Id> insertedOpportunityIdSet = new Set<Id>() ;               
        ID Rectype=Schema.SObjectType.Custom_Opportunity__c.getRecordTypeInfosByName().get('O&G').getRecordTypeId(); 
        ID ReadOnlyRectype=Schema.SObjectType.Custom_Opportunity__c.getRecordTypeInfosByName().get('O&G ReadOnly').getRecordTypeId();
        ID opptyRecTypeId= Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('O&G').getRecordTypeId();
        Database.SaveResult[] insertDMLState ;
        String opptyMaxQuery = '', fieldList = 'Name, GE_OG_Standard_Oppty__c, GE_OG_Opportunity_Number__c, GE_OG_FromSmax__c, ';
        
        for(Opportunity_to_OpptyMax__mdt metaDataRecords : [SELECT 
                                                                  Label,Type__c,OpptyMax_Field__c ,
                                                                  Opportunity_Field__c                                                                 
                                                                  FROM Opportunity_to_OpptyMax__mdt  
                                                                  WHERE Type__c = 'Opptymax To Oppty Mapping' 
                                                                  AND Active__c = true]){                                                                              
              opptyMaxToOpportunityMappingFieldList.add(metaDataRecords) ;
              fieldList += metaDataRecords.OpptyMax_Field__c + ', ' ;              
        }
        
        fieldList = fieldList.removeEnd(', ') ; // Generating the field list to query 
        opptyMaxQuery = 'SELECT '+ fieldList + ' FROM Custom_Opportunity__c WHERE ID IN : opptyMaxRecordIdSet ' ;  
        
        system.debug('Query string is ' + opptyMaxQuery ) ;
        
        opptyMaxRecordDynamicList = Database.query(opptyMaxQuery) ;
        
        for(Custom_Opportunity__c opptyMaxRecords : opptyMaxRecordDynamicList ) {
               opptyMaxRecordList.add(opptyMaxRecords)  ;                                                                           
        }            
        
        system.debug('Metadata list size' + opptyMaxToOpportunityMappingFieldList.size())  ;                                                                                            
        system.debug('Record list size' + opptyMaxRecordList.size() + 'and record is' + opptyMaxRecordList )  ;
        
        if(opptyMaxRecordList.size() > 0){           
           for(Custom_Opportunity__c opptyMaxRecord : opptyMaxRecordList){                
                    system.debug('inside outer If block') ;
                    Opportunity opportunityRecordToInsert = new Opportunity() ;
                    opportunityRecordToInsert.RecordTypeId = opptyRecTypeId ;
                    opportunityRecordToInsert.Name = opptyMaxRecord.Name+' (field)' ;
                    if(opptyMaxRecord.GE_OG_Standard_Oppty__c == null ){                     
                        for(Integer i=0 ; i < opptyMaxToOpportunityMappingFieldList.size() ; i++){ 
                             String targetField = String.valueOf(opptyMaxToOpportunityMappingFieldList.get(i).Opportunity_Field__c);
                             String sourceField = String.ValueOf(opptyMaxToOpportunityMappingFieldList.get(i).OpptyMax_Field__c);
                             if(opptyMaxRecord.get(sourceField) != null && opptyMaxRecord.get(sourceField) != ''){                      
                                opportunityRecordToInsert.put(targetField,opptyMaxRecord.get(sourceField));                                
                             }                                           
                        }                       
                        system.debug('inside If block') ;                                      
                    } 
                    opportunityRecordToInsertList.add(opportunityRecordToInsert) ;                 
            }         
        }
        
        system.debug('Opportunity record details' + opportunityRecordToInsertList ) ;
        
        if(opportunityRecordToInsertList.size() > 0 && opportunityRecordToInsertList != null){
            try{
                insertDMLState = Database.insert(opportunityRecordToInsertList,false) ;
                for(Database.SaveResult dmlState : insertDMLState){
                    if(dmlState.isSuccess()){
                        insertedOpportunityIdSet.add(dmlState.getId()) ;
                    }
                }
                system.debug('DML State list size' + insertDMLState ) ;
            }catch(DMLException e){
                system.debug('There is an error while doing the insertion/updation of standard Opportunity Record in the database.' + e.getMessage()) ;
            }            
        }        
           
        if(insertedOpportunityIdSet.size() > 0 && insertedOpportunityIdSet != null){
            for(Opportunity newOppRecord : [SELECT
                                                 Id,Name,
                                                 Opportunity_number_ge_og__c
                                                 FROM Opportunity
                                                 WHERE Id IN : insertedOpportunityIdSet ]){
                  newlyInsertedOpportunityRecordMap.put(newOppRecord.Name,newOppRecord) ;                               
            }
        }    
        
        if(newlyInsertedOpportunityRecordMap.size() > 0){
            for(Custom_Opportunity__c opptyMaxRec : opptyMaxRecordList){
                if(newlyInsertedOpportunityRecordMap.containsKey(opptyMaxRec.Name+' (field)') && opptyMaxRec.GE_OG_FromSmax__c == True ){
                    Custom_Opportunity__c opptyMaxRecordToUpdate = new Custom_Opportunity__c() ;
                    opptyMaxRecordToUpdate.Id = opptyMaxRec.Id ;
                    opptyMaxRecordToUpdate.RecordtypeId = ReadOnlyRectype ;                
                    opptyMaxRecordToUpdate.GE_OG_Opportunity_Number__c = opptyMaxRec.GE_OG_Opportunity_Number__c == null ? newlyInsertedOpportunityRecordMap.get(opptyMaxRec.Name+' (field)').opportunity_number_ge_og__c : opptyMaxRec.GE_OG_Opportunity_Number__c ;  
                    opptyMaxRecordToUpdate.GE_OG_Standard_Oppty__c = opptyMaxRec.GE_OG_Standard_Oppty__c == null ? newlyInsertedOpportunityRecordMap.get(opptyMaxRec.Name+' (field)').Id : opptyMaxRec.GE_OG_Standard_Oppty__c ;
                    opptyMaxRecordToUpdatelist.add(opptyMaxRecordToUpdate) ;
                }
            }
        }     
        
        if(opptyMaxRecordToUpdatelist.size() > 0 ){
            try{
                update opptyMaxRecordToUpdatelist ;
            }catch(DMLException e){
                system.debug('There is an error while doing the updation of Opptymax Opportunity Record in the database.' + e.getMessage()) ;
            }
        }
    }// End of method insertStndOpportunity 
    
    public static void updateCustomOpportunity(List<Custom_Opportunity__c> opptyMaxRecordList){
        ID Rectype = Schema.SObjectType.Custom_Opportunity__c.getRecordTypeInfosByName().get('O&G').getRecordTypeId();
        List<SVMXC__Service_Group_Members__c> technicianEquipmentList = new List<SVMXC__Service_Group_Members__c>(); 
        Map<String,String> leAccountWithCommercialAccountMap = new Map<String,String>() ;
        Set<Id> userIdSet = new set<Id>();
        Set<Id> leAccountIdSet = new Set<Id>() ;       
             
        for(Custom_Opportunity__c opptyMaxRec : opptyMaxRecordList){
            if(opptyMaxRec.RecordTypeID == Rectype){                
                userIdSet.add(opptyMaxRec.OwnerId);                
            }
            leAccountIdSet.add(opptyMaxRec.GE_OG_LE_Account__c) ; 
        }
        
        if(userIdSet.size() > 0){
            for(SVMXC__Service_Group_Members__c technicianRecord : [SELECT 
                                                                         Id,
                                                                         SVMXC__Service_Group__r.GE_HQ_Resource_Director__c,
                                                                         SVMXC__Service_Group__r.Name,SVMXC__Salesforce_User__r.Id
                                                                         FROM SVMXC__Service_Group_Members__c 
                                                                         WHERE SVMXC__Salesforce_User__r.Id IN : userIdSet]){
                  technicianEquipmentList.add(technicianRecord) ;                                                           
            }        
        }
        
        for(Account commercialAccountRec : [SELECT 
                                                  Id,Oil_Gas_Parent_Account__c,
                                                  Oil_Gas_Parent_Account__r.Recordtype.DeveloperName
                                                  FROM Account WHERE Id IN : leAccountIdSet]){         
               leAccountWithCommercialAccountMap.put(commercialAccountRec.Id,commercialAccountRec.Oil_Gas_Parent_Account__c) ;                                                  
        }
        
        for(Custom_Opportunity__c opptyMaxRecord : opptyMaxRecordList){
            for(SVMXC__Service_Group_Members__c technicianList : technicianEquipmentList){                
                if(opptyMaxRecord.ownerId == technicianList.SVMXC__Salesforce_User__r.Id){                        
                   opptyMaxRecord.GE_OG_ServiceTeam_Leader__c = technicianList.SVMXC__Service_Group__r.GE_HQ_Resource_Director__c;                    
                }                   
            }
            opptyMaxRecord.GE_OG_Customer_Name__c =  ( (opptyMaxRecord.GE_OG_Customer_Name__c == null || opptyMaxRecord.GE_OG_Customer_Name__c == '' ) && (leAccountWithCommercialAccountMap.size() > 0 && leAccountWithCommercialAccountMap.containsKey(opptyMaxRecord.GE_OG_LE_Account__c))) ?  
                                                                                              leAccountWithCommercialAccountMap.get(opptyMaxRecord.GE_OG_LE_Account__c) : opptyMaxRecord.GE_OG_Customer_Name__c ;                 
            system.debug('Updating OpptyMax block' +  leAccountWithCommercialAccountMap.get(opptyMaxRecord.GE_OG_LE_Account__c)) ;
        }        
    }// End of method updateCustOpportunity 
}// End of apex class GE_OG_CustomOpportunityHelper