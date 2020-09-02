/*
Class Name                   - GE_DS_UpdateCasewithWOERPProjnumber 
Object Name                  - SVMXCServiceOrder
Description                  -  Helper class GE_DS_UpdateCasewithWOERPProjnumber would process all the Handler requests coming from GE_OG_SVMXCServiceOrderTriggerHandler 
                                for the Trigger GE_OG_SVMXCServiceOrderTrigger
*/
public class GE_DS_UpdateCasewithWOERPProjnumber {
    public void caseupdatewithErpNumber(List<SVMXC__Service_Order__c> workorderlist) {
        set<String> erpId = new set<String> ();
        List<case> csList = new List<Case> ();
        List<SVMXC__Service_Order__c>InsertWorkOrders = new List<SVMXC__Service_Order__c>();
        ID rectypeId=Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('MCS').getRecordTypeId();
        ID caserectypeId=Schema.SObjectType.Case.getRecordTypeInfosByName().get('FS-MCS').getRecordTypeId();
        Map<String,Case> csMap = new Map<String,Case>();
		//User us = [select id from user where (profileID = '00e1H0000019IY4QAM' AND GE_HQ_SSO_ID__c = '502232984' AND IsActive = TRUE)];        
       for(SVMXC__Service_Order__c  wo : workorderlist){          
            if(wo.GE_OG_MC_ERP_Project_Number__c!=Null && wo.recordTypeId==rectypeId && wo.SVMXC__Case__c == NULL ){
                erpId.add(wo.GE_OG_MC_ERP_Project_Number__c);
                InsertWorkOrders.add(wo);
            }
        }                
        if(!erpId.isEmpty()){
            system.debug('checking the ERP Id'+erpId);
            csList =[select id,GE_SM_OG_MC_SAP_Project_Number__c from Case where GE_SM_OG_MC_SAP_Project_Number__c=:erpId and GE_SM_OG_MC_SAP_Project_Number__c!=null and recordtypeid=:caserectypeId ];
            system.debug('entering to the list'+csList);
        }
        if(!csList.isEmpty()){
            for( Case cs: csList ) {
                csMap.put(cs.GE_SM_OG_MC_SAP_Project_Number__c,cs);
            }
            if(csMap!=Null){
            for(SVMXC__Service_Order__c  wrd : InsertWorkOrders){              
                csMap.containskey(wrd.GE_OG_MC_ERP_Project_Number__c);
                {
                    wrd.SVMXC__Case__c = csMap.get(wrd.GE_OG_MC_ERP_Project_Number__c).Id;
                }
            }
            
            }
        }
        else{        
            for(SVMXC__Service_Order__c wo : InsertWorkOrders){
                case ca = new case();
                ca.GE_HQ_Business_Tier2__c = wo.GE_SM_HQ_Tier_2__c;
                ca.GE_Tier_3__c = wo.GE_OG_GS_P_L__c;
                ca.GE_OG_DS_Tier4_PL__c = wo.GE_OG_MC_Business_Unit__c;
                ca.GE_Region__c = wo.GE_OG_MC_Service_Region__c;
                ca.GE_Country__c = wo.SVMXC__Country__c;
                ca.GE_OG_Project_Name_CIR__c = wo.GE_OG_MC_Subject__c;
                ca.GE_SM_OG_MC_SAP_Project_Number__c = wo.GE_OG_MC_ERP_Project_Number__c;
                ca.GE_ES_PO__c = wo.GE_SS_Customer_PO_number__c;
                ca.GE_PW_SalesOrder__c = wo.GE_SS_Sales_Order__c;
                ca.Status = 'Open';
                ca.AccountId = wo.SVMXC__Company__c;
                //ca.GE_ES_Env_Case_Amount__c = wo.GE_DS_Daily_Rate__c;
                //ca.CurrencyIsoCode = wo.CurrencyIsoCode;
                //ca.GE_DS_Service_Rate__c = wo.GE_DS_Overtime__c;
                //ca.GE_DS_Service_Discount__c = wo.GE_DS_Service_Discount__c;
                ca.RecordTypeId = caserectypeId;
                //ca.OwnerId = us.id;
				ca.OwnerId = '005A0000005Z5ts';
                csList.add(ca);
            }
                            
            if(!csList.isEmpty()){
                insert csList;                
                for( Case cs: csList ) {
                    csMap.put(cs.GE_SM_OG_MC_SAP_Project_Number__c,cs);
                }
                if(csMap!=Null){
                 for(SVMXC__Service_Order__c  wrd : InsertWorkOrders){              
                    csMap.containskey(wrd.GE_OG_MC_ERP_Project_Number__c);
                    {
                        wrd.SVMXC__Case__c = csMap.get(wrd.GE_OG_MC_ERP_Project_Number__c).Id;
                    }
                }
            
                 }
        
            }
        }                                                   
    }
}