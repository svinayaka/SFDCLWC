/*Class name:		GE_OG_CaseCreditCardProcessor
* Pupose:			This class will accept a list of cases that are suspected of having CC data.  It will place cases into a special queue and/or send a chatter message to a private chatter group
* Date Created:	3/30/2016
* Author:			Koshay
* Related to:		R-24487
*/

public class GE_OG_CaseCreditCardProcessor {
    
    //private final static Pattern thepattern;
    private final static Group queue;
    private final static Id chatterGroupId;
    public static boolean isTestRunning = false;
    
    
    static{
        //thepattern = Pattern.compile('\\b(3[47]\\d{2}([ -]?)(?!(\\d)\\3{5}|123456|234567|345678)\\d{6}\\2(?!(\\d)\\4{4})\\d{5}|((4\\d|5[1-5]|65)\\d{2}|6011)([ -]?)(?!(\\d)\\8{3}|1234|3456|5678)\\d{4}\\7(?!(\\d)\\9{3})\\d{4}\\7\\d{4})\\b');
        try{
            queue = [select id, Name from group where name = :getCreditCardQueueName()];
        }
        Catch (Exception e){
            System.debug('Not able to set queue based on name North America: ' + e.getMessage());
        }
        chatterGroupId = (getCreditCardChatterGroup());      
    }
    /* This method isn't required since the trigger on Inbound Email Message will capture a new email that has CC data and generates a case
     
    public static void processCases(list<case> lc){
        
        map<Id, GE_OG_CaseCreditCardBean> CasesToProcess = new map<Id, GE_OG_CaseCreditCardBean>();
        List<String> casestoProcessSerialize = new List<String>();
        
        if(queue == null){
            System.debug('Failed to get queue; program exiting');
            return;
        }
        
        Matcher match = null;
        
        for(Case c : lc){            
            if (c != null && c.description!=null){      
                match = thepattern.matcher(c.description);                       
                String preText ='';
                String postText='';
                
                boolean ret = match.find();
                // if we have a match and the case is not in the special queue
                if (ret && c.OwnerId != queue.Id){
                    //Get the pre and post text context of this match
                    if(match.start() >34)
                        preText = c.Description.subString(match.start()-35,match.start()-1);
                    if(match.end() < c.Description.length()-35)
                        postText = c.Description.subString(match.end()+1,match.end()+34);
                    
                    list<string> lGroupValues = new list<String>();
                    for (integer i=1;i<match.groupCount();i++){
                        lGroupValues.add(match.group(i));
                        
                    }           
                    
                    System.debug('CaseCreditCardChecker.hasCreditCardInfo: groupCount - credit card info detected in case: ' + c.CaseNumber);
                    
                    // Add the case and related pre/post text to the map
                    CasesToProcess.put(c.Id, new GE_OG_CaseCreditCardBean(c.Id,preText,PostText));
                    GE_OG_CaseCreditCardBean CCBean = new GE_OG_CaseCreditCardBean(c.Id,preText,PostText);
                    //put the CC information into our String list, which will be past to the future method for processing
                    casestoProcessSerialize.add(JSON.serialize(CCBean));
                    
                }
                else if (ret){
                    System.debug('Case has Credit Card information and has been updated, but the case is already in the queue.  No processing to take place');
                }
            }
        }
        
        // call the process to update the owner of the Cases
        if(casestoProcessSerialize.size()>0){
            System.debug('Calling updateCasesOwnerToQueue method with ' + casestoProcessSerialize.size() +' case(s) to process');            
            futureUpdateCaseOwner(casestoProcessSerialize, null, false);
        }
        
    }  */
    
