/*
Req: R-25681

Class Name              :        GE_AL_WellEquipmentRunDataBatch_TEST
Purpose                 :        Test coverage for GE_AL_CreateWellEquipmentRunDataBatch and GE_AL_UpdateWellEquipmentRunDataBatch
Created on              :        5/17/2017  
*/
@isTest 

public class GE_AL_WellEquipmentRunDataBatch_TEST 
{
    static testMethod void WellRunEquipmentTestMethod() 
    {   
        ID ipRecTypeId=Schema.SObjectType.SVMXC__Installed_Product__c.getRecordTypeInfosByName().get('GE OG D&S Artificial Lift').getRecordTypeId();
        
        Test.startTest();
        
        SVMXC__Site__c loc = new SVMXC__Site__c();      
        loc.Name = 'Test Location';
        insert loc;
        
        SVMXC__Site__c loc1 = new SVMXC__Site__c();      
        loc1.Name = 'Test Location1';
        insert loc1;
        
        system.assertEquals(loc.Name,'Test Location');
        
        SVMXC__Installed_Product__c ip = new SVMXC__Installed_Product__c();     
        ip.Name = 'TestIP';
        insert ip;
        
        SVMXC__Installed_Product__c ip1 = new SVMXC__Installed_Product__c();     
        ip1.Name = 'TestIP1';
        insert ip1;
        
        SVMXC__Installed_Product__c ip2 = new SVMXC__Installed_Product__c();     
        ip2.Name = 'TestIP2';
        insert ip2;
        
        SVMXC__Installed_Product__c ip3 = new SVMXC__Installed_Product__c();     
        ip3.Name = 'TestIP3';
        insert ip3;
        
        SVMXC__Installed_Product__c ip4 = new SVMXC__Installed_Product__c();     
        ip4.Name = 'TestIP4';
        insert ip4;
        
        SVMXC__Installed_Product__c ip5 = new SVMXC__Installed_Product__c();     
        ip5.Name = 'TestIP5';
        insert ip5;
        
        SVMXC__Installed_Product__c ip6 = new SVMXC__Installed_Product__c();     
        ip6.Name = 'TestIP6';
        insert ip6;
        
        SVMXC__Installed_Product__c ip7 = new SVMXC__Installed_Product__c();     
        ip7.Name = 'TestIP7';
        insert ip7;
        
        SVMXC__Installed_Product__c ip8 = new SVMXC__Installed_Product__c();     
        ip8.Name = 'TestIP8';
        insert ip8;
        
        SVMXC__Installed_Product__c ip9 = new SVMXC__Installed_Product__c();     
        ip9.Name = 'TestIP9';
        insert ip9;
        
        SVMXC__Installed_Product__c ip10 = new SVMXC__Installed_Product__c();     
        ip10.Name = 'TestIP10';
        insert ip10;
        
        SVMXC__Installed_Product__c ip11 = new SVMXC__Installed_Product__c();     
        ip11.Name = 'TestIP11';
        insert ip11;
        
        SVMXC__Installed_Product__c ip12 = new SVMXC__Installed_Product__c();     
        ip12.Name = 'TestIP12';
        insert ip12;
        
        SVMXC__Installed_Product__c ip13 = new SVMXC__Installed_Product__c();     
        ip13.Name = 'TestIP13';
        insert ip13;
        
        SVMXC__Installed_Product__c ip14 = new SVMXC__Installed_Product__c();     
        ip14.Name = 'TestIP14';
        insert ip14;
        
         SVMXC__Installed_Product__c ip15 = new SVMXC__Installed_Product__c();     
        ip15.Name = 'TestIP15';
        insert ip15;
        
        system.assertEquals(ip.Name,'TestIP');
        
        
        I__c ins = new I__c();
        ins.LW__c = loc.id; //location
        ins.DC__c = Date.Today(); //completed date
        ins.P__c = ip.id;
        insert ins;
        
        I__c ins1 = new I__c();
        ins1.LW__c = loc.id; //location
        ins1.DC__c = Date.Today(); //completed date
        ins1.P2__c = ip1.id;
        insert ins1;
        
        I__c ins2 = new I__c();
        ins2.LW__c = loc.id; //location
        ins2.DC__c = Date.Today(); //completed date
        ins2.P3__c = ip2.id;
        insert ins2;
        
        I__c ins3 = new I__c();
        ins3.LW__c = loc.id; //location
        ins3.DC__c = Date.Today(); //completed date
        ins3.P4__c = ip3.id;
        insert ins3;
        
        I__c ins4 = new I__c();
        ins4.LW__c = loc.id; //location
        ins4.DC__c = Date.Today(); //completed date
        ins4.P5__c = ip4.id;
        insert ins4;
        
        I__c ins5 = new I__c();
        ins5.LW__c = loc.id; //location
        ins5.DC__c = Date.Today(); //completed date
        ins5.P6__c = ip5.id;
        insert ins5;
        
        I__c ins6 = new I__c();
        ins6.LW__c = loc.id; //location
        ins6.DC__c = Date.Today(); //completed date
        ins6.P7__c = ip6.id;
        insert ins6;
        
        I__c ins7 = new I__c();
        ins7.LW__c = loc.id; //location
        ins7.DC__c = Date.Today(); //completed date
        ins7.I__c = ip7.id;
        insert ins7;
        
        I__c ins8 = new I__c();
        ins8.LW__c = loc.id; //location
        ins8.DC__c = Date.Today(); //completed date
        ins8.I2__c = ip8.id;
        insert ins8;
        
        I__c ins9 = new I__c();
        ins9.LW__c = loc.id; //location
        ins9.DC__c = Date.Today(); //completed date
        ins9.L__c = ip9.id;
        insert ins9;
        
        I__c ins10 = new I__c();
        ins10.LW__c = loc.id; //location
        ins10.DC__c = Date.Today(); //completed date
        ins10.L2__c = ip10.id;
        insert ins10;
        
        I__c ins11 = new I__c();
        ins11.LW__c = loc.id; //location
        ins11.DC__c = Date.Today(); //completed date
        ins11.M__c = ip11.id;
        insert ins11;
        
        I__c ins12 = new I__c();
        ins12.LW__c = loc.id; //location
        ins12.DC__c = Date.Today(); //completed date
        ins12.M2__c = ip12.id;
        insert ins12;
        
        I__c ins13 = new I__c();
        ins13.LW__c = loc.id; //location
        ins13.DC__c = Date.Today(); //completed date
        ins13.R__c = ip13.id;
        insert ins13;
        
        I__c ins14 = new I__c();
        ins14.LW__c = loc.id; //location
        ins14.DC__c = Date.Today(); //completed date
        ins14.C__c = ip14.id;
        insert ins14;
        
        List<I__c> inslist = [select id,LW__c from I__C];
        
        system.debug('install '+inslist);
        
        GE_AL_Equipment_Run_Data__c erd = new GE_AL_Equipment_Run_Data__c();
        erd.GE_AL_Location__c = loc1.Id;
        erd.SVMXC_Installed_Product__c = ip15.id;
        insert erd;
        
        GE_AL_Well_Run_Data__c wrd = new GE_AL_Well_Run_Data__c();
        wrd.GE_AL_Location__c = loc1.id;
        insert wrd;
        
        GE_AL_CreateWellEquipmentRunDataBatch obj = new GE_AL_CreateWellEquipmentRunDataBatch();
        ID batchprocessid =  DataBase.executeBatch(obj); 
        
        //  List<GE_AL_Well_Run_Data__c> welldata = [select id from GE_AL_Well_Run_Data__c];
       //   List<GE_AL_Equipment_Run_Data__c> equipmentdata = [select id from GE_AL_Equipment_Run_Data__c where CreatedDate = TODAY];
        
        P__c pull = new P__c();
        pull.UD__c = Date.today();
        pull.DS__c = Date.today()+1;
        pull.DC__c = Date.today()+4;
        pull.P1__c = ip.id;
        pull.LL__c = loc.id;
        insert pull;
        
        P__c pull1 = new P__c();
        pull1.UD__c = Date.today();
        pull1.DS__c = Date.today()+1;
        pull1.DC__c = Date.today()+4;
        pull1.P2__c = ip1.id;
        pull1.LL__c = loc.id;
        insert pull1;
        
        P__c pull2 = new P__c();
        pull2.UD__c = Date.today();
        pull2.DS__c = Date.today()+1;
        pull2.DC__c = Date.today()+4;
        pull2.P3__c = ip2.id;
        pull2.LL__c = loc.id;
        insert pull2;
        
        P__c pull3 = new P__c();
        pull3.UD__c = Date.today();
        pull3.DS__c = Date.today()+1;
        pull3.DC__c = Date.today()+4;
        pull3.P4__c = ip3.id;
        pull3.LL__c = loc.id;
        insert pull3;
        
        P__c pull4 = new P__c();
        pull4.UD__c = Date.today();
        pull4.DS__c = Date.today()+1;
        pull4.DC__c = Date.today()+4;
        pull4.P5__c = ip4.id;
        pull4.LL__c = loc.id;
        insert pull4;
        
        P__c pull5 = new P__c();
        pull5.UD__c = Date.today();
        pull5.DS__c = Date.today()+1;
        pull5.DC__c = Date.today()+4;
        pull5.P6__c = ip5.id;
        pull5.LL__c = loc.id;
        insert pull5;
        
        P__c pull6 = new P__c();
        pull6.UD__c = Date.today();
        pull6.DS__c = Date.today()+1;
        pull6.DC__c = Date.today()+4;
        pull6.I1__c = ip6.id;
        pull6.LL__c = loc.id;
        insert pull6;
        
        P__c pull7 = new P__c();
        pull7.UD__c = Date.today();
        pull7.DS__c = Date.today()+1;
        pull7.DC__c = Date.today()+4;
        pull7.I2__c = ip7.id;
        pull7.LL__c = loc.id;
        insert pull7;
        
        P__c pull8 = new P__c();
        pull8.UD__c = Date.today();
        pull8.DS__c = Date.today()+1;
        pull8.DC__c = Date.today()+4;
        pull8.SU__c = ip8.id;
        pull8.LL__c = loc.id;
        insert pull8;
        
        P__c pull9 = new P__c();
        pull9.UD__c = Date.today();
        pull9.DS__c = Date.today()+1;
        pull9.DC__c = Date.today()+4;
        pull9.L__c = ip9.id;
        pull9.LL__c = loc.id;
        insert pull9;
        
        P__c pull10 = new P__c();
        pull10.UD__c = Date.today();
        pull10.DS__c = Date.today()+1;
        pull10.DC__c = Date.today()+4;
        pull10.MN__c = ip10.id;
        pull10.LL__c = loc.id;
        insert pull10;
        
        P__c pull11 = new P__c();
        pull11.UD__c = Date.today();
        pull11.DS__c = Date.today()+1;
        pull11.DC__c = Date.today()+4;
        pull11.MI__c = ip11.id;
        pull11.LL__c = loc.id;
        insert pull11;
        
        P__c pull12 = new P__c();
        pull12.UD__c = Date.today();
        pull12.DS__c = Date.today()+1;
        pull12.DC__c = Date.today()+4;
        pull12.MQ__c = ip12.id;
        pull12.LL__c = loc.id;
        insert pull12;
        
        P__c pull13 = new P__c();
        pull13.UD__c = Date.today();
        pull13.DS__c = Date.today()+1;
        pull13.DC__c = Date.today()+4;
        pull13.SR__c = ip13.id;
        pull13.LL__c = loc.id;
        insert pull13;
        
        P__c pull14 = new P__c();
        pull14.UD__c = Date.today();
        pull14.DS__c = Date.today()+1;
        pull14.DC__c = Date.today()+4;
        pull14.M__c = ip14.id;
        pull14.LL__c = loc.id;
        insert pull14;
         
        P__c pull15 = new P__c();
        pull15.UD__c = Date.today();
        pull15.DS__c = Date.today()+1;
        pull15.DC__c = Date.today()+4;
        pull15.LL__c = loc1.id;
        insert pull15;
       
        
     //   date myDate = date.today();
     //   P__c pull = new P__c (LL__c=loc.id,DS__c=myDate,P1__c=ip.id,P2__c=ip.id,P3__c=ip.id,P4__c=ip.id,P5__c=ip.id,P6__c=ip.id,I1__c=ip.id,I2__c=ip.id,SU__c=ip.id,L__c=ip.id,MN__c=ip.id,MI__c=ip.id,MQ__c=ip.id,SR__c=ip.id,M__c=ip.id);
      //  insert pull;
        
        GE_AL_UpdateWellEquipmentRunDataBatch obj1 = new GE_AL_UpdateWellEquipmentRunDataBatch();
        Database.executeBatch(obj1);
               
        Test.stopTest();
    }
}