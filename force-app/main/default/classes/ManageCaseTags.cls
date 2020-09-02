public with sharing class ManageCaseTags {

    Case caseRec;
    List<CaseTag> caseTags;
    public Id tagId {get;set;}
    public boolean isEdit{get;set;}
    public boolean manageTags {get;set;}
    public String publicInput {get;set;}
    public String privateInput {get;set;}
    public List<TagWrapper> tagList {get;set;}
    Map<Id, TagWrapper> tagMap;
    
    public ManageCaseTags(ApexPages.StandardController controller) {
        caseRec = (Case)controller.getRecord();
        caseTags = new List<CaseTag>();
        tagList = new List<TagWrapper>();
        tagMap = new Map<Id, TagWrapper>();
        
        for(CaseTag cTag: [SELECT ItemId, Name, Type FROM CaseTag where ItemId = :caseRec.Id]){
            caseTags.add(cTag);
            tagMap.put(cTag.Id, new TagWrapper(cTag.Id, cTag.Name, cTag.Type));
        }
        
        if(caseTags.size() > 0){
            isEdit = true;
            tagList = tagMap.values();
        }
        manageTags = false;
    }
    
    public PageReference DisplayTagBlock(){
        manageTags = true;
        publicInput = '';
        privateInput = '';
        return null;
    }
    
    public PageReference SaveTags(){
        List<CaseTag> newTags = new List<CaseTag>();
        if(publicInput != null && publicInput != ''){
            Set<String> publicInputs = new Set<String>();
            publicInputs.addAll(publicInput.split(','));
            for(String pb: publicInputs){
                newTags.add(new CaseTag(Name=pb, ItemId=caseRec.Id, Type='Public'));
            }
        }
        
        if(privateInput!=null && privateInput!=''){
            Set<String> privateInputs = new Set<String>();
            privateInputs.addAll(privateInput.split(','));
            for(String pb: privateInputs){
                newTags.add(new CaseTag(Name=pb, ItemId=caseRec.Id, Type='Personal'));
            }
        }
        if(newTags.size() > 0){
            try{
                insert newTags;
                for(CaseTag cTag: newTags){
                    tagMap.put(cTag.Id, new TagWrapper(cTag.Id, cTag.Name, cTag.Type));
                }
                tagList = tagMap.values();
            }catch(Exception e){}
        }
        isEdit = true;
        publicInput = '';
        privateInput = '';
        return null;
    }
    
    public PageReference DeleteTag(){
        
        try{
            CaseTag cTag = [Select Id from CaseTag where Id = :tagId];
            delete cTag;
            tagMap.remove(tagId);
            tagList = tagMap.values();
            if(tagList.size() == 0){
                isEdit = false;
            }
        }catch(Exception e){}
        return null;
    }
    
    public class TagWrapper{
        public Id tagId{get;set;}
        public String tagName{get;set;}
        public String tagType{get;set;}
        public TagWrapper(Id tId, String tName, String tType){
            tagId = tId;
            tagName = tName;
            tagType = tType;
        }
    }
}