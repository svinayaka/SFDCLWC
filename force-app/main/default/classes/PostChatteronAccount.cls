global class PostChatteronAccount {

    private static Map<ID,Task> NewTasksMap = null;
    private static map<String,Oppty_Threshold__c> settings = Oppty_Threshold__c.getall();

    public static void PostChatter(List<ID> records)
    {   
        system.debug('R*Rsettings'+settings);        
        List <FeedItem> chatterPostsToAdd = new List <FeedItem>() ;
        List<opportunity> opportunities = new list<opportunity>();
        opportunities = [select Id,accountid,tier_2_ge_og__c,tier_3_ge_og__c, name, Amount_Std_USD__c, Account.Account_Tier_GEOG__c, Account.Parentid, Amount_USD_ge_og__c,CloseDate, Threshold_Crossed__c from opportunity where Id IN : records ] ;
        system.debug('opportunities &&&&&&&&'+opportunities );
         
        for(opportunity o : opportunities ){
             System.debug('Found ' + opportunities.size());
             String OpptyTier = o.tier_2_ge_og__c;
             Double OpptyAmount;
             if(o.Amount_Std_USD__c!=0){
             OpptyAmount = o.Amount_Std_USD__c;
             }
             else{
             OpptyAmount = o.Amount_USD_ge_og__c; 
             }
             system.debug('settings.get(OpptyTier).Amount__c'+settings.get(OpptyTier).Amount__c);
             Double Threshold = settings.get(OpptyTier).Amount__c; 
             system.debug('akkku***'+Threshold);
             if (OpptyAmount >=Threshold && o.Threshold_Crossed__c == False && o.Account.Account_Tier_GEOG__c=='Country'&& o.Account.Parentid!=null ){
             String fullFileURL =  URL.getSalesforceBaseUrl().toExternalForm()+'/'+ o.id;
             String Body = 'Oppty Alert: Name- '+o.name +'\r\n Amount- USD'+OpptyAmount + '\r\n Expected Order Date- '+o.CloseDate + '\r\n Tier 3- '+o.tier_3_ge_og__c ;          
             FeedItem accountPost = new FeedItem();
             accountPost.ParentID = o.accountId ;
             accountpost.type= 'linkpost';
             accountpost.linkurl=fullFileURL;
             accountpost.body= Body;
             chatterPostsToAdd.add(accountPost);
             FeedItem accountPost1 = new FeedItem();
             accountPost1.ParentID = o.Account.Parentid;
             accountpost1.type= 'linkpost';
             accountpost1.linkurl=fullFileURL;
             accountpost1.body= Body;
             chatterPostsToAdd.add(accountPost1);             
             o.Threshold_Crossed__c = True;
             
            } 
              else if (OpptyAmount >=Threshold && o.Threshold_Crossed__c == False ){
             String fullFileURL =  URL.getSalesforceBaseUrl().toExternalForm()+'/'+ o.id;
             String Body = 'Oppty Alert : Name- '+o.name +'\r\n Amount- USD '+OpptyAmount + '\r\n Expected Order Date- '+o.CloseDate +'\r\n Tier 3- '+o.tier_3_ge_og__c;          
             FeedItem accountPost = new FeedItem();
             accountPost.ParentID = o.accountId ;
             accountpost.type= 'linkpost';
             accountpost.linkurl=fullFileURL;
             accountpost.body= Body;
             chatterPostsToAdd.add(accountPost);
             o.Threshold_Crossed__c = True;        
             }
            try{
                insert chatterPostsToAdd;  
            }
            catch(Exception e){
                system.debug('Exception caught in insert chatterPostsToAdd'+e);
            }
            try{
                update opportunities ;  
            }
            catch(Exception e1){
                system.debug('Exception caught in update opportunities'+e1);
            }
  //insert chatterPostsToAdd;
  //update opportunities ;
  }
  
   
  }
  
  
  
  public static void postchattertask(Map<ID,Task> newTasks)
     {
        NewTasksMap = newTasks;
        SendchatterOntaskcreation();
     }    
    
     private static void SendchatterOntaskcreation(){ 
     
     List <FeedItem> chatterPostsToAdd = new List <FeedItem>() ;
     Map<ID, String> tWhoMap = new Map<ID, String>();
     Map<ID, String> tWhatMap = new Map<ID, String>();
     Map<ID, String> taccountMap = new Map<ID, String>();
     for(Task t: [Select Who.Name, What.Name, Account.name from Task where id in :trigger.new]){taccountMap.put(t.account.Id, t.account.name);  twhoMap.put(t.Who.Id, t.Who.Name); twhatMap.put(t.What.Id, t.What.Name); }
 
    Set<ID> accIDs = new Set<ID>();
             for(Task t : NewTasksMap.values()){
                if(t.whatid!=null)
                {
                 if(String.valueOf(t.WhatId).StartsWith('001')){
                      accIDs.add(t.WhatId);
                   }
                                       
                }                 
             }
     List<Account> Highlightedacc = new List<Account>();
             Highlightedacc = [Select Id, name , Parentid, Account_Tier_GEOG__c from Account Where ID in :accIDs ];
             system.debug('Highlightedacc &&&&&&&&'+Highlightedacc );
                     
    
    for(Account ac: Highlightedacc ){
             
     if (ac.Account_Tier_GEOG__c=='Country'&& ac.parentid!=null){
    
     for(Task tsk:NewTasksMap.values()) {
     
     if(tsk.type=='Customer Meeting'|| tsk.type=='C-Level Meeting'){
             String fullFileURL =  URL.getSalesforceBaseUrl().toExternalForm()+'/'+ tsk.id;
             Datetime dt = tsk.activitydate;
             date d = dt.date();
             String Body = 'New CVR created: Subject- '+tsk.subject +'\r\n Type- '+tsk.type +'\r\n Due Date- '+d+ '\r\n Related To What - Account'+'\r\n Related To - '+tWhatMap.get(tsk.WhatId)+ '\r\n Tier 3- '+tsk.Tier_3__c;
             FeedItem accountPost = new FeedItem();
             accountPost.ParentID = ac.ID;
             accountpost.type= 'linkpost';
             accountpost.linkurl=fullFileURL;
             accountpost.body= Body;
             chatterPostsToAdd.add(accountPost);
             FeedItem accountPost1 = new FeedItem();
             accountPost1.ParentID = ac.ParentId ;
             accountpost1.type= 'linkpost';
             accountpost1.linkurl=fullFileURL;
             accountpost1.body= Body;
             chatterPostsToAdd.add(accountPost1);
     }   
     } 
     }
     else { 
          for(Task tsk:NewTasksMap.values()){
             if(tsk.type=='Customer Meeting'|| tsk.type=='C-Level Meeting'){
             String fullFileURL =  URL.getSalesforceBaseUrl().toExternalForm()+'/'+ tsk.id;
              Datetime dt = tsk.activitydate;
             date d = date.newinstance(dt.year(), dt.month(), dt.day());
             String Body = 'New CVR created: Subject- '+tsk.subject +'\r\n Type- '+tsk.type +'\r\n Due Date- '+d + '\r\n Related To What - Account'+'\r\n Related To - '+tWhatMap.get(tsk.WhatId)+ '\r\n Tier 3- '+tsk.Tier_3__c;
             FeedItem accountPost = new FeedItem();
             accountPost.ParentID = ac.Id ;
             accountpost.type= 'linkpost';
             accountpost.linkurl=fullFileURL;
             accountpost.body= Body;
             chatterPostsToAdd.add(accountPost);
     }
     }
     }    
             
     insert chatterPostsToAdd;
     }
     
             Set<ID> OppIDs = new Set<ID>();
             for(Task t : NewTasksMap.values()){
                if(t.whatid!=null)
                {
                 if(String.valueOf(t.WhatId).StartsWith('006')){
                      OppIDs.add(t.WhatId);
                   }
                                       
                }                 
             }
             List<Opportunity> HighlightedOpp = new List<Opportunity>();
             HighlightedOpp = [Select Id, accountid, tier_2_ge_og__c, name,Account.Account_Tier_GEOG__c,Account.Parentid, Amount_USD_ge_og__c, Threshold_Crossed__c from Opportunity where Threshold_Crossed__c=True AND ID in :OppIDs ];
             system.debug('HighlightedOpp &&&&&&&&'+HighlightedOpp );
             
             List<Task> Highlightedtask = new List<Task>();
             Highlightedtask = [Select Id, type, subject,Tier_3__c, accountid, activitydate, whatid, whoid from task where whatId In:HighlightedOpp AND Id In:NewTasksMap.values() ];
             system.debug('Highlightedtask &&&&&&&&'+Highlightedtask );            
             
             for(Opportunity o : HighlightedOpp ){
             String OpptyTier = o.tier_2_ge_og__c;
             Double OpptyAmount = o.Amount_USD_ge_og__c;
             Double Threshold = settings.get(OpptyTier).Amount__c;
             if(o.Amount_USD_ge_og__c>=Threshold && o.Account.Account_Tier_GEOG__c=='Country'&& o.Account.Parentid!= null){           
             
             for(Task t1: Highlightedtask){
             if((t1.type=='Customer Meeting'|| t1.type=='C-Level Meeting')){                 
             String fullFileURL =  URL.getSalesforceBaseUrl().toExternalForm()+'/'+ t1.id;
             String Body = 'New CVR created: Subject- '+t1.subject +'\r\n Type- '+t1.type +'\r\n Due Date- '+t1.activitydate + '\r\n Related To What- Opportunity'+ '\r\n Related To- '+tWhatMap.get(t1.WhatId) + '\r\n Tier 3- '+t1.Tier_3__c;
             FeedItem accountPost = new FeedItem();
             accountPost.ParentID = o.accountId ;
             accountpost.type= 'linkpost';
             accountpost.linkurl=fullFileURL;
             accountpost.body= Body;
             chatterPostsToAdd.add(accountPost);
             FeedItem accountPost1 = new FeedItem();
             accountPost1.ParentID = o.Account.ParentId ;
             accountpost1.type= 'linkpost';
             accountpost1.linkurl=fullFileURL;
             accountpost1.body= Body;
             chatterPostsToAdd.add(accountPost1);
             }
     }        
    }         
             else {
             for(Task t1: Highlightedtask){
             if((t1.type=='Customer Meeting'|| t1.type=='C-Level Meeting')){                 
             String fullFileURL =  URL.getSalesforceBaseUrl().toExternalForm()+'/'+ t1.id;
             String Body = 'New CVR created: Subject- '+t1.subject +'\r\n Type- '+t1.type +'\r\n Due Date- '+t1.activitydate + '\r\n Related To What- Opportunity'+ '\r\n Related To- '+tWhatMap.get(t1.WhatId) + '\r\n Tier 3- '+t1.Tier_3__c;
             FeedItem accountPost = new FeedItem();
             accountPost.ParentID = o.accountId ;
             accountpost.type= 'linkpost';
             accountpost.linkurl=fullFileURL;
             accountpost.body= Body;
             chatterPostsToAdd.add(accountPost);
             }
    }   
    }      
     
  insert chatterPostsToAdd;
 
 
 
 }
 
 
             Set<ID> assetIDs = new Set<ID>();
             for(Task t : NewTasksMap.values()){
                if(t.whatid!=null)
                {
                 if(String.valueOf(t.WhatId).StartsWith('02i')){
                      assetIDs.add(t.WhatId);
                   }
                                       
                }                 
             }
             List<Asset> HighlightedAsset = new List<Asset>();
             HighlightedAsset = [Select Id, accountid ,name, Account.Account_Tier_GEOG__c, Account.Parentid from Asset Where ID in :assetIDs ];
             system.debug('HighlightedAsset &&&&&&&&'+HighlightedAsset );
             
             for(Asset a : HighlightedAsset ){
                                   
             if(a.Account.Account_Tier_GEOG__c=='Country' && a.Account.parentid!=null){                      
             for(Task t2: NewTasksMap.values()){              
             if((t2.type=='Customer Meeting'|| t2.type=='C-Level Meeting')){ 
             String fullFileURL =  URL.getSalesforceBaseUrl().toExternalForm()+'/'+ t2.id;
             String Body = 'New CVR created: Subject- '+t2.subject +'\r\n Type- '+t2.type +'\r\n Due Date- '+t2.activitydate + '\r\n Related To What- Asset'+ '\r\n Related To- '+tWhatMap.get(t2.WhatId) + '\r\n Tier 3- '+t2.Tier_3__c;
             FeedItem accountPost = new FeedItem();
             accountPost.ParentID = a.accountId ;
             accountpost.type= 'linkpost';
             accountpost.linkurl=fullFileURL;
             accountpost.body= Body;
             chatterPostsToAdd.add(accountPost);
             FeedItem accountPost1 = new FeedItem();
             accountPost1.ParentID = a.Account.Parentid ;
             accountpost1.type= 'linkpost';
             accountpost1.linkurl=fullFileURL;
             accountpost1.body= Body;
             chatterPostsToAdd.add(accountPost1);
             }
     }   
     }        
                                    
            else{
             for(Task t2: NewTasksMap.values()){              
             if((t2.type=='Customer Meeting'|| t2.type=='C-Level Meeting')){ 
             String fullFileURL =  URL.getSalesforceBaseUrl().toExternalForm()+'/'+ t2.id;
             String Body = 'New CVR created: Subject- '+t2.subject +'\r\n Type- '+t2.type +'\r\n Due Date- '+t2.activitydate + '\r\n Related To What- Asset'+ '\r\n Related To- '+tWhatMap.get(t2.WhatId)+ '\r\n Tier 3- '+t2.Tier_3__c;
             FeedItem accountPost = new FeedItem();
             accountPost.ParentID = a.accountId ;
             accountpost.type= 'linkpost';
             accountpost.linkurl=fullFileURL;
             accountpost.body= Body;
             chatterPostsToAdd.add(accountPost); 
             }
       } 
       }
           
     
  insert chatterPostsToAdd;
 
 
 
 }
 
             Set<ID> projIDs = new Set<ID>();
             for(Task t : NewTasksMap.values()){
                if(t.whatid!=null)
                {
                 if(String.valueOf(t.WhatId).StartsWith('a06')){
                      projIDs.add(t.WhatId);
                   }
                                       
                }                 
             }
             List<Project_ge_og__c> HighlightedProj = new List<Project_ge_og__c>();
             HighlightedProj = [Select Id, project_account_ge_og__c ,project_account_ge_og__r.Parentid, project_account_ge_og__r.Account_Tier_GEOG__c,name from Project_ge_og__c Where ID in :projIDs ];
             system.debug('HighlightedProj &&&&&&&&'+HighlightedProj );
             
             
             
             for(Project_ge_og__c p: HighlightedProj ){
             
             if (p.project_account_ge_og__r.Account_Tier_GEOG__c=='Country'&& p.project_account_ge_og__r.parentid!=null){
             
                                   
             for(Task t3: NewTasksMap.values()){
             if((t3.type=='Customer Meeting'|| t3.type=='C-Level Meeting')){ 
             String fullFileURL =  URL.getSalesforceBaseUrl().toExternalForm()+'/'+ t3.id;
             String Body = 'New CVR created: Subject- '+t3.subject +'\r\n Type- '+t3.type +'\r\n Due Date- '+t3.activitydate + '\r\n Related To What- Project'+ '\r\n Related To- '+tWhatMap.get(t3.WhatId) + '\r\n Tier 3- '+t3.Tier_3__c;
             FeedItem accountPost = new FeedItem();
             accountPost.ParentID = p.project_account_ge_og__r.ParentID;
             accountpost.type= 'linkpost';
             accountpost.linkurl=fullFileURL;
             accountpost.body= Body;
             chatterPostsToAdd.add(accountPost);
             FeedItem accountPost1 = new FeedItem();
             accountPost1.ParentID = p.project_account_ge_og__c;
             accountpost1.type= 'linkpost';
             accountpost1.linkurl=fullFileURL;
             accountpost1.body= Body;
             chatterPostsToAdd.add(accountPost1);
             }
            } 
     }         
                     
             else{                      
             for(Task t3: NewTasksMap.values()){
             if((t3.type=='Customer Meeting'|| t3.type=='C-Level Meeting')){ 
             String fullFileURL =  URL.getSalesforceBaseUrl().toExternalForm()+'/'+ t3.id;
             String Body = 'New CVR created: Subject- '+t3.subject +'\r\n Type- '+t3.type +'\r\n Due Date- '+t3.activitydate + '\r\n Related To What- Project'+ '\r\n Related To- '+tWhatMap.get(t3.WhatId) + '\r\n Tier 3- '+t3.Tier_3__c;
             FeedItem accountPost = new FeedItem();
             accountPost.ParentID = p.project_account_ge_og__c;
             accountpost.type= 'linkpost';
             accountpost.linkurl=fullFileURL;
             accountpost.body= Body;
             chatterPostsToAdd.add(accountPost);
             }
            } 
        }    
            
             
     
  insert chatterPostsToAdd;
 
 
 
 }
 

                 
     
     
     
}    
             
  
}