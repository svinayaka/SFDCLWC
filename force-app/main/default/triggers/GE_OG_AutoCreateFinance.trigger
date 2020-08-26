/*
Trigger Name: GE_OG_AutoCreateFinance
Author : Malemleima Chanu
Use: Trigger to insert Finance and ERP record whenever a KYC record is created.
Test Class:GE_OG_AutoCreateFinanceTest
Change History    : Date Modified : Developer Name     :  Purpose/Overview of Change
                    15-Oct-2014     Satyanarayana P      14 Major 4 bugs 19086, 19088       
Modified : Added the new Logic the ERP 
Modified : Remove the Logic to create the Finance for the Account modification Process
                    22-Dec-2014     Satyanarayana P     15 Major 1  R-20337 
*/

 trigger GE_OG_AutoCreateFinance on GE_PRM_KYC_Termination_Checklist__c (after insert){

 String KYCType;
 List<GE_OG_Finance_Details__c> finance = new List<GE_OG_Finance_Details__c>();
 List<GE_OG_ERP_Detail__c> ERPs=new List<GE_OG_ERP_Detail__c>();
 List<Account> accToBeupdated = new List<Account>();

 List<GE_PW_CMFtoISOCountryName__c> CMFtoISO=new List<GE_PW_CMFtoISOCountryName__c>([select id,GE_PW_CMF_Name__c,GE_PW_Country__c from GE_PW_CMFtoISOCountryName__c where GE_PW_CMF_Name__c != null]);
 Map<String,String> riskMap=new  Map<String,String>();
 Map<Id,GE_HQ_Country__c> countryMap=new  Map<Id,GE_HQ_Country__c>([select id,name,GE_OG_Finance_Country_Risk__c,GE_OG_Tax_ID_Format__c from GE_HQ_Country__c where GE_OG_Finance_Country_Risk__c != null]);
 Set<Id> accSet=new Set<Id>();
 Set<Id> accModSet=new Set<Id>();
 
 //Account Metadata
 Schema.DescribeSObjectResult accObj = Schema.SObjectType.Account; 
 Map<String,Schema.RecordTypeInfo> accByName = accObj.getRecordTypeInfosByName();
 Schema.RecordTypeInfo rtByName_acc1 =  accByName.get('CMF Approved');
 Schema.RecordTypeInfo rtByName_acc2=  accByName.get('CMF Inactive');
 Id accRecId1=rtByName_acc1.getRecordTypeId();
 Id accRecId2=rtByName_acc2.getRecordTypeId();
 Set<Id> accRecSet=new Set<Id>();
 accRecSet.add(accRecId1);
 accRecSet.add(accRecId2);
 
 //KYC Metadata
 Schema.DescribeSObjectResult kycObj = Schema.SObjectType.GE_PRM_KYC_Termination_Checklist__c; 
 Map<String,Schema.RecordTypeInfo> kycByName = kycObj.getRecordTypeInfosByName();
 Schema.RecordTypeInfo rtByName_kyc1 =  kycByName.get('GE PW KYC Locked Record Type');
 Schema.RecordTypeInfo rtByName_kyc2 =  kycByName.get('GE PW KYC Edit Record Type');
 Id kyc1=rtByName_kyc1.getRecordTypeId();
 Id kyc2=rtByName_kyc2.getRecordTypeId();
 
 // ERP Metadata
 Schema.DescribeSObjectResult erpObj = Schema.SObjectType.GE_OG_ERP_Detail__c; 
 Map<String,Schema.RecordTypeInfo> rtMapByName = erpObj.getRecordTypeInfosByName();
 Schema.RecordTypeInfo rtByName_SAP =  rtMapByName.get('ERP SAP');
 Schema.RecordTypeInfo rtByName_DT =  rtMapByName.get('ERP Downhole Technology');
 Schema.RecordTypeInfo rtByName_Lufkin =  rtMapByName.get('ERP D&S-WPS');// For the Lufkin
 Schema.RecordTypeInfo rtByName_Subsea = rtMapByName.get('ERP Oracle'); //for subsea
 
 Id Sap_Id=rtByName_SAP.getRecordTypeId();
 Id DT_Id=rtByName_DT.getRecordTypeId();
 Id Lufkin_Id=rtByName_Lufkin.getRecordTypeId();
 Id Subsea_Id=rtByName_Subsea.getRecordTypeId();
 GE_OG_ERP_Detail__c erp=new GE_OG_ERP_Detail__c();
     
     for(GE_PW_CMFtoISOCountryName__c cmf:CMFtoISO){
         riskMap.put(cmf.GE_PW_CMF_Name__c,cmf.GE_PW_Country__c);
     }
 
     for(GE_PRM_KYC_Termination_Checklist__c kyc: Trigger.new){
         if(kyc.RecordTypeId==kyc1 || kyc.RecordTypeId==kyc2){
             if(kyc.GE_HQ_Account__c!=null){
                 accSet.add(kyc.GE_HQ_Account__c);
             }
             if(kyc.GE_PW_Acc_Mod_Req__c!=null){
                 accModSet.add(kyc.GE_PW_Acc_Mod_Req__c); 
             }
         }
     }
     
     Map<Id,Account> accMap=new Map<Id,Account>([select id,name,RecordTypeId,GE_OG_Buss_Tier1__c,GE_OG_Buss_Tier2__c,GE_OG_Buss_Tier3__c,GE_OG_Buss_Tier4__c,shippingCountry,BillingCountry,GE_HQ_New_Account_Country__c from Account where id IN :accSet]);
     Map<Id,Account_Request__c> accModMap=new Map<Id,Account_Request__c>([select id,name,GE_HQ_Account__c,GE_HQ_Country__c from Account_Request__c where id IN :accModSet]);
     Map<Id,List<String>> accSubsMap= new Map<Id,List<String>>();
     
     
      for(GE_PRM_KYC_Termination_Checklist__c newKYC: Trigger.new){
      
      if((newKYC.RecordTypeId==kyc1 || newKYC.RecordTypeId==kyc2 )){
        KYCType = newKYC.GE_PW_KYC_Type__c;
        if(!String.isBlank(newKYC.GE_HQ_Account__c )&& newKYC.GE_PW_KYC_Type__c !='Modify Account'){
                
             GE_OG_Finance_Details__c fin=new GE_OG_Finance_Details__c();                     
             fin.GE_OG_Account__c = newKYC.GE_HQ_Account__c; 
             fin.GE_OG_KYC__c = newKYC.Id;
             //String countryName=newKYC.GE_HQ_Account__r.GE_HQ_New_Account_Country__c;
             String countryName;
             if(!accRecSet.contains(accMap.get(newKYC.GE_HQ_Account__c).RecordTypeId)){
                 countryName=accMap.get(newKYC.GE_HQ_Account__c).GE_HQ_New_Account_Country__c;}
             else {countryName=accMap.get(newKYC.GE_HQ_Account__c).shippingCountry;}
             string countryId= '';
             String countrycodeName = '';
              List<GEMDM__GEMDMCountryList__c> Country_Codes = [SELECT GEMDM__Country_Code__c,GEMDM__Country_Name__c FROM GEMDM__GEMDMCountryList__c where GEMDM__Country_Code__c =: countryName];    
              if (Country_Codes.size() > 0) 
                countrycodeName=Country_Codes[0].GEMDM__Country_Name__c;
              else
                countrycodeName = countryName;
            
             countryId=riskMap.get(countrycodeName);
             GE_HQ_Country__c country=countryMap.get(countryId);
             //System.debug('*******************Country****************'+country.GE_OG_Finance_Country_Risk__c);
             if (country != null )
                fin.GE_OG_Finance_Country_Risk__c=country.GE_OG_Finance_Country_Risk__c;
             finance.add(fin);
           
            //********************** For the M&C ERP
            //String t3=accMap.get(newKYC.GE_HQ_Account__c).GE_OG_Buss_Tier3__c;
            //List<Business_Tier_Object__c> bTier=[select Business_Tier_3__c,SAP_ORACLE__c from Business_Tier_Object__c where Business_Tier_3__c=:t3];
            //insert finance;
            erp.GE_OG_KYC__c=newKYC.id;         
            /*if  (finance.size() > 0)
                erp.GE_OG_Finance_Details__c = finance[0].id;
                erp.GE_OG_CoE_Rec_Finance_TCs__c = finance[0].GE_OG_Finan_TC__c;
            */    
            if(!String.isBlank(newKYC.GE_HQ_Account__c ))
                erp.GE_OG_ERP_Account__c=newKYC.GE_HQ_Account__c;
            if (country != null )
                if (!String.isBlank(country.GE_OG_Tax_ID_Format__c))
                    erp.GE_OG_ERP_Tax_ID_Format__c=country.GE_OG_Tax_ID_Format__c;
            erp.GE_OG_Tier_1_PL__c=accMap.get(newKYC.GE_HQ_Account__c).GE_OG_Buss_Tier1__c;
            erp.GE_OG_Tier_2_PL__c=accMap.get(newKYC.GE_HQ_Account__c).GE_OG_Buss_Tier2__c;
            erp.GE_OG_Tier_3_PL__c=accMap.get(newKYC.GE_HQ_Account__c).GE_OG_Buss_Tier3__c;
            erp.GE_OG_Tier_4_PL__c=accMap.get(newKYC.GE_HQ_Account__c).GE_OG_Buss_Tier4__c;                  
            /****************************************
            if(accMap.get(newKYC.GE_HQ_Account__c).GE_OG_Buss_Tier2__c=='Digital Solutions' && accMap.get(newKYC.GE_HQ_Account__c).GE_OG_Buss_Tier3__c!='Flow & Process Technologies (Dresser)'){        
                erp.RecordTypeId=Sap_Id;                    
                ERPs.add(erp);
            }
            else if(accMap.get(newKYC.GE_HQ_Account__c).GE_OG_Buss_Tier2__c=='Digital Solutions' && (accMap.get(newKYC.GE_HQ_Account__c).GE_OG_Buss_Tier3__c=='Flow & Process Technologies (Dresser)'&& (accMap.get(newKYC.GE_HQ_Account__c).GE_OG_Buss_Tier4__c=='' || accMap.get(newKYC.GE_HQ_Account__c).GE_OG_Buss_Tier4__c == null))){        
                erp.RecordTypeId=Sap_Id;                    
                ERPs.add(erp);
            }
            //***************** For the DT ERP
            else if(accMap.get(newKYC.GE_HQ_Account__c).GE_OG_Buss_Tier3__c=='D&S - DT'){        
                erp.RecordTypeId=DT_Id;            
                ERPs.add(erp);
            }
            //***************** Changed Lufkin by Satya P For the R-20337 on 22-Dec-2014            
            //***************** Changed D&S-WPS  to D&S - WPS by Satya P For bug 0000020179 on 23-Jan-2015
            else if(accMap.get(newKYC.GE_HQ_Account__c).GE_OG_Buss_Tier3__c=='D&S - WPS'){
                erp.RecordTypeId=Lufkin_Id;            
                ERPs.add(erp);        
            } 
                       
          //For Sub Sea - Oracle Implementation - added by Rekha for 18814 
            //Removed  D&S - AL by Satya P For the R-20337 on 22-Dec-2014   
            else if(accMap.get(newKYC.GE_HQ_Account__c).GE_OG_Buss_Tier3__c=='In Line Inspection'||accMap.get(newKYC.GE_HQ_Account__c).GE_OG_Buss_Tier3__c=='Integrity Services'|| accMap.get(newKYC.GE_HQ_Account__c).GE_OG_Buss_Tier3__c=='SS - Subsea'||accMap.get(newKYC.GE_HQ_Account__c).GE_OG_Buss_Tier3__c=='SS - Offshore' || accMap.get(newKYC.GE_HQ_Account__c).GE_OG_Buss_Tier3__c=='SS - Services' || accMap.get(newKYC.GE_HQ_Account__c).GE_OG_Buss_Tier3__c=='SS - Well Stream' || accMap.get(newKYC.GE_HQ_Account__c).GE_OG_Buss_Tier3__c=='D&S - PC' || accMap.get(newKYC.GE_HQ_Account__c).GE_OG_Buss_Tier3__c=='D&S - Logging' || accMap.get(newKYC.GE_HQ_Account__c).GE_OG_Buss_Tier3__c=='D&S - Drilling' || (accMap.get(newKYC.GE_HQ_Account__c).GE_OG_Buss_Tier3__c=='Flow & Process Technologies (Dresser)' && (accMap.get(newKYC.GE_HQ_Account__c).GE_OG_Buss_Tier4__c!='' || accMap.get(newKYC.GE_HQ_Account__c).GE_OG_Buss_Tier4__c != null) )|| accMap.get(newKYC.GE_HQ_Account__c).GE_OG_Buss_Tier3__c=='Installation' || accMap.get(newKYC.GE_HQ_Account__c).GE_OG_Buss_Tier3__c=='New Units' || accMap.get(newKYC.GE_HQ_Account__c).GE_OG_Buss_Tier3__c=='Opex - Core' || accMap.get(newKYC.GE_HQ_Account__c).GE_OG_Buss_Tier3__c=='Opex - CS' || accMap.get(newKYC.GE_HQ_Account__c).GE_OG_Buss_Tier3__c=='Service Multi P&Ls' )
            {
                erp.RecordTypeId=Subsea_Id;                         
                //if(!String.isBlank(countryMap.get(countryId).GE_OG_Tax_ID_Format__c ))
                //    erp.GE_OG_ERP_Tax_ID_Format__c=countryMap.get(countryId).GE_OG_Tax_ID_Format__c;        
                ERPs.add(erp);        
            }
            ******************************************/
            
            /**************************************Added as part of Surface Tier changes********************/
            if(accMap.get(newKYC.GE_HQ_Account__c).GE_OG_Buss_Tier2__c=='Digital Solutions'){        
                erp.RecordTypeId=Sap_Id;                    
                ERPs.add(erp);
            }
            else if(accMap.get(newKYC.GE_HQ_Account__c).GE_OG_Buss_Tier2__c=='Oil Field Equipment' ){        
                erp.RecordTypeId=Subsea_Id;                    
                ERPs.add(erp);
            }
            
            else if(accMap.get(newKYC.GE_HQ_Account__c).GE_OG_Buss_Tier2__c=='Downstream Technology Solutions' && accMap.get(newKYC.GE_HQ_Account__c).GE_OG_Buss_Tier3__c =='Flow & Process Technologies'){        
                erp.RecordTypeId=Sap_Id;            
                ERPs.add(erp);
            }
            
            else if(accMap.get(newKYC.GE_HQ_Account__c).GE_OG_Buss_Tier2__c == 'Oil Field Services' && accMap.get(newKYC.GE_HQ_Account__c).GE_OG_Buss_Tier3__c == 'Wireline Services' && accMap.get(newKYC.GE_HQ_Account__c).GE_OG_Buss_Tier4__c == 'Downhole Technology'){
                erp.RecordTypeId=DT_Id;            
                ERPs.add(erp);   
            }
            
            else if(accMap.get(newKYC.GE_HQ_Account__c).GE_OG_Buss_Tier2__c == 'Turbomachinery Solutions' && accMap.get(newKYC.GE_HQ_Account__c).GE_OG_Buss_Tier3__c=='Power Transmission'){
                erp.RecordTypeId=Sap_Id;            
                ERPs.add(erp); 
            }
            else if(accMap.get(newKYC.GE_HQ_Account__c).GE_OG_Buss_Tier2__c == 'Oil Field Services' && accMap.get(newKYC.GE_HQ_Account__c).GE_OG_Buss_Tier3__c == 'Artificial Lift Services'){
                erp.RecordTypeId=Lufkin_Id;            
                ERPs.add(erp); 
            }
            
        }
            // ************************* added for the Finance Applicable
        else if(!String.isBlank(newKYC.GE_HQ_Account__c) && newKYC.GE_PW_KYC_Type__c =='Modify Account'){
            Set <Id> kycId = new Set<Id>();
            GE_OG_Finance_Details__c fin=new GE_OG_Finance_Details__c();                     
            fin.GE_OG_Account__c = newKYC.GE_HQ_Account__c; 
            fin.GE_OG_KYC__c = newKYC.Id;
            fin.GE_OG_Finance_Status__c='Finance Not Applicable';
            //String countryName=newKYC.GE_HQ_Account__r.GE_HQ_New_Account_Country__c;
             String countryName;
             if(!accRecSet.contains(accMap.get(newKYC.GE_HQ_Account__c).RecordTypeId)){
                 countryName=accMap.get(newKYC.GE_HQ_Account__c).GE_HQ_New_Account_Country__c;}
             else {countryName=accMap.get(newKYC.GE_HQ_Account__c).shippingCountry;}
             string countryId=riskMap.get(countryName);
             GE_HQ_Country__c country=countryMap.get(countryId);
             if (country != null )
                fin.GE_OG_Finance_Country_Risk__c=country.GE_OG_Finance_Country_Risk__c;
             finance.add(fin);       
            //insert finance; 
        }            
    }
    else 
    {
    // do nothing;
    }
  }

    insert finance;
    if (ERPs.size()>0) {
        insert ERPs;
    
        if  (finance.size() > 0) {
            if (KYCType !='Modify Account') {
                List<GE_OG_ERP_Detail__c> FinanceERPs=[select id,GE_OG_Finance_Details__c,GE_OG_CoE_Rec_Finance_TCs__c from GE_OG_ERP_Detail__c where GE_OG_KYC__c =:  finance[0].GE_OG_KYC__c limit 1];        
                FinanceERPs[0].GE_OG_Finance_Details__c = finance[0].id;
                FinanceERPs[0].GE_OG_CoE_Rec_Finance_TCs__c = finance[0].GE_OG_Finan_TC__c;
                update FinanceERPs;
            }
        }
    }   
    
}