/*
Class Name: GE_ES_CaseSearchAddProducts
Used Where ? : Used for Add Case Product functionality 
Purpose/Overview : Implements the search and add case products for the ES & Industrial business
Functional Area : Service Management (Case)
Author: Jayaraju Nulakachandanam 
Created Date: June 16th,2011
Test Class Name : TestGE_ES_CaseSearchAddProducts

Change History -
Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change

*/

public class GE_ES_CaseSearchAddProducts{
 
    //variable Declarations
    public Case CaseObj{get;set;} 
   
    public Apexpages.Standardcontroller GstdController;
    public Product2 PBE{get; set;}
    public list<id> pids{get; set;}
    public string pgMsgTxt{get; set;}
    @TestVisible private List<List<ProductsWrapper>> pagingRecordsList{get;set;}
    public Integer PER_PAGE_RESULTS_LIMIT {get; set;}
    public Integer resultsStartNumber{get;set;}
    public Integer resultsStopNumber{get;set;}
    public Boolean isPreviousRender{get;set;}
    public Boolean isNextRender{get;set;}
    public boolean isResultFound {get;set;}
    public boolean proBook{get; set;}
    public Integer ListIndex{get; set;}
    public Integer totalResults{get;set;}
    
    public integer limitrows{get;set;}
            
  
    public List<SelectOption> ServiceValues{get; set;}
    public List<SelectOption> OfferingValues{get; set;}
   
    public string selectedDriver{get; set;}
    public string selectedService{get; set;}
    public string selectedOffering{get; set;}
    public string ProductCode{get; set;}
    public string PartNumber{get; set;}

    public boolean chkFlag{get; set;}
    
    //variable declaration for pgs search
    public List<SelectOption> ProFamilyValues{get; set;}
    public List<SelectOption> ProHostValues{get; set;}
    public List<SelectOption> ProTechValues{get; set;}
    public List<SelectOption> ProLineValues{get; set;}
    public List<SelectOption> ProOfferingValues{get; set;}
    
    public string selectedProFamily{get; set;}
    public string selectedProHost{get; set;}
    public string selectedProTech{get; set;} 
    public string selectedProLine{get; set;}
    public string selectedProOffering{get; set;}
    
    //This is used to display the Case Name and the Resolution Date on the screen.
    //Value will be set in the constructor
    public String CaseResolDate;
    public void setCaseResolDate(String GE_ES_Resolution_Date)
    {
         /*CaseResolDate = GE_ES_Resolution_Date;
    }
    public String getCaseResolDate()
    {
       if(CaseObj.GE_ES_Resolution_Date__c == null)
       return '';
       return CaseResolDate = CaseObj.GE_ES_Resolution_Date__c.format(); */
    } 
    public boolean errorStatus{get;set;}         
    public string PriceBookId{get;set;} 
    
    //This will hold the string which is entered while searching for case products in  
    //Products search page.    
    public string SearchString{get; set;}                                
    
    //returns the list of case product search results
    public List<ProductsWrapper> getprodRes()
    {
       system.debug(pagingRecordsList.size() + '***'+ ListIndex);
      if(pagingRecordsList.size() > 0)
      return pagingRecordsList[ListIndex];
      else
      return new List<ProductsWrapper>(); 
    }          
    
    //List to accomodate the multi line items
    Public List<GE_Case_Product__c> CaseProdList; 
   
    public  List<GE_Case_Product__c> getCaseProdList(){
                                      
          return CaseProdList;
        }
    public void  setCaseProdList (List<GE_Case_Product__c> CasePrdct){
          CaseProdList = CasePrdct;
        }
    
    
    //standard constructor of the controller   
    public GE_ES_CaseSearchAddProducts(ApexPages.StandardController controller)
    {
        
        /*errorStatus=false;
        proBook = true;       
        
        //retrieving the product recordtype id using global describe
        Schema.DescribeSObjectResult d = Schema.SObjectType.Product2; 
        Map<String,Schema.RecordTypeInfo> rtMapByName = d.getRecordTypeInfosByName(); 
        
        PBE = new Product2();                        
        
        //setting the limit for the search results
        limitrows = Limits.getLimitQueryRows(); 
        
        try 
        {
            //getting Case Record using the query string     
            CaseObj=[Select o.GE_ES_Resolution_Date__c, o.CaseNumber,o.RecordTypeId, o.RecordType.Name,o.GE_ES_INDSCasePL__c,o.CurrencyIsoCode from Case o where o.id= :ApexPages.currentPage().getParameters().get('id')];
            
            String strRec = CaseObj.RecordType.Name == 'Nuclear' ? 'GE PW Nuclear' : 'GE ES Product';
            if(strRec != null)
            {
                Schema.RecordTypeInfo RecDPS =  rtMapByName.get(strRec);
                PBE.RecordTypeId = RecDPS.getRecordTypeId();
            }    
        
        
        }
        catch(Exception e)
        {
            system.debug(e.getMessage());
        }
        errorStatus=false;
                
        ID userId;
        userId=UserInfo.getUserId();        
        
        pids = new list<id>();
        pagingRecordsList = new List<List<ProductsWrapper>>();
       
        //reset the services picklist 
        ServiceValues = new List<SelectOption>();
        ServiceValues.add(new SelectOption('','--None--'));
        
        //reset the Offering picklist 
        OfferingValues = new List<SelectOption>();
        OfferingValues.add(new SelectOption('','--None--'));     
        
        ProFamilyValues = new List<SelectOption>();
        ProFamilyValues.add(new SelectOption('','--None--'));
        
        ProHostValues = new List<SelectOption>();
        ProHostValues.add(new SelectOption('','--None--'));
        
        ProTechValues = new List<SelectOption>();
        ProTechValues.add(new SelectOption('','--None--'));
        
        ProLineValues = new List<SelectOption>();
        ProLineValues.add(new SelectOption('','--None--'));
        
        ProOfferingValues = new List<SelectOption>();
        ProOfferingValues.add(new SelectOption('','--None--')); */
        
        
    }
    
