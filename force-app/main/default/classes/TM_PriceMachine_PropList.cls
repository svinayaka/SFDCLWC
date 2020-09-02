/**************************************************************************************************************************************
    Class Name: TM_PriceMachine_PropList    
    Purpose:    This class helper class for tmPrcMchPrcPropLst LWC.
               
    History of Changes:                 
    -----------------------------------------------------------------------------------------------------------------------------------
        Date                                Developer                               Comments
    -----------------------------------------------------------------------------------------------------------------------------------
    04-JUL-2020                             Vikram Potharaju                        Initial Code
    23-JUL-2020                             Vikram                                  created new method with name getListOfServices.
    
**************************************************************************************************************************************/
public without sharing class TM_PriceMachine_PropList {

    /*
        Method Name: fatchPickListValue
        Parameters:  Object API Name & Field API Name
        Description: This method will fetch picklist values for given Object and field
        Developer:   Vikram
    */    
    @AuraEnabled(cacheable = true)
    public static List < FatchValueWrapper > fatchPickListValue(sObject objInfo, string picklistFieldApi) {
        
        Schema.DescribeSObjectResult objDescribe = objInfo.getSObjectType().getDescribe();
        map < String, Schema.SObjectField > mapOfFields = objDescribe.fields.getMap();
        list < Schema.PicklistEntry > lstOfValues = mapOfFields.get(picklistFieldApi).getDescribe().getPickListValues();
        list < FatchValueWrapper > lstOfWrps = new list < FatchValueWrapper > ();
        if(lstOfValues != null && lstOfValues.size()>0){
            for (Schema.PicklistEntry sel : lstOfValues) {
                FatchValueWrapper wrpObj = new FatchValueWrapper();
                wrpObj.slabel = sel.getLabel();
                wrpObj.svalue = sel.getValue();
                lstOfWrps.add(wrpObj);
            }
        }
        
        return lstOfWrps;
 
    }
    
    /*
        Class Name: FatchValueWrapper
        Description: Wrapper class to hold picklist values
        Developer:   Vikram
    */
    public with sharing class FatchValueWrapper {
        @auraEnabled public string slabel {get;set;}
        @auraEnabled public string svalue {get;set;}
    }

    
    /*
        Class Name: getPriceProposalList
        Description: This method helps in pulling from Price Proposal Custom Object and display in tmPrcMchPrcPropLst LWC .
        Developer:   Vikram
    */
    @AuraEnabled(cacheable=true)
    public static List<TM_Price_Proposal__c> getPriceProposalList() {
        return [SELECT Id, Name, LastModifiedDate, TM_Pricing__c,TM_Total_Revenue__c,TM_Area__c,
                TM_District__c,TM_Total_Discount_From_List__c,TM_Products__c,TM_Profitability_Status__c
            FROM TM_Price_Proposal__c Limit 100];
    }

    
    /*
        Class Name: createPrcPropRcd
        Description: This method helps in creating Price Proposal record from UI for Price Machine.
        Developer:   Vikram
    */
    @AuraEnabled(cacheable=true)
    public static id createPrcPropRcd(TM_Price_Proposal__c propObj){
    //,Id customerId,String strCntry,
      //                                                          String strState) {
       system.debug('@@@ Entered method');
        TM_Price_Proposal__c prcPropObj = new TM_Price_Proposal__c();
        try{
        //prcPropObj.Name = prcPropName;
        //prcPropObj.Customer__c = customerId;
        /*prcPropObj.TM_Country__c = strCntry;
        prcPropObj.States__c  = strState;*/  

        insert prcPropObj;
        system.debug('@@@::: value of :::'+prcPropObj);
        return prcPropObj.id;
        }catch(Exception ex){
            
            system.debug('@@@::: value of :::'+ex.getMessage());
            return null;
        }

    }

    

    @AuraEnabled
    public static string updateRcd(String strName,String strAccId,String strCntry,String strState,
                                    String strBool){
        System.debug('@@@@:::String 1:::'+strCntry);
        System.debug('@@@@:::String 2:::'+strState);
        system.debug('@@@:::String 3::::'+strBool);
        TM_Price_Proposal__c obj = new TM_Price_Proposal__c();
            obj.Name = strName;
            List<String> lst = (List<String>) System.JSON.deserialize(strAccId, List<String>.class);
            obj.Customer__c = lst[0];
            obj.TM_Country__c = strCntry;
            obj.States__c = strState;

            insert obj;
        return String.valueOf(obj.id); 
        
    }


    /*
        Class Name: getListOfProducts
        Description: This method helps in pulling from Products and display in tmAddProductsLwc LWC .
        Developer:   Vikram
    */
    @AuraEnabled(cacheable=true)
    public static List<Product2> getListOfProducts() {
        return [SELECT id, Name, GE_Tier4_PnL__c, TM_Product_L1__c, TM_Product_L2__c, TM_Product_L3__c,TM_Product_L4__c,
                ProductCode FROM Product2 WHERE ProductCode != null AND Name != null 
                //AND TM_Product_L1__c != null
                Limit 100];
    }
    
    /*
        Class Name: fetchProductsData
        Description: This method helps in pulling Product records and display in tmAddProductsLwc LWC .
        Developer:   Vikram
    */
    //fetchProductsData
    @AuraEnabled( cacheable = true ) 
    public static List< Product2 > fetchProductsData( String searchKey, String strProd1,String strProd2, 
                                                        string strProd3, String strProd4,
                                                        String strTier, String strQuickview ) { 
        system.debug('@@:::searchKey::'+searchKey);
        system.debug('@@::: strProd1::'+strProd1);
        system.debug('@@::: strProd2::'+strProd2);
        system.debug('@@::: strProd3::'+strProd3);
        system.debug('@@::: strProd4::'+strProd4);                                                    
        system.debug('@@::: strTier:::'+strTier);
        system.debug('@@::: strQuickview::'+strQuickview);
                                                            
        String strQry;
        Boolean boolChk = false;
        List<Product2> lstRcds = new List<Product2>();
        strQry = 'SELECT id, Name, GE_Tier4_PnL__c, TM_Product_L1__c, TM_Product_L2__c, TM_Product_L3__c,TM_Product_L4__c,ProductCode FROM Product2 WHERE ';
        
        if(String.isNotBlank(searchKey) && searchKey!= 'All'){
            strQry += ' Name Like \'%'+searchKey+'%\' OR TM_Product_L1__c Like \'%'+searchKey+'%\' OR TM_Product_L2__c Like \'%'+searchKey+'%\' OR TM_Product_L3__c Like \'%'+searchKey+'%\' OR TM_Product_L4__c Like \'%'+searchKey+'%\' OR GE_Tier4_PnL__c Like \'%'+searchKey+'%\'';
            boolChk = true;
        }
        if(String.isNotBlank(strProd1) && strProd1 != 'All'){
            if(boolChk){
                strQry += 'OR TM_Product_L1__c Like \'%'+strProd1+'%\' ';
            }else{
                strQry += ' TM_Product_L1__c Like \'%'+strProd1+'%\' ';
                boolChk = true;
            }    
        }
        if(String.isNotBlank(strProd2) && strProd2 != 'All'){
            if(boolChk){
                strQry += 'OR TM_Product_L2__c Like \'%'+strProd2+'%\' ';
            }else{
                strQry += ' TM_Product_L2__c Like \'%'+strProd2+'%\' ';
                boolChk = true;
            }    
        }
        if(String.isNotBlank(strProd3) && strProd3 != 'All'){
            if(boolChk){
                strQry += 'OR TM_Product_L3__c Like \'%'+strProd3+'%\' ';
            }else{
                strQry += ' TM_Product_L3__c Like \'%'+strProd3+'%\' ';
                boolChk = true;
            }    
        }
        if(String.isNotBlank(strProd4) && strProd4 != 'All'){
            if(boolChk){
                strQry += 'OR TM_Product_L4__c Like \'%'+strProd4+'%\' ';
            }else{
                strQry += ' TM_Product_L4__c Like \'%'+strProd4+'%\' ';
                boolChk = true;
            }    
        }
                                                            
        if(String.isNotBlank(strTier) && strTier!= 'All'){
            if(boolChk){
                strQry += ' OR GE_Tier4_PnL__c Like \'%'+strTier+'%\' ';
            }else{
                strQry += ' GE_Tier4_PnL__c Like \'%'+strTier+'%\' ';
                boolChk = true;
            }  
        }
        
        strQry += ' Limit 300';
        
        System.debug('Query string is: '+ strQry);
        lstRcds = database.query(strQry);
        system.debug('@@@::Size:::'+lstRcds.size());
        return lstRcds;  
         
    } 

    /*
    Class Name: addProdsToProp
    Description: This method helps in Adding selected Products to Price Proposal Record.
    Developer:   Vikram
    */
    @AuraEnabled
    public static String addProdsToProp(List<Product2> lstOfProdRcds, String strRecId) {
        system.debug('@@::Size::::'+lstOfProdRcds.size());
        system.debug('@@:::'+lstOfProdRcds);
        System.debug('@@ rec ID:::'+strRecId);
        List<Product2> UpdProdLst = new List<product2>();

        if(lstOfProdRcds != null && lstOfProdRcds.size()>0){
            for(Product2 prod : lstOfProdRcds){
                prod.TM_Price_Proposal__c = strRecId;
                UpdProdLst.add(prod);
            }
            update UpdProdLst;
        }

        return 'OK';
    }

    /*
        Class Name: filterProdRcdsByKey
        Description: This method helps in pulling from Products records based on search Key.
        Developer:   Vikram
    */
    @AuraEnabled(cacheable=true)
    public static List<Product2> filterProdRcdsByKey(List<Product2> lstOfProdRcds, String strSearchKey){
        Set<Id> setOfProdIds = new Set<Id>();
        String strQry;
        List<Product2> lstRcds = new List<Product2>();
        if(lstOfProdRcds != null && lstOfProdRcds.size()>0){
            setOfProdIds = (new Map<Id,SObject>(lstOfProdRcds)).keySet();
            if(setOfProdIds != null && setOfProdIds.size()>0){
                strQry = 'SELECT id, Name, GE_Tier4_PnL__c, TM_Product_L1__c, TM_Product_L2__c, TM_Product_L3__c,TM_Product_L4__c,ProductCode FROM Product2 WHERE ';
                if(String.isNotBlank(strSearchKey) && strSearchKey!= 'All'){
                    strQry += ' (Name Like \'%'+strSearchKey+'%\' OR ProductCode Like \'%'+strSearchKey+'%\') AND Id IN: setOfProdIds';                    
                    strQry += ' Limit 300';
                    lstRcds = database.query(strQry);
                    system.debug('@@@::Size:::'+lstRcds.size());
                    
                }
            }
            
        }
        if(lstRcds != null && lstRcds.size()>0){
            return lstRcds;  
        }else{
            return null;
        }
    }
    
    
    /*
        Class Name: getListOfServices
        Description: This method helps in pulling from Services and display in tmAddServicesLwc LWC .
        Developer:   Vikram
    */
    @AuraEnabled(cacheable=true)
    public static List<TM_Service__c> getListOfServices() {
        return [SELECT id, Name,TM_Service_Name__c 
                FROM TM_Service__c WHERE Name != null Limit 100];
    }

    //filterServiceRcdsByKey

    /*
        Class Name: filterServiceRcdsByKey
        Description: This method helps in pulling from Services and display in tmAddServicesLwc LWC .
        Developer:   Vikram
    */
    @AuraEnabled(cacheable=true)
    public static List<TM_Service__c> filterServiceRcdsByKey(List<TM_Service__c> lstOfServiceRcds,String strSearchKey) {
        System.debug('@@::strSearchKey:::'+strSearchKey);
        Set<Id> setOfServiceIds = new Set<Id>();
        String strQry;
        List<TM_Service__c> lstRcdsToUpd = new List<TM_Service__c>();
        if(lstOfServiceRcds != null && lstOfServiceRcds.size()>0){
            setOfServiceIds = (new Map<Id,SObject>(lstOfServiceRcds)).keySet();
            if(setOfServiceIds != null && setOfServiceIds.size()>0){
                strQry = 'SELECT id, Name, TM_Service_Name__c FROM TM_Service__c WHERE ';
                if(String.isNotBlank(strSearchKey) && strSearchKey!= 'All'){
                    strQry += ' (Name Like \'%'+strSearchKey+'%\' OR TM_Service_Name__c Like \'%'+strSearchKey+'%\') AND Id IN: setOfServiceIds';                    
                    strQry += ' Limit 300';
                    lstRcdsToUpd = database.query(strQry);
                    system.debug('@@@::Size:::'+lstRcdsToUpd.size());
                    
                }
            }            
        }
        if(lstRcdsToUpd != null && lstRcdsToUpd.size()>0){
            return lstRcdsToUpd;  
        }else{
            return null;
        }
    }

    /*
    Class Name: addServicesToProp
    Description: This method helps in Adding selected Services to Price Proposal Record.
    Developer:   Vikram
    */
    @AuraEnabled
    public static String addServicesToProp(List<TM_Service__c> lstOfServiceRcds, String strRecId) {
        system.debug('@@::Size::::'+lstOfServiceRcds.size());
        system.debug('@@:::'+lstOfServiceRcds);
        System.debug('@@ rec ID:::'+strRecId);
        List<TM_Service__c> UpServiceLst = new List<TM_Service__c>();

        if(lstOfServiceRcds != null && lstOfServiceRcds.size()>0){
            for(TM_Service__c serv : lstOfServiceRcds){
                serv.TM_Price_Proposal__c = strRecId;
                UpServiceLst.add(serv);
            }
            update UpServiceLst;
        }

        return 'OK';
    }

    
}