/**********************
Description: Created for eRAD cloning process to create Closed big from Active Bid rad. 
Created By  : Chaitanya Gupta K
Date : Jan 28, 2015  
**********************/

public with sharing class GE_OG_eRad_Cloning{
    public static string getCreatableFieldsSOQL(String objectName,String whereClause){
        String selects = '';
        
        if (whereClause == null || whereClause == ''){ return null; }
        Map<String, Schema.SObjectField> fMap = Schema.getGlobalDescribe().get(objectName.toLowerCase()).getDescribe().Fields.getMap();
        list<string> selectFields = new list<string>();
        if (fMap != null){
            for (Schema.SObjectField ft : fMap.values()){
                Schema.DescribeFieldResult fd = ft.getDescribe();
                if (fd.isCreateable()){
                    selectFields.add(fd.getName());
                }
            }
        }
        if (!selectFields.isEmpty()){
            for (string s:selectFields){
                selects += s + ',';
            }
            if (selects.endsWith(',')){selects = selects.substring(0,selects.lastIndexOf(','));}
        }
        return 'SELECT ' + selects + ' FROM ' + objectName + ' WHERE ' + whereClause;
    }
}