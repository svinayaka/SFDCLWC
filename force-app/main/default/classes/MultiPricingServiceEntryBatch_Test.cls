@isTest
global class MultiPricingServiceEntryBatch_Test{
public static  testmethod  void MultiPricingServiceEntryBatchMethod(){


                    Product2 pd=new Product2();
                    pd.name='Test product';
                    pd.ProductCode='1234';
                    pd.Description='Test description';
                    insert pd;
                    
                    SVMXC__Activity_Master__c actMaster=new SVMXC__Activity_Master__c();
                    actMaster.SVMXC__Activity_Type__c='Service';
                    actMaster.SVMXC__Description__c='Test';
                    actMaster.Tier_3__c='Artificial Lift';
                    insert actMaster;
                    
                    SVMXC__Activity_Product__c pd1= new SVMXC__Activity_Product__c();
                    pd1.SVMXC__Activity__c=actMaster.id;
                    pd1.SVMXC__Product__c=pd.id;
                    insert pd1;

                    SVMXC__Service_Pricebook__c pbk=new SVMXC__Service_Pricebook__c();
                    pbk.name='servicepricebook';
                    pbk.SVMXC__Description__c='test';
                    pbk.SVMXC__Active__c=true;
                    insert pbk;

                    SVMXC__Service_Pricebook_Entry__c sspe=new SVMXC__Service_Pricebook_Entry__c();
                    
                    sspe.SVMXC__Price_Book__c=pbk.id;
                    //sspe.SVMXC__Price_Book__c=pbk.id;
                    //sspe.SVMXC__Product__c=pd1.id;
                    //sspe.ProductCode=1234;
                    sspe.SVMXC__Activity_Product__c=pd1.id;
                    insert sspe;


                    SVMX_MultiPricing__c nmultiObj = new SVMX_MultiPricing__c();
                    nmultiObj.List_price__c= 92.12;
                    nmultiObj.Service_Pricebook__c= pbk.id;
                    nmultiObj.SVMX_Product__c = pd.id;
                                        
                                        
                                    
                                 //insert nmultiobj;
                                 
                    Test.starttest();
                    MultiPricingServiceEntryBatch mpse=new MultiPricingServiceEntryBatch();
                    database.executebatch(mpse);
                    Test.stoptest();
}
}