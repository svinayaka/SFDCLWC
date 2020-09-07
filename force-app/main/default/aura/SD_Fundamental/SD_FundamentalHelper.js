({
	 navigateToSobject: function(recordId)
    {
      
    	var navEvt = $A.get("e.force:navigateToSObject");       
		navEvt.setParams({"recordId": recordId,"slideDevName": "detail"});
		navEvt.fire(); 
       $A.get('e.force:refreshView').fire();
        
	}
})