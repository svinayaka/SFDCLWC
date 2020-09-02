/**********
Class Name          : GE_PRM_TriggerhelperClass 
Used Where ?        : This acts as helper class to prevent trigger recursions in PRM                     
Purpose/Overview    : Check and Uncheck boolean values in this class to stop multiple execution of trigger 
Functional Area     : PRM
Author              : Pradeep Rao Yadagiri
Created Date        : 10/22/2014
Test Class Name     : Test_GE_PRM_Channel_Appointment_Class
Change History - 
Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change
************/

public class GE_PRM_TriggerhelperClass {
    private static boolean sendmailToPublicgroup = false;
    
    public static boolean sendmailToPublicgroup() {
        return sendmailToPublicgroup;
    }
    public static void setsendmailToPublicgroup() {
        sendmailToPublicgroup = true;
    } 
    private static boolean archiveoldchappt = false;
    
    public static boolean getarchiveoldchappt() {
        return archiveoldchappt;
    }
    public static void setarchiveoldchappt() {
        archiveoldchappt = true;
    }
    private static boolean archiveold = false;
    
    public static boolean getarchiveold() {
        return archiveold;
    }
    public static void setarchiveold() {
        archiveold = true;
    }
}