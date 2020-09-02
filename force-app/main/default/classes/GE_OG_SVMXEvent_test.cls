@istest
public class GE_OG_SVMXEvent_test
{
    public static testMethod void  Eventpositive(){
        
        
        // Service Team creation
        
        SVMXC__Service_Group__c sampServeTeam=new SVMXC__Service_Group__c() ;
        sampServeTeam.Name='hktets SERvice team';
        insert sampServeTeam;
        
        // Create Technician   
        
        SVMXC__Service_Group_Members__c ObjTechnician=new SVMXC__Service_Group_Members__c();
        
        ObjTechnician.name='Test Technician 1';
        ObjTechnician.SVMXC__Service_Group__c=sampServeTeam.id;
        ObjTechnician.GE_SS_Total_Planned_Working_Days_in_Year__c =24;
        ObjTechnician.GE_SS_Total_Training_Days__c=12;
        ObjTechnician.GE_SS_Total_Personal_Leave_Days__c=12;
        
        insert ObjTechnician;
        
        
        SVMXC__Service_Group_Members__c ObjTechnician2=new SVMXC__Service_Group_Members__c();
        
        ObjTechnician2.name='Test Tech 2';
        ObjTechnician2.SVMXC__Service_Group__c=sampServeTeam.id;
        ObjTechnician2.GE_SS_Total_Planned_Working_Days_in_Year__c =24;
        ObjTechnician2.GE_SS_Total_Training_Days__c=12;
        ObjTechnician2.GE_SS_Total_Personal_Leave_Days__c=12;
        insert ObjTechnician2;
        
        // Give dipsthcher Access to current user
        
        SVMXC__Dispatcher_Access__c dispatchAcceObj=new SVMXC__Dispatcher_Access__c();      
        
        dispatchAcceObj.SVMXC__Service_Team__c=sampServeTeam.id;
        dispatchAcceObj.SVMXC__Dispatcher__c=userinfo.getuserid();
        
        insert dispatchAcceObj;
        
        // Assign values to wrap techs
        
        list<GE_OG_SVMXEvent.WrapperTechnician> listWarptech=new 
            list<GE_OG_SVMXEvent.WrapperTechnician>();
        
        
        list<SVMXC__SVMX_Event__c> objEventList=new list<SVMXC__SVMX_Event__c>();
        
        SVMXC__SVMX_Event__c EveObj1=new SVMXC__SVMX_Event__c();
        
        EveObj1.Name='personal';
        EveObj1.SVMXC__StartDateTime__c=Date.newInstance(2015, 1, 3);
        EveObj1.SVMXC__EndDateTime__c=Date.newInstance(2015, 1, 4);
        EveObj1.SVMXC__Service_Team__c=sampServeTeam.id;
        EveObj1.SVMXC__Technician__c=ObjTechnician.id;
        EveObj1.SVMXC__IsAllDayEvent__c = true;
        EveObj1.SVMXC__ActivityDate__c = Date.newInstance(2015, 1, 3);
        EveObj1.SVMXC__DurationInMinutes__c = 2879;
        EveObj1.SVMXC__ActivityDateTime__c = Date.newInstance(2015, 1, 3);
        EveObj1.SVMXC__Type__c = 'Call';
        objEventList.add(EveObj1);
        
        SVMXC__SVMX_Event__c EveObj2=new SVMXC__SVMX_Event__c();
        
        EveObj2.Name='personal';
        EveObj2.SVMXC__StartDateTime__c=Date.newInstance(2015, 1, 6);
        EveObj2.SVMXC__EndDateTime__c=Date.newInstance(2015, 1, 8);
        EveObj2.SVMXC__Service_Team__c=sampServeTeam.id;
        EveObj2.SVMXC__Technician__c=ObjTechnician.id;
        EveObj2.SVMXC__IsAllDayEvent__c = true;
        EveObj2.SVMXC__ActivityDate__c = Date.newInstance(2015, 1, 3);
        EveObj2.SVMXC__DurationInMinutes__c = 2879;
        EveObj2.SVMXC__ActivityDateTime__c = Date.newInstance(2015, 1, 3);
        EveObj2.SVMXC__Type__c = 'Call';
        objEventList.add(EveObj2);  
        
        SVMXC__SVMX_Event__c EveObj3=new SVMXC__SVMX_Event__c();
        
        EveObj3.Name='personal';
        EveObj3.SVMXC__StartDateTime__c=Date.newInstance(2015, 1, 8);
        EveObj3.SVMXC__EndDateTime__c=Date.newInstance(2015, 1, 10);
        EveObj3.SVMXC__Service_Team__c=sampServeTeam.id;
        EveObj3.SVMXC__Technician__c=ObjTechnician.id;
        EveObj3.SVMXC__IsAllDayEvent__c = true;
        EveObj3.SVMXC__ActivityDate__c = Date.newInstance(2015, 1, 3);
        EveObj3.SVMXC__DurationInMinutes__c = 2879;
        EveObj3.SVMXC__ActivityDateTime__c = Date.newInstance(2015, 1, 3);
		EveObj3.SVMXC__Type__c = 'Call';        
        objEventList.add(EveObj3);
        
        SVMXC__SVMX_Event__c EveObj4=new SVMXC__SVMX_Event__c();
        
        
        EveObj4.Name='personal';
        EveObj4.SVMXC__StartDateTime__c=Date.newInstance(2015, 1, 6);
        EveObj4.SVMXC__EndDateTime__c=Date.newInstance(2015, 1, 10);
        EveObj4.SVMXC__Service_Team__c=sampServeTeam.id;
        EveObj4.SVMXC__Technician__c=ObjTechnician.id;
        EveObj4.SVMXC__IsAllDayEvent__c = true;
        EveObj4.SVMXC__ActivityDate__c = Date.newInstance(2015, 1, 3);
        EveObj4.SVMXC__DurationInMinutes__c = 2879;
        EveObj4.SVMXC__ActivityDateTime__c = Date.newInstance(2015, 1, 3);
        EveObj4.SVMXC__Type__c = 'Call';
        objEventList.add(EveObj4);
        
        SVMXC__SVMX_Event__c EveObj5=new SVMXC__SVMX_Event__c();
        
        EveObj5.Name='personal';
        EveObj5.SVMXC__StartDateTime__c=Date.newInstance(2015, 1, 7);
        EveObj5.SVMXC__EndDateTime__c=Date.newInstance(2015, 1, 9);
        EveObj5.SVMXC__Service_Team__c=sampServeTeam.id;
        EveObj5.SVMXC__Technician__c=ObjTechnician.id;
        EveObj5.SVMXC__IsAllDayEvent__c = true;
        EveObj5.SVMXC__ActivityDate__c = Date.newInstance(2015, 1, 3);
        EveObj5.SVMXC__DurationInMinutes__c = 2879;
        EveObj5.SVMXC__ActivityDateTime__c = Date.newInstance(2015, 1, 3);
        EveObj5.SVMXC__Type__c = 'Call';
        objEventList.add(EveObj5);
        insert objEventList;
        
        
        
        
        
        
        // Event Creation adn technecian has to be above technician
        
        SVMXC__SVMX_Event__c objeve=new SVMXC__SVMX_Event__c();  
        objeve.Name='personal';
        objeve.SVMXC__StartDateTime__c=Date.newInstance(2015, 1, 7);
        objeve.SVMXC__EndDateTime__c=Date.newInstance(2015, 1, 9);
        objeve.SVMXC__Service_Team__c=sampServeTeam.id;
        objeve.SVMXC__Technician__c=ObjTechnician.id;
        objeve.SVMXC__IsAllDayEvent__c = true;
        objeve.SVMXC__ActivityDate__c = Date.newInstance(2015, 1, 3);
        objeve.SVMXC__DurationInMinutes__c = 2879;
        objeve.SVMXC__ActivityDateTime__c = Date.newInstance(2015, 1, 3);
        objeve.SVMXC__Type__c = 'Call';
        
        ApexPages.StandardController controller=new ApexPages.StandardController(objeve);
        
        
        GE_OG_SVMXEvent objToClassEvent=new GE_OG_SVMXEvent(controller);
        objToClassEvent.SelectAll=TRUE; 
        
        GE_OG_SVMXEvent.WrapperTechnician WarpTechObj=new GE_OG_SVMXEvent.WrapperTechnician(ObjTechnician);
        
        
        WarpTechObj.tech=ObjTechnician;
        WarpTechObj.Check=true;
        
        
        listWarptech.add(WarpTechObj);
        
        WarpTechObj=new GE_OG_SVMXEvent.WrapperTechnician(ObjTechnician2);      
        WarpTechObj.tech=ObjTechnician2;
        WarpTechObj.Check=true;
        listWarptech.add(WarpTechObj);
        
        system.debug('$$$$ WarpTechObj.Check'+WarpTechObj.Check);
        
        objToClassEvent.WrapperList=listWarptech;
        //
        
        objToClassEvent.SelectAll=TRUE;         
        
        // initiate calls
        
        objToClassEvent.SelectAll=TRUE;
        objToClassEvent.save();     
        objToClassEvent.getGenerateTechnician();
        
        //objToClassEvent.getSelectAll();
        //objToClassEvent.ReSetAll();
    }
    
    
    public static testMethod void  validation()
    {
        SVMXC__SVMX_Event__c objeve=new SVMXC__SVMX_Event__c();  
        
        
        ApexPages.StandardController controller=new ApexPages.StandardController(objeve);
        
        GE_OG_SVMXEvent objToClassEvent=new GE_OG_SVMXEvent(controller);
       //objeve.GE_OG_MC_Subject__c=null;
        objeve.SVMXC__StartDateTime__c=null;
        objeve.SVMXC__EndDateTime__c=null;
        
        
        objToClassEvent.save();
        objToClassEvent.getGenerateTechnician();         
        objToClassEvent.cancel();
    }
    