    //get Sub Pnl Values
    public void SubPnlLovs()
    {
        
       
        Set<string> SpnlNm = new Set<string>();
        
        
        //reset the services picklist 
        ServiceValues.clear();
        ServiceValues.add(new SelectOption('','--None--'));
        
        //reset the Offering picklist 
        OfferingValues.clear();
        OfferingValues.add(new SelectOption('','--None--'));
        selectedService = '';
        selectedOffering = '';
        
        
    }
    
    //get  Oppty Driver Values
    public void DriverLovs()
    {
        
        
        PBE.GE_ES_Oppty_Driver__c = null;
        system.debug('**test ****'+PBE.GE_ES_Oppty_Driver__c);
        
        //reset the services picklist 
        ServiceValues.clear();
        ServiceValues.add(new SelectOption('','--None--'));
        
        //reset the Offering picklist 
        OfferingValues.clear();
        OfferingValues.add(new SelectOption('','--None--'));
        selectedService = '';
        selectedOffering = '';
        
        
    }
    
    
     //get  Product Service Values
    public void ServiceLovs()
    {
        
        //reset the services picklist       
        ServiceValues.clear();
        ServiceValues.add(new SelectOption('','--None--'));
        
        //reset the Offering picklist 
        OfferingValues.clear();
        OfferingValues.add(new SelectOption('','--None--'));
        selectedService = '';
        selectedOffering = '';
        
        Set<string> ServiceNm = new Set<string>();
        if(PBE.GE_ES_Oppty_Driver__c != null && PBE.GE_ES_Oppty_Driver__c != '' && PBE.GE_ES_Oppty_Driver__c != 'All')
        {
            
            List<Product2> ServiceList  = [select id,GE_ES_P_L__c,GE_ES_Sub_P_L__c,GE_ES_Oppty_Driver__c,GE_ES_Offering__c,GE_ES_Product_Service__c from Product2 where IsActive = true and GE_ES_Oppty_Driver__c = :PBE.GE_ES_Oppty_Driver__c and GE_ES_Sub_P_L__c = :PBE.GE_ES_Sub_P_L__c and GE_ES_P_L__c = :PBE.GE_ES_P_L__c limit :limitrows];
            system.debug('***342'+ServiceList.size());
            for(Product2 p : ServiceList)
            {
                if(ServiceNm.add(p.GE_ES_Product_Service__c) && p.GE_ES_Product_Service__c != null && p.GE_ES_Product_Service__c != '')
                ServiceValues.add(new SelectOption(p.GE_ES_Product_Service__c,p.GE_ES_Product_Service__c));
                ServiceNm.add(p.GE_ES_Product_Service__c);
            }
            
            
        }
        
        if(PBE.GE_ES_Oppty_Driver__c != null && PBE.GE_ES_Oppty_Driver__c != '' && PBE.GE_ES_Oppty_Driver__c == 'All')
        {
            
            List<Product2> ServiceList  = [select id,GE_ES_P_L__c,GE_ES_Sub_P_L__c,GE_ES_Oppty_Driver__c,GE_ES_Offering__c,GE_ES_Product_Service__c from Product2 where IsActive = true  and GE_ES_Sub_P_L__c = :PBE.GE_ES_Sub_P_L__c and GE_ES_P_L__c = :PBE.GE_ES_P_L__c limit :limitrows];
            system.debug('***342'+ServiceList.size());
            for(Product2 p : ServiceList)
            {
                if(ServiceNm.add(p.GE_ES_Product_Service__c) && p.GE_ES_Product_Service__c != null && p.GE_ES_Product_Service__c != '')
                ServiceValues.add(new SelectOption(p.GE_ES_Product_Service__c,p.GE_ES_Product_Service__c));
                ServiceNm.add(p.GE_ES_Product_Service__c);
            }
            
            
        }
        
        if(SelectedDriver != null && SelectedDriver != '')
        {
            List<Product2> ServiceList  = [select id,GE_ES_P_L__c,GE_ES_Sub_P_L__c,GE_ES_Oppty_Driver__c,GE_ES_Offering__c,GE_ES_Product_Service__c from Product2 where IsActive = true and GE_ES_Oppty_Driver__c = :SelectedDriver and GE_ES_Sub_P_L__c = :PBE.GE_ES_Sub_P_L__c and GE_ES_P_L__c = :PBE.GE_ES_P_L__c limit :limitrows];
            system.debug('***342'+ServiceList.size());
            for(Product2 p : ServiceList)
            {
                if(ServiceNm.add(p.GE_ES_Product_Service__c) && p.GE_ES_Product_Service__c != null && p.GE_ES_Product_Service__c != '')
                ServiceValues.add(new SelectOption(p.GE_ES_Product_Service__c,p.GE_ES_Product_Service__c));
                ServiceNm.add(p.GE_ES_Product_Service__c);
            }
        }
        
        
        
    }
    
    
    
    
    //get  Offering Values
    public void OfferingLovs()
    {
        
       
        //reset the Offering picklist
        OfferingValues.clear();
        OfferingValues.add(new SelectOption('','--None--'));
        selectedOffering = '';
        
        Set<string> OfferingNm = new Set<string>();
        if(selectedService != '')
        {
            
            List<Product2> OfferingList  = new List<Product2>();

            OfferingList  = [select id,Name,GE_ES_P_L__c,GE_ES_Sub_P_L__c,GE_ES_Oppty_Driver__c,GE_ES_Offering__c,GE_ES_Product_Service__c from Product2 where IsActive = true and  GE_ES_Product_Service__c = :selectedService and GE_ES_Oppty_Driver__c = :PBE.GE_ES_Oppty_Driver__c and GE_ES_Sub_P_L__c = :PBE.GE_ES_Sub_P_L__c and GE_ES_P_L__c = :PBE.GE_ES_P_L__c limit :limitrows];
            system.debug('***373'+OfferingList.size());
            for(Product2 p : OfferingList)
            {
                if(OfferingNm.add(p.GE_ES_Offering__c) && p.GE_ES_Offering__c != null && p.GE_ES_Offering__c != '')
                OfferingValues.add(new SelectOption(p.GE_ES_Offering__c,p.GE_ES_Offering__c));
                OfferingNm.add(p.GE_ES_Offering__c);
            }      
        }
        
    }
    

    
    //This will be populated with  search string on clicking the search button and then it displays
    // the result using the productsearchresult function below.
    public void ProductSearch()
    {
       /* List<Product2> prodQry = new  List<Product2>();
       //prodRes=null;
       String mySearchString = '%' + SearchString.trim() + '%';
       system.debug('SearchString is '+SearchString);
       system.debug('SearchString is curr.code'+CaseObj.CurrencyIsoCode);
              
       chkFlag = false;
       pagingRecordsList.clear();
       system.debug('recordtype name'+ CaseObj.RecordType.Name);
   
        string pquery = 'Select p.CurrencyIsoCode, p.Id, p.IsActive, p.Name,  p.Description, p.Family, p.ProductCode,p.GE_ES_P_L__c,p.BigMachines__Part_Number__c,p.GE_ES_Offering__c,p.GE_ES_Product_Service__c,p.GE_ES_Sub_P_L__c,p.GE_ES_Oppty_Driver__c,p.GE_Tier1_PnL__c,p.GE_Tier2_PnL__c,p.GE_Tier3_PnL__c,p.GE_Tier4_PnL__c,p.GEEM_ProFmly__c,p.GEEM_ProLn__c,p.GEEM_ProOffng__c,p.GE_Tier5_PnL__c,p.GE_Tier6_PnL__c,p.Technology__c,p.GEEM_HstEqpmt__c from Product2 p where   p.IsActive=true  '  ;
        
        if(SearchString != '' && SearchString != null)
        pquery = pquery + ' and p.Name like ' + '\'' + mySearchString + '\'';
        
        if(ProductCode != null && ProductCode != '')
        pquery = pquery + ' and p.ProductCode like ' + '\'%' + ProductCode + '%\'';
        
        if(CaseObj.CurrencyIsoCode != null)
        pquery = pquery + ' and p.CurrencyIsoCode = ' + '\'' + CaseObj.CurrencyIsoCode + '\'';
        
       if(CaseObj.RecordType.Name == 'Nuclear') 
        pquery = pquery + ' and (p.GE_Tier2_PnL__c = ' +  '\'' + 'GE Hitachi Nuclear Energy (GEH)' + '\'' + ' or p.GE_Tier2_PnL__c like ' +  '\'' + 'Nuclear%' + '\'' + ')' ;
        
        system.debug('*****'+pquery);
        try{
            prodQry = Database.Query(pquery  + ' order by p.Name asc limit 1000 '); 
        }
        catch(Exception E)
        {
            errorStatus=true;
        }
            
        List<ProductsWrapper> PBEList = new List<ProductsWrapper>();   
        isNextRender = false;
        isPreviousRender = false;     
        if(prodQry == null || prodQry.size()==0)
        {
            //prodRes = prodQry ;
            errorStatus=true;
            ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, 'No Products are present'));
            pgMsgTxt = 'not Found'; 
            
            totalResults =  0;
            resultsStartNumber = 0;
            resultsStopNumber = 0;            
            //return null;    
        }
        else
        {
            errorStatus = false;
            pgMsgTxt = '';
            pids.clear();
            integer i=1;
            integer j=1;
            ListIndex = 0;
            for(Product2 pb : prodQry)
            {
                if(i>j*25)
                {
                    pagingRecordsList.add(PBEList);
                    PBEList = new List<ProductsWrapper>();
                    j++;
                }    
                ProductsWrapper pw = new ProductsWrapper(pb);
                PBEList.add(pw);       
                pids.add(pb.Id); 
                i++;
            }  
            pagingRecordsList.add(PBEList);  
            if(pagingRecordsList.size() > 1)
            {
                isNextRender = true;
                isPreviousRender = false;
            }
            totalResults =  prodQry.size();
            resultsStartNumber = 1;
            if(totalResults < 25)
            resultsStopNumber = totalResults;
            else
            resultsStopNumber = 25;  
        }       
        system.debug('***389***prodQry '+prodQry+'**'+pgMsgTxt+'***'+pagingRecordsList.size());       
        PBE.GE_ES_P_L__c = null;
        PBE.GE_ES_Sub_P_L__c = null;
        PBE.GE_ES_Oppty_Driver__c = null;
        selectedOffering = null ;
        selectedService = null ;
       
        if(pagingRecordsList.size() > 0)               
        ProductSearchResult(pagingRecordsList[0]); */
        //return null;
    }
    
