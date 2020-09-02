/*
Class/Trigger Name     : O_CampaignClosureAction
Used Where ?           : 
Purpose/Overview       : Used for Campaign records
Scrum Team             : OPPTY MGMT
Requirement Number     : 
Author                 : Gourav Anand
Created Date           : 15/FEB/2017
Test Class Name        : O_Campaign_GE_OG_Test
Code Coverage          : 
*/

public class O_CampaignClosureAction {

    //To restrict edit on Completed or Aborted Campaigns
    public void checkEditCampaignFlds(List<Campaign> newCmpgnList, Map<Id,Campaign> oldCmpgnMap){
        
        //Get the list of all Campaign fields
        Map<String, Schema.SObjectField> fieldMap = Schema.SObjectType.Campaign.fields.getMap();
        System.debug('-----In O_CampaignClosureAction.checkEditCampaignFlds Map Keys cotains set of all Field API----  '+fieldMap.keyset());
        
        //Get the list of all editable fields
        Set<String> cmpgnEditableFields = getCmpgnFieldsSetValues();
        ID themeRecType = schema.SObjectType.Campaign.getRecordTypeInfosByName().get('Theme').getRecordTypeID();    
		Id programRecType  = Schema.SObjectType.Campaign.getRecordTypeInfosByName().get('Program').getRecordTypeID();    
        ID cmpgnRecType = schema.SObjectType.Campaign.getRecordTypeInfosByName().get('Campaign').getRecordTypeID();    
		
       
        for(String fldAPI: fieldMap.KeySet()){
            
            String fieldSetAPIName = fldAPI;
            String removeBlankSpaces = fieldSetAPIName.replaceAll( '\\s+', '');
            String upperCaseFieldAPIName  = removeBlankSpaces.touppercase();
        
            // Get all custom fields which ends with ge_og__c and standard fields
            if((upperCaseFieldAPIName.contains('__C') && upperCaseFieldAPIName.contains('GE_OG__C')) || (!upperCaseFieldAPIName.contains('__C'))){
                
                //Skip those fields which are present in the fielset of ediatble fields
                if(!cmpgnEditableFields.contains(upperCaseFieldAPIName)){ 
                   for(Campaign o:newCmpgnList){                                              
                        if(oldCmpgnMap.get(o.id).Status==o.Status && o.Status=='Completed'){
                            if(o.RecordTypeID == oldCmpgnMap.get(o.ID).RecordTypeID && (o.RecordTypeID == themeRecType || o.RecordTypeID== programRecType || o.RecordTypeID == cmpgnRecType) && upperCaseFieldAPIName !='ENDDATE' && o.get(upperCaseFieldAPIName) != oldCmpgnMap.get(o.id).get(upperCaseFieldAPIName)){
                                    
                                    System.debug('\n\n ERROR BLOCK : Field API Name '+upperCaseFieldAPIName);
                                    o.addError('These fields are not editable now because the record is in Completed status.'); 
                            }
                        }
						if(oldCmpgnMap.get(o.id).Status==o.Status && o.Status=='Aborted'){
							if(o.RecordTypeID == oldCmpgnMap.get(o.ID).RecordTypeID && o.RecordTypeID == themeRecType && upperCaseFieldAPIName !='ENDDATE' && o.get(upperCaseFieldAPIName) != oldCmpgnMap.get(o.id).get(upperCaseFieldAPIName)){
									System.debug('\n\n ERROR BLOCK : Field API Name '+upperCaseFieldAPIName);
                                    o.addError('This field is not editable now because the Theme Campaign record is in Aborted status.');
							}
							if(o.RecordTypeID == oldCmpgnMap.get(o.ID).RecordTypeID && (o.RecordTypeID == programRecType|| o.RecordTypeID == cmpgnRecType) && upperCaseFieldAPIName !='ENDDATE' && upperCaseFieldAPIName !='STARTDATE'&& upperCaseFieldAPIName !='PARENTID' && o.get(upperCaseFieldAPIName) != oldCmpgnMap.get(o.id).get(upperCaseFieldAPIName)){
								   System.debug('\n\n ERROR BLOCK : Field API Name '+upperCaseFieldAPIName);
                                   o.addError('This field is not editable now because the record is in Aborted status.');
							}
							
						}
				}
			}
        }
     }
    }
    
   //Method to get the editable list of fields for closed_completed Campaign
    public Set<String> getCmpgnFieldsSetValues() {
        List<Schema.FieldSetMember> fields =  SObjectType.Campaign.FieldSets.CampaignEditableFields_GE_OG.getFields();
        Set<String> fieldsSet = new Set<String>();
        for(Schema.FieldSetMember fld : fields) {
            String fieldSetAPIName = fld.getFieldPath();
            String removeBlankSpaces = fieldSetAPIName.replaceAll( '\\s+', '');
            String upperCaseFieldAPIName  = removeBlankSpaces.touppercase();
            fieldsSet.add(upperCaseFieldAPIName);
        }
        return fieldsSet;
    }
}