public with sharing class ChatterfeedUtility1{

public static Datetime myDatetime = Datetime.now();
public static String myDate = myDatetime.format('MMMM dd,  yyyy');

public static  Datetime myDT = Datetime.now();
public static  String myTime = myDT.format('h:mm a');


public static void  Feed_on_insert(object[] lstobj_add , String sObjName ){

list<feedItem> lstfeed = new list<feedItem> ();

//system.debug(myDate + ' '+ myTime);


for ( object triggered_insert_object: lstobj_add )
{ 
     if (sObjName == 'Key_Customer_Contacts__c' )  
         {
                Key_Customer_Contacts__c lstobj  = (Key_Customer_Contacts__c )triggered_insert_object; 
       
                feedItem feed= new feedItem();  
                feed.ParentId= lstobj .Account_Planning__c;
                feed.Title=lstobj  .Name +'has been inserted by'+ UserInfo.getUserId();          
                feed.body = 'User ' + UserInfo.getFirstName() +' '+ UserInfo.getLastName()
               + ' has added Customer Contact ' + lstobj.Full_Name_GEOG__c + ' to Relationship Mapping Page on '
                   + myDate + ' , ' + myTime ;
             
                lstfeed.add(feed);
        }
 

     else if (sObjName == 'Customer_Strategy_Map_Contacts__c')
     {
            Customer_Strategy_Map_Contacts__c lstobj  = (Customer_Strategy_Map_Contacts__c )triggered_insert_object; 
            feedItem feed= new feedItem();        
            feed.ParentId= lstobj.Account_Planning_chatter__c ;
            feed.Title=lstobj  .Name +'has been inserted by'+ UserInfo.getUserId();          
            feed.body = 'User ' + UserInfo.getFirstName() +' '+ UserInfo.getLastName()
               + ' has added Customer Contact ' + lstobj.Contact_for_Chatter__c + ' to Customer Strategy Map '
               + lstobj.CSM_Title_chatter__c + ' on ' + myDate + ' , ' + myTime ;
         
            lstfeed.add(feed);
     }
     //Added by Kiru for Opportunity Scrum - req R-30000
     //The below If block is for Key Projec linked to Account Plan
     
     else if (sObjName == 'Key Project')
     {
            Key_Project_ge_og__c lstobj  = (Key_Project_ge_og__c)triggered_insert_object; 
           
            feedItem feed = new feedItem();        
            feed.ParentId = lstobj.Account_Plan_ge_og__c;
            feed.Title = lstobj.Name +'has been inserted by'+ UserInfo.getUserId();          
            feed.body = 'User ' + UserInfo.getFirstName() +' '+ UserInfo.getLastName()
               + ' has added Project '+lstobj.Project_Name_ge_og__c +' to Key Project Page on ' + myDate + ' , ' + myTime ;
            lstfeed.add(feed);
     }
     
        else if (sObjName == 'Key Asset')
     {
            Key_Asset_ge_og__c lstobj  = (Key_Asset_ge_og__c)triggered_insert_object; 
           
            feedItem feed = new feedItem();        
            feed.ParentId = lstobj.Account_Planning_ge_og__c;
            feed.Title = lstobj.Name +'has been inserted by'+ UserInfo.getUserId();          
            feed.body = 'User ' + UserInfo.getFirstName() +' '+ UserInfo.getLastName()
               + ' has added Asset '+lstobj.Asset_Name_ge_og__c+' to Key Asset Page on ' + myDate + ' , ' + myTime ;
            lstfeed.add(feed);
     }

 
}
    try{
insert lstfeed;
    }
    catch (Exception e){
        for(feeditem fdi: lstfeed)
        {
            fdi.adderror('There are something wrong with this chatter feed. plz contact your administrator');
            System.debug('Unable to insertChatter feed ' + e.getMessage());   
        }
    }
}
// end of insert chatter feed on insert of related record


    
// method to display chatter feed when related objcet is deleted/unlikned from an account planning.


public static void  Feed_on_delete(object[] lstobj_Del , String sObjName2 ){

list<feedItem> lstfeed_for_Delete = new list<feedItem> ();
system.debug('******list of record ,got deleted****' +lstobj_Del );
for ( object triggered_del_object: lstobj_Del )
    { 
    system.debug('----list of record ,got deleted====' +triggered_del_object);
       if (sObjName2 == 'Key_Customer_Contacts__c' )  
          {
                Key_Customer_Contacts__c lstobj  = (Key_Customer_Contacts__c )triggered_del_object; 
   
                feedItem feed= new feedItem(); 
                feed.ParentId= lstobj .Account_Planning__c;
                feed.Title=lstobj  .Name +'has been inserted by'+ UserInfo.getUserId();          
                feed.body = 'User ' + UserInfo.getFirstName() +' '+ UserInfo.getLastName()
               + ' has removed Customer Contact ' + lstobj.Full_Name_GEOG__c + ' from Relationship Mapping Page on '
                 + myDate + ' , ' + myTime ;
              
                lstfeed_for_Delete .add(feed);
           }
        
        
else if (sObjName2 == 'Customer_Strategy_Map_Contacts__c')
     {
            Customer_Strategy_Map_Contacts__c lstobj  = (Customer_Strategy_Map_Contacts__c )triggered_del_object;
              
            feedItem feed= new feedItem();        
            feed.ParentId= lstobj.Account_Planning_chatter__c;
            feed.Title=lstobj  .Name +'has been inserted by'+ UserInfo.getUserId();          
            feed.body = 'User ' + UserInfo.getFirstName() +' '+ UserInfo.getLastName()
               + ' has removed Customer Contact ' + lstobj.Contact_for_Chatter__c + ' from Customer Strategy Map '
               + lstobj.CSM_Title_chatter__c + ' on ' + myDate + ' , ' + myTime ;
         
            lstfeed_for_Delete.add(feed);
     }
        
        
        
else if (sObjName2 == 'Key Project') 
          {
                Key_Project_ge_og__c lstobj  = (Key_Project_ge_og__c)triggered_del_object; 
                 string id1 = lstobj.id ;
                feedItem feed= new feedItem(); 
                feed.ParentId= lstobj.Account_Plan_ge_og__c;
                feed.Title=lstobj.Name +'has been inserted by'+ UserInfo.getUserId();             
                feed.body = 'User ' + UserInfo.getFirstName() +' '+ UserInfo.getLastName()
               + ' has removed Project ' +lstobj.Project_Name_ge_og__c + ' from Key Project Page on ' + myDate + ' , ' + myTime ;
               
                lstfeed_for_Delete .add(feed);
           }

else if (sObjName2 == 'Key Asset') 
          {
                Key_Asset_ge_og__c lstobj  = (Key_Asset_ge_og__c)triggered_del_object; 
                 string id1 = lstobj.id ;
                feedItem feed= new feedItem(); 
                feed.ParentId= lstobj.Account_Planning_ge_og__c;
                feed.Title=lstobj.Name +'has been inserted by'+ UserInfo.getUserId();             
                feed.body = 'User ' + UserInfo.getFirstName() +' '+ UserInfo.getLastName()
               + ' has removed Asset '+lstobj.Asset_Name_ge_og__c+ + ' from Key Asset Page on ' + myDate + ' , ' + myTime ;
               
                lstfeed_for_Delete .add(feed);
           }
        
        

}
    try{
insert lstfeed_for_Delete ;
    } 
    Catch (Exception me)
    { 
        for(feeditem fdi: lstfeed_for_Delete)
        {
            
            System.debug('Unable to insertChatter feed ' + me.getMessage());   
        }
            
    }
// end of delete chatter feed method
}
}