    public static testMethod void  validation1()
        
    {
        
        SVMXC__Service_Group__c sampServeTeam=new SVMXC__Service_Group__c() ;
        sampServeTeam.Name='hktets SERvice team';
        insert sampServeTeam;
        
        // Create Technician   
        
        SVMXC__Service_Group_Members__c ObjTechnician=new SVMXC__Service_Group_Members__c();
        
        ObjTechnician.name='Test Technician 1';
        ObjTechnician.SVMXC__Service_Group__c=sampServeTeam.id;
        
        insert ObjTechnician;
        
        SVMXC__SVMX_Event__c EveObj6=new SVMXC__SVMX_Event__c();
        
        ApexPages.StandardController controller=new ApexPages.StandardController(EveObj6);
        GE_OG_SVMXEvent objToClassEvent=new GE_OG_SVMXEvent(controller);
        EveObj6.Name='personal';
        EveObj6.SVMXC__StartDateTime__c=Date.newInstance(2015, 1, 9);                         
        EveObj6.SVMXC__EndDateTime__c=Date.newInstance(2015, 1, 10);
        EveObj6.SVMXC__Service_Team__c=sampServeTeam.id;
        EveObj6.SVMXC__Technician__c=ObjTechnician.id;
        EveObj6.SVMXC__IsAllDayEvent__c = true;
        EveObj6.SVMXC__ActivityDate__c = Date.newInstance(2015, 1, 3);
        EveObj6.SVMXC__DurationInMinutes__c = 2879;
        EveObj6.SVMXC__ActivityDateTime__c = Date.newInstance(2015, 1, 3);
        EveObj6.SVMXC__Type__c = 'Call';
        insert EveObj6;
        
        
        
        objToClassEvent.save();
        objToClassEvent.getGenerateTechnician();         
        objToClassEvent.cancel();
        
    }
    
    
    public static testMethod void  validation2()
        
