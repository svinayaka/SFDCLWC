public class GE_OG_MC_AssignFEWorkOrder_EmailHelper {

    List<Id> lstTechnicianEmail = new List<Id>();  
    List<SVMXC__Service_Order__c> lstSVMXCWorkOrder = new List<SVMXC__Service_Order__c>();
  
        public void borrowTechnicianAfterInsert(List<SVMXC__Service_Order__c> newObjects){
            for(SVMXC__Service_Order__c newWO :newObjects){
            
                if(newWO.SVMXC__Group_Member__c != null  && (newWO.GE_SM_HQ_Dispatched_Outside_Territory__c == false )){
                    lstSVMXCWorkOrder.add(newWO);
                    lstTechnicianEmail.add(newWO.SVMXC__Group_Member__c);
                }
            }           
            Map<Id,SVMXC__Service_Group_Members__c> mapTech = new Map<Id,SVMXC__Service_Group_Members__c>([Select s.SVMXC__Enable_Scheduling__c,s.name , s.SVMXC__Email__c, s.SVMXC__Active__c, s.Id From SVMXC__Service_Group_Members__c s  where id =:lstTechnicianEmail ]) ;
            Integer cnt=0;
            for(SVMXC__Service_Order__c workOrder: lstSVMXCWorkOrder)
            {
                if(workOrder.SVMXC__Group_Member__c != null && !GE_HQ_UpdateWorkOrderTechAssignment.sentEmail && (workOrder.GE_SM_HQ_Record_Type_Name__c == 'MCS' || workOrder.GE_SM_HQ_Record_Type_Name__c == 'D&S'))
                {
                    GE_MC_WorkorderEmail.sendTechEmail(UserInfo.getSessionId(),workOrder.id);
                    cnt++;
                }
            }
            if(cnt>0) 
                    GE_HQ_UpdateWorkOrderTechAssignment.sentEmail = true;
    
        }
      
    public void borrowTechnicianAfterUpdate(List<SVMXC__Service_Order__c> oldObjects, List<SVMXC__Service_Order__c> newObjects){
  
            for(SVMXC__Service_Order__c newWO :newObjects){
                
                for(SVMXC__Service_Order__c oldWO :oldObjects){
                         
                        if (newWO.SVMXC__Group_Member__c != oldWO.SVMXC__Group_Member__c && (newWO.GE_SM_HQ_Dispatched_Outside_Territory__c == false) )
                        {
                            lstSVMXCWorkOrder.add(newWO);
                            lstTechnicianEmail.add(newWO.SVMXC__Group_Member__c);
                        }
                        
                        system.debug('**********************************oldWO.GE_SM_HQ_Borrowed_Technician_Approved_On__c***************************'+oldWO.GE_SM_HQ_Borrowed_Technician_Approved_On__c);
                        
                        if(newWO.SVMXC__Group_Member__c != null && newWO.GE_SM_HQ_Dispatched_Outside_Territory__c == true &&  newWO.GE_SM_HQ_Borrowed_Technician_Approved_On__c != null && (oldWO.GE_SM_HQ_Borrowed_Technician_Approved_On__c == null || newWO.SVMXC__Group_Member__c != oldWO.SVMXC__Group_Member__c ))
                        {
                            lstSVMXCWorkOrder.add(newWO);
                            lstTechnicianEmail.add(newWO.SVMXC__Group_Member__c);                
                        }
         
                    }                   
            }
           
           // Map<Id,SVMXC__Service_Group_Members__c> mapTech = new Map<Id,SVMXC__Service_Group_Members__c>([Select s.SVMXC__Enable_Scheduling__c,s.name , s.SVMXC__Email__c, s.SVMXC__Active__c, s.Id From SVMXC__Service_Group_Members__c s  where id =:lstTechnicianEmail ]) ;
            Integer cnt=0;
            for(SVMXC__Service_Order__c workOrder: lstSVMXCWorkOrder)
            {
                if(workOrder.SVMXC__Group_Member__c != null && !GE_HQ_UpdateWorkOrderTechAssignment.sentEmail)
                {
                    //Added as part of Bug # 0000024354 
                    if(workOrder.GE_SM_HQ_Record_Type_Name__c == 'D&S' && (workOrder.SVMXC__Order_Status__c!='Billing in Progress'||workOrder.SVMXC__Order_Status__c!='Ready for Invoicing'))
                    {
                    GE_MC_WorkorderEmail.sendTechEmail(UserInfo.getSessionId(),workOrder.id);
                    }
                    
                    if(workOrder.GE_SM_HQ_Record_Type_Name__c == 'MCS'){
                    GE_MC_WorkorderEmail.sendTechEmail(UserInfo.getSessionId(),workOrder.id);
                    }
                    //END of Bug# 0000024354 
                    cnt++;
                }
            }
            if(cnt>0) 
                    GE_HQ_UpdateWorkOrderTechAssignment.sentEmail = true;
        
    }
    
}