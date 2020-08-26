import { LightningElement, wire } from 'lwc';
import { publish, MessageContext } from 'lightning/messageService';
import ALERTMODAL from '@salesforce/messageChannel/AlertMessageChannel__c';

export default class AlertModalWindowCallerButton extends LightningElement {
    @wire(MessageContext) messageContext;

    alertBodyInformation = [
        { normalTxt: 'This is normal text', boldTxt: 'This is bold text', boldLeftTxt: 'Left Bold', normalRightTxt: 'Right Normal'}
    ]
    alertHeadInformation = {
        title: 'Alert', titleInfo: 'These are some relevant alerts for this Opportunity' 
    }
    handleClick() {
        console.clear();
        console.log(this.messageContext);
        publish(this.messageContext, ALERTMODAL, { alertHeaderInfo: this.alertHeadInformation, alertBodyInfo: this.alertBodyInformation, alertVisibleInfo: true });
    }
}