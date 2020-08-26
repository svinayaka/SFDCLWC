trigger LeadTrigger on Lead (before Insert, Before Update, after update) {
  
  
    
   If(Trigger.IsUpdate && Trigger.IsAfter){
    List<Lead> records = (List<Lead>)Trigger.new;

    List<String> ids = new List<String>();
    List<String> queries = new List<String>();
    for(Lead l : records) {
        ids.add(l.id);
        queries.add(l.company);
    }
    lead lconv = records[0];
    if(lconv.IsConverted == TRUE && lconv.converteddate == Date.Today() ){
    if(lconv.ConvertedOpportunityId != null || lconv.ConvertedContactId != null){
    leadconvertsupportive.updateopp(lconv.ConvertedOpportunityId, lconv.ConvertedContactId,lconv.GE_HQ_Business_Tier2__c, lconv.status  );
    //
    /*
    opportunity oppty = [select stagename from opportunity where id =: lconv.ConvertedOpportunityId];
    oppty.stagename = 'Prospect';
    Update oppty;
    */
    //
    }
    //if(lconv.ConvertedContactId != null){
    
   // }
    }
  //  SearchService.searchAndPostAsyncRequest(ids, queries);
    }
    if(Trigger.IsBefore){
    for(lead leadObj : Trigger.New){
       if(leadObj.status != 'Opportunity' && leadObj.status != 'Sales Qualified'){
       If(Trigger.IsInsert){
       if(leadObj.GE_HQ_Business_Tier2__c=='Measurement & Control (M&C)' &&leadObj.GE_OG_MC_Marketo_Stage__c!=null)
                  leadObj.status=leadObj.GE_OG_MC_Marketo_Stage__c;
            else if(leadObj.GE_HQ_Business_Tier2__c=='Drilling & Surface (D&S)' &&leadObj.GE_OG_DS_Marketo_Stage__c!=null)
               leadObj.status=leadObj.GE_OG_DS_Marketo_Stage__c;
            else if(leadObj.GE_HQ_Business_Tier2__c=='DTS' &&leadObj.GE_OG_DTS_Marketo_Stage__c!=null)
               leadObj.status=leadObj.GE_OG_DTS_Marketo_Stage__c;
            else if(leadObj.GE_HQ_Business_Tier2__c=='Subsea (SS)' &&leadObj.GE_OG_SS_Marketo_Stage__c!=null)
               leadObj.status=leadObj.GE_OG_SS_Marketo_Stage__c;
           else if(leadObj.GE_HQ_Business_Tier2__c=='TMS' && leadObj.GE_OG_TMS_Marketo_Stage__c!=null)
              leadObj.status=leadObj.GE_OG_TMS_Marketo_Stage__c;
       }
       Else{
            if(leadObj.GE_HQ_Business_Tier2__c=='Measurement & Control (M&C)' &&leadObj.GE_OG_MC_Marketo_Stage__c!=null && Trigger.oldMap.get(leadObj.Id).GE_OG_MC_Marketo_Stage__c==null && leadObj.GE_OG_MC_Marketo_Stage__c!=Trigger.oldMap.get(leadObj.Id).GE_OG_MC_Marketo_Stage__c)
                  leadObj.status=leadObj.GE_OG_MC_Marketo_Stage__c;
            else if(leadObj.GE_HQ_Business_Tier2__c=='Drilling & Surface (D&S)' &&leadObj.GE_OG_DS_Marketo_Stage__c!=null  && Trigger.oldMap.get(leadObj.Id).GE_OG_DS_Marketo_Stage__c==null && leadObj.GE_OG_DS_Marketo_Stage__c!=Trigger.oldMap.get(leadObj.Id).GE_OG_DS_Marketo_Stage__c)
               leadObj.status=leadObj.GE_OG_DS_Marketo_Stage__c;
            else if(leadObj.GE_HQ_Business_Tier2__c=='DTS' &&leadObj.GE_OG_DTS_Marketo_Stage__c!=null  && Trigger.oldMap.get(leadObj.Id).GE_OG_DTS_Marketo_Stage__c==null && leadObj.GE_OG_DTS_Marketo_Stage__c!=Trigger.oldMap.get(leadObj.Id).GE_OG_DTS_Marketo_Stage__c)
               leadObj.status=leadObj.GE_OG_DTS_Marketo_Stage__c;
            else if(leadObj.GE_HQ_Business_Tier2__c=='Subsea (SS)' &&leadObj.GE_OG_SS_Marketo_Stage__c!=null && Trigger.oldMap.get(leadObj.Id).GE_OG_SS_Marketo_Stage__c==null && leadObj.GE_OG_SS_Marketo_Stage__c!=Trigger.oldMap.get(leadObj.Id).GE_OG_SS_Marketo_Stage__c)
               leadObj.status=leadObj.GE_OG_SS_Marketo_Stage__c;
           else if(leadObj.GE_HQ_Business_Tier2__c=='TMS' && leadObj.GE_OG_TMS_Marketo_Stage__c!=null  && Trigger.oldMap.get(leadObj.Id).GE_OG_TMS_Marketo_Stage__c==null && leadObj.GE_OG_TMS_Marketo_Stage__c!=Trigger.oldMap.get(leadObj.Id).GE_OG_TMS_Marketo_Stage__c)
              leadObj.status=leadObj.GE_OG_TMS_Marketo_Stage__c;
            }
            }
            
            }
     
            
            }
}