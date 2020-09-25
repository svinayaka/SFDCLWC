({
    
   createRecord : function (component, event, helper) {
    var createRecordEvent = $A.get("e.force:createRecord");
    createRecordEvent.setParams({
        "entityApiName": "Opportunity",
        "RecordTypeId":"01212000000VooCAAS"
    });
    createRecordEvent.fire();
}
})