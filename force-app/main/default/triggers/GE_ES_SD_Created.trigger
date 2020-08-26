/*

Trigger Name: GE_ES_SD_Created
Used In : 
Purpose/Overview : A Trigger to delete the exceptions created by the opportunities
Functional Area : Opportunity Management
Author: Prasad Yadala 
Created Date: 4/13/2011
Test Class Name : GE_ES_Currency_PL_MismatchTest

Change History -
Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
05/30/2012    : Prasad Yadala      :                               : for the requirement R-8452

*/

trigger GE_ES_SD_Created on Account (after update) {

  //Code to skip trigger

    
    //[Select Object_Name__c, Trigger_Name__c, isActive__c from OG_Trigger_fire_Decision__c 
    //where Trigger_Name__c='GE_ES_SD_Created' and isActive__c = true and Object_Name__c='Account']);
    
    
    OG_Trigger_fire_Decision__c lstObj = OG_Trigger_fire_Decision__c.getValues('GE_ES_SD_Created');
       
    if(lstObj!=null && lstObj.isActive__c == true && lstObj.Object_Name__c=='Account'){
      
        return;  
    }
    else{
    
    //retrieving the account recordtype id using global describe
    Schema.DescribeSObjectResult d = Schema.SObjectType.Account; 
    Map<String,Schema.RecordTypeInfo> rtMapByName = d.getRecordTypeInfosByName();
    Schema.RecordTypeInfo rtByName =  rtMapByName.get('GE Legal Entity');
    system.debug(rtByName.getRecordTypeId());
    Id LegalRecId = rtByName.getRecordTypeId();       
    
    //variable declaration
    Set<String> ParentDuns = new Set<String>();
    Map<Id,List<Account>> SDAccDataMap = new Map<Id,List<Account>>();    
    Map<Id,List<Opportunity>> OpptyAccMap = new Map<Id,List<Opportunity>>();    
    Set<Id> ParentIds = new Set<Id>();    
    Set<Id> AccIds = new Set<Id>();

    system.debug('**********Before loop'+'**RecID**'+LegalRecId );
    
    //iterates through the list of accounts and get the duns numbers list
    for(Account acc:Trigger.New)
    {
        ParentDuns.add(acc.GE_HQ_HQ_Parent_Duns__c);   
        
    }
    
    
    for(Account acc:Trigger.New)
    {        
        if(Trigger.isUpdate)
        { 
             //enter only if the Functional Currency or Parent of SD is modified or Account Currency is updated 
             if((acc.GE_ES_LE_Type__c == 'Statutory Department' && acc.RecordTypeId == LegalRecId && (acc.GE_ES_Functional_Currency__c != Trigger.oldMap.get(acc.id).GE_ES_Functional_Currency__c || acc.ParentId != Trigger.oldMap.get(acc.id).ParentId)) || (acc.RecordTypeId != LegalRecId && acc.CurrencyISOCode != Trigger.oldMap.get(acc.id).CurrencyISOCode))
             {
                 system.debug('**line57**'+acc.ParentId+'**'+ SDAccDataMap);
                 if(acc.ParentId != null   && acc.GE_ES_LE_Type__c == 'Statutory Department')
                 {
                      List<Account> TAList = new List<Account>();
                      if( SDAccDataMap.containsKey(acc.ParentId))
                      {
                          TAList = SDAccDataMap.get(acc.ParentId); 
                          TAList.add(acc);
                          SDAccDataMap.put(acc.ParentId,TAList);                         
                      }     
                      else                     
                      {
                          system.debug('**line81**'+SDAccDataMap);
                          TAList = new List<Account>();
                          TAList.add(acc);
                          SDAccDataMap.put(acc.ParentId,TAList);
                          system.debug('**line85**'+SDAccDataMap);                                                       
                      }                       
                      ParentIds.add(acc.ParentId); 
                  }
                  else
                  {
                      if(acc.RecordTypeId != LegalRecId)
                      {
                         AccIds.add(acc.id);
                      }
                  }
                           
                  system.debug('**line83**'+acc.ParentId+'**'+ SDAccDataMap);
             }
         } 
        
        system.debug('***AccIds**'+AccIds+'**Parents**'+ParentIds);
    } 
    
    List<Opportunity> Opptylist = new List<Opportunity>();
    
    //List of opportunities related to updated or inserted accounts
/*  Code Clean up #@^!  
   if(AccIds.size() > 0 || ParentIds.size() > 0)
    Opptylist = [select Id,Name,tier_1_ge_og__c,RecordType.Name,GE_ES_GE_Bid_Legal_Entity_Name__c,CurrencyIsoCode,Account.CurrencyIsoCode,Account.GE_HQ_Country_Code__c  from Opportunity where (AccountId in :AccIds or GE_ES_GE_Bid_Legal_Entity_Name__c in :ParentIds) and (RecordType.Name = 'DE' or RecordType.Name = 'IS' or RecordType.Name = 'Env' or RecordType.Name = 'Motors' or RecordType.Name = 'GE Motors Opportunity_MotorsPilot' or RecordType.Name = 'PGS Long Term' or RecordType.Name = 'PGS Short Term' or RecordType.Name = 'GE PW PGS' or RecordType.Name = 'MCS') ];
  */  
  
   if(AccIds.size() > 0 || ParentIds.size() > 0)
    Opptylist = [select Id,Name,tier_1_ge_og__c,RecordType.Name,GE_ES_GE_Bid_Legal_Entity_Name__c,CurrencyIsoCode,Account.CurrencyIsoCode,Account.GE_HQ_Country_Code__c  from Opportunity where (AccountId in :AccIds or GE_ES_GE_Bid_Legal_Entity_Name__c in :ParentIds) and  RecordType.Name = 'MCS' ];
  
    //for(Opportunity o : Opptylist)
    //ParentIds.add(o.GE_ES_GE_Bid_Legal_Entity_Name__c);
    
    system.debug('***line105**'+ParentIds);
     
    Map<Id,Account> LEAccMap = new Map<Id,Account>();
    
    Map<Id,Account> ByrAccMap = new Map<Id,Account>();
    List<Account> AccList = new List<Account>();
    if(AccIds.size() > 0 || ParentIds.size() > 0)
    AccList = [select id,name,GE_HQ_P_L_Type__c,parentid,GE_HQ_HQ_Parent_Duns__c,GE_ES_LE_Type__c,GE_ES_Functional_Currency__c,RecordTypeId from Account where ((ParentId in :SDAccDataMap.keyset() or ParentId in : ParentIds) and GE_ES_LE_Type__c = 'Statutory Department') or id in :ParentIds or  (id in :AccIds and RecordTypeId != :LegalRecId) order by parentid];       
    
    Id Accid = null;
    List<Account> Alist = new List<Account>();
    
    //iterates through all the accounts to build maps
    for(Account A : AccList)
    {        
        //SO map with account Id as key     
        if(A.GE_ES_LE_Type__c == 'Statutory Office')
        LEAccMap.put(A.Id,A); 
        
        //buyer map with account Id as key 
        if(A.RecordTypeId != LegalRecId )
        ByrAccMap.put(A.id,A);  
        
      
    }
    
    //iterates through all the opportunities to build the map of Opportunities for a Bid Legal Entity  
    for(Opportunity opp : Opptylist)
    {
        if(Trigger.newMap.containsKey(opp.GE_ES_GE_Bid_Legal_Entity_Name__c))
        {
            //if opportunities already exists for the Bid Legal Entity 
            if(OpptyAccMap.containsKey(opp.GE_ES_GE_Bid_Legal_Entity_Name__c))
            {
                List<Opportunity> GEOppList = OpptyAccMap.get(opp.GE_ES_GE_Bid_Legal_Entity_Name__c);
                GEOppList.add(opp);
                OpptyAccMap.put(opp.GE_ES_GE_Bid_Legal_Entity_Name__c,GEOppList);
            }
            else
            {
                List<Opportunity> GEOppList = new List<Opportunity>(); 
                GEOppList.add(opp);
                OpptyAccMap.put(opp.GE_ES_GE_Bid_Legal_Entity_Name__c,GEOppList);
            }
        }
        
        //if opportunity's account is modified
        if(Trigger.newMap.containsKey(opp.AccountId))
        {
            if(OpptyAccMap.containsKey(opp.AccountId))
            {
                List<Opportunity> GEOppList = OpptyAccMap.get(opp.AccountId);
                GEOppList.add(opp);
                OpptyAccMap.put(opp.AccountId,GEOppList);
            }
            else
            {
                List<Opportunity> GEOppList = new List<Opportunity>(); 
                GEOppList.add(opp);
                OpptyAccMap.put(opp.AccountId,GEOppList);
            }
        }
        
    }    
    
    List<GE_ES_Exception__c> ExcList = new List<GE_ES_Exception__c>();
    
    //List of existing exceptions 
    if(AccIds.size() > 0 || ParentIds.size() > 0)
    Exclist = [select id,GE_ES_Opportunity_Name__c,GE_ES_Is_SD_Not_Exists__c,GE_ES_Is_Bid_Currency_Mismatch__c,GE_ES_Is_Currency_Mismatch__c,GE_ES_Account_Name__c from GE_ES_Exception__c where GE_ES_Opportunity_Name__r.AccountId in :AccIds or GE_ES_Opportunity_Name__r.GE_ES_GE_Bid_Legal_Entity_Name__c in :ParentIds order by GE_ES_Opportunity_Name__c];
    
    //map to hold oppty id <-> exception list
    Map<Id,List<GE_ES_Exception__c>> MapExcList = new Map<Id,List<GE_ES_Exception__c>>();
    
    //list to hold the exception list related to oppty
    List<GE_ES_Exception__c> Elist = new List<GE_ES_Exception__c>();
    Id Oid = null;
    for(GE_ES_Exception__c E : Exclist)
    {       
        if(Oid != null && Oid != E.GE_ES_Opportunity_Name__c)
        {
            MapExcList.put(Oid,Elist);
            Elist = new List<GE_ES_Exception__c>();
        }
        Elist.add(E);
        Oid = E.GE_ES_Opportunity_Name__c;                       
    }
   
   //building exception map with Opportunity Id as key 
   if(Elist.size() > 0)
   MapExcList.put(Oid,Elist);
   
   Boolean mismatch; 
   List<GE_ES_Exception__c> ExcepList = new List<GE_ES_Exception__c>();
   List<GE_ES_Exception__c> TempExcepList = new List<GE_ES_Exception__c>();
   
   //list to accommodate the exceptions to be deleted
   List<GE_ES_Exception__c> DelExcList = new List<GE_ES_Exception__c>();
    
   for(Opportunity opp : Opptylist )   
    {
        mismatch = true;
        
        boolean chkflag = false;
        //if the Legal Entity have any Statutory Departments
        if(SDAccDataMap.containskey(opp.GE_ES_GE_Bid_Legal_Entity_Name__c))
        {
           
           system.debug('**line 202 ***'+SDAccDataMap.get(opp.GE_ES_GE_Bid_Legal_Entity_Name__c));        
            for(Account A : SDAccDataMap.get(opp.GE_ES_GE_Bid_Legal_Entity_Name__c))
            {
                system.debug('**inside for**');
              
                /*  code Clean up #@^!
                //only the SD's that have the LE Type equal to the opportunity P&L type
                if((opp.RecordType.Name == A.GE_HQ_P_L_Type__c || (A.GE_HQ_P_L_Type__c == 'IS' && (opp.RecordType.Name == 'Motors' || opp.RecordType.Name == 'GE Motors Opportunity_MotorsPilot')) || (A.GE_HQ_P_L_Type__c == 'IS' && opp.RecordType.Name == 'IS') || ((opp.RecordType.Name == 'PGS Long Term' || opp.RecordType.Name == 'PGS Short Term' || opp.RecordType.Name == 'GE PW PGS') && A.GE_HQ_P_L_Type__c == 'PGS') || (A.GE_HQ_P_L_Type__c == 'ENVS' && opp.RecordType.Name == 'Env') || (A.GE_HQ_P_L_Type__c == 'MCS' && opp.RecordType.Name == 'MCS')))
                
                */
                
                //only the SD's that have the LE Type equal to the opportunity P&L type
                
                if((opp.RecordType.Name == A.GE_HQ_P_L_Type__c || (A.GE_HQ_P_L_Type__c == 'MCS' && opp.RecordType.Name == 'MCS')))
                 {
                    system.debug('**inside if**');
                    chkflag = true;
                    //if there exist one SD with functional currency same as opportunity, delete all exceptions
                    if(opp.CurrencyIsoCode == A.GE_ES_Functional_Currency__c)
                    {
                        mismatch = false;
                        if(MapExcList.containskey(opp.id))
                        {
                            //iterate through all the exception for the corresponding oppty and add to delete list
                            for(GE_ES_Exception__c E : MapExcList.get(opp.id))
                            {
                                if(E.GE_ES_Account_Name__c == null || E.GE_ES_Account_Name__c == A.Id)
                                DelExcList.add(E);                                
                            }
                        }
                        
                    } 
                    //if SD's functional currency doesn't match with opportunity currency
                    else
                    {
                        GE_ES_Exception__c Excep = new GE_ES_Exception__c();
                        if(MapExcList.containskey(opp.id))
                        {
                            //iterate through all the exception for the corresponding oppty
                            for(GE_ES_Exception__c E : MapExcList.get(opp.id))
                            {
                                if(A.Id == E.GE_ES_Account_Name__c)
                                Excep = E;
                                
                            }
                            if(Excep.GE_ES_Is_SD_Not_Exists__c == true)
                            Excep.GE_ES_Is_SD_Not_Exists__c = false;
                            if(opp.CurrencyIsoCode == opp.Account.CurrencyIsoCode)
                            Excep.GE_ES_Is_Bid_Currency_Mismatch__c = false;
                            else
                            Excep.GE_ES_Is_Bid_Currency_Mismatch__c = true;
                            Excep.GE_ES_Is_Currency_Mismatch__c = true;
                        }
                        else
                        {
                            //if SD exists and oppty currency mismatches the account currency 
                            Excep = new GE_ES_Exception__c(GE_ES_Opportunity_Name__c = opp.id,GE_ES_Account_Name__c = A.id);
                            if(opp.CurrencyIsoCode != opp.Account.CurrencyIsoCode)
                            Excep.GE_ES_Is_Bid_Currency_Mismatch__c = true;                                                                                                    
                            Excep.GE_ES_Is_Currency_Mismatch__c = true;
                         }                       
                        TempExcepList.add(Excep);
                    }
                }    
                
                system.debug('**currency**'+ opp.RecordType.Name + '**'+ A.GE_HQ_P_L_Type__c + '***'+ opp.CurrencyIsoCode + '**'+ A.GE_ES_Functional_Currency__c );
            }
            
        }
        //if there are any exceptions for the opportunity
        else if(MapExcList.containskey(opp.id))
        {
            GE_ES_Exception__c Excep ;
            
            //updating the existing exceptions based on the updated SD values
            for(GE_ES_Exception__c E : MapExcList.get(opp.id))
            {
                system.debug('***inide exe**'+opp.CurrencyIsoCode+'****'+opp.Account.CurrencyIsoCode);
                Excep = E;
                if(opp.CurrencyIsoCode  != opp.Account.CurrencyIsoCode)
                Excep.GE_ES_Is_Bid_Currency_Mismatch__c = true;
                if(opp.CurrencyIsoCode  == opp.Account.CurrencyIsoCode)
                Excep.GE_ES_Is_Bid_Currency_Mismatch__c = false;
                TempExcepList.add(Excep);
            }
        }        
        
        if(mismatch == false)
        TempExcepList.clear();
        //if there are no SD's  and Exception exist
        if(mismatch == true && chkflag == false && !(MapExcList.containskey(opp.id)))
        {
            GE_ES_Exception__c Excep = new GE_ES_Exception__c(GE_ES_Opportunity_Name__c = opp.id);            
            Excep.GE_ES_Is_SD_Not_Exists__c = true;                        
            TempExcepList.add(Excep);
        }
        
        //adding the new exceptions to the final list
        for(GE_ES_Exception__c E : TempExcepList)
        ExcepList.add(E);
        
        TempExcepList.clear();
    }
    system.debug('**Delete List**'+DelExcList.size());
    
    //performing delete operation on  DelExcList
    if(DelExcList.size() > 0)
    Delete DelExcList;
    
    system.debug('**Exception List**'+ExcepList.size());
    
    //performing insert operation on ExcepList
    if(ExcepList.size() > 0)
    Upsert ExcepList;
    
}    
}