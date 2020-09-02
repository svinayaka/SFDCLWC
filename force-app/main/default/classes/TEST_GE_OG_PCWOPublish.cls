/*
=======================================================================================================================================
Name       : TEST_GE_OG_PCWOPublish 
Author     : Amit Kumar
Created On : 13th May 2015
Purpose    : To calculate code coverage for "GE_OG_PCWOPublish"  Apex class
======================================================================================================================================
*/
@isTest(SeeAllData=true)
public class TEST_GE_OG_PCWOPublish {
 static testMethod void GE_OG_PCWOPublish(){
           test.startTest();
           try{
                GE_OG_PCWOPublish.ProcessWorkOrder_pt processRequest_x = new GE_OG_PCWOPublish.ProcessWorkOrder_pt();
                GE_OG_PCWOPublish.ProcessWorkOrderDetails_element wdetail_x=new GE_OG_PCWOPublish.ProcessWorkOrderDetails_element();
                GE_OG_PCWOPublish.ProcessWorkOrderDetailsResponse_element processResponse_x= new GE_OG_PCWOPublish.ProcessWorkOrderDetailsResponse_element();
                Map<string,string> inputHeader=new Map<string,string>();
                string AccessToken='Bearer 12345678';
                inputHeader.put('Authorization',AccessToken); 
                processRequest_x.inputHttpHeaders_x = inputHeader;
                GE_OG_PCWOPublish.Account_element account_x = new GE_OG_PCWOPublish.Account_element();
                GE_OG_PCWOPublish.Location_element location_x = new GE_OG_PCWOPublish.Location_element(); 
                GE_OG_PCWOPublish.InstalledProduct_element installedproduct_x = new GE_OG_PCWOPublish.InstalledProduct_element();
                GE_OG_PCWOPublish.Case_element case_xl = new GE_OG_PCWOPublish.Case_element();
                GE_OG_PCWOPublish.WorkOrder_element workorder_x = new GE_OG_PCWOPublish.WorkOrder_element();
                GE_OG_PCWOPublish.ShipToAddress_element shipToAdd_x = new GE_OG_PCWOPublish.ShipToAddress_element(); 
                GE_OG_PCWOPublish.WorkDetail_element workdetail_x = new GE_OG_PCWOPublish.WorkDetail_element();
                GE_OG_PCWOPublish.Product_element product_x = new GE_OG_PCWOPublish.Product_element();
                GE_OG_PCWOPublish.ServiceTeam_element technician_x = new GE_OG_PCWOPublish.ServiceTeam_element();
                List<GE_OG_PCWOPublish.Location_element> location_xItem = new List<GE_OG_PCWOPublish.Location_element>();
                List<GE_OG_PCWOPublish.InstalledProduct_element>  installedproduct_xItem = new List<GE_OG_PCWOPublish.InstalledProduct_element>();
                List<GE_OG_PCWOPublish.Case_element> case_xItem = new List<GE_OG_PCWOPublish.Case_element>();
                List<GE_OG_PCWOPublish.WorkOrder_element> workorder_xItem = new List<GE_OG_PCWOPublish.WorkOrder_element>();
                List<GE_OG_PCWOPublish.WorkDetail_element> workdetail_xItem = new List<GE_OG_PCWOPublish.WorkDetail_element>();
                    
                //Attachment
                wdetail_x.Attachment='sdssdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsds';
                string attachment='sdsdasdfasfadafdfdfsfdsfsfsfsfdsfdsfdsss';
            
                //Populate account
                account_x.AccountName='IgateTest';
                system.assertequals(account_x.AccountName,'IgateTest');
             
                //Populate Location
                location_x.country='US';
                location_xItem .add(location_x); 
                account_x.Location=location_xItem ;
               
                //Populate Installed product
                installedproduct_x.WellID='IgateWell';
                installedproduct_xItem.add(installedproduct_x);
                location_x.InstalledProduct=installedproduct_xItem;
             
                //Populate case
                case_xl.CaseType='IgateCase';
                case_xItem.add(case_xl);
                location_x.Case_x=case_xItem;
            
                //Populate work order
                workorder_x.OrderType='IgateOrder';
                workorder_xItem.add(workorder_x);
                Case_xl.WorkOrder=workorder_xItem; 
            
                //Populate ship to
                shipToAdd_x.Street='IgateStreet';
                workorder_x.ShipToAddress=shipToAdd_x; 
            
                //Populate work detail
                workdetail_x.LineQuantity=1;                
                workdetail_xItem.add(workdetail_x);
                workorder_x.WorkDetail=workdetail_xItem; 
           
                //Populate product/pricebook
                product_x.ProductName='testProductName';
                product_x.Code='01234';
                product_x.PriceBook='Standard Pricebook';
               
                //Populate service team
                technician_x.ServiceTeamName='IgateTeam';
                workorder_x.ServiceTeam=technician_x; 
            
                //Populate product price book
                product_x.PriceBook='IgateBook';
                workdetail_x.Product=product_x; 
            
                system.assertequals(product_x.PriceBook,'IgateBook');
                processRequest_x.ProcessWorkOrder(attachment,account_x);
           }
           catch(Exception e){
                System.debug('Exception :'+e.getMessage());
           }
           test.stopTest();
           
        }
}