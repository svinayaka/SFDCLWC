public class PRMChannelAppointmentHandler_GE_OG {
    public void riskRatingCalculationOnCAInsert(List<PRM_Channel_Appointment_GE_OG__c> prm){
        set<ID> chAppId = new set<ID>();
        List<PRM_Channel_Appointment_GE_OG__c> ch = new List<PRM_Channel_Appointment_GE_OG__c>();
        Map<PRM_Channel_Appointment_GE_OG__c,String> accCountryISO = new Map<PRM_Channel_Appointment_GE_OG__c,String>();
        Map<String,GE_HQ_Country__c> countryISO = new Map<String,GE_HQ_Country__c>();
        List<String> primarybankName = new List<String>();
        Map<String,String> primaryBankISOCode = new Map<String,String>();
        
        for(PRM_Channel_Appointment_GE_OG__c pr : prm){
            chAppId.add(pr.Id);
        }
        for(PRM_Channel_Appointment_GE_OG__c chApt : [select id,PRM_Mandated_by_end_user_end_customer__c,PRM_Any_felony_or_crime__c,PRM_Account_Name__c,PRM_Last_Compliance_Approved__c,
                                                      PRM_Officers_Relatives_in_govt_positions__c,PRM_Any_Branch_Office_or_Subsidiaries__c,PRM_Exclusivity_requested__c,PRM_Account_Name__r.GE_HQ_Country_Code__c,
                                                      PRM_Any_use_of_Sub_dealers_or_Sub_Agents__c,PRM_Primary_Bank_Account_Country__c,PRM_Account_Name__r.GE_HQ_New_Account_Country__c 
                                                      from PRM_Channel_Appointment_GE_OG__c where id in :chAppId ]){
                                                          ch.add(chApt);
                                                          if(chApt.PRM_Account_Name__r.GE_HQ_Country_Code__c != null){                                              
                                                              accCountryISO.put(chApt,chApt.PRM_Account_Name__r.GE_HQ_Country_Code__c); 
                                                          }
                                                          if(chApt.PRM_Primary_Bank_Account_Country__c != null){
                                                              primarybankName.add(chApt.PRM_Primary_Bank_Account_Country__c);
                                                          }
                                                      }
        
        for(GE_HQ_Country__c country : [select name,GE_PRM_Adverse_Termination_Risk__c,GE_HQ_ISO_Code__c,GE_PRM_Channel_Risk_Type__c from GE_HQ_Country__c where GE_HQ_ISO_Code__c in :accCountryISO.values()]){
            countryISO.put(country.GE_HQ_ISO_Code__c,country);
        }
        
        for(GE_HQ_Country__c country1 : [select name,GE_PRM_Adverse_Termination_Risk__c,GE_HQ_ISO_Code__c,GE_PRM_Channel_Risk_Type__c from GE_HQ_Country__c where Name in :primarybankName]){
            primaryBankISOCode.put(country1.name,country1.GE_HQ_ISO_Code__c);
        }
        
        try{
            if(ch.size() > 0){
                for (PRM_Channel_Appointment_GE_OG__c chApp : ch){
                    if(chApp.PRM_Mandated_by_end_user_end_customer__c == 'Yes' || chApp.PRM_Any_felony_or_crime__c == 'Yes'|| chApp.PRM_Exclusivity_requested__c == 'Yes' ||
                       chApp.PRM_Officers_Relatives_in_govt_positions__c == 'Yes' || ((primaryBankISOCode.get(chApp.PRM_Primary_Bank_Account_Country__c) != chApp.PRM_Account_Name__r.GE_HQ_Country_Code__c) && chApp.PRM_Primary_Bank_Account_Country__c!= null)){
                           chApp.PRM_Risk_Rating__c = 'High'; 
                           chApp.PRM_Was_Ever_High__c = true;
                       }
                    else if(countryISO.get(chApp.PRM_Account_Name__r.GE_HQ_Country_Code__c).GE_PRM_Channel_Risk_Type__c == 'High'){
                        if(chApp.PRM_Last_Compliance_Approved__c != null){
                            chApp.PRM_Risk_Rating__c = 'Medium';
                        }
                        else{
                            chApp.PRM_Risk_Rating__c = 'High';
                            chApp.PRM_Was_Ever_High__c = true;
                        }
                    }
                    else if(countryISO.get(chApp.PRM_Account_Name__r.GE_HQ_Country_Code__c).GE_PRM_Channel_Risk_Type__c == 'Medium' || countryISO.get(chApp.PRM_Account_Name__r.GE_HQ_Country_Code__c).GE_PRM_Adverse_Termination_Risk__c > 20 || chApp.PRM_Any_use_of_Sub_dealers_or_Sub_Agents__c == 'Yes' || chApp.PRM_Any_Branch_Office_or_Subsidiaries__c == 'Yes'){  
                        chApp.PRM_Risk_Rating__c = 'Medium';
                    }
                    else if(countryISO.get(chApp.PRM_Account_Name__r.GE_HQ_Country_Code__c).GE_PRM_Channel_Risk_Type__c == 'Low'){
                        chApp.PRM_Risk_Rating__c = 'Low';
                    }
                    else{
                        chApp.PRM_Risk_Rating__c = 'Low';
                    }
                }
            }
            update ch;
        }
        
        catch(Exception e){
            system.debug('Exception is: '+e.getMessage());
        }
    }   
    
    public void riskRatingCalculationOnCAUpdate(List<PRM_Channel_Appointment_GE_OG__c> chNew,Map<Id,PRM_Channel_Appointment_GE_OG__c> chMap){
        set<ID> chId = new set<ID>();
        Map<PRM_Channel_Appointment_GE_OG__c,String> accCountryISO = new Map<PRM_Channel_Appointment_GE_OG__c,String>();
        Map<String,GE_HQ_Country__c> countryISO = new Map<String,GE_HQ_Country__c>();
        List<String> primarybankName = new List<String>();
        Map<String,String> primaryBankISOCode = new Map<String,String>();
        List<PRM_Commercial_Line_GE_OG__c> comLineList = new List<PRM_Commercial_Line_GE_OG__c>();
        List<string> country1 = new List<string>();
        List<string> countryName = new List<string>();
        List<string> risk = new List<string>();
        Map<list<string>,list<string>> conMap = new Map<list<string>,list<string>>();
        Map<ID,List<string>> riskVal = new Map<ID,List<string>>();
        List<String> riskRating = new List<String>();
        set<ID> prmChAppID = new set<ID>();
        List<PRM_Channel_Appointment_GE_OG__c> updateList = new List<PRM_Channel_Appointment_GE_OG__c> ();
        Integer i;
        Decimal Orders_Actual;
        Decimal Orders_Target;
        set<ID> prm_chAppID = new set<ID>();
        
        for(PRM_Channel_Appointment_GE_OG__c pr : chNew){   
            if((pr.PRM_Mandated_by_end_user_end_customer__c != chMap.get(pr.Id).PRM_Mandated_by_end_user_end_customer__c) || (pr.PRM_Account_Name__r.GE_HQ_Country_Code__c != chMap.get(pr.id).PRM_Account_Name__r.GE_HQ_Country_Code__c) || (pr.PRM_Last_Compliance_Approved__c != chMap.get(pr.Id).PRM_Last_Compliance_Approved__c) ||
               (pr.PRM_Any_felony_or_crime__c != chMap.get(pr.Id).PRM_Any_felony_or_crime__c) || (pr.PRM_Officers_Relatives_in_govt_positions__c != chMap.get(pr.Id).PRM_Officers_Relatives_in_govt_positions__c) || 
               (pr.PRM_Primary_Bank_Account_Country__c != chMap.get(pr.Id).PRM_Primary_Bank_Account_Country__c) || (pr.PRM_Exclusivity_requested__c != chMap.get(pr.Id).PRM_Exclusivity_requested__c) || (pr.PRM_Any_Branch_Office_or_Subsidiaries__c != chMap.get(pr.Id).PRM_Any_Branch_Office_or_Subsidiaries__c) ||
               (pr.PRM_Any_use_of_Sub_dealers_or_Sub_Agents__c != chMap.get(pr.Id).PRM_Any_use_of_Sub_dealers_or_Sub_Agents__c) || (pr.PRM_Account_Name__c != chMap.get(pr.Id).PRM_Account_Name__c) || (pr.PRM_Exports_outside_own_country__c != chMap.get(pr.Id).PRM_Exports_outside_own_country__c)){
                   chId.add(pr.Id);
               }
        }
        
        List<PRM_Channel_Appointment_GE_OG__c> channelApptList = [select id,PRM_Mandated_by_end_user_end_customer__c,PRM_Any_felony_or_crime__c,PRM_Last_Compliance_Approved__c,
                                                                  PRM_Officers_Relatives_in_govt_positions__c,PRM_Exclusivity_requested__c,PRM_Any_Branch_Office_or_Subsidiaries__c,PRM_Account_Name__r.GE_HQ_Country_Code__c,
                                                                  PRM_Any_use_of_Sub_dealers_or_Sub_Agents__c,CP_Backgound_Orders_Actual_Count__c,CP_Backgound_Target_Count__c,PRM_Primary_Bank_Account_Country__c,PRM_Account_Name__r.GE_HQ_New_Account_Country__c,
                                                                  (select id,PRM_Relationship_Type__c,PRM_Commercial_Line_Type__c,PRM_Channel_Appointment__c,PRM_Status__c,PRM_Channel_Appointment__r.PRM_Risk_Rating__c,PRM_Authorized_Countries_1__c,PRM_Non_Std_Indefinite_Discount_Com__c,PRM_Channel_Appointment__r.PRM_Mandated_by_end_user_end_customer__c,PRM_Channel_Appointment__r.PRM_Any_felony_or_crime__c,PRM_Channel_Appointment__r.PRM_Last_Compliance_Approved__c,
                                                                   PRM_Channel_Appointment__r.PRM_Officers_Relatives_in_govt_positions__c,PRM_Channel_Appointment__r.PRM_Exclusivity_requested__c,PRM_Channel_Appointment__r.PRM_Account_Name__r.GE_HQ_Country_Code__c,
                                                                   PRM_Channel_Appointment__r.PRM_Any_use_of_Sub_dealers_or_Sub_Agents__c,PRM_Channel_Appointment__r.PRM_Any_Branch_Office_or_Subsidiaries__c,PRM_Channel_Appointment__r.PRM_Primary_Bank_Account_Country__c,PRM_Channel_Appointment__r.PRM_Account_Name__r.GE_HQ_New_Account_Country__c,PRM_Channel_Appointment__r.CP_Backgound_Orders_Actual_Count__c,PRM_Channel_Appointment__r.CP_Backgound_Target_Count__c from PRM_Commercial_Lines__r),
                                                                  (select id,createddate,Year__c,Orders_Actual1__c,Orders_Actual2__c,Target__c,Target1__c,PRM_Channel_Appointment__c from Channel_Partners_Background__r order by createddate desc)
                                                                  from PRM_Channel_Appointment_GE_OG__c where id in :chId];
        
        for(PRM_Channel_Appointment_GE_OG__c chApt : channelApptList){
            if(chApt.PRM_Account_Name__r.GE_HQ_Country_Code__c != null){                                              
                accCountryISO.put(chApt,chApt.PRM_Account_Name__r.GE_HQ_Country_Code__c); 
            }
            if(chApt.PRM_Primary_Bank_Account_Country__c != null){
                primarybankName.add(chApt.PRM_Primary_Bank_Account_Country__c);
            }
            for(PRM_Commercial_Line_GE_OG__c ccL : chApt.PRM_Commercial_Lines__r){
                if(ccL.PRM_Status__c != 'Non-Renewed' && ccL.PRM_Status__c != 'Terminated' && ccL.PRM_Status__c != 'Archived' && ccL.PRM_Status__c != 'Rejected' && ccL.PRM_Status__c != 'Abandoned' && ccL.PRM_Commercial_Line_Type__c != 'NRT'){
                    comLineList.add(ccL);
                    if(ccL.PRM_Authorized_Countries_1__c != null){
                        country1.addAll(ccL.PRM_Authorized_Countries_1__c.split(';'));
                    }
                }
            }
            for(PRM_Channel_Partner_Background__c prm_cp : chApt.Channel_Partners_Background__r){
                prm_chAppID.add(prm_cp.PRM_Channel_Appointment__c);
            }
        }
        
        for(GE_HQ_Country__c country : [select name,GE_PRM_Adverse_Termination_Risk__c,GE_HQ_ISO_Code__c,GE_PRM_Channel_Risk_Type__c from GE_HQ_Country__c where GE_HQ_ISO_Code__c in :accCountryISO.values()]){
            countryISO.put(country.GE_HQ_ISO_Code__c,country);
        }
        
        for(GE_HQ_Country__c countries : [select name,GE_PRM_Adverse_Termination_Risk__c,GE_HQ_ISO_Code__c,GE_PRM_Channel_Risk_Type__c from GE_HQ_Country__c where Name in :primarybankName]){
            primaryBankISOCode.put(countries.name,countries.GE_HQ_ISO_Code__c);
        }
        
        for(GE_HQ_Country__c cont : [select GE_PRM_Channel_Risk_Type__c,name from GE_HQ_Country__c where name IN :country1]){
            countryName.add(cont.name);
            risk.add(cont.GE_PRM_Channel_Risk_Type__c);
        }
        conMap.put(countryName,risk);
        
        AggregateResult[] ag = [select Year__c,PRM_Channel_Appointment__c,sum(Orders_Actual2__c) OrdersActualSum,sum(Target1__c) OrdersTargetSum from PRM_Channel_Partner_Background__c
                                where PRM_Channel_Appointment__c in :prm_chAppID group by Year__c,PRM_Channel_Appointment__c];
        
        for(AggregateResult a : ag){
            Orders_Actual = (Decimal)a.get('OrdersActualSum');
            Orders_Target = (Decimal)a.get('OrdersTargetSum');
        }
        
        try{
            for(PRM_Channel_Appointment_GE_OG__c prm_chApp : channelApptList){
                if(prm_chApp.PRM_Any_felony_or_crime__c == 'Yes' || prm_chApp.PRM_Officers_Relatives_in_govt_positions__c == 'Yes' || prm_chApp.PRM_Mandated_by_end_user_end_customer__c == 'Yes' || prm_chApp.PRM_Exclusivity_requested__c == 'Yes' ||
                   ((primaryBankISOCode.get(prm_chApp.PRM_Primary_Bank_Account_Country__c) != prm_chApp.PRM_Account_Name__r.GE_HQ_Country_Code__c) && prm_chApp.PRM_Primary_Bank_Account_Country__c!= null)){
                       riskRating.add('High');
                       riskVal.put(prm_chApp.id, riskRating);   
                       prmChAppID = riskVal.keyset();
                   }
                else if(countryISO.get(prm_chApp.PRM_Account_Name__r.GE_HQ_Country_Code__c).GE_PRM_Channel_Risk_Type__c == 'High' || prm_chApp.CP_Backgound_Orders_Actual_Count__c > 0 || prm_chApp.CP_Backgound_Target_Count__c > 0 || Orders_Actual >= 10000000 || Orders_Target >= 10000000){
                    if(prm_chApp.PRM_Last_Compliance_Approved__c != null){
                        riskRating.add('Medium');
                        riskVal.put(prm_chApp.id, riskRating);
                    }
                    else{
                        riskRating.add('High');
                        riskVal.put(prm_chApp.id, riskRating);
                    }
                    prmChAppID = riskVal.keyset();
                }
                else if((prm_chApp.PRM_Any_use_of_Sub_dealers_or_Sub_Agents__c == 'Yes') || (prm_chApp.PRM_Any_Branch_Office_or_Subsidiaries__c == 'Yes') || (countryISO.get(prm_chApp.PRM_Account_Name__r.GE_HQ_Country_Code__c).GE_PRM_Channel_Risk_Type__c == 'Medium') || countryISO.get(prm_chApp.PRM_Account_Name__r.GE_HQ_Country_Code__c).GE_PRM_Adverse_Termination_Risk__c > 20){
                    riskRating.add('Medium');
                    riskVal.put(prm_chApp.id, riskRating);
                    prmChAppID = riskVal.keyset();
                }
                else if(countryISO.get(prm_chApp.PRM_Account_Name__r.GE_HQ_Country_Code__c).GE_PRM_Channel_Risk_Type__c == 'Low'){
                    riskRating.add('Low');
                    riskVal.put(prm_chApp.id, riskRating);
                    prmChAppID = riskVal.keyset();
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
            CheckRecursion_GE_OG.ChAppt = false;
            update updateList;
        } 
        catch(Exception e){
            system.debug('Exception is: '+e.getMessage());
        }
    }
}