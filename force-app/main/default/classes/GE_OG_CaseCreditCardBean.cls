/*Class name:		GE_OG_CaseCreditCardBean
 * Pupose:			This class is a simple bean to represent the credit card pre and post text
 * Date Created:	3/30/2016
 * Author:			Koshay
 * Related to:		R-24487
 * 
 */
public class GE_OG_CaseCreditCardBean {

    public Id m_CaseId{get;set;}
    public String m_preText{get;set;}
    public String m_postText{get;set;}
    
    public GE_OG_CaseCreditCardBean(Id cId, String pre, String post){
        m_CaseId = cId; 
        m_preText = pre;
        m_postText = post;
    }

}