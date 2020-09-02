public class WebFormMobileSiteController {

   // public String submitCase { get; set; }
    
   // public Case c { get; set; }
    
   // public String acctNum { get; set; }
    
    public WebFormMobileSiteController () {
      // c = new Case();
    }
    
  //  public PageReference submitCase() {
  //  insert c;
    //  PageReference pg= new PageReference('/apex/POC_ThankYouPage');
  //  pg.setRedirect(true);
  //  return pg;
  //  }
    public PageReference CloseCase() {
   // insert c;
      PageReference pg= new PageReference('http://www.salesforce.com');
    pg.setRedirect(true);
    return pg;
    }
    public PageReference CreateNewCase() {
   // insert c;
      PageReference pg= new PageReference('/apex/CIRMobileWebForm');
    pg.setRedirect(true);
    return pg;
    }
    }