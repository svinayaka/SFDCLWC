({
    doInit : function(component, event, helper) {
        component.get("v.cureentId");
    },
    onsubmit : function(component, event, helper) {
        event.preventDefault();
        
        var fields = event.getParam('fields');
        var final=JSON.stringify(fields);
        
        var action =component.get("c.getInsertRecord");
        action.setParams({
            ref : final  });
        var navEvt = $A.get("e.force:navigateToSObject");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var redirectId=response.getReturnValue();
               
                var myEvent = $A.get("e.c:SendDataToVFPage");
                myEvent.setParams({
                    currentRecId: redirectId,  
                });
                myEvent.fire();
                
            }
            
        }); 
        
        $A.enqueueAction(action);
    },
    
    
    
})