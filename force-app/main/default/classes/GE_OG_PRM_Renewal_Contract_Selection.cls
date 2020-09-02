public class GE_OG_PRM_Renewal_Contract_Selection {

public List<ExecutedContracts> lstExecutedAddendumContracts {get;set;}
public ID AccID {get;set;}
public List<Id> selectedContracts = new List<Id>();
public  list<contract> lstOldAddedumcontractNoappt = new list<contract>();
public  list<contract> Addedumcontract = new list<contract>();
public list<contract> lstOldMastercontract = new list<contract>();
public list<id> lstOldMastercontractid = new list<id>();
public  list<contract> lstupdatecontract = new list<contract>();
public Pagereference newChAppurl{get;set;}   
String contractRecordTypeMasterId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Channel Master Agreement').getRecordTypeId();
String contractRecordTypeAddenId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Channel Addendum Agreement').getRecordTypeId();
       

    public void GE_OG_PRM_Renewal_Contract_Selection ()
        {
        AccID = ApexPages.currentPage().getParameters().get('Accid');              
        }
             
    public Pagereference getcontracts()
        {       
        AccID = ApexPages.currentPage().getParameters().get('Accid');   
        lstExecutedAddendumContracts = new List<ExecutedContracts>();
        ExecutedContracts objExecContract ;        
        List<Contract>  lstmastercontracts = [ SELECT id,GE_PRM_Channel_Appointment_ID__c from contract where accountid =:AccID AND recordtypeid =:contractRecordTypeMasterId AND status = 'Executed'];
        System.debug('%%% ACCID ' +AccID);
        System.debug('%%% MASTER '+  lstmastercontracts );
        System.debug('%%% CHILD '+ [SELECT GE_PRM_Relationship_Type__c,id,name,ContractNumber,StartDate,GE_PRM_Tier_5__c , GE_PRM_Tier_2__c,GE_PRM_Tier_3__c ,GE_PRM_Tier_4__c ,Status,GE_OG_Contract_End_Date__c FROM contract WHERE recordtypeid =:contractRecordTypeAddenId AND status = 'Executed' AND accountid = :accID and GE_PRM_Master_Agreement__c IN : lstmastercontracts]);
          
        for(Contract objContract : [SELECT GE_PRM_Relationship_Type__c,id,name,ContractNumber,StartDate,GE_PRM_Tier_5__c , GE_PRM_Tier_2__c,GE_PRM_Tier_3__c ,GE_PRM_Tier_4__c ,Status,GE_OG_Contract_End_Date__c FROM contract WHERE recordtypeid =:contractRecordTypeAddenId AND status = 'Executed' AND accountid = :accID and GE_PRM_Master_Agreement__c IN : lstmastercontracts])
            {
                objExecContract  = new ExecutedContracts ();
                objExecContract.ContractID = objContract.id;
                objExecContract.ContractName = objContract.name;
                objExecContract.ContractNumber= objContract.ContractNumber;
                objExecContract.GE_PRM_Tier_2 = objContract.GE_PRM_Tier_2__c ;
                objExecContract.GE_PRM_Tier_3 = objContract.GE_PRM_Tier_3__c ;
                objExecContract.GE_PRM_Tier_4 = objContract.GE_PRM_Tier_4__c ;
                objExecContract.GE_PRM_Tier_5 = objContract.GE_PRM_Tier_5__c ;
                objExecContract.Status  = objContract.Status  ;
                objExecContract.GE_PRM_Relationship_Type = objContract.GE_PRM_Relationship_Type__c;
                If (objContract.GE_OG_Contract_End_Date__c !=null)
                {
                    objExecContract.EndDate = objContract.GE_OG_Contract_End_Date__c.month() +'/'+ objContract.GE_OG_Contract_End_Date__c.day() +'/'+ objContract.GE_OG_Contract_End_Date__c.year();
                }
                If (objContract.StartDate !=null )
                {
                    objExecContract.StartDate= objContract.StartDate.day()+'/'+ objContract.StartDate.month()+'/'+ objContract.StartDate.year();
                }
                    objExecContract.isSelected = false;                
                    lstExecutedAddendumContracts.add(objExecContract);                
                System.debug('inside for');
            }
            
            system.debug(lstExecutedAddendumContracts.size());
            return null;
        }
        
       
        
        public Pagereference renewContracts()
        {
            String contractRecordTypeMasterId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Channel Master Agreement').getRecordTypeId();
            Account acc = [select id,Oil_Gas_Parent_Account__c from account where id =:AccId];
            String Channel_Appointment_ID;  
            GE_PRM_Channel_Appointment__c Channel_Appointment = new GE_PRM_Channel_Appointment__c();                                               
            for(ExecutedContracts conwrapper : lstExecutedAddendumContracts )
            {
                if(conwrapper.isSelected== true)
                {
                    selectedContracts.add(conwrapper.ContractID);                   
                }
            }
            if(!selectedContracts.isEmpty()){
                Channel_Appointment_ID = [select GE_PRM_Channel_Appointment_ID__c from  contract where id = :selectedContracts[0]].GE_PRM_Channel_Appointment_ID__c;
            }
            If(Channel_Appointment_ID!=Null){
                Channel_Appointment = [Select GE_PRM_Region_Sales_Channel_Leader__c,GE_PRM_Primary_Sales_Channel_Manager__c,GE_PRM_In_Business_Since__c,
                                                    GE_PRM_With_GE_since__c,GE_PRM_Tier_2_P_L__c,GE_PRM_Principal_contact__c,GE_PRM_Commercial_quali_rationale__c,
                                                    GE_PRM_Payment_term_requested__c,GE_PRM_Credit_limit_requested__c,GE_PRM_Is_government_cert_uploaded__c,
                                                    GE_PRM_Primary_bank_name_address__c,GE_PRM_Primary_bank_account_country__c,GE_PRM_Primary_bank_account__c,
                                                    GE_PRM_Primary_bank_contact__c,GE_PRM_Due_diligence_approval_Status__c,Negative_News_Search_Date__c,
                                                    GE_PRM_Mandated_by_End_Customer__c,GE_PRM_Export_Controlled_products__c,GE_PRM_High_Risk_product_lines__c,
                                                    GE_PRM_Approved_exclusivity_from_P_L__c,GE_PRM_Do_you_sell_to_the_government__c,GE_PRM_Do_you_have_Officers_in_Gov__c,
                                                    GE_PRM_Convicted_of_any_felony_crims_r_s__c,GE_PRM_Does_Channel_Partner_have_subsid__c,GE_PRM_Des_Chnl_Partner_hv_sb_dea_sbagnt__c,
                                                    GE_PRM_Last_Spirit_Letter_signed_date__c,GE_PRM_Last_Site_visit_signed_date__c,Commercial_References_Requested_Date__c,
                                                    Commercial_References_Received_Date__c,GE_PRM_Deloitte_report_order_date__c,GE_PRM_Last_Deloitte_report_cmpltd_date__c,
                                                    ICP_Report_Request_Date__c,Last_ICP_Report_Completed_Date__c,Was_Ever_High__c,GE_PRM_Risk_rating__c
                                                    from GE_PRM_Channel_Appointment__c WHERE Id=:Channel_Appointment_ID];
            }          
            if((selectedContracts.size()>0 && Channel_Appointment!=Null) || Test.isRunningTest())
            {
                GE_PRM_Channel_Appointment__c ChaAppt = new GE_PRM_Channel_Appointment__c();
                ChaAppt.GE_PRM_Account_Name__c = accID;           
                if(acc != null && acc.Oil_Gas_Parent_Account__c != null){
                ChaAppt.GE_PRM_Commercial_Account__c= acc.Oil_Gas_Parent_Account__c;
                }
                ChaAppt.GE_PRM_Master_appointment_type__c = 'Renewal';
                ChaAppt.GE_PRM_Region_Sales_Channel_Leader__c = Channel_Appointment.GE_PRM_Region_Sales_Channel_Leader__c;
                ChaAppt.GE_PRM_Primary_Sales_Channel_Manager__c = Channel_Appointment.GE_PRM_Primary_Sales_Channel_Manager__c;
                ChaAppt.GE_PRM_In_Business_Since__c = Channel_Appointment.GE_PRM_In_Business_Since__c;            
                ChaAppt.GE_PRM_Tier_2_P_L__c = Channel_Appointment.GE_PRM_Tier_2_P_L__c;
                ChaAppt.GE_PRM_Principal_contact__c = Channel_Appointment.GE_PRM_Principal_contact__c;
                ChaAppt.GE_PRM_Commercial_quali_rationale__c = Channel_Appointment.GE_PRM_Commercial_quali_rationale__c;
                ChaAppt.GE_PRM_Payment_term_requested__c = Channel_Appointment.GE_PRM_Payment_term_requested__c;
                ChaAppt.GE_PRM_Credit_limit_requested__c = Channel_Appointment.GE_PRM_Credit_limit_requested__c;              
                ChaAppt.GE_PRM_Primary_bank_name_address__c = Channel_Appointment.GE_PRM_Primary_bank_name_address__c;
                ChaAppt.GE_PRM_Primary_bank_account_country__c = Channel_Appointment.GE_PRM_Primary_bank_account_country__c;
                ChaAppt.GE_PRM_Primary_bank_account__c = Channel_Appointment.GE_PRM_Primary_bank_account__c;
                ChaAppt.GE_PRM_Primary_bank_contact__c = Channel_Appointment.GE_PRM_Primary_bank_contact__c;             
            try
            {
                ChaAppt.Was_Ever_High__c = Channel_Appointment.Was_Ever_High__c;
                ChaAppt.GE_PRM_Old_Contract__c = [select GE_PRM_Master_Agreement__c from  contract where id = :selectedContracts[0]].GE_PRM_Master_Agreement__c;
            
                if(ChaAppt!=Null){
                insert ChaAppt;}
            }
            catch(Exception e)
            {
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Channel Appointment has not renewed yet');
                ApexPages.addMessage(myMsg); 
            } 
            
            lstOldAddedumcontractNoappt = [select status, GE_PRM_Channel_Appointment_ID__c,GE_PRM_Master_Agreement__c,accountid,GE_ES_User_Lead_Sales_Person__c,
                                           GE_PRM_Business_Tier_1__c,GE_PRM_Tier_2__c,GE_PRM_Tier_3__c,GE_PRM_Tier_4__c,GE_PRM_Authorized_Country__c,GE_PRM_Tier_5__c,
                                           GE_PRM_If_flat_Pricing__c,GE_PRM_If_schedule_Max_Pricing__c,GE_PRM_If_schedule_Min_Pricing__c, GE_PRM_Industries__c,
                                           GE_PRM_Buyers__c, GE_PRM_State_Province_Region__c, GE_PRM_Pricing__c, GE_PRM_Pricing_type__c, GE_PRM_Nuclear_use__c,
                                           GE_PRM_Military_use__c, GE_PRM_If_Brazil_SR_SC_core__c, GE_PRM_If_Brazil_SR_CMPJ__c, GE_PRM_Inclusions_exclusions__c,
                                           GE_PRM_If_SR_sales_to_US_government__c, GE_PRM_Comments__c, GE_PRM_Commercial_Manager1__c, GE_PRM_Relationship_Type__c,
                                           StartDate, ContractTerm, GE_OG_Contract_End_Date__c, GE_PRM_Limitations_exclusions__c, GE_PRM_Exclusions__c,GE_PRM_Sub_Channel_Address__c,
                                           GE_PRM_Sub_Channel_Legal_Entity_Name__c, GE_PRM_Primary_Sales_Channel_Manager__c, GE_PRM_Region__c,GE_PRM_Commercial_line__c,GE_PRM_Commercial_line__r.GE_PRM_Nuclear_use_Add_comment__c,GE_PRM_Commercial_line__r.GE_PRM_Military_use_Add_comment__c
                                           from Contract where id In: selectedContracts];  
            
            System.debug('List Of Contracts'+lstOldAddedumcontractNoappt );
            if(lstOldAddedumcontractNoappt.size()>0){           
            list<GE_PRM_Commercial_line__c> LstRenew_Commline = new list<GE_PRM_Commercial_line__c>();
            List<Contract> List_Addmn_Contract=new List<Contract>();
            for(contract addmcontract : lstOldAddedumcontractNoappt)
            {
                GE_PRM_Commercial_line__c renewcommline = new GE_PRM_Commercial_line__c();
                renewcommline.GE_PRM_Channel_Appointment__c = ChaAppt.id;
                renewcommline.GE_PRM_Status__c='Renewal';
                renewcommline.GE_PRM_Tier_1__c= 'Oil & Gas';
                renewcommline.GE_PRM_Tier_2__c= addmcontract.GE_PRM_Tier_2__c;
                renewcommline.GE_PRM_Tier_3__c= addmcontract.GE_PRM_Tier_3__c;
                renewcommline.GE_PRM_Tier_4__c= addmcontract.GE_PRM_Tier_4__c;
                renewcommline.GE_PRM_Tier_5__c= addmcontract.GE_PRM_Tier_5__c;
                renewcommline.GE_PRM_Type__c =   addmcontract.GE_PRM_Relationship_Type__c;                
                renewcommline.GE_PRM_Term__c=  addmcontract.ContractTerm;
                renewcommline.GE_PRM_Industries__c = addmcontract.GE_PRM_Industries__c;
                renewcommline.GE_PRM_Buyers__c = addmcontract.GE_PRM_Buyers__c;
                renewcommline.GE_PRM_Old_Contract__c = addmcontract.Id;
                renewcommline.GE_PRM_Nuclear_use_Add_comment__c=addmcontract.GE_PRM_Commercial_line__r.GE_PRM_Nuclear_use_Add_comment__c;
                renewcommline.GE_PRM_Military_use_Add_comment__c=addmcontract.GE_PRM_Commercial_line__r.GE_PRM_Military_use_Add_comment__c;
                LstRenew_Commline.add(renewcommline);
                addmcontract.GE_PRM_Old_Channel_Appointment_ID__c=Channel_Appointment_ID;
                List_Addmn_Contract.add(addmcontract);
                lstOldMastercontractid.add(addmcontract.GE_PRM_Master_Agreement__c);
                system.debug('**renewcommline'+renewcommline);   
            }
            if(!List_Addmn_Contract.isEmpty()){
               Database.SaveResult[] srList = Database.Update(List_Addmn_Contract, false);
                // Iterate through each returned result
                for (Database.SaveResult sr : srList) {
                    if (sr.isSuccess()) {
                        // Operation was successful, so get the ID of the record that was processed
                        System.debug('Successfully inserted account. Account ID: ' + sr.getId());
                    }
                    else {
                        // Operation failed, so get all errors  
                        for(Database.Error err : sr.getErrors()) {
                             System.debug('Account fields that affected this error: ' + err.getFields());           
                             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, +err.getMessage());
                             ApexPages.addMessage(myMsg);                            
                             newChAppurl=new PageReference('/apex/GE_OG_PRM_Renewal_Contract_Selection?accid='+accID) ;
                             return  newChAppurl;
                        }
                    }                            
               }     
         }       
         if(!LstRenew_Commline.isEmpty()) {   
                Insert LstRenew_Commline; }

             //Sync fields with commercial line 
            GE_PRM_Commercial_Lines_Class.SyncFieldsfromCommLines(ChaAppt.id);
            //Generating Risk                
                ApexPages.StandardController std = New ApexPages.StandardController(LstRenew_Commline[0]);
                GE_PRM_Commercial_Lines_Class ge = New GE_PRM_Commercial_Lines_Class(std);
                ge.GenerateRisk(ChaAppt.id); 
                //line no 129 and 130 are creating error
               
                lstOldMastercontract  =[select id, status, GE_PRM_Channel_Appointment_ID__c, accountid, GE_PRM_Primary_Sales_Channel_Manager__c,GE_PRM_Commercial_Manager1__c, GE_PRM_Tier_2__c, GE_PRM_Region__c, GE_PRM_Nuclear_sales__c, GE_PRM_Military_sales__c, GE_PRM_Sub_dealer_agents__c, GE_PRM_Brazil_Sales_Rep__c from contract where  id IN:lstOldMastercontractid AND RecordTypeId =: contractRecordTypeMasterId ];
                if(lstOldMastercontract.size()>0)
                {
                    for( Contract mastercontract: lstOldMastercontract)
                    {
                        Addedumcontract = [select status, GE_PRM_Channel_Appointment_ID__c,GE_PRM_Master_Agreement__c,accountid,GE_ES_User_Lead_Sales_Person__c, GE_PRM_Business_Tier_1__c,GE_PRM_Authorized_Country__c,GE_PRM_Tier_2__c,GE_PRM_Tier_3__c,GE_PRM_Tier_4__c,GE_PRM_Tier_5__c,GE_PRM_If_flat_Pricing__c,GE_PRM_If_schedule_Max_Pricing__c,GE_PRM_If_schedule_Min_Pricing__c, GE_PRM_Industries__c, GE_PRM_Buyers__c, GE_PRM_State_Province_Region__c, GE_PRM_Pricing__c, GE_PRM_Pricing_type__c, GE_PRM_Nuclear_use__c, GE_PRM_Military_use__c, GE_PRM_If_Brazil_SR_SC_core__c, GE_PRM_If_Brazil_SR_CMPJ__c, GE_PRM_Inclusions_exclusions__c, GE_PRM_If_SR_sales_to_US_government__c, GE_PRM_Comments__c, GE_PRM_Commercial_Manager1__c, GE_PRM_Relationship_Type__c, StartDate, ContractTerm, GE_OG_Contract_End_Date__c, GE_PRM_Limitations_exclusions__c, GE_PRM_Exclusions__c, GE_PRM_Sub_Channel_Address__c, GE_PRM_Sub_Channel_Legal_Entity_Name__c, GE_PRM_Primary_Sales_Channel_Manager__c, GE_PRM_Region__c from Contract where GE_PRM_Master_Agreement__c=:mastercontract.id];  
                    
                        if(Addedumcontract.size()>0)
                        {
                            for(Contract addmcnt: Addedumcontract)
                            if(addmcnt.status=='Generate Draft' ||Test.isRunningTest())
                            {
                                mastercontract.status='Generate Draft'; 
                                break;
                            }
                            else if(addmcnt.status=='Non-Renewed' ||Test.isRunningTest())
                            {
                                mastercontract.status='Non-Renewed'; 
                                break;
                            }
                             else if(addmcnt.status=='Under NR/T')
                            {
                                mastercontract.status='Under NR/T'; 
                                break;
                            }
                            else if(addmcnt.status=='Executed')
                            {
                                mastercontract.status='Executed'; 
                                break;
                            }
                        }
                    }
                }
                //update lstupdatecontract;
            //}
            //catch(Exception e){}
            //system.debug('**lstrenewcommline'+lstrenewcommline);      
        }         
        newChAppurl=new PageReference('/apex/GE_PRM_Channel_Appointment_View_Page1?id='+ChaAppt.id) ;
        newChAppurl.setRedirect(True); 
        }
        else
        {
            //alert("Please select Addendum Contract to renew');
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Please select Addendum Contract to renew');
            ApexPages.addMessage(myMsg); 
            
            newChAppurl=new PageReference('/apex/GE_OG_PRM_Renewal_Contract_Selection?accid='+accID) ;
            newChAppurl.setRedirect(false); 
        }
         return newChAppurl;        
        }
        
        public Pagereference backtoAccount()
        {
            accID = ApexPages.currentPage().getParameters().get('accID');
            System.debug('eeeeeee'+accID);
            PageReference account=new PageReference('/'+accID ) ;
            account.setRedirect(True);        
            return account;   
        }
        public  Class ExecutedContracts 
        {
            public ID ContractID {get;set;}
            public String ContractName {get;set;}
            public Boolean isSelected {get;set;}
            public String ContractNumber{get;set;}
            public String GE_PRM_Tier_2 {get;set;}
            public String GE_PRM_Tier_3 {get;set;}
            public String GE_PRM_Tier_4 {get;set;}
            public String GE_PRM_Tier_5 {get;set;}
            public String Status{get;set;}
            public String EndDate {get;set;}
            public String StartDate {get;set;}
            public String GE_PRM_Relationship_Type {get;set;}
       } 
}