/**
*  ClassName      : CaseHandlerToUpdateLocation
*  Description    : This is the handler class to update related Location object's checkbox fields
*  on insert of case based on case owner's profile.
*/
public with sharing class CaseHandlerToUpdateLocation 
{
    /*
        * MethodName   : onAfterInsert
        * param        : trigger.new values
        * Description  : This method is called after case records are inserted
    */
    public void onAfterInsert(List<Case> lstCase)
    {
        List<Case> lstFilteredCase = new List<Case>();
        
        // Filter cases which have location populated
        for(Case objCase: lstCase)
        {
            if(objCase.SVMXC__Site__c != null)
                lstFilteredCase.add(objCase);
        }
        
        if(!lstFilteredCase.isEmpty())
            updateCheckboxFieldsOnLocation(lstFilteredCase);
    } 
    
    
    /*
        * MethodName   : updateCheckboxFieldsOnLocation
        * param        : List<Case>lstCase
        * Description  : This method updates Location checkboxes based on case owner's profile
    */
    private void updateCheckboxFieldsOnLocation(List<Case> lstCase)
    {
        Map<Id,SVMXC__Site__c> mapLocationId_objLocationToUpdate = new Map<Id,SVMXC__Site__c>();
        
        // Create sets to store profile names
        Set<String> setALProfile = new Set<String>{'GE_AL Dispatcher','GE_AL_Field Manager','GE_AL_Field Service Office',
                                                   'GE_AL_FS Technician','GE_AL_Invoicing','GE_AL_SM Admin','GE_AL_SM Read Only'};
                                                   
        Set<String> setPCProfile = new Set<String>{'GE_PC_FS Technician','GE_PC_Super Technician',
                                                   'GE_PC_Titanium Dispatcher','GE_PC_Titanium Operations Support',
                                                   'GE_PC_Titanium Service Manager','SVMX_GE_PC_Super Technician'};
        
        Set<String> setSSProfile = new Set<String>{'GE_Business Intelligence',
                                                   'GE_OG_GS Assignment','GE_OG_SS Com Ops',
                                                   'GE_OG_SS Risk Approver','GE_OG_SS Risk Manager',
                                                   'GE_OG_SS Sales','GE_SS Field Service Admin',
                                                   'GE_SS Field Service Engineer/Technician',
                                                   'GE_SS Field Service Engineer/Technician Test Clone',
                                                   'GE_SS Field Service Read Only'};
                                                   
        Set<String> setDrillingProfile = new Set<String>{'GE_DS Dispatcher','GE_DS Smax Svc User',
                                                          'GE_DS_FS Technician','GE_DS_Gold Dispatcher',
                                                          'GE_DS_Gold Service Manager','GE_DS_Titanium Dispatcher',
                                                          'GE_DS_Titanium Operations Support',
                                                          'GE_DS_Titanium Service Manager','GE_DS_Titanium Smax Svc User',
                                                          'GE_DS_Titanium_Call_Center'};
        
        // Query the case since parent fields cannot be directly fetched from trigger.new                                                 
        for(Case objCase:[SELECT Id, Owner.Profile.Name, SVMXC__Site__c, 
                          SVMXC__Site__r.GE_SS__c, 
                          SVMXC__Site__r.GE_PC_Well__c, 
                          SVMXC__Site__r.GE_Drilling__c, 
                          SVMXC__Site__r.GE_AL_Well__c 
                          FROM Case
                          WHERE Id IN:lstCase 
                          AND (Owner.Profile.Name IN: setALProfile OR Owner.Profile.Name IN: setPCProfile OR
                          Owner.Profile.Name IN: setSSProfile OR Owner.Profile.Name IN: setDrillingProfile)])
        {
            SVMXC__Site__c objLocation = new SVMXC__Site__c();
            
            // Create a map of Location id to location object
            if(!mapLocationId_objLocationToUpdate.containskey(objCase.SVMXC__Site__c))
                objLocation = new SVMXC__Site__c(Id = objCase.SVMXC__Site__c);
            else if(mapLocationId_objLocationToUpdate.containskey(objCase.SVMXC__Site__c) &&
                    mapLocationId_objLocationToUpdate.get(objCase.SVMXC__Site__c) != null)
                objLocation = mapLocationId_objLocationToUpdate.get(objCase.SVMXC__Site__c);
            
            // Check if Profile matches 'AL' criteria
            if(setALProfile.contains(objCase.Owner.Profile.Name))
                objLocation.GE_AL_Well__c = true;
                
            // Check if Profile matches 'PC' criteria
            if(setPCProfile.contains(objCase.Owner.Profile.Name))
                objLocation.GE_PC_Well__c = true;
                
            // Check if Profile matches 'SS' criteria
            if(setSSProfile.contains(objCase.Owner.Profile.Name))
                objLocation.GE_SS__c = true;
                
            // Check if Profile matches 'Drilling' criteria
            if(setDrillingProfile.contains(objCase.Owner.Profile.Name))
                objLocation.GE_Drilling__c = true;
                
            mapLocationId_objLocationToUpdate.put(objCase.SVMXC__Site__c,objLocation);
        }
        
        Database.Saveresult[] saveResult;
        
        if(!mapLocationId_objLocationToUpdate.isEmpty())
            saveResult = database.update(mapLocationId_objLocationToUpdate.values(),false); 
        
        // Catch the exception
        if(saveResult != null)
        { 
            for(Database.Saveresult objSaveResult:saveResult)
            {
                if(objSaveResult.isSuccess())
                {
                    system.debug('-----Location Updated Successfully--->>>'+objSaveResult.getId());
                }
                else
                {
                    system.debug('-----Location Updation Failed--->>>'+objSaveResult.getId());
                    for(Database.Error objError:objSaveResult.getErrors())
                    {
                        system.debug('----Following fields caused the issue-->>>>'+objError.getFields());
                        system.debug('----Message----->>>>>>>>>'+objError.getMessage());
                        system.debug('----Status Code----->>>>>>>>>'+objError.getStatusCode());
                    }
                }
            }
        }
    }
}