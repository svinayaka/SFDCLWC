/*    
Class Name        : GE_Case_Trasbin
Purpose/Overview  : send a case to Trashbin.
Author            : Lakshmi Prasanna Kethu
Created Date      : 28 Jan 2013
Test Class        : GE_Case_Trasbin_Test
*/
/*
Change History    : Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
                    June 18 2013  : Prasanna Kethu     : Added DS P&L Trashbin functionality : New P&L DS enter into SFDC System.
                  : March 31 2015 : Raju Manche        : Added MCS-TS P&L Trashbin functionality . MC-TS Cases loaded to TQ_MC_TRASHBIN 
*/
global class GE_Case_Trasbin{

    
    Webservice static Boolean TrashBin(String s){
    
        system.debug('<<Incoming>>'+s);
        String urlCaseId;
        List<String> lCaseId= New List<String>();
        List<Case> lCase_selected= New List<Case>();
        List<Case> updateCase= New List<Case>();
        
        RecordType case_MCS_CS= New RecordType();
        RecordType case_MC_TS= New RecordType();
        RecordType case_DS_CSR= New RecordType();
     // RecordType case_DRL_INQ= New RecordType();
     // RecordType case_DRL_FDR= New RecordType();

        case_MCS_CS=[Select Name from Recordtype where sobjecttype='case' and Name='MCS - CS'];
        case_MC_TS=[Select Name from Recordtype where sobjecttype='case' and Name='MC-TS'];
        case_DS_CSR=[Select Name from Recordtype where sobjecttype='case' and Name='DS - CSR'];
     // case_DRL_INQ=[Select Name from Recordtype where sobjecttype='case' and Name ='DRL - INQ'];        
     // case_DRL_FDR=[Select Name from Recordtype where sobjecttype='case' and Name ='DRL - FDR'];        
                urlCaseid=s;
        
        system.debug('<<After Processing>>'+s);
        lCaseID=urlCaseID.split(',');            
       
       
        lCase_selected=[select id,OwnerID,Recordtype.Name from Case where ID in :lCaseID];
        
        system.debug('>>>slectedrecords>>'+lCase_selected); 
         
          
        List<QueueSobject> TQ_MC_TRASHBIN;
        List<QueueSobject> TQ_DS_TRASHBIN;
        List<QueueSobject> TQ_DRL_TRASHBIN;
        
        TQ_MC_TRASHBIN = new List<QueueSObject>([select id,Queue.Name,QueueId from QueueSobject where Queue.Name=:'MC_TRASHBIN']);
        
        if(TQ_MC_TRASHBIN.size()>0){
        
            for(Case c:lCase_Selected){
                 //if(c.RecordType.Name==case_MCS_CS.Name){ 
                 //Modified for the MC-TS recordtype cases . Cases owners will changed to MC-TRASHBIN              
                 if(c.RecordType.Name==case_MCS_CS.Name || c.RecordType.Name==case_MC_TS.Name){
                c.Ownerid=TQ_MC_TRASHBIN[0].QueueId; 
                updateCase.add(c);
                }
            
            }
        }
        
        TQ_DS_TRASHBIN = new List<QueueSObject>([Select id,Queue.Name,QueueId from QueueSobject where Queue.Name=:'DT_TRASHBIN']);
         
          if(TQ_DS_TRASHBIN.size()>0){
        
            for(Case ca:lCase_Selected){
                
                if(ca.RecordType.Name==case_DS_CSR.Name){
                ca.Ownerid=TQ_DS_TRASHBIN[0].QueueId;
                updateCase.add(ca);
                    }
                }
             
        }
      /*  TQ_DRL_TRASHBIN = new List<QueueSObject>([Select id,Queue.Name,QueueId from QueueSobject where Queue.Name=:'DRL_TRASHBIN']);
           
           if(TQ_DRL_TRASHBIN.size()>0){
               for(Case cas:lCase_Selected){
                if(cas.RecordType.Name==case_DRL_INQ.Name || cas.RecordType.Name==case_DRL_FDR.Name){
                cas.Ownerid=TQ_DRL_TRASHBIN[0].QueueId;
                updateCase.add(cas);
                    }
                }
             
        } */
         system.debug('>>>updatereocrds>>'+updateCase); 
        update updateCase;
       
        return true;  
    
    }

}