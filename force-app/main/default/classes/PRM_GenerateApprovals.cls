public class PRM_GenerateApprovals
{
   
    /**Method to generate commerial approvers **/
    @InvocableMethod
    public static void generateCommercialApprovers(List<Id> commLines)
    {
        List<GE_ES_Role__c> prmRoles = new List<GE_ES_Role__c>();
        Set<String> prmRolesSet = new Set<String>();
        Set<String> FinalTierSet = new Set<String>();
        List<PRM_Channel_Appointment_GE_OG__c> chApp = new List<PRM_Channel_Appointment_GE_OG__c>();
        List<PRM_Commercial_Line_GE_OG__c> updateCommines = new List<PRM_Commercial_Line_GE_OG__c>();
        List<GE_PRM_Recommendation_Approvers__c> RecommendationApproversList = new List<GE_PRM_Recommendation_Approvers__c>();
        List<Commercial_Line_Apporver_Relation__c> junctionList = new List<Commercial_Line_Apporver_Relation__c>();
        Set<Id> approvarIds = new Set<Id>();
        Map<Id, Id> userWithDelegatedUser = new Map<Id, Id>();
        List<PRM_Channel_Appointment_Approver__c> caaApproverList = new List<PRM_Channel_Appointment_Approver__c>();
        Set<Id> channelAppId = new Set<Id>();
        Set<Id> approverGenerated = new Set<Id>();
        Set<String> rolesGenerated = new Set<String>();
        //Map<Id,String> commLineFinalTierMap  = Map<Id,String>();
        //Integer count = 0;
        for(PRM_Commercial_Line_GE_OG__c com : [Select Id,PRM_Channel_Appointment__c From PRM_Commercial_Line_GE_OG__c Where Id IN: commLines])
        {
            channelAppId.add(com.PRM_Channel_Appointment__c);
        }
        chApp = [select id,PRM_Country__c,PRM_Region__c,PRM_Risk_Rating__c,PRM_Commercial_Manager__r.Email,PRM_Primary_Sales_Channel_Manager__r.Email,PRM_Account_Name__c,PRM_Account_Name__r.ShippingCountry,PRM_Account_Name__r.GE_HQ_Country_Code__c from PRM_Channel_Appointment_GE_OG__c where id IN :channelAppId];
        
        PRM_Channel_Appointment_Parent_Approval__c caaParent = new PRM_Channel_Appointment_Parent_Approval__c();
        caaParent.PRM_Channel_Appointment__c = chApp[0].Id;
        caaParent.Parent_Status__c = 'Pending';
        caaParent.Status_Date__c = System.Today();
        caaParent.Type__c = 'Commercial';
        insert caaParent;
        
        for(GE_ES_Role__c role : [select Name, GE_PRM_Approver_Type__c from GE_ES_Role__c where GE_PRM_Role__c = true AND GE_PRM_Approver_Type__c ='CommercialApprovers'])
        {
            prmRoles.add(role);
            prmRolesSet.add(role.Name);
        }
        //prmRoles = [select Name, GE_PRM_Approver_Type__c from GE_ES_Role__c where GE_PRM_Role__c = true AND GE_PRM_Approver_Type__c ='CommercialApprovers'];
        //prmRolesSet.addAll(prmRoles);
        
        
        for(PRM_Commercial_Line_GE_OG__c cl : [ Select Id, Name,Commercial_Parent__c, PRM_Tier_1__c,PRM_Tier_2__c,PRM_Tier_3__c,PRM_Tier_4__c,PRM_Tier_5__c From PRM_Commercial_Line_GE_OG__c Where Id IN: commLines ])
        {
            if(cl.PRM_Tier_4__c != null && cl.PRM_Tier_4__c != '')
            {
                FinalTierSet.add(cl.PRM_Tier_1__c+ ' - ' + cl.PRM_Tier_2__c + ' - '  + cl.PRM_Tier_3__c + ' - ' +cl.PRM_Tier_4__c+ ' - ' + 'Commercial 1' + ' - ' +chApp[0].PRM_Country__c+ ' - ' +chApp[0].PRM_Region__c+'%');
                
                FinalTierSet.add(cl.PRM_Tier_1__c+ ' - ' + cl.PRM_Tier_2__c + ' - '  + cl.PRM_Tier_3__c + ' - ' +cl.PRM_Tier_4__c+ ' - ' + 'Commercial 2' + ' - ' +chApp[0].PRM_Country__c+ ' - ' +chApp[0].PRM_Region__c+'%');
                
                
                
            }
            else
            {
                FinalTierSet.add(cl.PRM_Tier_1__c+ ' - ' + cl.PRM_Tier_2__c + ' - '  + cl.PRM_Tier_3__c + ' - ' + 'Commercial 1' + ' - ' +chApp[0].PRM_Country__c+ ' - ' +chApp[0].PRM_Region__c+'%');
                FinalTierSet.add(cl.PRM_Tier_1__c+ ' - ' + cl.PRM_Tier_2__c + ' - '  + cl.PRM_Tier_3__c + ' - ' + 'Commercial 2' + ' - ' +chApp[0].PRM_Country__c+ ' - ' +chApp[0].PRM_Region__c+'%');
            }
           
           cl.Commercial_Parent__c = caaParent.Id;
           cl.PRM_Status__c = 'Commercial Submitted';
            updateCommines.add(cl);
            
        }
        
        update updateCommines;
        
        for(GE_PRM_Recommendation_Approvers__c recApp : [Select Id, GE_PRM_Approver_Name__c,GE_PRM_Approver_Name__r.Name, GE_PRM_Tier_2__c,GE_PRM_Tier_3__c,GE_PRM_Region__c, GE_PRM_Country__c,GE_PRM_Role__c, GE_PRM_P_L__c,GE_PRM_TIER_4__c,GE_PRM_DOA_Stage__c,GE_PRM_Compliance_Validation__c,GE_PRM_FINAL_TIER_SELECTIONS__C from GE_PRM_Recommendation_Approvers__c where GE_PRM_FINAL_TIER_SELECTIONS__C like :FinalTierSet  AND GE_PRM_ISO_Code__c =: chApp[0].PRM_Account_Name__r.GE_HQ_Country_Code__c AND    GE_PRM_Role__c IN : prmRolesSet])
        {
            RecommendationApproversList.add(recApp);
            approvarIds.add(recApp.GE_PRM_Approver_Name__c);
        }
        
        if(!approvarIds.isEmpty())
        {
            for( User u : [select Id, DelegatedApproverID from User where Id IN: approvarIds])
            {
                userWithDelegatedUser.put(u.Id,u.DelegatedApproverID);
            }
        }
        
        for(GE_PRM_Recommendation_Approvers__c recApp : RecommendationApproversList)
        {   
            //approverGenerated.add(recApp.GE_PRM_Approver_Name__c);
           // rolesGenerated.add(String.valueOf(recApp.GE_PRM_Approver_Name__c)+recApp.GE_PRM_Role__c);
           Commercial_Line_Apporver_Relation__c rel = new Commercial_Line_Apporver_Relation__c();
           rel.Approver_Name__c = recApp.GE_PRM_Approver_Name__r.Name;
           rel.Final_Tier__c = recApp.GE_PRM_Tier_2__c + recApp.GE_PRM_Tier_3__c + recApp.GE_PRM_Tier_4__c;
           rel.Role__c = recApp.GE_PRM_Role__c;
           rel.ParentId__c = caaParent.Id;
           junctionList.add(rel);
            if(rolesGenerated.isEmpty() ||!rolesGenerated.contains(String.valueOf(recApp.GE_PRM_Approver_Name__c)+recApp.GE_PRM_Role__c))
            {
                system.debug('here111');
                PRM_Channel_Appointment_Approver__c approver = new PRM_Channel_Appointment_Approver__c();
                approver.Approver__c = recApp.GE_PRM_Approver_Name__c;
                approver.Role__c = recApp.GE_PRM_Role__c;
                approver.Region__c = recApp.GE_PRM_Region__c;
                approver.Country__c = recApp.GE_PRM_Country__c;
                approver.Delegated_User__c = userWithDelegatedUser.get(recApp.GE_PRM_Approver_Name__c);
                approver.Status__c = 'Pending';
                approver.PRM_Channel_Appointment__c = chApp[0].Id;
                approver.PRM_Channel_Appointment_Parent__c = caaParent.Id;
                approver.Tier_2_P_L__c = recApp.GE_PRM_Tier_2__c;
                approver.Tier_3_P_L__c = recApp.GE_PRM_Tier_3__c;
                approver.Tier_4_P_L__c = recApp.GE_PRM_Tier_4__c;
                approver.CM_Email__c = chApp[0].PRM_Commercial_Manager__r.Email;
                approver.SM_Email__c = chApp[0].PRM_Primary_Sales_Channel_Manager__r.Email;
                caaApproverList.add(approver);
                rolesGenerated.add(String.valueOf(recApp.GE_PRM_Approver_Name__c)+recApp.GE_PRM_Role__c);
            }
            
            //approverFinalTierMap.put(recApp);
            
            
        }
        
        system.debug('JN LIST'+junctionList);
        insert junctionList;
        insert caaApproverList;

            
    
    
    
}


}