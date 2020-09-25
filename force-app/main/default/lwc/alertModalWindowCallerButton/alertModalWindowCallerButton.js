import { LightningElement, wire, track } from 'lwc';
import { publish, MessageContext } from 'lightning/messageService';
import ALERTMODAL from '@salesforce/messageChannel/AlertMessageChannel__c';
import getAllAccount from '@salesforce/apex/AccountClass.getAccountList';

export default class AlertModalWindowCallerButton extends LightningElement {
    @wire(MessageContext) messageContext;
    @wire(getAllAccount) wiredAccount({err, data}) {
        if (err) {

        } else if (data) {
            
        }
        debugger;
    }

    @track accountList = null;
    @track alertCount = 1;
    alertBodyInformation = [
        { normalTxt: '', boldTxt: '', boldLeftTxt: 'This opportunity is Stale', normalRightTxt: 'the stale reason code is EOD PAST DUE.'},
        { normalTxt: '', boldTxt: '', boldLeftTxt: 'This account has 1 or more Frame Agreements', normalRightTxt: 'There is a Frame Agreement associated to the account, if applicable, please link to this opportunity using the Contract ID field.'},
    ]
    alertHeadInformation = {
        title: 'Alert', titleInfo: 'These are some relevant alerts for this Opportunity' 
    }
    renderedCallback() {
        this.template.querySelector('.BH-alert-icon').classList.add('BH-alert-icon_active');
    }
    handleClick() {
        publish(this.messageContext, ALERTMODAL, { alertHeaderInfo: this.alertHeadInformation, alertBodyInfo: this.alertBodyInformation, alertVisibleInfo: true });
    }
}