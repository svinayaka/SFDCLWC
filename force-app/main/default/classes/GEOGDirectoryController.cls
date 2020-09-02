/*
Class/Trigger Name     : GEOGDirectoryController
Used Where ?           : OG Directory
Purpose/Overview       : used for creating the filter criteria for Oil & Gas Directory
Functional Area        : Innovation 
Author                 : Prasanth Nalle
Created Date           : 13/03/2014
Test Class Name        : GEOGDirectory_Test
Code Coverage          : 100

Change History -

Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change

*/
public class GEOGDirectoryController 
{
    public GEOGDirectoryController (ApexPages.StandardController OGD){   }
    public void regionKeyPlayerCall(){} 
    public String targetField { get; set; }
    public string userid1;
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
        
        //Class the insert insertCodeUtilization Method
        cu.insertCodeUtilization('GEOGDirectoryController', 'Controller');
        cu.insertCodeUtilization(cu.captureVFPageName(), 'Visualforce Page');
    }   
    
}