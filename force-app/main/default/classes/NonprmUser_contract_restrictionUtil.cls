public with sharing class NonprmUser_contract_restrictionUtil {

public static void  contractaccess(list<contract> contractlist){
//if(checkRecursive.runBeforeOnce()){
          // system.debug('$$$$$$$$$$$$$$$'); 

            system.debug('$$$$$$$$$$$$$$$7777777777'); 
            id userid = Userinfo.getUserId();
            id channeladdendum_ID1 = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Channel Addendum Agreement').getRecordTypeId();
            id channeladdendum_ID2 = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Channel Master Agreement').getRecordTypeId();
            set<id> prm_permset_ID= new set<id> ();
            
            
            list<PRM_User_permission_set__mdt> stored_PRM_permissonsets = [ select Permission_set_id__c from PRM_User_permission_set__mdt];
            //system.debug('0000000000'+ stored_PRM_permissonsets );
            for(PRM_User_permission_set__mdt  ps :stored_PRM_permissonsets)
            {
                prm_permset_ID.add(ps.Permission_set_id__c);  
            }
            
            boolean NRTappointment = false;
            List<PermissionSetAssignment> prm_approver = [Select AssigneeId , PermissionSetId FROM PermissionSetAssignment WHERE AssigneeId=:userid AND PermissionSetId ='0PSA0000000Gmdh'and PermissionSetId NOT IN:prm_permset_ID];
       //     List<Contract> NRTcontracts =[select id , name from contract where GE_PRM_Channel_Appointment_ID__r.GE_PRM_Appointment_Type__c ='NR/T'];
            system.debug('111111111'+prm_permset_ID);
             
            List<PermissionSetAssignment> users_permissionset = [Select AssigneeId , PermissionSetId FROM PermissionSetAssignment WHERE AssigneeId=:userid AND PermissionSetId IN:prm_permset_ID];
            System.debug('*** user_permissionset'+users_permissionset);
            
            for (Contract cntrct : contractlist)
                
            {
                // this if condition is for letting PRM approver to edit channel contract , associted to 'NR/T' type appointment
                system.debug('GE_PRM_Appointment_Type__cccccc'+cntrct.GE_PRM_Channel_Appointment_ID__r.GE_PRM_Appointment_Type__c);
                system.debug('prm approver size....'+prm_approver.size());
                if(prm_approver.size()!=0 && (cntrct.Status == 'Under NR/T' || cntrct.Status == 'Executed') )
                    {
                        NRTappointment = true;
                        system.debug('inside prmapprovers iff condition....');
                    }
                // this else for calculating loic for edit restiction of contracts based on logged in user and metadattype.
                else
                {
                    
                system.debug('gggggggggggg'+cntrct.id);
                    system.debug('NRTappointmentttttttt'+NRTappointment);
                
                         if(((cntrct.RecordTypeId == channeladdendum_ID1 || cntrct.RecordTypeId == channeladdendum_ID2 ) && users_permissionset.size() == 0 && NRTappointment == False) && !Test.isRunningTest())
                              {   
                                 cntrct.addError('You do not have permissions to edit Channel Contracts');
                                 system.debug('inside ifffffff ......%%%%%%%%');
                                 
                                
                    
                                }
                
                         else{system.debug('inside else ......%%%%%%%%');}
                    
          
                 } // end of else of prm approver and NRT contracts check;
            } //end of for loop
   // }
    }

}