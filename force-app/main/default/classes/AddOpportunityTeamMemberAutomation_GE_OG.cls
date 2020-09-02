/*
Class/Trigger Name     : AddOpportunityTeamMemberAutomation_GE_OG
Used Where ?           : OpportunityTrigger_GE_OG
Purpose/Overview       : Add OpportunityTeamMember when Commercial Primary Resource updated
Scrum Team             : Transformation - OPPTY MGMT
Requirement Number     : R-23656
Author                 : Mohit Maheshwari
Created Date           : 21/OCT/2015
Test Class Name        : OpportunityDealTeamProcess_GE_OG_Test
Code Coverage          : 80
Changes                :                   
*/
public without sharing class AddOpportunityTeamMemberAutomation_GE_OG{
    public static boolean isFromCode = true;
    
    public void addCommercialUserToOpportunityTeam(List<Opportunity> newlstOpp, Map<ID,Opportunity> oldOppMap){
        System.debug('-------Entrering into AOTM.addCommercialUserToOpportunityTeam --->');
        ID RecordTypeID = schema.sObjectType.Opportunity.getRecordTypeInfosByName().get('O&G').getRecordTypeID();
        List<OpportunityTeamMember> lstOppTeamMember = new List<OpportunityTeamMember>();
        Set<ID> oppIDs = new Set<ID>();
        
    }

    public void updateOpportunityAccessLevel(Set<ID> oppIDs){
        System.debug('-------Entrering into AOTM.updateOpportunityAccessLevel --->');
        if(oppIDs.size()>0){
            List<OpportunityShare> lstshareOpportunity = [select Id, OpportunityAccessLevel, RowCause from OpportunityShare where OpportunityId in : oppIDs and RowCause = 'Team'];
            List<OpportunityShare> lstUpdateOpportunityShare = new List<OpportunityShare>();
            // set all team members access to read/write
            
            for (OpportunityShare oppShare : lstshareOpportunity){
               // if(oppShare.OpportunityAccessLevel!='Read/Write'){
                    oppShare.OpportunityAccessLevel = Label.OpportunityTeamMember_Access;
                    lstUpdateOpportunityShare.add(oppShare);
               // }    
            }
            if(lstUpdateOpportunityShare.size()>0 && !Test.isRunningTest())  
                update lstUpdateOpportunityShare;     
        }
    }  
    //added by Harsha C for R-33024   
    public static void addCPR(List<Opportunity> newlstOpp){
       System.debug('line 43  >>>> '); 
        List<OpportunityTeamMember> insotmLst =new List<OpportunityTeamMember>();
        List<OpportunityTeamMember> delotmLst =new List<OpportunityTeamMember>();
        List<OpportunityTeamMember> otmlist= [SELECT Id, OpportunityId, UserId, Name, PhotoUrl,  
                                              TeamMemberRole, OpportunityAccessLevel, CurrencyIsoCode, CreatedDate, 
                                              CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp, IsDeleted,
                                              opportunity_team_member_id_ge_og__c, bhi_ecrm_opportunityTeamMember_id__c,
                                              QB_ge_og__c, User_18_digit__c FROM OpportunityTeamMember where OpportunityId IN:newlstOpp];
        
        System.debug(' newlstOpp  >> '+newlstOpp);
        System.debug(' otmlist  >>> '+otmlist);
            
        
        if(otmlist.size()>0){
           for(OpportunityTeamMember ota : otmlist){
            if(ota.TeamMemberRole == 'Commercial Primary Resource'){
                OpportunityTeamMember otm = ota;
                delotmLst.add(otm);
            }
               if(ota.TeamMemberRole == 'Sales - Primary'){
                isFromCode =  false;   
               }
        } 
        }
        
        for(Opportunity ot :newlstOpp){
            System.debug('ot 66  >>> '+ot);
           String optyRecordtype = Schema.SObjectType.Opportunity.getRecordTypeInfosById().get(ot.RecordTypeId).getName();
            if(ot.Commercial_Primary_Resource_ge_og__c != null && optyRecordtype=='O&G Closed'){
            OpportunityTeamMember otm =new OpportunityTeamMember();
            otm.OpportunityId = ot.Id;
            otm.UserId = ot.Commercial_Primary_Resource_ge_og__c;
            otm.TeamMemberRole = 'Commercial Primary Resource';
            insotmLst.add(otm);    
            }else if(ot.Commercial_Primary_Resource_ge_og__c != null && optyRecordtype!='O&G Closed'){
               OpportunityTeamMember otm =new OpportunityTeamMember();
            otm.OpportunityId = ot.Id;
            otm.UserId = ot.Commercial_Primary_Resource_ge_og__c;
            otm.TeamMemberRole = 'Commercial Primary Resource';
            insotmLst.add(otm); 
            }
                if(ot.Commercial_Primary_Resource_ge_og__c == null && optyRecordtype=='O&G Closed'){
               ot.addError('Commercial Primary Resource cannot be blank for this Opportunity'); 
            }
                    
        }
        if(delotmLst.size() >0){
           delete delotmLst;
         
        }
        if(insotmLst.size() > 0 ){
         insert insotmLst;
           
        }
        
    }
    //added by vipin
    //Added method to delete CPR to an opprotunity and uncheck CPR checkbox
     //R-23804
    public void deleteCommercialManagerCheck(List<OpportunityTeamMember> oldOTMList, Set<ID> oppIDs){
    
        /***** Create a set of Profile IDs to make change in Deal Team  *****/
        Set<String> setprofileadmindev = new Set<String>();
        System.debug('------------Entering AOTM.deleteCommercialManagerCheck method-->>');
        /***** List of Profile IDs from Custom Setting  *****/
        List<profile_permission_ge_og__c> lstprofileadmindev = profile_permission_ge_og__c.getAll().values();
        for(profile_permission_ge_og__c profileadmindev : lstprofileadmindev){
            setprofileadmindev.add(profileadmindev.profile_id_ge_og__c);
        }
    
        List<Opportunity> opplist= [select id, has_commercial_primary_resource_ge_og__c from opportunity where id in: oppIDs];
        Map<id, Opportunity> opptymap = new Map<id, Opportunity>();
        List<Opportunity> updateopplist= new List<Opportunity>();
        for(Opportunity opp: opplist){
            opptymap.put(opp.id,opp);
        }
        for(OpportunityTeamMember OTM: oldOTMList){
            if(OTM.TeamMemberRole == 'Commercial Primary Resource' && OTM.UserID != null){
                opportunity op = new opportunity();
                op = opptymap.get(otm.opportunityId);
                op.has_commercial_primary_resource_ge_og__c = false;
                //Add COde for R-24539
                op.commercial_primary_resource_name_ge_og__c ='';
                updateopplist.add(op);
            }  
            else if(OTM.TeamMemberRole == Label.Sales_Primary && isFromCode && Util_GE_OG.isFromOppTriggerInsert == false && setprofileadmindev.size()>0 && !setprofileadmindev.contains(UserInfo.getprofileid()) && OTM.User.isActive){
                System.debug('----Getting error while deleting!! '+OTM.Team_member_name_ge_og__c);
                OTM.addError(System.Label.Opportunity_Primary_Sales_Error_Msg);
                
            }
            
        }
        if(updateopplist.size()>0 && !Test.isRunningTest())
            update updateopplist;
                        
    }
     //added by vipin
    //Added method to add CPR to an opprotunity and to check CPR checkbox
     //R-23804
    Public void insertCommercialManagercheck(List<OpportunityTeamMember> newOTMList, Set<ID> oppIDs,map<id,OpportunityTeamMember> oldOTMMap){
        System.debug('-------Entrering into AOTM.insertCommercialManagercheck --->');
        List<Opportunity> opplist= [select id, has_commercial_primary_resource_ge_og__c from opportunity where id in: oppIDs];
        Map<id, Opportunity> opptymap = new Map<id, Opportunity>();
        List<Opportunity> updateopplist= new List<Opportunity>();
        Set<ID> newoppIDs = new Set<ID>();
            for(Opportunity opp: opplist){
                opptymap.put(opp.id,opp);
            }
            System.debug('\n\n newOTMList '+newOTMList.size()+' ---- Records -----'+newOTMList);
            System.debug('\n\n opptyMap '+opptymap.size()+' ---- Records -----'+opptymap);

            for(OpportunityTeamMember OTM: newOTMList){
                
               //Update existing CPR to other Role                                 OpportunityTeamMember_Role=Commercial Primary Resource  
                if(oldOTMMap!= null && oldOTMmap.get(OTM.id).TeamMemberRole==System.Label.OpportunityTeamMember_Role && OTM.TeamMemberRole != oldOTMMap.get(OTM.id).TeamMemberRole){
                    opportunity op = new opportunity();
                    op = opptymap.get(otm.opportunityId);
                    op.has_commercial_primary_resource_ge_og__c = false;
                    op.commercial_primary_resource_name_ge_og__c = '';
                    updateopplist.add(op);
                }
              //Setting CPR name and flag if blank
                else if(OTM.TeamMemberRole == System.Label.OpportunityTeamMember_Role && OTM.UserID != null && opptymap.get(OTM.opportunityId).has_commercial_primary_resource_ge_og__c == false){
                    opportunity op = new opportunity();
                    op = opptymap.get(otm.opportunityId);
                    op.has_commercial_primary_resource_ge_og__c = true;
                    //Added below for Bug 0000024009
                    if(OTM.TeamMemberRole == 'Commercial Primary Resource'){
                        op.commercial_primary_resource_name_ge_og__c = OTM.Team_member_name_ge_og__c;
                    }
                    else{
                        op.addError('You can have only one Commercial Primary Resource in a deal team');
                    }
                    
                    //End Added below for Bug 0000024009
                    system.debug('================OpptyCPRNameInsert=================' +op.commercial_primary_resource_name_ge_og__c);
                    updateopplist.add(op);
                    
                }
                //Check for CPR duplicate addition
                else if(OTM.TeamMemberRole == System.Label.OpportunityTeamMember_Role && 
                        opptymap.get(OTM.opportunityId).has_commercial_primary_resource_ge_og__c == true && trigger.isInsert){
                           OTM.adderror('Commercial Primary Resource is already added for this opportunity');
                       }
                else if(OTM.TeamMemberRole == System.Label.OpportunityTeamMember_Role && oldOTMmap.get(OTM.Id).TeamMemberRole != System.Label.OpportunityTeamMember_Role 
                        && opptymap.get(OTM.opportunityId).has_commercial_primary_resource_ge_og__c == true && trigger.isUpdate){
                           OTM.adderror('Commercial Primary Resource is already added for this opportunity');
                       }
                 
            }
            
            Map<ID,Opportunity> newOppUpdate = new Map<ID,Opportunity>();
            for(Opportunity objOpp : updateopplist){
                System.debug('Into this----------------------------' +newOppUpdate.keySet());
                if(!newoppIDs.contains(objOpp.ID)){
                    newOppUpdate.put(objOpp.ID, objOpp);
                }
                else if(newoppIDs.contains(objOpp.ID)){
                    newOppUpdate.remove(objOpp.ID);
                    opportunity op = new opportunity();
                    op = opptymap.get(objOpp.ID);
                    system.debug('================OpptyId=================' +op);
                    system.debug('================OpptyCPRName=================' +op.commercial_primary_resource_name_ge_og__c);
                    op.has_commercial_primary_resource_ge_og__c = true;
                    newOppUpdate.put(objOpp.ID, op);
                }
                newoppIDs.add(objOpp.ID);
            }
            if(newOppUpdate.size()>0 && !Test.isRunningTest()){
                update newOppUpdate.values();
            }
        }
    
    //Added by Madhuri - R-24033 : Automatically add the opportunity owner to the Deal Team as the "Primary Sales" role
    public void addOppOwnerToOpportunityTeam(List<Opportunity> newlstOpp, Map<ID,Opportunity> oldOppMap){
        System.debug('-------Entrering into AOTM.addOppOwnerToOpportunityTeam --->');
        ID recordTypeIdOG = schema.sObjectType.Opportunity.getRecordTypeInfosByName().get('O&G').getRecordTypeID();
        //Adding Group Flow Oppty for assigning default role as Sales Primary to owner
        ID recordTypeIdOGGF = schema.sObjectType.Opportunity.getRecordTypeInfosByName().get('Grouped Flow').getRecordTypeID();
        ID recordTypeIdOGClosed = schema.sObjectType.Opportunity.getRecordTypeInfosByName().get('O&G Closed').getRecordTypeID();
        
        List<OpportunityTeamMember> lstOppTeamMemberToInsert;
        Map<ID,Opportunity> newOppsMap = new  Map<ID,Opportunity>();
        Map<ID,Opportunity> existingOppsMap = new  Map<ID,Opportunity>();
         
        for(Opportunity objOpportunity : newlstOpp){
            
             //Adding Group Flow Oppty RecordType:recordTypeIdOGGF for assigning default role as Sales Primary to owner
            if((objOpportunity.RecordTypeID == recordTypeIdOG || objOpportunity.RecordTypeID == recordTypeIdOGGF) && oldOppMap == null){
                newOppsMap.put(objOpportunity.Id,objOpportunity);
            
             //Adding Group Flow Oppty RecordType:recordTypeIdOGGF for assigning default role as Sales Primary to owner on updating owner  
            }else if((objOpportunity.RecordTypeID == recordTypeIdOG || objOpportunity.RecordTypeID == recordTypeIdOGClosed || objOpportunity.RecordTypeID == recordTypeIdOGGF) && oldOppMap != null && oldOppMap.get(objOpportunity.Id).OwnerId != objOpportunity.OwnerId){
                system.debug('\n\n=== In update opp ownere \n\n');
                existingOppsMap.put(objOpportunity.Id,objOpportunity);
            }
        }
        
        lstOppTeamMemberToInsert = new List<OpportunityTeamMember>();
        if(newOppsMap != null && newOppsMap.size() > 0){
            
            for(Opportunity opp:newOppsMap.values()){
                OpportunityTeamMember objOppTeamMem = new OpportunityTeamMember();
                objOppTeamMem.OpportunityID = opp.Id;
                objOppTeamMem.UserID = opp.OwnerId;
                objOppTeamMem.TeamMemberRole = Label.Sales_Primary;
                lstOppTeamMemberToInsert.add(objOppTeamMem);
                system.debug('\n\n=== In Insert opp ownere 1 \n\n' + objOppTeamMem);
            }
        }
        
        if(lstOppTeamMemberToInsert.size() > 0){
            system.debug('\n\n=== In Insert sales - primary  \n\n' + lstOppTeamMemberToInsert);
            insert lstOppTeamMemberToInsert;
            Util_GE_OG.isFromOppTriggerInsert = true ;
        }
        
        lstOppTeamMemberToInsert = new List<OpportunityTeamMember>();
        if(existingOppsMap != null && existingOppsMap.size() > 0){
            
            //Fetch OpportunityTeamMember of the changed opportunities
            List<OpportunityTeamMember> existingOppTeamMember = [Select Id,OpportunityID,UserID,Team_member_name_ge_og__c,TeamMemberRole,user.IsActive from OpportunityTeamMember where OpportunityID IN:existingOppsMap.keyset()];
            //To remove inactive Prm Sales on changing owner
            // Added for Bug-0000024133
            List<OpportunityTeamMember> existingOppTeamMemberToDelete = new List<OpportunityTeamMember>();
            //End added for Bug-0000024133
            List<OpportunityTeamMember> existingOppTeamMemberRoleToUpdate = new List<OpportunityTeamMember>();
            
            //Check if the owner is already present in the Opportunity Team
            for(OpportunityTeamMember otm:existingOppTeamMember){
                system.debug('otm.User.isActive' +otm.User.isActive);
                if(oldOppMap.get(otm.OpportunityID).OwnerId == otm.UserID && otm.TeamMemberRole == Label.Sales_Primary && otm.User.isActive){
                    system.debug('\n\n=== In Update, adding previous sales primary as sales  \n\n' + otm);
                     /******** Added by Madhuri : R-R-24725 : Opportunity Owner - Sales Primary *********/
                    otm.TeamMemberRole = Label.Default_Team_Role_Sales ;
                    existingOppTeamMemberRoleToUpdate.add(otm);
                    //Added for Bug-0000024133
                }
                else if(otm.User.isActive==false && otm.TeamMemberRole == Label.Sales_Primary){
                    system.debug('\n\n=== In delete,  previous inactive sales primary from deal team  \n\n' + otm);
                    otm.TeamMemberRole = Label.Default_Team_Role_Sales ;
                    System.debug('----1------------>> Adding inactive OTM to be removed Sales-Primary to delete list:'+otm.Team_member_name_ge_og__c);
                     existingOppTeamMemberToDelete.add(otm);
                } 
                //End added for Bug-0000024133
            }
            
            /******** Added by Madhuri : R-R-24725 : Opportunity Owner - Sales Primary *********/
            //Check if the owner is already present in the Opportunity Team
            if(existingOppTeamMemberRoleToUpdate.size() > 0 && !Test.isRunningTest()){
                Util_GE_OG.isFromOppTriggerInsert = true;
                system.debug('\n\n=== In Update - Sales Primary TO SALES \n\n' + existingOppTeamMemberRoleToUpdate);
                update existingOppTeamMemberRoleToUpdate;
            }
             
            //Delete existing inactive Opportunity Owner on change
            //Added for Bug-0000024133
            if(existingOppTeamMemberToDelete.size() > 0 && !Test.isRunningTest()){
                //Util_GE_OG.isFromOppTriggerInsert = true;
                system.debug('------2-----Going to Delete - inactive primary  \n\n' + existingOppTeamMemberToDelete.get(0).Team_member_name_ge_og__c);
                delete existingOppTeamMemberToDelete;
            } 
            // End added for Bug-0000024133
            
            //Add Opportunity Owner into the Opportunity Team List
            for(Opportunity opp:existingOppsMap.values()){
                OpportunityTeamMember objOppTeamMem = new OpportunityTeamMember();
                objOppTeamMem.OpportunityID = opp.Id;
                objOppTeamMem.UserID = opp.OwnerId;
                objOppTeamMem.TeamMemberRole = Label.Sales_Primary;
                lstOppTeamMemberToInsert.add(objOppTeamMem);
            }
            
            //Insert the OpportunityTeamMember
            if(lstOppTeamMemberToInsert.size() > 0){
                system.debug('\n\n=== In Insert - primary  \n\n' + lstOppTeamMemberToInsert);
                insert lstOppTeamMemberToInsert;
                Util_GE_OG.isFromOppTriggerInsert = true;
            }
           
        }
        
    }
    
    //Added by Madhuri - R-24033 : If the opportunity owner is already into the Deal Team then throw an error
    public void checkOppOwnerInsertUpdate(List<OpportunityTeamMember> newOTMList, Set<ID> oppIDs,map<id,OpportunityTeamMember> oldOTMMap){
       System.debug('-------Entrering into AOTM.addOppOwnerToOpportunityTeam --->');
       /***** Create a set of Profile IDs to make change in Deal Team  *****/
        Set<String> setprofileadmindev = new Set<String>();
        
       /***** List of Profile IDs from Custom Setting  *****/
       List<profile_permission_ge_og__c> lstprofileadmindev = profile_permission_ge_og__c.getAll().values();
       for(profile_permission_ge_og__c profileadmindev : lstprofileadmindev){
           setprofileadmindev.add(profileadmindev.profile_id_ge_og__c);
       }
       
       /***** Set of OTM IDs  *****/
       Set<ID>  teamIDs = new Set<ID>();
       if(oldOTMMap!=null)
       {
           for(OpportunityTeamMember otm : newOTMList){
               teamIDs.add(otm.ID);
           }
       }
       
       system.debug('\n\n==== teamIDs === '+teamIDs+'\n\n');
       
       Set<ID> newoppIDs = new Set<ID>();
       List<OpportunityTeamMember> existingOppTeamMember = new List<OpportunityTeamMember>();
       Set<String> teamRoleSet = new Set<String>();
       if(oppIDs.size()>0)
           existingOppTeamMember = [Select Id,OpportunityID,UserID,TeamMemberRole from OpportunityTeamMember where OpportunityID IN:oppIDs and ID Not IN : teamIDs];
        Map<ID,String> mapTeamMap = new Map<ID,String>();
        
        system.debug('\n\n==== existingOppTeamMember size === '+existingOppTeamMember.size()+'\n\n');
        
        for(OpportunityTeamMember otm:existingOppTeamMember){
            if(otm.TeamMemberRole == Label.Sales_Primary){
                system.debug('\n\n==== otm.TeamMemberRole === '+otm.TeamMemberRole+'\n\n'); 
                teamRoleSet.add(otm.TeamMemberRole);
                newoppIDs.add(otm.OpportunityID);
            }
       }
       
       system.debug('\n\n==== teamRoleSet === '+teamRoleSet+'\n\n'); 
       system.debug('\n\n==== newoppIDs === '+newoppIDs+'\n\n'); 
       system.debug('\n\n==== Insert trigger ===' +Util_GE_OG.isFromOppTriggerInsert);
       
        if(oldOTMMap != null){
            system.debug('\n\n==== In Update === \n\n'); 
            for(OpportunityTeamMember otm:newOTMList){
                system.debug('\n\n==== In Update otm === '+otm+'\n\n'); 
                if(otm.TeamMemberRole == Label.Sales_Primary && newoppIDs.contains(otm.OpportunityID)){
                    system.debug('\n\n==== In Update Error === \n\n'); 
                    otm.addError('Owner is already present in Deal Team with role as Sales - Primary');
                }
                else if(otm.TeamMemberRole != Label.Sales_Primary && isFromCode && oldOTMMap.get(otm.ID).TeamMemberRole == Label.Sales_Primary && setprofileadmindev.size()>0 && !setprofileadmindev.contains(UserInfo.getprofileid())){
                    OTM.addError(System.Label.Opportunity_Primary_Sales_Error_Msg);
                    //otm.addError('Sales - Primary can only be changed when Opportunity Owner changed.');    
                }
                 else if(otm.TeamMemberRole != 'Commercial Primary Resource' && isFromCode && oldOTMMap.get(otm.ID).TeamMemberRole == 'Commercial Primary Resource'){
                    OTM.addError('Commercial Primary Resource can only be changed from the Overview Page');
                    //otm.addError('Sales - Primary can only be changed when Opportunity Owner changed.');    
                }
            }
        }else if(oldOTMMap == null){
            system.debug('\n\n==== In Insert : oldOTM NULL === \n\n'); 
            Set<ID> setSalesIDs = new Set<ID>(); 
            for(OpportunityTeamMember otm:newOTMList){
                system.debug('\n\n==== In Insert otm === '+otm+'\n\n'); 
                String teamRole = otm.TeamMemberRole;
                //if(otm.TeamMemberRole == Label.Sales_Primary && setSalesIDs.contains(otm.OpportunityID)){
                system.debug('\n\n==== setSalesIDs === '+setSalesIDs+'\n\n'); 
                system.debug('\n\n==== newoppIDs  === '+newoppIDs+'\n\n'); 
                 system.debug('\n\n==== otm.OpportunityID  === '+otm.OpportunityID+'\n\n'); 
                
                //if(otm.TeamMemberRole == Label.Sales_Primary && setSalesIDs.contains(otm.OpportunityID)){
                if((otm.TeamMemberRole == Label.Sales_Primary &&  (setSalesIDs.contains(otm.OpportunityID) || newoppIDs.contains(otm.OpportunityID) )) && otm.User.IsActive){
                    system.debug('\n\n==== In Error Error === \n\n'); 
                    otm.addError('Owner is already present in Deal Team with role as  Sales - Primary ');
                }
                else if(otm.TeamMemberRole == Label.Sales_Primary && !setSalesIDs.contains(otm.OpportunityID)){
                    setSalesIDs.add(otm.OpportunityID);    
                }
            }
        }
        
    }
    
}