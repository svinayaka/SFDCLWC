({
    initHelper : function(component,event) {
        console.log('init helper called');
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
                console.log('new case Record',res);
            } 
            
        });
        $A.enqueueAction(action); 
    },
    
    validateCase : function(component, event, cse)
    {
        var errorMessage ='';
        component.set("v.hasError",false);
        //component.set("v.errorMessage",errorMessage);
        console.log('case record sent to validate', cse);
        var subType= cse.GE_ES_Sub_Type__c;
        
        console.log('case record sent to subType', subType);
        
        
        if(!$A.util.isEmpty(cse))  
        {
            if($A.util.isEmpty(cse.Site_Contact_Information__c) && ($A.util.isEmpty(cse.ContactId))){
                if($A.util.isEmpty(errorMessage)){
                    errorMessage = errorMessage + 'Please fill Account Name and Contact Or Site Contact Information';   
                }
                else{
                    errorMessage = errorMessage + 'Please fill Account Name and Contact Or Site Contact Information  '+',';

                }
            }              
            if((subType =='RFQ processing') && ($A.util.isEmpty(cse.Customer_RFQ__c) || $A.util.isEmpty(cse.GE_OG_Quote__c)))
                errorMessage = errorMessage + 'Customer RFQ and Quote Must be filled  '+',';
            
            if((subType =='PO pre-Processing') && ($A.util.isEmpty(cse.GE_ES_Env_Case_Amount__c) 
                                                   || $A.util.isEmpty(cse.GE_ES_PO__c) || $A.util.isEmpty(cse.GE_ES_Shop_Order__c)))
                errorMessage = errorMessage + 'Please fill  Case Amount, Customer PO#, ERP Sales Order # fields  '+',';
            
            if(((subType == 'RMA Creation') || (cse.GE_ES_Sub_Type__c == 'RMA Status Inquiry'))
               &&  ($A.util.isEmpty(cse.GE_PW_RMA__c)))
                errorMessage = errorMessage + 'Please fill RMA# field  '+',';          
            
            if($A.util.isEmpty(errorMessage))          
                errorMessage = 'No Error';
            
        }
        
        else
            errorMessage = 'Case not Found';
        
        
        
        console.log("error message",errorMessage);
        
        if(errorMessage != 'No Error'){
            component.set("v.hasError",true);
            component.set("v.errorMessage",errorMessage);
        }
        
        else
            this.saveCase(component,event);
      
        
        
    },
    
    saveCase : function(component, event, helper)
    {
        console.log("entering save");
        component.set("v.actionInProgress",true);
        var action = component.get("c.updateCaseServer");
        var caseRecord= component.get("v.caseRecord");
        var caseId= component.get("v.recordId");
        action.setParams({'caseRecord':caseRecord});
        action.setStorable();
        action.setCallback(this, function(a){   
            var state = a.getState();
            if (state === "SUCCESS"){
                var result = a.getReturnValue();
                console.log("Result :", JSON.stringify(result));
                
                if(result == 'Case updated successfully')
                {	         
                    console.log('entered savecase');
                    $A.get('e.force:refreshView').fire();
                    //this.navigateToSobject(caseId);              
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
                    this.handleError(component, event, errors);
                }
            component.set("v.actionInProgress",false);
            
        });
        $A.enqueueAction(action);                                                
        
    },
    
    handleError : function(component, event,errors){
        var errorString ='';
        for(var i=0; i<errors.length;i++){
            var fieldErrors = errors[i].fieldErrors;
            var pageErrors  = errors[i].pageErrors;
            if(fieldErrors && fieldErrors.length>0)
                errorString += JSON.stringify(fieldErrors);
            else if (pageErrors && pageErrors.length>0){
                errorString += JSON.stringify(pageErrors);
            }else if(errors[i] && errors[i].message){
                errorString += errors[i].message;
            }else{
                errorString += JSON.stringify(errors[i]);
            }
        }
        component.set('v.exceptionMessage',errorString);
        component.set('v.isRunTimeError',true);
        console.log('errorString',errorString);
    }
})