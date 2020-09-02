public class SWIBcontroller1{

public List<SWIBEventRecord__c> sortList;
public Integer sortNum;
public List<string> lstGESNEquipName {get;set;}
Public Boolean displayMessage{get;set;}
public string subjectInput{get;set;}

public string mode{ get; set; }
public integer listEmpty{ get; set; }
public date lastStatusDate{get;set;}
public string WellID{get;set;}
public string SWIBStatus{get;set;}
public boolean isSWIBPermissionExist{get;set;}     
Public List<PermissionSetAssignment> ServicePermissionAssigned{get; set;}    
Public List<SWIBEventRecord__c> lstGECombinedList {get;set;}
public List<SWIBEventRecord__c> lstGESNEquipNameSWIB {get;set;}
public List<GE_Installed_Base__c> lstIB {get;set;} 
public SWIBcontroller1(ApexPages.StandardController controller) {
    List<GE_Installed_Base__c> lstIB = [SELECT Name FROM GE_Installed_Base__c  WHERE ID = :ApexPages.currentPage().getParameters().get('id')];
    lstGESNEquipName = new List<string>();
    try{
    for(GE_Installed_Base__c tmpName :lstIB )
        {
            lstGESNEquipName.Add(tmpName.Name);        
        }
  }
  catch(exception ex)
  {
     System.debug('The following exception has occurred: ' + ex.getMessage());

  }
  system.debug('----------------lstGESNEquipName------------------------' + lstGESNEquipName);
 
  List<SWIBEventRecord__c> lstGESNEquipNameSWIB = new List<SWIBEventRecord__c>();
  
  
 lstGESNEquipNameSWIB=[SELECT Event_Description__c,Event_Type__c ,Well_ID__c,Event_Start_Date__c,Component_SN__c,Component_PN__c,Component_Affected__c,RecordTypeID__c ,Event_End_Date__c,Event_Record_Number__c,Failure_Mode__c,Notes__c,Record_Type__c,Name,SWIB_GE_S_N_Equip_Name__c from SWIBEventRecord__c where SWIB_GE_S_N_Equip_Name__c IN :lstGESNEquipName order by Event_End_Date__c asc];
 

 this.lstGESNEquipNameSWIB = lstGESNEquipNameSWIB;
 
   System.debug('--------- event in class ' +lstGESNEquipNameSWIB);
   
   
   
for (SWIBEventRecord__c SWIB : lstGESNEquipNameSWIB) {
   
          //  lastStatusDate=SWIB.Event_End_Date__c;
    
           //if(SWIB.Event_Type__c=='Installation' && SWIB.Well_ID__c!=null)
           if(SWIB.Event_Type__c=='Installation' ){
           WellID=SWIB.Well_ID__c;
           lastStatusDate=SWIB.Event_End_Date__c;
           SWIBStatus='Installed';
           }
           
            if(SWIB.Event_Type__c=='Pull' ){
           WellID=SWIB.Well_ID__c;
           lastStatusDate=SWIB.Event_End_Date__c;
           SWIBStatus='Pulled';
           } 
           
             if(SWIB.Event_Type__c=='Pulled – Scrapped'){
           WellID=SWIB.Well_ID__c;
           lastStatusDate=SWIB.Event_End_Date__c;
           SWIBStatus='Pulled – Scrapped';
           }
           
          /* if((SWIB.Event_Record_Number__c!=null)&&(SWIB.Event_Record_Number__c.length()<11)){
           subjectInput=  SWIB.Event_Record_Number__c;
           
           
           system.debug('----------------subjectInput------------------------' + subjectInput);
             }
             else if(SWIB.Event_Record_Number__c!=null)
             {
           subjectInput = SWIB.Event_Record_Number__c.substring(0,11);  
          
          system.debug('----------------subjectInput------------------------' + subjectInput);     
                   
}*/
           
}
 
  system.debug('----------------lstGESNEquipNameSWIB------------------------' + lstGESNEquipNameSWIB);
  
  List<SWIBEventRecord__c> lstGECombinedList = new List<SWIBEventRecord__c>();
  
  lstGECombinedList.AddAll(lstGESNEquipNameSWIB); // combine Lists for display in VF
  // combine Lists for display in VF  
  
  this.lstGECombinedList = lstGECombinedList; // Final combined List

  
 

  //sorting
  this.sortList = lstGECombinedList;
  this.sortNum = lstGECombinedList.Size();
  
  listEmpty =  this.sortNum;
    system.debug('----------------listEmpty ------------------------' + listEmpty );
    
  system.debug('----------------sortNum------------------------' + sortNum);
  
    system.debug('----------------lstGECombinedList------------------------' + lstGECombinedList);
  if(listEmpty>0){
  quickSort(0, sortNum-1);
  }
}
  //lstSWIBreq.AddAll(lstGECombinedList);
 
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

  
 
 

    
    

public PageReference save()
    {
          try{ 
          
           Update lstGECombinedList;
           
           } 
           
           catch (Exception ex) {System.debug('ERROR:' + ex);

ApexPages.addMessage(New ApexPages.Message(ApexPages.Severity.FATAL, 'Duplicate entry for this SWIB Event'));        }
          PageReference pageRef = new PageReference('/apex/SWIBReqPage_IB?id='+ ApexPages.currentPage().getParameters().get('Id'));
          //PageReference pageRef = new PageReference('https://cs9.salesforce.com/' + ApexPages.currentPage().getParameters().get('Id'));
          return pageRef;
        }
        
        
   public void IBupdate()
  {
   if((listEmpty>0 && SWIBStatus != null) ||Test.isRunningTest()){
   GE_Installed_Base__c IBUpdate = new  GE_Installed_Base__c();
   IBUpdate =[SELECT Name,GE_OGSS_InstnDte__c,GE_OGSS_WelIdntfr__c  FROM GE_Installed_Base__c  WHERE ID = :ApexPages.currentPage().getParameters().get('id')];
   IBUpdate.GE_OGSS_InstnDte__c =lastStatusDate;
   IBUpdate.GE_OGSS_WelIdntfr__c  =WellID;
   IBUpdate.GE_ES_Status__c=SWIBStatus;
   update IBUpdate;}
}

public void modeSet()
{

         String Userid = UserInfo.getUserId();
        ServicePermissionAssigned = new  List<PermissionSetAssignment>([SELECT AssigneeId, PermissionSet.Name FROM PermissionSetAssignment WHERE PermissionSet.Name= 'C_SWIB_Edit' AND AssigneeId =: Userid Limit 1]);           
       
       System.debug('====ServiceProfilePermissionSet==='+ServicePermissionAssigned ); 
       if(ServicePermissionAssigned!=null && ServicePermissionAssigned.size()>0){
            isSWIBPermissionExist = true;
        }
        else{
            isSWIBPermissionExist = false;
        } 
       // Profile profileRec=[SELECT Name FROM Profile WHERE Id=:UserInfo.getProfileId()];
      //  User profileRec=[SELECT Name FROM User WHERE Id=:UserInfo.getUserId()];
       if(sortNum > 0){
       if(isSWIBPermissionExist == true)
     // if(profileRec.Name=='Nirmala Bhat'|| profileRec.Name=='Katarzyna Osowska'|| profileRec.Name=='Jaroslaw Ziarek'|| profileRec.Name=='Akanksha Singh'|| profileRec.Name=='OGKYC DTS Sales')    
     //  if(profileRec.Name=='System Administrator'|| profileRec.Name=='OG_Sales/Comm Ops'||profileRec.Name=='OG_Read Only'|| profileRec.Name=='GE_OG_SS Com Ops'|| profileRec.Name=='GE_Business Intelligence' || profileRec.Name=='GE_ES Developer')
       {

            mode='edit';

        }

        else 

        {
            mode='readOnly';
        }
     }  else {displayMessage = true;} 
      }
        public PageReference callTwoMethods() {
        
          modeSet();
          IBupdate();
          return null;
}

    
    



 
}