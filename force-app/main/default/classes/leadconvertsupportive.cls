public class leadconvertsupportive{

@future
public static void updateopp(id oppyid, id contid, string leadtier2value, string lconvstatus){

/*if(oppyid != null){
opportunity oppty = [select stagename from opportunity where id =: oppyId];
    oppty.stagename = 'Prospect';
    //oppty.GE_ES_Lead_Number_Old__c = str;
    Update oppty;
}    */
//
if(contid != null){
 contact objContact1 = [select GE_OG_MC_Marketo_Stage__c, M_C_Marketo_Stage__c from contact where id =: contid];
    
    
     if(leadtier2value=='Measurement & Control (M&C)'){
                        objContact1.GE_OG_MC_Marketo_Stage__c=lconvstatus;
                        objContact1.M_C_Marketo_Stage__c=lconvstatus;
                    }
                if(leadtier2value=='Drilling & Surface (D&S)'){
                        objContact1.GE_OG_DS_Marketo_Stage__c=lconvstatus;
                        objContact1.D_S_Marketo_Stage__c=lconvstatus;
                    }
                if(leadtier2value=='DTS'){
                        objContact1.GE_OG_DTS_Marketo_Stage__c=lconvstatus;
                        objContact1.DTS_Marketo_Stage__c=lconvstatus;
                        }
                if(leadtier2value=='Subsea (SS)'){
                    
                        objContact1.GE_OG_SS_Marketo_Stage__c=lconvstatus;
                        objContact1.SS_Marketo_Stage__c=lconvstatus;
                    }
                if(leadtier2value=='TMS'){
                        objContact1.GE_OG_TMS_Marketo_Stage__c=lconvstatus;
                        objContact1.TMS_Marketo_Stage__c=lconvstatus;
                    }
    update objContact1;
   
}
    
}
}