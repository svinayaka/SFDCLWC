({
	 doinit : function(component, event, helper) {         
         var recordId = component.get("v.recordId");
         console.log("currentid"+recordId);
         component.set("v.jobId",recordId);         
          var message = event.getParam("message"); 
          component.set("v.eventMessage", message + 'testjolly');
       /*  
         // Added By Vijaya on 04.Oct.2019
         
          var jobId= component.get("v.recordId");
          var action = component.get("c.getJobData");
          action.setParams({ currentjobId: jobId});
          action.setCallback(this, function(response){             
            var state = response.getState();
            console.log('state----->'+response.getState());
              if (state === "SUCCESS") { 
                  console.log('Vijaya :getJobData method return values ----->'+response.getReturnValue());
                 // component.set("v.disableFundaBtn",response.getReturnValue()); 
                  //console.log('TEsting.....>'+component.get("v.disableFundaBtn")); 
                 // helper.navigateToSobject(jobId); 
                  //component.set("v.showfundamental", false);
            }
        });
        $A.enqueueAction(action); */
     },
    //Begin : Vijaya Code on 09.Oct.2019
    
    //End : Vijaya Code on 09.Oct.2019
    
    
    
     saveFundamental: function (component, event, helper) {
         var jobId= component.get("v.recordId");
         var action = component.get("c.addqualificationItem");
        action.setParams({ currentjobId: jobId
                         });
        action.setCallback(this, function(response){
             
            var state = response.getState();

            console.log('state----->'+response.getState());
           
            if (state === "SUCCESS") { 
               console.log('Button Hide----->'+response.getReturnValue());
               console.log('sucesssss');
               
               component.set("v.disableFundaBtn",response.getReturnValue()); 
               console.log('TEsting.....>'+component.get("v.disableFundaBtn")); 
               helper.navigateToSobject(jobId); 
               component.set("v.showfundamental", false);
            }
        });
        $A.enqueueAction(action);  
    },
    onclick: function(component,event,helper)
    {
// component.set("v.show",true);
        // Begin : Added By vijaya on 09.10.2019
    var jobId  = component.get("v.recordId");
    var action = component.get("c.fetchJobData");
    action.setParams({
        "jobId": jobId
    });

    action.setCallback(this,function (response){
        var state = response.getState(),
            jobData = response.getReturnValue();
        component.set('v.jobData',jobData);
        if (state === "SUCCESS") {
            
            if(jobData.SD_Fundamentals_To_Be_Added__c == true) {
				var errorMsg = 'Please refresh the page as Job Items/Qualifications have changed.';
                console.log(errorMsg);  
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title: 'Error',
                    type: 'error',
                    message: errorMsg
                });
                toastEvent.fire();
            }
            else if(jobData.SD_Job_Items_Added__c == false){
                var errorMsg = 'Please refresh the page as Job Items/Qualifications have changed.';
                console.log(errorMsg);  
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title: 'Error',
                    type: 'error',
                    message: errorMsg
                });
                toastEvent.fire();
            }
            else {
                component.set("v.show",true);
            }
        } 
    });

    $A.enqueueAction(action);       
    // End : Added By vijaya on 09.10.2019    
    },
    
    onclick2: function(component,event,helper)
    {
      component.set("v.showfundamental",true);
      //let button = component.find('disablebuttonid');
      // button.set('v.disabled',true);
    },
    parentComponentEvent : function(component, event) { 
        //Get the event message attribute
        var setshowvalue = event.getParam("setshow"); 
         console.log('setshowvalue'+setshowvalue);
        //Set the handler attributes based on event data 
        component.set("v.setshow", setshowvalue); 
         
         if(setshowvalue = "false")
         {
              component.set("v.show",false);
         }
    },
    Cancel : function(component, event, helper) 
    {
        var jobId = component.get("v.jobId");
        component.set("v.show", false);
        component.set("v.showfundamental", false);
    }

})