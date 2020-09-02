global class GE_SS_Attachments{
    webservice static SVMXC.INTF_WebServicesDef.INTF_Response addAttachmentstoMWO(SVMXC.INTF_WebServicesDef.INTF_Response request){
        id recordId,woID;
        Id rtWOId = Schema.SObjectType.SVMXC__Service_Order__c.getRecordTypeInfosByName().get('SS-Mobilize').getRecordTypeId();
        List<Attachment> addWOattach = new List<Attachment>();
        SVMXC.INTF_WebServicesDef.INTF_Response response= new SVMXC.INTF_WebServicesDef.INTF_Response();
        for(SVMXC.INTF_WebServicesDef.SVMXMap objSVXMMap : request.valueMap){                                     
                if(objSVXMMap.key == 'WorkDetail_ID'){                                                                
                    recordId = objSVXMMap.value;
                   
                }
                if(objSVXMMap.key == 'WorkOrder_ID'){
                    woID = objSVXMMap.value;
                }
                
            }
         SVMXC__Service_Order_Line__c wdDetail= [SELECT id, Name,SVMXC__Service_Order__c,SVMXC__Service_Order__r.RecordTypeId,
         SVMXC__Service_Order__r.Name from SVMXC__Service_Order_Line__c where Id=:recordId and SVMXC__Service_Order__r.RecordTypeId=:rtWOId  ];   
         List<Attachment> fsoattach=[SELECT Id, Name, ContentType,Body FROM Attachment WHERE ParentId=:recordId Order By CreatedDate DESC Limit 1];

             if(fsoattach.size()>0) {
                 for(Attachment addAtt : fsoattach){
                  
                  Attachment attachment = new Attachment();
                  
                  attachment.Body = addAtt.Body;
                  if(addAtt.Name.endsWith('.pdf')){
                  attachment.Name = wdDetail.SVMXC__Service_Order__r.Name+'/'+wdDetail.Name+' Service Ticket Report'+'.pdf';}
                  else if(addAtt.Name.endsWith('.jpg')){
                  attachment.Name = wdDetail.SVMXC__Service_Order__r.Name+'/'+wdDetail.Name+' Service Ticket Report'+'.jpg';}
                  else if(addAtt.Name.endsWith('.png')){
                  attachment.Name = wdDetail.SVMXC__Service_Order__r.Name+'/'+wdDetail.Name+' Service Ticket Report'+'.png';}
                  else if(addAtt.Name.endsWith('.zip')){
                  attachment.Name = wdDetail.SVMXC__Service_Order__r.Name+'/'+wdDetail.Name+' Service Ticket Report'+'.zip';}
                  else{
                  attachment.Name = wdDetail.SVMXC__Service_Order__r.Name+'/'+wdDetail.Name+' Service Ticket Report';}
                  attachment.ContentType = addAtt.ContentType;
                  //attachment.ParentId = woID;
                  attachment.ParentId = wdDetail.SVMXC__Service_Order__r.id;
                  addWOattach.add(attachment);

                 }
             }
             if(addWOattach.size()>0){
                
                 Insert addWOattach;
                 response.message = 'Successfully attached';
                 response.success = true;
                 return  response ;
             }
             else{
                 response.message = 'There are no Attchments to copy over to the Work Order';
                 response.success = false;
                 return  response ;
             }
       
    }
   
}