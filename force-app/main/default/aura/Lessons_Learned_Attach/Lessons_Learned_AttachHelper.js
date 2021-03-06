({
    getRecords : function(component, event, helper) {
        console.log('-----inside--');
        component.set("v.dataLoaded",false);
        var loading = component.find("loading");
        $A.util.removeClass(loading, "slds-hide");	
        var Field = component.get("v.fieldValue");
        var prodCategory = component.get("v.selectedProdCategory");
        var prodGroup = component.get("v.selectedProdGroup");
        var jobType = component.get("v.selectedJobType");
        var workOrder = component.get("v.workOrderValue");
        var accName = component.get("v.accName");
        var lessonLearned = component.get("v.selectedLessonLearned");
        var prodRegion = component.get("v.prodRegion");
        var Status = component.get("v.selectedStatus");
        var country = component.get("v.selectedCountry");
        var fsProject = component.get("v.fsProject");
        var owner = component.get("v.owner");
        var prodId = component.get("v.prodId");
        var installedProd = component.get("v.installedProd");
        var productPart = component.get("v.productPart");
        var rigVessel = component.get("v.rigVessel");
        var well = component.get("v.well");
        var workOrderRecId = component.get("v.workOrderRecId");
        
        var action = component.get("c.getLessonLearnedRecords");
        action.setParams({        
            "field":Field,
            "productCategory":prodCategory,
            "prodGroup":prodGroup,
            "jobType":jobType,
            "workOrder":workOrder,
            "accName":accName,
            "lessonLearned":lessonLearned,
            "prodRegion":prodRegion,
            "Status":Status,
            "country":country,
            "fsProject":fsProject,
            "owner":owner,
            "prodId":prodId,
            "installedProd":installedProd,
            "productPart":productPart,
            "rigVessel":rigVessel,
            "well":well,
            "workOrderRecId":workOrderRecId
        });
        action.setCallback(this,function(response) {
            var state = response.getState();
            console.log('----state----'+state);
            if (state === "SUCCESS") {
                
                var rows = response.getReturnValue();
                console.log('---rows----'+rows);
                if(rows == null || rows == '' || rows == undefined){
                    component.set("v.noRecordError",true);    
                }
                else{
                    component.set("v.noRecordError",false);  
                }
                console.log("----no error---"+component.get("v.noRecordError"));
                var fieldSetMap = component.get("v.fieldSetMap");
                console.log('-fieldSetMap-----'+JSON.stringify(fieldSetMap));
                
                
                 for (var i = 0; i < rows.length; i++) {
                    var row = rows[i];
                    
                    /*     if(row.GE_OG_Account__c) row.GE_OG_Account__c = row.GE_OG_Account__r.Name; 
                    if(row.GE_OG_Work_Order__c) row.GE_OG_Work_Order__c = row.GE_OG_Work_Order__r.Name; 
                    if(row.GE_OG_Location__c) row.GE_OG_Location__c = row.GE_OG_Location__r.Name;
                    if(row.GE_SS_FS_Project__c) row.GE_SS_FS_Project__c = row.GE_SS_FS_Project__r.Name;
                    if(row.GE_OG_Project_Region__c) row.GE_OG_Project_Region__c = row.GE_OG_Project_Region__r.Name;
					if(row.Owner) row.Owner = row.Owner.Name; 
                    console.log('---owner--'+row.Owner.Name);*/
                     if(rows[i].GE_OG_Project_Region__c) rows[i].GE_OG_Project_Region__c = rows[i].GE_OG_Project_Region__r.Name;  
       
                }
                
                component.set("v.data", rows);
                component.set("v.dataLoaded",true);
                var loading = component.find("loading");
                $A.util.addClass(loading, "slds-hide");	
            }
            
        });
        $A.enqueueAction(action);
    },
    
    getCountry : function(component, event, helper) { 
        var loading = component.find("loading");
                $A.util.removeClass(loading, "slds-hide");
        var action = component.get("c.getCountry");       
        action.setCallback(this,function(response) {
            var state = response.getState();
            console.log('----state----'+state);
            if (state === "SUCCESS") {
                var opList = response.getReturnValue();
                component.set("v.conutryList", opList);
                console.log('------'+component.get("v.options"));
                var loading = component.find("loading");
                $A.util.addClass(loading, "slds-hide");	
            }
        });
        
        $A.enqueueAction(action);   
    },
    getJobType : function(component, event, helper) {
        
        var action = component.get("c.getJobType");       
        action.setCallback(this,function(response) {
            var state = response.getState();
            console.log('----state----'+state);
            if (state === "SUCCESS") {
                var opList = response.getReturnValue();
                component.set("v.jobTypeList", opList);
                console.log('------'+component.get("v.jobTypeList"));
            }
        });
        $A.enqueueAction(action);   
    },
    getLessonLearnedType : function(component, event, helper) {
        
        var action = component.get("c.getLessonLearnedType");       
        action.setCallback(this,function(response) {
            var state = response.getState();
            console.log('----state----'+state);
            if (state === "SUCCESS") {
                var opList = response.getReturnValue();
                component.set("v.lessonLearnedList", opList);
                console.log('------'+component.get("v.options"));
            }
        });
        $A.enqueueAction(action);   
    },
    getProductCategory : function(component, event, helper) {
        
        var action = component.get("c.getProductCategory");       
        action.setCallback(this,function(response) {
            var state = response.getState();
            console.log('----state----'+state);
            if (state === "SUCCESS") {
                var opList = response.getReturnValue();
                component.set("v.productCategoryList", opList);
                console.log('------'+component.get("v.options"));
            }
        });
        $A.enqueueAction(action);   
    },
    getProductGroup : function(component, event, helper) {
        
        var action = component.get("c.getProductGroup");       
        action.setCallback(this,function(response) {
            var state = response.getState();
            console.log('----state----'+state);
            if (state === "SUCCESS") {
                var opList = response.getReturnValue();
                component.set("v.productGroupList", opList);
                console.log('------'+component.get("v.options"));
            }
        });
        $A.enqueueAction(action);   
    },
    getStatus : function(component, event, helper) {
        
        var action = component.get("c.getStatus");       
        action.setCallback(this,function(response) {
            var state = response.getState();
            console.log('----state----'+state);
            if (state === "SUCCESS") {
                var opList = response.getReturnValue();
                component.set("v.statusList", opList);
                
            }
        });
        $A.enqueueAction(action);   
    },
    saveDataTable :function(component, event, helper) {
        var editedRecords =  component.find("lessonLearntDataTable").get("v.draftValues");
        var totalRecordEdited = editedRecords.length;
        var action = component.get("c.updateLessonLearned");
        var updateRec;        
        if(totalRecordEdited == 1){
            updateRec = 'Record Updated Successfully';
        }
        else{
            updateRec = 'Record Updated Successfully';
        }
        action.setParams({
            'editLessonLearned' : editedRecords
        });
        action.setCallback(this,function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                //if update is successful
                var returnValue = response.getReturnValue();
                console.log('-----returnValue----------'+returnValue);
                if(returnValue === true){
                    helper.showToast({
                        "title": "Record Update",
                        "type": "success",
                        "message": totalRecordEdited+' '+updateRec 
                    });
                    
                    //helper.reloadDataTable(component,event);
                } else{ //if update got failed
                    helper.showToast({
                        "title": "Error!!",
                        "type": "error",
                        "message": returnValue
                    });
                }
            }
            else{                
                var errors = action.getError();
                
                if (errors) {
                    //console.log('error during save');
                    if (errors[0] && errors[0].message) {
                        // System Error
                        var errorMsg=errors[0].message;
                        var accessError="INSUFFICIENT_ACCESS_OR_READONLY";
                        var customError="FIELD_CUSTOM_VALIDATION_EXCEPTION";
                        
                        //var customError=errorMsg.substring(errorMsg.indexOf(",")+1);
                        if(errorMsg.includes(accessError)) {
                            alert('You do not have permission to edit the record');
                            
                        }
                        else if(errorMsg.includes(customError)){
                            var customErrorMsg=errorMsg.substring(errorMsg.indexOf(",")+1);
                            alert(customErrorMsg);
                        }
                            else{
                                
                            }
                    }
                    
                }
            }
        });
        $A.enqueueAction(action);
    },
    
    /*
     * Show toast with provided params
     * */
    showToast : function(params){
        var toastEvent = $A.get("e.force:showToast");
        if(toastEvent){
            toastEvent.setParams(params);
            toastEvent.fire();
        } else{
            alert(params.message);
        }
    },
    
    /*
     * reload data table
     * */
    reloadDataTable : function(component,event){
        var refreshEvent = $A.get("e.force:refreshView");
        console.log('--- reload table--'+refreshEvent);
        if(refreshEvent){
            
            refreshEvent.fire();
        }
        component.find("lessonLearntDataTable").set("v.draftValues", null);
    },
    getFieldSet : function(component, event, helper) {
        var loading = component.find("loading");
                $A.util.removeClass(loading, "slds-hide");
        var action = component.get("c.getFieldSet"); 
        var recType = component.get("v.recType"); 
        console.log('---recType----'+recType); 
        action.setParams({         
            "fieldSetType":  recType         
        });
        action.setCallback(this,function(response) {
            var state = response.getState();
            console.log('----state----'+state);
            if (state === "SUCCESS") {
                var fieldMap = response.getReturnValue();
                console.log('----fieldMap----'+fieldMap);
                component.set("v.fieldSetMap", fieldMap);
                var loading = component.find("loading");
                $A.util.addClass(loading, "slds-hide");
            }
            console.log('------fieldSet------'+JSON.stringify(component.get("v.fieldSetMap")));
        });
        $A.enqueueAction(action);   
    },
    sortData: function (component, fieldName, sortDirection,event) {
        var data = component.get("v.data");
        console.log('----------inside 2---'+sortDirection);
        var reverse = sortDirection !== 'asc';
        console.log('----insoide21---'+reverse);
        //sorts the rows based on the column header that's clicked
        data.sort(this.sortBy(fieldName, reverse))
        component.set("v.data", data);
    },
    sortBy: function (field, reverse, primer) {
        console.log('-----inside 3');
        var key = primer ?
            function(x) {return primer(x[field])} :
        function(x) {return x[field]};
        reverse = !reverse ? 1 : -1;
        return function (a, b) {
            return a = key(a)?key(a):'', b = key(b)?key(b):'', reverse * ((a > b) - (b > a));
        }
    },
    getCases: function(component,event, helper){
        component.set("v.dataLoaded",false);
        var loading = component.find("loading");
        $A.util.removeClass(loading, "slds-hide"); 
        var HSEProduct = component.get("v.HSEProduct");
        var typeOfIssue =  component.get("v.typeOfIssue");
        var customerEscalation = component.get("v.customerEscalation");
        var workOrderNPT = component.get("v.workOrderNPT");
        var SSRegion = component.get("v.SSRegion");
        var nearMissEvent = component.get("v.nearMissEvent");
        var primaryFailure = component.get("v.primaryFailure");
        var nonBHEvent = component.get("v.nonBHEvent");
        var recurrence = component.get("v.recurrence");
        var CINNumber = component.get("v.CINNumber");
        var type = component.get("v.type");
        var lossOfProduction = component.get("v.lossOfProduction");
        var accntNameSIRCaM = component.get("v.accntNameSIRCaM");
        var projectRegionSIRCaM = component.get("v.projectRegionSIRCaM");
        var field = component.get("v.field");
        var rigVesselName = component.get("v.rigVesselName");
        var wellNumber = component.get("v.wellNumber");
        var partNo = component.get("v.partNo");
        var lostProdGas = component.get("v.lostProdGas");
        var recType = component.get("v.recType");
        
        
        var action = component.get("c.getCaseRecords");
        action.setParams({          
            
            "HSEProduct":HSEProduct,
            "typeOfIssue":typeOfIssue,
            "customerEscalation":customerEscalation,
            "workOrderNPT":workOrderNPT,
            "SSRegion":SSRegion,
            "nearMissEvent":nearMissEvent,
            "primaryFailure":primaryFailure,
            "nonBHEvent":nonBHEvent,
            "recurrence":recurrence,
            "CINNumber":CINNumber,
            "type":type,
            "lossOfProduction":lossOfProduction,
            "accntNameSIRCaM":accntNameSIRCaM,
            "projectRegionSIRCaM":projectRegionSIRCaM,
            "field":field,
            "rigVesselName":rigVesselName,
            "wellNumber":wellNumber,
            "partNo":partNo,
            "lostProdGas":lostProdGas,
            "recType":recType
            
        });
        action.setCallback(this,function(response) {
            var state = response.getState();
            console.log('----state----'+state);
            if (state === "SUCCESS") {
                
                var rows = response.getReturnValue();
                console.log('---rows----'+JSON.stringify(rows));
                if(rows == null || rows == '' || rows == undefined){
                    component.set("v.noRecordError",true);    
                }
                else{
                    component.set("v.noRecordError",false);  
                }
                console.log("----no error---"+component.get("v.noRecordError"));
                var fieldSetMap = component.get("v.fieldSetMap");
                console.log('-fieldSetMap-----'+JSON.stringify(fieldSetMap));
                console.log('');
                for(var i =0;i < rows.length;i++){
                    var row = rows[i];
                    if(rows[i].GE_SS_Work_Order__c) rows[i].GE_SS_Work_Order__c = rows[i].GE_SS_Work_Order__r.Name;
                    if(rows[i].GE_SS_Rig_Vessel_Name__c) rows[i].GE_SS_Rig_Vessel_Name__c = rows[i].GE_SS_Rig_Vessel_Name__r.Name;
                    if(rows[i].AccountId) rows[i].AccountId = rows[i].Account.Name;  
                    if(rows[i].OwnerId) rows[i].OwnerId = rows[i].Owner.Name;
                    if(rows[i].ContactId) rows[i].ContactId = rows[i].Contact.Name;
                    if(rows[i].GE_SS_Well_ID__c) rows[i].GE_SS_Well_ID__c = rows[i].GE_SS_Well_ID__r.Name;
                }
                component.set("v.data", rows); 
                component.set("v.dataLoaded",true);
                var loading = component.find("loading");
                $A.util.addClass(loading, "slds-hide");	
            }
            
        });
        $A.enqueueAction(action);
        
    },
    getCasePickListValues :function(component,event, helper){
        var action = component.get("c.getCasePickList");       
        action.setCallback(this,function(response) {
            var state = response.getState();
            console.log('----state----'+state);
            if (state === "SUCCESS") {
                var opList = response.getReturnValue();
                console.log('----'+JSON.stringify(opList));
                for(var key in opList){
                    console.log('-oplist[key]-'+JSON.stringify(opList["HSEPRoductSafety"])); 
                }
                component.set("v.HSEProductSafetyValues", opList["HSEPRoductSafety"]);
                component.set("v.primaryFailureValues", opList["PrimaryFailure"]);
                component.set("v.typeOfIssuesValues", opList["TypeOfIssue"]);
                component.set("v.subSeaServicesRegionValues", opList["SubSeaServices"]);
                component.set("v.bhEventValues", opList["BHEvent"]);
                component.set("v.CustomerEscalationValues", opList["CustomerEscalation"]);
                component.set("v.nearMissEventValues", opList["NearmissEvent"]);
                component.set("v.reOccureneceValues", opList["Reoccurence"]);
                //console.log('------'+component.get("v.jobTypeList"));
                var loading = component.find("loading");
                $A.util.addClass(loading, "slds-hide");	
            }
            
        });
        $A.enqueueAction(action);   
    }
    
    
})