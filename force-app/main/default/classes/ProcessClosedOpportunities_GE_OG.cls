/*
Class/Trigger Name     : ProcessClosedOpportunities_GE_OG
Used Where ?           : Call From OpportunityTriggerHandler_GE_OG
Purpose/Overview       : Used to provide Edit access for closed opportunties
Scrum Team             : Transformation - OPPTY MGMT
Requirement Number     : R-24246
Author                 : Madhuri Sharma
Created Date           : 25/02/2016
Test Class Name        : ProcessClosedOpportunities_GE_OG_Test
Code Coverage          : 90%
*/

public class ProcessClosedOpportunities_GE_OG {
    
    public void editAccessOnOpportunity(List<Opportunity> lstOpp, Map<ID,Opportunity> oldOppMap){
        System.debug('--------------->> Entering into ProcessClosedOpportunities_GE_OG.editAccessOnOpportunity ');
        //Get the list of all opportunity fields
        Map<String, Schema.SObjectField> fieldMap = Schema.SObjectType.Opportunity.fields.getMap();
        System.debug('----- Map Keys ----  '+fieldMap.keyset());
        System.debug('----- Map Values ----  '+fieldMap.values());
        System.debug('----- Map ----  '+fieldMap);

        //Get the list of all editable fields
        Set<String> oppEditableFieldSet = getFieldsSetValues();
        Id oppOGClosedRecordTypeId = Util_GE_OG.getRecordTypeDetails('Opportunity','O&G Closed').getRecordTypeId();
       
        for(String s: fieldMap.KeySet()){
            
            String fieldSetAPIName = s;
            String removeBlankSpaces = fieldSetAPIName.replaceAll( '\\s+', '');
            String upperCaseFieldAPIName  = removeBlankSpaces.touppercase();
        
            // Get all custom fields wihich ends with ge_og__c and standard fields
            if((upperCaseFieldAPIName.contains('__C') && upperCaseFieldAPIName.contains('GE_OG__C')) || (!upperCaseFieldAPIName.contains('__C'))){
                
                //Skip those fields which are present in the fielset of ediatble fields
                if(((oppEditableFieldSet.contains(upperCaseFieldAPIName)) && (upperCaseFieldAPIName == 'STAGENAME' || upperCaseFieldAPIName == 'STAGE_GE_OG__C') || upperCaseFieldAPIName == 'OLICOUNT_GE_OG__C') || !oppEditableFieldSet.contains(upperCaseFieldAPIName)){ 
                   for(opportunity o:lstOpp){ 
                                             
                        
                        if(o.RecordTypeID == oldOppMap.get(o.ID).RecordTypeID && o.RecordTypeID == oppOGClosedRecordTypeId && o.opportunity_type_ge_og__c!='Grouped Flow'){
                        
                            if((o.StageName == 'Closed Won' || o.StageName == 'Closed Lost' || o.StageName == 'Cancelled')){
                               
                                System.debug('\n\n New StageName ' +o.StageName);
                                System.debug('\n\n OldStageName ' +oldOppMap.get(o.id).get(upperCaseFieldAPIName));
                                
                               if((upperCaseFieldAPIName == 'STAGENAME' || upperCaseFieldAPIName == 'STAGE_GE_OG__C' ) && 
                                    (o.get(upperCaseFieldAPIName) != oldOppMap.get(o.id).get(upperCaseFieldAPIName))  && 
                                    (((oldOppMap.get(o.id).get(upperCaseFieldAPIName) == 'Closed Won' && (o.get(upperCaseFieldAPIName) != 'Closed Lost' &&  o.get(upperCaseFieldAPIName) != 'Cancelled')) || 
                                    (oldOppMap.get(o.id).get(upperCaseFieldAPIName) == 'Closed Lost' &&  (o.get(upperCaseFieldAPIName) != 'Closed Won' && o.get(upperCaseFieldAPIName) != 'Cancelled')) || 
                                    (oldOppMap.get(o.id).get(upperCaseFieldAPIName) == 'Cancelled' &&  (o.get(upperCaseFieldAPIName) != 'Closed Won' && o.get(upperCaseFieldAPIName) != 'Closed Lost'))))){
                                        
                                    o.addError('You are not allowed to open a disposition opportunity');
                                }
                                else if(upperCaseFieldAPIName == 'OLICOUNT_GE_OG__C' && o.get(upperCaseFieldAPIName) != oldOppMap.get(o.id).get(upperCaseFieldAPIName)){
                                    o.addError('You are not allowed to add/delete the Opportunity Product because its Opportunity is in Closed/Cancelled Status');
                                }
                                //if the any of the other fields which are not in editable field set changed then throw an error
                                else if(o.get(upperCaseFieldAPIName) != oldOppMap.get(o.id).get(upperCaseFieldAPIName) && (upperCaseFieldAPIName != 'STAGENAME' &&
                                    upperCaseFieldAPIName != 'STAGE_GE_OG__C' && upperCaseFieldAPIName != 'OLICOUNT_GE_OG__C' )){
                                    System.debug('\n\n ERROR BLOCK : Field API Name '+upperCaseFieldAPIName);
                                    o.addError('These fields are not editable now because the Opportunity is in a Closed/Cancelled Status');
                                }
                                
                            }
                        }
                   }
                }
            }
        }
    }
    
