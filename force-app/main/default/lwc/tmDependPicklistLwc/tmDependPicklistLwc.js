import { LightningElement, wire, track,api } from 'lwc';
import { getPicklistValuesByRecordType } from 'lightning/uiObjectInfoApi';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import PRCPROP_OBJECT from '@salesforce/schema/TM_Price_Proposal__c';

export default class TmDependPicklistLwc extends LightningElement {

    
    @track controllingValues = [];
    @track dependentValues = [];
    @track selectedCountry;
    @track selectedState;
    @track isEmpty = false;
    @track error;
    @api showDist;
    controlValues;
    totalDependentValues = [];

    
    @wire(getObjectInfo, { objectApiName: PRCPROP_OBJECT })
    objectInfo;

    
    @wire(getPicklistValuesByRecordType, { objectApiName: PRCPROP_OBJECT, recordTypeId: '$objectInfo.data.defaultRecordTypeId'})
    countryPicklistValues({error, data}) {
        if(data) {
            this.error = null;
            let countyOptions = [{label:'--None--', value:'--None--'}];

            
            data.picklistFieldValues.TM_Country__c.values.forEach(key => {
                countyOptions.push({
                    label : key.label,
                    value: key.value
                })
            });

            this.controllingValues = countyOptions;

            let stateOptions = [{label:'--None--', value:'--None--'}];

             
            this.controlValues = data.picklistFieldValues.States__c.controllerValues;
            
            this.totalDependentValues = data.picklistFieldValues.States__c.values;

            this.totalDependentValues.forEach(key => {
                stateOptions.push({
                    label : key.label,
                    value: key.value
                })
            });

            this.dependentValues = stateOptions;
        }
        else if(error) {
            this.error = JSON.stringify(error);
        }
    }

    handleCountryChange(event) {

        const cntrySelect = new CustomEvent('countryselected', {
            detail: event.detail.value
        });
        this.dispatchEvent(cntrySelect);
        
        this.selectedCountry = event.target.value;
        this.isEmpty = false;
        let dependValues = [];

        if(this.selectedCountry) {
            
            if(this.selectedCountry === '--None--') {
                this.isEmpty = true;
                dependValues = [{label:'--None--', value:'--None--'}];
                this.selectedCountry = null;
                this.selectedState = null;
                return;
            }

            this.showDist = true;
            this.totalDependentValues.forEach(conValues => {
                if(conValues.validFor[0] === this.controlValues[this.selectedCountry]) {
                    dependValues.push({
                        label: conValues.label,
                        value: conValues.value
                    })
                }
            })

            this.dependentValues = dependValues;
        }
    }

    handleStateChange(event) {
        const stSelect = new CustomEvent('stateselected', {
            detail: event.detail.value
        });
        this.dispatchEvent(stSelect);

        this.selectedState = event.target.value;
    }
}