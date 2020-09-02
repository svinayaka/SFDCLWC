/*
================================================================
Type Name   : SVMX_EODocAttached_Cntrl
Author      : Raja Kumar M
Created Date: 10/12/2013
Reason      : This class is used to display the message on work order if Executive Ovveride is checked.
================================================================
*/


public class SVMX_EODocAttached_Cntrl {
     //Commented as part of requirement R-26296
    //Public String woid{get;set;}
    public SVMXC__Service_Order__c wo{get;set;}
    /*public String msg{get;set;}
    public boolean flag{get;set;}
    public SVMXC__Service_Order__c woRec {get;set;}*/
    public SVMX_EODocAttached_Cntrl(ApexPages.StandardController controller) {
        wo = (SVMXC__Service_Order__c) controller.getRecord();
       /* woid = wo.id;
        if(woid != null)
        //woRec = [select id,GE_DS_EO__c,GE_DS_Visa_Required__c from SVMXC__Service_Order__c where id =: woid];
    }   
    public void messageAction(){
        System.debug('***woRec***'+woRec);
        if(worec != null)
        if(woRec.GE_DS_EO__c == true){
            List<Attachment> Att = [select id from Attachment where pArentID = : woId];
            if(Att.size()  == 0 || Att == null){
                Msg = 'You have checked the Executive Override box: Please attach the supporting authorization under the "Attachments and Notes" section below.';
                flag = true;
            }
        }
        
        if (woRec.GE_DS_Visa_Required__c== true && woRec.GE_DS_EO__c==false  ){
        Msg='If technician does not have the appropriate visa, please select the "Executive Override Required" checkbox and initiate EO process.';
        flag = true;
        } 
    }*/
}
}