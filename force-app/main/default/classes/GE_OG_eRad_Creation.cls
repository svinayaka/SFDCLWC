/*  Description: Created Class for Trigger consolidation of GE_OG_eRad_Creation trigger. 
Created By  : Chaitanya Gupta K
Date : Dec 31, 2014 
Requirement: R-20178.
test Class : GE_OG_eRad_Creation_Test
Test Coverage : 85%  
Last Modified : Kirubakaran Shanmugam
Change Desc : R-26626  - TPS Tier change
*/  
public class GE_OG_eRad_Creation{
    public Id subseaid{get;set;}
    public Id TMSCSAid{get;set;}
    public Id Compsubseaid{get;set;}
    public Id CompTMSid{get;set;}
    public Id TMSNewUnitid{get;set;}
    public Map<id,Account> accMap{get;set;}
    public Map<id,opportunity> opMap{get;set;}
    //public id opptyDTSrtid{get;set;}
    public Set<id> compids{get;set;}
    public List<String> Profiles{get;set;}
    public boolean executeboo{get;set;}
    public Set<id> opptyset{get;set;}
    Public Id ogClosedId;
    
    Public Map<Id,OpportunityTeamMember> oppMemberMap;
    Public Map<Id,Pre_Bid_Evaluation_ge_og__c> preBidEvalMap;
    
    //public id OGRecordtype{get;set;} 
    
    public GE_OG_eRad_Creation(){
        subseaid = Schema.SObjectType.eRad__c.getRecordTypeInfosByName().get('Subsea').getRecordTypeId();
        TMSCSAid = Schema.SObjectType.eRad__c.getRecordTypeInfosByName().get('TMS - CSA').getRecordTypeId();
        TMSNewUnitid = Schema.SObjectType.eRad__c.getRecordTypeInfosByName().get('TMS New Units/Opex').getRecordTypeId();
        
        Compsubseaid = Schema.SObjectType.Competitor__c.getRecordTypeInfosByName().get('Subsea').getRecordTypeId();
        CompTMSid = Schema.SObjectType.Competitor__c.getRecordTypeInfosByName().get('TMS/DTS').getRecordTypeId();
        
        ogClosedId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('O&G Closed').getRecordTypeId();
        
        
        
        
    }
    public Map<id,Account> getAccountlist(Set<id> acid){
        accMap = new Map<id,Account>();
        for(Account ac : [select id,Name from Account where id IN: acid])
            accMap.put(ac.id,ac);
        return accmAp;    
    }
    public Map<id,Account> returnAccMap(List<Opportunity> oplist){
        System.debug('------------ GE_OG_eRad_Creation.returnAccMap');
        set<id> accrecid = new Set<id>();
        for(Opportunity opp : oplist){
            if(opp.end_user_ge_og__c != null)
                accrecid.add(opp.end_user_ge_og__c);
            /* if(opp.GE_OG_TM_EPC__c != null)
accrecid.add(opp.GE_OG_TM_EPC__c);*/
        }
        Map<id,Account> accMap = new Map<id,Account>([select id,name from Account where id IN: accrecid]);
        return accMap;
    }
    
