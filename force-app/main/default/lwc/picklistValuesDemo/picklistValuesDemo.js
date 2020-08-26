import { LightningElement, wire, track } from 'lwc';
import { getPicklistValues, getPicklistValuesByRecordType, getObjectInfo } from 'lightning/uiObjectInfoApi';
import Status_FIELD from '@salesforce/schema/TM_Price_Proposal__c.TM_Profitability_Status__c';
import Price_Proposal_OBJECT from '@salesforce/schema/TM_Price_Proposal__c';
import getStatusList from '@salesforce/apex/PricingProposal.getStatusOfPricingProposalList';  

export default class PicklistDemo extends LightningElement {
    @track pickListvalues;
    @track error;
    @track values;
    @track getStatusNameList=[];
    @track getSNameList=[];

    @wire(getPicklistValues, {
        recordTypeId : '012000000000000AAA',
        fieldApiName : Status_FIELD
    })
        wiredPickListValue({ data, error }){
            if(data){
                this.pickListvalues = data.values;
                this.error = undefined;
                this.getSNameList.push(this.pickListvalues);
                this.getStatusCount(this.pickListvalues);
            }
            if(error){
                this.error = error;
                this.pickListvalues = undefined;
            }
        }
        getStatusCount(pickListvalues){
           
            getStatusList()
            .then(pickListvalues => { 
                
               let i;
                    for (i = 0; i < pickListvalues.length; i++) {
                        alert('values are'+JSON.stringify(pickListvalues[i]));
                        this.getStatusNameList.push(result[i]);
                        
                    }  
            }).
            catch(error => { 
                this.error=error;
            })
        } 

}