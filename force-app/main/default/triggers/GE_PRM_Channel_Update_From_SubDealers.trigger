trigger GE_PRM_Channel_Update_From_SubDealers on Sub_Dealer__c (After Update, After Insert, After Delete) 
{
    boolean check1=false , check2=false ;
    Set<ID> chIds = New Set<ID>();

    If ( Trigger.isInsert || Trigger.IsUpdate )
    {                  
         For ( Sub_Dealer__c c : Trigger.New ) 
         {
              chIds.Add(c.GE_PRM_Channel_Appointment__c); 
         }
    }

    If ( Trigger.isDelete)
    {                  
         For ( Sub_Dealer__c c : Trigger.Old ) 
         {
              chIds.Add(c.GE_PRM_Channel_Appointment__c); 
         }
    }
    
    Map<Id,GE_PRM_Channel_Appointment__c> updateChannel = New Map<Id,GE_PRM_Channel_Appointment__c>();
    
    List<Sub_Dealer__c> subdealers = [Select ID, GE_PRM_Affiliate_dependent_type__c ,
    GE_PRM_Channel_Appointment__c,
    GE_PRM_Channel_Appointment__r.GE_PRM_Des_Chnl_Partner_hv_sb_dea_sbagnt__c,
    GE_PRM_Channel_Appointment__r.GE_PRM_Does_Channel_Partner_have_subsid__c 
    From Sub_Dealer__c Where GE_PRM_Channel_Appointment__c =:chIds ];    
    
    System.debug('********** SUB **   '+subdealers );
    
    
    
    
    If(subdealers == null || subdealers.size() < 1)
    
    {         
         For ( GE_PRM_Channel_Appointment__c c : [Select GE_PRM_Des_Chnl_Partner_hv_sb_dea_sbagnt__c,GE_PRM_Does_Channel_Partner_have_subsid__c
         From  GE_PRM_Channel_Appointment__c where Id in:chIds] )
         {
             c.GE_PRM_Des_Chnl_Partner_hv_sb_dea_sbagnt__c = 'No';
             c.GE_PRM_Does_Channel_Partner_have_subsid__c = 'No';
             updateChannel.put(c.ID,c);
         }
         
         System.debug('********** UPD**   '+updateChannel);
    }
    
    else
    {
    
    For ( Sub_Dealer__c sd : subdealers )
    {
       
       If ( sd.GE_PRM_Affiliate_dependent_type__c == 'Sub-Agent' || sd.GE_PRM_Affiliate_dependent_type__c == 'Sub-Dealer' )
       {          
          sd.GE_PRM_Channel_Appointment__r.GE_PRM_Des_Chnl_Partner_hv_sb_dea_sbagnt__c = 'Yes' ;         
          //updateChannel.put(sd.GE_PRM_Channel_Appointment__c, sd.GE_PRM_Channel_Appointment__r);
          check1=true;
       }
       else If ( !check1 )
       {
          sd.GE_PRM_Channel_Appointment__r.GE_PRM_Des_Chnl_Partner_hv_sb_dea_sbagnt__c = 'No' ;
          //updateChannel.put(sd.GE_PRM_Channel_Appointment__c, sd.GE_PRM_Channel_Appointment__r);         
       }
       
       If ( sd.GE_PRM_Affiliate_dependent_type__c == 'Branch' || sd.GE_PRM_Affiliate_dependent_type__c == 'Subsidiary' )
       {         
          sd.GE_PRM_Channel_Appointment__r.GE_PRM_Does_Channel_Partner_have_subsid__c = 'Yes' ;         
         // updateChannel.put(sd.GE_PRM_Channel_Appointment__c, sd.GE_PRM_Channel_Appointment__r);
          check2= True;
       }       
       else If ( !check2)
       {         
          sd.GE_PRM_Channel_Appointment__r.GE_PRM_Does_Channel_Partner_have_subsid__c = 'No' ;           
       }
       updateChannel.put(sd.GE_PRM_Channel_Appointment__c, sd.GE_PRM_Channel_Appointment__r);       
       
    }
    
    }
    
    
    System.debug('********** CHANNEL** '+updateChannel);
     If ( updateChannel.values().size() >0 )
     {
        update updateChannel.values() ;
     }



}