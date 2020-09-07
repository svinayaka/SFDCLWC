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
        var flag =false;
        var check = true;
        
        component.set("v.hasError",false);   
        
        if(!$A.util.isEmpty(cse))
        {
            var userId = $A.get("$SObjectType.CurrentUser.Id");
            if(cse.OwnerId != userId){
                errorMessage = 'You must be the owner of the case';  
                flag = true; 
            }
            else if(cse.Status == 'Cancelled'){
                errorMessage = 'Cannot close a cancelled case';
                flag = true; 
            }
                else {                    
                    /*  if($A.util.isEmpty(cse.Component__c)){   
                        errorMessage = 'Before closing the case please fill:-' + "Component"; 
                        flag = true;     
                    } */
                    
                    if($A.util.isEmpty(cse.GE_OG_CIR_Customer_Email__c)){ 
                        if(!$A.util.isEmpty(errorMessage))
                            errorMessage = errorMessage + ",Customer Email";       
                        else
                            errorMessage = 'Before closing the case please fill:-' + "Customer Email"; 
                        flag = true; 
                    } 
                    if($A.util.isEmpty(cse.GE_OG_Issue_Event_Date_CIR__c)){ 
                        if(!$A.util.isEmpty(errorMessage))
                            errorMessage = errorMessage + ",Issue Event Date";       
                        else
                            errorMessage = 'Before closing the case please fill:-' + "Issue Event Date"; 
                        flag = true; 
                    } 
                    if($A.util.isEmpty(cse.GE_OG_Customer_Want_Date_CIR__c)){ 
                        if(!$A.util.isEmpty(errorMessage))
                            errorMessage = errorMessage + ",Customer Want Date";       
                        else
                            errorMessage = 'Before closing the case please fill:-' + "Customer Want Date"; 
                        flag = true; 
                    } 
                    if($A.util.isEmpty(cse.GE_OG_Resolution_Committed_date_CIR__c)){ 
                        if(!$A.util.isEmpty(errorMessage))
                            errorMessage = errorMessage + ",Resolution Commited Date";       
                        else
                            errorMessage = 'Before closing the case please fill:-' + "Resolution Committed Date"; 
                        flag = true; 
                    } 
                    if($A.util.isEmpty(cse.GE_OG_Resolution_Forecasted_Date_CIR__c)){ 
                        if(!$A.util.isEmpty(errorMessage))
                            errorMessage = errorMessage + ",Resolution Forecasted Date";       
                        else
                            errorMessage = 'Before closing the case please fill:-' + "Resolution Forecasted Date"; 
                        flag = true; 
                    }
                    if($A.util.isEmpty(cse.GE_OG_Final_TS_Solution__c)){   
                        if(!$A.util.isEmpty(errorMessage))
                            errorMessage = errorMessage + ",Final Solution";       
                        else
                            errorMessage = 'Before closing the case please fill:-' + "Final Solution"; 
                        flag = true; 
                    }
                    if($A.util.isEmpty(cse.GE_OG_MC_TS_Final_Issue__c)){ 
                        if(!$A.util.isEmpty(errorMessage)) 
                            errorMessage = errorMessage + ",Final Issue";       
                        else
                            errorMessage = 'Before closing the case please fill:-' + "Final Issue"; 
                        flag = true; 
                    }
                    if($A.util.isEmpty(cse.GE_OG_CIR_Assembly__c)){ 
                        if(!$A.util.isEmpty(errorMessage))
                            errorMessage = errorMessage + ",Assembly";       
                        else
                            errorMessage = 'Before closing the case please fill:-' + "Assembly"; 
                        flag = true; 
                    } 
                    if($A.util.isEmpty(cse.Product_Hierarchy__c)){
                        if(!$A.util.isEmpty(errorMessage))
                            errorMessage = errorMessage + ",Product Hierarchy";         
                        else
                            errorMessage = 'Before closing the case please fill:-' + "Product Hierarchy"; 
                        flag = true;
                    }
                    /*  if($A.util.isEmpty(cse.Item__c)){ 
                        if(!$A.util.isEmpty(errorMessage))
                            errorMessage = errorMessage + ",Item";         
                        else
                            errorMessage = 'Before closing the case please fill:-' + "Item"; 
                        flag = true; 
                    } 
                    if($A.util.isEmpty(cse.Item_Description__c)){ 
                        if(!$A.util.isEmpty(errorMessage))
                            errorMessage = errorMessage + ",Item Description";  
                        else
                            errorMessage = 'Before closing the case please fill:-' + "Item Description";
                        flag = true; 
                    } 
                    if($A.util.isEmpty(cse.Item_Description_1__c)){  
                        if(!$A.util.isEmpty(errorMessage))
                            errorMessage = errorMessage + ",Item Description1";    
                        else
                            errorMessage = 'Before closing the case please fill:-' + "Item Description1"; 
                        flag = true; 
                    } */
                    if (flag == false) { 
                        var caseId = component.get("v.recordId");     
                        var action = component.get("c.getTaskInfo");
                        action.setParams({"caseId":caseId});                     
                        // action.setStorable();
                        action.setCallback(this, function(response){          
                            var state = response.getState();
                            console.log('---state--'+state);     
                            if (state === "SUCCESS") {
                                var res = response.getReturnValue();  
                                console.log("--res--"+res);     
                                if(res){  
                                    //alert('---');      
                                    errorMessage = "All Tasks must be Completed or Cancelled";
                                    component.set("v.hasError",true);
                                    component.set("v.errorMessage",errorMessage);    
                                    
                                }
                                else{                                        
                                    errorMessage = 'No Error';   
                                    check = false;
                                    this.saveCase(component,event);         
                                    
                                }
                            } 
                            
                        });
                        $A.enqueueAction(action);
                        
                    }
                    
                }
            
            
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
        /* else{
            if(check){
                this.saveCase(component,event);   
            }
            
        }*/
        
        
        
    },
    
    saveCase : function(component,event)     
    {
        component.set("v.actionInProgress",true);
        var action = component.get("c.updateCaseServer");
        var caseRecord= component.get("v.caseRecord");
        var caseId= component.get("v.recordId");
       // alert('--caseRecord--'+JSON.stringify(caseRecord));     
        action.setParams({'caseRecord':caseRecord});
        //action.setStorable();
        action.setCallback(this, function(a){   
            var state = a.getState();
            if (state === "SUCCESS"){
                var result = a.getReturnValue();
                console.log("Result :", JSON.stringify(result));    
                
                if(result == 'Case updated successfully')
                {	
                    if(component.get("v.isCloseCase")){    
                        
                        var createArticle = confirm("Case has been closed.Do you want to create an article?"); 
                        if(createArticle){
                            /* var urlEvent = $A.get("e.force:navigateToURL");
                        urlEvent.setParams({
                            "url": "/lightning/o/Deal_Machine__kav/new?"
                        });
                        urlEvent.fire();*/
                        var action = component.get("c.fetchRecordTypeId");  
                        action.setCallback(this, function(a){
                        var state = a.getState();
                            if (state === "SUCCESS"){ 
                                var result = a.getReturnValue();               
                                
                                var createKnowledgeEvent = $A.get("e.force:createRecord");         
                                createKnowledgeEvent.setParams({ 
                                    "entityApiName": "Deal_Machine__kav",       
                                    "recordTypeId":result,
                                    "defaultFieldValues": {                                          
                                          "Sub_Business__c":caseRecord.GE_OG_Sub_Business_CIR__c,
                                          "Assembly__c":caseRecord.GE_OG_CIR_Assembly__c,
                                          "Case__c":caseRecord.CaseNumber,  
                                          "ProblemDescription__c":caseRecord.GE_OG_MC_TS_Final_Issue__c,
                                          "Solution_Statement_Answer__c":caseRecord.GE_OG_Final_TS_Solution__c
                                      } 
                         
                                });   
                                createKnowledgeEvent.fire();    
                            }
                    });
                        $A.enqueueAction(action);
                        
                    }
                    }
                    $A.get('e.force:refreshView').fire();
                    
                } 
            }
            else if (state === "INCOMPLETE") {
                // do something
            }
                else if (state === "ERROR") {
                    component.set("v.actionInProgress",false);
                    var errorString = '';
                    var errors = a.getError();
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