    // future method will update the case owner + chatter
    @future
    public static void futureUpdateCaseOwner(List<String> cb, String p_queueName, boolean fromEmailTrigger){
        
        Set<Id> casesIds = new Set<Id>();
        
        List<GE_OG_CaseCreditCardBean> casesBeans = new List<GE_OG_CaseCreditCardBean>();
        map<Id, GE_OG_CaseCreditCardBean> caseBeanMap = new map<Id, GE_OG_CaseCreditCardBean>();
        GE_OG_CaseCreditCardBean tempBean = null;
        for(String str : cb){
            tempBean = (GE_OG_CaseCreditCardBean) JSON.deserialize(str, GE_OG_CaseCreditCardBean.class);
            if(tempBean != null){
                casesBeans.add(tempBean);
                caseBeanMap.put(tempBean.m_CaseId, tempBean);
                //casesIds.add(tempBean.m_CaseId);
            }
        }
        //Query the case details                
        List<Case> updatedCases = [Select Id, caseNumber, subject, Origin, OwnerId from Case where Id in : caseBeanMap.keyset()];
        //List will hold the cases we actuall update
        List<Case> casesToBeUpdated = new List<Case>();
        String toggle = Label.Case_Credit_Card_Queue_On_Off;
        
        // get the case origin values we're intersted in 
        Set<String> caseOrigins = getCaseOriginValues();
        
        // prepare some text for the chatter message if this even is related to a 2nd or more inbound email with CC information
        String relatedToEmailText = '';
        if(fromEmailTrigger)
            relatedToEmailText ='\r\n\r\nCC issue triggered from a related inbound email to the case\r\n\r\n';
        
        //This is the assignment queue we will use
        Group theQueue = null;
        // If a queue name was passed we'll try to get the queue
        if(p_queueName != null){
            System.debug('Attempting to set queue to ' + p_queueName);
            try{
            	theQueue = [select id from group where name = :p_queueName];
            }
            Catch(Exception e){
                System.debug('Exception caught: '+ e.getMessage());
                System.debug(e.getStackTraceString());                
            }
        }
        
        // if the queue passed is null, use the default queue setup for this class
        if(theQueue == null){
            System.debug('Queued passed to method is null; will use default static variable queue ID');
            theQueue = queue;
        }
        
        // if the queue is still null then we have a problem and can't actually assign the case
        if(theQueue == null){
            system.debug('Queue ' + getCreditCardQueueName() + ' not found... posting chatter message');
            for(Case c : updatedCases)
                postToChatterGroup('Assignment to Queue ' + getCreditCardQueueName() + ' failed!\r\n\r\n' + caseBeanMap.get(c.Id).m_preText, caseBeanMap.get(c.Id).m_postText, c, fromEmailTrigger, ChatterGroupId);
            return;
        } 
        
        // for each case decide if we update the owner ID or just chatter based on the toggle flag       
        for(Case c : updatedCases){
            if(c.OwnerId != theQueue.id){
                // if custom label is on AND the case origin is in our list, change owner
                System.debug('Queue of the case: ' + c.Origin);                
                if(toggle=='on' && caseOrigins.contains(c.Origin)){
                    c.OwnerId = theQueue.id;
                    System.debug('Changed Owner from: ' + c.OwnerId + ' to: ' + theQueue.id);
                    casesToBeUpdated.add(c); 
                    //postToChatterGroup(caseBeanMap.get(c.Id).m_preText, caseBeanMap.get(c.Id).m_postText, c, fromEmailTrigger);
                }
                // else just do a chatter message
                else{
                    System.debug('Toggle is off - posting chatter message');
                    postToChatterGroup(caseBeanMap.get(c.Id).m_preText, caseBeanMap.get(c.Id).m_postText, c, fromEmailTrigger, ChatterGroupId);                    
                }
            }
            else{
                System.debug('Case is already assigned to queue - possible new inbound email trigger this process');
                postToChatterGroup(caseBeanMap.get(c.Id).m_preText, caseBeanMap.get(c.Id).m_postText, c, fromEmailTrigger, ChatterGroupId); 
            }
        }
        
        if(casesToBeUpdated.size() > 0){
            try{
                System.debug('Updating ' + casesToBeUpdated.size() + ' case(s)');
                Database.DmlOptions options = new Database.DmlOptions();
                options.emailHeader.triggerUserEmail = true;
                Database.update(casesToBeUpdated, options);
                sendAssignmentEmail(casesToBeUpdated, queue);
            }
            catch(Exception e){
                System.debug('Failed to update case ownerId - Exception: ' + e.getMessage());
            }
        }   
    }        
    
