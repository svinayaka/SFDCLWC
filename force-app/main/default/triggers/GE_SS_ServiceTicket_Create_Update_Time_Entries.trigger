trigger GE_SS_ServiceTicket_Create_Update_Time_Entries on GE_SS_Service_Ticket__c (After Insert , After Update) {
   List<GE_SS_Time__c> lsttimeEntries = New List<GE_SS_Time__c>(); 
    Integer noofcon;
    Date StartDate ;
    Date EndDate ;
    
    if(Trigger.isInsert && Trigger.isAfter){
        List<GE_SS_Service_Ticket__c> lstSerTckt = trigger.new;
        
        for(GE_SS_Service_Ticket__c ST :lstSerTckt){
            if(ST.GE_SS_Service_Start_Date__c != null && ST.GE_SS_Service_Finish_Date__c != null){
               noofcon = ST.GE_SS_Service_Start_Date__c.daysBetween(ST.GE_SS_Service_Finish_Date__c);
               System.debug('-----noofcon------'+noofcon );
               for(Integer i=0;i<=noofcon;i++){
                  System.debug('-----i------'+i);
                  StartDate = ST.GE_SS_Service_Start_Date__c.addDays(i);
                  
                  GE_SS_Time__c TE = New GE_SS_Time__c();
                   TE.GE_SS_Service_Ticket__c = ST.id;
                   if(i==0){
                     TE.GE_SS_Date__c= ST.GE_SS_Service_Start_Date__c;
                   }else{                  
                     TE.GE_SS_Date__c = StartDate ; 
                   }
                   TE.GE_OG_SS_Total_Billable_Days__c = 1.00;
                   TE.GE_OG_SS_Time_Entry_Type__c = 'Regular';
                   TE.GE_OG_SS_Total_Billable_Hours__c = 12.00;
                   TE.GE_SS_WBS__c = ST.GE_SS_Billing_Reference__c;
                   lsttimeEntries.add(TE);
               }
            }
        }
        insert lsttimeEntries;
    }
    
    if(Trigger.isUpdate && Trigger.isAfter){
       List<GE_SS_Service_Ticket__c> lststck = New List<GE_SS_Service_Ticket__c>();
       List<GE_SS_Time__c> lsttimeEntries1 = New List<GE_SS_Time__c>(); 
       for(GE_SS_Service_Ticket__c STck : trigger.new){
         if (Trigger.oldMap.get(STck.Id).GE_SS_Service_Start_Date__c != Trigger.newMap.get(STck.Id).GE_SS_Service_Start_Date__c || Trigger.oldMap.get(STck.Id).GE_SS_Service_Finish_Date__c != Trigger.newMap.get(STck.Id).GE_SS_Service_Finish_Date__c){ 
          lststck.add(STck);
         }
       
             if( Trigger.oldMap.get(STck.Id).GE_SS_Service_Finish_Date__c != Trigger.newMap.get(STck.Id).GE_SS_Service_Finish_Date__c && Trigger.oldMap.get(STck.Id).GE_SS_Service_Finish_Date__c < Trigger.newMap.get(STck.Id).GE_SS_Service_Finish_Date__c){
                 noofcon = Trigger.oldMap.get(STck.Id).GE_SS_Service_Finish_Date__c.daysBetween(Trigger.newMap.get(STck.Id).GE_SS_Service_Finish_Date__c);
                 System.debug('---------second if---------==='+noofcon);
                for(Integer j=1;j<=noofcon;j++){
                   StartDate = Trigger.oldMap.get(STck.Id).GE_SS_Service_Finish_Date__c.addDays(j);
                   GE_SS_Time__c TE1 = New GE_SS_Time__c();
                   TE1.GE_SS_Service_Ticket__c = STck.id;
                   Date Chgedate = Trigger.oldMap.get(STck.Id).GE_SS_Service_Finish_Date__c;
                   if(j==1){
                     TE1.GE_SS_Date__c= Chgedate.addDays(1);
                   }else{                  
                     TE1.GE_SS_Date__c = StartDate ; 
                   }
                   TE1.GE_OG_SS_Total_Billable_Days__c = 1.00;
                   TE1.GE_OG_SS_Time_Entry_Type__c = 'Regular';
                   TE1.GE_OG_SS_Total_Billable_Hours__c = 12.00;
                   lsttimeEntries.add(TE1);
                }
              
           }
       
         for(GE_SS_Time__c Stime : [Select id,GE_SS_Service_Ticket__c, GE_SS_Date__c  from GE_SS_Time__c where GE_SS_Service_Ticket__c IN :lststck]){
           if(STck.GE_SS_Service_Finish_Date__c < Stime.GE_SS_Date__c && STck.id == Stime.GE_SS_Service_Ticket__c){
               System.debug('---------frist if---------');
               lsttimeEntries1.add(Stime);
           } 
        
          
         }
       }
       if(!lsttimeEntries1.IsEmpty()){
         Delete lsttimeEntries1; 
       } 
        
       if(!lsttimeEntries.IsEmpty()){
         Insert lsttimeEntries; 
       }        
    }
    
}