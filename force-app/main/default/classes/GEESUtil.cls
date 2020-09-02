public without sharing class GEESUtil {
public static Map<String,Schema.RecordTypeInfo> caseRecTypes{get;set;}
    public static Map<String,Schema.RecordTypeInfo> getAssociatedCaseRecordTypeIDforRecordTypeName()
{
caseRecTypes= Schema.SObjectType.Case.getRecordTypeInfosByName();

return caseRecTypes;
}
}