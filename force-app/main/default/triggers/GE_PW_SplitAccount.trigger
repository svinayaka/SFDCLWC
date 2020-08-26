/*
Trigger Name: GE_PW_SplitAccount
Purpose: Split Account based on the Bill To/Ship To address information provided during KYC process.
*/
trigger GE_PW_SplitAccount on GE_PRM_KYC_Termination_Checklist__c (after Update) {

    if(setKYCSplitFlag.splitCheck){
    setKYCSplitFlag.splitCheck=false;
    Schema.DescribeSObjectResult d = Schema.SObjectType.GE_PRM_KYC_Termination_Checklist__c; 
    Map<String,Schema.RecordTypeInfo> rtMapByName = d.getRecordTypeInfosByName();
    Schema.RecordTypeInfo rtByName1 =  rtMapByName.get('GE PW KYC Edit Record Type');
    Schema.RecordTypeInfo rtByName2 =  rtMapByName.get('GE PW KYC Locked Record Type');
    Set<Id> recTypeIds = new Set<Id>();
    recTypeIds.add(rtByName1.getRecordTypeId());
    recTypeIds.add(rtByName2.getRecordTypeId());
    
   Map<Id, Id> sentToCmfCheckorUncheck = new Map<Id, Id>();
    Set<Id> approvedKycAccountIds = new Set<Id>();
     
    for(GE_PRM_KYC_Termination_Checklist__c kycObj: Trigger.New){
    if(recTypeIds.contains(kycObj.RecordTypeId)){
        if(kycObj.GE_HQ_Status__c == 'Manual Due Diligence Approved' && Trigger.OldMap.get(kycObj.id).GE_HQ_Status__c != 'Manual Due Diligence Approved'){
            approvedKycAccountIds.add(kycObj.GE_HQ_Account__c);        
        }
        if(Trigger.NewMap.get(kycObj.id).GE_PW_Send_to_CMF_Bill_to__c != Trigger.OldMap.get(kycObj.id).GE_PW_Send_to_CMF_Bill_to__c)
            sentToCmfCheckorUncheck.put(kycObj.id, kycObj.GE_HQ_Account__c);
            
        if(Trigger.NewMap.get(kycObj.id).GE_PW_Send_to_CMF_Ship_to__c != Trigger.OldMap.get(kycObj.id).GE_PW_Send_to_CMF_Ship_to__c)
            sentToCmfCheckorUncheck.put(kycObj.id, kycObj.GE_HQ_Account__c);            
    }
    }
    
    if(sentToCmfCheckorUncheck.size()>0){
        Map<Id,Account> accMap= new Map<Id,Account>([select id, name, GE_PW_Send_to_CMF_Bill_To__c, GE_PW_Send_to_CMF_Ship_To__c from Account where id in :sentToCmfCheckorUncheck.values()]);
        System.debug('****accMap****'+accMap);
       
        for(Id kycId : sentToCmfCheckorUncheck.keySet()){
            accMap.get(sentToCmfCheckorUncheck.get(kycId)).GE_PW_Send_to_CMF_Bill_To__c = Trigger.newMap.get(kycId).GE_PW_Send_to_CMF_Bill_to__c;
            accMap.get(sentToCmfCheckorUncheck.get(kycId)).GE_PW_Send_to_CMF_Ship_To__c = Trigger.newMap.get(kycId).GE_PW_Send_to_CMF_Ship_to__c;            
        } 
        if(accMap.size()>0) {update accMap.values();}
                 
    }

    if(approvedKycAccountIds.size()>0){
        System.debug('****approvedKycAccountIds size****'+approvedKycAccountIds.size());
    }
    Account newAccObj = new Account();
    Map<Id,List<GE_HQ_SUBSCR_SYSTEMS__c>> accSubSysMap=new Map<Id,List<GE_HQ_SUBSCR_SYSTEMS__c>>();
    List<Account> spiltAccounts = new List<Account>();
    if( approvedKycAccountIds.size()>0){
        Map<Id, Account> accountsKycsList = new Map<Id, Account>([select id, name, GE_PW_Select_Type_of_Business__c, GE_HQ_Site_Use_Code__c, GE_HQ_New_Account_City__c, GE_HQ_New_Account_Street__c, GE_HQ_New_Account_State_Province__c, GE_HQ_New_Account_Zip_Postal_Code__c, GE_HQ_New_Account_Country__c, Phone, ShippingStreet, ShippingCity, ShippingState, ShippingPostalCode, ShippingCountry, BillingCity, BillingCountry, BillingPostalCode, BillingState, BillingStreet, GE_PW_Street_Quote_To_Sold_To_HQ__c, GE_PW_Phone_Quote_To_Sold_To_HQ__c, GE_PW_City_Quote_To_Sold_To_HQ__c, GE_PW_State_Province_Quote_To_Sold_To_HQ__c, GE_PW_Zip_Postal_Code_Quote_To_Sold_ToHQ__c, GE_PW_Street_Bill_To__c, GE_PW_City_Bill_To__c, GE_PW_State_Province_Bill_To__c, GE_PW_Zip_Postal_Code_Bill_To__c, GE_PW_Street_Ship_To__c, GE_PW_City_Ship_To__c, GE_PW_State_Province_Ship_To__c, GE_PW_Zip_Postal_Code_Ship_To__c, GE_PW_Country_Quote_To_Sold_To_HQ__c, GE_PW_Country_Bill_To__c, GE_PW_Country_Ship_To__c, GE_PW_Send_to_CMF_Bill_To__c, GE_PW_Send_to_CMF_Quote_to_Sold_To_HQ__c, GE_PW_Send_to_CMF_Ship_To__c, CreatedById, GE_HQ_Latitude__c, GE_PW_Latitude_Bill_To__c, GE_HQ_Longitude__c, GE_PW_Longitude_Bill_To__c, GE_PW_Phone_New_Request__c, GE_PW_Phone_Bill_To__c, GE_PW_Latitude_Ship_To__c, GE_PW_Longitude_Ship_To__c,  GE_PW_Phone_Ship_To__c, GE_HQ_Marketing_Name__c, GE_ES_Special_Agreements__c, GE_HQ_Request_Status__c, GE_PW_KYC_Status__c, GE_PW_Proposed_DUNS_Ship_To__c, GE_PW_Proposed_DUNS_Bill_To__c, GE_PW_Proposed_DUNS_Quote_to_Sold_To_HQ__c, GE_HQ_Request_Type__c, GE_HQ_Comments__c, GE_HQ_DB_DUNS__c,GE_PW_DB_DUNS_BillTo__c,GE_PW_DB_DUNS_New_Request__c,GE_PW_DB_DUNS_QuoteTo__c,GE_PW_DB_DUNS_ShipTo__c, (select id, Bill_To_Additional_Account__c, Ship_To_Additional_Account__c from KYC__r where GE_HQ_Status__c = 'Manual Due Diligence Approved' limit 1),(Select id,GE_HQ_Account__c,GE_OG_Org_Name__c,GE_HQ_Business_Tier2__c,GE_HQ_Business_Tier1__c,GE_HQ_Business_Tier3__c,GE_HQ_Business_Unit__c,GE_HQ_Subscr_Sys_Name__c,GE_HQ_ORG_ID__c,GE_OG_Status_val__c from Subscribed_Systems__r)  from Account where id in: approvedKycAccountIds and (GE_PW_Send_to_CMF_Bill_To__c = true or  GE_PW_Send_to_CMF_Ship_To__c = true)and GE_HQ_Request_Status__c = 'New' ]);        
        System.debug('****accountsKycsList size****'+accountsKycsList.size());
        for(Account accObj: accountsKycsList.values()){
            if(accObj.KYC__r.size()>0){
                if(accObj.Subscribed_Systems__r.size()>0){
                    List<GE_HQ_SUBSCR_SYSTEMS__c> subSys=new List<GE_HQ_SUBSCR_SYSTEMS__c>();
                    for(GE_HQ_SUBSCR_SYSTEMS__c sub:accObj.Subscribed_Systems__r){
                        subSys.add(sub);
                    }
                    accSubSysMap.put(accObj.id,subSys);
                }
                if(accObj.GE_PW_Send_to_CMF_Bill_To__c == true){
                    Account newAccObj1 = accObj.clone(false);
                    
                    if(accObj.GE_PW_Street_Bill_To__c != null){
                        newAccObj1.GE_HQ_New_Account_Street__c = accObj.GE_PW_Street_Bill_To__c;
                        newAccObj1.ShippingStreet = accObj.GE_PW_Street_Bill_To__c;
                    }     
                    if(accObj.GE_PW_City_Bill_To__c != null){
                        newAccObj1.GE_HQ_New_Account_City__c = accObj.GE_PW_City_Bill_To__c;
                        newAccObj1.ShippingCity = accObj.GE_PW_City_Bill_To__c;
                    }    
                    if(accObj.GE_PW_State_Province_Bill_To__c != null){
                        newAccObj1.GE_HQ_New_Account_State_Province__c = accObj.GE_PW_State_Province_Bill_To__c;
                        newAccObj1.ShippingState = accObj.GE_PW_State_Province_Bill_To__c;
                    }    
                    if(accObj.GE_PW_Zip_Postal_Code_Bill_To__c != null){
                        newAccObj1.GE_HQ_New_Account_Zip_Postal_Code__c = accObj.GE_PW_Zip_Postal_Code_Bill_To__c;
                        newAccObj1.ShippingPostalCode = accObj.GE_PW_Zip_Postal_Code_Bill_To__c;  
                    }    
                    if(accObj.GE_PW_Country_Bill_To__c != null){
                        newAccObj1.GE_HQ_New_Account_Country__c = accObj.GE_PW_Country_Bill_To__c ;
                        newAccObj1.ShippingCountry = accObj.GE_PW_Country_Bill_To__c ;
                    }   
                    if(accObj.GE_PW_Latitude_Bill_To__c != null){
                        newAccObj1.GE_HQ_Latitude__c = accObj.GE_PW_Latitude_Bill_To__c;
                    }    
                    if(accObj.GE_PW_Longitude_Bill_To__c != null)
                        newAccObj1.GE_HQ_Longitude__c = accObj.GE_PW_Longitude_Bill_To__c; 
                        
                    if(accObj.GE_PW_Phone_Bill_To__c !=null){
                        newAccObj1.GE_PW_Phone_New_Request__c = accObj.GE_PW_Phone_Bill_To__c ;
                        newAccObj1.Phone = accObj.GE_PW_Phone_Bill_To__c ;
                    }
                    if(accObj.GE_PW_DB_DUNS_BillTo__c !=null){
                        newAccObj1.GE_PW_DB_DUNS_New_Request__c = accObj.GE_PW_DB_DUNS_BillTo__c;
                        newAccObj1.GE_HQ_DB_DUNS__c = accObj.GE_PW_DB_DUNS_BillTo__c;
                    }
                                
                    newAccObj1.GE_HQ_Site_Use_Code__c = 'BILL_TO';
                    newAccObj1.GE_PW_Send_to_CMF_Ship_To__c = false;  
                    newAccObj1.GE_PW_Send_to_CMF_Quote_to_Sold_To_HQ__c = false;
                    newAccObj1.GE_HQ_Comments__c  = 'Bill To Split Account';
                    //Add a logic, to copy Bill To address from Original customer Request to New customer Request and uncheck send to cmf (Bill To) and send to cmf (Ship To)
                    //Link this KYC to New customer Request
                    //
                    //
                    spiltAccounts.add(newAccObj1);
                }
            
                if(accObj.GE_PW_Send_to_CMF_Ship_To__c == true){
                    Account newAccObj2 = accObj.clone(false);
    
                    if(accObj.GE_PW_Street_Ship_To__c != null){
                        newAccObj2.GE_HQ_New_Account_Street__c = accObj.GE_PW_Street_Ship_To__c;
                        newAccObj2.ShippingStreet = accObj.GE_PW_Street_Ship_To__c;
                    }                        
                         
                    if(accObj.GE_PW_City_Ship_To__c != null){
                        newAccObj2.GE_HQ_New_Account_City__c = accObj.GE_PW_City_Ship_To__c;
                        newAccObj2.ShippingCity = accObj.GE_PW_City_Ship_To__c;
                    }    
                    if(accObj.GE_PW_State_Province_Ship_To__c != null){
                        newAccObj2.GE_HQ_New_Account_State_Province__c = accObj.GE_PW_State_Province_Ship_To__c;
                        newAccObj2.ShippingState = accObj.GE_PW_State_Province_Ship_To__c;
                    }    
                    if(accObj.GE_PW_Zip_Postal_Code_Ship_To__c != null){
                        newAccObj2.GE_HQ_New_Account_Zip_Postal_Code__c = accObj.GE_PW_Zip_Postal_Code_Ship_To__c; 
                        newAccObj2.ShippingPostalCode = accObj.GE_PW_Zip_Postal_Code_Ship_To__c; 
                    }    
                    if(accObj.GE_PW_Country_Ship_To__c != null){
                        newAccObj2.GE_HQ_New_Account_Country__c = accObj.GE_PW_Country_Ship_To__c ;
                        newAccObj2.ShippingCountry = accObj.GE_PW_Country_Ship_To__c ;
                    }    
                    if(accObj.GE_PW_Latitude_Ship_To__c != null){
                        newAccObj2.GE_HQ_Latitude__c = accObj.GE_PW_Latitude_Ship_To__c;
                     }   
                    if(accObj.GE_PW_Longitude_Ship_To__c != null){
                        newAccObj2.GE_HQ_Longitude__c = accObj.GE_PW_Longitude_Ship_To__c; 
                    }    
                    if(accObj.GE_PW_Phone_Ship_To__c !=null){
                        newAccObj2.GE_PW_Phone_New_Request__c = accObj.GE_PW_Phone_Ship_To__c;
                        newAccObj2.Phone = accObj.GE_PW_Phone_Ship_To__c;
                    }
                    
                    if(accObj.GE_PW_DB_DUNS_ShipTo__c !=null){
                        newAccObj2.GE_PW_DB_DUNS_New_Request__c = accObj.GE_PW_DB_DUNS_ShipTo__c;
                        newAccObj2.GE_HQ_DB_DUNS__c = accObj.GE_PW_DB_DUNS_ShipTo__c;
                    } 
                                        
                    newAccObj2.GE_HQ_Site_Use_Code__c = 'SHIP_TO';
                    newAccObj2.GE_HQ_Comments__c  = 'Ship To Split Account';
                    newAccObj2.GE_PW_Send_to_CMF_Bill_To__c = false;  
                    newAccObj2.GE_PW_Send_to_CMF_Quote_to_Sold_To_HQ__c = false;                     
                    //Add a logic, to copy Ship To address from Original customer Request to New customer Request and check Same as quote Address fields and set sent to cmf (Bill To) and (Ship To) to false    
                    //Link this KYC to New customer Request
                    spiltAccounts.add(newAccObj2);                
                }            
            }
            System.debug('****spiltAccounts****'+spiltAccounts.size()); 
            Map<Id, GE_PRM_KYC_Termination_Checklist__c> kycRecs = new Map<Id, GE_PRM_KYC_Termination_Checklist__c>();
            if(spiltAccounts.size()>0){
                insert spiltAccounts;
                for(Account acc: spiltAccounts){
                    
                    if(acc.GE_PW_Send_to_CMF_Bill_To__c == true && acc.kyc__r.size()>0){
                        acc.kyc__r[0].Bill_To_Additional_Account__c = acc.id;
                        //Trigger.newMap.get(acc.kyc__r[0].id).Bill_To_Additional_Account__c = acc.id; 
                        //System.debug('****Bill_To_Additional_Account****'+ Trigger.newMap.get(acc.kyc__r[0].id).Bill_To_Additional_Account__c);
                        kycRecs.put(acc.kyc__r[0].id, acc.kyc__r[0]);   
                    } 
                    
                    else if(acc.GE_PW_Send_to_CMF_Ship_To__c == true && acc.kyc__r.size()>0){
                        acc.kyc__r[0].Ship_To_Additional_Account__c = acc.id;
                        //Trigger.newMap.get(acc.kyc__r[0].id).Ship_To_Additional_Account__c = acc.id;
                        //System.debug('****Ship_To_Additional_Account****'+ Trigger.newMap.get(acc.kyc__r[0].id).Ship_To_Additional_Account__c); 
                        kycRecs.put(acc.kyc__r[0].id, acc.kyc__r[0]);   
                    }   
                    
                    if(accSubSysMap.containsKey(accObj.id)){
                        if(accSubSysMap.get(accObj.id).size()>0){
                            List<GE_HQ_SUBSCR_SYSTEMS__c> subSys=new List<GE_HQ_SUBSCR_SYSTEMS__c>();
                            for(GE_HQ_SUBSCR_SYSTEMS__c sub:accSubSysMap.get(accObj.id)){
                                GE_HQ_SUBSCR_SYSTEMS__c cloneSub=sub.clone();
                                cloneSub.GE_HQ_Account__c=acc.id;
                                subSys.add(cloneSub);
                            }
                            if(subSys.size()>0){
                                insert subSys;
                            }
                        }
                    }
                } 
            }
            
            if(kycRecs.size()>0) update kycRecs.values(); 
            for(Account splicAcc: spiltAccounts){
                if(!Test.isRunningTest()){
                GE_HQ_ESKYC_CMF_Acc_Int_Wrapper.NewAccountRequest(splicAcc.id);
                }
            }               
        }
    }
}
}