global class GE_OG_MCS_Case_CloseSave{


Webservice static void closeCase (Id caseId){

Case cs = [Select Id,status from case where id =: caseId];
cs.status = 'Closed' ; 
update cs ; 

}
}