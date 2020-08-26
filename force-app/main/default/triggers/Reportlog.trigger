trigger Reportlog on Report_Export__c (after insert) {

List<Report_Export__c> Exportdetails =[select Userid__c,Report_ID__c from Report_Export__c where ID IN:Trigger.NewMap.keySet()];
Map<ID,ID> reportids= new Map<ID,ID>();
Map<ID,ID> Userids=new Map<ID,ID>();

list<Report_Export__c> tobeupdated =new list<Report_Export__c>();

for(Report_Export__c RE:Exportdetails)
{
reportids.put(re.id,re.Report_ID__c);
Userids.put(re.id,re.Userid__c);
}

Map<id,user> userlist= new Map<id,user>([select id,Firstname,lastname,profileid,FederationIdentifier from user where id IN:Userids.values()]);
Map<id,Report> publicreports =new Map<id,Report> ([SELECT Id,Name,CreatedByid,CreatedDate,DeveloperName,FolderName,Format,LastModifiedByid,
LastModifiedDate FROM Report where IsDeleted=false and id IN :reportids.values()]);
Map<id,Private_Reports__c> Privatereports1=new Map<id,Private_Reports__c>([SELECT Id,Name,Report_Created_By__c,Report_Created_date__c,Report_Developer_Name__c,Report_Folder_Name__c,Report_Format__c,Report_ID__c,
Report_Modified_By__c,Report_Modified_date__c FROM Private_Reports__c where  Report_ID__c IN :reportids.values()]);

Map<id,Private_Reports__c> Privatereports=new Map<id,Private_Reports__c>();

for(Private_Reports__c rep:Privatereports1.values())
{
Privatereports.put(rep.Report_ID__c,rep);

}

for(Report_Export__c re :Exportdetails)
{

if (!publicreports.isEmpty() && publicreports.get(re.Report_ID__c)!=null)
{
re.User_First_Name__c = userlist.get(re.Userid__c).Firstname;re.User_Last_Name__c = userlist.get(re.Userid__c).lastname;re.User_Profile__c = userlist.get(re.Userid__c).profileid;re.User_SSO__c = userlist.get(re.Userid__c).FederationIdentifier;re.Name = publicreports.get(re.Report_ID__c).DeveloperName;re.Report_Created_By__c = publicreports.get(re.Report_ID__c).CreatedByid;re.Report_Modified_By__c = publicreports.get(re.Report_ID__c).LastModifiedByid;re.Report_Created_date__c = publicreports.get(re.Report_ID__c).CreatedDate;re.Report_Modified_date__c = publicreports.get(re.Report_ID__c).LastModifiedDate;
tobeupdated.add(re);

}

if(!Privatereports.isEmpty() && Privatereports.get(re.Report_ID__c)!=null)
{
re.User_First_Name__c = userlist.get(re.Userid__c).Firstname; re.User_Last_Name__c = userlist.get(re.Userid__c).lastname;re.User_Profile__c = userlist.get(re.Userid__c).profileid;re.User_SSO__c = userlist.get(re.Userid__c).FederationIdentifier;re.Name = Privatereports.get(re.Report_ID__c).Report_Developer_Name__c;re.Report_Created_By__c = Privatereports.get(re.Report_ID__c).Report_Created_By__c;re.Report_Modified_By__c = Privatereports.get(re.Report_ID__c).Report_Modified_By__c;re.Report_Created_date__c = Privatereports.get(re.Report_ID__c).Report_Created_date__c;re.Report_Modified_date__c = Privatereports.get(re.Report_ID__c).Report_Modified_date__c;
tobeupdated.add(re);
}

if(re.Report_ID__c==null && re.Userid__c!=null)
{
re.User_First_Name__c = userlist.get(re.Userid__c).Firstname;
re.User_Last_Name__c = userlist.get(re.Userid__c).lastname;
re.User_Profile__c = userlist.get(re.Userid__c).profileid;
re.User_SSO__c = userlist.get(re.Userid__c).FederationIdentifier;
re.Name ='Report Not Saved';
tobeupdated.add(re);
}

else if((Privatereports.get(re.Report_ID__c)==null) && (publicreports.get(re.Report_ID__c)==null) )
{
re.User_First_Name__c = userlist.get(re.Userid__c).Firstname;
re.User_Last_Name__c = userlist.get(re.Userid__c).lastname;
re.User_Profile__c = userlist.get(re.Userid__c).profileid;
re.User_SSO__c = userlist.get(re.Userid__c).FederationIdentifier;
re.Name ='Report Deleted';
tobeupdated.add(re);
}


Map<id,Report_Export__c> test=new Map<id,Report_Export__c>();
Test.putall(tobeupdated);
if (test.size()>0)
{
Database.update(test.values(),false);
}
}
}