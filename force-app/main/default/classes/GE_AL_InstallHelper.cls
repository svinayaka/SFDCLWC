/*
Class Name                   - GE_AL_InstallHelper 
Object Name                  - Install
Created Date                 - 11/9/2016
Description                  -  Helper Class GE_AL_InstallTriggerHandler would process all the Trigger requests coming from GE_AL_InstallTrigger 
                                All Logic to be processed in the Helper Classes being executed from the Handler Class
Test Class                   -  GE_AL_InstallHelper_Test                                
*/
public with sharing class GE_AL_InstallHelper{
  public void CreateEquipmentRunData(List<I__c> lstInstalls)
  {
    List <GE_AL_Equipment_Run_Data__c> equToInsert = new List <GE_AL_Equipment_Run_Data__c> ();
    for(I__c i: lstInstalls)
    {
        if (i.P__c != Null)
        {
          GE_AL_Equipment_Run_Data__c e = new GE_AL_Equipment_Run_Data__c ();
          e.SVMXC_Installed_Product__c = i.P__c;
          e.GE_AL_Install_Date__c = i.DC__c;
          e.GE_AL_Location__c = i.LW__c;
          equToInsert.add(e);
        }
        if (i.P2__c != Null)
        {
          GE_AL_Equipment_Run_Data__c e1 = new GE_AL_Equipment_Run_Data__c ();
          e1.SVMXC_Installed_Product__c = i.P2__c;
          e1.GE_AL_Install_Date__c = i.DC__c;
          e1.GE_AL_Location__c = i.LW__c;
          equToInsert.add(e1);
        }
        if (i.P3__c != Null)
        {
          GE_AL_Equipment_Run_Data__c e1 = new GE_AL_Equipment_Run_Data__c ();
          e1.SVMXC_Installed_Product__c = i.P3__c;
          e1.GE_AL_Install_Date__c = i.DC__c;
          e1.GE_AL_Location__c = i.LW__c;
          equToInsert.add(e1);
        }
        if (i.P4__c != Null)
        {
          GE_AL_Equipment_Run_Data__c e1 = new GE_AL_Equipment_Run_Data__c ();
          e1.SVMXC_Installed_Product__c = i.P4__c;
          e1.GE_AL_Install_Date__c = i.DC__c;
          e1.GE_AL_Location__c = i.LW__c;
          equToInsert.add(e1);
        }
        if (i.P5__c != Null)
        {
          GE_AL_Equipment_Run_Data__c e1 = new GE_AL_Equipment_Run_Data__c ();
          e1.SVMXC_Installed_Product__c = i.P5__c;
          e1.GE_AL_Install_Date__c = i.DC__c;
          e1.GE_AL_Location__c = i.LW__c;
          equToInsert.add(e1);
        }
        if (i.P6__c != Null)
        {
          GE_AL_Equipment_Run_Data__c e1 = new GE_AL_Equipment_Run_Data__c ();
          e1.SVMXC_Installed_Product__c = i.P6__c;
          e1.GE_AL_Install_Date__c = i.DC__c;
          e1.GE_AL_Location__c = i.LW__c;
          equToInsert.add(e1);
        }
        if (i.P7__c != Null)
        {
          GE_AL_Equipment_Run_Data__c e1 = new GE_AL_Equipment_Run_Data__c ();
          e1.SVMXC_Installed_Product__c = i.P7__c;
          e1.GE_AL_Install_Date__c = i.DC__c;
          e1.GE_AL_Location__c = i.LW__c;
          equToInsert.add(e1);
        }
        if (i.I__c != Null)
        {
          GE_AL_Equipment_Run_Data__c e1 = new GE_AL_Equipment_Run_Data__c ();
          e1.SVMXC_Installed_Product__c = i.I__c;
          e1.GE_AL_Install_Date__c = i.DC__c;
          e1.GE_AL_Location__c = i.LW__c;
          equToInsert.add(e1);
        }
        if (i.I2__c != Null)
        {
          GE_AL_Equipment_Run_Data__c e1 = new GE_AL_Equipment_Run_Data__c ();
          e1.SVMXC_Installed_Product__c = i.I2__c;
          e1.GE_AL_Install_Date__c = i.DC__c;
          e1.GE_AL_Location__c = i.LW__c;
          equToInsert.add(e1);
        }
        if (i.L__c != Null)
        {
          GE_AL_Equipment_Run_Data__c e1 = new GE_AL_Equipment_Run_Data__c ();
          e1.SVMXC_Installed_Product__c = i.L__c;
          e1.GE_AL_Install_Date__c = i.DC__c;
          e1.GE_AL_Location__c = i.LW__c;
          equToInsert.add(e1);
        }
        if (i.L2__c != Null)
        {
          GE_AL_Equipment_Run_Data__c e1 = new GE_AL_Equipment_Run_Data__c ();
          e1.SVMXC_Installed_Product__c = i.L2__c;
          e1.GE_AL_Install_Date__c = i.DC__c;
          e1.GE_AL_Location__c = i.LW__c;
          equToInsert.add(e1);
        }
        if (i.M__c != Null)
        {
          GE_AL_Equipment_Run_Data__c e1 = new GE_AL_Equipment_Run_Data__c ();
          e1.SVMXC_Installed_Product__c = i.M__c;
          e1.GE_AL_Install_Date__c = i.DC__c;
          e1.GE_AL_Location__c = i.LW__c;
          equToInsert.add(e1);
        }
        if (i.M2__c != Null)
        {
          GE_AL_Equipment_Run_Data__c e1 = new GE_AL_Equipment_Run_Data__c ();
          e1.SVMXC_Installed_Product__c = i.M2__c;
          e1.GE_AL_Install_Date__c = i.DC__c;
          e1.GE_AL_Location__c = i.LW__c;
          equToInsert.add(e1);
        }
        if (i.R__c != Null)
        {
          GE_AL_Equipment_Run_Data__c e1 = new GE_AL_Equipment_Run_Data__c ();
          e1.SVMXC_Installed_Product__c = i.R__c;
          e1.GE_AL_Install_Date__c = i.DC__c;
          e1.GE_AL_Location__c = i.LW__c;
          equToInsert.add(e1);
        }
        if (i.C__c != Null)
        {
          GE_AL_Equipment_Run_Data__c e1 = new GE_AL_Equipment_Run_Data__c ();
          e1.SVMXC_Installed_Product__c = i.C__c;
          e1.GE_AL_Install_Date__c = i.DC__c;
          e1.GE_AL_Location__c = i.LW__c;
          equToInsert.add(e1);
        }
    }
    try{
        if(equToInsert.size() > 0)
        {
        insert equToInsert;
        }
    }catch(system.Dmlexception e){
        system.debug(e);
    }
  }
}