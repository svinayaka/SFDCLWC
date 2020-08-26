trigger GE_ES_AverageLife on GE_ES_ITO_Component__c (before insert,before update) {

    Set<ID> CompID = new Set<ID>();
    Set<ID> IBID = new Set<ID>();
    public GE_ES_Filter_Life_Rule__c FLR = new  GE_ES_Filter_Life_Rule__c();
    public GE_ES_GT_Filter_Life_Rule__c GFLR = new  GE_ES_GT_Filter_Life_Rule__c();
    public GE_Installed_Base__c IB = new  GE_Installed_Base__c();
    Map<Id,GE_ES_ITO_Component__c> compRec = new Map<Id,GE_ES_ITO_Component__c>();
    GE_ES_ITO_Component__c cmp = new GE_ES_ITO_Component__c();

//Query Component Record type 
    List<RecordType> CRecType= [Select Name, Id From RecordType where sObjectType='GE_ES_ITO_Component__c'];  
    Map<String,String> componentRecordTypes = new Map<String,String>{}; 
    for(RecordType rt: CRecType)   
    componentRecordTypes.put(rt.Name,rt.Id);
    System.debug('************componentRecordTypes************************'+componentRecordTypes);


    for(GE_ES_ITO_Component__c comp:Trigger.New) {
    //if((comp.GE_ES_Equipment_Record_Type__c=='Baghouse')&&((comp.RecordTypeId==componentRecordTypes.get('Filter'))||(comp.RecordTypeId==componentRecordTypes.get('GT-Filters'))))
    //CompID.add(comp.id);
    //if(((comp.GE_ES_Equipment_Record_Type__c=='Baghouse')&&(comp.RecordTypeId==componentRecordTypes.get('Filter')))||((comp.GE_ES_Equipment_Record_Type__c=='Intake System')&&(comp.RecordTypeId==componentRecordTypes.get('GT-Filters'))))
    if((((comp.GE_ES_Equipment_Record_Type__c=='Baghouse')||(comp.GE_ES_Equipment_Record_Type__c=='Cartridge Collector'))&&(comp.RecordTypeId==componentRecordTypes.get('Filter')))||((comp.GE_ES_Equipment_Record_Type__c=='Intake System')&&(comp.RecordTypeId==componentRecordTypes.get('GT-Filters'))))
    compRec.put(comp.id,comp);
    System.debug('************compRec************************'+compRec);
    cmp = compRec.get(comp.id);
    System.debug('************cmp************************'+cmp);
    
}

    try{
    IB = [select id,GE_ES_Application__c,GE_ES_Cleaning_Type__c from GE_Installed_Base__c where id =:cmp.GE_ES_Equipment_Name__c];
    System.debug('************IB.GE_ES_Application__c************************'+IB.GE_ES_Application__c+'---------->'+'************IB.GE_ES_Cleaning_Type__c*************'+IB.GE_ES_Cleaning_Type__c );
    
    System.debug('************compRec ************************'+compRec); 

}
    catch(Exception e)
    {
    e.getMessage();
}

try{
        try{
            FLR = [select id,GE_ES_Average_Life__c from GE_ES_Filter_Life_Rule__c where ((GE_ES_Application__c =:IB.GE_ES_Application__c)AND(GE_ES_Cleaning_Type__c =:IB.GE_ES_Cleaning_Type__c)AND(GE_ES_Filter_Type__c =:cmp.GE_ES_Filter_Type__c)AND(GE_ES_Raw_Materal__c =:cmp.GE_ES_Raw_Material__c))];
            System.debug('************FLR ************************'+FLR );
            }
            catch(Exception e)
            {e.getMessage();}
            
        try{
            
            GFLR = [select id,GE_ES_Average_Life__c from GE_ES_GT_Filter_Life_Rule__c where (GE_ES_Filtration_Stage__c =:cmp.GE_ES_Filtration_Stage__c AND GE_ES_Installed_Type__c =:cmp.GE_ES_Installed_Type__c)]; 
            System.debug('************GFLR ************************'+GFLR );
            }
            catch(Exception e)
            {e.getMessage();}
    }
catch(Exception e)
  {
   e.getMessage();
  }


for(GE_ES_ITO_Component__c CR:Trigger.New ){

{
  //if(((CR.RecordTypeId==componentRecordTypes.get('Filter'))||(CR.RecordTypeId==componentRecordTypes.get('GT-Filters'))) && (CR.GE_ES_Equipment_Record_Type__c=='Baghouse')){
  //if(((CR.GE_ES_Equipment_Record_Type__c=='Baghouse')&&(CR.RecordTypeId==componentRecordTypes.get('Filter')))||((CR.GE_ES_Equipment_Record_Type__c=='Intake System')&&(CR.RecordTypeId==componentRecordTypes.get('GT-Filters')))){
   if((((CR.GE_ES_Equipment_Record_Type__c=='Baghouse')||(CR.GE_ES_Equipment_Record_Type__c=='Cartridge Collector'))&&(CR.RecordTypeId==componentRecordTypes.get('Filter')))||((CR.GE_ES_Equipment_Record_Type__c=='Intake System')&&(CR.RecordTypeId==componentRecordTypes.get('GT-Filters')))){
    if(FLR.GE_ES_Average_Life__c!=Null && GFLR.GE_ES_Average_Life__c==Null)
    {
        CR.GE_ES_Average_Filter_Life_Months__c=FLR.GE_ES_Average_Life__c;
        System.debug('******FLR******GE_ES_Average_Filter_Life_Months__c*********************'+CR.GE_ES_Average_Filter_Life_Months__c);

    }
    else if(FLR.GE_ES_Average_Life__c==Null && GFLR.GE_ES_Average_Life__c!=Null)

    {
        CR.GE_ES_Average_Filter_Life_Months__c=GFLR.GE_ES_Average_Life__c;
        System.debug('******GFLR******GE_ES_Average_Filter_Life_Months__c*********************'+CR.GE_ES_Average_Filter_Life_Months__c);

      }
      else
      {
      CR.GE_ES_Average_Filter_Life_Months__c=12;
      System.debug('************Default*********************'+CR.GE_ES_Average_Filter_Life_Months__c);

      }
    }
}
}
}