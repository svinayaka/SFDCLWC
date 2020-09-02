public without sharing class TechnicianRegionUpdate_GE_OG
    {
          //Method to Populate region on the basis of Country from Custom Setting
        public static String regionPopulateByCountry(String TechnicianCountry){
        
         Map<String,String> mapcountryreg = new Map<String,String>();
        
         // Get a list of Country Region Mapping Custom Setting values 
        List<Country_Region_Mapping_ge_og__c> lstcountyregmap = Country_Region_Mapping_ge_og__c.getAll().values();
    
        // create a map of Country mapped with Region from Country Region Custom Setting List 
        for(Country_Region_Mapping_ge_og__c country : lstcountyregmap){
            mapcountryreg.put(country.country_name_ge_og__c.ToUpperCase(),country.region_ge_og__c);
        }
        
        //returning region Name from Map
        return (String.isBlank(TechnicianCountry)?TechnicianCountry:mapcountryreg.get(TechnicianCountry.ToUpperCase()));
    }
    
     //method on before insert and before update
      
        public void updateTechRegion(List<SVMXC__Service_Group_Members__c> lstTech){
        
        
        for(SVMXC__Service_Group_Members__c objTech : lstTech){
      
        if(objTech.SVMXC__Country__c!=null ){
                    objTech.GE_OG_Region__c = TechnicianRegionUpdate_GE_OG.regionPopulateByCountry(objTech.SVMXC__Country__c);
                 
            } else {
                    objTech.GE_OG_Region__c='';
            }
            
            }
        }
        
       //method on after insert 
        
     /*  public void afterinsertTechRegion(List<SVMXC__Service_Group_Members__c> lstTech,Map<Id,SVMXC__Service_Group_Members__c> oldTech){
        
         List<SVMXC__Service_Group_Members__c> lstTechObj = new List<SVMXC__Service_Group_Members__c>();
         Set<ID> TechIds = new Set<ID>();
        SVMXC__Service_Group_Members__c  technician= new SVMXC__Service_Group_Members__c();
        for(SVMXC__Service_Group_Members__c objTech : lstTech){
             if(oldTech!=null && objTech.SVMXC__Country__c!=null && objTech.SVMXC__Country__c!= oldTech.get(objTech.ID).SVMXC__Country__c){
                  System.debug('++++++++++++++oldTech,'+ oldTech);
                  System.debug('++++++++++++++objTech.SVMXC__Country__c,'+ objTech.SVMXC__Country__c);
                  
                technician.SVMXC__Service_Group__c  = objTech.SVMXC__Service_Group__c ;
                technician.SVMXC__Country__c = objTech.SVMXC__Country__c;
                technician.GE_OG_Region__c = TechnicianRegionUpdate_GE_OG.regionPopulateByCountry(objTech.SVMXC__Country__c);
                lstTechObj.add(technician);
                TechIds.add(objTech.ID); 
                System.debug('++++++++++++++TechIds,'+ TechIds);
             }
             else if(oldTech==null && objTech.SVMXC__Country__c!=null){
               technician.SVMXC__Service_Group__c  = objTech.SVMXC__Service_Group__c ;
                technician.SVMXC__Country__c = objTech.SVMXC__Country__c;
                technician.GE_OG_Region__c = TechnicianRegionUpdate_GE_OG.regionPopulateByCountry(objTech.SVMXC__Country__c);
                lstTechObj.add(technician);
                TechIds.add(objTech.ID); 
            }
            
        }  
        }
        
        //method on after update 
        
         public void afterupdateTechRegion(List<SVMXC__Service_Group_Members__c> lstTech,Map<Id,SVMXC__Service_Group_Members__c> oldTech){
        
         List<SVMXC__Service_Group_Members__c> lstTechObj = new List<SVMXC__Service_Group_Members__c>();
         Set<ID> TechIds = new Set<ID>();
        SVMXC__Service_Group_Members__c  technician= new SVMXC__Service_Group_Members__c();
        for(SVMXC__Service_Group_Members__c objTech : lstTech){
             if(oldTech!=null && objTech.SVMXC__Country__c!=null && objTech.SVMXC__Country__c!= oldTech.get(objTech.ID).SVMXC__Country__c){
                  System.debug('++++++++++++++oldTech,'+ oldTech);
                  System.debug('++++++++++++++objTech.SVMXC__Country__c,'+ objTech.SVMXC__Country__c);
                technician.id=  objTech.id;
                technician.SVMXC__Service_Group__c  = objTech.SVMXC__Service_Group__c ;
                technician.SVMXC__Country__c = objTech.SVMXC__Country__c;
                technician.GE_OG_Region__c = TechnicianRegionUpdate_GE_OG.regionPopulateByCountry(objTech.SVMXC__Country__c);
                lstTechObj.add(technician);
                TechIds.add(objTech.ID); 
                System.debug('++++++++++++++TechIds,'+ TechIds);
             }
             else if(oldTech==null && objTech.SVMXC__Country__c!=null){
                 technician.id=  objTech.id;
               technician.SVMXC__Service_Group__c  = objTech.SVMXC__Service_Group__c ;
                technician.SVMXC__Country__c = objTech.SVMXC__Country__c;
                technician.GE_OG_Region__c = TechnicianRegionUpdate_GE_OG.regionPopulateByCountry(objTech.SVMXC__Country__c);
                lstTechObj.add(technician);
                TechIds.add(objTech.ID); 
            }
            
        }  
    update lstTechObj;
        }*/

        
        }