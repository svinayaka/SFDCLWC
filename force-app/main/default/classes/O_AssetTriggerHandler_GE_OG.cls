/*
Class/Trigger Name  :   O_AssetTriggerHandler_GE_OG 
Purpose/Overview    :   Used to call O_AssetHelper_GE_OG
Scrum Team          :   OPPTY MGMT
Requirement Number  : 
Author              :   Rupal Seth
Created Date        :   27/MAR/2018
Test Class Name     :   
Code Coverage       : 
*/
public class O_AssetTriggerHandler_GE_OG {
    public void after_Insert_Functionality(List<Asset> newlstAsset, map<id, Asset> newMapAsset)
      {          
        List<Asset> OGAssets = new List<Asset>();
          // Only process Assets of type Deal machine asset Record type
          for(Asset ast : newlstAsset){
              if(ast.recordtypeid == Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Deal Machine Asset').getRecordTypeId()){
                  OGAssets.add(ast);
              }
          }
          if(OGAssets.size()>0){
              O_AssetHelper_GE_OG.AddAssetOwnerToAssetTeam(OGAssets, 'Insert', null);           
          }
       
       }
    
    public void after_Update_Functionality(List<Asset> newlstast, map<id, Asset> newMapast, List<Asset> oldlstast, map<Id, Asset> oldMapast){
        
        List<Asset> OGAssets = new List<Asset>();
        for(Asset ast : newlstast){
            if(ast.recordtypeid == Schema.SObjectType.Asset.getRecordTypeInfosByName().get('Deal Machine Asset').getRecordTypeId()
               && ast.ownerId != oldMapast.get(ast.Id).ownerId){
                   OGAssets.add(ast);
               }
        }
        if(OGAssets.size()>0){
            O_AssetHelper_GE_OG.AddAssetOwnerToAssetTeam(OGAssets,'Update', oldMapast);            
        }
        
    }
    
}