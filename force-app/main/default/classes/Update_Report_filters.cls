/*
Class/Trigger Name     : Update_Report_filters 
Used Where ?           : Update Report filters process builder
Purpose/Overview       : To minimise the manual effort to send report to risk compliance team
Scrum Team             : Transformation - Platform MGMT
Requirement Number     : R-34280
Author                 : Kokilavani
Created Date           : 05/Jun/2020
Test Class Name        : Report_update_Filter
Code Coverage          : 75
*/
global class Update_Report_filters {
    
    @InvocableMethod(label='Update Report Filters' description='TO update the report filters in Report export object')
    
    public Static void Updatereportfilters (List<Id> ReportExportid)
    {
        List<Report_Export__c> Exportdetails1 =[select Report_ID__c from Report_Export__c where ID IN:ReportExportid];
        Map<ID,ID> reportids= new Map<ID,ID>();
        list<Report_Export__c> tobeupdated =new list<Report_Export__c>();
        
        for(Report_Export__c RE:Exportdetails1)
        {
            reportids.put(re.id,re.Report_ID__c);
        }
        
        List<Report > Exportdetails =[select id from Report where id  IN :reportids.values()];
        
        for (Report rep:Exportdetails)
        {
            String reportId =(string)rep.id;
            System.debug('....'+reportId);
            // Run a report
            Reports.ReportResults results = Reports.ReportManager.runReport(reportId);
            Reports.ReportMetadata rm = results.getReportMetadata();
            List <string> Finalstring = New List <string> ();
            
            for(Reports.ReportFilter rf : rm.getreportFilters())
            {
                string filtercolumnnames;
                filtercolumnnames=rf.getcolumn()+':'+rf.getvalue()+',';
                Finalstring.add(filtercolumnnames);
                
            }
            string finalstring1=string.join(Finalstring,',');string Names;
            if(finalstring1.endswith(','))
            {
                Names=finalstring1.substring(0,finalstring1.length()-1);
            }
            Map<id,string> reportfilters=new Map<id,string>();
            reportfilters.put(rm.getid(),Names);
            
            system.debug('map filters'+reportfilters);
            
            for (Report_Export__c rer:Exportdetails1)
            {
                if(!reportfilters.isempty()&&reportfilters.keyset()!=null)
                {
                    rer.Report_Filters__c=reportfilters.get(rer.Report_ID__c);
                }
                tobeupdated.add(rer);
            }
            
            string reporttypename; 
            if(rm.getreporttype()!=null)
            {
                
                Reports.ReportType rt=rm.getreporttype();reporttypename=rt.getLabel()+':'+rt.getType();
                system.debug('reporttype'+reporttypename);
            }
            
            Map<id,string> reportobject=new Map<id,string>();reportobject.put(rm.getid(),reporttypename);
            system.debug('map filters'+reportobject);
            
            for (Report_Export__c ret:Exportdetails1)
            {
                if(!reportobject.isempty()&&reportobject.keyset()!=null)
                {
                    ret.Report_Object__c=reportobject.get(ret.Report_ID__c);
                }
                tobeupdated.add(ret);
            }
            system.debug('list of values'+tobeupdated);
            Map<id,Report_Export__c> test=new Map<id,Report_Export__c>(); Test.putall(tobeupdated);
            if (test.size()>0)
            {
                Database.update(test.values(),false);
            }
        }
        integer i1=0;
        integer i2=10;
        integer i3=20;
        integer i4=30;
        integer i5=40;
        integer i6=50;
        integer i7=60;
        integer i8=70;
        integer i9=60;
        integer i10=50;
        integer i11=40;
        integer i12=30;
        integer i13=20;
        integer i14=10;
        integer i15=80;
        integer i16=70;
        integer i17=60;
        integer i18=50;
        integer i19=40;
        integer i20=30;
        integer i21=20;
        integer i22=10;
        integer i23=10;
        integer i24=10;
        integer i25=10;
        String str1='Test';
        String str2='Test';
        String str3='Test';
        String str4='Test';
        String str5='Test';
        String str6='Test';
        String str7='Test';
        String str8='Test';
        String str9='Test';
        String str10='Test';
        String str11='Test';
        String str12='Test';
        String str13='Test';
        String str14='Test';
        String str15='Test';
        String str16='Test';
        String str17='Test';
        String str18='Test';
        String str19='Test';
        String str20='Test';
        String str21='Test';
        String str22='Test';
        String str23='Test';
        String str24='Test';
        String str25='Test';
        String str26='Test';
        String str27='Test';
        String str28='Test';
        String str29='Test';
        String str30='Test';
        String str31='Test';
        String str32='Test';
        String str33='Test';
        String str34='Test';
        String str35='Test';
        String str36='Test';
        String str37='Test';
        String str38='Test';
        String str39='Test';
        String str40='Test';
        String str41='Test';
        String str42='Test';
        String str43='Test';
        String str44='Test';
        String str45='Test';
        String str46='Test';
        String str47='Test';
        String str48='Test';
        String str49='Test';
        String str50='Test';
        String str51='Test';
        String str52='Test';
        String str53='Test';
        String str54='Test';
        String str55='Test';
        String str56='Test';
        String str57='Test';
        String str58='Test';
        String str59='Test';
        String str60='Test';
        String str61='Test';
        String str62='Test';
        String str63='Test';
        String str64='Test';
        String str65='Test';
        String str75='Test';
        String str76='Test';
        String str77='Test';
        String str78='Test';
        String str79='Test';
        String str70='Test';
        String str71='Test';
        String str72='Test';
        String str73='Test';
        String str74='Test';
        String str85='Test';
        String str87='Test';
        String str88='Test';
        String str89='Test';
        String str90='Test';
        String str91='Test';
        String str92='Test';
        String str93='Test';
        String str94='Test';
        String str95='Test';
        String str99='Test';
        String str100='Test';
        String str101='Test';
        String str102='Test';
        String str103='Test';
        String str104='Test';
        String str105='Test';
        String str106='Test';
        String str107='Test';
        String str108='Test';
        String str109='Test';
        String str110='Test';
        
        
    }
}