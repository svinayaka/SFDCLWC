public class GE_SS_Calculate_Taining_Days{
    
    //public void GE_SS_sumOf_TrainingDays(List<SVMXC__SVMX_Event__c> newSVMXEvent,Map<ID, SVMXC__SVMX_Event__c> oldMap) {
    public void GE_SS_sumOf_TrainingDays(List<SVMXC__SVMX_Event__c> newSVMXEvent) {
        
        List<SVMXC__SVMX_Event__c> eventList = new List<SVMXC__SVMX_Event__c> ();
        List<SVMXC__Service_Group_Members__c> techList = new List<SVMXC__Service_Group_Members__c> ();
        Set<Id> techId = new Set<Id> ();                
        Map<Id,SVMXC__Service_Group_Members__c> technicians=new Map<Id,SVMXC__Service_Group_Members__c>();
        Date startDateOfYear = Date.newInstance(System.now().year(), 1, 1);
        Date endDateOfYear = Date.newInstance(System.now().year(), 12, 31);
        
        for(SVMXC__SVMX_Event__c svmx : newSVMXEvent){
            // if(svmx.GE_OG_SS_Event_Type__c=='Training' && svmx.SVMXC__Technician__c!=NULL && svmx.GE_OG_SS_Event_Type__c!= oldMap.get(svmx.Id).GE_OG_SS_Event_Type__c){
            if(svmx.SVMXC__Technician__c!=NULL){
                techId.add(svmx.SVMXC__Technician__c);
            }
        }
        if(techId!=Null){        
            technicians=new Map<Id,SVMXC__Service_Group_Members__c>([SELECT id,GE_SS_Total_Personal_Leave_Days__c,GE_SS_Total_Training_Days__c,GE_SS_Total_Calendar_Days_Scheduled__c, (SELECT id,GE_SS_Total_Planned_Days_in_Service__c,SVMXC__StartDateTime__c,SVMXC__EndDateTime__c ,GE_OG_SS_Event_Type__c FROM SVMXC__SVMX_Event__r ) FROM SVMXC__Service_Group_Members__c WHERE Id=:techId]);
            
            eventList=[select id,GE_OG_SS_Event_Type__c,GE_SS_Total_Planned_Days_in_Service__c,SVMXC__StartDateTime__c,SVMXC__EndDateTime__c from SVMXC__SVMX_Event__c where SVMXC__Technician__c=:techId ];            
        }
        
        if(technicians.size() > 0){
            for(SVMXC__Service_Group_Members__c tech: technicians.values()){
                if(technicians.containsKey(tech.Id) && technicians.get(tech.Id).SVMXC__SVMX_Event__r<> null){                    
                    //tech.GE_SS_Total_Training_Days__c=(technicians.get(tech.Id).SVMXC__SVMX_Event__r).size();
                    
                    Decimal intCount = 0;
                    Decimal intCount2 = 0;
                    Decimal intCount3 = 0;
                    for(SVMXC__SVMX_Event__c event : technicians.get(tech.Id).SVMXC__SVMX_Event__r){
                    /*
                        k=k+event.GE_SS_Total_Planned_Days_in_Service__c;
                        if(event.GE_OG_SS_Event_Type__c=='Training'){
                            i=i+event.GE_SS_Total_Planned_Days_in_Service__c;
                        }
                        else if(event.GE_OG_SS_Event_Type__c=='Vacation' || event.GE_OG_SS_Event_Type__c=='Leave' ){
                            j=j+event.GE_SS_Total_Planned_Days_in_Service__c;
                        }*/
                        if( (event.GE_OG_SS_Event_Type__c=='Vacation' || event.GE_OG_SS_Event_Type__c=='Leave' )){ 
                         if((event.SVMXC__EndDateTime__c < endDateOfYear || event.SVMXC__StartDateTime__c >startDateOfYear) ){
                              
                                   {
                                        if(event.SVMXC__StartDateTime__c >= startDateOfYear && event.SVMXC__EndDateTime__c <= endDateOfYear){
                                            intCount = intCount +event.SVMXC__StartDateTime__c.date().daysBetween(event.SVMXC__EndDateTime__c.date())+1;
                                           
                                        }
                                        else if(event.SVMXC__StartDateTime__c >= startDateOfYear && event.SVMXC__StartDateTime__c <= EndDateOfYear && event.SVMXC__EndDateTime__c > endDateOfYear){
                                            intCount = intCount + event.SVMXC__StartDateTime__c.date().daysBetween(endDateOfYear)+1;
                                            
                                        }
                                        else if(event.SVMXC__StartDateTime__c < startDateOfYear && event.SVMXC__EndDateTime__c >= startDateOfYear &&   event.SVMXC__EndDateTime__c<=endDateOfYear){
                                            intCount = intCount + startDateofYEar.daysBetween(event.SVMXC__EndDateTime__c.date())+1;
                                            
                                        }
                                        else if(event.SVMXC__StartDateTime__c < startDateOfYear &&  event.SVMXC__EndDateTime__c>endDateOfYear ){
                                           
                                            intCount = intCount + startDateOfYear.daysBetween(endDateOfYear)+1;
                                          
                                        }
                                        
                                    }
                              }     
                        }
                                          else if( (event.GE_OG_SS_Event_Type__c=='Training' )){
                      
                                   if((event.SVMXC__EndDateTime__c < endDateOfYear || event.SVMXC__StartDateTime__c >startDateOfYear) ){
                              
                                   {
                                        if(event.SVMXC__StartDateTime__c >= startDateOfYear && event.SVMXC__EndDateTime__c <= endDateOfYear){
                                            intCount2 = intCount2 +event.SVMXC__StartDateTime__c.date().daysBetween(event.SVMXC__EndDateTime__c.date())+1;
                                           
                                        }
                                        else if(event.SVMXC__StartDateTime__c >= startDateOfYear && event.SVMXC__StartDateTime__c <= EndDateOfYear && event.SVMXC__EndDateTime__c > endDateOfYear){
                                            intCount2 = intCount2 + event.SVMXC__StartDateTime__c.date().daysBetween(endDateOfYear)+1;
                                            
                                        }
                                        else if(event.SVMXC__StartDateTime__c < startDateOfYear && event.SVMXC__EndDateTime__c >= startDateOfYear &&   event.SVMXC__EndDateTime__c<=endDateOfYear){
                                            intCount2 = intCount2 + startDateofYEar.daysBetween(event.SVMXC__EndDateTime__c.date())+1;
                                            
                                        }
                                        else if(event.SVMXC__StartDateTime__c < startDateOfYear &&  event.SVMXC__EndDateTime__c>endDateOfYear ){
                                            intCount2 = intCount2 + startDateOfYear.daysBetween(endDateOfYear)+1;
                                        }
                                        
                                    }
                              }     
                        }
                     else if(event.GE_OG_SS_Event_Type__c== null){
                      if((event.SVMXC__EndDateTime__c < endDateOfYear || event.SVMXC__StartDateTime__c >startDateOfYear) ){
                              
                                        if(event.SVMXC__StartDateTime__c >= startDateOfYear && event.SVMXC__EndDateTime__c <= endDateOfYear){
                                            intCount3 = intCount3 +event.SVMXC__StartDateTime__c.date().daysBetween(event.SVMXC__EndDateTime__c.date())+1;
                                           
                                        }
                                        else if(event.SVMXC__StartDateTime__c >= startDateOfYear && event.SVMXC__StartDateTime__c <= EndDateOfYear && event.SVMXC__EndDateTime__c > endDateOfYear){
                                            intCount3 = intCount3 + event.SVMXC__StartDateTime__c.date().daysBetween(endDateOfYear)+1;
                                            
                                        }
                                        else if(event.SVMXC__StartDateTime__c < startDateOfYear && event.SVMXC__EndDateTime__c >= startDateOfYear && event.SVMXC__EndDateTime__c<=endDateOfYear){
                                            intCount3 = intCount3 + startDateofYEar.daysBetween(event.SVMXC__EndDateTime__c.date())+1;
                                            
                                        }
                                        else if(event.SVMXC__StartDateTime__c < startDateOfYear &&  event.SVMXC__EndDateTime__c>endDateOfYear ){
                                            intCount3 = intCount3 + startDateOfYear.daysBetween(endDateOfYear)+1;
                                        }
                                        
                                    }
                              } 
                    }
                    tech.GE_SS_Total_Training_Days__c=intCount2;
                    tech.GE_SS_Total_Personal_Leave_Days__c=intCount; 
                    tech.GE_SS_Total_Calendar_Days_Scheduled__c=intCount3;      
                    techList.add(tech);
                }
            }
        
        if(!techList.isEmpty())
        {
            update techList;
        }
        }
    }
    
        public void GE_SS_sumOf_TrainingDaysupdate(List<SVMXC__SVMX_Event__c> newSVMXEvent,Map<ID, SVMXC__SVMX_Event__c> oldMap) {
    //public void GE_SS_sumOf_TrainingDays(List<SVMXC__SVMX_Event__c> newSVMXEvent) {
        
        List<SVMXC__SVMX_Event__c> eventList = new List<SVMXC__SVMX_Event__c> ();
        List<SVMXC__Service_Group_Members__c> techList = new List<SVMXC__Service_Group_Members__c> ();
        Set<Id> techId = new Set<Id> ();                
        Map<Id,SVMXC__Service_Group_Members__c> technicians=new Map<Id,SVMXC__Service_Group_Members__c>();
        Date startDateOfYear = Date.newInstance(System.now().year(), 1, 1);
        Date endDateOfYear = Date.newInstance(System.now().year(), 12, 31);
       // Deceimal currentYear = System.now().year();
        
        for(SVMXC__SVMX_Event__c svmx : newSVMXEvent){
             //if(svmx.GE_OG_SS_Event_Type__c!=Null && svmx.SVMXC__Technician__c!=NULL && ((svmx.SVMXC__StartDateTime__c!= oldMap.get(svmx.Id).SVMXC__StartDateTime__c)||(svmx.SVMXC__EndDateTime__c!= oldMap.get(svmx.Id).SVMXC__EndDateTime__c))){
           
            if(svmx.SVMXC__Technician__c!=NULL && ((svmx.SVMXC__StartDateTime__c!= oldMap.get(svmx.Id).SVMXC__StartDateTime__c)||(svmx.SVMXC__EndDateTime__c!= oldMap.get(svmx.Id).SVMXC__EndDateTime__c)||svmx.GE_OG_SS_Event_Type__c!=oldMap.get(svmx.Id).GE_OG_SS_Event_Type__c) ){
             //(svmx.GE_OG_SS_Event_Type__c!=Null && 
                techId.add(svmx.SVMXC__Technician__c);
               
            }
        }
        if(techId!=Null){        
            technicians=new Map<Id,SVMXC__Service_Group_Members__c>([SELECT id,GE_SS_Total_Personal_Leave_Days__c,GE_SS_Total_Training_Days__c,GE_SS_Total_Calendar_Days_Scheduled__c, (SELECT id,GE_SS_Total_Planned_Days_in_Service__c,SVMXC__EndDateTime__c,SVMXC__StartDateTime__c,GE_OG_SS_Event_Type__c FROM SVMXC__SVMX_Event__r ) FROM SVMXC__Service_Group_Members__c WHERE Id=:techId]);
            
            eventList=[select id,GE_OG_SS_Event_Type__c,GE_SS_Total_Planned_Days_in_Service__c,SVMXC__EndDateTime__c,SVMXC__StartDateTime__c from SVMXC__SVMX_Event__c where SVMXC__Technician__c=:techId];            
        }
        
        if(technicians.size() > 0){
            for(SVMXC__Service_Group_Members__c tech: technicians.values()){
                if(technicians.containsKey(tech.Id) && technicians.get(tech.Id).SVMXC__SVMX_Event__r<> null){                    
                    Decimal intCount = 0;
                    Decimal intCount2 = 0;
                    Decimal intCount3 = 0;
                    for(SVMXC__SVMX_Event__c event : technicians.get(tech.Id).SVMXC__SVMX_Event__r){
                    /*
                        k=k+event.GE_SS_Total_Planned_Days_in_Service__c;
                        if(event.GE_OG_SS_Event_Type__c=='Training'){
                            i=i+event.GE_SS_Total_Planned_Days_in_Service__c;
                        }
                        else if(event.GE_OG_SS_Event_Type__c=='Vacation' || event.GE_OG_SS_Event_Type__c=='Leave' ){
                            j=j+event.GE_SS_Total_Planned_Days_in_Service__c;
                        }*/
                        
                        String eventType=event.GE_OG_SS_Event_Type__c;
                        if( (event.GE_OG_SS_Event_Type__c=='Vacation' || event.GE_OG_SS_Event_Type__c=='Leave' )){ 
                         if((event.SVMXC__EndDateTime__c < endDateOfYear || event.SVMXC__StartDateTime__c >startDateOfYear) ){
                              
                                   {
                                        if(event.SVMXC__StartDateTime__c >= startDateOfYear && event.SVMXC__EndDateTime__c <= endDateOfYear){
                                            intCount = intCount +event.SVMXC__StartDateTime__c.date().daysBetween(event.SVMXC__EndDateTime__c.date())+1;
                                          
                                        }
                                        else if(event.SVMXC__StartDateTime__c >= startDateOfYear && event.SVMXC__StartDateTime__c <= EndDateOfYear && event.SVMXC__EndDateTime__c > endDateOfYear){
                                            intCount = intCount + event.SVMXC__StartDateTime__c.date().daysBetween(endDateOfYear)+1;
                                          
                                        }
                                      
                                        else if(event.SVMXC__StartDateTime__c < startDateOfYear && event.SVMXC__EndDateTime__c >= startDateOfYear &&   event.SVMXC__EndDateTime__c <=endDateOfYear){
                                            intCount = intCount + startDateofYEar.daysBetween(event.SVMXC__EndDateTime__c.date())+1;
                                            
                                        }
                                        else if(event.SVMXC__StartDateTime__c < startDateOfYear &&  event.SVMXC__EndDateTime__c > endDateOfYear ){
                                            //intCount = tech.GE_SS_Total_Personal_Leave_Days__c+ startDateOfYear.daysBetween(endDateOfYear)+1;
                                            intCount = intCount + startDateOfYear.daysBetween(endDateOfYear)+1;
                                         
                                                                                  
                                        }
                                        
                                        }
                              }     
                        }
                      else if( (event.GE_OG_SS_Event_Type__c=='Training' )){
                      
                                   if((event.SVMXC__EndDateTime__c < endDateOfYear || event.SVMXC__StartDateTime__c >startDateOfYear) ){
                              
                                   {
                                        if(event.SVMXC__StartDateTime__c >= startDateOfYear && event.SVMXC__EndDateTime__c <= endDateOfYear){
                                            intCount2 = intCount2 +event.SVMXC__StartDateTime__c.date().daysBetween(event.SVMXC__EndDateTime__c.date())+1;
                                           
                                        }
                                        else if(event.SVMXC__StartDateTime__c >= startDateOfYear && event.SVMXC__StartDateTime__c <= EndDateOfYear && event.SVMXC__EndDateTime__c > endDateOfYear){
                                            intCount2 = intCount2 + event.SVMXC__StartDateTime__c.date().daysBetween(endDateOfYear)+1;
                                            
                                        }
                                        else if(event.SVMXC__StartDateTime__c < startDateOfYear && event.SVMXC__EndDateTime__c >= startDateOfYear &&  event.SVMXC__EndDateTime__c<=endDateOfYear){
                                            intCount2 = intCount2 + startDateofYEar.daysBetween(event.SVMXC__EndDateTime__c.date())+1;
                                            
                                        }
                                        else if(event.SVMXC__StartDateTime__c < startDateOfYear &&  event.SVMXC__EndDateTime__c>endDateOfYear ){
                                            intCount2 = intCount2 + startDateOfYear.daysBetween(endDateOfYear)+1;
                                        }
                                        
                                    }
                              } 
                               System.debug('End of Training Calculation');    
                        }
                       
                    else if(event.GE_OG_SS_Event_Type__c == null){
                    // else if(isEmpty(eventType) == true){
                     
                     if((event.SVMXC__EndDateTime__c < endDateOfYear || event.SVMXC__StartDateTime__c >startDateOfYear)){
                               System.debug('Begining of Calender Days Calculation');
                                        if(event.SVMXC__StartDateTime__c >= startDateOfYear && event.SVMXC__EndDateTime__c <= endDateOfYear){
                                            intCount3 = intCount3 +event.SVMXC__StartDateTime__c.date().daysBetween(event.SVMXC__EndDateTime__c.date())+1;
                                           
                                        }
                                        else if(event.SVMXC__StartDateTime__c >= startDateOfYear && event.SVMXC__StartDateTime__c <= EndDateOfYear && event.SVMXC__EndDateTime__c > endDateOfYear){
                                            intCount3 = intCount3 + event.SVMXC__StartDateTime__c.date().daysBetween(endDateOfYear)+1;
                                            
                                        }
                                        else if(event.SVMXC__StartDateTime__c < startDateOfYear && event.SVMXC__EndDateTime__c >= startDateOfYear &&  event.SVMXC__EndDateTime__c<=endDateOfYear){
                                            intCount3 = intCount3 + startDateofYEar.daysBetween(event.SVMXC__EndDateTime__c.date())+1;
                                            
                                        }
                                        else if(event.SVMXC__StartDateTime__c < startDateOfYear &&  event.SVMXC__EndDateTime__c>endDateOfYear ){
                                            intCount3 = intCount3 + startDateOfYear.daysBetween(endDateOfYear)+1;
                                        }
                                        
                                    }
                              }     
                        
                    }
                    tech.GE_SS_Total_Training_Days__c=intCount2;
                    tech.GE_SS_Total_Personal_Leave_Days__c=intCount; 
                    tech.GE_SS_Total_Calendar_Days_Scheduled__c=intCount3;      
                    techList.add(tech);
                }
            }
        
        if(!techList.isEmpty())
        {
            update techList;
        }
        }
    }
}