/*Class Name          : GE_PRM_CAA_TriggerhelperClass
Used Where ?        : This acts as supportive handler class for trigger "GE_PRM_CAA_TriggerHandler"
                        on GE_PRM_Channel_Appointment_Approver__c object
Purpose/Overview    : in Termination/Non Renew Process, if all of the channel appointment
                        approvers for a single commercial line approves, this class
                        executes logic to send email to public group 
Functional Area     : PRM
Author              : Pradeep Rao Yadagiri
Created Date        : 10/6/2014.
Test Class Name     : Test_GE_PRM_Channel_Appointment_Class
Change History - 
Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
*/
public class GE_PRM_CAA_TriggerhelperClass 
{
    //** method to validate all cpa approver records for a commercial lines are approved        
    public static void sendmailToPublicgroupAfterUpdate(map<id,GE_PRM_Channel_Appointment_Approver__c> caanewmap)
    {      
        system.debug('Trigger Pass from Here too========================='); 
        list<GE_PRM_Channel_Appointment_Approver__c> lstcaa = new list<GE_PRM_Channel_Appointment_Approver__c>();
        list<id> lstcommid = new list<id>();
        list<GE_PRM_Commercial_line__c> lstcomline = new list<GE_PRM_Commercial_line__c>(); 
        List<GE_PRM_CAA_CommLine_Junction__c> lstCaaCommJunc = new List<GE_PRM_CAA_CommLine_Junction__c>();
        id channelAppId ;
        id AccId ;
        string strRelationTYpe;
        //** Retrieve channel appointment approver records from trigger.newmap
        lstcaa = [select id,Commercial_line__c from GE_PRM_Channel_Appointment_Approver__c where id in :caanewmap.keySet() and GE_PRM_Status__c = 'Approved' and (Non_Renewal__c = true or Terminate__c = true) ]; 
        lstCaaCommJunc = [select id,Commercial_line__c,Channel_Appointment_Approver__c from GE_PRM_CAA_CommLine_Junction__c where Channel_Appointment_Approver__c in :lstcaa ];
        
        if(lstCaaCommJunc.size()>0)
        {   
             
            for(GE_PRM_CAA_CommLine_Junction__c objCaaCommJunc: lstCaaCommJunc){
                lstcommid.add(objCaaCommJunc.Commercial_line__c);             
            }   
                
            //** retrieve relevant commercial lines information    
            lstcomline = [select id, (select GE_PRM_Status__c,Appr_Non_Renewal__c,AppTerminate__c from GE_PRM_CAA_CommLine_Junction__r where (AppTerminate__c = true OR Appr_Non_Renewal__c = true) ) from GE_PRM_Commercial_line__c where id in :lstcommid];          
            list<GE_PRM_Commercial_line__c> lstcomNonRenew = new list<GE_PRM_Commercial_line__c>();
            list<GE_PRM_Commercial_line__c> lstcomTerminate = new list<GE_PRM_Commercial_line__c>();            
            for(GE_PRM_Commercial_line__c comercline: lstcomline)
            {                
                boolean nrapproved = false;
                boolean nrnotapproved = false;
                boolean terminateapproved = false;
                boolean terminatenotapproved = false;
                    
                //** retrive channel appointment approver records for each commercial line
                for(GE_PRM_CAA_CommLine_Junction__c caanonrenew : comercline.GE_PRM_CAA_CommLine_Junction__r)
                {
                    //** retrive only non-renew submitted channel appointment approver records 
                    if(caanonrenew.GE_PRM_Status__c == 'Approved' && caanonrenew.Appr_Non_Renewal__c == true && caanonrenew.AppTerminate__c == false)
                    {                        
                        nrapproved = true ;                     
                    }
                    //** executes when atleast one of caa records is not approved
                    else
                    {
                        nrnotapproved = true ;                     
                    }
                    
                }
                if(nrnotapproved == false){
                    lstcomNonRenew.add(comercline);
                }                
                for(GE_PRM_CAA_CommLine_Junction__c caaterminate : comercline.GE_PRM_CAA_CommLine_Junction__r)
                {
                    //** retrive only terminate submitted channel appointment approver records 
                    if(caaterminate.GE_PRM_Status__c == 'Approved'  && caaterminate.Appr_Non_Renewal__c == false && caaterminate.AppTerminate__c == true)
                    {
                        terminateapproved = true ;                           
                    }
                    //** executes when atleast one of caa records is not approved
                    else
                    {
                        terminatenotapproved = true ;                         
                    }
                    
                }
                if(terminatenotapproved == false)
                {                    
                    lstcomTerminate.add(comercline);
                }                  
            }
              system.debug('lstcomNonRenew==='+lstcomNonRenew.size());  
            //** retrive nonrenew contract records for updation based on tier values
            if(lstcomNonRenew.size() > 0)
            {                
                list<id> lstnonrenewid = new list<id>();
                for(GE_PRM_Commercial_line__c c : lstcomNonRenew)
                {
                    lstnonrenewid.add(c.id);  
                }
                list<GE_PRM_Commercial_line__c> lstcomlineNonRenew = new list<GE_PRM_Commercial_line__c>();
                lstcomlineNonRenew = [select GE_PRM_Type__c, GE_PRM_Channel_Appointment__r.id, GE_PRM_Channel_Appointment__r.GE_PRM_Account_Name__c, GE_PRM_Tier_1__c, GE_PRM_Tier_2__c, GE_PRM_Tier_3__c, GE_PRM_Tier_4__c, GE_PRM_Tier_5__c from GE_PRM_Commercial_line__c where id in :lstnonrenewid];                 
                  
                   
                list<contract> lstnonrenewcontr = new list<contract>();
                Set<contract> setNonrenewcontr = new Set<contract>();
                if(lstcomlineNonRenew.size()>0)
                {
                    strRelationTYpe = lstcomlineNonRenew[0].GE_PRM_Type__c;
                    channelAppId = lstcomlineNonRenew[0].GE_PRM_Channel_Appointment__r.id;
                    AccId = lstcomlineNonRenew[0].GE_PRM_Channel_Appointment__r.GE_PRM_Account_Name__c;
                
                }

                for(Contract connonrenew : [select id, GE_PRM_Channel_Appointment_ID__c,GE_PRM_Business_Tier_1__c, GE_PRM_Tier_2__c,GE_PRM_Tier_3__c,GE_PRM_Tier_4__c,GE_PRM_Tier_5__c, GE_PRM_Channel_Appointment_URL__c from contract where (GE_PRM_Channel_Appointment_ID__c =: channelAppId) and (AccountID =: AccId)])
                {
                       system.debug('connonrenew ==='+connonrenew );  
                    for(GE_PRM_Commercial_line__c cRenew: lstcomlineNonRenew)
                    {
                        if(connonrenew.GE_PRM_Business_Tier_1__c == cRenew.GE_PRM_Tier_1__c && 
                           connonrenew.GE_PRM_Tier_2__c == cRenew.GE_PRM_Tier_2__c &&
                           connonrenew.GE_PRM_Tier_3__c == cRenew.GE_PRM_Tier_3__c &&
                           connonrenew.GE_PRM_Tier_4__c == cRenew.GE_PRM_Tier_4__c &&
                           connonrenew.GE_PRM_Tier_5__c == cRenew.GE_PRM_Tier_5__c 
                           )
                        {
                              system.debug('COMING HERE ===');  
                            connonrenew.GE_PRM_NRT_Email__c = true;
                            connonrenew.GE_PRM_Channel_Appointment_URL__c = URL.getSalesforceBaseUrl().toExternalForm() + '/' + connonrenew.GE_PRM_Channel_Appointment_ID__c;
                            
                            //lstnonrenewcontr.add(connonrenew); 
                            setNonrenewcontr.add(connonrenew); 
                        }
                    
                    }
                                      
                } 
                //Approver issue fix due to duplicate id in the list Starts
                if(setNonrenewcontr.size()>0){
                    for(Contract con:setNonrenewcontr){
                        lstnonrenewcontr.add(con);
                    }
                    
                }
                //Approver issue fix due to duplicate id in the list Ends   
                system.debug('lstnonrenewcontr========================'+lstnonrenewcontr);                           
                update lstnonrenewcontr;
            } 
                
            //** retrive terminate contract records for updation based on tier values            
            if(lstcomTerminate.size() > 0)
            {                
                list<id> lstterminateid = new list<id>();
                for(GE_PRM_Commercial_line__c c : lstcomTerminate){
                    lstterminateid.add(c.id);  
                }
                list<GE_PRM_Commercial_line__c> lstcomlineTerminate = new list<GE_PRM_Commercial_line__c>();
                lstcomlineTerminate = [select GE_PRM_Channel_Appointment__r.id,GE_PRM_Type__c,  GE_PRM_Channel_Appointment__r.GE_PRM_Account_Name__c, GE_PRM_Tier_1__c, GE_PRM_Tier_2__c, GE_PRM_Tier_3__c, GE_PRM_Tier_4__c, GE_PRM_Tier_5__c from GE_PRM_Commercial_line__c where id in :lstterminateid];                 
                list<contract> lstterminatecontr = new list<contract>();
                Set<contract> setTerminatecontr = new Set<contract>();

                if(lstcomlineTerminate.size()>0)
                {
                    strRelationTYpe = lstcomlineTerminate[0].GE_PRM_Type__c;
                    channelAppId = lstcomlineTerminate[0].GE_PRM_Channel_Appointment__r.id;
                    AccId = lstcomlineTerminate[0].GE_PRM_Channel_Appointment__r.GE_PRM_Account_Name__c;
                }
                
                for(Contract conterminate : [select id, GE_PRM_Channel_Appointment_ID__c,GE_PRM_Business_Tier_1__c, GE_PRM_Tier_2__c,GE_PRM_Tier_3__c,GE_PRM_Tier_4__c,GE_PRM_Tier_5__c, GE_PRM_Channel_Appointment_URL__c from contract where (GE_PRM_Channel_Appointment_ID__c =: channelAppId) and (AccountID =: AccId)])
                {
                    for(GE_PRM_Commercial_line__c cterminate: lstcomlineTerminate)
                    {
                        if(conterminate.GE_PRM_Business_Tier_1__c == cterminate.GE_PRM_Tier_1__c && 
                           conterminate.GE_PRM_Tier_2__c == cterminate.GE_PRM_Tier_2__c &&
                           conterminate.GE_PRM_Tier_3__c == cterminate.GE_PRM_Tier_3__c &&
                           conterminate.GE_PRM_Tier_4__c == cterminate.GE_PRM_Tier_4__c &&
                           conterminate.GE_PRM_Tier_5__c == cterminate.GE_PRM_Tier_5__c 
                           )
                        {
                            conterminate.Termination_Email__c = true;
                            conterminate.GE_PRM_Channel_Appointment_URL__c = URL.getSalesforceBaseUrl().toExternalForm() + '/' + conterminate.GE_PRM_Channel_Appointment_ID__c;
                            setTerminatecontr.add(conterminate);
                            //lstterminatecontr.add(conterminate);            
                        }
                    }
                               
                } 
                //Approver issue fix due to duplicate id in the list Starts               
                if(setTerminatecontr.size()>0){
                    for(Contract con:setTerminatecontr){
                        lstterminatecontr.add(con);
                    }
                    
                } 
                //Approver issue fix due to duplicate id in the list Ends
                update lstterminatecontr;
            }           
        }  
    } 

