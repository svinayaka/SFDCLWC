public class PRM_ApproversTriggerHandler
    {
        
        public static void handleApproverBeforeInsert(List<PRM_Channel_Appointment_Approver__c> caaList)
        {   
            for(PRM_Channel_Appointment_Approver__c caa : caaList)
            {
                caa.Status_Date__c = System.Today(); system.debug('here111');
                
                if(caa.Status__c=='Approved' ||caa.Status__c=='Rejected')
                {
                    caa.DOA_Approved_Rejected_Time_Stamp__c = System.now();system.debug('here222');
                }
                   
            }
        }
        
        public static void handleApproverBeforeUpdate(Map<Id,PRM_Channel_Appointment_Approver__c> caaMapOld,Map<Id,PRM_Channel_Appointment_Approver__c> caaMapNew)
        {   
            Set<Id> rejectedParents = new Set<Id>();
            Set<Id> rejectedCAA = new Set<Id>();
            Set<Id> needmoreInfoChApp = new Set<Id>();
            for(PRM_Channel_Appointment_Approver__c caa : caaMapNew.values())
            {
                if(caaMapOld.get(caa.Id).Status__c != caa.Status__c)
                {
                    caa.Status_Date__c = System.Today();
                    if(caaMapOld.get(caa.Id).Status__c == 'Need More Info')
                    {
                        needmoreInfoChApp.add(caa.PRM_Channel_Appointment__c);
                    }
                }
                if(caa.Status__c == 'Rejected')
                {
                    rejectedParents.add(caa.PRM_Channel_Appointment_Parent__c);
                    caa.DOA_Approved_Rejected_Time_Stamp__c = System.now();
                    rejectedCAA.add(caa.Id);
                }
                if(caa.Status__c == 'Approved')
                {
                    //rejectedParents.add(caa.PRM_Channel_Appointment_Parent__c);
                    caa.DOA_Approved_Rejected_Time_Stamp__c = System.now();
                }
                
                 
            }
            
            if(!rejectedParents.isEmpty())
            {
                handleRejectedApprover(rejectedParents,rejectedCAA);
            }
            if(!needmoreInfoChApp.isEmpty())
            {
                handleNeedMoreInfo(needmoreInfoChApp, false);
            }
        }
        
        public static void  handleAfterInsert(Map<Id,PRM_Channel_Appointment_Approver__c> caaMap)
        {
            //Map<String,PRM_Channel_Appointment_Approver__c> tierCaaMap = new Map<String,PRM_Channel_Appointment_Approver__c>();
            List<Id> parentId = new List<Id>();
            List<Commercial_Line_Apporver_Relation__c> relationList = new List<Commercial_Line_Apporver_Relation__c>();
            List<PRM_Commercial_Line_GE_OG__c>commLines = new List<PRM_Commercial_Line_GE_OG__c>();
            List<Commercial_Line_Apporver_Relation__c> junctionList = new List<Commercial_Line_Apporver_Relation__c>();
            Set<String> tierRoleSet = new Set<String>();
            List<Commercial_Line_Apporver_Relation__c> insertRelationList = new List<Commercial_Line_Apporver_Relation__c>();
            List<Commercial_Line_Apporver_Relation__c> updateRelationList = new List<Commercial_Line_Apporver_Relation__c>();
            List<PRM_Channel_Appointment_Approver__c> caaList = new List<PRM_Channel_Appointment_Approver__c>();
            Map<String,PRM_Channel_Appointment_Approver__c> caaRoleMap = new Map<String,PRM_Channel_Appointment_Approver__c>();
            
            for(PRM_Channel_Appointment_Approver__c caa : [Select Id,Name,Approver__r.Name,PRM_Channel_Appointment_Parent__c,PRM_Channel_Appointment_Parent__r.Type__c,Tier_2_P_L__c,Tier_3_P_L__c,Tier_4_P_L__c,Role__c From PRM_Channel_Appointment_Approver__c Where Id IN: caaMap.keyset()])
            {
                caaList.add(caa);
                parentId.add(caa.PRM_Channel_Appointment_Parent__c);
                caaRoleMap.put(caa.Approver__r.Name+caa.Role__c,caa);
                
            }
            for(Commercial_Line_Apporver_Relation__c rel : [Select Id,Approver_Name__c,Final_Tier__c,ParentId__c,PRM_Channel_Appointment_Approver__c,PRM_Commercial_Line__c,Role__c From Commercial_Line_Apporver_Relation__c Where ParentId__c IN :parentId])
            {
                //relationCommLineMap.put(rel.Final_Tier__c,rel);
                //relationApproverMap.put(rel.Approver_Name__c+rel.Role__c,rel);
                //relationMap.put(rel.Id,rel);
                junctionList.add(rel);
            }
            
            if(caaList[0].PRM_Channel_Appointment_Parent__r.Type__c == 'Commercial')
            {
                commLines = [Select Id,Name,PRM_Tier_2__c,PRM_Tier_3__c,PRM_Tier_4__c,Compliance_Parent__c,Commercial_Parent__c From PRM_Commercial_Line_GE_OG__c Where Commercial_Parent__c IN : parentId ]; system.debug('commercial');
            }
             if(caaList[0].PRM_Channel_Appointment_Parent__r.Type__c == 'Compliance')
            {
                commLines = [Select Id,Name,PRM_Tier_2__c,PRM_Tier_3__c,PRM_Tier_4__c,Compliance_Parent__c,Commercial_Parent__c From PRM_Commercial_Line_GE_OG__c Where Compliance_Parent__c IN : parentId ]; system.debug('compliance');
            }
            
            
            //relationList = [];
            system.debug('commines'+commLines);
            for(Commercial_Line_Apporver_Relation__c rel : junctionList)
            {    system.debug('junctionList-->'+rel);
                rel.PRM_Channel_Appointment_Approver__c = caaRoleMap.get(rel.Approver_Name__c+rel.Role__c).Id;
                Set<String> finaltierSet = new Set<String>();
                for(PRM_Commercial_Line_GE_OG__c com :  commLines)
                {   
                    if(rel.Final_Tier__c==com.PRM_Tier_2__c+com.PRM_Tier_3__c+com.PRM_Tier_4__c)
                    {
                        if(finaltierSet.isEmpty()|| !finaltierSet.contains(rel.Final_Tier__c))
                        {   
                            finaltierSet.add(rel.Final_Tier__c);
                            rel.PRM_Commercial_Line__c = com.Id;
                            updateRelationList.add(rel);
                            
                        }
                        else
                        {
                            if(!finaltierSet.isEmpty()|| finaltierSet.contains(rel.Final_Tier__c))
                            {
                                Commercial_Line_Apporver_Relation__c relation = new Commercial_Line_Apporver_Relation__c();
                                relation.Approver_Name__c = rel.Approver_Name__c;
                                relation.Final_Tier__c = rel.Final_Tier__c;
                                relation.ParentId__c = rel.ParentId__c;
                                relation.PRM_Channel_Appointment_Approver__c = rel.PRM_Channel_Appointment_Approver__c;
                                relation.Role__c = rel.Role__c;
                                relation.PRM_Commercial_Line__c = com.Id;
                                insertRelationList.add(relation);
                            }
                        }
                        
                        
                    }
                }
            }
            
            
            
            system.debug('JUNCTION+++>'+insertRelationList);
            system.debug('JUNCTION+++>'+updateRelationList);
            insert insertRelationList;
            update updateRelationList;
            
        }
        
        
        public static void handleAfterUpdate(Map<Id,PRM_Channel_Appointment_Approver__c> caaMap)
        {
            List <Id> approvedApproverParent  = new List<Id>();
            Set<Id> needsMoreInfoChannelApp = new Set<Id>();
            Set<Id> abandonedCAA = new Set<Id>();
            for(PRM_Channel_Appointment_Approver__c app: [Select Id,Status__c,PRM_Channel_Appointment__c,PRM_Channel_Appointment_Parent__c From PRM_Channel_Appointment_Approver__c Where Id IN : caaMap.keySet()])
            {
                if(app.Status__c == 'Approved')
                {
                    approvedApproverParent.add(app.PRM_Channel_Appointment_Parent__c);
                }
                if(app.Status__c == 'Need More Info')
                {
                    needsMoreInfoChannelApp.add(app.PRM_Channel_Appointment__c);
                }
                if(app.Status__c == 'Abandoned')
                {
                    abandonedCAA.add(app.PRM_Channel_Appointment_Parent__c);
                }
                
            }
            
                if(!approvedApproverParent.isEmpty())
                {
                    handleApprovedApprovers(approvedApproverParent);
                }
                
                if(!needsMoreInfoChannelApp.isEmpty())
                {
                    handleNeedMoreInfo(needsMoreInfoChannelApp, true);
                }
                if(!abandonedCAA.isEmpty())
                {
                    handleAbandonedCAA(abandonedCAA);
                }
                
            
        }
        
        public static void handleAbandonedCAA(Set<Id> parentID)
        {   
            Set<Id> abandonedParent = new Set<Id>(parentID);
            List<PRM_Channel_Appointment_Parent_Approval__c> abandonedParentList = new List<PRM_Channel_Appointment_Parent_Approval__c>();
            List<PRM_Channel_Appointment_Approver__c> abandonedCAAList = new List<PRM_Channel_Appointment_Approver__c>();
            
            for(PRM_Channel_Appointment_Approver__c app : [Select Id,Status__c,PRM_Channel_Appointment_Parent__c From PRM_Channel_Appointment_Approver__c Where PRM_Channel_Appointment_Parent__c IN :parentID ])
            {
                if(app.Status__c != 'Abandoned' && abandonedParent.contains(app.PRM_Channel_Appointment_Parent__c))
                {
                    abandonedParent.remove((Id)app.PRM_Channel_Appointment_Parent__c);
                }
                
            }
            
            if(!abandonedParent.isEmpty())
                {
                    for(PRM_Channel_Appointment_Parent_Approval__c par : [Select Id,Parent_Status__c,Status_Date__c FROM PRM_Channel_Appointment_Parent_Approval__c Where Id IN : abandonedParent])
                    {
                        par.Parent_Status__c = 'Abandoned';
                        par.Status_Date__c = System.Today();
                        abandonedParentList.add(par);
                    }
                }
                
                if(!abandonedParentList.isEmpty())
                {
                    update abandonedParentList;
                }
        }
        
        public static void handleNeedMoreInfo(Set<Id> chAppIds, Boolean isTrue)
        {
            List<PRM_Channel_Appointment_GE_OG__c> updateChApp = new List<PRM_Channel_Appointment_GE_OG__c>();
            for(PRM_Channel_Appointment_GE_OG__c ch : [Select Id, is_Needs_More_Info__c From PRM_Channel_Appointment_GE_OG__c Where Id IN : chAppIds])
            {
                ch.is_Needs_More_Info__c  = isTrue;
                updateChApp.add(ch);
            }
            
            if(!updateChApp.isEmpty())
            {
                update updateChApp;
            }
        }
        
        public static void handleApprovedApprovers(List<Id> caaParentList)
        {
            Set<Id> caaParent = new Set<Id>();
            Set<Id> approvedParentIds = new Set<Id>();
            List<PRM_Commercial_Line_GE_OG__c> approvedCommLines = new List<PRM_Commercial_Line_GE_OG__c>();
            List<PRM_Channel_Appointment_Parent_Approval__c> approvedParentList = new List<PRM_Channel_Appointment_Parent_Approval__c>();
            Map<Id,PRM_Channel_Appointment_Parent_Approval__c> autoComplianceUpdateParent = new Map<Id,PRM_Channel_Appointment_Parent_Approval__c>();
            Map<Id,String> chAppRisRatingMap = new Map<Id,String>();
            List<PRM_Channel_Appointment_GE_OG__c> updChApp = new List<PRM_Channel_Appointment_GE_OG__c>();
            approvedParentIds.addAll(caaParentList);
            
            for(PRM_Channel_Appointment_Approver__c app :[Select Id,Status__c,PRM_Channel_Appointment_Parent__c From PRM_Channel_Appointment_Approver__c Where PRM_Channel_Appointment_Parent__c IN :caaParentList])
            {
                if(app.Status__c != 'Approved' && approvedParentIds.contains(app.PRM_Channel_Appointment_Parent__c))
                {
                    approvedParentIds.remove(app.PRM_Channel_Appointment_Parent__c);
                }
            }
            
            for(PRM_Channel_Appointment_Parent_Approval__c par : [Select Id,Parent_Status__c,Type__c,auto_Compliance_Approved__c,PRM_Channel_Appointment__c,Risk_Rating__c,Status_Date__c FROM PRM_Channel_Appointment_Parent_Approval__c Where Id IN : approvedParentIds])
            {
                par.Parent_Status__c = 'Approved';
                par.Status_Date__c = System.Today();
                //approvedParentList.add(par);
                autoComplianceUpdateParent.put(par.Id, par);
                if(par.Type__c == 'Compliance')
                {
                    chAppRisRatingMap.put(par.PRM_Channel_Appointment__c,par.Risk_Rating__c);
                }
                
            }
            
            for(PRM_Commercial_Line_GE_OG__c com : [Select Id,PRM_Status__c,Commercial_Parent__c,Compliance_Parent__c,PRM_Commercial_Line_Type__c,Ammend_Needs_Compliance__c,Partner_Relationship_active_for_Tier_2__c From PRM_Commercial_Line_GE_OG__c Where Commercial_Parent__c IN:autoComplianceUpdateParent.keySet()  OR Compliance_Parent__c IN :autoComplianceUpdateParent.keySet()])
            {  System.debug('End of the world');
                if(approvedParentIds.contains(com.Commercial_Parent__c))
                { System.debug('End of the world1 ');
                    System.debug('Comm Line Type '+com.PRM_Commercial_Line_Type__c);
                    System.debug('needs compliance ? '+com.Ammend_Needs_Compliance__c);
                    System.debug('End of the world1 5') ;
                
                    if((com.PRM_Commercial_Line_Type__c == 'Amend' && !com.Ammend_Needs_Compliance__c) || (com.PRM_Commercial_Line_Type__c == 'NRT' && com.Partner_Relationship_active_for_Tier_2__c == 'Yes'))
                    {
                        com.PRM_Status__c = 'Compliance Approved';System.debug('End of the world1 99') ;
                        //com.isAutoComplianceApproved__c = true;
                        autoComplianceUpdateParent.get(com.Commercial_Parent__c).auto_Compliance_Approved__c = true;
                    }
                    else
                    {
                        com.PRM_Status__c = 'Commercial Approved';
                    }
                    
                }
                
                if(approvedParentIds.contains(com.Compliance_Parent__c))
                {
                    com.PRM_Status__c = 'Compliance Approved';
                }
                
                approvedCommLines.add(com);
            }
            
            for(PRM_Channel_Appointment_GE_OG__c ch : [Select Id,Last_Compliance_Risk_Rating__c From PRM_Channel_Appointment_GE_OG__c Where Id IN : chAppRisRatingMap.keySet()])
            {
                ch.Last_Compliance_Risk_Rating__c = chAppRisRatingMap.get(ch.Id);
                updChApp.add(ch);
                
            }
        update autoComplianceUpdateParent.values();
        update updChApp;
        update approvedCommLines;
        
        
        }
        
        
        public static void handleParentBeforeUpdate(Map<Id,PRM_Channel_Appointment_Parent_Approval__c> parentMap)
        {
            List<PRM_Channel_Appointment_Parent_Approval__c>recalledParent = new List<PRM_Channel_Appointment_Parent_Approval__c>();
            List<PRM_Channel_Appointment_Approver__c> approvers = new List<PRM_Channel_Appointment_Approver__c>();
            List<PRM_Commercial_Line_GE_OG__c> commLines = new List<PRM_Commercial_Line_GE_OG__c>();
            
            for(PRM_Channel_Appointment_Parent_Approval__c par : parentMap.values())
            {
                if(par.Parent_Status__c == 'Recalled')
                {
                    recalledParent.add(par);
                }
            }
            
            for(PRM_Channel_Appointment_Approver__c app : [Select Id,PRM_Channel_Appointment_Parent__c,Status__c From PRM_Channel_Appointment_Approver__c Where PRM_Channel_Appointment_Parent__c IN : recalledParent ])
            {
                app.Status__c = 'Recalled';
                approvers.add(app);
            }
            
            for(PRM_Commercial_Line_GE_OG__c com : [Select Id,Compliance_Parent__c,Commercial_Parent__c,PRM_Status__c From PRM_Commercial_Line_GE_OG__c Where Commercial_Parent__c IN : recalledParent OR Compliance_Parent__c IN : recalledParent])
            {
                if(com.PRM_Status__c == 'Compliance Submitted')
                {
                    com.PRM_Status__c = 'Commercial Approved';
                    commLines.add(com);
                    continue;
                    
                }
                
                if(com.PRM_Status__c == 'Commercial Submitted')
                {
                    com.PRM_Status__c = 'Draft';
                    commLines.add(com);
                    continue;
                }
                if(com.PRM_Status__c == 'Commercial Approved')
                {
                    com.PRM_Status__c = 'Commercial Submitted';
                    commLines.add(com);
                    continue;
                }
                
                if(com.PRM_Status__c == 'Compliance Approved')
                {
                    parentMap.get(com.Compliance_Parent__c).addError('Compliance Approved Commercial Lines cannot be recalled');
                }
                    
                    
                
            }
            
            update approvers;
            update commLines;   
            
        }
        
        public static void handleParentStatusOnUpdate(Map<Id,PRM_Channel_Appointment_Parent_Approval__c> parentMapNew,Map<Id,PRM_Channel_Appointment_Parent_Approval__c> parentMapOld)
        {
            for(PRM_Channel_Appointment_Parent_Approval__c par : parentMapNew.values())
            {
                if(par.Parent_Status__c != parentMapOld.get(par.Id).Parent_Status__c)
                {
                    par.Status_Date__c = System.Today();
                }
            }
        }
        
        public static void handleRejectedApprover(Set<Id> rejectedParentIds,Set<Id> rejectedCAA)
        {   
            List<PRM_Channel_Appointment_Parent_Approval__c> updateParent =  new List<PRM_Channel_Appointment_Parent_Approval__c>();
            List<PRM_Commercial_Line_GE_OG__c> updateCL =  new List<PRM_Commercial_Line_GE_OG__c>();
            List<PRM_Channel_Appointment_Approver__c> updateApprovers =  new List<PRM_Channel_Appointment_Approver__c>();
            
            
            for(PRM_Channel_Appointment_Parent_Approval__c par : [Select Id,Parent_Status__c From PRM_Channel_Appointment_Parent_Approval__c Where Id IN:rejectedParentIds ])
            {
                par.Parent_Status__c = 'Rejected';
                updateParent.add(par);
            }
            
            for(PRM_Commercial_Line_GE_OG__c com : [Select Id,Compliance_Parent__c,Commercial_Parent__c,PRM_Status__c From PRM_Commercial_Line_GE_OG__c Where Commercial_Parent__c IN : rejectedParentIds OR Compliance_Parent__c IN : rejectedParentIds])
            {
                com.PRM_Status__c = 'Rejected';
                updateCL.add(com);  
            }
            for(PRM_Channel_Appointment_Approver__c app :[Select Id,Status__c,PRM_Channel_Appointment_Parent__c From PRM_Channel_Appointment_Approver__c Where PRM_Channel_Appointment_Parent__c IN :rejectedParentIds AND Id NOT IN: rejectedCAA])
            {
                if(app.Status__c == 'Pending' )
                {   
                    app.Status__c = 'Recalled';
                    updateApprovers.add(app);
                }
            }
            
            
            if(!updateParent.isEmpty())
            {
                update updateParent;
            }
            if(!updateCL.isEmpty())
            {
                update updateCL;
            }
            if(!updateApprovers.isEmpty())
            {
                update updateApprovers;
            }
        }
        
        public static void handleJunctionObjectAfterUpdate(List<Commercial_Line_Apporver_Relation__c> relnList)
        {
            Map<Id,Integer> caaComCountMap = new Map<Id,Integer>();
            List<PRM_Channel_Appointment_Approver__c> updateList = new List<PRM_Channel_Appointment_Approver__c>();
            for(Commercial_Line_Apporver_Relation__c rel : [Select Id,PRM_Channel_Appointment_Approver__c From Commercial_Line_Apporver_Relation__c Where Id IN : relnList])
            {
                if(rel.PRM_Channel_Appointment_Approver__c != null)
                {
                    if(caaComCountMap.isEmpty() || !caaComCountMap.containsKey(rel.PRM_Channel_Appointment_Approver__c))
                    {
                        caaComCountMap.put(rel.PRM_Channel_Appointment_Approver__c,1);
                    }
                    else
                    {
                        if(caaComCountMap.containsKey(rel.PRM_Channel_Appointment_Approver__c))
                        {
                            Integer i = caaComCountMap.get(rel.PRM_Channel_Appointment_Approver__c);
                            i = i + 1;
                            caaComCountMap.put(rel.PRM_Channel_Appointment_Approver__c,i);
                        }
                    }
                }
            }
            
            if(!caaComCountMap.isEmpty())
            {
                for(PRM_Channel_Appointment_Approver__c caa : [Select Id, Number_of_Commercial_Lines__c  From PRM_Channel_Appointment_Approver__c Where Id IN: caaComCountMap.keySet()])
                {
                    caa.Number_of_Commercial_Lines__c = caaComCountMap.get(caa.Id);
                    updateList.add(caa);
                }
            }
            
            if(!updateList.isEmpty())
            {
                update updateList;
            }
            
        }
        
        
      
        
    }