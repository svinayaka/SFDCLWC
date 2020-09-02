@isTest(SeeAllData=true)
public class GE_AL_PullHelper_Test{
  static testmethod void pull11()
    {
        Test.StartTest();
        
        SVMXC__Site__c loc = [select Id from SVMXC__Site__c where GE_AL_Well__c=true limit 1]; 
        I__c install = new I__c (LW__c = loc.id);
        insert install;
        
        GE_AL_Well_Run_Data__c w1 = new GE_AL_Well_Run_Data__c(GE_AL_Install__c=install.id,GE_AL_Location__c=loc.id);
        insert w1;
         
        date myDate = date.today();
        P__c pull = new P__c (LL__c=loc.id,DS__c=myDate);
        insert pull;
        
        test.stopTest();     
    }
    
   static testmethod void pull22()
    {
        Test.StartTest();
    
        SVMXC__Site__c loc = [select Id from SVMXC__Site__c where GE_AL_Well__c=true limit 1];
        SVMXC__Installed_Product__c ip = [select Id from SVMXC__Installed_Product__c where GE_OG_DS_Part_Number__c = '17988' limit 1];
        date myDate1 = date.today();
        I__c install = new I__c (LW__c = loc.id,DS__c = myDate1, DC__c = myDate1, P__c = ip.id, P2__c = ip.id, P3__c = ip.id, P4__c = ip.id, P5__c = ip.id, P6__c = ip.id, P7__c = ip.id, I__c = ip.id, I2__c = ip.id, L__c = ip.id, L2__c = ip.id, M__c = ip.id, M2__c = ip.id, R__c = ip.id, C__c = ip.id);
        insert install;
        
        GE_AL_Equipment_Run_Data__c e1 = new GE_AL_Equipment_Run_Data__c(SVMXC_Installed_Product__c = ip.id,GE_AL_Location__c=loc.id, GE_AL_Install_Date__c = myDate1);
        insert e1;
         
        date myDate = date.today();
        P__c pull = new P__c (LL__c=loc.id,DS__c=myDate,P1__c=ip.id,P2__c=ip.id,P3__c=ip.id,P4__c=ip.id,P5__c=ip.id,P6__c=ip.id,I1__c=ip.id,I2__c=ip.id,SU__c=ip.id,L__c=ip.id,MN__c=ip.id,MI__c=ip.id,MQ__c=ip.id,SR__c=ip.id,M__c=ip.id);
        insert pull;
        
        test.stopTest();     
    } 
    
}