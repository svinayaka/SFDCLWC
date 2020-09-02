/*
Class/Trigger Name     : oppAmountSummation_Asset_Project
Purpose/Overview       : This class is used to sum amounts of opportunity on projects and assets.
Scrum Team             : DEAL MGMT - Transformation
Requirement Number     : R-32529
Author                 : Soumi Talukder
Created Date           : 06-Aug-2019
Test Class Name        : Prebid_Approval_Process_GE_OG_Test
Code Coverage          : 66
*/
public class oppAmountSummation_Asset_Project {
    public void amountSummationForAsset(List<Opportunity> newOpp,List<Opportunity> oldOpp, Map<ID,Opportunity> oppMap){
        System.debug('In 13 amountSummationForAsset > > > > > > > ');
        set<ID> assetId = new set<ID>();
        List<Asset> oppAsset = new List<Asset>();
        List<Asset> updateAssetList = new List<Asset>();
        List<Opportunity> dummyFieldUpdate = new List<Opportunity>();
        Trigger_Toggle__mdt triggerToggle = [select isEnabled__c from Trigger_Toggle__mdt where Trigger_Name__c = 'AssetProjectSummation' limit 1];
        
        if(trigger.isInsert || trigger.isUndelete){
            for(Opportunity op : newOpp){ 
                assetId.add(op.Opportunity_Asset_ge_og__c);
            }
        }
        if(trigger.isDelete){
            for(Opportunity op : oldOpp){
                assetId.add(op.Opportunity_Asset_ge_og__c);
            }
        }
        if(trigger.isUpdate){
            for(Opportunity op : newOpp){                
                if(oppMap.get(op.id).Opportunity_Asset_ge_og__c != op.Opportunity_Asset_ge_og__c || oppMap.get(op.id).Oppty_Dummy_Update_ge_og__c != op.Oppty_Dummy_Update_ge_og__c || oppMap.get(op.id).StageName != op.StageName ){ 
                    if(op.Opportunity_Asset_ge_og__c!=null){
                        assetId.add(op.Opportunity_Asset_ge_og__c);
                    }
                    else{
                        assetId.add(oppMap.get(op.id).Opportunity_Asset_ge_og__c);
                    }
                }
                else if(oppMap.get(op.id).Amount_USD_ge_og__c != op.Amount_USD_ge_og__c){
                    assetId.add(oppMap.get(op.Id).Opportunity_Asset_ge_og__c);
                }
                
                //custom metadata                 
                if(triggerToggle.isEnabled__c && (op.Oppty_Dummy_Update_ge_og__c!=oppMap.get(op.ID).Oppty_Dummy_Update_ge_og__c)){                    
                    assetId.add(op.Opportunity_Asset_ge_og__c);
                }
            }
        }
        System.debug('assetId >> '+assetId.size());
        if(assetId.size()>0){
            oppAsset = [select id,Total_Opportunity_Amount__c,(select Amount_USD_ge_og__c,amount_ge_og__c,Opportunity_Asset_ge_og__c,StageName from Opportunities__r where  Opportunity_Asset_ge_og__c != null )
                        from Asset where Id in :assetId];
        }
        
        for(Asset ast : oppAsset){
            decimal num = 0.00;
            decimal wonamt = 0.00;
            decimal lostamt = 0.00;
            decimal openamt = 0.00;
            for(Opportunity o : ast.opportunities__r){
                System.debug('62 >>>> '+o.StageName);
                if(o.StageName != 'Cancelled'){
                    num += o.Amount_USD_ge_og__c;
                }
                //added by Harsha c for R-32838
                if(o.StageName == 'Closed Won'){
                    wonamt+= o.Amount_USD_ge_og__c;  
                }
                else if(o.StageName == 'Closed Lost'){
                    lostamt+= o.Amount_USD_ge_og__c;
                }
                if(o.StageName == 'Prospecting' || o.StageName == 'Qualifying' || o.StageName == 'Bid In Development' || o.StageName == 'Bid In Submission' || o.StageName == 'Negotiating'){
                    openamt+= o.Amount_USD_ge_og__c;
                    System.debug('openamt >>> '+openamt);
                }
            }
            ast.Total_Opportunity_Amount__c = num;
            //added by Harsha c for R-32838
            ast.Total_US_Won_Opportunities_ge_og__c = wonamt;
            ast.Total_US_Lost_opportunities_ge_og__c = lostamt;
            ast.Total_US_Open_US_Opportunities_ge_og__c = openamt;
            updateAssetList.add(ast);
            
        }
        update updateAssetList;
    }
    
