public class TransformAccountUtility{

// This method will give us all the child of child of child records till LE branch
public List<Account> getChildsofChildsActs(Account rootSlvAct){
            
        system.debug('slave root act accounts dtsl==>'+rootSlvAct);
        List<Account> allChildActs = new  List<Account>();
        List<Account> regActs = new  List<Account>();
        List<Account> cntrActs = new  List<Account>();
        List<Account> lerActs =  new  List<Account>();
        
        String slvAcctId = rootSlvAct.id;
        String slvTier = rootSlvAct.Account_Tier_GEOG__c;
        
        if('Global' == slvTier){
            regActs= getChildActs(slvAcctId,slvTier);
            if(regActs != null && regActs.size() > 0){
            for(Account act: regActs){
                allChildActs.add(act);
                cntrActs= getChildActs(act.id,act.Account_Tier_GEOG__c);
                if(cntrActs != null && cntrActs.size() >0)
                for(Account act1: cntrActs){
                    allChildActs.add(act1);
                    lerActs = getChildActs(act1.id,act1.Account_Tier_GEOG__c);
                    if(lerActs != null && lerActs.size() >0){
                        allChildActs.addAll(lerActs);
                    }
                    }
                }
            }
        }// Global if end
        
        if('Regional' == slvTier){
                cntrActs= getChildActs(slvAcctId,slvTier);
                if(cntrActs != null && cntrActs.size() >0)
                for(Account act: cntrActs){
                    allChildActs.add(act);
                    lerActs = getChildActs(act.id,act.Account_Tier_GEOG__c);
                    if(lerActs != null && lerActs.size() >0){
                        allChildActs.addAll(lerActs);
                    }
                    }
        }// Regional if end
        
        if('Country' == slvTier){
            lerActs = getChildActs(slvAcctId,slvTier);
                if(lerActs != null && lerActs.size() >0){
                    allChildActs.addAll(lerActs);
                }
            }// Country if end
            
            return allChildActs;
            
    }// method getAllSlaveActs end
    
    
    // This method will give us list of child Accounts for Act tier Global/Regional/Country
    public List<Account> getChildActs(String slvAcctId,String slvTier){
    system.debug('slave accounts dtsl to capture childs Act Id ==>'+slvAcctId+' Act tier'+slvTier);
        List<Account> chldcts = new List<Account>();
        if('Global' == slvTier ||  'Regional' == slvTier ){
            chldcts = [select id,Name, ParentId,Account_Tier_GEOG__c,Member_of_GE_OG__c from Account where ParentId =: slvAcctId];
        }else if('Country' == slvTier){
            chldcts = [select id,Name, ParentId,Account_Tier_GEOG__c,Member_of_GE_OG__c,Oil_Gas_Parent_Account__c from Account where Oil_Gas_Parent_Account__c =: slvAcctId];
        }
        system.debug('child acts of account tier==>'+slvTier +' and child act count==>'+chldcts );
        return chldcts;
    }//EO of getChildActs method
    
}// EO class