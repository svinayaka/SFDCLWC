({
    doInit : function(component,event,helper){
        console.log('do init for case rec type flip type called');
        helper.initHelper(component,event);
    },
    
    handleClick : function(component, event, helper) {
        console.log('change record type clicked');
        component.set("v.showModal",true);
    },
    
    handleRecordTypeChange : function(component,event,helper){
        console.log('handle flip called');
        console.log('caseId value',component.get("v.recordId"));
        component.set("v.actionInProgress",true);
        var action = component.get("c.flipCaseRecordTypeServer");
        action.setParams({ caseId : component.get("v.recordId") });
        action.setStorable();
        action.setCallback(this, function(response) {
            console.log('inside callback');
            var state = response.getState();
            if (state === "SUCCESS") {
                var res = response.getReturnValue();
                console.log('inside success',res);
                if(res=='validation error'){
                    console.log('inside error clone and attach');
                    component.set("v.actionInProgress",false);
                    component.set('v.exceptionMessage','Please fill account and contact information before updating the record type');
                    component.set('v.isRunTimeError',true);
                }
                else{
                var showToast = $A.get("e.force:showToast"); 
                showToast.setParams({ 
                    'title' : 'Case Updated!', 
                    'message' : 'The record type has been updated sucessfully.' 
                }); 
                showToast.fire(); 
                $A.get('e.force:refreshView').fire();
                }
            }
            else if (state === "INCOMPLETE") {
                // do something
            }
                else if (state === "ERROR") {
                    console.log('inside error clone and attach');
                    component.set("v.actionInProgress",false);
                    var errorString = '';
                    var errors = response.getError();
                    console.log('errors clone and attach',errors);
                    helper.handleError(component, event, errors);
                }
            component.set("v.actionInProgress",false);
        });
        
        $A.enqueueAction(action);
    },
    closeModal : function(component,event,helper){
        console.log('close modal clicked');
        component.set("v.showModal",false);
    },
    
    handleTrashBin : function(component,event,helper){
        console.log('clicked trash bin');
        component.set("v.actionInProgress",true);
        var action = component.get("c.moveToTrashBin");
        action.setParams({ caseId : component.get("v.recordId") });
        action.setStorable();
        action.setCallback(this, function(response) {
            console.log('inside callback');
            var state = response.getState();
            if (state === "SUCCESS") {
                var res = response.getReturnValue();
                console.log('inside success',res);
                var showToast = $A.get("e.force:showToast"); 
                showToast.setParams({ 
                    'title' : 'Case Owner Updated!', 
                    'message' : 'The case owner has been updated sucessfully.' 
                }); 
                showToast.fire(); 
                $A.get('e.force:refreshView').fire();
                
                /* if(res=='update success')
                    console.log('updated record type successfully');
                else if(res=='validation error')
                    console.log('validation error account and contact not found.');*/
            }
            else if (state === "INCOMPLETE") {
                // do something
            }
                else if (state === "ERROR") {
                    console.log('inside error clone and attach');
                    component.set("v.actionInProgress",false);
                    var errorString = '';
                    var errors = response.getError();
                    console.log('errors clone and attach',errors);
                    helper.handleError(component, event, errors);
                }
            component.set("v.actionInProgress",false);
            
        });
        
        $A.enqueueAction(action);
    },
    
    handleCloneAndAttach : function(component,event,helper){
        console.log('clone and attach operation');
        component.set("v.actionInProgress",true);
        var action = component.get("c.cloneCaseAndAttachServer");
        action.setParams({ caseId : component.get("v.recordId") });
        action.setStorable();
        action.setCallback(this, function(response) {
            console.log('inside callback');
            var state = response.getState();
            if (state === "SUCCESS") {
                var res = response.getReturnValue();
                console.log('inside success',res);
                var showToast = $A.get("e.force:showToast"); 
                showToast.setParams({ 
                    'title' : 'Case cloned with attachments', 
                    'message' : 'The case has been successfully cloned along with the attachments.' 
                }); 
                showToast.fire(); 
                var navEvt = $A.get("e.force:navigateToSObject");
                navEvt.setParams({
                    "recordId": res,
                    "slideDevName": "Detail"
                });
                navEvt.fire();
            }
            else if (state === "INCOMPLETE") {
                // do something
            }
                else if (state === "ERROR") {
                    console.log('inside error clone and attach');
                    component.set("v.actionInProgress",false);
                    var errorString = '';
                    var errors = response.getError();
                    console.log('errors clone and attach',errors);
                    helper.handleError(component, event, errors);
                }
            component.set("v.actionInProgress",false);
        });
        
        $A.enqueueAction(action);
    },
    
    openCloneCaseModal : function(component,event,helper){
        console.log('open clone Modal');
        component.set("v.showCloneCaseModal",true);
    },
    
    closeCloneCaseModal : function(component,event,helper){
        console.log('case clone modal closed');
        component.set("v.showCloneCaseModal",false);
    },
    
    handleChangeToCurrentOwner: function(component, event, helper)
    {
        var caseId = component.get("v.recordId");
        console.log('caseId' ,caseId);
        component.set("v.actionInProgress",true);
        var action = component.get("c.acceptCase");
        action.setParams({"caseId":caseId});
        action.setStorable();
        action.setCallback(this, function(a){
            var state = a.getState();
            if (state === "SUCCESS"){
                var result = a.getReturnValue();
                console.log("Result :", JSON.stringify(result));
                if(result == 'Owner Updated Successfully')
                {  
                    var showToast = $A.get("e.force:showToast"); 
                    showToast.setParams({ 
                        'title' : 'Case Updated!', 
                        'message' : 'The Owner has been sucessfully updated	.' 
                    });
                    showToast.fire();
                    $A.get('e.force:refreshView').fire();
                    
                } 
            }
            else if (state === "INCOMPLETE") {
                // do something
            }
                else if (state === "ERROR") {
                    console.log('inside error clone and attach');
                    component.set("v.actionInProgress",false);
                    var errorString = '';
                    var errors = a.getError();
                    console.log('errors clone and attach',errors);
                    helper.handleError(component, event, errors);
                }
            
            component.set("v.actionInProgress",false);
        });
        
        $A.enqueueAction(action); 
        
        
    },
    
    handleChangeToPreviousOwner: function(component, event, helper)
    {
        var caseId = component.get("v.recordId");
        console.log('caseId' ,caseId);
        component.set("v.actionInProgress",true);
        var action = component.get("c.returnCase");
        action.setParams({"caseId":caseId});
        action.setStorable();
        action.setCallback(this, function(a){
            var state = a.getState();
            if (state === "SUCCESS"){
                var result = a.getReturnValue();
                console.log("Result :", JSON.stringify(result));
                if(result == 'Owner Reverted')
                {  
                    var showToast = $A.get("e.force:showToast"); 
                    showToast.setParams({ 
                        'title' : 'Case Updated!', 
                        'message' : 'The Owner has been sucessfully Reverted' 
                    });
                    showToast.fire();
                    $A.get('e.force:refreshView').fire();
                    
                }
            }
            else if (state === "INCOMPLETE") {
                // do something
            }
                else if (state === "ERROR") {
                    console.log('inside error clone and attach');
                    component.set("v.actionInProgress",false);
                    var errorString = '';
                    var errors = a.getError();
                    console.log('errors clone and attach',errors);
                    helper.handleError(component, event, errors);
                }
            component.set("v.actionInProgress",false);
        });
        
        $A.enqueueAction(action); 
        
        
    },
    
    changeHasError: function(component, event)
    {
        console.log("entring changeHasError");
        component.set("v.hasError",false);
        component.set("v.errorMessage",'');
        
        
        
    },
    
    closeCase : function(component, event, helper)
    {           
        console.log("inside close case");
        console.log('calling inithelper from case close');
        var caseId = component.get("v.recordId");
        console.log('caseId' ,caseId);
        var action = component.get("c.caseDetailServer");
        action.setParams({"caseId":caseId});
        action.setStorable();
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log('case ret helper success');
                var res = response.getReturnValue();
                component.set("v.caseRecord",res); 
                console.log('controller validate case Record',res);
                helper.validateCase(component, event, res);
            } 
            
        });
        $A.enqueueAction(action);
              
        
    },  
    
    
    handleModal : function(component,event,helper){
        console.log('button closed clicked');
        helper.validateCase(component,event,component.get("v.caseRecord"));
        component.set("v.openModal",true);
    },
    
    closeErrorAlert : function(component,event,helper){
        component.set("v.isRunTimeError",false);
    }
    
    
    
})