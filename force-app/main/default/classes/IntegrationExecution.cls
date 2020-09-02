public class IntegrationExecution{

    public Boolean IsOrgName {set; get;}

    public IntegrationExecution(String ClassOrgName){
        if(Label.GE_Organization_Name == ClassOrgName){
            IsOrgName = true;
        }       
        else
            IsOrgName = false;
            If(Test.isRunningTest()) { IsOrgName = true; }
    }
    
    public Boolean getIsOrgName(){
        return IsOrgName;
    }
}