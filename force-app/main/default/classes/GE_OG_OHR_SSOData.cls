/*
 * This will be used to serialize and deserialized sso service data
 * MJM 2014-02-25: Added new field to mapping - public String managerEmail
 */
public class GE_OG_OHR_SSOData {
    
    public Person person;

    public class ITFSEExpatContract {
        public String foreignPlant;
        public String country;
        public String zone;
        public String location;
        public Date effectiveStartDate;
        public Date effectiveEndDate;
    }

    public class Person {
        public String firstName;
        public String lastName;
        public String fullName;
        public String title;
        public String gender;
        public String sso;
        public String emailAddress;
        public Date dateOfBirth;
        public String personType;
        public Date dateFirstHired;
        public Date legalEntityHireDate;
        public Date actualTerminationDate;
        public String organizationName;
        public String businessSegment;
        public String subBusiness;
        public String positionTitle;
        public String payrollName;
        public String legalEntity;
        public String workLocationCountry;
        public String workLocationName;
        public String manager;
        public String managerEmail;
        public String yearsOfService;
        public String CWSupplierCompany;
        public String CWSupplierCode;
        public String ITContractType;
        public String ITContractStatus;
        public String workLocationStateOrProvince ;
        public String workLocationRegion ;
        public String workLocationAddressLine1 ;
        public String workLocationAddressLine2 ;
        public String workLocationTownOrCity ;
        public String work1PhoneNumber ;
        public String work2PhoneNumber ;
        public String mobilePhoneNumber ;
        public String workLocationPostalCode ;
        public ITFSEExpatContract ITFSEExpatContract;
    }

    /*
     * deserialize json string 
     */
    public static GE_OG_OHR_SSOData parse(String json) {
        try{
            return (GE_OG_OHR_SSOData ) System.JSON.deserializeStrict(json, GE_OG_OHR_SSOData.class);
        }catch(Exception e){
            String strJson = e.getMessage();
            System.Debug('... Json Exception .... '+e.getMessage());
            if(strJson.contains('Unknown field') && !strJson.contains('Unknown field: GE_OG_OHR_SSOData.errorResponse')){
                return (GE_OG_OHR_SSOData ) System.JSON.deserialize(json, GE_OG_OHR_SSOData.class);
            }else{
                throw new GE_OG_GS_SSOException('Bad SSO Data Found');
                return new GE_OG_OHR_SSOData();
            }
        }
    }
}