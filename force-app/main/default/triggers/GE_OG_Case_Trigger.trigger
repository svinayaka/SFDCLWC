//**********************************************************/
//Trigger Name : GE_OG_Case_Trigger
//Created Date : 06/24/2014
//Usage : Consolidated Single Trigger on Case Object.
//**********************************************************/
trigger GE_OG_Case_Trigger on Case(before Insert, before update, before delete, after Insert, after update, after delete) {
    ID NPTRectypeID = Schema.SObjectType.Case.getRecordTypeInfosByName().get('SS_NPT').getRecordTypeId();
    ID CIRRectypeID = Schema.SObjectType.Case.getRecordTypeInfosByName().get('CIR').getRecordTypeId();
    //** Adding the logic for MCS Substatus Age Hours Calculation. Ref:  Bug 17652
    /*if(Trigger.isInsert && Trigger.isBefore){
        for(case c : Trigger.New) {
            if(c.Status == 'New' || c.Status == 'Resolved'|| c.Status == 'Cancelled'){
                c.GE_OG_Service_MCS_SS_Age_Timer__C = -2; 
            }
            if(c.Status == 'Open' && string.valueof(c.MCS_Sub_Status__c) == '' ) {
                c.GE_OG_Service_MCS_SS_Age_Timer__C = -1; 
            }
            if(c.Status == 'Closed' && string.valueof(c.MCS_Sub_Status__c) == '' ) {
                c.GE_OG_Service_MCS_SS_Age_Timer__C = -1; 
            }
            if(c.Status == 'Open' && string.valueof(c.MCS_Sub_Status__c) != '' ) {
                c.GE_OG_Service_MCS_SS_Age_Timer__C = 0; 
            }
            if(c.Status == 'Closed' && string.valueof(c.MCS_Sub_Status__c) != '' ) {
                c.GE_OG_Service_MCS_SS_Age_Timer__C = c.GE_OG_Service_MCS_Substatus_Age_Hours__c; 
            }
        }
    }*/
    if (Trigger.isbefore && (Trigger.IsInsert || Trigger.IsUpdate))
    {   
        Set < Id > accid = new set < Id > ();
        for (Case c: Trigger.new) 
        {
            if (c.Key_Account_Name__c == null && c.AccountId != null && c.recordtypeid == CIRRectypeID) {
                accid.add(c.AccountId);
            }
        }
        
        Map < id, Account > accmap = new Map < Id, account > ([select id, name, Member_of_GE_OG__c from Account where id IN: accid]);
        Map<String, GEOG_Key_Account_mapping__c> allKeyA = GEOG_Key_Account_mapping__c.getAll();
        System.debug(allKeyA);
        for (case c : Trigger.New) 
        {
            if (c.Key_Account_Name__c == null && accmap.containskey(c.Accountid) && accmap.get(c.Accountid).Member_of_GE_OG__c != null &&  c.recordtypeid == CIRRectypeID && allKeyA.containsKey(accmap.get(c.Accountid).Member_of_GE_OG__c)) {
                c.Key_Account_Name__c = accmap.get(c.Accountid).Member_of_GE_OG__c;
            }
        }
    }
    
    if (Trigger.isbefore && Trigger.IsInsert) 
    {
        for (case c : Trigger.New) 
        {
            if (c.status == 'Waiting for Customer' && c.GE_OG_CIR_Waiting_for_Customer__c == null) {
                c.GE_OG_CIR_Waiting_for_Customer__c = system.today();

            }
            //System.debug('accmap.get(c.Accountid).Member_of_GE_OG__c'+ accmap.get(c.Accountid).Member_of_GE_OG__c);
            //System.debug('allKeyA.containsKey(accmap.get(c.Accountid).Member_of_GE_OG__c)'+allKeyA.containsKey(accmap.get(c.Accountid).Member_of_GE_OG__c));
            
            

            System.debug('c.Key_Account_Name_Web__c' + c.Key_Account_Name_Web__c);
            if ((c.Key_Account_Name_Web__c != Null)) 
            {    
                c.Web_Case_Check__c = true;
                
                if(c.Key_Account_Name_Web__c == 'None')
                {
                    c.Key_Account_Name__c = null;
                }
                else
                {
                    c.Key_Account_Name__c = c.Key_Account_Name_Web__c;
                }
            }

        }

    }

    if (trigger.isbefore && trigger.isupdate) {
        for (
            case c:
                Trigger.New) {
            if (c.status == 'Waiting for Customer' && c.GE_OG_CIR_Waiting_for_Customer__c == null) {
                c.GE_OG_CIR_Waiting_for_Customer__c = system.today();

            }
            if (c.status != 'Waiting for Customer' && trigger.oldmap.get(c.id).status == 'Waiting for Customer') {
                c.Waiting_for_Customer_Freeze__c = c.GE_OG_CIR_Waiting_for_Customer__c.daysbetween(system.today());
            }

        }
    }

    GE_OG_Case_TriggerHandlerManager CaseTriggerHandlerManager = new GE_OG_Case_TriggerHandlerManager();
    /*
    Added by Raju Manche for R-20954
    */
    if (trigger.isbefore) {
        if (trigger.isInsert) {
            for (
                case cas:
                    trigger.new) {
                CaseTriggerHandlerManager.dupecheck(cas);
            }
        } else if (trigger.isUpdate) {
            for (
                case cas:
                    trigger.new) {

                /////////////////////  for NPT Cases
                if (string.valueof(Trigger.oldmap.get(cas.id).ownerid).startswith('00G') && cas.recordtypeid == NPTRectypeID && Trigger.oldmap.get(cas.id).ownerid != cas.ownerid) {
                    List < GroupMember > groups1 = [select Id from GroupMember where Group.Type = 'Queue'
                        and GroupId =: Trigger.oldmap.get(cas.id).ownerid and UserOrGroupId =: userinfo.getuserid()
                    ];
                    if (groups1 == null || groups1.size() <= 0) {

                        cas.adderror('Only a Queue member can take the ownership of NPT cases, if you want to assign to some one else Please accept and then chnage the owner.');
                    } else {
                        cas.status = 'Open';
                    }

                }

                /////////////// for NPT cases
                CaseTriggerHandlerManager.dupecheckUpdate(cas, trigger.oldmap.get(cas.id));
            }
        }
    }
    if (trigger.isbefore) {
        if (trigger.isInsert) {
            CaseTriggerHandlerManager.beforeinsertbeforeupdatecaseCounterregionpopltion(trigger.new);
            //CaseTriggerHandlerManager.beforeInsertUpdateTier3(trigger.new);
            /*  
            Modified from Trigger:GE_NumOFContactsforEmailid.
            purpose:Close all tasks when case has closed
            */
            if (!OpptyTriggerhelperClass.sBNumOFContactsforEmailid()) {
                CaseTriggerHandlerManager.beforeInsertNumOFContactsforEmailid(Trigger.new);
                OpptyTriggerhelperClass.setsBNumOFContactsforEmailid();
            }

            /*  
            Modified from Trigger:AssignmentGroupFieldUpdation.
            purpose:Included subtype mandatory logic for mcs record type
            */
            CaseTriggerHandlerManager.beforeInsertassignmentGroupField(Trigger.new);

            /*  
            Modified from Trigger:GE_MCS_Prepopulate_from_ParentCase
            purpose:Used to populate the Opportunity field on the Child Case from the Parent Case if the Parent Case SubType = 'RFQ Processing'
            */
            CaseTriggerHandlerManager.beforeInsertbeforeUpdatePrePopulateParent(Trigger.new);

            /*  
            Modified from Trigger:GE_HQ_PopulateCaseFromInstalledBase.
            purpose:
            */
            CaseTriggerHandlerManager.beforeInsertpopulateCaseFromInstalledBase(Trigger.new);

            /*  
            Modified from Trigger:GE_HQ_MarkCaseAsRedundant.
            purpose:to mark Is Redundant flag as true if the case is getting generated as a result of 
            emails from customers for legacy Single Org cases belonging to OG  EM businesses
            */
            CaseTriggerHandlerManager.beforeInsertCaseAsRedundant(Trigger.new);
        } else if (trigger.isUpdate) {
            if (!OpptyTriggerhelperClass.sbeforeinsertbeforeupdatecaseCounterregionpopltion()) {
                CaseTriggerHandlerManager.beforeinsertbeforeupdatecaseCounterregionpopltion(trigger.new);
                OpptyTriggerhelperClass.setsbeforeinsertbeforeupdatecaseCounterregionpopltion();
            }

            if (!OpptyTriggerhelperClass.sbeforeupdatestatuschange()) {
                CaseTriggerHandlerManager.beforeupdatestatuschange(trigger.new, trigger.oldmap);
                OpptyTriggerhelperClass.setsbeforeupdatestatuschange();
            }


            /*  
            Modified from Trigger:GE_NumOFContactsforEmailid.
            purpose:Close all tasks when case has closed
            */
            if (!OpptyTriggerhelperClass.sBNumOFContactsforEmailidUpdate()) {
                CaseTriggerHandlerManager.beforeUpdateNumOFContactsforEmailid(Trigger.new, Trigger.oldMap, Trigger.newMap);
                OpptyTriggerhelperClass.setsBNumOFContactsforEmailidUpdate();
            }

            /*  
            Modified from Trigger:GE_MCS_Prepopulate_from_ParentCase
            purpose:Used to populate the Opportunity field on the Child Case from the Parent Case if the Parent Case SubType = 'RFQ Processing'
            */
            if (!OpptyTriggerhelperClass.sbeforeInsertbeforeUpdatePrePopulateParent()) {
                CaseTriggerHandlerManager.beforeInsertbeforeUpdatePrePopulateParent(Trigger.new);
                OpptyTriggerhelperClass.setsbeforeInsertbeforeUpdatePrePopulateParent();
            }

            /*  
            Modified from Trigger:AssignmentGroupFieldUpdation.
            purpose:Included subtype mandatory logic for mcs record type
            Reason for Commenting: Directly Implemented logic in Trigger.
            */
            if (!OpptyTriggerhelperClass.sbeforeUpdateassignmentGroupField()) {
                CaseTriggerHandlerManager.beforeUpdateassignmentGroupField(Trigger.new, Trigger.newMap, trigger.oldMap);
                OpptyTriggerhelperClass.setsbeforeUpdateassignmentGroupField();
            }

            /*  
            Modified from Trigger:GE_MCS_Prepopulate_from_ParentCase.
            purpose:PrePopulataing from ParentCase for RecordType-'MCS-CS'
            */
            // Commented by Atanu Dey - 8/29/14         
            // CaseTriggerHandlerManager.beforeInsertbeforeUpdatePrePopulateParent(Trigger.new); 
        } else if (trigger.isdelete) {}
    }
    if (trigger.isAfter) {
        if (trigger.isInsert) {

            /*
            purpose: Create New Caseteam record when creation NewCase from opportunity: MCS-CS record type    
            */
            //CaseTriggerHandlerManager.afterInsertMCSNewcaseteam(Trigger.new);
            Map < String, Object > params = new Map < String, Object > ();
            List < Case > newcaseList1 = (List < Case > ) Trigger.new;
            params.put('CaseSObjectCollVar', newcaseList1);
            Flow.Interview.MCS_Case_Team_Member_Update caseteam = new Flow.Interview.MCS_Case_Team_Member_Update(params);
            caseteam.start();

            /*
            Modified from Trigger:GEOGMCS_AutoUnfollowBasedOnCaseClosed.
            purpose:deleting ids for 'EntitySubscription' recordtype-'MCS-CS'    
            */
            CaseTriggerHandlerManager.afterInsertafterUpdateAutoUnfollow(Trigger.new);

            /*
            Commented as Account Team members are removed
            Modified from Trigger:GE_MCS_SendEmail_On_Case_Creation.
            purpose:Sending Email alert for Cases raised against critical accounts    
                     
            CaseTriggerHandlerManager.afterInsertafterUpdateMCSSendEmailCaseCreation(Trigger.new,Trigger.newMap,Trigger.oldMap);
            */
            /*
            Modified from Trigger:GE_MCS_TaskUpdate.
            purpose:Close all tasks when case has closed.  
            */
            CaseTriggerHandlerManager.afterInsertMCSTaskUpdate(Trigger.new);
        } else if (trigger.isUpdate) {

            IF(!OpptyTriggerhelperClass.SAUpdatechklststatus()) {
                CaseTriggerHandlerManager.afterUpdateCaseShare(trigger.new, trigger.oldmap);
                /*
                Modified from Trigger:GEOGMCS_AutoUnfollowBasedOnCaseClosed.
                purpose: deleting ids for 'EntitySubscription' recordtype-'MCS-CS'   
                */
                CaseTriggerHandlerManager.afterInsertafterUpdateAutoUnfollow(Trigger.new);

                /*
                Modified from Trigger:GE_MCS_TaskUpdate.
                purpose:Close all tasks when case has closed.  
                */
                CaseTriggerHandlerManager.afterUpdateMCSTaskUpdate(Trigger.new, Trigger.oldMap);

                OpptyTriggerhelperClass.setsSAUpdatechklststatus();
            }
        } else if (trigger.isdelete) {}
    }

}