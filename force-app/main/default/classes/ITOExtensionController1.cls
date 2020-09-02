public class ITOExtensionController1 {
 public final ITO_Commercial__c ITOCom;  
public ITOExtensionController1(ApexPages.StandardController stdController) {
        this.ITOCom = (ITO_Commercial__c)stdController.getRecord();
        }
       public id did = ApexPages.currentPage().getParameters().get('id');
      
   public blob attchment;
public string filename1;
 public Attachment document1 {
    get {
      if (document1 == null)
        document1 = new Attachment();
        document1.name = 'US Government Risk Checklist';
     
      return document1;
    }
    set ;}
    public Attachment document2 {
    get {
      if (document2 == null)
        document2 = new Attachment();
        document2.name = 'Audit Rights Language Document';
     
      return document2;
    }
    set ;}
    public Attachment document3 {
    get {
      if (document3 == null)
        document3 = new Attachment();
        document3.name = 'Revenue Recognition Tool output document';
     
      return document3;
    }
    set ;}
    public Attachment document4 {
    get {
      if (document4 == null)
        document4 = new Attachment();
        document4.name = 'Contract Billing or Milestone Schedule';
     
      return document4;
    }
    set ;
   
  }   
  public Attachment document5 {
    get {
      if (document5 == null)
        document5 = new Attachment();
        document5.name = 'Non-Standard Language Document for 1st source of Financial Security';
     
      return document5;
    }
    set ;
   
  }
  public Attachment document6 {
    get {
      if (document6 == null)
        document6 = new Attachment();
        document6.name = 'Non-Standard Language Document for 2nd source of Financial Security';
     
      return document6;
    }
    set ;
   
  }
  public Attachment document7 {
    get {
      if (document7 == null)
        document7 = new Attachment();
        document7.name = 'Non-Standard Language Document for 3rd source of Financial Security';
     
      return document7;
    }
    set ;
   
  }
  public Attachment document8 {
    get {
      if (document8 == null)
        document8 = new Attachment();
        document8.name = 'Non-Standard Language Document for 4th source of Financial Security';
     
      return document8;
    }
    set ;
   
  }
  public Attachment document9 {
    get {
      if (document9 == null)
        document9 = new Attachment();
        document9.name = 'eTax Output Document';
     
      return document9;
    }
    set ;
   
  }  
  public pagereference submit(){
      done();
      if(ITOCom.id!=null){PageReference acctPage = new pagereference('/'+ITOCom.id);
           return acctPage;
      } else      return null;
  }
   public PageReference done() {
    id did = ApexPages.currentPage().getParameters().get('id');
    document1.parentId = did;
    document2.parentId = did;
    document3.parentId = did;
    document4.parentId = did;
    document5.parentId = did;
    document6.parentId = did;
    document7.parentId = did;
    document8.parentId = did;
    document9.parentId = did;
    if(document1.body!=null){
    insert document1;}
    if(document2.body!=null){
    insert document2;}
    if(document3.body!=null){
    insert document3;}
    if(document4.body!=null){
    insert document4;}
    if(document5.body!=null){
    insert document5;}
    if(document6.body!=null){
    insert document6;}
    if(document7.body!=null){
    insert document7;}
    if(document8.body!=null){
    insert document8;}
    if(document9.body!=null){
    insert document9;}
    pagereference currpage = new pagereference('/'+did + '/e');
       // return null;
       return currpage;
    }
    }