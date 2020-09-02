public class GE_OG_GS_ReportGroupingController {
	
	public List<FieldName> fieldsList {get;set;}
	public List<String> reportNames {get;set;}
	public Map<String, List<Map<String, String>>> reportData {get;set;}
	public GE_OG_GS_Report_Grouping__c reportSetting {get;set;}
	public FieldName groupField {get;set;}
	public Id objId {get;set;}
	public SObject sObj {get;set;}
	public List<Filter> filterFields{get;set;}
	public Boolean groupData {get;set;}
	{
		groupData = true;
	}
	
	
	public GE_OG_GS_ReportGroupingController()
	{
		String settingName = String.escapeSingleQuotes(System.currentPageReference().getParameters().get('setting'));
		objId = System.currentPageReference().getParameters().get('id');
		reportSetting = GE_OG_GS_Report_Grouping__c.getInstance(settingName);
		reportNames = new List<String>();
		for (String reportName : new List<String> {'Report_Name_1__c' , 'Report_Name_2__c', 'Report_Name_3__c', 'Report_Name_4__c', 'Report_Name_5__c', 'Report_Name_6__c', 'Report_Name_7__c' })
		{
			if (reportSetting.get(reportName) != null)
			{
				reportNames.add((String) reportSetting.get(reportName));
			}
		}
		
		filterFields = new List<Filter>();
		List<String> filterObjFields = new List<String>();
		
		for (String filterId : new List<String> {'1', '2', '3', '4', '5', '6', '7', '8'})
		{
			if (reportSetting.get('Filter_' + filterId + '_Report_Field__c') != null)
			{
				filterFields.add(new Filter((String) reportSetting.get('Filter_' + filterId + '_Report_Field__c'), (String) reportSetting.get('Filter_' + filterId + '_Object_Field__c'), (Boolean) reportSetting.get('Filter_' + filterId + '_Include_Blanks__c'), (Boolean) reportSetting.get('Filter_' + filterId + '_Match_Exact__c')));
				filterObjFields.add((String) reportSetting.get('Filter_' + filterId + '_Object_Field__c'));
			}
			
		}
		
		if (reportSetting.Overlap_Filter_Object_End_Date_Field__c != null && reportSetting.Overlap_Filter_Object_Start_Date_Field__c != null)
		{
			filterObjFields.add(reportSetting.Overlap_Filter_Object_End_Date_Field__c);
			filterObjFields.add(reportSetting.Overlap_Filter_Object_Start_Date_Field__c);
		}
		
		if (! filterObjFields.isEmpty())
		{
			String query = 'SELECT Id, ' + String.join(filterObjFields, ', ') + ' FROM ' + reportSetting.Filter_Object__c + ' WHERE ID = \'' + objId + '\'';
			system.debug(query);
			for (SObject obj : Database.query(query))
			{
				sObj = obj;
				
				for (Filter f : filterFields)
				{
					f.filterValue = sObj.get(f.objField);
				}
			}
		}
		system.debug(sObj);
		reloadData();
		
	}
	
	public PageReference  reloadData()
	{
		Set<String> fieldNames = new Set<String>();
		fieldsList = new List<FieldName>();
		reportData = new Map<String, List<Map<String, String>>>();
		Pattern p = Pattern.compile('^.+?: (.+?)$');
		Map<String, Set<String>> reportContainsMap  = new Map<String, Set<String>>();
		
		Map<String, Report> reportMap = new Map<String, Report>();
			
		for (Report r : [SELECT Id, DeveloperName FROM Report WHERE DeveloperName IN :reportNames])
		{
			reportMap.put(r.DeveloperName, r);
			reportContainsMap.put(r.DeveloperName, new Set<String>());
		}
		
		for (String index : new List<String> {'1', '2', '3', '4', '5', '6', '7'})
		{
			String rName = (String) reportSetting.get('Report_Name_' + index + '__c');
			if (rName != null)
			{
			
				Reports.ReportDescribeResult descrResult = Reports.ReportManager.describeReport(reportMap.get(rName).Id);
				Reports.ReportMetadata rm = descrResult.getReportMetadata();
				Reports.ReportExtendedMetadata extRM = descrResult.getReportExtendedMetadata();
				Map<String, Reports.DetailColumn> columnMetaMap = extRM.getDetailColumnInfo();
				List<FieldName> currReportColumns = new List<FieldName>();
				Set<String> groupColumnSet = new Set<String>();
				Reports.ReportMetadata md = descrResult.getReportMetadata();
				String dateFilterReportEndColumn;
				String dateFilterReportStartColumn;
				
				for (String column : rm.getDetailColumns())
				{
					String cName = columnMetaMap.get(column).getLabel();
					Matcher m = p.matcher(cName);
					if (m.matches())
					{
						cName = m.group(1);
					}
					FieldName newField = new FieldName(cName);
					if (columnMetaMap.get(column).getDataType() == Reports.ColumnDataType.DATE_DATA)
					{
						newField.isDate = true;
					}
					else if (columnMetaMap.get(column).getDataType() == Reports.ColumnDataType.DOUBLE_DATA)
					{
						newField.isNumber = true;
					}
					
					currReportColumns.add(newField);
					if (fieldNames.add(cName))
					{
						fieldsList.add(newField);
					}
					
					if (reportSetting.Overlap_Filter_Report_End_Date_Field__c != null && reportSetting.Overlap_Filter_Report_End_Date_Field__c == cName)
					{
						dateFilterReportEndColumn = column;
					}
					
					if (reportSetting.Overlap_Filter_Report_Start_Date_Field__c != null && reportSetting.Overlap_Filter_Report_Start_Date_Field__c == cName)
					{
						dateFilterReportStartColumn = column;
					}
					
					if (! filterFields.isEmpty())
					{
						for (Filter f : filterFields)
						{
							if (f.selected && f.reportField == newField.fieldLabel)
							{
								Reports.ReportFilter newFilter = new Reports.ReportFilter();
								newFilter.setColumn(column);
								newFilter.setValue(String.valueOf(f.filterValue));
								
								if (f.matchExact)
								{
									newfilter.setOperator('equals');
								}
								else
								{
									newFilter.setOperator('contains');
								}
								
								if (! f.includeBlank)
								{
									reportSetting.put('Report_' + index + '_Exclusive__c', true);
								}
								
								md.getReportFilters().add(newFilter);
								
							}
						}
					}
				}
				
				if (dateFilterReportStartColumn != null && dateFilterReportEndColumn != null)
				{
					Reports.ReportFilter newFilter = new Reports.ReportFilter();
					newFilter.setColumn(dateFilterReportStartColumn);
					newFilter.setOperator('lessThan');
					newFilter.setValue(String.valueOf((Date) sObj.get(reportSetting.Overlap_Filter_Object_End_Date_Field__c)));
					md.getReportFilters().add(newFilter);
					
					newFilter = new Reports.ReportFilter();
					newFilter.setColumn(dateFilterReportEndColumn);
					newFilter.setOperator('greaterThan');
					newFilter.setValue(String.valueOf((Date) sObj.get(reportSetting.Overlap_Filter_Object_Start_Date_Field__c)));
					md.getReportFilters().add(newFilter);
				}
				
				if (md.getStandardFilters() == null)
				{
					md.setStandardFilters(new List<Reports.StandardFilter>());
				}
				system.debug(md);
				
				Reports.reportResults results = Reports.ReportManager.runReport(reportMap.get(rName).Id, md, true);
	            
				for (String key : results.getFactMap().keySet())
				{
					Reports.ReportFactWithDetails factDetails = (Reports.ReportFactWithDetails) results.getFactMap().get(key);
					
					for (Reports.ReportDetailRow detailRow : factDetails.getRows())
					{
						String groupColumnData = detailRow.getDataCells().get(0).getLabel();
						
						Map<String, String> currRowData = new Map<String, String>();
	                    Map<String, Object> currRowValueData = new Map<String, Object>();
						for (Integer i = 0; i < detailRow.getDataCells().size(); ++i)
						{
							currRowData.put(currReportColumns.get(i).apiFieldName, detailRow.getDataCells().get(i).getLabel() != '-' ? detailRow.getDataCells().get(i).getLabel() : '');
	                        currRowValueData.put(currReportColumns.get(i).apiFieldName, detailRow.getDataCells().get(i).getValue());
						}
	                    
						reportContainsMap.get(rName).add(groupColumnData);
                        if (! groupColumnSet.contains(groupColumnData) && ! reportData.containsKey(groupColumnData))
                        {
                            reportData.put(groupColumnData, new List<Map<String, String>>());
                            reportData.get(groupColumnData).add(new Map<String, String>(currRowData));
                        }
                        else if (groupColumnSet.contains(groupColumnData))
                        {
                            Map<String, String> newRowData = new Map<String, String>(reportData.get(groupColumnData).get(0));
                            newRowData.putAll(currRowData);
                            reportData.get(groupColumnData).add(newRowData);
                        }
                        else
                        {
                            for (Map<String, String> rowMap : reportData.get(groupColumnData))
                            {
                                rowMap.putAll(currRowData);
                            }
                        }
                        groupColumnSet.add(groupColumnData);
					}
				}
			}	
		}
		
		for (String key : reportData.keySet())
		{
			for (Map<String, String> row : reportData.get(key))
			{
				for (FieldName field : fieldsList)
				{
					if (! row.containsKey(field.apiFieldName))
					{
						row.put(field.apiFieldName, '');
					}
				}
			}
		}
		
		fieldsList.get(0).key = true;
		groupField = fieldsList.get(0);
		
		for (String index : new List<String> {'1', '2', '3', '4', '5', '6', '7'})
		{
			system.debug(index + ' - ' + reportContainsMap.get((String) reportSetting.get('Report_Name_' + index + '__c')));
			system.debug(reportSetting.get('Report_' + index + '_Exclusive__c'));
			
			if (reportSetting.get('Report_' + index + '_Exclusive__c') != null && ((Boolean) reportSetting.get('Report_' + index + '_Exclusive__c')))
			{
				Map<String, List<Map<String, String>>> newReportData = new MAp<String, List<MAp<String, String>>>();
				
				for (String fCol : reportContainsMap.get((String) reportSetting.get('Report_Name_' + index + '__c')))
				{
					if (reportData.get(fCol) != null)
					{
						newReportData.put(fCol, reportData.get(fCol));
					}
				}
				
				reportData = newReportData;
			}
			
			if (reportSetting.get('Report_' + index + '_Exclude__c') != null && ((Boolean) reportSetting.get('Report_' + index + '_Exclude__c')))
			{
				Map<String, List<Map<String, String>>> newReportData = new Map<String, List<MAp<String, String>>>();
				
				Set<String> reportContainsSet = reportContainsMap.get((String) reportSetting.get('Report_Name_' + index + '__c'));
				
				for (String fCol : reportData.keySet())
				{
					if (! reportContainsSet.contains(fCol))
					{
						newReportData.put(fCol, reportData.get(fCol));
					}
				}
				
				reportData = newReportData;
			}
		}
			
		return null;
	}
	
	
	public Boolean getHasFilters()
	{
		if (! filterFields.isEmpty())
		{
			return true;
		}
		
		return false;
	}
	
	public class FieldName
	{
		public String fieldLabel {get;set;}
		public String apiFieldName {get;set;}
		public Boolean isDate {get;set;}
		{
			isDate = false;
		}
		
		public Boolean isNumber {get;set;}
		{
			isNumber = false;
		}
		
		public Boolean key {get;set;}
		{
			key = false;
		}
		
		public FieldName(String fieldLabel)
		{
			this.fieldLabel = fieldLabel;
			this.apiFieldName = fieldLabel.replaceAll(' ', '_');
		}
		
	}
	
	public String getDateFormat1()
	{
		Date t = Date.newInstance(2015,2,28);
		Pattern p = Pattern.compile('^(\\d+)(.)(\\d+)(.)(\\d+)$');
		
		Matcher m = p.matcher(t.format());
		system.debug(t.format());
		
		if (m.matches())
		{
			if (Integer.valueOf(m.group(3)) == 28 && Integer.valueOf(m.group(5)) == 2015)
			{
				return 'mm' + m.group(2) + 'dd' + m.group(4) + 'YY';
		    }
			else if (Integer.valueOf(m.group(1)) == 28 && Integer.valueOf(m.group(5)) == 2015)
		    {
				return 'dd' + m.group(2) + 'mm' + m.group(4) + 'YY';
			}
			else if (Integer.valueOf(m.group(3)) == 28 && Integer.valueOf(m.group(1)) == 2015)
		    {
				return 'YY' + m.group(2) + 'dd' + m.group(4) + 'mm';
			}
			else if (Integer.valueOf(m.group(5)) == 28 && Integer.valueOf(m.group(1)) == 2015)
		    {
				return 'YY' + m.group(2) + 'mm' + m.group(4) + 'dd';
			}
		}
		
		return 'mm/dd/YY';
		
	}
	
	public String getDateFormat2()
	{
		Date t = Date.newInstance(2015,2,28);
		Pattern p = Pattern.compile('^(\\d+)(.)(\\d+)(.)(\\d+)$');
		
		Matcher m = p.matcher(t.format());
		system.debug(t.format());
		
		if (m.matches())
		{
			if (Integer.valueOf(m.group(3)) == 28 && Integer.valueOf(m.group(5)) == 2015)
			{
				return 'm' + m.group(2) + 'd' + m.group(4) + 'yy';
		    }
			else if (Integer.valueOf(m.group(1)) == 28 && Integer.valueOf(m.group(5)) == 2015)
		    {
				return 'd' + m.group(2) + 'm' + m.group(4) + 'yy';
			}
			else if (Integer.valueOf(m.group(3)) == 28 && Integer.valueOf(m.group(1)) == 2015)
		    {
				return 'yy' + m.group(2) + 'd' + m.group(4) + 'm';
			}
			else if (Integer.valueOf(m.group(5)) == 28 && Integer.valueOf(m.group(1)) == 2015)
		    {
				return 'yy' + m.group(2) + 'm' + m.group(4) + 'd';
			}
		}
		
		return 'm/d/yy';
		
	}
	
	public String getLocaleFile()
	{
		return 'js/i18n/grid.locale-' + getLocale() + '.js';
	}
	
	public String getLocale()
	{
		return UserInfo.getLocale().substring(0,2);
	}
	
	
	
	public class Filter 
    {
        public String reportField {get;set;}
        public String objField {get;set;}
        public Boolean includeBlank {get;set;}
        public Boolean matchExact {get;set;}
        public Object filterValue {get;set;}
        public Boolean selected {get;set;}
        
        public Filter(String reportField, String objField, Boolean includeBlank, Boolean matchExact)
        {
            this.reportField = reportField;
            this.objField = objField;
            this.includeBlank = includeBlank;
            this.matchExact = matchExact;
            selected = true;
        }
    }
    
    
	

}