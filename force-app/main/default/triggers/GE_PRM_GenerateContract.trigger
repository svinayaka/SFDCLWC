/*  
  trigger to generate master and addendum contract from channel appointment  and  related  commercial  lines
  for  R-17373 

*/



trigger GE_PRM_GenerateContract on GE_PRM_Channel_Appointment__c (after  update) {
GE_PRM_GenerateContracts trghndler =new GE_PRM_GenerateContracts();
if(trigger.isafter){
    if(trigger.isupdate){
  trghndler.createcontracts(trigger.new,Trigger.oldMap);
  }
}
}