    //Method invoked when Opportunity is updated
    public void onupdateradrecordcreation(List<opportunity> opptylist,Map<id,opportunity> opptyMap,Map<id,opportunity> opptyoldMap){
        System.debug('------------ GE_OG_eRad_Creation.onupdateradrecordcreation');
        preBidEvalMap = new Map<Id,Pre_Bid_Evaluation_ge_og__c>(); 
        oppMemberMap = new Map<Id,OpportunityTeamMember> ();
        //Set<ID> setOppIDs = new Set<ID>();
        Map<ID, eRAD__c> mape_Rad = new Map<ID,eRAD__c>();
        Boolean boolskipInsert = false;
        
        //Populating Oppty Members to Find out ComOps_Manager__c
        For ( OpportunityTeamMember otm : [Select Id,OpportunityId,UserId, TeamMemberRole From OpportunityTeamMember Where
                                           TeamMemberRole ='Commercial Primary Resource' and OpportunityId in: opptylist])
        {
            oppMemberMap.put(otm.OpportunityId,otm);
        }
        
        // For field "GE_OG_TM_Primary_Winner_Competitor__c" we are using pre  bid evaluation objec
        For( Pre_Bid_Evaluation_ge_og__c  pbe : [ Select entity_ge_og__c,pre_bid_name_ge_og__r.pre_bid_opportunity_ge_og__c From Pre_Bid_Evaluation_ge_og__c
                                                 Where pre_bid_name_ge_og__r.pre_bid_opportunity_ge_og__c in: opptylist and entity_ge_og__c!=null ] ) {
                                                     preBidEvalMap.put(pbe.pre_bid_name_ge_og__r.pre_bid_opportunity_ge_og__c, pbe);
                                                 }
        
        
        //if(executeboo == true){
        opMap = new Map<id,Opportunity>();
        Map<id,opportunity> opoldMap = new Map<id,Opportunity>();
        Set<id> Accid = new Set<id>();
        Map<id,Account> accMap = new Map<id,Account>();
        List<eRad__c> eradList = new List<eRad__c>();
        List<eRad__c> closederadList = new List<eRad__c>();
        List<Competitor__c> compstr = new List<Competitor__c>();
        List<Discount__c> discountstr = new List<Discount__c>();
        List<Competitor__c> compsttlist;
        List<Discount__c> discounttlist;
        String compsoql = '';
        Map<eRad__c,List<Competitor__c>> complistMap = new Map<eRad__c,List<Competitor__c>>();
        Map<eRad__c,List<Discount__c>> dislistMap = new Map<eRad__c,List<Discount__c>>();
        Map<id,List<Competitor__c>> oppmapp = new Map<id,List<Competitor__c>>();
        Map<id,List<Discount__c>> disoppmapp = new Map<id,List<Discount__c>>();
        List<Competitor__c> comtoins = new List<Competitor__c>();
        List<Discount__c> discomtoins = new List<Discount__c>();
        
        opMap = opptyMap;
        opoldMap = opptyoldMap;
        
        Set<id> radids = new Set<id>();
        Map<id,Account> accretMap = new Map<id,Account>();
        
        Map<id,eRad__c> eradMap = new Map<id,eRad__c>();
        Map<id,set<id>> compMap = new Map<id,set<id>>();
        opptyset = new Set<id>();
        List<opportunity> opppplist = new list<Opportunity>();
        
        //******************START ERaD CREATION*****************************
        //For Creating eRad record once Opportunity goes in Bid in Development
        accretMap = returnAccMap(opptylist);
        Set<id> Accid2 = new Set<id>();
        List<eRad__c> eradList2 = new List<eRad__c>();
        
        //for  counting active bid Erad for Opportunity
        List<AggregateResult> aggrList = [select count(id) cnt, Opportunity__c opt from eRad__c where Name like '%Active bid eRad%' and Opportunity__c in: opptylist group by Opportunity__c];
        Map<Id,Integer> opptyEradCountMap = new Map<id,Integer>();
        for(AggregateResult ag : aggrList){
            opptyEradCountMap.put(String.valueOf(ag.get('opt')), Integer.valueOf(ag.get('cnt')==null?0:ag.get('cnt')));
        }
        for(Opportunity opp : opptylist){
            //  if(mape_Rad.containskey(opp.ID))
            //      continue;   
            String enduser,epc;
            if(accretMap.containskey(opp.end_user_ge_og__c)){
                enduser = accretMap.get(opp.end_user_ge_og__c).Name;
            }else{
                enduser = '';
            }
            
            Set<String> stageSet = new Set<String>{'Bid In Submission','Negotiating','Bid In Development'};
                system.debug('    '+ opptyEradCountMap.get(opp.id) +'       '+ stageSet.contains(opp.StageName) +'     ' + opp.StageName);
            if(opptyoldMap.get(opp.id).StageName != opp.StageName && stageSet.contains(opp.StageName) &&
               (opptyEradCountMap.get(opp.id)<1 || opptyEradCountMap.get(opp.id) == null)
              ){
                  if(opp.tier_2_ge_og__c == 'Oil Field Equipment')// && opp.RecordtypeID == O&GRecordtype)
                  {
                      eRad__c radrec = returneradrec(opp.id,subseaid,opp.Ownerid,enduser,epc);
                      if(opp.has_commercial_primary_resource_ge_og__c == true)
                          //Populating UserId from OpptyTeamMember If TeamMemberRole is 'Commercial Primary Resource'
                          radrec.ComOps_Manager__c = (oppMemberMap.containskey(opp.Id) ? oppMemberMap.Get(opp.Id).UserId : null);
                      eradList2.add(radrec);
                  }else if(opp.tier_2_ge_og__c == 'Turbomachinery & Process Solutions'){
                      
                      if(opp.tier_3_ge_og__c != null){
                          system.debug('\n\n==== '+opp.tier_3_ge_og__c + ' === \n\n');
                          eRad__c radrec = returneradrec(opp.id,TMSNewUnitid,opp.Ownerid,enduser,epc);
                          if(opp.has_commercial_primary_resource_ge_og__c == true)
                              radrec.ComOps_Manager__c = (oppMemberMap.containskey(opp.Id) ? oppMemberMap.Get(opp.Id).UserId : null);
                          eradList2.add(radrec);
                      }
                      
                  }
                  
              }
            If( preBidEvalMap.get(opp.Id)!=null && preBidEvalMap.get(opp.Id).entity_ge_og__c!=null)
                Accid2.add(preBidEvalMap.get(opp.Id).entity_ge_og__c);
        }
        
        if(Accid2.size() >0){
            getAccountlist(Accid2);
        }
        if(eradList2 != null && eradList2.size()>0){
            boolskipInsert = true;
            insert eradList2;
        }
        
        if(eradList2.size() >0)
            createcompetitor(eradList2);
        
        //******************END ErAD CREATION*****************************
        
        
        //******************START ErAD UPDATION*****************************
        //For Updating eRad record 
        for(Opportunity opp : opptylist){
            if(boolskipInsert)
                continue;
            
            
            if(opptyoldMap.get(opp.id).StageName != opp.StageName){
                if(
                    
                    (opp.StageName == 'Closed Won' || opp.StageName == 'Closed Lost' )){
                        opptyset.add(opp.id);
                        opppplist.add(opp);
                    }
            }
            
            
        }
        if(opptyset.size() > 0){
            //accretMap = returnAccMap(opppplist);
            List<erad__c> RadList = [select id,Opportunity__c from eRad__c where Opportunity__c IN: opptyset and Status__c = 'Active Bid'];
            for(eRad__c er : Radlist){
                radids.add(er.id);
            }
            string s = '';
            if(radids.size() > 0){
                for(id i: radids){
                    if(s.length() > 0){
                        string st = '\''+string.valueof(i)+'\'';
                        s= s +','+ st;
                    }
                    else{
                        string st = '\''+string.valueof(i)+'\'';
                        s = st;
                    }
                }
            }
            if(s != ''){
                s = '('+s+')';
                system.debug('ppppppppppppppppppp     '+ s);
                
                String soql = GE_OG_eRad_Cloning.getCreatableFieldsSOQL('eRad__c','id IN '+s);
                system.debug('ggggggggggggggggg       ' + soql);
                List<eRad__c> radstr = (List<eRad__c>)Database.query(soql);
                for(eRad__c er : radstr){
                    eradMap.put(er.opportunity__c,er);
                }
                compsoql = GE_OG_eRad_Cloning.getCreatableFieldsSOQL('Competitor__c','erad__c IN '+s);
                if(compsoql != '')
                    compstr = (List<Competitor__c>)Database.query(compsoql);
                for(eRad__c rid : RadList){
                    compsttlist = new List<Competitor__c>();
                    for(Competitor__c co : compstr){
                        if(rid.id == co.erad__c)
                            compsttlist.add(co);
                    }
                    complistMap.put(rid,compsttlist);
                }
                for(eRad__c erd : complistMap.keyset()){
                    oppmapp.put(erd.opportunity__c,complistMap.get(erd));
                }
                system.debug('pppppppppppppp     ' + s);
                String Discountsoql='';
                //if(s.size() >0)
                Discountsoql= GE_OG_eRad_Cloning.getCreatableFieldsSOQL('Discount__c','erad__c IN '+s);
                system.debug('tttttttttttttttt    ' +Discountsoql);
                if(Discountsoql != '')
                    discountstr = (List<Discount__c>)Database.query(Discountsoql);
                if(discountstr.size() >0){
                    for(eRad__c rid : RadList){
                        discounttlist = new List<Discount__c>();
                        for(Discount__c dis : discountstr){
                            if(rid.id == dis.erad__c)
                                discounttlist.add(dis);    
                        }
                        dislistMap.put(rid,discounttlist);
                    }
                    for(eRad__c erd : dislistMap.keyset()){
                        disoppmapp.put(erd.opportunity__c,dislistMap.get(erd));
                    }    
                }
            }
            
            for(Opportunity opp : opptylist){
                String enduser,epc;
                if(accretMap.containskey(opp.end_user_ge_og__c)){
                    enduser = accretMap.get(opp.end_user_ge_og__c).Name;
                }else{
                    enduser = '';
                }
                
                
                if(opptyoldMap.get(opp.id).StageName != opptyMap.get(opp.id).StageName){
                    if((
                        
                        (opp.StageName == 'Closed Won' || opp.StageName == 'Closed Lost' 
                        ))){
                            opptyset.add(opp.id);
                            if(opp.tier_2_ge_og__c == 'Oil Field Equipment' && (opp.StageName == 'Closed Won' || opp.StageName == 'Closed Lost') && opp.recordTypeId != ogClosedId)
                                //&& opp.RecordtypeID == Oppsubseaid)
                            {
                                if(eradMap.containskey(opp.id)){
                                    system.debug('\n\n\n\n gggggggggggggggg \n\n\n\n Entred If Condition for SS Cloning \n\n\n\n\n\n');
                                    eRad__c radreclone = eradMap.get(opp.id).clone(false, true);
                                    radreclone.Mode__c = 'Closed';
                                    radreclone.Status__c = 'Sales Mode';
                                    closederadList.add(radreclone);
                                }else{
                                    system.debug('\n\n\n\n gggggggggggggggg \n\n\n\n\n Entred If Condition for SS \n\n\n\n\n\n');
                                    eRad__c radrec = retclosederadrec(opp.id,subseaid,opp.Ownerid,enduser,epc);
                                    if(opp.has_commercial_primary_resource_ge_og__c == true)
                                        radrec.ComOps_Manager__c = (oppMemberMap.containskey(opp.Id) ? oppMemberMap.Get(opp.Id).UserId : null);
                                    eradList.add(radrec);
                                }
                                If( preBidEvalMap.get(opp.Id)!=null && preBidEvalMap.get(opp.Id).entity_ge_og__c!=null)
                                    Accid.add(preBidEvalMap.get(opp.Id).entity_ge_og__c);
                            }
                            
                            
                            
                            
                            
                            else if(opp.tier_2_ge_og__c == 'Turbomachinery & Process Solutions' && opp.recordTypeId != ogClosedId){
                                //if(opp.GE_OG_GS_Mgmt_Entity__c == 'CS' && (opp.GE_OG_GS_Prod_Srvc__c =='Maintenance Contracts' || //opp.GE_OG_GS_Prod_Srvc__c =='MMP')){
                                if(opp.StageName == 'Closed Won' || opp.StageName == 'Closed Lost'){
                                    if(eradMap.containskey(opp.id)){
                                        eRad__c radreclone = eradMap.get(opp.id).clone(false, true);
                                       //Added by Harsha
                                         String eradName = 'Closed bid eRad for'+' '+opp.name;
                                        if(eradName.length()>80){
                                             radreclone.Name = eradName.substring(0,80);
                                        }else{
                                            radreclone.Name = eradName;
                                        }
                                        //radreclone.Name = eradName.substring(0,80);
                                        radreclone.Mode__c = 'Closed';
                                        radreclone.Status__c = 'Sales Mode';
                                        closederadList.add(radreclone);
                                    }else{
                                        eRad__c radrec = retclosederadrec(opp.id,TMSCSAid,opp.Ownerid,enduser,epc);
                                        if(opp.has_commercial_primary_resource_ge_og__c == true)
                                            radrec.ComOps_Manager__c = (oppMemberMap.containskey(opp.Id) ? oppMemberMap.Get(opp.Id).UserId : null);
                                        eradList.add(radrec);
                                    }
                                }
                                /*** commented BY Nitish ***/
                                
                                If( preBidEvalMap.get(opp.Id)!=null && preBidEvalMap.get(opp.Id).entity_ge_og__c!=null)
                                    Accid.add(preBidEvalMap.get(opp.Id).entity_ge_og__c);
                                
                            }
                            
                        }
                }
                
            }
            if(Accid.size() >0){
                getAccountlist(Accid);
            }
            if(eradList != null && !test.isRunningTest())
                insert eradList;
            if(eradList.size() >0)
                createcompetitor(eradList);
            if(closederadList != null && !test.isRunningTest())
                insert closederadList;
            
            if(closederadList.size() > 0){
                for(erad__c er : closederadList){
                    List<Competitor__c> comins = oppmapp.get(er.Opportunity__c);
                    for(Competitor__c c : comins){
                        Competitor__c compinsert = c.clone(false, true);
                        compinsert.erad__c = er.id;
                        comtoins.add(compinsert);
                    }
                    System.debug('**disoppmapp.get(er.Opportunity__c)***'+disoppmapp.get(er.Opportunity__c));
                    List<Discount__c> discomins = disoppmapp.get(er.Opportunity__c);
                    if(discomins != null){
                        for(Discount__c dis : discomins){
                            Discount__c d = dis.clone(false,true);
                            d.eRAD__c = er.id;
                            discomtoins.add(d);
                        }
                    }
                }
                if(comtoins.size() > 0)
                    insert comtoins;
                if(discomtoins.size() >0)
                    insert discomtoins;
            }
        }
        //******************END ErAD UPDATION*****************************
        //}
    }
    public erad__c returneradrec(id oppid,id opprectypeid,id oppownerid,string enduser,string epc){
        System.debug('--------------------------------->>GE_OG_eRad_Creation.returneradrec ');
        eRad__c rarec = new eRad__c();
        rarec.Mode__c = 'Active';
        rarec.Opportunity__c = oppid;
        rarec.RecordtypeId = opprectypeid;
        rarec.Sales_Manager__c = oppownerid;
        rarec.End_User__c = enduser;
        rarec.EPC__c = epc;
        rarec.eRAD_Start_Date__c = System.today();
        return rarec;
    }
    public erad__c retclosederadrec(id oppid,id opprectypeid,id oppownerid,string enduser,string epc){
        System.debug('--------------------------------->>GE_OG_eRad_Creation.retclosederadrec ');
        eRad__c rarec = new eRad__c();
        rarec.Mode__c = 'Closed';
        rarec.Status__c = 'Sales Mode';
        rarec.Opportunity__c = oppid;
        rarec.RecordtypeId = opprectypeid;
        rarec.Sales_Manager__c = oppownerid;
        rarec.End_User__c = enduser;
        rarec.eRAD_Start_Date__c = System.today();
        rarec.EPC__c = epc;
        return rarec;
    }
    public void createcompetitor(List<eRad__c> eList){
        System.debug('--------------------------------->>GE_OG_eRad_Creation.createcompetitor ');
        List<Competitor__c> comList = new List<Competitor__c>();  
        for(eRad__c erad : eList){
            if(opMap.containskey(erad.Opportunity__c)){
                if(erad.RecordTypeId == subseaid){
                    //if(opMap.get(erad.Opportunity__c).Primary_SS_Competitor__c != null){
                    competitor__c comp = new competitor__c();
                    //comp.Competitor__c = opMap.get(erad.Opportunity__c).Primary_SS_Competitor__c;
                    comp.eRAD__c = erad.id;
                    comp.Recordtypeid = Compsubseaid;
                    comList.add(comp);
                    //}
                    
                }
                else{
                    
                    //if(opMap.get(erad.Opportunity__c).GE_OG_TM_Primary_Winner_Competitor__c != null)                    
                    if( opMap.get(erad.Opportunity__c) != null  && preBidEvalMap.get(opMap.get(erad.Opportunity__c).Id).entity_ge_og__c!=null   )
                    {
                        competitor__c comp = new competitor__c();
                        //if(accMap.containskey(opMap.get(erad.Opportunity__c).GE_OG_TM_Primary_Winner_Competitor__c))
                        if(accMap.containskey(preBidEvalMap.get(opMap.get(erad.Opportunity__c).Id).entity_ge_og__c))
                            comp.Competitor__c = accMap.get(preBidEvalMap.get(opMap.get(erad.Opportunity__c).Id).entity_ge_og__c).Name;
                        comp.eRAD__c = erad.id;
                        comp.Recordtypeid = CompTMSid;
                        comList.add(comp);
                    }
                }
            }
        }
        if(comList != null && !test.isRunningTest())
            insert comList;
    }
}