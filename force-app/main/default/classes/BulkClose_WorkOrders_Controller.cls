public with sharing class BulkClose_WorkOrders_Controller {
    Public String endDateOperator{get;set;}
    Public String selectRecord{get;set;}
    Public Date endDate{get;set;}
    Public Date startDate{get;set;}
    Public SVMXC__Service_Order__c WO{get;set;}
    Public List<SVMXC__Service_Order__c > WOList{get;set;}
    Public List<SVMXC__Service_Order__c > CloseWOList{get;set;}
    Public Boolean PbTable{get;set;}
    Public List<WrapperWorkOrder> WrapperList{get;set;}
    Public List<WrapperWorkOrder> NewList{get;set;}
    Public Boolean Check1{get;set;}
    public Integer Start{get;set;}
    public Integer Count{get;set;}
    public Integer pageNumber {get;set;}
    Public Integer pageSize{get;set;}
    Public string currentPageInfo {get;set;}
    Public Boolean PageRender1{get;set;}
    Public Boolean PageRender2{get;set;}
    Public Boolean SelectAll{get;set;}
    public Boolean PbTableDis{get;set;}
    public String MessageDisplay{get;set;}
    public String selectedRecordType{get; set;}
    public ID Technician;
    public String Skill,ServiceGroup,OrderStatus;
    Public Boolean CloseWO{get;set;}
    
    Public  BulkClose_WorkOrders_Controller (){
        WO = new SVMXC__Service_Order__c ();
        PbTable = False;
        pageSize = 10;
        Start = 0;
        pageNumber  = 1;
        PageRender1 = false;
        PbTableDis = false;
        PageRender2 = false;
        SelectAll = False;
        MessageDisplay = '' ;
        CloseWO=false;
    }
    
    Public pagereference getWorkOrders(){
        endDate = WO.GE_SM_HQ_Schedule_End_Date2__c;
        startDate=WO.GE_SM_HQ_Schedule_Start_Date2__c;
        Technician=WO.SVMXC__Group_Member__c;
        OrderStatus=WO.SVMXC__Order_Status__c;
        Skill=WO.SVMXC__Skill__c;
        ServiceGroup=WO.SVMXC__Service_Group__c;
        SelectAll = False;
        MessageDisplay = '';
        System.debug('selectedRecordType***'+selectedRecordType);
        
        //if(endDate!=null&&startdate!=null){
            System.debug('WO.SVMXC__Order_Status__c'+WO.SVMXC__Order_Status__c);
            
            System.debug('WO.SVMXC__Order_Status__c'+WO.SVMXC__Order_Status__c);
            if(startDate!=null){
                if(WO.SVMXC__Group_Member__c==null&&WO.SVMXC__Skill__c==null&&wo.SVMXC__Service_Group__c==null){
            
                WOList = [select id,Name,RecordType.Name,RecordTypeID,SVMXC__Company__c,SVMXC__Order_Status__c,GE_OG_MC_ERP_Project_Number__c,GE_SM_OG_MC_Network_Number__c,GE_SM_HQ_Scheduled_Start_Date_Time__c,GE_SM_HQ_Scheduled_End_Date_Time__c,SVMXC__Service_Group__c,SVMXC__Group_Member__c,SVMXC__Skill__c
                      From SVMXC__Service_Order__c where  GE_SM_HQ_Scheduled_Start_Date__c >=:startDate  And SVMXC__Order_Status__c !=: 'Closed' and RecordTypeID=:selectedRecordType order by GE_SM_HQ_Scheduled_Start_Date_Time__c limit 999 OFFSET 10 ];
                      
            }else if(WO.SVMXC__Group_Member__c!=null&&WO.SVMXC__Skill__c==null&&wo.SVMXC__Service_Group__c==null){
            
                WOList = [select id,Name,RecordType.Name,RecordTypeID,SVMXC__Company__c,SVMXC__Order_Status__c,GE_OG_MC_ERP_Project_Number__c,GE_SM_OG_MC_Network_Number__c,GE_SM_HQ_Scheduled_Start_Date_Time__c,GE_SM_HQ_Scheduled_End_Date_Time__c,SVMXC__Service_Group__c,SVMXC__Group_Member__c,SVMXC__Skill__c
                         From SVMXC__Service_Order__c where  GE_SM_HQ_Scheduled_Start_Date__c >=:startdate  And SVMXC__Group_Member__c=:Technician And SVMXC__Order_Status__c != 'Closed' and RecordTypeID=:selectedRecordType order by GE_SM_HQ_Scheduled_Start_Date_Time__c limit 999] ; 
                          
            }else if(WO.SVMXC__Skill__c!=null&&WO.SVMXC__Group_Member__c==null&&wo.SVMXC__Service_Group__c==null){
            
                WOList = [select id,Name,RecordType.Name,RecordTypeID,SVMXC__Company__c,SVMXC__Order_Status__c,GE_OG_MC_ERP_Project_Number__c,GE_SM_OG_MC_Network_Number__c,GE_SM_HQ_Scheduled_Start_Date_Time__c,GE_SM_HQ_Scheduled_End_Date_Time__c,SVMXC__Service_Group__c,SVMXC__Group_Member__c,SVMXC__Skill__c
                          From SVMXC__Service_Order__c where  GE_SM_HQ_Scheduled_Start_Date__c >=:startDate  And SVMXC__Skill__c =:Skill And SVMXC__Order_Status__c !='Closed' And RecordTypeID=:selectedRecordType order by GE_SM_HQ_Scheduled_Start_Date_Time__c limit 999 ]; 
            }else if(wo.SVMXC__Service_Group__c!=null&&WO.SVMXC__Skill__c==null&&WO.SVMXC__Group_Member__c==null){
            
                WOList = [select id,Name,RecordType.Name,RecordTypeID,SVMXC__Company__c,SVMXC__Order_Status__c,GE_OG_MC_ERP_Project_Number__c,GE_SM_OG_MC_Network_Number__c,GE_SM_HQ_Scheduled_Start_Date_Time__c,GE_SM_HQ_Scheduled_End_Date_Time__c,SVMXC__Service_Group__c,SVMXC__Group_Member__c,SVMXC__Skill__c
                          From SVMXC__Service_Order__c where  GE_SM_HQ_Scheduled_Start_Date__c >=:startDate  And SVMXC__Service_Group__c =:ServiceGroup And SVMXC__Order_Status__c != 'Closed' And RecordTypeID=:selectedRecordType order by GE_SM_HQ_Scheduled_Start_Date_Time__c limit 999 ]; 
            }else if(WO.SVMXC__Group_Member__c!=null&&WO.SVMXC__Skill__c!=null&&WO.SVMXC__Service_Group__c==null ){
            
                WOList = [select id,Name,RecordType.Name,RecordTypeID,SVMXC__Company__c,SVMXC__Order_Status__c,GE_OG_MC_ERP_Project_Number__c,GE_SM_OG_MC_Network_Number__c,GE_SM_HQ_Scheduled_Start_Date_Time__c,GE_SM_HQ_Scheduled_End_Date_Time__c,SVMXC__Service_Group__c,SVMXC__Group_Member__c,SVMXC__Skill__c
                          From SVMXC__Service_Order__c where  GE_SM_HQ_Scheduled_Start_Date__c >=:startDate And SVMXC__Group_Member__c=:Technician And SVMXC__Skill__c=:Skill And SVMXC__Order_Status__c != 'Closed' And RecordTypeID=:selectedRecordType order by GE_SM_HQ_Scheduled_Start_Date_Time__c limit 999 ]; 
                          
            }else if(WO.SVMXC__Group_Member__c!=null&&WO.SVMXC__Service_Group__c!=null&&WO.SVMXC__Skill__c==null ){
            
                WOList = [select id,Name,RecordType.Name,RecordTypeID,SVMXC__Company__c,SVMXC__Order_Status__c,GE_OG_MC_ERP_Project_Number__c,GE_SM_OG_MC_Network_Number__c,GE_SM_HQ_Scheduled_Start_Date_Time__c,GE_SM_HQ_Scheduled_End_Date_Time__c,SVMXC__Service_Group__c,SVMXC__Group_Member__c,SVMXC__Skill__c
                          From SVMXC__Service_Order__c where  GE_SM_HQ_Scheduled_Start_Date__c >=:startDate And SVMXC__Group_Member__c=:Technician And SVMXC__Service_Group__c =:ServiceGroup And SVMXC__Order_Status__c != 'Closed' And RecordTypeID=:selectedRecordType order by GE_SM_HQ_Scheduled_Start_Date_Time__c limit 999 ]; 
                          
            }else if(WO.SVMXC__Group_Member__c!=null&&WO.SVMXC__Skill__c!=null&&WO.SVMXC__Service_Group__c!=null){
            
                WOList = [select id,Name,RecordType.Name,RecordTypeID,SVMXC__Company__c,SVMXC__Order_Status__c,GE_OG_MC_ERP_Project_Number__c,GE_SM_OG_MC_Network_Number__c,GE_SM_HQ_Scheduled_Start_Date_Time__c,GE_SM_HQ_Scheduled_End_Date_Time__c,SVMXC__Service_Group__c,SVMXC__Group_Member__c,SVMXC__Skill__c
                          From SVMXC__Service_Order__c where  GE_SM_HQ_Scheduled_Start_Date__c >=:startDate And SVMXC__Group_Member__c=:Technician And SVMXC__Service_Group__c =:ServiceGroup And SVMXC__Skill__c=:Skill And SVMXC__Order_Status__c != 'Closed' And RecordTypeID=:selectedRecordType order by GE_SM_HQ_Scheduled_Start_Date_Time__c limit 999 ]; 
                          
            }else if(WO.SVMXC__Group_Member__c==null&&WO.SVMXC__Service_Group__c!=null&&WO.SVMXC__Skill__c!=null ){
            
                WOList = [select id,Name,RecordType.Name,RecordTypeID,SVMXC__Company__c,SVMXC__Order_Status__c,GE_OG_MC_ERP_Project_Number__c,GE_SM_OG_MC_Network_Number__c,GE_SM_HQ_Scheduled_Start_Date_Time__c,GE_SM_HQ_Scheduled_End_Date_Time__c,SVMXC__Service_Group__c,SVMXC__Group_Member__c,SVMXC__Skill__c
                          From SVMXC__Service_Order__c where  GE_SM_HQ_Scheduled_Start_Date__c >=:startDate  And SVMXC__Service_Group__c =:ServiceGroup And SVMXC__Order_Status__c != 'Closed' And SVMXC__Skill__c=:Skill And RecordTypeID=:selectedRecordType order by GE_SM_HQ_Scheduled_Start_Date_Time__c limit 999 ]; 
                          
            }
            
            }else if(endDate!=null){
            
                if(WO.SVMXC__Group_Member__c==null&&WO.SVMXC__Skill__c==null&&wo.SVMXC__Service_Group__c==null){
            
                WOList = [select id,Name,RecordType.Name,RecordTypeID,SVMXC__Company__c,SVMXC__Order_Status__c,GE_OG_MC_ERP_Project_Number__c,GE_SM_OG_MC_Network_Number__c,GE_SM_HQ_Scheduled_Start_Date_Time__c,GE_SM_HQ_Scheduled_End_Date_Time__c,SVMXC__Service_Group__c,SVMXC__Group_Member__c,SVMXC__Skill__c
                      From SVMXC__Service_Order__c where   GE_SM_HQ_Scheduled_end_Date__c <=:endDate  And SVMXC__Order_Status__c !=: 'Closed' and RecordTypeID=:selectedRecordType order by GE_SM_HQ_Scheduled_Start_Date_Time__c limit 999 OFFSET 10 ];
                      
            }else if(WO.SVMXC__Group_Member__c!=null&&WO.SVMXC__Skill__c==null&&wo.SVMXC__Service_Group__c==null){
            
                WOList = [select id,Name,RecordType.Name,RecordTypeID,SVMXC__Company__c,SVMXC__Order_Status__c,GE_OG_MC_ERP_Project_Number__c,GE_SM_OG_MC_Network_Number__c,GE_SM_HQ_Scheduled_Start_Date_Time__c,GE_SM_HQ_Scheduled_End_Date_Time__c,SVMXC__Service_Group__c,SVMXC__Group_Member__c,SVMXC__Skill__c
                         From SVMXC__Service_Order__c where   GE_SM_HQ_Scheduled_end_Date__c <=:endDate And SVMXC__Group_Member__c=:Technician And SVMXC__Order_Status__c != 'Closed' and RecordTypeID=:selectedRecordType order by GE_SM_HQ_Scheduled_Start_Date_Time__c limit 999] ; 
                          
            }else if(WO.SVMXC__Skill__c!=null&&WO.SVMXC__Group_Member__c==null&&wo.SVMXC__Service_Group__c==null){
            
                WOList = [select id,Name,RecordType.Name,RecordTypeID,SVMXC__Company__c,SVMXC__Order_Status__c,GE_OG_MC_ERP_Project_Number__c,GE_SM_OG_MC_Network_Number__c,GE_SM_HQ_Scheduled_Start_Date_Time__c,GE_SM_HQ_Scheduled_End_Date_Time__c,SVMXC__Service_Group__c,SVMXC__Group_Member__c,SVMXC__Skill__c
                          From SVMXC__Service_Order__c where   GE_SM_HQ_Scheduled_end_Date__c <=:endDate And SVMXC__Skill__c =:Skill And SVMXC__Order_Status__c !='Closed' And RecordTypeID=:selectedRecordType order by GE_SM_HQ_Scheduled_Start_Date_Time__c limit 999 ]; 
            }else if(wo.SVMXC__Service_Group__c!=null&&WO.SVMXC__Skill__c==null&&WO.SVMXC__Group_Member__c==null){
            
                WOList = [select id,Name,RecordType.Name,RecordTypeID,SVMXC__Company__c,SVMXC__Order_Status__c,GE_OG_MC_ERP_Project_Number__c,GE_SM_OG_MC_Network_Number__c,GE_SM_HQ_Scheduled_Start_Date_Time__c,GE_SM_HQ_Scheduled_End_Date_Time__c,SVMXC__Service_Group__c,SVMXC__Group_Member__c,SVMXC__Skill__c
                          From SVMXC__Service_Order__c where   GE_SM_HQ_Scheduled_end_Date__c <=:endDate And SVMXC__Service_Group__c =:ServiceGroup And SVMXC__Order_Status__c != 'Closed' And RecordTypeID=:selectedRecordType order by GE_SM_HQ_Scheduled_Start_Date_Time__c limit 999 ]; 
            }else if(WO.SVMXC__Group_Member__c!=null&&WO.SVMXC__Skill__c!=null&&WO.SVMXC__Service_Group__c==null ){
            
                WOList = [select id,Name,RecordType.Name,RecordTypeID,SVMXC__Company__c,SVMXC__Order_Status__c,GE_OG_MC_ERP_Project_Number__c,GE_SM_OG_MC_Network_Number__c,GE_SM_HQ_Scheduled_Start_Date_Time__c,GE_SM_HQ_Scheduled_End_Date_Time__c,SVMXC__Service_Group__c,SVMXC__Group_Member__c,SVMXC__Skill__c
                          From SVMXC__Service_Order__c where   GE_SM_HQ_Scheduled_end_Date__c <=:endDate And SVMXC__Group_Member__c=:Technician And SVMXC__Skill__c=:Skill And SVMXC__Order_Status__c != 'Closed' And RecordTypeID=:selectedRecordType order by GE_SM_HQ_Scheduled_Start_Date_Time__c limit 999 ]; 
                          
            }else if(WO.SVMXC__Group_Member__c!=null&&WO.SVMXC__Service_Group__c!=null&&WO.SVMXC__Skill__c==null ){
            
                WOList = [select id,Name,RecordType.Name,RecordTypeID,SVMXC__Company__c,SVMXC__Order_Status__c,GE_OG_MC_ERP_Project_Number__c,GE_SM_OG_MC_Network_Number__c,GE_SM_HQ_Scheduled_Start_Date_Time__c,GE_SM_HQ_Scheduled_End_Date_Time__c,SVMXC__Service_Group__c,SVMXC__Group_Member__c,SVMXC__Skill__c
                          From SVMXC__Service_Order__c where   GE_SM_HQ_Scheduled_end_Date__c <=:endDate And SVMXC__Group_Member__c=:Technician And SVMXC__Service_Group__c =:ServiceGroup And SVMXC__Order_Status__c != 'Closed' And RecordTypeID=:selectedRecordType order by GE_SM_HQ_Scheduled_Start_Date_Time__c limit 999 ]; 
                          
            }else if(WO.SVMXC__Group_Member__c!=null&&WO.SVMXC__Skill__c!=null&&WO.SVMXC__Service_Group__c!=null ){
            
                WOList = [select id,Name,RecordType.Name,RecordTypeID,SVMXC__Company__c,SVMXC__Order_Status__c,GE_OG_MC_ERP_Project_Number__c,GE_SM_OG_MC_Network_Number__c,GE_SM_HQ_Scheduled_Start_Date_Time__c,GE_SM_HQ_Scheduled_End_Date_Time__c,SVMXC__Service_Group__c,SVMXC__Group_Member__c,SVMXC__Skill__c
                          From SVMXC__Service_Order__c where  GE_SM_HQ_Scheduled_end_Date__c <=:endDate And SVMXC__Group_Member__c=:Technician And SVMXC__Service_Group__c =:ServiceGroup And SVMXC__Skill__c=:Skill And SVMXC__Order_Status__c != 'Closed' And RecordTypeID=:selectedRecordType order by GE_SM_HQ_Scheduled_Start_Date_Time__c limit 999 ]; 
                          
            }else if(WO.SVMXC__Group_Member__c==null&&WO.SVMXC__Service_Group__c!=null&&WO.SVMXC__Skill__c!=null ){
            
                WOList = [select id,Name,RecordType.Name,RecordTypeID,SVMXC__Company__c,SVMXC__Order_Status__c,GE_OG_MC_ERP_Project_Number__c,GE_SM_OG_MC_Network_Number__c,GE_SM_HQ_Scheduled_Start_Date_Time__c,GE_SM_HQ_Scheduled_End_Date_Time__c,SVMXC__Service_Group__c,SVMXC__Group_Member__c,SVMXC__Skill__c
                          From SVMXC__Service_Order__c where  GE_SM_HQ_Scheduled_end_Date__c <=:endDate And  SVMXC__Service_Group__c =:ServiceGroup And SVMXC__Order_Status__c != 'Closed' And SVMXC__Skill__c=:Skill And RecordTypeID=:selectedRecordType order by GE_SM_HQ_Scheduled_Start_Date_Time__c limit 999 ]; 
                          
            }
            
            }else{
                if(WO.SVMXC__Group_Member__c==null&&WO.SVMXC__Skill__c==null&&wo.SVMXC__Service_Group__c==null){
            
                WOList = [select id,Name,RecordType.Name,RecordTypeID,SVMXC__Company__c,SVMXC__Order_Status__c,GE_OG_MC_ERP_Project_Number__c,GE_SM_OG_MC_Network_Number__c,GE_SM_HQ_Scheduled_Start_Date_Time__c,GE_SM_HQ_Scheduled_End_Date_Time__c,SVMXC__Service_Group__c,SVMXC__Group_Member__c,SVMXC__Skill__c
                      From SVMXC__Service_Order__c where  GE_SM_HQ_Scheduled_Start_Date__c >=:startDate And GE_SM_HQ_Scheduled_end_Date__c <=:endDate  And SVMXC__Order_Status__c !=: 'Closed' and RecordTypeID=:selectedRecordType order by GE_SM_HQ_Scheduled_Start_Date_Time__c limit 999 OFFSET 10 ];
                      
            }else if(WO.SVMXC__Group_Member__c!=null&&WO.SVMXC__Skill__c==null&&wo.SVMXC__Service_Group__c==null){
            
                WOList = [select id,Name,RecordType.Name,RecordTypeID,SVMXC__Company__c,SVMXC__Order_Status__c,GE_OG_MC_ERP_Project_Number__c,GE_SM_OG_MC_Network_Number__c,GE_SM_HQ_Scheduled_Start_Date_Time__c,GE_SM_HQ_Scheduled_End_Date_Time__c,SVMXC__Service_Group__c,SVMXC__Group_Member__c,SVMXC__Skill__c
                         From SVMXC__Service_Order__c where  GE_SM_HQ_Scheduled_Start_Date__c >=:startdate And GE_SM_HQ_Scheduled_end_Date__c <=:endDate And SVMXC__Group_Member__c=:Technician And SVMXC__Order_Status__c != 'Closed' and RecordTypeID=:selectedRecordType order by GE_SM_HQ_Scheduled_Start_Date_Time__c limit 999] ; 
                          
            }else if(WO.SVMXC__Skill__c!=null&&WO.SVMXC__Group_Member__c==null&&wo.SVMXC__Service_Group__c==null){
            
                WOList = [select id,Name,RecordType.Name,RecordTypeID,SVMXC__Company__c,SVMXC__Order_Status__c,GE_OG_MC_ERP_Project_Number__c,GE_SM_OG_MC_Network_Number__c,GE_SM_HQ_Scheduled_Start_Date_Time__c,GE_SM_HQ_Scheduled_End_Date_Time__c,SVMXC__Service_Group__c,SVMXC__Group_Member__c,SVMXC__Skill__c
                          From SVMXC__Service_Order__c where  GE_SM_HQ_Scheduled_Start_Date__c >=:startDate And GE_SM_HQ_Scheduled_end_Date__c <=:endDate And SVMXC__Skill__c =:Skill And SVMXC__Order_Status__c !='Closed' And RecordTypeID=:selectedRecordType order by GE_SM_HQ_Scheduled_Start_Date_Time__c limit 999 ]; 
            }else if(wo.SVMXC__Service_Group__c!=null&&WO.SVMXC__Skill__c==null&&WO.SVMXC__Group_Member__c==null){
            
                WOList = [select id,Name,RecordType.Name,RecordTypeID,SVMXC__Company__c,SVMXC__Order_Status__c,GE_OG_MC_ERP_Project_Number__c,GE_SM_OG_MC_Network_Number__c,GE_SM_HQ_Scheduled_Start_Date_Time__c,GE_SM_HQ_Scheduled_End_Date_Time__c,SVMXC__Service_Group__c,SVMXC__Group_Member__c,SVMXC__Skill__c
                          From SVMXC__Service_Order__c where  GE_SM_HQ_Scheduled_Start_Date__c >=:startDate And GE_SM_HQ_Scheduled_end_Date__c <=:endDate And SVMXC__Service_Group__c =:ServiceGroup And SVMXC__Order_Status__c != 'Closed' And RecordTypeID=:selectedRecordType order by GE_SM_HQ_Scheduled_Start_Date_Time__c limit 999 ]; 
            }else if(WO.SVMXC__Group_Member__c!=null&&WO.SVMXC__Skill__c!=null&&WO.SVMXC__Service_Group__c==null ){
            
                WOList = [select id,Name,RecordType.Name,RecordTypeID,SVMXC__Company__c,SVMXC__Order_Status__c,GE_OG_MC_ERP_Project_Number__c,GE_SM_OG_MC_Network_Number__c,GE_SM_HQ_Scheduled_Start_Date_Time__c,GE_SM_HQ_Scheduled_End_Date_Time__c,SVMXC__Service_Group__c,SVMXC__Group_Member__c,SVMXC__Skill__c
                          From SVMXC__Service_Order__c where  GE_SM_HQ_Scheduled_Start_Date__c >=:startDate And GE_SM_HQ_Scheduled_end_Date__c <=:endDate And SVMXC__Group_Member__c=:Technician And SVMXC__Skill__c=:Skill And SVMXC__Order_Status__c != 'Closed' And RecordTypeID=:selectedRecordType order by GE_SM_HQ_Scheduled_Start_Date_Time__c limit 999 ]; 
                          
            }else if(WO.SVMXC__Group_Member__c!=null&&WO.SVMXC__Service_Group__c!=null&&WO.SVMXC__Skill__c==null ){
            
                WOList = [select id,Name,RecordType.Name,RecordTypeID,SVMXC__Company__c,SVMXC__Order_Status__c,GE_OG_MC_ERP_Project_Number__c,GE_SM_OG_MC_Network_Number__c,GE_SM_HQ_Scheduled_Start_Date_Time__c,GE_SM_HQ_Scheduled_End_Date_Time__c,SVMXC__Service_Group__c,SVMXC__Group_Member__c,SVMXC__Skill__c
                          From SVMXC__Service_Order__c where  GE_SM_HQ_Scheduled_Start_Date__c >=:startDate And GE_SM_HQ_Scheduled_end_Date__c <=:endDate And SVMXC__Group_Member__c=:Technician And SVMXC__Service_Group__c =:ServiceGroup And SVMXC__Order_Status__c != 'Closed' And RecordTypeID=:selectedRecordType order by GE_SM_HQ_Scheduled_Start_Date_Time__c limit 999 ]; 
                          
            }else if(WO.SVMXC__Group_Member__c!=null&&WO.SVMXC__Skill__c!=null&&WO.SVMXC__Service_Group__c!=null&&WO.SVMXC__Order_Status__c==null ){
            
                WOList = [select id,Name,RecordType.Name,RecordTypeID,SVMXC__Company__c,SVMXC__Order_Status__c,GE_OG_MC_ERP_Project_Number__c,GE_SM_OG_MC_Network_Number__c,GE_SM_HQ_Scheduled_Start_Date_Time__c,GE_SM_HQ_Scheduled_End_Date_Time__c,SVMXC__Service_Group__c,SVMXC__Group_Member__c,SVMXC__Skill__c
                          From SVMXC__Service_Order__c where  GE_SM_HQ_Scheduled_Start_Date__c >=:startDate And GE_SM_HQ_Scheduled_end_Date__c <=:endDate And SVMXC__Group_Member__c=:Technician And SVMXC__Service_Group__c =:ServiceGroup And SVMXC__Skill__c=:Skill And SVMXC__Order_Status__c != 'Closed' And RecordTypeID=:selectedRecordType order by GE_SM_HQ_Scheduled_Start_Date_Time__c limit 999 ]; 
                          
            }else if(WO.SVMXC__Group_Member__c!=null&&WO.SVMXC__Skill__c!=null&&WO.SVMXC__Service_Group__c!=null){
            
                WOList = [select id,Name,RecordType.Name,RecordTypeID,SVMXC__Company__c,SVMXC__Order_Status__c,GE_OG_MC_ERP_Project_Number__c,GE_SM_OG_MC_Network_Number__c,GE_SM_HQ_Scheduled_Start_Date_Time__c,GE_SM_HQ_Scheduled_End_Date_Time__c,SVMXC__Service_Group__c,SVMXC__Group_Member__c,SVMXC__Skill__c
                          From SVMXC__Service_Order__c where  GE_SM_HQ_Scheduled_Start_Date__c >=:startDate And GE_SM_HQ_Scheduled_end_Date__c <=:endDate And SVMXC__Group_Member__c=:Technician  And SVMXC__Service_Group__c =:ServiceGroup And SVMXC__Skill__c=:Skill And SVMXC__Order_Status__c != 'Closed' And RecordTypeID=:selectedRecordType order by GE_SM_HQ_Scheduled_Start_Date_Time__c limit 999 ]; 
                          
            }else if(WO.SVMXC__Group_Member__c==null&&WO.SVMXC__Service_Group__c!=null&&WO.SVMXC__Skill__c!=null ){
            
                WOList = [select id,Name,RecordType.Name,RecordTypeID,SVMXC__Company__c,SVMXC__Order_Status__c,GE_OG_MC_ERP_Project_Number__c,GE_SM_OG_MC_Network_Number__c,GE_SM_HQ_Scheduled_Start_Date_Time__c,GE_SM_HQ_Scheduled_End_Date_Time__c,SVMXC__Service_Group__c,SVMXC__Group_Member__c,SVMXC__Skill__c
                          From SVMXC__Service_Order__c where  GE_SM_HQ_Scheduled_Start_Date__c >=:startDate And GE_SM_HQ_Scheduled_end_Date__c <=:endDate  And SVMXC__Service_Group__c =:ServiceGroup And SVMXC__Order_Status__c != 'Closed' And SVMXC__Skill__c=:Skill And RecordTypeID=:selectedRecordType order by GE_SM_HQ_Scheduled_Start_Date_Time__c limit 999 ]; 
                          
            }
            }
            
            
           
            if(WOList.Size()!=0){
                PbTable  = True;
                PbTableDis = true;
                closeWO=true;
                Count = WOList.Size();
                currentPageInfo = 'Showing Page ' + pageNumber +   ' of ' + (Math.mod(Count, pageSize) == 0 ? Count/pageSize : (Count/pageSize) + 1);
                if(count <= pagesize){
                    PageRender1 = false;
                    PageRender2 = false;
                }
                else{
                    PageRender2 = true;
                }
                getWrapperList();
            }else{
                ApexPages.Message myMsg1 = new ApexPages.Message(ApexPages.Severity.Info,'There are no Work Orders to Display.');
                ApexPages.addMessage(myMsg1);
                PbTable  = False;
            }
       // }
        return null;
    }
    /*public Boolean getRendercheckbox(){
    if(WO.GE_OG_MCS_Unassigned__c)
    return false;
       
    return true;
    }
    public Boolean getRendercheckbox1(){
    if(WO.GE_OG_MCS_Assigned__c )
    return false;
        
    return true;
    }*/
    public List<SelectOption> getItems() {
        List<SelectOption> items = new List<SelectOption>();
        //default value
        items.add(new SelectOption('','--Select Record Type --'));
        //query force.com database to get the record type of the requested object.
        for(RecordType rt: [select id,name from recordtype where sobjecttype='SVMXC__Service_Order__c' order by name]) {
            items.add(new SelectOption(rt.id,rt.name));
        }
        
        return items;
    }
    
    
    public pagereference ResetFileds(){
        PbTableDis=false;
        PbTable  = False;
        CloseWO=false;
        endDateOperator = ' = ';
        WO = new SVMXC__Service_Order__c ();
        return null;
    }
    Public Class WrapperWorkOrder{
        Public SVMXC__Service_Order__c  Work{get;set;}
        Public Boolean Check{get;set;}
        Public WrapperWorkOrder(SVMXC__Service_Order__c  w ){
            Work = w;
            Check = false;
        }
    }
    Public List<WrapperWorkOrder> getWrapperList(){
        WrapperList = new List<WrapperWorkOrder>();
        //Check1 = False;
        for(SVMXC__Service_Order__c  Wo:WoList){
            WrapperList.add(new WrapperWorkOrder(Wo));
        }
        return WrapperList;
    }
    Public PageReference Next(){
        start = start + pageSize;
        pageNumber= pageNumber+1;
        if( pageNumber == (Math.mod(Count, pageSize) == 0 ? Count/pageSize : (Count/pageSize) + 1)){
            PageRender2 = false;
            PageRender1 = true;
        }
        else{
            PageRender2 = true;
            PageRender1 = true;
        }
        currentPageInfo = 'Showing Page ' + pageNumber +   ' of ' + (Math.mod(Count, pageSize) == 0 ? Count/pageSize : (Count/pageSize) + 1);
        return null;
    }
    //code for Previous button
    Public PageReference Previous(){
        start = start - pageSize;
        pageNumber--;
        if( pageNumber == 1){
            pageRender1 = False;
            PageRender2 = true;
        }
        else{
            PageRender2 = true;
            PageRender1 = true;
        }
        currentPageInfo = 'Showing Page ' + pageNumber +   ' of ' + (Math.mod(Count, pageSize) == 0 ? Count/pageSize : (Count/pageSize) + 1);
        return null;
    }
    //code for First button
    Public PageReference First() {
        start=0;
        pageNumber  = 1;
        pageRender1 = False;
        pageRender2 = True;
        currentPageInfo = 'Showing Page ' + pageNumber +   ' of ' + (Math.mod(Count, pageSize) == 0 ? Count/pageSize : (Count/pageSize) + 1);
        return null;
    }
    //code for Last button
    Public PageReference Last(){
        
        if(Math.mod(Count, pageSize) == 0){
            start = Count - pageSize;
        }
        else{
            start = (Count/pageSize) * PageSize ;
        }
        system.debug('========start========='+start);
        pageNumber = (Math.mod(Count, pageSize) == 0 ? Count/pageSize : (Count/pageSize) + 1);
        pageRender2 = False;
        pageRender1 = True;
        currentPageInfo = 'Showing Page ' + pageNumber +   ' of ' + (Math.mod(Count, pageSize) == 0 ? Count/pageSize : (Count/pageSize) + 1);
        return null;    
    }
    
    Public pagereference CloseWorkOrders(){
        CloseWOList = new List<SVMXC__Service_Order__c> ();
        SVMXC__Skill__c NewSkill = new SVMXC__Skill__c();
        NewSkill.Name = 'Test';
        Insert NewSkill;
        // integer SelectedCount;
        for(WrapperWorkOrder wr : WrapperList){
            if(wr.Check == True)
                CloseWOList.add(wr.Work);
        }
        for(SVMXC__Service_Order__c wo : CloseWOList){
            if(wo.SVMXC__Skill__c == null){
                wo.SVMXC__Skill__c = NewSkill.id;   
            }
            wo.SVMXC__Order_Status__c = 'Closed';
            wo.SVMXC__Closed_By__c = UserInfo.getUserId();
            wo.SVMXC__Closed_On__c = System.Today();
        }
        update CloseWOList;
        delete NewSkill;
        getWorkOrders();
        SelectAll = False;
        PbTableDis = False;
        if(CloseWOList.size() == 1){
        
            MessageDisplay = CloseWOList.Size() + ' Work Order is Closed';    
        }
        else{
        
            MessageDisplay = CloseWOList.Size() + ' Work Orders are Closed';
        }
        return null;
    }
    public pagereference getSelectAll(){
        
        for(WrapperWorkOrder wr : WrapperList){
            wr.Check =SelectAll ;
        }
        return null;
    }
}