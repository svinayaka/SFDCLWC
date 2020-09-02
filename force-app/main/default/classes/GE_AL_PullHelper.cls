/*
Class Name                   - GE_AL_PullHelper
Object Name                  - Pull
Created Date                 - 9/1/2016
Description                  - To update Pull record on Latest Well Run Data record based up on the Location
Test Class                   - GE_AL_PullHelper_Test
*/

public with sharing class GE_AL_PullHelper{
    public void UpdateWellRunData(List<P__c> lstPulls)
    {
    map<ID, P__c> ObjMap = new map<ID, P__c>();
    
    for(P__c obj: lstPulls)
    {
        if (obj.LL__c != Null)
        {
            ObjMap.put(obj.LL__c, obj);
        }
    }
    
    //List<GE_AL_Well_Run_Data__c> wellrundata = [SELECT Id,GE_AL_Pull__c,GE_AL_Pull_Date__c ,GE_AL_Location__c,GE_AL_Pull_Created__c 
    //                                            FROM GE_AL_Well_Run_Data__c WHERE GE_AL_Location__c IN :ObjMap.KeySet() ORDER BY CreatedDate DESC LIMIT 1];
    List<GE_AL_Well_Run_Data__c> wellrundata = [SELECT Id,GE_AL_Pull__c,GE_AL_Pull_Date__c ,GE_AL_Location__c FROM GE_AL_Well_Run_Data__c WHERE GE_AL_Location__c IN :ObjMap.KeySet() ORDER BY CreatedDate DESC LIMIT 1];
     
    if(wellrundata.size() > 0)
    {
    for(P__c obj: lstPulls)
    {
        wellrundata[0].GE_AL_Pull__c = obj.Id;
        wellrundata[0].GE_AL_Pull_Date__c = obj.DS__c;     
    }
    }
    if(wellrundata.size() > 0)
    {
        update wellrundata;
    }
    else{
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Please create an Install record before creating Pull on the same Location'));
            //return null;
     }
    }
    
    //Part of R-25001
    public void UpdateEquipmentrundata(List<P__c> lstPulls1)
    {
    map<ID, P__c> ObjMap1 = new map<ID, P__c>();
    
    for(P__c obj1: lstPulls1)
    {
        if (obj1.LL__c != Null)
        {
            ObjMap1.put(obj1.LL__c, obj1);
        }
    }
    List<GE_AL_Equipment_Run_Data__c> equipmentrundata = [SELECT Id,GE_AL_Install_Date__c,SVMXC_Installed_Product__c,GE_AL_Location__c ,GE_AL_Pull_Date__c FROM GE_AL_Equipment_Run_Data__c WHERE GE_AL_Location__c IN :ObjMap1.KeySet() ORDER BY CreatedDate DESC];
       
    if(equipmentrundata.size() > 0)
    {
     for(P__c obj1: lstPulls1)
     {  
       for(Integer i=0; i<equipmentrundata.size(); i++){
        if(obj1.P1__c != Null && obj1.P1__c == equipmentrundata[i].SVMXC_Installed_Product__c)
        {       
        equipmentrundata[i].GE_AL_Pull_Date__c = obj1.DS__c;
        }
        if(obj1.P2__c != Null && obj1.P2__c == equipmentrundata[i].SVMXC_Installed_Product__c)
        {       
        equipmentrundata[i].GE_AL_Pull_Date__c = obj1.DS__c;
        }
        if(obj1.P3__c != Null && obj1.P3__c == equipmentrundata[i].SVMXC_Installed_Product__c)
        {       
        equipmentrundata[i].GE_AL_Pull_Date__c = obj1.DS__c;
        }
        if(obj1.P4__c != Null && obj1.P4__c == equipmentrundata[i].SVMXC_Installed_Product__c)
        {       
        equipmentrundata[i].GE_AL_Pull_Date__c = obj1.DS__c;
        }
        if(obj1.P5__c != Null && obj1.P5__c == equipmentrundata[i].SVMXC_Installed_Product__c)
        {       
        equipmentrundata[i].GE_AL_Pull_Date__c = obj1.DS__c;
        }
        if(obj1.P6__c != Null && obj1.P6__c == equipmentrundata[i].SVMXC_Installed_Product__c)
        {       
        equipmentrundata[i].GE_AL_Pull_Date__c = obj1.DS__c;
        }
        /*if(obj1.P7__c != Null && obj1.P7__c == equipmentrundata[i].SVMXC_Installed_Product__c)
        {       
        equipmentrundata[i].GE_AL_Pull_Date__c = obj1.DS__c;
        }*/
        if(obj1.I1__c != Null && obj1.I1__c == equipmentrundata[i].SVMXC_Installed_Product__c)
        {       
        equipmentrundata[i].GE_AL_Pull_Date__c = obj1.DS__c;
        }
        if(obj1.I2__c != Null && obj1.I2__c == equipmentrundata[i].SVMXC_Installed_Product__c)
        {       
        equipmentrundata[i].GE_AL_Pull_Date__c = obj1.DS__c;
        }
        if(obj1.SU__c != Null && obj1.SU__c == equipmentrundata[i].SVMXC_Installed_Product__c)
        {       
        equipmentrundata[i].GE_AL_Pull_Date__c = obj1.DS__c;
        }
        if(obj1.L__c != Null && obj1.L__c == equipmentrundata[i].SVMXC_Installed_Product__c)
        {       
        equipmentrundata[i].GE_AL_Pull_Date__c = obj1.DS__c;
        }
        if(obj1.MN__c != Null && obj1.MN__c == equipmentrundata[i].SVMXC_Installed_Product__c)
        {       
        equipmentrundata[i].GE_AL_Pull_Date__c = obj1.DS__c;
        }
        if(obj1.MI__c != Null && obj1.MI__c == equipmentrundata[i].SVMXC_Installed_Product__c)
        {       
        equipmentrundata[i].GE_AL_Pull_Date__c = obj1.DS__c;
        }
        if(obj1.MQ__c != Null && obj1.MQ__c == equipmentrundata[i].SVMXC_Installed_Product__c)
        {       
        equipmentrundata[i].GE_AL_Pull_Date__c = obj1.DS__c;
        }
        if(obj1.SR__c != Null && obj1.SR__c == equipmentrundata[i].SVMXC_Installed_Product__c)
        {       
        equipmentrundata[i].GE_AL_Pull_Date__c = obj1.DS__c;
        }
        if(obj1.M__c != Null && obj1.M__c == equipmentrundata[i].SVMXC_Installed_Product__c)
        {       
        equipmentrundata[i].GE_AL_Pull_Date__c = obj1.DS__c;
        }
       }    
     }
    }
    if(equipmentrundata.size() > 0)
    {
        update equipmentrundata;
    }
    else{
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Please create an Install record before creating Pull on the same Location'));
            //return null;
     }
    }
}