/*
Class/Trigger Name     : GE_OG_ProductAndPriceBookEnrty
Used Where ?           : 
Purpose/Overview       : Used to update is_product_active_ge_og__c flag on basis of products.
Scrum Team             : Opportunity Mangaement
Requirement Number     : R-31551
Author                 : Harsha C
Created Date           : 18/MARCH/2019
Test Class Name        : mark_ProductActive_ge_og_test
Code Coverage          : 82
*/

public class mark_ProductActive_ge_og {
    public static void markProductActiveOLI(List<Product2> prod){
        List<Id> productId = new List<Id>();
        Integer totalOli = 0;
        Integer total = 0;
        
        List<String> exception_List = new List<String>();
        List<String> success_List = new List<String>();
        Set<Id> failIds = new Set<Id>();
        Set<Id> successIds = new Set<Id>();
        
        Integer successOLIcount = 0;
        Integer failedOLIcount = 0;
        Database.SaveResult[]  SaveResultListLead; 
        
        List<OpportunityLineItem> updateoli = new List<OpportunityLineItem>();
        for(Product2 p : prod){
            productId.add(p.Id);
        }
        List<OpportunityLineItem> oli = new List<OpportunityLineItem>();
        try{
            oli= [SELECT Id, Product2Id, OpportunityId,Product2.IsActive,Name FROM OpportunityLineItem where Product2Id In: productId and  Opportunity.RecordType.developerName != 'O_G_Closed'];  
            for(OpportunityLineItem opli :oli){
                opli.is_product_active_ge_og__c=opli.Product2.IsActive;
                updateoli.add(opli);
            }
            SaveResultListLead = Database.update(updateoli, false);
            totalOli = totalOli + updateoli.size();
            for(integer i =0; i<updateoli.size();i++){
                String msg11='';
                String msg22='';
                If(!SaveResultListLead[i].isSuccess()){
                    failIds.add(updateoli.get(i).id);
                    msg11 += updateoli.get(i).id + '==>'+'Error: "';        
                    for(Database.Error err: SaveResultListLead[i].getErrors()){  
                        msg11 += err.getmessage()+'\n';
                        failedOLIcount = failedOLIcount +1;
                    } 
                }else{
                    successIds.add(updateoli.get(i).id);
                    successOLIcount = successOLIcount +1;
                    msg22= msg22+''+ updateoli.get(i).id +'==>'+'SUCCESS: Updated!';
                }
                if(msg11!='')
                    exception_List.add(msg11);
                if(msg22!='')
                    success_List.add(msg22);
            }
            System.debug('$Finish() --------- STARTS');
            System.debug('exception_List'+exception_List);
            System.debug('success_List'+success_List);
            System.debug('SUCCESS'+successOLIcount);
            System.debug('FAILURE'+failedOLIcount);
            System.debug('$Finish() --------- ENDS'+total);
            System.debug('$Finish() --------- ENDS'+totalOli);
        }
        catch(Exception e){
            system.debug('Exception occured cause>>> '+e.getCause());
            system.debug('Exception occured Line number >>> '+e.getLineNumber());
            system.debug('Exception message >>> '+e.getMessage());
        }
    }
    
}