    public static String getCreditCardQueueName(){
        
        CaseCreditCardQueue__c cc = CaseCreditCardQueue__c.getValues('North America');
        if(cc != null)
            return cc.Queue_Name__c;
        else
            return '';
    }
    
    public static Id getCreditCardChatterGroup(){
        // select Id from CollaborationGroup where name='Cases with Possible Credit Card data'
        List<CollaborationGroup> CG = new List<CollaborationGroup>();
        String CGName = Label.Case_Credit_Card_Chatter_Group;
        CG = [select Id from CollaborationGroup where name = :CGName];
        if(CG.size()==1)
            return CG.get(0).Id;
        else{
            System.debug('Did not find single result for Chatter Group name: ' + CGName);
            return null;
        }
    }
    
    public Static Set<String> getCaseOriginValues(){
        
        set<String> theSet = new set<String>();
        for(GE_OG_NA_Case_Origin_Values__c var : [select Id, Origin_Name__c from GE_OG_NA_Case_Origin_Values__c]){
            theSet.add(var.Origin_Name__c);
        }
        
        return theSet;
    }
    
    public static void postToChatterGroup(String p_preText, String p_postText, Case c, boolean emailUpdateRelated, Id CGId){
        
        String communicationText = '';
        
        if (CGId != null && c.Subject != null){
            communicationText = 'Attention:  Possible Credit Card within a case';
            if(c.CaseNumber != null){
                communicationText += ' Number: ' + c.CaseNumber + '.\r\n';
            }
            else
                communicationText += '.\r\n';
            
            if(emailUpdateRelated)
                communicationText += 'CC issue triggered from a NEW INBOUND EMAIL to the case\r\n';
            
            communicationText += 'Subject: '+ c.Subject + '\r\nOrigin is :' + c.Origin + '\r\nAction may be required.\r\n\r\n' +
                'Surrounding text of possible CC number: \r\n"' + p_preText  + ' <Redacted CC Number> ' +  p_postText +'"';
            if(!isTestRunning){
                ConnectApi.FeedElement feedElement = ConnectApi.ChatterFeeds.postFeedElement(Network.getNetworkId(), CGId, ConnectApi.FeedElementType.FeedItem, communicationText);
                System.debug('Posted chatter message: ' + communicationText);
            }
        }        
    }
    
    public static void sendAssignmentEmail(List<Case> updatedCases, Group p_queue){
        
        if(p_queue == null || updatedCases == null){
            System.debug('No email sent... null data passed');
            return;
        }       
        
        List <User> groupMembers = new List<User>();
        groupMembers = [SELECT ID from user where Id in (select UserOrGroupId FROM GroupMember where GroupId = :p_queue.Id) limit 250];        
        
        if(groupMembers.size() == 0){
            System.debug('No users in the queue we are assigning this to!');
            return;
        }
        
        EmailTemplate theTemplate = [SELECT Id, Name FROM EmailTemplate where Name ='Credit Card Case Email'];
        if(theTemplate == null){
            System.debug('Template is null; will not send email');
            return;
        }
        
        List<ID> sendToUserIDs = new List<ID>();
        for(User u : groupMembers)
            sendToUserIDs.add(u.Id);
        
        System.debug('Sending email to following users: ' + sendToUserIDs);
        Messaging.MassEmailMessage mail = new Messaging.MassEmailMessage();
        mail.setTargetObjectIds(sendToUserIDs);
        mail.setTemplateId(theTemplate.Id);
        mail.setUseSignature(false);
        mail.setSaveAsActivity(false);
        Messaging.sendEmail(new Messaging.MassEmailMessage[]{mail});
    }
    
}