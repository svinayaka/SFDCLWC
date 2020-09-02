@isTest
Public Class GE_OG_KYCTraining_Test {
    Static TestMethod Void GE_OG_KYCTraining_Test() {
    
    
    List<ContentVersion> lstContentVersion = [select Id,Title from ContentVersion where Title = 'KYC Training & Change Management'];
    if(lstContentVersion != null && lstContentVersion.size() > 0)
    {
        for(ContentVersion objContentVersion : lstContentVersion)
            objContentVersion.Title = 'test';
    }
    update lstContentVersion;
    GE_OG_KYCTraining tr1=new GE_OG_KYCTraining();
    
   ContentVersion content=new ContentVersion();
    content.Title ='KYC Training & Change Management';
    content.ContentURL='http://www.google.com/'; 
    
    insert content;
    
    PageReference contentPage = new ApexPages.StandardController(content).view();
    GE_OG_KYCTraining tr=new GE_OG_KYCTraining();
    tr.title='KYC Training & Change Management';
    tr.numcheck=true;
    PageReference pg = tr.ContentVersion();
    if(pg!=null)
    {
        system.assertequals(string.valueof(pg),string.valueof(contentPage));
    }
    }
    
    Static TestMethod Void GE_OG_KYCTraining_Test1() {
    
    
    List<ContentVersion> lstContentVersion = [select Id,Title from ContentVersion where Title = 'KYC Training & Change Management'];
    if(lstContentVersion != null && lstContentVersion.size() > 0)
    {
        for(ContentVersion objContentVersion : lstContentVersion)
            objContentVersion.Title = 'test';
    }
    update lstContentVersion;
    GE_OG_KYCTraining tr1=new GE_OG_KYCTraining();
   
   ContentVersion content=new ContentVersion();
    content.Title ='KYC Training & Change Management';
    content.ContentURL='http://www.google.com/'; 
    
    insert content;
    list<ContentVersion> lstcv = new list<ContentVersion>();
    lstcv.add(content);
     tr1.contentList = lstcv;
    
    PageReference contentPage = new ApexPages.StandardController(content).view();
    GE_OG_KYCTraining tr=new GE_OG_KYCTraining();
    tr.title='KYC Training & Change Management';
    tr.numcheck=true;
    PageReference pg = tr.ContentVersion();
    if(pg!=null)
    {
        system.assertequals(string.valueof(pg),string.valueof(contentPage));
    }
    }
}