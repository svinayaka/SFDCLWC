trigger GE_PW_PopulateAndUpdateAddresses on Account (before insert, before update) {

  //Code to skip trigger

    OG_Trigger_fire_Decision__c lstObj = OG_Trigger_fire_Decision__c.getValues('GE_PW_PopulateAndUpdateAddresses');
       
    if(lstObj!=null && lstObj.isActive__c == true && lstObj.Object_Name__c=='Account'){
    
        return;  
    }
    else{
    if(Trigger.isInsert || Trigger.isUpdate){
        set<String> newReqCountries = new Set<String>();
        set<String> existingCustomerIds = new Set<String>();
        Map<Id, String> existingCustomerIdsNames = new Map<Id, String>();
        
        Schema.DescribeSObjectResult d = Schema.SObjectType.Account; 
        Map<String,Schema.RecordTypeInfo> rtMapByName = d.getRecordTypeInfosByName();
        System.debug('rtMapByName ===='+rtMapByName );
        Schema.RecordTypeInfo rtByName1 =  rtMapByName.get('Pending Customer Request');
        System.debug('************'+rtByName1);
        //Schema.RecordTypeInfo rtByName2 =  rtMapByName.get('Pending customer request');
        //Schema.RecordTypeInfo rtByName3 =  rtMapByName.get('Pending customer request');
        
        Set<Id> recTypeIds = new Set<Id>();
        recTypeIds.add(rtByName1.getRecordTypeId());
        //recTypeIds.add(rtByName2.getRecordTypeId());
        //recTypeIds.add(rtByName3.getRecordTypeId());
        
        for(Account accObj: Trigger.new){
            if(Trigger.isInsert){
                if(recTypeIds.contains(accObj.RecordTypeId) && accObj.GE_PW_Existing_Customer_New_Address__c != null){
                    existingCustomerIds.add(accObj.GE_PW_Existing_Customer_New_Address__c);    
                }
                if(recTypeIds.contains(accObj.RecordTypeId) && accObj.GE_HQ_New_Account_Country__c !=null ){
                    newReqCountries.add(accObj.GE_HQ_New_Account_Country__c);   
                }
                
            }                
            if(Trigger.isUpdate){
                if(recTypeIds.contains(accObj.RecordTypeId) && accObj.GE_PW_Existing_Customer_New_Address__c != null && Trigger.newMap.get(accObj.id).GE_PW_Existing_Customer_New_Address__c != Trigger.oldMap.get(accObj.id).GE_PW_Existing_Customer_New_Address__c){
                    existingCustomerIds.add(accObj.GE_PW_Existing_Customer_New_Address__c);  
                }
                if(recTypeIds.contains(accObj.RecordTypeId) && accObj.GE_PW_Country_Quote_To_Sold_To_HQ__c !=null && accObj.GE_PW_Country_Quote_To_Sold_To_HQ__c != '' && Trigger.newMap.get(accObj.id).GE_PW_Country_Quote_To_Sold_To_HQ__c != Trigger.oldMap.get(accObj.id).GE_PW_Country_Quote_To_Sold_To_HQ__c){
                    newReqCountries.add(accObj.GE_PW_Country_Quote_To_Sold_To_HQ__c);  
                    System.debug('****Quote To Country****'+ accObj.GE_PW_Country_Quote_To_Sold_To_HQ__c);
                }
                if(recTypeIds.contains(accObj.RecordTypeId) && accObj.GE_HQ_New_Account_Country__c !=null && accObj.GE_HQ_New_Account_Country__c != '' && Trigger.newMap.get(accObj.id).GE_HQ_New_Account_Country__c != Trigger.oldMap.get(accObj.id).GE_HQ_New_Account_Country__c){
                    newReqCountries.add(accObj.GE_HQ_New_Account_Country__c);
                    System.debug('****New Country****'+ accObj.GE_HQ_New_Account_Country__c);
                }
                
            }            
            
        }
        if(existingCustomerIds.size()>0){
            for(Account accObj: [select id, name from Account where id in: existingCustomerIds]){
                existingCustomerIdsNames.put(accObj.id, accObj.name);  
            } 
            for(Account accObj: Trigger.new){
                accObj.name = existingCustomerIdsNames.get(accObj.GE_PW_Existing_Customer_New_Address__c);
            }
        }
        if(newReqCountries.size()>0){
            List<GE_PW_CMFtoISOCountryName__c> NewReqCMFCountryObj = [select id, GE_PW_CMF_Name__c, GE_PW_AML_Name__c, GE_PW_Country__c, GE_PW_Country_Name__c, GE_PW_ISO_Code__c from GE_PW_CMFtoISOCountryName__c where GE_PW_CMF_Name__c in: newReqCountries];
        
            Map<String,String> CountryToISOCode = new Map<String, String>();
            for(GE_PW_CMFtoISOCountryName__c NewReqCMFCObj : NewReqCMFCountryObj){
                CountryToISOCode.put(NewReqCMFCObj.GE_PW_CMF_Name__c, NewReqCMFCObj.GE_PW_ISO_Code__c);
            }
            
            if(CountryToISOCode.size()>0){
                for(Account accObj: Trigger.new){
                    if(CountryToISOCode.get(accObj.GE_HQ_New_Account_Country__c) != null){
                        accObj.GE_HQ_Country_Code__c = CountryToISOCode.get(accObj.GE_HQ_New_Account_Country__c);
                    }
                }
            }
        }                    
    }
    if(Trigger.isUpdate){
    
        Set<Id> accIds = new Set<Id>();
        //Map<Id,RecordType> recTypeIds = new Map<Id,RecordType>([select id from RecordType where DeveloperName in ('GE_PW_New_Customer_Request_Step_2' , 'GE_PW_New_Customer_Request_Step_3') and SobjectType = 'Account']);
        Schema.DescribeSObjectResult d = Schema.SObjectType.Account; 
        Map<String,Schema.RecordTypeInfo> rtMapByName = d.getRecordTypeInfosByName();
        
        Schema.RecordTypeInfo rtByName2 =  rtMapByName.get('Pending Customer Request');
        //Schema.RecordTypeInfo rtByName3 =  rtMapByName.get('Pending customer request');
        
        Set<Id> recTypeIds = new Set<Id>();
        
        recTypeIds.add(rtByName2.getRecordTypeId());
        //recTypeIds.add(rtByName3.getRecordTypeId());
        
        for(Account accObj: Trigger.new){
            if(recTypeIds.contains(accObj.RecordTypeId)){
                accIds.add(accObj.id);   
            }
        }
   
    if(accIds.size()>0){
        for(Id accId: accIds){
            if(Trigger.newMap.get(accId).RecordTypeId == Trigger.oldMap.get(accId).RecordTypeId){
            if( (Trigger.newMap.get(accId).GE_PW_Street_Quote_To_Sold_To_HQ__c != Trigger.oldMap.get(accId).GE_PW_Street_Quote_To_Sold_To_HQ__c) ){
                Trigger.newMap.get(accId).GE_HQ_New_Account_Street__c = Trigger.newMap.get(accId).GE_PW_Street_Quote_To_Sold_To_HQ__c;
                Trigger.newMap.get(accId).ShippingStreet = Trigger.newMap.get(accId).GE_PW_Street_Quote_To_Sold_To_HQ__c;
                
                if(Trigger.newMap.get(accId).GE_PW_Same_as_Quote_To_Sold_To_HQ_BillTo__c == true){
                    Trigger.newMap.get(accId).GE_PW_Street_Bill_To__c = Trigger.newMap.get(accId).GE_PW_Street_Quote_To_Sold_To_HQ__c;    
                }
                
                if(Trigger.newMap.get(accId).GE_PW_Same_as_Quote_To_Sold_To_HQ_ShipTo__c == true){
                    Trigger.newMap.get(accId).GE_PW_Street_Ship_To__c = Trigger.newMap.get(accId).GE_PW_Street_Quote_To_Sold_To_HQ__c;    
                }
                
            }
            
            if( (Trigger.newMap.get(accId).GE_PW_City_Quote_To_Sold_To_HQ__c != Trigger.oldMap.get(accId).GE_PW_City_Quote_To_Sold_To_HQ__c) ){
                Trigger.newMap.get(accId).GE_HQ_New_Account_City__c = Trigger.newMap.get(accId).GE_PW_City_Quote_To_Sold_To_HQ__c;
                Trigger.newMap.get(accId).ShippingCity = Trigger.newMap.get(accId).GE_PW_City_Quote_To_Sold_To_HQ__c;
                
                if(Trigger.newMap.get(accId).GE_PW_Same_as_Quote_To_Sold_To_HQ_BillTo__c == true){
                    Trigger.newMap.get(accId).GE_PW_City_Bill_To__c = Trigger.newMap.get(accId).GE_PW_City_Quote_To_Sold_To_HQ__c;    
                }
                
                if(Trigger.newMap.get(accId).GE_PW_Same_as_Quote_To_Sold_To_HQ_ShipTo__c == true){
                    Trigger.newMap.get(accId).GE_PW_City_Ship_To__c = Trigger.newMap.get(accId).GE_PW_City_Quote_To_Sold_To_HQ__c;    
                }
            
            }
            
            if( (Trigger.newMap.get(accId).GE_PW_State_Province_Quote_To_Sold_To_HQ__c != Trigger.oldMap.get(accId).GE_PW_State_Province_Quote_To_Sold_To_HQ__c) ){
                Trigger.newMap.get(accId).GE_HQ_New_Account_State_Province__c = Trigger.newMap.get(accId).GE_PW_State_Province_Quote_To_Sold_To_HQ__c;
                Trigger.newMap.get(accId).ShippingState = Trigger.newMap.get(accId).GE_PW_State_Province_Quote_To_Sold_To_HQ__c;
                
                if(Trigger.newMap.get(accId).GE_PW_Same_as_Quote_To_Sold_To_HQ_BillTo__c == true){
                    Trigger.newMap.get(accId).GE_PW_State_Province_Bill_To__c  = Trigger.newMap.get(accId).GE_PW_State_Province_Quote_To_Sold_To_HQ__c;    
                }
                
                if(Trigger.newMap.get(accId).GE_PW_Same_as_Quote_To_Sold_To_HQ_ShipTo__c == true){
                    Trigger.newMap.get(accId).GE_PW_State_Province_Ship_To__c = Trigger.newMap.get(accId).GE_PW_State_Province_Quote_To_Sold_To_HQ__c;    
                }
            
            }
            
            if( (Trigger.newMap.get(accId).GE_PW_Zip_Postal_Code_Quote_To_Sold_ToHQ__c != Trigger.oldMap.get(accId).GE_PW_Zip_Postal_Code_Quote_To_Sold_ToHQ__c) ){
                Trigger.newMap.get(accId).GE_HQ_New_Account_Zip_Postal_Code__c = Trigger.newMap.get(accId).GE_PW_Zip_Postal_Code_Quote_To_Sold_ToHQ__c;
                Trigger.newMap.get(accId).ShippingPostalCode = Trigger.newMap.get(accId).GE_PW_Zip_Postal_Code_Quote_To_Sold_ToHQ__c;
                
                if(Trigger.newMap.get(accId).GE_PW_Same_as_Quote_To_Sold_To_HQ_BillTo__c == true){
                    Trigger.newMap.get(accId).GE_PW_Zip_Postal_Code_Bill_To__c = Trigger.newMap.get(accId).GE_PW_Zip_Postal_Code_Quote_To_Sold_ToHQ__c;    
                }
                
                if(Trigger.newMap.get(accId).GE_PW_Same_as_Quote_To_Sold_To_HQ_ShipTo__c == true){
                    Trigger.newMap.get(accId).GE_PW_Zip_Postal_Code_Ship_To__c = Trigger.newMap.get(accId).GE_PW_Zip_Postal_Code_Quote_To_Sold_ToHQ__c;    
                }
            
            }

 
            if( (Trigger.newMap.get(accId).GE_PW_Country_Quote_To_Sold_To_HQ__c != Trigger.oldMap.get(accId).GE_PW_Country_Quote_To_Sold_To_HQ__c) ){
                Trigger.newMap.get(accId).GE_HQ_New_Account_Country__c = Trigger.newMap.get(accId).GE_PW_Country_Quote_To_Sold_To_HQ__c;
                Trigger.newMap.get(accId).ShippingCountry = Trigger.newMap.get(accId).GE_PW_Country_Quote_To_Sold_To_HQ__c;
                
                if(Trigger.newMap.get(accId).GE_PW_Same_as_Quote_To_Sold_To_HQ_BillTo__c == true){
                    Trigger.newMap.get(accId).GE_PW_Country_Bill_To__c = Trigger.newMap.get(accId).GE_PW_Country_Quote_To_Sold_To_HQ__c;    
                }
                
                if(Trigger.newMap.get(accId).GE_PW_Same_as_Quote_To_Sold_To_HQ_ShipTo__c == true){
                    Trigger.newMap.get(accId).GE_PW_Country_Ship_To__c = Trigger.newMap.get(accId).GE_PW_Country_Quote_To_Sold_To_HQ__c;    
                }
            
            }
            
            if( (Trigger.newMap.get(accId).GE_PW_Latitude_Quote_To_Sold_To_HQ__c != Trigger.oldMap.get(accId).GE_PW_Latitude_Quote_To_Sold_To_HQ__c) ){
                Trigger.newMap.get(accId).GE_HQ_Latitude__c = Trigger.newMap.get(accId).GE_PW_Latitude_Quote_To_Sold_To_HQ__c;
                
                if(Trigger.newMap.get(accId).GE_PW_Same_as_Quote_To_Sold_To_HQ_BillTo__c == true){
                    Trigger.newMap.get(accId).GE_PW_Latitude_Bill_To__c = Trigger.newMap.get(accId).GE_PW_Latitude_Quote_To_Sold_To_HQ__c;    
                }
                
                if(Trigger.newMap.get(accId).GE_PW_Same_as_Quote_To_Sold_To_HQ_ShipTo__c == true){
                    Trigger.newMap.get(accId).GE_PW_Latitude_Ship_To__c = Trigger.newMap.get(accId).GE_PW_Latitude_Quote_To_Sold_To_HQ__c;    
                }
            
            }
            
            if( (Trigger.newMap.get(accId).GE_PW_Longitude_Quote_To_Sold_To_HQ__c != Trigger.oldMap.get(accId).GE_PW_Longitude_Quote_To_Sold_To_HQ__c) ){
                Trigger.newMap.get(accId).GE_HQ_Longitude__c = Trigger.newMap.get(accId).GE_PW_Longitude_Quote_To_Sold_To_HQ__c;
                
                if(Trigger.newMap.get(accId).GE_PW_Same_as_Quote_To_Sold_To_HQ_BillTo__c == true){
                    Trigger.newMap.get(accId).GE_PW_Longitude_Bill_To__c = Trigger.newMap.get(accId).GE_PW_Longitude_Quote_To_Sold_To_HQ__c;    
                }
                
                if(Trigger.newMap.get(accId).GE_PW_Same_as_Quote_To_Sold_To_HQ_ShipTo__c == true){
                    Trigger.newMap.get(accId).GE_PW_Longitude_Ship_To__c = Trigger.newMap.get(accId).GE_PW_Longitude_Quote_To_Sold_To_HQ__c;    
                }
            
            }
            
            if( (Trigger.newMap.get(accId).GE_PW_Phone_Quote_To_Sold_To_HQ__c != Trigger.oldMap.get(accId).GE_PW_Phone_Quote_To_Sold_To_HQ__c) ){
                Trigger.newMap.get(accId).GE_PW_Phone_New_Request__c = Trigger.newMap.get(accId).GE_PW_Phone_Quote_To_Sold_To_HQ__c;
                Trigger.newMap.get(accId).Phone = Trigger.newMap.get(accId).GE_PW_Phone_Quote_To_Sold_To_HQ__c;
                
                if(Trigger.newMap.get(accId).GE_PW_Same_as_Quote_To_Sold_To_HQ_BillTo__c == true){
                    Trigger.newMap.get(accId).GE_PW_Phone_Bill_To__c = Trigger.newMap.get(accId).GE_PW_Phone_Quote_To_Sold_To_HQ__c;    
                }
                
                if(Trigger.newMap.get(accId).GE_PW_Same_as_Quote_To_Sold_To_HQ_ShipTo__c == true){
                    Trigger.newMap.get(accId).GE_PW_Phone_Ship_To__c = Trigger.newMap.get(accId).GE_PW_Phone_Quote_To_Sold_To_HQ__c;    
                }
            
            }
            
            if( (Trigger.newMap.get(accId).GE_PW_DB_DUNS_QuoteTo__c != Trigger.oldMap.get(accId).GE_PW_DB_DUNS_QuoteTo__c) ){
                Trigger.newMap.get(accId).GE_PW_DB_DUNS_New_Request__c = Trigger.newMap.get(accId).GE_PW_DB_DUNS_QuoteTo__c;
                Trigger.newMap.get(accId).GE_HQ_DB_DUNS__c = Trigger.newMap.get(accId).GE_PW_DB_DUNS_QuoteTo__c;
                
                if(Trigger.newMap.get(accId).GE_PW_Same_as_Quote_To_Sold_To_HQ_BillTo__c == true){
                    Trigger.newMap.get(accId).GE_PW_DB_DUNS_BillTo__c = Trigger.newMap.get(accId).GE_PW_DB_DUNS_QuoteTo__c;    
                }
                
                if(Trigger.newMap.get(accId).GE_PW_Same_as_Quote_To_Sold_To_HQ_ShipTo__c == true){
                    Trigger.newMap.get(accId).GE_PW_DB_DUNS_ShipTo__c = Trigger.newMap.get(accId).GE_PW_DB_DUNS_QuoteTo__c;    
                }
            
            }
          }  
            if(Trigger.newMap.get(accId).GE_PW_Same_as_Quote_To_Sold_To_HQ_BillTo__c == true && Trigger.oldMap.get(accId).GE_PW_Same_as_Quote_To_Sold_To_HQ_BillTo__c != true){
                if(Trigger.newMap.get(accId).GE_PW_Street_Quote_To_Sold_To_HQ__c!=null)
                    Trigger.newMap.get(accId).GE_PW_Street_Bill_To__c = Trigger.newMap.get(accId).GE_PW_Street_Quote_To_Sold_To_HQ__c; 
                if(Trigger.newMap.get(accId).GE_PW_City_Quote_To_Sold_To_HQ__c!=null)
                    Trigger.newMap.get(accId).GE_PW_City_Bill_To__c = Trigger.newMap.get(accId).GE_PW_City_Quote_To_Sold_To_HQ__c;
                if(Trigger.newMap.get(accId).GE_PW_State_Province_Quote_To_Sold_To_HQ__c!=null)
                    Trigger.newMap.get(accId).GE_PW_State_Province_Bill_To__c = Trigger.newMap.get(accId).GE_PW_State_Province_Quote_To_Sold_To_HQ__c;
                if(Trigger.newMap.get(accId).GE_PW_Zip_Postal_Code_Quote_To_Sold_ToHQ__c!=null)
                    Trigger.newMap.get(accId).GE_PW_Zip_Postal_Code_Bill_To__c = Trigger.newMap.get(accId).GE_PW_Zip_Postal_Code_Quote_To_Sold_ToHQ__c; 
                if(Trigger.newMap.get(accId).GE_PW_Country_Quote_To_Sold_To_HQ__c!=null)
                    Trigger.newMap.get(accId).GE_PW_Country_Bill_To__c = Trigger.newMap.get(accId).GE_PW_Country_Quote_To_Sold_To_HQ__c;
                if(Trigger.newMap.get(accId).GE_PW_Latitude_Quote_To_Sold_To_HQ__c!=null)
                    Trigger.newMap.get(accId).GE_PW_Latitude_Bill_To__c = Trigger.newMap.get(accId).GE_PW_Latitude_Quote_To_Sold_To_HQ__c;
                if(Trigger.newMap.get(accId).GE_PW_Longitude_Quote_To_Sold_To_HQ__c!=null)
                    Trigger.newMap.get(accId).GE_PW_Longitude_Bill_To__c = Trigger.newMap.get(accId).GE_PW_Longitude_Quote_To_Sold_To_HQ__c; 
                if(Trigger.newMap.get(accId).GE_PW_Phone_Quote_To_Sold_To_HQ__c!=null)
                    Trigger.newMap.get(accId).GE_PW_Phone_Bill_To__c = Trigger.newMap.get(accId).GE_PW_Phone_Quote_To_Sold_To_HQ__c;
                if(Trigger.newMap.get(accId).GE_PW_DB_DUNS_QuoteTo__c!=null)                    
                    Trigger.newMap.get(accId).GE_PW_DB_DUNS_BillTo__c = Trigger.newMap.get(accId).GE_PW_DB_DUNS_QuoteTo__c; 
            }
            
                if(Trigger.newMap.get(accId).GE_PW_Same_as_Quote_To_Sold_To_HQ_ShipTo__c ==true && Trigger.oldMap.get(accId).GE_PW_Same_as_Quote_To_Sold_To_HQ_ShipTo__c !=true){
                    if(Trigger.newMap.get(accId).GE_PW_Street_Quote_To_Sold_To_HQ__c!=null)
                        Trigger.newMap.get(accId).GE_PW_Street_Ship_To__c = Trigger.newMap.get(accId).GE_PW_Street_Quote_To_Sold_To_HQ__c; 
                    if(Trigger.newMap.get(accId).GE_PW_City_Quote_To_Sold_To_HQ__c!=null)
                        Trigger.newMap.get(accId).GE_PW_City_Ship_To__c = Trigger.newMap.get(accId).GE_PW_City_Quote_To_Sold_To_HQ__c;
                    if(Trigger.newMap.get(accId).GE_PW_State_Province_Quote_To_Sold_To_HQ__c!=null)
                        Trigger.newMap.get(accId).GE_PW_State_Province_Ship_To__c = Trigger.newMap.get(accId).GE_PW_State_Province_Quote_To_Sold_To_HQ__c;
                    if(Trigger.newMap.get(accId).GE_PW_Zip_Postal_Code_Quote_To_Sold_ToHQ__c!=null)
                        Trigger.newMap.get(accId).GE_PW_Zip_Postal_Code_Ship_To__c = Trigger.newMap.get(accId).GE_PW_Zip_Postal_Code_Quote_To_Sold_ToHQ__c; 
                    if(Trigger.newMap.get(accId).GE_PW_Country_Quote_To_Sold_To_HQ__c!=null)
                        Trigger.newMap.get(accId).GE_PW_Country_Ship_To__c = Trigger.newMap.get(accId).GE_PW_Country_Quote_To_Sold_To_HQ__c;
                    if(Trigger.newMap.get(accId).GE_PW_Latitude_Quote_To_Sold_To_HQ__c!=null)
                        Trigger.newMap.get(accId).GE_PW_Latitude_Ship_To__c = Trigger.newMap.get(accId).GE_PW_Latitude_Quote_To_Sold_To_HQ__c;
                    if(Trigger.newMap.get(accId).GE_PW_Longitude_Quote_To_Sold_To_HQ__c!=null)
                        Trigger.newMap.get(accId).GE_PW_Longitude_Ship_To__c = Trigger.newMap.get(accId).GE_PW_Longitude_Quote_To_Sold_To_HQ__c; 
                    if(Trigger.newMap.get(accId).GE_PW_Phone_Quote_To_Sold_To_HQ__c!=null)
                        Trigger.newMap.get(accId).GE_PW_Phone_Ship_To__c = Trigger.newMap.get(accId).GE_PW_Phone_Quote_To_Sold_To_HQ__c;
                     if(Trigger.newMap.get(accId).GE_PW_DB_DUNS_QuoteTo__c!=null)                    
                        Trigger.newMap.get(accId).GE_PW_DB_DUNS_ShipTo__c = Trigger.newMap.get(accId).GE_PW_DB_DUNS_QuoteTo__c;          
            }
            if(Trigger.newMap.get(accId).GE_PW_Send_to_CMF_Bill_To__c != true && Trigger.newMap.get(accId).GE_PW_Send_to_CMF_Quote_to_Sold_To_HQ__c != true && Trigger.newMap.get(accId).GE_PW_Send_to_CMF_Ship_To__c != true){
                Trigger.newMap.get(accId).GE_HQ_Site_Use_Code__c = 'SHIP_TO';
                if(Trigger.newMap.get(accId).GE_PW_Same_as_Quote_To_Sold_To_HQ_BillTo__c == true)
                    Trigger.newMap.get(accId).GE_HQ_Site_Use_Code__c = 'BOTH';
            
                else if(Trigger.newMap.get(accId).GE_PW_Same_as_Quote_To_Sold_To_HQ_ShipTo__c ==true)
                    Trigger.newMap.get(accId).GE_HQ_Site_Use_Code__c = 'SHIP_TO';
                
            }
        }
       }
    }        
    }
}