/*
Class/Trigger Name     : GEOGDirectoryController_Mobile
Used Where ?           : OG Directory
Purpose/Overview       : 
Functional Area        : Innovation
Author                 : Prasanth Nalle
Created Date           : 13/03/2014
Test Class Name        : GEOGDirectory_Test
Code Coverage          : 100

Change History -

Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change

*/

public with sharing class GEOGDirectoryController_Mobile 
{
    public GEOGDirectoryController_Mobile(ApexPages.StandardController OGD){   }
    public void regionKeyPlayerCall(){} 
    public String targetField { get; set; }
    public string userid1;
    public String selectedCountry { get; set; }
    public List<GE_HQ_Country__c> lstCountries {get;set;}
    public String[] countryNames{get;set;}
    
    public string JSONString {get;set;}
    public pageReference onLoadPage_Countries(){
        countryNames = new List<String>();
        lstCountries = [Select Id, Name from  GE_HQ_Country__c ];
        for( GE_HQ_Country__c instantCountry :  lstCountries){
            countryNames.add(instantCountry.Name);
            
        }
        JSONString = JSON.serialize(countryNames);
        system.debug('******'+JSONString);
        addCodeUtilization();
        return null;
        
    }
    public string getusrid()
    {
        List<user> usid = new List<user>();
        usid = [select Id,username from User where Id = :UserInfo.getUserId()];
        userid1= usid[0].id;
        system.debug('----------id-----------'+userid1);
        return userid1;
    }
    //Method to update the Code Utilization Object.
    //Psuedo Code to update the Code Utilization Object.
    public void addCodeUtilization() 
    {    
        //Instantiate the CCodeUtilization Class
        GE_CodeUtilization cu = new GE_CodeUtilization();
        
        //Pass the Component Name and Component Type    
        //Class the insert insertCodeUtilization Method
        cu.insertCodeUtilization('GEOGDirectoryController_Mobile', 'Controller');
        cu.insertCodeUtilization(cu.captureVFPageName(), 'Visualforce Page');
        
    }   
    
}