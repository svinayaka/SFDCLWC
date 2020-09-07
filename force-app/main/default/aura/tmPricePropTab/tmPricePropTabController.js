({
	closeQA : function(component, event, helper) {
        //alert('cls:::');
        
		$A.get("e.force:closeQuickAction").fire();
        $A.get('e.force:refreshView').fire();

	}
})