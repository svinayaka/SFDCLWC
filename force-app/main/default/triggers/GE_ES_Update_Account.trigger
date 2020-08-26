/*    
Trigger Name      : GE_ES_Update_Account
Purpose/Overview  : Updates the required Account Fields related to the KYC record.
Author            : Jayadev Rath
Test Class        : GE_ES_Update_Account_Test 
Change History    : Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
                  : 3rd Nov 2011  : Jayadev Rath       : Created : Before the KYC process, Account was directly being modified and then submitted to CMF. Now, KYC record is created for Account and the modifications are done here and from KYC, the request is submitted to CMF. So the details on Account has to be updated.
                  : 25th July 2013: Harsh Sharma       : Excluded this trigger logic for new KYC process post split to fix the bug 0000015274.
*/

Trigger GE_ES_Update_Account on GE_PRM_KYC_Termination_Checklist__c (before Update) {

    Schema.DescribeSObjectResult d = Schema.SObjectType.GE_PRM_KYC_Termination_Checklist__c; 
    Map<String,Schema.RecordTypeInfo> rtMapByName = d.getRecordTypeInfosByName();
    Schema.RecordTypeInfo rtByName1 =  rtMapByName.get('GE PW KYC Edit Record Type');
    Schema.RecordTypeInfo rtByName2 =  rtMapByName.get('GE PW KYC Locked Record Type');
    Set<Id> recTypeIds = new Set<Id>();
    recTypeIds.add(rtByName1.getRecordTypeId());
    recTypeIds.add(rtByName2.getRecordTypeId());
    Set<Id> AccIds = new Set<Id>();
    List<Account> AccList = new List<Account>();
    List<Account> UpdAccList = new List<Account>();
    Map<Id,GE_PRM_KYC_Termination_Checklist__c> AccKYCMap = new Map<Id,GE_PRM_KYC_Termination_Checklist__c>();
    For(GE_PRM_KYC_Termination_Checklist__c KycRec: Trigger.New) {
    if(!recTypeIds.contains(KycRec.RecordTypeId)){
        // Add only those Accounts, which belongs to ES KYC (GE_HQ_Account__c field is only used by ES KYC)
        If(KycRec.GE_HQ_Account__c != Null && (KycRec.GE_HQ_VAT_Tax_ID__c != Trigger.oldMap.get(KycRec.Id).GE_HQ_VAT_Tax_ID__c || KycRec.GE_HQ_Phone_Num__c != Trigger.oldMap.get(KycRec.Id).GE_HQ_Phone_Num__c || KycRec.GE_HQ_Bill_To_Street__c != Trigger.oldMap.get(KycRec.Id).GE_HQ_Bill_To_Street__c || KycRec.GE_HQ_Bill_To_City__c != Trigger.oldMap.get(KycRec.Id).GE_HQ_Bill_To_City__c || KycRec.GE_HQ_Bill_To_State__c != Trigger.oldMap.get(KycRec.Id).GE_HQ_Bill_To_State__c || KycRec.GE_HQ_Bill_To_Country__c != Trigger.oldMap.get(KycRec.Id).GE_HQ_Bill_To_Country__c || KycRec.GE_HQ_Bill_To_Zip__c != Trigger.oldMap.get(KycRec.Id).GE_HQ_Bill_To_Zip__c || KycRec.GE_HQ_Ship_To_Street__c != Trigger.oldMap.get(KycRec.Id).GE_HQ_Ship_To_Street__c || KycRec.GE_HQ_Ship_To_City__c != Trigger.oldMap.get(KycRec.Id).GE_HQ_Ship_To_City__c || KycRec.GE_HQ_Ship_To_State__c != Trigger.oldMap.get(KycRec.Id).GE_HQ_Ship_To_State__c || KycRec.GE_HQ_Ship_To_Country__c != Trigger.oldMap.get(KycRec.Id).GE_HQ_Ship_To_Country__c ||KycRec.GE_HQ_Ship_To_Zip__c != Trigger.oldMap.get(KycRec.Id).GE_HQ_Ship_To_Zip__c )) {
            // If any of these above fields in the condtion are changed, then only update the account else no need of updating.
            AccIds.add(KycRec.GE_HQ_Account__c);
            // Add the Account and its corresponding KYC record to the map.
            AccKYCMap.put(KycRec.GE_HQ_Account__c,KYCRec);
        }
    }
    }
    // Fetch all the Account records.
    If(AccIds != Null && AccIds.size() >0) AccList = [Select Id,GE_HQ_Site_Use_Code__c,GE_HQ_Vat_Number__c,GE_HQ_New_Account_City__c,GE_HQ_New_Account_State_Province__c,GE_HQ_New_Account_Country__c,GE_HQ_New_Account_Zip_Postal_Code__c from Account where Id in :AccIds];
    // If any Account exists for update, Overwrite the field values with KYC record's field value.
    If(AccList != Null && AccList.size() > 0) {
        For(Account Acc: AccList) {
            GE_PRM_KYC_Termination_Checklist__c ESKycRec = AccKYCMap.get(Acc.Id);
            Acc.GE_HQ_Vat_Number__c = ESKycRec.GE_HQ_VAT_Tax_ID__c;
            Acc.Phone = ESKycRec.GE_HQ_Phone_Num__c;
            // Set the Reason code on Acc as per selection in KYC (Below line is not used now, If needed reactivate later).
            // Acc.GE_HQ_Vat_Reg_Code__c = (ESKycRec.GE_HQ_Vat_Reason_Code__c == 'Customer Tax Exempt') ? 'Customer Tax-exempt' : ((ESKycRec.GE_HQ_Vat_Reason_Code__c == 'Customer Refusal') ? 'Customer Refusal' : ((ESKycRec.GE_HQ_Vat_Reason_Code__c == 'Non - VAT country')? 'Non – VAT Country' : Null ) );
            //If Acc is bill to type, put all bill to info of KYC to Account, else put the ship to addresses.
            If(Acc.GE_HQ_Site_Use_Code__c =='BILL_TO') {
                Acc.GE_HQ_New_Account_Street__c = ESKycRec.GE_HQ_Bill_To_Street__c;
                Acc.GE_HQ_New_Account_City__c = ESKycRec.GE_HQ_Bill_To_City__c;
                Acc.GE_HQ_New_Account_State_Province__c = ESKycRec.GE_HQ_Bill_To_State__c;
                Acc.GE_HQ_New_Account_Country__c = ESKycRec.GE_HQ_Bill_To_Country__c;
                Acc.GE_HQ_New_Account_Zip_Postal_Code__c = ESKycRec.GE_HQ_Bill_To_Zip__c;
            }
            else {
                Acc.GE_HQ_New_Account_Street__c = ESKycRec.GE_HQ_Ship_To_Street__c;
                Acc.GE_HQ_New_Account_City__c = ESKycRec.GE_HQ_Ship_To_City__c;
                Acc.GE_HQ_New_Account_State_Province__c = ESKycRec.GE_HQ_Ship_To_State__c;
                Acc.GE_HQ_New_Account_Country__c = ESKycRec.GE_HQ_Ship_To_Country__c;
                Acc.GE_HQ_New_Account_Zip_Postal_Code__c = ESKycRec.GE_HQ_Ship_To_Zip__c;
            }
            // Add the Account to the list for update
            UpdAccList.add(Acc);
        }
        // If any accounts are there to update, then update the list.
        If(UpdAccList != Null && UpdAccList.size() >0) Update UpdAccList;
    }
}