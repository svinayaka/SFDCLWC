/*
Class Name                   - SD_JobTriggerHandler 
Object Name                  - FX5__Job__c
Created Date                 - 8/28/2019
Created By                   - Naveen Vuppu
LastModifiedDate             -
Test Class                   - SD_JobupdatephaseclassTest 
Description                  -  Handler Class JobTriggerHandler would process all the Trigger requests coming from SD_CustomJobTrigger
All Logic to be processed in the Handler Class or Helper Classes being called from this Handler Class

Last Modified By             - VijayaLakshmi Murukutla
LastModified Date            - Oct/01/2019
Purpose                      - Auto update feilds ('Job Items Added','Fundamentals Added','Fundamentals To Be Added') of Job Object,
when JobItems are inserted or deleted for the job.

Last Modified By             - VijayaLakshmi Murukutla
LastModified Date            - Dec/26/2019 - Jan/07/2020
Purpose                      - Ref: Story/Requirement R-33390
1. Create/modify a job trigger so that whenever a job is selected as a rotator crew, it copies over all the crew records from the job to the current job
2. If user removes a rotator crew job, it deletes all the crew copied over from the rotator crew job
3. If there is a modification on the rotator crew job with regards to crew planning, it should reflect the change in all the jobs with are associated with that job as a rotator crew.


===========================================================================================================
*/
public without sharing class SD_JobTriggerHandler 
{
    public void OnBeforeInsert(List<FX5__Job__c> newObjects, Map<Id, FX5__Job__c> newObjectMap){
        /***** Added as part of R-34139 *********/
        Map<id,FX5__Job__c> JobmaptoProcess = new Map<id,FX5__Job__c>();
        for(FX5__Job__c jrec : newObjects){
            if(jrec.FX5__Projected_Start_Date__c != null ){ //Added by NS for R-33410
                if(jrec.SD_Day_Job__c)
                    jrec.FX5__Projected_Start_Date__c = DateTime.newInstance(jrec.FX5__Projected_Start_Date__c.year(), jrec.FX5__Projected_Start_Date__c.month(), jrec.FX5__Projected_Start_Date__c.day(), 00, 00, 00);
                jrec.SD_Job_Start_Date__c = jrec.FX5__Projected_Start_Date__c.format('YYYY-MM-dd');
            }
            if(jrec.SD_Duration__c != null){ //Added by NS for R-33410 
                if(jrec.SD_Day_Job__c){
                    jrec.FX5__Projected_End_Date__c = jrec.FX5__Projected_Start_Date__c +  jrec.SD_Duration__c  - 1 ;
                    jrec.FX5__Projected_End_Date__c = DateTime.newInstance(jrec.FX5__Projected_End_Date__c.year(), jrec.FX5__Projected_End_Date__c.month(), jrec.FX5__Projected_End_Date__c.day(), 23, 59, 00);
                }
                else{
                    jrec.FX5__Projected_End_Date__c = jrec.FX5__Projected_Start_Date__c +  jrec.SD_Duration__c;
                }
            }
            
            if(jrec.FX5__Well__c != null){
                JobmaptoProcess.put(jrec.id,jrec);
            }
        }
        if(JobmaptoProcess.size() > 0)
            PopulateLatandLongFromWell(JobmaptoProcess);
    }
    
    public void OnBeforeUpdate(List<FX5__Job__c> newJobrecs, Map<Id, FX5__Job__c> oldJobRecMap){
        /***** Added as part of R-34139 *********/
        Map<id,FX5__Job__c> JobmaptoProcess = new Map<id,FX5__Job__c>();
        for(FX5__Job__c jrec : newJobrecs){
            if(jrec.FX5__Projected_Start_Date__c != null ){ //Added by NS for R-33410
                if(jrec.SD_Day_Job__c){
                    jrec.FX5__Projected_Start_Date__c = DateTime.newInstance(jrec.FX5__Projected_Start_Date__c.year(), jrec.FX5__Projected_Start_Date__c.month(), jrec.FX5__Projected_Start_Date__c.day(), 00, 00, 00);
                }
                jrec.SD_Job_Start_Date__c = jrec.FX5__Projected_Start_Date__c.format('YYYY-MM-dd');
            }   
            
            if(jrec.SD_Duration__c != null){ //Added by NS for R-33410 
                if(jrec.SD_Day_Job__c){
                    jrec.FX5__Projected_End_Date__c = jrec.FX5__Projected_Start_Date__c +  jrec.SD_Duration__c  - 1 ;
                    jrec.FX5__Projected_End_Date__c = DateTime.newInstance(jrec.FX5__Projected_End_Date__c.year(), jrec.FX5__Projected_End_Date__c.month(), jrec.FX5__Projected_End_Date__c.day(), 23, 59, 00);
                }
                else{
                    jrec.FX5__Projected_End_Date__c = jrec.FX5__Projected_Start_Date__c +  jrec.SD_Duration__c;
                }
            }
            
            if(jrec.FX5__Well__c != oldJobRecMap.get(jrec.id).FX5__Well__c && jrec.FX5__Well__c != null){
                JobmaptoProcess.put(jrec.id,jrec);
            }
        }
        if(JobmaptoProcess.size() > 0)
            PopulateLatandLongFromWell(JobmaptoProcess);
    }
    /***** Added as part of R-34139 *********/
    Public void PopulateLatandLongFromWell(Map<id,FX5__Job__c> JobmaptoProcess){
        Set<Id> wellids = new Set<id>();
        if(JobmaptoProcess.size() > 0){
            for(FX5__Job__c jobrec : JobmaptoProcess.values())
                if(jobrec.FX5__Well__c != null)
                wellids.add(jobrec.FX5__Well__c);
            
            Map<id,FX5__Well__c> wellmap = new Map<id,FX5__Well__c>([select id,FX5__Latitude__c,FX5__Longitude__c from FX5__Well__c where id in: wellids]);
            for(FX5__Job__c job : JobmaptoProcess.values()){
                if(wellmap.containskey(job.FX5__Well__c)){
                    job.FX5__Site_Latitude__c = wellmap.get(job.FX5__Well__c).FX5__Latitude__c;
                    job.FX5__Site_Longitude__c = wellmap.get(job.FX5__Well__c).FX5__Longitude__c;
                }
            }
        }
    }
    
    Public void AltSync(List<FX5__Job__c> newObjects)
    {
        List<Account> updateAccountL= new List<Account>();
        List<Contact> UpdatecontactL = new List<Contact>();
        List<SD_Rig__c> updateRigL = new List<SD_Rig__c>();
        List<FX5__Well__c> updateWellL = new List<FX5__Well__c>();
        
        set<id> accountids = new set<id>();
        set<id> contactids= new set<id>();
        set<id> wellids = new set<id>();
        set<id> rigids = new set<id>();
        
        for(FX5__Job__c job : newObjects)
        {
            if(job.FX5__CustomerAccount__c!=null )
            {
                accountids.add(job.FX5__CustomerAccount__c);
            }
            if(Job.FX5__Office__c!=null)
            {
                accountids.add(job.FX5__Office__c);    
            }
            
            if(job.SD_Primary_Customer_Contact_Name__c!=null )
            {
                Contactids.add(job.SD_Primary_Customer_Contact_Name__c);
            }
            if(Job.FX5__Primary_Job_Contact__c!=null)
            {
                Contactids.add(job.FX5__Primary_Job_Contact__c);    
            }
            if(job.SD_Rig_Name__c!=null)
            {
                rigids.add(job.SD_Rig_Name__c);
            }
            if(job.FX5__Well__c!=null)
            {
                wellids.add(job.FX5__Well__c);
            }
        }
        if(accountids.size()>0)
        {
            for(account a:[select id, AltSync__c from account where id in:accountids])
                
            {
                a.AltSync__c=true;
                updateAccountL.add(a);
            }
        }
        if(wellids.size()>0)
        {
            for(FX5__Well__c w:[select id,AltSync__c from FX5__Well__c where id in:wellids ])
            {
                w.AltSync__c=true;
                updateWellL.add(w);
            }
        }
        if(rigids.size()>0)
        {
            for(SD_Rig__c r:[select id,AltSync__c from SD_Rig__c where id in:rigids])
            {
                r.AltSync__c=true;
                updateRigL.add(r);
            }
        }
        if(Contactids.size()>0)
        {
            for(contact a:[select id,AltSync__c  from contact where id in:Contactids])
                
            {
                a.AltSync__c =true;
                UpdatecontactL.add(a);
            }
        }
        database.update(UpdatecontactL,false);
        database.update(updateAccountL,false);
        database.update(updateRigL,false);
        database.update(updateWellL,false);
    }
    public void OnAfterInsert(List<FX5__Job__c> newObjects){
        AltSync(newObjects);
        set<Id> wellIdsSet = new set<Id>();
        
        for(FX5__Job__c job : newObjects){
            wellIdsSet.add(job.FX5__Well__c);
        }
        if(!wellIdsSet.isEmpty()){
            countJobsOnWell(wellIdsSet);
        }
    }    
    Public void PPQualificationRequirement(set<id> jobids)
    {
        List<Map<String,List<String>>> ListofMaps = new List<Map<String,List<String>>>();
        Map<id,List<FX5__Qualification__c>> QRmap = new Map<id,List<FX5__Qualification__c>>();
        List<FX5__Qualification_Requirement__c> deleteList = new List<FX5__Qualification_Requirement__c>();
        List<FX5__Qualification_Requirement__c> InsertList = new List<FX5__Qualification_Requirement__c>();
        
        Map<String,List<FX5__Qualification__c>> QualificationsIDs= new Map<String,List<FX5__Qualification__c>>(); 
        String QueryFields = '';
        
        for(PPJobs_PPQualifications__mdt cmd : [select id,Label from PPJobs_PPQualifications__mdt])
        {
            QueryFields=QueryFields+', '+cmd.Label;
        } 
        String js='select id '+QueryFields+' from FX5__Job__c where id in :jobids';
        
        Map<String,set<id>> Grandkeyjobs = new Map<String,set<id>>();
        Map<String,List<String>> CurrentFVMap = new Map<String,List<String>>();
        List<FX5__Job__c> JobsL = database.query(js);
        for(FX5__Job__c job : JobsL)
        {
            String Grandkey='';
            
            for(PPJobs_PPQualifications__mdt cmd : [select id,Label from PPJobs_PPQualifications__mdt])
            {
                system.debug('String.valueof(job.get(cmd.Label)) in job'+String.valueof(job.get(cmd.Label)));       
                if(String.valueof(job.get(cmd.Label))!=null)
                {
                    if(CurrentFVMap.Containskey(cmd.Label))
                    {
                        List<String> UtilityStrings = new List<String> ();
                        UtilityStrings = CurrentFVMap.get(cmd.Label);
                        UtilityStrings.add(String.valueof(job.get(cmd.Label)));
                        CurrentFVMap.Put(cmd.Label,UtilityStrings);
                    }
                    else
                    {
                        List<String> UtilityStrings = new List<String> ();
                        UtilityStrings.add(String.valueof(job.get(cmd.Label)));
                        CurrentFVMap.Put(cmd.Label,UtilityStrings);
                        
                    }
                    Grandkey=Grandkey+String.valueof(job.get(cmd.Label));
                }
            }
            //ListofMaps.add(CurrentFVMap);
            if(Grandkeyjobs.containskey(Grandkey))
            {
                set<id> utilityS = new set<id>();
                utilityS = Grandkeyjobs.get(Grandkey);
                utilityS.add(job.id);
                Grandkeyjobs.put(Grandkey,utilityS);
            }
            else
            {
                set<id> utilityS = new set<id>();
                utilityS.add(job.id);
                Grandkeyjobs.put(Grandkey,utilityS);
            }
            system.debug('Grandkeyjobs.keyset()=============================>'+Grandkeyjobs.keyset());
        }
        String Qs='select id,SD_Qualification_Type__c '+QueryFields+' from FX5__Qualification__c where SD_Active__c = true AND  ' ;
        String WhereConditions = '';
        Map<id,FX5__Qualification__c> QualificationRecord = new Map<id,FX5__Qualification__c>();
        integer Sizing = 1;
        integer listofmapssizing=1;
        for(String ms : CurrentFVMap.keyset())
        {
            String s =ms; 
            List<String> LS = CurrentFVMap.get(ms);
            System.debug('LS===========> '+ LS);
            
            Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
            Schema.SObjectType QualSchema = schemaMap.get('FX5__Qualification__c');
            
            Map<String, Schema.SObjectField> fieldMap = QualSchema.getDescribe().fields.getMap();
            
            Schema.DisplayType fielddataType = fieldMap.get(S).getDescribe().getType();
            
            if(fielddataType == Schema.DisplayType.MultiPicklist || fielddataType == Schema.DisplayType.Picklist)
            {
                List<String> WQSL = new List<String>();
                for(String WQS : LS)
                {
                    if(WQS!=null)
                        WQSL.add('\''+WQS+'\'');
                    else
                        WQSL.add(WQS);
                }
                if(fielddataType == Schema.DisplayType.MultiPicklist)
                {
                    if(Sizing == CurrentFVMap.Keyset().Size())
                        WhereConditions = WhereConditions + ' '+S+' includes ' + WQSL;
                    
                    else
                        WhereConditions = WhereConditions + ' '+S+' includes ' + WQSL+ ' AND ';
                }
                else
                {
                    if(Sizing == CurrentFVMap.Keyset().Size())
                        WhereConditions = WhereConditions + ' '+S+' in ' + WQSL;
                    else
                        WhereConditions = WhereConditions + ' '+S+' in ' + WQSL+ ' AND ';
                }
            }
            else
            {
                if(Sizing == CurrentFVMap.Keyset().Size())
                    WhereConditions = WhereConditions + ' '+S+' in ' + LS;
                else
                    WhereConditions = WhereConditions + ' '+S+' in ' + LS+ ' AND ';
            }
            Sizing = Sizing +1;   
        }
        String MasterStringofJob ='';
        for(String s : Grandkeyjobs.keyset())
        {
            MasterStringofJob=MasterStringofJob+s;
        }
        Qs=Qs+WhereConditions;
        system.debug('QS=================================>'+Qs);
        List<FX5__Qualification__c> ListQual = database.query(Qs);
        Map<String,set<id>> GrandkeyQuals = new Map<String,set<id>>();
        
        for(FX5__Qualification__c qal:ListQual)
        {
            List<String> GrandkeysList = new List<String>();
            //String Grandkey = '';
            List<String> keyvalues = new List<String>();
            QualificationRecord.put(qal.id,qal);
            for(PPJobs_PPQualifications__mdt cmd : [select id,Label from PPJobs_PPQualifications__mdt])
            {
                if(String.Valueof(qal.get(cmd.Label))!=null)
                {
                    String QualificationFieldValues = String.Valueof(qal.get(cmd.Label));
                    List<String> grandkeyAttachments = new List<String>();
                    if(QualificationFieldValues.contains(';'))
                    {
                        for(String s : QualificationFieldValues.Split(';'))
                        {
                            if(GrandkeysList.isEmpty() && MasterStringofJob.Contains(s))
                            {
                                
                                GrandkeysList.add(s);
                            }
                            else
                            {
                                List<String> newkeyList = new List<String>();
                                for(String s1 : GrandkeysList)
                                {
                                    if(MasterStringofJob.Contains(s1+s) )
                                    {
                                        newkeyList.add(s1+s);
                                    }
                                }
                                if(newkeyList.size()>0)
                                {
                                    //GrandkeysList.clear();
                                    GrandkeysList.addall(newkeyList);  
                                }
                            }
                        }
                    }
                    else
                    {
                        if(GrandkeysList.isempty() && MasterStringofJob.Contains(QualificationFieldValues))
                        {
                            GrandkeysList.add(QualificationFieldValues);
                        }
                        else
                        {
                            List<String> newkeylist = new List<String>();
                            
                            for(String s : GrandkeysList)
                            {
                                if(MasterStringofJob.Contains(s+QualificationFieldValues))
                                    newkeylist.add(s+QualificationFieldValues);
                            }
                            if(newkeylist.size()>0)
                            {
                                //GrandkeysList.clear();
                                GrandkeysList.addall(newkeylist);
                            }
                        }
                    }
                }
            }   
            System.debug('GrandkeysList================='+GrandkeysList);   
            system.debug('Grandkeylist size()==============================>'+GrandkeysList.size());    
            for(String s :GrandkeysList )
            {
                system.debug('Grand key of qualification=======>'+s);
                if(GrandkeyQuals.containskey(s))
                {
                    set<id> utilityS = new set<id>();
                    utilityS = GrandkeyQuals.get(s);
                    utilityS.add(qal.id);
                    GrandkeyQuals.put(s,utilityS);
                }
                else
                {
                    set<id> utilityS = new set<id>();
                    utilityS.add(qal.id);
                    GrandkeyQuals.put(s,utilityS);
                }
            }
        }      
        for(String job : Grandkeyjobs.keyset())
        {
            if(GrandkeyQuals.containskey(job))
            {
                for(id jid : Grandkeyjobs.get(job))
                {
                    List<FX5__Qualification__c> matchedQual = new List<FX5__Qualification__c>();
                    for(id qid : GrandkeyQuals.get(job))
                    {
                        if(QualificationRecord.containskey(qid))
                        {
                            matchedQual.add(QualificationRecord.get(qid));
                        }
                    }
                    QRmap.put(jid,matchedQual);
                }
            }
        }
        for(FX5__Qualification_Requirement__c qr : [select id,FX5__Job__c from FX5__Qualification_Requirement__c where FX5__Job__c in : jobids ])
        {
            deleteList.add(qr);
        }
        for(id jobi : QRmap.keyset())
        {
            for(FX5__Qualification__c qali:QRmap.get(jobi))
            {
                FX5__Qualification_Requirement__c qr = new FX5__Qualification_Requirement__c(FX5__Job__c = jobi, FX5__Qualification__c=qali.id,SD_type__C=qali.SD_Qualification_Type__c);
                InsertList.add(qr);
            }
        }
        if(deleteList.size()>0)
            database.delete(deleteList,false);
        if(InsertList.size()>0)
            database.insert(InsertList,false);
    }
    
    public void OnAfterUpdate(List<FX5__Job__c> oldObjects, List<FX5__Job__c> newobjects, Map<Id, FX5__Job__c> newObjectMap){
        set<id> ppjobids = new set<id>();
        for(FX5__Job__c nj: newObjects)
        {
            if(nj.SD_Product_Line__c=='PP')
            {       
                for(PPJobs_PPQualifications__mdt cmd : [select id,Label from PPJobs_PPQualifications__mdt])
                {
                    if(nj.get(cmd.Label)!=Trigger.oldmap.get(nj.id).get(cmd.Label))
                    {
                        ppjobids.add(nj.id);
                        break;
                    }          
                }
            }
        }
        system.debug('ppjobids'+ppjobids); 
        if(ppjobids.size()>0)
            PPQualificationRequirement(ppjobids);
        
        System.debug('Vijaya Tesing , Its in SD_JobTriggerHandler --> AFTER UPDATE LOGIC');
        // AFTER UPDATE LOGIC
        set<Id> wellIdsSet = new set<Id>();
        for(FX5__Job__c job : newObjects){
            if((ID)Trigger.oldMap.get(job.Id).get('FX5__Well__c') != job.FX5__Well__c ){
                wellIdsSet.add(job.FX5__Well__c);
                wellIdsSet.add((Id)Trigger.oldMap.get(job.Id).get('FX5__Well__c'));
            }
        }
        if(!wellIdsSet.isEmpty())
            countJobsOnWell(wellIdsSet);      
        
        
    }  
    
    public void OnAfterDelete(List<FX5__Job__c> deletedObjects, Map<Id, FX5__Job__c> oldObjectMap){
        set<Id> wellIdsSet = new set<Id>();
        for(FX5__Job__c job : deletedObjects){
            wellIdsSet.add(job.FX5__Well__c);
        }
        if(!wellIdsSet.isEmpty())
            countJobsOnWell(wellIdsSet);
    }
    
    public void OnUndelete(List<FX5__Job__c> restoredObjects){
        set<Id> wellIdsSet = new set<Id>();
        for(FX5__Job__c job : restoredObjects){
            wellIdsSet.add(job.FX5__Well__c);
        }
        if(!wellIdsSet.isEmpty())
            countJobsOnWell(wellIdsSet);
    }
    
    private static void countJobsOnWell(set<Id> wellIdsSet){
        list<FX5__Well__c> wellUpdateList = new list<FX5__Well__c>();
        System.debug('Vijaya Tesing , Its in SD_JobTriggerHandler --- Method=countJobsOnWell: '+wellIdsSet);
        list<FX5__Well__c> wellList = [SELECT id,(Select id from FX5__Jobs__r) from FX5__Well__c where ID IN : wellIdsSet];
        for(FX5__Well__c well:wellList){
            well.SD_Number_of_Jobs__c = well.FX5__Jobs__r.size();
            wellUpdateList.add(well);
        }
        
        if(!wellUpdateList.isEmpty())
            update wellUpdateList;
    }  
    
    /*  
==============================
Modified By : VijayaLakshmi M
Modified On : 30.Dec.2019 to 02/Jan/2020
Purpose     : Making a business logic for Rotator Crew Job.
============================== 
*/
    private static Id getRotatorCrewRecordTypeId(){
        return Schema.SObjectType.FX5__Job__c.getRecordTypeInfosByDeveloperName().get('SD_Rotator_Crew').getRecordTypeId();
    }
    private static Id getSinglePhaseRecordTypeId(){
        return Schema.SObjectType.FX5__Job__c.getRecordTypeInfosByDeveloperName().get('Service').getRecordTypeId();
    }
    
    /* Method 1: For After Insert: Implement business logic to auto-insert Crew Planning records to the current job
when the Rotator Crew field has selected on any Single Phase or Job Phase record.  */
    
    public void autoInsertRCCrewsOnJob(List<FX5__Job__c> lstNewJobs){
        System.debug('Vijaya : SD_JobTriggerHandler =================    ENTRY --> for Rotator Crew Logic  ========================== ');   
        System.debug('VM Testing ..... I am in method : autoInsertCrewPlansOnJob -->  No of Job reocrds --> '+lstNewJobs.size());
        // Variable Declaration
        ID RotatorCrewRecordTypeId = getRotatorCrewRecordTypeId();
        //ID JobPhaseRecordTypeId = getJobPhaseRecordTypeId();
        ID SinglePhaseRecordTypeId = getSinglePhaseRecordTypeId();
        FX5__Job__c objNewCrewPlan = new FX5__Job__c();         
        SET<ID> setRCJobIds = new SET<ID>();        
        List<FX5__Crew_Planning__c> lstRCJobCrewPlans = new List<FX5__Crew_Planning__c>();
        List<FX5__Crew_Planning__c> lstNewJobCrewPlans = new List<FX5__Crew_Planning__c>();
        List<FX5__Crew_Planning__c> lstCrewPlanstoInsert = new List<FX5__Crew_Planning__c>();               
        Map<ID,ID> mapJobwithRCJobIds =  new  Map<ID,ID>();    
        // Map<id,FX5__Job__c> MapCurJobCrewPlan = new Map<id,FX5__Job__c>(); 
        Map<id,FX5__Job__c> MapCurJobRecs = new Map<id,FX5__Job__c>(); 
        Map<id,List<FX5__Crew_Planning__c>> mapRCJobCrewPlans = new Map<id,List<FX5__Crew_Planning__c>>();
        
        For(FX5__Job__c objNewJob : lstNewJobs){
            // System.debug('Vijaya........... JobPhaseRecordTypeId ===> '+JobPhaseRecordTypeId);
            System.debug('Vijaya........... SinglePhaseRecordTypeId ===> '+SinglePhaseRecordTypeId );
            System.debug('Vijaya........... objNewJob.RecordTypeId ===> '+objNewJob.RecordTypeId);
            System.debug('Vijaya........... objNewJob.SD_Rotator_Crew__c ===> '+objNewJob.SD_Rotator_Crew__c);
            
            If((objNewJob.RecordTypeId == SinglePhaseRecordTypeId) && objNewJob.SD_Rotator_Crew__c != null){
                setRCJobIds.add(objNewJob.SD_Rotator_Crew__c);
                MapCurJobRecs.put(objNewJob.id,objNewJob);
            }
        }
        System.debug('Vijaya........... MapCurJobRecs ===> '+MapCurJobRecs);
        System.debug('Vijaya........... setRCJobIds ===> '+setRCJobIds);       
        
        IF(setRCJobIds.size() > 0){
            lstRCJobCrewPlans = [SELECT ID,NAME,FX5__Crew_Member__c,FX5__Job__c,SD_Shift__c,FX5__Planned_Start_Date__c,
                                 FX5__Planned_End_Date__c,FX5__Role_on_Job__c,SD_Role_Description__c,SD_Pre_Job_Brief__c,
                                 SD_Dispatch__c,SD_Heliport__c,SD_Check_in__c,SD_Name_Coming_In__c,SD_Rotator_Crew_Job_Reference__c 
                                 FROM FX5__Crew_Planning__c
                                 WHERE FX5__Job__c IN : setRCJobIds 
                                ]; 
            System.debug('Vijaya........... lstRCJobCrewPlans ===> '+lstRCJobCrewPlans);   
        }
        If(lstRCJobCrewPlans.size() > 0){
            For(ID objRCID : setRCJobIds){
                lstNewJobCrewPlans = new List<FX5__Crew_Planning__c>();
                For(FX5__Crew_Planning__c objCP : lstRCJobCrewPlans){
                    IF(objRCID == objCP.FX5__Job__c){
                        lstNewJobCrewPlans.add(objCP);
                        mapRCJobCrewPlans.put(objRCID,lstNewJobCrewPlans); 
                    } 
                }                
            }  
        } 
        System.debug('Vijaya........... lstNewJobCrewPlans ===> '+lstNewJobCrewPlans);
        System.debug('Vijaya........... mapRCJobCrewPlans ===> '+mapRCJobCrewPlans); 
        IF(mapRCJobCrewPlans.size() > 0 && MapCurJobRecs.size() > 0){
            For(FX5__Job__c objCurJobRec : MapCurJobRecs.values()){
                for(FX5__Crew_Planning__c objExistedRCCrewPlan : mapRCJobCrewPlans.get(objCurJobRec.SD_Rotator_Crew__c)){
                    FX5__Crew_Planning__c objNewCrewPlanToCrntJob = new FX5__Crew_Planning__c();
                    objNewCrewPlanToCrntJob.id = null;
                    objNewCrewPlanToCrntJob.FX5__Crew_Member__c = objExistedRCCrewPlan.FX5__Crew_Member__c;
                    objNewCrewPlanToCrntJob.SD_Shift__c  = objExistedRCCrewPlan.SD_Shift__c;
                    objNewCrewPlanToCrntJob.FX5__Planned_Start_Date__c = objCurJobRec.FX5__Projected_Start_Date__c; //Modified by NS 26/02/2020
                    objNewCrewPlanToCrntJob.FX5__Planned_End_Date__c = objCurJobRec.FX5__Projected_End_Date__c; //Modified by NS 26/02/2020
                    objNewCrewPlanToCrntJob.FX5__Role_on_Job__c =  objExistedRCCrewPlan.FX5__Role_on_Job__c;
                    objNewCrewPlanToCrntJob.SD_Pre_Job_Brief__c = objExistedRCCrewPlan.SD_Pre_Job_Brief__c;
                    objNewCrewPlanToCrntJob.SD_Dispatch__c  = objExistedRCCrewPlan.SD_Dispatch__c;
                    objNewCrewPlanToCrntJob.SD_Check_in__c  = objExistedRCCrewPlan.SD_Check_in__c;
                    objNewCrewPlanToCrntJob.SD_Name_Coming_In__c  = objExistedRCCrewPlan.SD_Name_Coming_In__c; 
                    objNewCrewPlanToCrntJob.FX5__Job__c = objCurJobRec.id;
                    objNewCrewPlanToCrntJob.SD_Rotator_Crew_Job_Reference__c = objCurJobRec.SD_Rotator_Crew__c;
                    objNewCrewPlanToCrntJob.SD_RCJob_CrewPlan_Reference__c = objExistedRCCrewPlan.id;
                    lstCrewPlanstoInsert.add(objNewCrewPlanToCrntJob);
                }
            }
        }
        System.debug('Vijaya........... lstCrewPlanstoInsert ===> '+lstCrewPlanstoInsert); 
        IF(lstCrewPlanstoInsert.size() > 0)
            insert lstCrewPlanstoInsert;
    }   
    
    /*Method 2 : After Update:- If Rotator Crew field made as empty,
Implement business logic to auto-delete Crew Planning records from the current job when the Rotator Crew field has removed.*/
    
    public void autoResetRCCrewsOnJobUpdate(Map<id,FX5__Job__c> mapOldJobs,List<FX5__Job__c> lstNewJobs){ 
        
        System.debug('VM Testing ..... I am in Method 2 : autoDeleteCrewPlansOnJob -->  No of Job reocrds --> '+lstNewJobs.size());
        // Variable Declaration
        ID RotatorCrewRecordTypeId = getRotatorCrewRecordTypeId();
        // ID JobPhaseRecordTypeId = getJobPhaseRecordTypeId();
        ID SinglePhaseRecordTypeId = getSinglePhaseRecordTypeId();  
        SET<ID> setExistedRCJobIds = new SET<ID>(); 
        SET<ID> setNewRCJobIds = new SET<ID>();
        List<FX5__Crew_Planning__c> lstRCJobCrewPlans = new List<FX5__Crew_Planning__c>();      
        List<FX5__Crew_Planning__c> lstCrewPlanstoDelete = new List<FX5__Crew_Planning__c>(); 
        // Map<id,FX5__Job__c> MapCurJobCrewPlan = new Map<id,FX5__Job__c>(); 
        Map<id,FX5__Job__c> MapCurJobRecs = new Map<id,FX5__Job__c>();        
        Map<id,List<FX5__Crew_Planning__c>> mapRCJobCrewPlans = new Map<id,List<FX5__Crew_Planning__c>>();
        List<FX5__Crew_Planning__c> lstNewJobCrewPlans = new List<FX5__Crew_Planning__c>();
        List<FX5__Crew_Planning__c> lstCrewPlanstoInsert = new List<FX5__Crew_Planning__c>();
        
        // Retrieving Rotator Crew Job Ids and current Job Records
        For(FX5__Job__c objNewJob : lstNewJobs){
            // System.debug('Vijaya........... JobPhaseRecordTypeId ===> '+JobPhaseRecordTypeId);
            System.debug('Vijaya........... SinglePhaseRecordTypeId ===> '+SinglePhaseRecordTypeId);
            If((objNewJob.RecordTypeId == SinglePhaseRecordTypeId) && objNewJob.SD_Rotator_Crew__c != mapOldJobs.get(objNewJob.id).SD_Rotator_Crew__c){
                if(mapOldJobs.get(objNewJob.id).SD_Rotator_Crew__c != null && objNewJob.SD_Rotator_Crew__c == null){
                    setExistedRCJobIds.add(mapOldJobs.get(objNewJob.id).SD_Rotator_Crew__c);    // Deleting
                }else if(mapOldJobs.get(objNewJob.id).SD_Rotator_Crew__c == null && objNewJob.SD_Rotator_Crew__c != null){
                    setNewRCJobIds.add(objNewJob.SD_Rotator_Crew__c); //Inserting
                    MapCurJobRecs.put(objNewJob.id,objNewJob);
                }else if(mapOldJobs.get(objNewJob.id).SD_Rotator_Crew__c != null && objNewJob.SD_Rotator_Crew__c != null){
                    setExistedRCJobIds.add(mapOldJobs.get(objNewJob.id).SD_Rotator_Crew__c);    // Deleting
                    setNewRCJobIds.add(objNewJob.SD_Rotator_Crew__c); //Inserting
                    MapCurJobRecs.put(objNewJob.id,objNewJob);
                }
            }
        }
        
        System.debug('Vijaya........... setExistedRCJobIds ===> '+setExistedRCJobIds); 
        // Retrieving Only Crew Planing Records which were created through related rotator Crew Jobs to delete
        IF(setExistedRCJobIds.size() > 0){
            lstRCJobCrewPlans = [SELECT ID,NAME,FX5__Crew_Member__c,FX5__Job__c,SD_Shift__c,FX5__Planned_Start_Date__c,
                                 FX5__Planned_End_Date__c,FX5__Role_on_Job__c,SD_Role_Description__c,SD_Pre_Job_Brief__c,
                                 SD_Dispatch__c,SD_Heliport__c,SD_Check_in__c,SD_Name_Coming_In__c,SD_Rotator_Crew_Job_Reference__c 
                                 FROM FX5__Crew_Planning__c
                                 WHERE SD_Rotator_Crew_Job_Reference__c IN : setExistedRCJobIds 
                                ]; 
            System.debug('Vijaya........... lstRCJobCrewPlans ===> '+lstRCJobCrewPlans);         
            If(lstRCJobCrewPlans.size() > 0){                 
                delete lstRCJobCrewPlans;  
            }
        }
        /* 
Method 2. B --> After Update:-If Rotator Crew field changed from one value to another
Implement business logic to auto-delete existed (old Rotator Crew Job's ) Crew Planning records from the current job
and auto-insert crew Planing Records of the newly selected Rotator Crew Job for the current Job record.
*/
        if(setNewRCJobIds.size() > 0){
            
            System.debug('Vijaya........... setNewRCJobIds ===> '+setNewRCJobIds); 
            // Retrieving Only Crew Planing Records which are related to current rotator Crew Job value on current job
            lstRCJobCrewPlans = new List<FX5__Crew_Planning__c>();  
            lstRCJobCrewPlans = [SELECT ID,NAME,FX5__Crew_Member__c,FX5__Job__c,SD_Shift__c,FX5__Planned_Start_Date__c,
                                 FX5__Planned_End_Date__c,FX5__Role_on_Job__c,SD_Role_Description__c,SD_Pre_Job_Brief__c,
                                 SD_Dispatch__c,SD_Heliport__c,SD_Check_in__c,SD_Name_Coming_In__c,SD_Rotator_Crew_Job_Reference__c 
                                 FROM FX5__Crew_Planning__c
                                 WHERE FX5__Job__c IN : setNewRCJobIds 
                                ]; 
            System.debug('Vijaya........... lstRCJobCrewPlans ===> '+lstRCJobCrewPlans);   
            
            If(lstRCJobCrewPlans.size() > 0){
                For(ID objRCID : setNewRCJobIds){
                    lstNewJobCrewPlans = new List<FX5__Crew_Planning__c>();
                    For(FX5__Crew_Planning__c objCP : lstRCJobCrewPlans){
                        IF(objRCID == objCP.FX5__Job__c){
                            lstNewJobCrewPlans.add(objCP);
                            mapRCJobCrewPlans.put(objRCID,lstNewJobCrewPlans); 
                        } 
                    }                
                }  
            } 
            System.debug('Vijaya........... lstNewJobCrewPlans ===> '+lstNewJobCrewPlans);
            System.debug('Vijaya........... mapRCJobCrewPlans ===> '+mapRCJobCrewPlans);         
            IF(mapRCJobCrewPlans.size() > 0 && MapCurJobRecs.size() > 0){
                For(FX5__Job__c objCurJobRec : MapCurJobRecs.values()){
                    System.debug('***mapRCJobCrewPlans.get(objCurJobRec.SD_Rotator_Crew__c)***'+mapRCJobCrewPlans.get(objCurJobRec.SD_Rotator_Crew__c));
                    for(FX5__Crew_Planning__c objExistedRCCrewPlan : mapRCJobCrewPlans.get(objCurJobRec.SD_Rotator_Crew__c)){
                        String crewid = objExistedRCCrewPlan.id;
                        FX5__Crew_Planning__c objNewCrewPlanToCrntJob = new FX5__Crew_Planning__c();
                        objNewCrewPlanToCrntJob.id = null;
                        objNewCrewPlanToCrntJob.FX5__Crew_Member__c = objExistedRCCrewPlan.FX5__Crew_Member__c;
                        objNewCrewPlanToCrntJob.SD_Shift__c  = objExistedRCCrewPlan.SD_Shift__c;
                        objNewCrewPlanToCrntJob.FX5__Planned_Start_Date__c = objCurJobRec.FX5__Projected_Start_Date__c; //Modified by NS 26/02/2020
                        objNewCrewPlanToCrntJob.FX5__Planned_End_Date__c = objCurJobRec.FX5__Projected_End_Date__c; //Modified by NS 26/02/2020
                        objNewCrewPlanToCrntJob.FX5__Role_on_Job__c =  objExistedRCCrewPlan.FX5__Role_on_Job__c;
                        objNewCrewPlanToCrntJob.SD_Pre_Job_Brief__c = objExistedRCCrewPlan.SD_Pre_Job_Brief__c;
                        objNewCrewPlanToCrntJob.SD_Dispatch__c  = objExistedRCCrewPlan.SD_Dispatch__c;
                        objNewCrewPlanToCrntJob.SD_Check_in__c  = objExistedRCCrewPlan.SD_Check_in__c;
                        objNewCrewPlanToCrntJob.SD_Name_Coming_In__c  = objExistedRCCrewPlan.SD_Name_Coming_In__c; 
                        objNewCrewPlanToCrntJob.FX5__Job__c = objCurJobRec.id;
                        objNewCrewPlanToCrntJob.SD_Rotator_Crew_Job_Reference__c = objCurJobRec.SD_Rotator_Crew__c;
                        objNewCrewPlanToCrntJob.SD_RCJob_CrewPlan_Reference__c = objExistedRCCrewPlan.id;
                        lstCrewPlanstoInsert.add(objNewCrewPlanToCrntJob);
                    }
                }
            }
            System.debug('Vijaya........... lstCrewPlanstoInsert ===> '+lstCrewPlanstoInsert); 
            if(lstCrewPlanstoInsert.size() > 0)
                insert lstCrewPlanstoInsert;
        }
        System.debug('Vijaya : SD_JobTriggerHandler =================    EXIT -------> Exit from Rotator Crew Logic ========================== ');
    }   
}