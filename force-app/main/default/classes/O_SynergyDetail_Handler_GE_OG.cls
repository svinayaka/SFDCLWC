public class O_SynergyDetail_Handler_GE_OG {

    public void createSynergyDetailName(List<Synergy_Detail_ge_og__c> synDetailList){
        
        Set<Id> cmpgnIdSet = new Set<Id>() ;
        Map<String,String> mapSynDet = new Map<String,String>(); // map to store multiple records
        for(Synergy_Detail_ge_og__c synDet: synDetailList){
            cmpgnIdSet.add(synDet.Synergy_Campaign_ID_ge_og__c);
            synDet.Name = synDet.Synergy_Campaign_ID_ge_og__c+'_'+synDet.Year_ge_og__c;
            mapSynDet.put(synDet.Year_ge_og__c,synDet.Name); // store multiple records
        }
        
        //Added logic for multiple record updates
        System.debug('---------------->>mapSynDet.keySet().size='+mapSynDet.keySet().size()+' & synDetailList.size='+synDetailList.size());
        for(Synergy_Detail_ge_og__c synDet: synDetailList){
		  if(mapSynDet.keySet().size() <> synDetailList.size()){
			synDet.addError('Multiple Synergy Details are added for the same year.');
		  }//
        }    
    }
    
    
    
    public void checkDuplicateYearEntry(List<Synergy_Detail_ge_og__c> synDetailList){
        Set<Id> cmpgnIdSet = new Set<Id>() ;
        
        for(Synergy_Detail_ge_og__c synDet: synDetailList){
            cmpgnIdSet.add(synDet.Synergy_Campaign_ID_ge_og__c);
            
        }
        List<Synergy_Detail_ge_og__c> existingSynRec = [Select Id,Name from Synergy_Detail_ge_og__c where 
                                                         Synergy_Campaign_ID_ge_og__c in:cmpgnIdSet];
        
        System.debug('-------------------------->>existingSynRec'+existingSynRec);
        for(Synergy_Detail_ge_og__c synergyDet:synDetailList){
            System.debug('-------------------------->>synergyDet.Name'+synergyDet.Name);
            for(Synergy_Detail_ge_og__c existingSynName:existingSynRec){
                System.debug('-------------------------->>existingSynName.Name'+existingSynName.Name);
                if(synergyDet.Name==existingSynName.Name){
                    synergyDet.addError('Synergy Details for the selected year is already present for this Campaign/Program record.');
                }
            }
        }
        
    }
}