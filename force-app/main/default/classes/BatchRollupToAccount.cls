//Class with debug Latest code DEV

public class BatchRollupToAccount
{
   
 
   //For LegalEntityQuickView(X)
   public void LegalEntityQuickView(List<Account> accountList)
    {
    
    //System.debug('accountList in '+accountList);
        Set<Id> setAccId = new Set<Id>();
         List<Account> ListCountryId = new List<Account>();//contains all country id's corresponding to global acct
        List<Account> ListRegionalId = new List<Account>();//contains all regional id's corresponding to globa acct
        List<Account> ListGlobalId = new List<Account>();//contains all regional id's corresponding to globa acct
        
        //setAccId.add('0011200001H9m2J');
        System.debug('accountList in '+setAccId);
        System.debug('accountList in '+setAccId.size());
        for(Account acc : accountList){
            if(acc.Account_Tier_GEOG__c == 'Global')
                setAccId.add(acc.Id);
        }
        

//System.debug('setAccId**'+setAccId);
//System.debug('setAccId****size'+setAccId.size());
        List<Account> lstAccountToUpdate = new List<Account>();
        Map<Id,Integer> mapAccountId_CountAccountTeamMember = new Map<Id,Integer>();
        
        
        // Rollup at country level from LE level
        
        AggregateResult result = null;
        
       List<AggregateResult> results=[SELECT Oil_Gas_Parent_Account__c, COUNT(Id) cnt
                                       FROM Account
                                       WHERE Member_of_GE_OG__c  IN:setAccId AND Account_Tier_GEOG__c = 'LE'
                                       AND Account_Status__c='CC Approved'
                                       GROUP BY Oil_Gas_Parent_Account__c];
                                       
                                       
                                       
                                       
    
    

    Set<id> countryAcctWithLe=new Set<id>();
    
    
                                       
 system.debug('SIZE OF AGG '+results.size());
if(results.size()>0){
    for(AggregateResult aggresults : results){
        
        
        if(aggresults != null){
            
            countryAcctWithLe.add((Id)aggresults.get('Oil_Gas_Parent_Account__c'));
            system.debug('aggresult******'+aggresults.get('cnt'));
mapAccountId_CountAccountTeamMember.put((Id)aggresults.get('Oil_Gas_Parent_Account__c'),(Integer)aggresults.get('cnt'));          
        }
        
    }
}

ListCountryId=[SELECT id from Account WHERE Member_of_GE_OG__c  IN:setAccId AND Account_Tier_GEOG__c = 'Country' ];  
    
    Set<id> allCountryid=new Set<id>();
    for(Account a:ListCountryId)
    {
        
        allCountryid.add(a.id);
    }

    
    for(id i:countryAcctWithLe)
    {
        
        if(allCountryid.contains(i))
        {
            
            allCountryid.remove(i);
        }
    }
    
    if(allCountryid.size() > 0)
        
    
    {
        for(id i:allCountryid)
        {
            mapAccountId_CountAccountTeamMember.put(i,0);
            
        }
        
    }
                                       
                                       
        
            
            
        
        // Rollup at Regional level from LE level
        
        //AggregateResult result = null;
        List<AggregateResult> results1=[SELECT Oil_Gas_Parent_Account__r.ParentId parentAccount,COUNT(Id) cnt
                                       FROM Account
                                       WHERE Member_of_GE_OG__c  IN:setAccId AND Account_Tier_GEOG__c = 'LE'
                                       AND Account_Status__c='CC Approved'
                                       GROUP BY Oil_Gas_Parent_Account__r.ParentId];
                                       
                                       Set<id> regionAcctWithLe=new Set<id>();
                                       
                                       
                                       system.debug('SIZE OF AGG '+results1.size());
if(results1.size()>0){
    for(AggregateResult aggresults : results1){
        
        
        if(aggresults != null){
            
            countryAcctWithLe.add((Id)aggresults.get('parentaccount'));
            system.debug('aggresult******'+aggresults.get('cnt'));
mapAccountId_CountAccountTeamMember.put((Id)aggresults.get('parentAccount'),(Integer)aggresults.get('cnt'));          
        }
        
    }
}
                                       


        ListRegionalId=[SELECT id from Account WHERE Member_of_GE_OG__c  IN:setAccId AND Account_Tier_GEOG__c = 'Regional' ];  
    
    Set<id> allRegionalid=new Set<id>();
    for(Account a:ListRegionalId)
    {
        
        allRegionalid.add(a.id);
    }

    
    for(id i:countryAcctWithLe)
    {
        
        if(allRegionalid.contains(i))
        {
            
            allRegionalid.remove(i);
        }
    }
    
    if(allRegionalid.size() > 0)
        
    
    {
        for(id i:allRegionalid)
        {
            mapAccountId_CountAccountTeamMember.put(i,0);
            
        }
        
    }                              
    

    
                                       
     
     
        // Rollup at Global level from LE level
        
            //AggregateResult result = null;
            
         List<AggregateResult> results2=[SELECT Oil_Gas_Parent_Account__r.Parent.ParentId parentAccount, COUNT(Id) cnt
                                       FROM Account
                                       WHERE Member_of_GE_OG__c  IN:setAccId AND Account_Tier_GEOG__c = 'LE'
                                       AND Account_Status__c='CC Approved'
                                       GROUP BY Oil_Gas_Parent_Account__r.Parent.ParentId];
                                       
                                       
                                       Set<id> globalAcctWithLe=new Set<id>();
                                       
                                       
 system.debug('SIZE OF AGG '+results2.size());

 
 if(results2.size()>0){
    for(AggregateResult aggresults : results2){
        
        
        if(aggresults != null){
            
            countryAcctWithLe.add((Id)aggresults.get('parentAccount'));
            system.debug('aggresult******'+aggresults.get('cnt'));
mapAccountId_CountAccountTeamMember.put((Id)aggresults.get('parentAccount'),(Integer)aggresults.get('cnt'));          
        }
        
    }
}

ListGlobalId=[SELECT id from Account WHERE Id  IN:setAccId AND Account_Tier_GEOG__c = 'Global'];  
    
    Set<id> allGlobalid=new Set<id>();
    for(Account a:ListGlobalId)
    {
        
        allGlobalid.add(a.id);
    }

    
    for(id i:countryAcctWithLe)
    {
        
        if(allGlobalid.contains(i))
        {
            
            allGlobalid.remove(i);
        }
    }
    
    if(allGlobalid.size() > 0)
        
    
    {
        for(id i:allGlobalid)
        {
            mapAccountId_CountAccountTeamMember.put(i,0);
            
        }
        
    }
                                       
           
    
        // Update account
      //System.debug('mapAccountId_CountAccountTeamMember.keyset()'+mapAccountId_CountAccountTeamMember.keyset());
        for(Account objAccount: [SELECT Id, Number_of_Child_LEs_GEOG__c
                                 FROM Account
                                 WHERE ID IN: mapAccountId_CountAccountTeamMember.keyset() AND Type != 'Competitor'])
                                  
        {
            objAccount.Number_of_Child_LEs_GEOG__c = mapAccountId_CountAccountTeamMember.get(objAccount.Id);
            lstAccountToUpdate.add(objAccount);
            System.debug('lstAccountToUpdate***'+lstAccountToUpdate);
        }
      
        if(!lstAccountToUpdate.isEmpty())
        {
            
            System.debug('lstAccountToUpdate************'+lstAccountToUpdate);
            update lstAccountToUpdate;
        }
    }
    
   
    //For Active Group Opportunities
    public void ActiveGroupOpportunities(List<Account> accountList)
    {
    
      //System.debug('accountList size*******'+accountList.size());
      //System.debug('accountList******'+accountList);
        Set<Id> setAccId = new Set<Id>();
        for(Account acc : accountList){
            if(acc.Account_Tier_GEOG__c == 'Global')
           
                setAccId.add(acc.Id);
                 //System.debug('setAccId*******'+setAccId);
        }

        List<Account> lstAccountToUpdate = new List<Account>();
        Map<Id,Decimal> mapAccountId_SumAmount = new Map<Id,Decimal>();
       
        // Sum at LE level
        for(AggregateResult aggResult:[SELECT SUM(pipeline_amount_ge_og__c) sumAmt,AccountId parentAccount
                                       FROM Opportunity
                                       WHERE Account.Member_of_GE_OG__c IN: setAccId AND Account.Account_Tier_GEOG__c = 'LE' 
                                       GROUP BY AccountId ])
        {
        //System.debug('****mapAccountId_SumAmount*******'+mapAccountId_SumAmount);
            mapAccountId_SumAmount.put((Id)aggresult.get('parentAccount'),(Decimal)aggresult.get('sumAmt'));
        }
        
        // Sum at country level 
        for(AggregateResult aggResult:[SELECT SUM(pipeline_amount_ge_og__c) sumAmt,AccountId parentAccount
                                       FROM Opportunity
                                       WHERE Account.Member_of_GE_OG__c IN: setAccId AND Account.Account_Tier_GEOG__c = 'Country'
                                       GROUP BY AccountId ])
        {
        
        //System.debug('aggResult**'+aggResult);
            mapAccountId_SumAmount.put((Id)aggresult.get('parentAccount'),(Decimal)aggresult.get('sumAmt'));
            //System.debug('****mapAccountId_SumAmount*******111111'+mapAccountId_SumAmount);
        }

        // Sum at country level from LE level
        for(AggregateResult aggResult:[SELECT SUM(pipeline_amount_ge_og__c) sumAmt,Account.Oil_Gas_Parent_Account__c parentAccount
                                       FROM Opportunity
                                       WHERE Account.Member_of_GE_OG__c IN: setAccId AND Account.Oil_Gas_Parent_Account__r.Account_Tier_GEOG__c = 'Country'
                                       GROUP BY Account.Oil_Gas_Parent_Account__c])
        {
            Id accId = (Id)aggresult.get('parentAccount');
            if(mapAccountId_SumAmount.containskey(accId ) && mapAccountId_SumAmount.get(accId ) != null)
            {
                Decimal value = mapAccountId_SumAmount.get(accId ) ;mapAccountId_SumAmount.put((Id)aggresult.get('parentAccount'),(Decimal)aggresult.get('sumAmt')+ value );
                
                //System.debug('****mapAccountId_SumAmount****LE**'+mapAccountId_SumAmount);
            }
            else
            {
                mapAccountId_SumAmount.put((Id)aggresult.get('parentAccount'),(Decimal)aggresult.get('sumAmt'));
                //System.debug('****mapAccAmount****LE**'+mapAccountId_SumAmount);
            }
        }

        // Sum at Regional level
        for(AggregateResult aggResult:[SELECT SUM(pipeline_amount_ge_og__c) sumAmt,AccountId parentAccount
                                       FROM Opportunity
                                       WHERE Account.Member_of_GE_OG__c IN: setAccId AND Account.Account_Tier_GEOG__c = 'Regional'
                                       GROUP BY AccountId ])
        {
            mapAccountId_SumAmount.put((Id)aggresult.get('parentAccount'),(Decimal)aggresult.get('sumAmt'));
            
            //System.debug('****mapAccountId_SumAmounregional*'+mapAccountId_SumAmount);
        }

        // Sum at Regional level from Country level
        for(AggregateResult aggResult:[SELECT SUM(pipeline_amount_ge_og__c) sumAmt,Account.ParentId parentAccount
                                       FROM Opportunity
                                       WHERE Account.Member_of_GE_OG__c IN: setAccId AND Account.Parent.Account_Tier_GEOG__c = 'Regional'
                                       GROUP BY Account.ParentId])
        {
            Id accId = (Id)aggresult.get('parentAccount');
            if(mapAccountId_SumAmount.containskey(accId ) && mapAccountId_SumAmount.get(accId ) != null)
            {
                Decimal value = mapAccountId_SumAmount.get(accId ) ;
                mapAccountId_SumAmount.put((Id)aggresult.get('parentAccount'),(Decimal)aggresult.get('sumAmt')+ value );
                //System.debug('****mapAccountId_regionalFromCount**'+mapAccountId_SumAmount);
            }
            else
            {
                mapAccountId_SumAmount.put((Id)aggresult.get('parentAccount'),(Decimal)aggresult.get('sumAmt'));
                  //System.debug('****mapAccountId_regionalFrCo**'+mapAccountId_SumAmount);
            }
        }

        // Sum at Regional level from LE level
        for(AggregateResult aggResult:[SELECT SUM(pipeline_amount_ge_og__c) sumAmt,Account.Oil_Gas_Parent_Account__r.ParentId parentAccount
                                       FROM Opportunity
                                       WHERE Account.Member_of_GE_OG__c IN: setAccId AND Account.Oil_Gas_Parent_Account__r.Parent.Account_Tier_GEOG__c= 'Regional'
                                       GROUP BY Account.Oil_Gas_Parent_Account__r.ParentId])
        {
            Id accId = (Id)aggresult.get('parentAccount');
            if(mapAccountId_SumAmount.containskey(accId ) && mapAccountId_SumAmount.get(accId ) != null)
            {
                Decimal value = mapAccountId_SumAmount.get(accId ) ;mapAccountId_SumAmount.put((Id)aggresult.get('parentAccount'),(Decimal)aggresult.get('sumAmt')+ value );
                
                  //System.debug('****ma_regionalFromCount**'+mapAccountId_SumAmount);
            }
            else
            {
                mapAccountId_SumAmount.put((Id)aggresult.get('parentAccount'),(Decimal)aggresult.get('sumAmt'));
                
                  //System.debug('****m*'+mapAccountId_SumAmount);
            }
       
        }

        // Sum at Global level 
        for(AggregateResult aggResult:[SELECT SUM(pipeline_amount_ge_og__c) sumAmt,AccountId parentAccount
                                       FROM Opportunity
                                       WHERE AccountId IN: setAccId AND Account.Account_Tier_GEOG__c = 'Global'
                                       GROUP BY AccountId ])
        {
            mapAccountId_SumAmount.put((Id)aggresult.get('parentAccount'),(Decimal)aggresult.get('sumAmt'));
              //System.debug('****1*'+mapAccountId_SumAmount);
        }
        
        // Sum at Global level from Regional level
        for(AggregateResult aggResult:[SELECT SUM(pipeline_amount_ge_og__c) sumAmt,Account.ParentId parentAccount
                                       FROM Opportunity
                                       WHERE Account.ParentId IN: setAccId AND Account.Parent.Account_Tier_GEOG__c = 'Global'
                                       GROUP BY Account.ParentId])
        {
            Id accId = (Id)aggresult.get('parentAccount');
            if(mapAccountId_SumAmount.containskey(accId ) && mapAccountId_SumAmount.get(accId ) != null)
            {
                Decimal value = mapAccountId_SumAmount.get(accId ) ;mapAccountId_SumAmount.put((Id)aggresult.get('parentAccount'),(Decimal)aggresult.get('sumAmt')+ value );
                
                  //System.debug('****mapAc2*'+mapAccountId_SumAmount);
            }
            else
            {
                mapAccountId_SumAmount.put((Id)aggresult.get('parentAccount'),(Decimal)aggresult.get('sumAmt'));
            }
        }

        // Sum at Global level from Country level 
        
        //System.debug('****m*setAccId'+setAccId);     
        
        
        for(AggregateResult aggResult:[SELECT SUM(pipeline_amount_ge_og__c) sumAmt,Account.Parent.ParentId parentAccount
                                       FROM Opportunity
                                       WHERE Account.Parent.ParentId IN: setAccId AND Account.Parent.Parent.Account_Tier_GEOG__c = 'Global'
                                       GROUP BY Account.Parent.ParentId])
        {
            Id accId = (Id)aggresult.get('parentAccount');
            if(mapAccountId_SumAmount.containskey(accId ) && mapAccountId_SumAmount.get(accId ) != null)
            {
                Decimal value = mapAccountId_SumAmount.get(accId ) ;mapAccountId_SumAmount.put((Id)aggresult.get('parentAccount'),(Decimal)aggresult.get('sumAmt')+ value );
                
            }
            else
            {
                mapAccountId_SumAmount.put((Id)aggresult.get('parentAccount'),(Decimal)aggresult.get('sumAmt'));
            }
       
        }

        // Sum at Global level from LE level     
        for(AggregateResult aggResult:[SELECT SUM(pipeline_amount_ge_og__c) sumAmt,Account.Oil_Gas_Parent_Account__r.Parent.parentId parentAccount
                                       FROM Opportunity
                                       WHERE Account.Oil_Gas_Parent_Account__r.Parent.ParentId IN: setAccId
                                       AND Account.Oil_Gas_Parent_Account__r.Parent.Parent.Account_Tier_GEOG__c = 'Global'
                                       GROUP BY Account.Oil_Gas_Parent_Account__r.Parent.parentId])
        {
            Id accId = (Id)aggresult.get('parentAccount');
           if(mapAccountId_SumAmount.containskey(accId ) && mapAccountId_SumAmount.get(accId ) != null)
            {
                Decimal value = mapAccountId_SumAmount.get(accId ) ;mapAccountId_SumAmount.put((Id)aggresult.get('parentAccount'),(Decimal)aggresult.get('sumAmt')+ value );
                
            }
            else
            {
                mapAccountId_SumAmount.put((Id)aggresult.get('parentAccount'),(Decimal)aggresult.get('sumAmt'));
            }
       
        }
        
        // Update account
        for(Account objAccount: [SELECT Id, Active_Group_Oppty_GEOG__c
                                 FROM Account
                                 WHERE ID IN: mapAccountId_SumAmount.keyset() AND Type != 'Competitor'])
        {
            objAccount.Active_Group_Oppty_GEOG__c = mapAccountId_SumAmount.get(objAccount.Id); lstAccountToUpdate.add(objAccount);
            
        }
       
        if(!lstAccountToUpdate.isEmpty())
        {
        
        //System.debug('lstAccountToUpdate**1'+lstAccountToUpdate);
            update lstAccountToUpdate;
            
        }
    }
    
   
    //For AccountQuickView & LEQuickView at Country level with Memberof Null
    public void MemberOfNull_Account_LEquickView(List<Account> accountList)
    {
        //System.debug('accountList size'+accountList.size());
        //System.debug('accountList size'+accountList);
        
        Set<Id> setAccId = new Set<Id>();
        
        List<Account> ListCountryId = new List<Account>();//contains all country id's corresponding to global acct
        List<Account> ListRegionalId = new List<Account>();//contains all regional id's corresponding to globa acct
        List<Account> ListGlobalId = new List<Account>();//contains all regional id's corresponding to globa acct
        
        
        for(Account acc : accountList){
                setAccId.add(acc.Id);
        }   
        
        //System.debug('setAccId in method1'+setAccId);
        List<Account> lstAccountToUpdate = new List<Account>();
        Map<Id,Integer> mapAccountId_CountAccountTeamMember = new Map<Id,Integer>();
        
        
        //  Rollup At Country Level(Memberof Null) from LE level 
        List<AggregateResult> results=[SELECT Oil_Gas_Parent_Account__c, COUNT(Id) cnt
                                       FROM Account
                                       WHERE Oil_Gas_Parent_Account__c IN:setAccId AND Account_Tier_GEOG__c = 'LE'
                                       AND Account_Status__c='CC Approved'
                                       GROUP BY Oil_Gas_Parent_Account__c];
                                       
                                       
                                       
                            Set<id> countryAcctWithLe=new Set<id>();    



 system.debug('SIZE OF AGG '+results.size());
if(results.size()>0){
    for(AggregateResult aggresults : results){
        
        
        if(aggresults != null){
            
            countryAcctWithLe.add((Id)aggresults.get('Oil_Gas_Parent_Account__c'));
            system.debug('aggresult******'+aggresults.get('cnt'));
mapAccountId_CountAccountTeamMember.put((Id)aggresults.get('Oil_Gas_Parent_Account__c'),(Integer)aggresults.get('cnt'));          
        }
        
    }
}                           
                                       
            ListCountryId=[SELECT id from Account WHERE Account_Tier_GEOG__c = 'Country'  and id IN:setAccId];
            
        

Set<id> allCountryid=new Set<id>();
    for(Account a:ListCountryId)
    {
        
        allCountryid.add(a.id);
    }

    
    for(id i:countryAcctWithLe)
    {
        
        if(allCountryid.contains(i))
        {
            
            allCountryid.remove(i);
        }
    }
    
    if(allCountryid.size() > 0)
        
    
    {
        for(id i:allCountryid)
        {
            mapAccountId_CountAccountTeamMember.put(i,0);
            
        }
        
    }
                
                                       
      
        // Update account
        
        //System.debug('mapAccountId_CountAccountTeamMember'+mapAccountId_CountAccountTeamMember);
        //System.debug('mapAccountId_CountAccountTeamMember keyset'+mapAccountId_CountAccountTeamMember.keyset());
        for(Account objAccount: [SELECT Id, Number_of_Child_Accounts_GEOG__c, Number_of_Child_LEs_GEOG__c
                                 FROM Account
                                 WHERE ID IN: mapAccountId_CountAccountTeamMember.keyset() AND Type != 'Competitor'])
        {
            objAccount.Number_of_Child_Accounts_GEOG__c = mapAccountId_CountAccountTeamMember.get(objAccount.Id) + 1;
            objAccount.Number_of_Child_LEs_GEOG__c = mapAccountId_CountAccountTeamMember.get(objAccount.Id);
            lstAccountToUpdate.add(objAccount);
            System.debug('lstAccountToUpdate1111'+lstAccountToUpdate);
        }
       
        if(!lstAccountToUpdate.isEmpty())
        {
            System.debug('lstAccountToUpdate11123'+lstAccountToUpdate);
            update lstAccountToUpdate;
        }
       
    }
    
   
    //For Active Group Opportunities at Country level with Memberof Null
    public void MemberOfNull_ActiveGroupOpportunities(List<Account> accountList)
    
