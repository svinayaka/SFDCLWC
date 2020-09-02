public class AccountHierarchyTestData {

    public static void createTestHierarchy() {
        // Create Accounts with Hierarchy
    
        // Create Top Level Accounts
    
    
        Account[] subAccounts = new Account[]{};
        Account[] accountList = new Account[]{};
        Account[] subAccountsSideTree = new Account[]{};
        Account[] subAccountsList = new Account[]{};
        
        
        String accountName = 'HierarchyTest';
        
        Account parentAccount = new Account(name=accountName+'0', ShippingStreet='1 Main St.', ShippingState='VA', ShippingPostalCode='12345', ShippingCountry='USA', ShippingCity='Anytown', Description='This is a test account', BillingStreet='1 Main St.', BillingState='VA', BillingPostalCode='12345', BillingCountry='USA', BillingCity='Anytown', AnnualRevenue=10000);
        Account subTreeParent  = new Account();
        Account subTreeSideParent  = new Account();

        System.debug('Step1*****');
        insert parentAccount;
        System.debug('Step2*****');

        //parentAccount = [select id, name from account where id=:parentAccount.Id];
        System.debug('Raj:'+parentAccount.Id );
        Id parentID = parentAccount.id;
  
  System.debug('Raj1111:'+ parentID );
    System.Assert(parentID != null, 'Parent Id not found');
        
        // Create sub accounts
    
        for (Integer i=0;i<10;i++){
            subAccounts.add(new Account(name=accountName+i, ShippingStreet='1 Main St.', ShippingState='VA', ShippingPostalCode='12345', ShippingCountry='USA', ShippingCity='Anytown', Description='This is a test account', BillingStreet='1 Main St.', BillingState='VA', BillingPostalCode='12345', BillingCountry='USA', BillingCity='Anytown', AnnualRevenue=10000)); 
        }
        
        insert subAccounts;
    
         system.debug('*****SubAccounts'+subAccounts.size());     
               
        for (Integer x=0;x<subAccounts.size();x++){
                subAccounts.get(x).parentID = parentID;
                parentID=subAccounts.get(x).Id; 
              }
        
        update subAccounts;
        
        subTreeParent = [Select id, parentID, name from account where name = 'HierarchyTest4'];
        parentID=subTreeParent.Id;

        for (Integer y=0;y<10;y++){
            subAccountsSideTree.add(new Account(name=accountName+'4.'+y, ShippingStreet='1 Main St.', ShippingState='VA', ShippingPostalCode='12345', ShippingCountry='USA', ShippingCity='Anytown', Description='This is a test account', BillingStreet='1 Main St.', BillingState='VA', BillingPostalCode='12345', BillingCountry='USA', BillingCity='Anytown', AnnualRevenue=10000));    
        }

        insert subAccountsSideTree;
  
        System.debug('****subAccountsSideTree'+subAccountsSideTree.size());    
   
    /*subAccountsList = [Select id, parentID, name from account where name like 'HierarchyTest4%'];

        for (Integer z=1;z<subAccountsList.size();z++){
            subAccountsList[z].parentID = parentID;
            parentID=accountList[z].Id; 
        }*/
      for (Integer z=1;z<subAccountsSideTree.size();z++){
            subAccountsSideTree.get(z).parentID = parentID;
            parentID=subAccountsSideTree.get(z).Id; 
       }
      
      update subAccountsList;
        
    }


}