/*Class Name: GE_OG_SAP_InboundIntegration
Used Where: 
Purpose/Overview: Used by PI middlewhere to Send details to SMAX.
Functional Area: 
Author: SriKrishna Kolanu
Created Date: 24-AUG-2015
Test Class Name:       
Change History: Test_GE_OG_SAP_Inboundtegration
Date Modified: Developer Name: Section/Page Block Modified/Added: Purpose/Overview of Change
*/
global class GE_OG_SAP_InboundIntegration{
    global class Status {                                           // inner class to provide a response structure for the service
        public Status() {
            statusCode = '-1';
            errorMsg = null;            
        }
        webservice String statusCode;                               // error code; to be defined by application logic
        webservice String errorMsg;                                 // a string description of the error
        webservice List<Location_info> locList;                     // a List of Location records
        webservice List<IP_info> ipList;                           // a List of IP records
              
    }
           
    public GE_OG_SAP_InboundIntegration(){}   
                                                                        
    global class Location_Info {                                    // Class for defining the input variables for WebService
        WebService String LocName;                                  // Location Name
        WebService String ShipToAddress;                            // SAP# for Ship To Address
        WebService String BillToAddress;                            // DUNS# of SoldTo Party
        WebService String BillToNumber;                             // SAP# of BillTo
        WebService String SoldToParty;                              // SAP# for SoldTo Party
        WebService String RecordTypeId;                             // RecordType of Location       
        WebService String GeRigId;                                  // Rig Id of Location
        WebService String Street;                                   // Street of Location
        WebService String City;                                     // City of Location
        WebService String State;                                    // Region of Location
        WebService String Country;                                  // Country of Location
        WebService String Zip;                                      // Postal Code of Location
        WebService String SitePhone;                                // SitePhone of Location
        WebService String SiteFax;                                  // SiteFax of Location
        WebService String ErrorMsg;                                 // Error Message of Location        
    }
    
    global class IP_Info {                                    // Class for defining the input variables for WebService
        WebService String LocName;                                  // Location Name
        WebService String ShipToAddress;                            // SAP# for Ship To Address
        WebService String BillToAddress;                            // DUNS# for Bill To Address
        WebService String BillToNumber;                             // SAP# of BillTo
        WebService String SoldToParty;                              // SAP# for SoldTo Party
        WebService String PartNumber;                               // PartNumber
        WebService String Serial;                                   // Serial/Lot Number
        WebService Decimal EquipmentNumber;                         // Equipment Number
        WebService String InstalledProductId;                       // Installed Product Id
        WebService String IPUniqueId;                               // Installed Product Unique Id      
        WebService String GeRigId;                                  // GE Rig Id of Location        
        WebService String IPStatus;                                 // Status of Installed Product
        WebService String ErrorMsg;                                 // Error Message of InstalledProduct
    } 
    
   
//webService for Location Insertion
   webservice static Status InsertLocation(List<Location_Info> LocationList, String BusinessUnit) {
        Status locStatus = new Status();
        String logDescription;
        Set<String> strLoc = new Set<String>{};
        Set<String> strRig = new Set<String>{};
        Set<String> strShipToAddress = new Set<String>{};
        Set<String> strBillToAddress = new Set<String>{};
        Set<String> strSoldToParty = new Set<String>{};
        String strBusinessUnit=BusinessUnit;
        
        
        List<SVMXC__Site__c> lstLocName= new List<SVMXC__Site__c>();
        List<SVMXC__Site__c> lstShipTo=new List<SVMXC__Site__c>();
        List<SVMXC__Site__c> lstSoldTo=new List<SVMXC__Site__c>();
        List<Account> lstBillTo=new List<Account>();
        
        List<SVMXC__Site__c> lstLoc=new List<SVMXC__Site__c>();
        List<SVMXC__Site__c> updateList=new List<SVMXC__Site__c>();
      

        List<Location_Info> locationsToInsert = new List<Location_Info>();
        List<Location_Info> locationsToNotify = new List<Location_Info>(); 
        List<Location_Info> finalList = new List<Location_Info>(); 
        try{ 
            
            for(Location_Info locinfo : LocationList) 
             {  
                //Separating Records when expected parameters of Location not provided.            
                if(locinfo.LocName!='' && locinfo.ShipToAddress!='' && locinfo.BillToAddress!='' && locinfo.RecordTypeId!='' && strBusinessUnit!='' && locinfo.SoldToParty!='' && locinfo.BillToNumber!='')
                {
                    strRig.add(locinfo.GeRigId);
                    strLoc.add(locinfo.LocName);
                    strBillToAddress.add(locinfo.BillToAddress); 
                    strShipToAddress.add(locinfo.ShipToAddress);
                   
                   locationsToInsert.add(locinfo);
                }
                else{                        
                    locinfo.ErrorMsg = 'Missing Mandatory Data - ';
                    if(locinfo.LocName==''){
                    locinfo.ErrorMsg = locinfo.ErrorMsg +'Location Name;';
                    }
                    if(locinfo.ShipToAddress==''){
                    locinfo.ErrorMsg = locinfo.ErrorMsg +'ShipToNumber;';
                    }
                    if(locinfo.BillToAddress==''){
                    locinfo.ErrorMsg = locinfo.ErrorMsg +'Bill To DUNS#;';
                    }
                    if(locinfo.RecordTypeId==''){
                    locinfo.ErrorMsg = locinfo.ErrorMsg +'RecordType;';
                    }
                    if(strBusinessUnit==''){
                    locinfo.ErrorMsg = locinfo.ErrorMsg +'BusinessUnit;';
                    }
                    if(locinfo.SoldToParty==''){
                    locinfo.ErrorMsg = locinfo.ErrorMsg +'SoldToParty;';
                    }
                    if(locinfo.BillToNumber==''){
                    locinfo.ErrorMsg = locinfo.ErrorMsg +'BillToNumber;';
                    }
                    
                    locationsToNotify.add(locinfo);           
                }
             }          
           
            if(locationsToInsert.size()>0)
            { 
                GE_OG_SAP_IntegrationUtility utility = new GE_OG_SAP_IntegrationUtility();
                
                //Pulling Account details using DUNS#                
                lstBillTo = utility.accountDetails(strBillToAddress);
                
                //Verifying Location Names in ServiceMax
                lstLocName = utility.locDetails(strRig,'RigId',strShipToAddress);                
                
                    for(Location_Info loc: locationsToInsert)
                    {                        
                        integer nameCount=0;
                        integer billToCount=0;
                        
                        SVMXC__Site__c location = new SVMXC__Site__c();
                                                
                        if(loc.RecordTypeId == 'Well')  
                         {                            
                            location.RecordTypeId = utility.getRecTypeId('location',GE_OG_SAP_IntegrationUtility.WELL_LOCATION_RECORD_TYPE);
                            location.Name = loc.LocName;
                            location.GE_OG_Sold_to_Party__c=loc.SoldToParty;
                            location.GE_OG_AL_Ship_to_Account_Number__c=loc.ShipToAddress;
                            location.GE_AL_Well__c=true;
                            location.GE_OG_AL_Bill_to_Account_Number__c=loc.BillToNumber;
                            location.SVMXC__Street__c=loc.Street;
                            location.SVMXC__City__c=loc.City;
                            location.SVMXC__Zip__c=loc.Zip;
                            location.SVMXC__Site_Phone__c=loc.SitePhone;
                            location.SVMXC__Site_Fax__c=loc.SiteFax;
                            location.SVMXC__State__c=loc.State;
                            location.SVMXC__Country__c=loc.country;                         
                            
                            for(Account billTo:lstBillTo){
                                if(billTo.GE_HQ_DUNS_Number__c==loc.BillToAddress)
                                {
                                    location.SVMXC__Account__c = billTo.id;
                                    billToCount=1;
                                }
                            }
                            if(billToCount==0){
                                loc.ErrorMsg = 'Invalid Bill To Address;';
                                locationsToNotify.add(loc);
                            }
                            if(strBusinessUnit!='AL' && billToCount==1){
                                loc.ErrorMsg = loc.ErrorMsg + 'Invalid Business Unit;';
                                locationsToNotify.add(loc);
                            }
                            
                            if(billToCount==1 && strBusinessUnit=='AL')
                            {    if(lstLocName.size()>0)
                                {
                                    for(SVMXC__Site__c locs:lstLocName){
                                    //if(locs.GE_Rig_ID__c==loc.GeRigId)        
                                    if(locs.GE_Rig_ID__c==loc.GeRigId && (locs.GE_Rig_ID__c!=Null || locs.GE_Rig_ID__c!= ''))   
                                        location.id=locs.id;
                                    }                       
                                } 
                            
                                lstLoc.add(location);                           
                            }
                        }
                        else{
                        loc.ErrorMsg = 'Invalid RecordType';
                        locationsToNotify.add(loc);
                        }                           
                    }   
                    
                    //Upserting Locations
                        if(lstLoc.size()>0){
                             upsert lstLoc;
                             
                             System.debug('Locations Upserted Successfully to SMax.');
                             locStatus.statusCode='0';
                             
                             List<SVMXC__Site__c> newLocation = utility.locDetails(strLoc,'Name',strShipToAddress);
                             List<Location_Info> temp = new List<Location_Info>();
                             
                             for(SVMXC__Site__c ltn: newLocation){
                                 Location_Info loct = new Location_Info();
                                 loct.LocName=ltn.Name;
                                 loct.GeRigId=ltn.GE_Rig_ID__c;                                
                                 temp.add(loct);
                             }
                             locStatus.locList=temp;
                             finalList=temp;
                        }   
            }          
            
            if(locationsToNotify.size()>0){
            
                // Email Notification logic
                 locStatus.statusCode='-1';
                 locStatus.errorMsg = 'Error in Insertion/Updation of Location(s)';
                 for(Location_Info ltn: locationsToNotify){
                     Location_Info locat = new Location_Info();
                     locat.LocName=ltn.LocName; 
                     locat.errorMsg=ltn.errorMsg;
                    finalList.add(locat);                    
                 }
                 locStatus.locList=finalList;
            }
            if(lstLoc.size()>0 && locationsToNotify.size()>0){
                locStatus.statusCode='-2';              
            }  
            
          return locStatus;
        }
        catch(Exception ex) {
            System.debug('Error in Insertion : '+ex +'---'+ ex.getLineNumber());
            locStatus.statusCode='-3'; 
            locStatus.errorMsg = 'Error in Insertion/Updation of Location(s) in ServiceMax'; 
            logDescription='GE_OG_SAP_InboundIntegration:' +ex.getLineNumber()+'---'+ex.getMessage()+'---'+ex.getStackTraceString()+'---'+ex.getTypeName();
            System.debug('Log Description: '+logDescription);
            List<Location_Info> locationsToError = new List<Location_Info>();
            for(SVMXC__Site__c ssc:lstLoc )
            {
                Location_Info errLoc = new Location_Info();
                errLoc.LocName=ssc.name;
                errLoc.BillToNumber=ssc.GE_OG_AL_Bill_to_Account_Number__c;
                errLoc.ShipToAddress=ssc.GE_OG_AL_Ship_to_Account_Number__c;
                errLoc.ErrorMsg=logDescription;
                
                locationsToError.add(errLoc);   
            }
                    
            GE_OG_SAP_IntegrationUtility.notifyInboundLocation(locationsToError,logDescription);         
            return locStatus;
        }        
   }
   
   
  
    
//webService for Installed Product Insertion    
  webservice static Status InsertInstalledProduct(List<IP_Info> InstalledProductList, String BusinessUnit) {
        Status ipStatus = new Status();
        String logDescription;
        Set<String> strBillToAddress = new Set<String>{};
        Set<String> strPartNumber = new Set<String>{};
        Set<String> strSerial = new Set<String>{};
        Set<String> strInstalledProductId = new Set<String>{};
        Set<String> strGeRigId = new Set<String>{};
        Set<String> strShipToAddress = new Set<String>{};
        String strBusinessUnit=BusinessUnit;
        
        List<SVMXC__Installed_Product__c> ipList= new List<SVMXC__Installed_Product__c>();
        List<Account> lstShipTo=new List<Account>();
        List<Account> lstBillTo=new List<Account>();
        List<SVMXC__Installed_Product__c> lstInstalledProduct= new List<SVMXC__Installed_Product__c>();
        List<SVMXC__Site__c> lstRigs=new List<SVMXC__Site__c>();
       
        
        
        List<IP_Info> IPsToInsert = new List<IP_Info>();
        List<IP_Info> IPsToNotify = new List<IP_Info>();
        List<IP_Info> finalList = new List<IP_Info>();
        try{ 
            
                for(IP_Info ipinfo : InstalledProductList) 
                 {  
                    //Separating Records when expected parameters of Location not provided.            
                    if(ipinfo.GeRigId!='' && ipinfo.ShipToAddress!='' && ipinfo.BillToAddress!='' && ipinfo.PartNumber!='' && ipinfo.Serial!='' && ipinfo.InstalledProductId!='' && ipinfo.SoldToParty!='' && strBusinessUnit!='')
                    {  
                       strBillToAddress.add(ipinfo.BillToAddress);
                       strSerial.add(ipinfo.Serial);
                       strGeRigId.add(ipinfo.GeRigId);
                       strShipToAddress.add(ipinfo.ShipToAddress);
                       
                       IPsToInsert.add(ipinfo);
                    }
                    else{ 
                        ipinfo.ErrorMsg='Missing Mandatory Data - ';
                        if(ipinfo.GeRigId=='')
                        { 
                            ipinfo.ErrorMsg = ipinfo.ErrorMsg + 'GeRigId;';
                        }
                        if(ipinfo.ShipToAddress=='')
                        { 
                            ipinfo.ErrorMsg = ipinfo.ErrorMsg + 'ShipToNumber;';
                        }
                        if(ipinfo.BillToAddress=='')
                        { 
                            ipinfo.ErrorMsg = ipinfo.ErrorMsg + 'Bill To DUNS#;';
                        }
                        if(ipinfo.PartNumber=='')
                        { 
                            ipinfo.ErrorMsg = ipinfo.ErrorMsg + 'PartNumber;';
                        }
                        if(ipinfo.Serial=='')
                        { 
                            ipinfo.ErrorMsg = ipinfo.ErrorMsg + 'Serial#;';
                        }
                        if(ipinfo.InstalledProductId=='')
                        { 
                            ipinfo.ErrorMsg = ipinfo.ErrorMsg + 'InstalledProductId;';
                        }
                        if(ipinfo.SoldToParty=='')
                        { 
                            ipinfo.ErrorMsg = ipinfo.ErrorMsg + 'SoldToParty;';
                        }
                        if(strBusinessUnit=='')
                        { 
                            ipinfo.ErrorMsg = ipinfo.ErrorMsg + 'BusinessUnit;';
                        }
                        
                        IPsToNotify.add(ipinfo);                    
                    }
                 }           
             
                if(IPsToInsert.size()>0)
                { 
                    GE_OG_SAP_IntegrationUtility utility = new GE_OG_SAP_IntegrationUtility();
                    //Pulling Account details using DUNS#                   
                    lstBillTo = utility.accountDetails(strBillToAddress);
                    
                    //Pulling Location details using GE Rig Id
                    lstRigs = utility.locDetails(strGeRigId,'RigId',strShipToAddress); 
                    
                    //Verifying Serial/Lot Numbers n ServiceMax
                    ipList = utility.ipDetails(strSerial,strBusinessUnit);  
                    
                    for(IP_Info ip: IPsToInsert)
                    {
                        integer locCount=0;
                        integer billToCount=0;
                        
                        
                        SVMXC__Installed_Product__c installedProd   = new SVMXC__Installed_Product__c();
                        if(strBusinessUnit=='AL')
                        {
                            installedProd.RecordTypeId = utility.getRecTypeId('InstalledProduct',GE_OG_SAP_IntegrationUtility.AL_InstalledProduct_RECORD_TYPE);
                            installedProd.GE_OG_Sold_to_Party__c = ip.SoldToParty;
                            installedProd.SVMXC__Status__c = ip.IPStatus;
                            installedProd.GE_AL_Equipment_Number__c = ip.EquipmentNumber;
                            installedProd.GE_OG_AL_Ship_to_Account_Number__c = ip.ShipToAddress;
                            installedProd.Name = ip.InstalledProductId;
                            installedProd.SVMXC__Serial_Lot_Number__c=ip.Serial;
                            installedProd.GE_OG_DS_Part_Number__c=ip.PartNumber;
                            installedProd.GE_OG_AL_Bill_to_Account_Number__c=ip.BillToNumber;
                            
                            for(SVMXC__Site__c rig:lstRigs){
                                if((rig.GE_Rig_ID__c !='' || rig.GE_Rig_ID__c != NULL) && rig.GE_Rig_ID__c==ip.GeRigId){
                                  //if(rig.GE_Rig_ID__c==ip.GeRigId){   
                                    installedProd.SVMXC__Site__c=rig.Id;
                                    locCount = 1;                              
                                    }                           
                                }                             
                            if(locCount!=1) {
                                ip.errorMsg='Invalid Location GE RIG Id';
                                IPsToNotify.add(ip);
                            }                       
                           
                            if(locCount == 1)
                            {
                                for(Account billTo:lstBillTo){
                                    if(billTo.GE_HQ_DUNS_Number__c==ip.BillToAddress)
                                    {
                                        installedProd.SVMXC__Company__c = billTo.id;
                                        billToCount = 1; 
                                    }                
                                }
                            } 
                            if(billToCount != 1 && locCount==1){
                                ip.errorMsg='Invalid Location Bill To DUNS#';
                                IPsToNotify.add(ip);
                            }
                            
                            
                            if(billToCount==1 && locCount==1){                             
                                if(ipList.size()>0){
                                    for(SVMXC__Installed_Product__c iplst:ipList){                          
                                        if(iplst.SVMXC__Serial_Lot_Number__c==ip.Serial && iplst.GE_AL_Equipment_Number__c==ip.EquipmentNumber)
                                            installedProd.id=iplst.id; 
                                    }                       
                                }
                                lstInstalledProduct.add(installedProd);  
                            }
                            
                        }
                        else{
                                ip.ErrorMsg = 'Invalid RecordType';
                                IPsToNotify.add(ip);
                            }
                    }
                    //Insert Installed Product 
                        if(lstInstalledProduct.size()>0){
                        System.debug('List to Insert'+ lstInstalledProduct);
                         upsert lstInstalledProduct;
                         
                         System.debug('Installed Product upserted Successfully to SMax.');
                         ipStatus.statusCode='0';
                         
                         List<SVMXC__Installed_Product__c> newIp = utility.ipDetails(strSerial,strBusinessUnit);
                             List<IP_Info> temp = new List<IP_Info>();
                             
                             for(SVMXC__Installed_Product__c iprd: newIp){
                                for(IP_Info ipinf: IPsToInsert){
                                     if(iprd.SVMXC__Serial_Lot_Number__c==ipinf.Serial && iprd.GE_AL_Equipment_Number__c==ipinf.EquipmentNumber){ 
                                     IP_Info iprod = new IP_Info();
                                     iprod.InstalledProductId = iprd.Name;
                                     iprod.IPUniqueId = iprd.GE_HQ_SFDC_LEGACY_ID__c; 
                                     iprod.EquipmentNumber = iprd.GE_AL_Equipment_Number__c;  
                                     iprod.PartNumber = iprd.GE_OG_DS_Part_Number__c;    
                                     temp.add(iprod);
                                 }
                                }
                             }
                             ipStatus.ipList=temp;
                             finalList=temp;
                        }
                      
                }
                
                if(IPsToNotify.size()>0){                
                 
                 ipStatus.statusCode='-1';
                 ipStatus.errorMsg = 'Error while Insertion/updation of InstalledProduct(s)';
                 
                 for(IP_Info instPrd: IPsToNotify){
                     IP_Info iproduct = new IP_Info();
                     iproduct.InstalledProductId=instPrd.InstalledProductId;
                     iproduct.EquipmentNumber =instPrd.EquipmentNumber ;                     
                     iproduct.ErrorMsg=instPrd.ErrorMsg;
                     finalList.add(iproduct);
                    }
                    ipStatus.ipList=finalList;
                }
                if(IPsToNotify.size()>0 && lstInstalledProduct.size()>0){
                     ipStatus.statusCode='-2';
                 } 
            return ipStatus;         
                
            }
            catch(Exception ex) {
            System.debug('Error in Insertion : '+ex);
            ipStatus.statusCode='-3'; 
            ipStatus.errorMsg = 'Error while Insertion/updation of Install Product(s) in ServiceMax'; 
            logDescription='GE_OG_SAP_InboundIntegration:' +ex.getLineNumber()+'---'+ex.getMessage()+'---'+ex.getStackTraceString()+'---'+ex.getTypeName();
            System.debug('Log Description: '+logDescription);
            List<IP_Info> tempList = new List<IP_Info>();
            for(SVMXC__Installed_Product__c instPrds: lstInstalledProduct){
                     IP_Info iproduct = new IP_Info();
                     iproduct.InstalledProductId = instPrds.Name;
                     iproduct.GeRigId= instPrds.SVMXC__Site__c;
                     iproduct.Serial= instPrds.SVMXC__Serial_Lot_Number__c;
                     iproduct.PartNumber= instPrds.GE_OG_DS_Part_Number__c;
                     iproduct.EquipmentNumber = instPrds.GE_AL_Equipment_Number__c;
                     iproduct.ErrorMsg=logDescription;
                     tempList.add(iproduct);
                    }
            GE_OG_SAP_IntegrationUtility.notifyInboundIP(tempList,logDescription);
            return ipStatus;
        } 
  }
   
  }