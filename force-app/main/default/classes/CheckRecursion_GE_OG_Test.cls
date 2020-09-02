@isTest
public class CheckRecursion_GE_OG_Test
{
    static TestMethod void runteamMemberTest()
    {
        CheckRecursion_GE_OG.runteamMember();
    }
    static TestMethod void runOnceTest()
    {
        CheckRecursion_GE_OG.run = true;
        CheckRecursion_GE_OG.runOnce();
        CheckRecursion_GE_OG.run = false;
    }
    
    static TestMethod void dealDeskRecusrionTest()
    {
        //CheckRecursion_GE_OG.run = true;
        CheckRecursion_GE_OG.dealDeskRecusrion();
        //CheckRecursion_GE_OG.run = false;
    }
    
    static TestMethod void ddBeforeProcessTest()
    {
        //CheckRecursion_GE_OG.run = true;
        CheckRecursion_GE_OG.ddBeforeProcess();
        //CheckRecursion_GE_OG.run = false;
    }
    
    static TestMethod void prebidRecursionTest()
    {
        //CheckRecursion_GE_OG.run = true;
        CheckRecursion_GE_OG.prebidRecursion();
        //CheckRecursion_GE_OG.run = false;
    }
    
    static TestMethod void taskRecursionTest()
    {
        //CheckRecursion_GE_OG.run = true;
        CheckRecursion_GE_OG.taskRecursion();
        //CheckRecursion_GE_OG.run = false;
    }
    static TestMethod void runDeliveryDateTest()
    {
        //CheckRecursion_GE_OG.run = true;
        CheckRecursion_GE_OG.runDeliveryDate();
        //CheckRecursion_GE_OG.run = false;
    }
    static TestMethod void eRadCreationTest()
    {
        //CheckRecursion_GE_OG.run = true;
        CheckRecursion_GE_OG.eRadCreation();
        //CheckRecursion_GE_OG.run = false;
    }
    static TestMethod void checkRecursionCampaignTest()
    {
        //CheckRecursion_GE_OG.run = true;
        CheckRecursion_GE_OG.checkRecursionCampaign();
        //CheckRecursion_GE_OG.run = false;
    }
    static TestMethod void cmrRecusrion()
    {
        //CheckRecursion_GE_OG.run = true;
        CheckRecursion_GE_OG.cmrRecusrion();
        //CheckRecursion_GE_OG.run = false;
    }
    static TestMethod void leadRecusrionTest()
    {
        //CheckRecursion_GE_OG.run = true;
        CheckRecursion_GE_OG.leadRecusrion();
        //CheckRecursion_GE_OG.run = false;
    }
}