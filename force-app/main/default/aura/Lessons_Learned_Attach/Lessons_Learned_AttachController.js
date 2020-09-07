({
    
    
    doInit : function(component, event, helper) { 
        var loading = component.find("loading");
        $A.util.removeClass(loading, "slds-hide");
        var workOrderRecId = component.get("v.workOrderRecId");
        if(!$A.util.isEmpty(workOrderRecId)){
            component.set("v.showAttach",true);
            component.set("v.hideCheckbox",false);
            
        }
        else{
            component.set("v.lessonsLearnt",true);
            component.set("v.hideCheckbox",true);
            component.set("v.showAttach",false);
            component.set("v.showButtons",true);
            helper.getFieldSet(component,event, helper); 
        }
        helper.getCountry(component,event, helper);
        helper.getJobType(component,event, helper);
        helper.getLessonLearnedType(component,event, helper);
        helper.getProductCategory(component,event, helper);
        helper.getProductGroup(component,event, helper);
        helper.getStatus(component,event, helper);
        helper.getCasePickListValues(component,event, helper);
        
        
        
    },
    searchLessonLearned : function(component, event, helper) {  
        var actions = [{ label: 'Show details', name: 'show_details' }];
        var fieldSetMap = component.get("v.fieldSetMap");
        var columns = [];
        columns.push({ type: 'action', typeAttributes: { rowActions: actions } });
        for(var key in fieldSetMap){
            var splitLable = fieldSetMap[key].split(';');
            console.log('-splitLable[0]----'+splitLable[0]);
            if(splitLable[0] == 'REFERENCE'){
                columns.push({label: splitLable[1], fieldName: key,type: 'text',sortable: true});
            }
            else{
                columns.push({label: splitLable[1], fieldName: key, editable:'true', type: 'text',sortable: true});
            }
        } 
        component.set('v.columns', columns);
        var selectedType;
        if(component.get("v.showAttach")){
            selectedType = component.find('selectType').get('v.value');  
        }            
        if(selectedType == 'NPT Case' || selectedType == 'SIR-CaM'){
            helper.getCases(component,event, helper);
        }
        else{ 
            helper.getRecords(component,event,helper);
        }
        
    },
    showMoreFilters : function(component, event, helper) { 
        component.set("v.showFilters",true);
        component.set("v.showFilterButton",false);
        var searchButton = component.find("searchButton");
        $A.util.addClass(searchButton, "buttonStyle2");	
        
    },
    hideFilters :function(component, event, helper){
        component.set("v.hideFilters",false);
    },
    showFilters :function(component, event, helper){
        component.set("v.hideFilters",true);
    },
    onSave : function (component, event, helper) {
        helper.saveDataTable(component, event, helper);
        helper.getRecords(component, helper);
    },
    handleRowAction : function(cmp,event,helper){
        var action = event.getParam('action');
        var row = event.getParam('row');
        console.log('---row--'+row.Id);
        //var url = '/'+row.Id+'?isdtp=vw';
        var url = '/'+row.Id;
        window.open(url, '_blank');
        
    },
    updateColumnSorting: function(component, event, helper) {
        var fieldName = event.getParam('fieldName');
        var sortDirection = event.getParam('sortDirection');
        // assign the latest attribute with the sorted column fieldName and sorted direction
        component.set("v.sortedBy", fieldName);
        component.set("v.sortedDirection", sortDirection);
        console.log('----------inside 1');
        helper.sortData(component, fieldName, sortDirection,event);
    },
    selectType:function(component, event, helper) {
        var selectedType = component.find('selectType').get('v.value');  
        console.log('selectedType--'+selectedType);
        component.set('v.dataLoaded', false);
        
        component.set("v.showButtons",true);
        if(selectedType == 'NPT Case'){
            component.set("v.NPTCase",true);
            component.set("v.SIRCaMCase",false);
            component.set("v.lessonsLearnt",false);  
            component.set("v.recType","SS_NPT");
        } 
        else if(selectedType == 'SIR-CaM'){
            component.set("v.SIRCaMCase",true);
            component.set("v.lessonsLearnt",false);  
            component.set("v.NPTCase",false);
            component.set("v.recType","SIR - CaM");
        }
            else{
                component.set("v.lessonsLearnt",true);  
                component.set("v.NPTCase",false);
                component.set("v.SIRCaMCase",false);
                component.set("v.recType","lessonsLearnt");
            }
        helper.getFieldSet(component,event, helper); 
        
    },
    attachNewRecords:function(component, event, helper) {
        var loading = component.find("loading");
        $A.util.removeClass(loading, "slds-hide");
        var selectedType = component.find('selectType').get('v.value');  
        var workOrderRecId = component.get("v.workOrderRecId");
        console.log('--inside attach'); 
        var action = component.get("c.attachRecords");         
        action.setParams({ 
            "selectedType":selectedType,
            "idList":  component.get("v.recordList"),   
            "workOrderId":workOrderRecId
        });
        action.setCallback(this,function(response) {
            var state = response.getState();
            console.log('----state----'+state);
            if (state === "SUCCESS") {
                var successMessage = response.getReturnValue();
                alert(successMessage);
                if(selectedType == 'NPT Case' || selectedType == 'SIR-CaM'){
                    helper.getCases(component,event, helper);
                }
                else{ 
                    helper.getRecords(component,event,helper);
                }
            }
        });
        $A.enqueueAction(action);   
        
    },
    updateSelectedText: function (component, event) {
        var selectedRows = event.getParam('selectedRows');        
        var idList = [];        
        for (var i = 0; i < selectedRows.length; i++){
            idList.push(selectedRows[i].Id);
        }
        console.log('--idList--'+JSON.stringify(idList));
        component.set("v.recordList",idList);
        component.set("v.activeButton",false);
        console.log("--recordList---"+component.get("v.recordList"));
        
    },
    clickBackButton:function (component, event) {            
        window.history.back();     
        
    }
    
})