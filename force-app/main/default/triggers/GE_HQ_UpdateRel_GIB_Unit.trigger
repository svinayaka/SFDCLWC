/*    
Class Name        : GE_HQ_UpdateRel_GIB_Unit
Purpose/Overview  : To take GE related S/N value and enter into Lookup for Related GIB Unit.
Author            : Jayadev Rath
Test Class        : GE_HQ_UpdateIBRecords_Test
Change History    : Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
                  : 19th Jan 2012 : Jayadev Rath       : Created: Created for the R-7151, BC S-04442.
                  : 30th Jan 2012 : Jayadev Rath       : Added the Before Update Condition: To overcome the difficulty of lookup field, we have put null when Site Account is changed by Integration user.
*/
Trigger GE_HQ_UpdateRel_GIB_Unit on GE_Installed_Base__c (Before Update, After Update) {
    
    List<Profile> Prof = [Select Id, Name from Profile where Id = :UserInfo.getProfileId() limit 1];

    // For the Before trigger part, update the Lookup filed to null, if the Site Account is changed.
    If(Trigger.IsBefore) {
        // Check if the records are being modified by 'System Integration' user.
        If(Prof[0].Name == 'GE_ES System Integration') {
        
            //List<RecordType> GIBRecTypes = [Select Id, Name from RecordType where SObjectType ='GE_Installed_Base__c' and Name in ('Aero Gas', 'Cooler', 'Gasification', 'Generator', 'HD Gas', 'Hydro Units', 'Installed Base Generic', 'Motors', 'Plant', 'Pump', 'Steam', 'Turboexpander', 'Valve', 'Wind')];
            List<RecordType> GIBRecTypes = [Select Id, Name from RecordType where SObjectType ='GE_Installed_Base__c' and Name in ('Generator','Steam','HD Gas')];
            Set<String> GIBRecIds = new Set<String>();
            // Gather all the GIB record type ids.
            For(RecordType r: GIBRecTypes) {
                GIBRecIds.add(r.Id); 
            }
            For(GE_Installed_Base__c IB: Trigger.New) {
                //If(GIBRecIds.contains(IB.RecordTypeId) && Trigger.oldMap.get(IB.Id).Account__c != IB.Account__c && Trigger.oldMap.get(IB.Id).GE_ES_GIB_Equipment__c!=Null && Trigger.oldMap.get(IB.Id).Account__c != Trigger.newMap.get(IB.Id).Account__c ) {    IB.GE_ES_GIB_Equipment__c = Null; }
                If(GIBRecIds.contains(IB.RecordTypeId) 
                && Trigger.oldMap.get(IB.Id).GE_ES_GIB_Equipment__c!=Null 
                && ((Trigger.oldMap.get(IB.Id).Account__c != Trigger.newMap.get(IB.Id).Account__c) || ( Trigger.oldMap.get(IB.Id).Account__c != Trigger.oldMap.get(IB.Id).GE_ES_GIB_Equipment__r.GE_ES_Site_DUNS__c )) )
                {    IB.GE_ES_GIB_Equipment__c = Null; } 
                
            }
        }
    }
    
    // If the GE_ES_GE_Related_S_N__c text field is updated, Fill the lookup field with correct sfdc id.
    If(Trigger.IsAfter) {
       If(Prof[0].Name == 'GE_ES System Integration') {
            List<RecordType> GIBRecTypes = [Select Id, Name from RecordType where SObjectType ='GE_Installed_Base__c' and Name in ('Generator','Steam','HD Gas')];
            Set<String> GIBRecIds = new Set<String>();
            // Gather all the GIB record type ids.
            For(RecordType r: GIBRecTypes) {
                GIBRecIds.add(r.Id); 
            }
            String RecsToUpdate='';
            For(GE_Installed_Base__c IB: Trigger.new) {
                If(GIBRecIds.contains(IB.RecordTypeId) && IB.GE_ES_GE_Related_S_N__c != Trigger.oldMap.get(IB.Id).GE_ES_GE_Related_S_N__c) {
                    //RecsToUpdate= (RecsToUpdate == '') ? IB.Id : (RecsToUpdate+','+(IB.Id).Tostring()) ;
                    if(RecsToUpdate == null)
                    RecsToUpdate = IB.Id;
                    else
                    RecsToUpdate = RecsToUpdate +','+IB.Id;
                    
                }
            }
            System.debug('RecsToUpdate :'+RecsToUpdate );
            If(RecsToUpdate !='') {
                //Calling batch
                GE_HQ_UpdateIBRecords UpdateRecords = new GE_HQ_UpdateIBRecords(RecsToUpdate);
                Database.executeBatch(UpdateRecords);
            }
      }
    }
}