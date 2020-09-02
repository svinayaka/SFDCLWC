public with sharing class CampaignMemberDetailAsPDF {

    public Boolean isContact {get; set;}
    public CampaignMember campaignMemberRecord {get; set;}
    private Id campaignMemberId;
    public String leadName {get;set;}
    public String website {get; set;}
    public String leadContactCompany {get;set;}
    public String leadCompanyAddress {get; set;}
    public String accName {get;set;}
    public String accClassification {get; set;}
    public String accType {get; set;}
    public String region {get;set;}
    public String country {get; set;}
    //private ApexPages.StandardController ctrl;

    public CampaignMemberDetailAsPDF(ApexPages.StandardController controller) {
        
        String cmrType =  ApexPages.currentPage().getParameters().get('Type');
        campaignMemberId = ApexPages.currentPage().getParameters().get('id');
        
        if(cmrType.equalsIgnoreCase('Contact'))
        {
            isContact = true;
        }
        else
        {
             isContact = false;
        }
        
            getRecord();
        
    }
    
    
    private void getRecord()
    {
        campaignMemberRecord = [Select Contact.Name,Title,Email,Phone,Opt_In_ge_og__c,HasOptedOutOfEmail,Area_of_Interest_ge_og__c,Inquiry_Type_ge_og__c,Description,Region_ge_og__c,Country, Campaign.Name, Campaign.Description, Campaign.tier2_ge_og__c, Campaign.tier3_ge_og__c, Campaign.Primary_Target_Industry_ge_og__c, Campaign.Material_Documentation_link_ge_og__c,Contact.Account.Name, Contact.Account.Classification__c, Contact.Account.Type, Contact.Account.Region_GEOG__c, Contact.Account.Country_GEOG__c,Lead.Name, Lead.Company, Lead.Address,Lead.Street, Lead.City, Lead.State, Lead.PostalCode, Lead.Website, Opportunity_Name__c, Dispostion_Reason_ge_og__c, CMR_Type_ge_og__c, Comments_ge_og__c, Status, CreatedDate, LastModifiedDate, LastModifiedBy.Name, Owner_ge_og__r.Name  FROM CampaignMember WHERE Id =:campaignMemberId ];
        
        if(campaignMemberRecord != null)
        {
            if(isContact)
            {
                leadName = campaignMemberRecord.Contact.Name;
                website = '';
                leadContactCompany = '';
                leadCompanyAddress = '';
                accName = campaignMemberRecord.Contact.Account.Name;
                accClassification = campaignMemberRecord.Contact.Account.Classification__c;
                accType = campaignMemberRecord.Contact.Account.Type;
                region = campaignMemberRecord.Contact.Account.Region_GEOG__c;
                country = campaignMemberRecord.Contact.Account.Country_GEOG__c;
                
                
                
            }
            else
            {
                leadName = campaignMemberRecord.Lead.Name;
                website = campaignMemberRecord.Lead.Website;
                leadContactCompany = campaignMemberRecord.Lead.Company;
                leadCompanyAddress = String.valueOf(campaignMemberRecord.Lead.Street) + String.valueOf(campaignMemberRecord.Lead.City) + String.valueOf(campaignMemberRecord.Lead.State) + String.valueOf(campaignMemberRecord.Lead.PostalCode) ;
               // leadCompanyAddress  = String.valueOf(campaignMemberRecord.Lead.Address);
                accName = '';
                accClassification = '';
                accType = '';
                region = '';
                country = '';
            }
        }
    }
    
    
    
    public CampaignMember campaignMemberRecord()
    {
        if(campaignMemberRecord == null)
        {
            campaignMemberRecord = new CampaignMember();
        }
        
        return campaignMemberRecord;
    }
    

}