     //lovs for Nuclear search begins            
    public void ProHostLovs()
    {
    
    
        //reset the Offering picklist
        ProHostValues.clear();
        ProTechValues.clear();
        ProLineValues.clear();
        ProOfferingValues.clear();
        ProHostValues.add(new SelectOption('','--None--'));
        ProTechValues.add(new SelectOption('','--None--'));
        ProLineValues.add(new SelectOption('','--None--'));
        ProOfferingValues.add(new SelectOption('','--None--'));
        selectedProHost = '';
        selectedProTech = '';
        selectedProLine = '';
        selectedProOffering = '';
        
        Set<string> ProHostNm = new Set<string>();
        if(PBE.GE_Tier1_PnL__c != '')
        {
        
            List<Product2> ProHostList = new List<Product2>();
            string pquery = 'Select p.CurrencyIsoCode, p.Id, p.IsActive, p.Name,p.Description, p.Family, p.ProductCode,p.GE_ES_P_L__c,p.BigMachines__Part_Number__c,p.GE_ES_Offering__c,p.GE_ES_Product_Service__c,p.GE_ES_Sub_P_L__c,p.GE_ES_Oppty_Driver__c,p.GE_Tier1_PnL__c,p.GE_Tier2_PnL__c,p.GE_Tier3_PnL__c,p.GE_Tier4_PnL__c,p.GEEM_ProFmly__c,p.GEEM_ProLn__c,p.GEEM_ProOffng__c,p.GE_Tier5_PnL__c,p.GE_Tier6_PnL__c,p.Technology__c,p.GEEM_HstEqpmt__c from Product2 p where p.IsActive=true ';
            if(PBE.GE_Tier1_PnL__c != null && PBE.GE_Tier1_PnL__c != '')
            pquery = pquery + ' and p.GE_Tier1_PnL__c = ' + '\'' + PBE.GE_Tier1_PnL__c + '\'';
            
            if(PBE.GE_Tier2_PnL__c != null && PBE.GE_Tier2_PnL__c != '')
            pquery = pquery + ' and p.GE_Tier2_PnL__c = ' + '\'' + PBE.GE_Tier2_PnL__c + '\'';
            
            if(PBE.GE_Tier3_PnL__c != null && PBE.GE_Tier3_PnL__c != '')
            pquery = pquery + ' and p.GE_Tier3_PnL__c = ' + '\'' + PBE.GE_Tier3_PnL__c + '\'';
            
            if(PBE.GE_Tier4_PnL__c != null && PBE.GE_Tier4_PnL__c != '')
            pquery = pquery + ' and p.GE_Tier4_PnL__c = ' + '\'' + PBE.GE_Tier4_PnL__c + '\'';
            
            if(PBE.GE_Tier5_PnL__c != null && PBE.GE_Tier5_PnL__c != '')
            pquery = pquery + ' and p.GE_Tier5_PnL__c = ' + '\'' + PBE.GE_Tier5_PnL__c + '\'';
        
            if(PBE.GE_Tier6_PnL__c != null && PBE.GE_Tier6_PnL__c != '')
            pquery = pquery + ' and p.GE_Tier6_PnL__c = ' + '\'' + PBE.GE_Tier6_PnL__c + '\'';
            
            
            ProHostList = Database.Query(pquery + ' order by p.Name asc limit :limitrows');
            for(Product2 p : ProHostList)
            {
                if((!ProHostNm.contains(p.GEEM_HstEqpmt__c)) && p.GEEM_HstEqpmt__c != null && p.GEEM_HstEqpmt__c != '')
                ProHostValues.add(new SelectOption((string)p.GEEM_HstEqpmt__c,(string)p.GEEM_HstEqpmt__c));
                ProHostNm.add((string)p.GEEM_HstEqpmt__c);
            }
        }
    
    }
    
