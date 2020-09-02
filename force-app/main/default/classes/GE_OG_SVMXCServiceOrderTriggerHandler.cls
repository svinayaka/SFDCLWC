/*
Class Name                   - GE_OG_SVMXCServiceOrderTriggerHandler 
Object Name                  - SVMXCServiceOrder
Created Date                 - 7/22/2014
Description                  -  Handler Class GE_OG_SVMXCServiceOrderTriggerHandler would process all the Trigger requests coming from GE_OG_ContactTrigger
All Logic to be processed in the Handler Class or Helper Classes being called from this Handler Class
*/
public without sharing class GE_OG_SVMXCServiceOrderTriggerHandler  {

ID Rectype=Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('PC').getRecordTypeId();    

    public void OnBeforeInsert(List<SVMXC__Service_Order__c> newObjects){
        // EXECUTE BEFORE INSERT LOGIC
        // CREATED A CLASS CALLED GE_OG_MCS_WOQueueassignment TO ASSIGN THE QUEUE BASED ON BUSINESS REGION AND SUB P&L
        
        //GE_OG_MCS_WOQueueassignment woQueue= new GE_OG_MCS_WOQueueassignment(); - R-29618
        //woQueue.beforeinsertWOQueueassignment(newObjects); - R-29618
        GE_OG_GS_FenceTimeUtils.setFenceTime(newObjects, null, true);
         /**R-24221,Added to manage the "GE_HQ_UpdateWorkOrderTechAssignment" Trigger from Old customization.*/
        GE_HQ_UpdateWOTechAssignmentHelper techassignhelper = new GE_HQ_UpdateWOTechAssignmentHelper();
        techassignhelper.techAssignmentbeforeInsert(newObjects);
        //*******R-24221,End of Code  for "GE_HQ_UpdateWorkOrderTechAssignment" Trigger ********************************/
        
         /****** Added to update case number based on ERP number***/
        ID DSRectypeId=Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('MCS').getRecordTypeId();
      List<SVMXC__Service_Order__c> DSlstWOs=new List<SVMXC__Service_Order__c>();
           
            /*for(SVMXC__Service_Order__c dsWO  : newObjects)
            {
            if(dsWO.RecordTypeId==DSRectypeId){
            DSlstWOs.add(dsWO);
            }
            }*/
            
               //if(DSlstWOs.Size()>0){
              GE_DS_UpdateCasewithWOERPProjnumber caseERPNo = new GE_DS_UpdateCasewithWOERPProjnumber();
              caseERPNo.caseupdatewithErpNumber(DSlstWOs); 
           // }
            
        
        Map<Id, SVMXC__Service_Order__c> mapMWO = new Map<Id, SVMXC__Service_Order__c>();
        Map<Id, Opportunity> mapWoOP = new Map<Id, Opportunity>();
        /////////////////////////////////////
        //Id csrtid = Schema.SObjectType.SVMXC__service_order__c.getRecordTypeInfosByName().get('SS-Mobilize').getRecordTypeId();
        Set<String> WORTNames = new Set<String>();
        WORTNames.Add('SS-Mobilize');
        
        List<Id> lstOppId = new List<Id>();
        system.debug('entered ');
         for (SVMXC__Service_Order__c tmpRec : newObjects)
          {
            mapMWO.put(tmpRec.id,tmpRec); 
            if(WORTNames.Contains(tmpRec.GE_SM_HQ_Record_Type_Name__c))// && tmpRec.GE_DS_Opportunity_Name__C != null)
                lstOppId.Add(tmpRec.GE_DS_Opportunity_Name__C);
                    
          }
          List<SVMXC__Service_Order__c> lstWO = new List<SVMXC__Service_Order__c>();
          if(lstOppId.size() > 0)
          {
          //for(newObjects.GE_DS_Opportunity_Name__C)
            mapWoOP.PutAll([SELECT id, Account.Name, Owner.Name, CloseDate, ForecastCategoryName, Type,Probability, StageName From Opportunity Where Id IN : lstOppId]);
          //where ID IN: newObjects.GE_DS_Opportunity_Name__C
     
          //List<Opportunity> lstOpp = new List<Opportunity>([SELECT id, Account.Name, Owner.Name, CloseDate, ForecastCategoryName, Type,Probability, StageName From Opportunity where ID IN: newObjects.GE_DS_Opportunity_Name__C]);
          for(SVMXC__Service_Order__c tmpRec : newObjects)
          {
               Opportunity objOpp = mapWoOP.get(tmpRec.GE_DS_Opportunity_Name__C);
              // system.debug('objOpp.Account.Name--->' + objOpp.Account.Name);
              if(objOpp != null )
              {
              tmpRec.GE_SS_Opp_Account_Name__c    = objOpp.Account.Name;
            //  tmpRec.GE_SS_Opportunity_Owner_Alias__c = objOpp.Owner.Name; Deleted the fields as part of R-26138
            //  tmpRec.GE_SS_Opp_Expected_Order_Date__c = string.ValueofGMT(objOpp.CloseDate); Deleted the fields as part of R-26138
              tmpRec.GE_SS_Opportunity_Forecast__c = objOpp.ForecastCategoryName;
            //  tmpRec.GE_SS_Opportunity_Type__c = objOpp.Type ;Deleted the fields as part of R-26138
            //  tmpRec.GE_SS_Opportunity_Probablity__c = objOpp.Probability;Deleted the fields as part of R-26138
            //  tmpRec.GE_SS_Opportunity_Stage__c = objOpp.StageName ; Deleted the fields as part of R-26138
              }
              else
              {
              tmpRec.GE_SS_Opp_Account_Name__c    = '';
            //  tmpRec.GE_SS_Opportunity_Owner_Alias__c = ''; Deleted the fields as part of R-26138
             // tmpRec.GE_SS_Opp_Expected_Order_Date__c = ''; Deleted the fields as part of R-26138
              tmpRec.GE_SS_Opportunity_Forecast__c = '';
            //  tmpRec.GE_SS_Opportunity_Type__c = '' ; Deleted the fields as part of R-26138
            //  tmpRec.GE_SS_Opportunity_Probablity__c = NULL; Deleted the fields as part of R-26138
             // tmpRec.GE_SS_Opportunity_Stage__c = '' ;  Deleted the fields as part of R-26138
              }
              lstWO.add(tmpRec);
              
          }
          }
          //R-30388
          //AutoEntitlement Multipricebook
           ID ALRectypeId=Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('AL').getRecordTypeId();
            
            List<SVMXC__Service_Order__c> ALlstWOs=new List<SVMXC__Service_Order__c>();
           
            for(SVMXC__Service_Order__c alWO  : newObjects)
            {
            if(alWO.RecordTypeId==ALRectypeId){
            ALlstWOs.add(alWO);
            }
            }
            
               if(ALlstWOs.Size()>0){
              SVMX_MultiPrice_AutoEntitlement autoentitlement = new SVMX_MultiPrice_AutoEntitlement();
              autoentitlement.ProcessAutoEntitlement(ALlstWOs,null,true); 
            }
            
          //SVMX_MultiPrice_AutoEntitlement.ProcessAutoEntitlement(newObjects, null, true);
          
          
          
          

   }
      public void OnAfterInsert(List<SVMXC__Service_Order__c> newObjects){
        // EXECUTE AFTER INSERT LOGIC
        //Start R-24337       
        GE_OG_WorkOrderUpdate updateWODs=new GE_OG_WorkOrderUpdate();
        updateWODs.updateWOBillingRegion(newObjects);            
        
        //End R-24337
        
        //R-24221,Added for code refactoring of added for trigger 'GE_OG_MC_AssignFEWorkOrder_Email'
        GE_OG_MC_AssignFEWorkOrder_EmailHelper assignFE = new GE_OG_MC_AssignFEWorkOrder_EmailHelper();
        assignFE.borrowTechnicianAfterInsert(newObjects);
       //End of code refactoring of added for trigger 'GE_OG_MC_AssignFEWorkOrder_Email'
       //*R-24221, Added to manage the "SVMX_CheckWOstatusUpdate" Trigger from Old customization.*/
        
        SVMX_CheckWOstatusUpdateTriggerHelper helper = new SVMX_CheckWOstatusUpdateTriggerHelper();
        //helper.updateCaseonWorkOrderCloseAfterInsert(newObjects);
        
        //**********************End of Code  for "SVMX_CheckWOstatusUpdate" Trigger ****************************// 
        
        List<SVMXC__Service_Order__c> oldObjects = new List<SVMXC__Service_Order__c>(); 
        GE_OG_WorkOrderUpdate wrkUpdates = new GE_OG_WorkOrderUpdate();
        wrkUpdates.updateWOJobTypeSkillset(oldObjects,newObjects,'afterInsert'); 
        
       
    }
    
    public void OnBeforeUpdate(List<SVMXC__Service_Order__c> oldObjects, List<SVMXC__Service_Order__c> newObjects, Map<Id, SVMXC__Service_Order__c> newObjectMap){
       
       
      
       
        // BEFORE UPDATE LOGIC
        // CREATED A CLASS CALLED GE_OG_MCS_WOQueueassignment TO ASSIGN THE QUEUE BASED ON BUSINESS REGION AND SUB P&L
        
        //GE_OG_MCS_WOQueueassignment woQueue= new GE_OG_MCS_WOQueueassignment(); - R-29618
        //woQueue.beforeupdateWOQueueassignment(newObjects,oldObjects); - R-29618
        GE_OG_GS_FenceTimeUtils.setFenceTime(newObjects, new Map<Id, SVMXC__Service_Order__c>(oldObjects), false);
        GE_OG_GS_ExpertiseUsage.updateExpertiseUsage(newObjects, new Map<ID, SVMXC__Service_Order__c>(oldObjects));
        //**R-24221, Added to manage the "GE_HQ_UpdateWorkOrderTechAssignment" Trigger from Old customization.*//
        
        GE_HQ_UpdateWOTechAssignmentHelper techassignhelperup = new GE_HQ_UpdateWOTechAssignmentHelper();
        techassignhelperup.techAssignmentbeforeUpdate(newObjects,oldObjects);
          
        //*******R-24221,End of Code  for "GE_HQ_UpdateWorkOrderTechAssignment" Trigger *******************//
              
        if (!SVMX_WorkOrderRecursiveSaveHelper.isAlreadyRunPreUpdateWorkOrder() )
        {                     
            SVMX_WorkOrderRecursiveSaveHelper.setAlreadyRunPreUpdateWorkOrder();
       /*---------DTS APPROVAL PROCESS-----------------*/
           GE_DTS_Non_Home_Territory dtshelper = new GE_DTS_Non_Home_Territory();
            dtshelper.beforewoupdate(oldObjects,newObjectMap);
        /*--------END OF APPROVAL PROCESS---------------*/
       }
        
        /****** Added to update case number based on ERP number***/
       ID DSRectypeId=Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('MCS').getRecordTypeId();
       GE_DS_UpdateCasewithWOERPProjnumber caseERPNo = new GE_DS_UpdateCasewithWOERPProjnumber();
       caseERPNo.caseupdatewithErpNumber(newObjects);
        
        ///////////////////////////////////////////////////////////////////////////////////////////////
        Map<Id, SVMXC__Service_Order__c> mapMWO = new Map<Id, SVMXC__Service_Order__c>();
        Map<Id, Custom_Opportunity__c> mapWoOP = new Map<Id, Custom_Opportunity__c>();
        Set<String> WORTNames = new Set<String>();
        WORTNames.Add('SS-Mobilize');
        /////////////////////////////////////
        List<Id> lstOppId = new List<Id>();
        system.debug('entered ');
         for (SVMXC__Service_Order__c tmpRec : newObjects)
          {
            mapMWO.put(tmpRec.id,tmpRec); 
            if(WORTNames.Contains(tmpRec.GE_SM_HQ_Record_Type_Name__c))// && tmpRec.GE_DS_Opportunity_Name__C != null)
                lstOppId.Add(tmpRec.GE_DTS_OpptyMax_Opportunity__c);
                    
          }
          List<SVMXC__Service_Order__c> lstWO = new List<SVMXC__Service_Order__c>();
          
          //for(newObjects.GE_DS_Opportunity_Name__C)
          if(lstOppId.size() > 0)
          {
              mapWoOP.PutAll([SELECT id, GE_OG_Customer_Name__r.Name, Owner.Name, GE_OG_Forecast__c From Custom_Opportunity__c Where Id IN : lstOppId]);
          //where ID IN: newObjects.GE_DS_Opportunity_Name__C
      
          //List<Opportunity> lstOpp = new List<Opportunity>([SELECT id, Account.Name, Owner.Name, CloseDate, ForecastCategoryName, Type,Probability, StageName From Opportunity where ID IN: newObjects.GE_DS_Opportunity_Name__C]);
          for(SVMXC__Service_Order__c tmpRec : newObjects)
          {
               Custom_Opportunity__c objOpp = mapWoOP.get(tmpRec.GE_DTS_OpptyMax_Opportunity__c);
              // system.debug('objOpp.Account.Name--->' + objOpp.Account.Name);
              if(objOpp != null )
              {
                  tmpRec.GE_SS_Opp_Account_Name__c    = objOpp.GE_OG_Customer_Name__r.Name;
                  tmpRec.GE_SS_Opportunity_Forecast__c = objOpp.GE_OG_Forecast__c; 
              } 
              else
              {
                  tmpRec.GE_SS_Opp_Account_Name__c    = '';
                  tmpRec.GE_SS_Opportunity_Forecast__c = '';
              }
              lstWO.add(tmpRec);
              
          }
            List<SVMXC__Service_Order__c> lstMWO = new List<SVMXC__Service_Order__c>();
            List<Id> lstWOIds = new List<Id>(); 
           for(SVMXC__Service_Order__c tmpWO : newObjects)
           {
               if(tmpWO.SVMXC__Order_Status__c == 'Closed')
               {
                   lstWOIds.add(tmpWO.id);
                   tmpWO.SVMXC__Closed_By__c = userinfo.getUserId();
                   tmpWO.SVMXC__Closed_On__c = Date.today();
                   lstMWO.add(tmpWO);
               }
           }
         }
           ID DRLRectypeId=Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('D&S').getRecordTypeId();
           List<SVMXC__Service_Order__c> drllstWOs=new List<SVMXC__Service_Order__c>();
           
            for(SVMXC__Service_Order__c tmpWO  : newObjects)
            {
               if(tmpWO.RecordTypeId==DRLRectypeId && (tmpWO.SVMXC__Order_Status__c=='Ready for Invoicing' ||tmpWO.SVMXC__Order_Status__c=='Billing in Progress')){
                  drllstWOs.add(tmpWO);
                }
            }
           
           if(drllstWOs.Size()>0){
                GE_OG_WOTotalLaborAmount updateWOAmount = new GE_OG_WOTotalLaborAmount();
                updateWOAmount.UpdateTotalAmount(drllstWOs);
            }
            //R-30388
            //AutoEntitlement Multipricebook
            ID ALRectypeId=Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('AL').getRecordTypeId();
            
            List<SVMXC__Service_Order__c> ALlstWOs=new List<SVMXC__Service_Order__c>();
           
            for(SVMXC__Service_Order__c alWO  : newObjects)
            {
            if(alWO.RecordTypeId==ALRectypeId){
            ALlstWOs.add(alWO);
            }
            }
            
               if(ALlstWOs.Size()>0){
              SVMX_MultiPrice_AutoEntitlement autoentitlement = new SVMX_MultiPrice_AutoEntitlement();
              autoentitlement.ProcessAutoEntitlement(ALlstWOs,new Map<Id, SVMXC__Service_Order__c>(oldObjects), false); 
            }
            
           //AutoEntitlement Multipricebook
          //SVMX_MultiPrice_AutoEntitlement.ProcessAutoEntitlement(newObjects, new Map<Id, SVMXC__Service_Order__c>(oldObjects), false);
        //////////////////////////////////////////////////////////////////////////////////////////////
        
    }
    
    public void OnAfterUpdate(List<SVMXC__Service_Order__c> oldObjects, List<SVMXC__Service_Order__c> newObjects, Map<Id, SVMXC__Service_Order__c> newObjectMap){
    List<SVMXC__Service_Order__c> lstWONew=new List<SVMXC__Service_Order__c>();
    ID PCRectypeId=Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('PC').getRecordTypeId();
    ID ALRectypeId=Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('AL').getRecordTypeId();
    ID DRLRectypeId=Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('D&S').getRecordTypeId();
    ID SSRectypeId=Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('SS-Mobilize').getRecordTypeId();
    ID MCSRectypeId=Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('MCS').getRecordTypeId();
   //Added as a part of R-24690 
    if(!SVMX_WorkOrderRecursiveSaveHelper.isAlreadyRunPostUpdateWorkOrderDRL())
    {
        SVMX_WorkOrderRecursiveSaveHelper.setAlreadyRunPostUpdateWorkOrderDRL();
        GE_DS_WO_LinesUpdate instance= new GE_DS_WO_LinesUpdate();
        instance.updateLineItemRates(newObjects,oldObjects);
      //End of R-24690
    }
    
   //**R-24221, Added to manage the "SVMX_CheckWOstatusUpdate" Trigger from Old customization.*****//
   //Stopped the recursion as part of R-29610
   for(SVMXC__Service_Order__c woNew : newObjects){
       if(woNew.recordTypeId==DRLRectypeId || woNew.recordTypeId==MCSRectypeId){
           lstWONew.add(woNew);
       }
   }
   if(lstWONew.size()>0){
   if (!SVMX_WorkOrderRecursiveSaveHelper.isAlreadyRunPostUpdateWorkOrder3() )
       {  
           SVMX_WorkOrderRecursiveSaveHelper.setAlreadyRunPostUpdateWorkOrder3();
           SVMX_CheckWOstatusUpdateTriggerHelper helper = new SVMX_CheckWOstatusUpdateTriggerHelper();
          // helper.updateCaseonWorkOrderCloseAfterUpdate(oldObjects,newObjects);
       }
   }
    //R-26065 starts
        if (!SVMX_WorkOrderRecursiveSaveHelper.isAlreadyRunPostUpdateWorkOrder2() )
        {                     
            SVMX_WorkOrderRecursiveSaveHelper.setAlreadyRunPostUpdateWorkOrder2();
            GE_OG_WorkOrderUpdate wrkUpdates = new GE_OG_WorkOrderUpdate();
            wrkUpdates.updateWOJobTypeSkillset(oldObjects,newObjects,'afterUpdate');  
        }
    ////R-26065 Ends
       /*---------DTS APPROVAL PROCESS-----------------*/
         
           GE_DTS_Non_Home_Territory dtshelper = new GE_DTS_Non_Home_Territory();
           dtshelper.afterwoupdate(oldObjects,newObjectMap);          
             /*--------END OF APPROVAL PROCESS---------------*/
     
        // AFTER UPDATE LOGIC
      /* GE_OG_MCS_WOupdateEvent EventUpdate=new GE_OG_MCS_WOupdateEvent();
       EventUpdate.afterupdatewoevent(oldObjects,newObjects);
       */ 
       
       // R-24221,Added for code refactoring of added for trigger 'GE_OG_MC_AssignFEWorkOrder_Email'
       //Stopped the recursion as part of R-29610
       if (!SVMX_WorkOrderRecursiveSaveHelper.isAlreadyRunPostUpdateWorkOrder4() )
        { 
           SVMX_WorkOrderRecursiveSaveHelper.setAlreadyRunPostUpdateWorkOrder4();
           GE_OG_MC_AssignFEWorkOrder_EmailHelper assignFE = new GE_OG_MC_AssignFEWorkOrder_EmailHelper();
           assignFE.borrowTechnicianAfterUpdate(oldObjects,newObjects);
        }
       //R-24221,End of code refactoring of added for trigger 'GE_OG_MC_AssignFEWorkOrder_Email'
       
      
      if(newObjects != null && newObjects.size() > 0)
      {
           List<Id> lstWOIds = new List<Id>();
           List<SVMXC__Service_Order__c> lstWorkOrders = new List<SVMXC__Service_Order__c>();
           List<SVMXC__Service_Order__c> lstTripWorkOrdersUpdate = new List<SVMXC__Service_Order__c>();
          // List<SVMXC__Service_Order__c> lstMWO = new List<SVMXC__Service_Order__c>();
           
           for(SVMXC__Service_Order__c tmpWO : newObjects)
           {
               if(tmpWO.SVMXC__Order_Status__c == 'Closed')
               {
                   lstWOIds.add(tmpWO.id);
                  // tmpWO.SVMXC__Closed_By__c = userinfo.getUserId();
                 //  tmpWO.SVMXC__Closed_On__c = Date.today();
                 //  lstMWO.add(tmpWO);
               }
           }
           
           if(lstWOIds != null && lstWOIds.size() > 0)
                lstWorkOrders = [Select Id, SVMXC__Order_Status__c, GE_SM_HQ_Actual_End_Date__c From SVMXC__Service_Order__c where GE_SS_Parent_Work_Order__c IN: lstWOIds and GE_SM_HQ_Record_Type_Name__c = 'SS-Trip'];
           
           //system.debug('lstWorkOrders--->' + lstWorkOrders);
           if(lstWorkOrders != null && lstWorkOrders.size() > 0)
            {system.debug('lstWorkOrders.size()--->' + lstWorkOrders.size());
                for(SVMXC__Service_Order__c ObjWO : lstWorkOrders)
                {system.debug('reached--->for');
                    ObjWO.SVMXC__Order_Status__c = 'Closed';
                    ObjWO.SVMXC__Closed_By__c = userinfo.getUserId();
                    ObjWO.SVMXC__Closed_On__c = Date.today();
                    //if(ObjWO.GE_SM_HQ_Actual_End_Date__c == null)
                      //  ObjWO.GE_SM_HQ_Actual_End_Date__c = System.Now();
                  lstTripWorkOrdersUpdate.add(ObjWO);
                }
                update lstTripWorkOrdersUpdate;
            }
          //integer a = 1/0;
      }  
      
       ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
      //*******R-24221,End of Code  for "SVMX_CheckWOstatusUpdate" Trigger *****************************************//
        System.debug('Testing--->');
        System.debug('oldObjects-->'+ oldObjects + 'newObjects-->'+ newObjects);
        Map<ID,SVMXC__Service_Order__c> mapWOs=new Map<ID,SVMXC__Service_Order__c> ();
        
        for(SVMXC__Service_Order__c woo:oldObjects)
        {
            for(SVMXC__Service_Order__c won:newObjects)
            {
            
            //Bug# 0000024074: For PC in the below criteria added woo.SVMXC__Order_Status__c=='Work Complete' 
            //R-25384 : For PC in the below criteria changed SVMXC__Order_Status__c=='Closed'
            //if((won.RecordTypeId==PCRectypeId && won.SVMXC__Order_Status__c=='Ready for Invoicing' && woo.SVMXC__Order_Status__c!='Ready for Invoicing' && woo.SVMXC__Order_Status__c=='Work Complete') || (won.RecordTypeId==DRLRectypeId && won.SVMXC__Order_Status__c=='Work Complete' && woo.SVMXC__Order_Status__c!='Work Complete') || (won.RecordTypeId==ALRectypeId && won.SVMXC__Order_Status__c=='Admin Verification' && woo.SVMXC__Order_Status__c!='Admin Verification') || (won.RecordTypeId==SSRectypeId && won.SVMXC__Order_Status__c=='Admin Verification' && woo.SVMXC__Order_Status__c!='Ready for Invoicing')  )
              if((won.RecordTypeId==PCRectypeId && won.SVMXC__Order_Status__c=='Closed' && woo.SVMXC__Order_Status__c!='Closed') || (won.RecordTypeId==DRLRectypeId && won.SVMXC__Order_Status__c=='Closed' && woo.SVMXC__Order_Status__c!='Closed') || (won.RecordTypeId==ALRectypeId && won.SVMXC__Order_Status__c=='Closed-Client Invoiced' && woo.SVMXC__Order_Status__c!='Closed-Client Invoiced') || (won.RecordTypeId==SSRectypeId && won.SVMXC__Order_Status__c=='Admin Verification' && woo.SVMXC__Order_Status__c!='Ready for Invoicing')  )
              {
                 if (!SVMX_WorkOrderRecursiveSaveHelper.isAlreadyRunPostUpdateWorkOrder() )
                 {                     
                     SVMX_WorkOrderRecursiveSaveHelper.setAlreadyRunPostUpdateWorkOrder();
                     System.debug('###Update Expertise ');
                     GE_OG_PC_WOupdateExpertise ExpertiseUpdate = new GE_OG_PC_WOupdateExpertise();
                     ExpertiseUpdate.afterupdatewo(oldObjects,newObjects);
                 }  
              }
              if(won.GE_PC_Safety_Answer__c!=woo.GE_PC_Safety_Answer__c || won.GE_PC_Quality_Answer__c!=woo.GE_PC_Quality_Answer__c || won.GE_PC_Deliver_Answer__c!=woo.GE_PC_Deliver_Answer__c)
              {         
                if (!WorkOrderRecursiveSaveHelper.isAlreadyRunPostUpdateWorkOrder() )
                {
                    WorkOrderRecursiveSaveHelper.setAlreadyRunPostUpdateWorkOrder();
                    GE_OG_WorkOrderUpdate surveyEmails = new GE_OG_WorkOrderUpdate();
                    surveyEmails.sendSurveyEmails(oldObjects,newObjects);                       
                }                   
                    
              }
//Start R-23096 : Added on 14-Sep-15 : Update Status of all Work Order Lines to Open when PC Work Order Status is set to Ready for Invoicing.
              if(won.RecordTypeId==Rectype && won.SVMXC__Order_Status__c=='Ready for Invoicing' && woo.SVMXC__Order_Status__c=='Sent to Oracle')
              {
                 if (!SVMX_WorkOrderRecursiveSaveHelper.isAlreadyRunPostUpdateWorkOrder() )
                 {
                     WorkOrderRecursiveSaveHelper.setAlreadyRunPostUpdateWorkOrder();
                     mapWOs.put(won.Id,won);
                 }              
              } 
                          
            }
        }
//Start R-23096 :        
        if(mapWOs.size()>0)
        {
                    GE_OG_WorkOrderUpdate updateWODs=new GE_OG_WorkOrderUpdate();
                    updateWODs.updateWorkDetailStatus(mapWOs);
        }
//End R-23096

//Start  R-24337
List<SVMXC__Service_Order__c> lstWOs=new List<SVMXC__Service_Order__c>();


for(SVMXC__Service_Order__c woo:oldObjects)
{
    for(SVMXC__Service_Order__c won:newObjects)
    {        
    if(won.RecordTypeId==PCRectypeId && won.GE_PC_Branch__c!= woo.GE_PC_Branch__c)
    {
               lstWOs.add(won);                
    }
    
    }
}
System.debug('### Size of Work Order before method call '+lstWOs.size());
if(lstWOs.Size()>0)
{
 GE_OG_WorkOrderUpdate updateWODs=new GE_OG_WorkOrderUpdate();
 updateWODs.updateWOBillingRegion(lstWOs);
}
//End  R-24337


    }
    
    public void OnBeforeDelete(List<SVMXC__Service_Order__c> ObjectsToDelete, Map<Id, SVMXC__Service_Order__c> oldObjectMap){
        // BEFORE DELETE LOGIC
    }
    
    public void OnAfterDelete(List<SVMXC__Service_Order__c> deletedObjects, Map<Id, SVMXC__Service_Order__c> oldObjectMap){
        // AFTER DELETE LOGIC
    }
    
    public void OnUndelete(List<SVMXC__Service_Order__c> restoredObjects){
        // AFTER UNDELETE LOGIC
    }
    
}