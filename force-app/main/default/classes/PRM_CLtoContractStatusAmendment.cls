public class PRM_CLtoContractStatusAmendment {

     @invocablemethod
    public static void calcualtecontractstatus(List<Contract> contrctids){
        system.debug(' inside PRM_CLtoContractStatusAmendment ');
        Map<Id,PRM_Commercial_Line_GE_OG__c[]> custdatamap = new Map<Id,PRM_Commercial_Line_GE_OG__c[]>();
        Set<Id> contrctid = new Set<Id>();
        for(Contract record : contrctids){
            contrctid.add(record.Id);
            
        }
        List<PRM_Commercial_Line_GE_OG__c> clallLst = [Select Id,PRM_Status__c,PRM_Addendum_ID__c from PRM_Commercial_Line_GE_OG__c where PRM_Addendum_ID__c in:contrctid and PRM_Commercial_Line_Type__c != 'NRT'];
        system.debug(' CL records related to Addendum == '+clallLst);
        if(clallLst != null){
        for(PRM_Commercial_Line_GE_OG__c record : clallLst){
            system.debug(' inside for loop === '+record);
            system.debug(' record == '+record.PRM_Addendum_ID__c);
            if(custdatamap.containsKey(record.PRM_Addendum_ID__c)) {
                // Code already in map
                custdatamap.get(record.PRM_Addendum_ID__c).add(record);
            } else {
                // Code is not yet in Map
                custdatamap.put(record.PRM_Addendum_ID__c, new List<PRM_Commercial_Line_GE_OG__c> {record});
            }
        }
        
    }
        
        system.debug('custdatamap== '+custdatamap);
        List<Contract> updcontractlst = new List<Contract>();
        if(custdatamap != null){
        
        for(Id addendumid : custdatamap.keyset()){
            Contract cntr = new Contract(Id=addendumid);
            Boolean has_executed = false;
            Boolean has_renewed = false;
            Boolean has_nrt = false;
            Boolean has_terminated = false;
            Boolean has_archived = false;
            Boolean has_underamend = false;
            for(PRM_Commercial_Line_GE_OG__c clid : custdatamap.get(addendumid)){
                system.debug(' CL Status == '+clid.PRM_Status__c);
                if(clid.PRM_Status__c == 'Under Renewal'){
                    cntr.Status='Under Renewal';
                    has_renewed = true;
                    has_nrt = false;
                    has_executed = false;
                    has_archived = false;
                    has_underamend  =false;
                    //  break;
                    
                }
                
                else if(has_renewed == false){
                    if(has_nrt == false && clid.PRM_Status__c == 'Under NR/T'){
                        cntr.Status='Under NR/T';
                        has_nrt = true;
                            has_archived = false;
                    }
                    
                   else if(has_executed == false && clid.PRM_Status__c == 'Executed'){
                        cntr.Status='Executed';
                        has_executed = true;
                         // has_archived = false;
                    }
                     else if(has_underamend == false && clid.PRM_Status__c == 'Under Amend'){
                        cntr.Status='Under Modification';
                        has_underamend = true;
                         // has_archived = false;
                    }
                     if(((has_nrt == true || has_underamend==true) && has_executed == true) && has_renewed == false && has_archived == false ){
                        cntr.Status='Under Modification';
                       // has_archived = false;
                    }
                    
                    if(has_archived==false && has_executed==false && has_nrt == false && (clid.PRM_Status__c == 'Archived' || clid.PRM_Status__c == 'Non-Renewed' || clid.PRM_Status__c == 'Terminated')){
                        cntr.Status='Archived';
                     has_archived = true;
                    } 
                }
                system.debug(' === flags has renewed=== '+has_renewed);
                system.debug(' === flags  has_executed=== '+has_executed);
                system.debug(' === flags  has_nrt=== '+has_nrt);
                system.debug(' === flags  has_archived === '+has_archived);
                /**
if(clid.PRM_Status__c == 'Under Renewal'){
cntr.Status='Under Renewal';
has_renewed = true;
} 

if(has_executed == false && has_renewed==false && clid.PRM_Status__c == 'Archived' || clid.PRM_Status__c == 'Non-Renewed' || clid.PRM_Status__c == 'Terminated'){
cntr.Status='Archived';
} 

if(has_executed == false && has_renewed==false && clid.PRM_Status__c == 'UNder NR/T'){
cntr.Status='Under NR/T';
}


if(clid.PRM_Status__c == 'Executed'){
cntr.Status='Executed';
has_executed  =true;
}

**/
            }
            updcontractlst.add(cntr);
        } 
    }
        
        if(updcontractlst != null){
            update updcontractlst;
        }
    }
}