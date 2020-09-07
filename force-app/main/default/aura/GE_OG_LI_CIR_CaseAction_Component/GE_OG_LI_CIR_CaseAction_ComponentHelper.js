({
    getCaseRec : function(component, event, helper){
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
            
        });
        $A.enqueueAction(action); 
        
    },    
    
    
    validateCase : function(component, event, cse,caseStatus)    
    {
        var profileName = component.get("v.profileName");
        var errorMessage ='';
        var flag =false;  
        var check = true;
        component.set("v.hasError",false);    
        var userId = $A.get("$SObjectType.CurrentUser.Id");  
        if(!$A.util.isEmpty(cse))
        {
            
            /*  if(caseStatus == 'Cancelled'){
                
                if(cse.Origin != "askDrilling System"){
                    if(profileName != 'GE_OG_Super User' && profileName != 'Lightning GE_OG_Super User'  && profileName != 'GE_ES Developer'){  
                         errorMessage = 'Only Super User can Cancel a case'; 
                         flag = true;         
                    }
                    else if($A.util.isEmpty(cse.GE_OG_Case_Cancellation_Note_CIR__c)){  
                         errorMessage = 'Cancellation Note is Mandatory before you cancel a case'; 
                         flag = true;     
                    }  
                }
                
            }*/
            /*  else if(caseStatus == 'Closed'){
                if(cse.Origin != "askDrilling System"){
                    if(cse.Status != 'Resolved'){  
                        errorMessage = 'Case should be Resolved before Close';
                        flag = true; 
                    }
                    else if(cse.OwnerId != userId){
                         errorMessage = 'You must be the owner of the case';  
                         flag = true; 
                    }
                    else if($A.util.isEmpty(cse.GE_OG_Customer_Feedback_CIR__c)){ 
                        errorMessage = 'Customer Feedback is mandatory before you Close a case'; 
                        flag = true; 
                    }  
                }
            }*/
            /*  else if(caseStatus == 'Resolved'){
                  
                if(cse.Origin != "askDrilling System"){
                    if(cse.Status == 'Cancelled'){
                        errorMessage = 'Cancelled Case cannot be Resolved';
                        flag = true; 
                    }
                    else if(cse.Status == 'Closed'){
                        errorMessage = 'Case is already closed';
                        flag = true; 
                    }
                    else if(cse.Status == 'Resolved'){  
                        errorMessage = 'Case is already Resolved';
                        flag = true; 
                    }
                    else if(cse.OwnerId != userId){
                         errorMessage = 'You must be the owner of the case';  
                         flag = true; 
                    }
                    else {
                          if($A.util.isEmpty(cse.GE_OG_Resolution_Committed_date_CIR__c)|| $A.util.isEmpty(cse.GE_OG_Correction_CIR__c)||$A.util.isEmpty(cse.GE_OG_CIR_NC_Screening__c) || $A.util.isEmpty(cse.GE_OG_CIR_Defect_Code_Lev_1__c)||$A.util.isEmpty(cse.GE_OG_CIR_Defect_Code_Lev_2__c)){  
                                               
                                   errorMessage = 'Please fill Resolution Committed Date,Summary of Correction/Containment and NC Screening and defect1,defect2,defect3 before you resolve a case'; 
                                   flag = true; 
                           } 
                           else if($A.util.isEmpty(cse.GE_OG_CIR_Safer_case__c) && cse.GE_OG_EHS_Product_Safety_CIR__c !='No Impact'){ 
                                   errorMessage = 'Please Fill Safer case # Before Resolve'; 
                                   flag = true;    
                           } 
                           else if(($A.util.isEmpty(cse.Item__c)||$A.util.isEmpty(cse.Component__c)||$A.util.isEmpty(cse.GE_OG_CIR_Assembly__c)) && cse.GE_OG_CIR_Type_of_Issue__c !='Commercial/Relational'){ 
                                   errorMessage = 'You have to fill Item,Component and Assembly before you resolve a Case'; 
                                   flag = true; 
                           }                
                           else if(cse.GE_OG_CIR_NC_Screening__c!='T&T'&& $A.util.isEmpty(cse.GE_OG_NCA_RCA_value_CIR__c)){ 
                                   errorMessage = 'NCA/RCA # field is mandatory if NC Screening is chosen as RCA or NCA'; 
                                   flag = true; 
                           }  
                      }
                 }
                else{
                    errorMessage = 'You don’t have access on this case record as this case origin is askDrilling System'; 
                    flag = true; 
                }
            }*/
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
                            this.saveCase(component,event,caseStatus);             
                            
                        }
                    } 
                    
                });
                $A.enqueueAction(action);
                
            }
            console.log('--error message1111--'+errorMessage);       
            
            if($A.util.isEmpty(errorMessage))          
                errorMessage = 'No Error';    
            
        }        
        else{
            errorMessage = 'Case not Found';
        }
        
        if(errorMessage != 'No Error'){
            component.set("v.hasError",true);
            component.set("v.errorMessage",errorMessage);             
        }        
       /* else{
            if(check){
                this.saveCase(component,event,caseStatus); 
            }
            
        }*/
        
        
        
    },
    acceptCaseHelper : function(component, event, cse){
        component.set("v.actionInProgress",true);
        var action = component.get("c.acceptCase");    
        action.setParams({ caseId : component.get("v.recordId") });    
        // action.setStorable();
        action.setCallback(this, function(response) {     
            var state = response.getState();   
            if (state === "SUCCESS") {
                var res = response.getReturnValue();
                if(res == 'Owner Updated Successfully'){
                    var showToast = $A.get("e.force:showToast");     
                    showToast.setParams({   
                        'title' : 'Case Owner Updated!', 
                        'message' : 'Case Owner updated successfully.' 
                    }); 
                    
                    showToast.fire(); 
                    $A.get('e.force:refreshView').fire();  
                }
                else{
                    component.set("v.hasError",true);
                    component.set("v.errorMessage",res);           
                }
                
            }
            else if (state === "INCOMPLETE") {
                // do something
            }
                else if (state === "ERROR") {
                    component.set("v.actionInProgress",false);
                    var errorString = '';
                    var errors = response.getError();
                    this.handleError(component, event, errors);
                }
            component.set("v.actionInProgress",false);
            
        });
        
        $A.enqueueAction(action);
    },
    reOpenCaseHelper : function(component, event, cse){
        var errorMessage =''; 
        var flag =false;
        component.set("v.hasError",false);
        var profileName = component.get("v.profileName");    
        
        if(!$A.util.isEmpty(cse))
        {
            if(cse.Origin != "askDrilling System"){
                if(profileName != 'GE_OG_Super User' && profileName != 'Lightning GE_OG_Super User' && profileName != 'GE_ES Developer'){
                    errorMessage = 'Only Super User Can Reopen a case'; 
                    flag = true;           
                }
                else if(cse.Status !='Closed'&& cse.Status !='Resolved' && cse.Status != 'Waiting for Customer'){
                    errorMessage = 'You Can Reopen a case only when status is Closed/Resolved/Waiting for Customer'; 
                    flag = true; 
                }
                    else{
                        this.saveCase(component,event,"Open");     
                    }  
            } 
            else{
                errorMessage = 'You don’t have access on this case record as this case origin is askDrilling System'; 
                flag = true; 
            }
            if($A.util.isEmpty(errorMessage))               
                errorMessage = 'No Error';
        }
        else{
            errorMessage = 'Case not Found';
        }
        
        if(errorMessage != 'No Error'){
            component.set("v.hasError",true);
            component.set("v.errorMessage",errorMessage);             
        }        
        
    },
    saveCase : function(component,event,caseStatus)     
    {
        console.log("entering save");
        component.set("v.actionInProgress",true);
        var action = component.get("c.updateCase");
        var caseRecord= component.get("v.caseRecord");
        var caseId= component.get("v.recordId");
        action.setParams({'caseRecord':caseRecord,'caseStatus':caseStatus});
        //action.setStorable();
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
    waitingForCustomerHelper: function(component, event, cse){
        var errorMessage =''; 
        var flag =false;
        component.set("v.hasError",false);
        var profileName = component.get("v.profileName");      
        
        if(!$A.util.isEmpty(cse)) 
        {
          /*  if(cse.Origin != "askDrilling System"){
                if(profileName != 'GE_OG_Super User' && profileName != 'Lightning GE_OG_Super User' && profileName != 'GE_ES Developer'){
                    errorMessage = 'Only Super User can put a case to Waiting'; 
                    flag = true;           
                }
                else{
                    this.saveCase(component,event,"Waiting for Customer");       
                }  
            } 
            else{
                errorMessage = 'You don’t have access on this case record as this case origin is askDrilling System'; 
                flag = true; 
            }*/
            if($A.util.isEmpty(errorMessage))                     
                errorMessage = 'No Error';
        }
        else{
            errorMessage = 'Case not Found';
        }
        
        if(errorMessage != 'No Error'){
            component.set("v.hasError",true);
            component.set("v.errorMessage",errorMessage);             
        }        
    },
    sendBackCaseStatus : function(component, event, cse){
        var errorMessage ='';
        var flag =false;
        component.set("v.hasError",false);     
        if(!$A.util.isEmpty(cse))
        {
            var userId = $A.get("$SObjectType.CurrentUser.Id");
            
            if(cse.Origin != "askDrilling System"){
                if(cse.OwnerId != userId){
                    errorMessage = 'You must be the owner of the case';    
                    flag = true; 
                }
                else if(cse.Status == 'Closed'){  
                    errorMessage = 'You can not send back a closed case';
                    flag = true; 
                }
                    else if(cse.Status == 'Open'){       
                        errorMessage = 'This case is already in open,only a resolved case can send back';
                        flag = true; 
                    }
                        else if(cse.Status=="Waiting Customer"){
                            alert("Only a resolved case can send back");  
                        }                    
                            else if($A.util.isEmpty(cse.GE_OG_Send_Back_Reason_Description_CIR__c)){ 
                                errorMessage = 'Please fill "Send Back Reason Description" to proceed to send back a case.'; 
                                flag = true; 
                            }  
                                else if(cse.Status == "Resolved"){        
                                    var r=confirm("Are you sure, do you want to send back this case?"); 
                                    if (r==true){
                                        this.saveCase(component,event,"SendBack");   
                                    }
                                }
                
            }           
            else{
                errorMessage = 'You don’t have access on this case record as this case origin is askDrilling System'; 
                flag = true; 
            } 
            
            if($A.util.isEmpty(errorMessage))          
                errorMessage = 'No Error';
            
        }        
        else{
            errorMessage = 'Case not Found';
        }
        
        if(errorMessage != 'No Error'){
            component.set("v.hasError",true);
            component.set("v.errorMessage",errorMessage);                 
        }        
        /* else{
            if(flag){
                this.saveCase(component,event,caseStatus); 
            }
            
        }*/
        
    },
    
    handleError : function(component, event,errors){
        var errorString ='';
        var customErrorMsg;
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
        
        if (errors) {
            //console.log('error during save');
            if (errors[0] && errors[0].message) {
                // System Error
                var errorMsg=errors[0].message;
                var invalidError="INVALID_OR_NULL_FOR_RESTRICTED_PICKLIST";
                var customError="FIELD_CUSTOM_VALIDATION_EXCEPTION";
                
                if(errorMsg.includes(customError)){
                    
                    customErrorMsg=errorMsg.substring(errorMsg.indexOf(",")+1);
                    //console.log("errorMsg"+customErrorMsg);
                    // alert(customErrorMsg);
                    //this.showToast(customErrorMsg);
                }
                
            }
            
        }
         component.set('v.isRunTimeError',true);
        if($A.util.isEmpty(customErrorMsg)){
            component.set('v.exceptionMessage',errorString);       
        }
        else{
            component.set('v.exceptionMessage',customErrorMsg);       
        }
        console.log('errorString',errorString);
    },
    editCaseRec : function(component, event, caseRec){
        var userId = $A.get("$SObjectType.CurrentUser.Id");
        if(caseRec.Origin != "askDrilling System"){
            if(caseRec.CreatedById == userId){
                if( (caseRec.OwnerId).substring(0,3) == '00G' ){ 
                    var editRecordEvent = $A.get("e.force:editRecord");  
                    editRecordEvent.setParams({
                        "recordId": component.get("v.recordId")  
                    });
                    editRecordEvent.fire(); 
                }
                else {
                    if(caseRec.OwnerId == userId){
                        var editRecordEvent = $A.get("e.force:editRecord");  
                        editRecordEvent.setParams({
                            "recordId": component.get("v.recordId")  
                        });
                        editRecordEvent.fire();
                    }
                    else{
                        var errorMessage = "Only Case Owner can edit the record";    
                        component.set("v.hasError",true);  
                        component.set("v.errorMessage",errorMessage);
                    }
                }
            }
            else{
                if(caseRec.OwnerId != userId){   
                    var errorMessage = "Only Case Owner can edit the record";    
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
                
                
            }  
        }
        else{
            errorMessage = 'You don’t have access on this case record as this case origin is askDrilling System'; 
            component.set("v.hasError",true);  
            component.set("v.errorMessage",errorMessage);   
        }
    },
    showToast : function(customErrorMsg)
{
    var toastEvent = $A.get("e.force:showToast");
    toastEvent.setParams({
        "type": "error",
        "title": "Error!",
        "message": customErrorMsg
    });
    toastEvent.fire();
    
    
    
}
})