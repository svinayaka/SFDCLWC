({
    doInit : function(component,event,helper){
        console.log('do init for case rec type flip type called');
        helper.initHelper(component,event);
        var action = component.get("c.fetchProfile");     
        
        action.setCallback(this, function(response) {    
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.profileName",response.getReturnValue());  
            }
            
        });
        
        $A.enqueueAction(action); 
    },
    
    handleRecordTypeChange : function(component,event,helper){
        console.log('handle flip called');
        console.log('caseId value',component.get("v.recordId"));
        component.set("v.actionInProgress",true);
        var action = component.get("c.flipCaseRecordTypeServer");
        action.setParams({ caseId : component.get("v.recordId") });
        //action.setStorable();  
        action.setCallback(this, function(response) {
            console.log('inside callback');     
            var state = response.getState();
            if (state === "SUCCESS") {
                var res = response.getReturnValue();
                console.log('inside success',res);
                var showToast = $A.get("e.force:showToast"); 
                showToast.setParams({ 
                    'title' : 'Case Updated!', 
                    'message' : 'The record type has been updated sucessfully.' 
                }); 
                showToast.fire(); 
                $A.get('e.force:refreshView').fire();
            }
            else if (state === "INCOMPLETE") {
                // do something
            }
                else if (state === "ERROR") {
                    component.set("v.actionInProgress",false);
                    var errorString = '';
                    var errors = response.getError();
                    helper.handleError(component, event, errors);
                }
            component.set("v.actionInProgress",false);
        });
        
        $A.enqueueAction(action);
    },
    
    handleTrashBin : function(component,event,helper){  
        component.set("v.actionInProgress",true);
        var action = component.get("c.moveToTrashBin");  
        action.setParams({ caseId : component.get("v.recordId") });    
        // action.setStorable();
        action.setCallback(this, function(response) {   
            console.log('inside callback');     
            var state = response.getState();    
            if (state === "SUCCESS") {
                var res = response.getReturnValue();
                var showToast = $A.get("e.force:showToast"); 
                showToast.setParams({   
                    'title' : 'Case Owner Updated!', 
                    'message' : 'Case moved to Trash bin Successfully.' 
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
                    component.set("v.actionInProgress",false);
                    var errorString = '';
                    var errors = response.getError();
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
        var caseId = component.get("v.recordId");     
        var action = component.get("c.caseDetailServer");
        setTimeout(function() {              
        	component.set("v.isCloseCase",true);         
        }, 3000);
        action.setParams({"caseId":caseId});                     
        // action.setStorable(); 
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                var res = response.getReturnValue();
                component.set("v.caseRecord",res); 
                helper.validateCase(component, event, res);
            } 
            
        });
        $A.enqueueAction(action);
        
        
    },  
    
    editButton : function (component, event, helper) {     
        var profileName = component.get("v.profileName");    
        
        if( profileName == 'CIR Company Community')   
        {
            var errorMessage = "You cannot edit the case";
            component.set("v.hasError",true);
            component.set("v.errorMessage",errorMessage);
            
        }
        else{
            var editRecordEvent = $A.get("e.force:editRecord");
            editRecordEvent.setParams({
                "recordId": component.get("v.recordId")  
            });
            editRecordEvent.fire(); 
            
        }
    },
    
    transferToCIR : function (component, event, helper) {  
        var recordId = component.get("v.recordId");
        var profileName = component.get("v.profileName");
        if( profileName == 'CIR Company Community') 
        { 
            var errorMessage = "You cannot transfer the case";
            component.set("v.hasError",true);
            component.set("v.errorMessage",errorMessage);
        } 
        else 
        { 
            var r=confirm("Are you Sure you want to transfer this case to CIR?");    
            if (r==true) 
            { 
                var urlEvent = $A.get("e.force:navigateToURL");       
                urlEvent.setParams({
                    "url": "/apex/GE_OG_MCTStoCIR_CaseTransfer?id="+recordId,
                    "isredirect": "true"
                });
                urlEvent.fire();
                
            }   
        }
    },
    
    
    closeErrorAlert : function(component,event,helper){   
        component.set("v.isRunTimeError",false);
    },	
    
    
    toggleVisibility : function(component, event, helper){
        
        var ddDiv = component.find('drpdwn');
        $A.util.toggleClass(ddDiv,'slds-is-open');  
        
    },
    acceptCaseRec :function(component, event, helper){
        component.set("v.actionInProgress",true);
        var action = component.get("c.acceptCase");    
        action.setParams({ caseId : component.get("v.recordId") });    
        // action.setStorable();
        action.setCallback(this, function(response) {     
            var state = response.getState();   
            if (state === "SUCCESS") {
                var res = response.getReturnValue();
                var showToast = $A.get("e.force:showToast"); 
                showToast.setParams({   
                    'title' : 'Case Owner Updated!', 
                    'message' : 'Case Owner updated successfully.' 
                }); 
                showToast.fire(); 
                $A.get('e.force:refreshView').fire();               
            }
            else if (state === "INCOMPLETE") {
                // do something
            }
                else if (state === "ERROR") {
                    component.set("v.actionInProgress",false);
                    var errorString = '';
                    var errors = response.getError();
                    helper.handleError(component, event, errors);
                }
            component.set("v.actionInProgress",false);
            
        });
        
        $A.enqueueAction(action);
    },
    
    select: function(component,event,helper){
        var selecteditem = event.currentTarget;
        
        var seletedMenuItem = selecteditem.dataset.id;
        
        if(seletedMenuItem == "TS-CC"){  
            var a = component.get('c.handleRecordTypeChange');  
            $A.enqueueAction(a); 
        }
        else if(seletedMenuItem == "Transfer to CIR"){           
            var a = component.get('c.transferToCIR');                  
            $A.enqueueAction(a);
        }
        else{
             console.log("Do Nothing");      
        }
      /*  else if(seletedMenuItem == "Trashbin"){
            var a = component.get('c.handleTrashBin');
            $A.enqueueAction(a);
        }
        else if(seletedMenuItem == "Close Case"){
            var a = component.get('c.closeCase');    
            $A.enqueueAction(a);  
        }		
        else if(seletedMenuItem == "Edit"){
            var a = component.get('c.editButton');
            $A.enqueueAction(a);
        }
        else if(seletedMenuItem == "Accept"){   
            var a = component.get('c.acceptCaseRec');                  
            $A.enqueueAction(a); 
        }*/
        
        
    },
    /*
    selectUpdateCaseAction : function( cmp, event, helper) {
        //alert('--inside function1--');      
        var actionAPI = cmp.find("quickActionAPI");
        var args = {actionName: "Case.Change_Owner"};  
        actionAPI.selectAction(args).then(function(result){
            //Action selected; show data and set field values       
           
        }).catch(function(e){
            if(e.errors){
                //If the specified action isn't found on the page, show an error message in the my component 
            }
        });  
    },
    
    updateCaseStatusAction : function( cmp, event, helper ) {           
       // alert('----update--');   
        var actionAPI = cmp.find("quickActionAPI");   
        var fields = {Status: {value: "Closed"}, Subject: {value: "Sets by lightning:quickActionAPI component"}, accountName: {Id: accountId}};
        var args = {actionName: "Case.Change_Owner", entityName: "Case", targetFields: fields};
        actionAPI.setActionFieldValues(args).then(function(){
            actionAPI.invokeAction(args);
        }).catch(function(e){  
            console.error(e.errors);
        });
    }
        */
    
    
})