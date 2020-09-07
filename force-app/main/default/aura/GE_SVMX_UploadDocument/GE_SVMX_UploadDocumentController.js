({
	doInit : function(component,event,helper){
        console.log('in controller helper');
        helper.initHelper(component,event);
    },
    
    uploadDocument : function(component,event) {
        var TaId = component.get("v.recordId");
        var docId= component.get("v.selectedDocId");
        var action = component.get("c.Upload");
        action.setParams({"TaId":TaId ,"docId":docId});
        
        action.setCallback(this, function(response){
            var state = response.getState();
              console.log('state'+state); 
            if (state === "SUCCESS") {
                console.log('case ret helper success'); 
                var res = response.getReturnValue();
                alert("Files uploaded successfully "); 
                console.log('updated successfully');
               
            } 
            
        });
        $A.enqueueAction(action); 
        $A.get("e.force:closeQuickAction").fire();
        $A.get('e.force:refreshView').fire();
        
    },
    handleUploadFinished: function (component, event) {
        // This will contain the List of File uploaded data and status
        var uploadedFiles = event.getParam("files");
        console.log("--uploadedFiles--"+uploadedFiles[0].documentId);
       // alert("Files uploaded : " + uploadedFiles.length);
        component.set("v.selectedDocId",uploadedFiles[0].documentId);
        console.log(component.get("v.selectedDocId"));
    }
    
})