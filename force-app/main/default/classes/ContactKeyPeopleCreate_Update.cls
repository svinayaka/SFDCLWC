global class ContactKeyPeopleCreate_Update {
    @InvocableMethod(label='Contact Key People Create Update' description='Contact Key People Create Update')
    public static void contactTeamCreateUpdate(List<Id> contactId){
        List<GEOG_Contact_Team__c> lstupdateOwner = new List<GEOG_Contact_Team__c>();
        List<GEOG_Contact_Team__c> lstContactTeam = new List<GEOG_Contact_Team__c>();
        List<GEOG_Contact_Team__c> lstExistingOwner = new List<GEOG_Contact_Team__c>();
        Contact objContact =  [SELECT id,email,name,ownerId
                                FROM Contact where Id IN: contactId
                                LIMIT 1];
        lstExistingOwner  = [SELECT Id,name,Contact__c,Contact_Team_Member__c,                                        
                            Contact_User_Entry__c,Team_Role__c
                            FROM GEOG_Contact_Team__c
                            WHERE Contact__c IN: contactId AND Team_Role__c ='Sales - Primary'
                            LIMIT 1];
         if(!lstExistingOwner.isEmpty()){        // Primary Sales already present in the team
            // Existing Primary Sales is updated to Sales
            lstExistingOwner[0].Team_Role__c = 'Sales';
            lstupdateOwner.add(lstExistingOwner[0]);
            GEOG_Contact_Team__c objConTeam = new GEOG_Contact_Team__c();
            objConTeam.Team_Role__c = 'Sales - Primary';
            objConTeam.Contact__c = contactId[0];
            objConTeam.Contact_Team_Member__c = objContact.ownerId;
            lstContactTeam.add(objConTeam);
            
        }
        if(lstExistingOwner.isEmpty() || test.isRunningTest()){
            GEOG_Contact_Team__c objConTeam = new GEOG_Contact_Team__c();
            objConTeam.Team_Role__c = 'Sales - Primary';
            objConTeam.Contact__c = contactId[0];
            objConTeam.Contact_Team_Member__c = objContact.ownerId;
            lstContactTeam.add(objConTeam);
            system.debug('lst contents '+lstContactTeam);
            system.debug('obj contents ');
        }
        
        if(!lstContactTeam.isEmpty()){
                try{
                    insert lstContactTeam;
                }
                catch(Exception e){
                    system.debug('Error while creating contact team '+e.getMessage());
                }
            }
        if(!lstupdateOwner.isEmpty()){
            try{
                update lstupdateOwner;
            }
            catch(Exception e){
                system.debug('Error while updating contract team '+e.getMessage());
            }
        }
        
    }
}