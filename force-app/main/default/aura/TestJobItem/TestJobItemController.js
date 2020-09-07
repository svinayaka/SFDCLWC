({
	  doinit : function(component, event, helper) {
         
         var recordId = component.get("v.recordId");
         console.log("currentid"+recordId);
         component.set("v.jobId",recordId);
         
         var message = event.getParam("message"); 
         component.set("v.eventMessage", message + 'testjolly');
          
          var action = component.get("c.fetchUser");
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log('22222222222 '+state);
            if (state === "SUCCESS") {
                var storeResponse = response.getReturnValue();
               // set current user information on userInfo attribute
                component.set("v.isDispatcherProfile", storeResponse);
                console.log('111111111111'+storeResponse);
            }
        });
         $A.enqueueAction(action);
     },
    
    onclick : function(component, event, helper)
    {
      component.set("v.show",true);  
         
    },
    
    openPage : function(component, event, helper) {
        
         /*var vfURL = 'https://' + component.get("v.domain") + '--c.visualforce.com/apex/';
         vfURL = vfURL + component.get("v.FX5__JSD") + '?';
         vfURL = vfURL + component.get("v.queryString");
         */
        window.open("https://geog.lightning.force.com/lightning/n/FX5__JSD");
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
    } 
    
     
  
});