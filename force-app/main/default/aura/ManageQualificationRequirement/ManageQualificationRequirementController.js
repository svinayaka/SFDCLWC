({
    init: function (component, event, helper) {
        var jobId= component.get("v.jobId");
        console.log('jobidfromchildcomp'+jobId);
        component.set("v.jobId",jobId);
        helper.fetchData(component, event, 100);  
    },
    
    
    
    updateSelectedText: function (component, event) {
        var selectedRows = event.getParam('selectedRows');
        component.set("v.selectedRowsCount",selectedRows.length);
        var qualifications= selectedRows;
        console.log('NewwwwwJollypbookItemList'+qualifications);
        component.set("v.qualificationList",qualifications);
        
    },
    
    
    Save: function (component, event, helper) {
        
        var qlist=JSON.stringify(component.get("v.qualificationList"));
        console.log('NewwwwwqualificationList'+qlist);
        var jobId= component.get("v.jobId");
        
        var action = component.get("c.updateqReqList");
        {
            action.setParams({ 
                qualificationList :qlist,
                jobId: jobId
            }); 
            
            
            action.setCallback(this, function(response){
                var state = response.getState();
                var message = response.statusmessage;
                var message = JSON.stringify(response.statusmessage);
                
                
                console.log('message'+message);
                if (state === "SUCCESS") {
                    //helper.showToast(message);
                    helper.navigateToSobject(jobId);
                   helper.childComponentEvent(component, event,helper);
                    
                }
                
                else{
                    console.log("ERROR");
                }
            });
            
            $A.enqueueAction(action); 
        }
        
    },
    
    cancel : function(component, event, helper) 
    {
        component.set("v.show",false); 
        helper.childComponentEvent(component, event,helper); 
        
    },
    
    filter : function (component, event, helper)
    {
        helper.filter(component, event, helper);
    }
 
    
});