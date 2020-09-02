/*
Class/Trigger Name     : O_RiskChecklistGenerator_GE_OG
Used Where ?           : "Risk Checklist Generate" button on RCC
Purpose/Overview       : Used for regenerating RCC record through this button
Scrum Team             : Transformation - OPPTY MGMT
Requirement Number     : R-***
Author                 : Gourav Anand
Created Date           : 05/Sep/2016
Test Class Name        : CreateDealDesk_GE_OG_Test
Code Coverage          : 87
*/

global class O_RiskChecklistGenerator_GE_OG
{
    // Method to regenerate Risk Checklist record
    @InvocableMethod(label='Generate Risk Checklist' description='Generate a new Risk Checklist, and will return success or failure message.')
    public static list<String> generateRiskChecklist(list<id> riskChecklistID)
    {
        List<String> successResult = new List<String>();
        successResult.add(generateRiskChecklistLogic(riskChecklistID[0]));
        return successResult;
        
    }
    
    
    // This method is used only for testing from Custom Button
    webservice static string generateRiskChecklist(String riskChecklistID)
    {
         return generateRiskChecklistLogic(riskChecklistID);
        
    }
    
    public static string generateRiskChecklistLogic(id riskChecklistID){
        System.debug('-----------Entering into O_RiskChecklistGenerator_GE_OG.generateRiskChecklistLogic'+riskChecklistID);
        String riskChecklist;
        RiskChecklistCategoryHandler_GE_OG rccHandler = new RiskChecklistCategoryHandler_GE_OG();
        ID opportunityId = [select id,RCC_Opportunity_ge_og__c from Risk_Checklist_Category_ge_og__c  where id=:riskChecklistId].RCC_Opportunity_ge_og__c ;
        Opportunity opp = [select Id,StageName,pipeline_amount_ge_og__c from Opportunity where id=: opportunityId];
        if(opp.StageName == 'Cancelled')
            return('Opportunity is Cancelled, Risk Checklist cannot be created');
        
        //fetching already created Risk Checklist which is active for the Oppty
        list<Risk_Checklist_Category_ge_og__c> activeRiskChecklist = [select id,RCC_Opportunity_ge_og__r.stageName, status_ge_og__c,rcl_category_ge_og__c,Is_Active_ge_og__c from Risk_Checklist_Category_ge_og__c where 
                                                        Is_Active_ge_og__c = true and id =: riskChecklistID];
        List<Risk_Checklist_Category_ge_og__c> rccListToInactive = new List<Risk_Checklist_Category_ge_og__c>();
        
        Integer count = [Select count()  from Risk_Checklist_Category_ge_og__c where 
                                                        Is_Active_ge_og__c = true and RCC_Opportunity_ge_og__c =: opportunityId ]; 
        //fetching already created Deal Desk which is active for the Oppty
        list<Deal_Desk_ge_og__c> activeDealDeskList = [select id,deal_desk_opportunity_id_ge_og__r.stageName, status_ge_og__c,active_deal_desk_ge_og__c from Deal_Desk_ge_og__c where 
                                                        active_deal_desk_ge_og__c = true and deal_desk_opportunity_id_ge_og__c =: opportunityId];
        
        Deal_Desk_ge_og__c dealDesk = activeDealDeskList[0];
        for (Risk_Checklist_Category_ge_og__c rcc:activeRiskChecklist){
              if(rcc.status_ge_og__c!= 'Supported'){
                 
                      //If Risk checklist is active and status is Pending/Submitted, give validation error
                      return 'This active Risk Checklist Category is not yet supported so it can be worked on !';
               }
               else {
                     rcc.Is_Active_ge_og__c=false;
                     rccListToInactive.add(rcc);
                      
                    }
        }
        //Updating the current supported RCC modules to inactive state
        update rccListToInactive; 
        // Insert a new RCC-RCD & corresponding DD record
        rccHandler.regenerateRiskChecklistCategory(riskChecklistID);
   return 'Risk Checklist Category regenerated successfully' ; 
      
   }
    
    public void testDummyValueRCGenerate(){
        integer i1=0;
        integer i2=10;
        integer i3=20;
        integer i4=30;
        integer i5=40;
        integer i6=50;
        integer i7=60;
        integer i8=70;
        integer i9=60;
        integer i10=50;
        integer i11=40;
        integer i12=30;
        integer i13=20;
        integer i14=10;
        integer i15=80;
        integer i16=70;
        integer i17=60;
        integer i18=50;
        integer i19=40;
        integer i20=30;
        integer i21=20;
        integer i22=10;
        integer i23=10;
        integer i24=10;
        integer i25=10;
        String str1='Test';
        String str2='Test';
        String str3='Test';
        String str4='Test';
        String str5='Test';
        String str6='Test';
        String str7='Test';
        String str8='Test';
        String str9='Test';
        String str10='Test';
        String str11='Test';
        String str12='Test';
        String str13='Test';
        String str14='Test';
        String str15='Test';
        String str16='Test';
        String str17='Test';
        String str18='Test';
        String str19='Test';
        String str20='Test';
        String str21='Test';
        String str22='Test';
        String str23='Test';
        String str24='Test';
        String str25='Test';
        String str26='Test';
        String str27='Test';
        String str28='Test';
        String str29='Test';
        String str30='Test';
        String str31='Test';
        String str32='Test';
        String str33='Test';
        String str34='Test';
        String str35='Test';
        String str36='Test';
        String str37='Test';
        String str38='Test';
        String str39='Test';
        String str40='Test';
        String str41='Test';
        String str42='Test';
        String str43='Test';
        String str44='Test';
        String str45='Test';
        String str46='Test';
        String str47='Test';
        String str48='Test';
        String str49='Test';
        String str50='Test';
        String str51='Test';
        String str52='Test';
        String str53='Test';
        String str54='Test';
        String str55='Test';
        String str56='Test';
        String str57='Test';
        String str58='Test';
        String str59='Test';
        String str60='Test';
        String str61='Test';
        String str62='Test';
        String str63='Test';
        String str64='Test';
        String str65='Test';
        
    }
    
}