/*
Req: R-25681
Class Name              :        GE_DTS_Non_Home_Territory
Class called in         :        GE_OG_SVMXCServiceOrderTriggerHandler,GE_OG_SVMX_Event_TriggerHandler
Purpose                 :        To trigger approval process for Non Home Territory Teams
Test class              :        GE_DTS_Non_Home_Territory_Test
Created on              :        5/18/2017  
*/

public without sharing class GE_DTS_Non_Home_Territory{
    
    public Id recrdtypeid= Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('GE OG DTS').getRecordTypeId();
     public Id techrecrtype = Schema.SObjectType.SVMXC__Service_Group_Members__c.getRecordTypeInfosByName().get('GE OG DTS Technician').getRecordTypeId();
     
    public void beforewoupdate(List<SVMXC__Service_Order__c> oldObjects,Map<Id, SVMXC__Service_Order__c> newObjectMap){
    
        List<SVMXC__Service_Order__c> dtswolist = new List<SVMXC__Service_Order__c>();
        List<Id> dtsteams = new List<Id>();
        List<SVMXC__Dispatcher_Access__c> dispatcherlist = new List<SVMXC__Dispatcher_Access__c>();
        Map<Id,SVMXC__Service_Group__c> servicegroupmap;
        
        for(SVMXC__Service_Order__c oldwo:oldObjects){
            if(oldwo.RecordTypeid == recrdtypeid){
            SVMXC__Service_Order__c newwo = newObjectMap.get(oldwo.Id);
            dtswolist.add(oldwo);
            dtsteams.add(newwo.SVMXC__Service_Group__c);
            }
        }
        if(dtswolist.size()>0){
         dispatcherlist = [select id,SVMXC__Dispatcher__c,GE_HQ_Not_Home_Territory__c,SVMXC__Service_Team__c from SVMXC__Dispatcher_Access__c where SVMXC__Dispatcher__c =:userinfo.getUserId() and SVMXC__Service_Team__c in : dtsteams ];
         servicegroupmap = new Map<Id,SVMXC__Service_Group__c>([select id,GE_HQ_Resource_Director__c from SVMXC__Service_Group__c where id in :dtsteams]);
         }
        Map<Id,SVMXC__Dispatcher_Access__c> dispatchermap = new Map<Id,SVMXC__Dispatcher_Access__c>();
        for(SVMXC__Dispatcher_Access__c d :dispatcherlist){
        
        dispatchermap.put(d.SVMXC__Service_Team__c,d);
        
        }
        
        for(SVMXC__Service_Order__c oldwo: dtswolist){
            
           
                
                SVMXC__Service_Order__c newwo = newObjectMap.get(oldwo.Id);
                
                //   system.debug('DTS STATUS'+oldwo.SVMXC__Dispatch_Status__c);
                //   system.debug('DTS STATUS'+newwo.SVMXC__Dispatch_Status__c);
                
                if(oldwo.SVMXC__Dispatch_Status__c == 'New' && newwo.SVMXC__Dispatch_Status__c != oldwo.SVMXC__Dispatch_Status__c){
                    
                 
                 
                     SVMXC__Dispatcher_Access__c dispatcher = dispatchermap.get(newwo.SVMXC__Service_Group__c);
                     
                    if(dispatcher!=null){
                    if(dispatcher.GE_HQ_Not_Home_Territory__c){
                        SVMXC__Service_Group__c team = servicegroupmap.get(newwo.SVMXC__Service_Group__c);
                        newwo.GE_SM_HQ_Technician_Home_Dispatcher__c = team.GE_HQ_Resource_Director__c;
                        newwo.GE_SM_HQ_Dispatcher_Name__c = UserInfo.getName();
                        newwo.GE_SM_HQ_Dispatcher_Email__c = userinfo.getUserEmail();
                        newwo.SVMXC__Preferred_Technician__c = newwo.SVMXC__Group_Member__c;
                        newwo.SVMXC__Group_Member__c=null;                        
                        newwo.GE_SM_HQ_Dispatched_Outside_Territory__c = true;
                        newwo.GE_PC_Date__c = system.today();
                             
                    }    
                    }
                    system.debug('IN DTS BEFORE UPDATE');                
                }  
                
                if(oldwo.SVMXC__Dispatch_Status__c.equals('Queued') && newwo.GE_SM_HQ_Borrowed_Technician_Approved_On__c != null){
                    newwo.SVMXC__Group_Member__c = newwo.SVMXC__Preferred_Technician__c;
                }
                if(oldwo.SVMXC__Dispatch_Status__c.equals('Queued') && newwo.GE_SM_HQ_Borrowed_Technician_Approved_On__c == null && newwo.GE_SM_HQ_Borrowed_Technician_Rejected__c == true){
                    newwo.SVMXC__Group_Member__c = null;
                    newwo.SVMXC__Service_Group__c = null;
                    newwo.GE_SM_HQ_Dispatched_Outside_Territory__c = false; 
                    newwo.SVMXC__Preferred_Technician__c = null;
                    newwo.GE_SM_HQ_Technician_Home_Dispatcher__c = null;
                    newwo.GE_SM_HQ_Scheduled_Start_Date_Time__c = null;
                    newwo.GE_SM_HQ_Scheduled_End_Date_Time__c = null;
                }
            }            
                      
        
    }
    
    
    public void afterwoupdate(List<SVMXC__Service_Order__c> oldObjects,Map<Id, SVMXC__Service_Order__c> newObjectMap){
        
         List<SVMXC__Service_Order__c> dtswolist = new List<SVMXC__Service_Order__c>();
        List<Id> dtsteams = new List<Id>();
        List<SVMXC__Dispatcher_Access__c> dispatcherlist = new List<SVMXC__Dispatcher_Access__c>();
        
        for(SVMXC__Service_Order__c oldwo:oldObjects){
            if(oldwo.RecordTypeid == recrdtypeid){
            SVMXC__Service_Order__c newwo = newObjectMap.get(oldwo.Id);
            dtswolist.add(oldwo);
            dtsteams.add(newwo.SVMXC__Service_Group__c);
            }
        }
            
         if(dtswolist.size()>0){
            
          dispatcherlist = [select id,SVMXC__Dispatcher__c,GE_HQ_Not_Home_Territory__c,SVMXC__Service_Team__c from SVMXC__Dispatcher_Access__c where SVMXC__Dispatcher__c =:userinfo.getUserId() and SVMXC__Service_Team__c in : dtsteams ];
         
         }
        Map<Id,SVMXC__Dispatcher_Access__c> dispatchermap = new Map<Id,SVMXC__Dispatcher_Access__c>();
        for(SVMXC__Dispatcher_Access__c d :dispatcherlist){
        
        dispatchermap.put(d.SVMXC__Service_Team__c,d);
        
        }
        List<SVMXC__SVMX_Event__c> evtlist = new List<SVMXC__SVMX_Event__c>();
        for(SVMXC__Service_Order__c oldwo: dtswolist){
            
            
                
                SVMXC__Service_Order__c newwo = newObjectMap.get(oldwo.Id);
                
                if(oldwo.SVMXC__Dispatch_Status__c == 'New' && newwo.SVMXC__Dispatch_Status__c != oldwo.SVMXC__Dispatch_Status__c){
                   
                     SVMXC__Dispatcher_Access__c dispatcher = dispatchermap.get(newwo.SVMXC__Service_Group__c);
                     
                    if(dispatcher!=null){
                    if(dispatcher.GE_HQ_Not_Home_Territory__c){
                        
                        Approval.ProcessSubmitRequest req = 
                            new Approval.ProcessSubmitRequest();
                        req.setComments('Submitting request for approval.');
                        req.setObjectId(oldwo.id);
                        Approval.ProcessResult result = Approval.process(req);
                        System.debug('DTS APPROVAL FIRED');
                        
                    } 
                    }
                    system.debug('IN DTS AFTER WO UPDATE');            
                }
                if(oldwo.SVMXC__Dispatch_Status__c.equals('Queued') && newwo.GE_SM_HQ_Borrowed_Technician_Approved_On__c != null){
                     
                    System.debug('In Event Create');
                    String s = newwo.GE_PC_Driving_Directions__c;
                    string[] eve = s.split(',');
                    
                    for(Integer i=0;i<eve.size();i++){
                        SVMXC__SVMX_Event__c  event = new SVMXC__SVMX_Event__c ();
                        string[] token = eve[i].split(';');
                        String team = token[1];
                        String tech = token[0];
                        Boolean allday = Boolean.valueOf(token[2]);
                        DateTime sd = DateTime.parse(token[3]);
                        DateTime ed = DateTime.parse(token[4]);
                        event.ownerid = oldwo.ownerid;
                        event.SVMXC__Service_Team__c = team;
                        event.SVMXC__Technician__c = tech;
                        event.SVMXC__Service_Order__c = newwo.id;
                        event.Name = newwo.Name;
                        event.SVMXC__StartDateTime__c = sd;
                        event.SVMXC__EndDateTime__c = ed;
                        event.SVMXC__IsAllDayEvent__c = allday;
                        event.SVMXC__Location__c = newwo.SVMXC__Site__r.Name;
                        event.SVMXC__WhatId__c = newwo.id;
                        event.SVMXC__ActivityDate__c  = sd.Date();
                        event.SVMXC__ActivityDateTime__c  = sd;
                        decimal minutes = (decimal.valueOf(ed.getTime() - sd.getTime())).divide(1000,0).divide(60,0);
                        event.SVMXC__DurationInMinutes__c  = integer.valueOf(math.floor(minutes));
                        evtlist.add(event);  
                    }
                    
                    
                    
                    
                }
                
            }   
        
         if(evtlist.size()>0){  
              insert evtlist;       
            } 
        
        
    }   
    
    public void nonhomeeventdelete(List<SVMXC__SVMX_Event__c>  evt){
        
        Map<Id,SVMXC__SVMX_Event__c> eventmap = new Map<Id,SVMXC__SVMX_Event__c>();
        List<Id> evntIds = new List<Id>();
        List<SVMXC__Service_Order__c> nonhomewo = new List<SVMXC__Service_Order__c>();
        String eventinfo = ''; 
        List<DateTime> endtime = new List<DateTime>();
        Set<Id> techidset = new set<Id>();
        List<SVMXC__SVMX_Event__c> dtseventlist = new List<SVMXC__SVMX_Event__c>();
        List<String> dtsteamlist = new List<String>();
        
        for(SVMXC__SVMX_Event__c e: evt){
            techidset.add(e.SVMXC__Technician__c);   
        }
         Map<Id,Id> techrecordtypemap = new Map<Id,Id>();  
         List<Id> dtstechlist = new List<Id>();      
        List<SVMXC__Service_Group_Members__c> techlist = [select id,recordtypeid from SVMXC__Service_Group_Members__c where id in : techidset];        
        for(SVMXC__Service_Group_Members__c tech : techlist){
            techrecordtypemap.put(tech.id,tech.RecordTypeId);
        }      
        
        for(SVMXC__SVMX_Event__c e: evt){
         if(techrecordtypemap.get(e.SVMXC__Technician__c) == techrecrtype){  
         dtseventlist.add(e);
       
         dtstechlist.add(e.SVMXC__Technician__c);
         dtsteamlist.add(e.GE_DS_Service_Team__c); 
         }            
        }
        
        List<SVMXC__Service_Group__c> teamlist = [select id,Name,GE_HQ_Resource_Director__c  from SVMXC__Service_Group__c where Name in: dtsteamlist];
        
        
        Map<String,Id> teammap = new Map<String,Id>();
        
        
        
        Map<String,Id> usermap = new Map<String,Id>();
        
        for(SVMXC__Service_Group__c t:teamlist){
            usermap.put(t.Name,t.GE_HQ_Resource_Director__c);
            teammap.put(t.name,t.id);
        }
        
        List<User> homeUser = [Select TimeZoneSidKey from User where id in : usermap.values()];
        
        Map<Id,String> homeusermap = new Map<Id,String>();
        for(User h :homeUser){
        homeusermap.put(h.id,h.TimezoneSidkey);
        }
        
        
        List<SVMXC__Dispatcher_Access__c> dispatcherlist = [select id,SVMXC__Dispatcher__c,GE_HQ_Not_Home_Territory__c,SVMXC__Service_Team__r.Name from SVMXC__Dispatcher_Access__c where SVMXC__Dispatcher__c =:userinfo.getUserId() and SVMXC__Service_Team__c in : teamlist ];
        Map<String,SVMXC__Dispatcher_Access__c> dispatchermap = new Map<String,SVMXC__Dispatcher_Access__c>();
         Map<Id,SVMXC__Dispatcher_Access__c> dispatchermap1 = new Map<Id,SVMXC__Dispatcher_Access__c>();
         
        for(SVMXC__Dispatcher_Access__c d :dispatcherlist){        
        dispatchermap.put(d.SVMXC__Service_Team__r.Name,d);        
        }
        
        for(SVMXC__Dispatcher_Access__c d :dispatcherlist){
         dispatchermap1.put(d.SVMXC__Service_Team__c,d);  
        }
        
        for(SVMXC__SVMX_Event__c e:dtseventlist){
            eventmap.put(e.SVMXC__Service_Order__c,e);   
            endtime.add(e.SVMXC__EndDateTime__c);            
         
           
           SVMXC__Dispatcher_Access__c dispatcher = dispatchermap.get(e.GE_DS_Service_Team__c);
            if(dispatcher!=null){
            if(dispatcher.GE_HQ_Not_Home_Territory__c){
            evntIds.add(e.Id);  
            Id teamid = teammap.get(e.GE_DS_Service_Team__c);
            Id serviceleader = usermap.get(e.GE_DS_Service_Team__c);
            String timezone =  homeusermap.get(serviceleader); 
       
            String sd = e.SVMXC__StartDateTime__c.format('MM/dd/yyyy h:mm a',timezone);
            String ed = e.SVMXC__EndDateTime__c.format('MM/dd/yyyy h:mm a',timezone);
            eventinfo = eventinfo + e.SVMXC__Technician__c+';'+teamid+';'+e.SVMXC__IsAllDayEvent__c+';'+sd+';'+ed+',';
            }
            }
            
        }
        endtime.sort();
        DateTime etime = null;
        if(endtime.size()>0){
        etime = endtime[endtime.size()-1];
        }
        system.debug('eventinfo'+eventinfo);
        List<SVMXC__Service_Order__c> wolist = [select id,recordtypeid,GE_PC_Driving_Directions__c,GE_SM_HQ_Record_Type_Name__c,SVMXC__Service_Group__c,GE_SM_HQ_Technician_Home_Dispatcher__c,GE_SM_HQ_Borrowed_Technician_Approved_On__c from SVMXC__Service_Order__c where id=:eventmap.keyset()];
       
        
        if(wolist.size()>0){            
            for(SVMXC__Service_Order__c wo : wolist){
                if(wo.recordtypeid == recrdtypeid){
                    if(wo.GE_SM_HQ_Borrowed_Technician_Approved_On__c == null){
                       // List<SVMXC__Dispatcher_Access__c> dispatcher = [select id,SVMXC__Dispatcher__c,GE_HQ_Not_Home_Territory__c from SVMXC__Dispatcher_Access__c where SVMXC__Dispatcher__c =:userinfo.getUserId() and SVMXC__Service_Team__c =:wo.SVMXC__Service_Group__c];
                        // SVMXC__SVMX_Event__c evnt = eventmap.get(wo.Id);
                        SVMXC__Dispatcher_Access__c dispatcher = dispatchermap1.get(wo.SVMXC__Service_Group__c);
                        if(dispatcher!=null){
                        if(dispatcher.GE_HQ_Not_Home_Territory__c){
                            wo.GE_PC_Driving_Directions__c = eventinfo;
                            wo.GE_SM_HQ_Scheduled_End_Date_Time__c = etime;
                            nonhomewo.add(wo);
                            delete [select id from SVMXC__SVMX_Event__c where id=:evntIds];                           
                            }
                        }                                                                      
                    }
                }
            }
        }
        
        
        if(nonhomewo.size()>0){
            update nonhomewo;
            sendEmail(nonhomewo[0].id,nonhomewo[0].GE_SM_HQ_Technician_Home_Dispatcher__c);
        }        
        
    }
        
    
    public void sendEmail(Id woid,Id receiverid){
    
    EmailTemplate et = [select id from EmailTemplate where developername='GE_OG_DTS_WorkOrderBorrowTechApproval'];
    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    mail.setTemplateId(et.id);
    mail.setTargetObjectId(receiverid);
    mail.setSaveAsActivity(false);
    mail.setWhatId(woid);
    Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    
    }
    
    
}