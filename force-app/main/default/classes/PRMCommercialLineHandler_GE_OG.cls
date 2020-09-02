public class PRMCommercialLineHandler_GE_OG	 {
    public void riskRatingCalculationOnCLInsert(List<PRM_Commercial_Line_GE_OG__c> cL){ 
        List<string> country1 = new List<string>();
        List<string> countryName = new List<string>();
        List<string> risk = new List<string>();
        set<ID> chAppId = new set<ID>();
        Map<list<string>,list<string>> conMap = new Map<list<string>,list<string>>();
        List<String> primarybankName = new List<String>();
        Map<String,String> primaryBankISOCode = new Map<String,String>();
        Map<String,GE_HQ_Country__c> countryISO = new Map<String,GE_HQ_Country__c>();
        Map<PRM_Channel_Appointment_GE_OG__c,String> accCountryISO = new Map<PRM_Channel_Appointment_GE_OG__c,String>();
        Map<ID,List<string>> riskVal = new Map<ID,List<string>>();
        List<String> riskRating = new List<String>();
        set<ID> prmChAppID = new set<ID>();
        List<PRM_Commercial_Line_GE_OG__c> comLineList = new List<PRM_Commercial_Line_GE_OG__c>();
        Integer i;
        Decimal Orders_Actual;
        Decimal Orders_Target;
        set<ID> prm_chAppID = new set<ID>();
        
        for(PRM_Commercial_Line_GE_OG__c comLine : cL){
            chAppId.add(comLine.PRM_Channel_Appointment__c);
        }
        
        for(PRM_Channel_Appointment_GE_OG__c appList : [select PRM_Mandated_by_end_user_end_customer__c,PRM_Any_felony_or_crime__c,PRM_Last_Compliance_Approved__c,
                                                        PRM_Officers_Relatives_in_govt_positions__c,PRM_Exclusivity_requested__c,PRM_Account_Name__r.GE_HQ_Country_Code__c,
                                                        PRM_Any_use_of_Sub_dealers_or_Sub_Agents__c,PRM_Any_Branch_Office_or_Subsidiaries__c,PRM_Primary_Bank_Account_Country__c,PRM_Account_Name__r.GE_HQ_New_Account_Country__c,
                                                        (select id,PRM_Relationship_Type__c,PRM_Commercial_Line_Type__c,PRM_Channel_Appointment__c,PRM_Status__c,PRM_Channel_Appointment__r.PRM_Risk_Rating__c,PRM_Authorized_Countries_1__c,PRM_Non_Std_Indefinite_Discount_Com__c,PRM_Channel_Appointment__r.PRM_Mandated_by_end_user_end_customer__c,PRM_Channel_Appointment__r.PRM_Any_felony_or_crime__c,PRM_Channel_Appointment__r.PRM_Last_Compliance_Approved__c,
                                                         PRM_Channel_Appointment__r.PRM_Officers_Relatives_in_govt_positions__c,PRM_Channel_Appointment__r.PRM_Exclusivity_requested__c,PRM_Channel_Appointment__r.PRM_Account_Name__r.GE_HQ_Country_Code__c,
                                                         PRM_Channel_Appointment__r.PRM_Any_use_of_Sub_dealers_or_Sub_Agents__c,PRM_Channel_Appointment__r.PRM_Any_Branch_Office_or_Subsidiaries__c,PRM_Channel_Appointment__r.PRM_Primary_Bank_Account_Country__c,PRM_Channel_Appointment__r.PRM_Account_Name__r.GE_HQ_New_Account_Country__c,PRM_Channel_Appointment__r.CP_Backgound_Orders_Actual_Count__c,PRM_Channel_Appointment__r.CP_Backgound_Target_Count__c from PRM_Commercial_Lines__r),
                                                        (select id,createddate,Year__c,Orders_Actual1__c,Orders_Actual2__c,Target__c,Target1__c,PRM_Channel_Appointment__c from Channel_Partners_Background__r order by createddate desc)
                                                        from PRM_Channel_Appointment_GE_OG__c where id in :chAppId]){
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
                                                            for(PRM_Channel_Partner_Background__c prm_cp : appList.Channel_Partners_Background__r){
                                                                prm_chAppID.add(prm_cp.PRM_Channel_Appointment__c);
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
            AggregateResult[] ag = [select Year__c,PRM_Channel_Appointment__c,sum(Orders_Actual2__c) OrdersActualSum,sum(Target1__c) OrdersTargetSum from PRM_Channel_Partner_Background__c
                                    where PRM_Channel_Appointment__c in :prm_chAppID group by Year__c,PRM_Channel_Appointment__c];
            
            for(AggregateResult a : ag){
                Orders_Actual = (Decimal)a.get('OrdersActualSum');
                Orders_Target = (Decimal)a.get('OrdersTargetSum');
            }
            
            for(i=0;i<comLineList.size();i++){
                if((comLineList[i].PRM_Relationship_Type__c == 'Sales Representative' && comLineList[i].PRM_Channel_Appointment__r.PRM_Risk_Rating__c == 'Medium') || comLineList[i].PRM_Channel_Appointment__r.PRM_Any_felony_or_crime__c == 'Yes' || comLineList[i].PRM_Channel_Appointment__r.PRM_Exclusivity_requested__c == 'Yes' ||  
                   comLineList[i].PRM_Channel_Appointment__r.PRM_Officers_Relatives_in_govt_positions__c == 'Yes' || comLineList[i].PRM_Channel_Appointment__r.PRM_Mandated_by_end_user_end_customer__c == 'Yes' || ((primaryBankISOCode.get(comLineList[i].PRM_Channel_Appointment__r.PRM_Primary_Bank_Account_Country__c) != comLineList[i].PRM_Channel_Appointment__r.PRM_Account_Name__r.GE_HQ_Country_Code__c) && comLineList[i].PRM_Channel_Appointment__r.PRM_Primary_Bank_Account_Country__c!= null)){
                       riskRating.add('High');
                       riskVal.put(comLineList[i].PRM_Channel_Appointment__c, riskRating);  
                       prmChAppID = riskVal.keyset();
                   }
                else if(conMap != null && conMap.get(countryName).contains('High') || countryISO.get(comLineList[i].PRM_Channel_Appointment__r.PRM_Account_Name__r.GE_HQ_Country_Code__c).GE_PRM_Channel_Risk_Type__c == 'High' || comLineList[i].PRM_Channel_Appointment__r.CP_Backgound_Orders_Actual_Count__c > 0 || comLineList[i].PRM_Channel_Appointment__r.CP_Backgound_Target_Count__c > 0 || Orders_Actual >= 10000000 || Orders_Target >= 10000000){
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
                else if((conMap != null && conMap.get(countryName).contains('Medium')) || (comLineList[i].PRM_Non_Std_Indefinite_Discount_Com__c == 'Non-standard') || (comLineList[i].PRM_Non_Std_Indefinite_Discount_Com__c == 'Indefinite') || (comLineList[i].PRM_Channel_Appointment__r.PRM_Any_use_of_Sub_dealers_or_Sub_Agents__c == 'Yes') || (comLineList[i].PRM_Channel_Appointment__r.PRM_Any_Branch_Office_or_Subsidiaries__c == 'Yes') || (countryISO.get(comLineList[i].PRM_Channel_Appointment__r.PRM_Account_Name__r.GE_HQ_Country_Code__c).GE_PRM_Channel_Risk_Type__c == 'Medium' || countryISO.get(comLineList[i].PRM_Channel_Appointment__r.PRM_Account_Name__r.GE_HQ_Country_Code__c).GE_PRM_Adverse_Termination_Risk__c > 20)){
                    riskRating.add('Medium');
                    riskVal.put(comLineList[i].PRM_Channel_Appointment__c, riskRating);
                    prmChAppID = riskVal.keyset();
                }
                else if(conMap != null && conMap.get(countryName).contains('Low') || countryISO.get(comLineList[i].PRM_Channel_Appointment__r.PRM_Account_Name__r.GE_HQ_Country_Code__c).GE_PRM_Channel_Risk_Type__c == 'Low'){
                    riskRating.add('Low');
                    riskVal.put(comLineList[i].PRM_Channel_Appointment__c, riskRating);
                    prmChAppID = riskVal.keyset();
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
        catch(Exception e){
            system.debug('Exception is: '+e.getMessage());
        }
    }
    
    public void riskRatingCalculationOnCLUpdate(List<PRM_Commercial_Line_GE_OG__c> chNew, Map<Id,PRM_Commercial_Line_GE_OG__c> chOld){
        set<ID> clID = new set<ID>();
        List<PRM_Commercial_Line_GE_OG__c> comLineList = new List<PRM_Commercial_Line_GE_OG__c>();
        List<string> country1 = new List<string>();
        List<string> countryName = new List<string>();
        List<string> risk = new List<string>();
        Map<list<string>,list<string>> conMap = new Map<list<string>,list<string>>();
        set<ID> prmChAppID = new set<ID>();
        List<String> primarybankName = new List<String>();
        Map<String,String> primaryBankISOCode = new Map<String,String>();
        Map<String,GE_HQ_Country__c> countryISO = new Map<String,GE_HQ_Country__c>();
        Map<PRM_Channel_Appointment_GE_OG__c,String> accCountryISO = new Map<PRM_Channel_Appointment_GE_OG__c,String>();
        Map<ID,List<string>> riskVal = new Map<ID,List<string>>();
        List<String> riskRating = new List<String>();
        List<PRM_Channel_Appointment_GE_OG__c> updateList = new List<PRM_Channel_Appointment_GE_OG__c> (); 
        Integer i;
        Decimal Orders_Actual;
        Decimal Orders_Target;
        set<ID> prm_chAppID = new set<ID>();
        
        for(PRM_Commercial_Line_GE_OG__c prmCL : chNew){
            if((prmCL.PRM_Relationship_Type__c != chOld.get(prmCl.id).PRM_Relationship_Type__c) || (prmCL.PRM_Channel_Appointment__r.PRM_Risk_Rating__c != chOld.get(prmCL.id).PRM_Channel_Appointment__r.PRM_Risk_Rating__c) || prmCL.PRM_Status__c != chOld.get(prmCL.id).PRM_Status__c || prmCL.PRM_Commercial_Line_Type__c != chOld.get(prmCL.id).PRM_Commercial_Line_Type__c ||
               (prmCL.PRM_Non_Std_Indefinite_Discount_Com__c != chOld.get(prmCL.id).PRM_Non_Std_Indefinite_Discount_Com__c) || (prmCL.PRM_Authorized_Countries_1__c != chOld.get(prmCL.id).PRM_Authorized_Countries_1__c)){
                   clID.add(prmCL.PRM_Channel_Appointment__c);
               }
        }
        
        for(PRM_Channel_Appointment_GE_OG__c appList : [select PRM_Mandated_by_end_user_end_customer__c,PRM_Any_felony_or_crime__c,PRM_Last_Compliance_Approved__c,
                                                        PRM_Officers_Relatives_in_govt_positions__c,PRM_Exclusivity_requested__c,PRM_Account_Name__r.GE_HQ_Country_Code__c,
                                                        PRM_Any_use_of_Sub_dealers_or_Sub_Agents__c,PRM_Any_Branch_Office_or_Subsidiaries__c,PRM_Primary_Bank_Account_Country__c,PRM_Account_Name__r.GE_HQ_New_Account_Country__c,
                                                        (select id,PRM_Relationship_Type__c,PRM_Commercial_Line_Type__c,PRM_Channel_Appointment__c,PRM_Status__c,PRM_Channel_Appointment__r.PRM_Risk_Rating__c,PRM_Authorized_Countries_1__c,PRM_Non_Std_Indefinite_Discount_Com__c,PRM_Channel_Appointment__r.PRM_Mandated_by_end_user_end_customer__c,PRM_Channel_Appointment__r.PRM_Any_felony_or_crime__c,PRM_Channel_Appointment__r.PRM_Last_Compliance_Approved__c,
                                                         PRM_Channel_Appointment__r.PRM_Officers_Relatives_in_govt_positions__c,PRM_Channel_Appointment__r.PRM_Exclusivity_requested__c,PRM_Channel_Appointment__r.PRM_Account_Name__r.GE_HQ_Country_Code__c,
                                                         PRM_Channel_Appointment__r.PRM_Any_use_of_Sub_dealers_or_Sub_Agents__c,PRM_Channel_Appointment__r.PRM_Any_Branch_Office_or_Subsidiaries__c,PRM_Channel_Appointment__r.PRM_Primary_Bank_Account_Country__c,PRM_Channel_Appointment__r.PRM_Account_Name__r.GE_HQ_New_Account_Country__c,PRM_Channel_Appointment__r.CP_Backgound_Orders_Actual_Count__c,PRM_Channel_Appointment__r.CP_Backgound_Target_Count__c from PRM_Commercial_Lines__r),
                                                        (select id,createddate,Year__c,Orders_Actual1__c,Orders_Actual2__c,Target__c,Target1__c,PRM_Channel_Appointment__c from Channel_Partners_Background__r order by createddate desc)
                                                        from PRM_Channel_Appointment_GE_OG__c where id in :clID]){
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
                                                            for(PRM_Channel_Partner_Background__c prm_cp : appList.Channel_Partners_Background__r){
                                                                prm_chAppID.add(prm_cp.PRM_Channel_Appointment__c);
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
            for(i=0;i<comLineList.size();i++){
                if((comLineList[i].PRM_Relationship_Type__c == 'Sales Representative' && comLineList[i].PRM_Channel_Appointment__r.PRM_Risk_Rating__c == 'Medium') || comLineList[i].PRM_Channel_Appointment__r.PRM_Any_felony_or_crime__c == 'Yes' || comLineList[i].PRM_Channel_Appointment__r.PRM_Exclusivity_requested__c == 'Yes' ||  
                   comLineList[i].PRM_Channel_Appointment__r.PRM_Officers_Relatives_in_govt_positions__c == 'Yes' || comLineList[i].PRM_Channel_Appointment__r.PRM_Mandated_by_end_user_end_customer__c == 'Yes' || ((primaryBankISOCode.get(comLineList[i].PRM_Channel_Appointment__r.PRM_Primary_Bank_Account_Country__c) != comLineList[i].PRM_Channel_Appointment__r.PRM_Account_Name__r.GE_HQ_Country_Code__c) && comLineList[i].PRM_Channel_Appointment__r.PRM_Primary_Bank_Account_Country__c!= null)){
                       riskRating.add('High');
                       riskVal.put(comLineList[i].PRM_Channel_Appointment__c, riskRating);   
                       prmChAppID = riskVal.keyset();
                   }
                else if(conMap != null && conMap.get(countryName).contains('High') || countryISO.get(comLineList[i].PRM_Channel_Appointment__r.PRM_Account_Name__r.GE_HQ_Country_Code__c).GE_PRM_Channel_Risk_Type__c == 'High' || comLineList[i].PRM_Channel_Appointment__r.CP_Backgound_Orders_Actual_Count__c > 0 || comLineList[i].PRM_Channel_Appointment__r.CP_Backgound_Target_Count__c > 0 || Orders_Actual >= 10000000 || Orders_Target >= 10000000){
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
                else if((conMap != null && conMap.get(countryName).contains('Medium')) || (comLineList[i].PRM_Non_Std_Indefinite_Discount_Com__c == 'Non-standard') || (comLineList[i].PRM_Non_Std_Indefinite_Discount_Com__c == 'Indefinite') || (comLineList[i].PRM_Channel_Appointment__r.PRM_Any_use_of_Sub_dealers_or_Sub_Agents__c == 'Yes') || (comLineList[i].PRM_Channel_Appointment__r.PRM_Any_Branch_Office_or_Subsidiaries__c == 'Yes') || (countryISO.get(comLineList[i].PRM_Channel_Appointment__r.PRM_Account_Name__r.GE_HQ_Country_Code__c).GE_PRM_Channel_Risk_Type__c == 'Medium' || countryISO.get(comLineList[i].PRM_Channel_Appointment__r.PRM_Account_Name__r.GE_HQ_Country_Code__c).GE_PRM_Adverse_Termination_Risk__c > 20)){
                    riskRating.add('Medium');
                    riskVal.put(comLineList[i].PRM_Channel_Appointment__c, riskRating);
                    prmChAppID = riskVal.keyset();
                }
                else if(conMap != null && conMap.get(countryName).contains('Low') || countryISO.get(comLineList[i].PRM_Channel_Appointment__r.PRM_Account_Name__r.GE_HQ_Country_Code__c).GE_PRM_Channel_Risk_Type__c == 'Low'){
                    riskRating.add('Low');
                    riskVal.put(comLineList[i].PRM_Channel_Appointment__c, riskRating);
                    prmChAppID = riskVal.keyset();
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
            CheckRecursion_GE_OG.comLine = false;
            update updateList;
        }
        catch(Exception e){
            system.debug('Exception is: '+e.getMessage());
        }
    }
    
    public void SyncFieldsfromCommLinesOnInsert(List<PRM_Commercial_Line_GE_OG__c> comLine){
        set<string> countries = new set<string>();
        set<ID> chAppID = new set<ID>();
        
        for(PRM_Commercial_Line_GE_OG__c prmComL : comLine){
            chAppID.add(prmComL.PRM_Channel_Appointment__c);
        }
        List<PRM_Channel_Appointment_GE_OG__c> chAppList  = [select id,PRM_Country__c,PRM_Exports_outside_own_country__c, (select id,PRM_Authorized_Countries_1__c,PRM_Channel_Appointment__r.PRM_Country__c from PRM_Commercial_Lines__r) from PRM_Channel_Appointment_GE_OG__c where id in :chAppID];
        for(PRM_Channel_Appointment_GE_OG__c prmChApp : chAppList){
            for(PRM_Commercial_Line_GE_OG__c cL : prmChApp.PRM_Commercial_Lines__r){
                if(cL.PRM_Authorized_Countries_1__c != null){
                    countries.addAll(cL.PRM_Authorized_Countries_1__c.split(';'));
                }
                countries.remove(cL.PRM_Channel_Appointment__r.PRM_Country__c);
                if(countries.size() > 0){
                    prmChApp.PRM_Exports_outside_own_country__c = 'Yes';
                }else if(countries.size() == 0){
                    prmChApp.PRM_Exports_outside_own_country__c = 'No';
                }
            }
        }
        update chAppList;
    }
    
    public void SyncFieldsfromCommLinesOnUpdate(List<PRM_Commercial_Line_GE_OG__c> comLine,Map<Id,PRM_Commercial_Line_GE_OG__c> comLineOld){
        set<ID> chAppID = new set<ID>();
        set<string> countries = new set<string>();
        for(PRM_Commercial_Line_GE_OG__c prmComL : comLine){
            if(prmComL.PRM_Authorized_Countries_1__c != comLineOld.get(prmComL.id).PRM_Authorized_Countries_1__c){
                chAppID.add(prmComL.PRM_Channel_Appointment__c);
            }
        }
        
        List<PRM_Channel_Appointment_GE_OG__c> chAppList  = [select id,PRM_Country__c,PRM_Exports_outside_own_country__c, (select id,PRM_Authorized_Countries_1__c,PRM_Channel_Appointment__r.PRM_Country__c from PRM_Commercial_Lines__r) from PRM_Channel_Appointment_GE_OG__c where id in :chAppID];
        for(PRM_Channel_Appointment_GE_OG__c prmChApp : chAppList){
            for(PRM_Commercial_Line_GE_OG__c cL : prmChApp.PRM_Commercial_Lines__r){
                if(cL.PRM_Authorized_Countries_1__c != null){
                    countries.addAll(cL.PRM_Authorized_Countries_1__c.split(';'));
                }
                countries.remove(cL.PRM_Channel_Appointment__r.PRM_Country__c);
                if(countries.size() > 0){
                    prmChApp.PRM_Exports_outside_own_country__c = 'Yes';
                }
                else if(countries.size() == 0){
                    prmChApp.PRM_Exports_outside_own_country__c = 'No';
                }
            }
        }
        CheckRecursion_GE_OG.comLine = false;
        update chAppList;
    }
    
    public void CLSalesRepCountInsert(List<PRM_Commercial_Line_GE_OG__c> clNew){
        set<ID> chAppId = new set<ID>();
        Map<ID,PRM_Channel_Appointment_GE_OG__c> chAppList = new Map<ID,PRM_Channel_Appointment_GE_OG__c>();
        
        for(PRM_Commercial_Line_GE_OG__c prm_CL : clNew){
            chAppId.add(prm_CL.PRM_Channel_Appointment__c);
        }
        
        List<PRM_Channel_Appointment_GE_OG__c> prm_chAppt = [select id,PRM_Count_CL_SalesRep__c, (select PRM_Channel_Appointment__c,PRM_Relationship_Type__c,PRM_Status__c,PRM_Commercial_Line_Type__c from PRM_Commercial_Lines__r 
                                                                                                  where PRM_Status__c not in ('Non-Renewed','Terminated','Archived','Rejected','Abandoned') and PRM_Relationship_Type__c='Sales Representative' and PRM_Commercial_Line_Type__c != 'NRT') from PRM_Channel_Appointment_GE_OG__c where id in :chAppId];
        for(PRM_Channel_Appointment_GE_OG__c prmCh : prm_chAppt){
            List<PRM_Commercial_Line_GE_OG__c> clCount = prmCh.PRM_Commercial_Lines__r;
            prmCh.PRM_Count_CL_SalesRep__c = clCount.size();
            chAppList.put(prmCh.id,prmCh);
        }
        update chAppList.values();
    }
    
    public void CLSalesRepCountUpdate(List<PRM_Commercial_Line_GE_OG__c> clNew,Map<ID,PRM_Commercial_Line_GE_OG__c> clOld){
        set<ID> chAppId = new set<ID>();
        Map<ID,PRM_Channel_Appointment_GE_OG__c> chAppList = new Map<ID,PRM_Channel_Appointment_GE_OG__c>();
        
        for(PRM_Commercial_Line_GE_OG__c prm_CL : clNew){
            if(prm_CL.PRM_Status__c != clOld.get(prm_CL.id).PRM_Status__c || prm_CL.PRM_Commercial_Line_Type__c != clOld.get(prm_CL.id).PRM_Commercial_Line_Type__c || prm_CL.PRM_Relationship_Type__c != clOld.get(prm_CL.id).PRM_Relationship_Type__c || ((prm_CL.PRM_Dummy_Update__c != clOld.get(prm_CL.id).PRM_Dummy_Update__c) && prm_CL.PRM_Dummy_Update__c == true)){
                chAppId.add(prm_CL.PRM_Channel_Appointment__c);
            }
        }
        
        List<PRM_Channel_Appointment_GE_OG__c> prm_chAppt = [select id,PRM_Count_CL_SalesRep__c, (select PRM_Channel_Appointment__c,PRM_Dummy_Update__c,PRM_Relationship_Type__c,PRM_Status__c,PRM_Commercial_Line_Type__c from PRM_Commercial_Lines__r 
                                                                                                  where PRM_Status__c not in ('Non-Renewed','Terminated','Archived','Rejected','Abandoned') and PRM_Relationship_Type__c='Sales Representative' and PRM_Commercial_Line_Type__c != 'NRT') from PRM_Channel_Appointment_GE_OG__c where id in :chAppId];
        for(PRM_Channel_Appointment_GE_OG__c prmCh : prm_chAppt){
            List<PRM_Commercial_Line_GE_OG__c> clCount = prmCh.PRM_Commercial_Lines__r;
            prmCh.PRM_Count_CL_SalesRep__c = clCount.size();
            chAppList.put(prmCh.id,prmCh);
        }
        //CheckRecursion_GE_OG.comLine = false;
        update chAppList.values();
    }
    
    public static void  handleBeforeUpdate(List<PRM_Commercial_Line_GE_OG__c> newComm,Map<Id,PRM_Commercial_Line_GE_OG__c> oldCommMap)
    { 
        for(PRM_Commercial_Line_GE_OG__c com : newComm)
        {
            if(com.PRM_Commercial_Line_Type__c == 'Amend')
            {  system.debug('Here'); 
             
             if(oldCommMap.get(com.Id).PRM_Authorized_Countries_1__c == null || oldCommMap.get(com.Id).PRM_Authorized_Countries_1__c =='' || oldCommMap.get(com.Id).PRM_Non_Std_Indefinite_Discount_Com__c == null || oldCommMap.get(com.Id).PRM_Non_Std_Indefinite_Discount_Com__c =='')
             {
                 if(com.PRM_Authorized_Countries_1__c!=null||com.PRM_Authorized_Countries_1__c!='')
                 {
                     com.Ammend_Needs_Compliance__c = true;
                 }
                 if(com.PRM_Non_Std_Indefinite_Discount_Com__c!=null ||com.PRM_Non_Std_Indefinite_Discount_Com__c!='')
                 {
                     com.Ammend_Needs_Compliance__c = true;
                 }
             }
             if(oldCommMap.get(com.Id).PRM_Authorized_Countries_1__c != null || oldCommMap.get(com.Id).PRM_Authorized_Countries_1__c !='' || oldCommMap.get(com.Id).PRM_Non_Std_Indefinite_Discount_Com__c != null || oldCommMap.get(com.Id).PRM_Non_Std_Indefinite_Discount_Com__c !='' )
             {
                 if(com.PRM_Authorized_Countries_1__c != oldCommMap.get(com.Id).PRM_Authorized_Countries_1__c || com.PRM_Non_Std_Indefinite_Discount_Com__c != oldCommMap.get(com.Id).PRM_Non_Std_Indefinite_Discount_Com__c)
                 {
                     com.Ammend_Needs_Compliance__c = true;
                 }
             }
             
            }
        }
    }
}