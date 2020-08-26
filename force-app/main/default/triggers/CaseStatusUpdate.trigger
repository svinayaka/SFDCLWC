trigger CaseStatusUpdate on GE_Case_Notes__c (after insert,after update) 
{
    set<id> caseid = new set<id>();
    for(GE_Case_Notes__c gcn:trigger.new)
    {
        caseid.add(gcn.GE_Case__c);
    }
    
    map<id,case> casemap = new map<id,case>();
    for(case c:[select id,GE_OG_Case_Update_CIR__c,Latest_Case_Note_Date__c from case where id in:caseid])
    {
        casemap.put(c.id,c);
    }
    
    map<id,list<GE_Case_Notes__c>> mapcasenotes = new map<id,list<GE_Case_Notes__c>>();
    for(GE_Case_Notes__c gcn:[select id,GE_Body__c,GE_Case__c,CreatedDate from GE_Case_Notes__c where GE_Case__c in:caseid order by createddate desc])
    {
        if(mapcasenotes.containskey(gcn.GE_Case__c)==false)
        {
            mapcasenotes.put(gcn.GE_Case__c,new list<GE_Case_Notes__c>{gcn});
        }
        else
        {
        
            mapcasenotes.get(gcn.GE_Case__c).add(gcn);
        }
    }
    map<id,case> clst = new map<id,case>();
    for(GE_Case_Notes__c gcn:trigger.new)
    {
        case c=casemap.get(gcn.GE_Case__c);
        list<GE_Case_Notes__c> casenoteslst = new list<GE_Case_Notes__c >();
        if(mapcasenotes.containskey(gcn.GE_Case__c)==true)
        {
            datetime d=gcn.createddate;
            casenoteslst =mapcasenotes.get(gcn.GE_Case__c);
            
                
                    c.GE_OG_Case_Update_CIR__c =casenoteslst[0].GE_Body__c ;
                    c.Latest_Case_Note_Date__c = Date.valueOf(casenoteslst[0].CreatedDate);
                   
                
                
            
            
        clst.put(c.id,c);
        }
    }
    update clst.values();
}