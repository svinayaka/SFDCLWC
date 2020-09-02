public class GE_OG_CIR_StatusChange
{

    public void statuchangemethod(list<case> newlist,map<id,case> oldmap)
    {
         Id rmcs= Schema.SObjectType.Case.getRecordTypeInfosByName().get('MC-TS').getRecordTypeId();
        Id rcir= Schema.SObjectType.Case.getRecordTypeInfosByName().get('CIR').getRecordTypeId();
        for(case c:newlist)
        {
           if(string.valueof(c.ownerid).startswith('00G')==true&&(c.recordtypeid==rmcs||c.recordtypeid==rcir))
           {
           
           c.status='New';
           }
        }
    
    
    
    
    }




}