public without sharing class SVMX_MultiPrice_AutoEntitlement{

    public void ProcessAutoEntitlement(List<SVMXC__Service_Order__c> woList, Map<Id, SVMXC__Service_Order__c> oldMap, Boolean isInsert){
      
        Set<Id> rtIdSet = new Set<Id>();
        Map<String, Schema.RecordTypeInfo> WORType = Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName(); 
      
        for (String rtName : WORType.keySet())
        {
            if (rtName.startsWith('AL'))
            {
                rtIdSet.add(WORType.get(rtName).getRecordTypeId());
            }
        }
        set<string> Branchlist=new set<string>();
        set<string> AccList=new set<string>();
        set<string> SerContractList=new set<string>();
        set<string> WOlisttemp=new set<string>();
        List<SVMXC__Service_Order__c> WOselectList=new List<SVMXC__Service_Order__c>();
        
        for (SVMXC__Service_Order__c wo : woList)
        {
             /*if (rtIdSet.contains(wo.RecordTypeId) && (wo.SVMXC__Service_Contract__c !=null || wo.GE_PC_Branch__c != null || (wo.GE_PC_Branch__c != null && wo.SVMXC__Company__c != null)) && (isInsert || wo.GE_PC_Branch__c != oldMap.get(wo.Id).GE_PC_Branch__c || wo.SVMXC__Company__c != oldMap.get(wo.Id).SVMXC__Company__c || (wo.SVMXC__Service_Contract__c !=null && wo.SVMXC__Service_Contract__c != oldMap.get(wo.Id).SVMXC__Service_Contract__c)))*/
            if (rtIdSet.contains(wo.RecordTypeId) && (wo.SVMXC__Service_Contract__c !=null) && (isInsert || (wo.SVMXC__Service_Contract__c !=null && wo.SVMXC__Service_Contract__c != oldMap.get(wo.Id).SVMXC__Service_Contract__c)))
            {
               // if(wo.GE_PC_Branch__c !=null)
                //    Branchlist.add(wo.GE_PC_Branch__c);
               // if(wo.SVMXC__Company__c !=null)
               //     AccList.add(wo.SVMXC__Company__c);
                if(wo.SVMXC__Service_Contract__c !=null)
                    SerContractList.add(wo.SVMXC__Service_Contract__c);
                WOlisttemp.add(wo.id);
                WOselectList.add(wo);
            }
        }
        Map<string,SVMXC__Entitlement_History__c> MapEHList = new Map<string,SVMXC__Entitlement_History__c>();
        If(!isinsert && !WOlisttemp.isempty()){
        List<SVMXC__Entitlement_History__c> WOEHlist=[select id,SVMXC__Covered_By__c,SVMXC__Date_of_entitlement__c,SVMXC__End_Date__c,SVMXC__Service_Contract__c,SVMXC__Start_Date__c,SVMXC__Service_Order__c,SVMXC__Inactive_Date__c from SVMXC__Entitlement_History__c where SVMXC__Service_Order__c in:WOlisttemp and SVMXC__Inactive_Date__c = null];  
        for(SVMXC__Entitlement_History__c EHtemp:WOEHlist){
            MapEHList.put(EHtemp.SVMXC__Service_Order__c,EHtemp);
        }
       }
         String SQlstr='select id,Parts_Pricebook__c, SVMXC__Start_Date__c,SVMXC__End_Date__c,SVMXC__Default_Parts_Price_Book__c,SVMXC__Service_Pricebook__c from SVMXC__Service_Contract__c where SVMXC__Active__c=true and SVMXC__Start_Date__c <= Today and SVMXC__End_Date__c >= Today ';
           /* If(!Branchlist.isEmpty() && !AccList.isEmpty())
            SQlstr=SQlstr+'AND ((Branch__c in:Branchlist AND SVMXC__Company__c in:AccList) OR (Branch__c in:Branchlist AND SVMXC__Company__c =null)) ';
            else If(!Branchlist.isEmpty() && AccList.isEmpty())
            SQlstr=SQlstr+'AND (Branch__c in:Branchlist AND SVMXC__Company__c =null)';*/
            If(!SerContractList.isEmpty())
            SQlstr=SQlstr+'AND Id in: SerContractList';
            //System.debug(SQlstr);
        List<SVMXC__Service_Contract__c> SClist=Database.query(SQlstr);
        //System.debug("SClist.size()"+SClist.size());
        Map<string,SVMXC__Service_Contract__c> MapSClistwithACC= new Map<string,SVMXC__Service_Contract__c>();
        Map<string,SVMXC__Service_Contract__c> MapSClistwithoutACC= new Map<string,SVMXC__Service_Contract__c>();
        Map<string,SVMXC__Service_Contract__c> MapSClistSCid= new Map<string,SVMXC__Service_Contract__c>();
        for(SVMXC__Service_Contract__c sc:SClist){
           /* if(sc.SVMXC__Company__c!=null)
                MapSClistwithACC.put(sc.Branch__c+'~'+sc.SVMXC__Company__c,sc);
            else if(sc.SVMXC__Company__c==null)
                MapSClistwithoutACC.put(sc.Branch__c,sc);*/
            if(SerContractList.contains(sc.Id))
                MapSClistSCid.put(sc.Id,sc);
        }
        
        List<SVMXC__Entitlement_History__c> EHList=new List<SVMXC__Entitlement_History__c>();
        List<SVMXC__Entitlement_History__c> UpdEHList=new List<SVMXC__Entitlement_History__c>();
        for(SVMXC__Service_Order__c wo :WOselectList){
            
           /* if(isinsert && MapSClistwithACC.containskey(wo.GE_PC_Branch__c+'~'+wo.SVMXC__Company__c)){
                wo.SVMXC__Service_Contract__c=MapSClistwithACC.get(wo.GE_PC_Branch__c+'~'+wo.SVMXC__Company__c).id;
                wo.Parts_Pricebook__c=MapSClistwithACC.get(wo.GE_PC_Branch__c+'~'+wo.SVMXC__Company__c).SVMXC__Default_Parts_Price_Book__c;
                wo.Service_Pricebook__c=MapSClistwithACC.get(wo.GE_PC_Branch__c+'~'+wo.SVMXC__Company__c).SVMXC__Service_Pricebook__c;
                wo.SVMXC__Is_Entitlement_Performed__c=True;
                wo.SVMXC__Entitlement_Type__c='INTERACTIVE';
                
            }
            else if(isinsert && MapSClistwithoutACC.containskey(wo.GE_PC_Branch__c)){
                wo.SVMXC__Service_Contract__c=MapSClistwithoutACC.get(wo.GE_PC_Branch__c).id;
                wo.Parts_Pricebook__c=MapSClistwithoutACC.get(wo.GE_PC_Branch__c).SVMXC__Default_Parts_Price_Book__c;
                wo.Service_Pricebook__c=MapSClistwithoutACC.get(wo.GE_PC_Branch__c).SVMXC__Service_Pricebook__c;
                wo.SVMXC__Is_Entitlement_Performed__c=True;
                wo.SVMXC__Entitlement_Type__c='INTERACTIVE';
                
            }*/
               if(isinsert && MapSClistSCid.containskey(wo.SVMXC__Service_Contract__c)){
                wo.SVMXC__Service_Contract__c=MapSClistSCid.get(wo.SVMXC__Service_Contract__c).id;
                wo.Parts_Pricebook__c=MapSClistSCid.get(wo.SVMXC__Service_Contract__c).Parts_Pricebook__c;
                wo.Service_Pricebook__c=MapSClistSCid.get(wo.SVMXC__Service_Contract__c).SVMXC__Service_Pricebook__c;
                wo.SVMXC__Is_Entitlement_Performed__c=True;
                wo.SVMXC__Entitlement_Type__c='INTERACTIVE';
                
            }
            if(!isinsert||Test.isRunningTest()){
                SVMXC__Entitlement_History__c EH=new SVMXC__Entitlement_History__c();
                EH.SVMXC__Covered_By__c='Account';
                EH.SVMXC__Date_of_entitlement__c=System.today();
                EH.SVMXC__Service_Order__c=wo.Id;
                
                if(MapSClistSCid.containskey(wo.SVMXC__Service_Contract__c)){
                wo.SVMXC__Service_Contract__c=MapSClistSCid.get(wo.SVMXC__Service_Contract__c).id;
                wo.Parts_Pricebook__c=MapSClistSCid.get(wo.SVMXC__Service_Contract__c).Parts_Pricebook__c;
                wo.Service_Pricebook__c=MapSClistSCid.get(wo.SVMXC__Service_Contract__c).SVMXC__Service_Pricebook__c;
                wo.SVMXC__Is_Entitlement_Performed__c=True;
                wo.SVMXC__Entitlement_Type__c='INTERACTIVE';
                
                    EH.SVMXC__End_Date__c=MapSClistSCid.get(wo.SVMXC__Service_Contract__c).SVMXC__End_Date__c;
                    EH.SVMXC__Service_Contract__c=MapSClistSCid.get(wo.SVMXC__Service_Contract__c).Id;
                    EH.SVMXC__Start_Date__c=MapSClistSCid.get(wo.SVMXC__Service_Contract__c).SVMXC__Start_Date__c;
                    EHList.add(EH);
                 
                }
                
                if(MapEHList.containskey(wo.id)){
                    SVMXC__Entitlement_History__c EH2=new SVMXC__Entitlement_History__c(id=MapEHList.get(wo.id).id);
                    EH2.SVMXC__Inactive_Date__c=System.today();
                    UpdEHList.add(EH2);
                }
                
            }
        }
        if(!EHList.isEmpty()){
            insert EHList;
        }
        if(!UpdEHList.isEmpty()){
            update UpdEHList;
        }
    }

}