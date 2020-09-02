/*Class name:       GE_OG_EmailCreditCardCheck
* Pupose:           This class will catch issues where an email has a credit card number in it and is related to case.  This will call the class GE_OG_CaseCreditCardChecker to 
*                   place the case it into a special queue and/or send a chatter message to a private chatter group
* Date Created: 3/30/2016
* Author:           Koshay
* Related to:       R-24487
* Last Modified by: Sonali Rathore related to Bug:0000024582
*/

public class GE_OG_EmailCreditCardCheck {
    
    private final static Pattern thepattern;
    
    static{
        thepattern = Pattern.compile('\\b(3[47]\\d{2}([ -]?)(?!(\\d)\\3{5}|123456|234567|345678)\\d{6}\\2(?!(\\d)\\4{4})\\d{5}|((4\\d|5[1-5]|65)\\d{2}|6011)([ -]?)(?!(\\d)\\8{3}|1234|3456|5678)\\d{4}\\7(?!(\\d)\\9{3})\\d{4}\\7\\d{4})\\b');     
    }
    
    public static void processEmails(List<EmailMessage> emailMessages){
        Matcher match = null;
        map<Id, GE_OG_CaseCreditCardBean> CasesToProcess = new map<Id, GE_OG_CaseCreditCardBean>();
        List<String> casestoProcessSerialize = new List<String>();
        system.debug('Before:thepattern ' +thepattern);
        for(EmailMessage em : emailMessages){
            //if(em != null && em.parentId != null && em.TextBody != null){
            if(em != null){
                    if(em.TextBody!=Null){
                        system.debug('Before:Testing Email body' +em.TextBody);
                        match = thepattern.matcher(em.TextBody);
                    
                        system.debug('After:Testing Email body' +em.TextBody);                  
                        String preText ='';
                        String postText='';
                        
                        boolean ret = match.find();
                // if we have a match!
                if (ret){                    
                    //Get the pre and post text context of this match
                    if(match.start() >34)
                        preText = em.TextBody.subString(match.start()-35,match.start()-1);
                    if(match.end() < em.TextBody.length()-35)
                        postText = em.TextBody.subString(match.end()+1,match.end()+34);
                    
                    list<string> lGroupValues = new list<String>();
                    for (integer i=1;i<match.groupCount();i++){
                        lGroupValues.add(match.group(i));
                        
                    }           
                    
                    System.debug('Credit card info detected in EmailMessage: ' + em.Id + ' ' + em.Subject);
                    //  print CC data to debug log System.debug( match.groupCount() + ' groupValues: ' +  lGroupValues );
                    if(em.ParentId!= null){
                        Schema.SObjectType token = Id.valueOf(em.ParentId).getSObjectType();
                        Schema.DescribeSObjectResult dr = token.getDescribe();
                        // if the parent Id is a case then add it to our list
                        if(dr.getLabel() == 'Case'){
                            System.debug('Parent Case ID found; adding to list for case processing');
                            GE_OG_CaseCreditCardBean CCBean = new GE_OG_CaseCreditCardBean(Id.valueOf(em.ParentId),preText,PostText);
                            //put the CC information into our String list, which will be past to the future method for processing
                            casestoProcessSerialize.add(JSON.serialize(CCBean));
                        }
                    }
                  

                    }// end if match
                
                }// end if not null
            }// end if not null
            
        }// end for loop
        
        if(casestoProcessSerialize.size()>0){
            System.debug('Passing map of cases to be processes for credit card information');
            GE_OG_CaseCreditCardProcessor.futureUpdateCaseOwner(casestoProcessSerialize, null, true);
        }
    }
        
}