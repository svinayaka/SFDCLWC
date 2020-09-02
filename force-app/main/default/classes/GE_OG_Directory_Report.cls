/*
Class/Trigger Name     : GE_OG_Directory_Report
Used Where ?           : OG Directory
Purpose/Overview       : Generating Report of region key players
Functional Area        : Innovation 
Author                 : Prasanth Nalle
Created Date           : 06/05/2014
Test Class Name        : GEOGDirectory_Test
Code Coverage          : 98

Change History -

Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change

*/
public with sharing class GE_OG_Directory_Report
{
    public string tier1{get;set;}
    public string tier2{get;set;}
    public string tier3{get;set;}
    public string funct{get;set;}
    public string country{get;set;}
    public List<GE_HQ_Country__c> country1{get;set;}
    public string id1{get;set;}
    private String soql {get;set;}
    public string id{get;set;}
    public List<User> OGDirectoryList{get;set;}
    public string userid1;
    
    
    public GE_OG_Directory_Report(ApexPages.StandardController OGD)
    {
        tier1='Oil & Gas (O&G)';
        tier3='';
        tier2= EncodingUtil.urlDecode(APexPages.currentPage().getParameters().get('Tier2'),'UTF-8');
        tier2=String.escapeSingleQuotes(tier2);
        system.debug('------tier2----'+tier2);
        tier2=tier2.replaceall('_',' ');
        tier2=tier2.replaceall(',','&');
        system.debug('------tier2----'+tier2);
        tier3= EncodingUtil.urlDecode(APexPages.currentPage().getParameters().get('Tier3'),'UTF-8');
        tier3=String.escapeSingleQuotes(tier3);
        tier3=tier3.replaceall('_',' ');
        tier3=tier3.replaceall(',','&');
        system.debug('------tier3----'+tier3);
        funct = APexPages.currentPage().getParameters().get('Function');
        funct=String.escapeSingleQuotes(funct);
        system.debug('-------funct---'+funct);
        country=APexPages.currentPage().getParameters().get('country');
        country=String.escapeSingleQuotes(country);
        country1=[select Id,Name from GE_HQ_Country__c where GE_HQ_ISO_Code__c=:country];
        if(!country1.isempty())
        {
        country=country1[0].Name;
        }
        system.debug('------all----'+tier2+tier3+funct+country);
        system.debug('------country----'+country);
        soql='Select Id,Name,Title,smallphotourl,Site_Location__c,Phone,Email,GE_HQ_SSO_ID__c  from User where IsActive=True and GE_HQ_Tier_1_P_L__c=\''+tier1+'\'  and GE_DS_Country__c =\''+country+'\' and  GE_HQ_Tier_2_P_L__c=\''+tier2+'\'  and Function__c =\''+funct+'\'';
        system.debug('----------soql------'+soql); 
        if(tier3!='')
        {
            soql=soql+'and GE_HQ_Tier_3_P_L__c=\''+tier3+'\'';
            system.debug('----------soql------'+soql);
            getAllKeyPlayer();
        } 
        else 
            getAllKeyPlayer();
    }
    
    public pagereference Query()
    {
        system.debug('--queentered');
        String location = APexPages.currentPage().getParameters().get('location');
        soql='Select Id,Name,smallphotourl,Title,Site_Location__c,Phone,Email,GE_HQ_SSO_ID__c  from User where IsActive=True and GE_HQ_Tier_1_P_L__c=\''+tier1+'\'  and GE_DS_Country__c =\''+country+'\' and  GE_HQ_Tier_2_P_L__c=\''+tier2+'\' and Function__c=\''+funct+'\'';
        system.debug('----------soql Query------'+soql); 
        if(tier3!='')
        {
            soql=soql+'and GE_HQ_Tier_3_P_L__c=\''+tier3+'\'';
            system.debug('----------soql tier3------'+soql);
        }
        if(!location.equals(''))
        {
            soql+= ' and Site_Location__c  LIKE \''+String.escapeSingleQuotes(location)+'%\'';
            system.debug('----------soql loc------'+soql);
        }
        getAllkeyPlayer();
        return null;
    }
    
    public void getAllKeyPlayer()
    {
        system.debug('----getallkeyplayer-----');
        OGDirectoryList = new List<User>();
        system.debug('----------soql get all------'+soql);
        OGDirectoryList=Database.query(soql+ 'order by Site_Location__c,Title,Name '+ ' limit 1001');     
    }
    
    public pagereference getUserDetail()
    {
        id1 =System.currentPageReference().getParameters().get('id1');
        system.debug('----------id------'+id1); 
        string link='/_ui/core/userprofile/UserProfilePage?u='+id1+'&tab=sfdc.ProfilePlatformFeed';
        system.debug('-----link---'+link);
        pageReference ref = new PageReference(link);
        return ref;
        
    }
    public pagereference backMethod()
    {
        Pagereference pg =  new Pagereference('/apex/GE_OG_Directory_Mobile'); 
        pg.setRedirect(true);
        return pg;
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
        cu.insertCodeUtilization('GE_OG_Directory_Report', 'Controller');
        cu.insertCodeUtilization(cu.captureVFPageName(), 'Visualforce Page');
    }   
}