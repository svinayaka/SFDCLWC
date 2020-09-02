public with sharing class PricingProposal {
  @AuraEnabled
    public static List<TM_Price_Proposal__c> getSavedPricingProposalList(){

      return [select id,Name,OwnerId,TM_Profitability_Status__c,CurrencyIsoCode,Customer__r.Name  from TM_Price_Proposal__c where  OwnerId= :UserInfo.getUserID()];
    
    }

    @AuraEnabled
    public static List<TM_Price_Proposal__c> getRecentViewedPricingProposalList(){

    //return [select id,Name,OwnerId,TM_Profitability_Status__c,CurrencyIsoCode,Customer__r.Name  from TM_Price_Proposal__c where  OwnerId= :UserInfo.getUserID() ORDER BY LastViewedDate DESC limit 10];
    return [select id,Name,OwnerId,TM_Profitability_Status__c,CurrencyIsoCode,Customer__r.Name  from TM_Price_Proposal__c  WHERE LastViewedDate != NULL  ORDER BY LastViewedDate DESC limit 5];

    }
    @AuraEnabled(cacheable=true)
    public static Map<String,Integer> getStatusOfPricingProposalList(){ 
      
      Map<String,Integer> Final_Result=new  Map<String,Integer>();
      String objectName = 'TM_Price_Proposal__c';
      String fieldName ='TM_Profitability_Status__c';
      
      Schema.SObjectType s = Schema.getGlobalDescribe().get(objectName) ;
      Schema.DescribeSObjectResult r = s.getDescribe() ;
      Map<String,Schema.SObjectField> fields = r.fields.getMap() ;
      Schema.DescribeFieldResult fieldResult = fields.get(fieldName).getDescribe();
      List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
      
      List<AggregateResult> Name_Count=[SELECT TM_Profitability_Status__c Name, COUNT(Id) recordCount
                                        FROM TM_Price_Proposal__c 
                                        where TM_Profitability_Status__c !=null and OwnerId= :UserInfo.getUserID()
                                        GROUP BY TM_Profitability_Status__c];
      for(Integer i=0;i<Name_Count.size();i++){
          Final_Result.put(((String)Name_Count[i].get('Name')),((Integer)Name_Count[i].get('recordCount')));
      }
      
      for( Schema.PicklistEntry pickListVal : ple){  
          
          if(!(Final_Result.containsKey(pickListVal.value))){
              Final_Result.put(pickListVal.value,0);
          }
}     
       
      return Final_Result;  

      }
      @AuraEnabled
      public static string getUpdateRcd(String strName,String strAccId,String strCntry,String strState,
                                      String strBool){
          System.debug('@@@@:::String 1:::'+strCntry);
          System.debug('@@@@:::String 2:::'+strState);
          system.debug('@@@:::String 3::::'+strBool);
          TM_Price_Proposal__c obj = new TM_Price_Proposal__c();
              obj.Name = strName;
              List<String> lst = (List<String>) System.JSON.deserialize(strAccId, List<String>.class);
              obj.Customer__c = lst[0];
              obj.TM_Country__c = strCntry;
              obj.States__c = strState;
  
              insert obj;
          return String.valueOf(obj.id); 
          
      }
}