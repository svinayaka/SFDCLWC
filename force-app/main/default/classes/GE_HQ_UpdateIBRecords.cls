/*    
Class Name        : GE_HQ_UpdateIBRecords
Purpose/Overview  : To take GE related S/N value and enter into Lookup for Related GIB Unit.
Author            : Jayadev Rath
Test Class        : GE_HQ_UpdateIBRecords_Test
Change History    : Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
                  : 19th Jan 2012 : Jayadev Rath       : Created: Created for the R-7151, BC S-04442.
*/
Global Class GE_HQ_UpdateIBRecords implements Database.Batchable<sObject>{
    Global Set<String> AllIBIds= new Set<String>();

    Global GE_HQ_UpdateIBRecords() {}
    Global GE_HQ_UpdateIBRecords(String Ids) {
        For(String ibID: Ids.split(',')) AllIBIds.add(ibID);
    }
    
    Global Database.QueryLocator Start(Database.BatchableContext BC) {
        Date Dt=Date.Today();
        RecordType[] IBRecTypes = [Select Id from RecordType where sObjectType='GE_Installed_Base__c' and Name in ('Generator','Steam','HD Gas') limit 3];
        Set<id> RecIds = new Set<Id>(); 
        For(RecordType r: IBRecTypes) {
                RecIds.add(r.Id); 
            }
        //RecIds.add(IBRecTypes[0].Id); RecIds.add(IBRecTypes[1].Id);RecIds.add(IBRectypes[2].Id);
        String Query= 'Select Id,GE_ES_GE_Related_S_N__c,GE_ES_GIB_Equipment__c from GE_Installed_Base__c where LastModifiedDate >= :Dt and recordtypeid in :RecIds';
        If(AllIBIds != Null && AllIBIds.size() > 0) Query += ' and Id in :AllIBIds';
        Return Database.getQueryLocator(Query);
    }
    
    Global void Execute(Database.BatchableContext BC, List<sObject> scope){
        List<GE_Installed_Base__c> IBList = (List<GE_Installed_Base__c>) scope;
        System.debug('::: IB Recs- IBList:::'+IBList);
        Set<String> AllSNValues = new Set<String>();
        Map<ID,GE_Installed_Base__c> IBMap = new Map<ID,GE_Installed_Base__c>();
        Map<ID, List<String>> IBvsSN = new Map<ID, List<String>>();
        For(GE_Installed_Base__c I: IBList) {
            If(I.GE_ES_GE_Related_S_N__c != Null) {
                List<String> RelSNs = I.GE_ES_GE_Related_S_N__c.Split(';');
                //Create a complete set of SNs
                For(String s: RelSNs) {
                    AllSNValues.add(s);
                }
            }
        }
        System.debug(':::AllSNValues '+AllSNValues);
        List<GE_Installed_Base__c> ExtractedIBs = [Select Id,Name from GE_Installed_Base__c where Name in :AllSNValues and RecordType.name in ('Generator', 'HD Gas', 'Motors', 'Steam')];
        Map<String,String> ExtractedSNMap = new Map<String,String>();
        If(ExtractedIBs != Null && ExtractedIBs.size() >0) {
            For(GE_Installed_Base__c I : ExtractedIBs) {
                ExtractedSNMap.put(I.Name,I.Id);
            }
        }
        System.debug(':::ExtractedSNMap '+ExtractedSNMap);
        If(ExtractedSNMap.size() > 0) {
            List<GE_Installed_Base__c> UpdIBRecs = new List<GE_Installed_Base__c>();
            For(GE_Installed_Base__c I: IBList) {
                If(I.GE_ES_GE_Related_S_N__c != Null) {
                    List<String> Names = I.GE_ES_GE_Related_S_N__c.Split(';');  //IBvsSN.get(I.Id);
                    For(String IBName : Names) {
                        If(ExtractedSNMap.keySet().Contains(IBName)) { I.GE_ES_GIB_Equipment__c = ExtractedSNMap.Get(IBName); UpdIBRecs.add(I); break;}
                    }
                }
            }
            If(UpdIBRecs !=Null && UpdIBRecs.size()>0) Update UpdIBRecs;
        }
    }
    // GE_ES_GIB_Equipment__c  lookup
    Global void Finish(Database.BatchableContext BC) {
    
    }
    


}