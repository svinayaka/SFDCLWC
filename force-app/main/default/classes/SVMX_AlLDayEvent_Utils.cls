public class SVMX_AlLDayEvent_Utils {
    
    public static DateTime getDateTimeInTimezone(Date givenDate, Time givenTime, String timeZoneSidKey)
    {
        DateTime gmtDateTime = DateTime.newInstanceGmt(givenDate, givenTime);
        
        String gmtDateTimeStr = gmtDateTime.formatGmt('yyyy-MM-dd HH:mm:ss');
        Double tmzOffsetMins = (DateTime.valueOfGmt(gmtDateTimeStr).getTime() - DateTime.valueOfGmt(gmtDateTime.format('yyyy-MM-dd HH:mm:ss', timeZoneSidKey)).getTime())/60000;
        DateTime retDateTime = gmtDateTime.addMinutes(tmzOffsetMins.intValue());        
        
        // Check if the conversion is correct.
        // If not correct (can happen during DST transition points), adjust the returned date time.
        
        if(retDateTime.format('yyyy-MM-dd HH:mm:ss', timeZoneSidKey) == gmtDateTimeStr)
            return retDateTime;
        else if(retDateTime.addhours(1).format('yyyy-MM-dd HH:mm:ss', timeZoneSidKey) == gmtDateTimeStr)
            return retDateTime.addhours(1);
        else if(retDateTime.addhours(-1).format('yyyy-MM-dd HH:mm:ss', timeZoneSidKey) == gmtDateTimeStr)
            return retDateTime.addhours(-1);
        else // Given date time is illegal for the given time zone, e.g. 13/Mar/2011, 2:30 AM, America/Los_Angeles
            return retDateTime;
    }
    
}