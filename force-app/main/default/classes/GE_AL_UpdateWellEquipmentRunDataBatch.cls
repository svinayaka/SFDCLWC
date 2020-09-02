/*
Req: R-25681

Class Name              :        GE_AL_UpdateWellEquipmentRunDataBatch
Class called in         :        GE_AL_wellRunscheduleUpdateBatch
Purpose                 :        To update well run data record under the location and Equipment Run data on the Installed Product record
Test class              :        GE_AL_WellEquipmentRunDataBatch_TEST
Created on              :        5/17/2017  
*/

global class GE_AL_UpdateWellEquipmentRunDataBatch implements Database.Batchable<sObject>{
    
    List<GE_AL_Well_Run_Data__c> wrderrorlist = new List<GE_AL_Well_Run_Data__c>();
    List<GE_AL_Equipment_Run_Data__c> erderrorlist = null;
    
    global Database.querylocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator([select id,LL__c,DS__c,PR__c,P1__c,P2__c,P3__c,P4__c,P5__c,P6__c,I1__c,I2__c,SU__c,L__c,MN__c,MI__c,MQ__c,SR__c,M__c from P__c where CreatedDate = TODAY]);
    }
    
    global void execute(Database.BatchableContext BC, list<P__c> scope) {
        
        Map<ID, P__c> pullmap = new Map<ID, P__c>();
        
        for(P__c pull: scope)
        {
            if (pull.LL__c != Null)
            {
                pullMap.put(pull.LL__c, pull);
            }
        }
        
        Map<ID, P__c> ipmap = new Map<ID, P__c>();
        
        for(P__c pull: scope){
            
            if(pull.P1__c!=Null){            
            ipmap.put(pull.P1__c,pull);
            }
            if(pull.P2__c!=Null){
            ipmap.put(pull.P2__c,pull);
            }
            if(pull.P3__c!=Null){
             ipmap.put(pull.P3__c,pull);
            }
            if(pull.P4__c!=Null){
            ipmap.put(pull.P4__c,pull);
            }
            if(pull.P5__c!=Null){
            ipmap.put(pull.P5__c,pull);
            }
            if(pull.P6__c!=Null){
            ipmap.put(pull.P6__c,pull);
            }
            if(pull.I1__c!=Null){
            ipmap.put(pull.I1__c,pull);
            }
            if(pull.I2__c!=Null){
           ipmap.put(pull.I2__c,pull);
            }
            if(pull.SU__c!=Null){
            ipmap.put(pull.SU__c,pull);
            }
            if(pull.L__c!=Null){
            ipmap.put(pull.L__c,pull);
            }
            if(pull.MN__c!=Null){
            ipmap.put(pull.MN__c,pull);
            }
            if(pull.MI__c!=Null){
            ipmap.put(pull.MI__c,pull);
            }
            if(pull.MQ__c!=Null){
            ipmap.put(pull.MQ__c,pull);
            }
            if(pull.SR__c!=Null){
            ipmap.put(pull.SR__c,pull);
            }
            if(pull.M__c!=Null){
            ipmap.put(pull.M__c,pull);
            }
        }
        
        // SOQL query to get all locations and their recent wellrundata in pullrecord location
        
        List<SVMXC__Site__c> loclist = [select id,name,(SELECT Id,Name,GE_AL_Pull__c,GE_AL_Install_Date__c,GE_AL_Pull_Date__c,GE_AL_Location__c FROM GE_AL_Wells_Run_Data__r ORDER BY CreatedDate DESC LIMIT 1) from SVMXC__Site__c where id IN : pullMap.KeySet()];        
        
        // to store wellrundata records with install date null
        
        // wrderrorlist = new List<GE_AL_Well_Run_Data__c>();
        List<GE_AL_Well_Run_Data__c> wrdsuccesslist = new List<GE_AL_Well_Run_Data__c>();
        
        for(SVMXC__Site__c loc : loclist){
            
            P__c pullrec = pullmap.get(loc.Id);
            
            for(GE_AL_Well_Run_Data__c wrd:loc.GE_AL_Wells_Run_Data__r){
                
                if(wrd.GE_AL_Pull_Date__c == Null && wrd.GE_AL_Install_Date__c != Null){
                    
                    wrd.GE_AL_Pull__c = pullrec.Id;
                    wrd.GE_AL_Pull_Date__c = pullrec.DS__c;
                    wrd.GE_AL_Reason_for_Pull__c = pullrec.PR__c;
                    wrdsuccesslist.add(wrd);
                }else{
                    wrderrorlist.add(wrd);
                } 
            } 
        }
        system.debug('wellrundata success'+wrdsuccesslist.size());
        system.debug('wellrundata error'+wrderrorlist.size());
        Database.SaveResult[] srlist = Database.update(wrdsuccesslist,false);
        
        List<SVMXC__Installed_Product__c> iplist =[select id,Name,(select id,Name,GE_AL_Install_Date__c,GE_AL_Location__c,SVMXC_Installed_Product__c,GE_AL_Pull_Date__c from Equipments_Run_Data__r ORDER BY CreatedDate DESC LIMIT 1) from SVMXC__Installed_Product__c where id in :ipmap.keyset()];
        List<GE_AL_Equipment_Run_Data__c> equipmentrundata = new List<GE_AL_Equipment_Run_Data__c>();
        
        for(SVMXC__Installed_Product__c ip : iplist){        
            for(GE_AL_Equipment_Run_Data__c erd : ip.Equipments_Run_Data__r){
            equipmentrundata.add(erd);
            }
        }
        
        system.debug('erd'+equipmentrundata.size());
        
        erderrorlist = new List<GE_AL_Equipment_Run_Data__c>();
        List<GE_AL_Equipment_Run_Data__c> erdsuccesslist = new List<GE_AL_Equipment_Run_Data__c>();
        
        for(SVMXC__Installed_Product__c ip : iplist){    
            P__c pull = ipmap.get(ip.Id);
            for(GE_AL_Equipment_Run_Data__c  erd:ip.Equipments_Run_Data__r){
                if(erd.GE_AL_Pull_Date__c == Null && erd.GE_AL_Install_Date__c != Null){
                     if(pull.P1__c != Null && pull.P1__c == erd.SVMXC_Installed_Product__c)
                        {   
                            erd.GE_AL_Pull_Date__c = pull.DS__c;
                            erdsuccesslist.add(erd);
                        }
                        if(pull.P2__c != Null && pull.P2__c == erd.SVMXC_Installed_Product__c)
                        {   
                            erd.GE_AL_Pull_Date__c = pull.DS__c;
                            erdsuccesslist.add(erd);
                        }
                        if(pull.P3__c != Null && pull.P3__c == erd.SVMXC_Installed_Product__c)
                        {   
                            erd.GE_AL_Pull_Date__c = pull.DS__c;
                            erdsuccesslist.add(erd);
                        }
                        if(pull.P4__c != Null && pull.P4__c == erd.SVMXC_Installed_Product__c)
                        {   
                            erd.GE_AL_Pull_Date__c = pull.DS__c;
                            erdsuccesslist.add(erd);
                        }
                        if(pull.P5__c != Null && pull.P5__c == erd.SVMXC_Installed_Product__c)
                        {   
                            erd.GE_AL_Pull_Date__c = pull.DS__c;
                            erdsuccesslist.add(erd);
                        }
                        if(pull.P6__c != Null && pull.P6__c == erd.SVMXC_Installed_Product__c)
                        {   
                            erd.GE_AL_Pull_Date__c = pull.DS__c;
                            erdsuccesslist.add(erd);
                        }
                        if(pull.I1__c != Null && pull.I1__c == erd.SVMXC_Installed_Product__c)
                        {   
                            erd.GE_AL_Pull_Date__c = pull.DS__c;
                            erdsuccesslist.add(erd);
                        }
                        if(pull.I2__c != Null && pull.I2__c == erd.SVMXC_Installed_Product__c)
                        {   
                            erd.GE_AL_Pull_Date__c = pull.DS__c;
                            erdsuccesslist.add(erd);
                        }
                        if(pull.SU__c != Null && pull.SU__c == erd.SVMXC_Installed_Product__c)
                        {   
                            erd.GE_AL_Pull_Date__c = pull.DS__c;
                            erdsuccesslist.add(erd);
                        }
                        if(pull.L__c != Null && pull.L__c == erd.SVMXC_Installed_Product__c)
                        {   
                            erd.GE_AL_Pull_Date__c = pull.DS__c;
                            erdsuccesslist.add(erd);
                        }
                        if(pull.MN__c != Null && pull.MN__c == erd.SVMXC_Installed_Product__c)
                        {   
                            erd.GE_AL_Pull_Date__c = pull.DS__c;
                            erdsuccesslist.add(erd);
                        }
                        if(pull.MI__c != Null && pull.MI__c == erd.SVMXC_Installed_Product__c)
                        {   
                            erd.GE_AL_Pull_Date__c = pull.DS__c;
                            erdsuccesslist.add(erd);
                        }
                        if(pull.MQ__c != Null && pull.MQ__c == erd.SVMXC_Installed_Product__c)
                        {   
                            erd.GE_AL_Pull_Date__c = pull.DS__c;
                            erdsuccesslist.add(erd);
                        }
                        if(pull.SR__c != Null && pull.SR__c == erd.SVMXC_Installed_Product__c)
                        {   
                            erd.GE_AL_Pull_Date__c = pull.DS__c;
                            erdsuccesslist.add(erd);
                        }
                        if(pull.M__c != Null && pull.M__c == erd.SVMXC_Installed_Product__c)
                        {   
                            erd.GE_AL_Pull_Date__c = pull.DS__c;
                            erdsuccesslist.add(erd);
                        }
                  
                }else{
                    erderrorlist.add(erd);
                } 
            } 
        }
        
        system.debug('equipmentrundata success'+erdsuccesslist.size());
        system.debug('equipmentrundata error'+erderrorlist.size());
        Database.SaveResult[] slist = Database.update(erdsuccesslist,false);
        
      /*  
        String msg = '';

        for(GE_AL_Well_Run_Data__c wrd:wrderrorlist){
           msg+=wrd.Id+'--';
        }
        
        for(GE_AL_Equipment_Run_Data__c erd:erderrorlist){
           msg+=erd.Id+'--';
        }
        */
        
        String body = '<table border="1"><tr> <th>Record Name</th><th>Record ID</th></tr>';
        
        for(GE_AL_Well_Run_Data__c wrd:wrderrorlist){
           body+='<tr><td>'+wrd.Name+'</td><td>'+wrd.Id+'</td></tr>';
        }
        
        for(GE_AL_Equipment_Run_Data__c erd:erderrorlist){
           body+='<tr><td>'+erd.Name+'</td><td>'+erd.Id+'</td></tr>';
        }
        
        body+='</table>';
        
      //  system.debug('in finish'+msg);
        if(wrderrorlist.size()>0 ||erderrorlist.size()>0 ){
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {'naveen.vuppu@ge.com','christie.huczek@ge.com'};
        mail.setToAddresses(toAddresses);
        mail.setSubject('Record not updated');
       // mail.setPlainTextBody('records failed '+msg);
        mail.setHtmlBody(body);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        
        }
    }
    global void finish(Database.BatchableContext BC) {   
    }
}