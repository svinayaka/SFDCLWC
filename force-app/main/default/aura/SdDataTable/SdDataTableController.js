({
    init: function (component, event, helper) {
        
        helper.fetchData(component, event, 100);  
    },
    
    updateSelectedText: function (component, event) {
        var selectedRows = event.getParam('selectedRows');
        component.set("v.selectedRowsCount",selectedRows.length);
        var pbookItems= selectedRows;
        console.log('NewwwwwJollypbookItemList'+pbookItems);
        component.set("v.pbookItemList",pbookItems);
        
    },
    
    
    Save: function (component, event, helper) {
        
        var now=JSON.stringify(component.get("v.pbookItemList"));
        console.log('NewwwwwJollypbookItemList'+now);
        var jobId= component.get("v.jobId");
        
        
        var action = component.get("c.UpdatepbookitmList");
        {
            var stringjobitemlist= JSON.stringify(component.get("v.pbookItemList"));
            action.setParams({ 
                pbookItemList :stringjobitemlist,
                jobId: component.get("v.jobId")
            }); 
            
            
            action.setCallback(this, function(response){
                var state = response.getState();
                if (state === "SUCCESS") {
                    helper.navigateToSobject(jobId); 
                    helper.childComponentEvent(component, event,helper);
                    
                }
            });
            
            $A.enqueueAction(action); 
        }
        
        // helper.childComponentEvent(component, event,helper);
        
    },
    
    cancel : function(component, event, helper) 
    {  
        helper.childComponentEvent(component, event,helper)
        //var jobId = component.get("v.jobId");
       // helper.navigateToSobject(jobId);
    },
    
    filter : function (component, event, helper)
    {
        helper.filter(component, event, helper);   
    },
    
    
    
      
});