/*
------------------------------------------------------------------------------------------------------------------------------------
Requirement Number: R-18900
Build Card Number: S-14391
Created By: Mounika Nellutla
Business: OG D&S > Artificial Lift. (Servicemax D&S) 
Purpose:  If User is modifying Status, Location, Shipped to or Shipped From field on Installed Product Object a new Record 
          should be created in Equipment Data Object with Record Type Equipment Data History. It should contain old and new values of
          the Fields mentioned earlier.
Trigger: CreateEquipDataHistory
TestClass: 
-------------------------------------------------------------------------------------------------------------------------------------
*/
public without sharing class GE_AL_CreateEquipHitoryTriggerHandler {
public static Boolean isFirstTime = true;

    public static void OnAfterUpdate(List<SVMXC__Installed_Product__c> installprodList, List<SVMXC__Installed_Product__c> oldInstallProdList ){     
    List<GE_AL_Equipment_Data__c> EquipDataList = new List <GE_AL_Equipment_Data__c>();
    Schema.DescribeSObjectResult des = Schema.SObjectType.SVMXC__Installed_Product__c; 
    Map<String,Schema.RecordTypeInfo> rtMapByName = des.getRecordTypeInfosByName();
    Schema.RecordTypeInfo rtByName =  rtMapByName.get('GE OG D&S Artificial Lift');
    Id installprodRT = rtByName.getRecordTypeId(); 
    Datetime dt=Datetime.now();
    
    Schema.DescribeSObjectResult des1 = Schema.SObjectType.GE_AL_Equipment_Data__c; 
    Map<String,Schema.RecordTypeInfo> rtMapByName1 = des1.getRecordTypeInfosByName();
    Schema.RecordTypeInfo rtByName1 =  rtMapByName1.get('Equipment Data History');
    Id equipHistoryDataRT = rtByName1.getRecordTypeId();

        for(SVMXC__Installed_Product__c installprod : installprodList)
            {   
                for(SVMXC__Installed_Product__c oldInstallProd : oldInstallProdList)
                {
                
                if(installprod.id==oldInstallProd.id){
        
                if(installprod.RecordTypeId == installprodRT && installprod.SVMXC__Status__c!= oldInstallProd.SVMXC__Status__c)
                {
                    GE_AL_Equipment_Data__c equipdata = new GE_AL_Equipment_Data__c();
                    equipdata.RecordTypeid = equipHistoryDataRT;
                    equipdata.Name = 'Equipment Data History';
                    equipdata.GE_AL_EquipHistory_Serial_Number__c= installprod.id;
                    equipdata.GE_AL_Run_Days__c = String.valueof(installprod.GE_AL_Store_Run_Days__c);
                    equipdata.GE_AL_Event_Date__c = Datetime.now();
                    equipdata.GE_AL_Current_Location__c = oldInstallProd.GE_AL_Location_Name__c;
                    equipdata.GE_AL_Shipped_Date_and_Time__c = installprod.GE_AL_Shipped_Date_and_Time__c;
                    equipdata.GE_AL_Shipper__c =  installprod.GE_AL_Shipper_Number__c;
                    equipdata.GE_AL_Receiver_Number__c = installprod.GE_AL_Receiver_Number__c;
                    equipdata.GE_AL_From_Old_Value__c = oldInstallProd.SVMXC__Status__c;
                    equipdata.GE_AL_To_New_Value__c = installprod.SVMXC__Status__c;
                    equipdata.GE_AL_Event_Type__c = 'Status Change'; 
                    equipdata.GE_AL_Operator__c = String.valueof(installprod.Createdby);
                    equipdata.GE_AL_Information__c = 'Status changed from '+ oldInstallProd.SVMXC__Status__c + ' to ' + installprod.SVMXC__Status__c;
                    
                    EquipDataList.add(equipdata); 
                           
                }
                
                 if(installprod.RecordTypeId == installprodRT && installprod.SVMXC__Site__c != oldInstallProd.SVMXC__Site__c )
                {
                    GE_AL_Equipment_Data__c equipdata = new GE_AL_Equipment_Data__c();
                    equipdata.RecordTypeid = equipHistoryDataRT;
                    equipdata.Name = 'Equipment Data History';
                    equipdata.GE_AL_EquipHistory_Serial_Number__c= installprod.id;
                    equipdata.GE_AL_Run_Days__c = String.valueof(installprod.GE_AL_Store_Run_Days__c);
                    equipdata.GE_AL_Event_Date__c = Datetime.now();
                    equipdata.GE_AL_Current_Location__c = oldInstallProd.GE_AL_Location_Name__c;
                    equipdata.GE_AL_Shipped_Date_and_Time__c = installprod.GE_AL_Shipped_Date_and_Time__c;
                    equipdata.GE_AL_Shipper__c =  installprod.GE_AL_Shipper_Number__c;
                    equipdata.GE_AL_Receiver_Number__c = installprod.GE_AL_Receiver_Number__c;
                    equipdata.GE_AL_From_Old_Value__c = oldInstallProd.GE_AL_Location_Name__c;
                    equipdata.GE_AL_To_New_Value__c = installprod.GE_AL_Location_Name__c;
                    equipdata.GE_AL_Event_Type__c = 'LocChg';
                    equipdata.GE_AL_Information__c = 'Location changed from '+ oldInstallProd.GE_AL_Location_Name__c + ' to ' + installprod.GE_AL_Location_Name__c;
                    
                    EquipDataList.add(equipdata);
                   
            
                }
                if(installprod.RecordTypeId == installprodRT &&  installprod.GE_AL_Shipped_From__c != oldInstallProd.GE_AL_Shipped_From__c)
                {
                    GE_AL_Equipment_Data__c equipdata = new GE_AL_Equipment_Data__c();
                    equipdata.RecordTypeid = equipHistoryDataRT;
                    equipdata.Name = 'Equipment Data History';
                    equipdata.GE_AL_EquipHistory_Serial_Number__c= installprod.id;
                    equipdata.GE_AL_Run_Days__c = String.valueof(installprod.GE_AL_Store_Run_Days__c);
                    equipdata.GE_AL_Event_Date__c = Datetime.now();
                    equipdata.GE_AL_Current_Location__c = oldInstallProd.GE_AL_Location_Name__c;
                    equipdata.GE_AL_Shipped_Date_and_Time__c = installprod.GE_AL_Shipped_Date_and_Time__c;
                    equipdata.GE_AL_Shipper__c =  installprod.GE_AL_Shipper_Number__c;
                    equipdata.GE_AL_Receiver_Number__c = installprod.GE_AL_Receiver_Number__c;
                    equipdata.GE_AL_From_Old_Value__c = oldInstallProd.GE_AL_Shipped_From_Location_Name__c;
                    equipdata.GE_AL_To_New_Value__c = installprod.GE_AL_Shipped_From_Location_Name__c;
                    equipdata.GE_AL_Event_Type__c = 'LocChg'; 
                    equipdata.GE_AL_Information__c = 'Shipped From Location changed from '+ oldInstallProd.GE_AL_Shipped_From_Location_Name__c + ' to ' + installprod.GE_AL_Shipped_From_Location_Name__c;                                 
                    EquipDataList.add(equipdata);

                }
                if(installprod.RecordTypeId == installprodRT && installprod.GE_AL_Shipped_To__c != oldInstallProd.GE_AL_Shipped_To__c )
                {
                    GE_AL_Equipment_Data__c equipdata = new GE_AL_Equipment_Data__c();
                    equipdata.RecordTypeid = equipHistoryDataRT;
                    equipdata.Name = 'Equipment Data History';
                    equipdata.GE_AL_EquipHistory_Serial_Number__c= installprod.id;
                    equipdata.GE_AL_Run_Days__c = String.valueof(installprod.GE_AL_Store_Run_Days__c);
                    equipdata.GE_AL_Event_Date__c = Datetime.now();
                    equipdata.GE_AL_Current_Location__c = oldInstallProd.GE_AL_Location_Name__c;
                    equipdata.GE_AL_Shipped_Date_and_Time__c = installprod.GE_AL_Shipped_Date_and_Time__c;
                    equipdata.GE_AL_Shipper__c =  installprod.GE_AL_Shipper_Number__c;
                    equipdata.GE_AL_Receiver_Number__c = installprod.GE_AL_Receiver_Number__c;
                    equipdata.GE_AL_From_Old_Value__c = oldInstallProd.GE_AL_Shipped_To_Location_Name__c;
                    equipdata.GE_AL_To_New_Value__c = installprod.GE_AL_Shipped_To_Location_Name__c;
                    equipdata.GE_AL_Event_Type__c = 'LocChg';
                    equipdata.GE_AL_Information__c = 'Shipped to Location changed from '+ oldInstallProd.GE_AL_Shipped_To_Location_Name__c + ' to ' + installprod.GE_AL_Shipped_To_Location_Name__c;        
                    EquipDataList.add(equipdata);
                            
                }
                // Added new code for the Requirement : R-21958 By Abhijeet Virgaonkar
                if(installprod.RecordTypeId == installprodRT && installprod.GE_AL_Shipper_Number__c != oldInstallProd.GE_AL_Shipper_Number__c )
                {
                    GE_AL_Equipment_Data__c equipdata = new GE_AL_Equipment_Data__c();
                    equipdata.RecordTypeid = equipHistoryDataRT;
                    equipdata.Name = 'Equipment Data History';
                    equipdata.GE_AL_EquipHistory_Serial_Number__c= installprod.id;
                    equipdata.GE_AL_Run_Days__c = String.valueof(installprod.GE_AL_Store_Run_Days__c);
                    equipdata.GE_AL_Event_Date__c = Datetime.now();
                    equipdata.GE_AL_Current_Location__c = oldInstallProd.GE_AL_Location_Name__c;
                    equipdata.GE_AL_Shipped_Date_and_Time__c = installprod.GE_AL_Shipped_Date_and_Time__c;
                    equipdata.GE_AL_Shipper__c =  installprod.GE_AL_Shipper_Number__c;
                    equipdata.GE_AL_Receiver_Number__c = installprod.GE_AL_Receiver_Number__c;
                    equipdata.GE_AL_From_Old_Value__c = String.valueof(oldInstallProd.GE_AL_Shipper_Number__c);
                    equipdata.GE_AL_To_New_Value__c = String.valueof(installprod.GE_AL_Shipper_Number__c);
                    equipdata.GE_AL_Event_Type__c = 'Shipper Number Change';
                    equipdata.GE_AL_Information__c = 'Shipper Number changed from '+ oldInstallProd.GE_AL_Shipper_Number__c + ' to ' + installprod.GE_AL_Shipper_Number__c;        
                    EquipDataList.add(equipdata);
                            
                }
                
                if(installprod.RecordTypeId == installprodRT && installprod.GE_AL_Receiver_Number__c != oldInstallProd.GE_AL_Receiver_Number__c )
                {
                    GE_AL_Equipment_Data__c equipdata = new GE_AL_Equipment_Data__c();
                    equipdata.RecordTypeid = equipHistoryDataRT;
                    equipdata.Name = 'Equipment Data History';
                    equipdata.GE_AL_EquipHistory_Serial_Number__c= installprod.id;
                    equipdata.GE_AL_Run_Days__c = String.valueof(installprod.GE_AL_Store_Run_Days__c);
                    equipdata.GE_AL_Event_Date__c = Datetime.now();
                    equipdata.GE_AL_Current_Location__c = oldInstallProd.GE_AL_Location_Name__c;
                    equipdata.GE_AL_Shipped_Date_and_Time__c = installprod.GE_AL_Shipped_Date_and_Time__c;
                    equipdata.GE_AL_Shipper__c =  installprod.GE_AL_Shipper_Number__c;
                    equipdata.GE_AL_Receiver_Number__c = installprod.GE_AL_Receiver_Number__c;
                    equipdata.GE_AL_From_Old_Value__c = String.valueof(oldInstallProd.GE_AL_Receiver_Number__c);
                    equipdata.GE_AL_To_New_Value__c = String.valueof(installprod.GE_AL_Receiver_Number__c);
                    equipdata.GE_AL_Event_Type__c = 'Receiver Number Change';
                    equipdata.GE_AL_Information__c = 'Receiver Number changed from '+ oldInstallProd.GE_AL_Receiver_Number__c + ' to ' + installprod.GE_AL_Receiver_Number__c;        
                    EquipDataList.add(equipdata);
                            
                }
                // code ends for R-21958                   
            }
          }
       }
       if(!EquipDataList.isEmpty())         
                 insert EquipDataList;
            
    }
        
 public static void onbeforeInsertUpdate(List<SVMXC__Installed_Product__c> ipRec ){
Id SSEquipId = Schema.SObjectType.SVMXC__Installed_Product__c.getRecordTypeInfosByName().get('Subsea Equipment').getRecordTypeId();
Id SSToolsId = Schema.SObjectType.SVMXC__Installed_Product__c.getRecordTypeInfosByName().get('Subsea Spares').getRecordTypeId();
Id SSSpareId = Schema.SObjectType.SVMXC__Installed_Product__c.getRecordTypeInfosByName().get('Subsea Tools').getRecordTypeId();

        for(SVMXC__Installed_Product__c rec : ipRec){
            if(rec.recordtypeId == SSEquipId || rec.recordtypeId == SSToolsId || rec.recordtypeId == SSSpareId)
                rec.duplicate__C = rec.Name + rec.SVMXC__Product__c + rec.RecordtypeId; 
            else
                rec.duplicate__C = rec.Id;
        } 
    }       
        
   /* public static void countInstalledProductOnAccount(set<Id> accountIDset){
        
        list<Account> accountUpdateList = new list<Account>();
        Set<String> developerNameSet = new set<String>{'GE_DS_BN','GE_DS_CS','GE_DS_IT_Field_Rad','GE_DS_IT_Film','GE_DS_IT_PHX','GE_DS_IT_PHX_Child','GE_DS_IT_PHX_GChild','GE_DS_IT_SEIFERT_TM','GE_DS_IT_UTTM','GE_DS_MS_Flow','GE_DS_MS_G_M'};
        Set<Id> DSRecTypeIDSet = new Set<Id>();
        for(Recordtype rt :[Select id from RecordType where Sobjecttype = 'SVMXC__Installed_Product__c' AND isActive = True AND DeveloperName In : developerNameSet]){
            DSRecTypeIDSet.add(rt.id);
        }
            list<Account> accountList = [SELECT id,name,(SELECT id from R00N70000001hzZ0EAI where RecordTypeID IN :DSRecTypeIDSet) from Account where ID IN : accountIDSet];
            for(Account a:accountList){
                a.InstalledProductsCount__c = a.R00N70000001hzZ0EAI.size();
                accountUpdateList.add(a);
            }
        
            if(!accountUpdateList.isEmpty())
                update accountUpdateList;
    }*/
} // End of class GE_AL_CreateEquipHitoryTriggerHandler