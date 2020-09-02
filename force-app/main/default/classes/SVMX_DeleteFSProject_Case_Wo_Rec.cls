global class SVMX_DeleteFSProject_Case_Wo_Rec{

    webService static String deleteFsRec(Id Id123) {
        GE_SS_Project__c FSPr = new GE_SS_Project__c();
        list<case> cs_lst = new list<case>();
        list<SVMXC__Service_Order__c> wo_lst = new list<SVMXC__Service_Order__c>();
        list<SVMXC__Service_Order__c> wo_Daily = new list<SVMXC__Service_Order__c>();
        list<GE_SS_Service_Ticket__c> wo_ST = new list<GE_SS_Service_Ticket__c>();
        set<Id> cs_id = new set<Id>();
        set<Id> wo_id = new set<Id>();
        
        FSPr = [SELECT id, name FROM GE_SS_Project__c WHERE Id =:Id123];
        cs_lst = [SELECT id FROM case WHERE GE_SS_Project__c =:Id123];
        system.debug('cs_lst====='+cs_lst.size());
        for(case c: cs_lst) {
            cs_id.add(c.id);
        }
        wo_lst = [SELECT id FROM SVMXC__Service_Order__c WHERE SVMXC__Case__c IN :cs_id AND RecordType.name='SS-Mobilize'];
        system.debug('wo_lst====='+wo_lst.size());
        for(SVMXC__Service_Order__c wo:  wo_lst) {
            wo_id.add(wo.id);
        }
        wo_Daily = [SELECT id,GE_SS_Parent_Work_Order__c FROM SVMXC__Service_Order__c WHERE GE_SS_Parent_Work_Order__c IN :wo_id];
        system.debug('wo_Daily====='+wo_Daily.size());
        wo_ST = [SELECT id,name,GE_SS_Work_Order__c FROM GE_SS_Service_Ticket__c WHERE GE_SS_Work_Order__c IN :wo_id];
        system.debug('wo_ST====='+wo_ST.size());
        
        delete FSPr;
        delete cs_lst;
        delete wo_lst;
        delete wo_Daily;
        delete wo_ST;
        return null;
    }
    
    webService static String deleteCsRec(Id Id123) {
        case cs = new case();
        list<SVMXC__Service_Order__c> wo_lst = new list<SVMXC__Service_Order__c>();
        list<SVMXC__Service_Order__c> wo_Daily = new list<SVMXC__Service_Order__c>();
        list<GE_SS_Service_Ticket__c> wo_ST = new list<GE_SS_Service_Ticket__c>();
        set<Id> wo_id = new set<Id>();
        cs = [SELECT id FROM case WHERE id =:Id123];
        wo_lst = [SELECT id FROM SVMXC__Service_Order__c WHERE SVMXC__Case__c =:Id123 AND RecordType.name='SS-Mobilize'];
        for(SVMXC__Service_Order__c wo:  wo_lst) {
            wo_id.add(wo.id);
        }
        wo_Daily = [SELECT id,GE_SS_Parent_Work_Order__c FROM SVMXC__Service_Order__c WHERE GE_SS_Parent_Work_Order__c IN:wo_id];
        
        wo_ST = [SELECT id,name,GE_SS_Work_Order__c FROM GE_SS_Service_Ticket__c WHERE GE_SS_Work_Order__c IN :wo_id];
        delete cs;
        delete wo_lst;
        delete wo_Daily;
        delete wo_ST;
        return null;
    }
    
    webService static String deleteMobWoRec(Id Id123) {
        SVMXC__Service_Order__c MobWo = new SVMXC__Service_Order__c();
        list<SVMXC__Service_Order__c> wo_Daily = new list<SVMXC__Service_Order__c>();
        list<GE_SS_Service_Ticket__c> wo_ST = new list<GE_SS_Service_Ticket__c>();
        
        MobWo = [SELECT id FROM SVMXC__Service_Order__c WHERE id =:Id123];
        wo_Daily = [SELECT id,GE_SS_Parent_Work_Order__c FROM SVMXC__Service_Order__c WHERE GE_SS_Parent_Work_Order__c =:Id123];
        wo_ST = [SELECT id,name,GE_SS_Work_Order__c FROM GE_SS_Service_Ticket__c WHERE GE_SS_Work_Order__c =:Id123];
        
        delete MobWo;
        delete wo_Daily;
        delete wo_ST;
        return null;
    }
}