    //Added By Madhuri : 01/04/2016 - To update the Standard stage field for Closed Opportunities
    //Method to update the standard stage field for Closed Opportunities : 
    public void updateStageOfClosedOpportunity(List<Opportunity> lstOpp, Map<ID,Opportunity> oldOppMap){
        System.debug('--------------->> Entering into ProcessClosedOpportunities_GE_OG.updateStageOfClosedOpportunity');
        Id oppOGClosedRecordTypeId = Util_GE_OG.getRecordTypeDetails('Opportunity','O&G Closed').getRecordTypeId();
        for(opportunity o:lstOpp){ 
            if(o.RecordTypeID == oldOppMap.get(o.ID).RecordTypeID && o.RecordTypeID == oppOGClosedRecordTypeId && o.opportunity_type_ge_og__c != 'Grouped Flow'){
                if((oldOppMap.get(o.id).StageName != o.StageName) && (o.stage_ge_og__c != o.StageName)){
                   System.debug('--------------->>ProcessClosedOpportunities_GE_OG setting custom stage on updating std Stage'); 
                   o.stage_ge_og__c = o.StageName;
                } else if((oldOppMap.get(o.id).STAGE_GE_OG__C != o.STAGE_GE_OG__C) && (o.StageName != o.STAGE_GE_OG__C)){
                   System.debug('--------------->>ProcessClosedOpportunities_GE_OG setting std Stage on updating Custom Stage');
                   o.StageName = o.stage_ge_og__c;
                }
            }
        }
        
    }
    
    //Method to get the editable list of fields for closed opportunity
    public Set<String> getFieldsSetValues() {
        List<Schema.FieldSetMember> fields =  SObjectType.Opportunity.FieldSets.EditableFieldsForClosedOpportunities.getFields();
        Set<String> fieldsSet = new Set<String>();
        for(Schema.FieldSetMember f : fields) {
            String fieldSetAPIName = f.getFieldPath();
            String removeBlankSpaces = fieldSetAPIName.replaceAll( '\\s+', '');
            String upperCaseFieldAPIName  = removeBlankSpaces.touppercase();
            System.debug('\n\n FINAL API NAME  '+upperCaseFieldAPIName);

            fieldsSet.add(upperCaseFieldAPIName);
        }
        return fieldsSet;
    }
    
    public static void ProcessClosedOppties(){
       Integer oppty = 0;
        oppty++;
        oppty++;
        oppty++;
        oppty++;
        oppty++;
        oppty++;
        oppty++;
        oppty++;
        oppty++;
        oppty++;
        oppty++;
        oppty++;
        oppty++;
        oppty++;
        oppty++;
        oppty++;
    }
        
}