trigger GEHQPopulateAccSalesRegion on Account (before insert, before update) {
    
  //Code to skip trigger

    OG_Trigger_fire_Decision__c lstObj = OG_Trigger_fire_Decision__c.getValues('GEHQPopulateAccSalesRegion');
       
    if(lstObj!=null && lstObj.isActive__c == true && lstObj.Object_Name__c=='Account'){
        return;  
    }
    else{
    system.debug('in GEHQPopulateAccSalesRegion');
    /*
    Description: Populates the Sales Region lookup field on Account based on information stored in the GE_ES_Country_State_Sales_Region__c
    configuration table.  Also uses a Custom Label called "RP_CountryWithStates" to determine whether the GE_HQ_Country_Code__c specified on the
    Account is one that uses States to determine the Region or not
    */
    
    /*Updated  by  Gautam For R-17813.This new  update will convert the MDM Country ISO code to Country name*/ 
    
    List<Account> accountsToProcess = new List<Account>();
    List<String> str,str1,str2,str3,str4 =new List<String>();
    set<string> ShipCode=new set<string>();
    set<string>  BillCode=new set<string>();  
    set<string> countrycode=new set<string>();
    map<string,string> ISOToNameMap=new map<string,string>();
    
    for (Account a : trigger.new){
    
       System.debug('User Name::'+UserInfo.getUserName());
        
        if(UserInfo.getUserName()=='userRCJ@testorg.com'){        
        
        } 
        else {     
            if (trigger.isInsert){
                if(a.ShippingCountry!=null  && (a.ShippingCountry).length()==2) {
                  a.GE_OG_MDM_Shipping_Country_ISO_Code__c=a.ShippingCountry;
                  a.GE_HQ_Country_Code__c=a.GE_OG_MDM_Shipping_Country_ISO_Code__c;
                  ShipCode.add(a.GE_OG_MDM_Shipping_Country_ISO_Code__c);
                }  
                if(a.BillingCountry!=null  &&  (a.BillingCountry).length()==2){
                  a.GE_OG_MDM_Billing_Country_ISO_Code__c=a.BillingCountry; 
                  a.GE_HQ_Country_Code__c=a.GE_OG_MDM_Billing_Country_ISO_Code__c;
                  BillCode.add(a.GE_OG_MDM_Billing_Country_ISO_Code__c);
                }
                
                System.debug('a.GE_HQ_Country_Code__c::'+a.GE_HQ_Country_Code__c);
                System.debug('a.ShippingCountry::'+a.ShippingCountry);
                System.debug('a.GE_HQ_New_Account_Country__c::'+a.GE_HQ_New_Account_Country__c);
                if (a.GE_HQ_Country_Code__c != null || a.ShippingCountry != null || a.GE_HQ_New_Account_Country__c != null){   
                    accountsToProcess.add(a);
                }
                
            }
            else if(trigger.isUpdate){
            
                if(a.ShippingCountry!=null  && (a.ShippingCountry).length()==2  && a.ShippingCountry!=trigger.oldmap.get(a.id).ShippingCountry) {
                   a.GE_OG_MDM_Shipping_Country_ISO_Code__c=a.ShippingCountry;
                   a.GE_HQ_Country_Code__c=a.GE_OG_MDM_Shipping_Country_ISO_Code__c;
                   ShipCode.add(a.GE_OG_MDM_Shipping_Country_ISO_Code__c);
                }   
                if(a.BillingCountry!=null  &&  (a.BillingCountry).length()==2  && a.BillingCountry!=trigger.oldmap.get(a.id).BillingCountry){ 
                   a.GE_OG_MDM_Billing_Country_ISO_Code__c=a.BillingCountry;
                   a.GE_HQ_Country_Code__c=a.GE_OG_MDM_Billing_Country_ISO_Code__c; 
                   BillCode.add(a.GE_OG_MDM_Billing_Country_ISO_Code__c);
                }   
            
                /* if(((trigger.oldmap.get(a.Id).GE_HQ_Country_Code__c != a.GE_HQ_Country_Code__c))
                 || ((trigger.oldmap.get(a.Id).ShippingCountry != a.ShippingCountry ))
                 || ((trigger.oldmap.get(a.Id).GE_HQ_New_Account_Country__c != a.GE_HQ_New_Account_Country__c))
                 || (((a.ShippingState != null) && trigger.oldmap.get(a.Id).ShippingState != a.ShippingState)))
                 
                  accountsToProcess.add(a); */
                     // Added by chanu
                      
                      if(((trigger.oldmap.get(a.Id).GE_HQ_Country_Code__c != a.GE_HQ_Country_Code__c))
                 || ((trigger.oldmap.get(a.Id).ShippingCountry != a.ShippingCountry ))
                 || ((trigger.oldmap.get(a.Id).GE_HQ_New_Account_Country__c != a.GE_HQ_New_Account_Country__c))
                 || ((trigger.oldmap.get(a.Id).ShippingState != a.ShippingState))){
                  system.debug('acount--'+ a);
                     accountsToProcess.add(a);
                 } 
            }
       }
    } // end of for loop
    
    System.debug('--------------Size::-----------'+ accountsToProcess.size());
   
    if((ShipCode.Size()>0  ||  BillCode.size()>0) && Label.MDMISOToCountryName=='ON')  {  
         for(GE_HQ_Country__c  cn:[select GE_HQ_ISO_Code__c,Name  from GE_HQ_Country__c where GE_HQ_ISO_Code__c in: ShipCode OR  GE_HQ_ISO_Code__c in: BillCode]){
           ISOToNameMap.put(cn.GE_HQ_ISO_Code__c,cn.Name);
         }
    }
    
    if(!ISOToNameMap.IsEmpty()){
      for(Account ac:trigger.new){
        if(ac.GE_OG_MDM_Shipping_Country_ISO_Code__c!=null && ISOToNameMap.Containskey(ac.GE_OG_MDM_Shipping_Country_ISO_Code__c))
            ac.ShippingCountry=ISOToNameMap.get(ac.GE_OG_MDM_Shipping_Country_ISO_Code__c);
        if(ac.GE_OG_MDM_Billing_Country_ISO_Code__c!=null && ISOToNameMap.Containskey(ac.GE_OG_MDM_Billing_Country_ISO_Code__c))
            ac.BillingCountry=ISOToNameMap.get(ac.GE_OG_MDM_Billing_Country_ISO_Code__c);    
      }
    }        
    
    if (accountsToProcess.size() > 0) { 
    
         for (Account a : accountsToProcess) { 
         
             String sCtry;
             
             if( a.GE_HQ_Country_Code__c != null)
             sCtry = a.GE_HQ_Country_Code__c;
             else if ( a.ShippingCountry != null)
             sCtry = a.ShippingCountry;
             else if ( a.GE_HQ_New_Account_Country__c != null)
             sCtry = a.GE_HQ_New_Account_Country__c;
                
             System.debug('---------sCtry-----::'+sCtry); 
             
             String sShippingState;
             if( ((sCtry != null) && (sCtry.toUpperCase() == 'US')) 
               || ((sCtry != null) && (sCtry.toUpperCase() == 'UNITED STATES')) 
               || ((sCtry != null) && (sCtry.toUpperCase() == 'CANADA')) )
                 sShippingState = a.ShippingState;
             else    
                 sShippingState = null;    
             
             System.debug('sShippingState::'+sShippingState ); 
              
                
             if(sCtry !=null){   
                //for Bug-0000020055 commented GE Energy (GEE, HQ)
                //str=GE_HQ_Get_Region.getRegion('GE Energy (GEE, HQ)',sCtry ,sShippingState,'Sales');
                //str1=GE_HQ_Get_Region.getRegion('Global Growth Organization (GGO)',sCtry,sShippingState,'Sales');
                //str2=GE_HQ_Get_Region.getRegion('Power & Water (P&W)',sCtry ,sShippingState,'Sales');
                system.debug('---sctry---'+sCtry);
                 str3=GE_HQ_Get_Region.getRegion('Oil & Gas',sCtry ,null,'Sales');
               //str4=GE_HQ_Get_Region.getRegion('Energy Management (EM)',sCtry ,sShippingState,'Sales');
                
                if(str !=null && str.size()>0 && str[1] != null) a.GE_HQ_Region_Tier1__c = str[1];                 
                else
                a.GE_HQ_Region_Tier1__c=null; 
                System.debug('*****Val of GE_EnergyHQRegion**'+a.GE_HQ_Region_Tier1__c); 
               // accountupdate.add(a);
                
                
                              
                if(str1 !=null && str1.size()>0 && str1[1] != null) a.GE_GGO_Region_Tier1__c = str1[1];
                else
                a.GE_GGO_Region_Tier1__c=null;  
                System.debug('*****Val of GE_GGO_Region__c**'+a.GE_GGO_Region_Tier1__c);
               // accountupdate.add(a);
                
                /*if(str2 !=null && str2.size()>0 && str2[1] != null) a.GE_PW_Region_Tier1_del__c = str2[1];
                else
                a.GE_PW_Region_Tier1_del__c=null;    
                System.debug('*****Val of GE_PW_Region__c**'+a.GE_PW_Region_Tier1_del__c); */
                            
                if(str3 !=null && str3.size()>0 && str3[1] != null)a.GE_OG_Region_Tier1__c = str3[1];
                else
                a.GE_OG_Region_Tier1__c=null;
                System.debug('*****Val of GE_OG_Region__c**'+a.GE_OG_Region_Tier1__c);
               // accountupdate.add(a);
               
                /* if(str4 !=null && str4.size()>0 && str4[1] != null) a.GE_EM_Region_Tier1__c = str4[1];
                else
                a.GE_EM_Region_Tier1__c=null;
                System.debug('*****Val of GE_EM_Region__c**'+a.GE_EM_Region_Tier1__c);*/
                
             }
         }
    } // end of If condition
   }
 } // end of Trigger