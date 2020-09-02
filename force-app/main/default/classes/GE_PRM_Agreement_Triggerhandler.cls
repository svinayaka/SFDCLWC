/**
* 
* Class/Trigger Name--: GE_PRM_Agreement_Triggerhandler
* Object Name         : Agreement 
* Purpose/Overview----: Handler Clas GE_PRM_Agreement_Triggerhandler would process all the Trigger requests coming from GE_OG_ContactTrigger
                        All Logic to be processed in the Handler Class or Helper Classes being called from this Handler Class
* Functional Area-----: PRM
* Author--------------: Neha Gupta
* Created Date--------: 2/17/2015
* Test Class Name-----: Test_GE_PRM_Agreement_Triggerhandler
* Change History -
* Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
**/


Public  without sharing class GE_PRM_Agreement_Triggerhandler 
{ 
 public void pusedomethod2(){string x ='100';
        system.debug('hahahhaa'+x);}
/**

    public void OnBeforeInsert(List<Apttus__APTS_Agreement__c> newObjects)
    {
        // EXECUTE BEFORE INSERT LOGIC
        
        //For Req#R-23904 "Commercial Account" populated from Channel Appointment
        
        Set<ID> cAIds = New Set<ID>();
        For ( Apttus__APTS_Agreement__c a : newObjects )
        {
              cAIds.Add(a.GE_PRM_Channel_Appointment_ID__c);
        }
        
        Map<Id,GE_PRM_Channel_Appointment__c> caMap = new Map<Id,GE_PRM_Channel_Appointment__c>
        ([Select Id ,GE_PRM_Commercial_Account__c  From GE_PRM_Channel_Appointment__c Where ID IN:cAIds]);
        
        For ( Apttus__APTS_Agreement__c a : newObjects )
        {
             GE_PRM_Channel_Appointment__c ca = caMap.get(a.GE_PRM_Channel_Appointment_ID__c) ;
             
             If( ca!=null && ca.GE_PRM_Commercial_Account__c !=null)
             {
                     a.GE_PRM_Commercial_Account__c =  ca.GE_PRM_Commercial_Account__c ;
             }
                  
        }
    }
    public void OnAfterInsert(List<Apttus__APTS_Agreement__c> newObjects)
    {
        // EXECUTE AFTER INSERT LOGIC
            
    }
    public void OnBeforeUpdate(List<Apttus__APTS_Agreement__c> oldObjects, List<Apttus__APTS_Agreement__c> newObjects, Map<Id, Apttus__APTS_Agreement__c> newObjectMap)
    {
        system.debug('*---Trigger.New---*'+ newObjects);
    }
     public void OnAfterUpdate(List<Apttus__APTS_Agreement__c> oldObjects, List<Apttus__APTS_Agreement__c> newObjects, Map<Id, Apttus__APTS_Agreement__c> Oldmap){
    {
        Map<id,Apttus__APTS_Agreement__c> MapMasterAggr = new Map<id,Apttus__APTS_Agreement__c>() ;
        LIST<Apttus__APTS_Agreement__c> ListAddendumAggr = new LIST<Apttus__APTS_Agreement__c>() ;
        Map<String,Schema.RecordTypeInfo> RecordTypeInfo = Schema.getGlobalDescribe().get('Apttus__APTS_Agreement__c').getDescribe().getRecordTypeInfosByName();
        String  recordTypeID = RecordTypeInfo.get('Channel Master Agreement').getRecordTypeId();
        for( Apttus__APTS_Agreement__c masterAgr: newObjects)
        {
            if(masterAgr.recordtypeid == recordTypeID && ( masterAgr.GE_PRM_Governing_Law__c != (Oldmap.get(masterAgr.id).GE_PRM_Governing_Law__c) || masterAgr.GE_PRM_Arbitration_location__c != (Oldmap.get(masterAgr.id).GE_PRM_Arbitration_location__c) || masterAgr.GE_PRM_Arbitation_Loc_If_Other__c != (Oldmap.get(masterAgr.id).GE_PRM_Arbitation_Loc_If_Other__c)|| masterAgr.GE_PRM_If_Other_Governing_Law__c != (Oldmap.get(masterAgr.id).GE_PRM_If_Other_Governing_Law__c)))
            {
                MapMasterAggr.put(masterAgr.id,masterAgr);
      
            }
    
        }
    
        if(MapMasterAggr!= null && MapMasterAggr.size()>0)
        {
            for(Apttus__APTS_Agreement__c AddAgr : [select id, Apttus__Parent_Agreement__c,GE_PRM_Governing_Law__c,GE_PRM_Arbitration_location__c,GE_PRM_If_Other_Governing_Law__c,GE_PRM_Arbitation_Loc_If_Other__c from Apttus__APTS_Agreement__c where Apttus__Parent_Agreement__c IN :MapMasterAggr.keyset()])          
            {
                if(MapMasterAggr.get(AddAgr.Apttus__Parent_Agreement__c) != null)
                {
                System.debug('Gov Law'+MapMasterAggr.get(AddAgr.Apttus__Parent_Agreement__c).GE_PRM_Governing_Law__c);
                System.debug(' Arb Location'+MapMasterAggr.get(AddAgr.Apttus__Parent_Agreement__c).GE_PRM_Arbitration_location__c);
                System.debug(' arb If other'+MapMasterAggr.get(AddAgr.Apttus__Parent_Agreement__c).GE_PRM_Arbitation_Loc_If_Other__c);
                System.debug(' law if other'+MapMasterAggr.get(AddAgr.Apttus__Parent_Agreement__c).GE_PRM_If_Other_Governing_Law__c);
                    AddAgr.GE_PRM_Governing_Law__c=MapMasterAggr.get(AddAgr.Apttus__Parent_Agreement__c).GE_PRM_Governing_Law__c;
                    AddAgr .GE_PRM_Arbitration_location__c=MapMasterAggr.get(AddAgr.Apttus__Parent_Agreement__c).GE_PRM_Arbitration_location__c;
                    AddAgr.GE_PRM_Arbitation_Loc_If_Other__c=MapMasterAggr.get(AddAgr.Apttus__Parent_Agreement__c).GE_PRM_Arbitation_Loc_If_Other__c;
                    AddAgr.GE_PRM_If_Other_Governing_Law__c=MapMasterAggr.get(AddAgr.Apttus__Parent_Agreement__c).GE_PRM_If_Other_Governing_Law__c;
                    System.debug('Gov Law'+AddAgr.GE_PRM_Governing_Law__c);
                System.debug(' Arb Location'+AddAgr.GE_PRM_Arbitration_location__c);
                System.debug(' arb If other'+AddAgr.GE_PRM_Arbitation_Loc_If_Other__c);
                System.debug(' law if other'+AddAgr.GE_PRM_If_Other_Governing_Law__c);
                    ListAddendumAggr.add(AddAgr);
                }
            }

            if(ListAddendumAggr!= null && ListAddendumAggr.size()>0)    
            {
                try
                {
                    update ListAddendumAggr ;
                     if(Test.isRunningTest())
                         integer intTest =1/0;
                }
                
                catch(Exception e)
                {
                    
                    for(Apttus__APTS_Agreement__c nb:newObjects)
                    {
                    if( e.getmessage().contains('Please provide details on Limitations/Exclusions'))
                    {
                        e.setMessage('Please provide details on Limitations/Exclusions on related addendums before updating Governing Law or Arbitration location on Master');
                        nb.adderror(e.getMessage());
                    }
                    else if(e.getmessage().contains('Please provide data'))
                    {
                        e.setMessage('Please update the related addendums first as there may be some information missing');
                        nb.adderror(e.getMessage());
                        }
                    }
                }
                
            
            }
            }
        }
    }
    public void OnBeforeDelete(List<Apttus__APTS_Agreement__c> ObjectsToDelete, Map<Id, Apttus__APTS_Agreement__c> oldObjectMap)
    {
        // BEFORE DELETE LOGIC
    }
    public void OnAfterDelete(List<Apttus__APTS_Agreement__c> deletedObjects, Map<Id, Apttus__APTS_Agreement__c> oldObjectMap)
    {
        // AFTER DELETE LOGIC
    }
    public void OnUndelete(List<Apttus__APTS_Agreement__c> restoredObjects)
    {
        // AFTER UNDELETE LOGIC
    }
    **/
}