    //get Product Offering Values
    public void ProTechLovs()
    {
    
    
        //reset the Offering picklist
        ProTechValues.clear();
        ProLineValues.clear();
        ProOfferingValues.clear();
        ProTechValues.add(new SelectOption('','--None--'));
        ProLineValues.add(new SelectOption('','--None--'));
        ProOfferingValues.add(new SelectOption('','--None--'));
        selectedProTech = '';
        selectedProLine = '';
        selectedProOffering = '';
        
        Set<string> ProTechNm = new Set<string>();
        if(selectedProHost != '')
        {
        
            List<Product2> ProTechList = new List<Product2>();
            string pquery = 'Select p.CurrencyIsoCode, p.Id, p.IsActive, p.Name,p.Description, p.Family, p.ProductCode,p.GE_ES_P_L__c,p.BigMachines__Part_Number__c,p.GE_ES_Offering__c,p.GE_ES_Product_Service__c,p.GE_ES_Sub_P_L__c,p.GE_ES_Oppty_Driver__c,p.GE_Tier1_PnL__c,p.GE_Tier2_PnL__c,p.GE_Tier3_PnL__c,p.GE_Tier4_PnL__c,p.GEEM_ProFmly__c,p.GEEM_ProLn__c,p.GEEM_ProOffng__c,p.GE_Tier5_PnL__c,p.GE_Tier6_PnL__c,p.Technology__c,p.GEEM_HstEqpmt__c from Product2 p where p.IsActive=true ';
            if(PBE.GE_Tier1_PnL__c != null && PBE.GE_Tier1_PnL__c != '')
            pquery = pquery + ' and p.GE_Tier1_PnL__c = ' + '\'' + PBE.GE_Tier1_PnL__c + '\'';
            
            if(PBE.GE_Tier2_PnL__c != null && PBE.GE_Tier2_PnL__c != '')
            pquery = pquery + ' and p.GE_Tier2_PnL__c = ' + '\'' + PBE.GE_Tier2_PnL__c + '\'';
            
            if(PBE.GE_Tier3_PnL__c != null && PBE.GE_Tier3_PnL__c != '')
            pquery = pquery + ' and p.GE_Tier3_PnL__c = ' + '\'' + PBE.GE_Tier3_PnL__c + '\'';
            
            if(PBE.GE_Tier4_PnL__c != null && PBE.GE_Tier4_PnL__c != '')
            pquery = pquery + ' and p.GE_Tier4_PnL__c = ' + '\'' + PBE.GE_Tier4_PnL__c + '\'';
            
            if(PBE.GE_Tier5_PnL__c != null && PBE.GE_Tier5_PnL__c != '')
            pquery = pquery + ' and p.GE_Tier5_PnL__c = ' + '\'' + PBE.GE_Tier5_PnL__c + '\'';
        
            if(PBE.GE_Tier6_PnL__c != null && PBE.GE_Tier6_PnL__c != '')
            pquery = pquery + ' and p.GE_Tier6_PnL__c = ' + '\'' + PBE.GE_Tier6_PnL__c + '\'';
            
            if(selectedProHost != '')
            pquery = pquery + ' and p.GEEM_HstEqpmt__c = ' + '\'' + selectedProHost + '\'';
            
            
            ProTechList = Database.Query(pquery + ' order by p.Name asc limit :limitrows');
            for(Product2 p : ProTechList)
            {
                if((!ProTechNm.contains(p.Technology__c)) && p.Technology__c != null && p.Technology__c != '' && p.GEEM_HstEqpmt__c != null && p.GEEM_HstEqpmt__c == selectedProHost)
                ProTechValues.add(new SelectOption((string)p.Technology__c,(string)p.Technology__c));
                ProTechNm.add((string)p.Technology__c);
            }
        }
    
    }
    
    
    //get Product Offering Values
    public void ProLineLovs()
    {
    
    
        //reset the Offering picklist
        ProLineValues.clear();
        ProOfferingValues.clear();
        ProLineValues.add(new SelectOption('','--None--'));
        ProOfferingValues.add(new SelectOption('','--None--'));
        selectedProLine = '';
        selectedProOffering = '';
        
        Set<string> ProLineNm = new Set<string>();
        if(selectedProTech != '')
        {
        
        List<Product2> ProLineList = new List<Product2>();
        string pquery = 'Select p.CurrencyIsoCode, p.Id, p.IsActive, p.GEEM_ProOffng__c,p.GEEM_ProLn__c,p.GEEM_ProFmly__c,p.Description, p.Family, p.Name, p.ProductCode,p.GE_ES_P_L__c,p.BigMachines__Part_Number__c,p.GE_ES_Offering__c,p.GE_ES_Product_Service__c,p.GE_ES_Sub_P_L__c,p.GE_ES_Oppty_Driver__c,p.GE_Tier1_PnL__c,p.GE_Tier2_PnL__c,p.GE_Tier3_PnL__c,p.GE_Tier4_PnL__c,p.GE_Tier5_PnL__c,p.GE_Tier6_PnL__c,p.Technology__c,p.GEEM_HstEqpmt__c from Product2 p where p.IsActive=true ';
        if(PBE.GE_Tier1_PnL__c != null && PBE.GE_Tier1_PnL__c != '')
        pquery = pquery + ' and p.GE_Tier1_PnL__c = ' + '\'' + PBE.GE_Tier1_PnL__c + '\'';
        
        if(PBE.GE_Tier2_PnL__c != null && PBE.GE_Tier2_PnL__c != '')
        pquery = pquery + ' and p.GE_Tier2_PnL__c = ' + '\'' + PBE.GE_Tier2_PnL__c + '\'';
        
        if(PBE.GE_Tier3_PnL__c != null && PBE.GE_Tier3_PnL__c != '')
        pquery = pquery + ' and p.GE_Tier3_PnL__c = ' + '\'' + PBE.GE_Tier3_PnL__c + '\'';
        
        if(PBE.GE_Tier4_PnL__c != null && PBE.GE_Tier4_PnL__c != '')
        pquery = pquery + ' and p.GE_Tier4_PnL__c = ' + '\'' + PBE.GE_Tier4_PnL__c + '\'';
        
        if(PBE.GE_Tier5_PnL__c != null && PBE.GE_Tier5_PnL__c != '')
        pquery = pquery + ' and p.GE_Tier5_PnL__c = ' + '\'' + PBE.GE_Tier5_PnL__c + '\'';
        
        if(PBE.GE_Tier6_PnL__c != null && PBE.GE_Tier6_PnL__c != '')
        pquery = pquery + ' and p.GE_Tier6_PnL__c = ' + '\'' + PBE.GE_Tier6_PnL__c + '\'';
        
        if(selectedProHost != null && selectedProHost != '')
        pquery = pquery + ' and p.GEEM_HstEqpmt__c = ' + '\'' + selectedProHost + '\'';
            
        if(selectedProTech != null && selectedProTech != '')
        pquery = pquery + ' and p.Technology__c = ' + '\'' + selectedProTech + '\'';  
        
        ProLineList = Database.Query(pquery + ' order by p.Name asc limit :limitrows');
            for(Product2 p : ProLineList)
            {
                if((!ProLineNm.contains(p.GEEM_ProLn__c)) && p.GEEM_ProLn__c != null && p.GEEM_ProLn__c != '')
                ProLineValues.add(new SelectOption((string)p.GEEM_ProLn__c,(string)p.GEEM_ProLn__c));
                ProLineNm.add((string)p.GEEM_ProLn__c);
            }
        }
    
    }
    
