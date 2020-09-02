public class eRAD_Custom_Report_Cntrl {
    public Id eradid{get;set;}
    public string reporttitle{get;set;}
    public List<erad__c> erAdlist{get;set;}
    public List<decimal> capexlist{get;set;}
    public List<decimal> opexlist{get;set;}
    public List<decimal> commerlist{get;set;}
    public List<decimal> refelist{get;set;}
    public List<decimal> relalist{get;set;}
    public List<decimal> techlist{get;set;}
    public List<competitor__c> comlis{get;set;}
    public String opptyscore{get;set;}
    public String GEOG{get;set;}
    public string capexweight{get;set;}
    public string opexweight{get;set;}
    public string commweight{get;set;}
    public string refweight{get;set;}
    public string relweight{get;set;}
    public string techweight{get;set;}
    private String[] sFields = new String[] {'data1', 'data2', 'data3','data4','data5'};
    public String fields {
        get {
            return String.join(sFields, ',');
        }
    }
    public eRAD_Custom_Report_Cntrl(ApexPages.StandardController controller) {
        erad__c eradobj = (erad__C)controller.getRecord();
        
        eradid = eradobj.id;
        sFields = new List<String>();
        if(eradid != null){
            ApexPages.StandardController stdcontroller = new ApexPages.StandardController(eradobj);
            RAD_Evaluation_Cntrl radeva = new RAD_Evaluation_Cntrl(stdcontroller);
            erAdlist= radeva.eradQuery(eradid);
        }
        GEOG = 'GE O&G';
        capexweight = erAdlist[0].Capex_Category_weight__c.replace('%','');
        opexweight = erAdlist[0].Opex_Category_weight__c.replace('%','');
        commweight = erAdlist[0].Commercial_Category_weight__c.replace('%','');
        refweight = erAdlist[0].Reference_Category_weight__c.replace('%','');
        relweight = erAdlist[0].Relation_Category_weight__c.replace('%','');
        techweight = erAdlist[0].Technical_Category_weight__c.replace('%','');
        comlis = new List<competitor__c>();
        reporttitle ='GE O&G,';
        for(eRAD__c erad : erAdlist){
            for(Competitor__c con : erad.Competitors__r){
                reporttitle = reporttitle+con.Competitor__c+',';
                comlis.add(con);
            }
        }
        for(integer i =0;i<erAdlist[0].Competitors__r.size();i++)
            sFields.add('data'+i);
    }
    public List<Data> getData() {
        return getChartData();
    }
    
    public List<Data> getChartData() {
        decimal capex,capex1;
        List<Data> data = new List<Data>();
        capexlist = new List<decimal>();
        opexlist = new List<decimal>();
        commerlist = new List<decimal>();
        refelist = new List<decimal>();
        relalist = new List<decimal>();
        techlist = new List<decimal>();
        for(Competitor__c c : comlis){
            if(c.Capex_Score__c != null)
                capexlist.add(decimal.valueOf(c.Capex_Score__c));
            else
                capexlist.add(0.0);
            if(c.Opex_Score__c != null)
                opexlist.add(decimal.valueOf(c.Opex_Score__c));
            else
                opexlist.add(0.0);
            if(c.Commercial_Score__c != null)
                commerlist.add(decimal.valueOf(c.Commercial_Score__c));
            else
                commerlist.add(0.0);
            if(c.References_Score__c != null)
                refelist.add(decimal.valueOf(c.References_Score__c));
            else
                refelist.add(0.0);
            if(c.Relations_Score__c != null)
                relalist.add(decimal.valueOf(c.Relations_Score__c));
            else
                relalist.add(0.0);
            if(c.Technical_Score__c!= null)
                techlist.add(decimal.valueOf(c.Technical_Score__c));
            else
                techlist.add(0.0);
        }
        if(erAdlist[0].Capex_Score__c != null)
            data.add(new Data('Capex'+'\n\r'+erAdlist[0].Capex_Category_weight__c,decimal.valueOf(erAdlist[0].Capex_Score__c),capexlist));
        else
            data.add(new Data('Capex'+'\n\r'+erAdlist[0].Capex_Category_weight__c,0.0,capexlist));
            
        if(erAdlist[0].Opex_Score__c!=null)
            data.add(new Data('Opex'+'\n\r'+erAdlist[0].Opex_Category_weight__c,decimal.valueOf(erAdlist[0].Opex_Score__c),opexlist));
        else
            data.add(new Data('Opex'+'\n\r'+erAdlist[0].Opex_Category_weight__c,0.0,opexlist));
            
        if(erAdlist[0].Commercial_Score__c!=null)
            data.add(new Data('Commercial'+'\n\r'+erAdlist[0].Commercial_Category_weight__c,decimal.valueOf(erAdlist[0].Commercial_Score__c),commerlist));
        else
            data.add(new Data('Commercial'+'\n\r'+erAdlist[0].Commercial_Category_weight__c,0.0,commerlist));
            
        if(erAdlist[0].References_Score__c!=null)
            data.add(new Data('References'+'\n\r'+erAdlist[0].Reference_Category_Weight__c,decimal.valueOf(erAdlist[0].References_Score__c),refelist));
        else
            data.add(new Data('References'+'\n\r'+erAdlist[0].Reference_Category_Weight__c,0.0,refelist));
            
        if(erAdlist[0].Relations_Score__c!=null)
            data.add(new Data('Relations'+'\n\r'+erAdlist[0].Relation_Category_Weight__c,decimal.valueOf(erAdlist[0].Relations_Score__c),relalist));
        else
            data.add(new Data('Relations'+'\n\r'+erAdlist[0].Relation_Category_Weight__c,0.0,relalist));
            
        if(erAdlist[0].Technical_Score__c!=null)
            data.add(new Data('Technical'+'\n\r'+erAdlist[0].Technical_Category_weight__c,decimal.valueOf(erAdlist[0].Technical_Score__c),techlist));
        else
            data.add(new Data('Technical'+'\n\r'+erAdlist[0].Technical_Category_weight__c,0.0,techlist));
            
        return data;
    }
    
    // Wrapper class
    public class Data{
        public String name {get;set;}
        public decimal score {get;set;}
        public decimal data0 {get;set;}
        public decimal data1 {get;set;}
        public decimal data2 {get;set;}
        public decimal data3 {get;set;}
        public decimal data4 {get;set;}
        public decimal data5 {get;set;}
        public decimal data6 {get;set;}
        public decimal data7 {get;set;}
        public decimal data8 {get;set;}
        public decimal data9 {get;set;}
        public decimal data10 {get;set;}
        list<decimal> totaldata{get;set;} 
       
        map<integer,decimal> datamap= new map<integer,decimal>();
       
        public Data(String name,decimal score,list<decimal> totdata) {
      
            for(integer i=0;i<totdata.size();i++){
                datamap.put(i,totdata[i]);
            }
         
            this.name = name;
            this.score= score;
           
            if(datamap.containskey(0))
            this.data0 = datamap.get(0);
            
            if(datamap.containskey(1))
            this.data1 = datamap.get(1);
            
            if(datamap.containskey(2))
            this.data2 = datamap.get(2);
            
            if(datamap.containskey(3))
            this.data3 = datamap.get(3);
            
            if(datamap.containskey(4))
            this.data4 = datamap.get(4);
            
            if(datamap.containskey(5))
            this.data5 = datamap.get(5);
            
            if(datamap.containskey(6))
            this.data6 = datamap.get(6);
            
            if(datamap.containskey(7))
            this.data7 = datamap.get(7);
            
            if(datamap.containskey(8))
            this.data8 = datamap.get(8);
            
            if(datamap.containskey(9))
            this.data9 = datamap.get(9);
            
            if(datamap.containskey(10))
            this.data10 = datamap.get(10);
          
        }
         
    }
}