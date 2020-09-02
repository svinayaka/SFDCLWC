@isTest
private class GE_AL_UpdateWellEquipRunDataScheduleTest{
                       static testmethod void  testschedule(){
                       Test.StartTest();
                       GE_AL_UpdateWellEquipRunDataSchedule sh1 = new GE_AL_UpdateWellEquipRunDataSchedule();
                       String sch = '0 0 2 * * ?';
                       system.schedule('Test', sch, sh1);
                       Test.StopTest();
                       }
                }