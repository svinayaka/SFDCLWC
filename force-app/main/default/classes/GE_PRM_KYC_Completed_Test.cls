@istest
public class GE_PRM_KYC_Completed_Test
{

public static Testmethod  void GE_PRM_KYC_Completed_Test1()
{

Test.starttest();
  Schema.DescribeSObjectResult accObj = Schema.SObjectType.Account; 
        Map<String,Schema.RecordTypeInfo> accByName = accObj.getRecordTypeInfosByName();
        Schema.RecordTypeInfo rtByName_acc1 =  accByName.get('CMF Approved');
        Id acc12=rtByName_acc1.getRecordTypeId();
        
        Account Acc= new Account();
        Acc.Name='Test Acc';  
        Acc.GE_HQ_KYC_Complete__c=False;
        Acc.GE_PRM_KYC_Completed__c=False;
        Acc.GE_HQ_DUNS_Number__c='555123459';  
        Acc.GE_OG_Buss_Tier1__c='Oil & Gas (O&G)';
        Acc.GE_OG_Buss_Tier2__c='Drilling & Surface (D&S)';
        Acc.GE_OG_Buss_Tier3__c='D&S - DT';
        Acc.GE_PW_Country_Quote_To_Sold_To_HQ__c='UNITED STATES';
        Acc.GE_PW_City_Quote_To_Sold_To_HQ__c='city';
        Acc.GE_PW_State_Province_Quote_To_Sold_To_HQ__c='state';
        Acc.GE_PW_Zip_Postal_Code_Quote_To_Sold_ToHQ__c='zip';
        Acc.GE_PW_Country_Bill_To__c='UNITED STATES';
        Acc.GE_PW_City_Bill_To__c='United States';
        Acc.GE_PW_State_Province_Bill_To__c='state';
        Acc.GE_PW_Zip_Postal_Code_Bill_To__c='560068';
        Acc.GE_PW_Country_Ship_To__c='UNITED STATES';
        Acc.GE_PW_City_Ship_To__c='city';
        Acc.GE_PW_State_Province_Ship_To__c='state';
        Acc.GE_PW_Zip_Postal_Code_Ship_To__c='zip';
        Acc.GE_HQ_New_Account_Country__c = 'UNITED STATES';
        Acc.GE_HQ_Nts_Comments__c='Test'; 
        Acc.GE_OG_MDM_Shipping_Country_ISO_Code__c = 'US';     
        acc.GE_OG_MDM_Billing_Country_ISO_Code__c ='IN';
       
        acc.RecordTypeId=acc12;
        acc.GE_OG_AccFin_Status__c='In Progress';
        acc.Account_Status__c ='CC Approved';
        acc.ShippingCountry ='ARGENTINA';
        acc.GE_PW_Phone_New_Request__c='(111)111-1111';
        Acc.GE_HQ_Site_Use_Code__c ='BILL_TO';
      
      
        insert Acc;  
        
       
      
    GE_PRM_Commercial_Vetting__c cv = new GE_PRM_Commercial_Vetting__c();
    cv.GE_PRM_Account__c = acc.id;
    cv.GE_PRM_Tier_2__c='Measurement & Control (M&C)';
    cv.GE_PRM_Type__c='New';
    cv.GE_PRM_Status__c='In Process';
    cv.GE_PRM_Reasons_for_recommendation__c='Test';
    cv.GE_PRM_Reasons_for_relationship__c='Test';
    cv.GE_PRM_Other_channels_considered__c='No';
    cv.GE_PRM_of_sales_with_GE_products__c=10;
    cv.GE_PRM_Coverage_overlap__c='No';
    cv.GE_PRM_Investment_required__c='No'; 
    cv.GE_PRM_Competitive_lines_or_services__c='No';
    cv.GE_PRM_Complimentary_Lines__c='Test';
    cv.GE_PRM_Other_GE_products__c='No';
    cv.GE_PRM_Time_in_business__c='2';
    cv.GE_PRM_Reputation_of_channel__c='Test';
    cv.GE_PRM_of_sales_people_selling_GE__c=12;
    cv.GE_PRM_Total_revenue__c=12;
    cv.GE_PRM_Expected_GE_Revenue__c=12; 
    cv.GE_PRM_I_Certify_above_information_true__c=true;
   
    insert cv;
   
 
   
    String rt1 = Schema.SObjectType.GE_PRM_Recommendation__c.getRecordTypeInfosByName().get('New Fast Track').getRecordTypeId(); 
    
         GE_PRM_Recommendation__c recomObjnew = new GE_PRM_Recommendation__c();
    recomObjnew.recordtypeid = rt1;  
    recomObjnew.GE_PRM_Status__c = 'In Process';    
    recomObjnew.GE_PRM_Account__c=acc.id;
    recomObjnew.GE_PRM_Business_Tier_1__c='Oil & Gas (O&G)';
    //recomObj.GE_PRM_Basic_Information_Page__c='Completed';
    recomObjnew.GE_PRM_sales_in_US_only__c='no';
    recomObjnew.GE_PRM_selling_to_government__c='No';
    recomObjnew.GE_PRM_use_of_sub_dealer__c='No';
    recomObjnew.GE_PRM_partner_1yr__c='No';
    recomObjnew.GE_PRM_Non_standard_discounts__c='Higher than Standard';
    recomObjnew.GE_PRM_Agreement_Type__c='New';
    recomObjnew.GE_PRM_Business_Tier_2__c=('Drilling & Surface (D&S)');
    recomObjnew.GE_PRM_Commercial_Vetting__c=cv.id;
    recomObjnew.GE_PRM_Channel_Manager_Contact__c='testing';
    recomObjnew.GE_PRM_Agreement_Category__c='New'; 
    
    insert recomObjnew;
      String RecID = Schema.SObjectType.GE_PRM_KYC_Termination_Checklist__c.getRecordTypeInfosByName().get('No KYC Required').getRecordTypeId(); 

GE_PRM_KYC_Termination_Checklist__c kyc = new GE_PRM_KYC_Termination_Checklist__c();     
      kyc.GE_HQ_Account__c = acc.Id;    
      kyc.GE_HQ_Bill_To_Street__c ='Test Street';  
      kyc.GE_HQ_Bill_To_City__c='Test city';  
      kyc.GE_HQ_Bill_To_State__c='Test State'; 
      kyc.GE_HQ_Bill_To_Country__c='India';   
      kyc.GE_HQ_Bill_To_Zip__c='123456';   
      kyc.GE_HQ_VAT_Tax_ID__c = 'AHJPQ2339K';   
      kyc.GE_HQ_Phone_Num__c='08916624435';   
      kyc.GE_HQ_Ship_To_Street__c = 'Test Street'; 
      kyc.GE_HQ_Ship_To_City__c = 'Test Street';  
      kyc.GE_HQ_Ship_To_State__c = 'Test Street';   
      kyc.GE_HQ_Ship_To_Country__c = 'India';   
      kyc.GE_HQ_Ship_To_Zip__c = '9457395';     
     kyc.GE_PRM_Recommendation__c=recomObjnew.Id;
      kyc.GE_PRM_Status__c='KYC Passed';
      kyc.recordtypeid =RecID ;
      //kyc.GE_PRM_Status__c='Due Diligence Accepted';
      kyc.GE_HQ_Status__c='Manual Due Diligence Approved';
      Insert kyc;
Test.stopTest();



}


}