/*
Type Name [Class/Trigger/Page Name] : Class - GE_OG_trg_Case_CaseShare
Purpose                             : Used to create a caseshare for a case when owner of the case changes 
Functional Area                     : Service
Author                              : CaseTeam
Created Date                        : 6 August 2014
Test Class                          : 
*/


public class  GE_OG_trg_Case_CaseShare
{
    public void createCaseShare(list<case> newlist,map<id,case> oldMapCase)
    {   
    

     Id rtypeCir= Schema.SObjectType.Case.getRecordTypeInfosByName().get('CIR').getRecordTypeId(); 
       Id rtypemcts= Schema.SObjectType.Case.getRecordTypeInfosByName().get('MC-TS').getRecordTypeId();
       Id predixrcID= Schema.SObjectType.Case.getRecordTypeInfosByName().get('OG Predix Support').getRecordTypeId();
       ID NPTRectypeID = Schema.SObjectType.Case.getRecordTypeInfosByName().get('SS_NPT').getRecordTypeId();
       // user u =[select id,profileid from user where id=:userinfo.getuserid()];       
        Set<ID> setCaseCreatedby = new Set<ID>();
        Map<id,User> mapCreatedby= new Map<id,User>();        
        set<id> caseowneid = new set<id>();     
        setCaseCreatedby.add(userinfo.getuserid());
        
       for(case c:newlist)
       {
            caseowneid.add(oldMapCase.get(c.id).ownerid);
            setCaseCreatedby.add(c.createdbyid);
       }
      
        mapCreatedby = new Map<id,User>([select id, isActive,profileID from User where id in  :setCaseCreatedby]);    
      profile p =[select id,name from profile where id=:mapCreatedby.get(userinfo.getuserid()).profileid];
      List<GroupMember> groups = [select Id from GroupMember where Group.Type = 'Queue' and GroupId =:caseowneid and UserOrGroupId =:userinfo.getuserid() ];
       
        list<caseshare>  cslst = new list<caseshare>();
        for(case c:newlist)   
        {
            if(c.origin== null ||c.origin== ''||(c.origin!= null && c.Origin !='OG_ECCR' && c.Origin !='TMS NC System' && c.Origin !='askDrilling System'))
                {   
            if(c.recordtypeID != predixrcID )
            {       
        
            if(c.status=='Open'&&oldMapCase.get(c.id).ownerid!=c.ownerid&&c.recordtypeid==rtypeCir&&p.name!='GE_OG_Super User'&&c.GE_OG_Confirm_Escalated_CIR__c==true)
            {
                   c.adderror('You Cannot change the ownership of this case');
            
            }
             /////////////////////  for NPT Cases
             /*if(string.valueof(oldMapCase.get(c.id).ownerid).startswith('00G') && c.recordtypeid == NPTRectypeID && oldMapCase.get(c.id).ownerid!=c.ownerid ){
            List<GroupMember> groups1 = [select Id from GroupMember where Group.Type = 'Queue' and GroupId =:oldMapCase.get(c.id).ownerid and UserOrGroupId =:userinfo.getuserid() ];
            if(groups1 == null || groups1.size()<=0) {
               
                   c.adderror('Only a Queue member can take the ownership of NPT cases, if you want to assign to some one else Please accept and then chnage the owner.');
            }
            
        } */
             
             /////////////// for NPT cases
        if(c.status!='New'&& string.valueof(oldMapCase.get(c.id).ownerid).startswith('00G')!=TRUE)
        {         
         
              if(p.name!='GE_OG_Super User' && c.recordtypeid==rtypeCir && oldMapCase.get(c.id).ownerid!=c.ownerid && oldMapCase.get(c.id).ownerid!=userinfo.getuserid())
              {
                   c.adderror('Only Case Owner or Super User can change the ownership of the CIR case.');
              } 
           
         }
         else if(c.status=='New')
        {
          if(oldMapCase.get(c.id).GE_OG_CIR_Type_of_Issue__c==c.GE_OG_CIR_Type_of_Issue__c && 
          oldMapCase.get(c.id).GE_OG_Customer_Impact_CIR__c==c.GE_OG_Customer_Impact_CIR__c   &&
           oldMapCase.get(c.id).GE_OG_Customer_Escalation_CIR__c==c.GE_OG_Customer_Escalation_CIR__c&& 
           oldMapCase.get(c.id).GE_OG_GE_Executive_Request_CIR__c==c.GE_OG_GE_Executive_Request_CIR__c&&
           oldMapCase.get(c.id).GE_OG_EHS_Product_Safety_CIR__c==c.GE_OG_EHS_Product_Safety_CIR__c&&
           oldMapCase.get(c.id).GE_OG_Business_CIR__c==c.GE_OG_Business_CIR__c &&
           oldMapCase.get(c.id).GE_OG_Sub_Business_CIR__c==c.GE_OG_Sub_Business_CIR__c&&
           string.valueof(oldMapCase.get(c.id).ownerid).startswith('00G')==TRUE &&
           oldMapCase.get(c.id).ownerid!=c.ownerid && c.recordtypeid==rtypeCir&&
           p.name!='GE_OG_Super User')
          {
            c.adderror('Case Owner can not be changed without accepting the case by clicking on "Accept"');
          }
          else if (string.valueof(oldMapCase.get(c.id).ownerid).startswith('00G')!= TRUE)
          {
               if(p.name!='GE_OG_Super User'&& c.recordtypeid==rtypeCir && oldMapCase.get(c.id).ownerid!=c.ownerid && oldMapCase.get(c.id).ownerid!=userinfo.getuserid()&&oldMapCase.get(c.id).recordtypeid!=Schema.SObjectType.Case.getRecordTypeInfosByName().get('MC-TS').getRecordTypeId())
                  {
                       c.adderror('Only Case Owner or Super User can change the ownership of the CIR case');
                  } 

          }
       }
      }
       System.debug('initiator status:-----'+mapCreatedby.get(c.createdById).isActive);

            if((mapCreatedby.get(c.createdById) != null && mapCreatedby.get(c.createdById).isActive == True)&&c.ownerid!=c.createdById&&c.ownerid!= oldMapCase.get(c.id).ownerid&&(c.recordtypeid==rtypeCir||c.recordtypeid==rtypemcts|| c.recordtypeid==predixrcID||c.recordtypeid==NPTRectypeID))              {            
                caseShare cshare = new caseShare();   
                if( c.recordtypeid==predixrcID)
                    {           
                    cshare.CaseAccessLevel = 'Read'; 
                    }
                else
                {
                    cshare.CaseAccessLevel = 'Edit'; 
                }
                       
                cshare.CaseId = c.id;            
                cshare.UserOrGroupId = c.createdById;            
                cslst.add(cshare); 
                system.debug('inside adding case team');
            }  
            
         
        
           
            
        }       
     }
     
     system.debug('case team size'+cslst.size());
     
        if(cslst != null && cslst.size() > 0)
        {
       insert cslst;
       }
        }
        
    
      
}