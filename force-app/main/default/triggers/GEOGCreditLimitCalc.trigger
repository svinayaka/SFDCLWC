trigger GEOGCreditLimitCalc on GE_HQ_CUST_CREDIT_HIST__c (before insert, before update) {

     List<GE_HQ_CUST_CREDIT_HIST__c> accountsToProcess = new List<GE_HQ_CUST_CREDIT_HIST__c>();
    // Map<ID, List<Opportunity>> crOppsMap = new Map<ID, List<Opportunity>>();
     Map<ID, List<Opportunity>> crOppsMapOG = new Map<ID, List<Opportunity>>();
     MAP<ID, ID> crAccsMap=new Map<ID, ID>();
     Set<ID> acctids=new Set<ID>();  
     Set<ID> crids = new Set<ID>();
       
     
       for (GE_HQ_CUST_CREDIT_HIST__c a : trigger.new) { 
       
           if( trigger.isInsert){
                 if( a.GE_HQ_Acct_Cr_Limit__c !=  null ){       
                          crids.add(a.id); 
                          acctids.add(a.GE_HQ_Acc__c);
                          crAccsMap.put(a.id, a.GE_HQ_Acc__c);              
                  }        
            }
            else if(trigger.isUpdate)
            {     crids.add(a.id); 
                  acctids.add(a.GE_HQ_Acc__c);  
                  crAccsMap.put(a.id, a.GE_HQ_Acc__c);             
            }              
        }
        
        system.debug('Pass 1 Size:'+acctids.size());
        if(acctids!=null && acctids.size()>0){
 
        //List<Opportunity> allOpps = [Select Id,AccountId,StageName,convertCurrency(Amount),convertCurrency(pipeline_amount_ge_og__c),delivery_date_ge_og__c,GE_ES_R_Status__c,tier_1_ge_og__c from Opportunity where ((StageName='Active - Commit') OR (StageName='Closed Won' AND delivery_date_ge_og__c > TODAY)) AND (GE_ES_R_Status__c !=null) AND (GE_ES_R_Status__c != 'R0') AND tier_1_ge_og__c in ('Oil & Gas (O&G)') AND AccountId in :acctids];
               
       List<Opportunity> allOpps = [Select Id,AccountId,StageName,convertCurrency(Amount),convertCurrency(pipeline_amount_ge_og__c),delivery_date_ge_og__c,tier_1_ge_og__c from Opportunity where ((StageName='Active - Commit') OR (StageName='Closed Won' AND delivery_date_ge_og__c > TODAY)) AND tier_1_ge_og__c in ('Oil & Gas (O&G)') AND AccountId in :acctids];
               
            system.debug('Pass 2 Size:'+allOpps.size()); 
            if(allOpps != null && allOpps.size()>0){            
                for(ID crid: crids ){
                   //List<Opportunity> PWoppList = new List<Opportunity>();
                   List<Opportunity> OGoppList = new List<Opportunity>();
                   ID accid = crAccsMap.get(crid);
                   for(Opportunity opp : allOpps){
                      //if (accid == opp.AccountId && opp.tier_1_ge_og__c=='Power & Water (P&W)'){
                       //  PWoppList.add(opp);     
                     // } 
                      if (accid == opp.AccountId && opp.tier_1_ge_og__c=='Oil & Gas (O&G)'){
                         OGoppList.add(opp); 
                      } 
                   }
                   //crOppsMap.put(crid, PWoppList);
                   crOppsMapOG.put(crid, OGoppList);
                }            
            }   
            
           //system.debug('Pass 3 crOppsMap Size:'+crOppsMap.size());
            system.debug('Pass 4 crOppsMapOG Size:'+crOppsMapOG.size());
           
            for(GE_HQ_CUST_CREDIT_HIST__c a: Trigger.new){
             //if( (a.GE_HQ_Bus_Tier_1__c=='P&W') || (a.GE_HQ_Bus_Tier_1__c=='O&G'))
              if (a.GE_HQ_Bus_Tier_1__c=='O&G') { 

               double Total_AR_s = 0;
               double Credit_Limit =0;
               double Total_Pipeline_Amount=0;
               

               if(a.GE_HQ_Cr_Watchlist__c==null || a.GE_HQ_Cr_Watchlist__c == 'No' ){
                 a.GE_HQ_Cr_Watchlist_Level__c=null;                  
               }
               //  The following if block can be eliminated. Because, only those records are added whose GE_HQ_Acct_Cr_Limit__c is != NULL. So the following condition is never meeting (and test class coverage will also not meet 100%).
               if (a.GE_HQ_Acct_Cr_Limit__c  ==  null){
                  a.GE_HQ_Cr_Limit_Exceeded__c=false;    a.GE_HQ_Cr_Info_Available__c = 'No';    continue;
               }

               if( a.GE_HQ_Tot_AR_s__c  ==  null || a.GE_HQ_Tot_AR_s__c ==0){Total_AR_s = 0;} 
               else {Total_AR_s = a.GE_HQ_Tot_AR_s__c;}
              
               if( a.GE_HQ_Acct_Cr_Limit__c  ==  null || a.GE_HQ_Acct_Cr_Limit__c  ==  null){Credit_Limit  = 0;}
               else {Credit_Limit  = a.GE_HQ_Acct_Cr_Limit__c;}
               Total_Pipeline_Amount = 0;

               // For PW type CCH
              /* if(a.GE_HQ_Bus_Tier_1__c=='P&W' && crOppsMap != null){
                    List<Opportunity> PWoppList = crOppsMap.get(a.id);
                    if(PWoppList !=null && PWoppList.size() >0)
                    {                   
                        for(Opportunity opps : PWoppList){
                            Total_Pipeline_Amount = Total_Pipeline_Amount + opps.Amount;   
                        }
                    }    
                }     */
               
               // For OG type CCH
               if(a.GE_HQ_Bus_Tier_1__c=='O&G' && crOppsMapOG != null){
                    System.debug('Pass 5 a.GE_HQ_Bus_Tier_1__c:'+a.GE_HQ_Bus_Tier_1__c);
                    List<Opportunity> OGoppList = crOppsMapOG.get(a.id);
                    if(OGoppList !=null && OGoppList.size() >0)
                    {                   
                        for(Opportunity opps : OGoppList){
                            Total_Pipeline_Amount = Total_Pipeline_Amount + opps.Amount;   
                        }
                    }    
                }     

                System.debug('Pass 5 Total_Pipeline_Amount:'+Total_Pipeline_Amount);
                a.GE_HQ_Cr_Limit_Remaining__c =(Credit_Limit  - Total_AR_s - Total_Pipeline_Amount);
                System.debug('Pass 5 Credit_Limit:'+Credit_Limit);
                System.debug('Pass 5 Total_AR_s:'+Total_AR_s);
                System.debug('Pass 5 GE_HQ_Cr_Limit_Remaining__c:'+a.GE_HQ_Cr_Limit_Remaining__c);
                a.GE_HQ_Cr_Info_Available__c = 'Yes';
                
                if((a.GE_HQ_Cr_Limit_Remaining__c) < 0)
                {
                    a.GE_HQ_Cr_Limit_Exceeded__c=True;
                    a.GE_HQ_Cr_Lt_Exceeded_Dt__c=System.today();
                }
                else
                {
                    a.GE_HQ_Cr_Limit_Exceeded__c=false;
                    a.GE_HQ_Cr_Lt_Exceeded_Dt__c =null;
                }
            } 
        }
        }
}