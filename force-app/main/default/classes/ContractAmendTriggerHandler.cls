public class ContractAmendTriggerHandler 
{
    public void OnBeforeDelete(List<Contract_Amendment_GEOG__c> oldContractA, Map<Id,Contract_Amendment_GEOG__c> oldCAMAP)
    {
        Set<Id>CId = new Set<Id>(); 
        List<Contract> Cupdatelist = new List<Contract>();
        
        for(Contract_Amendment_GEOG__c ca : oldContractA)
        {
            if(ca.Type_GEOG__c == 'Extension')
            CId.add(ca.Contract_GEOG__c);
            
            if(Trigger.IsUpdate)
            {
                if(oldCAMAP.get(ca.Id).Type_GEOG__c != ca.Type_GEOG__c && oldCAMAP.get(ca.Id).Type_GEOG__c == 'Extension')
                CId.add(ca.Contract_GEOG__c);
            }
        }
        List<Contract> cupdate = new List<Contract>();
        Map <id,Contract> cMap =new Map<id,Contract>([select id,enddate,Amended_End_Date_GEOG__c,Number_of_Amendments_GEOG__c,No_Of_Extension_Contract_Amendment_GEOG__c from Contract where id in: CId]);
        System.debug('cMap '+ cMap );
        for(Contract_Amendment_GEOG__c ca : oldContractA)
        {
            if(cMap.containsKey(ca.Contract_GEOG__c) && cMap.get(ca.Contract_GEOG__c).No_Of_Extension_Contract_Amendment_GEOG__c ==1)
            {
               cMap.get(ca.Contract_GEOG__c).Amended_End_Date_GEOG__c = null;
               cupdate.add(cMap.get(ca.Contract_GEOG__c));
            }
        }
        update cupdate;
    }

    public void OnAfterInsert(Contract_Amendment_GEOG__c[] newCA, Map<Id,Contract_Amendment_GEOG__c> oldCAMAP)
    {
        Set<Id>CId = new Set<Id>(); 
        List<Contract> Cupdatelist = new List<Contract>();
        
        for(Contract_Amendment_GEOG__c ca : newCA)
        {
            if(ca.Type_GEOG__c == 'Extension')
            CId.add(ca.Contract_GEOG__c);
            if(Trigger.IsUpdate)
            {
                if(oldCAMAP.get(ca.Id).Type_GEOG__c != ca.Type_GEOG__c && oldCAMAP.get(ca.Id).Type_GEOG__c == 'Extension')
                CId.add(ca.Contract_GEOG__c);
            }
        }
        
        Map <id,Contract> cMap =new Map<id,Contract>([select id,enddate,Amended_End_Date_GEOG__c,Number_of_Amendments_GEOG__c from Contract where id in: CId]);
        
        for(AggregateResult result : [select Contract_GEOG__c,MAX(Expiration_date_GEOG__c ) maxdate
            FROM   Contract_Amendment_GEOG__c 
            WHERE   Contract_GEOG__c in : CId AND Type_GEOG__c = 'Extension'
            GROUP BY Contract_GEOG__c])
        {
            System.debug('test'+ result );
            if(cMap.containsKey((Id)result.get('Contract_GEOG__c')))
            {
                if((cMap.get((Id)result.get('Contract_GEOG__c')).EndDate < (Date)result.get('maxdate')))    
                {
                    cMap.get((Id)result.get('Contract_GEOG__c')).Amended_End_Date_GEOG__c = (Date)result.get('maxdate') ;
                    Cupdatelist.add(cMap.get((Id)result.get('Contract_GEOG__c')));
                }
                /*else if((cMap.get((Id)result.get('Contract_GEOG__c')).Number_of_Amendments_GEOG__c > 0) )
                {
                    cMap.get((Id)result.get('Contract_GEOG__c')).Amended_End_Date_GEOG__c = (Date)result.get('maxdate') ;
                    Cupdatelist.add(cMap.get((Id)result.get('Contract_GEOG__c')));
                }*/
            }
        }
        System.debug('CA::' + Cupdatelist );
        update Cupdatelist;
    }
    
    
}