public with sharing class FAComparer {

    public List<ObjectLabel> label;
    public String selectedLabel{get;set;}
    public List<SelectOption> selectLabels{set;get;}
    public List<SelectOption> selectedLabels{set;get;}
    public List<SelectOption> submitedLabels{set;get;}
    public String objLabel{get;set;}
    public String objapi{get;set;}
    public List<Record> searchedRecords {get;set;}
    public List<Record> searchedRecordsList {get;set;}
    public String record {get;set;}
    public String searchString {get;set;}
    private List<Id> recordsA;
    public Integer count{get;set;}
    public List<String> searchedFields{get;set;}
    public boolean manageField {get; set;}
    public boolean addRecords {get; set;}
    public boolean showNext{get;set;}
    public boolean showprevious{get;set;}
    public Integer size{get;set;}
    public Integer offset{get;set;}
    public String addId{get;set;}
    public Integer showSize{get;set;}
    public Integer viewCount{get;set;}
    public boolean viewCheck{get;set;}
    public String errormsg{get;set;}
    public List<String> defaultFields;
    public void closePopup() { errormsg = null; manageField = false; addRecords = false;setGrid();}
    public void showPopup() {
        checkCount();
        selectedLabels = new List<SelectOption>();
        for(SelectOption s:submitedLabels)
            for(ObjectLabel o : label)
                if(o.visible&&o.value.equals(s.getValue()))
                    selectedLabels.add(new SelectOption(o.value,o.label));
        selectLabels = new List<SelectOption>();
        for(ObjectLabel o : label){
            if(!o.visible)
                selectLabels.add(new SelectOption(o.value,o.label));
        }
        manageField = true;
    }
   
    public FAComparer() {
        
        defaultFields = new List<String>{'ContractNumber','Name','GE_HQ_Buss_Tier1__c','Status','GE_OG_Contract_Overview__c','GE_OG_Contract_End_Date__c'};
        Set<String> fieldSet = new Set<String>();
        fieldSet.addAll(defaultFields);
        SFDC_Support_Case__c views;
        try { 
            views = [Select User_SSO__c from SFDC_Support_Case__c where Type__c = 'Counter' AND Application__c = 'FAComparer' Limit 1];
            viewCount = Integer.valueOf(views.User_SSO__c);
            viewCount++;
        } catch(Exception e){
            viewCount = 1;
        }
        viewCheck = false;
        recordsA = new List<Id>();
        Id recId = ApexPages.currentPage().getParameters().get('id');
        if(recId !=null){
            objapi = recId.getSobjectType().getDescribe().getName();
            recordsA.add(recId);
        }
        if(objapi ==null)
            objapi = ApexPages.currentPage().getParameters().get('object');
        if(objapi ==null)
            objapi = 'Contract';
        Set<String> allFields = new Set<String>('ContractNumber,Name,GE_OG_Contract_Overview__c,GE_PRM_Record_Type_Name__c,AccountId,GE_OG_Account_Name__c,GE_Customer_Type__c,GE_OG_FA_Type__c,Status,Pricebook2Id,GE_HQ_SFDC_LEGACY_ID__c,GE_PRM_Business_Tier_1__c,GE_HQ_Buss_Tier1__c,GE_HQ_Buss_Tier2__c,GE_OG_Legal_Entity__c,StartDate,GE_OG_Evergreen__c,GE_OG_Contract_End_Date__c,GE_OG_FA_Applicable_Regions__c,GE_FA_Applicable_Products_Services__c,GE_Scope_of_Work__c,GE_Scope_of_Work_Description__c,GE_Revision_Amendments_Assignments__c,GE_Fleet_or_covered_units__c,GE_Pricing_Validity__c,GE_OG_Standard_Warranty__c,GE_OG_Warranty_Coverage__c,GE_OG_Warranty_Timeframe1__c,GE_OG_Warranty_Time_Frame__c,GE_OG_Governing_Law__c,GE_OG_Dispute_Resolution_Arbitration__c,GE_OG_Dispute_Resolution_Description__c,GE_OG_Mutual_Confidentiality__c,GE_OG_Confidentiality_duration_years1__c,GE_OG_Limitation_of_liability__c,GE_OG_Limitation_of_Liability_amount__c,GE_OG_3rd_Party_Indemnity__c,GE_Indty_Stru_Peop_Prop__c,GE_OG_Other_Indemnity__c,Exclusion_of_Consequential_Damages_incl__c,CreatedById,LastModifiedById,AccountId'.split('[,]'));
        Set<String> financeFields = new Set<String>('GE_Status__c,GE_Is_GE_entitled_to_reject_orders__c,GE_Is_there_a_LD_clause__c,GE_LDs_or_Penalty_amount_Details__c,GE_harm_no_foul_clause__c,GE_LDs_or_Pena_max_amt__c,GE_Cust_suspnd_for_conv__c,GE_Max_term_for_Cust_sus__c,GE_s_Susp_for_Cust_deft__c,GE_Max_GE_susp_due_to_Cust__c,GE_OG_Features_of_GE_susp_due_to_Cust__c,GE_rigt_to_term_Cust_defalt__c,GE_Term_fees_if_GE_term__c,GE_Cust_term_for_conven__c,GE_Can_sche_and_fees__c,GE_Cust_issue_order_vari__c,GE_Paymt_Term_days_from_which_event__c,GE_Is_there_Paymt_mile__c,GE_Structure_of_Payment_milestone__c,GE_Appli_Deliv_Terms__c,GE_IT_pnt_of_deliy_and_rea__c,GE_Deli_confirm_upon_Cust_accep__c,GE_Title_Transfer_and_Risk_of_Loss_Std__c,GE_Desc_title_trfr_loss__c,GE_TCs_to_be_agreed_each_PO__c,GE_Finance_Pricing_Currency__c,GE_Are_FX_Fluct_provision__c,GE_Invoic_proced__c,GE_Are_e_invoice_allowed__c,GE_Is_subject_to_perfrm_Guar__c,GE_right_ship_goods_to_strge__c,GE_Char_of_ship_storage__c,GE_Prods_Services_quoted_in_Pricing_List__c,GE_If_Othrs_specify_Prod_Ser__c,GE_Incen_Disc_are_includ__c,GE_If_Othrs_spcify_incen_Dis__c,GE_How_the_discount_is_applied__c,GE_Is_there_an_Esc_mech__c,GE_If_detail_Esc_mech__c,GE_If_vari_mini_floor_applic__c,GE_Detail_Frm_indx_Floor_Cap__c,GE_Is_there_a_Pricing_Letter__c,GE_If_detail_quot_Prod_Serv__c'.split('[,]'));
        Set<String> legalFields = new Set<String>('GE_Status__c,GE_Is_the_Assig_Clau_std__c,GE_Desc_the_Assign_clause_istd__c,GE_List_pre_appr_GE_Legal_Entit__c,GE_Is_the_Subcon_Clase_std__c,GE_Cust_suspnd_for_conv__c,GE_Is_GE_right_Subcon_std__c,GE_List_of_pre_app_GE_Legal_Enti__c,GE_Warranty_clause_if_no_std__c,GE_Is_there_Exten_of_warnty_term__c,GE_Are_there_carve_to_the_LOL1__c,GE_Conse_Damages_exclu__c,GE_Comm_on_Indem_Stru__c,GE_Indtion_3rd_Party_Use__c,GE_Pollution_Liability_indemn_by_Buyer__c,GE_Other_Poll_relat_notable_item__c,GE_CATAS_LOSS_OF_WELL__c,GE_Hazard_Waste_disp_respon__c,GE_Insu_Buyer_as_Add_Insured__c,GE_Insu_Waiver_of_Sub__c,GE_IP_Own_provision_non_std__c,GE_Sum_IP_provision_req__c,GE_Local_Content__c'.split('[,]'));
        Set<String> taxesFields = new Set<String>('GE_Status__c,GE_Tax_indemnity_clause__c,GE_MSD_and_dlrs_from_the_US__c,GE_Conty_specific_tax_duties_clau__c,GE_VAT_or_similar_exclud_from_prices__c,GE_add_Vat_or_similar_Prices__c,GE_IS_GE_std_Tax_clause_includ__c,GE_Describe_no_std_Tax_Clause__c,GE_Cust_provide_export_certif__c,GE_Cust_shall_provide_its_exempt__c,GE_Are_Seller_Taxes_defined__c,GE_Are_Cust_Taxe_defin__c,GE_in_contry_out_of_cotry_defin__c,GE_chang_in_law_clau_incl_taxes__c,GE_Cust_obli_to_apply_GE_exemp__c,GE_Cust_shall_provide_WHT_certifi__c,GE_possty_gross_taxes__c'.split('[,]'));
        Map<String, Schema.SObjectField> groupMemberFieldMap = Schema.getGlobalDescribe().get(objapi).getDescribe().fields.getMap();
        objLabel = Schema.getGlobalDescribe().get(objapi).getDescribe().getLabel();
        label = new List<ObjectLabel>();
        submitedLabels = new List<SelectOption>();
        for(Schema.SObjectField  s : groupMemberFieldMap.values()){
            if(allFields.contains(s.getDescribe().getName())&&s.getDescribe().isAccessible()&&!String.valueOf(s.getDescribe().getType()).equals('ADDRESS')) {
               ObjectLabel ol = new ObjectLabel();
               if(String.valueOf(s.getDescribe().getType()).equals('REFERENCE')){
                   ol.label = s.getDescribe().getLabel().removeEnd(' ID');
                   ol.type = String.valueOf(s.getDescribe().getType());
                   if(s.getDescribe().isCustom())
                       ol.apiName = s.getDescribe().getName().removeEnd('__c')+'__r.Name';
                   else
                       ol.apiName = s.getDescribe().getName().removeEnd('Id')+'.Name';
               } else {
                   ol.label = s.getDescribe().getLabel();
                   ol.apiName = s.getDescribe().getName();
                   ol.type = String.valueOf(s.getDescribe().getType());
               }
               ol.value = 'Contract.'+ol.apiName;
               ol.fromObj = 'Contract';
               label.add(ol);
            }
        }
        groupMemberFieldMap = Schema.getGlobalDescribe().get('Contract_Summary__c').getDescribe().fields.getMap();
        for(Schema.SObjectField  s : groupMemberFieldMap.values()){
            if(financeFields.contains(s.getDescribe().getName())&&s.getDescribe().isAccessible()&&!String.valueOf(s.getDescribe().getType()).equals('ADDRESS')) {
               ObjectLabel ol = new ObjectLabel();
               ol.label = 'Finance : '+s.getDescribe().getLabel();
               ol.apiName = s.getDescribe().getName();
               ol.type = String.valueOf(s.getDescribe().getType());
               ol.fromObj = 'Finance & Pricing';
               ol.value = 'Finance.'+ol.apiName;
               label.add(ol);
            }
            if(legalFields.contains(s.getDescribe().getName())&&s.getDescribe().isAccessible()&&!String.valueOf(s.getDescribe().getType()).equals('ADDRESS')) {
               ObjectLabel ol = new ObjectLabel();
               ol.label = 'Legal : '+s.getDescribe().getLabel();
               ol.apiName = s.getDescribe().getName();
               ol.type = String.valueOf(s.getDescribe().getType());
               ol.fromObj = 'Legal';
               ol.value = 'Legal.'+ol.apiName;
               label.add(ol);
            }
            if(taxesFields.contains(s.getDescribe().getName())&&s.getDescribe().isAccessible()&&!String.valueOf(s.getDescribe().getType()).equals('ADDRESS')) {
               ObjectLabel ol = new ObjectLabel();
               ol.label = 'Taxes : '+s.getDescribe().getLabel();
               ol.apiName = s.getDescribe().getName();
               ol.type = String.valueOf(s.getDescribe().getType());
               ol.fromObj = 'Taxes';
               ol.value = 'Taxes.'+ol.apiName;
               label.add(ol);
            }
        }
        searchedFields = new List<String>();
        searchedFields.add('Id');
        if('Contract'.equals(objapi)){
            searchedFields.add('ContractNumber');
            searchedFields.add('RecordType.Name');
            searchedFields.add('Name');
            searchedFields.add('Account.Name');
            searchedFields.add('Status');
        } else
            searchedFields.add('Name');
        label.sort();
        for(ObjectLabel ol:label){
            if('Contract'.equals(objapi)){
                   if(fieldSet.contains(ol.apiName)){
                       ol.visible = true;
                   } else {
                       ol.visible = false;
                   }
               } else {
                   if(ol.apiName.equals('Name')){
                       ol.visible = true;
                   } else {
                       ol.visible = false;
                   }
               }
        }
        setGrid();
        selectLabels = new List<SelectOption>();
        for(String s:defaultFields )
            for(ObjectLabel o : label){
                if(o.visible&&s.equals(o.apiName))
                    submitedLabels.add(new SelectOption(o.value,o.label));
            }
        for(ObjectLabel o : label){
            if(!o.visible)
                selectLabels.add(new SelectOption(o.value,o.label));
            }
    }
    
   public class ObjectLabel implements Comparable{
        public String fromObj{get;set;}
        public String label{get;set;}
        public String value{get;set;}
        public String apiName{get;set;}
        public Boolean visible{get;set;}
        public String type{get;set;}
        public Object record1{get;set;}
        public Object record2{get;set;}
        public Object record3{get;set;}
        public Object record4{get;set;}
        public Object record5{get;set;}
        public Object record6{get;set;}
        public Object record7{get;set;}
        public Object record8{get;set;}
        public Object record9{get;set;}
        public Object record10{get;set;}
        public Object record11{get;set;}
        public Object record12{get;set;}
        public Object record13{get;set;}
        public Object record14{get;set;}
        public Object record15{get;set;}
        public Object record16{get;set;}
        public Object record17{get;set;}
        public Object record18{get;set;}
        public Object record19{get;set;}
        public Object record20{get;set;}
        
        public Integer hashCode() {
            return (31 * apiName.hashCode()) ^ apiName.hashCode();
        }
        
        public Boolean equals(Object obj) {
            if (obj instanceof ObjectLabel) {
                ObjectLabel p = (ObjectLabel)obj;
                return (apiName.equals(p.apiName));
            }
            return false;
        }
        
        public Integer compareTo(Object compareTo) {
            ObjectLabel compareToEmp = (ObjectLabel)compareTo;
            if(fromObj==compareToEmp.fromObj){
                if (label == compareToEmp.label) return 0;
                if (label > compareToEmp.label) return 1;
                return -1;
            }
            if (fromObj > compareToEmp.fromObj) return 1;
            return -1;    
        }
    }
    
    public class Record implements Comparable{
        public String id{get;set;}
        public Boolean selected{get;set;}
        public String label1{get;set;}
        public String label2{get;set;}
        public String label3{get;set;}
        public String label4{get;set;}
        public String label5{get;set;}
        
        public Integer hashCode() {
            return (31 * id.hashCode()) ^ id.hashCode();
        }
        
        public Boolean equals(Object obj) {
            if (obj instanceof Record) {
                Record  p = (Record)obj;
                return (id.equals(p.id));
            }
            return false;
        }
        
        public Integer compareTo(Object compareTo) {
            Record compareToEmp = (Record)compareTo;
            if (id == compareToEmp.id) return 0;
            if (id > compareToEmp.id) return 1;
            return -1;        
        }
    }
    
    public List<ObjectLabel> getFieldList(){
        List<ObjectLabel> options = new List<ObjectLabel>();
        for(SelectOption s:submitedLabels)
            for(ObjectLabel o : label){
                if(o.value.equals(s.getValue())){
                    options.add(o);
                }
            }
        return options;
    }
    
    public List<SelectOption> getSelectLabel(){
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption(' ','--Add more field--'));
        for(ObjectLabel o : label){
            if(!o.visible)
                options.add(new SelectOption(o.value,o.label));
        }
        return options;
    }
    
    public void addField(){
        checkCount();
        for(ObjectLabel s:label){
            if(s.value.equals(selectedLabel)){
                s.visible = true;
                submitedLabels.add(new SelectOption(s.value,s.label));
            }
        }
        setGrid();
    }
    
    public void addFields(){
        if(selectedLabels.size()==0){
            errormsg = 'Cannot move everything to left.';
            return;
        }
        manageField = false;
        submitedLabels = selectedLabels;
        for(SelectOption s:submitedLabels)
            for(ObjectLabel ol:label)
                if(ol.value.equals(s.getValue())){
                    ol.visible = true;
                    break;
                }
        for(SelectOption s:selectLabels)
            for(ObjectLabel ol:label)
                if(ol.value.equals(s.getValue())){
                    ol.visible = false;
                    break;
                }
        errormsg = null;
        setGrid();
    }
    
    public PageReference selectRecord() {
        
        recordsA.add(addId);
        setGrid();
        addRecords = false;
        return null;
    }
    
    public PageReference selectRecords() {
        Integer i = recordsA.size();
        selectNSearchRecords();
        if(i!=recordsA.size())
            addRecords = false;
        return null;
    }

    public PageReference selectNSearchRecords() {
        Set<Id> ids = new Set<Id>();
        ids.addAll(recordsA);
        List<Id> temp = recordsA;
        recordsA = new List<Id>();
        recordsA.addAll(temp);
        boolean flag = false;
        for(Record r:searchedRecords)
            if(r.selected){
                flag = true;
                if(ids.add(r.Id))
                    recordsA.add(r.Id);
            }
        if(!flag){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Select atleast one record'));
            return null;
        }
        if(recordsA.size()>20){
            recordsA = temp;
            String msg = 'You can only add '+(20-temp.size())+' more Records';
            if(5-temp.size()==1)
                msg = msg.removeEnd('s');
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,msg));
        } else {
            setGrid();
        }
        if(recordsA.size()==20)
            addRecords = false;
        submit();
        return null;
    }
    
    private void setGrid(){
        String query = 'Select ';
        Set<String> field2 = new Set<String>();
        String query2 = 'Select RecordType.Name,GE_Contract_Name__c,';
        for(ObjectLabel o : label){
            if(o.visible){
                if('Contract'.equals(o.fromObj))
                    query += ' '+o.apiName+',';
                else
                    field2.add(o.apiName);   
            }
        }
        for(String s:field2)
            query2 += ' '+s+',';
        
        query = query.removeEnd(',');
        query2 = query2.removeEnd(',');
        query += ' from '+objapi+' where Id IN:recordsA';
        query2 += ' from Contract_Summary__c where GE_Contract_Name__c IN:recordsA';
        
        List<SObject> recordsL = Database.query(query);
        system.debug(query2);
        List<SObject> recordsRL = Database.query(query2);
        count = 0;
        for(Id i:recordsA){
            for(SObject s : recordsL){
                if(i.equals(String.valueOf(getValue(s,'Id')))){
                    for(ObjectLabel o : label){
                        if(o.visible&&'Contract'.equals(o.fromObj)){
                            setValue(o,s,count);
                        }
                    }
                }
            }
            count++;
        }
        integer countx = 0;
        for(Id i:recordsA){
            for(SObject s : recordsRL){
                if(i.equals(String.valueOf(getValue(s,'GE_Contract_Name__c')))){
                    for(ObjectLabel o : label){
                        if(o.visible&&String.valueOf(getValue(s,'RecordType.Name')).equals(o.fromObj)){
                            setValue(o,s,countx);
                        }
                    }
                }
            }
            countx++;
        }
    }
    
    private void setValue(ObjectLabel o, SObject s, Integer count){
        if(count==0)
            o.record1 = getStringValue(s, o);
        if(count==1)
            o.record2 = getStringValue(s, o);
        if(count==2)
            o.record3 = getStringValue(s, o);
        if(count==3)
            o.record4 = getStringValue(s, o);
        if(count==4)
            o.record5 = getStringValue(s, o);
        if(count==5)
            o.record6 = getStringValue(s, o);
        if(count==6)
            o.record7 = getStringValue(s, o);
        if(count==7)
            o.record8 = getStringValue(s, o);
        if(count==8)
            o.record9 = getStringValue(s, o);
        if(count==9)
            o.record10 = getStringValue(s, o);
        if(count==10)
            o.record11 = getStringValue(s, o);
        if(count==11)
            o.record12 = getStringValue(s, o);
        if(count==12)
            o.record13 = getStringValue(s, o);
        if(count==13)
            o.record14 = getStringValue(s, o);
        if(count==14)
            o.record15 = getStringValue(s, o);
        if(count==15)
            o.record16 = getStringValue(s, o);
        if(count==16)
            o.record17 = getStringValue(s, o);
        if(count==17)
            o.record18 = getStringValue(s, o);
        if(count==18)
            o.record19 = getStringValue(s, o);
        if(count==19)
            o.record20 = getStringValue(s, o);
    }
    
    public PageReference submit() {
        checkCount();
        if (searchString.replaceAll('[*]','').length()<2) {  
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Your search term must have 2 or more characters.'));  
            return null;
        }
        addRecords = true;
        searchedRecords = searchItems(searchString);
        if(searchedrecords.size()==200)
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Your search result is more then 200'));
        size = searchedrecords.size();
        setList();
        return null;
    }
    
    public List<Record> searchItems(String searchString){
        
        List<Record> records = new List<Record>();
        String returnFields = '';
        for(String o : searchedFields){
            returnFields += o+', ';
        }
        returnFields = returnFields.removeEnd(', ');
        List<List<SObject>> recordList = Search.query('FIND :searchString IN ALL FIELDS RETURNING '+objapi+'('+returnFields+' where RecordType.Name=\'Master Frame Agreement\' AND Id NOT IN :recordsA) LIMIT 200');
        recordList[0].sort();
        for(SObject u : recordList[0]){
            Record r = new Record();
            r.Id = String.valueOf(getValue(u,'Id')==null?'':getValue(u,'Id'));
            r.selected = false;
            Integer z = searchedFields.size();
            for(Integer i=1;i<z;i++){
                String o = searchedFields.get(i);
                if(i==1)
                    r.label1 = String.valueOf(getValue(u,o)==null?'':getValue(u,o));
                if(i==2)
                    r.label2 = String.valueOf(getValue(u,o)==null?'':getValue(u,o));
                if(i==3)
                    r.label3 = String.valueOf(getValue(u,o)==null?'':getValue(u,o));
                if(i==4)
                    r.label4 = String.valueOf(getValue(u,o)==null?'':getValue(u,o));
                if(i==5)
                    r.label5 = String.valueOf(getValue(u,o)==null?'':getValue(u,o));            }
            records.add(r);
        }
        return records;
    }
    
    public Component.Apex.PageBlockTable getSearchedRecord() {
        Component.Apex.PageBlockTable table = new Component.Apex.PageBlockTable(var='a');
        table.expressions.value='{!searchedRecordsList}';
        Component.Apex.inputCheckbox inputCheckbox = new Component.Apex.inputCheckbox();
        inputCheckbox.expressions.value = '{!a.selected}';
        Component.Apex.Column column = new Component.Apex.Column(headerValue='Selection');
        column.width = '5%';
        column.childComponents.add(inputCheckbox);
        table.childComponents.add(column);
        
        Integer z = searchedFields.size();
        for(Integer i=1;i<z;i++){
            if(i==1){
                Component.Apex.OutputPanel outputPanel = new Component.Apex.OutputPanel();
                outputPanel.expressions.onclick='add(\'{!a.id}\')';
                Component.Apex.OutputLabel outputText = new Component.Apex.OutputLabel();
                outputText.expressions.value = '{!a.label'+i+'}';
                outputText.style = 'text-decoration:underline;';
                outputPanel.childComponents.add(outputText);
                outputPanel.onmouseover = 'link(this)';
                outputPanel.onmouseout = 'linkout(this)';
                column = new Component.Apex.Column(headerValue=searchedFields.get(i));
                column.width = 95/z+'%';
                column.childComponents.add(outputPanel);
                table.childComponents.add(column);
            } else {
                Component.Apex.OutputText outputText = new Component.Apex.OutputText();
                outputText.expressions.value = '{!a.label'+i+'}';
                column = new Component.Apex.Column(headerValue=searchedFields.get(i));
                column.width = 95/z+'%';
                column.childComponents.add(outputText);
                table.childComponents.add(column);
            }
        }
        return table;
    }
    
    public Component.Apex.PageBlockTable getMyPageBlockTable() {
        Component.Apex.PageBlockTable table = new Component.Apex.PageBlockTable(var='a');
        table.expressions.value='{!FieldList}';
        table.style = count>5?'width:'+(count+1)*16.66667+'%':'width:100%';
        Component.Apex.OutputText outputText = new Component.Apex.OutputText();
        outputText.expressions.value = '{!a.label}';
        outputText.style = 'font-weight:bold;color:white;';
        Component.Apex.Column column = new Component.Apex.Column(headerValue=objLabel+' Field Name');
        column.childComponents.add(outputText);
        column.width = count>5?100/(count+1)+'%':'20%';
        column.style = 'background-color:#99CCFF;';
        table.childComponents.add(column);
        
        for(Integer i=1;i<=count;i++){
            outputText = new Component.Apex.OutputText();
            outputText.expressions.value = '{!a.record'+i+'}';
            column = new Component.Apex.Column(headerValue='Record '+i);
            column.width = count>5?100/(count+1)+'%':80/count+'%';
            column.childComponents.add(outputText);
            table.childComponents.add(column);
        }
        if(count==0){
            column = new Component.Apex.Column();
            column.width = '80%';
            table.childComponents.add(column);
        }
        return table;
    }
    
    private String getStringValue(SObject sObj, ObjectLabel o){
        
        //return o.type;
        if('MULTIPICKLIST'.equals(o.type)){
            if(getValue(sObj, o.apiName)==null)
                return '';
            String value = '';
            for(String s:String.valueOf(getValue(sObj, o.apiName)).split('[;]'))
                value += s.trim() + ', ';
            return value.removeEnd(', ');
        } else if('DATE'.equals(o.type)){
            if(getValue(sObj, o.apiName)==null)
                return '';
            return String.valueOf(((DateTime)getValue(sObj, o.apiName)).date());
        } else
            return String.valueOf(getValue(sObj, o.apiName));
    }
    
    private Object getValue(SObject sObj, String attr){
        
        String[] info = attr.split('[.]',2);
        if(info.size()>1){
            if(sObj.getSObject(info[0])==null)
                return '';
            return getValue(sObj.getSObject(info[0]),info[1]);
        } else {
            return sObj.get(attr);
        }
    }
    
    private void setList(){
        searchedRecordsList = new List<Record>();
        showSize = (size > 8)?(8):(size);
        for(Integer i=0;i<showSize;i++){
            searchedRecordsList.add(searchedRecords.get(i));
        }
        offset = 0;
        if((size-offset-8)<=0)
            showNext = false;
        else
            showNext = true;
        if(offset==0)
            showPrevious = false;
        else
            showPrevious = true;
    }
    
    public PageReference next() {
    
        searchedRecordsList = new List<Record>();
        offset += 8;
        if((size-offset-8)<=0){
            showNext = false;
            showSize = size;
        }else {
            showNext = true;
            showSize = offset + 8;
        }
        if(offset==0)
            showPrevious = false;
        else
            showPrevious = true;
        for(Integer i=offset;i<showSize;i++)
            searchedRecordsList.add(searchedRecords.get(i));
        return null;
    }

    public PageReference previous() {
    
        searchedRecordsList = new List<Record>();
        offset -= 8;
        showSize = offset + 8;
        if((size-offset-8)<=0)
            showNext = false;
        else
            showNext = true;
        if(offset==0)
            showPrevious = false;
        else
            showPrevious = true;
        for(Integer i=offset;i<showSize;i++)
            searchedRecordsList.add(searchedRecords.get(i));
        return null;
    }
    
    public PageReference exportAsXLS() {
        checkCount();
        PageReference csvPage = new PageReference( '/apex/FAComparerXLS' );
        csvPage.getHeaders().put('content-disposition', 'attachemnt; filename=FAComparer-'+System.Now().getTime()+'.xls');
        return csvPage;
    }

    public PageReference exportAsPDF() {
        checkCount();
        PageReference pdfPage = new PageReference( '/apex/FAComparerPDF' );
        pdfPage.getHeaders().put('content-disposition', 'attachemnt; filename=FAComparer-'+System.Now().getTime()+'.pdf');
        return pdfPage;
    }
    
    private void checkCount(){
        if(!viewCheck){
            if(viewCount==1){
                insert new SFDC_Support_Case__c(Type__c = 'Counter',Application__c = 'FAComparer',User_SSO__c = '1');
            } else {
                SFDC_Support_Case__c views = [Select Id from SFDC_Support_Case__c where Type__c = 'Counter' AND Application__c = 'FAComparer' Limit 1];
                views.User_SSO__c = String.valueOf(viewCount);
                update views;
            }
            viewCheck = true;
        }
    } 
}