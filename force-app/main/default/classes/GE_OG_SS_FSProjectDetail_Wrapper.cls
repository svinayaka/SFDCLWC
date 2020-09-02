/*
Class Name: GE_OG_SS_FSProjectDetail_Wrapper 
Purpose/Overview: Wrapper class for GE_OG_PCOutboundIntegration class to invoke SOA Endpoint.
Author: Shiv Pratap Singh Bhadauria
Developed Date : 26/06/2019
Test Class Name:  Test_GE_OG_PCIntegration
*/
Global class GE_OG_SS_FSProjectDetail_Wrapper{
    public GE_OG_SS_FSProjectDetail_Wrapper(){
    
    }
    GE_SS_FSProjectLines_Publish.Rental_Output_Type rentalOutputType_x = new GE_SS_FSProjectLines_Publish.Rental_Output_Type() ;
    GE_SS_FSProjectLines_Publish.RentalFeatureCollectionType rentalFeatureCollectionType_x = new GE_SS_FSProjectLines_Publish.RentalFeatureCollectionType() ;
    GE_SS_FSProjectLines_Publish.RentalFeatureResponseCollectionType rentalFeatureResponseCollectionType_x = new  GE_SS_FSProjectLines_Publish.RentalFeatureResponseCollectionType() ;
    GE_SS_FSProjectLines_Publish.Return_RentalLines_BPELProcess_pt processRequest_x = new GE_SS_FSProjectLines_Publish.Return_RentalLines_BPELProcess_pt () ;
    list<GE_SS_FSProjectLines_Publish.RentalFeatures> rentalFeatureItemsList_x = new list<GE_SS_FSProjectLines_Publish.RentalFeatures>() ;
    list<GE_SS_FSProjectLines_Publish.Rental_Output_Type> rentalOutputTypeList_x = new list<GE_SS_FSProjectLines_Publish.Rental_Output_Type>() ;
    
    public void submitFSProjectDetailUpdatesToOracleERP(Set<Id> fsProjectDetailRecordId , string accessToken){
        Map<String,String> inputHeaderMap = new Map<String,String>() ;
        List<GE_OG_FS_Project_Detail__c> fsProjectLineListToUpdate = new list<GE_OG_FS_Project_Detail__c>() ; 
        inputHeaderMap.put('Authorization',accessToken) ;
        processRequest_x.inputHttpHeaders_x = inputHeaderMap ;
        processRequest_x.timeout_x = GE_OG_PCIntegrationUtility.PC_SOA_TIMEOUT ;
        processRequest_x.endpoint_x = System.Label.FS_Project_Line_URL ;
        for(GE_OG_FS_Project_Detail__c fsProjectLinesRecord : [SELECT 
                                                                    Id,
                                                                    GE_OG_Line_Id__c,
                                                                    GE_SS_Tool_condition__c,
                                                                    GE_SS_Actual_Shipped_Date_from_Customer__c,
                                                                    GE_SS_Expected_Arrival_Date_to_Shop__c                                                                    
                                                                    FROM GE_OG_FS_Project_Detail__c
                                                                    WHERE Id IN : fsProjectDetailRecordId]){
            GE_SS_FSProjectLines_Publish.RentalFeatures rentalFeatures_x = new GE_SS_FSProjectLines_Publish.RentalFeatures() ;                                                             
            rentalFeatures_x.Tool_Condition = fsProjectLinesRecord.GE_SS_Tool_condition__c ; 
            rentalFeatures_x.Line_Id = fsProjectLinesRecord.GE_OG_Line_Id__c ;
            rentalFeatures_x.Date_Tool_Sent = fsProjectLinesRecord.GE_SS_Actual_Shipped_Date_from_Customer__c ;
            rentalFeatures_x.Date_Tool_Arrives_Back = fsProjectLinesRecord.GE_SS_Expected_Arrival_Date_to_Shop__c ;
            rentalFeatureItemsList_x.add(rentalFeatures_x) ;
        }
        rentalFeatureCollectionType_x.RentalFeatures = rentalFeatureItemsList_x ;        
        system.debug('Item List' + rentalFeatureItemsList_x);
        try{
          rentalOutputTypeList_x = processRequest_x.process(rentalFeatureItemsList_x) ;
          system.debug('Response' + rentalOutputTypeList_x);
        }catch(Exception e){
            for(Id projectDetailRecordId : fsProjectDetailRecordId){
               GE_OG_FS_Project_Detail__c fsProjectDetailErrorUpdate = new GE_OG_FS_Project_Detail__c() ;
               fsProjectDetailErrorUpdate.Id = projectDetailRecordId ;
               fsProjectDetailErrorUpdate.GE_OG_Error_Message__c = 'There is an error in FS Project Lines web service invocation ---->' + e.getMessage() ;
               fsProjectLineListToUpdate.add(fsProjectDetailErrorUpdate) ;
            }
         }
         
         if(fsProjectLineListToUpdate.size() > 0){
                update fsProjectLineListToUpdate ;
         }
   }
}