/********************************************************/
/***Class Name: WebFormMobileSiteController**************/
/***Purpose: Test class for WebFormMobileSiteController**/
/***Created Date: 10/03/2016*****************************/
/***Created By: Richa Chauhan****************************/
/********************************************************/

@istest

Private Class testWebFormMobileSiteController{
    
    Static testmethod Void testWebFormMobileSiteController()
    {
        
    }
    
    Static testmethod void submitCase1()
    {
        WebFormMobileSiteController wfmsc = new WebFormMobileSiteController ();
        
      //  wfmsc.submitCase();
        wfmsc.CloseCase();
        wfmsc.CreateNewCase();    
            
    }
}