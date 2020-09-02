public class PRMChannelPartnerBackgroundHandler_GE_OG {
    public void riskRatingCalculationOnCPInsert(List<PRM_Channel_Partner_Background__c> cpbList){
        set<ID> caID = new set<ID>();
        List<PRM_Channel_Partner_Background__c> cpList = new List<PRM_Channel_Partner_Background__c>();
        List<String> primarybankName = new List<String>();
        Map<String,String> primaryBankISOCode = new Map<String,String>();
        Map<String,GE_HQ_Country__c> countryISO = new Map<String,GE_HQ_Country__c>();
        Map<PRM_Channel_Appointment_GE_OG__c,String> accCountryISO = new Map<PRM_Channel_Appointment_GE_OG__c,String>();
        List<string> country1 = new List<string>();
        List<PRM_Commercial_Line_GE_OG__c> comLineList = new List<PRM_Commercial_Line_GE_OG__c>();
        List<string> countryName = new List<string>();
        List<string> risk = new List<string>();
        Map<list<string>,list<string>> conMap = new Map<list<string>,list<string>>();
        Map<ID,List<string>> riskVal = new Map<ID,List<string>>();
        List<String> riskRating = new List<String>();
        set<ID> prmChAppID = new set<ID>();
        Integer i;
        Decimal Orders_Actual;
        Decimal Orders_Target;
        
        for(PRM_Channel_Partner_Background__c chP : cpbList){
            caID.add(chP.PRM_Channel_Appointment__c);
        }
        
        for(PRM_Channel_Appointment_GE_OG__c appList : [select PRM_Mandated_by_end_user_end_customer__c,PRM_Any_felony_or_crime__c,PRM_Last_Compliance_Approved__c,
                                                        PRM_Officers_Relatives_in_govt_positions__c,PRM_Any_Branch_Office_or_Subsidiaries__c,PRM_Exclusivity_requested__c,PRM_Account_Name__r.GE_HQ_Country_Code__c,
                                                        PRM_Any_use_of_Sub_dealers_or_Sub_Agents__c,PRM_Primary_Bank_Account_Country__c,PRM_Account_Name__r.GE_HQ_New_Account_Country__c,
                                                        (select id,PRM_Relationship_Type__c,PRM_Commercial_Line_Type__c,PRM_Channel_Appointment__c,PRM_Status__c,PRM_Channel_Appointment__r.PRM_Risk_Rating__c,PRM_Authorized_Countries_1__c,PRM_Non_Std_Indefinite_Discount_Com__c,PRM_Channel_Appointment__r.PRM_Mandated_by_end_user_end_customer__c,PRM_Channel_Appointment__r.PRM_Any_felony_or_crime__c,PRM_Channel_Appointment__r.PRM_Last_Compliance_Approved__c,
                                                         PRM_Channel_Appointment__r.PRM_Officers_Relatives_in_govt_positions__c,PRM_Channel_Appointment__r.PRM_Exclusivity_requested__c,PRM_Channel_Appointment__r.PRM_Account_Name__r.GE_HQ_Country_Code__c,
                                                         PRM_Channel_Appointment__r.PRM_Any_use_of_Sub_dealers_or_Sub_Agents__c,PRM_Channel_Appointment__r.PRM_Any_Branch_Office_or_Subsidiaries__c,PRM_Channel_Appointment__r.PRM_Primary_Bank_Account_Country__c,PRM_Channel_Appointment__r.PRM_Account_Name__r.GE_HQ_New_Account_Country__c,PRM_Channel_Appointment__r.CP_Backgound_Orders_Actual_Count__c,PRM_Channel_Appointment__r.CP_Backgound_Target_Count__c from PRM_Commercial_Lines__r), 
                                                        (select id,createddate,Year__c,Orders_Actual1__c,Orders_Actual2__c,Target__c,Target1__c,PRM_Channel_Appointment__r.PRM_Risk_Rating__c,PRM_Channel_Appointment__c,PRM_Channel_Appointment__r.PRM_Last_Compliance_Approved__c,
                                                         PRM_Channel_Appointment__r.PRM_Mandated_by_end_user_end_customer__c,PRM_Channel_Appointment__r.PRM_Any_felony_or_crime__c,PRM_Channel_Appointment__r.PRM_Officers_Relatives_in_govt_positions__c,PRM_Channel_Appointment__r.PRM_Exclusivity_requested__c,PRM_Channel_Appointment__r.PRM_Account_Name__r.GE_HQ_Country_Code__c,
                                                         PRM_Channel_Appointment__r.PRM_Any_use_of_Sub_dealers_or_Sub_Agents__c,PRM_Channel_Appointment__r.PRM_Any_Branch_Office_or_Subsidiaries__c,PRM_Channel_Appointment__r.PRM_Primary_Bank_Account_Country__c,PRM_Channel_Appointment__r.PRM_Account_Name__r.GE_HQ_New_Account_Country__c from Channel_Partners_Background__r order by createddate desc) from PRM_Channel_Appointment_GE_OG__c where id in :caID]){
                                                             if(appList.PRM_Account_Name__r.GE_HQ_Country_Code__c != null){                                              
                                                                 accCountryISO.put(appList,appList.PRM_Account_Name__r.GE_HQ_Country_Code__c); 
                                                             }
                                                             if(appList.PRM_Primary_Bank_Account_Country__c != null){
                                                                 primarybankName.add(appList.PRM_Primary_Bank_Account_Country__c);
                                                             }
                                                             for(PRM_Commercial_Line_GE_OG__c ccL : appList.PRM_Commercial_Lines__r){
                                                                 if(ccL.PRM_Status__c != 'Non-Renewed' && ccL.PRM_Status__c != 'Terminated' && ccL.PRM_Status__c != 'Archived' && ccL.PRM_Status__c != 'Rejected'&& ccL.PRM_Status__c != 'Abandoned' && ccL.PRM_Commercial_Line_Type__c != 'NRT'){
                                                                     comLineList.add(ccL);
                                                                     if(ccL.PRM_Authorized_Countries_1__c != null){
                                                                         country1.addAll(ccL.PRM_Authorized_Countries_1__c.split(';'));
                                                                     }
                                                                 }
                                                             }
                                                             for(PRM_Channel_Partner_Background__c chp : appList.Channel_Partners_Background__r){
                                                                 cpList.add(chp);
                                                             }
                                                         }
        
        
        for(GE_HQ_Country__c countries : [select name,GE_PRM_Adverse_Termination_Risk__c,GE_HQ_ISO_Code__c,GE_PRM_Channel_Risk_Type__c from GE_HQ_Country__c where GE_HQ_ISO_Code__c in :accCountryISO.values()]){
            countryISO.put(countries.GE_HQ_ISO_Code__c,countries);
        }
        
        for(GE_HQ_Country__c countries_1 : [select name,GE_PRM_Adverse_Termination_Risk__c,GE_HQ_ISO_Code__c,GE_PRM_Channel_Risk_Type__c from GE_HQ_Country__c where Name in :primarybankName]){
            primaryBankISOCode.put(countries_1.name,countries_1.GE_HQ_ISO_Code__c);
        }
        
        for(GE_HQ_Country__c cont : [select GE_PRM_Channel_Risk_Type__c,name from GE_HQ_Country__c where name IN :country1]){
            countryName.add(cont.name);
            risk.add(cont.GE_PRM_Channel_Risk_Type__c);
        }
        conMap.put(countryName,risk);
        
        try{
            if(cpList.size() > 0){
                AggregateResult[] ag = [select Year__c,PRM_Channel_Appointment__c,sum(Orders_Actual2__c) OrdersActualSum,sum(Target1__c) OrdersTargetSum from PRM_Channel_Partner_Background__c
                                        where PRM_Channel_Appointment__c in :caID group by Year__c,PRM_Channel_Appointment__c];
                
                for(AggregateResult a : ag){
                    Orders_Actual = (Decimal)a.get('OrdersActualSum');
                    Orders_Target = (Decimal)a.get('OrdersTargetSum');
                }
                
                for(i=0;i<cpList.size();i++){
                    if(cpList[i].Orders_Actual1__c != null || cpList[i].Target__c != null){                        
                        if(((cpList[i].Orders_Actual2__c > cpList[i].Target1__c) && (cpList[i].Orders_Actual2__c >= 10000000)) || ((cpList[i].Target1__c > cpList[i].Orders_Actual2__c) && (cpList[i].Target1__c >= 10000000)) || Orders_Actual >= 10000000 || Orders_Target >= 10000000 || 
                           countryISO.get(cpList[i].PRM_Channel_Appointment__r.PRM_Account_Name__r.GE_HQ_Country_Code__c).GE_PRM_Channel_Risk_Type__c == 'High'){
                               if(cpList[i].PRM_Channel_Appointment__r.PRM_Last_Compliance_Approved__c != null){
                                   riskRating.add('Medium');
                                   riskVal.put(cpList[i].PRM_Channel_Appointment__c, riskRating);
                               }
                               else{
                                   riskRating.add('High');
                                   riskVal.put(cpList[i].PRM_Channel_Appointment__c, riskRating);
                               }  
                               prmChAppID = riskVal.keyset();
                           }
                        else if(cpList[i].PRM_Channel_Appointment__r.PRM_Any_felony_or_crime__c == 'Yes' || cpList[i].PRM_Channel_Appointment__r.PRM_Officers_Relatives_in_govt_positions__c == 'Yes'|| 
                                cpList[i].PRM_Channel_Appointment__r.PRM_Mandated_by_end_user_end_customer__c == 'Yes' || cpList[i].PRM_Channel_Appointment__r.PRM_Exclusivity_requested__c == 'Yes'||
                                ((primaryBankISOCode.get(cpList[i].PRM_Channel_Appointment__r.PRM_Primary_Bank_Account_Country__c) != cpList[i].PRM_Channel_Appointment__r.PRM_Account_Name__r.GE_HQ_Country_Code__c) && cpList[i].PRM_Channel_Appointment__r.PRM_Primary_Bank_Account_Country__c!= null) ||
                                countryISO.get(cpList[i].PRM_Channel_Appointment__r.PRM_Account_Name__r.GE_HQ_Country_Code__c).GE_PRM_Channel_Risk_Type__c == 'High'){
                                    riskRating.add('High');
                                    riskVal.put(cpList[i].PRM_Channel_Appointment__c, riskRating); 
                                    prmChAppID = riskVal.keyset();
                                }
                        else if((cpList[i].PRM_Channel_Appointment__r.PRM_Any_use_of_Sub_dealers_or_Sub_Agents__c == 'Yes') || (cpList[i].PRM_Channel_Appointment__r.PRM_Any_Branch_Office_or_Subsidiaries__c == 'Yes') || (countryISO.get(cpList[i].PRM_Channel_Appointment__r.PRM_Account_Name__r.GE_HQ_Country_Code__c).GE_PRM_Channel_Risk_Type__c == 'Medium') || (countryISO.get(cpList[i].PRM_Channel_Appointment__r.PRM_Account_Name__r.GE_HQ_Country_Code__c).GE_PRM_Adverse_Termination_Risk__c > 20)){
                            riskRating.add('Medium');
                            riskVal.put(cpList[i].PRM_Channel_Appointment__c, riskRating); 
                            prmChAppID = riskVal.keyset();
                        }
                        else if(countryISO.get(cpList[i].PRM_Channel_Appointment__r.PRM_Account_Name__r.GE_HQ_Country_Code__c).GE_PRM_Channel_Risk_Type__c == 'Low'){
                            riskRating.add('Low');
                            riskVal.put(cpList[i].PRM_Channel_Appointment__c, riskRating);   
                            prmChAppID = riskVal.keyset();
                        }
                    }
                }
            }
            
            if(comLineList.size() > 0){
                for(i=0;i<comLineList.size();i++){
                    if(comLineList[i].PRM_Relationship_Type__c == 'Sales Representative' && comLineList[i].PRM_Channel_Appointment__r.PRM_Risk_Rating__c == 'Medium'){
                        riskRating.add('High');
                        riskVal.put(comLineList[i].PRM_Channel_Appointment__c, riskRating); 
                        prmChAppID = riskVal.keyset();
                    }
                    else if(conMap.values() != null && conMap.get(countryName).contains('High')){
                        if(comLineList[i].PRM_Channel_Appointment__r.PRM_Last_Compliance_Approved__c != null){
                            riskRating.add('Medium');
                            riskVal.put(comLineList[i].PRM_Channel_Appointment__c, riskRating);
                        }
                        else {
                            riskRating.add('High');
                            riskVal.put(comLineList[i].PRM_Channel_Appointment__c, riskRating);
                        }
                        prmChAppID = riskVal.keyset();
                    }
                    else if((conMap != null && conMap.get(countryName).contains('Medium')) || (comLineList[i].PRM_Non_Std_Indefinite_Discount_Com__c == 'Non-standard') || (comLineList[i].PRM_Non_Std_Indefinite_Discount_Com__c == 'Indefinite')){
                        riskRating.add('Medium');
                        riskVal.put(comLineList[i].PRM_Channel_Appointment__c, riskRating);
                        prmChAppID = riskVal.keyset();
                    }
                    else if(conMap != null && conMap.get(countryName).contains('Low')){
                        riskRating.add('Low');
                        riskVal.put(comLineList[i].PRM_Channel_Appointment__c, riskRating);
                        prmChAppID = riskVal.keyset();
                    }
                }
            }
            
            List<PRM_Channel_Appointment_GE_OG__c> updateList = new List<PRM_Channel_Appointment_GE_OG__c> (); 
            for(ID ch : prmChAppID){
                if(riskVal.get(ch).contains('High')){
                    PRM_Channel_Appointment_GE_OG__c prm_chanel_apointment = new PRM_Channel_Appointment_GE_OG__c();
                    prm_chanel_apointment.id = ch;
                    prm_chanel_apointment.PRM_Risk_Rating__c = 'High';
                    prm_chanel_apointment.PRM_Was_Ever_High__c = true;
                    updateList.add(prm_chanel_apointment);
                } 
                else if(riskVal.get(ch).contains('Medium')){
                    PRM_Channel_Appointment_GE_OG__c prm_chanel_apointment = new PRM_Channel_Appointment_GE_OG__c();
                    prm_chanel_apointment.id = ch;
                    prm_chanel_apointment.PRM_Risk_Rating__c = 'Medium';
                    updateList.add(prm_chanel_apointment);
                }
                else if(riskVal.get(ch).contains('Low')){
                    PRM_Channel_Appointment_GE_OG__c prm_chanel_apointment = new PRM_Channel_Appointment_GE_OG__c();
                    prm_chanel_apointment.id = ch;
                    prm_chanel_apointment.PRM_Risk_Rating__c = 'Low';
                    updateList.add(prm_chanel_apointment);
                }
            }
            update updateList;
        }
        catch(exception e){
            system.debug('Exception is: '+e.getMessage());
        }
    }
    
    public void riskRatingCalculationOnCPUpdate(List<PRM_Channel_Partner_Background__c> cpbNew,Map<ID,PRM_Channel_Partner_Background__c> cpbOld){
        set<ID> chAId = new set<ID>();
        Map<PRM_Channel_Appointment_GE_OG__c,String> accCountryISO = new Map<PRM_Channel_Appointment_GE_OG__c,String>();
        Map<String,GE_HQ_Country__c> countryISO = new Map<String,GE_HQ_Country__c>();
        List<String> primarybankName = new List<String>();
        Map<String,String> primaryBankISOCode = new Map<String,String>();
        List<string> country1 = new List<string>();
        List<string> countryName = new List<string>();
        List<string> risk = new List<string>();
        Map<list<string>,list<string>> conMap = new Map<list<string>,list<string>>();
        Map<ID,List<string>> riskVal = new Map<ID,List<string>>();
        List<String> riskRating = new List<String>();
        List<PRM_Commercial_Line_GE_OG__c> comLineList = new List<PRM_Commercial_Line_GE_OG__c>();
        List<PRM_Channel_Partner_Background__c> cpList = new List<PRM_Channel_Partner_Background__c>();
        set<ID> prmChAppID = new set<ID>();
        Integer i;
        Decimal Orders_Actual;
        Decimal Orders_Target;
        
        for(PRM_Channel_Partner_Background__c cpbg : cpbNew){
            if((cpbg.Orders_Actual2__c != cpbOld.get(cpbg.id).Orders_Actual2__c) || (cpbg.Target1__c != cpbOld.get(cpbg.id).Target1__c) || (cpbg.Year__c != cpbOld.get(cpbg.id).Year__c)){
                chAId.add(cpbg.PRM_Channel_Appointment__c);
            }
        }
        
        for(PRM_Channel_Appointment_GE_OG__c appList : [select PRM_Mandated_by_end_user_end_customer__c,PRM_Any_felony_or_crime__c,PRM_Last_Compliance_Approved__c,
                                                        PRM_Officers_Relatives_in_govt_positions__c,PRM_Exclusivity_requested__c,PRM_Account_Name__r.GE_HQ_Country_Code__c,
                                                        PRM_Any_use_of_Sub_dealers_or_Sub_Agents__c,PRM_Any_Branch_Office_or_Subsidiaries__c,PRM_Primary_Bank_Account_Country__c,PRM_Account_Name__r.GE_HQ_New_Account_Country__c,
                                                        (select id,PRM_Relationship_Type__c,PRM_Commercial_Line_Type__c,PRM_Channel_Appointment__c,PRM_Status__c,PRM_Channel_Appointment__r.PRM_Risk_Rating__c,PRM_Authorized_Countries_1__c,PRM_Non_Std_Indefinite_Discount_Com__c,PRM_Channel_Appointment__r.PRM_Mandated_by_end_user_end_customer__c,PRM_Channel_Appointment__r.PRM_Any_felony_or_crime__c,PRM_Channel_Appointment__r.PRM_Last_Compliance_Approved__c,
                                                         PRM_Channel_Appointment__r.PRM_Officers_Relatives_in_govt_positions__c,PRM_Channel_Appointment__r.PRM_Exclusivity_requested__c,PRM_Channel_Appointment__r.PRM_Account_Name__r.GE_HQ_Country_Code__c,
                                                         PRM_Channel_Appointment__r.PRM_Any_use_of_Sub_dealers_or_Sub_Agents__c,PRM_Channel_Appointment__r.PRM_Any_Branch_Office_or_Subsidiaries__c,PRM_Channel_Appointment__r.PRM_Primary_Bank_Account_Country__c,PRM_Channel_Appointment__r.PRM_Account_Name__r.GE_HQ_New_Account_Country__c,PRM_Channel_Appointment__r.CP_Backgound_Orders_Actual_Count__c,PRM_Channel_Appointment__r.CP_Backgound_Target_Count__c from PRM_Commercial_Lines__r), 
                                                        (select id,createddate,Year__c,Orders_Actual1__c,Orders_Actual2__c,Target__c,Target1__c,PRM_Channel_Appointment__r.PRM_Risk_Rating__c,PRM_Channel_Appointment__c,PRM_Channel_Appointment__r.PRM_Last_Compliance_Approved__c,
                                                         PRM_Channel_Appointment__r.PRM_Mandated_by_end_user_end_customer__c,PRM_Channel_Appointment__r.PRM_Any_felony_or_crime__c,PRM_Channel_Appointment__r.PRM_Officers_Relatives_in_govt_positions__c,PRM_Channel_Appointment__r.PRM_Exclusivity_requested__c,PRM_Channel_Appointment__r.PRM_Account_Name__r.GE_HQ_Country_Code__c,
                                                         PRM_Channel_Appointment__r.PRM_Any_use_of_Sub_dealers_or_Sub_Agents__c,PRM_Channel_Appointment__r.PRM_Any_Branch_Office_or_Subsidiaries__c,PRM_Channel_Appointment__r.PRM_Primary_Bank_Account_Country__c,PRM_Channel_Appointment__r.PRM_Account_Name__r.GE_HQ_New_Account_Country__c from Channel_Partners_Background__r order by createddate desc) from PRM_Channel_Appointment_GE_OG__c where id in :chAId]){
                                                             if(appList.PRM_Account_Name__r.GE_HQ_Country_Code__c != null){                                              
                                                                 accCountryISO.put(appList,appList.PRM_Account_Name__r.GE_HQ_Country_Code__c); 
                                                             }
                                                             if(appList.PRM_Primary_Bank_Account_Country__c != null){
                                                                 primarybankName.add(appList.PRM_Primary_Bank_Account_Country__c);
                                                             }
                                                             for(PRM_Commercial_Line_GE_OG__c ccL : appList.PRM_Commercial_Lines__r){
                                                                 if(ccL.PRM_Status__c != 'Non-Renewed' && ccL.PRM_Status__c != 'Terminated' && ccL.PRM_Status__c != 'Archived' && ccL.PRM_Status__c != 'Rejected' && ccL.PRM_Status__c != 'Abandoned' && ccL.PRM_Commercial_Line_Type__c != 'NRT'){
                                                                     comLineList.add(ccL);
                                                                     if(ccL.PRM_Authorized_Countries_1__c != null){
                                                                         country1.addAll(ccL.PRM_Authorized_Countries_1__c.split(';'));
                                                                     }
                                                                 }
                                                             }
                                                             for(PRM_Channel_Partner_Background__c chp : appList.Channel_Partners_Background__r){
                                                                 cpList.add(chp);
                                                             }
                                                         }
        
        for(GE_HQ_Country__c countries : [select name,GE_PRM_Adverse_Termination_Risk__c,GE_HQ_ISO_Code__c,GE_PRM_Channel_Risk_Type__c from GE_HQ_Country__c where GE_HQ_ISO_Code__c in :accCountryISO.values()]){
            countryISO.put(countries.GE_HQ_ISO_Code__c,countries);
        }
        
        for(GE_HQ_Country__c countries_1 : [select name,GE_PRM_Adverse_Termination_Risk__c,GE_HQ_ISO_Code__c,GE_PRM_Channel_Risk_Type__c from GE_HQ_Country__c where Name in :primarybankName]){
            primaryBankISOCode.put(countries_1.name,countries_1.GE_HQ_ISO_Code__c);
        }
        
        for(GE_HQ_Country__c cont : [select GE_PRM_Channel_Risk_Type__c,name from GE_HQ_Country__c where name IN :country1]){
            countryName.add(cont.name);
            risk.add(cont.GE_PRM_Channel_Risk_Type__c);
        }
        conMap.put(countryName,risk);
        
        try{
            if(cpList.size() > 0){
                AggregateResult[] ag = [select Year__c,PRM_Channel_Appointment__c,sum(Orders_Actual2__c) OrdersActualSum,sum(Target1__c) OrdersTargetSum from PRM_Channel_Partner_Background__c
                                        where PRM_Channel_Appointment__c in :chAId group by Year__c,PRM_Channel_Appointment__c];
                
                for(AggregateResult a : ag){
                    Orders_Actual = (Decimal)a.get('OrdersActualSum');
                    Orders_Target = (Decimal)a.get('OrdersTargetSum');
                }
                
                for(i=0;i<cpList.size();i++){
                    if(cpList[i].Orders_Actual1__c != null || cpList[i].Target__c != null){
                        if(((cpList[i].Orders_Actual2__c > cpList[i].Target1__c) && (cpList[i].Orders_Actual2__c >= 10000000)) || ((cpList[i].Target1__c > cpList[i].Orders_Actual2__c) && (cpList[i].Target1__c >= 10000000)) || 
                           Orders_Actual >= 10000000 || Orders_Target >= 10000000 || countryISO.get(cpList[i].PRM_Channel_Appointment__r.PRM_Account_Name__r.GE_HQ_Country_Code__c).GE_PRM_Channel_Risk_Type__c == 'High'){
                               if(cpList[i].PRM_Channel_Appointment__r.PRM_Last_Compliance_Approved__c != null){
                                   riskRating.add('Medium');
                                   riskVal.put(cpList[i].PRM_Channel_Appointment__c, riskRating);
                               }
                               else{
                                   riskRating.add('High');
                                   riskVal.put(cpList[i].PRM_Channel_Appointment__c, riskRating);
                               }
                               prmChAppID = riskVal.keyset();
                           }
                        else if(cpList[i].PRM_Channel_Appointment__r.PRM_Any_felony_or_crime__c == 'Yes' || cpList[i].PRM_Channel_Appointment__r.PRM_Exclusivity_requested__c == 'Yes' || 
                                cpList[i].PRM_Channel_Appointment__r.PRM_Officers_Relatives_in_govt_positions__c == 'Yes' || cpList[i].PRM_Channel_Appointment__r.PRM_Mandated_by_end_user_end_customer__c == 'Yes' || 
                                ((primaryBankISOCode.get(cpList[i].PRM_Channel_Appointment__r.PRM_Primary_Bank_Account_Country__c) != cpList[i].PRM_Channel_Appointment__r.PRM_Account_Name__r.GE_HQ_Country_Code__c) && cpList[i].PRM_Channel_Appointment__r.PRM_Primary_Bank_Account_Country__c!= null)){
                                    riskRating.add('High');
                                    riskVal.put(cpList[i].PRM_Channel_Appointment__c, riskRating);  
                                    prmChAppID = riskVal.keyset();
                                }
                        else if((cpList[i].PRM_Channel_Appointment__r.PRM_Any_use_of_Sub_dealers_or_Sub_Agents__c == 'Yes') || (cpList[i].PRM_Channel_Appointment__r.PRM_Any_Branch_Office_or_Subsidiaries__c == 'Yes') || (countryISO.get(cpList[i].PRM_Channel_Appointment__r.PRM_Account_Name__r.GE_HQ_Country_Code__c).GE_PRM_Channel_Risk_Type__c == 'Medium') || (countryISO.get(cpList[i].PRM_Channel_Appointment__r.PRM_Account_Name__r.GE_HQ_Country_Code__c).GE_PRM_Adverse_Termination_Risk__c > 20)){
                            riskRating.add('Medium');
                            riskVal.put(cpList[i].PRM_Channel_Appointment__c, riskRating); 
                            prmChAppID = riskVal.keyset();
                        }
                        else if(countryISO.get(cpList[i].PRM_Channel_Appointment__r.PRM_Account_Name__r.GE_HQ_Country_Code__c).GE_PRM_Channel_Risk_Type__c == 'Low'){
                            riskRating.add('Low');
                            riskVal.put(cpList[i].PRM_Channel_Appointment__c, riskRating);   
                            prmChAppID = riskVal.keyset();
                        }
                    }
                }
            }
            
            if(comLineList.size() > 0){
                for(i=0;i<comLineList.size();i++){
                    if(comLineList[i].PRM_Relationship_Type__c == 'Sales Representative' && comLineList[i].PRM_Channel_Appointment__r.PRM_Risk_Rating__c == 'Medium'){
                        riskRating.add('High');
                        riskVal.put(comLineList[i].PRM_Channel_Appointment__c, riskRating);  
                        prmChAppID = riskVal.keyset();
                    }
                    else if(conMap != null && conMap.get(countryName).contains('High')){
                        if(comLineList[i].PRM_Channel_Appointment__r.PRM_Last_Compliance_Approved__c != null){
                            riskRating.add('Medium');
                            riskVal.put(comLineList[i].PRM_Channel_Appointment__c, riskRating);
                        }
                        else {
                            riskRating.add('High');
                            riskVal.put(comLineList[i].PRM_Channel_Appointment__c, riskRating);
                        }
                        prmChAppID = riskVal.keyset();
                    }
                    else if((conMap != null && conMap.get(countryName).contains('Medium')) || (comLineList[i].PRM_Non_Std_Indefinite_Discount_Com__c == 'Non-standard') || (comLineList[i].PRM_Non_Std_Indefinite_Discount_Com__c == 'Indefinite')){
                        riskRating.add('Medium');
                        riskVal.put(comLineList[i].PRM_Channel_Appointment__c, riskRating);
                        prmChAppID = riskVal.keyset();
                    }
                    else if(conMap != null && conMap.get(countryName).contains('Low')){
                        riskRating.add('Low');
                        riskVal.put(comLineList[i].PRM_Channel_Appointment__c, riskRating);
                        prmChAppID = riskVal.keyset();
                    }
                }
            }
            
            List<PRM_Channel_Appointment_GE_OG__c> updateList = new List<PRM_Channel_Appointment_GE_OG__c> (); 
            for(ID ch : prmChAppID){
                if(riskVal.get(ch).contains('High')){
                    PRM_Channel_Appointment_GE_OG__c prm_chanel_apointment = new PRM_Channel_Appointment_GE_OG__c();
                    prm_chanel_apointment.id = ch;
                    prm_chanel_apointment.PRM_Risk_Rating__c = 'High';
                    prm_chanel_apointment.PRM_Was_Ever_High__c = true;
                    updateList.add(prm_chanel_apointment);
                } 
                else if(riskVal.get(ch).contains('Medium')){
                    PRM_Channel_Appointment_GE_OG__c prm_chanel_apointment = new PRM_Channel_Appointment_GE_OG__c();
                    prm_chanel_apointment.id = ch;
                    prm_chanel_apointment.PRM_Risk_Rating__c = 'Medium';
                    updateList.add(prm_chanel_apointment);
                }
                else if(riskVal.get(ch).contains('Low')){
                    PRM_Channel_Appointment_GE_OG__c prm_chanel_apointment = new PRM_Channel_Appointment_GE_OG__c();
                    prm_chanel_apointment.id = ch;
                    prm_chanel_apointment.PRM_Risk_Rating__c = 'Low';
                    updateList.add(prm_chanel_apointment);
                }
            }
            CheckRecursion_GE_OG.cp_background = false;
            update updateList;
        }
        catch(Exception e){
            system.debug('Exception is: '+e.getMessage());
        }
    }
}