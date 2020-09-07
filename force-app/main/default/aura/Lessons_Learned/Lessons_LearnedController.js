({
    

   doInit : function(component, event, helper) { 
       
        helper.getCountry(component,event, helper);
        helper.getJobType(component,event, helper);
        helper.getLessonLearnedType(component,event, helper);
        helper.getProductCategory(component,event, helper);
        helper.getProductGroup(component,event, helper);
        helper.getStatus(component,event, helper);
        helper.getFieldSet(component,event, helper); 
        
      
    },
   searchLessonLearned : function(component, event, helper) {   
       var actions = [{ label: 'Show details', name: 'show_details' }];
       var fieldSetMap = component.get("v.fieldSetMap");
       var columns = [];
       columns.push({ type: 'action', typeAttributes: { rowActions: actions } });
       for(var key in fieldSetMap){ 
                //console.log('---key--'+key);
                // console.log('value----'+fieldSetMap[key]);
           var splitLable = fieldSetMap[key].split(';');
              /*  if(fieldSetMap[key] == 'REFERENCE'){
                    console.log('---row.key.Name'+row.key.Name);
                    if (row.key) row.key = row.key.Name;
                }*/
           console.log('-splitLable[0]----'+splitLable[0]);
           if(splitLable[0] == 'REFERENCE'){
               columns.push({label: splitLable[1], fieldName: key,type: 'text',sortable: true});
           }
           else{
               columns.push({label: splitLable[1], fieldName: key, editable:'true', type: 'text',sortable: true});
           }
         } 
       component.set('v.columns', columns);
        /*component.set('v.columns', [            
            { type: 'action', typeAttributes: { rowActions: actions } },
            {label: 'Work Order', fieldName: 'GE_OG_Work_Order__c', editable:'true', type: 'text'},
            {label: 'Product Category', fieldName: 'GE_SS_Product_Category__c', editable:'true', type: 'text'},
            {label: 'Subject', fieldName: 'GE_OG_Subject__c', editable:'true', type: 'text'},
            {label: 'Account', fieldName: 'GE_OG_Account__c', editable:'true', type: 'text'},
            {label: 'Field', fieldName: 'GE_OG_Location__c', editable:'true', type: 'text'},
            {label: 'Product Group', fieldName: 'Product_Group__c', editable:'true', type: 'text'},
            {label: 'Status', fieldName: 'Status__c', editable:'true', type: 'text'},
            {label: 'Product ID', fieldName: 'GE_SS_Product__c', editable:'true', type: 'text'},
            {label: 'Lessons Learned Type', fieldName: 'Lessons_Learned_Type__c', editable:'true', type: 'text'},
            {label: 'Job Type', fieldName: 'GE_OG_Job_Type__c', editable:'true', type: 'text'},
            {label: 'Country', fieldName: 'GE_OG_Country__c', editable:'true', type: 'text'},
            {label: 'Project Region', fieldName: 'GE_OG_Project_Region__c', editable:'true', type: 'text'},
            {label: 'FS Project', fieldName: 'GE_SS_FS_Project__c', editable:'true', type: 'text'},
            {label: 'Created Date', fieldName: 'Created Date', editable:'true', type: 'Date'} 
            
            
       ]); */       
        helper.getRecords(component, helper);
        

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
    }
})