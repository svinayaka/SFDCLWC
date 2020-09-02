/**
* 
* Class/Trigger Name--: GE_OG_Case_updateTier3 
* Used Where ?--------: Case Trigger Handler
* Purpose/Overview----: Case Trigger Handler - R-17954 - Auto update the Tier 3 and Region for MCS - CS cases
* Functional Area-----: Service
* Author--------------: Raju Manche
* Created Date--------: 12-12-2014
* Test Class Name-----: Test_GE_OG_Case_Related

* Change History -
09-15-2015 - Ramaprasad Sangameshwar - R-22731

* Date Modified : Developer Name     : Method/Section Modified/Added : Purpose/Overview of Change

**/
public class GE_OG_MCS_Case_updateTier3 {
    public void updateTier3value(List<Case>  newcaseList){
        for(Case c : newcaseList){
            String caseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('MCS - CS').getRecordTypeId();            
            if(c.RecordTypeId == caseRecordTypeId)
            {            
                if(c.Origin == 'Email - Grobycc' || c.Origin == 'Email - groby sensing sales'  || c.Origin == 'Email - EMEA Sensing' || c.Origin == 'Email - gesensingorders' || c.Origin == 'Email - iesensingsales'  || c.Origin == 'Email - SensingFrance' || c.Origin == 'Email - SensingDE' || c.Origin == 'Email - CSD Italia'  || c.Origin == 'Email - Sensing Iberia' || c.Origin == 'Email - Sensing NL CC' || c.Origin == 'Email - CC SensingMEA'  || c.Origin == 'Email - MS Boston' || c.Origin == 'Email - Pressure' || c.Origin == 'Email - CC Brasil Sensing'  || c.Origin == 'Email - Brasil Sensing' || c.Origin == 'Email - sudamer Sensing' || c.Origin == 'Email - CC MS IND'){
                    c.GE_Tier_3__c = 'Measurement Solutions';
                }
                
                
                
                if(c.Origin == 'Email Taunton' || c.Origin == 'Email - ST Marys' || c.Origin == 'Email - CC Validation LA' || c.Origin == 'Email - custcaresea'){
                    c.GE_Tier_3__c = 'Advanced Sensors';
                }
                
                
                if(c.Origin == 'Email - rviservice' || c.Origin == 'Email - SalesInspTech FR' || c.Origin == 'Email - InspTechEMEA Film' || c.Origin == 'Email - TransGEIT' || c.Origin == 'Email - InspTechEMEA EC' || c.Origin == 'Email - GEIT Nordic' || c.Origin == 'Email - SalesSensInsp ES' || c.Origin == 'Email - GEIT CC Italia' || c.Origin == 'Email - GEIT CC Film' || c.Origin == 'Email - InspTechDE Film' || c.Origin == 'Email - GeItSales EMEA' || c.Origin == 'Email - InspTech EMEA CRDR' || c.Origin == 'Email - CCRviDE' || c.Origin == 'Email - Phoenix Xray' || c.Origin == 'Email - cclwtn' || c.Origin == 'Email - partslwtn' || c.Origin == 'Email - rviservice' || c.Origin == 'Email - pasadena' || c.Origin == 'Email - filmbr' || c.Origin == 'Email - insbr' || c.Origin == 'Email - aregntina' || c.Origin == 'Email - ccinsarg' || c.Origin == 'Email - insarg' || c.Origin == 'Email - itsun' || c.Origin == 'Email - CC IT IND' || c.Origin == 'Email - custcarehk'){
                    c.GE_Tier_3__c = 'Inspection Technologies';
                }
                
                
                if(c.Origin == 'Email - CSUK' || c.Origin == 'Email - BNkunden' || c.Origin == 'Email - klanten' || c.Origin == 'Email - clientes' || c.Origin == 'Email - clientel' || c.Origin == 'Email - BNclienti' || c.Origin == 'Email - CSEE' || c.Origin == 'Email - CSHun' || c.Origin == 'Email - Kundtjan' || c.Origin == 'Email - Kundeservice' || c.Origin == 'Email - BentlyGulf' || c.Origin == 'Email - BentlyAfrica' || c.Origin == 'Email - BentlySaudi' || c.Origin == 'Email - bnusa' || c.Origin == 'Email - bncan' || c.Origin == 'Email - bently1' || c.Origin == 'Email - bently2' || c.Origin == 'Email - bently3' || c.Origin == 'Email - bently4' || c.Origin == 'Email - bently5' || c.Origin == 'Email - bently6' || c.Origin == 'Email - bently7' || c.Origin == 'Email - bently8' || c.Origin == 'Email - bently9' || c.Origin == 'Email - bently10' || c.Origin == 'Email - bently11' || c.Origin == 'Email - bently12' || c.Origin == 'Email - Brasil' || c.Origin == 'Email - venezuela' || c.Origin == 'Email - Mexico' || c.Origin == 'Email - bnla' || c.Origin == 'Email - ccla' || c.Origin == 'Email - ccmcla' || c.Origin == 'Email - CCBN' || c.Origin == 'Email - CC BN IND' || c.Origin == 'MCNA_BNU14 - Email Bently14' || c.Origin == 'MCNA_BNU15 - Email Bently15' || c.Origin == 'MCNA_BNU16 - Email Bently16' || c.Origin == 'MCNA_BNU17 - Email Bently17' || c.Origin == 'MCNA_BNU18 - Email Bently18' || c.Origin == 'MCNA_BNBN_OEM Email - oembn' || c.Origin == 'MCNA_BNBN_KEY Email - keyaccbn' || c.Origin == 'MCNA_BNBN_CHNL Email - channelsbn' || c.Origin == 'MCNA_BNBN Email - custcarebn'){
                    c.GE_Tier_3__c = 'Bently Nevada';                    
                }
                
                
                if(c.Origin == 'Email - EnergyCS' || c.Origin == 'Email - CS Project' ){
                    c.GE_Tier_3__c = 'Control Solutions';
                }
                
                
                if(c.Origin == 'Email - rsweb'){
                    c.GE_Tier_3__c = 'Reuter Stokes';
                }
                
                
                if(c.Origin == 'Email - CSFPTKR' || c.Origin == 'Email - Avon' || c.Origin == 'Email - Nuclear Order' || c.Origin == 'Email - software Reg' || c.Origin == 'MCNA_FPDPS Email - DPSCustcare' || c.Origin == 'MCNA_FPMET Email - MetersCustcare' || c.Origin == 'MCNA_FPIPG Email - IPGCustcare' || c.Origin == 'MCNA_FPMAS Email - MasoneilanCustcare' || c.Origin == 'MCNA_FPCON Email - ConsoldiatedCustcare' || c.Origin == 'MCNA_FPAMC Email - AMCCustcare' || c.Origin == 'MCNA_FPMOO Email - MooneyCustcare' || c.Origin == 'MCNA_FPBEC Email - BeckerCustcare' || c.Origin == 'MCEU_FPUK Email - UKCustcare' || c.Origin == 'MCEU_FPIT Email - ITCustcare' || c.Origin == 'MCEU_FPFR Email - FRCustcare' || c.Origin == 'MCEU_FPDE Email - DECustcare' || c.Origin == 'MCEU_FPES Email - ESCustcare' || c.Origin == 'MCEU_FP_CONDCC_F Email - Custcare' || c.Origin == 'MCEU_FP_CONDCR_F Email - ContRev' || c.Origin == 'MCNA_FPCON_OM Email - AlexOrdEnrty' || c.Origin == 'MCNA_FPMN_GE Email - gefpt' || c.Origin == 'MCNA_FPAMC_CNCOMP Email - CNComp' || c.Origin == 'MCNA_FPAMC_PREM Email - Premium' || c.Origin == 'MCNA_FPAMC_MNCOMP Email - MNComp' || c.Origin == 'MCNA_FPAMC_PARTS Email - AMCParts' || c.Origin == 'MCNA_FPAMC_BOM Email - BOMReq' || c.Origin == 'MCNA_FPJAX Email - JAXCustcare'){
                    c.GE_Tier_3__c = 'Flow and Process Technologies (Dresser)';
                }
                //Before insert for updating Region Field
                //_MEMC       
                if(c.Origin == 'Email - BentlyGulf' || c.Origin == 'Email - CC SensingMEA'  || c.Origin == 'Email - BentlyAfrica' || c.Origin == 'Email - BentlySaudi' || c.Origin == 'Email - InspectionMEA'){
                    c.GE_Region__c='MEA';
                }
                //_LAMC
                if(c.Origin == 'Email - Brasil Sensing' || c.Origin == 'Email - sudamer Sensing' || c.Origin == 'Email - CC Validation LA' || c.Origin == 'Email - CC Brasil Sensing'|| c.Origin == 'Email - Brasil'|| c.Origin == 'Email - venezuela'|| c.Origin == 'Email - mexico'|| c.Origin == 'Email - bnla'|| c.Origin == 'Email - filmbr'|| c.Origin == 'Email - argentina'|| c.Origin == 'Email - insbr'|| c.Origin == 'Email - ndt'|| c.Origin == 'Email - itsun'|| c.Origin == 'Email - ccinsarg'|| c.Origin == 'Email - insarg'|| c.Origin == 'Email - pedidos'|| c.Origin == 'Email - vendas'|| c.Origin == 'Email - Assistencia'|| c.Origin == 'Email - ccla'|| c.Origin == 'Email - ccmcla'|| c.Origin == 'Email - FTP Brasil' || c.Origin == 'MCLA - Email CCPortals' || c.Origin == 'MCLA - Email CCPortals'){
                    c.GE_Region__c='LA';
                }
                //_EUMC
                if(c.Origin == 'Email - gesensingorders' || c.Origin == 'Email - iesensingsales' || c.Origin == 'Email - SensingFrance' || c.Origin == 'Email - SensingDE' || c.Origin == 'Email - CSD Italia' || c.Origin == 'Email - SensingIberia' || c.Origin == 'Email - GEIT CC Film' || c.Origin == 'Email - GEIT CC Italia' || c.Origin == 'Email - NLSensing' || c.Origin == 'Email - NL Sens' || c.Origin == 'Email - Sensing NL CC' || c.Origin == 'Email - Sensing NL Sales' || c.Origin == 'Email - Grobyservices' || c.Origin == 'Email - Grobycc' || c.Origin == 'Email - groby sensing sales' || c.Origin == 'Email - EMEA Sensing' || c.Origin == 'Email - SalesInspTech FR' || c.Origin == 'Email - GeItFR' || c.Origin == 'Email - InspTechEMEA Film' || c.Origin == 'Email - TransGEIT' || c.Origin == 'Email - AdminCoventry' || c.Origin == 'Email - InspTechEMEA EC' || c.Origin == 'Email - GEIT Nordic' || c.Origin == 'Email - SalesSensInsp ES' || c.Origin == 'Email - Taunton' || c.Origin == 'Email - InspTechDE Film'|| c.Origin == 'Email - GeItSales EMEA'|| c.Origin == 'Email - InspTech EMEA CRDR'|| c.Origin == 'Email - CCRviDE'|| c.Origin == 'Email - Order'|| c.Origin == 'Email - Phoenix Xray'|| c.Origin == 'Email - Kundeservice'|| c.Origin == 'Email - Kundtjan'|| c.Origin == 'Email - EnergyCS'|| c.Origin == 'Email - CSHun'|| c.Origin == 'Email - CSEE'|| c.Origin == 'Email - BNclienti'|| c.Origin == 'Email - clientel'|| c.Origin == 'Email - clientes'|| c.Origin == 'Email - klanten'|| c.Origin == 'Email - BNkunden'|| c.Origin == 'Email - CSUK'|| c.Origin == 'Email - OCInvoice'|| c.Origin == 'Email - DirectShipment'|| c.Origin == 'Email - CS Project'|| c.Origin == 'Email - RVI repairs'|| c.Origin == 'Email - GEITService' || c.Origin == 'MCEU_FPUK Email - UKCustcare' || c.Origin == 'MCEU_FPIT Email - ITCustcare' || c.Origin == 'MCEU_FPFR Email - FRCustcare' || c.Origin == 'MCEU_FPDE Email - DECustcare' || c.Origin == 'MCEU_FPES Email - ESCustcare' || c.Origin == 'MCEU_FP_CONDCC_F Email - Custcare' || c.Origin == 'MCEU_FP_CONDCR_F Email - ContRev'){
                    c.GE_Region__c='Europe';
                }
                //_INMC

                if(c.Origin == 'Email - CC IT IND' || c.Origin == 'Email - CUSTCARE IND' || c.Origin == 'Email - CC MS IND' || c.Origin == 'Email - CC BN IND' || c.Origin == 'Email - SVCBN India' || c.Origin == 'Email - SVCMS India' || c.Origin == 'Email - SVCIT India'){
                    c.GE_Region__c='India';
                }
                //_CNMC
                if(c.Origin == 'Email - CustSVCCN' || c.Origin == 'Email - CCBN' || c.Origin == 'Email - CCCZ' || c.Origin == 'Email - CCTAIWAN'){
                    c.GE_Region__c='China';
                }
                //_NAMC
                if(c.Origin == 'Email - MS Boston' || c.Origin == 'Email - Pressure' || c.Origin == 'Email - ST Marys' || c.Origin == 'Email - rsweb' || c.Origin == 'Email - bncan' || c.Origin == 'Email - bnusa' || c.Origin == 'Email - cclwtn' || c.Origin == 'Email - rviservice' || c.Origin == 'Email - partslwtn' || c.Origin == 'Email - bently1' || c.Origin == 'Email - bently2' || c.Origin == 'Email - bently3' || c.Origin == 'Email - bently4' || c.Origin == 'Email - bently5' || c.Origin == 'Email - bently6' || c.Origin == 'Email - bently7' || c.Origin == 'Email - bently8' || c.Origin == 'Email - bently9' || c.Origin == 'Email - bently10' || c.Origin == 'Email - bently11' || c.Origin == 'Email - bently112' || c.Origin == 'Email - pasadena' || c.Origin == 'Email - Avon' || c.Origin == 'Email - Avon Orderentry' || c.Origin == 'Email - Nuclear Quotations' || c.Origin == 'Email - Nuclear Order' || c.Origin == 'Email - software Reg' || c.Origin == 'Email - Inspection Academy' || c.Origin == 'Email - KAAcuren' || c.Origin == 'Email - KAApplus' || c.Origin == 'Email - KAMistras' || c.Origin == 'Email - KATeam' || c.Origin == 'Email - Avon' || c.Origin == 'Email - Nuclear Order' || c.Origin == 'Email - software Reg' || c.Origin == 'MCNA_FPDPS Email - DPSCustcare' || c.Origin == 'MCNA_FPMET Email - MetersCustcare' || c.Origin == 'MCNA_FPIPG Email - IPGCustcare' || c.Origin == 'MCNA_FPMAS Email - MasoneilanCustcare' || c.Origin == 'MCNA_FPCON Email - ConsoldiatedCustcare' || c.Origin == 'MCNA_FPAMC Email - AMCCustcare' || c.Origin == 'MCNA_FPMOO Email - MooneyCustcare' || c.Origin == 'MCNA_FPBEC Email - BeckerCustcare' || c.Origin == 'MCNA_FPCON_OM Email - AlexOrdEnrty' || c.Origin == 'MCNA_FPMN_GE Email - gefpt' || c.Origin == 'MCNA_FPAMC_CNCOMP Email - CNComp' || c.Origin == 'MCNA_FPAMC_PREM Email - Premium' || c.Origin == 'MCNA_FPAMC_MNCOMP Email - MNComp' || c.Origin == 'MCNA_FPAMC_PARTS Email - AMCParts' || c.Origin == 'MCNA_FPAMC_BOM Email - BOMReq' || c.Origin == 'MCNA_FPJAX Email - JAXCustcare' || c.Origin == 'MCNA_BNU14 - Email Bently14' || c.Origin == 'MCNA_BNU15 - Email Bently15' || c.Origin == 'MCNA_BNU16 - Email Bently16' || c.Origin == 'MCNA_BNU17 - Email Bently17' || c.Origin == 'MCNA_BNU18 - Email Bently18' || c.Origin == 'MCNA_BNBN_OEM Email - oembn' || c.Origin == 'MCNA_BNBN_KEY Email - keyaccbn' || c.Origin == 'MCNA_BNBN_CHNL Email - channelsbn' || c.Origin == 'MCNA_BNBN Email - custcarebn'){
                    c.GE_Region__c='North America';
                }
                
            }
        }
    }   
}