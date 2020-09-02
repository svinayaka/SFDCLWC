/*    
Class Name        : GE_Case_Trasbin
Purpose/Overview  : send selected set of case to Trashbin.
Author            : Lakshmi Prasanna Kethu
Created Date      : 28 Jan 2013
Test Class        : GE_Case_Trasbin_Test
*/
/*
Change History    : Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
                    June 18 2013  : Prasanna Kethu     : Added DS P&L Trashbin functionality : New P&L DS enter into SFDC System.
                    April 28th 2014  : Sudhakar Botta  :   Added Recordtype.Name in the query at line 47
                                                       :   Modified QueueSObject to List<QueueSObject> from line 50 - 52 and subsequently at line 58,70&84
*/


global  class GE_ES_CaseTrashBin_ctrl_delete {

    Webservice static String MyTrashBin(ID caseId){return null;}

    Webservice static String TrashBin(String s){
        String urlCaseId;
        List<String> lCaseId= New List<String>();
        List<Case> lCase_selected= New List<Case>();
        List<Case>
        ted= New List<Case>();
        List<Case> updateCase= New List<Case>();
        
        RecordType case_MCS_CS= New RecordType();
        RecordType case_DS_CSR= New RecordType();
        //RecordType case_DRL_INQ= New RecordType();       
        //RecordType case_DRL_FDR= New RecordType();
          
                  
        case_MCS_CS=[Select Name from Recordtype where sobjecttype='case' and Name='MCS - CS'];
        case_DS_CSR=[Select Name from Recordtype where sobjecttype='case' and Name='DS - CSR'];
        //case_DRL_INQ=[Select Name from Recordtype where sobjecttype='case' and Name ='DRL - INQ'];        
       //case_DRL_FDR=[Select Name from Recordtype where sobjecttype='case' and Name ='DRL - FDR'];        
              
        
        urlCaseid=s;
        if(urlCaseid.contains(',')){
        lCaseID.add(urlCaseid);
        }else{
             lCaseID=urlCaseID.split(',');            
        }
       
        lCase_selected=[select id,OwnerID,Recordtype.Name from Case where ID in :lCaseID];
        
        system.debug('>>>slectedrecords>>'+lCase_selected); 
        
         List<QueueSobject> TQ_MC_TRASHBIN;
         List<QueueSobject> TQ_DS_TRASHBIN;
         List<QueueSobject> TQ_DRL_TRASHBIN;

         
              
        
        TQ_MC_TRASHBIN= new List<QueueSObject>([select id,Queue.Name,QueueId from QueueSobject where Queue.Name=:'MC_TRASHBIN']);
        
        if(TQ_MC_TRASHBIN!=null){
        
            for(Case c:lCase_Selected){
                 if(c.RecordType.Name==case_MCS_CS.Name){
                c.Ownerid=TQ_MC_TRASHBIN[0].QueueId;
                updateCase.add(c);
            
            }
          }
        }
                TQ_DS_TRASHBIN= new List<QueueSObject>([Select id,Queue.Name,QueueId from QueueSobject where Queue.Name=:'DS_TRASHBIN']);
         
          if(TQ_DS_TRASHBIN!=null){
        
            for(Case ca:lCase_Selected){
                
                if(ca.RecordType.Name==case_DS_CSR.Name){
                ca.Ownerid=TQ_DS_TRASHBIN[0].QueueId;
                updateCase.add(ca);
                    }
                }
             
        }
        
       /* TQ_DRL_TRASHBIN= new List<QueueSObject>([select id,Queue.Name,QueueId from QueueSobject where Queue.Name=:'DRL_TRASHBIN']);
        
        if(TQ_DRL_TRASHBIN!=null){
        
            for(Case cas:lCase_Selected){
                 if(cas.RecordType.Name==case_DRL_INQ.Name || cas.RecordType.Name==case_DRL_FDR.Name){                
                 cas.Ownerid=TQ_DRL_TRASHBIN[0].QueueId;
                updateCase.add(cas);
            
            }
          }
        }*/

        update updateCase;
        system.debug('>>>updatereocrds>>'+updateCase); 
        
        
        //p= new PageReference('/500');
        return '';  
    
    }

    
}