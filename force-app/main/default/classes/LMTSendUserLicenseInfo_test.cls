/******************************************************************************************************************************
* @Name -               SendUserLicenseInfo_test
* @Author:              CHandralekha
* @ Modified By:        
* @Used By:             
*----------------------------------------------------------------------------
* Description - This class does the following:
                * It provides the test coverage to SendUserLicenseInfo class
                
* Modification Log :
* --------------------------------------------------------------------------- */
@istest
public class LMTSendUserLicenseInfo_test {
    @istest
    static  void testmethod1(){
      List<LicenseManagmentData__mdt> org=[SELECT LMTClientSec__c,Label,LMTClientId__c,LMTPwd__c,LMTUID__c,LMTURLServices__c,LMTURL__c FROM LicenseManagmentData__mdt WHERE Label = 'LicenseManagmentData'];
      Test.startTest();
      Test.setMock(HttpCalloutMock.class, new LMTMockHttpResponseGenerator ());
      Database.BatchableContext bc;
      LMTSendUserLicenseInfo bClass = new LMTSendUserLicenseInfo();
      bClass.start(bc);
      LMTSendUserLicenseInfo.execute(bc, org);
      bClass.finish(bc);
      Test.stopTest();
    }


}