/*
Trigger Name: GE_PRM_CustomContractCreateEditDelete
Used in : 
Purpose/Overview : When a user Insert or Update or Delete Standard Contract records, the trigger will do same operation on Custom contract object (Object API Name: GE_ES_Contracts__c) using an external Id (Field API Name: GE_ES_Contract_Id__c)
Functional Area : PRM
Author: Ramakrishna Kolluri 
Date: 12-Jun-2012
Release: Jerry Release 
Test Class Name / Test Method Name: Test_GE_PRM_Strategy / Test_GE_PRM_CustomContractCreateEditDelete_Trigger_Method()
Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
12/2/2014       Pradeep Rao Yadagiri  Added Record type condition
*/
trigger GE_PRM_CustomContractCreateEditDelete on Contract (before insert,before update,after insert, after update, before delete) {
    
    
    OG_Trigger_fire_Decision__c lstObj = OG_Trigger_fire_Decision__c.getValues('GE_PRM_CustomContractCreateEditDelete');
    
    if(lstObj!=null && lstObj.isActive__c == true && lstObj.Object_Name__c=='Contract'){
        
        return;  
    }
    else{
        //Code to update Account Hierarchy Once Contract is Executed
        //-commented below lines by Kiru(6-feb-20). this is old code
        /**  if (Trigger.isAfter) 
{

GE_PRM_Contract_Trigger_Handler cc= new GE_PRM_Contract_Trigger_Handler();  
if(Trigger.isUpdate)
{
System.debug('===I m in after update====');
cc.activeInactiveOnTerminate(Trigger.New,trigger.oldmap);
cc.update_acc_hier(Trigger.New,trigger.oldmap);
}
} 
if(trigger.isBefore && Trigger.isDelete)
{
GE_PRM_Contract_Trigger_Handler cc= new GE_PRM_Contract_Trigger_Handler ();
cc.update_acc_hier_OnDelete(Trigger.old);
}

**/
        
        //To check Trigger fired once
        if(CheckRecursion_GE_OG.runOnce())
        {
            String contractRecordTypeMasterId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Channel Master Agreement').getRecordTypeId();
            String contractRecordTypeAddedumId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Channel Addendum Agreement').getRecordTypeId();    
            
            //Code added for Creation of agreements coming from Channel appointmnet.
            /*  if(Trigger.isInsert)
{

String AgreementRecordTypeMasterId = Schema.SObjectType.Apttus__APTS_Agreement__c.getRecordTypeInfosByName().get('Channel Master Agreement').getRecordTypeId();
String AgreementRecordTypeAddumId = Schema.SObjectType.Apttus__APTS_Agreement__c.getRecordTypeInfosByName().get('Channel Addendum Agreement').getRecordTypeId();
map<String,String> fieldmapping=new map<String,String>();
map<String,String> fieldmappingaddedum=new map<String,String>();
list<sobject> agreementlist=new list<sobject>();
map<id,list< Apttus__APTS_Agreement__c>>  Agreementmap=new map<id,list< Apttus__APTS_Agreement__c>>();
map<id,id> conmasterrecidmap=new map<id,id>();

list<Apttus__APTS_Agreement__c> Agreementtoupdate=new list<Apttus__APTS_Agreement__c>();
for(GE_PRM_Master_contract_agreemnet_Mapping__c i :GE_PRM_Master_contract_agreemnet_Mapping__c.getAll().values())
{
fieldmapping.put(i.Target_Field_API__c,i.SourceFieldAPi__c);
}

for(GE_PRM_Adddum_contract__c C :GE_PRM_Adddum_contract__c.getAll().values())
{
fieldmappingaddedum.put(c.Target_Field_API__c,C.Source_Field_API__c);
}
for(Contract C :Trigger.New)
{
if(c.RecordtypeID ==contractRecordTypeMasterId )
{
Apttus__APTS_Agreement__c Agreement =new Apttus__APTS_Agreement__c();
Agreement.recordtypeid=AgreementRecordTypeMasterId;
Agreement.Name='Master Agreement';
sobject cont=C;
for(String ss:fieldmapping.keyset())
{             
Agreement.put(ss,cont.get(fieldmapping.get(ss))); 
system.debug('mastermap----'+Agreement);        
}
agreementlist.add(Agreement);
system.debug('master agreement -----'+ agreementlist); 
} 
if(c.RecordtypeID ==contractRecordTypeAddedumId)
{
Apttus__APTS_Agreement__c Agreement1 = new Apttus__APTS_Agreement__c();
Agreement1.RecordtypeID =AgreementRecordTypeAddumId ;
Agreement1.Name='Addedum Agreement';
sobject cont1=C;
for(String  Addedum :fieldmappingaddedum.keyset())
{
Agreement1.put(Addedum,cont1.get(fieldmappingaddedum.get(Addedum))); 
}
agreementlist.add(Agreement1);
} 
}
if( agreementlist.size()>0)
{
insert agreementlist;
}
if( agreementlist.size()>0){
list<id> lstcpaid = new list<id>();
list<id> lstcpaid1 = new list<id>();
for(sobject a:agreementlist){
Apttus__APTS_Agreement__c b = (Apttus__APTS_Agreement__c )a;
lstcpaid1.add(b.GE_PRM_Channel_Appointment_ID__c);
}


for(id id1 : lstcpaid1){
if(string.valueOf(id1) != null && string.valueOf(id1) != ''){
lstcpaid.add(id1);
}  
}
list<Apttus__APTS_Agreement__c> lstmasteragr = [select GE_PRM_Channel_Appointment_ID__c, Apttus__Parent_Agreement__c from Apttus__APTS_Agreement__c where GE_PRM_Channel_Appointment_ID__c in :lstcpaid and recordtypeid =: AgreementRecordTypeMasterId ];

list<Apttus__APTS_Agreement__c> lstaddagr = [select GE_PRM_Channel_Appointment_ID__c, Apttus__Parent_Agreement__c from Apttus__APTS_Agreement__c where GE_PRM_Channel_Appointment_ID__c in :lstcpaid and recordtypeid =: AgreementRecordTypeAddumId];
if(!(lstmasteragr.size() > 0)){
//delete lstmasteragr;
delete lstaddagr ;
}
else{
for(Apttus__APTS_Agreement__c m : lstmasteragr ){
if(lstaddagr.size()>0)
for(Apttus__APTS_Agreement__c a : lstaddagr ){
if(m.GE_PRM_Channel_Appointment_ID__c == a.GE_PRM_Channel_Appointment_ID__c){
a.Apttus__Parent_Agreement__c = m.id;
}
}
}
update lstaddagr; 
}
}

/*

if(!Agreementmap.IsEmpty()){
list<Apttus__APTS_Agreement__c> s = new list<Apttus__APTS_Agreement__c> (); 
s=  [Select Id from Apttus__APTS_Agreement__c where GE_PRM_Channel_Appointment_ID__c =:conmasterrecidmap.keyset()  and RecordType.Name='Channel Master Agreement'];  
for(Id caid:Agreementmap.KeySet()){
for(Apttus__APTS_Agreement__c con:Agreementmap.get(caid)){
if(con.RecordType.Name=='Channel Addendum Agreement'){
system.debug('map----->'+conmasterrecidmap +'            '+Agreementmap+'          '+caid);
//Apttus__APTS_Agreement__c s=  [Select Id from Apttus__APTS_Agreement__c where GE_PRM_Channel_Appointment_ID__c =:conmasterrecidmap.keyset()  and RecordType.Name='Channel Master Agreement']; 
if(s.size() > 0){
if(string.valueof(s[0].id) != '' || string.valueof(s[0].id) != null){
con.Apttus__Parent_Agreement__c=s[0].id;
}
}
Agreementtoupdate.add(con);
}
}
}
}
if(Agreementtoupdate.size() >0)  
update Agreementtoupdate; 
list<id> lstcpaid = new list<id>();
for(Apttus__APTS_Agreement__c a :Agreementtoupdate){
lstcpaid.add(a.GE_PRM_Channel_Appointment_ID__c);
}
list<Apttus__APTS_Agreement__c> lstagreement = [select Apttus__Parent_Agreement__c,GE_PRM_Channel_Appointment_ID__c   from Apttus__APTS_Agreement__c where Apttus__Parent_Agreement__c = null and GE_PRM_Channel_Appointment_ID__c in :lstcpaid and recordtypeid =: AgreementRecordTypeAddumId  ];
delete lstagreement; 
*/      
            /*  } */
            
            
            //Code to update commercial line status to Terminated or Non-Renewed based on the associated Contract's status.
            if(Trigger.isUpdate || Trigger.isInsert){
                if (Trigger.isAfter) {
                    List<Contract> conlist = new List<Contract>();
                    List<Contract> execConlist = new List<Contract>();
                    List<Contract> exeAmmendList = new List<Contract>();
                    List<Contract> archivedConlist = new List<Contract>();
                    List<Id> accountList = new List<Id>();
                    list<id> lstaccid = new list<id>();
                    list<id> lstaddmaccid = new list<id>();
                    list<id> lstaccexecutedid = new list<id>();
                    Map<Id,Contract> memOfMap = new Map<Id,Contract>();
                    Map<Id,Contract> commAccMap = new Map<Id,Contract>();
                    //contractRecordTypeMasterId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Channel Master Agreement').getRecordTypeId();
                    // contractRecordTypeAddedumId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Channel Addendum Agreement').getRecordTypeId();
                    String prmAddendumId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('PRM Addendum').getRecordTypeId(); 
                    String prmAmmendId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('PRM Amendment').getRecordTypeId();     
                    for(Contract conObj: Trigger.new){
                        //** when contract status is executed
                        /*  if(conObj.Status == 'Executed' && conObj.RecordTypeId == contractRecordTypeMasterId){
lstaccexecutedid.add(conObj.AccountId); 
} */
                        if(Trigger.isUpdate && conObj.Status != Trigger.oldMap.get(conObj.Id).Status && conObj.Status == 'Executed' && conObj.RecordTypeId == prmAmmendId)
                        {
                            exeAmmendList.add(conObj);
                        } 
                        if(Trigger.isUpdate && conObj.Status != Trigger.oldMap.get(conObj.Id).Status &&( conObj.Status == 'Executed' || conObj.Status == 'Under Renewal' || conObj.Status == 'Under NR/T' )&& conObj.RecordTypeId == prmAddendumId)
                        {
                            execConlist.add(conObj);
                            if(conObj.GE_Commercial_Member_Of_GE_OG__c != null )
                            {
                                
                                accountList.add(conObj.GE_Commercial_Member_Of_GE_OG__c);
                                
                            }
                            if(conObj.GE_PRM_Commercial_Account__c != null)
                            {
                                
                                accountList.add(conObj.GE_PRM_Commercial_Account__c);
                            }
                            
                        }
                        if(conObj.Status == 'Archived' && conObj.RecordTypeId == prmAddendumId)
                        {
                            archivedConlist.add(conObj);
                            
                            if(conObj.GE_Commercial_Member_Of_GE_OG__c != null )
                            {
                                memOfMap.put(conObj.GE_Commercial_Member_Of_GE_OG__c,conObj);
                                //accountList.add(conObj.GE_Commercial_Member_Of_GE_OG__c);
                            }
                            commAccMap.put(conObj.AccountId,conObj);
                            
                            
                        }
                        System.debug('qqqqqqterminated status'+conObj.Status);
                        //** When contract status is Terminated or Executed
                        /**if(conObj.Status == 'Terminated' || conobj.Status == 'Non-Renewed')
{
Contract cont =new Contract();
if(conObj.RecordTypeId == contractRecordTypeMasterId || conObj.RecordTypeId == contractRecordTypeAddedumId ){
conlist.add(conObj);
if(conObj.AccountId != null)
lstaddmaccid.add(conObj.AccountId);
}
if(conObj.RecordTypeId == contractRecordTypeMasterId){
lstaccid.add(conObj.AccountId);
}
} */
                    }
                    system.debug('**contracts'+conlist);
                    system.debug('**AMMEND'+exeAmmendList);
                    system.debug('**EXECUTED---->'+execConlist);
                    system.debug('**ARCHIVED---->'+archivedConlist);
                    if(!execConlist.isEmpty())
                    {
                        PRM_ContractStatus.passID(execConlist);
                        GE_PRM_Contract_Trigger_Handler.handlePRMExecutedContracts(execConlist,accountList);
                    }
                    if(!exeAmmendList.isEmpty())
                    {
                        PRM_ContractStatus.passID(exeAmmendList);
                        //GE_PRM_Contract_Trigger_Handler.handlePRMExecutedContracts(execConlist,accountList);
                    }
                    if(!archivedConlist.isEmpty())
                    {
                       GE_PRM_Contract_Trigger_Handler.handlePRMArchivedContracts(memOfMap,commAccMap);
                    }
                    
                    
                    //Commented by Kiru (06-Feb-20) as it refers to old PRM objects
                    
                    //            list<GE_PRM_Commercial_line__c> lsttotalcommline = new list<GE_PRM_Commercial_line__c>();
                    //   list<GE_PRM_Commercial_line__c> lsttotalupdatingcommline = new list<GE_PRM_Commercial_line__c>();
                    //   lsttotalcommline = [select id,name,GE_PRM_Type__c,GE_PRM_Status__c,GE_PRM_Tier_1__c, GE_PRM_Tier_2__c,GE_PRM_Tier_3__c,GE_PRM_Tier_4__c,GE_PRM_Channel_Appointment__r.GE_PRM_Account_Name__c,GE_PRM_Channel_Appointment__c  from GE_PRM_Commercial_line__c where GE_PRM_Channel_Appointment__r.GE_PRM_Account_Name__c IN : lstaddmaccid];
                    /***
for(Contract c : conlist)
{
//** Updating Commerciallines Status
//
for(GE_PRM_Commercial_line__c comm : lsttotalcommline){
IF(comm.GE_PRM_Tier_1__c == c.GE_PRM_Business_Tier_1__c 
&& comm.GE_PRM_Tier_2__c==c.GE_PRM_Tier_2__c 
&& comm.GE_PRM_Tier_3__c ==c.GE_PRM_Tier_3__c 
&& comm.GE_PRM_Tier_4__c ==c.GE_PRM_Tier_4__c
&& comm.GE_PRM_Channel_Appointment__r.GE_PRM_Account_Name__c == c.AccountID 
&& comm.GE_PRM_Channel_Appointment__c  == c.GE_PRM_Channel_Appointment_ID__c
&& comm.GE_PRM_Status__c == 'Under NR/T'
&& comm.GE_PRM_Type__c == c.GE_PRM_Relationship_Type__c
)
{
comm.GE_PRM_Status__c = c.Status; 
lsttotalupdatingcommline.add(comm);   
}
}
/*list<GE_PRM_Commercial_line__c> lstcommline =[select id,name,GE_PRM_Status__c from GE_PRM_Commercial_line__c where GE_PRM_Tier_1__c =: c.GE_PRM_Business_Tier_1__c AND GE_PRM_Tier_2__c=:c.GE_PRM_Tier_2__c AND GE_PRM_Tier_3__c =:c.GE_PRM_Tier_3__c AND GE_PRM_Tier_4__c =:c.GE_PRM_Tier_4__c
AND GE_PRM_Channel_Appointment__r.GE_PRM_Account_Name__c =: c.AccountID AND GE_PRM_Channel_Appointment__c  =: c.GE_PRM_Channel_Appointment_ID__c LIMIT 1];
if(lstcommline.size() > 0)
if(lstcommline[0].GE_PRM_Status__c == 'Under NR/T')
{
lstcommline[0].GE_PRM_Status__c = c.Status;    
update lstcommline;
}
*/
                    //  }
                    //  Update lsttotalupdatingcommline;
                    
                    //** Updating isParner field on Account if there is any other active master contract(status = executed)
                    /**    list<account> lstmasteracc = new list<account>();
list<account> lstmasterexecutedacc = new list<account>();

lstmasterexecutedacc = [select IsPartner ,GE_HQ_Channel_Representative__c , GE_PRM_Channel_Type__c from account where id in :lstaccexecutedid ];
for(account acc : lstmasterexecutedacc){
acc.IsPartner = True; 
acc.GE_HQ_Channel_Representative__c = 'Yes';
acc.GE_PRM_Channel_Type__c = '';
}
Update lstmasterexecutedacc;

lstmasteracc = [select IsPartner, GE_HQ_Channel_Representative__c ,  (select status from Contracts where status = 'Executed' AND RecordTypeId =: contractRecordTypeMasterId) from account where id IN :lstaccid];
for(account acc : lstmasteracc){
system.debug('**Contracts'+acc.Contracts);
if(acc.Contracts.size() > 0){
acc.IsPartner = True; 
acc.GE_HQ_Channel_Representative__c = 'Yes';
acc.GE_PRM_Channel_Type__c = '';
} 
else{
acc.IsPartner = False; 
acc.GE_HQ_Channel_Representative__c = 'No';
}
}
Update lstmasteracc;
//**
}
}
//Code to update Commline date field
if(Trigger.isUpdate || Trigger.isInsert){
if (Trigger.isAfter) {
List<Contract> conlist = new List<Contract>();
list<id> lstaccid = new list<id>();
list<id> lstaccexecutedid = new list<id>();
// contractRecordTypeMasterId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Channel Master Agreement').getRecordTypeId();
// contractRecordTypeAddedumId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Channel Addendum Agreement').getRecordTypeId();
list<id> lstaccidd = new list<id>();

for(Contract conObj: Trigger.new){
system.debug(conObj.GE_PRM_Channel_Appointment_ID__c);
if(conObj.GE_PRM_Channel_Appointment_ID__c != null){                                
if(conObj.recordtypeid == contractRecordTypeMasterId || conobj.RecordTypeId == contractRecordTypeAddedumId)
conlist.add(conObj);
lstaccidd.add(conObj.AccountId);
}
}
//commented by Kiru (o6-Feb-2020) as the below refers to old object
/***
list<GE_PRM_Commercial_line__c> lsttotalcommlinee = new list<GE_PRM_Commercial_line__c>();
list<GE_PRM_Commercial_line__c> lsttotalupdatingcommlinee = new list<GE_PRM_Commercial_line__c>();
lsttotalcommlinee = [select id,name,GE_PRM_Type__c ,GE_PRM_Status__c,GE_PRM_Tier_1__c, GE_PRM_Tier_2__c,GE_PRM_Tier_3__c,GE_PRM_Tier_4__c,GE_PRM_Channel_Appointment__r.GE_PRM_Account_Name__c,GE_PRM_Channel_Appointment__c  from GE_PRM_Commercial_line__c where GE_PRM_Channel_Appointment__r.GE_PRM_Account_Name__c IN : lstaccidd];


if(conlist.size()>0)       
for(Contract c : conlist)
{
if(c.RecordTypeId==contractRecordTypeAddedumId)
{
//** Updating Commercialline's end date
//
for(GE_PRM_Commercial_line__c comm : lsttotalcommlinee){
IF(comm.GE_PRM_Tier_1__c == c.GE_PRM_Business_Tier_1__c 
&& comm.GE_PRM_Tier_2__c==c.GE_PRM_Tier_2__c 
&& comm.GE_PRM_Tier_3__c ==c.GE_PRM_Tier_3__c 
&& comm.GE_PRM_Tier_4__c ==c.GE_PRM_Tier_4__c
&& comm.GE_PRM_Channel_Appointment__r.GE_PRM_Account_Name__c == c.AccountID 
&& comm.GE_PRM_Channel_Appointment__c  == c.GE_PRM_Channel_Appointment_ID__c
&& comm.GE_PRM_Type__c == c.GE_PRM_Relationship_Type__c
// && comm.GE_PRM_Status__c == 'Under NR/T'
)
{
comm.GE_PRM_Relationship_expiry_date__c = c.GE_OG_Contract_End_Date__c; 
lsttotalupdatingcommlinee.add(comm);   
}
}

list<GE_PRM_Commercial_line__c> lstcommline =[select id,name,GE_PRM_Relationship_expiry_date__c,GE_PRM_Status__c from GE_PRM_Commercial_line__c where GE_PRM_Tier_1__c =: c.GE_PRM_Business_Tier_1__c AND GE_PRM_Tier_2__c=:c.GE_PRM_Tier_2__c AND GE_PRM_Tier_3__c =:c.GE_PRM_Tier_3__c AND GE_PRM_Tier_4__c =:c.GE_PRM_Tier_4__c
AND GE_PRM_Channel_Appointment__r.GE_PRM_Account_Name__c =: c.AccountID AND GE_PRM_Channel_Appointment__c  =: c.GE_PRM_Channel_Appointment_ID__c LIMIT 1];
if(lstcommline.size() > 0)
{
lstcommline[0].GE_PRM_Relationship_expiry_date__c = c.GE_OG_Contract_End_Date__c;    
update lstcommline;
}

}
} **/
                    //Update lsttotalupdatingcommlinee; 
                    /***  list<GE_PRM_Commercial_line__c> lstcommer = new list<GE_PRM_Commercial_line__c>();
if(lsttotalupdatingcommlinee.size()>0)
for(GE_PRM_Commercial_line__c comm : lsttotalupdatingcommlinee){
if(lstcommer.size()>0){
boolean duplicate = false;
for(GE_PRM_Commercial_line__c comm1 : lstcommer){
if(comm.id == comm1.id){
duplicate = true;
}  
} 
if(duplicate == true){

}
else{
lstcommer.add(comm);  
}

}
else{
lstcommer.add(comm);   
}
} 
if(lstcommer.size()>0)
update lstcommer; **/
                }
            }
            //Commented Old contract code : Joydeep
            // system.debug('Trigger.isUpdate===isAfter====='+Trigger.isUpdate+'=='+trigger.isAfter);
            //system.debug('GE_PRM_TriggerhelperClass.getarchiveold()========='+GE_PRM_TriggerhelperClass.getarchiveold());
            /*  if (!GE_PRM_TriggerhelperClass.getarchiveold() || Test.IsrunningTest()){
/*
Sunayana : 14 Aug 2016 Commented code for Archiving
//** changing status of old appointment contracts to Archived when current contract status is Executed
if(Trigger.isUpdate && Trigger.isAfter){

boolean isStatusChanged= false;
for(Contract c : trigger.new)
{
if(c.status =='Executed' && trigger.oldmap.get(c.id).status != c.status)
isStatusChanged= true;
}
if(isStatusChanged== false)
return;

system.debug('**---Contracts After Update----**'+Trigger.New);
list<contract> lstexecutedmaster = new list<contract>();
list<contract> lstexecutedaddedum = new list<contract>();
list<contract> lstArchivingContract = new list<contract>();
//contractRecordTypeMasterId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Channel Master Agreement').getRecordTypeId();
string contractRecordTypeAddendumId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Channel Addendum Agreement').getRecordTypeId();
map<id, GE_PRM_Channel_Appointment__c> NewOldChapptmap = new map<id,GE_PRM_Channel_Appointment__c>();
list<id> lstnewchapptid = new list<id>();
list<GE_PRM_Channel_Appointment__c> lstnewchappt = new list<GE_PRM_Channel_Appointment__c>();
for(Contract con: Trigger.new){
system.debug('**con'+con);
system.debug(Trigger.oldmap.get(con.id));
if(
(
(
(string.valueof(con.GE_PRM_Contract_Draft_date__c) != null 
&& string.valueof(con.GE_PRM_GE_Confirmed_Date__c) != null
&& string.valueof(con.GE_PRM_Contract_Sent_to_CP__c) != null
&& string.valueof(con.GE_PRM_ASC_Signed_contract_received__c) != null 
&& string.valueof(con.GE_PRM_GE_Signatures_completed__c) != null
&& string.valueof(con.GE_PRM_Close_out__c) != null)
&&
(
!(string.valueof(Trigger.oldmap.get(con.id).GE_PRM_Contract_Draft_date__c) != null 
&& string.valueof(Trigger.oldmap.get(con.id).GE_PRM_GE_Confirmed_Date__c) != null
&& string.valueof(Trigger.oldmap.get(con.id).GE_PRM_Contract_Sent_to_CP__c) != null
&& string.valueof(Trigger.oldmap.get(con.id).GE_PRM_ASC_Signed_contract_received__c) != null 
&& string.valueof(Trigger.oldmap.get(con.id).GE_PRM_GE_Signatures_completed__c) != null
&& string.valueof(Trigger.oldmap.get(con.id).GE_PRM_Close_out__c) != null)
)
)                 
|| con.status == 'Executed')
&& con.RecordTypeId == contractRecordTypeMasterId){
lstexecutedmaster.add(con);
lstnewchapptid.add(con.GE_PRM_Channel_Appointment_ID__c); 
}





if(
(
(
(string.valueof(con.GE_PRM_Contract_Draft_date__c) != null 
&& string.valueof(con.GE_PRM_GE_Confirmed_Date__c) != null
&& string.valueof(con.GE_PRM_Contract_Sent_to_CP__c) != null
&& string.valueof(con.GE_PRM_ASC_Signed_contarct_received__c) != null 
&& string.valueof(con.GE_PRM_GE_Signatures_completed__c) != null
&& string.valueof(con.GE_PRM_Close_out__c) != null)
&&
(
!(string.valueof(Trigger.oldmap.get(con.id).GE_PRM_Contract_Draft_date__c) != null 
&& string.valueof(Trigger.oldmap.get(con.id).GE_PRM_GE_Confirmed_Date__c) != null
&& string.valueof(Trigger.oldmap.get(con.id).GE_PRM_Contract_Sent_to_CP__c) != null
&& string.valueof(Trigger.oldmap.get(con.id).GE_PRM_ASC_Signed_contarct_received__c) != null 
&& string.valueof(Trigger.oldmap.get(con.id).GE_PRM_GE_Signatures_completed__c) != null
&& string.valueof(Trigger.oldmap.get(con.id).GE_PRM_Close_out__c) != null)
)
)                 
|| con.status == 'Executed')
&& con.RecordTypeId == contractRecordTypeAddendumId){
lstexecutedaddedum.add(con);
lstnewchapptid.add(con.GE_PRM_Channel_Appointment_ID__c);
}




}
lstnewchappt = [select GE_PRM_Old_Channel_Appointment__c, GE_PRM_Old_Contract__c from GE_PRM_Channel_Appointment__c where id IN : lstnewchapptid];
if(lstnewchappt.size()>0){
NewOldChapptmap = new map<id,GE_PRM_Channel_Appointment__c>(lstnewchappt);
system.debug('**---New Channel Appointment Map----**'+NewOldChapptmap);
system.debug('**---Executed Master Contracts After Update----**'+lstexecutedmaster);
system.debug('**---Executed Addedum Contracts After Update----**'+lstexecutedaddedum);
if(lstexecutedmaster.size() > 0){

for(contract con : lstexecutedmaster){
list<contract> conarchiving = new list<contract>();
if(NewOldChapptmap.get(con.GE_PRM_Channel_Appointment_ID__c).GE_PRM_Old_Channel_Appointment__c != null || NewOldChapptmap.get(con.GE_PRM_Channel_Appointment_ID__c).GE_PRM_Old_Contract__c != null){
if(NewOldChapptmap.get(con.GE_PRM_Channel_Appointment_ID__c).GE_PRM_Old_Channel_Appointment__c != null){
conarchiving =  [select status from contract where GE_PRM_Channel_Appointment_ID__c = :NewOldChapptmap.get(con.GE_PRM_Channel_Appointment_ID__c).GE_PRM_Old_Channel_Appointment__c AND RecordTypeId = :contractRecordTypeMasterId AND Id != :con.id];
}
if(NewOldChapptmap.get(con.GE_PRM_Channel_Appointment_ID__c).GE_PRM_Old_Contract__c != null){
conarchiving =  [select status from contract where id = :NewOldChapptmap.get(con.GE_PRM_Channel_Appointment_ID__c).GE_PRM_Old_Contract__c AND RecordTypeId = :contractRecordTypeMasterId AND Id != :con.id];
}
if(conarchiving.size()>0){
lstArchivingContract.add(conarchiving[0]);
}
}

}
}
system.debug('**---Archiving Master Contract----**'+lstArchivingContract);
if(lstexecutedaddedum.size() > 0)
{
id channelAppId = NewOldChapptmap.get(lstexecutedaddedum[0].GE_PRM_Channel_Appointment_ID__c).GE_PRM_Old_Channel_Appointment__c;
id OldContractId = NewOldChapptmap.get(lstexecutedaddedum[0].GE_PRM_Channel_Appointment_ID__c).GE_PRM_Old_Contract__c;
string strRelationTYpe =lstexecutedaddedum[0].GE_PRM_Relationship_Type__c;
for(Contract conarchiving : [select status,GE_PRM_Business_Tier_1__c, GE_PRM_Relationship_Type__c,GE_PRM_Tier_2__c,GE_PRM_Tier_3__c,GE_PRM_Tier_4__c,GE_PRM_Tier_5__c from contract where (GE_PRM_Channel_Appointment_ID__c =:channelAppId OR GE_PRM_Master_Agreement__c =:OldContractId) AND  GE_PRM_Relationship_Type__c =: strRelationTYpe AND RecordTypeId = :contractRecordTypeAddendumId ])
{
system.debug('**---Archiving Addedudum Contract----**'+conarchiving);
system.debug('**---Archiving Addedudum Contract size----**'+conarchiving);
for(contract con : lstexecutedaddedum)
{
system.debug('**---con.GE_PRM_Channel_Appointment_ID__c----**'+con.GE_PRM_Channel_Appointment_ID__c);
if(NewOldChapptmap.get(con.GE_PRM_Channel_Appointment_ID__c)!= null)
{
if(NewOldChapptmap.get(con.GE_PRM_Channel_Appointment_ID__c).GE_PRM_Old_Channel_Appointment__c != null)
{
if(conarchiving.GE_PRM_Business_Tier_1__c == con.GE_PRM_Business_Tier_1__c && 
conarchiving.GE_PRM_Tier_2__c == con.GE_PRM_Tier_2__c &&
conarchiving.GE_PRM_Tier_3__c == con.GE_PRM_Tier_3__c &&
conarchiving.GE_PRM_Tier_4__c == con.GE_PRM_Tier_4__c &&
conarchiving.GE_PRM_Tier_5__c == con.GE_PRM_Tier_5__c &&
conarchiving.GE_PRM_Relationship_Type__c == con.GE_PRM_Relationship_Type__c &&
con.id !=conarchiving.id
)
{
lstArchivingContract.add(conarchiving); 
}
}
else if(NewOldChapptmap.get(con.GE_PRM_Channel_Appointment_ID__c) != null)
{
if(NewOldChapptmap.get(con.GE_PRM_Channel_Appointment_ID__c).GE_PRM_Old_Contract__c != null)
{
if(conarchiving.GE_PRM_Business_Tier_1__c == con.GE_PRM_Business_Tier_1__c && 
conarchiving.GE_PRM_Tier_2__c == con.GE_PRM_Tier_2__c &&
conarchiving.GE_PRM_Tier_3__c == con.GE_PRM_Tier_3__c &&
conarchiving.GE_PRM_Tier_4__c == con.GE_PRM_Tier_4__c &&
conarchiving.GE_PRM_Tier_5__c == con.GE_PRM_Tier_5__c &&
conarchiving.GE_PRM_Relationship_Type__c == con.GE_PRM_Relationship_Type__c && 
con.id !=conarchiving.id
)
{
lstArchivingContract.add(conarchiving); 
}
}
}
}

}

}
}
system.debug('**---Archiving Master && Addedum Contract----**'+lstArchivingContract);
if(lstArchivingContract.size()>0){
for(contract con : lstArchivingContract){
con.status = 'Archived';  
}
list<contract> lstArchivingContract1 = new list<contract>();
for(contract c : lstArchivingContract){
boolean duplicate = false;
if(lstArchivingContract1.size()>0){
for(contract con : lstArchivingContract1){
if(con.id == c.id){
duplicate = true;
}
}
if(duplicate == false){
lstArchivingContract1.add(c);   
}
}   
else{
lstArchivingContract1.add(c);
}

}
update lstArchivingContract1;
} 
}    
}
//** End to changing status of old appointment contracts to archived
//GE_PRM_TriggerhelperClass.setarchiveold(); 
Sunayana : 14 Aug 2016 Commented code for Archiving
*/
            // } 
            
            
        }
    }
    
    
    // code for contract edit restriction -- start --by SK
    
    if(trigger.isbefore )
    {
        if(checkRecursive.Var_bypasstrigger == false)
            return;
        
        if(checkRecursive.runBeforeOnce()){
            system.debug('$$$$$$$$$$$$$$$'); 
            if( trigger.isupdate)
            {
                
                NonprmUser_contract_restrictionUtil.contractaccess(Trigger.New); 
                
            }
        }
    } 
    // code for contract edit restriction -- end --
    
    
    
    // rahul code start from here
    if(trigger.isBefore && (trigger.isInsert || trigger.isUpdate))
    {
        String prmAddendumId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('PRM Addendum').getRecordTypeId(); 
        String prmAmmendId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('PRM Amendment').getRecordTypeId();     
        String prmMasterId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('PRM Master Agreement').getRecordTypeId();  
        //List<Contract> cancelledContracts = new List<Contract>();
        set<id> setAcId = new set<id>();
        map<id,Account> mapAcToMemberof = new map<id,Account>();
        GE_PRM_Contract_Trigger_Handler.handlePRMCancelledContracts(trigger.new);
        for(contract c : trigger.new)
        {
            if(c.recordtypeid == prmAddendumId || c.recordtypeid == prmAmmendId || c.recordtypeid == prmMasterId )
            {
                setAcId.add(c.AccountId);
                
            }
                
        }
        
        
        if(setAcId.size()>0)
        {
            for(Account Ac : [select id,Member_of_GE_OG__c,Oil_Gas_Parent_Account__c from Account where id in: setAcId])
            {
                mapAcToMemberof.put(Ac.id,Ac);
            }
        }
        for(contract c : trigger.new)
        {
            if(mapAcToMemberof.get(c.AccountId) != null)
            {
                c.GE_Commercial_Member_Of_GE_OG__c = mapAcToMemberof.get(c.AccountId).Member_of_GE_OG__c;
                c.GE_PRM_Commercial_Account__c = mapAcToMemberof.get(c.AccountId).Oil_Gas_Parent_Account__c ;
            }
        } 
        CheckRecursion_GE_OG.run = true;
    }  
    
}