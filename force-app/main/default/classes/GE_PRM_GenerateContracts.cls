/**
* 
* Class/Trigger Name--: GE_PRM_GenerateContracts
* Used Where ?--------: in channel appointment 
* Purpose/Overview----: To generate contracts when channel appointment is approved
* Functional Area-----: PRM
* Author--------------: Revathi Veesam
* Created Date--------: 
* Test Class Name-----: Test_GE_PRM_Channel_Appointment_Class
* Change History -
* Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
**/
Public without sharing class GE_PRM_GenerateContracts
{
    //** method to generate contract when channel appointment status is approved
    public void createcontracts(list<GE_PRM_Channel_Appointment__c> CPAlist,Map<id,GE_PRM_Channel_Appointment__c> CPAoldlist)
    {
    
      
        
        set<Id> CAIDs=new  set<Id>();
        list<Contract>  contractstoinsert=new list<Contract>();
        list<GE_PRM_Channel_Appointment__c> CPAlist1 =new list<GE_PRM_Channel_Appointment__c>();
        map<id,list<Contract>>  contractmap=new map<id,list<Contract>>();
        map<id,id> conmasterrecidmap=new map<id,id>();
        list<Contract> contractstoupdate=new list<Contract>();
        list<Contract> updatecontract=new list<Contract>();
        map<GE_PRM_Channel_Appointment__c,list<GE_PRM_Commercial_line__c>> CACommMap=new map<GE_PRM_Channel_Appointment__c,list<GE_PRM_Commercial_line__c>>();
        String contractRecordTypeMasterId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Channel Master Agreement').getRecordTypeId();
        String contractRecordTypeAddendumId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Channel Addendum Agreement').getRecordTypeId();
        set<ID> Masterid =new SET<ID>();
        for(GE_PRM_Channel_Appointment__c ca:CPAlist){
            if(ca.GE_PRM_Current_Status__c!=null && ca.GE_PRM_Current_Status__c=='Approved' && ca.GE_PRM_Current_Status__c!=CPAoldlist.get(ca.id).GE_PRM_Current_Status__c ){
                CAIDs.add(ca.id);
                CPAlist1.add(ca);
                system.debug('id---->'+ca.id);
            }
        }
        if(CAIDs.size()>0){
            list<contract> cntlst = new list<contract>([select id from contract where GE_PRM_Channel_Appointment_ID__c in :CAIDs and recordtypeID =:contractRecordTypeMasterId ]);
            system.debug('Contract generation.'+cntlst.size() +'     '+contractRecordTypeMasterId );
            list<contract> updatecon= new list<contract>();
            list<GE_PRM_Commercial_line__c> commline =new list<GE_PRM_Commercial_line__c>(); 
            list<GE_PRM_Commercial_line__c> updatingcommlines=new list<GE_PRM_Commercial_line__c>(); 
            //list<GE_PRM_Commercial_line__c> updatingcommlines1=new list<GE_PRM_Commercial_line__c>(); 
            Map<Id,GE_PRM_Commercial_line__c> MapUpdatingcommlines1=new Map<Id,GE_PRM_Commercial_line__c>(); 
            List<id> commid=new List<id>();
            commline =[select GE_PRM_Any_Exclusions__c, id,GE_PRM_Type__c,GE_PRM_Channel_Appointment__r.GE_PRM_Commercial_Manager__c,GE_PRM_Channel_Appointment__r.GE_PRM_Account_Name__r.Oil_Gas_Parent_Account__c, GE_PRM_Channel_Appointment__r.GE_PRM_Account_Name__c,GE_PRM_Channel_Appointment__r.GE_PRM_GE_Account_Name__c,GE_PRM_Authorized_Countries_1__c,GE_PRM_Authorized_Countries_2__c,GE_PRM_Channel_Appointment__r.GE_PRM_Primary_Sales_Channel_Manager__c,
                       GE_PRM_contract_genrated__c, GE_PRM_Channel_Appointment__r.GE_PRM_O_G_Region__c,GE_PRM_Tier_1__c,GE_PRM_Tier_2__c,GE_PRM_Tier_3__c,GE_PRM_Tier_4__c,GE_PRM_Tier_5__c,GE_PRM_State_Province_Region__c,
                       GE_PRM_if_Yes_provide_comments_SlaesRep__c,GE_PRM_Term__c,GE_PRM_Channel_Appointment__r.GE_PRM_Expirydate__c, GE_PRM_Pricing__c,GE_PRM_Pricing_Type__c,GE_PRM_Nuclear_use_Add_comment__c,GE_PRM_Sales_Manager__c,GE_PRM_Military_use_Add_comment__c,GE_PRM_Channel_Appointment__r.GE_PRM_If_Brazil_SR_SC_Core__c,GE_PRM_Channel_Appointment__r.GE_PRM_If_Brazil_SR_CMPJ__c,GE_PRM_Inclusions_exclusions_Add_comment__c,GE_PRIf_Sales_Rep_sales_to_US_Government__c
                       ,GE_PRM_If_flat_Pricing__c,GE_PRM_If_schedule_Max_Pricing__c, GE_PRM_If_schedule_Min_Pricing__c, GE_PRM_Industries__c, GE_PRM_Buyers__c 
                      ,ERP_Contact__c from GE_PRM_Commercial_line__c where GE_PRM_Channel_Appointment__c in :CAIDs ];
             if(commline.size()>0)
             {
                 for(GE_PRM_Commercial_line__c commercialL:commline)
                 {
                     commid.add(commercialL.id);
                 }
             }
             if(commid.size()>0)
             {
                 updatecon=[select id,GE_PRM_Commercial_line__c,GE_PRM_Comments__c,GE_PRM_ERP_Contact__c from Contract where GE_PRM_Commercial_line__c IN:commid];          
             }
            system.debug('count11----->'+ cntlst.size());
            list<Sub_Dealer__c> lstsubdealer = new list<Sub_Dealer__c>([select GE_PRM_Affiliate_dependent_type__c, GE_PRM_Legal_name__c, GE_PRM_Address_line_1__c, GE_PRM_Address_line_2__c, GE_PRM_City__c, GE_PRM_Country__c, GE_PRM_Postal_code__c, GE_PRM_Channel_Appointment__c from Sub_Dealer__c where GE_PRM_Channel_Appointment__c in :CAIDs]);
            map<id,list<Sub_Dealer__c>> CASubdealerMap=new map<id,list<Sub_Dealer__c>>();
            for(id id1: CAIDs){
                list<Sub_Dealer__c> templstsd = new list<Sub_Dealer__c>();
                for(Sub_Dealer__c s : lstsubdealer){
                    if(s.GE_PRM_Channel_Appointment__c == id1){
                        templstsd.add(s);               
                    }           
                }
                CASubdealerMap.put(id1,templstsd);  
            }
         //Added for Req#R-23904
         Map<ID,GE_PRM_Channel_Appointment__c> caMapCommAcc = New Map<Id,GE_PRM_Channel_Appointment__c>(
         [Select Id, GE_PRM_Account_Name__r.Oil_Gas_Parent_Account__c From GE_PRM_Channel_Appointment__c Where ID IN: CAIDs]);
      
      
            for(GE_PRM_Channel_Appointment__c cpa :CPAlist1)
            {
                if(cntlst.isempty() &&!commline.isempty())
                {
                    system.debug('geeting account id'+cpa.GE_PRM_Account_Name__c);
                    Contract master=new  Contract();
                    master.RecordTypeId= contractRecordTypeMasterId ;
                    master.GE_PRM_Channel_Appointment_ID__c=cpa.id;
                    master.accountid = cpa.GE_PRM_Account_Name__c;
                    
                    //Added for Req#R-23904
                    System.debug('^^^^^^^^^ ACCOUNT ^^^^^^ 1 ' + caMapCommAcc);
                    master.GE_PRM_Commercial_Account__c = caMapCommAcc.Get(cpa.Id).GE_PRM_Account_Name__r.Oil_Gas_Parent_Account__c ;
                    
                    master.GE_PRM_Primary_Sales_Channel_Manager__c =cpa.GE_PRM_Primary_Sales_Channel_Manager__c;
                    system.debug('commid--->'+cpa.GE_PRM_Commercial_Manager__c);
                    master.GE_PRM_Commercial_Manager1__c=cpa.GE_PRM_Commercial_Manager__c;
                    master.GE_PRM_Tier_2__c=cpa.GE_PRM_Tier_2_P_L__c;
                    master.GE_PRM_Region__c=cpa.GE_PRM_O_G_Region__c;
                    master.StartDate =Date.today();
                    integer intterm = -1;
                    for(GE_PRM_Commercial_line__c c: commline){
                        if(c.GE_PRM_Channel_Appointment__c == cpa.id){
                            if(intterm < integer.valueof(c.GE_PRM_Term__c)){
                                intterm = integer.valueof(c.GE_PRM_Term__c);
                            }
                        }           
                    }
                    if(intterm != -1){    
                        master.ContractTerm = intterm;
                        master.GE_OG_Contract_End_Date__c = Date.today().addMonths(intterm);     
                    }
                    if(cpa.GE_PRM_Sell_to_Nuclear_industry__c=='Yes')
                        master.GE_PRM_Nuclear_sales__c=true;
                    if(cpa.GE_PRM_Sell_to_Military__c=='Yes')
                        master.GE_PRM_Military_sales__c=true;
                    if(cpa.GE_PRM_No_Of_Subdealers_Subsidary__c>0)
                        master.GE_PRM_Sub_dealer_agents__c=true;
                    if(cpa.GE_PRM_Account_Country__c=='BRAZIL')
                        master.GE_PRM_Brazil_Sales_Rep__c=true;
                    contractstoinsert.add(master);
                }
            } 
            for (GE_PRM_Commercial_line__c commlines1 :commline)
            {
                if(!commline.isempty() && commlines1.GE_PRM_contract_genrated__c==false)
                {
                    Contract addedum=new  Contract();
                    addedum.GE_PRM_ERP_Contact__c = commlines1.ERP_Contact__c;
                    addedum.GE_PRM_Commercial_line__c = commlines1.Id;
                    addedum.RecordTypeId=contractRecordTypeAddendumId;
                    addedum.AccountID=commlines1.GE_PRM_Channel_Appointment__r.GE_PRM_Account_Name__c;
                    
                    
                    //Added for Req#R-23904
                    System.debug('^^^^^^^^^ ACCOUNT ^^^^^^ 1 ' + commlines1.GE_PRM_Channel_Appointment__c);
                    
                    addedum.GE_PRM_Commercial_Account__c = caMapCommAcc.Get(commlines1.GE_PRM_Channel_Appointment__c).GE_PRM_Account_Name__r.Oil_Gas_Parent_Account__c ; 
                    
                    addedum.GE_ES_User_Lead_Sales_Person__c =commlines1.GE_PRM_Sales_Manager__c;
                    addedum.GE_PRM_Business_Tier_1__c = commlines1.GE_PRM_Tier_1__c;
                    addedum.GE_PRM_Tier_2__c =commlines1.GE_PRM_Tier_2__c;
                    addedum.GE_PRM_Tier_3__c= commlines1.GE_PRM_Tier_3__c;
                    addedum.GE_PRM_Tier_4__c =commlines1.GE_PRM_Tier_4__c;
                    addedum.GE_PRM_Tier_5__c= commlines1.GE_PRM_Tier_5__c;
                    addedum.GE_PRM_If_flat_Pricing__c= commlines1.GE_PRM_If_flat_Pricing__c;
                    addedum.GE_PRM_If_schedule_Max_Pricing__c= commlines1.GE_PRM_If_schedule_Max_Pricing__c;
                    addedum.GE_PRM_If_schedule_Min_Pricing__c= commlines1.GE_PRM_If_schedule_Min_Pricing__c;
                    addedum.GE_PRM_Industries__c= commlines1.GE_PRM_Industries__c;
                    addedum.GE_PRM_Buyers__c= commlines1.GE_PRM_Buyers__c;
                    addedum.GE_PRM_Channel_Appointment_ID__c=commlines1.GE_PRM_Channel_Appointment__r.id;
                    addedum.GE_PRM_Authorized_Country__c =commlines1.GE_PRM_Authorized_Countries_1__c + ';'+ commlines1.GE_PRM_Authorized_Countries_2__c;
                    addedum.GE_PRM_State_Province_Region__c =commlines1.GE_PRM_State_Province_Region__c;
                    addedum.GE_PRM_Pricing__c= commlines1.GE_PRM_Pricing__c;
                    addedum.GE_PRM_Pricing_type__c=commlines1.GE_PRM_Pricing_Type__c;
                    addedum.GE_PRM_Nuclear_use__c=commlines1.GE_PRM_Nuclear_use_Add_comment__c;
                    addedum.GE_PRM_Military_use__c =commlines1.GE_PRM_Military_use_Add_comment__c;
                    addedum.GE_PRM_If_Brazil_SR_SC_core__c= commlines1.GE_PRM_Channel_Appointment__r.GE_PRM_If_Brazil_SR_SC_Core__c;
                    addedum.GE_PRM_If_Brazil_SR_CMPJ__c=commlines1.GE_PRM_Channel_Appointment__r.GE_PRM_If_Brazil_SR_CMPJ__c;
                    addedum.GE_PRM_Inclusions_exclusions__c = commlines1.GE_PRM_Inclusions_exclusions_Add_comment__c;
                    addedum.GE_PRM_If_SR_sales_to_US_government__c =commlines1.GE_PRIf_Sales_Rep_sales_to_US_Government__c;
                    addedum.GE_PRM_Comments__c =commlines1.GE_PRM_if_Yes_provide_comments_SlaesRep__c;
                    addedum.GE_PRM_Commercial_Manager1__c=commlines1.GE_PRM_Channel_Appointment__r.GE_PRM_Commercial_Manager__c;
                    addedum.GE_PRM_Relationship_Type__c=commlines1.GE_PRM_Type__c;
                    addedum.StartDate =Date.today();
                    addedum.ContractTerm = integer.valueof(commlines1.GE_PRM_Term__c);
                    if(commlines1.GE_PRM_Term__c!=null)
                        addedum.GE_OG_Contract_End_Date__c = addedum.StartDate.addmonths(integer.valueof(commlines1.GE_PRM_Term__c));
                    if(commlines1.GE_PRM_Inclusions_exclusions_Add_comment__c =='yes')
                    {
                        addedum.GE_PRM_Limitations_exclusions__c=true;
                    }
                    else if(commlines1.GE_PRM_Inclusions_exclusions_Add_comment__c =='no')
                    {
                        addedum.GE_PRM_Limitations_exclusions__c=false;
                    }
                    if(commlines1.GE_PRM_Any_Exclusions__c=='yes')
                    {
                        addedum.GE_PRM_Exclusions__c=true;
                    }
                    else if(commlines1.GE_PRM_Any_Exclusions__c=='no')
                    {
                        addedum.GE_PRM_Exclusions__c=false;
                    }
                    /*
                    //GE_PRM_Channel_use_of_Sub_ACSs__c=
                    if(lstsubdealer .size()>0)
                    {
                        if(CASubdealerMap.get(commlines1.GE_PRM_Channel_Appointment__r.id).size() > 0){
                            addedum.GE_PRM_Sub_Channel_Address__c = CASubdealerMap.get(commlines1.GE_PRM_Channel_Appointment__r.id)[0].GE_PRM_Address_line_1__c +
                                CASubdealerMap.get(commlines1.GE_PRM_Channel_Appointment__r.id)[0].GE_PRM_Address_line_2__c ;
                            
                            addedum.GE_PRM_Sub_Channel_Legal_Entity_Name__c = CASubdealerMap.get(commlines1.GE_PRM_Channel_Appointment__r.id)[0].GE_PRM_Legal_name__c;
                        }
                    }*/
                    addedum.GE_PRM_Primary_Sales_Channel_Manager__c =commlines1.GE_PRM_Channel_Appointment__r.GE_PRM_Primary_Sales_Channel_Manager__c;
                    addedum.GE_PRM_Region__c =commlines1.GE_PRM_Channel_Appointment__r.GE_PRM_O_G_Region__c;
                    contractstoinsert.add(addedum);
                    commlines1.GE_PRM_contract_genrated__c=true;
                    updatingcommlines.add(commlines1);
                }
                
                if(!commline.isempty() && commlines1.GE_PRM_contract_genrated__c==true)
                {
                    //Contract addedum=new  Contract();
                    for(contract con:updatecon)
                    {
                        if(commlines1.id==con.GE_PRM_Commercial_line__c)
                        {
                                con.GE_PRM_ERP_Contact__c = commlines1.ERP_Contact__c;
                                con.GE_PRM_Comments__c=commlines1.GE_PRM_if_Yes_provide_comments_SlaesRep__c;
                                con.GE_ES_User_Lead_Sales_Person__c =commlines1.GE_PRM_Sales_Manager__c;
                                con.GE_PRM_Business_Tier_1__c = commlines1.GE_PRM_Tier_1__c;
                                con.GE_PRM_Tier_2__c =commlines1.GE_PRM_Tier_2__c;
                                con.GE_PRM_Tier_3__c= commlines1.GE_PRM_Tier_3__c;
                                con.GE_PRM_Tier_4__c =commlines1.GE_PRM_Tier_4__c;
                                con.GE_PRM_Tier_5__c= commlines1.GE_PRM_Tier_5__c;
                                con.GE_PRM_If_flat_Pricing__c= commlines1.GE_PRM_If_flat_Pricing__c;
                                con.GE_PRM_If_schedule_Max_Pricing__c= commlines1.GE_PRM_If_schedule_Max_Pricing__c;
                                con.GE_PRM_If_schedule_Min_Pricing__c= commlines1.GE_PRM_If_schedule_Min_Pricing__c;
                                con.GE_PRM_Industries__c= commlines1.GE_PRM_Industries__c;
                                con.GE_PRM_Buyers__c= commlines1.GE_PRM_Buyers__c;
                                con.GE_PRM_Authorized_Country__c =commlines1.GE_PRM_Authorized_Countries_1__c + ';'+ commlines1.GE_PRM_Authorized_Countries_2__c;
                                con.GE_PRM_State_Province_Region__c =commlines1.GE_PRM_State_Province_Region__c;
                                con.GE_PRM_Pricing__c= commlines1.GE_PRM_Pricing__c;
                                con.GE_PRM_Pricing_type__c=commlines1.GE_PRM_Pricing_Type__c;
                                con.GE_PRM_Nuclear_use__c=commlines1.GE_PRM_Nuclear_use_Add_comment__c;
                                con.GE_PRM_Military_use__c =commlines1.GE_PRM_Military_use_Add_comment__c;
                                con.GE_PRM_If_Brazil_SR_SC_core__c= commlines1.GE_PRM_Channel_Appointment__r.GE_PRM_If_Brazil_SR_SC_Core__c;
                                con.GE_PRM_If_Brazil_SR_CMPJ__c=commlines1.GE_PRM_Channel_Appointment__r.GE_PRM_If_Brazil_SR_CMPJ__c;
                                con.GE_PRM_Inclusions_exclusions__c = commlines1.GE_PRM_Inclusions_exclusions_Add_comment__c;
                                con.GE_PRM_If_SR_sales_to_US_government__c =commlines1.GE_PRIf_Sales_Rep_sales_to_US_Government__c;
                                con.GE_PRM_Comments__c =commlines1.GE_PRM_if_Yes_provide_comments_SlaesRep__c;
                                con.GE_PRM_Relationship_Type__c=commlines1.GE_PRM_Type__c;
                                con.ContractTerm = integer.valueof(commlines1.GE_PRM_Term__c);
                                if(commlines1.GE_PRM_Inclusions_exclusions_Add_comment__c =='yes')
                                {
                                    con.GE_PRM_Limitations_exclusions__c=true;
                                }
                                else if(commlines1.GE_PRM_Inclusions_exclusions_Add_comment__c =='no')
                                {
                                    con.GE_PRM_Limitations_exclusions__c=false;
                                }
                                if(commlines1.GE_PRM_Any_Exclusions__c=='yes')
                                {
                                    con.GE_PRM_Exclusions__c=true;
                                }
                                else if(commlines1.GE_PRM_Any_Exclusions__c=='no')
                                {
                                    con.GE_PRM_Exclusions__c=false;
                                }
                                updatecontract.add(con);
                                commlines1.GE_PRM_IsCommercialUpdatedCL__c=false;
                               // updatingcommlines1.add(commlines1);
                                MapUpdatingcommlines1.put(commlines1.Id,commlines1);
                           
                        }
                    }
                }
            } 
            if(contractstoinsert.size()>0){
                
                    insert contractstoinsert;
                    system.debug('insertion list ids------->'+contractstoinsert);
                    for(Contract con: [Select Id,GE_PRM_Master_Agreement__c,RecordType.Name,GE_PRM_Channel_Appointment_ID__c,ContractNumber from Contract where Id IN: contractstoinsert]){ 
                        if(con.RecordType.Name=='Channel Master Agreement')
                            conmasterrecidmap.put(con.GE_PRM_Channel_Appointment_ID__c,con.id);
                        system.debug('mapping------>'+conmasterrecidmap);
                        if (contractmap.containsKey(con.GE_PRM_Channel_Appointment_ID__c))
                            contractmap.get(con.GE_PRM_Channel_Appointment_ID__c). add(con);
                        else
                            contractmap.put(con.GE_PRM_Channel_Appointment_ID__c,new list <Contract> { con }); 
                    }
                
                if(!contractmap.IsEmpty()){
                    for(Id caid:contractmap.KeySet()){
                        system.debug('id------1111'+caid);
                        for(Contract con:contractmap.get(caid)){
                            if(con.RecordType.Name=='Channel Addendum Agreement'){
                                Masterid.add(conmasterrecidmap.get(caid));
                                system.debug('id------------>'+conmasterrecidmap.get(caid));
                                if(!conmasterrecidmap.IsEmpty())
                                    con.GE_PRM_Master_Agreement__c=conmasterrecidmap.get(caid);
                                else
                                    con.GE_PRM_Master_Agreement__c=cntlst[0].id;
                                system.debug('updated list '+con.GE_PRM_Master_Agreement__c);
                                contractstoupdate.add(con);
                            }
                        }
                    }
                } 
            }
            if(updatecontract.size()>0)
            {
                checkRecursive.Var_bypasstrigger=false;
                System.debug('%%%%%%%%%%%%updatecontract%%%%%%%%%%%%%%'+updatecontract);
                update updatecontract;
            }
            if(contractstoupdate.size()>0){
                checkRecursive.Var_bypasstrigger=false;
                System.debug('%%%%%%%%%%%%contractstoupdate%%%%%%%%%%%%%%'+contractstoupdate);
                update contractstoupdate;
             }
            if(updatingcommlines.size()>0)
            {
                System.debug('%%%%%%%%%%%%updatingcommlines%%%%%%%%%%%%%%'+updatingcommlines);
                update updatingcommlines;
            }
            System.debug('%%%%%%%%%%%%MapUpdatingcommlines1%%%%%%%%%%%%%%'+MapUpdatingcommlines1);
            if(!MapUpdatingcommlines1.isEmpty())
            {
                System.debug('%%%%%%%%%%%%MapUpdatingcommlines1%%%%%%%%%%%%%%'+MapUpdatingcommlines1);
                update MapUpdatingcommlines1.values();
            }
            
            //** Updating old appointment status to archived when renewing channel appt is approved
            if (!GE_PRM_TriggerhelperClass.getarchiveoldchappt()){
                system.debug('***----Iteration----***');
                list<id> lstIdtobeArchived = new list<id>();
                list<GE_PRM_Channel_Appointment__c> lstarchivedchappt = new list<GE_PRM_Channel_Appointment__c>();
            for(GE_PRM_Channel_Appointment__c chappt : CPAlist1){
                if(chappt.GE_PRM_Old_Channel_Appointment__c != null){
                  lstIdtobeArchived.add(chappt.GE_PRM_Old_Channel_Appointment__c);  
                }                
            }
            System.debug('%%%%%%%%%%%%lstIdtobeArchived%%%%%%%%%%%%%%'+lstIdtobeArchived);
                if(lstIdtobeArchived.size() > 0){    
            lstarchivedchappt = [select GE_PRM_Current_Status__c from GE_PRM_Channel_Appointment__c where id IN :lstIdtobeArchived ];    
            for(GE_PRM_Channel_Appointment__c chapptarchived : lstarchivedchappt){
               chapptarchived.GE_PRM_Current_Status__c = 'Archived';
            }
            System.debug('%%%%%%%%%%%%lstarchivedchappt%%%%%%%%%%%%%%'+lstarchivedchappt);
            Update lstarchivedchappt;
            }
            GE_PRM_TriggerhelperClass.setarchiveoldchappt();    
            }
            
            
            
        }
        //Logic for Channel appointmnet expiry date
        List<contract> contractenddate =new list<contract>();
        List<GE_PRM_Channel_Appointment__c> updatelist =new list<GE_PRM_Channel_Appointment__c>();
        if(Masterid.size()>0)
        {
            contractenddate =[select id,GE_PRM_Channel_Appointment_ID__c,GE_OG_Contract_End_Date__c from Contract where ID in :Masterid] ;
        }
         System.debug('%%%%%%%%%%%%contractenddate %%%%%%%%%%%%%%'+contractenddate);
        if(contractenddate.size()>0)
        {
            updatelist =[select id ,GE_PRM_Expirydate1__c from GE_PRM_Channel_Appointment__c where id =:contractenddate[0].GE_PRM_Channel_Appointment_ID__c];
            updatelist[0].GE_PRM_Expirydate1__c =contractenddate[0].GE_OG_Contract_End_Date__c ;
            update updatelist[0];
        }
        System.debug('%%%%%%%%%%%%updatelist%%%%%%%%%%%%%%'+updatelist);
    }
    //** logic to update contract status when channel appointment status is changed to terminated or nonrenewed    
    /*
    Public Void updatecontract(GE_PRM_Channel_Appointment__c chappt)
    {
        String contractRecordTypeMasterId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Channel Master Agreement').getRecordTypeId();
        contract con = [select Status from contract where GE_PRM_Channel_Appointment_ID__c =: chappt.id and RecordTypeId =: contractRecordTypeMasterId ];
        GE_PRM_Channel_Appointment__c ch = [select GE_PRM_Current_Status__c from GE_PRM_Channel_Appointment__c where id =: chappt.id];
        if(ch.GE_PRM_Current_Status__c == 'Terminated' || ch.GE_PRM_Current_Status__c == 'Non-Renewed' ){
            con.Status = ch.GE_PRM_Current_Status__c;
        }
       // update con;    
    }
    */
    //
    Public Void updatecontract1(list<GE_PRM_Channel_Appointment__c> lstchappt)
    {
        list<id> lstTerminationId = new list<id>();
        list<id> lstNonRenewId = new list<id>();
        list<contract> lstTerminationContract = new list<contract>();
        list<contract> lstNonRenewContract = new list<contract>();    
        for(GE_PRM_Channel_Appointment__c ch:lstchappt){
           if(ch.GE_PRM_Current_Status__c == 'Terminated'){
           lstTerminationId.add(ch.Id);
           }
           if(ch.GE_PRM_Current_Status__c == 'Non-Renewed'){
           lstNonRenewId.add(ch.Id);
           }
           }
        
        String contractRecordTypeMasterId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Channel Master Agreement').getRecordTypeId();
        if(lstTerminationId.size()>0){
        lstTerminationContract = [select Status from contract where GE_PRM_Channel_Appointment_ID__c IN : lstTerminationId and RecordTypeId =: contractRecordTypeMasterId ];    
        }
        if(lstNonRenewId.size()>0){
        lstNonRenewContract = [select Status from contract where GE_PRM_Channel_Appointment_ID__c IN : lstNonRenewId and RecordTypeId =: contractRecordTypeMasterId ];    
        }
        if(lstTerminationContract.size()>0){
        for(contract c: lstTerminationContract){
         c.status = 'Terminated';   
        }
        }
        if(lstNonRenewContract.size()>0){
        for(contract c: lstNonRenewContract){
         c.status = 'Non-Renewed';   
        }
        }
        list<contract> lstcon = new list<contract>();
        if(lstTerminationContract.size()>0)
        lstcon.addAll(lstTerminationContract);
        if(lstNonRenewContract.size()>0)
        lstcon.addAll(lstNonRenewContract);
        if(lstcon.size()>0)
        Update lstcon;
             
    }
    
    //
    
    
}