import { LightningElement,wire,api } from 'lwc';
import magicProposal from '@salesforce/resourceUrl/magiciconforproposal';
import { NavigationMixin } from 'lightning/navigation';

import {  ShowToastEvent } from 'lightning/platformShowToastEvent';
//import insertCon from '@salesforce/apex/TM_PriceMachine_PropList.createPrcPropRcd';
import {createRecord} from 'lightning/uiRecordApi';
import PRCPROP_OBJECT from '@salesforce/schema/TM_Price_Proposal__c';

import NAME_FIELD from '@salesforce/schema/TM_Price_Proposal__c.Name';
import CUSTOMER_FIELD from '@salesforce/schema/TM_Price_Proposal__c.Customer__c';
import CNTRY_FIELD from '@salesforce/schema/TM_Price_Proposal__c.TM_Country__c';
import STATE_FIELD from '@salesforce/schema/TM_Price_Proposal__c.States__c';
import updateRcdCall from '@salesforce/apex/TM_PriceMachine_PropList.updateRcd';

//import createPrcPropRcd from '@salesforce/apex/TM_PriceMachine_PropList.createPrcPropRcd';


export default class TmCrtPrcPropGbActLwc extends NavigationMixin(LightningElement) { 
    imgLogo = magicProposal;
    @api selectedRecordId;    
    @api crtId;
    @api prcpropVal;
    @api PRP_RCDID;
    @api prpRcd = PRCPROP_OBJECT;
    selectedCountry;
    selectedState;
    fieldLabel = "  ";
    error;
    checkboxVal;
    @api bundleCheckBox;
    @api showDist;
    

    prcpropNameChngHandler(event){
        this.prcpropVal = event.target.value;
    }
    
    //handleValueSelcted
    selActRcdHandler(event) {        
        this.selectedRecordId = event.detail;        
    }

    cntryHandler(event){
        //alert('Check Acc:Rcd:::Info::1::3:'+event.detail);
        this.selectedCountry = event.detail;
        this.alignText = true;
    }

    stateHandler(event){
        this.selectedState= event.detail;
        this.bundleCheckBox = true;
    }

    boolHandler(event){
        this.checkboxVal = event.target.checked;
    }

    validateLookupField() {
        this.template.querySelector('c-custom-lookup').isValid();
    }
    saveActionHandler(){
        this.prpRcd.Name = this.prcpropVal;
        this.prpRcd.Customer__c = this.selectedRecordId;
        updateRcdCall({
            //prpObj : this.prpRcd
            strName: this.prcpropVal,
            strAccId: JSON.stringify(this.selectedRecordId),
            strCntry: this.selectedCountry,
            strState: this.selectedState,
            strBool: this.checkboxVal

        }).then(result=>{
            this.PRP_RCDID = result;
            this.closeThewindow();
            
        }).catch((error)=>{
            //this.message = 'Error received: code:::::::' + error.errorCode + ', ' +
                //'message:::::: ' + error.body.message;
                alert('Error::::');
        });
        
    }

    closeThewindow() {
            this[NavigationMixin.Navigate]({
                type: 'standard__recordPage',
                attributes: {
                    recordId: this.PRP_RCDID,       //aEV6s000000000BGAQ
                    objectApiName: 'TM_Price_Proposal__c', 
                    actionName: 'view'
                }
            });
        const closeQA = new CustomEvent('close');
        this.dispatchEvent(closeQA);        
    }

    

    
}