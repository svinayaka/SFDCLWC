@istest
public class SVMX_MultiPrice_AutoEntitlement_Test
{

   static testmethod void method1()
    {
        id rid = Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('AL').getRecordTypeId(); 
          id rid1 = Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('SS-Mobilize').getRecordTypeId(); 
        list<SVMXC__Service_Order__c> wolist=new list<SVMXC__Service_Order__c>();
        map<id,SVMXC__Service_Order__c> womap=new map<id,SVMXC__Service_Order__c>();
        Map<string,SVMXC__Entitlement_History__c> MapEHList = new Map<string,SVMXC__Entitlement_History__c>();
        Map<string,SVMXC__Service_Contract__c> MapSClistSCid= new Map<string,SVMXC__Service_Contract__c>();

        Account acc=new Account();
        acc.name='XTO ENERGY INC';
        insert acc;
        
        pricebook2 pb2=new pricebook2();
        pb2.name='test';
        pb2.IsActive = true;
        pb2.CurrencyIsoCode='MXN';
        pb2.Tier_1__c='Oil & Gas';   
        insert pb2;
        
        SVMXC__Service_Pricebook__c spbk=new SVMXC__Service_Pricebook__c();
        spbk.name='servicepricebook';
        spbk.SVMXC__Description__c='test';
        spbk.SVMXC__Active__c=true;
        insert spbk;
        
        list<SVMXC__Service_Contract__c> ctrlst=new list<SVMXC__Service_Contract__c>();
        SVMXC__Service_Contract__c ctr=new SVMXC__Service_Contract__c();
        ctr.Parts_Pricebook__c=pb2.id;
        ctr.SVMXC__Active__c=true;
        ctr.SVMXC__Start_Date__c=system.today();
        ctr.SVMXC__End_Date__c=system.today()+2;
        ctr.SVMXC__Company__c=acc.id;
        ctr.SVMXC__Default_Parts_Price_Book__c='test'; 
        ctr.SVMXC__Service_Pricebook__c=spbk.id;       
        ctr.Region__c='North America';
        ctr.Tier_1__c='Oil & Gas';
        ctr.Tier_2__c='Oil Field Services';
        ctr.Tier3__c='Artificial Lift';
        insert ctr;
        ctrlst.add(ctr);
        
        MapSClistSCid.put(ctr.id,ctr);
        id contractrid = Schema.SObjectType.SVMXC__Service_Contract__c.getRecordTypeInfosByName().get('AL').getRecordTypeId();       
       SVMXC__Service_Contract__c ctr1=new SVMXC__Service_Contract__c();
       ctr1.SVMXC__Start_Date__c=system.today();
       ctr1.SVMXC__Active__c=true;
       ctr1.Parts_Pricebook__c=pb2.id;
       ctr1.SVMXC__End_Date__c=system.today()+2;
       ctr1.SVMXC__Company__c=null;
       ctr1.SVMXC__Default_Parts_Price_Book__c='test';
       ctr1.SVMXC__Service_Pricebook__c=spbk.id;
       ctr1.Branch__c='Canada';
       ctr1.Region__c='North America';
       ctr1.Tier_1__c='Oil & Gas';
       ctr1.Tier_2__c='Oil Field Services';
       ctr1.Tier3__c='Artificial Lift';
       //ctr1.Recordtypeid=contractrid;
       insert ctr1;
       ctrlst.add(ctr1);
        
       SVMXC__Service_Order__c EH=new SVMXC__Service_Order__c(); 
       
       EH.SVMXC__Service_Contract__c=ctr.id;
       EH.Parts_Pricebook__c=pb2.id;
       EH.Service_Pricebook__c=spbk.id;
       EH.SVMXC__Is_Entitlement_Performed__c=True;
       EH.SVMXC__Entitlement_Type__c='INTERACTIVE';
       EH.Recordtypeid=rid;
       insert EH;
       
        SVMXC__Service_Order__c EH1=new SVMXC__Service_Order__c(); 
       
       EH1.SVMXC__Service_Contract__c=ctr.id;
       EH1.Parts_Pricebook__c=pb2.id;
       EH1.Service_Pricebook__c=spbk.id;
       EH1.SVMXC__Is_Entitlement_Performed__c=True;
       EH1.SVMXC__Entitlement_Type__c='INTERACTIVE';
       EH1.Recordtypeid=rid1;
      
       insert EH1;

       wolist.add(EH);
       womap.put(EH.id,EH);
       
       if( MapSClistSCid.containskey(EH.SVMXC__Service_Contract__c)){
        MapSClistSCid.put(ctr1.id,ctr1);
       }
            try{
                insert wolist;
            }catch(Exception e){}
        
       EH.SVMXC__Service_Contract__c=ctr1.id;
       update EH;
       
       SVMXC__Entitlement_History__c enh=new SVMXC__Entitlement_History__c();
       enh.SVMXC__Service_Contract__c=ctr.id;
       enh.SVMXC__End_Date__c=system.today()+1;
       enh.SVMXC__Date_of_entitlement__c=system.today();
       enh.SVMXC__Service_Order__c=EH.id;
       enh.SVMXC__Start_Date__c=system.today();
       enh.SVMXC__Inactive_Date__c=null;
       insert enh;
        
       MapEHList.put(enh.SVMXC__Service_Order__c,enh);
      // SVMX_MultiPrice_AutoEntitlement.ProcessAutoEntitlement(wolist,womap,false);
                
    }  
}