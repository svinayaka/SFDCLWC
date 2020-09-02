/*
================================================================
Class Name : GE_MCS_massCaseCloseController
Author          : Jagan Mohan Cherlakola
Created Date    : 23/12/2013
Reason          : This Controller is used with 'GE_MCS_massCaseClose' page to close number of cases using 'Mass Case Close' button on MCS List View.
Test Class      : GE_MCS_massCaseCloseController_Test
Modified By/ ON : Vijaya Murukutla / On 18 July 2014
Purpose : Included the logic for Subtype validation as part of the R-17252

================================================================
*/

public class GE_MCS_MassCaseCloseController 
{

    public ApexPages.StandardSetController setCon;
    List<String> noACdet= new List<String>();
    List<String> difRecList= new List<String>();
    List<Case> ACdet= new List<Case>();
    public String csNums{get;set;}
    public Integer noCs{get;set;}
    public String msg{get;set;}
    public String msg1{get;set;}
    public String msg2{get;set;}
    public boolean flag{get;set;}
    public boolean toggle{get;set;}
    public boolean mblock{get;set;}
    public boolean difRec{get;set;}
    public boolean temp{get;set;}
    public boolean oktemp{get;set;}
    Public Id LoggedInUSerId{get;set;}
    
    
    //

    public GE_MCS_MassCaseCloseController(ApexPages.StandardSetController controller) {
        setCon = controller;
        LoggedInUSerId = UserInfo.getUserId();
        //recordAction();
        getListCases();
        getMyRecordsSize();
        getMySelectedSize();
       
    }
    
    public void recordAction(){
   /* for ( Case cse : (Case[])setCon.getSelected() )
    {
      if (cse.RecordTypeId!='012A0000000k0IAIAY') {
      //cse.addError('Your custom error message');
      difRecList.add(cse.CaseNumber);    
      }
    }
    if(difRecList.size()> 0 ){
    Msg2 = 'Note: This button works only for "MCS-CS" Record Type';
    difRec=true;
    mblock= false;
 
    system.debug('$$ difRecList'+difRecList +'difRec'+difRec);
  
    }*/
   
   }
    
    

    public integer getMySelectedSize() {
    //system.debug('$$$size'+setCon.getSelected().values());
        return setCon.getSelected().size();
        
    }
    public integer getMyRecordsSize() {
     system.debug('$$$size'+setCon.getSelected().size());
     //mblock=true;
     temp=false;
     oktemp=false;
        if(setCon.getSelected().size()== 0 ){
             Msg1 = 'Note: Please select atleast one Case to Close';
             toggle = true;
           // mblock= false;
        }
     return setCon.getRecords().size();
    }
     
    
    public void getListCases()
    {
       for ( Case cse : (Case[])setCon.getSelected() )
        {
        system.debug('$$selected cases'+(Case[])setCon.getSelected());
        system.debug('$$AccName'+cse.Account.Name);system.debug('$$Contact name'+cse.Contact.Name);
        if(cse.RecordType.Name=='MCS - CS')
          {
             if(cse.RecordType.Name=='MCS - CS' && cse.Account.Name!=null && cse.Contact.Name!=null && cse.ownerId==LoggedInUSerId && cse.GE_ES_Sub_Type__c !=null){
             ACdet.add(cse);
                
             }
             else{
             noACdet.add(cse.CaseNumber);
                              
             system.debug('$$noACdet'+noACdet);
             }
          }
        else
          {
         difRecList.add(cse.CaseNumber);
          }
                     
        }
       noCs=noAcdet.size();
       csNums=String.join( noACdet,', ');
       if(Acdet.size()> 0 )
        {
         mblock= true;
        }
        if(Acdet.size()== 0)
        {
         //flag = true;
         oktemp= true;
         system.debug('$$$oktemp'+oktemp+'Acdet.size()'+Acdet.size());
        }
       if(noAcdet.size()> 0 )
        {
         Msg = 'Note: The cases '+ csNums +' will not be closed, as they do not have Account or Contact or Sub type fields completed, or you are not the owner of the case.';
          flag = true;
        }
       if(difRecList.size()> 0 )
       {
        Msg2 = 'Note: This button works only for "MCS-CS" Record Type';
        difRec=true;
        //mblock= false;
        system.debug('$$ difRecList'+difRecList +'difRec'+difRec);
        }
    
    }
      
    
    
    public Pagereference save()
    {
        update Acdet;
        system.debug('$$size'+noCs);
        system.debug('$$CsNums'+csNums);
        system.debug('$$changestatus'+Acdet);
        pagereference ret=setcon.cancel();
        return ret;
    }
}