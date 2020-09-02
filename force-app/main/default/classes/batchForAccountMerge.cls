global class batchForAccountMerge implements Database.Batchable<sObject>{

    public Account masterAcct{get;set;}
    public Account slaveAcct{get;set;}
    
    public Id masterAcctId{get;set;}
    public Id slaveAcctId{get;set;}
    public boolean actFound = true; 
    
    global Database.QueryLocator start(Database.BatchableContext BC){
      string query = 'select Name, Master_Account_Name__c, Slave_Account_Name__c from GE_OG_Merge_Master_Slave_Account__c'; 
        
        return Database.getQueryLocator(query);
    }
   
    global void execute(Database.BatchableContext BC, List<GE_OG_Merge_Master_Slave_Account__c> scope){
        
       for(GE_OG_Merge_Master_Slave_Account__c act: scope){
            mergeAct(act.Master_Account_Name__c, act.Slave_Account_Name__c);
        } 
       // mergeAct('001m000000MRKeG', '001m000000OLkho');
    } 
    
    global void finish(Database.BatchableContext BC){

    }
    //public class myException extends Exception {} 
    
    public boolean searchForBatch(String mstrId,String slvId){
        try{
            System.debug('Master Act Id:::='+mstrId);
            masterAcct = [select id,Name,Account_Tier_GEOG__c,Member_of_GE_OG__c,ParentId from Account where id =: mstrId];
            
            masterAcctId = masterAcct.id;
            }
        catch(Exception e){
            throw e;
        //throw new myException('Master Account Not found With Id "'+mstrId+'" Please enter valid Master Account');     
            actFound = False;
            }
            
        try{
            System.debug('slvId Act Id:::='+slvId);
            slaveAcct = [select id,Name,Account_Tier_GEOG__c,Member_of_GE_OG__c,ParentId from Account where id =: slvId];
            
            slaveAcctId = slaveAcct.id;
            }
        catch(Exception e){
            throw e;
            //throw new myException('Slave Account Not found With Id "'+slvId+'" Please enter valid Slave Account');     
            actFound = False;
            }
         
        return actFound;
        
    }// end of Search method

    public void mergeAct(String mstrId,String slvId){
    
        boolean srchRes = searchForBatch(mstrId,slvId);
        
        System.debug('Masterrrrrr==>'+masterAcct.id);
        System.debug('Slaveeeeee==>'+slaveAcct.id);
        
        List<Account> childActs = new List<Account>();
        List<Account> allChildActs = new List<Account>();
        List<Account> updtChildActs = new List<Account>();
                
        if(srchRes == true && masterAcct != null && slaveAcct != null){
                
            // This  TransformAccountUtility.getChildsofChildsActs method will fetch all the child of child Accounts List to change the MemberOff only
            TransformAccountUtility transutility = new TransformAccountUtility();
            allChildActs = transutility.getChildsofChildsActs(slaveAcct);
            System.debug('Childaccounts==>'+allChildActs);
            for(Account act1: allChildActs){
                if('Global' == masterAcct.Account_Tier_GEOG__c )
                    act1.Member_of_GE_OG__c = masterAcct.Id;
                else
                    act1.Member_of_GE_OG__c = masterAcct.Member_of_GE_OG__c;
                updtChildActs.add(act1);
            }
            try{
                    update updtChildActs;
                }catch(Exception e){
                            system.debug(e);
            }finally{
                //updtChildActs = new List<Account>();
                updtChildActs.clear();
            }

            // This method TransformAccountUtility.getChildActs will return list of next level acts to change  Account Hierarchy (ParentID)
            childActs = transutility.getChildActs(slaveAcct.id,slaveAcct.Account_Tier_GEOG__c);
            updtChildActs = new List<Account>(); 
            for(Account act2: childActs){
                //Added by Priyanka Joshi to change the name as per master hierarchy.
                if(act2.name.indexOf('/') != -1){
 
                    string acc2name = act2.name.subString(0, act2.name.indexOf('/')-1);
                    act2.name = act2.name.replace(acc2name, masterAcct.name.subString(0, masterAcct.name.indexOf('/')));
                }
                if('LE' == act2.Account_Tier_GEOG__c)
                    act2.Oil_Gas_Parent_Account__c = masterAcct.Id;
                else
                    act2.ParentId = masterAcct.Id;
                    
                updtChildActs.add(act2);
            } 
            try{
                    update updtChildActs;
                }catch(Exception e){
                            system.debug(e);
            }finally{
                //updtChildActs = new List<Account>();
                updtChildActs.clear();
            }
            
            //Update all the child Accounts hierarchy as well as ParentID map @ once
            //update updtChildActs;
            
            // This method will migrate the slave act detailed object's records to master
            try{
                swapChilds(masterAcctId, slaveAcct.id);
            }catch(Exception e){
                system.debug(e);
            }
            
            // Delete Slave record after merge process
            try{
                delete slaveAcct;
            }catch(Exception e){
                system.debug(e);
                throw e;
           //throw new myException('Slave Account Name  "'+slaveAcct.name+'" Still have some reference Object records, We cannot delete it');     

            }
                        
    }// EO main if
    
  }// EO mergeAct method
    
    // This method will mapp to the Master Account
    public boolean swapChilds(String mstAcctId, String slvAcctId ){
        
        List<Contact> updCnts                    = new List<contact>();
        List<Opportunity> updOptys               = new List<Opportunity>();
        List<Task> updTsk                        = new List<Task>();
        List<Attachment> updatts                 = new List<Attachment>();
        List<Note> updnots                       = new List<Note>();
        List<ContactAccountSharing__c> updACshar = new List<ContactAccountSharing__c>();
        
        Boolean childsSwapped = true;
        
        slaveAcct= [select id,Name, ParentId,Account_Tier_GEOG__c,Member_of_GE_OG__c, (select Id,AccountId from contacts),(select Id,AccountId from Opportunities),(select Id,WhatId from Tasks ),(select Id,Account_GEOG__c  from ContactAccountSharing__r),(select Id,ParentID,Title,Body from Notes) from Account where id =: slvAcctId ];    
        
        SObject parentObject = slaveAcct;
        system.debug('*****************'+slaveAcct);
            
        masterAcct = [select id,Name,ParentId,Account_Tier_GEOG__c,Member_of_GE_OG__c from Account where id =: mstAcctId ];
        system.debug('*****************'+masterAcct);
        
        
        if(masterAcct != null && slaveAcct != null && masterAcct.Account_Tier_GEOG__c == slaveAcct.Account_Tier_GEOG__c){

            List<SObject> cntRec         = parentObject.getSObjects('contacts');
            List<SObject> oppRec        = parentObject.getSObjects('Opportunities');
            List<SObject> taskRec       = parentObject.getSObjects('Tasks');
            List<SObject> notRec        = parentObject.getSObjects('Notes');
            List<SObject> cntActShrRec  = parentObject.getSObjects('ContactAccountSharing__r');
             
        //1 cntRec
        if(cntRec != null && cntRec.size() > 0){
            System.debug('cntRec.size()==>'+cntRec.size());
            System.debug('masterAcct.Id==>'+masterAcct.Id);
            try{                
                for(SObject cnts: cntRec){
                    Contact cnt = (contact)cnts;
                    cnt.AccountId = masterAcct.Id;
                    updCnts.add(cnt);
                }//end of contact Iteration
                System.debug('before Update of cntRec');
                update updCnts;
                System.debug('after Update of cntRec');
            }catch(Exception e){
                System.debug('Error Occured ==>'+e);
                childsSwapped = False;
                throw e;
                //throw new myException('Contact Record(\'s) was not able to attach'); 
            }
        }//end of if for cntRec null check
       
        //2 oppRec
        if(oppRec != null && oppRec.size() > 0){
            System.debug('oppRec.size()==>'+oppRec.size());
            System.debug('masterAcct.Id==>'+masterAcct.Id);
        //try{                
            for(SObject opts: oppRec){
                Opportunity opt = (Opportunity)opts;
                opt.AccountId = masterAcct.Id;
                updOptys.add(opt);
            }//end of oppRec Iteration
                System.debug('before Update of oppRec');
            update updOptys;
               // System.debug('After Update of oppRec');
        }//end of if for oppRec null check
            
        //3 taskRec
        if(taskRec != null && taskRec.size() > 0){
            System.debug('taskRec.size()==>'+taskRec.size());
            System.debug('masterAcct.Id==>'+masterAcct.Id);
        //try{    
        for(SObject Tsks: taskRec){
            Task tsk = (Task)Tsks;
            tsk.WhatId = masterAcct.Id;
            updTsk.add(tsk);
        }//end of contact Iteration
            
                System.debug('before Update of taskRec');
            update updTsk;
                
        }//end of if for taskRec null check
            
        //4 notRec
        if(notRec != null && notRec.size() > 0){
            
            List<Note> notsToInsert = new List<Note>();
            List<Note> notsToDelete = new List<Note>();
            
            System.debug('notRec.size()==>'+notRec.size());
            System.debug('masterAcct.Id==>'+masterAcct.Id);
                       
            for(SObject ns: notRec){
                
                Note nott = (Note)ns;
                Note tempNott = nott.clone(false,false);
                tempNott.parentId = masterAcct.Id;
                tempNott.Title = nott.Title;
                tempNott.Body = nott.Body;
                notsToInsert.add(tempNott);
                notsToDelete.add(nott);
            }//end of notRec Iteration

            System.debug('before insert of notRec');
            insert notsToInsert;
            delete notsToDelete;

        }//end of if for notRec null check
            
        //5 attRec
        List<Attachment> attRec = new List<Attachment>();
        attRec = [select id,ParentID,name,Body From Attachment where ParentID =: slvAcctId];
        if(attRec != null && attRec.size() > 0){
            
            List<Attachment> attachmentsToInsert = new List<Attachment>();
            List<Attachment> attachmentsToDelete = new List<Attachment>();
            
            System.debug('attRec.size()==>'+attRec.size());
            System.debug('masterAcct.Id==>'+masterAcct.Id);
                       
            //for(SObject ats: attRec){
                for(Attachment ats: attRec){
                //Attachment att = (Attachment)ats;
                Attachment tempAtt = ats.clone(false,false);
                tempAtt.parentId = masterAcct.Id;
                tempAtt.Body = ats.Body;
                tempAtt.Name = ats.Name;
                attachmentstoInsert.add(tempAtt);
                attachmentsToDelete.add(ats);
            }//end of attRec Iteration
                
            System.debug('before insert of attRec');
            insert attachmentsToInsert;
            delete attachmentsToDelete;

        }//end of if for attRec null check
            
        //11 cntActShrRec
        if(cntActShrRec != null && cntActShrRec.size() > 0){
            System.debug('cntActShrRec.size()==>'+cntActShrRec.size());
            System.debug('masterAcct.Id==>'+masterAcct.Id);
        try{    
            for(SObject ACShas: cntActShrRec){
                ContactAccountSharing__c ACSha = (ContactAccountSharing__c)ACShas;
                ACSha.Account_GEOG__c = masterAcct.Id;
                updACshar.add(ACSha);
            }//end of cntActShrRec Iteration
            
                    System.debug('before Update of cntActShrRec');
                update updACshar;
                    System.debug('After Update of cntActShrRec');
        }catch(Exception e){
            System.debug('Error Occured ==>'+e);
            childsSwapped = False;
            throw e;
            //throw new myException('ContactAccountSharing Record(\'s) was not able to attach'); 
            }
        }//end of if for cntActShrRec null check

    }// EO if loop
    
   return null;   
   }// End of swapChilds method
}