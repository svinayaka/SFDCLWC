({
    onHandleClick : function(component, event, helper) {
        // Get the action of Controller (Apex) Class
        var action = component.get('c.makeAPICall');
        
        // set the callback which will return the response from apex
        action.setCallback(this, function(response){
            // get the state
            var state = response.getState();
            if( (state === 'SUCCESS' || state ==='DRAFT') && component.isValid()){
                // get the response
                var responseValue = response.getReturnValue();
                // Parse the respose
                var responseData = JSON.parse(responseValue);
                alert(responseData);
                //alert(responseData.totalSize);
                console.log(responseData);
            } else if( state === 'INCOMPLETE'){
                console.log("User is offline, device doesn't support drafts.");
            } else if( state === 'ERROR'){
                console.log('Problem saving record, error: ' +
                            JSON.stringify(response.getError()));
            } else{
                console.log('Unknown problem, state: ' + state +
                            ', error: ' + JSON.stringify(response.getError()));
            }
        });
        // send the action to the server which will call the apex and will return the response
        $A.enqueueAction(action);
    }
})