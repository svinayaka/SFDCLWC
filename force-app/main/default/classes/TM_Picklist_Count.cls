public class TM_Picklist_Count {
    
    
    public TM_Picklist_Count(){
        getStatusOfPricingProposalList();
    }
    public  void  getStatusOfPricingProposalList(){
        
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
              system.debug('Final_Result'+Final_Result);                   
            }
       }