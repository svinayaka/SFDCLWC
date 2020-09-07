({
    fetchData: function (component, event, numberOfRecords) {
        
        console.log("JobIddddddddd"+component.get("v.jobId"));
        component.set('v.columns', [
            {label: 'Name ', fieldName: 'Name', type: 'text'},
            {label: 'Qualification ID', fieldName: 'FX5__Abbreviation__c', type: 'text'},
            {label: 'Qualification Type', fieldName: 'SD_Qualification_Type__c', type: 'text'}
            
                       
         ]);
        
        var action = component.get("c.fetchQualification");
        action.setParams({ currentjobId: component.get("v.jobId")
                         });
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.data", response.getReturnValue());
                component.set("v.filteredData", response.getReturnValue());
            }
        });
        $A.enqueueAction(action); 
    },
    
    filter: function(component, event, helper) {
        console.log('Line at 27--->',component.get("v.filteredData"));
        //var completedata = component.get("v.data"),
        var data = component.get("v.filteredData"),
            term = component.get("v.filter"),
            results = data, regex;
        try {
            regex = new RegExp(term, "i");
            console.log('Line 34',term.length);
            if(term.length > 0){
                console.log('Line at 36')
            // filter checks each row, constructs new array where function returns true
            results = data.filter(row=>regex.test(row.Name) || regex.test(row.SD_Qualification_ID__c) || regex.test(row.SD_Qualification_Type__c));
            }
            else
            {
                //result=data;
                console.log('Line at 43',component.get("v.data"));
                results = component.get("v.data");
            }
         
        } catch(e) {
             // invalid regex, use full list
            console.log('Line at 48',component.get("v.data"));          
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
    
     showToast : function(customErrorMsg )
{
    var toastEvent = $A.get("e.force:showToast");
    toastEvent.setParams({
        "type": "error",
        "title": "Error!",
        "message": customErrorMsg
    });
    toastEvent.fire();

} ,
    
     showToastSuccess : function(customErrorMsg )
{
    var toastEvent = $A.get("e.force:showToast");
    toastEvent.setParams({
        "type": "success",
        "title": "Success",
        "message": customErrorMsg
    });
    toastEvent.fire();

} ,
    
    childComponentEvent : function(component, event,helper) { 
        var cmpEvent = component.getEvent("SDJobItemEvent"); 
        cmpEvent.setParams({"setshow" : false}); 
        cmpEvent.fire(); 
    }
    
   


});