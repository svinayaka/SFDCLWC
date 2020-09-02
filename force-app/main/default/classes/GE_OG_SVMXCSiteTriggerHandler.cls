/*
Class Name                   - GE_OG_SVMXCSiteTriggerHandler  
Object Name                  - SVMXC__Site__c 
Created Date                 - 04-Oct-2016
Description                  - Handler Class GE_OG_SVMXCSiteTriggerHandler  would process all the Trigger requests coming from GE_OG_SVMXCSiteTrigger
                               All Logic to be processed in the Handler Class or Helper Classes being called from this Handler Class
*/

public without sharing class GE_OG_SVMXCSiteTriggerHandler{


  public void OnBeforeInsert(List<SVMXC__Site__c> newObjects){    
  GE_OG_SVMXC_LocationHelper helper = new GE_OG_SVMXC_LocationHelper();
  helper.updateLocation(newObjects);
  
  }
  
   public void OnBeforeUpdate(List<SVMXC__Site__c> newObjects){
   GE_OG_SVMXC_LocationHelper helper = new GE_OG_SVMXC_LocationHelper();
   helper.updateLocation(newObjects);
   }
}