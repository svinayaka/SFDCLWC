({
	Select : function(component, event, helper) {
        console.log('select functionality');
        var cmpEvent = component.getEvent("service_amt_Popup_table_event");
        cmpEvent.setParams({'userObj' : component.get('v.userSearchArray'),
                            'isUser' : component.get('v.isUser'),
                            });
        cmpEvent.fire();
	}
})