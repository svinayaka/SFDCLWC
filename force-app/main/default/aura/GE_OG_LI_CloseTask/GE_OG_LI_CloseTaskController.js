({
    doInit : function(component, event, helper) {
           
        var taskId= component.get("v.recordId");  
        console.log('taskId'+taskId);
          
        var action = component.get("c.updateTaskStatus");  
        action.setParams({"taskId":taskId});
        action.setCallback(this, function(a){
            
            var result = a.getReturnValue();
            console.log("Result :", JSON.stringify(result));
            //alert('updated successfully');
            if(result == 'Task updated successfully') 
            {   
                $A.get('e.force:refreshView').fire();
                
                setTimeout(function() {$A.get("e.force:closeQuickAction").fire();}, 3200); 
                
                setTimeout(function() { window.location.reload();}, 3200);                     
                  
            } 
            else{
                console.log('encounterred error');   
            }      
            
            
        });
        
        $A.enqueueAction(action);  
        
        //setTimeout(function() {$A.get('e.force:refreshView').fire();}, 6000);
            
        
        
    } 
})