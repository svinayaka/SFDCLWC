trigger GEESPopulateSICDesc on Account (before insert, before update) {

  //Code to skip trigger

    OG_Trigger_fire_Decision__c lstObj = OG_Trigger_fire_Decision__c.getValues('GEESPopulateSICDesc');
       
    if(lstObj!=null && lstObj.isActive__c == true && lstObj.Object_Name__c=='Account'){
      
        return;  
    }

   else{ 
    /*
       Description: Populates SIC1 Description, SIC2 Description, SIC3 Description fields 
       on Account based on information stored in SIC1, SIC2 and SIC3
    */

    List<Account> accountsToProcess = new List<Account>();
    Map<Double, Id> SICCode_Map = new Map<Double, Id>();  
    Set<Double> SICCode = new Set<Double>();
    
    
    for (Account a : trigger.new) { 
    
        if(a.GE_HQ_SIC1__c ==  null && a.GE_HQ_SIC2__c ==  null && a.GE_HQ_SIC3__c ==  null) 
          continue;
          
        if (trigger.isInsert) 
        {    
            if( a.GE_HQ_SIC1__c  !=  null || a.GE_HQ_SIC2__c  !=  null || a.GE_HQ_SIC3__c  !=  null )
            {
                accountsToProcess.add(a);             
              
                if(a.GE_HQ_SIC1__c  !=  null && !SICCode.contains(a.GE_HQ_SIC1__c )) 
                {    SICCode.add(a.GE_HQ_SIC1__c);
                }            
                if(a.GE_HQ_SIC2__c  !=  null && !SICCode.contains(a.GE_HQ_SIC2__c ))  
                {    SICCode.add(a.GE_HQ_SIC2__c);
                }
                if(a.GE_HQ_SIC3__c  !=  null && !SICCode.contains(a.GE_HQ_SIC3__c )) 
                {    SICCode.add(a.GE_HQ_SIC3__c);
                }  
           }      
        }else if (trigger.isUpdate) {
        
            if(((a.GE_HQ_SIC1__c  !=  null) && (a.GE_HQ_SIC1__c != trigger.oldmap.get(a.Id).GE_HQ_SIC1__c))
               || ((a.GE_HQ_SIC2__c  !=  null) && (a.GE_HQ_SIC2__c != trigger.oldmap.get(a.Id).GE_HQ_SIC2__c))
               || ((a.GE_HQ_SIC3__c  !=  null) && (a.GE_HQ_SIC3__c != trigger.oldmap.get(a.Id).GE_HQ_SIC3__c)))
               {
                accountsToProcess.add(a);         
                if( (a.GE_HQ_SIC1__c  !=  null) && (a.GE_HQ_SIC1__c != trigger.oldmap.get(a.Id).GE_HQ_SIC1__c) && !SICCode.contains(a.GE_HQ_SIC1__c ))
                    SICCode.add(a.GE_HQ_SIC1__c);
                if( (a.GE_HQ_SIC2__c  !=  null) && (a.GE_HQ_SIC2__c != trigger.oldmap.get(a.Id).GE_HQ_SIC2__c) && !SICCode.contains(a.GE_HQ_SIC2__c ))
                    SICCode.add(a.GE_HQ_SIC2__c);            
                if( (a.GE_HQ_SIC3__c  !=  null) && (a.GE_HQ_SIC3__c != trigger.oldmap.get(a.Id).GE_HQ_SIC3__c) && !SICCode.contains(a.GE_HQ_SIC3__c ))
                    SICCode.add(a.GE_HQ_SIC3__c);  
              }
        }       
    }   // end of for loop
    
    for (GE_ES_ITO_SIC_Code__c sic : [Select Id, Name, GE_ES_SIC_Code__c  from GE_ES_ITO_SIC_Code__c where GE_ES_SIC_Code__c in :SICCode]) 
       SICCode_Map.put(sic.GE_ES_SIC_Code__c, sic.id ); 

    for(Account a : accountsToProcess ){
    
        if (trigger.isInsert){            
            if(a.GE_HQ_SIC1__c  !=  null) 
            {    a.GE_ES_SIC1_Description__c =  SICCode_Map.get(a.GE_HQ_SIC1__c);
            }            
            if(a.GE_HQ_SIC2__c  !=  null) 
            {    a.GE_ES_SIC2_Description__c =  SICCode_Map.get(a.GE_HQ_SIC2__c);
            }
            if(a.GE_HQ_SIC3__c  !=  null) 
            {    a.GE_ES_SIC3_Description__c =  SICCode_Map.get(a.GE_HQ_SIC3__c);
            }
        }else if (trigger.isUpdate){
        
            if( (a.GE_HQ_SIC1__c  !=  null) && (a.GE_HQ_SIC1__c != trigger.oldmap.get(a.Id).GE_HQ_SIC1__c))
                  a.GE_ES_SIC1_Description__c =  SICCode_Map.get(a.GE_HQ_SIC1__c);                 
            
            if( (a.GE_HQ_SIC2__c  !=  null) && (a.GE_HQ_SIC2__c != trigger.oldmap.get(a.Id).GE_HQ_SIC2__c))
                 a.GE_ES_SIC2_Description__c =  SICCode_Map.get(a.GE_HQ_SIC2__c);
 
            if( (a.GE_HQ_SIC3__c  !=  null) && (a.GE_HQ_SIC3__c != trigger.oldmap.get(a.Id).GE_HQ_SIC3__c))
                 a.GE_ES_SIC3_Description__c =  SICCode_Map.get(a.GE_HQ_SIC3__c);
        }
    
    }         
        
   } 
} // end of trigger