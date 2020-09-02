public class Opportuity_Cancel_Batch_Helper {
    public static  List<Mass_Cancel_Opportunities_ge_og__c> processOptyCancellation(List<Mass_Cancel_Opportunities_ge_og__c> masscancel){
        List<Mass_Cancel_Opportunities_ge_og__c> masscancelrecordsList = masscancel;
        System.debug(' masscancel list >>> '+masscancel);
        List<Opportunity> optyList = new List<Opportunity>();
        Map<Id,Id> optyUploadrequestMap = new Map<Id,Id>();
        List<Mass_Cancel_Opportunities_ge_og__c> masscancelList = new List<Mass_Cancel_Opportunities_ge_og__c>();
        try{
            for(Mass_Cancel_Opportunities_ge_og__c  mc : masscancelrecordsList){
                System.debug('mc Id in opportunity cancel batch line 9 '+mc.Id);
                optyUploadrequestMap.put(mc.OpportunityId_ge_og__c, mc.Id);
                Opportunity opp = new Opportunity();
                opp.Id = mc.OpportunityId_ge_og__c;
                opp.disposition_comments_ge_og__c = mc.Opportunity_Win_Loss_Comments_ge_og__c;
                opp.stage_ge_og__c = 'Cancelled';
                opp.primary_reason_code_ge_og__c = 'Mass Cancellation';
                optyList.add(opp);
            }
            System.debug('optyList >>> '+optyList +' optyList.size() >>>> '+optyList.size());
            System.debug('optyUploadrequestMap >>>> '+optyUploadrequestMap);
            Database.SaveResult[]  SaveResultListOpty;
            if(!optyList.isEmpty()){
                SaveResultListOpty = Database.update(optyList, false);
                // totalopty = totalopty + optyList.size();
                System.debug('SaveResultListOpty.size() >>> '+SaveResultListOpty.size());
                for(integer i =0; i<optyList.size();i++){
                    String msg11='';
                    String msg22='';
                    Mass_Cancel_Opportunities_ge_og__c mrc = new Mass_Cancel_Opportunities_ge_og__c();
                    System.debug('optyUploadrequestMap.get(SaveResultListOpty[i].Id); >>>> '+optyUploadrequestMap.get(SaveResultListOpty[i].Id));
                    
                    
                    If(!SaveResultListOpty[i].isSuccess()){
                        // failIds.add(optyList.get(i).id);
                        System.debug('optyUploadrequestMap.get(SaveResultListOpty[i].Id) >>>> '+optyUploadrequestMap.get(optyList[i].Id) );
                        
                        mrc.Id = optyUploadrequestMap.get(optyList[i].Id);
                        System.debug('SaveResultListOpty[i].Id >>> '+optyList[i].Id);
                        msg11 += 'Error: "';        
                        for(Database.Error err: SaveResultListOpty[i].getErrors()){  
                            msg11 += err.getmessage()+'\n';
                            mrc.Success_Error_Message_ge_og__c = msg11;
                            
                            System.debug('msg11 >>> '+msg11 + 'mrc Id >>> '+mrc.id);                        }
                        masscancelList.add(mrc);
                    }else{
                        System.debug('optyUploadrequestMap.get(SaveResultListOpty[i].Id) >>>> '+optyUploadrequestMap.get(optyList[i].Id) );
                        mrc.Id = optyUploadrequestMap.get(optyList[i].Id);
                        //successIds.add(optyList.get(i).id);
                        //successOpportunitiesCount = successOpportunitiesCount +1;
                        msg22= 'SUCCESS: Updated!';
                        mrc.Success_Error_Message_ge_og__c = msg22;
                        System.debug('msg22 >>> '+msg22+ 'mrc Id >>> '+mrc.id);   
                        masscancelList.add(mrc);
                        
                    }
                    
                }       
            }
            
        } catch(Exception e){
            System.debug('exception occured >>> '+e.getCause());
            System.debug('exception error message >>> '+e.getMessage());
            System.debug('exception occured in Line number >>> '+e.getLineNumber());
        }
        
        return masscancelList;
    }
    
}