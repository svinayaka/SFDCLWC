@isTest
private class GE_AL_CreateWellEquipRunDataScheduleTest{
                       static testmethod void  testschedule(){
                       Test.StartTest();
                       GE_AL_CreateWellEquipRunDataSchedule sh1 = new GE_AL_CreateWellEquipRunDataSchedule();
                       String sch = '0 0 2 * * ?';
                       system.schedule('Test', sch, sh1);
                       Test.StopTest();
                       }
                }