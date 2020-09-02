/*
========================================================
Author      : VijayaLakshmi Murukutla
Created On  : 11/Sept/2019
Purpose    : Test Class for the functionlaity / business logic for Schedule and/or Dispatch qualified Personnel to a Job.
        Ref #R-32464
Modified By : 
Modified On : 
Purpose    :
========================================================
*/
@IsTest 
public class SD_getCrewPlanAndJobDetailsTest {
   
    static testmethod void callTestData() {
        SD_getCrewPlanAndJobDetails objgetCPandJob = new SD_getCrewPlanAndJobDetails();
        objgetCPandJob.getCrewPlanData();
        objgetCPandJob.getJobItems();
    }

}