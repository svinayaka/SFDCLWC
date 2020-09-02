public class UpdateMCTSArticleDataCategory{
@InvocableMethod
    public static void updateMCTSArticleDataCategory(List<Id> knowledgeid)
    {
       List<Deal_Machine__kav> kArticle = [SELECT ID,Sub_Business__c,Assembly__c,RecordTypeId FROM Deal_Machine__kav  WHERE Id IN: knowledgeid];
       Id MCTSRecId = Schema.SObjectType.Deal_Machine__kav.getRecordTypeInfosByName().get('MC-TS Article').getRecordTypeId();
       Id dealMachineRecId = Schema.SObjectType.Deal_Machine__kav.getRecordTypeInfosByName().get('Deal_Machine').getRecordTypeId();

       List<Deal_Machine__DataCategorySelection> kADCSLst = new List<Deal_Machine__DataCategorySelection>();
       Map<String,String> DataCategorySubBusinessMapping = new Map<String,String>();
       Map<String,String> DataCategoryAssemblyMapping = new Map<String,String>();
       List<MC_TS_Data_Categories__mdt> dataCategoryList = [Select Data_Category__c,Sub_Business__c,Assembly__c from MC_TS_Data_Categories__mdt];
       for(MC_TS_Data_Categories__mdt dCat:dataCategoryList){
           if(string.isNotBlank(dCat.Sub_Business__c)){
               DataCategorySubBusinessMapping .put(dCat.Sub_Business__c,dCat.Data_Category__c);
           }
           if(string.isNotBlank(dCat.Assembly__c)){
               DataCategoryAssemblyMapping.put(dCat.Assembly__c,dCat.Data_Category__c);
           }
           
       }      
       
        for(Deal_Machine__kav kak: kArticle)
        {
           
            Deal_Machine__DataCategorySelection kADCS = new Deal_Machine__DataCategorySelection();
            kADCS.ParentId = kak.Id;
            if(kak.RecordTypeId == MCTSRecId){ 
                kADCS.DataCategoryGroupName = 'Digital_Solutions';
                if(kak.Assembly__c != null){
                     kADCS.DataCategoryName = DataCategoryAssemblyMapping.get(kak.Assembly__c);
                }
                
                else if(kak.Sub_Business__c != null){
                     kADCS.DataCategoryName = DataCategorySubBusinessMapping.get(kak.Sub_Business__c);
                }
                else{                     
                     kADCS.DataCategoryName = 'Digital_Solutions';
                }
            }
            else if(kak.RecordTypeId == dealMachineRecId){
                kADCS.DataCategoryGroupName = 'Deal_Machine';
                kADCS.DataCategoryName = 'All';
            }
            kADCSLst.add(kADCS);
         }
          if(kADCSLst.size()>0)
            {

                Database.upsert(kADCSLst,false);
                system.debug('res**'+kADCSLst);

            }
     }
     
    
     
}