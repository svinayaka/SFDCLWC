({
    myAction : function(component, event, helper) {
        
    },
    showPPFields : function(component, event, helper) {
        component.set("v.showPPfields",true);
    },
    handleOnSuccess : function(component, event, helper) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "type": "Success",
            "title": "Success:",
            "message": "The record saved successfully."
        });
        toastEvent.fire();
        $A.get('e.force:refreshView').fire();
        component.set("v.showPPfields",false);
    },
    closemodel : function(component, event, helper) {
        component.set("v.showPPfields",false);
    }
})