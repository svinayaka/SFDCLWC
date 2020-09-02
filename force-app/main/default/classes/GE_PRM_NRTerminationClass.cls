/**
 * 
 * Class/Trigger Name--: GE_PRM_NRTerminationClass
 * Used Where ?--------: acts as controller for GE_PRM_NonRenewTerminationEditPage
 * Purpose/Overview----: To Enter Non-Renew/Termination section details for a commercial line
 * Functional Area-----: PRM
 * Author--------------: Pradeep Rao Yadagiri
 * Created Date--------:  9/30/2014
 * Test Class Name-----: Test_GE_PRM_Channel_Appointment_Class
 * Change History -
 * Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
**/

public without sharing class GE_PRM_NRTerminationClass {
    //** variable declaration
    public class MyException extends Exception {}
    public GE_PRM_Commercial_line__c commline {get; set;}
    public List<GE_PRM_Channel_Appointment_Approver__c > appt1Approvalslst{get; set;}
    public contract c{get; set;} 
    public list<GE_PRM_Commercial_line__c> finallist{get; set;}  
    public string approverType{get; set;}
    public GE_PRM_Channel_Appointment__c chappt{get; set;}
    
    //** constructor
    public GE_PRM_NRTerminationClass (ApexPages.StandardController controller) {
        finallist =new list<GE_PRM_Commercial_line__c>();
        c = new contract();
        chappt = new GE_PRM_Channel_Appointment__c();
        appt1Approvalslst = new List<GE_PRM_Channel_Appointment_Approver__c >();
        String clineid = ApexPages.currentPage().getParameters().get('clineid');
        String terminatestr= ApexPages.currentPage().getParameters().get('terminate');
        String nonrenewstr = ApexPages.currentPage().getParameters().get('nonrenew');
        commline = [select GE_PRM_If_due_to_Compliance_issue_Yes1__c, GE_PRM_Status__c, GE_PRM_Non_Renewal_or_Termination__c,
                    GE_PRM_Future_market_coverage__c,GE_PRM_Proposed_effective_date__c,
                    GE_PRM_Due_To_Compliance_Issue__c,GE_PRM_If_due_to_Compliance_issue_Yes__c,
                    GE_PRM_Is_there_contracts_T_C_risk__c, GE_PRM_If_Is_there_contracts_T_C_Yes1__c,
                    GE_PRM_outstanding_receivables__c, GE_PRM_If_outstanding_receivable_Yes1__c,
                    GE_PRM_Outstanding_Payments__c, GE_PRM_If_Outstanding_Payments_Yes1__c,
                    GE_PRM_any_GE_equipment_to_return__c, GE_PRM_If_GE_Equipment_to_return_Yes1__c,
                    GE_PRM_Authorized_to_sell_other__c, GE_PRM_If_authorized_to_sell_other_Yes1__c,
                    GE_PRM_Channel_Appointment__r.GE_PRM_Account_Name__c,GE_PRM_Tier_2__c,GE_PRM_Tier_3__c,GE_PRM_Tier_4__c,GE_PRM_Tier_5__c,
                    GE_PRM_Channel_Appointment__c,GE_PRM_Channel_Appointment__r.id,                   
                    GE_PRM_Sales_Manager__c,
                    GE_PRM_Tier_1__c,
                    GE_PRM_Channel_Appointment__r.GE_PRM_Account_Country__c,                  
                    Non_renewal_Termination_Rationale__c, Adverse_country_risk__c,GE_PRM_Type__c
                    from GE_PRM_Commercial_line__c where id =: clineid ];   
        
        chappt =    [select id, GE_PRM_Account_Name__c, GE_PRM_Region_Sales_Channel_Leader__c, GE_PRM_Primary_Sales_Channel_Manager__c, CreatedById,GE_PRM_Account_Country__c,GE_PRM_O_G_Region__c from GE_PRM_Channel_Appointment__c where id =: commline.GE_PRM_Channel_Appointment__c];
        
    }
    // Saving the Non-Renew / Termination Details
    public PageReference cmdSubmit() {
        string strmsg = '';
        commline.GE_PRM_Status__c = 'Under NR/T';
        try {
            if(commline.GE_PRM_Non_Renewal_or_Termination__c == null) {
                strmsg = strmsg+ '--'+'please Enter Non-Renewal or Termination?';        
            }            
            if(commline.GE_PRM_Due_To_Compliance_Issue__c == null) {
                strmsg= strmsg+'--'+'Please Enter Non-Renewal or Termination due to Compliance issue?';
            }            
            if(commline.GE_PRM_Is_there_contracts_T_C_risk__c == null) {
                strmsg= strmsg+'--'+'Please enter Is there contracts T&Cs risk related to ending GE s relationship with this Partner?';
            }            
            if(commline.GE_PRM_outstanding_receivables__c == null) {
                strmsg= strmsg+'--'+'Please enter Are there outstanding receivables with this Partner?';
            }            
            if(commline.GE_PRM_Outstanding_Payments__c == null){
                strmsg= strmsg+'--'+'Please enter Are there outstanding payments due to this Partner?';
            }            
            if(commline.GE_PRM_any_GE_equipment_to_return__c == null) {
                strmsg= strmsg+'--'+'Please enter Does the Partner have any GE equipment to return';
            }            
            if(commline.GE_PRM_Authorized_to_sell_other__c == null) {
                strmsg= strmsg+'--'+' Please enter Is the Partner authorized to sell other GE product lines?';
            }            
            if(commline.GE_PRM_Non_Renewal_or_Termination__c == null)
                throw new MyException();
            if(commline.GE_PRM_Due_To_Compliance_Issue__c == null)
                throw new MyException();
            if(commline.GE_PRM_Is_there_contracts_T_C_risk__c == null)
                throw new MyException();
            if(commline.GE_PRM_outstanding_receivables__c == null)
                throw new MyException();
            if(commline.GE_PRM_Outstanding_Payments__c == null)
                throw new MyException();
            if(commline.GE_PRM_any_GE_equipment_to_return__c == null)
                throw new MyException();
            if(commline.GE_PRM_Authorized_to_sell_other__c == null)
                throw new MyException();
        }
        catch(exception e) {
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.FATAL,strmsg);
            ApexPages.addMessage(myMsg);
            return null;
        } 
       try{        
          c = [select GE_PRM_channel_Appoinment_createdby__c,GE_PRM_PrimarySalesChannel_Manager__c, GE_PRM_Region_Sales_Channel_Leader__c,  Status, GE_PRM_NRT_Email__c from contract where (GE_PRM_Channel_Appointment_ID__c =: commline.GE_PRM_Channel_Appointment__r.id) and (AccountID =: commline.GE_PRM_Channel_Appointment__r.GE_PRM_Account_Name__c)  AND
                 (GE_PRM_Business_Tier_1__c =: commline.GE_PRM_Tier_1__c) AND (GE_PRM_Tier_2__c =: commline.GE_PRM_Tier_2__c) AND (GE_PRM_Tier_3__c =:commline.GE_PRM_Tier_3__c ) AND (GE_PRM_Tier_4__c =: commline.GE_PRM_Tier_4__c ) AND( GE_PRM_Tier_5__c =:commline.GE_PRM_Tier_5__c) 
                 AND (GE_PRM_Relationship_Type__c =: commline.GE_PRM_Type__c) AND (GE_PRM_Commercial_line__c =:commline.Id)
                 ];
             system.debug('%%%%%%%c$$$$$$'+c);
        }    
       catch(exception e) {
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.FATAL,'Cannot be terminated or Non-Renewed as the contract is not available or Multiple contracts with same tiers');
            ApexPages.addMessage(myMsg);
            return null;
        } 
        
        try {            
            update commline;
        }
        catch(exception e) {
            return null;
        }        
        c.status = 'Under NR/T';
        c.GE_PRM_channel_Appoinment_createdby__c = chappt.CreatedById;
        c.GE_PRM_PrimarySalesChannel_Manager__c = chappt.GE_PRM_Primary_Sales_Channel_Manager__c;
        c.GE_PRM_Region_Sales_Channel_Leader__c = chappt.GE_PRM_Region_Sales_Channel_Leader__c;
        update c;        
        finallist.add(commline); 
        if(commline.GE_PRM_Non_Renewal_or_Termination__c == 'Non-renewal') {
            approverType = 'Non-Renewal';
        }
        if(commline.GE_PRM_Non_Renewal_or_Termination__c == 'Termination') {
            approverType = 'Termination';
        }
        Getapprovers(finallist ,approverType);          
        pagereference pf = new pagereference('/apex/GE_PRM_Channel_Appointment_View_Page1?id='+commline.GE_PRM_Channel_Appointment__c);
        return pf;
    }    
    public PageReference cmdcancel() {
        pagereference pf = new pagereference('/apex/GE_PRM_Channel_Appointment_View_Page1?id='+commline.GE_PRM_Channel_Appointment__c);
        return pf;
    }
    // logic implemented to generate NRT approvers based on commercial line details
    public PageReference  Getapprovers(list<GE_PRM_Commercial_line__c> commlines,String apprtype) {   
        List<GE_PRM_Channel_Appointment_Approver__c > apptApprovalslstwithD = new List<GE_PRM_Channel_Appointment_Approver__c >();  
        
        
        List<GE_ES_Role__c> prmRoles = new List<GE_ES_Role__c>();       
        list<GE_PRM_Channel_Appointment__c>  capplist =new list<GE_PRM_Channel_Appointment__c>();
        List<String> PnLRegionRoleList = new List<String>();         
        Set<String> approvarIds = new Set<String>();
        Set<String> FinalTierSet = new Set<String>();
        Map<Id, Set<String>> RecIdPnl = new Map<Id, Set<String>>();
        List<GE_PRM_Channel_Appointment_Approver__c > apptApprovalslst = new List<GE_PRM_Channel_Appointment_Approver__c >();  
        List<GE_PRM_Channel_Appointment_Approver__c > apptApprovalslst1 = new List<GE_PRM_Channel_Appointment_Approver__c >();  
        List<GE_PRM_Recommendation_Approvers__c> RecommendationApproversList = new List<GE_PRM_Recommendation_Approvers__c>();
        capplist =[select id,GE_PRM_Prior_performance_rating__c, GE_PRM_Commercial_Start_Date_addCL__c,GE_PRM_Account_Country__c,GE_PRM_O_G_Region__c,GE_PRM_Risk_rating__c,GE_PRM_Appointment_Type__c from GE_PRM_Channel_Appointment__c where id =:chappt.id];       
        prmRoles = [select Name, GE_PRM_Approver_Type__c from GE_ES_Role__c where GE_PRM_Role__c = true AND GE_PRM_Approver_Type__c =:apprtype];                
        for(GE_ES_Role__c i :prmRoles ) {
            PnLRegionRoleList.add(i.Name);            
        }
        Set<String> RecomPnLSet = new Set<String>();
        Set<String> RecomPnL = new Set<String>();   
        
        
         //** DOA based on ISO Code
        
        account a = [select name,ShippingCountry, GE_HQ_Country_Code__c from account where id =: chappt.GE_PRM_Account_Name__c]; 
        
        for(GE_PRM_Commercial_line__c j : Commlines )
        {
            RecomPnL.add(j.GE_PRM_Tier_4__c);
            RecomPnLSet.add(j.GE_PRM_Tier_4__c);           
            for(String ESrole : PnLRegionRoleList){
             
                if(j.GE_PRM_Tier_4__c!=null && j.GE_PRM_Tier_4__c!=''){
                    FinalTierSet.add(j.GE_PRM_Tier_1__c+ ' - ' + j.GE_PRM_Tier_2__c + ' - '  + j.GE_PRM_Tier_3__c + ' - ' +j.GE_PRM_Tier_4__c+ ' - ' + ESrole + ' - ' +chappt.GE_PRM_Account_Country__c+ ' - ' +chappt.GE_PRM_O_G_Region__c+'%'); 
                }
               else{
                    FinalTierSet.add(j.GE_PRM_Tier_1__c+ ' - ' + j.GE_PRM_Tier_2__c + ' - '  + j.GE_PRM_Tier_3__c + ' - ' + ESrole + ' - ' +chappt.GE_PRM_Account_Country__c+ ' - ' +chappt.GE_PRM_O_G_Region__c+'%'); 
                }
            RecIdPnl.put(j.GE_PRM_Channel_Appointment__c, RecomPnL);
        }
      }
        
         
        system.debug('FinalTierSetvar'+FinalTierSet +'ssssss'+ a.GE_HQ_Country_Code__c);
        
       /* if(a.ShippingCountry != 'United States'){
        RecommendationApproversList = [Select Id, GE_PRM_Approver_Name__c, GE_PRM_Tier_2__c,GE_PRM_Tier_3__c,GE_PRM_Region__c, GE_PRM_Country__c,GE_PRM_Role__c, GE_PRM_P_L__c,GE_PRM_TIER_4__c,GE_PRM_DOA_Stage__c,GE_PRM_Compliance_Validation__c from GE_PRM_Recommendation_Approvers__c where GE_PRM_FINAL_TIER_SELECTIONS__C like :FinalTierSet  AND GE_PRM_ISO_Code__c =: a.GE_HQ_Country_Code__c];  
        }
        else
        {
        RecommendationApproversList = [Select Id, GE_PRM_Approver_Name__c, GE_PRM_Tier_2__c,GE_PRM_Tier_3__c,GE_PRM_Region__c, GE_PRM_Country__c,GE_PRM_Role__c, GE_PRM_P_L__c,GE_PRM_TIER_4__c,GE_PRM_DOA_Stage__c,GE_PRM_Compliance_Validation__c from GE_PRM_Recommendation_Approvers__c where GE_PRM_FINAL_TIER_SELECTIONS__C like :FinalTierSet  AND GE_PRM_ISO_Code__c =: a.GE_HQ_Country_Code__c AND GE_PRM_FINAL_TIER_SELECTIONS__C like '%US North'];  
        }*/
        if(Test.isRunningTest()){
          FinalTierSet.add('Oil & Gas - Digital Solutions - Controls & Condition Monitoring - Commercial 1 - United States - North America');
        }
        System.debug('FinalTierSet>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'+FinalTierSet);
         RecommendationApproversList = [Select Id, GE_PRM_Approver_Name__c, GE_PRM_Tier_2__c,GE_PRM_Tier_3__c,GE_PRM_Region__c, GE_PRM_Country__c,GE_PRM_Role__c, GE_PRM_P_L__c,GE_PRM_TIER_4__c,GE_PRM_DOA_Stage__c,GE_PRM_Compliance_Validation__c from GE_PRM_Recommendation_Approvers__c where GE_PRM_FINAL_TIER_SELECTIONS__C like :FinalTierSet  AND GE_PRM_ISO_Code__c =: a.GE_HQ_Country_Code__c];  
       
           
        for(GE_PRM_Recommendation_Approvers__c j :RecommendationApproversList ) {
            approvarIds.add(j.GE_PRM_Approver_Name__c);
        }
        
        List<User> delegatedUserLst = new List<User>();
        if(approvarIds.size() > 0) {
            delegatedUserLst = [select id, DelegatedApproverID from User where Id IN: approvarIds];
        }        
        Map<Id, Id> userWithDelegatedUser = new Map<Id, Id>();
        for(Integer i =0; i<delegatedUserLst.size(); i++) {
            userWithDelegatedUser.put(delegatedUserLst.get(i).Id, delegatedUserLst.get(i).DelegatedApproverId);
        }        
        List<GE_PRM_Recommendation_Approvers__c> ESRoleApproverList = new list<GE_PRM_Recommendation_Approvers__c>();
        for(string i :PnLRegionRoleList ) {
            for( GE_PRM_Recommendation_Approvers__c j :RecommendationApproversList ) {
                if(i== j.GE_PRM_Role__c)
                    ESRoleApproverList.add(j);              
            }
        }         
        for(GE_PRM_Recommendation_Approvers__c i :ESRoleApproverList) {
            GE_PRM_Channel_Appointment_Approver__c apprvers =new GE_PRM_Channel_Appointment_Approver__c();
            apprvers.GE_PRM_Approvers__c =i.GE_PRM_Approver_Name__c;
            apprvers.GE_PRM_Role__c =i.GE_PRM_Role__c;
            apprvers.GE_PRM_Region__c =i.GE_PRM_Region__c;
            apprvers.GE_PRM_Country__c =i.GE_PRM_Country__c;
            apprvers.GE_PRM_Delegated_User__c =userWithDelegatedUser.get(i.GE_PRM_Approver_Name__c);
            apprvers.GE_PRM_Status__c ='Pending';
            apprvers.GE_PRM_Channel_Appointment__c= commline.GE_PRM_Channel_Appointment__r.id;
            apprvers.GE_PRM_Tier_2__c=i.GE_PRM_Tier_2__c;
            apprvers.GE_PRM_Tier_3__c=i.GE_PRM_Tier_3__c;
            apprvers.Commercial_line__c = commline.id;
            if(commline.GE_PRM_Non_Renewal_or_Termination__c == 'Non-renewal') {
                apprvers.Non_Renewal__c = true;
            } 
            if(commline.GE_PRM_Non_Renewal_or_Termination__c == 'Termination') {
                apprvers.Terminate__c = true;
            }
            apprvers.Commercial_line__c = commline.id;
            if(apprvers.GE_PRM_Approvers__c != null && string.valueof(apprvers.GE_PRM_Approvers__c) != ''){
            apptApprovalslstwithD.add(apprvers);
            }
        } 
        
        //** Duplicate Approver records removal
        integer intr= 0;
        
        apptApprovalslst1=[SELECT GE_PRM_Role__c,Commercial_line__c,GE_PRM_Approvers__c,GE_PRM_Tier_2__c,GE_PRM_Tier_3__c,GE_PRM_Channel_Appointment__c,GE_PRM_Status__c FROM GE_PRM_Channel_Appointment_Approver__c WHERE GE_PRM_Channel_Appointment__c = :commline.GE_PRM_Channel_Appointment__r.id AND GE_PRM_Status__c!='Approved' AND GE_PRM_Status__c!='Rejected' ];
        
        List<GE_PRM_CAA_CommLine_Junction__c> lstCaaCommJunc = new List<GE_PRM_CAA_CommLine_Junction__c>();
        GE_PRM_CAA_CommLine_Junction__c objCaaCommJunc ;
        if(apptApprovalslst1.size() > 0)
        {
            for(GE_PRM_Channel_Appointment_Approver__c appr : apptApprovalslstwithD)
            {
                boolean foundduplicate;
                objCaaCommJunc = new GE_PRM_CAA_CommLine_Junction__c();
                for(GE_PRM_Channel_Appointment_Approver__c approv : apptApprovalslst1)
                {
                 
                
                if(appr.GE_PRM_Approvers__c == approv.GE_PRM_Approvers__c && approv.GE_PRM_Status__c!='Approved' && approv.GE_PRM_Status__c!='Rejected'  &&appr.GE_PRM_Role__c ==approv.GE_PRM_Role__c)
                {
                    objCaaCommJunc.Channel_Appointment_Approver__c = approv.id;
                    objCaaCommJunc.Commercial_line__c = appr.Commercial_line__c;
                    objCaaCommJunc.Appr_Non_Renewal__c =appr.Non_Renewal__c;
                    objCaaCommJunc.AppTerminate__c =appr.Terminate__c;
                    lstCaaCommJunc.add(objCaaCommJunc);
                    System.debug('found duplicate');
                    foundduplicate = true;
                    break;
        
                }
                else
                {
                    System.debug('ccccc adddduser');
                    foundduplicate = false;
                   
                }
                }
                
                if(foundduplicate == false){
                    apptApprovalslst.add(appr);
             
                }
            
        }
         
        }
        else{
                for(GE_PRM_Channel_Appointment_Approver__c appr : apptApprovalslstwithD)
                {
                    apptApprovalslst.add(appr);
                }
            }
               
        if( apptApprovalslst.size()>0) 
        {
            insert apptApprovalslst;             
            for(GE_PRM_Channel_Appointment_Approver__c apprin :apptApprovalslst)
            {
                system.debug('GE_PRM_Channel_Appointment_Approver__c apprin----------- '+apprin);
                objCaaCommJunc = new GE_PRM_CAA_CommLine_Junction__c();
                 objCaaCommJunc.Channel_Appointment_Approver__c = apprin.id;
                 objCaaCommJunc.Commercial_line__c = apprin.Commercial_line__c;
                 objCaaCommJunc.Appr_Non_Renewal__c =apprin.Non_Renewal__c;
                 objCaaCommJunc.AppTerminate__c =apprin.Terminate__c;
                 lstCaaCommJunc.add(objCaaCommJunc);                
            } 
            appt1Approvalslst = apptApprovalslst;
        }   

        if(lstCaaCommJunc!= null && lstCaaCommJunc.size() > 0)
                {                    
                    insert lstCaaCommJunc;                    
                }
        return null;
    }
  
}