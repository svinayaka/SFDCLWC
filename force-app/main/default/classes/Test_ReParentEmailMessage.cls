@isTest
private class Test_ReParentEmailMessage{
static testMethod void reparentEmailMsg()
{
Case case1 = new Case (Subject='[ ref:_00DA07HHO._500J0aBCD:ref ]', Legacy_Thread_ID__c='[ ref:_00DA07HHO._500J0aBCD:ref ]',
GE_ES_PO__c='123',
GE_ES_Sub_Type__c = 'RFQ processing',
GE_ES_Customer_Request_Date__c = Date.Today().adddays(20)

);
insert case1;
Case case2 = new Case (Subject='Test Case 2', Legacy_Thread_ID__c='',
GE_ES_PO__c='456',
GE_ES_Sub_Type__c = 'RFQ processing',
GE_ES_Customer_Request_Date__c = Date.Today().adddays(20)

);
insert case2;

EmailMessage emailMsg = new EmailMessage(FromAddress = 'shahbaz.ahmed@ge.com',
            FromName = 'Shahbaz Ahmed',
            ToAddress = 'salim.sha@ge.com',
            Subject = '[ ref:_00DA07HHO._500J0aBCD:ref ]',
            TextBody = '',
            HtmlBody = '',
            Status= '0',
            Incoming= true,
            MessageDate =System.Today(),
            ParentId = case2.Id);
insert emailMsg;
}
}