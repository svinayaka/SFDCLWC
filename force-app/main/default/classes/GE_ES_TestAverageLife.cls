@isTest
private class GE_ES_TestAverageLife{

static testMethod void avgLife(){

//Insert Account record
Account acc = new Account(Name = 'a test account',
          ShippingStreet = '123 Test Ave.', 
            ShippingCity = 'Testville',    
           ShippingPostalCode = '32951',  
           ShippingState = 'MH',   
          ShippingCountry = 'IN_TESTX',
          GE_HQ_DUNS_Number__c = 'test');
insert acc; 
//Account accRec = [select id from Account where id=:acc.id];
     
     
//Query Component recordType
List<RecordType> compRecTypes = [select Name,id from RecordType where sObjectType='GE_ES_ITO_Component__c'];
Map<String,String> compMap= new Map<String,String>();
for(RecordType rt:compRecTypes)
compMap.put(rt.Name,rt.Id);

//Query IB recordType
List<RecordType> IBRecTypes = [select Name,id from RecordType where sObjectType='GE_Installed_Base__c'];
Map<String,String> IBMap= new Map<String,String>();
for(RecordType rt:IBRecTypes )
IBMap.put(rt.Name,rt.Id);
System.debug('************compMap************************'+compMap);

//Insert IB Record
GE_Installed_Base__c IB =new GE_Installed_Base__c();
//IB.GE_ES_Record_Type__c='Baghouse';
//IB.GE_ES_Equipment_Record_Type__c='Baghouse';
IB.Account__c =acc.id;
IB.GE_ES_Application__c='BOILER-CYCLONE';
IB.GE_ES_Cleaning_Type__c='Pulse Jet';
//IB.RecordTypeId=IBMap.get('Baghouse'); 
insert IB;
//IB.GE_ES_Cleaning_Type__c='Pulse Jet1';
//IB.GE_ES_Record_Type__c='Cartridge Collector';
//update IB;
//GE_Installed_Base__c IBRec = [select id,GE_ES_Application__c,GE_ES_Cleaning_Type__c from GE_Installed_Base__c where id=:IB.id];

//GFLR.GE_ES_Average_Life__c=12;
//update GFLR;

GE_ES_ITO_Component__c comp = new GE_ES_ITO_Component__c();
comp.RecordTypeId=compMap.get('Filter');
comp.Name='Comp01';
comp.GE_ES_Equipment_Name__c=IB.id;
comp.GE_ES_Raw_Material__c='PC047';
comp.GE_ES_Filter_Type__c='Bag';
//comp.RecordTypeId=compRecTypes[0].id;
comp.GE_ES_Raw_Material__c='gab';
insert comp;
comp.GE_ES_Raw_Material__c='gab1';
System.debug('GE_ES_Equipment_Record_Type__c'+ comp.GE_ES_Equipment_Record_Type__c);
//comp.RecordTypeId=compMap.get('GT-Filters');
//update comp;

GE_ES_Filter_Life_Rule__c FLR1 = new GE_ES_Filter_Life_Rule__c();
FLR1.GE_ES_Average_Life__c=11;
FLR1.GE_ES_External_ID__c='10101';
FLR1.GE_ES_Application__c =IB.GE_ES_Application__c;
FLR1.GE_ES_Cleaning_Type__c =IB.GE_ES_Cleaning_Type__c;
FLR1.GE_ES_Filter_Type__c = comp.GE_ES_Filter_Type__c;
FLR1.GE_ES_Raw_Materal__c = comp.GE_ES_Raw_Material__c;
insert FLR1;
FLR1.GE_ES_Average_Life__c=11;
update FLR1;

GE_ES_GT_Filter_Life_Rule__c  GFLR =new GE_ES_GT_Filter_Life_Rule__c();
GFLR.GE_ES_Average_Life__c=Null;
GFLR.GE_ES_External_ID__c='10101';
GFLR.GE_ES_Filtration_Stage__c =comp.GE_ES_Filtration_Stage__c ;
GFLR.GE_ES_Installed_Type__c =comp.GE_ES_Installed_Type__c;
insert GFLR;

  // if((((comp.GE_ES_Equipment_Record_Type__c=='Baghouse')||(comp.GE_ES_Equipment_Record_Type__c=='Cartridge Collector'))&&(CR.RecordTypeId==componentRecordTypes.get('Filter')))||((CR.GE_ES_Equipment_Record_Type__c=='Intake System')&&(CR.RecordTypeId==componentRecordTypes.get('GT-Filters')))){
//comp.GE_ES_Equipment_Record_Type__c='Baghouse';
//System.debug('FLR1.GE_ES_Average_Life__c ----'+FLR1.GE_ES_Average_Life__c+'GFLR.GE_ES_Average_Life__c-----'+GFLR.GE_ES_Average_Life__c);
if(FLR1.GE_ES_Average_Life__c!=Null && GFLR.GE_ES_Average_Life__c==Null)
    {
     System.debug('FLR1.GE_ES_Average_Life__c ----'+FLR1.GE_ES_Average_Life__c+'GFLR.GE_ES_Average_Life__c-----'+GFLR.GE_ES_Average_Life__c);
     comp.GE_ES_Average_Filter_Life_Months__c=FLR1.GE_ES_Average_Life__c;
    // update comp;
    }
    
  if(FLR1.GE_ES_Average_Life__c==Null && GFLR.GE_ES_Average_Life__c!=Null)   
     {  
 System.debug('FLR1.GE_ES_Average_Life__c11 ----'+FLR1.GE_ES_Average_Life__c+'GFLR.GE_ES_Average_Life__c-----'+GFLR.GE_ES_Average_Life__c);
    
       comp.GE_ES_Average_Filter_Life_Months__c=GFLR.GE_ES_Average_Life__c;
     }
       
      { 
           comp.GE_ES_Average_Filter_Life_Months__c=12;
      
      }
      comp.GE_ES_Filter_Type__c='Bag1';
    update comp;
}
}