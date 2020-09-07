({
    fetchData: function (component, event, numberOfRecords) {
        
        console.log("JobIddddddddd"+component.get("v.jobId"));
        component.set('v.columns', [
            {label: 'Id ', fieldName: 'Name', type: 'text'},
           
            {label: 'Tier 4', fieldName: 'SD_PBI_Tier_4__c', type: 'text'},
            {label: 'Tier 5', fieldName: 'SD_PBI_Tier_5__c', type: 'text'},
            {label: 'Job Type', fieldName: 'SD_PBI_Tier_6__c', type: 'text'},
            {label: 'Job Sub-Type', fieldName: 'SD_PBI_Tier_7__c', type: 'text'}
             
                       
         ]);
        
        var action = component.get("c.fetchPriceBookItem");
        action.setParams({ jobId: component.get("v.jobId")
                         });
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log('itemsssssssss'+response.getReturnValue());
                component.set("v.data", response.getReturnValue());
                component.set("v.filteredData", response.getReturnValue());
               // console.log("filterdata"+component.get("v.filteredData"));
            }
        });
        $A.enqueueAction(action); 
    },
    
    filter: function(component, event, helper) {
        var data = component.get("v.filteredData"),
            term = component.get("v.filter"),
            results = data, regex;
        try {
            regex = new RegExp(term, "i");
            if(term.length > 0){
            // filter checks each row, constructs new array where function returns true
            results = data.filter(row=>regex.test(row.Name) || regex.test(row.SD_PBI_Tier_3__c) || regex.test(row.FX5__Catalog_Description__c) || regex.test(row.SD_PBI_Tier_6__c) || regex.test(row.SD_PBI_Tier_7__c));
            }
            else{
             //console.log('Line at 38');  
             results = component.get("v.data"); 
            }
        } catch(e) {
            // invalid regex, use full list
             console.log('Line at 43');
            results = component.get("v.data");
        }
        component.set("v.filteredData", results);
    },
    
        navigateToSobject: function(recordId)
    {
      
    	var navEvt = $A.get("e.force:navigateToSObject");       
		navEvt.setParams({"recordId": recordId,"slideDevName": "detail"});
		navEvt.fire(); 
       $A.get('e.force:refreshView').fire();
        
	},
    
    
     childComponentEvent : function(component, event,helper) { 
        //Get the event using registerEvent name. 
        var cmpEvent = component.getEvent("SDJobItemEvent"); 
        //Set event attribute value
        cmpEvent.setParams({"setshow" : false}); 
        cmpEvent.fire(); 
    }
    
   
    

});