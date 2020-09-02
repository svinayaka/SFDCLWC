@isTest(seeAllData=true)
public class BulkClose_WorkOrders_Controller_Test{


static testmethod void validateStandardController(){
RecordType rt = [select id,name from recordtype where sObjectType = 'SVMXC__Service_Order__c' and Name = 'MCS' limit 1];

BulkClose_WorkOrders_Controller BWC = new BulkClose_WorkOrders_Controller();
BWC.pageNumber=10;
BWC.Count=1;
BWC.Pagesize=10;
BWC.getWorkOrders();
BWC.PbTable  = True;
BWC.PbTableDis = true;
List<SVMXC__Service_Order__c>  sc=[select id, name,GE_SM_HQ_Schedule_Start_Date2__c, GE_SM_HQ_Schedule_End_Date2__c from SVMXC__Service_Order__c limit 1];
BWC.getItems();
BWC.WOList=sc;
BWC.getWrapperList();
List<SVMXC__Service_Order__c > liWO=new List<SVMXC__Service_Order__c >();


BWC.WO.GE_SM_HQ_Schedule_End_Date2__c=date.newInstance(2014, 2, 17);
BWC.WO.GE_SM_HQ_Schedule_Start_Date2__c=date.newInstance(2014, 2, 15);
System.assertEquals(BWC.PbTableDis,True);


// Hk change

 SVMXC__Service_Order__c  Woobjtemp=new SVMXC__Service_Order__c();
      
       Woobjtemp=[select id,name,SVMXC__Group_Member__c,SVMXC__Skill__c,SVMXC__Service_Group__c from SVMXC__Service_Order__c where  SVMXC__Skill__c!=null and SVMXC__Service_Group__c != null and SVMXC__Group_Member__c!=null limit 1];

liWO.add(Woobjtemp);

BWC.WOList=liWO;

SVMXC__Service_Order__c wo=new SVMXC__Service_Order__c();
if(BWC.wo.GE_SM_HQ_Schedule_Start_Date2__c!=null)
{
 if(wo.SVMXC__Group_Member__c==null&&WO.SVMXC__Skill__c==null&&wo.SVMXC__Service_Group__c==null&& wo.SVMXC__Order_Status__c==null){
 sc=[select id, name,GE_SM_HQ_Schedule_Start_Date2__c, GE_SM_HQ_Schedule_End_Date2__c from SVMXC__Service_Order__c where GE_SM_HQ_Scheduled_Start_Date__c >=:BWC.WO.GE_SM_HQ_Schedule_Start_Date2__c And GE_SM_HQ_Scheduled_end_Date__c <=:BWC.WO.GE_SM_HQ_Schedule_End_Date2__c];
 }
 else if(wo.SVMXC__Group_Member__c!=null&&WO.SVMXC__Skill__c==null&&wo.SVMXC__Service_Group__c==null&& wo.SVMXC__Order_Status__c==null){
 sc=[select id, name,GE_SM_HQ_Schedule_Start_Date2__c, GE_SM_HQ_Schedule_End_Date2__c from SVMXC__Service_Order__c where GE_SM_HQ_Scheduled_Start_Date__c >=:BWC.WO.GE_SM_HQ_Schedule_Start_Date2__c And GE_SM_HQ_Scheduled_end_Date__c <=:BWC.WO.GE_SM_HQ_Schedule_End_Date2__c limit 1];
 }
}
else if(wo.GE_SM_HQ_Schedule_End_Date2__c!=null)
{
if(wo.SVMXC__Group_Member__c==null&&WO.SVMXC__Skill__c==null&&wo.SVMXC__Service_Group__c==null&& wo.SVMXC__Order_Status__c==null){
 sc=[select id, name,GE_SM_HQ_Schedule_Start_Date2__c, GE_SM_HQ_Schedule_End_Date2__c from SVMXC__Service_Order__c where GE_SM_HQ_Scheduled_Start_Date__c >=:BWC.WO.GE_SM_HQ_Schedule_Start_Date2__c And GE_SM_HQ_Scheduled_end_Date__c <=:BWC.WO.GE_SM_HQ_Schedule_End_Date2__c];
 }
 else if(wo.SVMXC__Group_Member__c!=null&&WO.SVMXC__Skill__c==null&&wo.SVMXC__Service_Group__c==null&& wo.SVMXC__Order_Status__c==null){
 sc=[select id, name,GE_SM_HQ_Schedule_Start_Date2__c, GE_SM_HQ_Schedule_End_Date2__c from SVMXC__Service_Order__c limit 1];
 }
 }
else{
if(wo.SVMXC__Group_Member__c==null&&WO.SVMXC__Skill__c==null&&wo.SVMXC__Service_Group__c==null&& wo.SVMXC__Order_Status__c==null){
 sc=[select id, name,GE_SM_HQ_Schedule_Start_Date2__c, GE_SM_HQ_Schedule_End_Date2__c from SVMXC__Service_Order__c where GE_SM_HQ_Scheduled_Start_Date__c >=:BWC.WO.GE_SM_HQ_Schedule_Start_Date2__c And GE_SM_HQ_Scheduled_end_Date__c <=:BWC.WO.GE_SM_HQ_Schedule_End_Date2__c];
 }
 else if(wo.SVMXC__Group_Member__c!=null&&WO.SVMXC__Skill__c==null&&wo.SVMXC__Service_Group__c==null&& wo.SVMXC__Order_Status__c==null){
 sc=[select id, name,GE_SM_HQ_Schedule_Start_Date2__c, GE_SM_HQ_Schedule_End_Date2__c from SVMXC__Service_Order__c limit 1];
 }
}

BWC.getWorkOrders();
 List<Apexpages.Message> msgs = ApexPages.getMessages();
 boolean isErrorMessage = false;
 for(Apexpages.Message msg : msgs){
 if (msg.getDetail().contains('There are no Work Orders to Display.'))
 isErrorMessage  = true;
 }
//BWC.getRendercheckbox();
//BWC.getRendercheckbox1();
BWC.CloseWorkOrders();
BWC.getSelectAll();
BWC.Previous();

BWC.Next();
BWC.First();
BWC.Last();
BWC.ResetFileds();

//BWC.Rendercheckbox1();
       
        PageReference myVfPage = Page.GE_OG_MassCloseWorkOrder;
          Test.setCurrentPage(myVfPage);
          
// HK Update


      
   // For First Else If WO.SVMXC__Group_Member__c!=null&&WO.SVMXC__Skill__c==null&&wo.SVMXC__Service_Group__c==null


BWC.WO.SVMXC__Group_Member__c=Woobjtemp.SVMXC__Group_Member__c;
BWC.WO.SVMXC__Skill__c=null;                     
BWC.wo.SVMXC__Service_Group__c=null;
BWC.getWorkOrders();
  
     
       
// If WO.SVMXC__Group_Member__c==null&&WO.SVMXC__Skill__c==null&&wo.SVMXC__Service_Group__c==null

       BWC.WO.SVMXC__Group_Member__c=null;
       BWC.WO.SVMXC__Skill__c=null;
       BWC.wo.SVMXC__Service_Group__c=null;
       



// For second Else if WO.SVMXC__Skill__c!=null&&WO.SVMXC__Group_Member__c==null&&wo.SVMXC__Service_Group__c==null

BWC.WO.SVMXC__Group_Member__c=null;
BWC.WO.SVMXC__Skill__c=Woobjtemp.SVMXC__Skill__c;                    
BWC.wo.SVMXC__Service_Group__c=null;
BWC.getWorkOrders();


// For Third Else if wo.SVMXC__Service_Group__c!=null&&WO.SVMXC__Skill__c==null&&WO.SVMXC__Group_Member__c==null
          
          BWC.wo.SVMXC__Service_Group__c=Woobjtemp.SVMXC__Service_Group__c;
          BWC.WO.SVMXC__Skill__c=null;
          BWC.WO.SVMXC__Group_Member__c=null;
          BWC.getWorkOrders();

// For Fourth Else if  WO.SVMXC__Group_Member__c!=null&&WO.SVMXC__Skill__c!=null&&WO.SVMXC__Service_Group__c==null 
          
BWC.WO.SVMXC__Group_Member__c=Woobjtemp.SVMXC__Group_Member__c;
BWC.WO.SVMXC__Skill__c=Woobjtemp.SVMXC__Skill__c;
BWC.WO.SVMXC__Service_Group__c=null; 

 BWC.getWorkOrders();
 
 // For Fifth Elseif  WO.SVMXC__Group_Member__c!=null&&WO.SVMXC__Service_Group__c!=null&&WO.SVMXC__Skill__c==null 
 
 BWC.WO.SVMXC__Group_Member__c=Woobjtemp.SVMXC__Group_Member__c; 
 BWC.WO.SVMXC__Service_Group__c=Woobjtemp.SVMXC__Service_Group__c;
 BWC.WO.SVMXC__Skill__c=null;
 BWC.getWorkOrders();
 
 // 
 
// for sixth Elseif  WO.SVMXC__Group_Member__c!=null&&WO.SVMXC__Skill__c!=null&&WO.SVMXC__Service_Group__c!=null
 
 BWC.WO.SVMXC__Group_Member__c=Woobjtemp.SVMXC__Group_Member__c;
 BWC.WO.SVMXC__Service_Group__c=Woobjtemp.SVMXC__Service_Group__c;
 BWC.WO.SVMXC__Skill__c=Woobjtemp.SVMXC__Skill__c;
 BWC.getWorkOrders();

//  WO.SVMXC__Group_Member__c==null&&WO.SVMXC__Service_Group__c!=null&&WO.SVMXC__Skill__c!=null 
 
 BWC.WO.SVMXC__Group_Member__c=null;
 BWC.WO.SVMXC__Service_Group__c=Woobjtemp.SVMXC__Service_Group__c;
 BWC.WO.SVMXC__Skill__c=Woobjtemp.SVMXC__Skill__c;
    BWC.getWorkOrders();
    
    // All else ifs are done
    
   
    
    
    
}
      
      
      static testmethod void validateStandardController2()
      {
      
      RecordType rt = [select id,name from recordtype where sObjectType = 'SVMXC__Service_Order__c' and Name = 'MCS' limit 1];

            BulkClose_WorkOrders_Controller BWC = new BulkClose_WorkOrders_Controller();
            BWC.pageNumber=10;
            BWC.Count=1;
            BWC.Pagesize=10;
            BWC.getWorkOrders();
            BWC.PbTable  = True;
            BWC.PbTableDis = true;
        List<SVMXC__Service_Order__c>  sc=[select id, name,GE_SM_HQ_Schedule_Start_Date2__c, GE_SM_HQ_Schedule_End_Date2__c from SVMXC__Service_Order__c limit 1];
                BWC.getItems();
                BWC.WOList=sc;
                BWC.getWrapperList();

            BWC.WO.GE_SM_HQ_Schedule_End_Date2__c=date.today() ;
            
System.assertEquals(BWC.PbTableDis,True);    
    
    // If WO.SVMXC__Group_Member__c==null&&WO.SVMXC__Skill__c==null&&wo.SVMXC__Service_Group__c==null

       BWC.WO.SVMXC__Group_Member__c=null;
       BWC.WO.SVMXC__Skill__c=null;
       BWC.wo.SVMXC__Service_Group__c=null;
       BWC.getWorkOrders();



SVMXC__Service_Order__c  Woobjtemp=new SVMXC__Service_Order__c();
      
       Woobjtemp=[select id,name,SVMXC__Group_Member__c,SVMXC__Skill__c,SVMXC__Service_Group__c from SVMXC__Service_Order__c where  SVMXC__Skill__c!=null and SVMXC__Service_Group__c != null and SVMXC__Group_Member__c!=null limit 1];

      // For First Else If WO.SVMXC__Group_Member__c!=null&&WO.SVMXC__Skill__c==null&&wo.SVMXC__Service_Group__c==null
       
BWC.WO.SVMXC__Group_Member__c=Woobjtemp.SVMXC__Group_Member__c;
BWC.WO.SVMXC__Skill__c=null;                     
BWC.wo.SVMXC__Service_Group__c=null;
BWC.getWorkOrders();


// For second Else if WO.SVMXC__Skill__c!=null&&WO.SVMXC__Group_Member__c==null&&wo.SVMXC__Service_Group__c==null

BWC.WO.SVMXC__Group_Member__c=null;
BWC.WO.SVMXC__Skill__c=Woobjtemp.SVMXC__Skill__c;                    
BWC.wo.SVMXC__Service_Group__c=null;
BWC.getWorkOrders();


// For Third Else if wo.SVMXC__Service_Group__c!=null&&WO.SVMXC__Skill__c==null&&WO.SVMXC__Group_Member__c==null
          
          BWC.wo.SVMXC__Service_Group__c=Woobjtemp.SVMXC__Service_Group__c;
          BWC.WO.SVMXC__Skill__c=null;
          BWC.WO.SVMXC__Group_Member__c=null;
          BWC.getWorkOrders();

// For Fourth Else if  WO.SVMXC__Group_Member__c!=null&&WO.SVMXC__Skill__c!=null&&WO.SVMXC__Service_Group__c==null 
          
BWC.WO.SVMXC__Group_Member__c=Woobjtemp.SVMXC__Group_Member__c;
BWC.WO.SVMXC__Skill__c=Woobjtemp.SVMXC__Skill__c;
BWC.WO.SVMXC__Service_Group__c=null; 

 BWC.getWorkOrders();
 
 // For Fifth Elseif  WO.SVMXC__Group_Member__c!=null&&WO.SVMXC__Service_Group__c!=null&&WO.SVMXC__Skill__c==null 
 
 BWC.WO.SVMXC__Group_Member__c=Woobjtemp.SVMXC__Group_Member__c; 
 BWC.WO.SVMXC__Service_Group__c=Woobjtemp.SVMXC__Service_Group__c;
 BWC.WO.SVMXC__Skill__c=null;
 BWC.getWorkOrders();
 
 // 
 
// for sixth Elseif  WO.SVMXC__Group_Member__c!=null&&WO.SVMXC__Skill__c!=null&&WO.SVMXC__Service_Group__c!=null
 
 BWC.WO.SVMXC__Group_Member__c=Woobjtemp.SVMXC__Group_Member__c;
 BWC.WO.SVMXC__Service_Group__c=Woobjtemp.SVMXC__Service_Group__c;
 BWC.WO.SVMXC__Skill__c=Woobjtemp.SVMXC__Skill__c;
 BWC.getWorkOrders();

//  WO.SVMXC__Group_Member__c==null&&WO.SVMXC__Service_Group__c!=null&&WO.SVMXC__Skill__c!=null 
 
    BWC.WO.SVMXC__Group_Member__c=null;
    BWC.WO.SVMXC__Service_Group__c=Woobjtemp.SVMXC__Service_Group__c;
    BWC.WO.SVMXC__Skill__c=Woobjtemp.SVMXC__Skill__c;
    BWC.getWorkOrders();
    
        
      }
      

      
    static testmethod void validateStandardController3()  
      
