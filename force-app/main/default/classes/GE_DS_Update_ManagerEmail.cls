public class GE_DS_Update_ManagerEmail {
    Public Void UpdateManageremail(List<SVMXC__Service_Group__c> Teamlist){
    set<Id>steamIds = new set<Id>();
    map<Id,String>Teammap = new map<Id,String>();
    map<Id,Id>TechTeammap = new map<Id,Id>();
        
   for(SVMXC__Service_Group__c grouplist:[select id,GE_HQ_Resource_Director__r.Email,GE_HQ_P_L_Level__c from SVMXC__Service_Group__c where id IN:Teamlist and GE_HQ_P_L_Level__c = 'Digital Solutions' ]){   
    system.debug('grouplist'+grouplist);
    steamIds.add(grouplist.GE_HQ_Resource_Director__c);
   Teammap.put(grouplist.Id,grouplist.GE_HQ_Resource_Director__r.Email);
    }
    
   list<SVMXC__Service_Group_Members__c>techmembr=[select id,SVMXC__Service_Group__c from SVMXC__Service_Group_Members__c where SVMXC__Service_Group__c in:Teammap.keyset()]; 
    for(SVMXC__Service_Group_Members__c tech: techmembr){
    TechTeammap.put(tech.Id,tech.SVMXC__Service_Group__c) ;  
    }
  String email;
  list<GE_OG_GS_Passport__c> lpassports = new list<GE_OG_GS_Passport__c>();
  list<GE_OG_GS_Passport__c> passprtlist=[select id,GE_DS_Manager_Email__c,GE_OG_GS_Technician__c from GE_OG_GS_Passport__c where GE_OG_GS_Technician__c in:TechTeammap.keyset()];
    for(GE_OG_GS_Passport__c psprt: passprtlist){
    if(TechTeammap.containsKey(psprt.GE_OG_GS_Technician__c) && Teammap.containsKey(TechTeammap.get(psprt.GE_OG_GS_Technician__c))){
	email=Teammap.get(psprt.GE_OG_GS_Technician__c);
    lpassports.add(new GE_OG_GS_Passport__c(id=psprt.Id,GE_DS_Manager_Email__c=email));
        }
    } 
    if(lpassports.size()>0)
		update lpassports;
    
  String Visaemail;
  list<GE_OG_GS_Visa__c> lVisa = new list<GE_OG_GS_Visa__c>();
  list<GE_OG_GS_Visa__c> Visalist=[select id,GE_DS_Manager_Email__c,GE_OG_GS_Technician__c from GE_OG_GS_Visa__c where GE_OG_GS_Technician__c in:TechTeammap.keyset()];
  for(GE_OG_GS_Visa__c Visa: Visalist){  
  if(TechTeammap.containsKey(Visa.GE_OG_GS_Technician__c) && Teammap.containsKey(TechTeammap.get(Visa.GE_OG_GS_Technician__c))){
	Visaemail=Teammap.get(Visa.GE_OG_GS_Technician__c);
    lVisa.add(new GE_OG_GS_Visa__c(id=Visa.Id,GE_DS_Manager_Email__c=Visaemail));  
}
    }
   if(lVisa.size()>0)
		update lVisa; 
    
 String gatepsemail;
  list<GE_OG_DS_Gate_Pass__c> lgatepass = new list<GE_OG_DS_Gate_Pass__c>();
  list<GE_OG_DS_Gate_Pass__c> Gpasslist=[select id,GE_DS_Manager_Email__c,GE_DS_Technician__c from GE_OG_DS_Gate_Pass__c where GE_DS_Technician__c in:TechTeammap.keyset()];
  for(GE_OG_DS_Gate_Pass__c Gatepass: Gpasslist){  
  if(TechTeammap.containsKey(Gatepass.GE_DS_Technician__c) && Teammap.containsKey(TechTeammap.get(Gatepass.GE_DS_Technician__c))){
	gatepsemail=Teammap.get(Gatepass.GE_DS_Technician__c);
    lgatepass.add(new GE_OG_DS_Gate_Pass__c(id=Gatepass.Id,GE_DS_Manager_Email__c=gatepsemail));  
}
    }
   if(lgatepass.size()>0)
		update lgatepass;    


String exprtseemail;
  list<SVMXC__Service_Group_Skills__c> lxpertise = new list<SVMXC__Service_Group_Skills__c>();
  list<SVMXC__Service_Group_Skills__c> exprtselist=[select id,GE_SM_HQ_Manager_Email__c,SVMXC__Group_Member__c from SVMXC__Service_Group_Skills__c where SVMXC__Group_Member__c in:TechTeammap.keyset()];
  for(SVMXC__Service_Group_Skills__c expertise: exprtselist){  
  if(TechTeammap.containsKey(expertise.SVMXC__Group_Member__c) && Teammap.containsKey(TechTeammap.get(expertise.SVMXC__Group_Member__c))){
	exprtseemail=Teammap.get(expertise.SVMXC__Group_Member__c);
    lxpertise.add(new SVMXC__Service_Group_Skills__c(id=expertise.Id,GE_SM_HQ_Manager_Email__c=exprtseemail));  
}
    }
   if(lxpertise.size()>0)
		update lxpertise;    

}
    }