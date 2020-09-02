/*
Class/Trigger Name     : ProcessOppRegionUpdate_GE_OG
Purpose/Overview       : call from OpportunityTrigger_GE_OG - OpportunityTriggerHandler_GE_OG Class for update O&G Region and Install Country
Scrum Team             : Transformation - OPPTY MGMT
Requirement Number     : R-23408
Author                 : Mohit Maheshwari
Created Date           : 15/OCT/2015
Test Class Name        : ProcessOppRegionUpdate_GE_OG_Test
Code Coverage          : 89
Modified By            : Mohit Maheshwari
Modified Purpose       : Update PriceBook2ID  
*/

public without sharing class ProcessOppRegionUpdate_GE_OG{
    // create logic to update 'GE OG Region' and 'Install Country' and Risk Region field value on Opportunity    
    public void updateOppRegion(List<Opportunity> lstOpp, Map<ID,Opportunity> mapOpp){
    
        // Initialize variables
        Map<String,String> mapcountryreg = new Map<String,String>();
    
        // Get O&G Opportunity RecordTypeID
        ID oppOGRecordTypeID = Util_GE_OG.getRecordTypeDetails('Opportunity',System.Label.O_G).getRecordTypeId();
        ID oppGroupFlowRecordTypeID = Util_GE_OG.getRecordTypeDetails('Opportunity',System.Label.Grouped_Flow).getRecordTypeId();
        ID oppGroupHedgeRecordTypeID = Util_GE_OG.getRecordTypeDetails('Opportunity',System.Label.Hedge).getRecordTypeId();
        ID oppClosedRecordTypeID = Util_GE_OG.getRecordTypeDetails('Opportunity',System.Label.O_G_Closed).getRecordTypeId();
        
        
        Set<ID> setRecordTypeID = new Set<ID>();
        setRecordTypeID.add(oppOGRecordTypeID);
        setRecordTypeID.add(oppGroupFlowRecordTypeID);
        setRecordTypeID.add(oppGroupHedgeRecordTypeID);
        setRecordTypeID.add(oppClosedRecordTypeID);
        
        Set<ID> setOppID = new Set<ID>();
        Set<ID> setHasContactToleID = new Set<ID>();
        
        // Implement logic to update Region and Install country and Risk Region
        for(Opportunity objOpp : lstOpp){
            system.debug('\n\n  === > Stage Is Convert ' + objOpp.is_convert_ge_og__c+ ' == > \n\n');
            system.debug('\n\n  === > Stage on Insert ' + objOpp.StageName + ' == > \n\n');
            
            /***** Add logic to update Pricebook2ID *****/
            objOpp.PriceBook2ID = System.Label.Std_PriceBookID;
            
            // Add logic as part of Bug : 0000022938
            // validate Opportunity is created from Lead Conversion
            if(objOpp.is_convert_ge_og__c){
                objOpp.StageName = System.Label.Prospecting;
                objOpp.is_convert_ge_og__c = False; 
                system.debug('\n\n  === > Stage on Insert from Lead ' + objOpp.StageName + ' == > \n\n');   
            } 
            
            if(mapOpp!=null){
                setOppID.add(objOpp.ID);    
            }    
            
            // update 'Install Country' to 'End User's Country' if it is null
            if(!setRecordTypeID.contains(objOpp.RecordTypeID))
                continue;
            
            if(String.IsBlank(objOpp.primary_industry_ge_og__c))
                objOpp.primary_industry_ge_og__c = objOpp.account_industry_ge_og__c;
                
            if(objOpp.install_country_ge_og__c==null & objOpp.end_user_ge_og__c != null){
                objOpp.install_country_ge_og__c= objOpp.account_country_ge_og__c;        
            }
            if(objOpp.install_country_ge_og__c==null && objOpp.end_user_ge_og__c == null && objOpp.legal_entity_ge_og__c==null){
                if(mapOpp!=null && mapOpp.get(objOpp.ID).account_country_ge_og__c!= objOpp.account_country_ge_og__c){
                    objOpp.region_ge_og__c = objOpp.account_country_ge_og__c;
                }
                else{
                    objOpp.region_ge_og__c = objOpp.account_country_ge_og__c;
                }       
            }
            else if(objOpp.install_country_ge_og__c!=null || objOpp.end_user_ge_og__c!=null || objOpp.legal_entity_ge_og__c!=null){
                objOpp.region_ge_og__c = Util_GE_OG.regionPopulateByCountry(objOpp.account_country_ge_og__c);
                      //Risk region change as per Deal Type; Install Country - R-24543
                    /*  if(objOpp.RecordTypeID == oppOGRecordTypeID && objOpp.Risk_Region_ge_og__c==null )
                      objOpp.Risk_Region_ge_og__c = Util_GE_OG.regionPopulateByCountry(objOpp.install_country_ge_og__c); */
                
            }
            
            //Risk region change as per Deal Type; Install Country - R-24543
            if(objOpp.RecordTypeID == oppOGRecordTypeID ){
                if(objOpp.opportunity_region_ge_og__c=='Global'){
                     if(mapOpp!=null && mapOpp.get(objOpp.ID).Risk_Region_ge_og__c=='Global' && objOpp.Risk_Region_ge_og__c!='Global')
                         objOpp.addError(' Deal is Global so Risk Region must be Global and cannot be changed!');
                    else{   
                     system.debug('Setting risk region global -------------------------------------------!!');
                     objOpp.Risk_Region_ge_og__c = 'Global';
                    }   
                }else if(mapOpp!=null && objOpp.opportunity_region_ge_og__c=='Regional' && mapOpp.get(objOpp.ID).opportunity_region_ge_og__c=='Global'){
                    objOpp.Risk_Region_ge_og__c = null;
                }else if(objOpp.Risk_Region_ge_og__c==null && objOpp.install_country_ge_og__c!=null && objOpp.install_country_ge_og__c!='INDIA'){
                    objOpp.Risk_Region_ge_og__c = Util_GE_OG.regionPopulateByCountry(objOpp.install_country_ge_og__c);
                }
                
                else if(objOpp.Risk_Region_ge_og__c==null && objOpp.install_country_ge_og__c=='INDIA'&& objOpp.tier_2_ge_og__c=='Oil Field Equipment')
                {
                  objOpp.Risk_Region_ge_og__c ='Asia Pacific';
                 }
                 
                 else if(objOpp.Risk_Region_ge_og__c==null && objOpp.install_country_ge_og__c=='INDIA'&& objOpp.tier_2_ge_og__c!='Oil Field Equipment')
                {
                  objOpp.Risk_Region_ge_og__c = Util_GE_OG.regionPopulateByCountry(objOpp.install_country_ge_og__c);
                 }
            }  
        }
        
        if(setOppID.size()>0){
            
            Map<ID,OpportunityContactRole> mapContactRole = new Map<ID,OpportunityContactRole>([SELECT ID, OpportunityId FROM OpportunityContactRole WHERE OpportunityId in:setOppID]);
            
            if(mapContactRole!=null){
                for(OpportunityContactRole objRole : mapContactRole.values()){
                    setHasContactToleID.add(objRole.OpportunityID); 
                      
                }
            }
             
            for(Opportunity objOpp : lstOpp){
                if(setHasContactToleID.contains(objOpp.ID)){
                    objOpp.has_opportunitycontactrole_ge_og__c = True;    
                }
                else{
                    objOpp.has_opportunitycontactrole_ge_og__c = False;
                }
            }
                                            
        } 
           
    }    
}