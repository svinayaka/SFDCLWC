public class GE_OG_SVMXEvent {

public SVMXC__SVMX_Event__c SVMXEvent{get;set;}
public SVMXC__SVMX_Event__c sv;    
Public Datetime endDate{get;set;}
public String URLofCurrentPage{get;set;}
Public Datetime startDate{get;set;}
public string Tech{get;set;}
public String MessageDisplay{get;set;}
public Boolean isShowMsg{get;set;}
public Boolean isShowError{get;set;}
public String ErrorMessage{get;set;}
public List<SVMXC__Dispatcher_Access__c> Dispatcher{get;set;}
public List<SVMXC__Service_Group_Members__c> technician{get;set;}        
Public List<WrapperTechnician> WrapperList{get;set;}
Public Boolean SelectAll{get;set;}    
public boolean TechnicianTable{get;set;}
public boolean EventStatusDisplay{get;set;}
public List<SVMXC__SVMX_Event__c> OldEvents{get;set;}  
public  long dt1Long{get;set;} 
public  long dt2Long{get;set;}
public  long milliseconds{get;set;}
public  long seconds{get;set;}
public  long DurationInMinutes{get;set;}
public boolean checkDate= false;

    
    private ApexPages.StandardController controller;
    
    public boolean DatesCheck(){
    
       SVMXEvent=  (SVMXC__SVMX_Event__c)controller.getRecord();
      
       If(SVMXEvent.SVMXC__StartDateTime__c > SVMXEvent.SVMXC__EndDateTime__c )
        {
            checkDate=true;
        system.debug('check of flag '+checkDate);
        }
        return checkDate;
        }
    
    
    
    public GE_OG_SVMXEvent(ApexPages.StandardController controller) {
              
    this.controller=controller;
    technician=new List<SVMXC__Service_Group_Members__c>();
        Dispatcher=new List<SVMXC__Dispatcher_Access__c>();
        OldEvents=new List<SVMXC__SVMX_Event__c>();
    TechnicianTable=false;
      isShowError=FALSE;
      ErrorMessage='';
      MessageDisplay='';
      EventStatusDisplay=false;
    }
      // Generating technicians
    
    public PageReference getGenerateTechnician(){
        
        
    GE_OG_SVMXEvent objc = new GE_OG_SVMXEvent(controller);
    
    this.controller=controller;
    
    boolean checkDate = objc.DatesCheck();
        
        
    MessageDisplay='';
    isShowError=FALSE;
    List<ID> serviceTeamDetails=new List<ID>(); 
    SVMXEvent=  (SVMXC__SVMX_Event__c)controller.getRecord();    
    
    if(SVMXEvent.Name==NULL|| SVMXEvent.Name=='')
    { 
       isShowError=TRUE;
       ErrorMessage='Enter Subject ';
    }else if(SVMXEvent.SVMXC__Type__c==Null || SVMXEvent.SVMXC__Type__c==''){
        isShowError=TRUE;
        ErrorMessage='Enter Event Type ';
    }
    
  else  if(SVMXEvent.SVMXC__StartDateTime__c==NULL )
    { 
       isShowError=TRUE;
       ErrorMessage='Enter Event Start Date ';
    }
     
     else if(SVMXEvent.SVMXC__EndDateTime__c==NULL )
     {
        isShowError=TRUE;
          ErrorMessage='Enter Event END Date ';
     }
    
    else if(SVMXEvent.SVMXC__Service_Team__c==NULL){
    
       isShowError=TRUE;
       ErrorMessage='Enter Service Team';
    
    }
    else IF(checkDate==true){
        
        isShowError=TRUE;
        ErrorMessage='End date has to be greater than start date';
    }
    

    else{
         
        Dispatcher=[Select id,SVMXC__Dispatcher__c,SVMXC__Service_Team__c from SVMXC__Dispatcher_Access__c where SVMXC__Service_Team__c=:SVMXEvent.SVMXC__Service_Team__c And SVMXC__Dispatcher__c=:Userinfo.getUserID()];
        system.debug('*****Dispatcher*****'+Dispatcher.size());
           
           if(Dispatcher.size()>0){
            TechnicianTable=true;
           for(SVMXC__Dispatcher_Access__c Dispatcher:Dispatcher){
               
               serviceTeamDetails.add(Dispatcher.SVMXC__Service_Team__c);
          
           }
             
           if(serviceTeamDetails.size()>0){
                technician.clear();
               technician.addall([Select ID,Name,SVMXC__Active__c,SVMXC__Service_Group__c from SVMXC__Service_Group_Members__c where SVMXC__Service_Group__c IN:serviceTeamDetails] );         
           }
           
  System.debug('^^^^^^^^^ WrapperList Before gettech method end'+WrapperList);  
    
           if(technician.Size()!=0){
                        
                        getWrapperList();
                    }else{
                        isShowError=TRUE;
                       ErrorMessage='Service Team Does not have any Technicians';
                        
                    }
           }else{
           isShowError=TRUE;      
           ErrorMessage='You do not have Dispather Access to the selected Service Team';       
           }       
       }
       
        System.debug('^^^^^^^^^^ WrapperList after gettech method end'+WrapperList);
    
           return null;     
              }
    
    
    
 public PageReference save()
 {
 
      GE_OG_SVMXEvent objc1 = new GE_OG_SVMXEvent(controller);        
      boolean checkDate = objc1.DatesCheck();
 
    isShowError=FALSE;
    SVMXEvent=  (SVMXC__SVMX_Event__c)controller.getRecord();
    
    if(checkDate==true)
    { 
        isShowError=TRUE;
        ErrorMessage='End date has to be greater than start date';
       }

    System.debug('$$$$$ WrapperList At save method Start'+WrapperList);

    /*
    for(integer i=0;i<WrapperList.size();i++){
    OldEvents=[Select id,SVMXC__StartDateTime__c,SVMXC__EndDateTime__c,SVMXC__Technician__c from SVMXC__SVMX_Event__c where SVMXC__StartDateTime__c>=:SVMXEvent.SVMXC__StartDateTime__c And SVMXC__EndDateTime__c<=:SVMXEvent.SVMXC__EndDateTime__c And SVMXC__Technician__c=:SVMXEvent.SVMXC__Technician__c];
    }
    */  
      
    //system.debug('*****OldEvents*****'+OldEvents.size());
    list<SVMXC__Service_Group_Members__c> technician1=new List<SVMXC__Service_Group_Members__c>();
    List<SVMXC__SVMX_Event__c> event1=new List<SVMXC__SVMX_Event__c>();

       // set<id> AEIds=new set<id>();
      // for(WrapperTechnician objTech  :WrapperList)
       // if(objTech.Check==TRUE)
       //  AEIds.add(objTech.tech.id);
         
          
    // OldEvents.addall([Select id,SVMXC__StartDateTime__c,SVMXC__EndDateTime__c,SVMXC__Technician__c from SVMXC__SVMX_Event__c where SVMXC__Technician__c IN :AEIds ]);
    //   system.debug('$$$$ Old Events'+ OldEvents);

    //if(OldEvents.size()==0){
        
        
        
        
       if(WrapperList==null || WrapperList.size()==0)
         {
             SVMXC__SVMX_Event__c sevent =new SVMXC__SVMX_Event__c();
                  sevent=(SVMXC__SVMX_Event__c)controller.getRecord();
                  if( sevent.SVMXC__Service_Team__c==Null)
                   {
                     isShowError=TRUE;
                      ErrorMessage='Please Select a Service team';
                   }
                    else
                    {
                      isShowError=TRUE;
                      ErrorMessage='Enter all necessary inputs';
                     }
                   
         }
        else{
         System.debug('#### What is the wrapper list  ----'+WrapperList);
         system.debug('#### What is the wrapper size  ----'+WrapperList.size());
        
        for(WrapperTechnician WT: WrapperList)
        {
          system.debug('$$$$$$$$$$$$$ What is wrapepr here'+WT);
            If(WT.Check == True)
             technician1.add(WT.Tech);
        }
           
                // If no Technecian created , then populate an error
                if(technician1.size()==0)
                {
                   isShowError=TRUE;
                   ErrorMessage='Select technicians to whom you want to create event';
                    
                   
                }

                 system.debug('check value 2'+checkDate);
                  
         for(SVMXC__Service_Group_Members__c  Tech:technician1)
         {
   
            if(SVMXEvent.Name!=null && SVMXEvent.SVMXC__Type__c!=null && !checkDate )
            {
                SVMXC__SVMX_Event__c event=new SVMXC__SVMX_Event__c();
                event.Name=SVMXEvent.Name;
                event.SVMXC__Description__c=SVMXEvent.SVMXC__Description__c;
                event.SVMXC__Technician__c=Tech.Id;
                event.SVMXC__StartDateTime__c=SVMXEvent.SVMXC__StartDateTime__c;
                event.SVMXC__EndDateTime__c=SVMXEvent.SVMXC__EndDateTime__c;
                event.SVMXC__Type__c = SVMXEvent.SVMXC__Type__c;
               // event1.add(event);
                dt1Long = SVMXEvent.SVMXC__EndDateTime__c.getTime();
                dt2Long = SVMXEvent.SVMXC__StartDateTime__c.getTime();
                milliseconds = dt1Long - dt2Long;
                seconds = milliseconds / 1000;
                DurationInMinutes = seconds / 60;
                SVMXEvent.SVMXC__DurationInMinutes__c = DurationInMinutes;
                event.SVMXC__DurationInMinutes__c=SVMXEvent.SVMXC__DurationInMinutes__c;
                System.debug('min value of variable;'+DurationInMinutes);
                System.debug('min value of field;'+SVMXEvent.SVMXC__DurationInMinutes__c);
                event1.add(event);         
                              }
            
            
            
            
            
            
            }
        }
    System.debug('SVMXC__Service_Team__c'+SVMXEvent.SVMXC__Service_Team__c);
     
                      
                      // HK START
                     
                        list<SVMXC__SVMX_Event__c> ExistingEveLi=new  list<SVMXC__SVMX_Event__c>();
                        set<id> SetExistEventIDs=new set<id>();
                        // check the event list before inserting for event
                          for(SVMXC__SVMX_Event__c ObjEve:event1)
                           SetExistEventIDs.add(ObjEve.SVMXC__Technician__c);
                          String EventCheck='NO';
                          system.debug('##### What the events to be checked---'+event1);
                      // Query for already existing events    
                               if(SetExistEventIDs.size()>0)
                                ExistingEveLi.addall([select id,name,SVMXC__StartDateTime__c ,SVMXC__EndDateTime__c,SVMXC__Technician__c from SVMXC__SVMX_Event__c where SVMXC__Technician__c IN:SetExistEventIDs]);
                                
                                System.Debug('$$$$$ Existign event size '+ExistingEveLi.size());
                                system.debug('$$$$$$ alredy Existing events'+ExistingEveLi);
                                
                      // Check for over lap  
                        
                        System.debug('$$$$$$ did I go inside if I have events');
                        
                        List<SVMXC__SVMX_Event__c> LeftOverlap=new List<SVMXC__SVMX_Event__c>();
                        List<SVMXC__SVMX_Event__c> LyingBtW=new List<SVMXC__SVMX_Event__c>();
                        List<SVMXC__SVMX_Event__c> RightOverlap=new List<SVMXC__SVMX_Event__c>();
                        List<SVMXC__SVMX_Event__c> streachedOut=new List<SVMXC__SVMX_Event__c>();
                        List<SVMXC__SVMX_Event__c> ExactTimestampEves=new List<SVMXC__SVMX_Event__c>();
                        
                         System.debug('###### Event List Before process---'+event1);
                        
                         for(SVMXC__SVMX_Event__c OldEveObj:ExistingEveLi)   
                             {
                                  for(SVMXC__SVMX_Event__c NewEveObj  :event1)
                                  {
                                     if(NewEveObj.SVMXC__Technician__c==OldEveObj.SVMXC__Technician__c)
                                     {
                                          // 1st Scenario (new event overlapping from left)
                                        //(New.SD< Old.SD && New.ED >Old.SD && New.ED<Old.ED) 

                                        If ( NewEveObj.SVMXC__StartDateTime__c < OldEveObj.SVMXC__StartDateTime__c &&  NewEveObj.SVMXC__EndDateTime__c   > OldEveObj.SVMXC__StartDateTime__c  && NewEveObj.SVMXC__EndDateTime__c   < OldEveObj.SVMXC__EndDateTime__c)
                                        LeftOverlap.add(OldEveObj);
                                        //system.debug('###### Overlapping from left ----'+LeftOverlap);

                                        //2nd Scenario (new event lying in between)
                                        //(New.SD>Old.SD && NEW.ED <OLD.ED)
                                          If(NewEveObj.SVMXC__StartDateTime__c > OldEveObj.SVMXC__StartDateTime__c &&  NewEveObj.SVMXC__EndDateTime__c   < OldEveObj.SVMXC__EndDateTime__c)
                                         LyingBtW.add(OldEveObj);
                                         //system.debug('##### new event lying in between---'+LyingBtW); 
                                         
                                         //3rd Scenario (New event overlapping from right)
                                        //  (New.SD>Old.SD && New.SD<Old.ED&&NewED>Old.ED)
                                         
                                          If(NewEveObj.SVMXC__StartDateTime__c > OldEveObj.SVMXC__StartDateTime__c && NewEveObj.SVMXC__StartDateTime__c < OldEveObj.SVMXC__EndDateTime__c   && NewEveObj.SVMXC__EndDateTime__c   > OldEveObj.SVMXC__EndDateTime__c)
                                         RightOverlap.add(OldEveObj); 
                                         //system.debug('##### Overlapping from right ----'+RightOverlap); 
                                         
                                         //4th Scenario (New event streached out an old event)
                                        //(New.SD<Old.SD && New.ED>Old.ED )

                                          If(NewEveObj.SVMXC__StartDateTime__c < OldEveObj.SVMXC__StartDateTime__c && NewEveObj.SVMXC__EndDateTime__c   > OldEveObj.SVMXC__EndDateTime__c)
                                         streachedOut.add(OldEveObj);                                    
                                         
                                         // 5Th scenario (When time stamps are exactly same)
                                         //(New.SD=Old.SD && New.ED=Old.ED )
                                         
                                          if( NewEveObj.SVMXC__StartDateTime__c== OldEveObj.SVMXC__StartDateTime__c && NewEveObj.SVMXC__EndDateTime__c == OldEveObj.SVMXC__EndDateTime__c)
                                           ExactTimestampEves.add(OldEveObj);
                                         
                                         //system.debug('#####  New event streached out an old event---'+streachedOut); 
                                     }
                                      
                                        
                                  }                    
                             
                            
                            }
                            
                            if(LeftOverlap.size()>0)
                              system.debug('###### Overlapping from left ----'+ LeftOverlap);
                             else if(LyingBtW.size()>0)
                              system.debug('##### new event lying in between---'+ LyingBtW);
                             else if(RightOverlap.size()>0)
                              system.debug('##### Overlapping from right ----'+ RightOverlap);
                              else if (streachedOut.size()>0)
                               system.debug('#####  New event streached out an old event---'+ streachedOut); 
                                else if(ExactTimestampEves.size()>0)
                                      system.debug('#####  Events with the same time stamp are ---'+ streachedOut);                     
                               else {
                                    System.debug('$$$$$$$$$     NEW SCENARIO HAS BEEN FOUND OUT ');
                               }
                               
                             //if((LeftOverlap.size()==0 && LyingBtW.size()==0 && RightOverlap.size()==0 && streachedOut.size()==0 && ExactTimestampEves.size()==0) || ExistingEveLi.size()==0) 
                               // {       
     if(!event1.isEmpty()){
         insert event1;
                                         system.debug('$$$$$$ Events created' +event1);                    
         if(event1.size() == 1){
             MessageDisplay= event1.Size() + ' Event is Created'; 
         }else{
             MessageDisplay = event1.Size() + ' Events are Created';
         }        
          EventStatusDisplay=true;                                   
      }
                                         
                           // }
                       /*  else
                            {
                            
                            system.debug('$$$$$$$$ Am I popping up the error '+EventCheck);
                               isShowError=TRUE;              
                               TechnicianTable=TRUE;
                               ErrorMessage='One or more of the selected Technicians already have events allocated for selected time period';
                               EventStatusDisplay=false;
                                             
                         // HK END
                             
                            
            
                        
        } */              
            return null;

    }

public PageReference cancel() {
return null;
}

Public List<WrapperTechnician> getWrapperList(){
        WrapperList = new List<WrapperTechnician>();
        //Check1 = False;
        for(SVMXC__Service_Group_Members__c  Tech:technician){
            WrapperList.add(new WrapperTechnician(Tech));
        }
        return WrapperList;
   }
Public Class WrapperTechnician{
        Public SVMXC__Service_Group_Members__c  tech{get;set;}
        Public Boolean Check{get;set;}
        Public WrapperTechnician(SVMXC__Service_Group_Members__c  t ){
            tech = t;
            Check = false;
        }
   }
public pagereference getSelectAll(){
        
        for(WrapperTechnician wr : WrapperList){
            wr.Check =SelectAll ;
        }
        return null;
    }
    
   public pagereference ReSetAll(){
     
     ErrorMessage='';
     isShowError=FALSE;
     MessageDisplay='';    
          
     //pg.setRedirect(true);
          
     return null;
   }    
    
     public pagereference CurrentpageURL()
     {
         SVMXEvent.GE_OG_MC_Subject__c='';        
            
        URLofCurrentPage=Apexpages.currentPage().getUrl();
       PageReference pageRef=new PageReference(URLofCurrentPage); 
       return pageRef;
     }
    
}