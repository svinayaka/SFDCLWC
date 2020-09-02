public class GE_ES_Utils
    { 
    // Returns a dynamic SOQL statement for the whole object, includes only creatable fields since we will be inserting a cloned result of this query
    public static string getCreatableFieldsSOQL(String objectName, String whereClause)
        {
        system.debug('whereClause-----------'+whereClause);
        String selects = '';
        if (whereClause == null || whereClause == '')
            { 
            return null; 
            }
 
        // Get a map of field name and field token
        Map<String, Schema.SObjectField> fMap = Schema.getGlobalDescribe().get(objectName.toLowerCase()).getDescribe().Fields.getMap();
        list<string> selectFields = new list<string>();
        
        if (fMap != null)
            {
            for (Schema.SObjectField ft : fMap.values())
                { // loop through all field tokens (ft)
                Schema.DescribeFieldResult fd = ft.getDescribe(); // describe each field (fd)
                system.debug('Field Details - '+fd);
                if (fd.isCreateable())
                    { // field is creatable
                    selectFields.add(fd.getName());
                    }
                }
            }
 
        if (!selectFields.isEmpty())
            {
            for (string s:selectFields)
                {
                selects += s + ',';
                }
            if (selects.endsWith(','))
                {
                selects = selects.substring(0,selects.lastIndexOf(','));
                }
            }
        system.debug('hereee'+ 'SELECT ' + selects + ' FROM ' + objectName + ' WHERE id=' + '\''+whereClause+'\'');
        
        return 'SELECT ' + selects + ' FROM ' + objectName + ' WHERE ' + whereClause;
       }

    // Returns a RecordType Name
    public static string getRecordTypeName(String objectName, String recordTypeId)
        {
        return null;
        }
        
   //populate a map with locale values and corresponding datetime formats
    public Map<String, String> MapValues() 
        {
        Map<String, String> locale_map = new Map<String, String>(); //holds the locale to timedate formats
        locale_map.put('ar' , 'dd/mm/yyyy');
        locale_map.put('ar_AE' , 'dd/mm/yyyy');
        locale_map.put('ar_BH' , 'dd/mm/yyyy');
        locale_map.put('ar_EG' , 'dd/mm/yyyy');
        locale_map.put('ar_JO' , 'dd/mm/yyyy');
        locale_map.put('ar_KW' , 'dd/mm/yyyy');
        locale_map.put('ar_LB' , 'dd/mm/yyyy');
        locale_map.put('ar_SA' , 'dd/mm/yyyy');
        locale_map.put('bg' , 'yyyy-m-d');
        locale_map.put('bg_BG' , 'yyyy-m-d');
        locale_map.put('ca' , 'dd/mm/yyyy');
        locale_map.put('ca_ES' , 'dd/mm/yyyy');
        locale_map.put('cs' , 'd.m.yyyy ');
        locale_map.put('cs_CZ' , 'd.m.yyyy ');
        locale_map.put('da' , 'dd-mm-yyyy');
        locale_map.put('da_DK' , 'dd-mm-yyyy');
        locale_map.put('de' , 'dd.mm.yyyy ');
        locale_map.put('de_AT' , 'dd.mm.yyyy ');
        locale_map.put('de_CH' , 'dd.mm.yyyy ');
        locale_map.put('de_DE' , 'dd.mm.yyyy ');
        locale_map.put('de_LU' , 'dd.mm.yyyy ');
        locale_map.put('el' , 'd/m/yyyy');
        locale_map.put('el_GR' , 'd/m/yyyy');
        locale_map.put('en_AU' , 'd/mm/yyyy');
        locale_map.put('en_BB' , 'm/d/yyyy');
        locale_map.put('en_BM' , 'm/d/yyyy');
        locale_map.put('en_CA' , 'dd/mm/yyyy');
        locale_map.put('en_GB' , 'dd/mm/yyyy');
        locale_map.put('en_GH' , 'm/d/yyyy');
        locale_map.put('en_ID' , 'm/d/yyyy');
        locale_map.put('en_IE' , 'dd/mm/yyyy');
        locale_map.put('en_IN' , 'd/m/yyyy');
        locale_map.put('en_MY' , 'm/d/yyyy');
        locale_map.put('en_NG' , 'm/d/yyyy');
        locale_map.put('en_NZ' , 'd/mm/yyyy');
        locale_map.put('en_PH' , 'm/d/yyyy');
        locale_map.put('en_SG' , 'm/d/yyyy');
        locale_map.put('en_US' , 'm/d/yyyy');
        locale_map.put('en_ZA' , 'yyyy/mm/dd');
        locale_map.put('es' , 'd/mm/yyyy');
        locale_map.put('es_AR' , 'dd/mm/yyyy');
        locale_map.put('es_BO' , 'dd-mm-yyyy');
        locale_map.put('es_CL' , 'dd-mm-yyyy');
        locale_map.put('es_CO' , 'd/mm/yyyy');
        locale_map.put('es_CR' , 'dd/mm/yyyy');
        locale_map.put('es_DO' , 'mm/dd/yyyy');
        locale_map.put('es_EC' , 'dd/mm/yyyy');
        locale_map.put('es_ES' , 'd/mm/yyyy');
        locale_map.put('es_GT' , 'd/mm/yyyy');
        locale_map.put('es_HN' , 'mm-dd-yyyy');
        locale_map.put('es_MX' , 'd/mm/yyyy');
        locale_map.put('es_PA' , 'mm/dd/yyyy');
        locale_map.put('es_PE' , 'dd/mm/yyyy');
        locale_map.put('es_PR' , 'mm-dd-yyyy');
        locale_map.put('es_PY' , 'dd/mm/yyyy');
        locale_map.put('es_SVUS' , 'mm-dd-yyyy');
        locale_map.put('es_UY' , 'dd/mm/yyyy');
        locale_map.put('es_VE' , 'dd/mm/yyyy');
        locale_map.put('et_EE' , 'd.mm.yyyy ');
        locale_map.put('fi' , 'd.m.yyyy ');
        locale_map.put('fi_FI' , 'd.m.yyyy ');
        locale_map.put('fr' , 'dd/mm/yyyy');
        locale_map.put('fr_BE' , 'd/mm/yyyy');
        locale_map.put('fr_CA' , 'yyyy-mm-dd');
        locale_map.put('fr_CH' , 'dd.mm.yyyy ');
        locale_map.put('fr_FR' , 'dd/mm/yyyy');
        locale_map.put('fr_LU' , 'dd/mm/yyyy');
        locale_map.put('fr_MC' , 'dd/mm/yyyy');
        locale_map.put('hr_HR' , 'dd.mm.yyyy. ');
        locale_map.put('hu' , 'yyyy.mm.dd. ');
        locale_map.put('hy_AM' , 'm/d/yyyy');
        locale_map.put('in' , 'yyyy/mm/dd');
        locale_map.put('is_IS' , 'd.m.yyyy ');
        locale_map.put('it' , 'dd/mm/yyyy');
        locale_map.put('it_CH' , 'dd.mm.yyyy ');
        locale_map.put('it_IT' , 'dd/mm/yyyy');
        locale_map.put('iw' , 'dd/mm/yyyy');
        locale_map.put('iw_IL' , 'dd/mm/yyyy');
        locale_map.put('ja' , 'yyyy/mm/dd');
        locale_map.put('ja_JP' , 'yyyy/mm/dd');
        locale_map.put('ka' , 'm/d/yyyy');
        locale_map.put('ka_GE' , 'm/d/yyyy');
        locale_map.put('kk_KZ' , 'm/d/yyyy');
        locale_map.put('km_KH' , 'm/d/yyyy');
        locale_map.put('ko' , 'yyyy. m. d');
        locale_map.put('ko_KR' , 'yyyy. m. d');
        locale_map.put('lt_LT' , 'yyyy.m.d');
        locale_map.put('lv_LV' , 'yyyy.d.m ');
        locale_map.put('ms_MY' , 'dd/mm/yyyy');
        locale_map.put('nl' , 'd-m-yyyy');
        locale_map.put('nl_BE' , 'd/mm/yyyy');
        locale_map.put('nl_NL' , 'd-m-yyyy');
        locale_map.put('nl_SR' , 'd-m-yyyy');
        locale_map.put('no' , 'dd.mm.yyyy ');
        locale_map.put('no_NO' , 'dd.mm.yyyy ');
        locale_map.put('pl' , 'yyyy-mm-dd');
        locale_map.put('pt' , 'dd-mm-yyyy');
        locale_map.put('pt_AO' , 'dd-mm-yyyy');
        locale_map.put('pt_BR' , 'dd/mm/yyyy');
        locale_map.put('pt_PT' , 'dd-mm-yyyy');
        locale_map.put('ro' , 'dd.mm.yyyy');
        locale_map.put('ro_RO' , 'dd.mm.yyyy');
        locale_map.put('ru' , 'dd.mm.yyyy');
        locale_map.put('ru_RU' , 'dd.mm.yyyy');
        locale_map.put('sh' , 'dd.mm.yyyy.');
        locale_map.put('sh_BA' , 'dd.mm.yyyy.');
        locale_map.put('sh_CS' , 'dd.mm.yyyy.');
        locale_map.put('sk' , 'd.m.yyyy ');
        locale_map.put('sk_SK' , 'd.m.yyyy ');
        locale_map.put('sl_SI' , 'd.m.yy ');
        locale_map.put('sr' , 'd.m.yyyy.');
        locale_map.put('sr_BA' , 'yyyy-mm-dd');
        locale_map.put('sr_CS' , 'd.m.yyyy.');
        locale_map.put('sv' , 'yyyy-mm-dd');
        locale_map.put('sv_SE' , 'yyyy-mm-dd');
        locale_map.put('th' , 'd/m/yyyy');
        locale_map.put('th_TH' , 'd/m/d55M');
        locale_map.put('tl' , 'm/d/yyyy');
        locale_map.put('tl_PH' , 'm/d/yyyy');
        locale_map.put('tr' , 'dd.mm.yyyy ');
        locale_map.put('uk' , 'dd.mm.yyyy ');
        locale_map.put('uk_UA' , 'dd.mm.yyyy ');
        locale_map.put('ur_PK' , 'm/d/yyyy');
        locale_map.put('vi' , 'dd/mm/yyyy');
        locale_map.put('vi_VN' , 'dd/mm/yyyy');
        locale_map.put('zh' , 'yyyy-m-d');
        locale_map.put('zh_CN' , 'yyyy-m-d');
        locale_map.put('zh_HK' , 'yyyy年M月d日');
        locale_map.put('zh_TW' , 'yyyy/m/d');
        locale_map.put('hu_HU' , 'yyyy.mm.dd');
        locale_map.put('in_ID' , 'dd/mm/yyyy');
        locale_map.put('tr_TR' , 'dd.mm.yyyy');
        return locale_map; //return the map
        }     
         
    }