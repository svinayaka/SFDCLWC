/*
Type Name [Class/Trigger/Page Name] : Class
Used Where ?                        : Used in the VF page GE_ES_CustomClone 
Purpose/Overview                    : Cloning a Record and allowing Users to choose on what can be cloned along with the Parent record.   
Functional Area                     : Cross Functional
Author                              : Sanjay Patidar
Created Date                        : 
Test Class Name                     : Test_GE_ES_CustomClone - 97%
Limitation                          : 

Change History -
Date Modified   : Developer Name        : Method/Section Modified/Added     : Purpose/Overview of Change
11/10/2014              : Sanjay Kumar Patidar  : Added Clone Options                           : Allowing users to choose what to clone along with the Parent Record.  
*/

public class GE_ES_CustomClone {
    //getting Parent Record Id
    public Id parentCloneId = apexPages.currentPage().getParameters().get('ParentId');
    //getting current Parent record type
    public String recordTypeId = apexPages.currentPage().getParameters().get('RecordTypeId');
    //getting the mode in which the cloned record needs to be opened.
    public String mode = apexPages.currentPage().getParameters().get('Mode');
    //Wrapper List for the Clone Option List
    public List<cCloneOptions> cloneOptionsList {get; set;}
    //Parent Object Type
    public String parentObjectType {get; set;}
    //Boolean Clone Options
    public boolean showCloneOptions {get; set;}
    
   //Get Clone options for selected parent record.
    public List<cCloneOptions> getcloneOptions() {
        if(cloneOptionsList == null) {
            cloneOptionsList = new List<cCloneOptions>();
            Map<String, Schema.SObjectType> ds = Schema.getGlobalDescribe(); 
            Map<String,String> keyPrefixMap = new Map<String,String>{};
                Set<String> keyPrefixSet = ds.keySet();
            for(String sObj : keyPrefixSet) {
                Schema.DescribeSObjectResult r =  ds.get(sObj).getDescribe();
                String tempName = r.getName();
                String tempPrefix = r.getKeyPrefix();
                keyPrefixMap.put(tempPrefix,tempName);
            }
            
            String tPrefix = parentCloneId;
            tPrefix = tPrefix.subString(0,3);
            String SobjectType = keyPrefixMap.get(tPrefix);
            parentObjectType = keyPrefixMap.get(tPrefix);
            String sWhereClause = 'Id =' +'\'' +parentCloneId+ '\'';
            string recordTypeName;
            if(recordTypeId == null) {
                recordTypeName = null;
            }
            else {
                recordTypeName = [select Id, Name from RecordType where Id =:recordTypeId].Name;
            }
            for(GE_ES_Custom_Clone__c c: [Select Id, Name, GE_ES_Object_Name__c from GE_ES_Custom_Clone__c where GE_ES_Parent_Object__r.GE_ES_Object_API_Name__c =:SobjectType and GE_ES_Parent_Object__r.GE_ES_Record_Type__c =:recordTypeName]) {
                // As each Custom Clone is processed we create a new cCloneOptions object and add it to the cloneOptionsList
                cloneOptionsList.add(new cCloneOptions(c));
            }
        }
        if(cloneOptionsList.size()>0) {
            showCloneOptions = true;
        }        
        return cloneOptionsList;
    }
    
    //Page reference for Cancel, redirect user to the Parent Object
    public PageReference cancelClone() {            
        PageReference clonePage = new PageReference('/'+parentCloneId);
        clonePage .setRedirect(true);
        return clonePage;
    }
    
