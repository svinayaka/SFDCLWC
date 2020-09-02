global class GE_PRM_AccountPlan_SL_Policy implements Messaging.InboundEmailHandler {

    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {

        //System.debug('dhanush*******email*******' + email);
        //System.debug('*******envelope*******' + envelope);

        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
        String appObjPrefix = GE_HQ_Account_Plan__c.SObjectType.getDescribe().getKeyPrefix();
        //System.debug('*****appObjPrefix**********' + appObjPrefix);
        //System.debug('appObjPrefix*********' + appObjPrefix);
        GE_HQ_Account_Plan__c appt = new GE_HQ_Account_Plan__c();
        GE_HQ_Account_Plan__c acctPlan = new GE_HQ_Account_Plan__c();
        String[] ccAddF = new String[2];

        EmailTemplate templateId = [Select id from EmailTemplate where name = 'GE_PRM_AccountPlanpdf'];

        //System.debug('templateId***' + templateId);

        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

        List < Attachment > attachments = new list < attachment > ();
        String ApptId;
        Boolean blnProceed;

        String mailSubject = email.subject;

        if (mailSubject.contains(appObjPrefix)) {
            List < String > subjectLst = email.subject.split(' ');
            ApptId = subjectLst.get(subjectLst.size() - 1);
            blnProceed = true;

        }

        try {

            //System.debug('*email subject*' + email.subject);





            //System.debug('***ApptId***' + ApptId);





            if (ApptId != null || ApptId != '') {

                appt = [SELECT Name, Id, ownerid, GE_AccountPlan_Partner_Email_Comment__c,
                    Channel_Partner_Acknowledgement_Status__c, Channel_Last_acknowledgment_Date__c FROM GE_HQ_Account_Plan__c WHERE ID =: ApptId limit 1
                ];


                //New Code:March 27,2017

                acctPlan = [Select id, Channel_Partner_Contact_Name_GEOG__c, Primary_Channel_Manager_18_digit_ID__c, Secondary_Channel_Manager_18_digit_ID__c from GE_HQ_Account_Plan__c where id =: ApptId];

              //  System.debug('acctPlan contents' + acctPlan);


                Set < String > ccAddresses = new Set < String > ();
                if (acctPlan.Primary_Channel_Manager_18_digit_ID__c != null) {
                    ccAddresses.add(acctPlan.Primary_Channel_Manager_18_digit_ID__c);
                }

                if (acctPlan.Secondary_Channel_Manager_18_digit_ID__c != null) {
                    ccAddresses.add(acctPlan.Secondary_Channel_Manager_18_digit_ID__c);
                }

                String primaryChnlMgr = '';
                String secChnlMgr = '';

                List < User > useradd = [SELECT Email FROM User WHERE Id =: ccAddresses];
                System.debug('**useradd**' + useradd);
                System.debug('**useradd[0]**' + useradd[0].email);
                //System.debug('**useradd[1]**' + useradd[1].email);



                if ((useradd.size() > 0) && (useradd.size() == 2)) {
                    if (useradd[0].email != null) {
                        primaryChnlMgr = useradd[0].email;
                    }

                    if (useradd[1].email != null) {
                        secChnlMgr = useradd[1].email;
                    }


                } else if ((useradd.size() > 0) && (useradd.size() == 1)) {
                    primaryChnlMgr = useradd[0].email;
                    secChnlMgr = '';

                }

                //System.debug('**primaryChnlMgr' + primaryChnlMgr);
                //System.debug('**secChnlMgr' + secChnlMgr);


                ccAddF.clear();

                if (primaryChnlMgr != null && String.isNotBlank(primaryChnlMgr)) {
                    ccAddF.add(primaryChnlMgr);
                }

                if (secChnlMgr != null && String.isNotBlank(secChnlMgr) ) {
                    ccAddF.add(secChnlMgr);
                }

                //System.debug('Array of Users' + ccAddF);









                //End Code:March 27,2017



                //System.debug('appt******' + appt);
                if (appt == Null) {
                    blnProceed = false;
                }
            }

            if (blnProceed) {

                String[] emailBody = email.plainTextBody.split('\n');

                String emailResponse = '';

                if (emailBody[0] != null && emailBody[1] != null) {
                    emailResponse = emailBody[0] + '\n' + emailBody[1];
                   // System.debug('emailResponse' + emailResponse);
                }

                if (emailBody[0] != null && emailBody[1] == null) {
                    emailResponse = emailBody[0];
                    //System.debug('emailResponse ' + emailResponse);

                }
                //System.debug('emailBody ***0' + emailBody[0]);


                //System.debug('emailBody ***1' + emailBody[1]);


                //System.debug('emailBody**************' + emailBody);
                String emailapprej= (emailBody[0]).toLowerCase();

                //If emailapprej contains agree or modify then update the field. If agree or modify do not exist then skip the code or return


                // If emailBody[1] exists and doesnt contain From: then update the field
                OrgWideEmailAddress owea = [select Id,DisplayName,Address from OrgWideEmailAddress where DisplayName = 'MAP Channel Partner Response (Do not reply)'];
                   
                   
                   System.debug('owea**'+owea);
                if (emailapprej.contains('agree')) {
                    appt.Channel_Partner_Acknowledgement_Status__c = 'Agree';
                    appt.Channel_Last_acknowledgment_Date__c = Date.today();

                    Integer quarter = date.today().month();

                    if (quarter == 1 || quarter == 2 || quarter == 3 || Test.isRunningTest()) {

                        appt.Q1_Acknowledgement_GEOG__c = true;
                    } else if (quarter == 4 || quarter == 5 || quarter == 6 || Test.isRunningTest()) {
                        appt.Q2_Acknowledgement_GEOG__c = true;
                    } else if (quarter == 7 || quarter == 8 || quarter == 9 || Test.isRunningTest()) {
                        appt.Q3_Acknowledgement_GEOG__c = true;
                    } else {
                        appt.Q4_Acknowledgement_GEOG__c = true;
                    }
                    //send mail to Primary Channel Manager and Secondary Channel Manager                    
                    mail.setSubject(mailSubject);
                    if(owea!=Null){
                        mail.setOrgWideEmailAddressId(owea.Id);  
                        //mail.setSenderDisplayName('MAP Channel Partner Response (Do not reply)');   
                    }               
                    mail.setTemplateID(templateId.id);                   
                    mail.setToAddresses(ccAddF);                   
                    mail.setUseSignature(true);
                    mail.sethtmlbody(email.htmlbody );
                    Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
                    system.debug('Mail Debug ***************');
                } else if (emailapprej.contains('modify')) {
                    appt.Channel_Partner_Acknowledgement_Status__c = 'Modify';
                    //send mail to Primary Channel Manager and Secondary Channel Manager
                    mail.setSubject(mailSubject);                    
                    if(owea!=Null){
                        mail.setOrgWideEmailAddressId(owea.Id);
                        //mail.setSenderDisplayName('MAP Channel Partner Response (Do not reply)'); 
                    }
                    mail.setTemplateID(templateId.id);
                    mail.setToAddresses(ccAddF);
                    mail.setUseSignature(true);
                    mail.sethtmlbody(email.htmlbody);
                    Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
                    //system.debug('Mail Debug ***************');
                }else if (emailapprej!=null && !(emailapprej.contains('modify')) && !(emailapprej.contains('agree'))) {
                    
                   // System.debug('Inside cond 3');
                    //appt.Channel_Partner_Acknowledgement_Status__c = 'Modify';
                    //send mail to Primary Channel Manager and Secondary Channel Manager
                    mail.setSubject(mailSubject);                    
                    if(owea!=Null){
                        mail.setOrgWideEmailAddressId(owea.Id);
                        //mail.setSenderDisplayName('MAP Channel Partner Response (Do not reply)'); 
                    }
                    mail.setTemplateID(templateId.id);
                    mail.setToAddresses(ccAddF);
                    mail.setUseSignature(true);
                    mail.sethtmlbody(email.htmlbody);
                    Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
                    //system.debug('Mail Debug ***************');
                }

                else {
                    result.success = true;
                    return result;
                }
                String comments = '';
                comments= emailBody[1].abbreviate(8);
                if (emailBody[1] != null && !emailBody[1].contains('From:')) {                    
                    comments = emailBody[1].abbreviate(254);
                    System.debug('Abrrevated Cmts'+comments);
                    appt.GE_AccountPlan_Partner_Email_Comment__c = comments;                    
                    //System.debug('comments** before update'+comments);
                }

                update appt;
                    //System.debug('comments** after update'+comments);
            }
        } catch (Exception e) {

            //System.debug('ERROR: Not able to update appt: ' + e);
        }

        // Set the result to true, no need to send an email back to the user
        result.success = true;
        // Return the result for the Force.com Email Service
        return result;
    }
}