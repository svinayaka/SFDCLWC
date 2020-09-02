public with sharing class GE_OG_Mapa_ExpertiseExtn {
    
    private String recId;
    List<SVMXC__Service_Group_Skills__c> sMaxExpertiseList;    
    List<SVMXC__SVMX_Event__c> sMaxEventList;
    private String techId;
    
    public GE_OG_Mapa_ExpertiseExtn(){
        sMaxExpertiseList = new List<SVMXC__Service_Group_Skills__c>();
        sMaxEventList = new List<SVMXC__SVMX_Event__c>();
        techId='';
    }
    
    // This method is called when the Vf page GE_OG_Mapa_Expertise loads.  Map anything passes the ID of the SMax Event record
    public void getSkillInfo(){   
        //recordId is the parameter MapAnything passes via the custom button we place on the UI
        if(apexpages.currentpage().getparameters().get('recordId')==null){
            recId='';
            System.debug('recordId value is null');
        }
        else{
            recId =apexpages.currentpage().getparameters().get('recordId');
            Id i = Id.valueOf(recId);
            String objectAPIName = i.getSObjectType().getDescribe().getName();
            System.debug('Set recId to: ' + recId);
            System.debug('Object name is: ' + objectAPIName);            
            if(objectAPIName == 'SVMXC__Service_Group_Members__c')
                techId=i;
            else if (objectAPIName =='SVMXC__SVMX_Event__c'){
                List<SVMXC__SVMX_Event__c> lEvent = new List<SVMXC__SVMX_Event__c> ();
                lEvent = [select SVMXC__Technician__c from SVMXC__SVMX_Event__c where Id = :recId];
                if(lEvent.size() == 1)
                    techId = lEvent[0].SVMXC__Technician__c;
            }
        }
        
    }
    
    // Based on the member variable recId try to pull related Technician expertise records (skills)
    public List<SVMXC__Service_Group_Skills__c> getSMaxExpertiseList() {
        if(techId != '')
            sMaxExpertiseList = [Select Name, GE_OG_GS_Official_Certification_Level__c,SVMXC_Primary_Skill__c from SVMXC__Service_Group_Skills__c where SVMXC__Group_Member__c = :techId];
        System.debug('Expertise List: ' + sMaxExpertiseList);
        return this.sMaxExpertiseList;
    }
    
    public List<SVMXC__SVMX_Event__c> getSMaxEventList(){
        if(techId != '')
            sMaxEventList = [select Name, SVMXC__Service_Order__r.Name, SVMXC__StartDateTime__c, SVMXC__EndDateTime__c from SVMXC__SVMX_Event__c where SVMXC__Technician__c  = :techId 
                             order by SVMXC__EndDateTime__c desc limit 5 ]; 
        System.debug('Event List: ' + sMaxEventList);
        return this.sMaxEventList;
    }
    
}