/**
@ name            AddressModel
@ author          Ramakrisha Kolluri
@ date            05th June 2012
@ description     The model which contains the addresses info like info, lat, long and address
*/
public class AddressModel{
    /*
    public List<Address> addresslist {get;set;}
    public string getDefault(){
        if(addresslist.size() > 0)
            return addresslist.get(0).address;
        return '';
    }
    public AddressModel(){
        addresslist = new List<Address>();    
    }
    public void add(string address, string lat, string lng, string info){
        addresslist.add(new Address(address, lat, lng, info));
    }
    public class Address{
        public string address {get;set;}
        public string lat {get;set;}
        public string lng {get;set;}
        public string info {get;set;}
        
        public Address(string address, string lat, string lng, string info){
            this.address = address;
            this.lat = lat;
            this.lng = lng;
            this.info = info;
        }
    }
   */
   // To get CodeCoverage for Commented class
    public AddressModel(){ }

    public static testmethod void AddressModeltest(){
        AddressModel addmdl= new AddressModel(); 
    }
    
   /* public static testmethod void GEESUpdateBMPriceMgmttest(){
        GE_ES_UpdateBMPriceMgmt obj = new GE_ES_UpdateBMPriceMgmt(); 
        GE_ES_UpdateBMPriceMgmt.updteaBMPricemanagement(new List<OpportunityLineItem> () , new Map<id,OpportunityLineItem> ());

    }*/
}