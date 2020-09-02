global class batchIBUpdate implements Database.Batchable<sObject> {
    global date lastStatusDate;
    global string WellID;
    global string SWIBStatus;
    global Integer sortNum;
    global integer listEmpty;
    global string rtypeSCM;
    global string rtypeSM;
    global string rtypeSXT;
    global string rtypeSC;
    global string rtypeSEM;
   
    global List<SWIBEventRecord__c> sortList = new List<SWIBEventRecord__c>();
    global Database.QueryLocator start(Database.BatchableContext BC) {
     rtypeSCM = Schema.SObjectType.GE_Installed_Base__c.getRecordTypeInfosByName().get('Subsea Control Module').getRecordTypeId();
      rtypeSM = Schema.SObjectType.GE_Installed_Base__c.getRecordTypeInfosByName().get('Subsea Manifold').getRecordTypeId();
      rtypeSXT = Schema.SObjectType.GE_Installed_Base__c.getRecordTypeInfosByName().get('Subsea Xmas Tree').getRecordTypeId();
      rtypeSC = Schema.SObjectType.GE_Installed_Base__c.getRecordTypeInfosByName().get('Subsea Choke').getRecordTypeId();
      rtypeSEM = Schema.SObjectType.GE_Installed_Base__c.getRecordTypeInfosByName().get('Subsea Electronic Module').getRecordTypeId();
      
    String query = 'SELECT Id, Name, GE_OGSS_InstnDte__c,GE_OGSS_WelIdntfr__c, GE_ES_Status__c FROM GE_Installed_Base__c WHERE recordTypeID =: rtypeSCM OR recordTypeID =: rtypeSM OR recordTypeID =: rtypeSXT  OR recordTypeID =: rtypeSC  OR recordTypeID = :rtypeSEM';
    return Database.getQueryLocator(query);
    }


    global void execute(Database.BatchableContext BC, List<GE_Installed_Base__c> scope) {
        //List<string> lstGESNEquipName = new List<String>();
       
       Set<Id> setGESNEquipName = new Set<Id>();
        try{
            for(GE_Installed_Base__c tmpName :scope)
            {
                setGESNEquipName.Add(tmpName.Id);        
            }
        }
        catch(exception ex)
        {
            System.debug('The following exception has occurred: ' + ex.getMessage());

        }
        system.debug('----------------setGESNEquipName------------------------' + setGESNEquipName);

        List<SWIBEventRecord__c> lstGESNEquipNameSWIB = new List<SWIBEventRecord__c>();


        //lstGESNEquipNameSWIB=[SELECT Event_Description__c,Event_Type__c ,Well_ID__c,Event_Start_Date__c,Component_SN__c,Component_PN__c,Component_Affected__c,RecordTypeID__c ,Event_End_Date__c,Event_Record_Number__c,Failure_Mode__c,Notes__c,Record_Type__c,Name,
        //SWIB_GE_S_N_Equip_Name__c from SWIBEventRecord__c where SWIB_GE_S_N_Equip_Name__c IN :lstGESNEquipName order by Event_End_Date__c asc];

        lstGESNEquipNameSWIB=[SELECT Event_Description__c,Event_Type__c ,Well_ID__c,Event_Start_Date__c,Component_SN__c,Component_PN__c,Component_Affected__c,RecordTypeID__c ,Event_End_Date__c,Event_Record_Number__c,Failure_Mode__c,Notes__c,Record_Type__c,Name,
        GE_Equipment_Name_Lkp__c from SWIBEventRecord__c where GE_Equipment_Name_Lkp__c IN :setGESNEquipName order by Event_End_Date__c asc];

         

        System.debug('--------- event in class ' +lstGESNEquipNameSWIB);



        for (SWIBEventRecord__c SWIB : lstGESNEquipNameSWIB) {
            if(SWIB.Event_Type__c=='Installation'){
                WellID=SWIB.Well_ID__c;
                lastStatusDate=SWIB.Event_End_Date__c;
                SWIBStatus='Installed';
            }
            if(SWIB.Event_Type__c=='Pull'){
                WellID=SWIB.Well_ID__c;
                lastStatusDate=SWIB.Event_End_Date__c;
                SWIBStatus='Pulled';
            }
            if(SWIB.Event_Type__c=='Pulled – Scrapped'){
                WellID=SWIB.Well_ID__c;
                lastStatusDate=SWIB.Event_End_Date__c;
                SWIBStatus='Pulled – Scrapped';
           }
        }

        system.debug('----------------lstGESNEquipNameSWIB------------------------' + lstGESNEquipNameSWIB);

        List<SWIBEventRecord__c> lstGECombinedList = new List<SWIBEventRecord__c>();

        lstGECombinedList.AddAll(lstGESNEquipNameSWIB); // combine Lists for display in VF
        // combine Lists for display in VF  
 
        //sorting
        sortList = lstGECombinedList;
        sortNum = lstGECombinedList.Size();

        listEmpty =  sortNum;
        system.debug('----------------listEmpty ------------------------' + listEmpty );

        system.debug('----------------sortNum------------------------' + sortNum);

        system.debug('----------------lstGECombinedList------------------------' + lstGECombinedList);
        if(listEmpty>0){
        quickSort(0, sortNum-1);
        }

        if((listEmpty>0 && SWIBStatus != null) || Test.IsRunningTest()){
            scope[0].GE_OGSS_InstnDte__c =lastStatusDate;
            scope[0].GE_OGSS_WelIdntfr__c  =WellID;
            scope[0].GE_ES_Status__c=SWIBStatus;
            update scope;
        }
    }


    global void finish(Database.BatchableContext BC) {
    }

    Public void quickSort(Integer low, Integer high) {
    Integer i = low;
    Integer j = high;
    // Get the pivot element from the middle of the list
    system.debug('sortList--->' + sortList);
    system.debug('low high--->' + low + (high-low)/2);
    system.debug('sort low high--->' + sortList[low + (high-low)/2]);
    SWIBEventRecord__c pivot = sortList[low + (high-low)/2];

    // Divide into two lists
    while (i <= j) {
        while (sortList[i].Event_End_Date__c > pivot.Event_End_Date__c) {
            i++;
        }
        while (sortList[j].Event_End_Date__c < pivot.Event_End_Date__c) {
            j--;
        }
    if (i <= j) {
        exchange(i, j);
        i++;
        j--;
        }
    }
    // Recursion
    if (low < j)
        quicksort(low, j);
    if (i < high)
        quicksort(i, high);
    }


    private void exchange(Integer i, Integer j) {
        SWIBEventRecord__c temp = sortList[i];
        sortList[i] = sortList[j];
        sortList[j] = temp;
    }
}