    {
        
        
        SVMXC__Service_Group__c sampServeTeam=new SVMXC__Service_Group__c() ;
        sampServeTeam.Name='hktets SERvice team';
        insert sampServeTeam;
        
        // Create Technician   
        
        SVMXC__Service_Group_Members__c ObjTechnician=new SVMXC__Service_Group_Members__c();
        
        ObjTechnician.name='Test Technician 1';
        ObjTechnician.SVMXC__Service_Group__c=sampServeTeam.id;
        
        insert ObjTechnician;
        
        SVMXC__SVMX_Event__c EveObj7 = new SVMXC__SVMX_Event__c();
       	EveObj7.Name='personal';           
        EveObj7.SVMXC__StartDateTime__c=Date.newInstance(2015, 1, 11);
        EveObj7.SVMXC__EndDateTime__c=Date.newInstance(2015, 1, 13);
        EveObj7.SVMXC__Service_Team__c=sampServeTeam.id;
        EveObj7.SVMXC__Technician__c=ObjTechnician.id;
        EveObj7.SVMXC__IsAllDayEvent__c = true;
        EveObj7.SVMXC__ActivityDate__c = Date.newInstance(2015, 1, 13);
        EveObj7.SVMXC__DurationInMinutes__c = 2879;
        EveObj7.SVMXC__ActivityDateTime__c = Date.newInstance(2015, 1, 3);
        EveObj7.SVMXC__Type__c = 'Call';
        
        ApexPages.StandardController controller=new ApexPages.StandardController(EveObj7);
        GE_OG_SVMXEvent objToClassEvent=new GE_OG_SVMXEvent(controller);
        
       // insert EveObj7;
        
        
        objToClassEvent.save();
        objToClassEvent.getGenerateTechnician();         
        objToClassEvent.cancel();
    }
    
    
    public static testMethod void  validation3()
        
