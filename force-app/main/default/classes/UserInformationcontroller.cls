public class UserInformationcontroller {
 public List<User> userslst { get; set; }
    public String sso { get; set; }
    public list<LoginHistory> history  { get; set; }
    string logindate;
    integer daysSincelogin;
    Date myDate;
    string sdate;
    list<LoginHistory> histo =new list<LoginHistory>();
    

    public UserInformationcontroller()
    {
        userslst = new List<User>();
    }

    public PageReference searchUsers()
    {
        userslst = [select Id,
                     GE_HQ_SSO_ID__c,IsActive,LastLoginDate,name,Days_Since_Login__c,UserRole.Name,Profile.Name 
                     from User 
                    where GE_HQ_SSO_ID__c = :sso
                    ];
                    
        if(!userslst.isEmpty())
        {
            histo=[SELECT Id,LoginTime, Status,UserId from LoginHistory where UserId=:userslst[0].Id];
        }
        //integer i=history.size();
        if(!histo.isEmpty()){
        for(LoginHistory L:histo)
        {
            if(L.Status == 'Success')
            {
                logindate=string.valueOfGmt(L.LoginTime);
                system.debug(logindate+'logindate');
                Datetime dt = (Datetime) L.LoginTime;
                myDate = date.newinstance(dT.year(), dT.month(), dT.day());
                sdate= String.valueOf(myDate);
                daysSincelogin=Integer.valueof(myDate.daysBetween(System.Today()));
             }
            
        }
        }
        if(sso ==null || sso == ' '||sso=='')
        {
            Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,''+' <font  size="3px">Please enter SSO.</font>' ));
            return null;
        }
        if(userslst.isEmpty())
        {
             Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,''+'<font  size="3px">You do not have access to Salesforce</font>'+'<font  size="3px"><a href="https://ge.box.com/s/ff856ub5cj38vn5ui3rjl4776gc0bq9t" target="_blank" target="_blank" >click here</a>for instructions</font>' ));
        }
        else if(!userslst.isEmpty())
        {
        for(user u:userslst){
        //system.debug('user info'+users);
        if( u.IsActive == false && daysSincelogin!=null){
             
             Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,''+'<font  size="3px">-Your account is inactive since you have not logged for more than </font>'+'<font  size="3px">'+daysSincelogin+'</font>' +'<font  size="3px"> days. Last successful login: </font> '+'<font size="3px">'+sdate+'.</font>'+'</br></br><font  size="3px">-<a href="https://ge.box.com/s/ff856ub5cj38vn5ui3rjl4776gc0bq9t" target="_blank" >Click Here</a>for insructions to apply in IDM for access.<font>'+'</br></br><font  size="3px">-While applying select profile as </font>'+'<font  size="3px">'+u.Profile.Name+'</font>'+'<font  size="3px"> and role as </font>'+'<font  size="3px">'+u.UserRole.Name+'</font>' ));
        
        }
        else if(u.IsActive == True)
        {
           Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,''+' <font  size="3px">To access Deal Machine click on the link: <a href="https://geog.my.salesforce.com"  target="_blank">https://geog.my.salesforce.com</a>.If the issue persists <a href="mailto:itconfigurationteam@ge.com" target="_blank" >Email Us</a></font>' ));
        }
        
    }
   }
    return null;
}
}