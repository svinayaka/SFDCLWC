public class PRM_GenerateCompliance
{
    /**Method to generate compliance approvers **/
    @InvocableMethod
    public static void generateComplianceApprovers(List<Id> commLines)
    {
        List<GE_ES_Role__c> prmRoles = new List<GE_ES_Role__c>();
        Set<String> prmRolesSet = new Set<String>();
        Set<String> FinalTierSet = new Set<String>();
        List<PRM_Channel_Appointment_GE_OG__c> channelApp = new List<PRM_Channel_Appointment_GE_OG__c>();
        List<PRM_Commercial_Line_GE_OG__c> updateCommines = new List<PRM_Commercial_Line_GE_OG__c>();
        List<GE_PRM_Recommendation_Approvers__c> RecommendationApproversList = new List<GE_PRM_Recommendation_Approvers__c>();
        Set<Id> approvarIds = new Set<Id>();
        Map<Id, Id> userWithDelegatedUser = new Map<Id, Id>();
        List<PRM_Channel_Appointment_Approver__c> caaApproverList = new List<PRM_Channel_Appointment_Approver__c>();
        Map<String,String> extingPendingApprovers = new Map<String,String>();
        Set<String> rolesGenerated = new Set<String>();
        Set<String> tier2Set = new Set<String>();
        String currentRiskRating ;
        String lastComplianceRiskRating = '';
        List<Commercial_Line_Apporver_Relation__c> junctionList = new List<Commercial_Line_Apporver_Relation__c>();
        List<PRM_Channel_Appointment_Approver__c> ApprovedCAA  = new List<PRM_Channel_Appointment_Approver__c> ();
        Map<String , PRM_Channel_Appointment_Approver__c> rolesCAA_map  = new  Map<string , PRM_Channel_Appointment_Approver__c> ();
        Set<String> rolesCAASet = new Set<String>();
        Map<String,String> tierValueCLMap = new Map<String,String>();
        List<Commercial_Line_Apporver_Relation__c> relationshipList = new List<Commercial_Line_Apporver_Relation__c>();
        List<PRM_Channel_Appointment_GE_OG__History> ch = new List<PRM_Channel_Appointment_GE_OG__History> ();
        Set<Id> channelAppId = new Set<Id>();
        Boolean hasRiskRatingChanged = false;
        Boolean newTier2Additon = false;
        Boolean isRenewal = false;
        Boolean isNRT = false;
        Boolean isAmmend = false;
        Boolean isSalesRep = false;
        
        for(PRM_Commercial_Line_GE_OG__c com : [Select Id,PRM_Channel_Appointment__c,PRM_Commercial_Line_Type__c From PRM_Commercial_Line_GE_OG__c Where Id IN: commLines])
        {
            channelAppId.add(com.PRM_Channel_Appointment__c);
            if(com.PRM_Commercial_Line_Type__c == 'Renewal')
            {
                isRenewal = true;
            }
            if(com.PRM_Commercial_Line_Type__c == 'NRT')
            {
                isNRT = true;
            }
            if(com.PRM_Commercial_Line_Type__c == 'Amend')
            {
                isAmmend = true;
            }
            
        }
         channelApp = [select id,PRM_Country__c,PRM_CL_Sales_Rep_Count__c,PRM_Region__c,Sales_Rep_Compliance_Approved_Count__c,PRM_Risk_Rating__c,PRM_Account_Name__c,PRM_Account_Name__r.ShippingCountry,PRM_Account_Name__r.GE_HQ_Country_Code__c,LastModifiedBy.Name, LastModifiedDate,Last_Compliance_Risk_Rating__c from PRM_Channel_Appointment_GE_OG__c where id IN :channelAppId];
        
        /* ch =[SELECT ParentId, OldValue, NewValue, Field,CreatedBy.Name, CreatedDate FROM PRM_Channel_Appointment_GE_OG__History where parentId =: channelApp[0].Id and Field = 'PRM_Risk_Rating__c' Order by CreatedDate Desc]; */
        
        currentRiskRating = channelApp[0].PRM_Risk_Rating__c;
        if(!String.isBlank(channelApp[0].Last_Compliance_Risk_Rating__c))
        {
            lastComplianceRiskRating = channelApp[0].Last_Compliance_Risk_Rating__c;
        }
        
        
        if(!currentRiskRating.equalsIgnoreCase(lastComplianceRiskRating) )
        {
            hasRiskRatingChanged = true; //compare with newly created field "Last compliance approved" before setting this flag
        }
        for(PRM_Commercial_Line_GE_OG__c com :[Select Id,Name,PRM_Tier_2__c From PRM_Commercial_Line_GE_OG__c Where PRM_Channel_Appointment__c =:channelApp[0].Id AND ID NOT IN : commLines AND (PRM_Status__c != 'Draft' AND PRM_Status__c != 'Commercial Submitted' AND PRM_Status__c != 'Commercial Approved')])
        {
            system.debug('comm line '+com.Name+'--->'+com.PRM_Tier_2__c);
            tier2Set.add(com.PRM_Tier_2__c);
        }
        system.debug('TIER2--->'+tier2Set);
        PRM_Channel_Appointment_Parent_Approval__c caaParent = new PRM_Channel_Appointment_Parent_Approval__c();
        caaParent.PRM_Channel_Appointment__c = channelApp[0].Id;
        caaParent.Parent_Status__c = 'Pending';
        caaParent.Status_Date__c = System.Today();
        caaParent.Type__c = 'Compliance';
        caaParent.Risk_Rating__c = currentRiskRating;
        insert caaParent;
        for(PRM_Commercial_Line_GE_OG__c com : [Select Id,PRM_Relationship_Type__c,PRM_Compliance_CAA_Parent_ID__c,PRM_Status__c,PRM_Tier_1__c,PRM_Tier_2__c,PRM_Tier_3__c,PRM_Tier_4__c,PRM_Sales_Manager__r.Email From PRM_Commercial_Line_GE_OG__c where Id IN :commLines])
        {   
            if(com.PRM_Relationship_Type__c == 'Sales Representative'&& channelApp[0].Sales_Rep_Compliance_Approved_Count__c == 0)
            {
                isSalesRep = true;
            }
            if(!tier2Set.contains(com.PRM_Tier_2__c))
            {
                newTier2Additon = true;
            }
            
            system.debug('TIER2NEW--->'+newTier2Additon );
            String tier = com.PRM_Tier_2__c + com.PRM_Tier_3__c + com.PRM_Tier_4__c;
            tierValueCLMap.put(tier, com.PRM_Sales_Manager__r.Email);
            com.Compliance_Parent__c = caaParent.Id;
            com.PRM_Status__c = 'Compliance Submitted';
            
           /** Commercial_Line_Apporver_Relation__c rel = new Commercial_Line_Apporver_Relation__c();
            rel.PRM_Commercial_Line__c = com.Id;
            rel.Final_Tier__c = tier;
            relationshipList.add(rel); **/
            
            updateCommines.add(com);
            
            
        }
        
        update updateCommines;
        
        
        for(PRM_Channel_Appointment_Approver__c caa : [select Approver__c,Role__c,Status__c,PRM_Channel_Appointment__c, PRM_Channel_Appointment__r.PRM_Risk_Rating__c from PRM_Channel_Appointment_Approver__c where PRM_Channel_Appointment__c =:channelApp[0].Id and Status__c = 'Approved'and Role__c!='Commercial 1'and Role__c!='Commercial 2'])
        {
            ApprovedCAA.add(caa);
            //rolesCAA_map.put(caa.Role__c , caa);
            rolesCAASet.add(caa.Role__c);
        }
        for(GE_ES_Role__c role : [select Name, GE_PRM_Approver_Type__c from GE_ES_Role__c where GE_PRM_Role__c = true AND GE_PRM_Approver_Type__c =: currentRiskRating])
        {
            prmRoles.add(role);
            //prmRolesSet.add(role.Name);
            if(ApprovedCAA.isEmpty())
            {
                prmRolesSet.add(role.Name);
            }
            else
            {
                if(currentRiskRating == 'Low' || isRenewal)
                {
                    prmRolesSet.add(role.Name);
                }
                else if(currentRiskRating == 'Medium')
                {
                    if((rolesCAASet.contains('Regional Legal Approver') && !hasRiskRatingChanged && !isSalesRep && !newTier2Additon && !isRenewal))
                    {
                        if(role.Name != 'Regional Legal Approver')
                        {
                            prmRolesSet.add(role.Name);
                        }
                    }
                    else
                    {
                        prmRolesSet.add(role.Name);
                    }
                }
                
                else
                {
                    if((rolesCAASet.contains('Legal Counsel') || rolesCAASet.contains('CFO')|| rolesCAASet.contains('Compliance Leader') || rolesCAASet.contains('Global Channel Sales')) && !hasRiskRatingChanged && !isSalesRep && !newTier2Additon && !isRenewal)
                    {
                        if(role.Name == 'Global Channel Sales')
                        {
                            prmRolesSet.add(role.Name);
                        }
                    }
                    else
                    {
                        prmRolesSet.add(role.Name);
                    }
                }
            }
            
            
        }
        system.debug('--->PRM ROLE '+prmRolesSet);
        
        for(PRM_Commercial_Line_GE_OG__c cl : [ Select Id, Name,Commercial_Parent__c,PRM_Commercial_Line_Type__c, PRM_Tier_1__c,PRM_Tier_2__c,PRM_Tier_3__c,PRM_Tier_4__c,PRM_Tier_5__c From PRM_Commercial_Line_GE_OG__c Where Id IN: commLines] )
        {
            if(cl.PRM_Commercial_Line_Type__c != 'NRT')
            {
                for(String role : prmRolesSet)
                {
                    if(cl.PRM_Tier_4__c!=null && cl.PRM_Tier_4__c!='')
                    {
                        FinalTierSet.add(cl.PRM_Tier_1__c+ ' - ' + cl.PRM_Tier_2__c + ' - '  + cl.PRM_Tier_3__c + ' - ' +cl.PRM_Tier_4__c+ ' - ' + role + ' - ' +channelApp[0].PRM_Country__c+ ' - ' +channelApp[0].PRM_Region__c+'%'); 
                    }
                    else
                    {
                        FinalTierSet.add(cl.PRM_Tier_1__c+ ' - ' + cl.PRM_Tier_2__c + ' - '  + cl.PRM_Tier_3__c + ' - ' + role + ' - ' +channelApp[0].PRM_Country__c+ ' - ' +channelApp[0].PRM_Region__c+'%');
                    }
                }
            }
            else
            {   if(cl.PRM_Tier_4__c!=null && cl.PRM_Tier_4__c!='')
                {
                    FinalTierSet.add(cl.PRM_Tier_1__c+ ' - ' + cl.PRM_Tier_2__c + ' - '  + cl.PRM_Tier_3__c + ' - ' + cl.PRM_Tier_4__c+ ' - '+ 'Regional Legal Approver' + ' - ' +channelApp[0].PRM_Country__c+ ' - ' +channelApp[0].PRM_Region__c+'%');
                }
                else
                {
                    FinalTierSet.add(cl.PRM_Tier_1__c+ ' - ' + cl.PRM_Tier_2__c + ' - '  + cl.PRM_Tier_3__c + ' - '+ 'Regional Legal Approver' + ' - ' +channelApp[0].PRM_Country__c+ ' - ' +channelApp[0].PRM_Region__c+'%');
                }
                
                
                prmRolesSet.clear();
                prmRolesSet.add('Regional Legal Approver');
                
            }
            
        }
        system.debug('FINAL TIER SET'+FinalTierSet);
        system.debug('ROle'+prmRolesSet);
    system.debug('HQ'+channelApp[0].PRM_Account_Name__r.GE_HQ_Country_Code__c);
        for(GE_PRM_Recommendation_Approvers__c recApp : [Select Id, GE_PRM_Approver_Name__c,GE_PRM_Approver_Name__r.Name, GE_PRM_Tier_2__c,GE_PRM_Tier_3__c,GE_PRM_Region__c, GE_PRM_Country__c,GE_PRM_Role__c, GE_PRM_P_L__c,GE_PRM_TIER_4__c,GE_PRM_DOA_Stage__c,GE_PRM_Compliance_Validation__c,GE_PRM_FINAL_TIER_SELECTIONS__C from GE_PRM_Recommendation_Approvers__c where GE_PRM_FINAL_TIER_SELECTIONS__C like :FinalTierSet  AND GE_PRM_ISO_Code__c =: channelApp[0].PRM_Account_Name__r.GE_HQ_Country_Code__c AND    GE_PRM_Role__c IN : prmRolesSet])
        {
            RecommendationApproversList.add(recApp);
            approvarIds.add(recApp.GE_PRM_Approver_Name__c);
        }
        system.debug('Recomendatino'+RecommendationApproversList);

        if(!approvarIds.isEmpty())
        {
            for( User u : [select Id, DelegatedApproverID from User where Id IN: approvarIds])
            {
                userWithDelegatedUser.put(u.Id,u.DelegatedApproverID);
            }
        }
        
        for(PRM_Channel_Appointment_Approver__c extAppr : [SELECT Role__c,Approver__c,Tier_2_P_L__c,Tier_3_P_L__c,PRM_Channel_Appointment__c,Status__c FROM PRM_Channel_Appointment_Approver__c WHERE PRM_Channel_Appointment__c =:channelApp[0].Id AND Status__c ='Pending' ])
        {
            extingPendingApprovers.put(extAppr.Approver__c+extAppr.Role__c,extAppr.Role__c);
        }
        system.debug('Existing'+extingPendingApprovers);
        for(GE_PRM_Recommendation_Approvers__c recApp : RecommendationApproversList)
        {       
               Commercial_Line_Apporver_Relation__c rel = new Commercial_Line_Apporver_Relation__c();
               rel.Approver_Name__c = recApp.GE_PRM_Approver_Name__r.Name;
               rel.Final_Tier__c = recApp.GE_PRM_Tier_2__c + recApp.GE_PRM_Tier_3__c + recApp.GE_PRM_Tier_4__c;
               rel.Role__c = recApp.GE_PRM_Role__c;
               rel.ParentId__c = caaParent.Id;
               junctionList.add(rel);
               
            if(!extingPendingApprovers.containsKey(String.valueOf(recApp.GE_PRM_Approver_Name__c)+recApp.GE_PRM_Role__c) && ( rolesGenerated.isEmpty() ||!rolesGenerated.contains(String.valueOf(recApp.GE_PRM_Approver_Name__c)+recApp.GE_PRM_Role__c)))
            {
                PRM_Channel_Appointment_Approver__c approver = new PRM_Channel_Appointment_Approver__c();
                approver.Approver__c = recApp.GE_PRM_Approver_Name__c;
                approver.Role__c = recApp.GE_PRM_Role__c;
                approver.Region__c = recApp.GE_PRM_Region__c;
                approver.Country__c = recApp.GE_PRM_Country__c;
                approver.Delegated_User__c = userWithDelegatedUser.get(recApp.GE_PRM_Approver_Name__c);
                approver.Status__c = 'Pending';
                approver.PRM_Channel_Appointment__c = channelApp[0].Id;
                approver.PRM_Channel_Appointment_Parent__c = caaParent.Id;
                approver.Tier_2_P_L__c = recApp.GE_PRM_Tier_2__c;
                approver.Tier_3_P_L__c = recApp.GE_PRM_Tier_3__c;
                approver.Tier_4_P_L__c = recApp.GE_PRM_Tier_4__c;
                approver.Sales_Mgr_Commline__c = tierValueCLMap.get(recApp.GE_PRM_Tier_2__c+recApp.GE_PRM_Tier_3__c+recApp.GE_PRM_Tier_4__c);
                caaApproverList.add(approver);
                rolesGenerated.add(String.valueOf(recApp.GE_PRM_Approver_Name__c)+recApp.GE_PRM_Role__c);
                
                
            }
            
            //approverFinalTierMap.put(recApp);
        }
        insert junctionList;
        insert caaApproverList;
        
        
        
        
        
    }
}