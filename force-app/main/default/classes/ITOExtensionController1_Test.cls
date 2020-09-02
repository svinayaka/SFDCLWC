/*
  class :: test class
  to cover :: ITOExtensionController1
  created by :: Hari B
  Date :: 11-Feb-2015
  coverage :: 88%

*/

@istest
public class ITOExtensionController1_Test{
  
  static testmethod void  ITOEXTMETH1()
  {
     Test.Starttest();
       ITO_Commercial__c objTIO=new ITO_Commercial__c();
       insert objTIO;
       
       ApexPages.StandardController SC=new  ApexPages.StandardController(objTIO);
      ITOExtensionController1 objitoclass=new ITOExtensionController1(SC);
      objitoclass.submit();
      Test.StopTest();
  }

}