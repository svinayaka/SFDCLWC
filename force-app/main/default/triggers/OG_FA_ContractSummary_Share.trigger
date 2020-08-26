trigger OG_FA_ContractSummary_Share on Contract_Summary__c (after insert, after update) {
//Id userId = userInfo.getUserID();
//User user = [select id , GE_HQ_Tier_1_P_L__c , GE_HQ_Tier_2_P_L__c from User where id=:userId];
//String userTier1 = user.GE_HQ_Tier_1_P_L__c;
//String userTier2 = user.GE_HQ_Tier_2_P_L__c;
List<Contract_Summary__c> conSum = new List<Contract_Summary__c>();
List<String> contier2slst = new List<String>();
Set<Id> conId = new Set<Id>();
Set<Id> conSumId = new Set<Id>();
Set<Id> result = new Set<Id>();

List<Contract> con = new List<Contract>();
List <Contract_Summary__Share> conSumToShare = new List <Contract_Summary__Share>() ;
List<GroupMember> gm = new List<GroupMember>();
gm=[select UserOrGroupId from GroupMember where GroupId= '00GA0000002UojtMAC'and UserOrGroupId NOT IN(select id from Group)];
System.debug(gm);

if(!test.isrunningtest()){
Group grp2 = [select Id , Name from Group where Id = '00GA0000002UojtMAC' limit 1];
System.debug(grp2.Id);
System.debug(grp2.Name);
}

 for(Contract_Summary__c objId : trigger.new)
    {
    conSumId.add(objId.Id);
    }
    Map<string,id> groupMap = new Map<string,id>();
    for(Group grp :[SELECT id ,Name from Group where Name like 'OG FA%']){
        groupMap.put(grp.Name, grp.id);
    }
    Map<string, string> businessMap = new Map<string, string>();
    for(Business_And_Group_Name__c bus :[SELECT Business_Name__c, Group_Name__c from Business_And_Group_Name__c]){
        businessMap.put(bus.Business_Name__c, bus.Group_Name__c);
    } 
    conSum = [select Id , GE_Contract_Name__c from Contract_Summary__c where Id IN: conSumId];
    for(Contract_Summary__c conSum1 : conSum)
    {
    conId.add(conSum1.GE_Contract_Name__c);
    }
    con = [select Id , GE_HQ_Buss_Tier1__c from Contract where Id IN: conId];
    for(Contract contr : con)
    {
    String conTier2 = contr.GE_HQ_Buss_Tier1__c;
    contier2slst = conTier2.split(';');
    System.debug(contier2slst);
    //contier2slst.addAll(conTier2s);
    for(String tier2Itr : contier2slst)
    {
    for(Contract_Summary__c cS : conSum)
    {
    System.debug(tier2Itr);
     Contract_Summary__Share conSumShare = new Contract_Summary__Share();
     conSumShare.AccessLevel='Read';
                     conSumShare.ParentId = cS.ID;
                     conSumShare.UserorGroupID = groupMap.get(businessMap.get(tier2Itr));       
conSumShare.RowCause = Schema.Contract_Summary__Share.rowCause.Exceptional_Access__c;
                     system.debug('records shared'); 
                     conSumToShare.add(conSumShare);
                     system.debug('conSumShare  : ' + conSumShare);                  
    }
    }
    }
    try{
insert conSumToShare;
}
catch(Exception e)
{
}
}