    {
        SVMXC__Service_Group__c sampServeTeam=new SVMXC__Service_Group__c() ;
        sampServeTeam.Name='hktets SERvice team';
        insert sampServeTeam;
        
        // Create Technician   
        
        SVMXC__Service_Group_Members__c ObjTechnician=new SVMXC__Service_Group_Members__c();
        
        ObjTechnician.name='Test Technician 1';
        ObjTechnician.SVMXC__Service_Group__c=sampServeTeam.id;
        
        insert ObjTechnician;
        SVMXC__SVMX_Event__c EveObj8=new SVMXC__SVMX_Event__c();
        
        ApexPages.StandardController controller=new ApexPages.StandardController(EveObj8);
        GE_OG_SVMXEvent objToClassEvent=new GE_OG_SVMXEvent(controller);
        EveObj8.Name='personal';
        EveObj8.SVMXC__StartDateTime__c=Date.newInstance(2015, 1, 7);
        EveObj8.SVMXC__EndDateTime__c=Date.newInstance(2015, 1, 9);
        EveObj8.SVMXC__Technician__c=ObjTechnician.id;
        EveObj8.SVMXC__IsAllDayEvent__c = true;
        EveObj8.SVMXC__ActivityDate__c = Date.newInstance(2015, 1, 3);
        EveObj8.SVMXC__DurationInMinutes__c = 2879;
        EveObj8.SVMXC__ActivityDateTime__c = Date.newInstance(2015, 1, 3);
		EveObj8.SVMXC__Type__c = 'Call';
        insert EveObj8;
        
        
        objToClassEvent.save();
        objToClassEvent.getGenerateTechnician();         
        objToClassEvent.cancel();
        
    } 
    
    
   
    public static testMethod void  validation4(){
        
        //13/Mar/2011, 2:30 AM, America/Los_Angeles
        Date myDate1 = Date.newInstance(2015, 11, 1);
        Time myTime = Time.newInstance(0, 0, 0, 0);
        String key = 'America/New_York';
        
        DateTime result = SVMX_AlLDayEvent_Utils.getDateTimeInTimezone(myDate1, myTime, key);
        
        myDate1 = Date.newInstance(2011, 3, 13);
        myTime = Time.newInstance(2, 30, 0, 0);
        key = 'America/Los_Angeles';
        
        result = SVMX_AlLDayEvent_Utils.getDateTimeInTimezone(myDate1, myTime, key);
        
    }
    
}