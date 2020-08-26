/*
    Author - Sajana Thomas
    Date - 13 Nov 2013
    Description - Case #8619 - Made changes to send email alert when a technician is assigned a WO. 
        This is implemented to replace workflow GE_OG_MC_AssignFEWorkOrder to fix defect 
        regarding time not appearing correctly on the email.
    Modified - Case #8619 - 26 Nov 2013 - Modified to replace workflow GE_OG_DS_AssignFEWorkOrder
*/

trigger SVMX_SendEmailOnWOAssignment on SVMXC__SVMX_Event__c (after insert, after update) {
    
    Set<Id> techid = new Set<Id>();
    Set<Id> svoid = new Set<Id>();
    Set<Id> whatIds  = new Set<Id>();
    
    
    for(SVMXC__SVMX_Event__c smaxevt:trigger.new)
    {
        whatIds.add(smaxevt.SVMXC__WhatId__c);
        
        if (SVMX_Utility.sendEmail == false 
            && ((trigger.isInsert 
                && smaxevt.SVMXC__WhatId__c != null 
                && smaxevt.SVMXC__Technician__c != null)
               || 
               (trigger.isUpdate
                && smaxevt.SVMXC__WhatId__c != null 
                && smaxevt.SVMXC__Technician__c != null
                && (smaxevt.SVMXC__Technician__c != trigger.oldMap.get(smaxevt.id).SVMXC__Technician__c)) 
               )
             && !SVMX_Utility.idset.contains(smaxevt.SVMXC__WhatId__c)
           )
        {
            System.debug('SVMX: Date is '+smaxevt.SVMXC__StartDateTime__c );
            svoid.add(smaxevt.SVMXC__WhatId__c);
            techid.add(smaxevt.SVMXC__Technician__c);
        }
        
        if(SVMX_Utility.idset.contains(smaxevt.SVMXC__WhatId__c))
            SVMX_Utility.idset.remove(smaxevt.SVMXC__WhatId__c);
        
        
    }
     
    if(svoid.size() > 0)
    {
        Id Userid = UserInfo.getUserId();
        String userEmail = UserInfo.getUserEmail();
        Id mcsET, dsET, mcsalldayET; 
        List<EmailTemplate> emailTemp = [Select id, Name, Body, Subject  from EmailTemplate where Name in ('GE_OG_DS_WorkOrderTechAssigned','GE_OG_MC_WorkOrderTechAssignedForMCS','GE_MC_EmailAlertForAllDayEvent')]; 
        for(EmailTemplate et : emailTemp )
        {
            if(et.Name =='GE_OG_MC_WorkOrderTechAssignedForMCS')
                mcsET = et.id;
            else if (et.Name =='GE_MC_EmailAlertForAllDayEvent')
                mcsalldayET = et.id;                
            else
                dsET  = et.id;
        }
                
        Map<id,SVMXC__Service_Group_Members__c> techs = new Map<id,SVMXC__Service_Group_Members__c>([select id, SVMXC__Email__c from SVMXC__Service_Group_Members__c where id in :techid]);
        //fetching all Work Orders assoicated with the events with the Recordtype MCS
        Map<id,SVMXC__Service_Order__c> wolist = new Map<id,SVMXC__Service_Order__c>([select id, SVMXC__Group_Member__c, GE_SM_HQ_Record_Type_Name__c , SVMXC__Group_Member__r.SVMXC__Email__c,GE_OG_MC_Service_Region__c 
            from SVMXC__Service_Order__c where id IN:svoid and 
            (GE_SM_HQ_Record_Type_Name__c = 'MCS' or 
            (GE_SM_HQ_Record_Type_Name__c = 'D&S' and SVMXC__NoOfTimesAssigned__c >= 1)) 
            and GE_SM_HQ_Dispatched_Outside_Territory__c = false ]);
        
        if(wolist != null && wolist.size() > 0)
        {
            for(SVMXC__SVMX_Event__c smaxevt:trigger.new)
            {
                
                if(techs.containskey(smaxevt.SVMXC__Technician__c) && techs.get(smaxevt.SVMXC__Technician__c).SVMXC__Email__c != null)
                {
                    System.debug('in here2 send email ');
                    //Send email
                    if(wolist.get(smaxevt.SVMXC__WhatId__c) != null 
                        && wolist.get(smaxevt.SVMXC__WhatId__c).GE_SM_HQ_Record_Type_Name__c == 'D&S')
                        SVMX_Utility.sendEmail(smaxevt.SVMXC__WhatId__c, dsET, Userid, techs.get(smaxevt.SVMXC__Technician__c).SVMXC__Email__c);
                    else if(wolist.get(smaxevt.SVMXC__WhatId__c) != null
                         && wolist.get(smaxevt.SVMXC__WhatId__c).GE_SM_HQ_Record_Type_Name__c == 'MCS')
                         {
                            if(smaxevt.SVMXC__IsAllDayEvent__c){
                                system.debug('smax event Id'+smaxevt.id +'Email template Id'+mcsalldayET+'user Name'+Userid+'technician Email Id'+techs.get(smaxevt.SVMXC__Technician__c).SVMXC__Email__c);
                                SVMX_Utility.sendEmailstoMCS(smaxevt.id, mcsalldayET, Userid, techs.get(smaxevt.SVMXC__Technician__c).SVMXC__Email__c);
                                
                            }else{
                            system.debug('smax event Id'+smaxevt.id +'Email template Id'+mcsET+'user Name'+Userid+'technician Email Id'+techs.get(smaxevt.SVMXC__Technician__c).SVMXC__Email__c);
                         
                                SVMX_Utility.sendEmailstoMCS(smaxevt.id, mcsET, Userid, techs.get(smaxevt.SVMXC__Technician__c).SVMXC__Email__c);
                            }
                         }
                        
                }
            }
            SVMX_Utility.sendEmail = true;
        }
    }
    //Below code is for PC ServiceMaxEvents
    if(Trigger.isInsert){ 
    List<SVMXC__Service_Order__c> pcWoList = new List<SVMXC__Service_Order__c>();
    if(whatIds!=null){
                    //R-26288 - Added GE_SM_HQ_Task_Description__c,GE_PC_Driving_Directions__c in the below query
                pcWoList = [SELECT Id,Name,GE_SM_HQ_Task_Description__c,GE_PC_Driving_Directions__c,GE_SM_HQ_Record_Type_Name__c,SVMXC__Site__r.Name,SVMXC__Company__r.Name,GE_SM_HQ_Scheduled_Start_Date_Time__c,GE_SM_HQ_Scheduled_End_Date_Time__c,Region__c from SVMXC__Service_Order__c where Id in :whatIds and GE_SM_HQ_Record_Type_Name__c='PC'];              
                
                   }
    if(pcWoList!=null){
    SVMX_Utility.sendEmailsToPC(Trigger.new,pcWoList);
    }
    }
    

}