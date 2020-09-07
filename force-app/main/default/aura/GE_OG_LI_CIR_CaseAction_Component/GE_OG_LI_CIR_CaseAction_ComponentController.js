({
    doInit : function(component,event,helper){
        //alert('do init for case rec type flip type called');      
        var loading = component.find("loading");
        $A.util.addClass(loading, "slds-hide");
        var caseId = component.get("v.recordId");  
         
        helper.getCaseRec(component,event,helper);    
        var action = component.get("c.fetchProfile");     
       
        action.setCallback(this, function(response) {    
            var state = response.getState();
            if (state === "SUCCESS") {  
                component.set("v.profileName",response.getReturnValue());
            }
            
        });
          
        $A.enqueueAction(action); 
    },
    
    
    handleClick : function(component, event, helper) {
        console.log('change record type clicked');
        component.set("v.showModal",true);
    },
    
    
    closeModal : function(component,event,helper){
        console.log('close modal clicked');
        component.set("v.showModal",false);
    },
    openCloneCaseModal : function(component,event,helper){
        console.log('open clone Modal');
        component.set("v.showCloneCaseModal",true);
    },
    
    closeCloneCaseModal : function(component,event,helper){
        console.log('case clone modal closed');
        component.set("v.showCloneCaseModal",false);
    },
    
    changeHasError: function(component, event)
    {
        console.log("entring changeHasError");
        component.set("v.hasError",false);
        component.set("v.errorMessage",'');
        
        
        
    }, 
    closeCase : function(component, event, helper){ 
        var caseId = component.get("v.recordId");
        var action = component.get("c.caseDetailServer"); 
        action.setParams({"caseId":caseId});
        //action.setStorable();  
        action.setCallback(this, function(response){  
            var state = response.getState();  
            if (state === "SUCCESS") {
                console.log('case ret helper success');
                var res = response.getReturnValue();
                helper.validateCase(component, event, res,"Closed"); 
            }    
            
             
            
            });
        $A.enqueueAction(action); 
           
    },
    resolveCase : function(component, event, helper){
          
        var caseId = component.get("v.recordId");
        var action = component.get("c.caseDetailServer"); 
        action.setParams({"caseId":caseId});
        //action.setStorable();  
        action.setCallback(this, function(response){  
            var state = response.getState();  
            if (state === "SUCCESS") {
                console.log('case ret helper success');
                var res = response.getReturnValue();
                helper.validateCase(component, event, res,"Resolved"); 
            }    
            
             
            
            });
        $A.enqueueAction(action); 
            
    },
    cancelCase :function(component, event, helper){            
           
        var caseRec = component.get("v.caseRecord");
        helper.validateCase(component, event, caseRec,"Cancelled");      
            
    },
    sendBack :function(component, event, helper){  
         var caseRec = component.get("v.caseRecord");
            helper.sendBackCaseStatus(component, event, caseRec);    
            
    }, 
    reOpenCase :function(component, event, helper){
        
            var caseRec = component.get("v.caseRecord");
            helper.reOpenCaseHelper(component, event, caseRec);  
            
    }, 
    acceptCaseRec :function(component, event, helper){
        
        var caseId = component.get("v.recordId");
        var action = component.get("c.caseDetailServer"); 
        action.setParams({"caseId":caseId});
        //action.setStorable();  
        action.setCallback(this, function(response){  
            var state = response.getState();  
            if (state === "SUCCESS") {
                console.log('case ret helper success');  
                var res = response.getReturnValue();
                helper.acceptCaseHelper(component, event, res); 
            }    
            
             
            
            });
        $A.enqueueAction(action); 
        
             
            
    }, 
    waitingForCustomer:function(component, event, helper){
    	
            var caseRec = component.get("v.caseRecord");        
            helper.waitingForCustomerHelper(component, event, caseRec);  
            
    },     
    editButton : function (component, event, helper) {      
        var profileName = component.get("v.profileName");    
        //var caseRec = component.get("v.caseRecord");
        var caseId = component.get("v.recordId");
        var action = component.get("c.caseDetailServer"); 
        action.setParams({"caseId":caseId});
        //action.setStorable();  
        action.setCallback(this, function(response){  
            var state = response.getState();  
            if (state === "SUCCESS") {  
                console.log('case ret helper success');  
                var res = response.getReturnValue();
                helper.editCaseRec(component, event, res); 
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
    },
	

    
    toggleVisibility : function(component, event, helper){  

      var ddDiv = component.find('drpdwn');
      $A.util.toggleClass(ddDiv,'slds-is-open');

    },
    
    select: function(component,event,helper){   
        var selecteditem = event.currentTarget;
        
        var seletedMenuItem = selecteditem.dataset.id;
        
        var caseId = component.get("v.recordId");
        var action = component.get("c.caseDetailServer"); 
        action.setParams({"caseId":caseId});
        //action.setStorable();  
        action.setCallback(this, function(response){  
            var state = response.getState();  
            if (state === "SUCCESS") {
                console.log('case ret helper success');
                var res = response.getReturnValue();
                component.set("v.caseRecord",res); 
            }    
        if(seletedMenuItem == "Cancel Case"){
            var a = component.get('c.cancelCase');         
			$A.enqueueAction(a);
		}
        else if(seletedMenuItem == "Send Back"){         
            var a = component.get('c.sendBack');                      
			$A.enqueueAction(a);
        }
        else if(seletedMenuItem == "Re-Open"){      
            var a = component.get('c.reOpenCase');                    
			$A.enqueueAction(a);
        }
        else if(seletedMenuItem == "Waiting for Customer"){      
            var a = component.get('c.waitingForCustomer');                    
			$A.enqueueAction(a);
        }
		else{
			console.log("Do Nothing");      
		}
       /* if(seletedMenuItem == "Resolve"){  
           var a = component.get('c.resolveCase');  
			$A.enqueueAction(a); 
		}
		else if(seletedMenuItem == "Close"){
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
        
                
        });
        $A.enqueueAction(action); 

    }
    
})