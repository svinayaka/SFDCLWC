public class GE_OG_KYCTraining {
    
    public string title {get; set;}
    public Id conId ;
    public ContentVersion content;
    public List<ContentVersion> contentList{get;set;}
    public boolean numcheck{get; set;}
    
   
public pageReference ContentVersion()  {

List<ContentVersion> content = new List<ContentVersion>([select Id,Title from ContentVersion where Title = 'KYC Training & Change Management']);
   
     //system.debug('----------------content---------------'+content[0]);
     //system.debug('----------------content---------------'+content[1]);
     PageReference contentPage;
    if(content.size()>0)
    {
         contentPage= new ApexPages.StandardController(content[0]).view();
        contentPage.setRedirect(true);
       
    }
    else
    {
        contentPage=null;
    }
     return contentPage;
 }

}