    {
    //System.debug('***accountList***'+accountList);
        //accountList:Member_of_GE_OG__c == null && acc.Account_Tier_GEOG__c == 'Country'
        //System.debug('1accountList1'+accountList);
        Set<Id> setAccId = new Set<Id>();
        for(Account acc : accountList){
            setAccId.add(acc.Id);
        }
        //System.debug('setAccIdsetAccId'+setAccId);
        List<Account> lstAccountToUpdate = new List<Account>();
        Map<Id,Decimal> mapAccountId_SumAmount = new Map<Id,Decimal>();
       
        // Sum at LE level
        for(AggregateResult aggResult:[SELECT SUM(pipeline_amount_ge_og__c) sumAmt,AccountId parentAccount
                                       FROM Opportunity
                                       WHERE Account.Oil_Gas_Parent_Account__c IN: setAccId AND Account.Account_Tier_GEOG__c = 'LE'
                                       GROUP BY AccountId ])
        {
            mapAccountId_SumAmount.put((Id)aggresult.get('parentAccount'),(Decimal)aggresult.get('sumAmt'));
            
            //System.debug('##mapAccountId_SumAmount'+mapAccountId_SumAmount);
        }
        
        // Sum at country level 
        for(AggregateResult aggResult:[SELECT SUM(pipeline_amount_ge_og__c) sumAmt,AccountId parentAccount
                                       FROM Opportunity
                                       WHERE AccountId IN: setAccId AND Account.Account_Tier_GEOG__c = 'Country'
                                       GROUP BY AccountId ])
        {
            mapAccountId_SumAmount.put((Id)aggresult.get('parentAccount'),(Decimal)aggresult.get('sumAmt'));
            //System.debug('##mapAccountId_SumAmount##'+mapAccountId_SumAmount);
        }
        
        // Sum at country level from LE level
        for(AggregateResult aggResult:[SELECT SUM(pipeline_amount_ge_og__c) sumAmt,Account.Oil_Gas_Parent_Account__c parentAccount
                                       FROM Opportunity
                                       WHERE Account.Oil_Gas_Parent_Account__c IN: setAccId AND Account.Oil_Gas_Parent_Account__r.Account_Tier_GEOG__c = 'Country'
                                       GROUP BY Account.Oil_Gas_Parent_Account__c])
        {
            Id accId = (Id)aggresult.get('parentAccount');
            if(mapAccountId_SumAmount.containskey(accId ) && mapAccountId_SumAmount.get(accId ) != null)
            {
                Decimal value = mapAccountId_SumAmount.get(accId ) ;mapAccountId_SumAmount.put((Id)aggresult.get('parentAccount'),(Decimal)aggresult.get('sumAmt')+ value );
                //System.debug('##mapAccountId_SumAmount!@@'+mapAccountId_SumAmount);
                
            }
            else
            {
                mapAccountId_SumAmount.put((Id)aggresult.get('parentAccount'),(Decimal)aggresult.get('sumAmt'));
                //System.debug('##mapAccountId_SumAmountw3212'+mapAccountId_SumAmount);
            }
        }
       
        // Update account
        for(Account objAccount: [SELECT Id, Active_Group_Oppty_GEOG__c FROM Account
                                 WHERE ID IN: mapAccountId_SumAmount.keyset() AND Type != 'Competitor'])
        {
            objAccount.Active_Group_Oppty_GEOG__c = mapAccountId_SumAmount.get(objAccount.Id);
            lstAccountToUpdate.add(objAccount);
            //System.debug('lstAccountToUpdate222'+lstAccountToUpdate);
        }
       
        if(!lstAccountToUpdate.isEmpty())
        {
            //System.debug('lstAccountToUpdate222'+lstAccountToUpdate);
            update lstAccountToUpdate;
        }
    }

}