    // Create the Custom Clone records based on the User Selection
    public PageReference processSelected() {
        
        //We create a new list of Custom_Clone__c that we be populated only with Related Objects if they are selected
        List<GE_ES_Custom_Clone__c> selectedCloneOptions = new List<GE_ES_Custom_Clone__c>();
        
        //We will cycle through our list of cClone and will check to see if the selected property is set to true, if it is we add the Custom_Clone__c to the selectedCloneOptions list
        for(cCloneOptions cClone: getcloneOptions()) {
            if(cClone.selected == true) {
                selectedCloneOptions.add(cClone.cClone);
            }
        }
        SObject cloneId;
        Map<String, Schema.SObjectType> ds = Schema.getGlobalDescribe(); 
        Map<String,String> keyPrefixMap = new Map<String,String>{};
            Set<String> keyPrefixSet = ds.keySet();
        for(String sObj : keyPrefixSet) {
            Schema.DescribeSObjectResult r =  ds.get(sObj).getDescribe();
            String tempName = r.getName();
            String tempPrefix = r.getKeyPrefix();
            keyPrefixMap.put(tempPrefix,tempName);
        }
        
        String tPrefix = parentCloneId;
        tPrefix = tPrefix.subString(0,3);
        String SobjectType = keyPrefixMap.get(tPrefix);
        String sWhereClause = 'Id =' +'\'' +parentCloneId+ '\''; 
        string recordTypeName;
        if(recordTypeId == null) {
            recordTypeName = null;
        }
        else {
            recordTypeName = [select Id, Name from RecordType where Id =:recordTypeId].Name;
        }
        
        //Getting Parent and its exception records
        List<GE_ES_Custom_Clone__c> masterClone = new List<GE_ES_Custom_Clone__c>([Select Id, Name from GE_ES_Custom_Clone__c where GE_ES_Object_API_Name__c =:SobjectType and GE_ES_Record_Type__c =:recordTypeName]);
        List<GE_ES_Custom_Clone_Detail__c> exceptions = new List<GE_ES_Custom_Clone_Detail__c>([Select Id, GE_ES_Custom_Clone__c, GE_ES_Label__c, GE_ES_API_Name__c, GE_ES_Default_Value__c, GE_ES_Data_Type__c from  GE_ES_Custom_Clone_Detail__c where GE_ES_Custom_Clone__c IN :masterClone]);
        
        String sQryString = GE_ES_Utils.getCreatableFieldsSOQL(SobjectType,sWhereClause);
        Sobject s = Database.query(sQryString);
        //Cloning the parent record(Recommendation)
        cloneId = s.clone(false, true);
        
        system.debug('Cloned Record  - '+cloneId);
        //Logic to assign default values to the cloned record
        for(integer i=0; i<exceptions.size(); i++) {
            if(exceptions.get(i).GE_ES_Data_Type__c == 'String') {
                cloneId.put(exceptions.get(i).GE_ES_API_Name__c, exceptions.get(i).GE_ES_Default_Value__c); 
            }
            
            if(exceptions.get(i).GE_ES_Data_Type__c == 'Integer') {
                cloneId.put(exceptions.get(i).GE_ES_API_Name__c,  Integer.valueof(exceptions.get(i).GE_ES_Default_Value__c.trim())); 
            }
            
            if(exceptions.get(i).GE_ES_Data_Type__c == 'Boolean') {
                cloneId.put(exceptions.get(i).GE_ES_API_Name__c,  Boolean.ValueOf(exceptions.get(i).GE_ES_Default_Value__c)); 
            }  
        }
        cloneId.put('GE_PRM_Parent_Id__c', parentCloneId);            
        //Inserting cloned record
        insert cloneId;
        
        //Variable declaration
        List<sObject> childCloneId = new List<sObject>();
        List<List<sObject>> cloneChilds = new List<List<sObject>>();
        //Getting Parent child records and its exceptions
        Map<Id,GE_ES_Custom_Clone__c> masterChilds = new Map<Id, GE_ES_Custom_Clone__c>([select id, name, GE_ES_Object_API_Name__c, GE_ES_Where_Field__c,(select id, GE_ES_Custom_Clone__c, GE_ES_Label__c, GE_ES_API_Name__c, GE_ES_Default_Value__c, GE_ES_Data_Type__c from Custom_Clone_Details__r) from GE_ES_Custom_Clone__c where GE_ES_Parent_Object__c!=null and ID in: selectedCloneOptions]);
        //Logic for cloning child records 
        for(GE_ES_Custom_Clone__c customCloneObj: masterChilds.values()) {
            childCloneId = new List<sObject>();
            sQryString = GE_ES_Utils.getCreatableFieldsSOQL(customCloneObj.GE_ES_Object_API_Name__c,customCloneObj.GE_ES_Where_Field__c+'='+'\'' +parentCloneId+ '\'');
            List<sObject> sList = Database.query(sQryString);
            for(Integer i=0; i<sList.size(); i++)
                childCloneId.add(sList[i].clone(false, true));  
            
            //Logic to assign default values to the child records
            for(Integer i=0; i<childCloneId.size(); i++) {
                for(GE_ES_Custom_Clone_Detail__c exceptionObj: customCloneObj.Custom_Clone_Details__r) {
                    if(exceptionObj.GE_ES_Data_Type__c == 'String') {
                        childCloneId[i].put(exceptionObj.GE_ES_API_Name__c, exceptionObj.GE_ES_Default_Value__c); 
                    }
                    if(exceptionObj.GE_ES_Data_Type__c == 'Integer') {
                        if(exceptionObj.GE_ES_Default_Value__c == null) {
                            childCloneId[i].put(exceptionObj.GE_ES_API_Name__c,  exceptionObj.GE_ES_Default_Value__c); 
                        } else {                                                
                            childCloneId[i].put(exceptionObj.GE_ES_API_Name__c,  Integer.valueof(exceptionObj.GE_ES_Default_Value__c.trim())); 
                        }
                    }
                    if(exceptionObj.GE_ES_Data_Type__c == 'Boolean') {
                        childCloneId[i].put(exceptionObj.GE_ES_API_Name__c,  Boolean.ValueOf(exceptionObj.GE_ES_Default_Value__c)); 
                    }  
                }
                childCloneId[i].put(customCloneObj.GE_ES_Where_Field__c, cloneId.id);
            }
            cloneChilds.add(childCloneId);
            
        }
        //Inserting child records
        for(Integer i=0; i<cloneChilds.size(); i++)
            if(cloneChilds[i].size()>0) {
                insert cloneChilds[i];
            }
        
        // Now we have our list of selected contacts and can perform any type of logic we want, sending emails, updating a field on the Contact, etc
        System.debug('These are the selected Contacts...');
        for(GE_ES_Custom_Clone__c clone: selectedCloneOptions) {
            system.debug(clone);
        }
        cloneOptionsList=null; // we need this line if we performed a write operation  because getContacts gets a fresh list now
        PageReference clonePage = new PageReference('/'+cloneId.id);
        clonePage .setRedirect(true);
        return clonePage;
    }
    
    
    //wrapper class contains GE_ES_Custom_Clone__c and a Boolean value
    public class cCloneOptions {
        public GE_ES_Custom_Clone__c cClone {get; set;}
        public Boolean selected {get; set;}
        
        //Contructor method. When we create a new cClone object we pass a Custom_Clone__c that is set to the cClone property. Set the selected value to false
        public cCloneOptions(GE_ES_Custom_Clone__c c) {
            cClone = c;
            selected = false;
        }
    }
    //Constructor
    public GE_ES_CustomClone() {
    }
}