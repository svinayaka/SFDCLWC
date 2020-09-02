public class SD_MostRecentJobonCrew{
    public static void crewPlanning(List<FX5__Crew_Planning__c> cpList,Map<Id,FX5__Crew_Planning__c> oldMap,Boolean isInsert,Boolean isDelete){
        Set<Id> crewId=new Set<Id>();
        List<FX5__Crew_Planning__c> cpNewList=new List<FX5__Crew_Planning__c>();
        List<FX5__Crew_Planning__c> exstCpList=new List<FX5__Crew_Planning__c>();
        Map<Id,FX5__Crew_Planning__c> exstCpMap=new Map<Id,FX5__Crew_Planning__c>();
        Set<Id> cpId=new Set<Id>();
        for(FX5__Crew_Planning__c cp : cpList){
            if((isDelete) || (!isDelete && isInsert && cp.FX5__Crew_Member__c!=null && cp.FX5__Job__c!=null && cp.FX5__Planned_End_Date__c!=null ) || ( !isDelete && !isInsert && ((cp.FX5__Crew_Member__c!=oldMap.get(cp.Id).FX5__Crew_Member__c && cp.FX5__Crew_Member__c!=null) || (cp.FX5__Planned_End_Date__c!=null && cp.FX5__Planned_End_Date__c!=oldMap.get(cp.Id).FX5__Planned_End_Date__c) ))){
                crewId.add(cp.FX5__Crew_Member__c);
                system.debug('=====>crewid adding'+crewId);
                cpNewList.add(cp); 
                if(isDelete || !isInsert){
                    cpId.add(cp.Id);
                }
            }           
        }
        
        Map<Id,FX5__Crew_Planning__c> cpMap=new Map<Id,FX5__Crew_Planning__c>();
        DateTime sysDt=System.Now();
        if(crewId.size()>0){
            system.debug('=====>crewid'+crewId.size());
            system.debug('=====>crewid'+crewId);
            system.debug('=====>sysDt '+sysDt);
            system.debug('=====>cpId '+cpId);
            for(FX5__Crew_Planning__c cp : [SELECT Id,FX5__Crew_Member__c,FX5__Job__c,FX5__Planned_End_Date__c,SD_Most_Recent_Job__c FROM FX5__Crew_Planning__c WHERE FX5__Crew_Member__c =:crewId AND FX5__Planned_End_Date__c<=:sysDt AND Id!=:cpId AND FX5__Job__c != null ORDER By FX5__Planned_End_Date__c DESC LIMIT 1]){
                cpMap.put(cp.FX5__Crew_Member__c,cp);
                exstCpList.add(cp);
            }
            
            if(isDelete){
                if(exstCpList.size()>0){
                    for(FX5__Crew_Planning__c cp : exstCpList){
                        cp.SD_Most_Recent_Job__c=true;
                        exstCpMap.put(cp.id,cp);
                    }
                }
            }
            else{
                if(exstCpList.size()>0){
                    for(FX5__Crew_Planning__c cp : cpNewList){
                        DateTime cpEndDateTime = cp.FX5__Planned_End_Date__c;
                        Date cpEndDate = date.newinstance(cpEndDateTime.year(), cpEndDateTime.month(), cpEndDateTime.day());
                        if(cpMap.containsKey(cp.FX5__Crew_Member__c)){
                            FX5__Crew_Planning__c crePl=cpMap.get(cp.FX5__Crew_Member__c);
                            DateTime exsCpEndDateTime = crePl.FX5__Planned_End_Date__c;
                            Date exsCpEndDate = date.newinstance(exsCpEndDateTime.year(), exsCpEndDateTime.month(), exsCpEndDateTime.day());
                            if(cp.FX5__Planned_End_Date__c < crePl.FX5__Planned_End_Date__c){
                                crePl.SD_Most_Recent_Job__c=true;
                                exstCpMap.put(crePl.id,crePl);
                                if(cp.SD_Most_Recent_Job__c==true){
                                    cp.SD_Most_Recent_Job__c=false;
                                }
                            }
                            else{
                                cp.SD_Most_Recent_Job__c=true;
                                if(crePl.SD_Most_Recent_Job__c==true){
                                    crePl.SD_Most_Recent_Job__c=false;
                                    exstCpMap.put(crePl.id,crePl);
                                }
                            }
                        }
                    }
                }
                else{
                    for(FX5__Crew_Planning__c cp : cpNewList){
                        cp.SD_Most_Recent_Job__c=true;
                    }
                }
            }
            
            if(exstCpMap.size()>0){
                update exstCpMap.values();
            }   
        }       
    }
}