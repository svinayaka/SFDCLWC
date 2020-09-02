public class PRMDueDiligenceHandler_GE_OG {
    public static final String FORM_HTML_START = '<HTML><BODY>';
    public static final String FORM_HTML_END = '</BODY></HTML>';
    
    public void dueDiligenceStatusChangePDFGeneration(List<PRM_Due_Diligence__c> dgNew,Map<ID,PRM_Due_Diligence__c> dgOld){
        String pdfContent = '' + FORM_HTML_START;
        set<ID> chAppId = new set<ID>();
        List<PRM_Due_Diligence__c> ddRec = new List<PRM_Due_Diligence__c>();
        List<PRM_Channel_Appointment_GE_OG__c> prmChApt = new List<PRM_Channel_Appointment_GE_OG__c>();
        
        try{
            pdfContent = '' + FORM_HTML_START;
            
            for(PRM_Due_Diligence__c dgdl : dgNew){
                if(dgdl.PRM_Due_Diligence_Status__c != dgOld.get(dgdl.id).PRM_Due_Diligence_Status__c){
                    if(dgdl.PRM_Due_Diligence_Status__c == 'None' || dgdl.PRM_Due_Diligence_Status__c == 'Yellow Flag' || dgdl.PRM_Due_Diligence_Status__c == 'Orange Flag' || dgdl.PRM_Due_Diligence_Status__c == 'Red Flag')
                        chAppId.add(dgdl.PRM_Channel_Appointment__c);
                    ddRec.add(dgdl);
                }
            }
            
            for(PRM_Channel_Appointment_GE_OG__c prmChApp : [select id,Name,(select Name,PRM_3rd_Party_Report_Received_Date__c,PRM_3rd_Party_Report_Request_Date__c,PRM_3rd_Party_Search_Comments__c,PRM_3rd_Party_Searches__c,PRM_Account_Name__c,PRM_Active__c,PRM_Adverse_flags_in_Legal_Proceedings__c,PRM_Branch_issue_identified__c,
                                                                             PRM_Branch_Validation__c,CA_Commercial_Manager__c,CA_Primary_Sales_Manager__c,PRM_Due_Diligence_Comments__c,PRM_Due_Diligence_Status__c,PRM_Government_link_Comments__c,PRM_Government_Links__c,PRM_Internet_Search__c,PRM_Internet_Search_Comments__c,PRM_Is_Government_Certification_uploaded__c,
                                                                             PRM_KYC_DD_Completed_Date__c,PRM_KYC_Reviewer__c,PRM_Legal_Entity_Address_Validation__c,PRM_Legal_Entity_Name_Validation__c,PRM_Legal_Proceedings_Check__c,PRM_Mobile__c,PRM_Negative_News_Search_Complete_Date__c,PRM_Negative_News_Status__c,PRM_Positive_WatchList_Alerts__c,PRM_Positive_Watchlist_Comments__c,PRM_Channel_Appointment__c,
                                                                             PRM_Sub_agent_Sub_dealer_Validation__c,PRM_Sub_Agent_issue_identified__c,LastModifiedDate,PRM_Submitted_By__c,PRM_Submitted_Date__c,PRM_Subsidiaries_Validation__c,PRM_Subsidiary_issue_identified__c,PRM_Total_100__c,PRM_KYC_Reviewer__r.name,PRM_Submitted_By__r.name from PRM_Due_Diligences__r where PRM_Active__c=true),
                                                             (select id,Name,PRM_Ownership__c,PRM_Red_Flag__c,PRM_Commercial_Mgr_Comments__c,PRM_KYC_Reviewer_Comments__c,PRM_Active__c,PRM_Channel_Appointment__r.PRM_Last_Due_Diligence_Review__c from Share_Holders__r),
                                                             (select Name,PRM_Position__c,PRM_Red_Flag__c,PRM_Commercial_Mgr_Comments__c,PRM_KYC_Reviewer_Comments__c,PRM_Active__c,PRM_Channel_Appointment__r.PRM_Last_Due_Diligence_Review__c from PRM_Officers__r),
                                                             (select PRM_Affiliate_Dependent_Type__c,PRM_Phone__c,PRM_Address_Line_1__c,PRM_Address_Line_2__c,PRM_Email__c,PRM_Mobile__c,PRM_City__c,PRM_City_Of_Registration__c,PRM_Postal_Code__c,PRM_Ownership__c,PRM_Country__c,PRM_Prinicipal_Contact__c,PRM_Authorized_Commercial_Lines__c,PRM_Active__c,PRM_Legal_Name__c,PRM_Channel_Appointment__r.PRM_Last_Due_Diligence_Review__c,PRM_Red_Flag__c,PRM_KYC_Reviewer_Comments__c from Sub_Affiliates__r)
                                                             from PRM_Channel_Appointment_GE_OG__c where id in :chAppId]){
                                                                 prmChApt.add(prmChApp);
                                                                 if(prmChApp.PRM_Due_Diligences__r.size() > 0){
                                                                     for(PRM_Due_Diligence__c dueDilg : prmChApp.PRM_Due_Diligences__r){
                                                                         pdfContent = pdfContent + '<H2><B><U>' + 'Due Diligence Information' + '</U></B></H2>';
                                                                         pdfContent = pdfContent + '<P>' + 'DD Completed Date' + ': ' + '<B>'+dueDilg.LastModifiedDate +'</B>'+'</P>';
                                                                         pdfContent = pdfContent + '<P>' + 'Due Diligence Status' + ': ' + dueDilg.PRM_Due_Diligence_Status__c + '</P>';
                                                                         pdfContent = pdfContent + '<P>' + 'Due Diligence Name' + ': ' + dueDilg.Name + '</P>';
                                                                         pdfContent = pdfContent + '<P>' + 'PRM Channel Appointment' + ': ' + dueDilg.PRM_Channel_Appointment__c + '</P><br/>';
                                                                         pdfContent = pdfContent + '<P>' + '3rd Party Report Received Date' + ': ' + dueDilg.PRM_3rd_Party_Report_Received_Date__c + '</P>';
                                                                         pdfContent = pdfContent + '<P>' + '3rd Party Report Request Date' + ': ' + dueDilg.PRM_3rd_Party_Report_Request_Date__c + '</P>';
                                                                         pdfContent = pdfContent + '<P>' + '3rd Party Search Comments' + ': ' + dueDilg.PRM_3rd_Party_Search_Comments__c + '</P>';
                                                                         pdfContent = pdfContent + '<P>' + '3rd Party Searches' + ': ' + dueDilg.PRM_3rd_Party_Searches__c + '</P>';
                                                                         pdfContent = pdfContent + '<P>' + 'Account Name' + ': ' + dueDilg.PRM_Account_Name__c + '</P>';
                                                                         pdfContent = pdfContent + '<P>' + 'Active' + ': ' + dueDilg.PRM_Active__c + '</P>';
                                                                         pdfContent = pdfContent + '<P>' + 'Adverse flags in Legal Proceedings?' + ': ' + dueDilg.PRM_Adverse_flags_in_Legal_Proceedings__c + '</P>';
                                                                         pdfContent = pdfContent + '<P>' + 'Branch issue identified?' + ': ' + dueDilg.PRM_Branch_issue_identified__c + '</P>';
                                                                         pdfContent = pdfContent + '<P>' + 'Branch Validation' + ': ' + dueDilg.PRM_Branch_Validation__c + '</P>';
                                                                         pdfContent = pdfContent + '<P>' + 'Due Diligence Comments' + ': ' + dueDilg.PRM_Due_Diligence_Comments__c + '</P>';
                                                                         pdfContent = pdfContent + '<P>' + 'Government link Comments' + ': ' + dueDilg.PRM_Government_link_Comments__c + '</P>';
                                                                         pdfContent = pdfContent + '<P>' + 'Government Links' + ': ' + dueDilg.PRM_Government_Links__c + '</P>';
                                                                         pdfContent = pdfContent + '<P>' + 'Internet Search' + ': ' + dueDilg.PRM_Internet_Search__c + '</P>';
                                                                         pdfContent = pdfContent + '<P>' + 'Internet Search Comments' + ': ' + dueDilg.PRM_Internet_Search_Comments__c + '</P>';
                                                                         pdfContent = pdfContent + '<P>' + 'Is Government Certification uploaded?' + ': ' + dueDilg.PRM_Is_Government_Certification_uploaded__c + '</P>';
                                                                         pdfContent = pdfContent + '<P>' + 'KYC DD Completed Date' + ': ' + dueDilg.PRM_KYC_DD_Completed_Date__c + '</P>';
                                                                         pdfContent = pdfContent + '<P>' + 'KYC Reviewer' + ': ' + dueDilg.PRM_KYC_Reviewer__r.name + '</P>';
                                                                         pdfContent = pdfContent + '<P>' + 'Legal Entity Address Validation' + ': ' + dueDilg.PRM_Legal_Entity_Address_Validation__c + '</P>';
                                                                         pdfContent = pdfContent + '<P>' + 'Legal Entity Name Validation' + ': ' + dueDilg.PRM_Legal_Entity_Name_Validation__c + '</P>';
                                                                         pdfContent = pdfContent + '<P>' + 'Legal Proceedings Check' + ': ' + dueDilg.PRM_Legal_Proceedings_Check__c + '</P>';
                                                                         pdfContent = pdfContent + '<P>' + 'Negative News Search Complete Date' + ': ' + dueDilg.PRM_Negative_News_Search_Complete_Date__c + '</P>';
                                                                         pdfContent = pdfContent + '<P>' + 'Negative News Status' + ': ' + dueDilg.PRM_Negative_News_Status__c + '</P>';
                                                                         pdfContent = pdfContent + '<P>' + 'Positive WatchList Alerts' + ': ' + dueDilg.PRM_Positive_WatchList_Alerts__c + '</P>';
                                                                         pdfContent = pdfContent + '<P>' + 'Positive Watchlist Comments' + ': ' + dueDilg.PRM_Positive_Watchlist_Comments__c + '</P>';
                                                                         pdfContent = pdfContent + '<P>' + 'Sub-agent / Sub-dealer Validation' + ': ' + dueDilg.PRM_Sub_agent_Sub_dealer_Validation__c + '</P>';
                                                                         pdfContent = pdfContent + '<P>' + 'Sub-Agent issue identified?' + ': ' + dueDilg.PRM_Sub_Agent_issue_identified__c + '</P>';
                                                                         pdfContent = pdfContent + '<P>' + 'Submitted By' + ': ' + dueDilg.PRM_Submitted_By__r.name + '</P>';
                                                                         pdfContent = pdfContent + '<P>' + 'Submitted Date' + ': ' + dueDilg.PRM_Submitted_Date__c + '</P>';
                                                                         pdfContent = pdfContent + '<P>' + 'Subsidiaries Validation' + ': ' + dueDilg.PRM_Subsidiaries_Validation__c + '</P>';
                                                                         pdfContent = pdfContent + '<P>' + 'Subsidiary issue identified?' + ': ' + dueDilg.PRM_Subsidiary_issue_identified__c + '</P><br/>';
                                                                     }
                                                                 }
                                                                 if(prmChApp.Share_Holders__r.size() > 0){
                                                                     for(PRM_Share_Holder__c shareHolder : prmChApp.Share_Holders__r){
                                                                         pdfContent = pdfContent + '<H2><B><U>' + 'Share Holder Information' + '</U></B></H2>';
                                                                         pdfContent = pdfContent + '<P>' + 'DD Completed Date' + ': ' + '<B>'+shareHolder.PRM_Channel_Appointment__r.PRM_Last_Due_Diligence_Review__c +'</B>'+'</P>';
                                                                         pdfContent = pdfContent + '<P>' + 'Name' + ': ' + shareHolder.Name + '</P>';
                                                                         pdfContent = pdfContent + '<P>' + 'Ownership' + ': ' + shareHolder.PRM_Ownership__c + '</P>';
                                                                         pdfContent = pdfContent + '<P>' + 'Red Flag' + ': ' + shareHolder.PRM_Red_Flag__c + '</P>';
                                                                         pdfContent = pdfContent + '<P>' + 'Commercial Mgr Comments' + ': ' + shareHolder.PRM_Commercial_Mgr_Comments__c + '</P>';
                                                                         pdfContent = pdfContent + '<P>' + 'KYC Reviewer Comments' + ': ' + shareHolder.PRM_KYC_Reviewer_Comments__c + '</P>';
                                                                         pdfContent = pdfContent + '<P>' + 'Active' + ': ' + shareHolder.PRM_Active__c + '</P><br/>';
                                                                     }
                                                                 }
                                                                 if(prmChApp.PRM_Officers__r.size() > 0){
                                                                     for(PRM_Officer__c officer : prmChApp.PRM_Officers__r){
                                                                         pdfContent = pdfContent + '<H2><B><U>' + 'Officer Information' + '</U></B></H2>';
                                                                         pdfContent = pdfContent + '<P>' + 'DD Completed Date' + ': ' + '<B>'+officer.PRM_Channel_Appointment__r.PRM_Last_Due_Diligence_Review__c +'</B>'+'</P>';
                                                                         pdfContent = pdfContent + '<P>' + 'Name' + ': ' + officer.Name + '</P>';
                                                                         pdfContent = pdfContent + '<P>' + 'Position' + ': ' + officer.PRM_Position__c + '</P>';
                                                                         pdfContent = pdfContent + '<P>' + 'Red Flag' + ': ' + officer.PRM_Red_Flag__c + '</P>';
                                                                         pdfContent = pdfContent + '<P>' + 'Commercial Mgr Comments' + ': ' + officer.PRM_Commercial_Mgr_Comments__c + '</P>';
                                                                         pdfContent = pdfContent + '<P>' + 'KYC Reviewer Comments' + ': ' + officer.PRM_KYC_Reviewer_Comments__c + '</P>';
                                                                         pdfContent = pdfContent + '<P>' + 'Active' + ': ' + officer.PRM_Active__c + '</P><br/>';
                                                                     }
                                                                 }
                                                                 if(prmChApp.Sub_Affiliates__r.size() > 0){
                                                                     for(PRM_Sub_Affiliate__c subAffiliate : prmChApp.Sub_Affiliates__r){
                                                                         pdfContent = pdfContent + '<H2><B><U>' + 'Sub-Channel Information' + '</U></B></H2>';
                                                                         pdfContent = pdfContent + '<P>' + 'DD Completed Date' + ': ' + '<B>'+subAffiliate.PRM_Channel_Appointment__r.PRM_Last_Due_Diligence_Review__c +'</B>'+'</P>';
                                                                         pdfContent = pdfContent + '<P>' + 'Legal Name' + ': ' + subAffiliate.PRM_Legal_Name__c + '</P>';
                                                                         pdfContent = pdfContent + '<P>' + 'Sub-Channel Type' + ': ' + subAffiliate.PRM_Affiliate_Dependent_Type__c + '</P>';
                                                                         pdfContent = pdfContent + '<P>' + 'Phone' + ': ' + subAffiliate.PRM_Phone__c + '</P>';
                                                                         pdfContent = pdfContent + '<P>' + 'Address Line 1' + ': ' + subAffiliate.PRM_Address_Line_1__c + '</P>';
                                                                         pdfContent = pdfContent + '<P>' + 'Address Line 2' + ': ' + subAffiliate.PRM_Address_Line_2__c + '</P>';
                                                                         pdfContent = pdfContent + '<P>' + 'Email' + ': ' + subAffiliate.PRM_Email__c + '</P>';
                                                                         pdfContent = pdfContent + '<P>' + 'Mobile' + ': ' + subAffiliate.PRM_Mobile__c + '</P>';
                                                                         pdfContent = pdfContent + '<P>' + 'City' + ': ' + subAffiliate.PRM_City__c + '</P>';
                                                                         pdfContent = pdfContent + '<P>' + 'City of Registration' + ': ' + subAffiliate.PRM_City_Of_Registration__c + '</P>';
                                                                         pdfContent = pdfContent + '<P>' + 'Postal Code' + ': ' + subAffiliate.PRM_Postal_Code__c + '</P>';
                                                                         pdfContent = pdfContent + '<P>' + 'Ownership %' + ': ' + subAffiliate.PRM_Ownership__c + '</P>';
                                                                         pdfContent = pdfContent + '<P>' + 'Country' + ': ' + subAffiliate.PRM_Country__c + '</P>';
                                                                         pdfContent = pdfContent + '<P>' + 'Principal Contact' + ': ' + subAffiliate.PRM_Prinicipal_Contact__c + '</P>';
                                                                         pdfContent = pdfContent + '<P>' + 'Authorized Commercial Lines' + ': ' + subAffiliate.PRM_Authorized_Commercial_Lines__c + '</P>';
                                                                         pdfContent = pdfContent + '<P>' + 'Red Flag?' + ': ' + subAffiliate.PRM_Red_Flag__c + '</P>';
                                                                         pdfContent = pdfContent + '<P>' + 'KYC Reviewer Comments' + ': ' + subAffiliate.PRM_KYC_Reviewer_Comments__c + '</P>';
                                                                         pdfContent = pdfContent + '<P>' + 'Active' + ': ' + subAffiliate.PRM_Active__c + '</P><br/>';
                                                                     }
                                                                 }
                                                             }
            pdfContent = pdfContent + FORM_HTML_END;
        }
        
        catch(Exception e){
            pdfContent = '' + FORM_HTML_START;
            pdfContent = pdfContent + '<P>THERE WAS AN ERROR GENERATING PDF: ' + e.getMessage() + '</P>';
            pdfContent = pdfContent + FORM_HTML_END;
        }
        PRMDueDiligenceHandler_GE_OG.attachPDF(ddRec,pdfContent);
    }
    
    public static void attachPDF(List<PRM_Due_Diligence__c> ddgRec, String pdfContent){
        try{
            for(Integer i=0; i<ddgRec.size();i++){
                Attachment attachmentPDF = new Attachment();
                attachmentPDF.parentId = ddgRec[i].PRM_Channel_Appointment__c;
                attachmentPDF.Name = ddgRec[i].Name +'_' +ddgRec[i].LastModifiedDate+'.pdf';
                attachmentPDF.body = Blob.toPDF(pdfContent); 
                insert attachmentPDF;
            }
        }
        catch(Exception e){
            system.debug('Exception is: '+e.getMessage());
        }
    }
    
    public void populateLastDueDiligenceReview(List<PRM_Due_Diligence__c> ddRec){
        set<ID> chAppId = new set<ID>();
        List<PRM_Channel_Appointment_GE_OG__c> chApt = new List<PRM_Channel_Appointment_GE_OG__c>();
        Date KYCReviewDate;
        Map<ID,Date> chID = new Map<ID,Date>();
        
        for(PRM_Due_Diligence__c ddg : ddRec){
            chAppId.add(ddg.PRM_Channel_Appointment__c); 
        }
        
        for(PRM_Channel_Appointment_GE_OG__c prmChApp : [select id,PRM_Last_Due_Diligence_Review__c, (select name,PRM_KYC_DD_Completed_Date__c,PRM_Channel_Appointment__c,PRM_Active__c,PRM_Channel_Appointment__r.PRM_Last_Due_Diligence_Review__c from PRM_Due_Diligences__r where PRM_Active__c=true order by PRM_KYC_DD_Completed_Date__c desc) from PRM_Channel_Appointment_GE_OG__c where id in :chAppId]){
            for(PRM_Due_Diligence__c dd : prmChApp.PRM_Due_Diligences__r){
                if(dd.PRM_KYC_DD_Completed_Date__c != null && dd.PRM_Active__c == true){
                    KYCReviewDate = dd.PRM_KYC_DD_Completed_Date__c;
                    chID.put(dd.PRM_Channel_Appointment__c,KYCReviewDate);
                }
            }
        }
        
        for(ID prmCh : chID.keyset()){
            PRM_Channel_Appointment_GE_OG__c prm_channel_appointment = new PRM_Channel_Appointment_GE_OG__c();
            prm_channel_appointment.id = prmCh;
            prm_channel_appointment.PRM_Last_Due_Diligence_Review__c = chID.get(prmCh);
            system.debug('Due Diligence review date: '+prm_channel_appointment.PRM_Last_Due_Diligence_Review__c);
            chApt.add(prm_channel_appointment);
        }
        update chApt;
    }
    
    public void emailNotificationOnDDNotStarted(List<PRM_Due_Diligence__c> ddNew,Map<ID,PRM_Due_Diligence__c> ddOld){
        List<ID> assigneeID = new List<ID>();
        List<PRM_Due_Diligence__c> prm_ddg = new List<PRM_Due_Diligence__c>();
        
        for(PRM_Due_Diligence__c dd : ddNew){
            if((dd.PRM_Due_Diligence_Status__c != ddOld.get(dd.id).PRM_Due_Diligence_Status__c) || (dd.PRM_Active__c != ddOld.get(dd.id).PRM_Active__c)){
                if(dd.PRM_Due_Diligence_Status__c == 'Not Started' && dd.PRM_Active__c == true){
                    prm_ddg.add(dd);
                }
            }
        }
        
        List<PermissionSetAssignment> userID = [SELECT AssigneeId FROM PermissionSetAssignment WHERE PermissionSet.Name = 'PRM_KYC_DD_Permission_Set'];
        
        for(PermissionSetAssignment p : userID){
            assigneeID.add(p.AssigneeId);
            system.debug('AssigneeID: '+assigneeID);
        }
        
        EmailTemplate emailTemp = [SELECT id,body,subject,htmlValue FROM EmailTemplate WHERE developerName = 'Due_Diligence_Submission'];
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        
        for(PRM_Due_Diligence__c ddg : prm_ddg){
            Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
            message.setToAddresses(assigneeID);
            message.TargetObjectId= assigneeID[0];
            system.debug('To Address---> '+message.TargetObjectId);
            message.TemplateId = emailTemp.Id;
            system.debug('Email Template---> '+message.TemplateId);
            message.setSaveAsActivity(false);
            message.setCcAddresses(new String[] {ddg.CA_Commercial_Manager__c});
            message.WhatId = ddg.id;
            mails.add(message);     
        }
        Messaging.SendEmailResult[] results = Messaging.sendEmail(mails);
        system.debug('Mail Status: '+results);
    }
    
    public void emailNotificationOnDDInsertNotStarted(List<PRM_Due_Diligence__c> ddNew){
        List<PRM_Due_Diligence__c> prm_ddg = new List<PRM_Due_Diligence__c>();
        List<ID> assigneeID = new List<ID>();
        
        for(PRM_Due_Diligence__c dd : ddNew){
            prm_ddg.add(dd);
        }
        
        List<PermissionSetAssignment> userID = [SELECT AssigneeId FROM PermissionSetAssignment WHERE PermissionSet.Name = 'PRM_KYC_DD_Permission_Set'];
        
        for(PermissionSetAssignment p : userID){
            assigneeID.add(p.AssigneeId);
        }
        
        EmailTemplate emailTemp = [SELECT id,body,subject,htmlValue FROM EmailTemplate WHERE developerName = 'Due_Diligence_Submission'];
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        
        for(PRM_Due_Diligence__c ddg : prm_ddg){
            Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
            message.setToAddresses(assigneeID);
            message.TargetObjectId= assigneeID[0];
            message.TemplateId = emailTemp.Id;
            message.setSaveAsActivity(false);
            message.setCcAddresses(new String[] {ddg.CA_Commercial_Manager__c});
            message.WhatId = ddg.id;
            mails.add(message);     
        }
        Messaging.SendEmailResult[] results = Messaging.sendEmail(mails);
        system.debug('Mail Status: '+results);
    }
}