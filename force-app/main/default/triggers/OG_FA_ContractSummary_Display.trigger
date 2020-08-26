/**********
Class Name          : OG_FA_ContractSummary_Display 
Used Where ?        : 
Purpose/Overview    :  
Functional Area     : 
Author              : 
Created Date        : 
Test Class Name     :
Change History - 
Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
11/26/2014      Pradeep Rao Yadagiri   Added Record type condition to prevent execution for channel master , channel addedum agreement record types
************/

trigger OG_FA_ContractSummary_Display on Contract (after insert, after update) {
    
    String contractRecordTypeMasterId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Channel Master Agreement').getRecordTypeId();
    String contractRecordTypeAddendumId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Channel Addendum Agreement').getRecordTypeId();
    boolean brecordtype = false;
    for(contract con: Trigger.New){
        if(con.RecordTypeId == contractRecordTypeMasterId || con.RecordTypeId != contractRecordTypeAddendumId){
           brecordtype = true; 
        } 
    }
    if(brecordtype == false){
    string userId = userInfo.getUserID();
    string userTier1 = [select GE_HQ_Tier_1_P_L__c from User where id=:userId limit 1].GE_HQ_Tier_1_P_L__c;
    system.debug('User Tier 1'+userTier1);
    string userTier2 = [select GE_HQ_Tier_2_P_L__c from User where id=:userId limit 1].GE_HQ_Tier_2_P_L__c;
    system.debug('User Tier 2'+userTier2);
    
    
    Map<string,id> groupMap = new Map<string,id>();
    for(Group grp :[SELECT id ,Name from Group where Name like 'OG FA%']){
        groupMap.put(grp.Name, grp.id);
    }
    
    system.debug('groupMap  : ' + groupMap);

    Map<string, string> businessMap = new Map<string, string>();
    for(Business_And_Group_Name__c bus :[SELECT Business_Name__c, Group_Name__c from Business_And_Group_Name__c]){
        businessMap.put(bus.Business_Name__c, bus.Group_Name__c);
    }
    
    system.debug('businessMap : ' + businessMap);
    
    List<Contract> contr = new List<Contract>();
    
    try
    {
    contr = [select id, RecordTypeId,GE_HQ_Buss_Tier1__c, (select Id, name from Contract_Summary__r) from Contract where Id IN: Trigger.oldMap.keySet()];
    system.debug('Contract list size'+contr.size());
    }
    catch(Exception e)
    {
    
    }
    
    Set <Id> Id1 = new Set <ID>() ;
    for(Contract con: contr){
        if(con.RecordTypeId != contractRecordTypeMasterId && con.RecordTypeId != contractRecordTypeAddendumId){
        for(Contract_Summary__c CS: con.Contract_Summary__r)
        {
            Id1.add(CS.ID);
        } 
        }
    }
    
    
    List<Contract_Summary__Share> conSumToShare_todelete = new List<Contract_Summary__Share>();
    
    conSumToShare_todelete = [select Id from Contract_Summary__Share where ParentId IN: Id1 and AccessLevel='Read'];
    
    delete conSumToShare_todelete;

    
    List <Contract_Summary__Share> conSumToShare = new List <Contract_Summary__Share>() ;
    
    for(Contract con: contr){
        //checking Contract Tier2 P&L as not null and containing User Tier2 P&L
        if(con.GE_HQ_Buss_Tier1__c != null){
            String str = con.GE_HQ_Buss_Tier1__c;
            system.debug('str  : '+ str);
            string sub = ';';
            integer k = str.countMatches(';');
            String[] t2 = str.split('\\;');
            system.debug('t2  : ' + t2);
            integer i;
            for (i = 0; i < k+1; i++){                
                system.debug('t2[i]  : ' + t2[i]);
                system.debug('businessMap.get(t2[i])  : ' + businessMap.get(t2[i]));
                system.debug('groupMap.get(businessMap.get(t2[i]))  : ' + groupMap.get(businessMap.get(t2[i])));
                for(Contract_Summary__c cS: con.Contract_Summary__r){
                     System.debug('Enter Insert Loop');
                     Contract_Summary__Share conSumShare = new Contract_Summary__Share();
                     conSumShare.AccessLevel='Read';
                     conSumShare.ParentId = cS.ID;
                     conSumShare.UserorGroupID = groupMap.get(businessMap.get(t2[i]));
                     conSumShare.RowCause = Schema.Contract_Summary__Share.rowCause.Exceptional_Access__c;
                     system.debug('records shared'); 
                     conSumToShare.add(conSumShare);
                     system.debug('conSumShare  : ' + conSumShare);
                }
            }
        }
    }
    try
    {
    insert conSumToShare;
    System.debug('******'+conSumToShare);
    }
    catch(Exception e)
    {
    System.debug(e);
    }
    
}
}