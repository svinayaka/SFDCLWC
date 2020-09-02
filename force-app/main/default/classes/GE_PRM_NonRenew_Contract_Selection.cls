/*

Created By : Shanu Aggarwal
Release: 15.7
*/


Public without sharing Class GE_PRM_NonRenew_Contract_Selection {
    public List < ExecutedContracts > ExecutedAddendumContracts;
    public List < ChannelAppointments > lstAppointments;
    public ID AccID {
        get;
        set;
    }
    public List < Id > selectedContracts = new List < Id > ();
    public list < contract > lstUpdateContract = new list < contract > ();
    public Pagereference newChAppurl {
        get;
        set;
    }
    public boolean displayAppointments {
        get;
        set;
    }
    public boolean displayContracts {
        get;
        set;
    }
    List < Contract > lstMasterContracts = new List < Contract > ();
    List < Contract > lstAddendumContracts = new List < Contract > ();
    //  public id cid{get;set;}
    public boolean notExecutedContract;
    String contractRecordTypeMasterId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Channel Master Agreement').getRecordTypeId();
    String contractRecordTypeAddenId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Channel Addendum Agreement').getRecordTypeId();
    Public Account acct {
        get;
        set;
    }

    public GE_PRM_NonRenew_Contract_Selection() {
        notExecutedContract = false;
        accID = ApexPages.currentPage().getParameters().get('Accid');
        if (accID != Null) {
            acct = [Select Name, GE_HQ_DUNS_Number__c From Account Where ID =: accID];
        }

        //Getting Addendum Executed Contracts for one Master
        ExecutedAddendumContracts = new List < ExecutedContracts > ();
        ExecutedContracts objExecContract;

        lstMasterContracts = [SELECT id, GE_PRM_Contract_Draft_date__c,GE_PRM_GE_Confirmed_Date__c, GE_PRM_E_signature_okay__c, 
                               StartDate, GE_PRM_Original_Source_System__c, EndDate, GE_PRM_Channel_Appointment_ID__c, Account.id,
                               GE_PRM_Tier_2__c, GE_PRM_Primary_Sales_Channel_Manager__c
                               from contract where accountid =: accid AND recordtypeid =: contractRecordTypeMasterId
            AND status = 'Executed'
            AND recordtypeid =: contractRecordTypeMasterId
        ];

        lstAddendumContracts = [SELECT GE_PRM_Relationship_Type__c, id, name, ContractNumber, StartDate, GE_PRM_Tier_5__c, GE_PRM_Tier_2__c,
            GE_PRM_Tier_3__c, GE_PRM_Tier_4__c, Status, GE_OG_Contract_End_Date__c,GE_PRM_Channel_Appointment_ID__c,GE_PRM_Channel_Appointment_ID__r.Name,
            GE_PRM_Master_Agreement__c,GE_PRM_Master_Agreement__r.ContractNumber FROM contract
            WHERE recordtypeid =: contractRecordTypeAddenId AND accountid =: accID
            and GE_PRM_Master_Agreement__c IN: lstMasterContracts
        ];


        for (Contract objContract: lstAddendumContracts) {
            If(objContract.status == 'Executed') {
                objExecContract = new ExecutedContracts();
                objExecContract.ContractID = objContract.id;
                objExecContract.ContractName = objContract.name;
                objExecContract.ContractNumber = objContract.ContractNumber;
                objExecContract.GE_PRM_Tier_2 = objContract.GE_PRM_Tier_2__c;
                objExecContract.GE_PRM_Tier_3 = objContract.GE_PRM_Tier_3__c;
                objExecContract.GE_PRM_Tier_4 = objContract.GE_PRM_Tier_4__c;
                objExecContract.GE_PRM_Tier_5 = objContract.GE_PRM_Tier_5__c;
                objExecContract.Status = objContract.Status;
                objExecContract.GE_PRM_Master_agreement_ID = objContract.GE_PRM_Master_Agreement__r.ContractNumber;
                objExecContract.GE_PRM_Channel_Appointment_ID =objContract.GE_PRM_Channel_Appointment_ID__r.Name;
                objExecContract.GE_PRM_Relationship_Type = objContract.GE_PRM_Relationship_Type__c;
 
                If(objContract.GE_OG_Contract_End_Date__c != null) {
                    objExecContract.EndDate = objContract.GE_OG_Contract_End_Date__c.month() + '/' + objContract.GE_OG_Contract_End_Date__c.day() + '/' + objContract.GE_OG_Contract_End_Date__c.year();
                }
                If(objContract.StartDate != null) {
                    objExecContract.StartDate = objContract.StartDate.day() + '/' + objContract.StartDate.month() + '/' + objContract.StartDate.year();
                }
                objExecContract.isSelected = false;

                ExecutedAddendumContracts.add(objExecContract);
            }
            else if (objContract.status != 'Executed') {
                notExecutedContract = true;
            }
        }
         system.debug('&&&&&&&&&&&&&&&&&&&&'+ExecutedAddendumContracts);


        //Getting Approved Channel Appointments   
        lstAppointments = new List < ChannelAppointments > ();
        ChannelAppointments ChAppt;

        for (GE_PRM_Channel_Appointment__c capp: [Select ID, Name, GE_PRM_Last_Compliance_Approved__c, GE_PRM_Account_Name__r.Name, GE_PRM_Account_Name__r.GE_HQ_DUNS_Number__c,
                GE_PRM_Master_appointment_type__c, GE_PRM_Risk_rating__c, GE_PRM_Account_Country__c, GE_PRM_Current_Status__c
                From GE_PRM_Channel_Appointment__c Where GE_PRM_Current_Status__c = 'Approved'
                and
                GE_PRM_Account_Name__c =: accID
            ]) {
            ChAppt = new ChannelAppointments();
            ChAppt.chapID = capp.ID;
            ChAppt.chappName = capp.Name;
            ChAppt.isSelected = false;
            ChAppt.currentStatus = capp.GE_PRM_Current_Status__c;
            ChAppt.primaryCountry = capp.GE_PRM_Account_Country__c;
            ChAppt.channeltype = capp.GE_PRM_Master_appointment_type__c;
            ChAppt.riskrating = capp.GE_PRM_Risk_rating__c;
            If(capp.GE_PRM_Last_Compliance_Approved__c != null)
            ChAppt.approvedate = capp.GE_PRM_Last_Compliance_Approved__c.month() + '/' + capp.GE_PRM_Last_Compliance_Approved__c.day() + '/' + capp.GE_PRM_Last_Compliance_Approved__c.year();
            lstAppointments.Add(ChAppt);
        }

        If(ExecutedAddendumContracts != null && ExecutedAddendumContracts.size() > 0) {
            displayContracts = true;
        }

        else {
            displayContracts = false;
        }

        If(lstAppointments != null && lstAppointments.size() > 0) {
            displayAppointments = true;
        }

        else {
            displayAppointments = false;

        }

    }

    public List < ExecutedContracts > getlstExecutedAddendumContracts() {

        return ExecutedAddendumContracts;

    }

    //Getting Channel Appointments with Approved Status
    public List < ChannelAppointments > getAppointments() {
            return lstAppointments;
        }
        /* public Pagereference createTask()
         { 
             System.debug('###'+ cid );
             Task tsk = New Task();
             tsk.WhatID = cid ;
             tsk.ActivityDate = Date.Today() + 15 ;
             tsk.subject = 'Please do the NR/T for All Commercial Lines for this Channel Appointment';
             tsk.OwnerID = Userinfo.getuserID();
             tsk.IsReminderSet = true ;
             
             //Time remindertime;
             Time remindertime = Time.newInstance(8, 0, 0,0);
             datetime reminderdate = datetime.newInstance(tsk.ActivityDate, remindertime);
             
             tsk.ReminderDateTime = reminderdate ;
             Insert tsk;
             System.debug('###'+ tsk.id);            
             return new Pagereference ('/apex/GE_PRM_Channel_Appointment_View_Page1?id='+cid); 
             
         } */

    public Pagereference backtoAccount() {
        accID = ApexPages.currentPage().getParameters().get('accID');
        System.debug('eeeeeee' + accID);
        PageReference account = new PageReference('/' + accID);
        account.setRedirect(True);
        return account;
    }

    public PageReference checkforAppointment() {
        Pagereference Page1;
        Set < ID > contractids = New Set < ID > ();
        GE_PRM_Channel_Appointment__c newChannelApp = new GE_PRM_Channel_Appointment__c();

        For(ExecutedContracts c: ExecutedAddendumContracts) {
            If(c.isSelected == true || test.isRunningtest())
            contractids.Add(c.ContractID);
        }

        If(contractids != null && contractids.size() > 0) {
            List < Contract > acontractList = [select Id, Name, GE_PRM_Channel_Appointment_ID__c, GE_PRM_Master_Agreement__c, GE_PRM_Relationship_Type__c, ContractTerm, GE_PRM_Tier_4__c, GE_PRM_Tier_5__c, GE_PRM_Tier_3__c, GE_PRM_Tier_2__c, GE_PRM_Business_Tier_1__c, Status from Contract where Id in: contractids];

            Contract mc = lstMasterContracts[0];
            system.debug('**acontractList' + acontractList);
            list < contract > lstupdatingcont = new list < contract > ();

            newChannelApp.GE_PRM_Master_appointment_type__c = 'NR/T';
            newChannelApp.GE_PRM_Current_Status__c = 'Approved';
            account aa = new account();
            aa = [select id, Oil_Gas_Parent_Account__c from account where id =: accId];
            if (aa != null && aa.Oil_Gas_Parent_Account__c != null)
                newChannelApp.GE_PRM_Commercial_Account__c = aa.Oil_Gas_Parent_Account__c;
            newChannelApp.GE_PRM_Primary_Sales_Channel_Manager__c = mc.GE_PRM_Primary_Sales_Channel_Manager__c;
            newChannelApp.GE_PRM_Tier_2_P_L__c = mc.GE_PRM_Tier_2__c;
            newChannelApp.GE_PRM_Account_Name__c = mc.Account.id;
            newChannelApp.GE_PRM_Dummy_Apppointment__c = true;
            newChannelApp.GE_PRM_IsApproved__c = true;
            insert newChannelApp;
            System.debug('CHANNEL APPOINTMENT CREATED' + newChannelApp.id);

            System.Debug('$$$$$$ notExecutedContract ' + notExecutedContract);
            //Check If All Executed Master Contracts Selected
            If(ExecutedAddendumContracts.size() == acontractList.size() && notExecutedContract == false) {

                mc.GE_PRM_Channel_Appointment_ID__c = newChannelApp.ID;
            }
            else {
                String soql = getCreatableFieldsSOQL('Contract', 'id=\'' + mc.ID + '\'');
                system.debug('SOQL &&&&& ' + soql);
                Contract c = (Contract) Database.query(soql);
                mc = c.Clone(false, true);
                Insert mc;
                System.debug('MCCCC***** ' + mc.ID + mc);
                mc.GE_PRM_Channel_Appointment_ID__c = newChannelApp.ID;
            }

            lstupdatingcont.add(mc);

            System.debug('Masterch' + mc.GE_PRM_Channel_Appointment_ID__c);

            for (Contract a: acontractList) {

                GE_PRM_Commercial_line__c addendumcommline = new GE_PRM_Commercial_line__c(GE_PRM_Channel_Appointment__c = mc.GE_PRM_Channel_Appointment_ID__c);

                addendumcommline.GE_PRM_Tier_4__c = a.GE_PRM_Tier_4__c;
                addendumcommline.GE_PRM_Tier_1__c = 'Oil & Gas';
                addendumcommline.GE_PRM_Tier_2__c = a.GE_PRM_Tier_2__c;
                addendumcommline.GE_PRM_Tier_3__c = a.GE_PRM_Tier_3__c;
                addendumcommline.GE_PRM_Tier_5__c = a.GE_PRM_Tier_5__c;
                addendumcommline.GE_PRM_Type__c = a.GE_PRM_Relationship_Type__c;
                addendumcommline.GE_PRM_Status__c = 'Renewal';
                addendumcommline.GE_PRM_Term__c = a.ContractTerm;
                addendumcommline.GE_PRM_Non_Standrd_Indefnte_Discnt_r_Com__c = 'Standard';
                insert addendumcommline;
                System.debug('addendumcommline' + addendumcommline.id);

                a.GE_PRM_Channel_Appointment_ID__c = mc.GE_PRM_Channel_Appointment_ID__c;
                a.GE_PRM_Commercial_line__c = addendumcommline.id;
                a.GE_PRM_Master_Agreement__c = mc.ID;
                lstupdatingcont.add(a);


            }
            update lstupdatingcont;
            Page1 = new Pagereference('/' + mc.GE_PRM_Channel_Appointment_ID__c);
            System.debug('Page1' + Page1);
            Page1.setRedirect(true);

            return Page1;
        }
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'Please select a Contract'));
        return null;
    }

    // Returns a dynamic SOQL statement for the whole object, includes only creatable fields since we will be inserting a cloned result of this query
    public static string getCreatableFieldsSOQL(String objectName, String whereClause) {

        String selects = '';

        if (whereClause == null || whereClause == '') {
            return null;
        }

        // Get a map of field name and field token
        Map < String, Schema.SObjectField > fMap = Schema.getGlobalDescribe().get(objectName.toLowerCase()).getDescribe().Fields.getMap();
        list < string > selectFields = new list < string > ();

        if (fMap != null) {
            for (Schema.SObjectField ft: fMap.values()) { // loop through all field tokens (ft)
                Schema.DescribeFieldResult fd = ft.getDescribe(); // describe each field (fd)
                //if (fd.isCreateable()){ // field is creatable
                selectFields.add(fd.getName());
                //}
            }
        }

        if (!selectFields.isEmpty()) {
            for (string s: selectFields) {
                selects += s + ',';
            }
            if (selects.endsWith(',')) {
                selects = selects.substring(0, selects.lastIndexOf(','));
            }

        }

        return 'SELECT ' + selects + ' FROM ' + objectName + ' WHERE ' + whereClause;

    }

    public Class ExecutedContracts {
        public ID ContractID {
            get;
            set;
        }
        public String ContractName {
            get;
            set;
        }
        public String GE_PRM_Channel_Appointment_ID{
            get;
            set;
        }
        public String GE_PRM_Master_agreement_ID {
            get;
            set;
        }
        public Boolean isSelected {
            get;
            set;
        }
        public String ContractNumber {
            get;
            set;
        }
        public String GE_PRM_Tier_2 {
            get;
            set;
        }
        public String GE_PRM_Tier_3 {
            get;
            set;
        }
        public String GE_PRM_Tier_4 {
            get;
            set;
        }
        public String GE_PRM_Tier_5 {
            get;
            set;
        }
        public String Status {
            get;
            set;
        }
        public String EndDate {
            get;
            set;
        }
        public String StartDate {
            get;
            set;
        }
        public String GE_PRM_Relationship_Type {
            get;
            set;
        }
    }

    public Class ChannelAppointments {
        public ID chapID {
            get;
            set;
        }
        public String chappName {
            get;
            set;
        }
        public Boolean isSelected {
            get;
            set;
        }
        public string currentStatus {
            get;
            set;
        }
        public string primaryCountry {
            get;
            set;
        }
        public string channeltype {
            get;
            set;
        }
        public string riskrating {
            get;
            set;
        }
        public string approvedate {
            get;
            set;
        }
    }
}