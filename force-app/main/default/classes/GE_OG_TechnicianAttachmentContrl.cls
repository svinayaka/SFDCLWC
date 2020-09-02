public without sharing class GE_OG_TechnicianAttachmentContrl {
     
   public Id techId = ApexPages.currentPage().getParameters().get('techId1');
   Public String valueSelected{get;set;}
   Public String courseName{get;set;}
   public String certName{get;set;}
   Public String passportNumber{get;set;}
   Public String visaCountry{get;set;}
   public String techattachName{get;set;}
   Public String expertise{get;set;}
   Public String associatedTo{get;set;}
  
   Public Boolean expertDisplayfield{get; set;}
   Public Boolean courseDisplayfield{get; set;}
   Public Boolean certsDisplayfield{get; set;}
   Public Boolean visaDisplayfield{get; set;}
   Public Boolean passportDisplayfield{get;set;}
   
   public List<selectOption> expertOptions {get;set;} 
   public List<selectOption> courseOptions {get;set;} 
   public List<selectOption> certOptions {get;set;} 
   public List<selectOption> passportOptions {get;set;}  
   public List<selectOption> visaOptions {get;set;}  
   public List<selectOption> getvalues{get;set;}
   public List<selectOption> options{get;set;}
   
   Map<String,Id> pasportnumberMap = new Map<string,Id>();    
   Map<String,Id> visaMap = new Map<string,Id>(); 
   Map<String,Id> expertiseMap = new Map<string,Id>();
   Map<String,Id> courseMap = new Map<string,Id>();
   Map<String,Id> certsMap = new Map<string,Id>();
 
   
    public pagereference reset(){
        ApexPages.getMessages().clear();  
        PageReference resetPage = new PageReference('/apex/GE_OG_TechnicianAttachmentPage?techId1='+techId);
        resetPage.setRedirect(true);
        return resetPage;
    }
    
   public List<SelectOption> getAssociatedTo1(){  
           Schema.sObjectType taObj = GE_OG_GS_Technician_Attachment__c.getSObjectType();
           Schema.DescribeSObjectResult taDescribe = taObj.getDescribe();
           Map<String, Schema.SObjectField> tafieldMap = taDescribe.fields.getMap();           
                  
           List<Schema.PicklistEntry> associatedTovalues = tafieldMap.get('GE_OG_GS_TA_Associated_To__c').getDescribe().getPickListValues();
           List<selectOption> options = new List<selectOption>();
           options.add(new selectoption('','None'));
           for (Schema.PicklistEntry a : associatedTovalues) {
                      options.add(new selectOption(a.getLabel(), a.getValue()));
          }
      return options;
    }
    
    public pageReference selectedvalue(){
    
     if(associatedTo =='Expertise'){   
           
           expertDisplayfield = true;
           courseDisplayfield = false;
           certsDisplayfield = false;
           visaDisplayfield = false;
           passportDisplayfield = false;
        
         }
        else if(associatedTo =='Courses'){
         
          expertDisplayfield = false;
           courseDisplayfield = true;
           certsDisplayfield = false;
           visaDisplayfield = false;
           passportDisplayfield = false;
          
         }
         
        else if(associatedTo =='Certification'){
         
           expertDisplayfield = false;
           courseDisplayfield = false;
           certsDisplayfield = true;
           visaDisplayfield = false;
           passportDisplayfield = false;
         
         }
        else if(associatedTo =='Passport'){
         
           expertDisplayfield = false;
           courseDisplayfield = false;
           certsDisplayfield = false;
           visaDisplayfield = false;
           passportDisplayfield = true;
         
         }
        else  if(associatedTo =='Visa'){
              
           expertDisplayfield = false;
           courseDisplayfield = false;
           certsDisplayfield = false;
           visaDisplayfield = true;
           passportDisplayfield = false;
             
         }
         else if(associatedTo !='Visa' ||associatedTo !='Passport'||associatedTo !='Certification'||associatedTo !='Courses'|| associatedTo !='Expertise'){
           expertDisplayfield = false;
           courseDisplayfield = false;
           certsDisplayfield = false;
           visaDisplayfield = false;
           passportDisplayfield = false;
         }
         return null;
           
    }  
    
    public List<selectOption> getExpertiseLst(){    
         List<SVMXC__Service_Group_Skills__c > expertiseList = new List<SVMXC__Service_Group_Skills__c >();        
        
         expertiseList  = [Select id, Name, SVMXC__Skill__r.Name,SVMXC__Group_Member__c from SVMXC__Service_Group_Skills__c 
        where SVMXC__Group_Member__c =: techId ORDER BY Name];  
         List<selectOption> options = new List<selectOption>();
        options.add(new selectoption('','None'));
        for(SVMXC__Service_Group_Skills__c expObj : expertiseList){         
          expertiseMap.put(expObj.SVMXC__Skill__r.Name,expObj.Id);
          options.add(new selectOption(expObj.SVMXC__Skill__r.Name,expObj.SVMXC__Skill__r.Name)); 
        } 
        return options; 
    }   
    public List<selectOption> getCourseLst(){    
        List<GE_OG_GS_Course__c> courseList = new List<GE_OG_GS_Course__c >();        
        
         courseList = [Select id, Name, GE_OG_SS_Master_Course__r.Name,GE_OG_GS_Course_Technician__c from GE_OG_GS_Course__c 
         where GE_OG_GS_Course_Technician__c=: techId ORDER BY Name];  
        List<selectOption> options = new List<selectOption>();
        options.add(new selectoption('','None'));
        for(GE_OG_GS_Course__c courObj : courseList){         
          courseMap.put(courObj.GE_OG_SS_Master_Course__r.Name,courObj.Id);
          options.add(new selectOption(courObj.GE_OG_SS_Master_Course__r.Name , courObj.GE_OG_SS_Master_Course__r.Name)); 
        } 
        return options; 
    }
   public List<selectOption> getCertificateLst(){    
        List<GE_OG_GS_Certification__c > certsList = new List<GE_OG_GS_Certification__c  >();        
        
         certsList = [Select id, Name, GE_OG_GS_Certificate_Name__c,GE_OG_GS_Cert_Technician__c,GE_OG_GS_Category__c from GE_OG_GS_Certification__c  where GE_OG_GS_Cert_Technician__c=: techId 
        ORDER BY Name];  
        List<selectOption> options = new List<selectOption>();
        options.add(new selectoption('','None'));
        for(GE_OG_GS_Certification__c certsObj : certsList){         
          certsMap.put(certsObj.GE_OG_GS_Certificate_Name__c,certsObj.Id);
          options.add(new selectOption(certsObj.GE_OG_GS_Certificate_Name__c,'Category - '+certsObj.GE_OG_GS_Category__c+' /Certification Name -'+certsObj.GE_OG_GS_Certificate_Name__c)); 
        } 
        return options; 
    }
    public List<selectOption> getPassportLst(){    
         List<GE_OG_GS_Passport__c> passportList = new List<GE_OG_GS_Passport__c>();        
        
         passportList  = [Select id, Name,GE_OG_GS_Passport_Number__c,GE_OG_GS_Technician__c from GE_OG_GS_Passport__c where GE_OG_GS_Technician__c=:techId 
        ORDER BY Name];  
        List<selectOption> options = new List<selectOption>();
        options.add(new selectoption('','None'));
        for(GE_OG_GS_Passport__c pspObj : passportList ){         
          pasportnumberMap.put(pspObj.GE_OG_GS_Passport_Number__c,pspObj.Id);
          options.add(new selectOption(pspObj.GE_OG_GS_Passport_Number__c,pspObj.GE_OG_GS_Passport_Number__c)); 
        } 
        return options ; 
    }
    public List<selectOption> getVisaLst(){    
        List<GE_OG_GS_Visa__c > visaList = new List<GE_OG_GS_Visa__c  >();        
        
         visaList = [Select id, Name,GE_OG_GS_Passport__c,GE_OG_GS_Passport__r.GE_OG_GS_Passport_Number__c, GE_OG_GS_Technician__c,
         GE_OG_GS_Visa_Country__c,GE_OG_GS_Visa_For__c from GE_OG_GS_Visa__c where GE_OG_GS_Technician__c =: techId 
          
        ORDER BY Name];  
        List<selectOption> options = new List<selectOption>();
        options.add(new selectoption('','None'));
        for(GE_OG_GS_Visa__c visaObj: visaList){ 
          
          visaMap.put(visaObj.GE_OG_GS_Visa_Country__c,visaObj.Id);
          options.add(new selectOption(visaObj.GE_OG_GS_Visa_Country__c,'Visa Country - '+visaObj.GE_OG_GS_Visa_Country__c+' /Passport Number- '+visaObj.GE_OG_GS_Passport__r.GE_OG_GS_Passport_Number__c+'/ Visa For- '+visaObj.GE_OG_GS_Visa_For__c)); 
        }       
        return options; 
    }
    
    Public PageReference addTechAttachment(){
      
         if(techattachName==''){
             ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Please Enter Attachment Name')); 
          }
            
          else if(String.isBlank(passportNumber) && associatedTo=='Passport'){
                System.Debug('********Vaue**********'+certName);
               ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Please select Passport'));            
              }
              else if(String.isBlank(visaCountry) &&  associatedTo=='Visa'){
                System.Debug('********Vaue**********'+certName);
               ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Please select Visa'));            
              }
              else if(String.isBlank(certName) && associatedTo=='Certification'){
                System.Debug('********Vaue**********'+certName);
               ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Please select Certificate'));            
              }
              else if(String.isBlank(courseName) && associatedTo =='Courses'){
                System.Debug('********Vaue**********'+certName);
               ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Please select Course'));            
              }
              else if(String.isBlank(expertise) && associatedTo=='Expertise'){
                System.Debug('********Vaue**********'+certName);
               ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Please select Expertise'));            
              }        
        
            else{
            ApexPages.getMessages().clear();            
            GE_OG_GS_Technician_Attachment__c temp = new GE_OG_GS_Technician_Attachment__c ();
           
            temp.GE_OG_GS_TA_Technician__c= techId;
            temp.GE_OG_GS_Technician_Attachment_Name__c = techattachName;
            temp.GE_OG_GS_TA_Passport__c= pasportnumberMap.get(passportNumber);
            temp.GE_OG_GS_TA_Visa__c = visaMap.get(visaCountry);
            temp.GE_OG_GS_TA_Certification__c= certsMap.get(certName);
            temp.GE_OG_GS_TA_Course__c=courseMap.get(courseName);
            temp.GE_OG_Expertise__c=expertiseMap.get(expertise);
            temp.GE_OG_GS_TA_Associated_To__c = associatedTo;              
            
            insert temp; 
                     
            PageReference openTA = new PageReference('/'+temp.id);
            openTA.setRedirect(true);
            return openTA;
        }
        return null;
    }

}