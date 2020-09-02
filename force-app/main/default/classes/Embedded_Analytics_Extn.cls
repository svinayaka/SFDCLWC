public class Embedded_Analytics_Extn{
  /*  
   // public Id AccPlanId{get; set;}
    public GE_HQ_Account_Plan__c aPlan{get;set;}
    public String DashId{get; set;}
    public String Report0Id{get; set;}
    public String Report0Name{get; set;}
    public String Report1Id{get; set;}
    public String Report1Name{get; set;}
    public String Report2Id{get; set;}
    public String Report2Name{get; set;}
    public String Report3Id{get; set;}
    public String Report3Name{get; set;}
    public String Report4Id{get; set;}
    public String Report4Name{get; set;}
    public String Report5Id{get; set;}
    public String Report5Name{get; set;}
    public String Report6Id{get; set;}
    public String Report6Name{get; set;}
    public String Report7Id{get; set;}
    public String Report7Name{get; set;}
    public String Report8Id{get; set;}
    public String Report8Name{get; set;}
    public String Report9Id{get; set;}
    public String Report9Name{get; set;}
    public String Report10Id{get; set;}
    public String Report10Name{get; set;}
    public String Report11Id{get; set;}
    public String Report11Name{get; set;}
    public String Report12Id{get; set;}
    public String Report12Name{get; set;}
    public String Report13Id{get; set;}
    public String Report13Name{get; set;}
    public String Report14Id{get; set;}
    public String Report14Name{get; set;}
    public String AccPlanName{get; set;}
    Public String DDUNS{get; set;}
    public List<SelectOption> tiers{get;set;}
    public String tier2{get;set;}
    public String tier3{get;set;}
    public String accName{get;set;}
    public Embedded_Analytics_Extn(ApexPages.StandardController controller){
       //ReportId='String19';
       // Report0Name='String100';
        Report r1=[select id,name,developerName from Report where developerName='OG_Tier_1_O_G_Region_Current_Year'];
        Report1Id=r1.id;
        Report1Name=r1.name;
        Report r2=[select id,name,developerName from Report where developerName='OG_Forecast_by_PL_Current_Year'];
        Report2Id=r2.id;
        Report2Name=r2.name;
        Report r3=[select id,name,developerName from Report where developerName='OG_Tier_2_Account_Region_Current_Year'];
        Report3Id=r3.id;
        Report3Name=r3.name;
    
        Report r4=[select id,name,developerName from Report limit 1];
        Report4Id=r4.id;
        Report4Name=r4.name;
        Report5Id=r4.id;
        Report5Name=r4.name;
        Report6Id=r4.id;
        Report6Name=r4.name;
        /*
        Report r4=[select id,name,developerName from Report where developerName='OG_SalesMgr_Current_Year_OPEN'];
        Report4Id=r4.id;
        Report4Name=r4.name;
        Report r5=[select id,name,developerName from Report where developerName='OG_Oppty_by_Stage_Current_Year'];
        Report5Id=r5.id;
        Report5Name=r5.name;
        Report r6=[select id,name,developerName from Report where developerName='OG_SalesMgr_Current_Year_Forecast'];
        Report6Id=r6.id;
        Report6Name=r6.name;
        */
       
      /*  Report7Id='String1';
        Report7Name='String2';
        Report8Id='String3';
        Report8Name='String4';
        Report9Id='String5';
        Report9Name='String6';
        Report10Id='String7';
        Report10Name='String8';
        Report11Id='String9';
        Report11Name='String0';
        Report12Id='String12';
        Report12Name='String22';
        Report13Id='String32';
        Report13Name='String42';
        Report14Id='String52';
        Report14Name='String72';
        Report0Id='String74';
        Report0Name='String73'; */
        
       /*Report r7=[select id,name,developerName from Report where developerName='Global_by_Oppty_CurrYr_Won'];
        Report7Id=r7.id;
        Report7Name=r7.name;
        Report r8=[select id,name,developerName from Report where developerName='Oppty_CurrentYear_ActiveMedium'];
        Report8Id=r8.id;
        Report8Name=r8.name;
        Report r9=[select id,name,developerName from Report where developerName='Oppty_CurrentYear_ActiveLow'];
        Report9Id=r9.id;
        Report9Name=r9.name;
        Report r10=[select id,name,developerName from Report where developerName='SalesMgr_CurrentYear_Forecast'];
        Report10Id=r10.id;
        Report10Name=r10.name;
        Report r11=[select id,name,developerName from Report where developerName='Oppty_CurrentYear_ActiveHigh'];
        Report11Id=r11.id;
        Report11Name=r11.name;
        Report r12=[select id,name,developerName from Report where developerName='OG_Oppty_by_Offering_CurrentYear'];
        Report12Id=r12.id;
        Report12Name=r12.name;
        Report r13=[select id,name,developerName from Report where developerName='Oppty_CurrentYear_Prospect'];
        Report13Id=r13.id;
        Report13Name=r13.name;
        Report r14=[select id,name,developerName from Report where developerName='OpptyDrive_CurrentYear'];
        Report14Id=r14.id;
        Report14Name=r14.name;
        */
        
        
       /* DashId=[select id,developerName from Dashboard where developerName='OG_Account_Plan_Dashboard'].id;
        List<DashboardComponent> comp=[select id,name from DashboardComponent where DashboardId=:DashId];
        Map<String,DashboardComponent> DashCompMap=new Map<String,DashboardComponent>();
        for(DashboardComponent c: comp){
            DashCompMap.put(c.name,c);    
        }
        this.aPlan=(GE_HQ_Account_Plan__c)controller.getRecord();
        GE_HQ_Account_Plan__c AccPlan=[select id,name,GE_HQ_DDUNS_fm__c,GE_HQ_DDUNS_Number__c from GE_HQ_Account_Plan__c where id=:aPlan.Id];
        
        AccPlanName=AccPlan.Name;
        DDUNS=AccPlan.GE_HQ_DDUNS_fm__c;
        Account acc=[select id,name from Account where id=:AccPlan.GE_HQ_DDUNS_Number__c];
        this.accName=acc.name;
        /*
        tiers=new List<SelectOption>();
        tiers.add(new SelectOption('','None'));
        tiers.add(new SelectOption('Turbo Machinery','Turbo Machinery'));
        tiers.add(new SelectOption('PII Pipeline Solutions','Pipeline Solutions'));
        tiers.add(new SelectOption('Global Services (GS)','Global Services'));
        tiers.add(new SelectOption('Mesurement & Control (M&C)','Mesurement & Control'));
        tiers.add(new SelectOption('Drilling & Surface (D&S)','Drilling & Surface'));
        tiers.add(new SelectOption('Subsea (SS)','Subsea'));
        
    }
    
    public PageReference setTiers(){
        this.tier2=aPlan.GE_OG_Tier_2_P_L__c;
        this.tier3=aPlan.GE_OG_Tier_3_P_L__c;
        return null;
    }*/
    
    public Embedded_Analytics_Extn(){
    }
    
}