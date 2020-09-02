public class O_UpdateRevenueScheduleIncludedFlag {
    public void afterUpdateHandler(List < OpportunityLineItem > updatedOppItemList) {

		System.debug('RS__Inside O_UpdateRevenueScheduleIncludedFlag class');
        Set < Id > OLISet = new Set < Id > ();
        List<Revenue_Schedule_ge_og__c> updateRevSchList = new List<Revenue_Schedule_ge_og__c>();

        for (OpportunityLineItem oppLineItem: updatedOppItemList) {
            system.debug('Inside updatedOppItemList' + updatedOppItemList);
            OLISet.add(oppLineItem.Id);
            system.debug('Inside updatedOppItemList after adding to set' + OLISet);
        }

        List < OpportunityLineItem > ListOlis = [Select id, GE_ES_Primary_Quote__c from OpportunityLineItem where id in: OLISet];
        System.debug('RS__Inside OpptyLineItemQuery ListOlis'+ListOlis);
        List < Revenue_Schedule_ge_og__c > ListRevSch = [Select id from Revenue_Schedule_ge_og__c where OpportunityLineItemID_ge_og__c in: OLISet];
        System.debug('RS__Inside RevScheduleQuery ListRevSch'+ListRevSch);
        for (OpportunityLineItem oli: ListOlis) {
            for (Revenue_Schedule_ge_og__c rs: ListRevSch) {
                system.debug('RS__Inside RevSchedule for loop rsnew'+rs);
                if (oli.GE_ES_Primary_Quote__c == true) {
                    
                    rs.Is_OpportunityLineItem_Included_ge_og__c = true;
                } else {
                    rs.Is_OpportunityLineItem_Included_ge_og__c = false;
                }
                updateRevSchList.add(rs);
            }
        }
        Map<id,Revenue_Schedule_ge_og__c> RevSchMap = new Map<id, Revenue_Schedule_ge_og__c>();
        RevSchMap.putAll(updateRevSchList);
        if(RevSchMap.size() > 0){
            update RevSchMap.values();
        }
        //update updateRevSchList;
    }
}