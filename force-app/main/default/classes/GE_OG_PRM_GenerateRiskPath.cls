Public Without sharing class GE_OG_PRM_GenerateRiskPath
{

  Public PageReference generateRisk(List<GE_PRM_Channel_Appointment__c> oldObjects, List<GE_PRM_Channel_Appointment__c> newObjects, Map<Id, GE_PRM_Channel_Appointment__c> oldmapCPA)
  {
 
    for(GE_PRM_Channel_Appointment__c newCPA :newObjects)
    {
      
      if(newCPA .GE_PRM_DOA_generated__c==true &&(newCPA.GE_PRM_Mandated_by_End_Customer__c!=oldmapCPA.get(newCPA.id).GE_PRM_Mandated_by_End_Customer__c 
        ||newCPA.GE_PRM_Export_Controlled_products__c!=oldmapCPA.get(newCPA.id).GE_PRM_Export_Controlled_products__c 
        ||newCPA.GE_PRM_High_Risk_product_lines__c!=oldmapCPA.get(newCPA.id).GE_PRM_High_Risk_product_lines__c
        ||newCPA.GE_PRM_Approved_exclusivity_from_P_L__c!=oldmapCPA.get(newCPA.id).GE_PRM_Approved_exclusivity_from_P_L__c
        ||newCPA.GE_PRM_Do_you_sell_to_the_government__c!=oldmapCPA.get(newCPA.id).GE_PRM_Do_you_sell_to_the_government__c
        ||newCPA.GE_PRM_Do_you_have_Officers_in_Gov__c!=oldmapCPA.get(newCPA.id).GE_PRM_Do_you_have_Officers_in_Gov__c 
        ||newCPA.GE_PRM_Convicted_of_any_felony_crims_r_s__c!=oldmapCPA.get(newCPA.id).GE_PRM_Convicted_of_any_felony_crims_r_s__c
        ))
        {
          ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.FATAL, 'You cannot change the Risk path once approvers are Generated');
          ApexPages.addMessage(myMsg); 
        } 
     }
          Return null;
    } 
    
    // Method needs to be commented for breaking the linkage of CA and KYC object
    /*
    Public PageReference updateKYC( List<GE_PRM_Channel_Appointment__c> newObjects)
    {
 
     GE_PRM_Channel_Appointment__c channelApp =new  GE_PRM_Channel_Appointment__c();
     channelApp = [select Id,Name,CreatedDate,GE_PRM_Account_Name__c,GE_PRM_Current_Status__c  from GE_PRM_Channel_Appointment__c where GE_PRM_Account_Name__c =:newObjects[0].GE_PRM_Account_Name__c order by CreatedDate,Name asc limit 1 ];
     list<GE_PRM_KYC_Termination_Checklist__c> kyc = new list<GE_PRM_KYC_Termination_Checklist__c>([select id,name,GE_PRM_Channel_Appointment__c,GE_HQ_Account__c,GE_PRM_Status__c,GE_PRM_KYC_Completed_Time_Stamp__c from GE_PRM_KYC_Termination_Checklist__c where GE_HQ_Account__c =:newObjects[0].GE_PRM_Account_Name__c]);

      if(kyc.size()>0)
        {
         if(kyc[0].GE_PRM_Channel_Appointment__c==NULL   )
         {
             kyc[0].GE_PRM_Channel_Appointment__c=channelApp.id;

         }    
              update kyc[0];
         }
      
             return null;
     }
     */
 
}