    public void amountSummationForProject(List<Opportunity> newOpp,List<Opportunity> oldOpp, Map<ID,Opportunity> oppMap){
        set<ID> projId = new set<ID>();
        List<Project_ge_og__c> oppProject = new List<Project_ge_og__c>();
        List<Project_ge_og__c> updateProject = new List<Project_ge_og__c>();
        
        set<ID> dummyFieldUpdate = new set<ID>();
        Decimal amt = 0.00;
        Trigger_Toggle__mdt triggerToggle = [select isEnabled__c from Trigger_Toggle__mdt where Trigger_Name__c = 'AssetProjectSummation' limit 1];
        if(trigger.isInsert || trigger.isUndelete){
            for(Opportunity op : newOpp){                
                projId.add(op.opportunity_project_ge_og__c);
            }
        }
        if(trigger.isDelete){
            for(Opportunity op : oldOpp){
                projId.add(op.opportunity_project_ge_og__c);
            }
        }
        if(trigger.isUpdate){
            for(Opportunity op : newOpp){                
                if(oppMap.get(op.id).opportunity_project_ge_og__c != op.opportunity_project_ge_og__c ||oppMap.get(op.id).Oppty_Dummy_Update_ge_og__c != op.Oppty_Dummy_Update_ge_og__c || oppMap.get(op.id).StageName != op.StageName ){
                    if(op.opportunity_project_ge_og__c!=null){
                        projId.add(op.opportunity_project_ge_og__c);
                    }
                    else{
                        projId.add(oppMap.get(op.id).opportunity_project_ge_og__c);
                        system.debug('Project ID: '+projId);
                    }
                }
                else if(oppMap.get(op.id).Amount_USD_ge_og__c != op.Amount_USD_ge_og__c){
                    projId.add(op.opportunity_project_ge_og__c);                            
                }
                else if(oppMap.get(op.id).StageName != op.StageName){
                    projId.add(op.opportunity_project_ge_og__c);
                }
                
                //custom metadata                 
                else if(triggerToggle.isEnabled__c && (op.Oppty_Dummy_Update_ge_og__c!=oppMap.get(op.ID).Oppty_Dummy_Update_ge_og__c)){                    
                    projId.add(op.opportunity_project_ge_og__c);
                    system.debug('Dummy Update-->'+projId);
                }
            }
        }
        if(projId.size()>0){
            oppProject = [select id,Total_Opportunity_Amount__c,(select Amount_USD_ge_og__c,opportunity_project_ge_og__c,Oppty_Dummy_Update_ge_og__c ,StageName from Opportunities3__r where StageName != 'Cancelled' and opportunity_project_ge_og__c!=null)
                          from Project_ge_og__c where Id in :projId and (RecordType.Name in('O&G Project') or RecordType.Name in ('Joint Pursuit Project'))];
            system.debug('Opp Project: '+oppProject);
        }
        decimal wonamt = 0.00;
        decimal lostamt = 0.00;
        decimal openamt = 0.00;
        
        
        for(Project_ge_og__c prj : oppProject){
            decimal num = 0.00;
            for(Opportunity o : prj.Opportunities3__r){
                num += o.Amount_USD_ge_og__c;
                //added by Harsha c for R-32838
                if(o.StageName == 'Closed Won'){
                    wonamt+= o.Amount_USD_ge_og__c;  
                }
                if(o.StageName == 'Closed Lost'){
                    lostamt+= o.Amount_USD_ge_og__c;
                }
                if(o.StageName == 'Prospecting' || o.StageName == 'Qualifying' || o.StageName == 'Bid In Development' || o.StageName == 'Bid In Submission' || o.StageName == 'Negotiating'){
                    openamt+= o.Amount_USD_ge_og__c;
                    System.debug('openamt >>> '+openamt);
                }
                
            }
            
            prj.Total_Opportunity_Amount__c = num;
            prj.Total_US_Won_Opportunities_ge_og__c = wonamt;
            prj.Total_US_Lost_opportunities_ge_og__c = lostamt;
            prj.Total_US_Open_US_Opportunities_ge_og__c = openamt;
            updateProject.add(prj);
        }
        update updateProject;
    }
    
}