      {
       
         RecordType rt = [select id,name from recordtype where sObjectType = 'SVMXC__Service_Order__c' and Name = 'MCS' limit 1];

            BulkClose_WorkOrders_Controller BWC = new BulkClose_WorkOrders_Controller();
            BWC.pageNumber=10;
            BWC.Count=1;
            BWC.Pagesize=10;
            BWC.getWorkOrders();
            BWC.PbTable  = True;
            BWC.PbTableDis = true;
        List<SVMXC__Service_Order__c>  sc=[select id, name,GE_SM_HQ_Schedule_Start_Date2__c, GE_SM_HQ_Schedule_End_Date2__c from SVMXC__Service_Order__c limit 1];
                BWC.getItems();
                BWC.WOList=sc;
                BWC.getWrapperList();

            BWC.WO.GE_SM_HQ_Schedule_Start_Date2__c=date.today() ;
            
System.assertEquals(BWC.PbTableDis,True);    
    
    // If WO.SVMXC__Group_Member__c==null&&WO.SVMXC__Skill__c==null&&wo.SVMXC__Service_Group__c==null

       BWC.WO.SVMXC__Group_Member__c=null;
       BWC.WO.SVMXC__Skill__c=null;
       BWC.wo.SVMXC__Service_Group__c=null;
       BWC.getWorkOrders();



SVMXC__Service_Order__c  Woobjtemp=new SVMXC__Service_Order__c();
      
       Woobjtemp=[select id,name,SVMXC__Group_Member__c,SVMXC__Skill__c,SVMXC__Service_Group__c from SVMXC__Service_Order__c where  SVMXC__Skill__c!=null and SVMXC__Service_Group__c != null and SVMXC__Group_Member__c!=null limit 1];
       
// For First Else If WO.SVMXC__Group_Member__c!=null&&WO.SVMXC__Skill__c==null&&wo.SVMXC__Service_Group__c==null
BWC.WO.SVMXC__Group_Member__c=Woobjtemp.SVMXC__Group_Member__c;
BWC.WO.SVMXC__Skill__c=null;                     
BWC.wo.SVMXC__Service_Group__c=null;
BWC.getWorkOrders();


// For second Else if WO.SVMXC__Skill__c!=null&&WO.SVMXC__Group_Member__c==null&&wo.SVMXC__Service_Group__c==null

BWC.WO.SVMXC__Group_Member__c=null;
BWC.WO.SVMXC__Skill__c=Woobjtemp.SVMXC__Skill__c;                    
BWC.wo.SVMXC__Service_Group__c=null;
BWC.getWorkOrders();


// For Third Else if wo.SVMXC__Service_Group__c!=null&&WO.SVMXC__Skill__c==null&&WO.SVMXC__Group_Member__c==null
          
          BWC.wo.SVMXC__Service_Group__c=Woobjtemp.SVMXC__Service_Group__c;
          BWC.WO.SVMXC__Skill__c=null;
          BWC.WO.SVMXC__Group_Member__c=null;
          BWC.getWorkOrders();

// For Fourth Else if  WO.SVMXC__Group_Member__c!=null&&WO.SVMXC__Skill__c!=null&&WO.SVMXC__Service_Group__c==null 
          
BWC.WO.SVMXC__Group_Member__c=Woobjtemp.SVMXC__Group_Member__c;
BWC.WO.SVMXC__Skill__c=Woobjtemp.SVMXC__Skill__c;
BWC.WO.SVMXC__Service_Group__c=null; 

 BWC.getWorkOrders();
 
 // For Fifth Elseif  WO.SVMXC__Group_Member__c!=null&&WO.SVMXC__Service_Group__c!=null&&WO.SVMXC__Skill__c==null 
 
 BWC.WO.SVMXC__Group_Member__c=Woobjtemp.SVMXC__Group_Member__c; 
 BWC.WO.SVMXC__Service_Group__c=Woobjtemp.SVMXC__Service_Group__c;
 BWC.WO.SVMXC__Skill__c=null;
 BWC.getWorkOrders();
 
 // 
 
// for sixth Elseif  WO.SVMXC__Group_Member__c!=null&&WO.SVMXC__Skill__c!=null&&WO.SVMXC__Service_Group__c!=null
 
 BWC.WO.SVMXC__Group_Member__c=Woobjtemp.SVMXC__Group_Member__c;
 BWC.WO.SVMXC__Service_Group__c=Woobjtemp.SVMXC__Service_Group__c;
 BWC.WO.SVMXC__Skill__c=Woobjtemp.SVMXC__Skill__c;
 BWC.getWorkOrders();

//  WO.SVMXC__Group_Member__c==null&&WO.SVMXC__Service_Group__c!=null&&WO.SVMXC__Skill__c!=null 
 
    BWC.WO.SVMXC__Group_Member__c=null;
    BWC.WO.SVMXC__Service_Group__c=Woobjtemp.SVMXC__Service_Group__c;
    BWC.WO.SVMXC__Skill__c=Woobjtemp.SVMXC__Skill__c;
    BWC.getWorkOrders();
    }
       
      
   
}