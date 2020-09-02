/*
 * This will be used to serialize and deserialized sso service data
 * MJM 2014-02-25: Added new field to mapping - public String managerEmail
 */
public class GE_OG_GS_SSOData {
    
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
        public String workLocationRegion;
        public String workLocationStateOrProvince;
        public String workLocationCountry;
        public String workLocationAddressLine1;
        public String workLocationAddressLine2;
        public String workLocationTownOrCity;
        public String workLocationPostalCode;
        public String workLocationName;
        public String mobilePhoneNumber;
        public String work1PhoneNumber;
        public String work2PhoneNumber;
        public String manager;
        public String managerEmail;
        public String yearsOfService;
        public String CWSupplierCompany;
        public String CWSupplierCode;
        public String ITContractType;
        public String ITContractStatus;
        public ITFSEExpatContract ITFSEExpatContract;
    }

    /*
     * deserialize json string 
     */
    public static GE_OG_GS_SSOData parse(String json) {
        trY{
            System.debug('Json from call: '+ json);
          return (GE_OG_GS_SSOData ) System.JSON.deserializeStrict(json, GE_OG_GS_SSOData .class);
        }catch(System.JSONException e){
            throw new GE_OG_GS_SSOException('Bad SSO Data Found');
            return new GE_OG_GS_SSOData ();
        }
    }
    
}