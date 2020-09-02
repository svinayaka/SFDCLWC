/*
Req: R-25681
Class Name              :        GE_AL_CreateWellEquipmentRunDataBatch
Class called in         :        GE_AL_wellRunscheduleBatch
Purpose                 :        To create new, well run data record under the location and Equipment Run data on the Installed Product record
Test class              :        GE_AL_WellEquipmentRunDataBatch_TEST
Created on              :        5/17/2017  
*/

global class GE_AL_CreateWellEquipmentRunDataBatch implements Database.Batchable<sObject>{
    
    
    global Database.QueryLocator start(Database.BatchableContext BC){
        String query = 'select id,DC__c,LW__r.Id,P__c,P2__c,P3__c,P4__c,P5__c,P6__c,P7__c,I2__c,I__c,L__c,L2__c,M__c,M2__c,R__c,C__c from I__c where CreatedDate = TODAY';
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, 
                        List<I__c> scope){
                            List<GE_AL_Well_Run_Data__c> wellrundata = new List<GE_AL_Well_Run_Data__c>();
                            List<GE_AL_Equipment_Run_Data__c> equipmentrundata = new List<GE_AL_Equipment_Run_Data__c>();
                            for(I__c ins:scope){
                                GE_AL_Well_Run_Data__c wellrun = new GE_AL_Well_Run_Data__c();
                                wellrun.GE_AL_Location__c = ins.LW__r.Id;
                                wellrun.GE_AL_Install_Date__c = ins.DC__c;
                                wellrun.GE_AL_Install__c = ins.Id;
                                wellrundata.add(wellrun);
                                
        if (ins.P__c != Null)
        {
          GE_AL_Equipment_Run_Data__c erd = new GE_AL_Equipment_Run_Data__c ();
          erd.SVMXC_Installed_Product__c = ins.P__c;
          erd.GE_AL_Install_Date__c = ins.DC__c;
          erd.GE_AL_Location__c = ins.LW__c;
          equipmentrundata.add(erd);
        }
        if (ins.P2__c != Null)
        {
          GE_AL_Equipment_Run_Data__c erd = new GE_AL_Equipment_Run_Data__c ();
          erd.SVMXC_Installed_Product__c = ins.P2__c;
          erd.GE_AL_Install_Date__c = ins.DC__c;
          erd.GE_AL_Location__c = ins.LW__c;
          equipmentrundata.add(erd);
        }
        if (ins.P3__c != Null)
        {
          GE_AL_Equipment_Run_Data__c erd = new GE_AL_Equipment_Run_Data__c ();
          erd.SVMXC_Installed_Product__c = ins.P3__c;
          erd.GE_AL_Install_Date__c = ins.DC__c;
          erd.GE_AL_Location__c = ins.LW__c;
          equipmentrundata.add(erd);
        }
        if (ins.P4__c != Null)
        {
          GE_AL_Equipment_Run_Data__c erd = new GE_AL_Equipment_Run_Data__c ();
          erd.SVMXC_Installed_Product__c = ins.P4__c;
          erd.GE_AL_Install_Date__c = ins.DC__c;
          erd.GE_AL_Location__c = ins.LW__c;
          equipmentrundata.add(erd);
        }
        if (ins.P5__c != Null)
        {
          GE_AL_Equipment_Run_Data__c erd = new GE_AL_Equipment_Run_Data__c ();
          erd.SVMXC_Installed_Product__c = ins.P5__c;
          erd.GE_AL_Install_Date__c = ins.DC__c;
          erd.GE_AL_Location__c = ins.LW__c;
          equipmentrundata.add(erd);
        }
        if (ins.P6__c != Null)
        {
          GE_AL_Equipment_Run_Data__c erd = new GE_AL_Equipment_Run_Data__c ();
          erd.SVMXC_Installed_Product__c = ins.P6__c;
          erd.GE_AL_Install_Date__c = ins.DC__c;
          erd.GE_AL_Location__c = ins.LW__c;
          equipmentrundata.add(erd);
        }
        if (ins.P7__c != Null)
        {
          GE_AL_Equipment_Run_Data__c erd = new GE_AL_Equipment_Run_Data__c ();
          erd.SVMXC_Installed_Product__c = ins.P7__c;
          erd.GE_AL_Install_Date__c = ins.DC__c;
          erd.GE_AL_Location__c = ins.LW__c;
          equipmentrundata.add(erd);
        }
        if (ins.I__c != Null)
        {
          GE_AL_Equipment_Run_Data__c erd = new GE_AL_Equipment_Run_Data__c ();
          erd.SVMXC_Installed_Product__c = ins.I__c;
          erd.GE_AL_Install_Date__c = ins.DC__c;
          erd.GE_AL_Location__c = ins.LW__c;
          equipmentrundata.add(erd);
        }
        if (ins.I2__c != Null)
        {
          GE_AL_Equipment_Run_Data__c erd = new GE_AL_Equipment_Run_Data__c ();
          erd.SVMXC_Installed_Product__c = ins.I2__c;
          erd.GE_AL_Install_Date__c = ins.DC__c;
          erd.GE_AL_Location__c = ins.LW__c;
          equipmentrundata.add(erd);
        }
        if (ins.L__c != Null)
        {
          GE_AL_Equipment_Run_Data__c erd = new GE_AL_Equipment_Run_Data__c ();
          erd.SVMXC_Installed_Product__c = ins.L__c;
          erd.GE_AL_Install_Date__c = ins.DC__c;
          erd.GE_AL_Location__c = ins.LW__c;
          equipmentrundata.add(erd);
        }
        if (ins.L2__c != Null)
        {
          GE_AL_Equipment_Run_Data__c erd = new GE_AL_Equipment_Run_Data__c ();
          erd.SVMXC_Installed_Product__c = ins.L2__c;
          erd.GE_AL_Install_Date__c = ins.DC__c;
          erd.GE_AL_Location__c = ins.LW__c;
          equipmentrundata.add(erd);
        }
        if (ins.M__c != Null)
        {
          GE_AL_Equipment_Run_Data__c erd = new GE_AL_Equipment_Run_Data__c ();
          erd.SVMXC_Installed_Product__c = ins.M__c;
          erd.GE_AL_Install_Date__c = ins.DC__c;
          erd.GE_AL_Location__c = ins.LW__c;
          equipmentrundata.add(erd);
        }
        if (ins.M2__c != Null)
        {
          GE_AL_Equipment_Run_Data__c erd = new GE_AL_Equipment_Run_Data__c ();
          erd.SVMXC_Installed_Product__c = ins.M2__c;
          erd.GE_AL_Install_Date__c = ins.DC__c;
          erd.GE_AL_Location__c = ins.LW__c;
          equipmentrundata.add(erd);
        }
        if (ins.R__c != Null)
        {
          GE_AL_Equipment_Run_Data__c erd = new GE_AL_Equipment_Run_Data__c ();
          erd.SVMXC_Installed_Product__c = ins.R__c;
          erd.GE_AL_Install_Date__c = ins.DC__c;
          erd.GE_AL_Location__c = ins.LW__c;
          equipmentrundata.add(erd);
        }
        if (ins.C__c != Null)
        {
          GE_AL_Equipment_Run_Data__c erd = new GE_AL_Equipment_Run_Data__c ();
          erd.SVMXC_Installed_Product__c = ins.C__c;
          erd.GE_AL_Install_Date__c = ins.DC__c;
          erd.GE_AL_Location__c = ins.LW__c;
          equipmentrundata.add(erd);
        }
                                
                    }

        try{
            if(wellrundata.size()>0){
                insert wellrundata; 
                system.debug('wellrundata'+wellrundata.size());
            }
            if(equipmentrundata.size()>0){
                insert equipmentrundata;
            }
        }catch(System.Dmlexception e){
            System.debug(e);
        }
    }
    global void finish(Database.BatchableContext BC){
        
    } 
}