    //get Product Offering Values
    public void ProOfferingLovs()
    {
    
    
        //reset the Offering picklist
        ProOfferingValues.clear();
        ProOfferingValues.add(new SelectOption('','--None--'));
        selectedProOffering = '';
        
        Set<string> ProOfferingNm = new Set<string>();
        if(selectedProLine != '')
        {
        
        List<Product2> ProOfferingList = new List<Product2>();
        string pquery = 'Select p.CurrencyIsoCode, p.Id, p.IsActive,  p.GEEM_ProOffng__c,p.GEEM_ProLn__c,p.GEEM_ProFmly__c,p.Description, p.Family, p.Name, p.ProductCode,p.GE_ES_P_L__c,p.BigMachines__Part_Number__c,p.GE_ES_Offering__c,p.GE_ES_Product_Service__c,p.GE_ES_Sub_P_L__c,p.GE_ES_Oppty_Driver__c,p.GE_Tier1_PnL__c,p.GE_Tier2_PnL__c,p.GE_Tier3_PnL__c,p.GE_Tier4_PnL__c,p.GE_Tier5_PnL__c,p.GE_Tier6_PnL__c,p.Technology__c,p.GEEM_HstEqpmt__c from Product2 p where p.IsActive=true ';
        if(PBE.GE_Tier1_PnL__c != null && PBE.GE_Tier1_PnL__c != '')
        pquery = pquery + ' and p.GE_Tier1_PnL__c = ' + '\'' + PBE.GE_Tier1_PnL__c + '\'';
        
        if(PBE.GE_Tier2_PnL__c != null && PBE.GE_Tier2_PnL__c != '')
        pquery = pquery + ' and p.GE_Tier2_PnL__c = ' + '\'' + PBE.GE_Tier2_PnL__c + '\'';
        
        if(PBE.GE_Tier3_PnL__c != null && PBE.GE_Tier3_PnL__c != '')
        pquery = pquery + ' and p.GE_Tier3_PnL__c = ' + '\'' + PBE.GE_Tier3_PnL__c + '\'';
        
        if(PBE.GE_Tier4_PnL__c != null && PBE.GE_Tier4_PnL__c != '')
        pquery = pquery + ' and p.GE_Tier4_PnL__c = ' + '\'' + PBE.GE_Tier4_PnL__c + '\'';
        
        if(PBE.GE_Tier5_PnL__c != null && PBE.GE_Tier5_PnL__c != '')
        pquery = pquery + ' and p.GE_Tier5_PnL__c = ' + '\'' + PBE.GE_Tier5_PnL__c + '\'';
        
        if(PBE.GE_Tier6_PnL__c != null && PBE.GE_Tier6_PnL__c != '')
        pquery = pquery + ' and p.GE_Tier6_PnL__c = ' + '\'' + PBE.GE_Tier6_PnL__c + '\'';
        
        if(selectedProHost != null && selectedProHost != '')
        pquery = pquery + ' and p.GEEM_HstEqpmt__c = ' + '\'' + selectedProHost + '\'';
            
        if(selectedProTech != null && selectedProTech != '')
        pquery = pquery + ' and p.Technology__c = ' + '\'' + selectedProTech + '\'';                    
        
        if(selectedProLine != null && selectedProLine != '')
        pquery = pquery + ' and p.GEEM_ProLn__c = ' + '\'' + selectedProLine + '\'';
        
        
        
        ProOfferingList = Database.Query(pquery + ' order by p.Name asc limit :limitrows');
            for(Product2 p : ProOfferingList)
            {
                if((!ProOfferingNm.contains(p.GEEM_ProOffng__c)) && p.GEEM_ProOffng__c != null && p.GEEM_ProOffng__c != '')
                ProOfferingValues.add(new SelectOption((string)p.GEEM_ProOffng__c,(string)p.GEEM_ProOffng__c));
                ProOfferingNm.add((string)p.GEEM_ProOffng__c);
            }
        }
    
    }
    