    public static void updateChannelAppointment(map<id,GE_PRM_Channel_Appointment_Approver__c> caanewmap)
    {/*
        System.debug('Approver record updated'+caanewmap);
        list<GE_PRM_Channel_Appointment_Approver__c> lstcaa = new list<GE_PRM_Channel_Appointment_Approver__c>();
        list<GE_PRM_Channel_Appointment_Approver__c> lstcapending = new list<GE_PRM_Channel_Appointment_Approver__c>();
        list<id> lstcommid = new list<id>();
        list<id> lstCAid = new list<id>();
        list<GE_PRM_Commercial_line__c> lstcomline = new list<GE_PRM_Commercial_line__c>();
        List<GE_PRM_Channel_Appointment__c> listCAupdate= new list<GE_PRM_Channel_Appointment__c>(); 
        List<GE_PRM_Channel_Appointment__c> listCAupdatenew= new list<GE_PRM_Channel_Appointment__c>(); 
        //** Retrieve channel appointment approver records from trigger.newmap
       // lstcaa = [select id,Commercial_line__c, (select id from Channel_Appointment_Approvers__r) from GE_PRM_Channel_Appointment_Approver__c where id in :caanewmap.keySet()  ]; 
        lstcaa = [select Commercial_line__c,GE_PRM_Channel_Appointment__c from GE_PRM_Channel_Appointment_Approver__c where id in :caanewmap.keySet()  ]; 
        list<GE_PRM_Channel_Appointment_Approver__c> lstchaa = new list<GE_PRM_Channel_Appointment_Approver__c>();
        if(lstcaa.size()>0){   
            if(lstcaa.size()>0){
                for(GE_PRM_Channel_Appointment_Approver__c caprover: lstcaa){
                    lstcommid.add(caprover.GE_PRM_Channel_Appointment__c);             
                }   
            } 
        }
        System.debug('llkkjj'+lstcommid);
            System.debug('List of Commercial line id'+ lstcommid);
            listCAupdate=[select id,GE_PRM_CommercialAffected__c,GE_PRM_ComplainceAffected__c,GE_PRM_Current_Status__c from GE_PRM_Channel_Appointment__c where id IN:lstcommid];
            
            lstcapending=[select id,GE_PRM_Status__c from GE_PRM_Channel_Appointment_Approver__c where GE_PRM_Status__c!='Approved' and GE_PRM_Channel_Appointment__c IN : lstcommid ];
            System.debug('mmnnbbvv'+lstcapending);
            if(lstcapending.size()==0)
            {
                System.debug('to update channel update'+listCAupdate);
                for(GE_PRM_Channel_Appointment__c ca: listCAupdate)
                {
                    System.debug('to update channel updateaaaaaaa'+ca.GE_PRM_CommercialAffected__c);
                  if(ca.GE_PRM_CommercialAffected__c==true)
                  {
                      
                      ca.GE_PRM_Current_Status__c='Approved';
                      ca.GE_PRM_CommercialAffected__c=false;
                      listCAupdatenew.add(ca);
                  }  
                }
                if(listCAupdatenew.size()>0)
                {
                    System.debug('updating channel appointmnet'+listCAupdatenew);
                    update listCAupdatenew;
                }
            }*/
    }
    
}