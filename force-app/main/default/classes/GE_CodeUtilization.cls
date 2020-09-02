/*
Class/Trigger Name     : GE_CodeUtilization
Used Where ?           : OG Directory
Purpose/Overview       : used for creating the filter criteria for Oil & Gas Directory
Functional Area        : Innovation 
Author                 : Sanjay Patidar
Created Date           : 11/14/2014
Test Class Name        : GE_CodeUtilization_Test
Code Coverage          : 100

Change History -

Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change

*/

public without sharing class GE_CodeUtilization {
   
   public String captureVFPageName()
   {
        //To get VF Page name
        String pageName = ApexPages.CurrentPage().getUrl();  
        // Page name start from /apex/ so remove it till there
        pageName = pageName.replaceFirst('/apex/','');         
        pageName = EncodingUtil.urlEncode(pageName, 'UTF-8');  
        // %3F is the vale of the question mark in UTF-8  
        string[] pageNameExtra = pageName.split('%3F',0);   
        // split the string at that point
        pageName = pageNameExtra[0];
               
        return pageName;
   }
   
   public void insertCodeUtilization(String cName, String cType) {
        
        //Capture the Component Name and Type
        String ComponentName =  cName;
        String ComponentType = cType;
        
        //Instantiate the Code Utilization Object
        GE_Code_Utilization__c cu = new GE_Code_Utilization__c();
        //Set the Logged In User Value
        cu.GE_Referenced_By__c = UserInfo.getUserId();
        //Set the Component Name
        cu.GE_Component_Name__c = ComponentName;
        //Set the Component Type
        cu.GE_Component_Type__c = ComponentType;
        //Set the Time as of Now
        cu.GE_Date_Referenced__c = datetime.now();
        system.debug('Code UtilizatioN Record - '+cu);
        //Insert the Code Utilization Record.
        insert cu ;
    } 
}