    //filter criteria
    public void ProductFilterSearch()
    {
       List<Product2> prodQry = new  List<Product2>();
       pids.clear();
       
       
       chkFlag = false;
       pagingRecordsList.clear();
       SearchString = '';
       ProductCode = '';
       PBE.BigMachines__Part_Number__c = '';
           
       string pquery = 'Select p.CurrencyIsoCode, p.Id, p.IsActive, p.Description, p.GE_ES_Sub_P_L__c, p.Name, p.ProductCode,p.GE_ES_P_L__c,p.BigMachines__Part_Number__c,p.GE_ES_Offering__c,p.GE_ES_Product_Service__c,p.GE_ES_Oppty_Driver__c,p.GE_Tier1_PnL__c,p.GE_Tier2_PnL__c,p.GE_Tier3_PnL__c,p.GE_Tier4_PnL__c,p.GEEM_ProFmly__c,p.GEEM_ProLn__c,p.GEEM_ProOffng__c,p.GE_Tier5_PnL__c,p.GE_Tier6_PnL__c,p.Technology__c,p.GEEM_HstEqpmt__c from Product2 p where   p.IsActive=true and p.CurrencyIsoCode = ' + '\'' + CaseObj.CurrencyIsoCode + '\'';
        if(PBE.GE_ES_Sub_P_L__c != null && PBE.GE_ES_Sub_P_L__c != '')
        pquery = pquery + ' and p.GE_ES_Sub_P_L__c = ' + '\'' + PBE.GE_ES_Sub_P_L__c + '\'';
        
       
        if(PBE.GE_ES_P_L__c != null && PBE.GE_ES_P_L__c != '')
        pquery = pquery + ' and p.GE_ES_P_L__c = ' + '\'' + PBE.GE_ES_P_L__c + '\'';
        
        if(PBE.GE_ES_Oppty_Driver__c != null && PBE.GE_ES_Oppty_Driver__c != '')
        pquery = pquery + ' and p.GE_ES_Oppty_Driver__c = ' + '\'' + PBE.GE_ES_Oppty_Driver__c + '\'';
        
        if(selectedOffering != null && selectedOffering != '')
        pquery = pquery + ' and p.GE_ES_Offering__c = ' + '\'' + selectedOffering + '\'';
        
        if(selectedService != null && selectedService != '')
        pquery = pquery + ' and p.GE_ES_Product_Service__c = ' + '\'' + selectedService + '\'';
        
        if(PBE.GE_Tier2_PnL__c != null && PBE.GE_Tier2_PnL__c != '')
        pquery = pquery + ' and p.GE_Tier2_PnL__c = ' + '\'' + PBE.GE_Tier2_PnL__c + '\'';
        
        if(PBE.GE_Tier3_PnL__c != null && PBE.GE_Tier3_PnL__c != '')
        pquery = pquery + ' and p.GE_Tier3_PnL__c = ' + '\'' + PBE.GE_Tier3_PnL__c + '\'';
        
        if(PBE.GE_Tier4_PnL__c != null && PBE.GE_Tier4_PnL__c != '')
        pquery = pquery + ' and p.GE_Tier4_PnL__c = ' + '\'' + PBE.GE_Tier4_PnL__c + '\''; 
        
        if(PBE.GE_Tier5_PnL__c != null && PBE.GE_Tier5_PnL__c != '')
        pquery = pquery + ' and p.GE_Tier5_PnL__c = ' + '\'' + PBE.GE_Tier5_PnL__c + '\'';
        
        if(PBE.GE_Tier6_PnL__c != null && PBE.GE_Tier6_PnL__c != '')
        pquery = pquery + ' and p.GE_Tier6_PnL__c = ' + '\'' + PBE.GE_Tier6_PnL__c + '\''; 
        
        if(selectedProHost  != null && selectedProHost  != '')
        pquery = pquery + ' and p.GEEM_HstEqpmt__c = ' + '\'' + selectedProHost + '\'';
        
        if(selectedProTech  != null && selectedProTech  != '')
        pquery = pquery + ' and p.Technology__c = ' + '\'' + selectedProTech + '\'';
        
        if(selectedProLine != null && selectedProLine != '')
        pquery = pquery + ' and p.GEEM_ProLn__c = ' + '\'' + selectedProLine + '\'';
        
        if(selectedProOffering != null && selectedProOffering != '')
        pquery = pquery + ' and p.GEEM_ProOffng__c = ' + '\'' + selectedProOffering + '\'';
        
        if(CaseObj.RecordType.Name == 'Nuclear') 
        pquery = pquery + ' and (p.GE_Tier2_PnL__c = ' +  '\'' + 'GE Hitachi Nuclear Energy (GEH)' + '\'' + ' or p.GE_Tier2_PnL__c like ' +  '\'' + 'Nuclear%' + '\'' + ')' ;
                                
        system.debug('***424**prodQry '+prodQry+'**'+pgMsgTxt+'***'+pagingRecordsList.size());
        
        prodQry = Database.Query(pquery  + ' order by p.Name asc limit 1000'); 
        List<ProductsWrapper> PBEList = new List<ProductsWrapper>();    
        isNextRender = false;
        isPreviousRender = false;    
        if(prodQry.size() == 0 )
        {
            //prodRes = prodQry ;
            errorStatus=true;
            ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, 'No Products are present'));
            pgMsgTxt = 'Please search for the products and then filter';            
            totalResults =  0;
            resultsStartNumber = 0;
            resultsStopNumber = 0; 
            //return null;    
        }
        else
        {
            errorStatus = false;
            pgMsgTxt = '';
            integer i = 1;
            integer j=1;
            ListIndex = 0;
            for(Product2 pb : prodQry)
            {
                if(i > j*25)
                {
                    pagingRecordsList.add(PBEList);
                    PBEList = new List<ProductsWrapper>();
                    j++;
                }
                ProductsWrapper pw = new ProductsWrapper(pb);
                PBEList.add(pw);      
                pids.add(pb.Id); 
                i++;
            } 
            pagingRecordsList.add(PBEList);
            system.debug('**final**'+pagingRecordsList.size() + '***'+ ListIndex);
            if(pagingRecordsList.size() > 1)
            {
                isNextRender = true;
                isPreviousRender = false;
            } 
            totalResults =  prodQry.size();
            resultsStartNumber = 1;
            if(totalResults < 25)
            resultsStopNumber = totalResults;
            else
            resultsStopNumber = 25;     

        }    
                
        system.debug('prodQry '+prodQry);       
        if(pagingRecordsList.size() > 0)                 
        ProductSearchResult(pagingRecordsList[0]);
        //return null;
    }
    
    //method the return the search result status  
    public void ProductSearchResult(List<ProductsWrapper> prodQry)
    {  
       /*system.debug(prodQry);
       system.debug(prodQry.size());
       
       
       System.debug('product result'+prodQry);
       
        if(prodQry.size()==0)
        {
            errorStatus=true;
            ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, 'No Products are present'));
                
        }
        else
        {
            errorStatus = false;
        }  */     
 
       
    }
    
    
    
    // Redirects the page to AddProducts page
    public PageReference ProcessSelected()
    {
    
         try
         {
            
           
            
            pagereference pg;
            if(CaseObj.RecordType.Name == 'Env - CS')
            pg = new Pagereference('/apex/GE_ES_CaseProductsAddingMultiLineItem?id='+CaseObj.id);
            /*if(CaseObj.RecordType.Name == 'Env - IR')
            pg = new Pagereference('/apex/GE_PW_WES_AddMultiLineItems?id='+CaseObj.id);
            if(CaseObj.RecordType.Name == 'Industrial')
            pg = new Pagereference('/apex/GE_OG_DPS_AddMultiLineItems?id='+CaseObj.id);
            if(CaseObj.RecordType.Name == 'MCS - CS')
            pg = new Pagereference('/apex/GE_PW_Thermal_AddMultiLineItems?id='+CaseObj.id);
            if(CaseObj.RecordType.Name == 'MCS - IR')
            pg = new Pagereference('/apex/GE_PW_AE_AddMultiLineItems?id='+CaseObj.id);
            if(CaseObj.RecordType.Name == 'Nuclear')*/
            pg = new Pagereference('/apex/GE_ES_CaseProductsAddingMultiLineItem?id='+CaseObj.id);
            return pg;

           
         }
         catch(Exception ex)
         {
             ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'testing the data'));
             return null;
         }
    }
    
  
    public string[] getheaders() 
    { 
        return new string [] {'Product','Product Code','Product Description','Quantity','Sales Price','Serial Number','Manufacturing Date','Defect Information'} ; 
    }


    
    //get previous page of search result
    public void getPrevious()
    {
         chkFlag = false;
         
         //Hide Previous link on first page and  
         //enable the next link
         if(pagingRecordsList.size() > 0)
         {
             if(ListIndex == 1)
             {
                 isNextRender = true;
                 isPreviousRender = false;
             }
             //enable Previous and next link between first and last page
             else
             {
                 isNextRender = true;
                 isPreviousRender = true;
             } 
             //Reset the start and stop result parameters
             if(resultsStartNumber > 1) 
             {
                 resultsStartNumber = resultsStartNumber - 25;
                 resultsStopNumber = resultsStopNumber  - pagingRecordsList[ListIndex].size();
             }
             //rest the list index
             if(ListIndex > 0)
             {
                 ListIndex--;
                  
             } 
         }   
    }
            
    //get next page of search result
    public void getNext()
    {
         chkFlag = false;
         
         //Hide Next link on last page and 
         //enable the previous link
         system.debug('***'+pagingRecordsList.size());
         if(pagingRecordsList.size() > 0)
         {
             if(ListIndex + 1 == pagingRecordsList.size()-1)
             {
                 isNextRender = false;
                 isPreviousRender = true;
             }
             //enable Previous and next link between first and last page
             else
             {
                 isNextRender = true;
                 isPreviousRender = true;
             }    
             //Reset the start and stop result parameters
             if(totalResults > resultsStopNumber)
             {
                 resultsStartNumber = resultsStopNumber + 1;
                 resultsStopNumber = resultsStopNumber  + pagingRecordsList[ListIndex + 1].size();
             }
                
             //reset the list index
             if(ListIndex < pagingRecordsList.size()-1 )
             { 
                 ListIndex++;
                 //prodRes = pagingRecordsList[ListIndex];
             } 
         }   
    }
            
            
        
    //method to populate the multi line items
    public PageReference populateLineItems()
    {
         /*List<GE_Case_Product__c> CLMList1 = new List<GE_Case_Product__c>(); 
         Set<Id> selectedIds = new Set<id>();
         
         if(ListIndex == null)
         {
             PageReference pg = new PageReference('/apex/GE_ES_SearchAddCaseProducts?id='+CaseObj.id);
             pg.setRedirect(true);
             return pg;
         }
         //if(pagingRecordsList.size() > 0)
         for(ProductsWrapper pbEnt : pagingRecordsList[ListIndex])
            {
               
               if(pbEnt.checked == true)
               selectedIds.add(pbEnt.PBooke.Id);
            }
             
         List<Product2> PbeList = [Select  p.Id, p.IsActive, p.Name ,p.Description, p.Family,p.ProductCode,p.GE_ES_P_L__c,p.GE_ES_Sub_P_L__c,p.GE_ES_Oppty_Driver__c,p.BigMachines__Part_Number__c,p.GE_ES_Offering__c,p.GE_ES_Product_Service__c from Product2 p where   id in :selectedIds];            
         for(Product2 pb : PbeList)
         {
             GE_Case_Product__c cli = new GE_Case_Product__c();
             cli.GE_ES_Case__c= CaseObj.Id;
             cli.GE_ES_ProdctName__c = pb.id;
             cli.GE_ES_ProdNamHid__c = (string)pb.Name;
             cli.GE_ES_P_L_Temp__c = (string)pb.GE_ES_P_L__c;
             cli.GE_ES_SubPL_Hid__c = (string)pb.GE_ES_Sub_P_L__c;
             cli.GE_ES_OptyDrvHid__c = (string)pb.GE_ES_Oppty_Driver__c;
             cli.GE_ES_ProdSerHid__c = (string)pb.GE_ES_Product_Service__c;
             cli.GE_ES_OffrngHid__c = (string)pb.GE_ES_Offering__c;
             cli.GE_ES_ProdCodHid__c = (string)pb.ProductCode;
             cli.GE_ES_ProdDesHid__c= (string)pb.Description;
             system.debug(cli.GE_ES_ProdNamHid__c+'****'+'718'+'***'+pb.Name);             
             cli.GE_ES_Quantity__c= 1;             
             CLMList1.add(cli);
         } 
         CaseProdList = CLMList1; */
          
         /*SFDC Support Test - Begin*/
         //System.debug('CLMLIST**'+ CLMList1 ) ;
         /*SFDC Support Test - End*/

         return null;
    }
        
    //method to save and add more products
    public pagereference SavenMore()
    {
        PageReference pg = saveEdit();
        PageReference pgMore = new Pagereference('/apex/GE_ES_SearchAddCaseProducts?id='+CaseObj.id);
        pgMore.setRedirect(true);
        return pgMore;
    }    
    
    // Used to save the Case Product Line Items in the multi line page  
    public PageReference  saveEdit() 
    {
         system.debug(' inside save edit ******'); 
         PageReference pref;     
    
             try
                {
                    system.debug('###'+CaseProdList);
                    for(GE_Case_Product__c cLM : getCaseProdList())
                    {
                        
                        //system.debug('quantity value ::'+ oLM.Quantity +'oLM for product' + oLM.Product_Family__c);
                           
                                
                    }
 
        
                    upsert CaseProdList;
                    PageReference actPageRef = new PageReference('/'+CaseObj.Id);
                    return actPageRef;
                }
         
                catch(ListException ex)
                {
                    system.debug(' inside listexception ex #### ');
                    //ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, ex));
                    ApexPages.addMessages(ex);
                    return null;
                }
                catch(DmlException e)
                {
                    system.debug(' inside DML exception e ');
                    //ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, e));
                    ApexPages.addMessages(e);
                    return null;
                }
                catch(Exception e) 
                {
                    system.debug(' inside exception e ');
                    ApexPages.Message qtyMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Please enter quantity');
                    ApexPages.addMessages(e);
                    return null;
                }
        
    
    } 
     
    
     //helper class for testmethod
     public void callpopulateitems()
     {
        List<ProductsWrapper> lstwpcls2 = new List<ProductsWrapper>();
        ProductSearchResult(lstwpcls2);
        ProductsWrapper p = new ProductsWrapper();
        for(ProductsWrapper pw: pagingRecordsList[0])
        pw.checked = true;
        PageReference pgl = populateLineItems();
        List<ProductsWrapper> lstwpcls = getprodRes();
     }
     
     
     //wrapper class to accomodate the searched products
    public class ProductsWrapper {
 
        public Boolean checked{ get; set; }
        public Product2 PBooke { get; set;}
        
       
        public ProductsWrapper(){
            PBooke = new Product2();
            checked =false;
        }
     
        public ProductsWrapper(Product2 pb)
        {
            PBooke = pb;
            checked = false;
            
        }
        
    }     
      

}