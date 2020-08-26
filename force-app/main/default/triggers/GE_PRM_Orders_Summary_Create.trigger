trigger GE_PRM_Orders_Summary_Create on GE_HQ_Account_Plan__c (after insert) {
    List<GE_PRM_Sales_Orders_Goals__c> orders = new List<GE_PRM_Sales_Orders_Goals__c>();

    for(GE_HQ_Account_Plan__c a : trigger.new)
    {
       GE_PRM_Sales_Orders_Goals__c o2 = new GE_PRM_Sales_Orders_Goals__c ();
       o2.GE_PRM_Account_Plan__c = a.id;
       //o2.GE_PRM_Tier_1_New__c = a.GE_HQ_Buss_Tier__c;
       o2.GE_PRM_Tier_1_New__c =  'Oil & Gas (O&G)'; 
      // o2.GE_PRM_Tier_2__c = a.GE_PRM_Tier_2__c;
      // o2.GE_PRM_Tier_3__c = a.GE_PRM_Tier_3__c;
       o2.GE_PRM_Period__c = 'Q2';

       GE_PRM_Sales_Orders_Goals__c o1 = new GE_PRM_Sales_Orders_Goals__c ();
       o1.GE_PRM_Account_Plan__c = a.id;
       //o1.GE_PRM_Tier_1_New__c = a.GE_HQ_Buss_Tier__c;
       o1.GE_PRM_Tier_1_New__c =  'Oil & Gas (O&G)'; 
       //o1.GE_PRM_Tier_2__c = a.GE_PRM_Tier_2__c;       
       //o1.GE_PRM_Tier_3__c = a.GE_PRM_Tier_3__c;
       o1.GE_PRM_Period__c = 'Q1';
       
              
       GE_PRM_Sales_Orders_Goals__c o3 = new GE_PRM_Sales_Orders_Goals__c ();
       o3.GE_PRM_Account_Plan__c = a.id;
       //o3.GE_PRM_Tier_1_New__c = a.GE_HQ_Buss_Tier__c;
       o3.GE_PRM_Tier_1_New__c =  'Oil & Gas (O&G)'; 
       //o3.GE_PRM_Tier_2__c = a.GE_PRM_Tier_2__c;
       //o3.GE_PRM_Tier_3__c = a.GE_PRM_Tier_3__c;
       o3.GE_PRM_Period__c = 'Q3';
       
       GE_PRM_Sales_Orders_Goals__c o4 = new GE_PRM_Sales_Orders_Goals__c ();
       //o4.GE_PRM_Tier_1_New__c = a.GE_HQ_Buss_Tier__c;
       o4.GE_PRM_Tier_1_New__c =  'Oil & Gas (O&G)'; 
       //o4.GE_PRM_Tier_2__c = a.GE_PRM_Tier_2__c;
       o4.GE_PRM_Account_Plan__c = a.id;
       //o4.GE_PRM_Tier_3__c = a.GE_PRM_Tier_3__c;
       o4.GE_PRM_Period__c = 'Q4';
       
       GE_PRM_Sales_Orders_Goals__c o5 = new GE_PRM_Sales_Orders_Goals__c ();
       //o5.GE_PRM_Tier_1_New__c = a.GE_HQ_Buss_Tier__c;
       o5.GE_PRM_Tier_1_New__c =  'Oil & Gas (O&G)'; 
       //o5.GE_PRM_Tier_2__c = a.GE_PRM_Tier_2__c;
       o5.GE_PRM_Account_Plan__c = a.id;
       //o5.GE_PRM_Tier_3__c = a.GE_PRM_Tier_3__c;
       o5.GE_PRM_Period__c = 'YEAR';
       
       orders.add(o1);
       orders.add(o2);
       orders.add(o3);
       orders.add(o4);
       orders.add(o5);
       
       for(GE_PRM_Sales_Orders_Goals__c o : orders)
       System.debug('OR'+o.GE_PRM_Period__c);
    }

    insert orders; 

}