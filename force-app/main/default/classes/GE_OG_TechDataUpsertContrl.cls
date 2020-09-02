public without sharing class GE_OG_TechDataUpsertContrl {
    
    public Id techId = ApexPages.currentPage().getParameters().get('techId1');
    public string parmtype = ApexPages.currentPage().getParameters().get('recordType');
    public SVMXC__Service_Group_members__c technician {get;set;} 
    public GE_OG_SS_Master_Course__c courses{get;set;}
    public SVMXC__Skill__c skills{get;set;}
    
    public list<GE_OG_TechBean.courseAssignmentBean> lstCourseAssignmentBeans{get;set;}     
    public list<GE_OG_TechBean.certificationBean> lstCertificationBeans {get;set;} 
    public list<GE_OG_TechBean.visaBean> lstVisaBeans{get;set;}
    public list<GE_OG_TechBean.passportBean> lstPassportBeans{get;set;} 
    public list<GE_OG_TechBean.expertiseBean> lstExpertiseBeans {get;set;} 
    public List<GE_OG_SS_Master_Course__c> coursesLst {get; set;}
    public List<SVMXC__Skill__c> skillLst {get; set;}
    public List<skillWrapper> skillwrprList{get;set;}
    public List<CourseWrapper> cwrprList{get;set;}
    Public list<selectoption> skillGroupOptions{get;set;}
    public List<SelectOption> certNamesList {get; set;}
    List<GE_OG_GS_Course__c> courseAssignList = new List<GE_OG_GS_Course__c>();
    
    Public string category{get;set;}
    Public string skillGroup{get;set;}
    public string courseSource{get;set;}
    Public string courseCode{get;set;}
    Public string courseCategory{get;set;}
    Public string courseName{get;set;}
    Public string courseStatus{get;set;}
    Public string courseCriticality{get;set;}
    Public string courseTargetLevel{get;set;}
    Public string courseSearch{get;set;}
    public string legacyId{get;set;}
    public string certCategory{get;set;}
    public string certName{get;set;}
    Public String certStatus{get;set;}
    Public String certType{get;set;}
    public string additionalInfo{get;set;}
    Public String passportA{get;set;}
    Public String visaCountryA{get;set;}
    Public string visaforA{get;set;}
    Public string visaStatusA{get;set;}
    Public string passportNumberA {get;set;}
    public string passportTypeA{get;set;}
    public string passportCountryA{get;set;}
    public string passportStatusA{get;set;}
    public string passportIssuedByA{get;set;}
    //public string techattachName{get;set;}
   // Public string expertise{get;set;}
   // Public string associatedTo{get;set;}
    
    public Date attendedDate{get;set;}
    public Date passedDate{get;set;}    
    Public date aquiredDate{get;set;}
    Public date expiryDate{get;set;}
    Public Date targetDate{get;set;}
    Public date expiryDateA{get;set;}
    Public date issueDateA{get;set;}
    public Date passportExpiryDateA{get;set;}
    public Date passportIssueDateA{get;set;} 
    
    public integer passportremainingPagesA{get;set;}
    
    public Boolean showExpertise{get;set;}
    public Boolean showCourses{get;set;}
    public Boolean showCertification{get;set;}
    public Boolean showPassport{get;set;}
    public Boolean showVisa{get;set;}    
    
    Public Boolean expertDisplayBlock{get; set;}
    Public Boolean courseDisplayBlock{get; set;}
    Public Boolean certsDisplayBlock{get; set;}
    Public Boolean visaDisplayBlock{get; set;}
    Public Boolean passportDisplayBlock{get;set;}
    
    public boolean isSelectSkill{get;set;} 
    public boolean isSelectCour{get;set;}
    Public Boolean disablebButton{get;set;}
    
    public boolean showEditpanel {get; set;}  
    Public Boolean ShowCourseBlock{get;set;}
    Public Boolean ShowpageBlock{get;set;}
    Public Boolean ShowVisaBlock{get;set;}
    Public Boolean ShowpassportBlock{get;set;}  
    
    Public Boolean editExpertBlock{get;set;}
    Public Boolean editCourseBlock{get;set;}
    Public Boolean editCertsBlock{get;set;}
    Public Boolean editVisaBlock{get;set;}
    Public Boolean editPassportBlock{get;set;}  
    
    public set<id> courseIds = new set<id>();    
    public set<id> skillIds = new set<id>(); 
    
    Map<String,Id> pasportnumberMap = new Map<string,Id>();    
  //  Map<String,Id> visaMap = new Map<string,Id>(); 
  //  Map<String,Id> expertiseMap = new Map<string,Id>();
  //  Map<String,Id> courseMap = new Map<string,Id>();
  //  Map<String,Id> certsMap = new Map<string,Id>();
         
    public pagereference goback(){
        PageReference editPage = new PageReference('/apex/GE_OG_TechData?techId='+techId);
        editPage.setRedirect(true);
        return editPage;
    }
    public void showRecords(){
        showEditpanel = true;
        disablebButton =true;
    }   
    Public Void ShowBlockMethod(){
       ShowpageBlock = true;
       disablebButton =true;
       
    }   
    Public void ShowCourseMethod(){ 
          ShowCourseBlock = true;
          disablebButton =true;
    } 
    Public void ShowpassportMethod(){
       ShowpassportBlock = true;
       disablebButton =true;
    } 
    Public void ShowVisaMethod(){
       ShowVisaBlock = true;
        disablebButton =true;
    }
    Public void editpassportMethod(){
       passportDisplayBlock = false;
       editPassportBlock= true;
       disablebButton =true;       
    }   
    Public void editVisaMethod(){
       visaDisplayBlock = false;
       editVisaBlock= true;
       disablebButton =true;       
    }  
    Public void editCertsMethod(){
       certsDisplayBlock= false;
       editCertsBlock= true;
       disablebButton =true;       
    }  
    Public void editCourseMethod(){
       courseDisplayBlock= false;
       editCourseBlock = true;
       disablebButton =true;       
    }     
    Public void editExpertMethod(){
       expertDisplayBlock= false;
       editExpertBlock = true;
       disablebButton = true;       
    } 
    GE_OG_TechDataUpsertHelper helper = new GE_OG_TechDataUpsertHelper();
    Public GE_OG_TechDataUpsertContrl(){
          
        technician = [ SELECT Id, Name,SVMXC__Service_Group__c, SVMXC__Service_Group__r.Name, SVMXC__Salesforce_User__r.Id FROM SVMXC__Service_Group_members__c
       WHERE Id =: techId]; 
       
       if(parmtype =='Expert')
       {
           showExpertise=true;
           showCourses=false;
           showCertification=false;
           showPassport=false;
           showVisa=false;
           expertDisplayBlock =true;
           skillwrprList = new List<skillWrapper>();
           lstExpertiseBeans = helper.getExpertises(techId);
           }
           
       if(parmtype =='Course'){
           showExpertise=false;
           showCourses=true;
           showCertification=false;
           showPassport=false;
           showVisa=false;
           courseDisplayBlock = true;
           lstCourseAssignmentBeans = helper.getCourseAssignments(techId); 
           }
           
      if(parmtype=='Certification'){
           showExpertise=false;
           showCourses=false;
           showCertification=true;
           showPassport=false;
           showVisa=false;
           certsDisplayBlock = true;
           lstCertificationBeans = helper.getCertifications(techId);
           }
           
      if(parmtype=='Passport'){
           showExpertise=false;
           showCourses=false;
           showCertification=false;
           showPassport=true;
           showVisa=false;
           passportDisplayBlock = true;           
           lstPassportBeans = helper.getPassports(techId);
           }
           
       if(parmtype=='Visa'){
           showExpertise=false;
           showCourses=false;
           showCertification=false;
           showPassport=false;
           showVisa=true;
           visaDisplayBlock = true;
           lstVisaBeans = helper.getVisas(techId);          
           }
           
    }

    @TestVisible
    class skillWrapper
    {
        public boolean isSelectSkill{get;set;}
        public SVMXC__Skill__c objSkill{get;set;}
        public skillWrapper(SVMXC__Skill__c Sk)
        {
            this.isSelectSkill = false;
            this.objSkill = Sk;
        }
    }       
            
    @TestVisible
    class CourseWrapper
    {
        public boolean isSelectCour{get;set;}
        public GE_OG_SS_Master_Course__c objCourse{get;set;}
        public CourseWrapper(GE_OG_SS_Master_Course__c course)
        {
            this.isSelectCour= false;
            this.objCourse= course;
        }
    }    
            
    public PageReference Cancelexpt(){        
       disablebButton =false;
        PageReference editPage = new PageReference('/apex/GE_OG_TechDataUpsert?techId1='+techId);
           editPage.getParameters().put('recordType','Expert');        
           editPage.setRedirect(true);
           return editPage;
            
        }
                
    public PageReference cancelCour(){
            lstCourseAssignmentBeans = helper.getCourseAssignments(techId); 
            ShowCourseBlock =false;  
            disablebButton =false; 
             PageReference editPage = new PageReference('/apex/GE_OG_TechDataUpsert?techId1='+techId);
           editPage.getParameters().put('recordType','Course');        
           editPage.setRedirect(true);
           return editPage;      
            
        }
    public PageReference cancelCerts(){
           lstCertificationBeans = helper.getCertifications(techId);
           ShowpageBlock=false;
           disablebButton =false;
           PageReference editPage = new PageReference('/apex/GE_OG_TechDataUpsert?techId1='+techId);
           editPage.getParameters().put('recordType','Certification');        
           editPage.setRedirect(true);
           return editPage;            
        }
    public PageReference cancelVisa(){
           lstVisaBeans = helper.getVisas(techId); 
           ShowVisaBlock =false;
           disablebButton =false;
           PageReference editPage = new PageReference('/apex/GE_OG_TechDataUpsert?techId1='+techId);
           editPage.getParameters().put('recordType','Visa');        
           editPage.setRedirect(true);
           return editPage;           
        }
     public PageReference cancelPassport(){
           lstPassportBeans = helper.getPassports(techId);
           ShowpassportBlock =false;
           disablebButton =false;
           PageReference editPage = new PageReference('/apex/GE_OG_TechDataUpsert?techId1='+techId);
           editPage.getParameters().put('recordType','Passport');        
           editPage.setRedirect(true);
           return editPage;           
        }
    
    public List<SelectOption> getLevel(){
          
           Schema.sObjectType expertiseObj = SVMXC__Service_Group_Skills__c.getSObjectType();
           Schema.DescribeSObjectResult expertDescribe = expertiseObj.getDescribe();
           Map<String, Schema.SObjectField> expfieldMap = expertDescribe.fields.getMap();          
           List<Schema.PicklistEntry> exprtlevelvalues = expfieldMap.get('Expertise_Level__c').getDescribe().getPickListValues();
           List<selectOption> options = new List<selectOption>();

           for (Schema.PicklistEntry a : exprtlevelvalues) {
                      options.add(new selectOption(a.getLabel(), a.getValue()));
          }
      return options;
    }
    public List<SelectOption> getcategorylist() {
        List<SelectOption> category = new List<SelectOption>();
        category.add(new selectoption('','---SELECT ONE---'));
        set<string> categoryUnique= new set<string>();
        for(GE_OG_Skill_Category_Group__c setting : GE_OG_Skill_Category_Group__c.getAll().values()){
        if(!categoryUnique.contains(setting.GE_OG_Skill_Category__c)){
            category.add(new SelectOption(setting.name, setting.GE_OG_Skill_Category__c));
            categoryUnique.add(setting.GE_OG_Skill_Category__c);       
            }
        }         
        return category;
    }
    public PageReference getgroupList() {        
        skillGroupOptions= new list<selectoption>();
        skillGroupOptions.add(new selectoption('','---SELECT ONE---'));
         String temp = '';
         for(GE_OG_Skill_Category_Group__c setting : GE_OG_Skill_Category_Group__c.getAll().values()) {
            if (setting.Name == category) {
                temp = setting.GE_OG_Skill_Category__c;
                }
            }
            for(GE_OG_Skill_Category_Group__c setting : GE_OG_Skill_Category_Group__c.getAll().values()) {
            if(setting.GE_OG_Skill_Category__c == temp){ 
                skillGroupOptions.add(new selectOption(setting.name,setting.GE_OG_Skill_Group__c));
                }
            
            }
        system.debug('****Skill Group*****'+skillGroupoptions);    
        return null;     
    }   
    public List<SelectOption> getCourStatus(){  
           Schema.sObjectType coursObj = GE_OG_GS_Course__c.getSObjectType();
           Schema.DescribeSObjectResult coursDescribe = coursObj.getDescribe();
           Map<String, Schema.SObjectField> coursfieldMap = coursDescribe.fields.getMap();           
                  
           List<Schema.PicklistEntry> coursStatusvalues = coursfieldMap.get('GE_OG_GS_Course_Status__c').getDescribe().getPickListValues();
           List<selectOption> options = new List<selectOption>();
           options.add(new selectoption('','None'));
           for (Schema.PicklistEntry a : coursStatusvalues ) {
                      options.add(new selectOption(a.getLabel(), a.getValue()));
          }
      return options; 
    }
    public List<SelectOption> getCourTargetLevel(){  
           Schema.sObjectType coursObj = GE_OG_GS_Course__c.getSObjectType();
           Schema.DescribeSObjectResult coursDescribe = coursObj.getDescribe();
           Map<String, Schema.SObjectField> coursfieldMap = coursDescribe.fields.getMap();           
                  
           List<Schema.PicklistEntry> coursTargetLevelvalues = coursfieldMap.get('GE_OG_GS_Target_Level__c').getDescribe().getPickListValues();
           List<selectOption> options = new List<selectOption>();
           options.add(new selectoption('','None'));
           for (Schema.PicklistEntry a : coursTargetLevelvalues ) {
                      options.add(new selectOption(a.getLabel(), a.getValue()));
          }
      return options;  
    }
    public List<SelectOption> getCourName(){  
           Schema.sObjectType coursObj = GE_OG_GS_Course__c.getSObjectType();
           Schema.DescribeSObjectResult coursDescribe = coursObj.getDescribe();
           Map<String, Schema.SObjectField> coursfieldMap = coursDescribe.fields.getMap();           
                  
           List<Schema.PicklistEntry> coursNamevalues = coursfieldMap.get('GE_OG_GS_Course_Name__c').getDescribe().getPickListValues();
           List<selectOption> options = new List<selectOption>();
           options.add(new selectoption('','None'));
           for (Schema.PicklistEntry a : coursNamevalues ) {
                      options.add(new selectOption(a.getLabel(), a.getValue()));
          }
      return options;
    }
    public List<SelectOption> getCourCriticality(){  
           Schema.sObjectType coursObj = GE_OG_GS_Course__c.getSObjectType();
           Schema.DescribeSObjectResult coursDescribe = coursObj.getDescribe();
           Map<String, Schema.SObjectField> coursfieldMap = coursDescribe.fields.getMap();           
                  
           List<Schema.PicklistEntry> coursCriticalityvalues = coursfieldMap.get('GE_DS_Criticality__c').getDescribe().getPickListValues();
           List<selectOption> options = new List<selectOption>();
           options.add(new selectoption('','None'));
           for (Schema.PicklistEntry a : coursCriticalityvalues ) {
                      options.add(new selectOption(a.getLabel(), a.getValue()));
          }
          return options;
    }
    public List<SelectOption> getCourCategory(){  
           Schema.sObjectType coursObj = GE_OG_GS_Course__c.getSObjectType();
           Schema.DescribeSObjectResult coursDescribe = coursObj.getDescribe();
           Map<String, Schema.SObjectField> coursfieldMap = coursDescribe.fields.getMap();           
                  
           List<Schema.PicklistEntry> coursCatgeryvalues = coursfieldMap.get('GE_OG_GS_Category__c').getDescribe().getPickListValues();
           List<selectOption> options = new List<selectOption>();
           options.add(new selectoption('','None'));
           for (Schema.PicklistEntry a : coursCatgeryvalues) {
                      options.add(new selectOption(a.getLabel(), a.getValue()));
          }
      return options;
    }
    public List<SelectOption> getCourCurrentLevl(){  
           Schema.sObjectType coursObj = GE_OG_GS_Course__c.getSObjectType();
           Schema.DescribeSObjectResult coursDescribe = coursObj.getDescribe();
           Map<String, Schema.SObjectField> coursfieldMap = coursDescribe.fields.getMap();           
                  
           List<Schema.PicklistEntry> coursCurrentLevelvalues = coursfieldMap.get('GE_OG_GS_Current_Level__c').getDescribe().getPickListValues();
           List<selectOption> options = new List<selectOption>();
           options.add(new selectoption('','None'));
           for (Schema.PicklistEntry a : coursCurrentLevelvalues ) {
                      options.add(new selectOption(a.getLabel(), a.getValue()));
          }
      return options;
    }
    public List<SelectOption> getCourTrainingPath(){  
           Schema.sObjectType coursObj = GE_OG_GS_Course__c.getSObjectType();
           Schema.DescribeSObjectResult coursDescribe = coursObj.getDescribe();
           Map<String, Schema.SObjectField> coursfieldMap = coursDescribe.fields.getMap();           
                  
           List<Schema.PicklistEntry> courspathvalues = coursfieldMap.get('GE_OG_GS_Training_Path__c').getDescribe().getPickListValues();
           List<selectOption> options = new List<selectOption>();
           options.add(new selectoption('','None'));
           for (Schema.PicklistEntry a : courspathvalues ) {
                      options.add(new selectOption(a.getLabel(), a.getValue()));
          }
          return options;
    }
    public List<SelectOption> getCertscategory(){  
        List<selectOption> options = new List<selectOption>();
        options.add(new selectoption('','--Select One--'));
        set<String> setUniqueCategory = new set<String>();
        for(GE_OG_Certification_map__c setting : GE_OG_Certification_map__c.getAll().values()){
        if(!setUniqueCategory.contains(setting.GE_OG_CertsCategory__c)){
            options.add(new SelectOption(setting.name, setting.GE_OG_CertsCategory__c));
            setUniqueCategory.add(setting.GE_OG_CertsCategory__c);       
            }
        }    
        return options;
    }
    public PageReference getCertsName(){  
          certNamesList  = new List<selectOption>();
          System.debug('***Category***'+certCategory);
          String temp = '';
          certNamesList.add(new selectoption('','--Select One--'));
          for(GE_OG_Certification_map__c setting : GE_OG_Certification_map__c.getAll().values()) {
            if (setting.Name == certCategory) {
                temp = setting.GE_OG_CertsCategory__c;
                }
            }
            for(GE_OG_Certification_map__c setting : GE_OG_Certification_map__c.getAll().values()) {
            if(setting.GE_OG_CertsCategory__c == temp){ 
                certNamesList.add(new selectOption(setting.name,setting.GE_OG_Certification_Name__c));
            }
            
        }
        return null;
    }
    public List<SelectOption> getcertStatusList(){  
           Schema.sObjectType certObj = GE_OG_GS_Certification__c.getSObjectType();
           Schema.DescribeSObjectResult certDescribe = certObj.getDescribe();
           Map<String, Schema.SObjectField> certfieldMap = certDescribe.fields.getMap();           
                  
           List<Schema.PicklistEntry> certStatusvalues = certfieldMap.get('GE_OG_GS_Status__c').getDescribe().getPickListValues();
           List<selectOption> options = new List<selectOption>();
           options.add(new selectoption('','None'));
           for (Schema.PicklistEntry a : certStatusvalues) {
                      options.add(new selectOption(a.getLabel(), a.getValue()));
          }
      return options;
    }
    public List<SelectOption> getcertTypeList(){  
           Schema.sObjectType certObj = GE_OG_GS_Certification__c.getSObjectType();
           Schema.DescribeSObjectResult certDescribe = certObj.getDescribe();
           Map<String, Schema.SObjectField> certfieldMap = certDescribe.fields.getMap();           
                  
           List<Schema.PicklistEntry> certTypevalues = certfieldMap.get('GE_OG_DRL_Certificate_Type__c').getDescribe().getPickListValues();
           List<selectOption> options = new List<selectOption>();
           options.add(new selectoption('','None'));
           for (Schema.PicklistEntry a : certTypevalues) {
                      options.add(new selectOption(a.getLabel(), a.getValue()));
          }
      return options;
    }   
    public List<SelectOption> getpassportCountrylst(){  
           Schema.sObjectType passObj = GE_OG_GS_Passport__c.getSObjectType();
           Schema.DescribeSObjectResult passDescribe = passObj.getDescribe();
           Map<String, Schema.SObjectField> passfieldMap = passDescribe.fields.getMap();
                  
           List<Schema.PicklistEntry> passCountryValues = passfieldMap.get('GE_OG_GS_Passport_Country__c').getDescribe().getPickListValues();
           List<selectOption> options = new List<selectOption>();
           options.add(new selectoption('','None'));

           for (Schema.PicklistEntry a : passCountryValues) {
                      options.add(new selectOption(a.getLabel(), a.getValue()));
           }
           return options;
    }
    public List<SelectOption> getpassportStatuslst(){  
           Schema.sObjectType passObj = GE_OG_GS_Passport__c.getSObjectType();
           Schema.DescribeSObjectResult passDescribe = passObj.getDescribe();
           Map<String, Schema.SObjectField> passfieldMap = passDescribe.fields.getMap();
                  
           List<Schema.PicklistEntry> passStatusValues = passfieldMap.get('GE_OG_GS_Passport_Status__c').getDescribe().getPickListValues();
           List<selectOption> options = new List<selectOption>();

           options.add(new selectoption('','None'));
           for (Schema.PicklistEntry a : passStatusValues) {
                      options.add(new selectOption(a.getLabel(), a.getValue()));
           }
            return options;
    }
    public List<SelectOption> getpassportTypelst(){  
           Schema.sObjectType passObj = GE_OG_GS_Passport__c.getSObjectType();
           Schema.DescribeSObjectResult passDescribe = passObj.getDescribe();
           Map<String, Schema.SObjectField> passfieldMap = passDescribe.fields.getMap();                  
           List<Schema.PicklistEntry> passTypeValues = passfieldMap.get('GE_OG_GS_Passport_Type__c').getDescribe().getPickListValues();
           List<selectOption> options = new List<selectOption>();
           options.add(new selectoption('','None'));
           for (Schema.PicklistEntry a : passTypeValues) {
                      options.add(new selectOption(a.getLabel(), a.getValue()));
           }
            return options;
    }
    public List<selectOption> getPassports(){    
         List<GE_OG_GS_Passport__c> passportList = new List<GE_OG_GS_Passport__c>();        
        
         passportList  = [Select id, Name, GE_OG_GS_Passport_Expiry__c, GE_OG_GS_Passport_Expiry_Date__c, GE_OG_GS_Passport_Type__c, 
        GE_OG_GS_Remaining_Pages__c,GE_OG_GS_Passport_Number__c from GE_OG_GS_Passport__c where GE_OG_GS_Technician__r.Id=:techId 
        ORDER BY Name];  
         List<selectOption> options = new List<selectOption>();
        options.add(new selectoption('','None'));
        for(GE_OG_GS_Passport__c pspObj : passportList ){         
          pasportnumberMap.put(pspObj.GE_OG_GS_Passport_Number__c,pspObj.Id);
          options.add(new selectOption(pspObj.GE_OG_GS_Passport_Number__c,pspObj.GE_OG_GS_Passport_Number__c)); 
        } 
        return options;
    }       
    public List<SelectOption> getVisacountry(){  
           Schema.sObjectType visaObj = GE_OG_GS_Visa__c.getSObjectType();
           Schema.DescribeSObjectResult visaDescribe = visaObj.getDescribe();
           Map<String, Schema.SObjectField> visafieldMap = visaDescribe.fields.getMap();           
                  
           List<Schema.PicklistEntry> visacountryvalues = visafieldMap.get('GE_OG_GS_Visa_Country__c').getDescribe().getPickListValues();
           List<selectOption> options = new List<selectOption>();
           options.add(new selectoption('','None'));
           for (Schema.PicklistEntry a : visacountryvalues) {
                      options.add(new selectOption(a.getLabel(), a.getValue()));
          }
      return options;
    }
    public List<SelectOption> getVisaStatus(){  
           Schema.sObjectType visaObj = GE_OG_GS_Visa__c.getSObjectType();
           Schema.DescribeSObjectResult visaDescribe = visaObj.getDescribe();
           Map<String, Schema.SObjectField> visafieldMap = visaDescribe.fields.getMap();           
                  
           List<Schema.PicklistEntry> visacountryvalues = visafieldMap.get('GE_OG_GS_Visa_Status__c').getDescribe().getPickListValues();
           List<selectOption> options = new List<selectOption>();
           options.add(new selectoption('','None'));
           for (Schema.PicklistEntry a : visacountryvalues) {
                      options.add(new selectOption(a.getLabel(), a.getValue()));
          }
          return options;
    }
    public List<SelectOption> getVisafor(){  
           Schema.sObjectType visaObj = GE_OG_GS_Visa__c.getSObjectType();
           Schema.DescribeSObjectResult visaDescribe = visaObj.getDescribe();
           Map<String, Schema.SObjectField> visafieldMap = visaDescribe.fields.getMap();           
                  
           List<Schema.PicklistEntry> visaforvalues = visafieldMap.get('GE_OG_GS_Visa_For__c').getDescribe().getPickListValues();
           List<selectOption> options = new List<selectOption>();
           options.add(new selectoption('','None'));
           for (Schema.PicklistEntry a : visaforvalues) {
                      options.add(new selectOption(a.getLabel(), a.getValue()));
          }
      return options;
    }
    
  
    Public PageReference Go(){
        showEditpanel= true;
        skillwrprList = new List<skillWrapper>();
        List<SVMXC__Service_Group_Skills__c> expertiseList = new List<SVMXC__Service_Group_Skills__c>();
        List<GE_OG_TechBean.expertiseBean>  lstExpertiseBeans = new List<GE_OG_TechBean.expertiseBean>();
        string selectedCateg; 
        string selectedGroup;
          for(GE_OG_Skill_Category_Group__c setting : GE_OG_Skill_Category_Group__c.getAll().values()) { 
            
            if (setting.Name == category) {
                selectedCateg= setting.GE_OG_Skill_Category__c;
                }
             if (setting.Name == skillGroup) {
                selectedGroup = setting.GE_OG_Skill_Group__c;
                }   
            }      
             system.debug('******Group******'+skillGroup);
            system.debug('******Category******'+category +selectedCateg ); 
      
        if(selectedCateg!=null && (selectedGroup ==null || selectedGroup =='None')){
            system.debug('******Group******'+skillGroup);
            system.debug('******Category******'+category +selectedCateg );
            skillLst = [Select id,Name, SVMXC__Description__c, GE_OG_PC_Complexity__c,GE_DRL_Skill_Category__c, GE_OG_DS_Product_Category__c, GE_OG_DS_Product_Group__c,Sub_Business__c, SVMXC__Skill_Category__c, GE_OG_DS_FSCC_EX_ID__c from SVMXC__Skill__c where Id Not in :skillIds and  GE_DRL_Skill_Category__c includes (:selectedCateg)];
        }
        if(selectedCateg!=null && selectedGroup !=null && selectedGroup !='None'){
            skillLst = [Select id,Name, SVMXC__Description__c, GE_OG_PC_Complexity__c,GE_DRL_Skill_Category__c, GE_OG_DS_Product_Category__c, Sub_Business__c,GE_OG_DS_Product_Group__c, SVMXC__Skill_Category__c, GE_OG_DS_FSCC_EX_ID__c from SVMXC__Skill__c where Id Not in :skillIds and  GE_DRL_Skill_Category__c includes (:selectedCateg) and GE_OG_DS_Product_Group__c in (:selectedGroup)];
        }
        system.debug('****SkillList*****'+skillLst);
        
        if(skillLst.size() >0){
        for(SVMXC__Skill__c objskills : skillLst){
            skillWrapper objWrp1 = new skillWrapper(objskills);
            if(test.isRunningTest()){objWrp1.isSelectSkill=true;}
            skillwrprList.add(objWrp1);
            }
        }
        return null;
    }
     
    Public Pagereference courseSearch(){
            ShowCourseBlock=true;
            courseAssignList = [Select id, Name, GE_OG_GS_Category__c, GE_OG_GS_Course_Name__c, GE_OG_GS_Course_Status__c,  
            GE_OG_GS_Target_Level__c, GE_OG_GS_Attended_Date__c, GE_OG_GS_Passed_Date__c, GE_DRL_Course_Expiry__c, 
            GE_OG_SS_Course_Source__c, GE_DS_Criticality__c, GE_OG_GS_Score__c,GE_OG_SS_Master_Course__r.Name, 
            GE_OG_GS_Cross_Training_Plan__c, GE_OG_GS_Training_Path__c,GE_OG_GS_Current_Level__c, GE_OG_DRL_Course_Code__c 
            from GE_OG_GS_Course__c where GE_OG_GS_Course_Technician__r.Id=: techId];  
            
            for(GE_OG_GS_Course__c courseObj : courseAssignList ){ 
                courseIds.add(courseObj.GE_OG_SS_Master_Course__c);
            }
            
           coursesLst =[Select Id,Name,GE_OG_SS_Course_Active__c,GE_OG_SS_Course_Area__c,GE_OG_SS_Course_Category__c ,GE_OG_SS_Course_ID__c, 
           GE_OG_SS_Course_Source__c,GE_OG_SS_Customer_Course_Source_Owner__c,GE_OG_SS_Legacy_Id__c,GE_OG_SS_PL_Level__c,
           Renewal_Frequency__c,GE_OG_SS_Sub_PL__c from GE_OG_SS_Master_Course__c where Id not in: courseIds AND Name LIKE :('%' +courseSearch + '%')];
           System.debug('****Courses*****'+coursesLst.size()); 
           
           
           cwrprList= new List<CourseWrapper>();
           if(coursesLst.size()>0){
            for(GE_OG_SS_Master_Course__c objcour : coursesLst){
                CourseWrapper objWrp = new CourseWrapper(objcour);
                if(test.isRunningTest()){objWrp.isSelectCour=true;}
                cwrprList.add(objWrp);
                }     
            }
         
           return null;
    }
    
    
    public PageReference saveExpertise(){
            List<SVMXC__Service_Group_Skills__c>  expertiseListtosave = new List<SVMXC__Service_Group_Skills__c>();
            List<GE_OG_TechBean.expertiseBean>  temp = new List<GE_OG_TechBean.expertiseBean>();             
            integer count = 0;
            for(GE_OG_TechBean.expertiseBean tempexprt: lstExpertiseBeans){
                system.debug('*****IsSelect Expert****'+ tempexprt.isSelectExprt);  
                    if (tempexprt.isSelectExprt == true){
                        count = count +1;
                        ApexPages.getMessages().clear();
                        SVMXC__Service_Group_Skills__c updateexpert =new SVMXC__Service_Group_Skills__c();
                        updateexpert.Expertise_Level__c= tempexprt.expertiseLevel;
                        updateexpert.Id = tempexprt.expertiseId ;
                        updateexpert.SVMXC_Primary_Skill__c = tempexprt.primarySkill ;                        
                        expertiseListtosave.add(updateexpert);
                                                
                    }
                }               
            if(count==0){
                helper.CheckSelection();
            }
            else{
                helper.CheckSuccess();
                if(expertiseListtosave.size()>0){
                expertDisplayBlock= true;
                editExpertBlock = false;
                disablebButton = false;  
                update expertiseListtosave;
               // go();
                }
            }   
            lstExpertiseBeans =helper.getExpertises(techId);
            
            return null;
    }
        
    public PageReference addExpertise(){
            
         List<SVMXC__Service_Group_Skills__c> expertiseListtoInsert =new List<SVMXC__Service_Group_Skills__c>();
        List<skillWrapper> temp = new List<skillWrapper>();
        integer count = 0;
        
        temp = skillwrprList;
        
        skillwrprList = new List<skillWrapper>();
        
        for(skillWrapper skillWrapObj: temp){
            if(skillWrapObj.isSelectSkill){
                count = count +1;
                ApexPages.getMessages().clear();
                SVMXC__Service_Group_Skills__c newexp = new SVMXC__Service_Group_Skills__c();
                newexp.SVMXC__Service_Group__c = technician.SVMXC__Service_Group__c;
                newexp.SVMXC__Skill__c=skillWrapObj.objSkill.Id;
                newexp.SVMXC__Group_Member__c=techId;
                newexp.GE_DRL_Skill_Category__c = skillWrapObj.objSkill.GE_DRL_Skill_Category__c ;
                newexp.GE_SS_Skill_Group__c = skillWrapObj.objSkill.GE_OG_DS_Product_Group__c;
                expertiseListtoInsert.add(newexp);
            }
            
            else{
                skillwrprList.add(skillWrapObj);
            }
        } 
        if (count==0){
            helper.CheckSkillSelection();
                           
            }   
        else{
                helper.CheckaddExpertiseSuccess();
                showEditpanel = false;
                disablebButton =false; 
            }
        if (expertiseListtoInsert.size()>0){
        insert expertiseListtoInsert;
       // go();
          lstExpertiseBeans =helper.getExpertises(techId);
       }
       return null;
        
    }
    public PageReference addCourse(){
        
            List<GE_OG_GS_Course__c> courseListtoinsert=new List<GE_OG_GS_Course__c>();
        List<CourseWrapper> temp = new List<CourseWrapper>();
        integer count = 0;        
        temp = cwrprList;        
        cwrprList = new List<CourseWrapper>(); 
            
        for(CourseWrapper courWrapObj: temp){
            if(courWrapObj.isSelectCour){
                count = count +1;
                ApexPages.getMessages().clear();
                GE_OG_GS_Course__c newcour = new GE_OG_GS_Course__c();
                
                newcour.GE_OG_SS_Master_Course__c=courWrapObj.objCourse.Id;
                newcour.GE_OG_GS_Course_Technician__c=techId;
                newcour.GE_OG_GS_Category__c= courWrapObj.objCourse.GE_OG_SS_Course_Category__c;
                newcour.GE_DS_Renewal_Frequency__c= courWrapObj.objCourse.Renewal_Frequency__c;
                newcour.GE_OG_DRL_Course_Code__c=courWrapObj.objCourse.GE_OG_SS_Course_ID__c;
                newcour.GE_OG_GS_Category__c=courWrapObj.objCourse.GE_OG_SS_Course_Category__c;
               /* newcour.GE_OG_GS_Passed_Date__c=passedDate;
                newcour.GE_OG_DRL_Course_Code__c=courseCode;
                newcour.GE_OG_GS_Course_Technician__c=techId;
                newcour.GE_OG_GS_Category__c=courseCategory ;
                newcour.GE_OG_GS_Course_Name__c=courseName ;
                newcour.GE_OG_DRL_Course_Source__c=courseSource;
                newcour.GE_DS_Criticality__c=courseCriticality;
                newcour.GE_OG_GS_Target_Level__c=courseTargetLevel;                    
                newcour.GE_OG_GS_Course_Status__c=courseStatus;
                newcour.GE_OG_GS_Attended_Date__c=attendedDate;   */ 
               
                courseListtoinsert.add(newcour);
            }
            
            else{
                cwrprList.add(courWrapObj);
            }
        } 
               if(count==0){
                helper.CheckCourseSelection();
            }
            else{
                helper.CheckaddCourseSuccess();
                Insert CourseListtoinsert;
                ShowCourseBlock = false;
                disablebButton =false;
                lstCourseAssignmentBeans = helper.getCourseAssignments(techId);
            }   
        
        return null;
        
    }
       
    public PageReference saveCourse(){
            
            List<GE_OG_GS_Course__c>  CourseListtosave = new List<GE_OG_GS_Course__c>();
            List<GE_OG_TechBean.courseAssignmentBean>  temp = new List<GE_OG_TechBean.courseAssignmentBean>();
           
            integer count = 0;            
           
            for(GE_OG_TechBean.courseAssignmentBean temcourse: lstCourseAssignmentBeans){
                System.debug('***Attended Date***' +temcourse.attendedDate);
                    if (temcourse.isSelectCourse == true){
                        count = count +1;
                        ApexPages.getMessages().clear();
                        GE_OG_GS_Course__c  courAssi= new GE_OG_GS_Course__c ();
                        courAssi.GE_OG_GS_Attended_Date__c= temcourse.attendedDate;  
                        courAssi.GE_OG_GS_Passed_Date__c=temcourse.passedDate;
                        courAssi.Id= temcourse.courseId ;
                        courAssi.GE_OG_GS_Target_Level__c=temcourse.targetLevel ;                    
                        courAssi.GE_OG_GS_Course_Status__c=temcourse.courseStatus;
                        courAssi.GE_OG_GS_Current_Level__c=temcourse.currentLevel; 
                        courAssi.GE_OG_GS_Training_Path__c= temcourse.trainingPath ;
                        courAssi.GE_OG_GS_Score__c = temcourse.score ;   
                        CourseListtosave.add(courAssi);
                                                
                    }
                }
               
            if(count==0){
                helper.CheckSelectionCour();
            }
            else{
                helper.CheckSuccessCour();
                if(CourseListtosave.size()>0)
                System.debug('***Attended Date***' +CourseListtosave);
                courseDisplayBlock= true;
                editCourseBlock= false;
                disablebButton =false;   
                update CourseListtosave;
                lstCourseAssignmentBeans = helper.getCourseAssignments(techId);
                
            }   
           
            
            return null;
    }
    Public PageReference updateCerts(){
        List<GE_OG_GS_Certification__c> updateCertLst =new List<GE_OG_GS_Certification__c>();
        List<GE_OG_TechBean.certificationBean> tempc = new List<GE_OG_TechBean.certificationBean>();
        integer count =0;
        Boolean flag= true;
         
        for(GE_OG_TechBean.certificationBean temp :lstCertificationBeans){
        
            if(temp.isSelectCerts==true){
                
                ApexPages.getMessages().clear();
                 if(temp.status=='Acquired' && temp.acquiredDate==null){
                 ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Please fill Aquired Date'));
                 flag = false;
                 }
                 else if(temp.status=='Scheduled' && temp.targetDate==null){
                   ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Please fill Target Date'));
                   flag=false;
                 }                
                else{
                count = count +1;
                GE_OG_GS_Certification__c updatecert = new GE_OG_GS_Certification__c();
                updatecert.GE_OG_GS_Acquired_Date__c= temp.acquiredDate ;
                updatecert.GE_OG_GS_Cert_Expiry_Date__c=temp.expiryDate ;
                updatecert.Id= temp.certificationId ;
                updatecert.GE_OG_GS_Status__c=temp.status ;
                updatecert.GE_OG_DRL_Certificate_Type__c=temp.certificateType;
                updatecert.GE_OG_GS_Target_Date__c = temp.targetDate;
                updateCertLst.add(updatecert);
                }
            }
        }
        
         if (count==0 && flag == true){
            helper.CheckSelectionCert();
            }
            else{
              if(flag==true){            
                helper.CheckSuccessCert();}
              if(updateCertLst.size()>0){
                certsDisplayBlock= true;
                editCertsBlock= false;
                disablebButton =false; 
                Update updateCertLst; 
                lstCertificationBeans = helper.getCertifications(techId);           
                }
            } 
        return null;
    }
    
    Public PageReference addCerts(){
        
         ApexPages.getMessages().clear();
         if(certCategory==null || certName == null ||certStatus ==null ){
              ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Please enter the required fields Catergory and Certificate Name'));
         }
         else if(certStatus=='Acquired' && aquiredDate==null){
         ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Please fill Aquired Date'));
         }
         else if(certStatus=='Scheduled' && targetDate==null){
           ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Please fill Target Date'));
         }         
         else{
         ShowpageBlock=false;
        disablebButton =false;
         GE_OG_GS_Certification__c newcert = new GE_OG_GS_Certification__c();
         
         for(GE_OG_Certification_map__c setting : GE_OG_Certification_map__c.getAll().values()) { 
            
            if (setting.Name == certCategory) {
                newcert.GE_OG_GS_Category__c= setting.GE_OG_CertsCategory__c;
                }
             if (setting.Name == certName) {
                
                if(setting.GE_OG_Certification_Name__c=='--Select One--' || setting.GE_OG_Certification_Name__c == 'None'){
                    newcert.GE_OG_GS_Certificate_Name__c ='';
                }
                else{
                newcert.GE_OG_GS_Certificate_Name__c = setting.GE_OG_Certification_Name__c;  
                } 
            }
          }              
            newcert.GE_OG_GS_Acquired_Date__c=aquiredDate;
            newcert.GE_OG_GS_Cert_Expiry_Date__c=expiryDate;
            newcert.GE_OG_DRL_Certification_Source__c=additionalInfo;
            newcert.GE_OG_GS_Cert_Technician__c=techId;
            newcert.GE_OG_DRL_Legacy_Id__c=legacyId;
            newcert.GE_OG_GS_Status__c=certStatus;
            newcert.GE_OG_DRL_Certificate_Type__c=certType;
            newcert.GE_OG_GS_Target_Date__c=targetDate;
            insert newcert;
            
            lstCertificationBeans = helper.getCertifications(techId);
           PageReference editPage = new PageReference('/apex/GE_OG_TechDataUpsert?techId1='+techId);
           editPage.getParameters().put('recordType','Certification');        
           editPage.setRedirect(true);
           return editPage;
        }
        return null;
    } 
    Public PageReference addVisa(){
        System.debug('****PassportId****'+pasportnumberMap.get(passportA));
           
         ApexPages.getMessages().clear();
         if(passportA==null || visaCountryA ==null ||visaStatusA==null||expiryDateA==null||issueDateA == null ||visaforA==null){            
             ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Please enter all the required fields Passport Number, Visa Country, Visa Status, Issue Date, Expiry Date'));            
            }
         
            else{
            ShowVisaBlock =false;
            disablebButton =false;
            GE_OG_GS_Visa__c temp = new GE_OG_GS_Visa__c();
            temp.GE_OG_GS_Passport__c= pasportnumberMap.get(passportA);
            temp.GE_OG_GS_Technician__c=techId;
            temp.GE_OG_GS_Visa_Status__c= visaStatusA;
            temp.GE_OG_GS_Visa_Country__c= visaCountryA;
            temp.GE_OG_GS_Visa_Expiry_Date__c=expiryDateA;
            temp.GE_OG_GS_Visa_Issued_Date__c=issueDateA;
            temp.GE_OG_GS_Visa_For__c= visaforA;   
            
            insert temp;            
            helper.CheckaddVisaSuccess();
            lstVisaBeans = helper.getVisas(techId); 
            PageReference editPage = new PageReference('/apex/GE_OG_TechDataUpsert?techId1='+techId);
            editPage.getParameters().put('recordType','Visa');        
            editPage.setRedirect(true);
           return editPage;
        }
        return null;
    }
    
    Public PageReference saveVisa(){
     
         integer count=0;
         List<GE_OG_GS_Visa__c> visaUpdatelst = new List<GE_OG_GS_Visa__c >(); 
         List<GE_OG_TechBean.visaBean> tempv = new List<GE_OG_TechBean.visaBean>();
          
         for(GE_OG_TechBean.visaBean visatemp:lstVisaBeans){ 
             if(visatemp.isSelectVisa==True){
              count= count + 1;
              ApexPages.getMessages().clear();
              GE_OG_GS_Visa__c temp = new GE_OG_GS_Visa__c();
              temp.Id=visatemp.visaId;
              temp.GE_OG_GS_Visa_Expiry_Date__c = visatemp.visaExpiryDate;
              temp.GE_OG_GS_Visa_Status__c = visatemp.visaStatus;
              visaUpdatelst.add(temp);
              System.debug('****UpdateList*****'+visaUpdatelst);
              }
          
          }
          if(count==0){
                helper.CheckSelectionvisa();}
          else {
                helper.CheckSuccessVisa();}
          if(visaUpdatelst.size()>0){
              visaDisplayBlock = true;
               editVisaBlock= false;
               disablebButton =false;   
              Update visaUpdatelst;
              lstVisaBeans = helper.getVisas(techId);  
           }   
         
        return null;
    }
    Public PageReference addPassport(){    
        
        ApexPages.getMessages().clear();
        if(passportNumberA == null || passportNumberA == '' || passportIssueDateA==null|| passportExpiryDateA==null|| passportStatusA==null|| passportCountryA==null){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Please enter all the required data: Passport Number, Passport Country, Issue Date, Expiry Date, and Passport Status'));
        }
        else{     
        ShowpassportBlock =false;
        disablebButton =true;
        GE_OG_GS_Passport__c addPassport = new GE_OG_GS_Passport__c();
        addPassport.GE_OG_GS_Passport_Number__c=passportNumberA;
        addPassport.GE_OG_GS_Passport_Type__c=passportTypeA;
        addPassport.GE_OG_GS_Passport_Expiry_Date__c=passportExpiryDateA;
        addPassport.GE_OG_GS_Issued_Date__c=passportIssueDateA;
        addPassport.GE_OG_GS_Issued_By__c=passportIssuedByA;
        addPassport.GE_OG_GS_Passport_Status__c=passportStatusA;
        addPassport.GE_OG_GS_Technician__c=techId;
        addPassport.GE_OG_GS_Passport_Country__c=passportCountryA;
        addPassport.GE_OG_GS_Remaining_Pages__c =passportremainingPagesA;
        insert addPassport;
        System.debug('*****Passport Created******'+addPassport);
        helper.CheckaddPassportSuccess();
        lstPassportBeans = helper.getPassports(techId);
    
        PageReference editPage = new PageReference('/apex/GE_OG_TechDataUpsert?techId1='+techId);
           editPage.getParameters().put('recordType','Passport');        
           editPage.setRedirect(true);
           return editPage;
        }
        
        return null;
    }
    Public PageReference savePassport(){
     
         List<GE_OG_GS_Passport__c> passportUpdateList = new List<GE_OG_GS_Passport__c>();
         List<GE_OG_TechBean.passportBean> tempP = new List<GE_OG_TechBean.passportBean>();
         integer count =0;
         for(GE_OG_TechBean.passportBean temp : lstPassportBeans){
             if(temp.isSelectPassport==true){
             count =count+1;
             ApexPages.getMessages().clear();
             GE_OG_GS_Passport__c passtemp = new GE_OG_GS_Passport__c();
             passtemp.Id=temp.passportId ;
             passtemp.GE_OG_GS_Passport_Expiry_Date__c =temp.passportExpiryDate ;
             passtemp.GE_OG_GS_Remaining_Pages__c =temp.remainingPages ;
             passtemp.GE_OG_GS_Passport_Status__c = temp.passportStatus ;
             passportUpdateList.add(passtemp);
             }
         }
         if(count==0){
         helper.CheckSelectionPassport();}
         else{
         helper.CheckSuccessPassport();}
         
         if(passportUpdateList.size()>0){
             editPassportBlock=false;
             disablebButton =false;
             passportDisplayBlock = true;
             Update passportUpdateList;
             lstPassportBeans = helper.getPassports(techId);
         }
     
        return null;
    }
    
        
}