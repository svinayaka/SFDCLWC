/* 
Type Name [Class/Trigger/Page Name] : Class - GE_OG_CIR_CaseNewController
Purpose                             : Redirectd to a visulaforce page when clicked on new button on Case 
Functional Area                     : Service
Author                              : Sandeep Rayavarapu
Created Date                        : 21 August 2014
Test Class                          : GE_OG_CIR_CaseNewControllerTest
Modified On/By                      : 28 September 2017/Sonali Rathore
Purpose                             : To accomidate extra functionalities for CIR Layout on Case 

*/
public with sharing class GE_OG_CIR_CaseNewController {
    public
    case c {get;set;}
    public String retURL {
        get;
        set;
    }
    public String saveNewURL {
        get;
        set;
    }
    public String rType {
        get;
        set;
    }
    public String cancelURL {
        get;
        set;
    }
    public String ent {
        get;
        set;
    }
    public String confirmationToken {
        get;
        set;
    }
    public String accountID {
        get;
        set;
    }
    public String contactID {
        get;
        set;
    }
    public String CLOP {
        get;
        set;
    }
    public String CLOPvalue {
        get;
        set;
    }
    public String VS {
        get;
        set;
    }
    public String VSvalue {
        get;
        set;
    }
    public String KeyAccountNamevalue {
        get;
        set;
    }
    public string cirinitiatorvisibility {
        get;
        set;
    }
    Public String IBid {
        get;
        set;
    }
    Public String Accid {
        get;
        set;
    }
    Public String currentIBAccId {
        get;
        set;
    }
    Public String currentAccName {
        get;
        set;
    }
    Public String currentSiteName {
        get;
        set;
    }
    Public String currentAccSiteName {
        get;
        set;
    }
    Public String currentIBId {
        get;
        set;
    }
    Public String currentIBAccnameid {
        get;
        set;
    }
    Public String currentIBnameid {
        get;
        set;
    }
    Public String ShippingCountry {
        get;
        set;
    }
    Public String ShippingAccCountry {
        get;
        set;
    }
    Public boolean MCboolean {
        get;
        set;
    }
    Public String sitename {
        get;
        set;
    }
    public String accname {
        get;
        set;
    }
    public String conname {
        get;
        set;
    }
    public String conaccname {
        get;
        set;
    }
    public String oppname {
        get;
        set;
    }
    public string IBname {
        get;
        set;
    }
    public string SelectedFields {
        get;
        set;
    }
    public string handbook {
        get;
        set;
    }
    public id caseid;
    public Boolean flag = false;
    Public String JobType;
    Public String business;
    Public String subbusiness;
    public Case currentCase {
        get;
        set;
    }
    ApexPages.standardController cp;
    List < Case > ccc = New List <
    case >();
    public string pgMsgTxt {
        get;
        set;
    }
    public Boolean disableInput {
        get;
        set;
    }
    List < SelectOption > optionscomponent {
        get;
        set;
    }
    List < SelectOption > optionsitem {
        get;
        set;
    }
    public string assembly {
        get;
        set;
    }
    public String component {
        get;
        set;
    }
    public String item {
        get;
        set;
    }
    public Boolean booleanexp {
        get;
        set;
    }
    public string businessvalue {
        get;
        set;
    }
    public string subbusinessvalue {
        get;
        set;
    }
    public string assemblyvalue {
        get;
        set;
    }
    public string componentvalue {
        get;
        set;
    }
    public string itemvalue {
        get;
        set;
    }
    public string Businesscir {
        get;
        set;
    }
    public string SubBusinesscir {
        get;
        set;
    }


    public List < SelectOption > getcomponentsSelectList() {
        optionscomponent.clear();
        system.debug('..........' + assembly);
        system.debug('..........' + SubBusinesscir);
        system.debug('..........' + businessvalue);
        system.debug('..........' + Businesscir);
        // Find all the components in the custom setting
        List < GE_OG_Product_Hierarchy1__c > prd = [select GE_OG_MCS_Component__c, GE_OG_MCS_Assembly__c from GE_OG_Product_Hierarchy1__c where GE_OG_MCS_Assembly__c =: assembly and GE_OG_MCS_Sub_Business__c =: SubBusinesscir and GE_OG_MCS_Business__c =: Businesscir];
        set < String > s = new Set < String > ();
        for (GE_OG_Product_Hierarchy1__c pr: prd) {
            s.add(pr.GE_OG_MCS_Component__c);
        }
        System.debug('--ash--' + prd);
        List < String > list1 = new List < String > ();
        list1.addAll(s);
        list1.sort();
        for (String s1: list1) {
            optionscomponent.add(new SelectOption(s1, s1));
        }

        if (optionscomponent.size() == 1 && prd.size() == 1) {
            component = prd[0].GE_OG_MCS_Component__c;
        } else if (optionscomponent.size() == 1 && prd.size() > 1) {
            optionscomponent.add(0, new SelectOption('', '--Select One--'));
        } else if (optionscomponent.size() > 1 && prd.size() > 1) {
            optionscomponent.add(0, new SelectOption('', '--Select One--'));
        } else {

            optionscomponent.add(new SelectOption('', '--None--'));

        }

        return optionscomponent;
    }

    public List < SelectOption > getitemsSelectList1() {
        c.GE_OG_CIR_Component__c = component;
        c.GE_OG_CIR_Item__c = item;
        booleanexp = true;
        GE_OG_Product_Hierarchy1__c state;
        optionscomponent.clear();
        optionsitem = new List < SelectOption > ();
        // Find all the states we have in custom settings.
        List < GE_OG_Product_Hierarchy1__c > allitem = [select GE_OG_MCS_Item__c, GE_OG_MCS_Component__c from GE_OG_Product_Hierarchy1__c where GE_OG_MCS_Component__c =: component and GE_OG_MCS_Assembly__c =: assembly and GE_OG_MCS_Sub_Business__c =: SubBusinesscir and GE_OG_MCS_Business__c =: Businesscir];
        if (allitem.size() == 1) {
            System.debug('Size is one========>');
            // Filter states that belong to the selected country
            Map < String, GE_OG_Product_Hierarchy1__c > items = new Map < String, GE_OG_Product_Hierarchy1__c > ();
            for (GE_OG_Product_Hierarchy1__c item9: allitem) {
                if (item9.GE_OG_MCS_Component__c == this.component) {
                    items.put(item9.GE_OG_MCS_Item__c, item9);
                }
            }

            // Sort the states based on their names
            List < String > itemNames = new List < String > ();
            itemNames.addAll(items.keySet());
            itemNames.sort();
            // Generate the Select Options based on the final sorted list
            for (String itemName: itemNames) {
                state = items.get(itemName);

                optionsitem.add(new SelectOption(state.GE_OG_MCS_Item__c, state.GE_OG_MCS_Item__c));
            }
            item = allitem[0].GE_OG_MCS_Item__c;

        } else if (allitem.size() > 1) {

            System.debug('Size is >1========>');

            // Filter states that belong to the selected country
            Map < String, GE_OG_Product_Hierarchy1__c > items = new Map < String, GE_OG_Product_Hierarchy1__c > ();
            for (GE_OG_Product_Hierarchy1__c item9: allitem) {
                if (item9.GE_OG_MCS_Component__c == this.component) {
                    items.put(item9.GE_OG_MCS_Item__c, item9);
                }
            }

            // Sort the states based on their names
            List < String > itemNames = new List < String > ();
            itemNames.addAll(items.keySet());
            itemNames.sort();

            // Generate the Select Options based on the final sorted list
            for (String itemName: itemNames) {
                state = items.get(itemName);
                optionsitem.add(new SelectOption(state.GE_OG_MCS_Item__c, state.GE_OG_MCS_Item__c));
            }
        }

        // If no states are found, just say not required in the dropdown.
        if (optionsitem.size() == 1 && allitem.size() == 1) {} else if (optionsitem.size() == 1 && allitem.size() > 1) {
            optionsitem.add(0, new SelectOption('', '--Select One--'));
        } else if (optionsitem.size() > 1 && allitem.size() > 1) {
            optionsitem.add(0, new SelectOption('', '--Select One--'));
        } else {
            optionsitem.add(new SelectOption('', '--None--'));
        }
        return optionsitem;
    }

    public string oppname1 {
        get;
        set;
    }

    public GE_OG_CIR_CaseNewController(ApexPages.StandardController Controller) {
        handbook = 'https://ge.ent.box.com/s/6llge7bbyqxer16gfkcm8mwvlp32vr8y';
        disableInput = true;
        pgMsgTxt = '';
        optionscomponent = new List < SelectOption > ();
        c=new Case();
        this.c = (case) Controller.getRecord();
        System.debug('case details' + c);
        c.status = 'New';
        retURL = ApexPages.currentPage().getParameters().get('retURL');

        System.debug('dedd' + retURL);

        if (retURL != null) {
            system.debug('..............' + retURL);
            if (retURL.startsWith('/001')) {
                system.debug('..............' + retURL.substring(1, retURL.length()));
                c.accountid = retURL.substring(1, 16);
                account a = [select id, name from account where id =: retURL.substring(1, 16)];
                if (a != null) {
                    accname = a.id;
                }
            }
            if (retURL.startsWith('/a0M')) {
                system.debug('..............' + retURL.substring(1, retURL.length()));
                GE_Installed_Base__c Installbase = [SELECT id, GE_ES_Station_Name__c, Account__r.id, Account__r.ShippingCountry, Account__r.Name, Account__r.Site from GE_Installed_Base__c WHERE id =: retURL.substring(1, 16)];
                system.debug('..............' + Installbase);
                if (Installbase != null) {

                    c.GE_OG_CIR_Unit_Serial_number__c = Installbase.id;
                    c.accountid = Installbase.Account__r.id;
                    c.GE_OG_CIR_Site_Name__c = Installbase.GE_ES_Station_Name__c;
                    c.GE_OG_CIR_Site_Country__c = Installbase.Account__r.ShippingCountry;
                    system.debug('..............' + IBname);
                }
            }

            if (retURL.startsWith('/003')) {
                system.debug('..............' + retURL.substring(1, retURL.length()));
                contact con = [SELECT id, name, accountid from contact WHERE id =: retURL.substring(1, 16)];
                system.debug('..............' + con);
                if (con != null) {

                    c.Contactid = con.id;
                    conname = con.id;
                    c.accountid = con.accountid;
                    conaccname = con.accountid;
                    system.debug('..............' + c);
                }
            }

            if (retURL.startsWith('/006')) {
                opportunity o = [select id, accountid, Name from opportunity where id =: retURL.substring(1, 16)];
                c.Opportunity_Name__c = o.id;
                c.accountid = o.accountid;
                oppname = o.id;
                oppname1 = o.name;
                accname = o.accountid;
                list < OpportunityContactRole > OpConRo = [SELECT Contact.Name, ContactId FROM OpportunityContactRole WHERE OpportunityId =: o.id AND IsPrimary = TRUE LIMIT 1];
                if (OpConRo.size() > 0) {
                    c.Contactid = OpConRo[0].ContactId;
                    conname = OpconRo[0].ContactId;
                    system.debug('..............' + c);
                }
            }
        }
        rType = ApexPages.currentPage().getParameters().get('RecordType');
        System.debug('dedds' + rType);
        c.recordtypeid = rtype;
        CLOP = Apexpages.currentPage().getParameters().get('Six');
        VS =  Apexpages.currentPage().getParameters().get('Seven');
        string CurrentPageURL = ApexPages.currentPage().getURL();
        system.debug('....page URl  ..........' + CurrentPageURL);

    }

    public void jobtypeToController() {
        JobType = SelectedFields;
    }





    recordtype rtypeCir;
    public PageReference redirect() {

        id mctsid = Schema.SObjectType.Case.getRecordTypeInfosByName().get('MC-TS').getRecordTypeId();
        rtypeCir = [Select id from recordtype where sobjecttype =: 'Case'
            and name =: 'CIR'
        ];
        user u = [select id, profileid from user where id =: userinfo.getuserid()];
        profile p = [select id, name from profile where id =: u.profileid];
          string ProfileName = p.name;
        if (p.name.contains('II Partner Community') && rtype == null) {

            Community_pro_rec_map__c recmap = [select RecordtypeID__c from Community_pro_rec_map__c where Profile_Name__c =: p.name];

            rtype = recmap.RecordtypeID__c;
        }

        PageReference returnURL;

        // Redirect if Record Type corresponds to custom VisualForce page
        System.debug('sffs' + rtype);
        if (rtype == null) {
            returnURL = new PageReference('/apex/Lightning_GE_OG_CIR_CaseNew');

        } else IF(rtype == rtypeCir.id && rtype != null) {
          
            if(ProfileName == 'GE_OG_CIR_Initiator' || ProfileName == 'GE_OG_Super User' ||ProfileName == 'GE_OG_Queue Manager' || ProfileName == 'GE_ES Developer' ||  ProfileName == 'System Administrator'||ProfileName =='GE_ES Service MCS'|| ProfileName=='GE_ES Sales Mgr_MCS-SI')
            {
           returnURL = new PageReference('/apex/Lightning_GE_OG_CIR_CaseNew');
           //returnURL = new PageReference('/apex/BH_CIR_LightingCaseCreateComponentCall');
            }
            
            else
            {
               returnURL = new PageReference('/apex/GE_OG_CIR_CaseNew');
               
            }
        }
        else if(rtype == mctsid && rtype != null){
            if(ProfileName == 'GE_ES Developer' || ProfileName == 'System Administrator'|| ProfileName == 'GE_ES Service MCS'||  ProfileName=='GE_ES Sales Mgr_MCS-SI' || ProfileName == 'GE_OG_Super User' || ProfileName == 'GE_OG_Queue Manager')
            {
                returnURL = new PageReference('/500/e');            
            }
            
            else
            {
               returnURL = new PageReference('/apex/GE_OG_MC_TS_New');
               
            }
        }        

        ELSE {

            returnURL = new PageReference('/500/e');


        }

        returnURL.getParameters().put('retURL', retURL);
        if (accname != null) {
            returnURL.getParameters().put('cas4_lkid', accname);
        }
        if (conname != null) {
            returnURL.getParameters().put('cas3_lkid', conname);
        }

        if (conaccname != null) {
            returnURL.getParameters().put('cas4_lkid', conaccname);
        }

        if (oppname != null) {
            returnURL.getParameters().put('cas4_lkid', accname);
            returnURL.getParameters().put('CF00NA0000009xOJR', oppname1);
            returnURL.getParameters().put('CF00NA0000009xOJR_lkid', oppname);
        }
        returnURL.getParameters().put('RecordType', rType);
        returnURL.getParameters().put('nooverride', '1');

        returnURL.setRedirect(true);
        return returnURL;

    }

    public pagereference save() {
        Businesscir = c.GE_OG_Business_CIR__c;
        subbusinessvalue = c.GE_OG_Sub_Business_CIR__c;
        c.Customer_Loss_of_Production__c = CLOPvalue;
        
        //KeyAccountNamevalue = c.Key_Account_Name__c;
        System.debug('---- Save Customer_Loss_of_Production__c---' + c.Customer_Loss_of_Production__c);
        AssignmentRule AR = new AssignmentRule();
        AR = [select id from AssignmentRule where SobjectType = 'Case'
            and Active = true limit 1
        ];
        Database.DMLOptions dmlOpts = new Database.DMLOptions();
        dmlOpts.assignmentRuleHeader.assignmentRuleId = AR.id;

        rtypeCir = [Select id from recordtype where sobjecttype =: 'Case'
            and name =: 'CIR'
        ];

        c.setOptions(dmlOpts);

        if (c.GE_OG_CIR_Unit_Serial_number__c != null) {
            GE_Installed_Base__c ib = [select id, Account__c, GE_ES_Station_Name__c from GE_Installed_Base__c where id =: c.GE_OG_CIR_Unit_Serial_number__c];
            list < account > a = [select id, ShippingCountry, Shippingstate from account where id =: ib.Account__c];
            if (a.size() > 0) {
                c.accountid = a[0].id;
                //c.GE_OG_Key_Account_Name_CIR__c = null;
                c.GE_OG_Account_Name_Only_If_Not_List_CIR__c = null;
                c.GE_OG_CIR_Site_Country__c = a[0].ShippingCountry;
                c.GE_OG_CIR_State__c = a[0].Shippingstate;
            } else {
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'The provided unit serial number does not have an account');
                ApexPages.addMessage(myMsg);

            }
            if (ib.GE_ES_Station_Name__c != null) {
                c.GE_OG_CIR_Site_Name__c = ib.GE_ES_Station_Name__c;
            }

        } else if (c.accountid != null) {
            account a = [select id, ShippingCountry, Shippingstate from account where id =: c.accountid];
            c.GE_OG_CIR_Site_Country__c = a.ShippingCountry;
            c.GE_OG_CIR_Site_Country__c = a.ShippingCountry;
            c.GE_OG_CIR_State__c = a.Shippingstate;
            //c.GE_OG_Key_Account_Name_CIR__c = null;
            c.GE_OG_Account_Name_Only_If_Not_List_CIR__c = null;



        }
        system.debug('......' + c.GE_OG_CIR_Site_Country__c);
        try {
            system.debug('......' + c);
            c.Customer_Loss_of_Production__c = CLOPvalue;
            System.debug('---- Save Customer_Loss_of_Production__c---' + c.Customer_Loss_of_Production__c);
            insert c;
            system.debug('......Created Case' + c);
             system.debug('......Created Case' + c.Key_Account_Name__c);
           // pagereference p2 = new pagereference('/' + c.id);
         //   return p2;
         PageReference casePage = new ApexPages.StandardController(c).view();
         casePage.setRedirect(true);
         return casePage;
        } catch (exception e) {
            ApexPages.addMessages(e);


        }

        return null;


    }
    
    public pagereference cancel() {
        pagereference p = new pagereference('/500/o');
        return p;


    }

    public void MCFields() {
        MCboolean = true;
    }


    public pagereference makeNullValues() {
        SubBusinesscir = null;
        subbusinessvalue = null;

        businessvalue = Apexpages.currentPage().getParameters().get('one');
        if (businessvalue == 'Turbomachinery & Process Solutions') {
            Businesscir = 'Turbomachinery & Process Solutions';

        } 
        /*else if (businessvalue == 'DTS') {
            Businesscir = 'DTS';

        } 
        */
        else if (businessvalue == 'Oil Field Equipment') {
            Businesscir = 'Oil Field Equipment';
        } else {

            System.debug('!!!' + businessvalue);
            if (businessvalue != null || businessvalue != '') {
                Businesscir = businessvalue;
            }

            assembly = '';
            optionscomponent.clear();
            component = '';
            item = '';
        }

        return null;
    }



    public pagereference makeNullValues1() {

        SubBusinesscir = null;
        subbusinessvalue = null;

        subbusinessvalue = Apexpages.currentPage().getParameters().get('two');

        if (subbusinessvalue == 'New Units' || subbusinessvalue == 'Services - CS & TX' || subbusinessvalue == 'Services - Upgrades' || subbusinessvalue == 'Power Transmission' ||
            subbusinessvalue == 'Gas Processing' || subbusinessvalue == 'RC - New Units' || subbusinessvalue == 'RC - Services' || subbusinessvalue == 'FPT - Valve Projects' || subbusinessvalue == 'FPT - Aftermarket Solutions' || subbusinessvalue == 'FPT - Natural Gas Solutions' || subbusinessvalue == 'PVS') {
            Businesscir = 'Turbomachinery & Process Solutions';
            subbusinesscir = 'All';
        }
        /*
        if (subbusinessvalue == 'New Units' || subbusinessvalue == 'CMS' || subbusinessvalue == 'U&IA' || subbusinessvalue == 'DP&S' ||
            subbusinessvalue == 'DGS' || subbusinessvalue == 'IA&GT' || subbusinessvalue == 'GP' || subbusinessvalue == 'Recip. Compression') {
            Businesscir = 'DTS';
            subbusinesscir = 'All';

        }*/

        /* if(subbusinessvalue=='DP&S')
         {
         Businesscir='DTS';
         subbusinesscir='DP&S';
         
         }
         if(subbusinessvalue=='New Units'||subbusinessvalue=='CMS'||subbusinessvalue=='U&IA'
         ||subbusinessvalue=='DGS'||subbusinessvalue=='IA&GT'||subbusinessvalue=='GP'||subbusinessvalue=='Recip. Compression')
         {
         Businesscir='DTS';
         subbusinesscir='All';
         
         }
         if(subbusinessvalue=='Recip. Compression')
         {
         Businesscir='DTS';
         subbusinesscir='Recip. Compression';
         
         }
        if (subbusinessvalue == 'DP&S') {
            Businesscir = 'DTS';
            subbusinesscir = 'DP&S';

        }*/
        if (subbusinessvalue == 'Drilling Equipment' || subbusinessvalue == 'Subsea Services' || subbusinessvalue == 'Subsea Production Systems, Services & Offshore' || subbusinessvalue == 'Flexible Pipeline Systems & Wellstream Construction Services' || subbusinessvalue == 'Surface Pressure Control') {
            Businesscir = 'Oil Field Equipment';
            subbusinesscir = 'All';

        }
        if (subbusinessvalue == 'Wireline Services' || subbusinessvalue == 'Artificial Lift' || subbusinessvalue == 'Drilling Services' || subbusinessvalue == 'Drilling & Completion Fluids' || subbusinessvalue == 'Drill Bits' || subbusinessvalue == 'Completions' || subbusinessvalue == 'Wellbore interventions ' || subbusinessvalue == 'Pressure Pumping' || subbusinessvalue == 'Chemicals') {
            Businesscir = 'Oil Field Services';
            subbusinesscir = 'All';
        }
        
         if (subbusinessvalue == 'Control Solutions' || subbusinessvalue == 'Inspection Technologies' || subbusinessvalue == 'Measurement & Sensing' || subbusinessvalue == 'Bently Nevada' ||
        subbusinessvalue == 'PII') {
        Businesscir = 'Digital Solutions';
}
        if (subbusinessvalue != null || subbusinessvalue != '') {
            subBusinesscir = subbusinessvalue;
        }

        if (subbusinessvalue == 'FPT- Valve Projects' || subbusinessvalue == 'FPT- Aftermarket Solutions' || subbusinessvalue == 'FPT- Natural Gas Solutions') {
            Businesscir = 'Turbomachinery & Process Solutions';

            if (subbusinessvalue != null || subbusinessvalue != '') {
                subBusinesscir = subbusinessvalue;
            }

        }
        if (subbusinessvalue == 'FPT- Pumps Valves & Systems') {
            Businesscir = 'Turbomachinery & Process Solutions';
            c.GE_OG_CIR_M_C_Location_of_Mfg_Service__c = 'Bari';
            if (subbusinessvalue != null || subbusinessvalue != '') {
                subBusinesscir = subbusinessvalue;
            }

        }

        assembly = '';
        optionscomponent.clear();
        component = '';
        item = '';

        return null;

    }





    public pagereference makeNullValues2() {
        assemblyvalue = Apexpages.currentPage().getParameters().get('three');
        System.debug('!!!' + assemblyvalue);
        if (assemblyvalue != null || assemblyvalue != '') {
            assembly = assemblyvalue;
        }
        optionscomponent.clear();
        component = '';
        item = '';


        return null;
    }

    public pagereference makeNullValues3() {


        item = '';

        return null;
    }

    public pagereference makeNullValues4() {


        return null;
    }
    public pagereference makeNullValues6() {
        CLOPvalue = null;


        CLOPvalue = Apexpages.currentPage().getParameters().get('Six');
        system.debug('clopvalue' + CLOPvalue);

        return null;
    }
    public pagereference makeNullValues7() {
        VSvalue = null;


        VSvalue = Apexpages.currentPage().getParameters().get('Seven');
        system.debug('VSvalue' + VSvalue);

        return null;
    }
     


    public pagereference loctypeToController() {


        return null;
    }


}