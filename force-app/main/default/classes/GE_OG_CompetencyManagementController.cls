public with sharing class GE_OG_CompetencyManagementController{

    public SVMXC__Service_Group_Skills__c expert{get;set;}
    public List<SVMXC__Service_Group_Skills__c> expertLst{get;set;}
    
    public SVMXC__Skill__c skills{get;set;}
    public List<SVMXC__Skill__c> skillLst {get; set;}
    
    public boolean showEditpanel {get; set;}
    public boolean showTechDetails {get; set;}
    public string subBusiness {get;set;}
     

    string sortFullExp ;

    public set<Id> skillIds ;
    
    
    // Variables for Sorting Functionality
    
    public String sortDirection = 'ASC';
    public String sortExp = 'SVMXC__Skill__r.GE_OG_DS_FSCC_EX_ID__c';
    
    public String sortExpression
    {
        get
        {
            return sortExp;
        }
        set
        {
        //if the column is clicked on then switch between Ascending and Descending modes
            if (value == sortExp)
            sortDirection = (sortDirection == 'ASC')? 'DESC' : 'ASC';
            else
            sortDirection = 'ASC';
            sortExp = value;
        }
    }
    
    public String getSortDirection()
    {
        //if not column is selected 
        if (sortExpression == null || sortExpression == '')
        return 'ASC';
        else
        return sortDirection;
    }

    public void setSortDirection(String value)
    {  
        sortDirection = value;
    }
  
    
    
    
    public SVMXC__Service_Group_Members__c techObj {get;set;}

   @TestVisible
   class expertiseWrapper
    {
        public boolean isSelect{get;set;}
        public SVMXC__Service_Group_Skills__c objExpert{get;set;}
        public expertiseWrapper()
        {
            isSelect = false;
            objExpert = new SVMXC__Service_Group_Skills__c();
        }
    }
    
    @TestVisible
    class skillWrapper
    {
        public boolean isSelect1{get;set;}
        public SVMXC__Skill__c objSkill{get;set;}
        public skillWrapper(SVMXC__Skill__c Sk)
        {
            this.isSelect1 = false;
            this.objSkill = Sk;
        }
    }
    
    public List<expertiseWrapper>  expertwrprList{get;set;}  //transient
    public List<skillWrapper> skillwrprList{get;set;}
    

    public String subBusines{ get; set; }
    public String business{ get; set; }
     Map<String,GE_OG_Business_Sub_Business__c> bSB = GE_OG_Business_Sub_Business__c.getall();
   
    public list<selectoption> getsubBusinessList() {
        list<selectoption> subBusiOptions= new list<selectoption> ();
        subBusiOptions.add(new selectoption('','---SELECT ONE---'));
        if(business==null){
            business='';
        }
        else
        if(bSB.containskey(business)){
            subBusiOptions.clear();
            string sg = bSB.get(business).GE_OG_Sub_Business__c;
            for(string st: sg.split(';'))
            subBusiOptions.add(new selectoption(st,st));
        }

        return subBusiOptions;
    }

    public List<SelectOption> getBusinesslist() {
        List<SelectOption> business= new List<SelectOption>();
        business.add(new selectoption('','---SELECT ONE---'));
        list<string> businessname= new list<string>();
        businessname.addall(bSB.keyset());

        for(string s : businessname){
        business.add(new selectoption(s,s));

        }

        return business;
    }
    
    
    public GE_OG_CompetencyManagementController(){
        showEditpanel = false;
        showTechDetails = false;
      // setupPickValMap();
      // getPrimaryPickVals();
              
    init();    

    }
    public void showRecords(){
        showEditpanel = true;
    }
    
    
    Public void init(){
     
    
    expert = new SVMXC__Service_Group_Skills__c();
    expertwrprList = new List<expertiseWrapper>();
    expertLst = new List<SVMXC__Service_Group_Skills__c>();
    
    skills = new SVMXC__Skill__c();
    List<SVMXC__Skill__c> skills = new List<SVMXC__Skill__c>();
    skillwrprList = new List<skillWrapper>();
   
    
    String BusinessUnit;
    
    
    expertLst = [Select Name,GE_DRL_Skill_Category__c,SVMXC__Skill__r.Business__c,SVMXC__Skill__r.Sub_Business__c,SVMXC__Skill__c,SVMXC__Skill__r.GE_OG_PC_Complexity__c,SVMXC__Skill__r.GE_DRL_Skill_Category__c, GE_DRL_Target_Level__c,GE_PC_WorkOrders_Completed__c,Expertise_Level__c, SVMXC__Group_Member__c,
    GE_OG_Skill_Description__c,SVMXC__Skill__r.Name, GE_SS_Skill_Group__c, SVMXC__Group_Member__r.GE_SM_HQ_Business_Unit__c, SVMXC__Service_Group__c, SVMXC__Skill__r.GE_OG_DS_FSCC_EX_ID__c,GE_DRL_Current_Target_Level__c, LastModifiedById , LastModifiedDate, LastModifiedBy.Name, SVMXC__Group_Member__r.SVMXC__Service_Group__c, 
    SVMXC__Group_Member__r.SVMXC__Service_Group__r.Name,GE_OG_PC_Skill_Level_Target_Date__c from SVMXC__Service_Group_Skills__c where SVMXC__Group_Member__c =: expert.SVMXC__Group_Member__c ORDER BY SVMXC__Skill__r.GE_OG_DS_FSCC_EX_ID__c ];
    
    System.debug('****Business Unit*****' +BusinessUnit);
    
    
    }
    
    
    
    public void Go(){
        
        boolean check = false ;
        showEditpanel = false;
        expertLst = new List<SVMXC__Service_Group_Skills__c>();
        expertwrprList = new List<expertiseWrapper>();
        skillIds = new Set<Id>();
        skillLst = new List<SVMXC__Skill__c>();
        skillwrprList = new List<skillWrapper>();
        
        String BusinessUnit;
        String CareerTrack ;
        String SkillGroup;
        String SubBusiness;
      
        //build the full sort expression
       string sortFullExp = sortExpression  + ' ' + sortDirection ;
       Id TechnicianId = expert.SVMXC__Group_Member__c;
       
       Careertrack = expert.GE_DRL_Skill_Category__c;
       SkillGroup = expert.GE_SS_Skill_Group__c;      
    //  SubBusiness = skills.Sub_Business__c;
           
        SubBusiness= subBusines;
       
        System.debug('Sort Full Expression to be put on the VF Page'+sortFullExp);
        System.debug('Sort Expression to be put on the VF Page'+sortExpression);
        
        
         try{
         
         //expertLst = [Select Name, Complexity__c, GE_DRL_Skill_Category__c, SVMXC__Skill__c,SVMXC__Skill__r.GE_OG_PC_Complexity__c, SVMXC__Skill__r. , GE_DRL_GE_DRL_Target_Level__c,GE_PC_WorkOrders_Completed__c,Expertise_Level__c, SVMXC__Group_Member__c,GE_OG_Skill_Description__c,SVMXC__Skill__r.Name, SVMXC__Group_Member__r.GE_SM_HQ_Business_Unit__c, Technician_Business_Unit__c,SVMXC__Service_Group__c, SVMXC__Skill__r.GE_OG_DS_FSCC_EX_ID__c, LastModifiedById , LastModifiedDate, LastModifiedBy.Name, SVMXC__Group_Member__r.SVMXC__Service_Group__c, SVMXC__Group_Member__r.SVMXC__Service_Group__r.Name,GE_OG_PC_Skill_Level_Target_Date__c from SVMXC__Service_Group_Skills__c where SVMXC__Group_Member__c =: expert.SVMXC__Group_Member__c ORDER BY SVMXC__Skill__r.GE_OG_DS_FSCC_EX_ID__c ]; 
         
        
         
         if(expert.GE_DRL_Skill_Category__c!=null && expert.GE_SS_Skill_Group__c == null)
         {
        
           expertLst = Database.query('Select Name,SVMXC__Skill__c, GE_SS_Skill_Group__c,GE_DRL_Skill_Category__c,SVMXC__Skill__r.GE_OG_PC_Complexity__c, GE_DRL_Target_Level__c,GE_PC_WorkOrders_Completed__c,Expertise_Level__c, SVMXC__Skill__r.GE_DRL_Skill_Category__c, SVMXC__Group_Member__c,GE_OG_Skill_Description__c,SVMXC__Skill__r.Name, SVMXC__Group_Member__r.GE_SM_HQ_Business_Unit__c,SVMXC__Service_Group__c, SVMXC__Skill__r.GE_OG_DS_FSCC_EX_ID__c, LastModifiedById , GE_DRL_Current_Target_Level__c,LastModifiedDate, LastModifiedBy.Name, SVMXC__Group_Member__r.SVMXC__Service_Group__c, SVMXC__Group_Member__r.SVMXC__Service_Group__r.Name,GE_OG_PC_Skill_Level_Target_Date__c from SVMXC__Service_Group_Skills__c where SVMXC__Group_Member__c =\'' + expert.SVMXC__Group_Member__c + '\' AND SVMXC__Skill__r.GE_DRL_Skill_Category__c includes (\''+expert.GE_DRL_Skill_Category__c +'\') ORDER BY ' +sortFullExp );
         }
         else if(expert.GE_DRL_Skill_Category__c!=null && expert.GE_SS_Skill_Group__c != null)
         {
            expertLst = Database.query('Select Name,SVMXC__Skill__c, GE_DRL_Skill_Category__c,SVMXC__Skill__r.GE_OG_PC_Complexity__c, GE_DRL_Target_Level__c,GE_SS_Skill_Group__c, GE_PC_WorkOrders_Completed__c,Expertise_Level__c, SVMXC__Skill__r.GE_DRL_Skill_Category__c, SVMXC__Group_Member__c,GE_OG_Skill_Description__c,SVMXC__Skill__r.Name, SVMXC__Group_Member__r.GE_SM_HQ_Business_Unit__c,SVMXC__Service_Group__c, SVMXC__Skill__r.GE_OG_DS_FSCC_EX_ID__c, LastModifiedById , GE_DRL_Current_Target_Level__c,LastModifiedDate, LastModifiedBy.Name, SVMXC__Group_Member__r.SVMXC__Service_Group__c, SVMXC__Group_Member__r.SVMXC__Service_Group__r.Name,GE_OG_PC_Skill_Level_Target_Date__c from SVMXC__Service_Group_Skills__c where SVMXC__Group_Member__c =\'' + expert.SVMXC__Group_Member__c + '\' AND SVMXC__Skill__r.GE_DRL_Skill_Category__c includes (\''+expert.GE_DRL_Skill_Category__c +'\') AND SVMXC__Skill__r.GE_OG_DS_Product_Group__c in  (\''+expert.GE_SS_Skill_Group__c +'\') ORDER BY ' +sortFullExp );
         }
         
         else if(expert.GE_DRL_Skill_Category__c==null && expert.GE_SS_Skill_Group__c == null)
         {
         
            expertLst = Database.query('Select Name,SVMXC__Skill__c, GE_DRL_Skill_Category__c,SVMXC__Skill__r.GE_OG_PC_Complexity__c, GE_DRL_Target_Level__c,GE_PC_WorkOrders_Completed__c,Expertise_Level__c, SVMXC__Skill__r.GE_DRL_Skill_Category__c, SVMXC__Group_Member__c,GE_OG_Skill_Description__c,SVMXC__Skill__r.Name, SVMXC__Group_Member__r.GE_SM_HQ_Business_Unit__c,GE_DRL_Current_Target_Level__c,SVMXC__Service_Group__c, SVMXC__Skill__r.GE_OG_DS_FSCC_EX_ID__c, LastModifiedById , LastModifiedDate, LastModifiedBy.Name, SVMXC__Group_Member__r.SVMXC__Service_Group__c, SVMXC__Group_Member__r.SVMXC__Service_Group__r.Name,GE_OG_PC_Skill_Level_Target_Date__c from SVMXC__Service_Group_Skills__c where SVMXC__Group_Member__c =\'' + expert.SVMXC__Group_Member__c + '\' ORDER BY ' +sortFullExp );
          }
         

         System.debug('************Expertise List Size*************'+expertLst.size());
        for(integer i =0; i<expertLst.size();i++)
        {
            skillIds.Add(expertLst[i].SVMXC__Skill__c);
        }
        
        techObj = [Select Id, SVMXC__Service_Group__c , GE_SM_HQ_Business_Unit__c, GE_DS_Career_Track_Level__c,  GE_DS_FSE_Discipline__c,
                          GE_OG_Technician_Business_Unit__c, SVMXC__Service_Group__r.Name,  GE_OG_DS_Supervisor_Name__c, GE_SM_HQ_SSO_ID__c, 
                          SVMXC__Active__c, GE_DRL_Target_Date__c, RecordTypeId from SVMXC__Service_Group_Members__c 
                          where Id =: expert.SVMXC__Group_Member__c ]; // AND RecordTypeId = '012A0000000oAiP' ];
            System.debug('Technician Id'+techObj);
        
            BusinessUnit = techObj.GE_SM_HQ_Business_Unit__c;
 
            
            
            showTechDetails = true;
            
    
        for(SVMXC__Service_Group_Skills__c objExpertise : expertLst)
        {
            expertiseWrapper objWrp = new expertiseWrapper();
            //Added because objWrp is a Private variable which is not accessible in test class
            If(test.isRunningTest()){objWrp.isSelect=true;}
            objWrp.objExpert = objExpertise;
            expertwrprList.add(objWrp);
        }
        
            
     
        System.debug('******Business Unit******'+BusinessUnit);
        System.debug('******Careertrack ******'+CareerTrack);
        if(Careertrack!=null && SkillGroup==null)
        {
            skillLst = [Select id,Name, SVMXC__Description__c, GE_OG_PC_Complexity__c,GE_DRL_Skill_Category__c, GE_OG_DS_Product_Category__c, GE_OG_DS_Product_Group__c,Sub_Business__c, SVMXC__Skill_Category__c, GE_OG_DS_FSCC_EX_ID__c from SVMXC__Skill__c where Id Not in :skillIds  and  GE_DRL_Skill_Category__c includes (:Careertrack)];// Sub_Business__c =: BusinessUnit and
        }
        if(Careertrack!=null && SkillGroup!=null)
        {
            skillLst = [Select id,Name, SVMXC__Description__c, GE_OG_PC_Complexity__c,GE_DRL_Skill_Category__c, GE_OG_DS_Product_Category__c, Sub_Business__c,GE_OG_DS_Product_Group__c, SVMXC__Skill_Category__c, GE_OG_DS_FSCC_EX_ID__c from SVMXC__Skill__c where Id Not in :skillIds and  GE_DRL_Skill_Category__c includes (:Careertrack) and GE_OG_DS_Product_Group__c in (:SkillGroup)];// Sub_Business__c =: BusinessUnit and
        }
        if(SubBusiness!=Null)
        {
            skillLst = [Select id,Name, SVMXC__Description__c, GE_OG_PC_Complexity__c,GE_DRL_Skill_Category__c, GE_OG_DS_Product_Category__c, Sub_Business__c,
            GE_OG_DS_Product_Group__c, SVMXC__Skill_Category__c, GE_OG_DS_FSCC_EX_ID__c from SVMXC__Skill__c where Sub_Business__c =: SubBusiness and Id Not in :skillIds ];
        
        }
        if(SubBusiness!=Null && Careertrack != Null &&  SkillGroup!=null)
        {
            skillLst = [Select id,Name, SVMXC__Description__c, GE_OG_PC_Complexity__c,GE_DRL_Skill_Category__c, GE_OG_DS_Product_Category__c, Sub_Business__c,
            GE_OG_DS_Product_Group__c, SVMXC__Skill_Category__c, GE_OG_DS_FSCC_EX_ID__c from SVMXC__Skill__c where Sub_Business__c =: SubBusiness and Id Not in :skillIds 
            and  GE_DRL_Skill_Category__c includes (:Careertrack) and GE_OG_DS_Product_Group__c in (:SkillGroup) ];
        
        }
         if(SubBusiness!=Null && Careertrack != Null &&  SkillGroup==null)
        {
            skillLst = [Select id,Name, SVMXC__Description__c, GE_OG_PC_Complexity__c,GE_DRL_Skill_Category__c, GE_OG_DS_Product_Category__c, Sub_Business__c,
            GE_OG_DS_Product_Group__c, SVMXC__Skill_Category__c, GE_OG_DS_FSCC_EX_ID__c from SVMXC__Skill__c where Sub_Business__c =: SubBusiness and Id Not in :skillIds 
            and  GE_DRL_Skill_Category__c includes (:Careertrack) ];
        
        }
        
        System.debug('******Skill List ******'+skillLst.size());
    
    for(SVMXC__Skill__c objskills : skillLst)
        {
            skillWrapper objWrp1 = new skillWrapper(objskills);
            //Added because objWrp1 is a Private variable which is not accessible in test class
            If(test.isRunningTest()){objWrp1.isSelect1=true;}
            //objWrp1.objSkill = objskills;
            skillwrprList.add(objWrp1);
        }
        System.debug('******SkillWrapList ******'+skillwrprList.size());
        }
        catch(exception e)
        {
                 ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Please select Technician '));
        }
    }
    
     public PageReference saveExpertise()
        {
            List<SVMXC__Service_Group_Skills__c>  expertiseListtosave = new List<SVMXC__Service_Group_Skills__c>();
            List<expertiseWrapper> temp = new List<expertiseWrapper>();
            temp = expertwrprList;
            
            expertwrprList = new List<expertiseWrapper>();
            integer count = 0;
            for(expertiseWrapper expertWrapObj : temp)
                {
                    if (expertWrapObj.isSelect == true)
                    {
                        count = count +1;
                        ApexPages.getMessages().clear();
                        //expertWrapObj.objExpert.Expertise_Level__c = ' Level 1';
                        expertiseListtosave.add(expertWrapObj.objExpert);
                    }
                    else
                    {
                        expertwrprList.add(expertWrapObj);
                    }
                }
                
            if(count==0){
                CheckSelection();
            }
            else{
                CheckSuccess();
                if(expertiseListtosave.size()>0)
                update expertiseListtosave;
                go();
            }   
            
            
            return null;
        }
        
     public PageReference Cancel(){
        go();
            return null;
        }
        
        
     public Void CheckSelection(){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Please select Exeprtise record to update'));
        }

     public Void CheckSuccess(){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Confirm,'Expertise  Updated'));
        }
        
         public Void CheckSkillSelection(){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Please select Skills to add an Expertise Record'));
        }

     public void CheckaddExpertiseSuccess()
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Confirm,'New Expertise Records  Added'));     
        }       
        
     
    
     public PageReference addExpertise() {
        List<SVMXC__Service_Group_Skills__c> expertiseListtoInsert =new List<SVMXC__Service_Group_Skills__c>();
        List<skillWrapper> temp = new List<skillWrapper>();
        integer count = 0;
        
        temp = skillwrprList;
        
        skillwrprList = new List<skillWrapper>();
        
        for(skillWrapper skillWrapObj: temp)
        {
            if(skillWrapObj.isSelect1)
            {
                count = count +1;
                ApexPages.getMessages().clear();
                SVMXC__Service_Group_Skills__c newexp = new SVMXC__Service_Group_Skills__c();
                newexp.SVMXC__Service_Group__c = techObj.SVMXC__Service_Group__c;
                newexp.SVMXC__Skill__c=skillWrapObj.objSkill.Id;
                newexp.SVMXC__Group_Member__c=techObj.Id;
                newexp.GE_DRL_Skill_Category__c = skillWrapObj.objSkill.GE_DRL_Skill_Category__c ;
                newexp.GE_SS_Skill_Group__c = skillWrapObj.objSkill.GE_OG_DS_Product_Group__c;
                expertiseListtoInsert.add(newexp);
            }
            
            else
            {
                skillwrprList.add(skillWrapObj);
            }
        } 
        if (count==0)
            {
                CheckSkillSelection();
            }   
        else
            {
                CheckaddExpertiseSuccess();
            }
        if (expertiseListtoInsert.size()>0)
        insert expertiseListtoInsert;
        go();
       return null;
       
        
    }

}